; ModuleID = 'test27.bc'
source_filename = "test27.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !7 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %a.addr, align 4, !dbg !15
  %1 = load i32, i32* %b.addr, align 4, !dbg !16
  %add = add nsw i32 %0, %1, !dbg !17
  ret i32 %add, !dbg !18
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !19 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !20, metadata !DIExpression()), !dbg !21
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32, i32* %a.addr, align 4, !dbg !24
  %1 = load i32, i32* %b.addr, align 4, !dbg !25
  %sub = sub nsw i32 %0, %1, !dbg !26
  ret i32 %sub, !dbg !27
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32 %a, i32 %b, %struct.fptr* %c_fptr) #0 !dbg !28 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !38, metadata !DIExpression()), !dbg !39
  store %struct.fptr* %c_fptr, %struct.fptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %c_fptr.addr, metadata !40, metadata !DIExpression()), !dbg !41
  %0 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !42
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %0, i32 0, i32 0, !dbg !43
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !43
  %2 = load i32, i32* %a.addr, align 4, !dbg !44
  %3 = load i32, i32* %b.addr, align 4, !dbg !45
  %call = call i32 %1(i32 %2, i32 %3), !dbg !42
  ret i32 %call, !dbg !46
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %a, i32 %b, %struct.fptr* %c_fptr) #0 !dbg !47 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %c_fptr.addr = alloca %struct.fptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !48, metadata !DIExpression()), !dbg !49
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !50, metadata !DIExpression()), !dbg !51
  store %struct.fptr* %c_fptr, %struct.fptr** %c_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %c_fptr.addr, metadata !52, metadata !DIExpression()), !dbg !53
  %0 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !54
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %0, i32 0, i32 0, !dbg !55
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !56
  %1 = load i32, i32* %a.addr, align 4, !dbg !57
  %2 = load i32, i32* %b.addr, align 4, !dbg !58
  %3 = load %struct.fptr*, %struct.fptr** %c_fptr.addr, align 8, !dbg !59
  %call = call i32 @foo(i32 %1, i32 %2, %struct.fptr* %3), !dbg !60
  ret i32 %call, !dbg !61
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !62 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  %m_fptr = alloca %struct.fptr, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !66, metadata !DIExpression()), !dbg !67
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !68, metadata !DIExpression()), !dbg !69
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !70, metadata !DIExpression()), !dbg !71
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !72, metadata !DIExpression()), !dbg !73
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !73
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !74, metadata !DIExpression()), !dbg !75
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !75
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !76, metadata !DIExpression()), !dbg !77
  store i32 (i32, i32)* null, i32 (i32, i32)** %t_fptr, align 8, !dbg !77
  call void @llvm.dbg.declare(metadata %struct.fptr* %m_fptr, metadata !78, metadata !DIExpression()), !dbg !79
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %m_fptr, i32 0, i32 0, !dbg !80
  store i32 (i32, i32)* null, i32 (i32, i32)** %p_fptr, align 8, !dbg !81
  %0 = load i8, i8* %x.addr, align 1, !dbg !82
  %conv = sext i8 %0 to i32, !dbg !82
  %cmp = icmp eq i32 %conv, 43, !dbg !84
  br i1 %cmp, label %if.then, label %if.else, !dbg !85

if.then:                                          ; preds = %entry
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !86
  store i32 (i32, i32)* %1, i32 (i32, i32)** %t_fptr, align 8, !dbg !88
  br label %if.end6, !dbg !89

if.else:                                          ; preds = %entry
  %2 = load i8, i8* %x.addr, align 1, !dbg !90
  %conv2 = sext i8 %2 to i32, !dbg !90
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !92
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !93

if.then5:                                         ; preds = %if.else
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !94
  store i32 (i32, i32)* %3, i32 (i32, i32)** %t_fptr, align 8, !dbg !96
  br label %if.end, !dbg !97

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !98
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %m_fptr, i32 0, i32 0, !dbg !99
  store i32 (i32, i32)* %4, i32 (i32, i32)** %p_fptr7, align 8, !dbg !100
  call void @llvm.dbg.declare(metadata i32* %result, metadata !101, metadata !DIExpression()), !dbg !103
  %5 = load i32, i32* %op1.addr, align 4, !dbg !104
  %6 = load i32, i32* %op2.addr, align 4, !dbg !105
  %call = call i32 @clever(i32 %5, i32 %6, %struct.fptr* %m_fptr), !dbg !106
  store i32 %call, i32* %result, align 4, !dbg !103
  ret i32 0, !dbg !107
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test27.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !8, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 14, type: !10)
!12 = !DILocation(line: 14, column: 14, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 14, type: !10)
!14 = !DILocation(line: 14, column: 21, scope: !7)
!15 = !DILocation(line: 15, column: 11, scope: !7)
!16 = !DILocation(line: 15, column: 13, scope: !7)
!17 = !DILocation(line: 15, column: 12, scope: !7)
!18 = !DILocation(line: 15, column: 4, scope: !7)
!19 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !8, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 18, type: !10)
!21 = !DILocation(line: 18, column: 15, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 18, type: !10)
!23 = !DILocation(line: 18, column: 22, scope: !19)
!24 = !DILocation(line: 19, column: 11, scope: !19)
!25 = !DILocation(line: 19, column: 13, scope: !19)
!26 = !DILocation(line: 19, column: 12, scope: !19)
!27 = !DILocation(line: 19, column: 4, scope: !19)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !29, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!10, !10, !10, !31}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !32, file: !1, line: 4, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!36 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 21, type: !10)
!37 = !DILocation(line: 21, column: 13, scope: !28)
!38 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 21, type: !10)
!39 = !DILocation(line: 21, column: 20, scope: !28)
!40 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !28, file: !1, line: 21, type: !31)
!41 = !DILocation(line: 21, column: 36, scope: !28)
!42 = !DILocation(line: 22, column: 11, scope: !28)
!43 = !DILocation(line: 22, column: 19, scope: !28)
!44 = !DILocation(line: 22, column: 26, scope: !28)
!45 = !DILocation(line: 22, column: 29, scope: !28)
!46 = !DILocation(line: 22, column: 4, scope: !28)
!47 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 25, type: !29, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!48 = !DILocalVariable(name: "a", arg: 1, scope: !47, file: !1, line: 25, type: !10)
!49 = !DILocation(line: 25, column: 16, scope: !47)
!50 = !DILocalVariable(name: "b", arg: 2, scope: !47, file: !1, line: 25, type: !10)
!51 = !DILocation(line: 25, column: 23, scope: !47)
!52 = !DILocalVariable(name: "c_fptr", arg: 3, scope: !47, file: !1, line: 25, type: !31)
!53 = !DILocation(line: 25, column: 40, scope: !47)
!54 = !DILocation(line: 26, column: 4, scope: !47)
!55 = !DILocation(line: 26, column: 12, scope: !47)
!56 = !DILocation(line: 26, column: 18, scope: !47)
!57 = !DILocation(line: 27, column: 16, scope: !47)
!58 = !DILocation(line: 27, column: 19, scope: !47)
!59 = !DILocation(line: 27, column: 22, scope: !47)
!60 = !DILocation(line: 27, column: 12, scope: !47)
!61 = !DILocation(line: 27, column: 5, scope: !47)
!62 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 31, type: !63, scopeLine: 31, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!63 = !DISubroutineType(types: !64)
!64 = !{!10, !65, !10, !10}
!65 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!66 = !DILocalVariable(name: "x", arg: 1, scope: !62, file: !1, line: 31, type: !65)
!67 = !DILocation(line: 31, column: 14, scope: !62)
!68 = !DILocalVariable(name: "op1", arg: 2, scope: !62, file: !1, line: 31, type: !10)
!69 = !DILocation(line: 31, column: 21, scope: !62)
!70 = !DILocalVariable(name: "op2", arg: 3, scope: !62, file: !1, line: 31, type: !10)
!71 = !DILocation(line: 31, column: 30, scope: !62)
!72 = !DILocalVariable(name: "a_fptr", scope: !62, file: !1, line: 32, type: !35)
!73 = !DILocation(line: 32, column: 11, scope: !62)
!74 = !DILocalVariable(name: "s_fptr", scope: !62, file: !1, line: 33, type: !35)
!75 = !DILocation(line: 33, column: 11, scope: !62)
!76 = !DILocalVariable(name: "t_fptr", scope: !62, file: !1, line: 34, type: !35)
!77 = !DILocation(line: 34, column: 11, scope: !62)
!78 = !DILocalVariable(name: "m_fptr", scope: !62, file: !1, line: 35, type: !32)
!79 = !DILocation(line: 35, column: 17, scope: !62)
!80 = !DILocation(line: 36, column: 12, scope: !62)
!81 = !DILocation(line: 36, column: 18, scope: !62)
!82 = !DILocation(line: 37, column: 9, scope: !83)
!83 = distinct !DILexicalBlock(scope: !62, file: !1, line: 37, column: 9)
!84 = !DILocation(line: 37, column: 11, scope: !83)
!85 = !DILocation(line: 37, column: 9, scope: !62)
!86 = !DILocation(line: 38, column: 17, scope: !87)
!87 = distinct !DILexicalBlock(scope: !83, file: !1, line: 37, column: 19)
!88 = !DILocation(line: 38, column: 15, scope: !87)
!89 = !DILocation(line: 39, column: 5, scope: !87)
!90 = !DILocation(line: 40, column: 14, scope: !91)
!91 = distinct !DILexicalBlock(scope: !83, file: !1, line: 40, column: 14)
!92 = !DILocation(line: 40, column: 16, scope: !91)
!93 = !DILocation(line: 40, column: 14, scope: !83)
!94 = !DILocation(line: 41, column: 17, scope: !95)
!95 = distinct !DILexicalBlock(scope: !91, file: !1, line: 40, column: 24)
!96 = !DILocation(line: 41, column: 15, scope: !95)
!97 = !DILocation(line: 42, column: 5, scope: !95)
!98 = !DILocation(line: 43, column: 19, scope: !62)
!99 = !DILocation(line: 43, column: 12, scope: !62)
!100 = !DILocation(line: 43, column: 18, scope: !62)
!101 = !DILocalVariable(name: "result", scope: !62, file: !1, line: 44, type: !102)
!102 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!103 = !DILocation(line: 44, column: 14, scope: !62)
!104 = !DILocation(line: 44, column: 30, scope: !62)
!105 = !DILocation(line: 44, column: 35, scope: !62)
!106 = !DILocation(line: 44, column: 23, scope: !62)
!107 = !DILocation(line: 45, column: 5, scope: !62)
