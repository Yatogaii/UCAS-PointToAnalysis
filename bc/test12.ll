; ModuleID = 'test12.bc'
source_filename = "test12.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !16 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !19, metadata !DIExpression()), !dbg !20
  %0 = load i32, i32* %a.addr, align 4, !dbg !21
  %1 = load i32, i32* %b.addr, align 4, !dbg !22
  %add = add nsw i32 %0, %1, !dbg !23
  ret i32 %add, !dbg !24
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !25 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !26, metadata !DIExpression()), !dbg !27
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !28, metadata !DIExpression()), !dbg !29
  %0 = load i32, i32* %a.addr, align 4, !dbg !30
  %1 = load i32, i32* %b.addr, align 4, !dbg !31
  %sub = sub nsw i32 %0, %1, !dbg !32
  ret i32 %sub, !dbg !33
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !34 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !37, metadata !DIExpression()), !dbg !38
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !39, metadata !DIExpression()), !dbg !40
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !41, metadata !DIExpression()), !dbg !42
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !43
  %1 = load i32, i32* %a.addr, align 4, !dbg !44
  %2 = load i32, i32* %b.addr, align 4, !dbg !45
  %call = call i32 %0(i32 %1, i32 %2), !dbg !43
  ret i32 %call, !dbg !46
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !47 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca %struct.fptr*, align 8
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !51, metadata !DIExpression()), !dbg !52
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !55, metadata !DIExpression()), !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !57, metadata !DIExpression()), !dbg !58
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !59, metadata !DIExpression()), !dbg !60
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !60
  call void @llvm.dbg.declare(metadata %struct.fptr** %t_fptr, metadata !61, metadata !DIExpression()), !dbg !62
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !63
  %0 = bitcast i8* %call to %struct.fptr*, !dbg !64
  store %struct.fptr* %0, %struct.fptr** %t_fptr, align 8, !dbg !62
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !65, metadata !DIExpression()), !dbg !67
  store i32 (i32, i32, i32 (i32, i32)*)* @clever, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !67
  call void @llvm.dbg.declare(metadata i32* %result, metadata !68, metadata !DIExpression()), !dbg !70
  store i32 0, i32* %result, align 4, !dbg !70
  %1 = load i8, i8* %x.addr, align 1, !dbg !71
  %conv = sext i8 %1 to i32, !dbg !71
  %cmp = icmp eq i32 %conv, 43, !dbg !73
  br i1 %cmp, label %if.then, label %if.else, !dbg !74

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !75
  %3 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !77
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !78
  store i32 (i32, i32)* %2, i32 (i32, i32)** %p_fptr, align 8, !dbg !79
  br label %if.end, !dbg !80

if.else:                                          ; preds = %entry
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !81
  %5 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !83
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !84
  store i32 (i32, i32)* %4, i32 (i32, i32)** %p_fptr2, align 8, !dbg !85
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %6 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !86
  %7 = load i32, i32* %op1.addr, align 4, !dbg !87
  %8 = load i32, i32* %op2.addr, align 4, !dbg !88
  %9 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !89
  %p_fptr3 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !90
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr3, align 8, !dbg !90
  %call4 = call i32 %6(i32 %7, i32 %8, i32 (i32, i32)* %10), !dbg !86
  store i32 %call4, i32* %result, align 4, !dbg !91
  %11 = load i32, i32* %result, align 4, !dbg !92
  ret i32 %11, !dbg !93
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test12.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 13, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !5, file: !1, line: 15, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = !DISubroutineType(types: !10)
!10 = !{!11, !11, !11}
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{i32 7, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 10.0.0 "}
!16 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !9, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!17 = !DILocalVariable(name: "a", arg: 1, scope: !16, file: !1, line: 2, type: !11)
!18 = !DILocation(line: 2, column: 14, scope: !16)
!19 = !DILocalVariable(name: "b", arg: 2, scope: !16, file: !1, line: 2, type: !11)
!20 = !DILocation(line: 2, column: 21, scope: !16)
!21 = !DILocation(line: 3, column: 11, scope: !16)
!22 = !DILocation(line: 3, column: 13, scope: !16)
!23 = !DILocation(line: 3, column: 12, scope: !16)
!24 = !DILocation(line: 3, column: 4, scope: !16)
!25 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !9, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!26 = !DILocalVariable(name: "a", arg: 1, scope: !25, file: !1, line: 6, type: !11)
!27 = !DILocation(line: 6, column: 15, scope: !25)
!28 = !DILocalVariable(name: "b", arg: 2, scope: !25, file: !1, line: 6, type: !11)
!29 = !DILocation(line: 6, column: 22, scope: !25)
!30 = !DILocation(line: 7, column: 11, scope: !25)
!31 = !DILocation(line: 7, column: 13, scope: !25)
!32 = !DILocation(line: 7, column: 12, scope: !25)
!33 = !DILocation(line: 7, column: 4, scope: !25)
!34 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !35, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!35 = !DISubroutineType(types: !36)
!36 = !{!11, !11, !11, !8}
!37 = !DILocalVariable(name: "a", arg: 1, scope: !34, file: !1, line: 10, type: !11)
!38 = !DILocation(line: 10, column: 16, scope: !34)
!39 = !DILocalVariable(name: "b", arg: 2, scope: !34, file: !1, line: 10, type: !11)
!40 = !DILocation(line: 10, column: 23, scope: !34)
!41 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !34, file: !1, line: 10, type: !8)
!42 = !DILocation(line: 10, column: 32, scope: !34)
!43 = !DILocation(line: 11, column: 12, scope: !34)
!44 = !DILocation(line: 11, column: 19, scope: !34)
!45 = !DILocation(line: 11, column: 22, scope: !34)
!46 = !DILocation(line: 11, column: 5, scope: !34)
!47 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !48, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!48 = !DISubroutineType(types: !49)
!49 = !{!11, !50, !11, !11}
!50 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!51 = !DILocalVariable(name: "x", arg: 1, scope: !47, file: !1, line: 18, type: !50)
!52 = !DILocation(line: 18, column: 14, scope: !47)
!53 = !DILocalVariable(name: "op1", arg: 2, scope: !47, file: !1, line: 18, type: !11)
!54 = !DILocation(line: 18, column: 21, scope: !47)
!55 = !DILocalVariable(name: "op2", arg: 3, scope: !47, file: !1, line: 18, type: !11)
!56 = !DILocation(line: 18, column: 30, scope: !47)
!57 = !DILocalVariable(name: "a_fptr", scope: !47, file: !1, line: 19, type: !8)
!58 = !DILocation(line: 19, column: 11, scope: !47)
!59 = !DILocalVariable(name: "s_fptr", scope: !47, file: !1, line: 20, type: !8)
!60 = !DILocation(line: 20, column: 11, scope: !47)
!61 = !DILocalVariable(name: "t_fptr", scope: !47, file: !1, line: 21, type: !4)
!62 = !DILocation(line: 21, column: 19, scope: !47)
!63 = !DILocation(line: 21, column: 41, scope: !47)
!64 = !DILocation(line: 21, column: 26, scope: !47)
!65 = !DILocalVariable(name: "af_ptr", scope: !47, file: !1, line: 22, type: !66)
!66 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !35, size: 64)
!67 = !DILocation(line: 22, column: 11, scope: !47)
!68 = !DILocalVariable(name: "result", scope: !47, file: !1, line: 23, type: !69)
!69 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!70 = !DILocation(line: 23, column: 14, scope: !47)
!71 = !DILocation(line: 24, column: 9, scope: !72)
!72 = distinct !DILexicalBlock(scope: !47, file: !1, line: 24, column: 9)
!73 = !DILocation(line: 24, column: 11, scope: !72)
!74 = !DILocation(line: 24, column: 9, scope: !47)
!75 = !DILocation(line: 25, column: 25, scope: !76)
!76 = distinct !DILexicalBlock(scope: !72, file: !1, line: 24, column: 19)
!77 = !DILocation(line: 25, column: 8, scope: !76)
!78 = !DILocation(line: 25, column: 16, scope: !76)
!79 = !DILocation(line: 25, column: 23, scope: !76)
!80 = !DILocation(line: 26, column: 5, scope: !76)
!81 = !DILocation(line: 28, column: 25, scope: !82)
!82 = distinct !DILexicalBlock(scope: !72, file: !1, line: 27, column: 5)
!83 = !DILocation(line: 28, column: 8, scope: !82)
!84 = !DILocation(line: 28, column: 16, scope: !82)
!85 = !DILocation(line: 28, column: 23, scope: !82)
!86 = !DILocation(line: 30, column: 13, scope: !47)
!87 = !DILocation(line: 30, column: 20, scope: !47)
!88 = !DILocation(line: 30, column: 25, scope: !47)
!89 = !DILocation(line: 30, column: 30, scope: !47)
!90 = !DILocation(line: 30, column: 38, scope: !47)
!91 = !DILocation(line: 30, column: 11, scope: !47)
!92 = !DILocation(line: 31, column: 12, scope: !47)
!93 = !DILocation(line: 31, column: 5, scope: !47)
