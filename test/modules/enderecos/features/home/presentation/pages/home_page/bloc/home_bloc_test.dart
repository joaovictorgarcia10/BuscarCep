import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/disconnect_account.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/save_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late BuscarEndreco buscarEndreco;
  late SaveEndereco saveEndereco;
  late DisconnectAccount disconnectAccount;
  late HomeBloc bloc;

  setUp(() {
    repository = MockHomeRepository();

    buscarEndreco = BuscarEndreco(repository);
    saveEndereco = SaveEndereco(repository);
    disconnectAccount = DisconnectAccount(repository);

    bloc = HomeBloc(buscarEndreco, saveEndereco, disconnectAccount);
  });

  group("DisconnectAccount", () {
    test("DisconnectAccount - success", () {
      when(() => repository.disconnet())
          .thenAnswer((_) async => const Right(true));

      bloc.add(const HomeEvent.disconnectAccount());

      expectLater(
        bloc.stream,
        emitsInOrder(
          const [
            HomeState.loading(),
            HomeState.disconnectAccountSuccess(),
          ],
        ),
      );
    });

    test("DisconnectAccount - failure", () {
      final failure = Failure();

      when(() => repository.disconnet()).thenAnswer((_) async => Left(failure));

      bloc.add(const HomeEvent.disconnectAccount());

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ],
        ),
      );
    });
  });

  group("SaveEndereco", () {
    final endereco = Endereco();
    test("SaveEndereco - success", () {
      when(() => repository.saveEndereco(endereco: endereco))
          .thenAnswer((_) async => const Right(true));

      bloc.add(HomeEvent.saveEndereco(model: endereco));

      expectLater(
        bloc.stream,
        emitsInOrder(
          const [
            HomeState.loading(),
            HomeState.saveEnderecoSuccess(),
          ],
        ),
      );
    });

    test("SaveEndereco - failure", () {
      final failure = Failure();

      when(() => repository.saveEndereco(endereco: endereco))
          .thenAnswer((_) async => Left(failure));
      bloc.add(HomeEvent.saveEndereco(model: endereco));

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ],
        ),
      );
    });
  });

  group("BuscarEndreco", () {
    final endereco = Endereco();
    test("BuscarEndreco - success", () {
      when(() => repository.buscarEndereco(cep: "123456"))
          .thenAnswer((_) async => Right(endereco));

      bloc.add(
          HomeEvent.buscarEndereco(params: BuscarEndrecoParams(cep: "123456")));

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.buscarEnderecoSuccess(endereco: endereco),
          ],
        ),
      );
    });

    test("BuscarEndreco - failure", () {
      final failure = Failure();

      when(() => repository.buscarEndereco(cep: "123456"))
          .thenAnswer((_) async => Left(failure));

      bloc.add(
          HomeEvent.buscarEndereco(params: BuscarEndrecoParams(cep: "123456")));

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ],
        ),
      );
    });
  });
}
