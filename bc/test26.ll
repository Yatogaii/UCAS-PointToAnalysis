; ModuleID = 'test26.bc'
source_filename = "test26.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.wfsptr = type { %struct.fsptr* }
%struct.fsptr = type { %struct.fptr* }
%struct.fptr = type { i32 (i32, i32)* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !24 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !25, metadata !DIExpression()), !dbg !26
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !27, metadata !DIExpression()), !dbg !28
  %0 = load i32, i32* %a.addr, align 4, !dbg !29
  %1 = load i32, i32* %b.addr, align 4, !dbg !30
  %add = add nsw i32 %0, %1, !dbg !31
  ret i32 %add, !dbg !32
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !33 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !36, metadata !DIExpression()), !dbg !37
  %0 = load i32, i32* %a.addr, align 4, !dbg !38
  %1 = load i32, i32* %b.addr, align 4, !dbg !39
  %sub = sub nsw i32 %0, %1, !dbg !40
  ret i32 %sub, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @make_alias(%struct.wfsptr* %a, %struct.fsptr* %b) #0 !dbg !42 {
entry:
  %a.addr = alloca %struct.wfsptr*, align 8
  %b.addr = alloca %struct.fsptr*, align 8
  store %struct.wfsptr* %a, %struct.wfsptr** %a.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %a.addr, metadata !45, metadata !DIExpression()), !dbg !46
  store %struct.fsptr* %b, %struct.fsptr** %b.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b.addr, metadata !47, metadata !DIExpression()), !dbg !48
  %0 = load %struct.fsptr*, %struct.fsptr** %b.addr, align 8, !dbg !49
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !50
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !50
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !51
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !51
  %3 = load %struct.wfsptr*, %struct.wfsptr** %a.addr, align 8, !dbg !52
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %3, i32 0, i32 0, !dbg !53
  %4 = load %struct.fsptr*, %struct.fsptr** %wfptr, align 8, !dbg !53
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %4, i32 0, i32 0, !dbg !54
  %5 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !54
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !55
  store i32 (i32, i32)* %2, i32 (i32, i32)** %p_fptr2, align 8, !dbg !56
  ret void, !dbg !57
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foo(i32 %x) #0 !dbg !58 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %b_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %m_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.wfsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !61, metadata !DIExpression()), !dbg !62
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !63, metadata !DIExpression()), !dbg !64
  call void @llvm.dbg.declare(metadata %struct.fptr* %b_fptr, metadata !65, metadata !DIExpression()), !dbg !66
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !67, metadata !DIExpression()), !dbg !68
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !69, metadata !DIExpression()), !dbg !70
  call void @llvm.dbg.declare(metadata %struct.wfsptr** %w_fptr, metadata !71, metadata !DIExpression()), !dbg !72
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !73
  %0 = bitcast i8* %call to %struct.wfsptr*, !dbg !74
  store %struct.wfsptr* %0, %struct.wfsptr** %w_fptr, align 8, !dbg !72
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !75
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !76
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !77
  store %struct.fptr* %b_fptr, %struct.fptr** %sptr1, align 8, !dbg !78
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %b_fptr, i32 0, i32 0, !dbg !79
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr, align 8, !dbg !80
  %1 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !81
  %wfptr = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %1, i32 0, i32 0, !dbg !82
  store %struct.fsptr* %s_fptr, %struct.fsptr** %wfptr, align 8, !dbg !83
  %2 = load i32, i32* %x.addr, align 4, !dbg !84
  %cmp = icmp sgt i32 %2, 1, !dbg !86
  br i1 %cmp, label %if.then, label %if.else, !dbg !87

if.then:                                          ; preds = %entry
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !88
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr2, align 8, !dbg !90
  %sptr3 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !91
  %3 = load %struct.fptr*, %struct.fptr** %sptr3, align 8, !dbg !91
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %3, i32 0, i32 0, !dbg !92
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr4, align 8, !dbg !92
  %5 = load i32, i32* %x.addr, align 4, !dbg !93
  %call5 = call i32 %4(i32 1, i32 %5), !dbg !94
  store i32 %call5, i32* %x.addr, align 4, !dbg !95
  %6 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !96
  call void @make_alias(%struct.wfsptr* %6, %struct.fsptr* %m_fptr), !dbg !97
  br label %if.end, !dbg !98

if.else:                                          ; preds = %entry
  %7 = load %struct.wfsptr*, %struct.wfsptr** %w_fptr, align 8, !dbg !99
  %wfptr6 = getelementptr inbounds %struct.wfsptr, %struct.wfsptr* %7, i32 0, i32 0, !dbg !101
  %8 = load %struct.fsptr*, %struct.fsptr** %wfptr6, align 8, !dbg !101
  %sptr7 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !102
  %9 = load %struct.fptr*, %struct.fptr** %sptr7, align 8, !dbg !102
  %p_fptr8 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !103
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr8, align 8, !dbg !104
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr9 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !105
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr9, align 8, !dbg !105
  %11 = load i32, i32* %x.addr, align 4, !dbg !106
  %call10 = call i32 %10(i32 1, i32 %11), !dbg !107
  store i32 %call10, i32* %x.addr, align 4, !dbg !108
  ret void, !dbg !109
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!20, !21, !22}
!llvm.ident = !{!23}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test26.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wfsptr", file: !1, line: 10, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "wfptr", scope: !5, file: !1, line: 12, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !9, file: !1, line: 8, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !14)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !13, file: !1, line: 4, baseType: !16, size: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !17, size: 64)
!17 = !DISubroutineType(types: !18)
!18 = !{!19, !19, !19}
!19 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!20 = !{i32 7, !"Dwarf Version", i32 4}
!21 = !{i32 2, !"Debug Info Version", i32 3}
!22 = !{i32 1, !"wchar_size", i32 4}
!23 = !{!"clang version 10.0.0 "}
!24 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 14, type: !17, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!25 = !DILocalVariable(name: "a", arg: 1, scope: !24, file: !1, line: 14, type: !19)
!26 = !DILocation(line: 14, column: 14, scope: !24)
!27 = !DILocalVariable(name: "b", arg: 2, scope: !24, file: !1, line: 14, type: !19)
!28 = !DILocation(line: 14, column: 21, scope: !24)
!29 = !DILocation(line: 15, column: 11, scope: !24)
!30 = !DILocation(line: 15, column: 13, scope: !24)
!31 = !DILocation(line: 15, column: 12, scope: !24)
!32 = !DILocation(line: 15, column: 4, scope: !24)
!33 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 18, type: !17, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!34 = !DILocalVariable(name: "a", arg: 1, scope: !33, file: !1, line: 18, type: !19)
!35 = !DILocation(line: 18, column: 15, scope: !33)
!36 = !DILocalVariable(name: "b", arg: 2, scope: !33, file: !1, line: 18, type: !19)
!37 = !DILocation(line: 18, column: 22, scope: !33)
!38 = !DILocation(line: 19, column: 11, scope: !33)
!39 = !DILocation(line: 19, column: 13, scope: !33)
!40 = !DILocation(line: 19, column: 12, scope: !33)
!41 = !DILocation(line: 19, column: 4, scope: !33)
!42 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 21, type: !43, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{null, !4, !8}
!45 = !DILocalVariable(name: "a", arg: 1, scope: !42, file: !1, line: 21, type: !4)
!46 = !DILocation(line: 21, column: 32, scope: !42)
!47 = !DILocalVariable(name: "b", arg: 2, scope: !42, file: !1, line: 21, type: !8)
!48 = !DILocation(line: 21, column: 48, scope: !42)
!49 = !DILocation(line: 23, column: 25, scope: !42)
!50 = !DILocation(line: 23, column: 28, scope: !42)
!51 = !DILocation(line: 23, column: 34, scope: !42)
!52 = !DILocation(line: 23, column: 2, scope: !42)
!53 = !DILocation(line: 23, column: 5, scope: !42)
!54 = !DILocation(line: 23, column: 12, scope: !42)
!55 = !DILocation(line: 23, column: 18, scope: !42)
!56 = !DILocation(line: 23, column: 24, scope: !42)
!57 = !DILocation(line: 24, column: 1, scope: !42)
!58 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 25, type: !59, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!59 = !DISubroutineType(types: !60)
!60 = !{null, !19}
!61 = !DILocalVariable(name: "x", arg: 1, scope: !58, file: !1, line: 25, type: !19)
!62 = !DILocation(line: 25, column: 14, scope: !58)
!63 = !DILocalVariable(name: "a_fptr", scope: !58, file: !1, line: 27, type: !13)
!64 = !DILocation(line: 27, column: 14, scope: !58)
!65 = !DILocalVariable(name: "b_fptr", scope: !58, file: !1, line: 28, type: !13)
!66 = !DILocation(line: 28, column: 14, scope: !58)
!67 = !DILocalVariable(name: "s_fptr", scope: !58, file: !1, line: 29, type: !9)
!68 = !DILocation(line: 29, column: 15, scope: !58)
!69 = !DILocalVariable(name: "m_fptr", scope: !58, file: !1, line: 30, type: !9)
!70 = !DILocation(line: 30, column: 15, scope: !58)
!71 = !DILocalVariable(name: "w_fptr", scope: !58, file: !1, line: 31, type: !4)
!72 = !DILocation(line: 31, column: 17, scope: !58)
!73 = !DILocation(line: 31, column: 40, scope: !58)
!74 = !DILocation(line: 31, column: 24, scope: !58)
!75 = !DILocation(line: 32, column: 9, scope: !58)
!76 = !DILocation(line: 32, column: 13, scope: !58)
!77 = !DILocation(line: 33, column: 9, scope: !58)
!78 = !DILocation(line: 33, column: 13, scope: !58)
!79 = !DILocation(line: 34, column: 9, scope: !58)
!80 = !DILocation(line: 34, column: 15, scope: !58)
!81 = !DILocation(line: 35, column: 2, scope: !58)
!82 = !DILocation(line: 35, column: 10, scope: !58)
!83 = !DILocation(line: 35, column: 15, scope: !58)
!84 = !DILocation(line: 36, column: 5, scope: !85)
!85 = distinct !DILexicalBlock(scope: !58, file: !1, line: 36, column: 5)
!86 = !DILocation(line: 36, column: 6, scope: !85)
!87 = !DILocation(line: 36, column: 5, scope: !58)
!88 = !DILocation(line: 38, column: 11, scope: !89)
!89 = distinct !DILexicalBlock(scope: !85, file: !1, line: 37, column: 2)
!90 = !DILocation(line: 38, column: 17, scope: !89)
!91 = !DILocation(line: 39, column: 13, scope: !89)
!92 = !DILocation(line: 39, column: 19, scope: !89)
!93 = !DILocation(line: 39, column: 28, scope: !89)
!94 = !DILocation(line: 39, column: 6, scope: !89)
!95 = !DILocation(line: 39, column: 5, scope: !89)
!96 = !DILocation(line: 40, column: 15, scope: !89)
!97 = !DILocation(line: 40, column: 4, scope: !89)
!98 = !DILocation(line: 41, column: 2, scope: !89)
!99 = !DILocation(line: 43, column: 3, scope: !100)
!100 = distinct !DILexicalBlock(scope: !85, file: !1, line: 42, column: 2)
!101 = !DILocation(line: 43, column: 11, scope: !100)
!102 = !DILocation(line: 43, column: 18, scope: !100)
!103 = !DILocation(line: 43, column: 24, scope: !100)
!104 = !DILocation(line: 43, column: 30, scope: !100)
!105 = !DILocation(line: 45, column: 11, scope: !58)
!106 = !DILocation(line: 45, column: 20, scope: !58)
!107 = !DILocation(line: 45, column: 4, scope: !58)
!108 = !DILocation(line: 45, column: 3, scope: !58)
!109 = !DILocation(line: 46, column: 1, scope: !58)
