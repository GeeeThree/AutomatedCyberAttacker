inferenceengine :-
	intro,
	reset_answers,
	find_attack(Attack),
	decribe(Attack), nl.

intro :-
	write('Inferring data to decide which attack is the most viable option.'), nl,
	write('Attack viability is based on highest success rate with lowest risk.'), nl, nl.

find_attack(Attack) :-
	attack(Attack), !.

:- dynamic(progress/2).

reset_answers :-
	retract(progress(_, _)),
	fail.
reset_answers.

attack(reverse_tcp) :-
	ports(tcp_ports),
	port_types_tcp(tcp).
attack(reverse_tcp) :-
	ports_open(open),
	port_types_tcp(tcp).

attack(password_crack) :-
	file_p(password_file),
	information(username).
attack(password_crack) :-
	file_sp(shadow_password_file),
	information(username).

attack(denial) :-
	user(local_ip_address),
	internet(global_ip_address),
	port_types_tcp(tcp).
attack(denial) :-
	user(local_ip_address),
	internet(global_ip_address),
	port_types_udp(udp).

attack(mitm) :-
	user(local_ip_address),
	ports_open(open),
	port_types_tcp(tcp).
attack(mitm) :-
	user(local_ip_address),
	ports_open(open),
	port_types_udp(udp).

question(ports) :-
	write('Does the ports file exist?'), nl.

question(ports_open):-
	write('Do the open ports file exist?'), nl.

question(port_types_tcp) :-
	write('Does the TCP port types file exist?'), nl.

question(port_types_udp) :-
	write('Does the UDP port types file exist?'), nl.

question(file_p) :-
	write('Does the password file exist?'), nl.	

question(file_sp) :-
	write('Does the shadow password file exist?'), nl.

question(information) :-
	write('Is the username known?'), nl.

question(user) :-
	write('Is the local IP address available?'), nl.

question(internet) :-
	write('Is the global IP address available?'), nl.

answer(tcp_ports) :-
	write('The TCP port numbers are available.').

answer(open) :-
	write('The open port numbers are available.').

answer(tcp) :-
	write('TCP ports are available.').

answer(udp) :-
	write('UDP ports are available.').

answer(password_file) :-
	write('The password file is available.').

answer(shadow_password_file) :-
	write('The shadow password file is available').

answer(username) :-
	write('The username is available.').

answer(local_ip_address) :-
	write('The local IP address is available.').

answer(global_ip_address) :-
	write('The global IP address is available.').

ports(Answer) :-
	progress(ports, Answer).
ports(Answer) :-
	\+ progress(ports, _),
	ask(ports, Answer, [tcp_ports]).

ports_open(Answer) :-
	progress(ports_open, Answer).
ports_open(Answer) :-
	\+ progress(ports_open, _),
	ask(ports_open, Answer, [open]).

port_types_tcp(Answer) :-
	progress(port_types_tcp, Answer).
port_types_tcp(Answer) :-
	\+ progress(port_types_tcp, _),
	ask(port_types_tcp, Answer, [tcp]).

port_types_udp(Answer) :-
	progress(port_types_udp, Answer).
port_types_udp(Answer) :-
	\+ progress(port_types_udp, _),
	ask(port_types_udp, Answer, [udp]).

file_p(Answer) :-
	progress(file_p, Answer).
file_p(Answer) :-
	\+ progress(file_p, _),
	ask(file_p, Answer, [password_file]).

file_sp(Answer) :-
	progress(file_sp, Answer).
file_sp(Answer) :-
	\+ progress(file_sp, _),
	ask(file_sp, Answer, [shadow_password_file]).

information(Answer) :-
	progress(information, Answer).
information(Answer) :-
	\+ progress(information, _),
	ask(information, Answer, [username]).

user(Answer) :-
	progress(user, Answer).
user(Answer) :-
	\+ progress(user, _),
	ask(user, Answer, [local_ip_address]).

internet(Answer) :-
	progress(internet, Answer).
internet(Answer) :-
	\+ progress(internet, _),
	ask(internet, Answer, [global_ip_address]).

answers([], _).
answers([First|Rest], Index) :-
	write(Index), write(' '), answer(First), nl,
	NextIndex is Index + 1,
	answers(Rest, NextIndex).

parse(0, [First|_], First).
parse(Index, [_First|Rest], Response) :-
	Index > 0,
	NextIndex is Index - 1,
	parse(NextIndex, Rest, Response).

ask(Question, Answer, Choices) :-
	question(Question),
	answers(Choices, 0),
	read(Index),
	parse(Index, Choices, Response),
	asserta(progress(Question, Response)),
	Response = Answer.

