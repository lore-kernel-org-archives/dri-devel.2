Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14157CD98E7
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:47:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCA3310EC0F;
	Tue, 16 Jun 2026 14:47:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="CM3Vczts";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 339D910EC0F
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 14:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781621219; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M55wjNKrSS0643KhFjJ+C7/cdREiWZ+AMLdUfo+ZbtBU1Xdlf9mEDWTMEwG2nPPaM6eKAcYH3eDILCmqhfsDH1TjNwMSIvVtoDmpdjWTPk9o8Fx+9xBuPmqPLtqUTBzrJ7aqsqXT7RDNEF92dWCpRmA4w+v/5qC7oq0M03Q1MUU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781621219;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pJ5VYQiKaE4g3DWUVCKJZoEJIoC8dcs97MDGz/j3zLY=; 
 b=TROEK+5Fj1h+w0XF96UBSRGw+wkvwAKARk4MIcjXPmg02jlsS1cHhtjCF3lmBWnRyYQxkT6hCbJbEXpL75fnxZTmCkcMIl1hfjpaYrDlSe3T+8dHDik8SIzd7qlWt8rrYdTCQb5wY5hdeXjKMrRW/+JKGNuGhiyLLr/iu2XhrgQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781621219; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=pJ5VYQiKaE4g3DWUVCKJZoEJIoC8dcs97MDGz/j3zLY=;
 b=CM3Vczts4X71kj2cgljzqjP31k7JxfXIHG53ypFstXySGnuQ7omK+4lfoH6VCmis
 AKEoPqgHA+r4WEud6eHe8O9HaGjLTIIKldA7sgQz13fJK8zGSWU7Y6uX73pTleUMwzz
 1/eDnCYUdlHc2bo+WS6tb5iNrnqKBIdGpFMoZns8=
Received: by mx.zohomail.com with SMTPS id 1781621217893705.4250486537643;
 Tue, 16 Jun 2026 07:46:57 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Tue, 16 Jun 2026 15:46:43 +0100
Subject: [PATCH 1/2] drm/panthor: Add vm_bind region with kbo range
 intersection check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260616-vm_bind_checks-v1-1-956198602ae3@collabora.com>
References: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
In-Reply-To: <20260616-vm_bind_checks-v1-0-956198602ae3@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3059;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=N3l7npS3Z2xKnmWHhO7TanxTOdQV0X2TjqqYWi7KUug=;
 b=owEB7AET/pANAwAKAQ4mfkzuU0M9AcsmYgBqMWHcBATW6ch8bVo8O7rouh7Ab60xiLBwzeLPB
 XmZPbyPfvmJAbIEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajFh3AAKCRAOJn5M7lND
 PYVaC/dJP4Gg75pbxlHxfuNa7WBvHplyG5EGtxLQZ0IJP+c1vzJj7sAV5xzyrruU2pqLjh8GkRz
 WWT0OJbs6zbybuX7xNaDd2SfbYvJ8SvabhsN4WPyTbBJT0C93hBmIeXsSP49i+0imh8YMKnD+Ph
 WKOHB7XpxGXCZA4ZDV8wZhBa9BnvU2K4HuP0ZIDtzTjb1r24Dd+fF2GnSkbJv7Sqx5V3xHB5eiJ
 9UizcQaS896xansWUbqdZd/rplQJLtucy4mmGmN30cW9+RAeWqVGOndhwYDeOyG1wrr3EfzhKgI
 rUjBCzCd8cXaGeA9/YrvS5cTPGNWGv9vSRhlQ+Sd4G44+6gEB7iIPathfoxs93TlSGkQFK/FUHv
 y74BLGv5W/IZvw9WOVTFFWQDcJoqo9vNjMWLsj62ceC+DY8MF+WURAhk1Ln7nW2v+08exDPxOIL
 /WZo2rL3JzaqVRgQMowuRH0DUazQojf/XEdbcEnFqq/IUXh+sbGhPJX2gIR+056HliUg==
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

When a VM is created, caller has to specify the range of the address space
carve-out set aside for mapping kernel BO's. That means vm_bind mappings of
UM-exposed BO's should not intersect with that region, but at the moment
we're not checking this.

At first, I thought of giving these values to drm_gpuvm_init() through its
reserve_{offset, range} arguments, but it turns out that is meant for VM
address spans that are not managed through the usual drm_gpuvm split/merge
circuit, so I had no choice but to sort of duplicate that functionality in
Panthor. That means we also need to keep that interval recorded in the VM.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..5625f3d34031 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -301,6 +301,15 @@ struct panthor_vm {
 	/** @mm_lock: Lock protecting the @mm field. */
 	struct mutex mm_lock;
 
+	/** @kernel_va: VA-range reserved for kernel BOs. */
+	struct {
+		/** @kernel_va.start: Start of the VA-range for kernel BOs. */
+		u64 start;
+
+		/** @kernel_va.range: Size of the automatic VA-range for kernel BOs. */
+		u64 range;
+	} kernel_va;
+
 	/** @kernel_auto_va: Automatic VA-range for kernel BOs. */
 	struct {
 		/** @kernel_auto_va.start: Start of the automatic VA-range for kernel BOs. */
@@ -1309,6 +1318,24 @@ static int panthor_vm_op_ctx_prealloc_pts(struct panthor_vm_op_ctx *op_ctx)
 	return 0;
 }
 
+static bool
+panthor_vm_is_kernel_address(struct panthor_vm *vm,
+			     const struct drm_panthor_vm_bind_op *op)
+{
+	u32 op_type = op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK;
+	u64 end, kstart, krange, kend;
+
+	if (op_type == DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY)
+		return false;
+
+	end = op->va + op->size;
+	kstart = vm->kernel_va.start;
+	krange = vm->kernel_va.range;
+	kend = kstart + krange;
+
+	return krange && op->va < kend && kstart < end;
+}
+
 #define PANTHOR_VM_BIND_OP_MAP_FLAGS \
 	(DRM_PANTHOR_VM_BIND_OP_MAP_READONLY | \
 	 DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC | \
@@ -2891,6 +2918,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 	} else {
 		min_va = 0;
 		va_range = full_va_range;
+		vm->kernel_va.start = kernel_va_start;
+		vm->kernel_va.range = kernel_va_size;
 	}
 
 	mutex_init(&vm->mm_lock);
@@ -2981,6 +3010,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
+	/* We don't allow mappings that intersect with kbo's reserved range */
+	if (panthor_vm_is_kernel_address(vm, op))
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.54.0

