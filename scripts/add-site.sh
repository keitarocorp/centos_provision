#!/usr/bin/env bash

# Generated by POWSCRIPT (https://github.com/coderofsalvation/powscript)

# Unless you like pain: edit the .pow sourcefiles instead of this file

# powscript general settings
set -e                                # halt on error
set +m                                
SHELL="$(echo $0)"                    # shellname
shopt -s lastpipe                     # flexible while loops (maintain scope)
shopt -s extglob                      # regular expressions
path="$(pwd)"
if [[ "$BASH_SOURCE" == "$0"  ]];then 
  SHELLNAME="$(basename $SHELL)"      # shellname without path
  selfpath="$( dirname "$(readlink -f "$0")" )"
  tmpfile="/tmp/$(basename $0).tmp.$(whoami)"
else
  selfpath="$path"
  tmpfile="/tmp/.dot.tmp.$(whoami)"
fi





empty()
{
    [[ "${#1}" == 0 ]] && return 0 || return 1
}

isset ()
{
    [[ ! "${#1}" == 0 ]] && return 0 || return 1
}

on ()
{
    func="$1";
    shift;
    for sig in "$@";
    do
        trap "$func $sig" "$sig";
    done
}

values ()
{
    echo "$2"
}

last ()
{
    [[ ! -n $1 ]] && return 1;
    echo "$(eval "echo \${$1[@]:(-1)}")"
}




TOOL_NAME='add-site'


#




SHELL_NAME=$(basename "$0")

SUCCESS_RESULT=0
TRUE=0
FAILURE_RESULT=1
FALSE=1
ROOT_UID=0

KEITARO_URL="https://keitaro.io"

RELEASE_VERSION="1.0"
DEFAULT_RELEASE_BRANCH="release-${RELEASE_VERSION}"
RELEASE_BRANCH="${RELEASE_BRANCH:-${DEFAULT_RELEASE_BRANCH}}"

WEBROOT_PATH="/var/www/keitaro"

CONFIG_DIR=".keitaro"
INVENTORY_FILE="${CONFIG_DIR}/installer_config"

NGINX_ROOT_PATH="/etc/nginx"
NGINX_VHOSTS_DIR="${NGINX_ROOT_PATH}/conf.d"
NGINX_KEITARO_CONF="${NGINX_VHOSTS_DIR}/keitaro.conf"

SCRIPT_NAME="${TOOL_NAME}.sh"
SCRIPT_URL="${KEITARO_URL}/${TOOL_NAME}.sh"
SCRIPT_LOG="${TOOL_NAME}.log"

CURRENT_COMMAND_OUTPUT_LOG="current_command.output.log"
CURRENT_COMMAND_ERROR_LOG="current_command.error.log"
CURRENT_COMMAND_SCRIPT_NAME="current_command.sh"

INDENTATION_LENGTH=2
INDENTATION_SPACES=$(printf "%${INDENTATION_LENGTH}s")

if ! empty ${@}; then
  SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" > run; bash run ${@}"
  TOOL_ARGS="${@}"
else
  SCRIPT_COMMAND="curl -sSL "$SCRIPT_URL" > run; bash run"
fi

declare -A VARS

SSL_ENABLER_ERRORS_LOG="${CONFIG_DIR}/ssl_enabler_errors.log"


declare -A DICT

DICT['en.errors.program_failed']='PROGRAM FAILED'
DICT['en.errors.must_be_root']='You must run this program as root.'
DICT['en.errors.contact_support_team']='Please contact Keitaro support team'
DICT['en.errors.run_command.fail']='There was an error evaluating current command'
DICT['en.errors.run_command.fail_extra']=''
DICT['en.errors.terminated']='Terminated by user'
DICT['en.messages.reload_nginx']="Reloading nginx"
DICT['en.messages.run_command']='Evaluating command'
DICT['en.messages.successful']='Everything is done!'
DICT['en.no']='no'
DICT['en.prompt_errors.validate_domains_list']='Please enter domains list, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld). Each domain name must consist of only letters, numbers and hyphens and contain at least one dot.'
DICT['en.prompt_errors.validate_presence']='Please enter value'
DICT['en.prompt_errors.validate_yes_no']='Please answer "yes" or "no"'

DICT['ru.errors.program_failed']='ОШИБКА ВЫПОЛНЕНИЯ ПРОГРАММЫ'
DICT['ru.errors.must_be_root']='Эту программу может запускать только root.'
DICT['ru.errors.contact_support_team']='Пожалуйста, обратитесь в службу технической поддержки Keitaro'
DICT['ru.errors.run_command.fail']='Ошибка выполнения текущей команды'
DICT['ru.errors.run_command.fail_extra']=''
DICT['ru.errors.terminated']='Выполнение прервано'
DICT['ru.messages.reload_nginx']="Перезагружается nginx"
DICT['ru.messages.run_command']='Выполняется команда'
DICT['ru.messages.successful']='Готово!'
DICT['ru.no']='нет'
DICT['ru.prompt_errors.validate_domains_list']='Укажите список доменных имён через запятую без пробелов (например domain1.tld,www.domain1.tld). Каждое доменное имя должно состоять только из букв, цифр и тире и содержать хотябы одну точку.'
DICT['ru.prompt_errors.validate_presence']='Введите значение'
DICT['ru.prompt_errors.validate_yes_no']='Ответьте "да" или "нет" (можно также ответить "yes" или "no")'





DICT['en.errors.see_logs']="Evaluating log saved to ${SCRIPT_LOG}. Please rerun \`${SCRIPT_COMMAND}\` after resolving problems."
DICT['en.errors.reinstall_keitaro']="Your Keitaro installation does not properly configured. Please contact Keitaro support team"
DICT['en.errors.vhost_already_exists']="Can not save site configuration - :vhost_filepath: already exists"
DICT['en.errors.site_root_not_exists']="Can not save site configuration - :site_root: directory does not exist"
DICT['en.messages.add_vhost']="Creating site config"
DICT['en.prompts.site_domains']='Please enter domain name with aliases, separated by comma without spaces (i.e. domain1.tld,www.domain1.tld)'
DICT['en.prompts.site_root']='Please enter site root directory'

DICT['ru.errors.reinstall_keitaro']="Keitaro отконфигурирована неправильно. Пожалуйста, обратитесь в службу поддержки Keitaro"
DICT['ru.errors.see_logs']="Журнал выполнения сохранён в ${SCRIPT_LOG}. Пожалуйста запустите \`${SCRIPT_COMMAND}\` после устранения возникших проблем."
DICT['ru.errors.vhost_already_exists']="Невозможно сохранить конфигурацию сайта - :vhost_filepath: уже существует"
DICT['ru.errors.site_root_not_exists']="Невозможно сохранить конфигурацию сайта - нет директории :site_root:"
DICT['ru.messages.add_vhost']="Создаётся конфигурация для сайта"
DICT['ru.prompts.site_domains']='Укажите доменное имя и список альясов через запятую без пробелов (например domain1.tld,www.domain1.tld)'
DICT['ru.prompts.site_root']='Укажите корневую директорию сайта'



#





assert_caller_root(){
  debug 'Ensure script has been running by root'
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: actual checking of current user"
  else
    if [[ "$EUID" == "$ROOT_UID" ]]; then
      debug 'OK: current user is root'
    else
      debug 'NOK: current user is not root'
      fail "$(translate errors.must_be_root)"
    fi
  fi
}



assert_installed(){
  local program="${1}"
  local error="${2}"
  if ! is_installed "$program"; then
    fail "$(translate ${error})" "see_logs"
  fi
}


#






assert_server_configuration_relevant(){
  debug 'Ensure configs was genereated by relevant installer'
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of installer version in ${INVENTORY_FILE} disabled"
  else
    installed_version=$(detect_installed_version)
    if [[ "${RELEASE_VERSION}" == "${installed_version}" ]]; then
      debug "Configs was generated by recent version of installer ${RELEASE_VERSION}"
    else
      debug "Configs was generated by old version of installer iv=${installed_version} rv=${RELEASE_VERSION}"
      fail "$(translate 'errors.contact_support_team')"
    fi
  fi
}

detect_installed_version(){
  local version=""
  if is_file_exist ${INVENTORY_FILE}; then
    version=$(grep "^installer_version=" ${INVENTORY_FILE} | sed s/^installer_version=//g)
  fi
  if empty "$version"; then
    version="0.9"
  fi
  echo "$version"
}


#





is_directory_exist(){
  local directory="${1}"
  local result_on_skip="${2}"
  debug "Checking ${directory} directory existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${directory} directory existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${directory} directory does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${directory} directory exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -d "${directory}" ]; then
    debug "YES: ${directory} directory exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${directory} directory does not exist"
    return ${FAILURE_RESULT}
  fi
}


#





is_path_exist(){
  local path="${1}"
  local result_on_skip="${2}"
  debug "Checking ${path} path existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${path} path existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${path} path does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${path} path exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -e "${path}" ]; then
    debug "YES: ${path} path exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${path} path does not exist"
    return ${FAILURE_RESULT}
  fi
}


#





is_file_exist(){
  local file="${1}"
  local result_on_skip="${2}"
  debug "Checking ${file} file existence"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of ${file} file existence disabled"
    if [[ "$result_on_skip" == "no" ]]; then
      debug "NO: simulate ${file} file does not exist"
      return ${FAILURE_RESULT}
    fi
    debug "YES: simulate ${file} file exists"
    return ${SUCCESS_RESULT}
  fi
  if [ -f "${file}" ]; then
    debug "YES: ${file} file exists"
    return ${SUCCESS_RESULT}
  else
    debug "NO: ${file} file does not exist"
    return ${FAILURE_RESULT}
  fi
}


#





set_ui_lang(){
  if empty "$UI_LANG"; then
    UI_LANG=$(detect_language)
  fi
  debug "Language: ${UI_LANG}"
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


#





translate(){
  local key="${1}"
  local i18n_key=$UI_LANG.$key
  message="${DICT[$i18n_key]}"
  while isset "${2}"; do
    message=$(interpolate "${message}" "${2}")
    shift
  done
  echo "$message"
}


interpolate(){
  local string="${1}"
  local substitution="${2}"
  IFS="=" read name value <<< "${substitution}"
  string="${string//:${name}:/${value}}"
  echo "${string}"
}


#





is_installed(){
  local command="${1}"
  debug "Try to found "$command""
  if isset "$SKIP_CHECKS"; then
    debug "SKIPPED: actual checking of '$command' presence skipped"
  else
    if [[ $(sh -c "command -v "$command" -gt /dev/null") ]]; then
      debug "FOUND: "$command" found"
    else
      debug "NOT FOUND: "$command" not found"
      return ${FAILURE_RESULT}
    fi
  fi
}



add_indentation(){
  sed -r "s/^/$INDENTATION_SPACES/g"
}



force_utf8_input(){
  LC_CTYPE=en_US.UTF-8
  if [ -f /proc/$$/fd/1 ]; then
    stty -F /proc/$$/fd/1 iutf8
  fi
}


#






get_user_var(){
  local var_name="${1}"
  local validation_methods="${2}"
  print_prompt_help "$var_name"
  while true; do
    print_prompt "$var_name"
    value="$(read_stdin)"
    debug "$var_name: got value '${value}'"
    if ! empty "$value"; then
      VARS[$var_name]="${value}"
    fi
    error=$(get_error "${var_name}" "$validation_methods")
    if isset "$error"; then
      debug "$var_name: validation error - '${error}'"
      print_prompt_error "$error"
      VARS[$var_name]=''
    else
      if [[ "$validation_methods" =~ 'validate_yes_no' ]]; then
        transform_to_yes_no "$var_name"
      fi
      debug "  ${var_name}=${value}" 'light.blue'
      break
    fi
  done
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



is_pipe_mode(){
  [ "${SHELL_NAME}" == 'bash' ]
}


#





print_prompt(){
  local var_name="${1}"
  prompt=$(translate "prompts.$var_name")
  prompt="$(print_with_color "$prompt" 'bold')"
  if ! empty ${VARS[$var_name]}; then
    prompt="$prompt [${VARS[$var_name]}]"
  fi
  echo -en "$prompt > "
}


print_prompt_error(){
  local error_key="${1}"
  error=$(translate "prompt_errors.$error_key")
  print_with_color "*** ${error}" 'red'
}



print_prompt_help(){
  local var_name="${1}"
  print_translated "prompts.$var_name.help"
}



read_stdin(){
  if is_pipe_mode; then
    read -r -u 3 variable
  else
    read -r variable
  fi
  echo "$variable"
}


#






regenerate_vhost_config(){
  local domain="${1}"
  local message_key="${2}"
  local generating_message="$(translate "${message_key}")"
  local command=""
  local changes=""
  local vhost_path="$(get_vhost_path "$domain")"
  local vhost_backup_path="$(get_vhost_backup_path "$domain")"
  if is_file_exist "$vhost_path" no; then
    debug "Backing up nginx config for ${domain} to ${vhost_backup_path}"
    cp "${vhost_path}" "${vhost_backup_path}"
  fi
  if need_to_regenerate_host_config "$vhost_path"; then
    command="${command}cp ${NGINX_KEITARO_CONF} "$vhost_path" && "
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "listen 80" "listen 80 .*")"
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "server_name ${domain}")"
  fi
  while isset "${3}"; do
    changes="${changes}$(build_sed_expression_from_nginx_setting_block "${3}")"
    shift
  done
  command="${command}sed -i${changes} ${vhost_path}"
  run_command "${command}" "${generating_message} ${domain}" "hide_output"
}


need_to_regenerate_host_config(){
  local vhost_path="${1}"
  ! is_file_exist "$vhost_path" no || ! vhost_config_relevant "$vhost_path"
}


vhost_config_relevant(){
  local vhost_path="${1}"
  grep -q -P "^# Generated by Keitaro .* v${RELEASE_VERSION}" "${vhost_path}"
}


get_vhost_path(){
  local domain="${1}"
  echo "${NGINX_VHOSTS_DIR}/${domain}.conf"
}

get_vhost_backup_path(){
  local domain="${1}"
  echo "${NGINX_VHOSTS_DIR}/${domain}.conf.$(date +%Y%m%d%H%M%S)"
}


build_sed_expression_from_nginx_setting_block(){
  local setting="${1}"
  local search_pattern="${2}"
  read name value <<< "$setting"
  if empty "$search_pattern"; then
    search_pattern="${name} .*"
  fi
  echo " -e 's|${search_pattern}|${name} ${value};|g'"
}



clean_up(){
  debug 'called clean_up()'
}


#





debug(){
  local message="${1}"
  local color="${2}"
  if empty "$color"; then
    color='light.green'
  fi
  print_with_color "$message" "$color" >> "$SCRIPT_LOG"
}


#





fail(){
  local message="${1}"
  local see_logs="${2}"
  log_and_print_err "*** $(translate errors.program_failed) ***"
  log_and_print_err "$message"
  if isset "$see_logs"; then
    log_and_print_err "$(translate errors.see_logs)"
  fi
  print_err
  clean_up
  exit ${FAILURE_RESULT}
}



init(){
  init_log
  force_utf8_input
  debug "Starting init stage: log basic info"
  debug "Command: ${SCRIPT_COMMAND}"
  debug "Script version: ${RELEASE_VERSION}"
  debug "User ID: "$EUID""
  debug "Current date time: $(date +'%Y-%m-%d %H:%M:%S %:z')"
  trap on_exit SIGHUP SIGINT SIGTERM
}



init_log(){
  if mkdir -p ${CONFIG_DIR} &> /dev/null; then
    > ${SCRIPT_LOG}
  else
    echo "Can't create keitaro config dir ${CONFIG_DIR}" >&2
    exit 1
  fi
}



log_and_print_err(){
  local message="${1}"
  print_err "$message" 'red'
  debug "$message" 'red'
}



on_exit(){
  debug "Terminated by user"
  echo
  clean_up
  fail "$(translate 'errors.terminated')"
}


#





print_content_of(){
  local filepath="${1}"
  if [ -f "$filepath" ]; then
    if [ -s "$filepath" ]; then
      echo "Content of '${filepath}':\n$(cat "$filepath" | add_indentation)"
    else
      debug "File '${filepath}' is empty"
    fi
  else
    debug "Can't show '${filepath}' content - file does not exist"
  fi
}



print_err(){
  local message="${1}"
  local color="${2}"
  print_with_color "$message" "$color" >&2
}


#





print_translated(){
  local key="${1}"
  message=$(translate "${key}")
  if ! empty "$message"; then
    echo "$message"
  fi
}


#





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



reload_nginx(){
  debug "Reload nginx"
  run_command "nginx -s reload" "$(translate 'messages.reload_nginx')" 'hide_output'
}


#






run_command(){
  local command="${1}"
  local message="${2}"
  local hide_output="${3}"
  local allow_errors="${4}"
  local run_as="${5}"
  local print_fail_message_method="${6}"
  local output_log="${7}"
  debug "Evaluating command: ${command}"
  if empty "$message"; then
    run_command_message=$(print_with_color "$(translate 'messages.run_command')" 'blue')
    message="$run_command_message \`$command\`"
  else
    message=$(print_with_color "${message}" 'blue')
  fi
  if isset "$hide_output"; then
    echo -en "${message} . "
  else
    echo -e "${message}"
  fi
  if isset "$PRESERVE_RUNNING"; then
    print_command_status "$command" 'SKIPPED' 'yellow' "$hide_output"
    debug "Actual running disabled"
  else
    really_run_command "${command}" "${hide_output}" "${allow_errors}" "${run_as}" \
        "${print_fail_message_method}" "${output_log}"
      fi
    }


print_command_status(){
  local command="${1}"
  local status="${2}"
  local color="${3}"
  local hide_output="${4}"
  debug "Command result: ${status}"
  if isset "$hide_output"; then
    if [[ "$hide_output" =~ (uncolored_yes_no) ]]; then
      print_uncolored_yes_no "$status"
    else
      print_with_color "$status" "$color"
    fi
  fi
}


print_uncolored_yes_no(){
  local status="${1}"
  if [[ "$status" == "NOK" ]]; then
    echo "NO"
  else
    echo "YES"
  fi
}



really_run_command(){
  local command="${1}"
  local hide_output="${2}"
  local allow_errors="${3}"
  local run_as="${4}"
  local print_fail_message_method="${5}"
  local output_log="${6}"
  local current_command_script=$(save_command_script "${command}" "${run_as}")
  local evaluated_command=$(command_run_as "${current_command_script}" "${run_as}")
  evaluated_command=$(unbuffer_streams "${evaluated_command}")
  evaluated_command=$(save_command_logs "${evaluated_command}" "${output_log}")
  evaluated_command=$(hide_command_output "${evaluated_command}" "${hide_output}")
  debug "Real command: ${evaluated_command}"
  if ! eval "${evaluated_command}"; then
    print_command_status "${command}" 'NOK' 'red' "${hide_output}"
    if isset "$allow_errors"; then
      remove_current_command "$current_command_script"
      return ${FAILURE_RESULT}
    else
      fail_message=$(print_current_command_fail_message "$print_fail_message_method" "$current_command_script")
      remove_current_command "$current_command_script"
      fail "${fail_message}" "see_logs"
    fi
  else
    print_command_status "$command" 'OK' 'green' "$hide_output"
    remove_current_command "$current_command_script"
  fi
}


command_run_as(){
  local command="${1}"
  local run_as="${2}"
  if isset "$run_as"; then
    echo "sudo -u '${run_as}' bash -c '${command}'"
  else
    echo "bash ${command}"
  fi
}


unbuffer_streams(){
  local command="${1}"
  echo "stdbuf -i0 -o0 -e0 ${command}"
}


save_command_logs(){
  local evaluated_command="${1}"
  local output_log="${2}"
  save_output_log="tee -i ${CURRENT_COMMAND_OUTPUT_LOG} | tee -ia ${SCRIPT_LOG}"
  save_error_log="tee -i ${CURRENT_COMMAND_ERROR_LOG} | tee -ia ${SCRIPT_LOG}"
  if isset "${output_log}"; then
    save_output_log="${save_output_log} | tee -ia ${output_log}"
    save_error_log="${save_error_log} | tee -ia ${output_log}"
  fi
  echo "((${evaluated_command}) 2> >(${save_error_log}) > >(${save_output_log}))"
}


remove_colors_from_file(){
  local file="${1}"
  debug "Removing colors from file ${file}"
  sed -r -e 's/\x1b\[([0-9]{1,3}(;[0-9]{1,3}){,2})?[mGK]//g' -i "$file"
}


hide_command_output(){
  local command="${1}"
  local hide_output="${2}"
  if isset "$hide_output"; then
    echo "${command} > /dev/null"
  else
    echo "${command}"
  fi
}


save_command_script(){
  local command="${1}"
  local run_as="${2}"
  local current_command_dir=$(mktemp -d)
  if isset "$run_as"; then
    chown "$run_as" "$current_command_dir"
  fi
  local current_command_script="${current_command_dir}/${CURRENT_COMMAND_SCRIPT_NAME}"
  echo '#!/usr/bin/env bash' > "${current_command_script}"
  echo 'set -o pipefail' >> "${current_command_script}"
  echo -e "${command}" >> "${current_command_script}"
  debug "$(print_content_of ${current_command_script})"
  echo "${current_command_script}"
}


print_current_command_fail_message(){
  local print_fail_message_method="${1}"
  local current_command_script="${2}"
  remove_colors_from_file "${CURRENT_COMMAND_OUTPUT_LOG}"
  remove_colors_from_file "${CURRENT_COMMAND_ERROR_LOG}"
  if empty "$print_fail_message_method"; then
    print_fail_message_method="print_common_fail_message"
  fi
  local fail_message_header=$(translate 'errors.run_command.fail')
  local fail_message=$(eval "$print_fail_message_method" "$current_command_script")
  echo -e "${fail_message_header}\n${fail_message}"
}


print_common_fail_message(){
  local current_command_script="${1}"
  print_content_of ${current_command_script}
  print_tail_content_of "${CURRENT_COMMAND_OUTPUT_LOG}"
  print_tail_content_of "${CURRENT_COMMAND_ERROR_LOG}"
}


print_tail_content_of(){
  local file="${1}"
  MAX_LINES_COUNT=20
  print_content_of "${file}" |  tail -n "$MAX_LINES_COUNT"
}


remove_current_command(){
  local current_command_script="${1}"
  debug "Removing current command script and logs"
  rm -f "$CURRENT_COMMAND_OUTPUT_LOG" "$CURRENT_COMMAND_ERROR_LOG" "$current_command_script"
  rmdir $(dirname "$current_command_script")
}



get_error(){
  local var_name="${1}"
  local validation_methods_string="${2}"
  local value="${VARS[$var_name]}"
  local error=""
  read -ra validation_methods <<< "$validation_methods_string"
  for validation_method in "${validation_methods[@]}"; do
    if ! eval "${validation_method} '${value}'"; then
      debug "${var_name}: '${value}' invalid for ${validation_method} validator"
      error="${validation_method}"
      break
    else
      debug "${var_name}: '${value}' valid for ${validation_method} validator"
    fi
  done
  echo "${error}"
}


#





validate_presence(){
  local value="${1}"
  isset "$value"
}


SUBDOMAIN_REGEXP="[[:alnum:]-]+"
DOMAIN_REGEXP="(${SUBDOMAIN_REGEXP}\.)+[[:alpha:]]${SUBDOMAIN_REGEXP}"

validate_domain(){
  local value="${1}"
  [[ "$value" =~ ^${DOMAIN_REGEXP}$ ]]
}


DOMAIN_LIST_REGEXP="${DOMAIN_REGEXP}(,${DOMAIN_REGEXP})*"

validate_domains_list(){
  local value="${1}"
  [[ "$value" =~ ^${DOMAIN_LIST_REGEXP}$ ]]
}



is_no(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(no|n|нет|н)$ ]]
}



is_yes(){
  local answer="${1}"
  shopt -s nocasematch
  [[ "$answer" =~ ^(yes|y|да|д)$ ]]
}



transform_to_yes_no(){
  local var_name="${1}"
  if is_yes "${VARS[$var_name]}"; then
    debug "Transform ${var_name}: ${VARS[$var_name]} => yes"
    VARS[$var_name]='yes'
  else
    debug "Transform ${var_name}: ${VARS[$var_name]} => no"
    VARS[$var_name]='no'
  fi
}


validate_yes_no(){
  local value="${1}"
  (is_yes "$value" || is_no "$value")
}




first_domain(){
  echo "${VARS['site_domains']%%,*}"
}



vhost_filepath(){
  echo "${NGINX_VHOSTS_DIR}/$(first_domain).conf"
}



stage1(){
  debug "Starting stage 1: initial script setup"
  parse_options "$@"
  set_ui_lang
}


#





parse_options(){
  while getopts ":hpsvl:" opt; do
    case $opt in
      p)
        PRESERVE_RUNNING=true
        ;;
      s)
        SKIP_CHECKS=true
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
            exit ${FAILURE_RESULT}
            ;;
        esac
        ;;
      :)
        print_err "Option -$OPTARG requires an argument."
        exit ${FAILURE_RESULT}
        ;;
      h)
        usage
        exit ${SUCCESS_RESULT}
        ;;
      v)
        echo "${SCRIPT_NAME} v${RELEASE_VERSION}"
        exit ${SUCCESS_RESULT}
        ;;
      \?)
        usage
        exit ${FAILURE_RESULT}
        ;;
    esac
  done
}


usage(){
  set_ui_lang
  if [[ "$UI_LANG" == 'ru' ]]; then
    ru_usage
  else
    en_usage
  fi
}


ru_usage(){
  print_err "$SCRIPT_NAME позволяет запустить дополнительный сайт совместно с Keitaro"
  print_err
  print_err "Использование: "$SCRIPT_NAME" [-ps] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    С опцией -p (preserve commands running) "$SCRIPT_NAME" не выполняет установочные команды. Вместо этого текст команд будет показан на экране."
  print_err
  print_err "  -s"
  print_err "    С опцией -s (skip checks) "$SCRIPT_NAME" не будет проверять присутствие нужных программ в системе, не будет проверять факт запуска из под root."
  print_err
  print_err "  -l <lang>"
  print_err "    "$SCRIPT_NAME" определяет язык через установленные переменные окружения LANG/LC_MESSAGES/LC_ALL, однако язык может быть явно задан помощи параметра -l."
  print_err "    На данный момент поддерживаются значения en и ru (для английского и русского языков)."
  print_err
}


en_usage(){
  print_err "$SCRIPT_NAME allows to run additional site together with Keitaro"
  print_err
  print_err "Usage: "$SCRIPT_NAME" [-ps] [-l en|ru]"
  print_err
  print_err "  -p"
  print_err "    The -p (preserve commands running) option causes "$SCRIPT_NAME" to preserve the invoking of installation commands. Installation commands will be printed to stdout instead."
  print_err
  print_err "  -s"
  print_err "    The -s (skip checks) option causes "$SCRIPT_NAME" to skip checks of required programs presence, skip check root running"
  print_err
  print_err "  -l <lang>"
  print_err "    By default "$SCRIPT_NAME" tries to detect language from LANG/LC_MESSAGES/LC_ALL environment variables, but language can be explicitly set  with -l option."
  print_err "    Only en and ru (for English and Russian) values are supported now."
  print_err
}



stage2(){
  debug "Starting stage 2: make some asserts"
  assert_caller_root
  assert_installed 'nginx' 'errors.reinstall_keitaro'
  assert_server_configuration_relevant
  assert_nginx_configured
}


#






assert_nginx_configured(){
  if ! is_nginx_properly_configured; then
    fail "$(translate 'errors.reinstall_keitaro')" "see_logs"
  fi
}


is_nginx_properly_configured(){
  if ! is_file_exist "${NGINX_KEITARO_CONF}"; then
    log_and_print_err "ERROR: File ${NGINX_KEITARO_CONF} doesn't exists"
    return ${FAILURE_RESULT}
  fi
  if ! is_directory_exist "${WEBROOT_PATH}"; then
    log_and_print_err "ERROR: Directory ${WEBROOT_PATH} doesn't exists"
    return ${FAILURE_RESULT}
  fi
  is_keitaro_configured
}


is_keitaro_configured(){
  debug "Checking keitaro params in ${NGINX_KEITARO_CONF}"
  if isset "$SKIP_CHECKS"; then
    debug "SKIP: аctual check of keitaro params in ${NGINX_KEITARO_CONF} disabled"
    FASTCGI_PASS_LINE="fastcgi_pass unix:/var/run/php70-fpm.sock;"
    return ${SUCCESS_RESULT}
  fi
  if grep -q -e "root ${WEBROOT_PATH};" "${NGINX_KEITARO_CONF}"; then
    FASTCGI_PASS_LINE="$(cat "$NGINX_KEITARO_CONF" | grep fastcgi_pass | sed 's/^ +//' | head -n1)"
    if empty "${FASTCGI_PASS_LINE}"; then
      log_and_print_err "ERROR: ${NGINX_KEITARO_CONF} is not properly configured (can't find 'fastcgi_pass ...;' directive)"
      log_and_print_err "$(print_content_of ${NGINX_KEITARO_CONF})"
      return ${FAILURE_RESULT}
    else
      debug "OK: it seems like ${NGINX_KEITARO_CONF} is properly configured"
      return ${SUCCESS_RESULT}
    fi
  else
    log_and_print_err "ERROR: ${NGINX_KEITARO_CONF} is not properly configured (can't find 'root ${WEBROOT_PATH};' directive"
    log_and_print_err $(print_content_of ${NGINX_KEITARO_CONF})
    return ${FAILURE_RESULT}
  fi
}



stage3(){
  debug "Starting stage 3: get user vars"
  get_user_vars
}



get_user_vars(){
  debug 'Read vars from user input'
  hack_stdin_if_pipe_mode
  get_user_var 'site_domains' 'validate_presence validate_domains_list'
  VARS['site_root']="/var/www/$(first_domain)"
  get_user_var 'site_root' 'validate_presence'
}



stage4(){
  debug "Starting stage 4: add vhost"
  ensure_can_add_vhost
  for domain in ${VARS['site_domains']//,/ }; do
    generate_nginx_host_config $domain
  done
  reload_nginx
  show_successful_message
}



ensure_can_add_vhost(){
  debug "Ensure can add vhost"
  if is_path_exist "$(vhost_filepath)" "no"; then
    fail "$(translate 'errors.vhost_already_exists' "vhost_filepath=$(vhost_filepath)")"
  fi
  if ! is_directory_exist "${VARS['site_root']}"; then
    fail "$(translate 'errors.site_root_not_exists' "site_root=${VARS['site_root']}")"
  fi
}



generate_nginx_host_config(){
  local domain="${1}"
  debug "Add vhost"
  regenerate_vhost_config "$domain" 'messages.add_vhost' "root ${VARS['site_root']}"
}



show_successful_message(){
  print_with_color "$(translate 'messages.successful')" 'green'
}



add_site(){
  init "$@"
  stage1 "$@"
  stage2
  stage3
  stage4
}


add_site "$@"

# wait for all async child processes (because "await ... then" is used in powscript)
[[ $ASYNC == 1 ]] && wait


exit 0

