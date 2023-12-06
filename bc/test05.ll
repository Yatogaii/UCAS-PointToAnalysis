; ModuleID = 'test05.bc'
source_filename = "test05.c"
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
define dso_local i32 @clever(i32 %x) #0 !dbg !30 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %t_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %q_fptr = alloca [1 x i32 (i32, i32)*], align 8
  %r_fptr = alloca [2 x i32 (i32, i32)*], align 16
  %op1 = alloca i32, align 4
  %op2 = alloca i32, align 4
  %result = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !33, metadata !DIExpression()), !dbg !34
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr, metadata !35, metadata !DIExpression()), !dbg !37
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %a_fptr, align 8, !dbg !37
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !38, metadata !DIExpression()), !dbg !39
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %s_fptr, align 8, !dbg !39
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %t_fptr, metadata !40, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.declare(metadata [1 x i32 (i32, i32)*]* %q_fptr, metadata !45, metadata !DIExpression()), !dbg !49
  call void @llvm.dbg.declare(metadata [2 x i32 (i32, i32)*]* %r_fptr, metadata !50, metadata !DIExpression()), !dbg !51
  call void @llvm.dbg.declare(metadata i32* %op1, metadata !52, metadata !DIExpression()), !dbg !53
  store i32 1, i32* %op1, align 4, !dbg !53
  call void @llvm.dbg.declare(metadata i32* %op2, metadata !54, metadata !DIExpression()), !dbg !55
  store i32 2, i32* %op2, align 4, !dbg !55
  %0 = load i32, i32* %x.addr, align 4, !dbg !56
  %cmp = icmp sge i32 %0, 3, !dbg !58
  br i1 %cmp, label %if.then, label %if.end, !dbg !59

if.then:                                          ; preds = %entry
  %1 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !60
  %arrayidx = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !62
  store i32 (i32, i32)* %1, i32 (i32, i32)** %arrayidx, align 8, !dbg !63
  br label %if.end, !dbg !64

if.end:                                           ; preds = %if.then, %entry
  %2 = load i32, i32* %x.addr, align 4, !dbg !65
  %cmp1 = icmp sge i32 %2, 4, !dbg !67
  br i1 %cmp1, label %if.then2, label %if.end4, !dbg !68

if.then2:                                         ; preds = %if.end
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !69
  %arrayidx3 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !71
  store i32 (i32, i32)* %3, i32 (i32, i32)** %arrayidx3, align 8, !dbg !72
  br label %if.end4, !dbg !73

if.end4:                                          ; preds = %if.then2, %if.end
  %4 = load i32, i32* %x.addr, align 4, !dbg !74
  %cmp5 = icmp sge i32 %4, 5, !dbg !76
  br i1 %cmp5, label %if.then6, label %if.end9, !dbg !77

if.then6:                                         ; preds = %if.end4
  %arrayidx7 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !78
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx7, align 8, !dbg !78
  %arrayidx8 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !80
  store i32 (i32, i32)* %5, i32 (i32, i32)** %arrayidx8, align 8, !dbg !81
  br label %if.end9, !dbg !82

if.end9:                                          ; preds = %if.then6, %if.end4
  %6 = load i32, i32* %x.addr, align 4, !dbg !83
  %cmp10 = icmp sge i32 %6, 6, !dbg !85
  br i1 %cmp10, label %if.then11, label %if.end14, !dbg !86

if.then11:                                        ; preds = %if.end9
  %arrayidx12 = getelementptr inbounds [1 x i32 (i32, i32)*], [1 x i32 (i32, i32)*]* %q_fptr, i64 0, i64 0, !dbg !87
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx12, align 8, !dbg !87
  %arrayidx13 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !88
  store i32 (i32, i32)* %7, i32 (i32, i32)** %arrayidx13, align 8, !dbg !89
  br label %if.end14, !dbg !88

if.end14:                                         ; preds = %if.then11, %if.end9
  %arrayidx15 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %t_fptr, i64 0, i64 1, !dbg !90
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx15, align 8, !dbg !90
  %cmp16 = icmp ne i32 (i32, i32)* %8, null, !dbg !92
  br i1 %cmp16, label %if.then17, label %if.end19, !dbg !93

if.then17:                                        ; preds = %if.end14
  call void @llvm.dbg.declare(metadata i32* %result, metadata !94, metadata !DIExpression()), !dbg !97
  %arrayidx18 = getelementptr inbounds [2 x i32 (i32, i32)*], [2 x i32 (i32, i32)*]* %r_fptr, i64 0, i64 1, !dbg !98
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %arrayidx18, align 8, !dbg !98
  %10 = load i32, i32* %op1, align 4, !dbg !99
  %11 = load i32, i32* %op2, align 4, !dbg !100
  %call = call i32 %9(i32 %10, i32 %11), !dbg !98
  store i32 %call, i32* %result, align 4, !dbg !97
  br label %if.end19, !dbg !101

if.end19:                                         ; preds = %if.then17, %if.end14
  ret i32 0, !dbg !102
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test05.c", directory: "/root/assign3/test")
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
!30 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 10, type: !31, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!31 = !DISubroutineType(types: !32)
!32 = !{!12, !12}
!33 = !DILocalVariable(name: "x", arg: 1, scope: !30, file: !1, line: 10, type: !12)
!34 = !DILocation(line: 10, column: 16, scope: !30)
!35 = !DILocalVariable(name: "a_fptr", scope: !30, file: !1, line: 11, type: !36)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!37 = !DILocation(line: 11, column: 11, scope: !30)
!38 = !DILocalVariable(name: "s_fptr", scope: !30, file: !1, line: 12, type: !36)
!39 = !DILocation(line: 12, column: 11, scope: !30)
!40 = !DILocalVariable(name: "t_fptr", scope: !30, file: !1, line: 13, type: !41)
!41 = !DICompositeType(tag: DW_TAG_array_type, baseType: !36, size: 128, elements: !42)
!42 = !{!43}
!43 = !DISubrange(count: 2)
!44 = !DILocation(line: 13, column: 11, scope: !30)
!45 = !DILocalVariable(name: "q_fptr", scope: !30, file: !1, line: 14, type: !46)
!46 = !DICompositeType(tag: DW_TAG_array_type, baseType: !36, size: 64, elements: !47)
!47 = !{!48}
!48 = !DISubrange(count: 1)
!49 = !DILocation(line: 14, column: 11, scope: !30)
!50 = !DILocalVariable(name: "r_fptr", scope: !30, file: !1, line: 15, type: !41)
!51 = !DILocation(line: 15, column: 11, scope: !30)
!52 = !DILocalVariable(name: "op1", scope: !30, file: !1, line: 17, type: !12)
!53 = !DILocation(line: 17, column: 9, scope: !30)
!54 = !DILocalVariable(name: "op2", scope: !30, file: !1, line: 17, type: !12)
!55 = !DILocation(line: 17, column: 16, scope: !30)
!56 = !DILocation(line: 19, column: 9, scope: !57)
!57 = distinct !DILexicalBlock(scope: !30, file: !1, line: 19, column: 9)
!58 = !DILocation(line: 19, column: 11, scope: !57)
!59 = !DILocation(line: 19, column: 9, scope: !30)
!60 = !DILocation(line: 20, column: 20, scope: !61)
!61 = distinct !DILexicalBlock(scope: !57, file: !1, line: 19, column: 17)
!62 = !DILocation(line: 20, column: 8, scope: !61)
!63 = !DILocation(line: 20, column: 18, scope: !61)
!64 = !DILocation(line: 21, column: 5, scope: !61)
!65 = !DILocation(line: 22, column: 9, scope: !66)
!66 = distinct !DILexicalBlock(scope: !30, file: !1, line: 22, column: 9)
!67 = !DILocation(line: 22, column: 11, scope: !66)
!68 = !DILocation(line: 22, column: 9, scope: !30)
!69 = !DILocation(line: 23, column: 20, scope: !70)
!70 = distinct !DILexicalBlock(scope: !66, file: !1, line: 22, column: 17)
!71 = !DILocation(line: 23, column: 8, scope: !70)
!72 = !DILocation(line: 23, column: 18, scope: !70)
!73 = !DILocation(line: 24, column: 5, scope: !70)
!74 = !DILocation(line: 25, column: 9, scope: !75)
!75 = distinct !DILexicalBlock(scope: !30, file: !1, line: 25, column: 9)
!76 = !DILocation(line: 25, column: 11, scope: !75)
!77 = !DILocation(line: 25, column: 9, scope: !30)
!78 = !DILocation(line: 26, column: 20, scope: !79)
!79 = distinct !DILexicalBlock(scope: !75, file: !1, line: 25, column: 17)
!80 = !DILocation(line: 26, column: 8, scope: !79)
!81 = !DILocation(line: 26, column: 18, scope: !79)
!82 = !DILocation(line: 27, column: 5, scope: !79)
!83 = !DILocation(line: 28, column: 9, scope: !84)
!84 = distinct !DILexicalBlock(scope: !30, file: !1, line: 28, column: 9)
!85 = !DILocation(line: 28, column: 11, scope: !84)
!86 = !DILocation(line: 28, column: 9, scope: !30)
!87 = !DILocation(line: 29, column: 20, scope: !84)
!88 = !DILocation(line: 29, column: 8, scope: !84)
!89 = !DILocation(line: 29, column: 18, scope: !84)
!90 = !DILocation(line: 32, column: 9, scope: !91)
!91 = distinct !DILexicalBlock(scope: !30, file: !1, line: 32, column: 9)
!92 = !DILocation(line: 32, column: 19, scope: !91)
!93 = !DILocation(line: 32, column: 9, scope: !30)
!94 = !DILocalVariable(name: "result", scope: !95, file: !1, line: 33, type: !96)
!95 = distinct !DILexicalBlock(scope: !91, file: !1, line: 32, column: 28)
!96 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!97 = !DILocation(line: 33, column: 17, scope: !95)
!98 = !DILocation(line: 33, column: 26, scope: !95)
!99 = !DILocation(line: 33, column: 36, scope: !95)
!100 = !DILocation(line: 33, column: 41, scope: !95)
!101 = !DILocation(line: 34, column: 5, scope: !95)
!102 = !DILocation(line: 35, column: 4, scope: !30)
