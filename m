Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 189C7C88E77
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:57:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CEA10E1C9;
	Wed, 16 Sep 2026 07:57:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="GC6ILyBk";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151A010E1C9;
 Wed, 16 Sep 2026 07:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789545466; x=1821081466;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=xd9mjHXAq8WOs1fL/bd74jrquQ15VROoEJ02awqnzXo=;
 b=GC6ILyBknWF3+njuodz2fEApfEX25UQohnm9RIHdo5C+J1TsBBucL0qA
 2sjU4EBynBNK+8GdVk3A56ZyI0GRfRU15KAcPdIEsMy/idc8QU9Mz6oLE
 lEI2G/uqVUX0Dv+I97cfSRqh3D02JyqFhT0t6JOicLghl/snslGXNFvUd
 WFLLsuY70B/gNfd+6V5PuMW+808aFUnkUxH2xlmpVA4hkatllU13H2q3P
 UhIjc3LtnN2ny56yPf3jLpvzcuToNX0ikgAHNY2jhgJ4cEI8NCjLS/zu+
 qgkeUrhfoNTEwyyeJet3q3oM0xrVJ76633GjwmB3rtDPL/yv2/IvqGnSe A==;
X-CSE-ConnectionGUID: TZdiTO/AScKuIwQ16H4okw==
X-CSE-MsgGUID: /kcWVi6jT42gzTmuhSBOGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="93788322"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="93788322"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 00:57:46 -0700
X-CSE-ConnectionGUID: 9v6acAyfSc202CRmsHCBqQ==
X-CSE-MsgGUID: 4iEmjvTbSluQDmtAlMx5qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1665314"
Received: from kamilkon-desk.igk.intel.com (HELO localhost) ([10.211.136.201])
 by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 00:57:44 -0700
Date: Wed, 16 Sep 2026 09:57:41 +0200
From: Kamil Konieczny <kamil.konieczny@linux.intel.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com, samitolvanen@google.com
Subject: Re: [PATCH i-g-t] tests/panthor: skip sparse VM_BIND tests before v1.9
Message-ID: <20260916075741.zeu3k3bd7ynwdrju@kamilkon-DESK.igk.intel.com>
Mail-Followup-To: Kamil Konieczny <kamil.konieczny@linux.intel.com>,
 Deborah Brouwer <deborah.brouwer@collabora.com>,
 igt-dev@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 boris.brezillon@collabora.com, steven.price@arm.com,
 liviu.dudau@arm.com, adrian.larumbe@collabora.com,
 samitolvanen@google.com
References: <20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915-b4-panthor_version_sparse-v1-1-7ac10b75e631@collabora.com>
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

Hi Deborah,
On 2026-09-15 at 17:13:26 -0700, Deborah Brouwer wrote:
> Sparse VM_BIND support was introduced with Panthor DRM driver version
> 1.9. If a driver isn't advertising support for v1.9, then tests that
> call DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE should not be run.

Can you just call that ioctl and if EINVALID skip?
Checking version of a driver seems strange.

> 
> So skip the sparse VM_BIND subtests when running against a driver older
> than version 1.9.
> 
> Also add indentation to group the sparse tests together.
> 
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
>  tests/panthor/panthor_vm.c | 660 +++++++++++++++++++++++----------------------
>  1 file changed, 342 insertions(+), 318 deletions(-)
> 
> diff --git a/tests/panthor/panthor_vm.c b/tests/panthor/panthor_vm.c
> index 9011df25e..0140b9e40 100644
> --- a/tests/panthor/panthor_vm.c
> +++ b/tests/panthor/panthor_vm.c
> @@ -7,6 +7,20 @@
>  #include "igt_sizes.h"
>  #include "panthor_drm.h"
>  
> +static bool panthor_driver_version_at_least(int fd, int major, int minor)
> +{
> +	drmVersionPtr version = drmGetVersion(fd);
> +	bool supported;
> +
> +	igt_assert(version);
> +	supported = version->version_major > major ||
> +		    (version->version_major == major &&
> +		     version->version_minor >= minor);
> +	drmFreeVersion(version);
> +
> +	return supported;
> +}
> +
>  int igt_main() {
>  	int fd = -1;
>  
> @@ -288,324 +302,334 @@ int igt_main() {
>  		igt_panthor_vm_destroy(fd, vm_id, 0);
>  	}
>  
> -	igt_describe("Perform a simple sparse vm_bind operation");
> -	igt_subtest("vm_bind_sparse") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_4K * 4;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, SZ_2M, map_size, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Perform a partial hugepage-unaligned unmap of a sparsely bound region");
> -	igt_subtest("vm_bind_sparse_partial_unmap_start_size_unaligned") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_4K * 2,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do a partial hugeapge-aligned unmap from start of sparsely-bound region");
> -	igt_subtest("vm_bind_sparse_partial_unmap_start_size_aligned") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_2M,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do a partial hugeapge-unaligned unmap from start of sparsely-bound region");
> -	igt_subtest("vm_bind_sparse_partial_unmap_start_aligned_no_hugepage_multiple") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, 4 * SZ_64K,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do partial hugeapge-aligned unmap that left-intersects with sparse region");
> -	igt_subtest("vm_bind_sparse_partial_unmap_below_start") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA - SZ_2M, SZ_2M * 3,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do partial hugepage-aligned unmap that is proper subset of sparse region");
> -	igt_subtest("vm_bind_sparse_partial_unmap_above_start") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA + SZ_2M, SZ_2M,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
> -	igt_subtest("vm_bind_sparse_remap") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M, SZ_2M * 2,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
> -	igt_subtest("vm_bind_sparse_remap_start_unaligned") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
> -				    SZ_4M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
> -	igt_subtest("vm_bind_sparse_remap_start_size_unaligned") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
> -				    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
> -	igt_subtest("vm_bind_sparse_remap_start_size_aligned") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle,
> -				    INITIAL_VA + map_size - SZ_2M, SZ_4M,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-aligned bind that splits original region in two");
> -	igt_subtest("vm_bind_sparse_remap_aligned_split_original_va") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
> -				    SZ_2M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal 2MiB aligned hugepage-size-unaligned bind over sparse region");
> -	igt_subtest("vm_bind_sparse_remap_start_aligned_size_unaligned") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
> -				    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-aligned bind over left end of sparse region");
> -	igt_subtest("vm_bind_sparse_remap_aligned_intersect_left") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle,
> -				    INITIAL_VA - SZ_2M, SZ_2M * 2,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-unaligned bind over left end of sparse region");
> -	igt_subtest("vm_bind_sparse_remap_size_unaligned_intersect_left") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle,
> -				    INITIAL_VA - SZ_2M, SZ_1M * 3,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-unaligned bind over right end of sparse region");
> -	igt_subtest("vm_bind_sparse_remap_start_aligned_intersect_right") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle,
> -				    INITIAL_VA + map_size - SZ_2M, SZ_2M + SZ_4K * 6,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Do normal hugepage-aligned bind that envelopes whole sparse region");
> -	igt_subtest("vm_bind_sparse_remap_wrap_around_va") {
> -		uint32_t vm_id;
> -		struct panthor_bo bo;
> -		uint64_t map_size = SZ_2M * 3;
> -		const int INITIAL_VA = SZ_4M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -
> -		/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> -		igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> -		igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA - SZ_2M,
> -				    SZ_8M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> -
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Perform sparse binding operation whose range causes an overflow");
> -	igt_subtest("vm_bind_sparse_overflow") {
> -		uint32_t vm_id;
> -		uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
> -		const int INITIAL_VA = SZ_512M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, EINVAL);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> -	}
> -
> -	igt_describe("Perform sparse unbind operation whose range causes an overflow");
> -	igt_subtest("vm_unbind_sparse_overflow") {
> -		uint32_t vm_id;
> -		uint64_t map_size = SZ_2M * 3;
> -		uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
> -		const int INITIAL_VA = SZ_512M;
> -
> -		igt_panthor_vm_create(fd, &vm_id, 0);
> -		igt_assert(vm_id != 0);
> -
> -		igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> -		igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, unmap_size,
> -				    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, EINVAL);
> -		igt_panthor_vm_destroy(fd, vm_id, 0);
> +	igt_subtest_group() {
> +		igt_fixture() {
> +			bool sparse_supported = panthor_driver_version_at_least(fd, 1, 9);
> +
> +			errno = 0;
> +			igt_require_f(sparse_supported,
> +				      "Sparse VM_BIND requires Panthor DRM driver version 1.9 or newer\n");

Skips in group fixture confuse users, it is better to add it to
every subtests which needs it, it can also be calling a function
which will check condition and then make a skip.

Change then will be minimal in a few subtests.

With this, when you will run some other tests after/before this,
you can see:

sudo ./panthor_vm --r some-later-subtest
SKIP: igt_require not satisfied...
SUCCESS: some-later-subtest



Regards,
Kamil

> +		}
> +
> +		igt_describe("Perform a simple sparse vm_bind operation");
> +		igt_subtest("vm_bind_sparse") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_4K * 4;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, SZ_2M, map_size, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Perform a partial hugepage-unaligned unmap of a sparsely bound region");
> +		igt_subtest("vm_bind_sparse_partial_unmap_start_size_unaligned") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_4K * 2,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do a partial hugeapge-aligned unmap from start of sparsely-bound region");
> +		igt_subtest("vm_bind_sparse_partial_unmap_start_size_aligned") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, SZ_2M,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do a partial hugeapge-unaligned unmap from start of sparsely-bound region");
> +		igt_subtest("vm_bind_sparse_partial_unmap_start_aligned_no_hugepage_multiple") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, 4 * SZ_64K,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do partial hugeapge-aligned unmap that left-intersects with sparse region");
> +		igt_subtest("vm_bind_sparse_partial_unmap_below_start") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA - SZ_2M, SZ_2M * 3,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do partial hugepage-aligned unmap that is proper subset of sparse region");
> +		igt_subtest("vm_bind_sparse_partial_unmap_above_start") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA + SZ_2M, SZ_2M,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, 0);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
> +		igt_subtest("vm_bind_sparse_remap") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M, SZ_2M * 2,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
> +		igt_subtest("vm_bind_sparse_remap_start_unaligned") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
> +					    SZ_4M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-unaligned bind that intersects with sparsely-mapped region");
> +		igt_subtest("vm_bind_sparse_remap_start_size_unaligned") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + map_size - SZ_1M,
> +					    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-aligned bind that intersects with sparsely-mapped region");
> +		igt_subtest("vm_bind_sparse_remap_start_size_aligned") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle,
> +					    INITIAL_VA + map_size - SZ_2M, SZ_4M,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-aligned bind that splits original region in two");
> +		igt_subtest("vm_bind_sparse_remap_aligned_split_original_va") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
> +					    SZ_2M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal 2MiB aligned hugepage-size-unaligned bind over sparse region");
> +		igt_subtest("vm_bind_sparse_remap_start_aligned_size_unaligned") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA + SZ_2M,
> +					    SZ_1M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-aligned bind over left end of sparse region");
> +		igt_subtest("vm_bind_sparse_remap_aligned_intersect_left") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle,
> +					    INITIAL_VA - SZ_2M, SZ_2M * 2,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-unaligned bind over left end of sparse region");
> +		igt_subtest("vm_bind_sparse_remap_size_unaligned_intersect_left") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle,
> +					    INITIAL_VA - SZ_2M, SZ_1M * 3,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-unaligned bind over right end of sparse region");
> +		igt_subtest("vm_bind_sparse_remap_start_aligned_intersect_right") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle,
> +					    INITIAL_VA + map_size - SZ_2M, SZ_2M + SZ_4K * 6,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Do normal hugepage-aligned bind that envelopes whole sparse region");
> +		igt_subtest("vm_bind_sparse_remap_wrap_around_va") {
> +			uint32_t vm_id;
> +			struct panthor_bo bo;
> +			uint64_t map_size = SZ_2M * 3;
> +			const int INITIAL_VA = SZ_4M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +
> +			/* Now attempt normal VM_BIND's that intersect with the previous chunk */
> +			igt_panthor_bo_create(fd, &bo, SZ_8M, 0, 0);
> +			igt_panthor_vm_bind(fd, vm_id, bo.handle, INITIAL_VA - SZ_2M,
> +					    SZ_8M, DRM_PANTHOR_VM_BIND_OP_TYPE_MAP, 0);
> +
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Perform sparse binding operation whose range causes an overflow");
> +		igt_subtest("vm_bind_sparse_overflow") {
> +			uint32_t vm_id;
> +			uint64_t map_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - (SZ_2M * 3);
> +			const int INITIAL_VA = SZ_512M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, EINVAL);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
> +
> +		igt_describe("Perform sparse unbind operation whose range causes an overflow");
> +		igt_subtest("vm_unbind_sparse_overflow") {
> +			uint32_t vm_id;
> +			uint64_t map_size = SZ_2M * 3;
> +			uint64_t unmap_size = ALIGN_DOWN(UINT64_MAX, SZ_2M) - map_size;
> +			const int INITIAL_VA = SZ_512M;
> +
> +			igt_panthor_vm_create(fd, &vm_id, 0);
> +			igt_assert(vm_id != 0);
> +
> +			igt_panthor_vm_bind_sparse(fd, vm_id, INITIAL_VA, map_size, 0);
> +			igt_panthor_vm_bind(fd, vm_id, 0, INITIAL_VA, unmap_size,
> +					    DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP, EINVAL);
> +			igt_panthor_vm_destroy(fd, vm_id, 0);
> +		}
>  	}
>  
>  	igt_fixture() {
> 
> ---
> base-commit: 970700a95acd74bb987287d10147b5f23380519b
> change-id: 20260915-b4-panthor_version_sparse-5fbd31cc0d5d
> 
> Best regards,
> -- 
> Deborah Brouwer <deborah.brouwer@collabora.com>
> 
