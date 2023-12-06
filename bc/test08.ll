; ModuleID = 'test08.bc'
source_filename = "test08.c"
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
define dso_local void @foo(i32 %x) #0 !dbg !28 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !31, metadata !DIExpression()), !dbg !32
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !33, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !39, metadata !DIExpression()), !dbg !44
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !45
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !46
  %0 = load i32, i32* %x.addr, align 4, !dbg !47
  %cmp = icmp sgt i32 %0, 1, !dbg !49
  br i1 %cmp, label %if.then, label %if.else, !dbg !50

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !51
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !53
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !54
  %1 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !54
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %1, i32 0, i32 0, !dbg !55
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !55
  %3 = load i32, i32* %x.addr, align 4, !dbg !56
  %call = call i32 %2(i32 1, i32 %3), !dbg !57
  store i32 %call, i32* %x.addr, align 4, !dbg !58
  %p_fptr3 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !59
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr3, align 8, !dbg !60
  br label %if.end, !dbg !61

if.else:                                          ; preds = %entry
  %sptr4 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !62
  %4 = load %struct.fptr*, %struct.fptr** %sptr4, align 8, !dbg !62
  %p_fptr5 = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !64
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr5, align 8, !dbg !65
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !66
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr6, align 8, !dbg !66
  %6 = load i32, i32* %x.addr, align 4, !dbg !67
  %call7 = call i32 %5(i32 1, i32 %6), !dbg !68
  store i32 %call7, i32* %x.addr, align 4, !dbg !69
  ret void, !dbg !70
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test08.c", directory: "/root/assign3/test")
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
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 17, type: !29, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{null, !10}
!31 = !DILocalVariable(name: "x", arg: 1, scope: !28, file: !1, line: 17, type: !10)
!32 = !DILocation(line: 17, column: 14, scope: !28)
!33 = !DILocalVariable(name: "a_fptr", scope: !28, file: !1, line: 19, type: !34)
!34 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !35)
!35 = !{!36}
!36 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !34, file: !1, line: 4, baseType: !37, size: 64)
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!38 = !DILocation(line: 19, column: 14, scope: !28)
!39 = !DILocalVariable(name: "s_fptr", scope: !28, file: !1, line: 20, type: !40)
!40 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !41)
!41 = !{!42}
!42 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !40, file: !1, line: 8, baseType: !43, size: 64)
!43 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !34, size: 64)
!44 = !DILocation(line: 20, column: 15, scope: !28)
!45 = !DILocation(line: 21, column: 9, scope: !28)
!46 = !DILocation(line: 21, column: 13, scope: !28)
!47 = !DILocation(line: 22, column: 5, scope: !48)
!48 = distinct !DILexicalBlock(scope: !28, file: !1, line: 22, column: 5)
!49 = !DILocation(line: 22, column: 6, scope: !48)
!50 = !DILocation(line: 22, column: 5, scope: !28)
!51 = !DILocation(line: 24, column: 11, scope: !52)
!52 = distinct !DILexicalBlock(scope: !48, file: !1, line: 23, column: 2)
!53 = !DILocation(line: 24, column: 17, scope: !52)
!54 = !DILocation(line: 25, column: 13, scope: !52)
!55 = !DILocation(line: 25, column: 19, scope: !52)
!56 = !DILocation(line: 25, column: 28, scope: !52)
!57 = !DILocation(line: 25, column: 6, scope: !52)
!58 = !DILocation(line: 25, column: 5, scope: !52)
!59 = !DILocation(line: 26, column: 11, scope: !52)
!60 = !DILocation(line: 26, column: 17, scope: !52)
!61 = !DILocation(line: 27, column: 2, scope: !52)
!62 = !DILocation(line: 29, column: 10, scope: !63)
!63 = distinct !DILexicalBlock(scope: !48, file: !1, line: 28, column: 2)
!64 = !DILocation(line: 29, column: 16, scope: !63)
!65 = !DILocation(line: 29, column: 22, scope: !63)
!66 = !DILocation(line: 31, column: 11, scope: !28)
!67 = !DILocation(line: 31, column: 20, scope: !28)
!68 = !DILocation(line: 31, column: 4, scope: !28)
!69 = !DILocation(line: 31, column: 3, scope: !28)
!70 = !DILocation(line: 32, column: 1, scope: !28)
