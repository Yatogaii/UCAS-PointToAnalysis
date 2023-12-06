; ModuleID = 'test16.bc'
source_filename = "test16.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !13 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32, i32* %a.addr, align 4, !dbg !18
  %1 = load i32, i32* %b.addr, align 4, !dbg !19
  %add = add nsw i32 %0, %1, !dbg !20
  ret i32 %add, !dbg !21
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !22 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !23, metadata !DIExpression()), !dbg !24
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !25, metadata !DIExpression()), !dbg !26
  %0 = load i32, i32* %a.addr, align 4, !dbg !27
  %1 = load i32, i32* %b.addr, align 4, !dbg !28
  %sub = sub nsw i32 %0, %1, !dbg !29
  ret i32 %sub, !dbg !30
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !31 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !38, metadata !DIExpression()), !dbg !39
  store i32 (i32, i32)* %b_fptr, i32 (i32, i32)** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %b_fptr.addr, metadata !40, metadata !DIExpression()), !dbg !41
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !42
  ret i32 (i32, i32)* %0, !dbg !43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %b_fptr) #0 !dbg !44 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)**, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !47, metadata !DIExpression()), !dbg !48
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !49, metadata !DIExpression()), !dbg !50
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !51, metadata !DIExpression()), !dbg !52
  store i32 (i32, i32)** %b_fptr, i32 (i32, i32)*** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %b_fptr.addr, metadata !53, metadata !DIExpression()), !dbg !54
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !55, metadata !DIExpression()), !dbg !56
  %0 = load i32, i32* %a.addr, align 4, !dbg !57
  %1 = load i32, i32* %b.addr, align 4, !dbg !58
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !59
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !60
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !61
  %call = call i32 (i32, i32)* @foo(i32 %0, i32 %1, i32 (i32, i32)* %2, i32 (i32, i32)* %4), !dbg !62
  store i32 (i32, i32)* %call, i32 (i32, i32)** %s_fptr, align 8, !dbg !63
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !64
  %6 = load i32, i32* %a.addr, align 4, !dbg !65
  %7 = load i32, i32* %b.addr, align 4, !dbg !66
  %call1 = call i32 %5(i32 %6, i32 %7), !dbg !64
  ret i32 %call1, !dbg !67
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !68 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca i32 (i32, i32)**, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !72, metadata !DIExpression()), !dbg !73
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !74, metadata !DIExpression()), !dbg !75
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !76, metadata !DIExpression()), !dbg !77
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !78, metadata !DIExpression()), !dbg !79
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !79
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !80, metadata !DIExpression()), !dbg !81
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !81
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %t_fptr, metadata !82, metadata !DIExpression()), !dbg !83
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !84
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !85
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %t_fptr, align 8, !dbg !83
  %1 = load i8, i8* %x.addr, align 1, !dbg !86
  %conv = sext i8 %1 to i32, !dbg !86
  %cmp = icmp eq i32 %conv, 43, !dbg !88
  br i1 %cmp, label %if.then, label %if.else, !dbg !89

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !90
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !92
  store i32 (i32, i32)* %2, i32 (i32, i32)** %3, align 8, !dbg !93
  br label %if.end6, !dbg !94

if.else:                                          ; preds = %entry
  %4 = load i8, i8* %x.addr, align 1, !dbg !95
  %conv2 = sext i8 %4 to i32, !dbg !95
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !97
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !98

if.then5:                                         ; preds = %if.else
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !99
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !101
  store i32 (i32, i32)* %5, i32 (i32, i32)** %6, align 8, !dbg !102
  br label %if.end, !dbg !103

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end6

if.end6:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !104, metadata !DIExpression()), !dbg !106
  %7 = load i32, i32* %op1.addr, align 4, !dbg !107
  %8 = load i32, i32* %op2.addr, align 4, !dbg !108
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !109
  %10 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !110
  %call7 = call i32 @clever(i32 %7, i32 %8, i32 (i32, i32)* %9, i32 (i32, i32)** %10), !dbg !111
  store i32 %call7, i32* %result, align 4, !dbg !106
  ret i32 0, !dbg !112
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10, !11}
!llvm.ident = !{!12}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test16.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!6 = !DISubroutineType(types: !7)
!7 = !{!8, !8, !8}
!8 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!9 = !{i32 7, !"Dwarf Version", i32 4}
!10 = !{i32 2, !"Debug Info Version", i32 3}
!11 = !{i32 1, !"wchar_size", i32 4}
!12 = !{!"clang version 10.0.0 "}
!13 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !6, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!14 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 2, type: !8)
!15 = !DILocation(line: 2, column: 14, scope: !13)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 2, type: !8)
!17 = !DILocation(line: 2, column: 21, scope: !13)
!18 = !DILocation(line: 3, column: 11, scope: !13)
!19 = !DILocation(line: 3, column: 13, scope: !13)
!20 = !DILocation(line: 3, column: 12, scope: !13)
!21 = !DILocation(line: 3, column: 4, scope: !13)
!22 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !6, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 6, type: !8)
!24 = !DILocation(line: 6, column: 15, scope: !22)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 6, type: !8)
!26 = !DILocation(line: 6, column: 22, scope: !22)
!27 = !DILocation(line: 7, column: 11, scope: !22)
!28 = !DILocation(line: 7, column: 13, scope: !22)
!29 = !DILocation(line: 7, column: 12, scope: !22)
!30 = !DILocation(line: 7, column: 4, scope: !22)
!31 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 10, type: !32, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!5, !8, !8, !5, !5}
!34 = !DILocalVariable(name: "a", arg: 1, scope: !31, file: !1, line: 10, type: !8)
!35 = !DILocation(line: 10, column: 15, scope: !31)
!36 = !DILocalVariable(name: "b", arg: 2, scope: !31, file: !1, line: 10, type: !8)
!37 = !DILocation(line: 10, column: 22, scope: !31)
!38 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !31, file: !1, line: 10, type: !5)
!39 = !DILocation(line: 10, column: 31, scope: !31)
!40 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !31, file: !1, line: 10, type: !5)
!41 = !DILocation(line: 10, column: 55, scope: !31)
!42 = !DILocation(line: 11, column: 11, scope: !31)
!43 = !DILocation(line: 11, column: 4, scope: !31)
!44 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 14, type: !45, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!8, !8, !8, !5, !4}
!47 = !DILocalVariable(name: "a", arg: 1, scope: !44, file: !1, line: 14, type: !8)
!48 = !DILocation(line: 14, column: 16, scope: !44)
!49 = !DILocalVariable(name: "b", arg: 2, scope: !44, file: !1, line: 14, type: !8)
!50 = !DILocation(line: 14, column: 23, scope: !44)
!51 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !44, file: !1, line: 14, type: !5)
!52 = !DILocation(line: 14, column: 32, scope: !44)
!53 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !44, file: !1, line: 14, type: !4)
!54 = !DILocation(line: 14, column: 57, scope: !44)
!55 = !DILocalVariable(name: "s_fptr", scope: !44, file: !1, line: 15, type: !5)
!56 = !DILocation(line: 15, column: 10, scope: !44)
!57 = !DILocation(line: 16, column: 17, scope: !44)
!58 = !DILocation(line: 16, column: 20, scope: !44)
!59 = !DILocation(line: 16, column: 23, scope: !44)
!60 = !DILocation(line: 16, column: 32, scope: !44)
!61 = !DILocation(line: 16, column: 31, scope: !44)
!62 = !DILocation(line: 16, column: 13, scope: !44)
!63 = !DILocation(line: 16, column: 11, scope: !44)
!64 = !DILocation(line: 17, column: 11, scope: !44)
!65 = !DILocation(line: 17, column: 18, scope: !44)
!66 = !DILocation(line: 17, column: 21, scope: !44)
!67 = !DILocation(line: 17, column: 4, scope: !44)
!68 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 21, type: !69, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!8, !71, !8, !8}
!71 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!72 = !DILocalVariable(name: "x", arg: 1, scope: !68, file: !1, line: 21, type: !71)
!73 = !DILocation(line: 21, column: 14, scope: !68)
!74 = !DILocalVariable(name: "op1", arg: 2, scope: !68, file: !1, line: 21, type: !8)
!75 = !DILocation(line: 21, column: 21, scope: !68)
!76 = !DILocalVariable(name: "op2", arg: 3, scope: !68, file: !1, line: 21, type: !8)
!77 = !DILocation(line: 21, column: 30, scope: !68)
!78 = !DILocalVariable(name: "a_fptr", scope: !68, file: !1, line: 22, type: !5)
!79 = !DILocation(line: 22, column: 11, scope: !68)
!80 = !DILocalVariable(name: "s_fptr", scope: !68, file: !1, line: 23, type: !5)
!81 = !DILocation(line: 23, column: 11, scope: !68)
!82 = !DILocalVariable(name: "t_fptr", scope: !68, file: !1, line: 24, type: !4)
!83 = !DILocation(line: 24, column: 12, scope: !68)
!84 = !DILocation(line: 24, column: 52, scope: !68)
!85 = !DILocation(line: 24, column: 32, scope: !68)
!86 = !DILocation(line: 26, column: 9, scope: !87)
!87 = distinct !DILexicalBlock(scope: !68, file: !1, line: 26, column: 9)
!88 = !DILocation(line: 26, column: 11, scope: !87)
!89 = !DILocation(line: 26, column: 9, scope: !68)
!90 = !DILocation(line: 27, column: 18, scope: !91)
!91 = distinct !DILexicalBlock(scope: !87, file: !1, line: 26, column: 19)
!92 = !DILocation(line: 27, column: 9, scope: !91)
!93 = !DILocation(line: 27, column: 16, scope: !91)
!94 = !DILocation(line: 28, column: 5, scope: !91)
!95 = !DILocation(line: 29, column: 14, scope: !96)
!96 = distinct !DILexicalBlock(scope: !87, file: !1, line: 29, column: 14)
!97 = !DILocation(line: 29, column: 16, scope: !96)
!98 = !DILocation(line: 29, column: 14, scope: !87)
!99 = !DILocation(line: 30, column: 18, scope: !100)
!100 = distinct !DILexicalBlock(scope: !96, file: !1, line: 29, column: 24)
!101 = !DILocation(line: 30, column: 9, scope: !100)
!102 = !DILocation(line: 30, column: 16, scope: !100)
!103 = !DILocation(line: 31, column: 5, scope: !100)
!104 = !DILocalVariable(name: "result", scope: !68, file: !1, line: 32, type: !105)
!105 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!106 = !DILocation(line: 32, column: 14, scope: !68)
!107 = !DILocation(line: 32, column: 30, scope: !68)
!108 = !DILocation(line: 32, column: 35, scope: !68)
!109 = !DILocation(line: 32, column: 40, scope: !68)
!110 = !DILocation(line: 32, column: 48, scope: !68)
!111 = !DILocation(line: 32, column: 23, scope: !68)
!112 = !DILocation(line: 33, column: 5, scope: !68)
