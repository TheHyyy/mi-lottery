import type { IPersonConfig } from '@/types/storeType'
import { rgba } from '@/utils/color'

export function useElementStyle(element: any, person: IPersonConfig, index: number, patternList: number[], patternColor: string, cardColor: string, cardSize: { width: number, height: number }, textSize: number, mod: 'default' | 'lucky' | 'sphere' = 'default', type: 'add' | 'change' = 'add') {
    if (patternList.includes(index + 1) && mod === 'default') {
        element.style.backgroundColor = rgba(patternColor, Math.random() * 0.2 + 0.8)
    }
    else if (mod === 'sphere') {
        // 球体模式：随机30%橙色，70%紫色
        const isOrange = Math.random() < 0.5
        const colorToUse = isOrange ? '#FF6700' : cardColor
        element.style.backgroundColor = rgba(colorToUse, Math.random() * 0.5 + 0.25)
    }
    else if (mod === 'default') {
        element.style.backgroundColor = rgba(cardColor, Math.random() * 0.5 + 0.25)
    }
    else if (mod === 'lucky') {
        element.style.backgroundColor = rgba(cardColor, 0.8)
    }
    element.style.border = `1px solid ${rgba(cardColor, 0.25)}`
    element.style.boxShadow = `0 0 12px ${rgba(cardColor, 0.5)}`
    element.style.width = `${cardSize.width}px`
    element.style.height = `${cardSize.height}px`
    if (mod === 'lucky') {
        element.className = 'lucky-element-card'
    }
    else {
        element.className = 'element-card'
    }
    if (type === 'add') {
        element.addEventListener('mouseenter', (ev: MouseEvent) => {
            const target = ev.target as HTMLElement
            target.style.border = `1px solid ${rgba(cardColor, 0.75)}`
            target.style.boxShadow = `0 0 12px ${rgba(cardColor, 0.75)}`
        })
        element.addEventListener('mouseleave', (ev: MouseEvent) => {
            const target = ev.target as HTMLElement
            target.style.border = `1px solid ${rgba(cardColor, 0.25)}`
            target.style.boxShadow = `0 0 12px ${rgba(cardColor, 0.5)}`
        })
    }
    element.children[0].style.fontSize = `${textSize * 0.5}px`
    if (person.uid) {
        element.children[0].textContent = person.uid
    }

    element.children[1].style.fontSize = `${textSize}px`
    element.children[1].style.lineHeight = `${textSize * 3}px`
    element.children[1].style.textShadow = `0 0 12px ${rgba(cardColor, 0.95)}`
    if (person.name) {
        element.children[1].textContent = person.name
    }
    // element.children[2].style.fontSize = `${textSize * 0.5}px`
    // if (person.department || person.identity) {
    //     element.children[2].innerHTML = `${person.department ? person.department : ''}<br/>${person.identity ? person.identity : ''}`
    // }

    element.children[2].style.fontSize = `${textSize * 0.5}px`
    // 设置部门和身份的默认值
    element.children[2].innerHTML = ''
    if (person.department || person.identity) {
        element.children[2].innerHTML = `${person.department ? person.department : ''}<br/>${person.identity ? person.identity : ''}`
    }
    element.children[3].src = person.avatar
    return element
}

/**
 * @description 设置抽中卡片的位置
 * 最少一个，最大二十个
 */
export function useElementPosition(element: any, count: number, totalCount: number, cardSize: { width: number, height: number }, windowSize: { width: number, height: number }, cardIndex: number) {
    let xTable = 0
    let yTable = 0
    const gapX = cardSize.width * 0.36
    const gapY = cardSize.height * 0.08
    const rowHeight = cardSize.height + gapY
    const itemsPerRow = 5
    const maxRowIndex = Math.floor((totalCount - 1) / itemsPerRow)
    const centerPosition = {
        x: 0,
        y: (maxRowIndex * rowHeight) / 2,
    }

    const currentRow = Math.floor(cardIndex / itemsPerRow)
    const isLastRow = currentRow === maxRowIndex
    const lastRowItems = totalCount % itemsPerRow === 0 ? itemsPerRow : totalCount % itemsPerRow

    // Check if we should use special layout (centered even number) for this row
    // We only apply special layout to the last row if it has even number of items
    const isSpecialLayout = isLastRow && (lastRowItems % 2 === 0)
    const indexInRow = cardIndex % itemsPerRow
    const unitWidth = cardSize.width + gapX

    if (!isSpecialLayout) {
        if (indexInRow === 0) {
            xTable = centerPosition.x
            yTable = centerPosition.y - currentRow * rowHeight
        }
        else {
            xTable = indexInRow % 2 === 0 ? Math.ceil(indexInRow / 2) * unitWidth : -Math.ceil(indexInRow / 2) * unitWidth
            yTable = centerPosition.y - currentRow * rowHeight
        }
    }
    else {
        if (indexInRow === 0) {
            xTable = centerPosition.x + unitWidth / 2
            yTable = centerPosition.y - currentRow * rowHeight
        }
        else {
            xTable = indexInRow % 2 === 0
                ? Math.ceil(indexInRow / 2) * unitWidth + unitWidth / 2
                : -(Math.ceil(indexInRow / 2) * unitWidth) + unitWidth / 2
            yTable = centerPosition.y - currentRow * rowHeight
        }
    }
    return { xTable, yTable }
}
