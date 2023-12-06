; ModuleID = 'test20.bc'
source_filename = "test20.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

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
define dso_local %struct.fptr* @foo(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !28 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !40, metadata !DIExpression()), !dbg !41
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !42, metadata !DIExpression()), !dbg !43
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !44, metadata !DIExpression()), !dbg !45
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !46, metadata !DIExpression()), !dbg !47
  %0 = load %struct.fsptr*, %struct.fsptr** %a_fptr.addr, align 8, !dbg !48
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !49
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !49
  ret %struct.fptr* %1, !dbg !50
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local %struct.fptr* @clever(i32 %a, i32 %b, %struct.fsptr* %a_fptr, %struct.fsptr* %b_fptr) #0 !dbg !51 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca %struct.fsptr*, align 8
  %b_fptr.addr = alloca %struct.fsptr*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !52, metadata !DIExpression()), !dbg !53
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !54, metadata !DIExpression()), !dbg !55
  store %struct.fsptr* %a_fptr, %struct.fsptr** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a_fptr.addr, metadata !56, metadata !DIExpression()), !dbg !57
  store %struct.fsptr* %b_fptr, %struct.fsptr** %b_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %b_fptr.addr, metadata !58, metadata !DIExpression()), !dbg !59
  %0 = load %struct.fsptr*, %struct.fsptr** %b_fptr.addr, align 8, !dbg !60
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %0, i32 0, i32 0, !dbg !61
  %1 = load %struct.fptr*, %struct.fptr** %sptr, align 8, !dbg !61
  ret %struct.fptr* %1, !dbg !62
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x, i32 %op1, i32 %op2) #0 !dbg !63 {
entry:
  %x.addr = alloca i8, align 1
  %op1.addr = alloca i32, align 4
  %op2.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fptr, align 8
  %m_fptr = alloca %struct.fsptr, align 8
  %n_fptr = alloca %struct.fsptr, align 8
  %goo_ptr = alloca %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)*, align 8
  %t_fptr = alloca %struct.fptr*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !67, metadata !DIExpression()), !dbg !68
  store i32 %op1, i32* %op1.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op1.addr, metadata !69, metadata !DIExpression()), !dbg !70
  store i32 %op2, i32* %op2.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %op2.addr, metadata !71, metadata !DIExpression()), !dbg !72
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !73, metadata !DIExpression()), !dbg !74
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !75
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !76
  call void @llvm.dbg.declare(metadata %struct.fptr* %s_fptr, metadata !77, metadata !DIExpression()), !dbg !78
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %s_fptr, i32 0, i32 0, !dbg !79
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !80
  call void @llvm.dbg.declare(metadata %struct.fsptr* %m_fptr, metadata !81, metadata !DIExpression()), !dbg !82
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %m_fptr, i32 0, i32 0, !dbg !83
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata %struct.fsptr* %n_fptr, metadata !85, metadata !DIExpression()), !dbg !86
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %n_fptr, i32 0, i32 0, !dbg !87
  store %struct.fptr* %s_fptr, %struct.fptr** %sptr2, align 8, !dbg !88
  call void @llvm.dbg.declare(metadata %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, metadata !89, metadata !DIExpression()), !dbg !91
  call void @llvm.dbg.declare(metadata %struct.fptr** %t_fptr, metadata !92, metadata !DIExpression()), !dbg !93
  store %struct.fptr* null, %struct.fptr** %t_fptr, align 8, !dbg !93
  %0 = load i8, i8* %x.addr, align 1, !dbg !94
  %conv = sext i8 %0 to i32, !dbg !94
  %cmp = icmp eq i32 %conv, 43, !dbg !96
  br i1 %cmp, label %if.then, label %if.else, !dbg !97

if.then:                                          ; preds = %entry
  store %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @foo, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !98
  br label %if.end8, !dbg !100

if.else:                                          ; preds = %entry
  %1 = load i8, i8* %x.addr, align 1, !dbg !101
  %conv4 = sext i8 %1 to i32, !dbg !101
  %cmp5 = icmp eq i32 %conv4, 45, !dbg !103
  br i1 %cmp5, label %if.then7, label %if.end, !dbg !104

if.then7:                                         ; preds = %if.else
  store %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)* @clever, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !105
  br label %if.end, !dbg !107

if.end:                                           ; preds = %if.then7, %if.else
  br label %if.end8

if.end8:                                          ; preds = %if.end, %if.then
  %2 = load %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)*, %struct.fptr* (i32, i32, %struct.fsptr*, %struct.fsptr*)** %goo_ptr, align 8, !dbg !108
  %3 = load i32, i32* %op1.addr, align 4, !dbg !109
  %4 = load i32, i32* %op2.addr, align 4, !dbg !110
  %call = call %struct.fptr* %2(i32 %3, i32 %4, %struct.fsptr* %m_fptr, %struct.fsptr* %n_fptr), !dbg !108
  store %struct.fptr* %call, %struct.fptr** %t_fptr, align 8, !dbg !111
  %5 = load %struct.fptr*, %struct.fptr** %t_fptr, align 8, !dbg !112
  %p_fptr9 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !113
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr9, align 8, !dbg !113
  %7 = load i32, i32* %op1.addr, align 4, !dbg !114
  %8 = load i32, i32* %op2.addr, align 4, !dbg !115
  %call10 = call i32 %6(i32 %7, i32 %8), !dbg !112
  ret i32 0, !dbg !116
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test20.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !8, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 10, type: !10)
!12 = !DILocation(line: 10, column: 14, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 10, type: !10)
!14 = !DILocation(line: 10, column: 21, scope: !7)
!15 = !DILocation(line: 11, column: 11, scope: !7)
!16 = !DILocation(line: 11, column: 13, scope: !7)
!17 = !DILocation(line: 11, column: 12, scope: !7)
!18 = !DILocation(line: 11, column: 4, scope: !7)
!19 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !8, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 14, type: !10)
!21 = !DILocation(line: 14, column: 15, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 14, type: !10)
!23 = !DILocation(line: 14, column: 22, scope: !19)
!24 = !DILocation(line: 15, column: 11, scope: !19)
!25 = !DILocation(line: 15, column: 13, scope: !19)
!26 = !DILocation(line: 15, column: 12, scope: !19)
!27 = !DILocation(line: 15, column: 4, scope: !19)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 18, type: !29, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!31, !10, !10, !36, !36}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !32, size: 64)
!32 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !33)
!33 = !{!34}
!34 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !32, file: !1, line: 4, baseType: !35, size: 64)
!35 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!36 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !37, size: 64)
!37 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !38)
!38 = !{!39}
!39 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !37, file: !1, line: 8, baseType: !31, size: 64)
!40 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 18, type: !10)
!41 = !DILocation(line: 18, column: 23, scope: !28)
!42 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 18, type: !10)
!43 = !DILocation(line: 18, column: 30, scope: !28)
!44 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !28, file: !1, line: 18, type: !36)
!45 = !DILocation(line: 18, column: 48, scope: !28)
!46 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !28, file: !1, line: 18, type: !36)
!47 = !DILocation(line: 18, column: 71, scope: !28)
!48 = !DILocation(line: 19, column: 11, scope: !28)
!49 = !DILocation(line: 19, column: 19, scope: !28)
!50 = !DILocation(line: 19, column: 4, scope: !28)
!51 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 22, type: !29, scopeLine: 22, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!52 = !DILocalVariable(name: "a", arg: 1, scope: !51, file: !1, line: 22, type: !10)
!53 = !DILocation(line: 22, column: 26, scope: !51)
!54 = !DILocalVariable(name: "b", arg: 2, scope: !51, file: !1, line: 22, type: !10)
!55 = !DILocation(line: 22, column: 33, scope: !51)
!56 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !51, file: !1, line: 22, type: !36)
!57 = !DILocation(line: 22, column: 51, scope: !51)
!58 = !DILocalVariable(name: "b_fptr", arg: 4, scope: !51, file: !1, line: 22, type: !36)
!59 = !DILocation(line: 22, column: 74, scope: !51)
!60 = !DILocation(line: 23, column: 11, scope: !51)
!61 = !DILocation(line: 23, column: 19, scope: !51)
!62 = !DILocation(line: 23, column: 4, scope: !51)
!63 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 26, type: !64, scopeLine: 26, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!64 = !DISubroutineType(types: !65)
!65 = !{!10, !66, !10, !10}
!66 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!67 = !DILocalVariable(name: "x", arg: 1, scope: !63, file: !1, line: 26, type: !66)
!68 = !DILocation(line: 26, column: 14, scope: !63)
!69 = !DILocalVariable(name: "op1", arg: 2, scope: !63, file: !1, line: 26, type: !10)
!70 = !DILocation(line: 26, column: 21, scope: !63)
!71 = !DILocalVariable(name: "op2", arg: 3, scope: !63, file: !1, line: 26, type: !10)
!72 = !DILocation(line: 26, column: 30, scope: !63)
!73 = !DILocalVariable(name: "a_fptr", scope: !63, file: !1, line: 27, type: !32)
!74 = !DILocation(line: 27, column: 17, scope: !63)
!75 = !DILocation(line: 28, column: 12, scope: !63)
!76 = !DILocation(line: 28, column: 18, scope: !63)
!77 = !DILocalVariable(name: "s_fptr", scope: !63, file: !1, line: 29, type: !32)
!78 = !DILocation(line: 29, column: 17, scope: !63)
!79 = !DILocation(line: 30, column: 12, scope: !63)
!80 = !DILocation(line: 30, column: 18, scope: !63)
!81 = !DILocalVariable(name: "m_fptr", scope: !63, file: !1, line: 31, type: !37)
!82 = !DILocation(line: 31, column: 18, scope: !63)
!83 = !DILocation(line: 32, column: 12, scope: !63)
!84 = !DILocation(line: 32, column: 16, scope: !63)
!85 = !DILocalVariable(name: "n_fptr", scope: !63, file: !1, line: 33, type: !37)
!86 = !DILocation(line: 33, column: 18, scope: !63)
!87 = !DILocation(line: 34, column: 12, scope: !63)
!88 = !DILocation(line: 34, column: 16, scope: !63)
!89 = !DILocalVariable(name: "goo_ptr", scope: !63, file: !1, line: 36, type: !90)
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!91 = !DILocation(line: 36, column: 20, scope: !63)
!92 = !DILocalVariable(name: "t_fptr", scope: !63, file: !1, line: 37, type: !31)
!93 = !DILocation(line: 37, column: 18, scope: !63)
!94 = !DILocation(line: 39, column: 9, scope: !95)
!95 = distinct !DILexicalBlock(scope: !63, file: !1, line: 39, column: 9)
!96 = !DILocation(line: 39, column: 11, scope: !95)
!97 = !DILocation(line: 39, column: 9, scope: !63)
!98 = !DILocation(line: 40, column: 16, scope: !99)
!99 = distinct !DILexicalBlock(scope: !95, file: !1, line: 39, column: 19)
!100 = !DILocation(line: 41, column: 5, scope: !99)
!101 = !DILocation(line: 42, column: 14, scope: !102)
!102 = distinct !DILexicalBlock(scope: !95, file: !1, line: 42, column: 14)
!103 = !DILocation(line: 42, column: 16, scope: !102)
!104 = !DILocation(line: 42, column: 14, scope: !95)
!105 = !DILocation(line: 43, column: 16, scope: !106)
!106 = distinct !DILexicalBlock(scope: !102, file: !1, line: 42, column: 24)
!107 = !DILocation(line: 45, column: 5, scope: !106)
!108 = !DILocation(line: 47, column: 14, scope: !63)
!109 = !DILocation(line: 47, column: 22, scope: !63)
!110 = !DILocation(line: 47, column: 27, scope: !63)
!111 = !DILocation(line: 47, column: 12, scope: !63)
!112 = !DILocation(line: 48, column: 5, scope: !63)
!113 = !DILocation(line: 48, column: 13, scope: !63)
!114 = !DILocation(line: 48, column: 20, scope: !63)
!115 = !DILocation(line: 48, column: 25, scope: !63)
!116 = !DILocation(line: 50, column: 5, scope: !63)
