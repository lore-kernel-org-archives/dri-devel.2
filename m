Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D1E3C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 00:28:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC3210E02A;
	Wed, 16 Sep 2026 00:28:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="HZVe+J98";
	dkim-atps=neutral
X-Greylist: delayed 904 seconds by postgrey-1.36 at gabe;
 Wed, 16 Sep 2026 00:28:47 UTC
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D73C610E02A
 for <dri-devel@lists.freedesktop.org>; Wed, 16 Sep 2026 00:28:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1789517620; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=oHChKgvC+BQoO1fAateMcEViN5Cq2eMYY3waxIQ+gTrGaU7jzlISWvYCH1Gl2BApIw5qA6dk84LriI+jM7Pi0lujnNubFlZEBfSsJ8njQVEj5iGulxaHxdPWRWfVotXBPd/vDDqdcCeIMxjQ+hSpqW6LzrwQBY5a69818vtbWV0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1789517620;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=An2wT/kto2OfyEK3/lnoA/hsyauingzGyd1Jv03v988=; 
 b=RrdSHmfQ8s17F1/qLqhTCJp+rlYnprKhrxoPiElRAZUYfuD53rrJ4ypbvO63GCISXgjbSmFmm+KSdTnbxvR49/QDAVNBfaoid36C3xL53uVOnpYHlf+cmoz/o/CVqFE+lKDIYxGMAKAokILn0DwhQguaQaZoXlQyUK4GRoM2MAk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1789517620; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
 bh=An2wT/kto2OfyEK3/lnoA/hsyauingzGyd1Jv03v988=;
 b=HZVe+J98zBxf5UpvDjXAF3hurrYUXww7oNr0td2DS8DrgF+tjZKCypqH19qSanXy
 /qaHHVgVMLHYxIfkjrb+C61pLTvnzyxeiNpMsKplX6EtZQb6kXO0kFo2Hmau0je3FlW
 N23k0ZPWvngMruNeeBOmb3DUoHoqf0cxX6xs7TM8=
Received: by mx.zohomail.com with SMTPS id 1789517619217260.63917719170524;
 Tue, 15 Sep 2026 17:13:39 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 15 Sep 2026 17:13:26 -0700
Subject: [PATCH i-g-t] tests/panthor: skip sparse VM_BIND tests before v1.9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqDMBAAvyJ77kJiTaF+RYrEZBP3EsOuSEH8e
 1OPAzNzgpIwKYzdCUIHK2+lgX10EFZfMiHHxtCb/mXe1uEyYPVlXzeZD5K/Pmv1ooQuLfFpQzD
 RRWh9FUr8vd8TMGbc4XNdPwGvnVVyAAAA
X-Change-ID: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
To: igt-dev@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com, adrian.larumbe@collabora.com, 
 kamil.konieczny@linux.intel.com, samitolvanen@google.com, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=24876;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=2i6bQtte9UfTcIBtzzcDqw5lVQtRHdLSzKW8PGojZCI=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkr7xuu3RLX5hfFcyA820z0xHOTDxe/Tv2RXGKbsa3Qd
 JnqhNsFHaUsDGJcDLJiiixn7Y16xKveG+nO/98MM4eVCWQIAxenAExkjT/D/8x3vMruaiemJV9c
 fddRannU0smvTXacvPCLJX9x4xuD958Y/lc9WyQVu1bvkqi8XXF3xj3z2XFu8+Y4vsqojOZQWBL
 vyQEA
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Sparse VM_BIND support was introduced with Panthor DRM driver version
1.9. If a driver isn't advertising support for v1.9, then tests that
call DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE should not be run.

So skip the sparse VM_BIND subtests when running against a driver older
than version 1.9.

Also add indentation to group the sparse tests together.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 tests/panthor/panthor_vm.c | 660 +++++++++++++++++++++++----------------------
 1 file changed, 342 insertions(+), 318 deletions(-)

diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
index 9011df25e..0140b9e40 100644
--- a/tests/panthor/panthor_vm.c
+++ b/tests/panthor/panthor_vm.c
@@ -7,6 +7,20 @@
 #include "igt_sizes.h"
 #include "panthor_drm.h"
 
+static bool panthor_driver_version_at_least(int fd, int major, int minor)
+{
+	drmVersionPtr version = drmGetVersion(fd);
+	bool supported;
+
+	igt_assert(version);
+	supported = version->version_major > major ||
+		    (version->version_major == major &&
+		     version->version_minor >= minor);
+	drmFreeVersion(version);
+
+	return supported;
+}
+
 int igt_main() {
 	int fd = -1;
 
@@ -288,324 +302,334 @@ int igt_main() {
 		igt_panthor_vm_destroy(fd, vm_id, 0);
 	}
 
-	igt_describe("Perform a simple sparse vm_bind operation");
-	igt_subtest("vm_bind_sparse") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_4K * 4;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, SZ_2M, map_size, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Perform a partial hugepage-unaligned unmap of a sparsely bound region");
-	igt_subtest("vm_bind_sparse_partial_unmap_start_size_unaligned") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_4K * 2,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do a partial hugeapge-aligned unmap from start of sparsely-bound region");
-	igt_subtest("vm_bind_sparse_partial_unmap_start_size_aligned") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_2M,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do a partial hugeapge-unaligned unmap from start of sparsely-bound region");
-	igt_subtest("vm_bind_sparse_partial_unmap_start_aligned_no_hugepage_multiple") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, 4 * SZ_64K,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do partial hugeapge-aligned unmap that left-intersects with sparse region");
-	igt_subtest("vm_bind_sparse_partial_unmap_below_start") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA - SZ_2M, SZ_2M * 3,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do partial hugepage-aligned unmap that is proper subset of sparse region");
-	igt_subtest("vm_bind_sparse_partial_unmap_above_start") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA + SZ_2M, SZ_2M,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
-	igt_subtest("vm_bind_sparse_remap") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M, SZ_2M * 2,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
-	igt_subtest("vm_bind_sparse_remap_start_unaligned") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
-				    SZ_4M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
-	igt_subtest("vm_bind_sparse_remap_start_size_unaligned") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
-				    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
-	igt_subtest("vm_bind_sparse_remap_start_size_aligned") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle,
-				    INITIAL_VA + map_size - SZ_2M, SZ_4M,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-aligned bind that splits original region in two");
-	igt_subtest("vm_bind_sparse_remap_aligned_split_original_va") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
-				    SZ_2M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal 2MiB aligned hugepage-size-unaligned bind over sparse region");
-	igt_subtest("vm_bind_sparse_remap_start_aligned_size_unaligned") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
-				    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-aligned bind over left end of sparse region");
-	igt_subtest("vm_bind_sparse_remap_aligned_intersect_left") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle,
-				    INITIAL_VA - SZ_2M, SZ_2M * 2,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-unaligned bind over left end of sparse region");
-	igt_subtest("vm_bind_sparse_remap_size_unaligned_intersect_left") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle,
-				    INITIAL_VA - SZ_2M, SZ_1M * 3,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-unaligned bind over right end of sparse region");
-	igt_subtest("vm_bind_sparse_remap_start_aligned_intersect_right") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle,
-				    INITIAL_VA + map_size - SZ_2M, SZ_2M + SZ_4K * 6,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Do normal hugepage-aligned bind that envelopes whole sparse region");
-	igt_subtest("vm_bind_sparse_remap_wrap_around_va") {
-		uint32_t vm_id;
-		struct panthor_bo bo;
-		uint64_t map_size = SZ_2M * 3;
-		const int INITIAL_VA = SZ_4M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-
-		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
-		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
-		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA - SZ_2M,
-				    SZ_8M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
-
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Perform sparse binding operation whose range causes an overflow");
-	igt_subtest("vm_bind_sparse_overflow") {
-		uint32_t vm_id;
-		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
-		const int INITIAL_VA = SZ_512M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, EINVAL);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
-	}
-
-	igt_describe("Perform sparse unbind operation whose range causes an overflow");
-	igt_subtest("vm_unbind_sparse_overflow") {
-		uint32_t vm_id;
-		uint64_t map_size = SZ_2M * 3;
-		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
-		const int INITIAL_VA = SZ_512M;
-
-		igt_panthor_vm_create(fd, &vm_id, 0);
-		igt_assert(vm_id != 0);
-
-		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
-		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, unmap_size,
-				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, EINVAL);
-		igt_panthor_vm_destroy(fd, vm_id, 0);
+	igt_subtest_group() {
+		igt_fixture() {
+			bool sparse_supported = panthor_driver_version_at_least(fd, 1, 9);
+
+			errno = 0;
+			igt_require_f(sparse_supported,
+				      "Sparse VM_BIND requires Panthor DRM driver version 1.9 or newer\n");
+		}
+
+		igt_describe("Perform a simple sparse vm_bind operation");
+		igt_subtest("vm_bind_sparse") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_4K * 4;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, SZ_2M, map_size, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Perform a partial hugepage-unaligned unmap of a sparsely bound region");
+		igt_subtest("vm_bind_sparse_partial_unmap_start_size_unaligned") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_4K * 2,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do a partial hugeapge-aligned unmap from start of sparsely-bound region");
+		igt_subtest("vm_bind_sparse_partial_unmap_start_size_aligned") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_2M,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do a partial hugeapge-unaligned unmap from start of sparsely-bound region");
+		igt_subtest("vm_bind_sparse_partial_unmap_start_aligned_no_hugepage_multiple") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, 4 * SZ_64K,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do partial hugeapge-aligned unmap that left-intersects with sparse region");
+		igt_subtest("vm_bind_sparse_partial_unmap_below_start") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA - SZ_2M, SZ_2M * 3,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do partial hugepage-aligned unmap that is proper subset of sparse region");
+		igt_subtest("vm_bind_sparse_partial_unmap_above_start") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA + SZ_2M, SZ_2M,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
+		igt_subtest("vm_bind_sparse_remap") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M, SZ_2M * 2,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
+		igt_subtest("vm_bind_sparse_remap_start_unaligned") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
+					    SZ_4M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
+		igt_subtest("vm_bind_sparse_remap_start_size_unaligned") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
+					    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
+		igt_subtest("vm_bind_sparse_remap_start_size_aligned") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle,
+					    INITIAL_VA + map_size - SZ_2M, SZ_4M,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-aligned bind that splits original region in two");
+		igt_subtest("vm_bind_sparse_remap_aligned_split_original_va") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
+					    SZ_2M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal 2MiB aligned hugepage-size-unaligned bind over sparse region");
+		igt_subtest("vm_bind_sparse_remap_start_aligned_size_unaligned") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
+					    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-aligned bind over left end of sparse region");
+		igt_subtest("vm_bind_sparse_remap_aligned_intersect_left") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle,
+					    INITIAL_VA - SZ_2M, SZ_2M * 2,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-unaligned bind over left end of sparse region");
+		igt_subtest("vm_bind_sparse_remap_size_unaligned_intersect_left") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle,
+					    INITIAL_VA - SZ_2M, SZ_1M * 3,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-unaligned bind over right end of sparse region");
+		igt_subtest("vm_bind_sparse_remap_start_aligned_intersect_right") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle,
+					    INITIAL_VA + map_size - SZ_2M, SZ_2M + SZ_4K * 6,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Do normal hugepage-aligned bind that envelopes whole sparse region");
+		igt_subtest("vm_bind_sparse_remap_wrap_around_va") {
+			uint32_t vm_id;
+			struct panthor_bo bo;
+			uint64_t map_size = SZ_2M * 3;
+			const int INITIAL_VA = SZ_4M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+
+			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
+			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
+			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA - SZ_2M,
+					    SZ_8M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
+
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Perform sparse binding operation whose range causes an overflow");
+		igt_subtest("vm_bind_sparse_overflow") {
+			uint32_t vm_id;
+			uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
+			const int INITIAL_VA = SZ_512M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, EINVAL);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
+
+		igt_describe("Perform sparse unbind operation whose range causes an overflow");
+		igt_subtest("vm_unbind_sparse_overflow") {
+			uint32_t vm_id;
+			uint64_t map_size = SZ_2M * 3;
+			uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
+			const int INITIAL_VA = SZ_512M;
+
+			igt_panthor_vm_create(fd, &vm_id, 0);
+			igt_assert(vm_id != 0);
+
+			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
+			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, unmap_size,
+					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, EINVAL);
+			igt_panthor_vm_destroy(fd, vm_id, 0);
+		}
 	}
 
 	igt_fixture() {

---
base-commit: 970700a95acd74bb987287d10147b5f23380519b
change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d

Best regards,
-- 
Deborah Brouwer <deborah.brouwer@collabora.com>

