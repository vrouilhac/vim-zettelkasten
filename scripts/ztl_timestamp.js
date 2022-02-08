const today = new Date(Date.now());
console.log(formatZettelkastenDate(today));

function formatZettelkastenDate(date) {
  const year = date.getFullYear();
  const month = date.getMonth()+1;
  const day = date.getDate();
  const hours = formatHMTimeUnit(date.getHours());
  const minutes = formatHMTimeUnit(date.getMinutes());
  return `${year}-${month}-${day} ${hours}:${minutes}`;
}

function formatHMTimeUnit(hours) {
  return hours < 10 ? `0${hours}` : hours;
}
