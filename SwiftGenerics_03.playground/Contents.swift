import UIKit

// MARK: - Задача 3*. К выполнению необязательна. 


enum EnumQueue<T>{
    
    typealias Item = T
    
    indirect case Node (value: T,  next: EnumQueue<T> )
    
    case End
    
    func count()->Int{
        switch self {
        case let .Node(_, next):
            return 1 + next.count()
        case .End:
            return 0
        }
    }
    
    mutating  func add(_ item: T) {
        switch self {
        case var .Node(value, next):
            //если узел не пустой рекурсивно вызываем add() у следующего
            next.add(item)
            //заменяем узел новым, в котором все элементы заменены на свои новые копии, и добавлен последний
            self = .Node(value: value,  next: next)
        //если дошли до пустого узла, то заменяем его нa Node
        case .End:
            //последний узел на новый
            self = .Node(value: item,  next: EnumQueue.End)
        }
        
    }
    
    func getByIndex(_ index: Int) -> T! {
        if index < 0 {
            return nil
        }
        switch self {
        case let .Node(value, next):
            if index == 0 {
                return value
            } else {
                return next.getByIndex(index - 1)
            }
        case .End:
            return nil
        }
    }
    
    
    mutating func removeByIndex(_ index: Int){
        if index > 0 { //нашли нужный узел
            switch self {
            case var .Node(value, next):
                //рекурсивно переходим к удаляемому узлу
                next.removeByIndex((index - 1))
                //после удаления заменим текущий на изменненую цепочку
                self = .Node(value: value,  next: next)
            case .End://иначе список и так пустой
                return
            }
        } else if index == 0 {
            switch self {
            case var .Node(_, next): //если есть следующий, то переносим его в текущий
                self = next
                return
            case .End://иначе список и так пустой
                return
            }
        }
    }
}


var eq = EnumQueue<String>.End

for i in 0...4{
    eq.add(String(i))
}
print(eq)

print(eq.count())
print(eq.getByIndex(-1))

for i in 0..<eq.count(){
    print(eq.getByIndex(i))
}


for i in 0..<eq.count(){
    eq.removeByIndex(0)
    print(eq)
}



