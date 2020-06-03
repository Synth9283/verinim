import src/checksum, nigui, options, strutils

app.init()

var window = newWindow("verinim")
window.width = 600.scaleToDpi
window.height = 400.scaleToDpi

# main container
var container = newLayoutContainer(Layout_Vertical)
window.add(container)

# top container
var topContainer = newLayoutContainer(Layout_Horizontal)
topContainer.frame = newFrame("File")
container.add(topContainer)

# pre defined bottom container items
var fileHash = newTextBox("None")
fileHash.editable = false

# items in topContainer
var fileLocation = newTextBox()
topContainer.add(fileLocation)

var browseButton = newButton("Browse")
topContainer.add(browseButton)
browseButton.onClick = proc(event: ClickEvent) =
    var dialog = newOpenFileDialog()
    dialog.title = "Open file"
    dialog.run()
    let selectedDir: string = dialog.files.join()
    fileLocation.text = selectedDir
    let result = checksum(selectedDir)
    if result.isNone:
        fileHash.text = "None"
    else:
        fileHash.text = result.get()

# bottom container
var bottomContainer = newLayoutContainer(Layout_Horizontal)
bottomContainer.frame = newFrame("Checksum")
container.add(bottomContainer)

# top items in bottomContainer
var bottomLayout = newLayoutContainer(Layout_Vertical)
bottomContainer.add(bottomLayout)
var checkHashLabel = newLabel("Checksum Hash:")
bottomLayout.add(checkHashLabel)
var checkHashTextBox = newTextBox()
bottomLayout.add(checkHashTextBox)
var fileHashLabel = newLabel("Selected File Hash:")
bottomLayout.add(fileHashLabel)
bottomLayout.add(fileHash)
var fileHashCheckButton = newButton("Check")
bottomLayout.add(fileHashCheckButton)

# checksum button click event
fileHashCheckButton.onClick = proc(event: ClickEvent) =
    let checksumVal: string = checkHashTextBox.text
    let fileHashVal: string = fileHash.text
    if checksumVal == "":
        window.alert("Please provide a file hash!")
    elif fileHashVal == "None":
        window.alert("Please select a valid file!")
    elif fileHashVal == checksumVal:
        window.alert("Hashes matched!\nInputted: " & checksumVal & "\nFile hash: " & fileHashVal)
    else:
        window.alert("Hashes did not match!\nInputted: " & checksumVal & "\nFile hash: " & fileHashVal)

window.show()
app.run()
