package log

import (
  "fmt"
  "github.com/fatih/color"
)

// Action - Logs command in appropriate color
func Action(output string, args ...interface{}) {
  color.Magenta(output, args...)
}

// Info - Logs info in appropriate color
func Info(output string, args ...interface{}) {
  color.Blue(output, args...)
}

// Success - Logs error in appropriate color
func Success(output string, args ...interface{}) {
  color.Green(output, args...)
}

// Error - Logs error in appropriate color
func Error(output string, args ...interface{}) {
  color.Red(output, args...)
}

// Warning - Logs warning in appropriate color
func Warning(output string, args ...interface{}) {
  color.Yellow(output, args...)
}

// Command - Logs command in appropriate color
func Command(output string, args ...interface{}) {
  output = fmt.Sprintf(output, args...)
  color.White("%s %s", color.BlueString("❯"), output)
}
