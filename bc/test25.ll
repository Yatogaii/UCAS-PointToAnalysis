; ModuleID = 'test25.bc'
source_filename = "test25.c"
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
define dso_local i32 @foo(i32 %a, i32 %b, i32 (i32, i32)* %af_ptr.coerce) #0 !dbg !28 {
entry:
  %af_ptr = alloca %struct.fptr, align 8
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0
  store i32 (i32, i32)* %af_ptr.coerce, i32 (i32, i32)** %coerce.dive, align 8
  store i32 %a, i32* %a.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %a.addr, metadata !35, metadata !DIExpression()), !dbg !36
  store i32 %b, i32* %b.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %b.addr, metadata !37, metadata !DIExpression()), !dbg !38
  call void @llvm.dbg.declare(metadata %struct.fptr* %af_ptr, metadata !39, metadata !DIExpression()), !dbg !40
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %af_ptr, i32 0, i32 0, !dbg !41
  %0 = load i32 (i32, i32)*, i32 (i32, i32)** %p_fptr, align 8, !dbg !41
  %1 = load i32, i32* %a.addr, align 4, !dbg !42
  %2 = load i32, i32* %b.addr, align 4, !dbg !43
  %call = call i32 %0(i32 %1, i32 %2), !dbg !44
  ret i32 %call, !dbg !45
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @make_alias(%struct.fsptr* %a, %struct.fptr* %b) #0 !dbg !46 {
entry:
  %a.addr = alloca %struct.fsptr*, align 8
  %b.addr = alloca %struct.fptr*, align 8
  store %struct.fsptr* %a, %struct.fsptr** %a.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fsptr** %a.addr, metadata !54, metadata !DIExpression()), !dbg !55
  store %struct.fptr* %b, %struct.fptr** %b.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.fptr** %b.addr, metadata !56, metadata !DIExpression()), !dbg !57
  %0 = load %struct.fptr*, %struct.fptr** %b.addr, align 8, !dbg !58
  %1 = load %struct.fsptr*, %struct.fsptr** %a.addr, align 8, !dbg !59
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %1, i32 0, i32 0, !dbg !60
  store %struct.fptr* %0, %struct.fptr** %sptr, align 8, !dbg !61
  ret void, !dbg !62
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @clever() #0 !dbg !63 {
entry:
  %af_ptr = alloca i32 (i32, i32, i32 (i32, i32)*)*, align 8
  %tf_ptr = alloca %struct.fptr, align 8
  %mf_ptr = alloca %struct.fptr, align 8
  %sf_ptr = alloca %struct.fsptr, align 8
  %result = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, metadata !66, metadata !DIExpression()), !dbg !68
  store i32 (i32, i32, i32 (i32, i32)*)* null, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !68
  call void @llvm.dbg.declare(metadata %struct.fptr* %tf_ptr, metadata !69, metadata !DIExpression()), !dbg !70
  %0 = bitcast %struct.fptr* %tf_ptr to i8*, !dbg !70
  call void @llvm.memset.p0i8.i64(i8* align 8 %0, i8 0, i64 8, i1 false), !dbg !70
  call void @llvm.dbg.declare(metadata %struct.fptr* %mf_ptr, metadata !71, metadata !DIExpression()), !dbg !72
  %1 = bitcast %struct.fptr* %mf_ptr to i8*, !dbg !72
  call void @llvm.memset.p0i8.i64(i8* align 8 %1, i8 0, i64 8, i1 false), !dbg !72
  call void @llvm.dbg.declare(metadata %struct.fsptr* %sf_ptr, metadata !73, metadata !DIExpression()), !dbg !74
  %2 = bitcast %struct.fsptr* %sf_ptr to i8*, !dbg !74
  call void @llvm.memset.p0i8.i64(i8* align 8 %2, i8 0, i64 8, i1 false), !dbg !74
  %sptr = getelementptr inbounds %struct.fsptr, %struct.fsptr* %sf_ptr, i32 0, i32 0, !dbg !75
  store %struct.fptr* %mf_ptr, %struct.fptr** %sptr, align 8, !dbg !76
  %p_fptr = getelementptr inbounds %struct.fptr, %struct.fptr* %tf_ptr, i32 0, i32 0, !dbg !77
  store i32 (i32, i32)* @plus, i32 (i32, i32)** %p_fptr, align 8, !dbg !78
  %p_fptr1 = getelementptr inbounds %struct.fptr, %struct.fptr* %mf_ptr, i32 0, i32 0, !dbg !79
  store i32 (i32, i32)* @minus, i32 (i32, i32)** %p_fptr1, align 8, !dbg !80
  store i32 (i32, i32, i32 (i32, i32)*)* @foo, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !81
  call void @make_alias(%struct.fsptr* %sf_ptr, %struct.fptr* %tf_ptr), !dbg !82
  call void @llvm.dbg.declare(metadata i32* %result, metadata !83, metadata !DIExpression()), !dbg !85
  %3 = load i32 (i32, i32, i32 (i32, i32)*)*, i32 (i32, i32, i32 (i32, i32)*)** %af_ptr, align 8, !dbg !86
  %sptr2 = getelementptr inbounds %struct.fsptr, %struct.fsptr* %sf_ptr, i32 0, i32 0, !dbg !87
  %4 = load %struct.fptr*, %struct.fptr** %sptr2, align 8, !dbg !87
  %coerce.dive = getelementptr inbounds %struct.fptr, %struct.fptr* %4, i32 0, i32 0, !dbg !86
  %5 = load i32 (i32, i32)*, i32 (i32, i32)** %coerce.dive, align 8, !dbg !86
  %call = call i32 %3(i32 1, i32 2, i32 (i32, i32)* %5), !dbg !86
  store i32 %call, i32* %result, align 4, !dbg !85
  ret i32 0, !dbg !88
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
!1 = !DIFile(filename: "test25.c", directory: "/root/assign3/test")
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
!19 = distinct !DISubprogram(name: "minus", scope: !1, file: !1, line: 14, type: !8, scopeLine: 15, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!20 = !DILocalVariable(name: "a", arg: 1, scope: !19, file: !1, line: 14, type: !10)
!21 = !DILocation(line: 14, column: 15, scope: !19)
!22 = !DILocalVariable(name: "b", arg: 2, scope: !19, file: !1, line: 14, type: !10)
!23 = !DILocation(line: 14, column: 21, scope: !19)
!24 = !DILocation(line: 16, column: 12, scope: !19)
!25 = !DILocation(line: 16, column: 14, scope: !19)
!26 = !DILocation(line: 16, column: 13, scope: !19)
!27 = !DILocation(line: 16, column: 5, scope: !19)
!28 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 19, type: !29, scopeLine: 20, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!29 = !DISubroutineType(types: !30)
!30 = !{!10, !10, !10, !31}
!31 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fptr", file: !1, line: 2, size: 64, elements: !32)
!32 = !{!33}
!33 = !DIDerivedType(tag: DW_TAG_member, name: "p_fptr", scope: !31, file: !1, line: 4, baseType: !34, size: 64)
!34 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8, size: 64)
!35 = !DILocalVariable(name: "a", arg: 1, scope: !28, file: !1, line: 19, type: !10)
!36 = !DILocation(line: 19, column: 13, scope: !28)
!37 = !DILocalVariable(name: "b", arg: 2, scope: !28, file: !1, line: 19, type: !10)
!38 = !DILocation(line: 19, column: 19, scope: !28)
!39 = !DILocalVariable(name: "af_ptr", arg: 3, scope: !28, file: !1, line: 19, type: !31)
!40 = !DILocation(line: 19, column: 33, scope: !28)
!41 = !DILocation(line: 21, column: 16, scope: !28)
!42 = !DILocation(line: 21, column: 23, scope: !28)
!43 = !DILocation(line: 21, column: 25, scope: !28)
!44 = !DILocation(line: 21, column: 9, scope: !28)
!45 = !DILocation(line: 21, column: 2, scope: !28)
!46 = distinct !DISubprogram(name: "make_alias", scope: !1, file: !1, line: 23, type: !47, scopeLine: 24, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!47 = !DISubroutineType(types: !48)
!48 = !{null, !49, !53}
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50, size: 64)
!50 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fsptr", file: !1, line: 6, size: 64, elements: !51)
!51 = !{!52}
!52 = !DIDerivedType(tag: DW_TAG_member, name: "sptr", scope: !50, file: !1, line: 8, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!54 = !DILocalVariable(name: "a", arg: 1, scope: !46, file: !1, line: 23, type: !49)
!55 = !DILocation(line: 23, column: 32, scope: !46)
!56 = !DILocalVariable(name: "b", arg: 2, scope: !46, file: !1, line: 23, type: !53)
!57 = !DILocation(line: 23, column: 47, scope: !46)
!58 = !DILocation(line: 25, column: 13, scope: !46)
!59 = !DILocation(line: 25, column: 5, scope: !46)
!60 = !DILocation(line: 25, column: 8, scope: !46)
!61 = !DILocation(line: 25, column: 12, scope: !46)
!62 = !DILocation(line: 26, column: 1, scope: !46)
!63 = distinct !DISubprogram(name: "clever", scope: !1, file: !1, line: 27, type: !64, scopeLine: 27, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!64 = !DISubroutineType(types: !65)
!65 = !{!10}
!66 = !DILocalVariable(name: "af_ptr", scope: !63, file: !1, line: 29, type: !67)
!67 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!68 = !DILocation(line: 29, column: 11, scope: !63)
!69 = !DILocalVariable(name: "tf_ptr", scope: !63, file: !1, line: 30, type: !31)
!70 = !DILocation(line: 30, column: 17, scope: !63)
!71 = !DILocalVariable(name: "mf_ptr", scope: !63, file: !1, line: 31, type: !31)
!72 = !DILocation(line: 31, column: 17, scope: !63)
!73 = !DILocalVariable(name: "sf_ptr", scope: !63, file: !1, line: 32, type: !50)
!74 = !DILocation(line: 32, column: 18, scope: !63)
!75 = !DILocation(line: 33, column: 12, scope: !63)
!76 = !DILocation(line: 33, column: 16, scope: !63)
!77 = !DILocation(line: 34, column: 12, scope: !63)
!78 = !DILocation(line: 34, column: 18, scope: !63)
!79 = !DILocation(line: 35, column: 12, scope: !63)
!80 = !DILocation(line: 35, column: 18, scope: !63)
!81 = !DILocation(line: 36, column: 11, scope: !63)
!82 = !DILocation(line: 37, column: 5, scope: !63)
!83 = !DILocalVariable(name: "result", scope: !63, file: !1, line: 38, type: !84)
!84 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!85 = !DILocation(line: 38, column: 14, scope: !63)
!86 = !DILocation(line: 38, column: 23, scope: !63)
!87 = !DILocation(line: 38, column: 44, scope: !63)
!88 = !DILocation(line: 39, column: 5, scope: !63)
