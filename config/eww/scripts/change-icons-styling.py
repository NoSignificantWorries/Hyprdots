import xml.etree.ElementTree as ET


def change_svg_color(svg_file, output_file, arc_colors):
    tree = ET.parse(svg_file)
    root = tree.getroot()
    
    all_paths = []
    for element in root.iter():
        tag_name = element.tag.split('}')[-1] if '}' in element.tag else element.tag
        if tag_name == 'path':
            all_paths.append(element)
    
    if len(all_paths) > 0:
        all_paths[0].set('fill', arc_colors[0])
    
    for i, color in enumerate(arc_colors[1:]):
        if i + 1 < len(all_paths):
            all_paths[i + 1].set('fill', color)

    tree.write(output_file, encoding='utf-8', xml_declaration=True)


change_svg_color('/home/dmitry/.config/eww/icons/wifi-high.svg', 'test.svg', ["#ff00ff", "#ffff00", "#00ffff", "#f0f0f0"])
