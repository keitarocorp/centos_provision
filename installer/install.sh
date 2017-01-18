#!/usr/bin/env bash

# Generated by POWSCRIPT (https://github.com/coderofsalvation/powscript)
#
# Unless you like pain: edit the .pow sourcefiles instead of this file

# powscript general settings
set -e                         # halt on error
set +m                         #
SHELL="$(echo $0)"             # shellname
SHELLNAME="$(basename $SHELL)" # shellname without path
shopt -s lastpipe              # flexible while loops (maintain scope)
shopt -s extglob               # regular expressions
path="$(pwd)"
selfpath="$( dirname "$(readlink -f "$0")" )"
tmpfile="/tmp/$(basename $0).tmp.$(whoami)"
#
# generated by powscript (https://github.com/coderofsalvation/powscript)
#

on () 
{ 
    func="$1";
    shift;
    for sig in "$@";
    do
        trap "$func $sig" "$sig";
    done
}

isset () 
{ 
    [[ ! "${#1}" == 0 ]] && return 0 || return 1
}

empty () 
{ 
    [[ "${#1}" == 0 ]] && return 0 || return 1
}

values () 
{ 
    echo "$2"
}



INSTALL_LOG="install.$(date -u +'%Y%m%d.%H%M%S').log"
SUPPORT_EMAIL=support@keitarotds.com
INVENTORY_FILE=hosts.txt
PROVISION_DIRECTORY=centos_provision-master


declare -A DICT

DICT['en.errors.installation_failed_header']='INSTALLATION FAILED'
DICT['en.errors.must_be_root']='You must run this program as root.'
DICT['en.errors.please_send_email']="Please send email to "$SUPPORT_EMAIL" with attached "$INSTALL_LOG""
DICT['en.errors.unsuccessful_run_command']='There was an error evaluating command'
DICT['en.errors.yum_not_installed']='This installer works only on yum-based systems. Please run "$SHELLNAME" in CentOS/RHEL/Fedora distro'
DICT['en.messages.run_command']='Evaluating command'
DICT['en.messages.successful_install']='Everything done!'
DICT['en.no']='no'
DICT['en.prompt_errors.validate_presence']='Please enter value'
DICT['en.prompt_errors.validate_yes_no']='Please answer "yes" or "no"'
DICT['en.prompts.admin_login']='Please enter keitaro admin login'
DICT['en.prompts.admin_password']='Please enter keitaro admin password'
DICT['en.prompts.db_name']='Please enter database name'
DICT['en.prompts.db_password']='Please enter database user password'
DICT['en.prompts.db_user']='Please enter database user name'
DICT['en.prompts.license_ip']='Please enter server IP'
DICT['en.prompts.license_ip']='Please enter server IP'
DICT['en.prompts.license_key']='Please enter license key'
DICT['en.prompts.ssl']="Do you want to install Free SSL certificates from Let's Encrypt?"
DICT['en.prompts.ssl.help']=$(cat <<- END
	Installer can install Free SSL certificates from Let's Encrypt. In order to install this certificates you must:
	1. Agree with terms of Let's Encrypt Subscriber Agreement (https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf).
	2. Have at least one domain associated with this server.
END
)
DICT['en.prompts.ssl.error']='Please answer "yes" or "no"'
DICT['en.prompts.ssl_agree_tos']="Do you agree with terms of Let's Encrypt Subscriber Agreement?"
DICT['ru.prompts.ssl_agree_tos.help']="Let's Encrypt Subscriber Agreement located at https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf."
DICT['en.prompts.ssl_domains']='Please enter server domains, separated by comma'
DICT['en.welcome']=$(cat <<- END
	Welcome to Keitaro TDS installer.
	This installer will guide you through the steps required to install Keitaro TDS on your server.
END
)

DICT['ru.errors.installation_failed_header']='ОШИБКА УСТАНОВКИ'
DICT['ru.errors.must_be_root']='Эту программу может запускать только root.'
DICT['ru.errors.please_send_email']="Пожалуйста, отправьте email на $SUPPORT_EMAIL приложив $INSTALL_LOG"
DICT['ru.errors.unsuccessful_run_command']='Ошибка выполнения команды'
DICT['ru.errors.yum_not_installed']='Утановщик keitaro работает только с пакетным менеджером yum. Пожалуйста, запустите $SHELLNAME в CentOS/RHEL/Fedora дистрибутиве'
DICT['ru.messages.run_command']='Выполняется команда'
DICT['ru.messages.successful_install']='Установка завершена!'
DICT['ru.no']='нет'
DICT['ru.prompt_errors.validate_presence']='Введите значение'
DICT['ru.prompt_errors.validate_yes_no']='Ответьте "да" или "нет" (можно также ответить "yes" или "no")'
DICT['ru.prompts.admin_login']='Укажите имя администратора keitaro'
DICT['ru.prompts.admin_password']='Укажите пароль администратора keitaro'
DICT['ru.prompts.db_name']='Укажите имя базы данных'
DICT['ru.prompts.db_password']='Укажите пароль пользователя базы данных'
DICT['ru.prompts.db_user']='Укажите пользователя базы данных'
DICT['ru.prompts.license_ip']='Укажите IP адрес сервера'
DICT['ru.prompts.license_key']='Укажите лицензионный ключ'
DICT['ru.prompts.ssl']="Вы хотите установить бесплатные SSL сертификаты, предоставляемые Let's Encrypt?"
DICT['ru.prompts.ssl.help']=$(cat <<- END
	Программа установки может установить бесплатные SSL сертификаты, предоставляемые Let's Encrypt. Для этого вы должны:
	1. Согласиться с условиями Абонентского Соглашения Let's Encrypt (https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf).
	2. Иметь хотя бы один домен для этого сервера.
END
)
DICT['ru.prompts.ssl_agree_tos']="Вы согласны с условиями Абонентского Соглашения Let's Encrypt?"
DICT['ru.prompts.ssl_agree_tos.help']="Абонентское Соглашение Let's Encrypt находится по адресу https://letsencrypt.org/documents/LE-SA-v1.0.1-July-27-2015.pdf."
DICT['ru.prompts.ssl_domains']='Укажите список доменов через запятую'
DICT['ru.welcome']=$(cat <<- END
	Добро пожаловать в программу установки Keitaro TDS.
	Эта программа поможет собрать информацию необходимую для установки Keitaro TDS на вашем сервере.
END
)



cleanup(){
  if [ -d "$PROVISION_DIRECTORY" ]; then
    debug "Remove ${PROVISION_DIRECTORY}"
    rm -rf "$PROVISION_DIRECTORY"
  fi
}



debug(){
  local message="${1}"
  if [[ "$VERBOSE" == "true" ]]; then
    print_with_color "$message" 'light.green'
  fi
  print_with_color "$message" 'light.green' >> "$INSTALL_LOG"
}



fail(){
  local message="${1}"
  print_err "*** $(translate errors.installation_failed_header) ***" 'red'
  print_err "$message" 'red'
  print_err
  cleanup
  exit 1
}



install_package(){
  local package="${1}"
  run_command "yum install -y "$package""
}




is_installed(){
  local command="${1}"
  debug "Try to found "$command""
  if isset "$SKIP_CHECKS"; then
    debug "OK, skip actual checking of '$command' presence"
  else
    if [[ $(sh -c "command -v "$command" -gt /dev/null") ]]; then
      debug "OK, "$command" found"
    else
      debug "NOK, "$command" not found"
      return 1
    fi
  fi
}



is_pipe_mode(){
  [ "${SHELLNAME}" == 'bash' ]
}



print_err(){
  local message="${1}"
  local color="${2}"
  print_with_color "$message" "$color" >&2
}



declare -A COLOR_CODE

COLOR_CODE['bold']=1

COLOR_CODE['default']=39
COLOR_CODE['red']=31
COLOR_CODE['green']=32
COLOR_CODE['yellow']=33
COLOR_CODE['blue']=34
COLOR_CODE['magenta']=35
COLOR_CODE['cyan']=36
COLOR_CODE['grey']=90
COLOR_CODE['light.red']=91
COLOR_CODE['light.green']=92
COLOR_CODE['light.yellow']=99
COLOR_CODE['light.blue']=94
COLOR_CODE['light.magenta']=95
COLOR_CODE['light.cyan']=96
COLOR_CODE['light.grey']=37

RESET_FORMATTING='\e[0m'


print_with_color(){
  local message="${1}"
  local color="${2}"
  if ! empty "$color"; then
    escape_sequence="\e[${COLOR_CODE[$color]}m"
    echo -e "${escape_sequence}${message}${RESET_FORMATTING}"
  else
    echo "$message"
  fi
}




run_command(){
  local command="${1}"
  debug "Evaluating command: ${command}"
  run_command_message=$(print_with_color "$(translate 'messages.run_command')" 'blue')
  echo -e "$run_command_message '$command'"
  if isset "$PRESERVE"; then
    debug "Actual running disabled"
  else
    bash -c "set -euo pipefail; ($command) &>> "$INSTALL_LOG"" & pid=$!
    print_dots_while_alive "$pid"
    handle_failed_process "$pid"
  fi
}

print_dots_while_alive(){
  local pid="${1}"
  while kill -0 "$pid" 2>/dev/null; do
    echo -n  "."
    sleep 1
  done
  echo
}

handle_failed_process(){
  local pid="${1}"
  if ! wait "$pid"; then
    fail "$(translate 'errors.unsuccessful_run_command') '$command'\n$(translate 'errors.please_send_email')"
  fi
}



translate(){
  local key="${1}"
  i18n_key=$UI_LANG.$key
  if isset ${DICT[$i18n_key]}; then
    echo "${DICT[$i18n_key]}"
  fi
}



stage0(){
  debug "Run with arguments: '$@'"
  debug "Current date time: $(date +'%Y-%m-%d %H:%M:%S %:z')"
}



stage1(){
  parse_options "$@"
  set_ui_lang
  print_debug_info
  hack_stdin_if_pipe_mode
}


hack_stdin_if_pipe_mode(){
  if is_pipe_mode; then
    debug 'Detected pipe bash mode. Stdin hack enabled'
    hack_stdin
  else
    debug "Can't detect pipe bash mode. Stdin hack disabled"
  fi
}


hack_stdin(){
  exec 3<&1
}




parse_options(){
  while getopts ":hpvsl:" opt; do
    case $opt in
      p)
        PRESERVE=true
        ;;
      s)
        SKIP_CHECKS=true
        ;;
      v)
        VERBOSE=true
        ;;
      l)
        case $OPTARG in
          en)
            UI_LANG=en
            ;;
          ru)
            UI_LANG=ru
            ;;
          *)
            print_err "Specified language \"$OPTARG\" is not supported"
            exit 1
            ;;
        esac
        ;;
      :)
        print_err "Option -$OPTARG requires an argument."
        exit 1
        ;;
      h)
        usage
        exit 0
        ;;
      \?)
        usage
        exit 1
        ;;
    esac
  done
}


usage(){
  set_ui_lang
  if [[ "$UI_LANG" = 'ru' ]]; then
    ru_usage
  else
    en_usage
  fi
}


ru_usage(){
  print_err "$SHELLNAME устанавливает Keitaro TDS"
  print_err
  print_err "Использование: "$SHELLNAME" [-psv] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    С опцией -p (preserve installation) "$SHELLNAME" не запускает установочные команды. Вместо этого текс команд будет показан на экране."
  print_err
  print_err "  -s"
  print_err "    С опцией -s (skip checks) "$SHELLNAME" не будет проверять присутствие yum/ansible в системе, не будет проверять факт запуска из под root."
  print_err
  print_err "  -v"
  print_err "    С опцией -v (verbose mode) "$SHELLNAME" будет выводить детальную информацию оп процессе установки."
  print_err
  print_err "  -l <lang>"
  print_err "    "$SHELLNAME" определяет язык через установленные переменные окружения LANG/LC_MESSAGES/LC_ALL, однако вы можете явно задать язык при помощи параметра -l."
  print_err "    На данный момент поддерживаются значения en и ru (для английского и русского языков)."
  print_err
}


en_usage(){
  print_err "$SHELLNAME installs Keitaro TDS"
  print_err
  print_err "Usage: "$SHELLNAME" [-psv] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    The -p (preserve installation) option causes "$SHELLNAME" to preserve the invoking of installation commands. Installation commands will be printed to stdout instead."
  print_err
  print_err "  -s"
  print_err "    The -s (skip checks) option causes "$SHELLNAME" to skip checks of yum/ansible presence, skip check root running"
  print_err
  print_err "  -v"
  print_err "    The -v (verbose mode) option causes "$SHELLNAME" to display more verbose information of installation process."
  print_err
  print_err "  -l <lang>"
  print_err "    By default "$SHELLNAME" tries to detect language from LANG/LC_MESSAGES/LC_ALL environment variables, but you can explicitly set language with -l option."
  print_err "    Only en and ru (for English and Russian) values supported now."
  print_err
}



print_debug_info(){
  debug "Verbose mode: on"
  debug "Language: ${UI_LANG}"
}



set_ui_lang(){
  if empty "$UI_LANG"; then
    UI_LANG=$(detect_language)
  fi
}


detect_language(){
  if ! empty "$LC_ALL"; then
    detect_language_from_var "$LC_ALL"
  else
    if ! empty "$LC_MESSAGES"; then
      detect_language_from_var "$LC_MESSAGES"
    else
      detect_language_from_var "$LANG"
    fi
  fi
}


detect_language_from_var(){
  local lang_value="${1}"
  if [[ "$lang_value" =~ ^ru_[[:alpha:]]+\.UTF-8$ ]]; then
    echo ru
  else
    echo en
  fi
}



stage2(){
  assert_caller_root
  assert_yum_installed
}



assert_caller_root(){
  debug 'Ensure script has been running by root'
  if isset "$SKIP_CHECKS"; then
    debug "OK, skip actual checking of current user"
  else
    if [[ "$EUID" = 0 ]]; then
      debug 'OK, current user is root'
    else
      debug 'NOK, current user is not root'
      fail "$(translate errors.must_be_root)"
    fi
  fi
}


assert_yum_installed(){
  if ! is_installed 'yum'; then
    fail "$(translate errors.yum_not_installed)"
  fi
}



declare -A VARS

PASSWORD_LENGTH=16


stage3(){
  setup_vars
  read_inventory_file
  get_user_vars
  write_inventory_file
}



setup_vars(){
  VARS['ssl']=$(translate 'no')
  VARS['ssl_agree_tos']=$(translate 'no')
  VARS['db_name']='keitaro'
  VARS['db_user']='keitaro'
  VARS['db_password']=$(generate_password)
  VARS['admin_login']='admin'
  VARS['admin_password']=$(generate_password)
}


generate_password(){
  LC_ALL=C tr -cd '[:alnum:]' < /dev/urandom | head -c16
}






read_inventory_file(){
  if [ -f "$INVENTORY_FILE" ]; then
    debug "Inventory file found, read defaults from it"
    while IFS="" read -r line; do
      parse_line_from_inventory_file "$line"
    done <   $INVENTORY_FILE
  else
    debug "Inventory file not found"
  fi
}


parse_line_from_inventory_file(){
  local line="${1}"
  if [[ "$line" =~ = ]]; then
    IFS="=" read var_name value <<< "$line"
    VARS[$var_name]=$value
    debug "  "$var_name"=${VARS[$var_name]}"
  fi
}



get_user_vars(){
  debug 'Read vars from user input'
  print_welcome
  get_var 'ssl' 'validate_yes_no'
  if is_yes_answer ${VARS['ssl']}; then
    get_var 'ssl_agree_tos' 'validate_yes_no'
    if is_yes_answer ${VARS['ssl_agree_tos']}; then
      get_var 'ssl_domains' 'validate_presence'
      get_var 'ssl_email'
    fi
  fi
  get_var 'license_ip' 'validate_presence'
  get_var 'license_key' 'validate_presence'
  get_var 'db_name' 'validate_presence'
  get_var 'db_user' 'validate_presence'
  get_var 'db_password' 'validate_presence'
  get_var 'admin_login' 'validate_presence'
  get_var 'admin_password' 'validate_presence'
}


get_var(){
  local var_name="${1}"
  local validation_method="${2}"
  print_help "$var_name"
  while true; do
    print_prompt "$var_name"
    variable=$(read_stdin "$var_name")
    if ! empty "$variable"; then
      VARS[$var_name]=$variable
    fi
    if is_valid "$validation_method" "${VARS[$var_name]}"; then
      debug "  "$var_name"="$variable""
      break
    else
      VARS[$var_name]=''
      print_error "$validation_method"
    fi
  done
}


print_welcome(){
  print_translated "welcome"
}


print_help(){
  local var_name="${1}"
  print_translated "prompts.$var_name.help"
}


print_prompt(){
  local var_name="${1}"
  prompt=$(translate "prompts.$var_name")
  prompt="$(print_with_color "$prompt" 'bold')"
  if ! empty ${VARS[$var_name]}; then
    prompt="$prompt [${VARS[$var_name]}]"
  fi
  echo -en "$prompt > "
}


read_stdin(){
  local var_name="${1}"
  if is_pipe_mode; then
    read -r -u 3 variable
  else
    read -r variable
  fi
  echo "$variable"
}


is_valid(){
  local validation_method="${1}"
  local value="${2}"
  if empty "$validation_method"; then
    true
  else
    eval "$validation_method" "$value"
  fi
}


print_error(){
  local error_key="${1}"
  error=$(translate "prompt_errors.$error_key")
  print_with_color "*** ${error}" 'red'
}


print_translated(){
  local key="${1}"
  message=$(translate "${key}")
  if ! empty "$message"; then
    echo "$message"
  fi
}


validate_presence(){
  local value="${1}"
  isset "$value"
}


validate_yes_no(){
  local value="${1}"
  (is_yes_answer "$value" || is_no_answer "$value")
}


is_yes_answer(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(yes|y|да|д) ]]
}


is_no_answer(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(no|n|нет|н) ]]
}



write_inventory_file(){
  debug "Write inventory file"
  echo -n > "$INVENTORY_FILE"
  print_line_to_inventory_file "[server]"
  print_line_to_inventory_file "localhost connection=local"
  print_line_to_inventory_file
  print_line_to_inventory_file "[server:vars]"
  print_line_to_inventory_file "license_ip="${VARS['license_ip']}""
  print_line_to_inventory_file "license_key="${VARS['license_key']}""
  print_line_to_inventory_file "db_name="${VARS['db_name']}""
  print_line_to_inventory_file "db_user="${VARS['db_user']}""
  print_line_to_inventory_file "db_password="${VARS['db_password']}""
  print_line_to_inventory_file "admin_login="${VARS['admin_login']}""
  print_line_to_inventory_file "admin_password="${VARS['admin_password']}""
}


print_line_to_inventory_file(){
  local line="${1}"
  debug "  "$line""
  echo "$line" >> "$INVENTORY_FILE"
}



stage4(){
  install_ansible_if_not_installed
}



install_ansible_if_not_installed(){
  if ! is_installed ansible; then
    debug "Try to install ansible"
    install_package epel-release
    install_package ansible
  fi
}



stage5(){
  download_provision
  run_ansible_playbook
}



download_provision(){
  release_url=https://github.com/keitarocorp/centos_provision/archive/master.tar.gz
  run_command "curl -sSL "$release_url" | tar xz"
}



run_ansible_playbook(){
  run_command "ansible-playbook -vvv -i ${INVENTORY_FILE} ${PROVISION_DIRECTORY}/playbook.yml"
  cleanup
  show_successful_install_message
}


show_successful_install_message(){
  print_with_color "$(translate 'messages.successful_install')" 'green'
  print_with_color "http://${VARS['license_ip']}/admin" 'light.green'
  colored_login=$(print_with_color "${VARS['admin_login']}" 'light.green')
  colored_password=$(print_with_color "${VARS['admin_password']}" 'light.green')
  echo -e "login: ${colored_login}"
  echo -e "password: ${colored_password}"
}





install(){
  debug "Starting stage 0: log basic info"
  stage0 "$@"
  debug "Starting stage 1: initial script setup"
  stage1 "$@"
  debug "Starting stage 2: make some asserts"
  stage2
  debug "Starting stage 3: write inventory file"
  stage3
  debug "Starting stage 4: install ansible"
  stage4
  debug "Starting stage 5: run ansible playbook"
  stage5
}

install "$@"

# wait for all async child processes (because "await ... then" is used in powscript)
[[ $ASYNC == 1 ]] && wait


exit 0

