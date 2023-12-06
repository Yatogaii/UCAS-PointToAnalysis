; ModuleID = 'test04.bc'
source_filename = "test04.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !9 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !15, metadata !DIExpression()), !dbg !16
  %0 = load i32, i32* %a.addr, align 4, !dbg !17
  %1 = load i32, i32* %b.addr, align 4, !dbg !18
  %add = add nsw i32 %0, %1, !dbg !19
  ret i32 %add, !dbg !20
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !21 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !22, metadata !DIExpression()), !dbg !23
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !24, metadata !DIExpression()), !dbg !25
  %0 = load i32, i32* %a.addr, align 4, !dbg !26
  %1 = load i32, i32* %b.addr, align 4, !dbg !27
  %sub = sub nsw i32 %0, %1, !dbg !28
  ret i32 %sub, !dbg !29
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !30 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !38, metadata !DIExpression()), !dbg !39
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !40
  %1 = load i32, i32* %a.addr, align 4, !dbg !41
  %2 = load i32, i32* %b.addr, align 4, !dbg !42
  %call = call i32 %0(i32 %1, i32 %2), !dbg !40
  ret i32 %call, !dbg !43
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %x) #0 !dbg !44 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca i32 (i32, i32)*, align 8
  %q_fptr = alloca i32 (i32, i32)*, align 8
  %r_fptr = alloca i32 (i32, i32)*, align 8
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %op1 = alloca i32, align 4
  %op2 = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !47, metadata !DIExpression()), !dbg !48
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !49, metadata !DIExpression()), !dbg !50
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !50
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !51, metadata !DIExpression()), !dbg !52
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !52
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %t_fptr, metadata !53, metadata !DIExpression()), !dbg !54
  store i32 (i32, i32)* null, i32 (i32, i32)** %t_fptr, align 8, !dbg !54
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %q_fptr, metadata !55, metadata !DIExpression()), !dbg !56
  store i32 (i32, i32)* null, i32 (i32, i32)** %q_fptr, align 8, !dbg !56
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %r_fptr, metadata !57, metadata !DIExpression()), !dbg !58
  store i32 (i32, i32)* null, i32 (i32, i32)** %r_fptr, align 8, !dbg !58
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !59, metadata !DIExpression()), !dbg !61
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !61
  call void @llvm.dbg.declare(metadata i32* %op1, metadata !62, metadata !DIExpression()), !dbg !63
  store i32 1, i32* %op1, align 4, !dbg !63
  call void @llvm.dbg.declare(metadata i32* %op2, metadata !64, metadata !DIExpression()), !dbg !65
  store i32 2, i32* %op2, align 4, !dbg !65
  %0 = load i32, i32* %x.addr, align 4, !dbg !66
  %cmp = icmp sge i32 %0, 4, !dbg !68
  br i1 %cmp, label %if.then, label %if.end, !dbg !69

if.then:                                          ; preds = %entry
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !70
  store i32 (i32, i32)* %1, i32 (i32, i32)** %t_fptr, align 8, !dbg !72
  br label %if.end, !dbg !73

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !74
  %3 = load i32, i32* %op1, align 4, !dbg !75
  %4 = load i32, i32* %op2, align 4, !dbg !76
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !77
  %call = call i32 %2(i32 %3, i32 %4, i32 (i32, i32)* %5), !dbg !74
  %6 = load i32, i32* %x.addr, align 4, !dbg !78
  %cmp1 = icmp sge i32 %6, 5, !dbg !80
  br i1 %cmp1, label %if.then2, label %if.end3, !dbg !81

if.then2:                                         ; preds = %if.end
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !82
  store i32 (i32, i32)* %7, i32 (i32, i32)** %t_fptr, align 8, !dbg !84
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !85
  store i32 (i32, i32)* %8, i32 (i32, i32)** %q_fptr, align 8, !dbg !86
  br label %if.end3, !dbg !87

if.end3:                                          ; preds = %if.then2, %if.end
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %t_fptr, align 8, !dbg !88
  %cmp4 = icmp ne i32 (i32, i32)* %9, null, !dbg !90
  br i1 %cmp4, label %if.then5, label %if.end7, !dbg !91

if.then5:                                         ; preds = %if.end3
  call void @llvm.dbg.declare(metadata i32* %result, metadata !92, metadata !DIExpression()), !dbg !95
  %10 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !96
  %11 = load i32, i32* %op1, align 4, !dbg !97
  %12 = load i32, i32* %op2, align 4, !dbg !98
  %13 = load i32 (i32, i32)*, i32 (i32, i32)** %q_fptr, align 8, !dbg !99
  %call6 = call i32 %10(i32 %11, i32 %12, i32 (i32, i32)* %13), !dbg !96
  store i32 %call6, i32* %result, align 4, !dbg !95
  br label %if.end7, !dbg !100

if.end7:                                          ; preds = %if.then5, %if.end3
  ret i32 0, !dbg !101
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test04.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 10.0.0 "}
!9 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 2, type: !10, scopeLine: 2, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12, !12, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "a", arg: 1, scope: !9, file: !1, line: 2, type: !12)
!14 = !DILocation(line: 2, column: 14, scope: !9)
!15 = !DILocalVariable(name: "b", arg: 2, scope: !9, file: !1, line: 2, type: !12)
!16 = !DILocation(line: 2, column: 21, scope: !9)
!17 = !DILocation(line: 3, column: 11, scope: !9)
!18 = !DILocation(line: 3, column: 13, scope: !9)
!19 = !DILocation(line: 3, column: 12, scope: !9)
!20 = !DILocation(line: 3, column: 4, scope: !9)
!21 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 6, type: !10, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!22 = !DILocalVariable(name: "a", arg: 1, scope: !21, file: !1, line: 6, type: !12)
!23 = !DILocation(line: 6, column: 15, scope: !21)
!24 = !DILocalVariable(name: "b", arg: 2, scope: !21, file: !1, line: 6, type: !12)
!25 = !DILocation(line: 6, column: 22, scope: !21)
!26 = !DILocation(line: 7, column: 11, scope: !21)
!27 = !DILocation(line: 7, column: 13, scope: !21)
!28 = !DILocation(line: 7, column: 12, scope: !21)
!29 = !DILocation(line: 7, column: 4, scope: !21)
!30 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !31, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!12, !12, !12, !33}
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!34 = !DILocalVariable(name: "a", arg: 1, scope: !30, file: !1, line: 9, type: !12)
!35 = !DILocation(line: 9, column: 13, scope: !30)
!36 = !DILocalVariable(name: "b", arg: 2, scope: !30, file: !1, line: 9, type: !12)
!37 = !DILocation(line: 9, column: 20, scope: !30)
!38 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !30, file: !1, line: 9, type: !33)
!39 = !DILocation(line: 9, column: 29, scope: !30)
!40 = !DILocation(line: 10, column: 12, scope: !30)
!41 = !DILocation(line: 10, column: 19, scope: !30)
!42 = !DILocation(line: 10, column: 22, scope: !30)
!43 = !DILocation(line: 10, column: 5, scope: !30)
!44 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 13, type: !45, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!45 = !DISubroutineType(types: !46)
!46 = !{!12, !12}
!47 = !DILocalVariable(name: "x", arg: 1, scope: !44, file: !1, line: 13, type: !12)
!48 = !DILocation(line: 13, column: 16, scope: !44)
!49 = !DILocalVariable(name: "a_fptr", scope: !44, file: !1, line: 14, type: !33)
!50 = !DILocation(line: 14, column: 11, scope: !44)
!51 = !DILocalVariable(name: "s_fptr", scope: !44, file: !1, line: 15, type: !33)
!52 = !DILocation(line: 15, column: 11, scope: !44)
!53 = !DILocalVariable(name: "t_fptr", scope: !44, file: !1, line: 16, type: !33)
!54 = !DILocation(line: 16, column: 11, scope: !44)
!55 = !DILocalVariable(name: "q_fptr", scope: !44, file: !1, line: 17, type: !33)
!56 = !DILocation(line: 17, column: 11, scope: !44)
!57 = !DILocalVariable(name: "r_fptr", scope: !44, file: !1, line: 18, type: !33)
!58 = !DILocation(line: 18, column: 11, scope: !44)
!59 = !DILocalVariable(name: "af_ptr", scope: !44, file: !1, line: 19, type: !60)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!61 = !DILocation(line: 19, column: 11, scope: !44)
!62 = !DILocalVariable(name: "op1", scope: !44, file: !1, line: 21, type: !12)
!63 = !DILocation(line: 21, column: 9, scope: !44)
!64 = !DILocalVariable(name: "op2", scope: !44, file: !1, line: 21, type: !12)
!65 = !DILocation(line: 21, column: 16, scope: !44)
!66 = !DILocation(line: 23, column: 9, scope: !67)
!67 = distinct !DILexicalBlock(scope: !44, file: !1, line: 23, column: 9)
!68 = !DILocation(line: 23, column: 11, scope: !67)
!69 = !DILocation(line: 23, column: 9, scope: !44)
!70 = !DILocation(line: 24, column: 17, scope: !71)
!71 = distinct !DILexicalBlock(scope: !67, file: !1, line: 23, column: 17)
!72 = !DILocation(line: 24, column: 15, scope: !71)
!73 = !DILocation(line: 25, column: 5, scope: !71)
!74 = !DILocation(line: 26, column: 5, scope: !44)
!75 = !DILocation(line: 26, column: 12, scope: !44)
!76 = !DILocation(line: 26, column: 16, scope: !44)
!77 = !DILocation(line: 26, column: 20, scope: !44)
!78 = !DILocation(line: 27, column: 9, scope: !79)
!79 = distinct !DILexicalBlock(scope: !44, file: !1, line: 27, column: 9)
!80 = !DILocation(line: 27, column: 11, scope: !79)
!81 = !DILocation(line: 27, column: 9, scope: !44)
!82 = !DILocation(line: 28, column: 17, scope: !83)
!83 = distinct !DILexicalBlock(scope: !79, file: !1, line: 27, column: 17)
!84 = !DILocation(line: 28, column: 15, scope: !83)
!85 = !DILocation(line: 29, column: 17, scope: !83)
!86 = !DILocation(line: 29, column: 15, scope: !83)
!87 = !DILocation(line: 30, column: 5, scope: !83)
!88 = !DILocation(line: 32, column: 9, scope: !89)
!89 = distinct !DILexicalBlock(scope: !44, file: !1, line: 32, column: 9)
!90 = !DILocation(line: 32, column: 16, scope: !89)
!91 = !DILocation(line: 32, column: 9, scope: !44)
!92 = !DILocalVariable(name: "result", scope: !93, file: !1, line: 33, type: !94)
!93 = distinct !DILexicalBlock(scope: !89, file: !1, line: 32, column: 25)
!94 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!95 = !DILocation(line: 33, column: 17, scope: !93)
!96 = !DILocation(line: 33, column: 26, scope: !93)
!97 = !DILocation(line: 33, column: 33, scope: !93)
!98 = !DILocation(line: 33, column: 37, scope: !93)
!99 = !DILocation(line: 33, column: 41, scope: !93)
!100 = !DILocation(line: 34, column: 5, scope: !93)
!101 = !DILocation(line: 35, column: 4, scope: !44)
