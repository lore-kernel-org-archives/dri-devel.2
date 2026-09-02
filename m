Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECE18C624DB
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BB3410F3FE;
	Thu,  3 Sep 2026 07:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=empyreal.works header.i=@empyreal.works header.b="PKRsKe/q";
	dkim-atps=neutral
Received: from mail-244105.protonmail.ch (mail-244105.protonmail.ch
 [109.224.244.105])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFE610F1A8
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 12:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=empyreal.works;
 s=protonmail2; t=1788351957; x=1788611157;
 bh=iHjWnT0jlb2Iol6Nzi7YDxpQFzDBH8b1quQqLixhaVw=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=PKRsKe/qKcWIzc98TeeX6eBDhvYxrUfiaBXdi5vkZ1tyoM7aUrhoqZVyDr1FbWAjK
 /gxqcCUV3p0yaD1xfXE/g+Dh7VYH/IZdUSCn6r2SuQn04xfk6zkBeTDLSCw560y53+
 y3CK/hzsEo/VHENUZr3HPtEHS1vtfC7yBBHcO3EIfSIc9qYIWbnGxLS2Qcaz/oj4Z0
 mJ9+IqngKt6hPYkV8+ii0LUxSsYqmeIB8wKVdkNBrGjVdVammyfEjcT00aFTHyE95c
 dT7gG+a3zAyxJOWB6Q790QimThU/ueW7eiwHN+XvXJ8vmsjlnArNNM0aA9U5ZQjcz3
 lqldYY5C1NrHg==
Date: Wed, 02 Sep 2026 12:25:52 +0000
To: amd-gfx@lists.freedesktop.org
From: Andrei Rusu de Castro <arc@empyreal.works>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, sunil.khatri@amd.com, Prike.Liang@amd.com,
 timur.kristof@gmail.com, nat@pixelcluster.dev, mikhail.v.gavrilov@gmail.com,
 pierre-eric.pelloux-prayer@amd.com, srinivasan.shanmugam@amd.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: reject out of range PFNs in
 amdgpu_vm_update_range()
Message-ID: <20260902-vm-4f19ee6f@empyreal.works>
Feedback-ID: 182420409:user:proton
X-Pm-Message-ID: 4faec4b9ae5bb64e6db0f242f9775f91ad1e8d40
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 03 Sep 2026 07:33:13 +0000
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

amdgpu_vm_update_range() walks the page tables for the inclusive PFN
range [@start, @last] without validating it. Two properties have to
hold for that walk to be well defined, and both are currently left to
caller convention.

The range must not be reversed. The resource cursor is initialized with
a size of (last - start + 1) * AMDGPU_GPU_PAGE_SIZE in unsigned
arithmetic, so a @last below @start - 1 wraps to a multi-terabyte size
and the update runs past the intended end.

@last must also stay below vm_manager.max_pfn. Unlike the lower levels,
the root level uses a mask wide enough to be ineffective. The page-table
walker derives an index from the PFN and applies a 0xffffffff root mask,
while amdgpu_vm_pt_num_entries() allocates the root directory with only

=09round_up(max_pfn, 1ULL << shift) >> shift

entries. A PFN at or above max_pfn therefore indexes past the root entry
array on the first descent.

The buffer-object mapping path enforces both properties in
amdgpu_vm_verify_parameters(), which rejects a zero size "which also
leads to end < begin" and an lpfn >=3D max_pfn. Ranges reaching
amdgpu_vm_update_range() from amdgpu_vm_bo_update() and
amdgpu_vm_clear_freed() come from mappings validated there. The retry
fault handler instead forwards one hardware-reported PFN without
checking it against the configured aperture.

The KFD SVM path is not covered either. This has been possible since
commit f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs"), which first
mapped SVM ranges into the GPUVM page tables without an equivalent bound
check. svm_range_map_to_gpu() and svm_range_unmap_from_gpu() check only
amdgpu_vm_ready(). Their callers guard against reversed ranges, but
nothing compares the result against max_pfn.

When amdgpu.vm_size configures a GPU virtual address space smaller than
the CPU address space, a process can register memory whose PFN exceeds
max_pfn. A range near 113 TiB against a 256-entry root produced index
116128 and oopsed in amdgpu_vm_ptes_update().

Validate the shared page-table-walk primitive rather than relying on
every caller to duplicate its root-array precondition. Reject invalid
ranges before device entry, allocation, or locking. Two in-tree paths
can reach an out-of-range PFN once the aperture is smaller than an
address a process can touch: KFD SVM and the retry fault handler. The
fault handler will now log -EINVAL and return the fault as unhandled.
The validated buffer-object callers are unaffected.

Source and call-chain analysis identified the missing
shared precondition. The amdgpu VM and KFD SVM objects and the complete
amdgpu object were built with W=3D1. No runtime test was performed.

Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")

Signed-off-by: Andrei Rusu de Castro <arc@empyreal.works>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/a=
mdgpu/amdgpu_vm.c
index aedf72c2333e..f9a46d706340 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1140,6 +1140,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *ade=
v, struct amdgpu_vm *vm,
 =09struct amdgpu_res_cursor cursor;
 =09int r, idx;
=20
+=09/*
+=09 * The page table walk indexes the root PD without masking, so an
+=09 * out of range PFN would index past the end of its entry array.
+=09 * A reversed range would additionally underflow the cursor size.
+=09 */
+=09if (start > last || last >=3D adev->vm_manager.max_pfn)
+=09=09return -EINVAL;
+
 =09if (!drm_dev_enter(adev_to_drm(adev), &idx))
 =09=09return -ENODEV;
=20

