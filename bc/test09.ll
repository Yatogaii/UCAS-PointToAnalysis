; ModuleID = 'test09.bc'
source_filename = "test09.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.fptr = type { i32 (i32, i32)* }
%struct.fsptr = type { %struct.fptr* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @plus(i32 %a, i32 %b) #0 !dbg !20 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !21, metadata !DIExpression()), !dbg !22
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !23, metadata !DIExpression()), !dbg !24
  %0 = load i32, i32* %a.addr, align 4, !dbg !25
  %1 = load i32, i32* %b.addr, align 4, !dbg !26
  %add = add nsw i32 %0, %1, !dbg !27
  ret i32 %add, !dbg !28
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @minus(i32 %a, i32 %b) #0 !dbg !29 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !30, metadata !DIExpression()), !dbg !31
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !32, metadata !DIExpression()), !dbg !33
  %0 = load i32, i32* %a.addr, align 4, !dbg !34
  %1 = load i32, i32* %b.addr, align 4, !dbg !35
  %sub = sub nsw i32 %0, %1, !dbg !36
  ret i32 %sub, !dbg !37
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @foo(i32 %x) #0 !dbg !38 {
entry:
  %x.addr = alloca i32, align 4
  %a_fptr = alloca %struct.fptr, align 8
  %s_fptr = alloca %struct.fsptr, align 8
  %w_fptr = alloca %struct.fsptr*, align 8
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !41, metadata !DIExpression()), !dbg !42
  call void @llvm.dbg.declare(metadata %struct.fptr* %a_fptr, metadata !43, metadata !DIExpression()), !dbg !44
  call void @llvm.dbg.declare(metadata %struct.fsptr* %s_fptr, metadata !45, metadata !DIExpression()), !dbg !46
  call void @llvm.dbg.declare(metadata %struct.fsptr** %w_fptr, metadata !47, metadata !DIExpression()), !dbg !48
  %call = call noalias i8* @malloc(i64 8) #4, !dbg !49
  %0 = bitcast i8* %call to %struct.fsptr*, !dbg !50
  store %struct.fsptr* %0, %struct.fsptr** %w_fptr, align 8, !dbg !48
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !51
  store %struct.fptr* %a_fptr, %struct.fptr** %sptr, align 8, !dbg !52
  %1 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !53
  %2 = bitcast %struct.fsptr* %1 to i8*, !dbg !54
  %3 = bitcast %struct.fsptr* %s_fptr to i8*, !dbg !54
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* align 8 %2, i8* align 8 %3, i64 8, i1 false), !dbg !54
  %4 = load i32, i32* %x.addr, align 4, !dbg !55
  %cmp = icmp sgt i32 %4, 1, !dbg !57
  br i1 %cmp, label %if.then, label %if.else, !dbg !58

if.then:                                          ; preds = %entry
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !59
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !61
  %sptr1 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %s_fptr, i32 0, i32 0, !dbg !62
  %5 = load %struct.fptr*, %struct.fptr** %sptr1, align 8, !dbg !62
  %p_fptr2 = getelementptr inbounds %struct.fptr, %struct.fptr* %5, i32 0, i32 0, !dbg !63
  %6 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr2, align 8, !dbg !63
  %7 = load i32, i32* %x.addr, align 4, !dbg !64
  %call3 = call i32 %6(i32 1, i32 %7), !dbg !65
  store i32 %call3, i32* %x.addr, align 4, !dbg !66
  %p_fptr4 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !67
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr4, align 8, !dbg !68
  br label %if.end, !dbg !69

if.else:                                          ; preds = %entry
  %8 = load %struct.fsptr*, %struct.fsptr** %w_fptr, align 8, !dbg !70
  %sptr5 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %8, i32 0, i32 0, !dbg !72
  %9 = load %struct.fptr*, %struct.fptr** %sptr5, align 8, !dbg !72
  %p_fptr6 = getelementptr inbounds %struct.fptr, %struct.fptr* %9, i32 0, i32 0, !dbg !73
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr6, align 8, !dbg !74
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %p_fptr7 = getelementptr inbounds %struct.fptr, %struct.fptr* %a_fptr, i32 0, i32 0, !dbg !75
  %10 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr7, align 8, !dbg !75
  %11 = load i32, i32* %x.addr, align 4, !dbg !76
  %call8 = call i32 %10(i32 1, i32 %11), !dbg !77
  store i32 %call8, i32* %x.addr, align 4, !dbg !78
  ret void, !dbg !79
}

; Function Attrs: nounwind
declare dso_local noalias i8* @malloc(i64) #2

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind willreturn }
attributes #4 = { nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!16, !17, !18}
!llvm.ident = !{!19}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 10.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "test09.c", directory: "/root/assign3/test")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !6)
!6 = !{!7}
!7 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !5, file: !1, line: 8, baseType: !8, size: 64)
!8 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !9, size: 64)
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !10)
!10 = !{!11}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !9, file: !1, line: 4, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !15}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !{i32 7, !"Dwarf Version", i32 4}
!17 = !{i32 2, !"Debug Info Version", i32 3}
!18 = !{i32 1, !"wchar_size", i32 4}
!19 = !{!"clang version 10.0.0 "}
!20 = distinct !DISubprogram(name: "plus", scope: !1, file: !1, line: 10, type: !13, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!21 = !DILocalVariable(name: "a", arg: 1, scope: !20, file: !1, line: 10, type: !15)
!22 = !DILocation(line: 10, column: 14, scope: !20)
!23 = !DILocalVariable(name: "b", arg: 2, scope: !20, file: !1, line: 10, type: !15)
!24 = !DILocation(line: 10, column: 21, scope: !20)
!25 = !DILocation(line: 11, column: 11, scope: !20)
!26 = !DILocation(line: 11, column: 13, scope: !20)
!27 = !DILocation(line: 11, column: 12, scope: !20)
!28 = !DILocation(line: 11, column: 4, scope: !20)
!29 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !13, scopeLine: 14, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!30 = !DILocalVariable(name: "a", arg: 1, scope: !29, file: !1, line: 14, type: !15)
!31 = !DILocation(line: 14, column: 15, scope: !29)
!32 = !DILocalVariable(name: "b", arg: 2, scope: !29, file: !1, line: 14, type: !15)
!33 = !DILocation(line: 14, column: 22, scope: !29)
!34 = !DILocation(line: 15, column: 11, scope: !29)
!35 = !DILocation(line: 15, column: 13, scope: !29)
!36 = !DILocation(line: 15, column: 12, scope: !29)
!37 = !DILocation(line: 15, column: 4, scope: !29)
!38 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 17, type: !39, scopeLine: 18, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!39 = !DISubroutineType(types: !40)
!40 = !{null, !15}
!41 = !DILocalVariable(name: "x", arg: 1, scope: !38, file: !1, line: 17, type: !15)
!42 = !DILocation(line: 17, column: 14, scope: !38)
!43 = !DILocalVariable(name: "a_fptr", scope: !38, file: !1, line: 19, type: !9)
!44 = !DILocation(line: 19, column: 14, scope: !38)
!45 = !DILocalVariable(name: "s_fptr", scope: !38, file: !1, line: 20, type: !5)
!46 = !DILocation(line: 20, column: 15, scope: !38)
!47 = !DILocalVariable(name: "w_fptr", scope: !38, file: !1, line: 21, type: !4)
!48 = !DILocation(line: 21, column: 16, scope: !38)
!49 = !DILocation(line: 21, column: 38, scope: !38)
!50 = !DILocation(line: 21, column: 23, scope: !38)
!51 = !DILocation(line: 22, column: 9, scope: !38)
!52 = !DILocation(line: 22, column: 13, scope: !38)
!53 = !DILocation(line: 23, column: 3, scope: !38)
!54 = !DILocation(line: 23, column: 10, scope: !38)
!55 = !DILocation(line: 24, column: 5, scope: !56)
!56 = distinct !DILexicalBlock(scope: !38, file: !1, line: 24, column: 5)
!57 = !DILocation(line: 24, column: 6, scope: !56)
!58 = !DILocation(line: 24, column: 5, scope: !38)
!59 = !DILocation(line: 26, column: 11, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !1, line: 25, column: 2)
!61 = !DILocation(line: 26, column: 17, scope: !60)
!62 = !DILocation(line: 27, column: 13, scope: !60)
!63 = !DILocation(line: 27, column: 19, scope: !60)
!64 = !DILocation(line: 27, column: 28, scope: !60)
!65 = !DILocation(line: 27, column: 6, scope: !60)
!66 = !DILocation(line: 27, column: 5, scope: !60)
!67 = !DILocation(line: 28, column: 11, scope: !60)
!68 = !DILocation(line: 28, column: 17, scope: !60)
!69 = !DILocation(line: 29, column: 2, scope: !60)
!70 = !DILocation(line: 31, column: 3, scope: !71)
!71 = distinct !DILexicalBlock(scope: !56, file: !1, line: 30, column: 2)
!72 = !DILocation(line: 31, column: 11, scope: !71)
!73 = !DILocation(line: 31, column: 17, scope: !71)
!74 = !DILocation(line: 31, column: 23, scope: !71)
!75 = !DILocation(line: 33, column: 11, scope: !38)
!76 = !DILocation(line: 33, column: 20, scope: !38)
!77 = !DILocation(line: 33, column: 4, scope: !38)
!78 = !DILocation(line: 33, column: 3, scope: !38)
!79 = !DILocation(line: 34, column: 1, scope: !38)
