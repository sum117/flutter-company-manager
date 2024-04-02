class FeedbackMessage {
  static const genericError =
      'Houve um erro ao tentar realizar a operação. Por favor, tente novamente mais tarde.';
  static const fetchError =
      'Houve um erro ao tentar buscar os dados. Por favor, tente novamente mais tarde.';
  static const noCompanies = 'Nenhuma empresa cadastrada.';
  static const userNoCompaniesOwned =
      'Você ainda não possui empresas cadastradas.';
}

class ButtonLabels {
  static const anonymousLogin = 'Continuar como Anônimo';
  static const googleLogin = 'Entrar com Google';
  static const appleLogin = 'Entrar com Apple';
  static const signOut = 'Sair';
  static const start = 'Começar';
  static const next = 'Próximo';
  static const save = 'Salvar';
  static const previous = 'Anterior';
  static const createLicense = 'Criar Licença';
  static const delete = 'Excluir';
  static const cancel = 'Cancelar';
  static const updateLicense = 'Atualizar Licença';
}

class DialogPrompt {
  static const deleteConfirmationTitle = 'Confirmação de Exclusão';
  static const deleteConfirmationMessage =
      'Tem certeza que deseja excluir este item?';
}

class UserProfileFields {
  static const anonymous = 'Anônimo';
  static const name = 'Nome';
  static const email = 'E-mail';
  static const withUsSince = 'Usuário desde';
  static const defaultProfileImage =
      'https://www.gravatar.com/avatar/placeholder';
  static const companiesOwned = 'Número de Empresas Registradas';
}

class AnimationTime {
  static const progressBarMilliseconds = 800;
  static const pageChangeMilliseconds = 500;
}

const companyAddScreenParagraphs = [
  'Vamos começar o cadastro da sua empresa.',
  'Cada empresa possui uma Razão Social, CNPJ, CEP, Cidade, Estado, Bairro e Complemento.',
  'Existem 3 seções neste formulário. Cada seção possui campos relacionados para prevenir a fadiga do usuário.',
  'Aperte o botão de começar para preencher os campos da próxima seção quando terminar uma.',
  'Ao criar sua empresa, você poderá adicionar gerenciar as licenças dela na pagina dela, assim como gerenciar os campos.'
];

const aboutParagraphs = [
  'Este aplicativo foi desenvolvido para ajudar empresas a gerenciar suas licenças ambientais. Ele é uma POC (Prova de Conceito).',
  'Ele foi desenvolvido com Flutter e Firebase, utilizando o Firestore para armazenar os dados.',
  'O aplicativo foi desenvolvido por um desenvolvedor autônomo e não possui nenhuma relação com empresas ou órgãos governamentais.',
  'O código fonte está disponível no GitHub.',
  'https://github.com/sum117/flutter-companymanager',
];
const companyAddStepTitles = [
  'Informações Gerais',
  'Endereço',
];
const companyAddFieldsTranslationMap = {
  'companyName': 'Razão Social',
  'federalTaxNumber': 'CNPJ',
  'image': 'Imagem',
  'city': 'Cidade',
  'state': 'Estado',
  'neighborhood': 'Bairro',
  'complement': 'Complemento',
  'zipCode': 'CEP',
};

const companyAddFieldsPlaceholders = {
  'companyName': 'Digite a Razão Social',
  'federalTaxNumber': 'Digite o CNPJ',
  'image': 'Cole o link da imagem',
  'city': 'Digite a Cidade',
  'state': 'Digite o Estado',
  'neighborhood': 'Digite o Bairro',
  'complement': 'Digite o Complemento',
  'zipCode': 'Digite o CEP',
};

const licenseFormFieldsTranslationMap = {
  'environmentalAgency': 'Órgão Ambiental',
  'number': 'Número',
  'issuance': 'Emissão',
  'validity': 'Validade',
};

const licensesFormFieldsPlaceholders = {
  'environmentalAgency': 'Digite o Órgão Ambiental',
  'number': 'Digite o Número',
  'issuance': 'Selecione a Data de Emissão',
  'validity': 'Selecione a Data de Validade',
};

const licensesHeaderText = 'Licenças';
const licensesAddHeaderText = 'Adicionar Licença';
const licensesUpdateHeaderText = 'Atualizar Licença';
const companyAddFinishTitle = 'Confira os dados da sua empresa:';
