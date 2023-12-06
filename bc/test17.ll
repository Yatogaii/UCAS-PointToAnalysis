; ModuleID = 'test17.bc'
source_filename = "test17.c"
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
define dso_local i32 (i32, i32)* @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr) #0 !dbg !28 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %b_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !36, metadata !DIExpression()), !dbg !37
  store i32 (i32, i32)* %b_fptr, i32 (i32, i32)** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %b_fptr.addr, metadata !38, metadata !DIExpression()), !dbg !39
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %b_fptr.addr, align 8, !dbg !40
  ret i32 (i32, i32)* %0, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr, i32 (i32, i32)* %b_fptr.coerce) #0 !dbg !42 {
entry:
  %b_fptr = alloca %struct.fptr, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  %s_fptr = alloca i32 (i32, i32)*, align 8
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0
  store i32 (i32, i32)* %b_fptr.coerce, i32 (i32, i32)** %coerce.dive, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !48, metadata !DIExpression()), !dbg !49
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !50, metadata !DIExpression()), !dbg !51
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !52, metadata !DIExpression()), !dbg !53
  call void @llvm.dbg.declare(metadata %struct.fptr* %b_fptr, metadata !54, metadata !DIExpression()), !dbg !55
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %s_fptr, metadata !56, metadata !DIExpression()), !dbg !57
  %0 = load i32, i32* %a.addr, align 4, !dbg !58
  %1 = load i32, i32* %b.addr, align 4, !dbg !59
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !60
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0, !dbg !61
  %3 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !61
  %call = call i32 (i32, i32)* @foo(i32 %0, i32 %1, i32 (i32, i32)* %2, i32 (i32, i32)* %3), !dbg !62
  store i32 (i32, i32)* %call, i32 (i32, i32)** %s_fptr, align 8, !dbg !63
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !64
  %5 = load i32, i32* %a.addr, align 4, !dbg !65
  %6 = load i32, i32* %b.addr, align 4, !dbg !66
  %call1 = call i32 %4(i32 %5, i32 %6), !dbg !64
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
  %t_fptr = alloca %struct.fptr, align 8
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
  call void @llvm.dbg.declare(metadata %struct.fptr* %t_fptr, metadata !82, metadata !DIExpression()), !dbg !83
  %0 = bitcast %struct.fptr* %t_fptr to i8*, !dbg !83
  call void @llvm.memset.p0i8.i64(i8* align 8 %0, i8 0, i64 8, i1 false), !dbg !83
  %1 = load i8, i8* %x.addr, align 1, !dbg !84
  %conv = sext i8 %1 to i32, !dbg !84
  %cmp = icmp eq i32 %conv, 43, !dbg !86
  br i1 %cmp, label %if.then, label %if.else, !dbg !87

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !88
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !90
  store i32 (i32, i32)* %2, i32 (i32, i32)** %p_fptr, align 8, !dbg !91
  br label %if.end7, !dbg !92

if.else:                                          ; preds = %entry
  %3 = load i8, i8* %x.addr, align 1, !dbg !93
  %conv2 = sext i8 %3 to i32, !dbg !93
  %cmp3 = icmp eq i32 %conv2, 45, !dbg !95
  br i1 %cmp3, label %if.then5, label %if.end, !dbg !96

if.then5:                                         ; preds = %if.else
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %s_fptr, align 8, !dbg !97
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !99
  store i32 (i32, i32)* %4, i32 (i32, i32)** %p_fptr6, align 8, !dbg !100
  br label %if.end, !dbg !101

if.end:                                           ; preds = %if.then5, %if.else
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then
  call void @llvm.dbg.declare(metadata i32* %result, metadata !102, metadata !DIExpression()), !dbg !104
  %5 = load i32, i32* %op1.addr, align 4, !dbg !105
  %6 = load i32, i32* %op2.addr, align 4, !dbg !106
  %7 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr, align 8, !dbg !107
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %t_fptr, i32 0, i32 0, !dbg !108
  %8 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive, align 8, !dbg !108
  %call = call i32 @clever(i32 %5, i32 %6, i32 (i32, i32)* %7, i32 (i32, i32)* %8), !dbg !108
  store i32 %call, i32* %result, align 4, !dbg !104
  ret i32 0, !dbg !109
}

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test17.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 6, type: !8, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 6, type: !10)
!12 = !DILocation(line: 6, column: 14, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 6, type: !10)
!14 = !DILocation(line: 6, column: 21, scope: !7)
!15 = !DILocation(line: 7, column: 11, scope: !7)
!16 = !DILocation(line: 7, column: 13, scope: !7)
!17 = !DILocation(line: 7, column: 12, scope: !7)
!18 = !DILocation(line: 7, column: 4, scope: !7)
!19 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 10, type: !8, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 10, type: !10)
!21 = !DILocation(line: 10, column: 15, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 10, type: !10)
!23 = !DILocation(line: 10, column: 22, scope: !19)
!24 = !DILocation(line: 11, column: 11, scope: !19)
!25 = !DILocation(line: 11, column: 13, scope: !19)
!26 = !DILocation(line: 11, column: 12, scope: !19)
!27 = !DILocation(line: 11, column: 4, scope: !19)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 14, type: !29, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !10, !10, !31, !31}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!32 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 14, type: !10)
!33 = !DILocation(line: 14, column: 15, scope: !28)
!34 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 14, type: !10)
!35 = !DILocation(line: 14, column: 22, scope: !28)
!36 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !28, file: !1, line: 14, type: !31)
!37 = !DILocation(line: 14, column: 31, scope: !28)
!38 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !28, file: !1, line: 14, type: !31)
!39 = !DILocation(line: 14, column: 55, scope: !28)
!40 = !DILocation(line: 15, column: 11, scope: !28)
!41 = !DILocation(line: 15, column: 4, scope: !28)
!42 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 18, type: !43, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!10, !10, !10, !31, !45}
!45 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !46)
!46 = !{!47}
!47 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !45, file: !1, line: 4, baseType: !31, size: 64)
!48 = !DILocalVariable(name: "a", arg: 1, scope: !42, file: !1, line: 18, type: !10)
!49 = !DILocation(line: 18, column: 16, scope: !42)
!50 = !DILocalVariable(name: "b", arg: 2, scope: !42, file: !1, line: 18, type: !10)
!51 = !DILocation(line: 18, column: 23, scope: !42)
!52 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !42, file: !1, line: 18, type: !31)
!53 = !DILocation(line: 18, column: 32, scope: !42)
!54 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !42, file: !1, line: 18, type: !45)
!55 = !DILocation(line: 18, column: 63, scope: !42)
!56 = !DILocalVariable(name: "s_fptr", scope: !42, file: !1, line: 19, type: !31)
!57 = !DILocation(line: 19, column: 10, scope: !42)
!58 = !DILocation(line: 20, column: 17, scope: !42)
!59 = !DILocation(line: 20, column: 20, scope: !42)
!60 = !DILocation(line: 20, column: 23, scope: !42)
!61 = !DILocation(line: 20, column: 38, scope: !42)
!62 = !DILocation(line: 20, column: 13, scope: !42)
!63 = !DILocation(line: 20, column: 11, scope: !42)
!64 = !DILocation(line: 21, column: 11, scope: !42)
!65 = !DILocation(line: 21, column: 18, scope: !42)
!66 = !DILocation(line: 21, column: 21, scope: !42)
!67 = !DILocation(line: 21, column: 4, scope: !42)
!68 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 25, type: !69, scopeLine: 25, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!69 = !DISubroutineType(types: !70)
!70 = !{!10, !71, !10, !10}
!71 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!72 = !DILocalVariable(name: "x", arg: 1, scope: !68, file: !1, line: 25, type: !71)
!73 = !DILocation(line: 25, column: 14, scope: !68)
!74 = !DILocalVariable(name: "op1", arg: 2, scope: !68, file: !1, line: 25, type: !10)
!75 = !DILocation(line: 25, column: 21, scope: !68)
!76 = !DILocalVariable(name: "op2", arg: 3, scope: !68, file: !1, line: 25, type: !10)
!77 = !DILocation(line: 25, column: 30, scope: !68)
!78 = !DILocalVariable(name: "a_fptr", scope: !68, file: !1, line: 26, type: !31)
!79 = !DILocation(line: 26, column: 11, scope: !68)
!80 = !DILocalVariable(name: "s_fptr", scope: !68, file: !1, line: 27, type: !31)
!81 = !DILocation(line: 27, column: 11, scope: !68)
!82 = !DILocalVariable(name: "t_fptr", scope: !68, file: !1, line: 28, type: !45)
!83 = !DILocation(line: 28, column: 17, scope: !68)
!84 = !DILocation(line: 30, column: 9, scope: !85)
!85 = distinct !DILexicalBlock(scope: !68, file: !1, line: 30, column: 9)
!86 = !DILocation(line: 30, column: 11, scope: !85)
!87 = !DILocation(line: 30, column: 9, scope: !68)
!88 = !DILocation(line: 31, column: 24, scope: !89)
!89 = distinct !DILexicalBlock(scope: !85, file: !1, line: 30, column: 19)
!90 = !DILocation(line: 31, column: 15, scope: !89)
!91 = !DILocation(line: 31, column: 22, scope: !89)
!92 = !DILocation(line: 32, column: 5, scope: !89)
!93 = !DILocation(line: 33, column: 14, scope: !94)
!94 = distinct !DILexicalBlock(scope: !85, file: !1, line: 33, column: 14)
!95 = !DILocation(line: 33, column: 16, scope: !94)
!96 = !DILocation(line: 33, column: 14, scope: !85)
!97 = !DILocation(line: 34, column: 24, scope: !98)
!98 = distinct !DILexicalBlock(scope: !94, file: !1, line: 33, column: 24)
!99 = !DILocation(line: 34, column: 15, scope: !98)
!100 = !DILocation(line: 34, column: 22, scope: !98)
!101 = !DILocation(line: 35, column: 5, scope: !98)
!102 = !DILocalVariable(name: "result", scope: !68, file: !1, line: 37, type: !103)
!103 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!104 = !DILocation(line: 37, column: 14, scope: !68)
!105 = !DILocation(line: 37, column: 30, scope: !68)
!106 = !DILocation(line: 37, column: 35, scope: !68)
!107 = !DILocation(line: 37, column: 40, scope: !68)
!108 = !DILocation(line: 37, column: 23, scope: !68)
!109 = !DILocation(line: 38, column: 5, scope: !68)
