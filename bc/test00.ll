; ModuleID = 'test00.bc'
source_filename = "test00.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

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
define dso_local i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %a_fptr) #0 !dbg !28 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %a_fptr.addr = alloca i32 (i32, i32)*, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !32, metadata !DIExpression()), !dbg !33
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !34, metadata !DIExpression()), !dbg !35
  store i32 (i32, i32)* %a_fptr, i32 (i32, i32)** %a_fptr.addr, align 8
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %a_fptr.addr, metadata !36, metadata !DIExpression()), !dbg !37
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %a_fptr.addr, align 8, !dbg !38
  %1 = load i32, i32* %a.addr, align 4, !dbg !39
  %2 = load i32, i32* %b.addr, align 4, !dbg !40
  %call = call i32 %0(i32 %1, i32 %2), !dbg !38
  ret i32 %call, !dbg !41
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @moo(i8 signext %x) #0 !dbg !42 {
entry:
  %x.addr = alloca i8, align 1
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %pf_ptr = alloca i32 (i32, i32)*, align 8
  store i8 %x, i8* %x.addr, align 1
  call void @llvm.dbg.declare(metadata i8* %x.addr, metadata !46, metadata !DIExpression()), !dbg !47
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !48, metadata !DIExpression()), !dbg !50
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !50
  call void @llvm.dbg.declare(metadata i32 (i32, i32)** %pf_ptr, metadata !51, metadata !DIExpression()), !dbg !52
  store i32 (i32, i32)* null, i32 (i32, i32)** %pf_ptr, align 8, !dbg !52
  %0 = load i8, i8* %x.addr, align 1, !dbg !53
  %conv = sext i8 %0 to i32, !dbg !53
  %cmp = icmp eq i32 %conv, 43, !dbg !55
  br i1 %cmp, label %if.then, label %if.end, !dbg !56

if.then:                                          ; preds = %entry
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %pf_ptr, align 8, !dbg !57
  %1 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !59
  %2 = load i32 (i32, i32)*, i32 (i32, i32)** %pf_ptr, align 8, !dbg !60
  %call = call i32 %1(i32 1, i32 2, i32 (i32, i32)* %2), !dbg !59
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %pf_ptr, align 8, !dbg !61
  br label %if.end, !dbg !62

if.end:                                           ; preds = %if.then, %entry
  %3 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !63
  %4 = load i32 (i32, i32)*, i32 (i32, i32)** %pf_ptr, align 8, !dbg !64
  %call2 = call i32 %3(i32 1, i32 2, i32 (i32, i32)* %4), !dbg !63
  ret i32 0, !dbg !65
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test00.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0 "}
!7 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 3, type: !8, scopeLine: 3, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", arg: 1, scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 14, scope: !7)
!13 = !DILocalVariable(name: "b", arg: 2, scope: !7, file: !1, line: 3, type: !10)
!14 = !DILocation(line: 3, column: 21, scope: !7)
!15 = !DILocation(line: 4, column: 11, scope: !7)
!16 = !DILocation(line: 4, column: 13, scope: !7)
!17 = !DILocation(line: 4, column: 12, scope: !7)
!18 = !DILocation(line: 4, column: 4, scope: !7)
!19 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 7, type: !10)
!21 = !DILocation(line: 7, column: 15, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 7, type: !10)
!23 = !DILocation(line: 7, column: 21, scope: !19)
!24 = !DILocation(line: 9, column: 12, scope: !19)
!25 = !DILocation(line: 9, column: 14, scope: !19)
!26 = !DILocation(line: 9, column: 13, scope: !19)
!27 = !DILocation(line: 9, column: 5, scope: !19)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 12, type: !29, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!10, !10, !10, !31}
!31 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!32 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 12, type: !10)
!33 = !DILocation(line: 12, column: 13, scope: !28)
!34 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 12, type: !10)
!35 = !DILocation(line: 12, column: 19, scope: !28)
!36 = !DILocalVariable(name: "a_fptr", arg: 3, scope: !28, file: !1, line: 12, type: !31)
!37 = !DILocation(line: 12, column: 27, scope: !28)
!38 = !DILocation(line: 14, column: 12, scope: !28)
!39 = !DILocation(line: 14, column: 19, scope: !28)
!40 = !DILocation(line: 14, column: 21, scope: !28)
!41 = !DILocation(line: 14, column: 5, scope: !28)
!42 = distinct !DISubprogram(name: "moo", scope: !1, file: !1, line: 18, type: !43, scopeLine: 19, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!43 = !DISubroutineType(types: !44)
!44 = !{!10, !45}
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !DILocalVariable(name: "x", arg: 1, scope: !42, file: !1, line: 18, type: !45)
!47 = !DILocation(line: 18, column: 14, scope: !42)
!48 = !DILocalVariable(name: "af_ptr", scope: !42, file: !1, line: 20, type: !49)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!50 = !DILocation(line: 20, column: 11, scope: !42)
!51 = !DILocalVariable(name: "pf_ptr", scope: !42, file: !1, line: 21, type: !31)
!52 = !DILocation(line: 21, column: 11, scope: !42)
!53 = !DILocation(line: 22, column: 8, scope: !54)
!54 = distinct !DILexicalBlock(scope: !42, file: !1, line: 22, column: 8)
!55 = !DILocation(line: 22, column: 10, scope: !54)
!56 = !DILocation(line: 22, column: 8, scope: !42)
!57 = !DILocation(line: 23, column: 15, scope: !58)
!58 = distinct !DILexicalBlock(scope: !54, file: !1, line: 22, column: 17)
!59 = !DILocation(line: 24, column: 9, scope: !58)
!60 = !DILocation(line: 24, column: 20, scope: !58)
!61 = !DILocation(line: 25, column: 15, scope: !58)
!62 = !DILocation(line: 26, column: 5, scope: !58)
!63 = !DILocation(line: 27, column: 5, scope: !42)
!64 = !DILocation(line: 27, column: 16, scope: !42)
!65 = !DILocation(line: 28, column: 5, scope: !42)
