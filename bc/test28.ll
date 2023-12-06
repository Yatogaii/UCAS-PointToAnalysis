; ModuleID = 'test28.bc'
source_filename = "test28.c"
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
define dso_local i32 @foo(i32 %a, i32 %b, i32 (i32, i32)** %a_fptr, i32 (i32, i32)** %b_fptr) #0 !dbg !31 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)**, align 8
  %b_fptr.addr = alloca i32 (i32, i32)**, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 (i32, i32)** %a_fptr, i32 (i32, i32)*** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr.addr, metadata !38, metadata !DIExpression()), !dbg !39
  store i32 (i32, i32)** %b_fptr, i32 (i32, i32)*** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %b_fptr.addr, metadata !40, metadata !DIExpression()), !dbg !41
  %0 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !42
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !43
  %2 = load i32, i32* %a.addr, align 4, !dbg !44
  %3 = load i32, i32* %b.addr, align 4, !dbg !45
  %call = call i32 %1(i32 %2, i32 %3), !dbg !46
  ret i32 %call, !dbg !47
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %a, i32 %b, i32 (i32, i32)** %a_fptr, i32 (i32, i32)** %b_fptr) #0 !dbg !48 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)**, align 8
  %b_fptr.addr = alloca i32 (i32, i32)**, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !49, metadata !DIExpression()), !dbg !50
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !51, metadata !DIExpression()), !dbg !52
  store i32 (i32, i32)** %a_fptr, i32 (i32, i32)*** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr.addr, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 (i32, i32)** %b_fptr, i32 (i32, i32)*** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %b_fptr.addr, metadata !55, metadata !DIExpression()), !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !57, metadata !DIExpression()), !dbg !58
  %0 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr.addr, align 8, !dbg !59
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %0, align 8, !dbg !60
  store i32 (i32, i32)* %1, i32 (i32, i32)** %t_fptr, align 8, !dbg !58
  %2 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !61
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %2, align 8, !dbg !62
  %4 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr.addr, align 8, !dbg !63
  store i32 (i32, i32)* %3, i32 (i32, i32)** %4, align 8, !dbg !64
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !65
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !66
  store i32 (i32, i32)* %5, i32 (i32, i32)** %6, align 8, !dbg !67
  %7 = load i32, i32* %a.addr, align 4, !dbg !68
  %8 = load i32, i32* %b.addr, align 4, !dbg !69
  %9 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr.addr, align 8, !dbg !70
  %10 = load i32 (i32, i32)**, i32 (i32, i32)*** %b_fptr.addr, align 8, !dbg !71
  %call = call i32 @foo(i32 %7, i32 %8, i32 (i32, i32)** %9, i32 (i32, i32)** %10), !dbg !72
  ret i32 %call, !dbg !73
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !74 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)**, align 8
  %s_fptr = alloca i32 (i32, i32)**, align 8
  %t_fptr = alloca i32 (i32, i32)**, align 8
  %result = alloca i32, align 4
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !78, metadata !DIExpression()), !dbg !79
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !80, metadata !DIExpression()), !dbg !81
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !82, metadata !DIExpression()), !dbg !83
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr, metadata !84, metadata !DIExpression()), !dbg !85
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !86
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !87
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %a_fptr, align 8, !dbg !85
  %1 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !88
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %1, align 8, !dbg !89
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %s_fptr, metadata !90, metadata !DIExpression()), !dbg !91
  %call1 = call noalias i8* @malloc(i64 8) #3, !dbg !92
  %2 = bitcast i8* %call1 to i32 (i32, i32)**, !dbg !93
  store i32 (i32, i32)** %2, i32 (i32, i32)*** %s_fptr, align 8, !dbg !91
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %s_fptr, align 8, !dbg !94
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %3, align 8, !dbg !95
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %t_fptr, metadata !96, metadata !DIExpression()), !dbg !97
  %call2 = call noalias i8* @malloc(i64 8) #3, !dbg !98
  %4 = bitcast i8* %call2 to i32 (i32, i32)**, !dbg !99
  store i32 (i32, i32)** %4, i32 (i32, i32)*** %t_fptr, align 8, !dbg !97
  %5 = load i8, i8* %x.addr, align 1, !dbg !100
  %conv = sext i8 %5 to i32, !dbg !100
  %cmp = icmp eq i32 %conv, 43, !dbg !102
  br i1 %cmp, label %if.then, label %if.else, !dbg !103

if.then:                                          ; preds = %entry
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !104
  store i32 (i32, i32)** %6, i32 (i32, i32)*** %t_fptr, align 8, !dbg !106
  br label %if.end8, !dbg !107

if.else:                                          ; preds = %entry
  %7 = load i8, i8* %x.addr, align 1, !dbg !108
  %conv4 = sext i8 %7 to i32, !dbg !108
  %cmp5 = icmp eq i32 %conv4, 45, !dbg !110
  br i1 %cmp5, label %if.then7, label %if.end, !dbg !111

if.then7:                                         ; preds = %if.else
  %8 = load i32 (i32, i32)**, i32 (i32, i32)*** %s_fptr, align 8, !dbg !112
  store i32 (i32, i32)** %8, i32 (i32, i32)*** %t_fptr, align 8, !dbg !114
  br label %if.end, !dbg !115

if.end:                                           ; preds = %if.then7, %if.else
  br label %if.end8

if.end8:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !116, metadata !DIExpression()), !dbg !118
  %9 = load i32, i32* %op1.addr, align 4, !dbg !119
  %10 = load i32, i32* %op2.addr, align 4, !dbg !120
  %11 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !121
  %12 = load i32 (i32, i32)**, i32 (i32, i32)*** %t_fptr, align 8, !dbg !122
  %call9 = call i32 @clever(i32 %9, i32 %10, i32 (i32, i32)** %11, i32 (i32, i32)** %12), !dbg !123
  store i32 %call9, i32* %result, align 4, !dbg !118
  ret i32 0, !dbg !124
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
!1 = !DIFile(filename: "test28.c", directory: "/root/assign3/test")
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
!13 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !6, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!14 = !DILocalVariable(name: "a", arg: 1, scope: !13, file: !1, line: 14, type: !8)
!15 = !DILocation(line: 14, column: 14, scope: !13)
!16 = !DILocalVariable(name: "b", arg: 2, scope: !13, file: !1, line: 14, type: !8)
!17 = !DILocation(line: 14, column: 21, scope: !13)
!18 = !DILocation(line: 15, column: 11, scope: !13)
!19 = !DILocation(line: 15, column: 13, scope: !13)
!20 = !DILocation(line: 15, column: 12, scope: !13)
!21 = !DILocation(line: 15, column: 4, scope: !13)
!22 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !6, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!23 = !DILocalVariable(name: "a", arg: 1, scope: !22, file: !1, line: 18, type: !8)
!24 = !DILocation(line: 18, column: 15, scope: !22)
!25 = !DILocalVariable(name: "b", arg: 2, scope: !22, file: !1, line: 18, type: !8)
!26 = !DILocation(line: 18, column: 22, scope: !22)
!27 = !DILocation(line: 19, column: 11, scope: !22)
!28 = !DILocation(line: 19, column: 13, scope: !22)
!29 = !DILocation(line: 19, column: 12, scope: !22)
!30 = !DILocation(line: 19, column: 4, scope: !22)
!31 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 21, type: !32, scopeLine: 21, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{!8, !8, !8, !4, !4}
!34 = !DILocalVariable(name: "a", arg: 1, scope: !31, file: !1, line: 21, type: !8)
!35 = !DILocation(line: 21, column: 13, scope: !31)
!36 = !DILocalVariable(name: "b", arg: 2, scope: !31, file: !1, line: 21, type: !8)
!37 = !DILocation(line: 21, column: 20, scope: !31)
!38 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !31, file: !1, line: 21, type: !4)
!39 = !DILocation(line: 21, column: 30, scope: !31)
!40 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !31, file: !1, line: 21, type: !4)
!41 = !DILocation(line: 21, column: 55, scope: !31)
!42 = !DILocation(line: 22, column: 13, scope: !31)
!43 = !DILocation(line: 22, column: 12, scope: !31)
!44 = !DILocation(line: 22, column: 21, scope: !31)
!45 = !DILocation(line: 22, column: 24, scope: !31)
!46 = !DILocation(line: 22, column: 11, scope: !31)
!47 = !DILocation(line: 22, column: 4, scope: !31)
!48 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 25, type: !32, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!49 = !DILocalVariable(name: "a", arg: 1, scope: !48, file: !1, line: 25, type: !8)
!50 = !DILocation(line: 25, column: 16, scope: !48)
!51 = !DILocalVariable(name: "b", arg: 2, scope: !48, file: !1, line: 25, type: !8)
!52 = !DILocation(line: 25, column: 23, scope: !48)
!53 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !48, file: !1, line: 25, type: !4)
!54 = !DILocation(line: 25, column: 33, scope: !48)
!55 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !48, file: !1, line: 25, type: !4)
!56 = !DILocation(line: 25, column: 58, scope: !48)
!57 = !DILocalVariable(name: "t_fptr", scope: !48, file: !1, line: 26, type: !5)
!58 = !DILocation(line: 26, column: 8, scope: !48)
!59 = !DILocation(line: 26, column: 27, scope: !48)
!60 = !DILocation(line: 26, column: 26, scope: !48)
!61 = !DILocation(line: 27, column: 11, scope: !48)
!62 = !DILocation(line: 27, column: 10, scope: !48)
!63 = !DILocation(line: 27, column: 3, scope: !48)
!64 = !DILocation(line: 27, column: 9, scope: !48)
!65 = !DILocation(line: 28, column: 10, scope: !48)
!66 = !DILocation(line: 28, column: 3, scope: !48)
!67 = !DILocation(line: 28, column: 9, scope: !48)
!68 = !DILocation(line: 29, column: 16, scope: !48)
!69 = !DILocation(line: 29, column: 19, scope: !48)
!70 = !DILocation(line: 29, column: 22, scope: !48)
!71 = !DILocation(line: 29, column: 30, scope: !48)
!72 = !DILocation(line: 29, column: 12, scope: !48)
!73 = !DILocation(line: 29, column: 5, scope: !48)
!74 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 33, type: !75, scopeLine: 33, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!75 = !DISubroutineType(types: !76)
!76 = !{!8, !77, !8, !8}
!77 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!78 = !DILocalVariable(name: "x", arg: 1, scope: !74, file: !1, line: 33, type: !77)
!79 = !DILocation(line: 33, column: 14, scope: !74)
!80 = !DILocalVariable(name: "op1", arg: 2, scope: !74, file: !1, line: 33, type: !8)
!81 = !DILocation(line: 33, column: 21, scope: !74)
!82 = !DILocalVariable(name: "op2", arg: 3, scope: !74, file: !1, line: 33, type: !8)
!83 = !DILocation(line: 33, column: 30, scope: !74)
!84 = !DILocalVariable(name: "a_fptr", scope: !74, file: !1, line: 34, type: !4)
!85 = !DILocation(line: 34, column: 9, scope: !74)
!86 = !DILocation(line: 34, column: 49, scope: !74)
!87 = !DILocation(line: 34, column: 29, scope: !74)
!88 = !DILocation(line: 35, column: 6, scope: !74)
!89 = !DILocation(line: 35, column: 12, scope: !74)
!90 = !DILocalVariable(name: "s_fptr", scope: !74, file: !1, line: 36, type: !4)
!91 = !DILocation(line: 36, column: 12, scope: !74)
!92 = !DILocation(line: 36, column: 52, scope: !74)
!93 = !DILocation(line: 36, column: 32, scope: !74)
!94 = !DILocation(line: 37, column: 6, scope: !74)
!95 = !DILocation(line: 37, column: 13, scope: !74)
!96 = !DILocalVariable(name: "t_fptr", scope: !74, file: !1, line: 38, type: !4)
!97 = !DILocation(line: 38, column: 12, scope: !74)
!98 = !DILocation(line: 38, column: 52, scope: !74)
!99 = !DILocation(line: 38, column: 32, scope: !74)
!100 = !DILocation(line: 40, column: 9, scope: !101)
!101 = distinct !DILexicalBlock(scope: !74, file: !1, line: 40, column: 9)
!102 = !DILocation(line: 40, column: 11, scope: !101)
!103 = !DILocation(line: 40, column: 9, scope: !74)
!104 = !DILocation(line: 41, column: 17, scope: !105)
!105 = distinct !DILexicalBlock(scope: !101, file: !1, line: 40, column: 19)
!106 = !DILocation(line: 41, column: 15, scope: !105)
!107 = !DILocation(line: 42, column: 5, scope: !105)
!108 = !DILocation(line: 43, column: 14, scope: !109)
!109 = distinct !DILexicalBlock(scope: !101, file: !1, line: 43, column: 14)
!110 = !DILocation(line: 43, column: 16, scope: !109)
!111 = !DILocation(line: 43, column: 14, scope: !101)
!112 = !DILocation(line: 44, column: 17, scope: !113)
!113 = distinct !DILexicalBlock(scope: !109, file: !1, line: 43, column: 24)
!114 = !DILocation(line: 44, column: 15, scope: !113)
!115 = !DILocation(line: 45, column: 5, scope: !113)
!116 = !DILocalVariable(name: "result", scope: !74, file: !1, line: 47, type: !117)
!117 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!118 = !DILocation(line: 47, column: 14, scope: !74)
!119 = !DILocation(line: 47, column: 30, scope: !74)
!120 = !DILocation(line: 47, column: 35, scope: !74)
!121 = !DILocation(line: 47, column: 40, scope: !74)
!122 = !DILocation(line: 47, column: 48, scope: !74)
!123 = !DILocation(line: 47, column: 23, scope: !74)
!124 = !DILocation(line: 48, column: 5, scope: !74)
