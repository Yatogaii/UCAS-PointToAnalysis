; ModuleID = 'test06.bc'
source_filename = "test06.c"
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
define dso_local void @foo(i32 %x) #0 !dbg !31 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca i32 (i32, i32)**, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !34, metadata !DIExpression()), !dbg !35
  call void @llvm.dbg.declare(metadata i32 (i32, i32)*** %a_fptr, metadata !36, metadata !DIExpression()), !dbg !37
  %call = call noalias i8* @malloc(i64 8) #3, !dbg !38
  %0 = bitcast i8* %call to i32 (i32, i32)**, !dbg !39
  store i32 (i32, i32)** %0, i32 (i32, i32)*** %a_fptr, align 8, !dbg !37
  %1 = load i32, i32* %x.addr, align 4, !dbg !40
  %cmp = icmp sgt i32 %1, 1, !dbg !42
  br i1 %cmp, label %if.then, label %if.else, !dbg !43

if.then:                                          ; preds = %entry
  %2 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !44
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %2, align 8, !dbg !46
  %3 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !47
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %3, align 8, !dbg !48
  %5 = load i32, i32* %x.addr, align 4, !dbg !49
  %call1 = call i32 %4(i32 1, i32 %5), !dbg !50
  store i32 %call1, i32* %x.addr, align 4, !dbg !51
  %6 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !52
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %6, align 8, !dbg !53
  br label %if.end, !dbg !54

if.else:                                          ; preds = %entry
  %7 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !55
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %7, align 8, !dbg !57
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %8 = load i32 (i32, i32)**, i32 (i32, i32)*** %a_fptr, align 8, !dbg !58
  %9 = load i32 (i32, i32)*, i32 (i32, i32)** %8, align 8, !dbg !59
  %10 = load i32, i32* %x.addr, align 4, !dbg !60
  %call2 = call i32 %9(i32 1, i32 %10), !dbg !61
  store i32 %call2, i32* %x.addr, align 4, !dbg !62
  ret void, !dbg !63
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
!1 = !DIFile(filename: "test06.c", directory: "/root/assign3/test")
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
!31 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 9, type: !32, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!32 = !DISubroutineType(types: !33)
!33 = !{null, !8}
!34 = !DILocalVariable(name: "x", arg: 1, scope: !31, file: !1, line: 9, type: !8)
!35 = !DILocation(line: 9, column: 14, scope: !31)
!36 = !DILocalVariable(name: "a_fptr", scope: !31, file: !1, line: 11, type: !4)
!37 = !DILocation(line: 11, column: 9, scope: !31)
!38 = !DILocation(line: 11, column: 45, scope: !31)
!39 = !DILocation(line: 11, column: 26, scope: !31)
!40 = !DILocation(line: 12, column: 5, scope: !41)
!41 = distinct !DILexicalBlock(scope: !31, file: !1, line: 12, column: 5)
!42 = !DILocation(line: 12, column: 6, scope: !41)
!43 = !DILocation(line: 12, column: 5, scope: !31)
!44 = !DILocation(line: 14, column: 4, scope: !45)
!45 = distinct !DILexicalBlock(scope: !41, file: !1, line: 13, column: 2)
!46 = !DILocation(line: 14, column: 10, scope: !45)
!47 = !DILocation(line: 15, column: 8, scope: !45)
!48 = !DILocation(line: 15, column: 7, scope: !45)
!49 = !DILocation(line: 15, column: 18, scope: !45)
!50 = !DILocation(line: 15, column: 6, scope: !45)
!51 = !DILocation(line: 15, column: 5, scope: !45)
!52 = !DILocation(line: 16, column: 5, scope: !45)
!53 = !DILocation(line: 16, column: 11, scope: !45)
!54 = !DILocation(line: 17, column: 2, scope: !45)
!55 = !DILocation(line: 19, column: 4, scope: !56)
!56 = distinct !DILexicalBlock(scope: !41, file: !1, line: 18, column: 2)
!57 = !DILocation(line: 19, column: 10, scope: !56)
!58 = !DILocation(line: 21, column: 6, scope: !31)
!59 = !DILocation(line: 21, column: 5, scope: !31)
!60 = !DILocation(line: 21, column: 16, scope: !31)
!61 = !DILocation(line: 21, column: 4, scope: !31)
!62 = !DILocation(line: 21, column: 3, scope: !31)
!63 = !DILocation(line: 22, column: 1, scope: !31)
