Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50DAC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B82A710EA23;
	Mon, 29 Jun 2026 20:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="L/Ravg0u";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2A6E10EA0E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:17:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782764245; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=LyU6UvMQUIHGktBLoRYlaFNjSAux9RUoq6JAi+aTmmYfRDy8wlk1PW2UQAdvf4jKEKmLPJ9wM9XEAMRPGjyXG2hNGKFGddTEgMIz54PTWN2r6dvFJWi/zpHFXwROfeFPad7Kl6pvOtHZD3x6buuvRGIDclljY4x5+h03+LHngrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782764245;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=6t2YhC5+otXx+vRCxMxF0nZ1HBOLYB3uJADWo/HG4WI=; 
 b=JQgYiTBOBOtx5JrECGwp+A+J/fRMmtRVqw6XUmWUQYyrCB9+15Ghwf7Yr8j6GVzvxuYi67KboP77IaxSrW6rASNS5O2qxC0U2zL8P5GkTTENI8B6qaTnJyoqclfyRPLEwKyZDrG3yrX5ifhnd/HavCKYqPuDvmCigT13etQ0Rps=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782764245; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=6t2YhC5+otXx+vRCxMxF0nZ1HBOLYB3uJADWo/HG4WI=;
 b=L/Ravg0uq/vR5lXEHzVmNakdkCp05X21xLlxz3GzQc5llMmQZs+LpxAMshZW9lWx
 RN9va3xJTzcu3JS5xPNiKivKH8mMDrAcMSCKHTcY1hto0TacWt4VQuIrAGF+joyek1L
 wElPi8midSbF8wkNBrz2NrZiS/ITbDpGabv+QFiw=
Received: by mx.zohomail.com with SMTPS id 1782764243553100.60197623565034;
 Mon, 29 Jun 2026 13:17:23 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 29 Jun 2026 21:17:07 +0100
Subject: [PATCH v3 3/4] drm/panthor: Have prepare_unmap_op_ctx receive a
 whole vm_bind op
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-vm_bind_checks-v3-3-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
In-Reply-To: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2584;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=juLZK0gpjP3lytTA1rtlwF5oMq3500A5tbnDG1KpR2I=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQtLDN4hTwag63lsU08WMhNZihIk50dV0IXTPC
 uK/y/7OMb2JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakLSwwAKCRAOJn5M7lND
 PQILDAC2pe+PeaPh3S3v7tMq+G2kFTYPgg/6Oqp5A1Hfra5SUWldRpKMNgOS3r/8eQxfMtRCDvc
 TXXeooV2yr3j89sNvHg+5X7dXPEAdjbzDAZRfkxiaLMoGMQzTASIUrH4NRuU7LBveX5WoOM4jPN
 8ZkDdoMPkr3tlJMSBQ0O9r04aRUdSSPXTEN5HjigW+UKCJaCR5dRy/kiYTozOZDNW1Nx4cRW8DS
 FBU+RFe6a8i1eKXsLODmao02r4pvKixLAxtVOLrROrJRWk4iqTGPwYsrPJl1Jmqo/BctUz2HYTP
 +jGMnbEigqyEhgkVI5LxgK2/B9x4X2VETVUpw/7pUU8TWCIhx/vAy7xFbBWOCfingRa2lIShKCI
 lhKmhJO5i8rhZXlZ6Gl0Ry1Wo6aKMJG8XfAH4v+PQXCoAN0FzlW50d2dd/PIES1N1fniWPq4WBN
 WDnf3DzYkpmuY4RgXWRRXHISBoTD8FxKVQf8lvLDsDBfnnjkXdqPUV5d/qu4ozdKM5flw=
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

This change was already enforced for panthor_vm_prepare_map_op_ctx. In a
future commit, access to the drm_panthor_vm_bind_op flags will be needed
inside panthor_vm_prepare_unmap_op_ctx, so rather than expanding the
parameter list, simply pass the operation struct instead.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 48aa23573cd6..77fdad4e5166 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1416,24 +1416,24 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 
 static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					   struct panthor_vm *vm,
-					   u64 va, u64 size)
+					   const struct drm_panthor_vm_bind_op *op)
 {
 	u32 pt_count = 0;
 	int ret;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
-	op_ctx->va.range = size;
-	op_ctx->va.addr = va;
+	op_ctx->va.range = op->size;
+	op_ctx->va.addr = op->va;
 	op_ctx->flags = DRM_PANTHOR_VM_BIND_OP_TYPE_UNMAP;
 
 	/* Pre-allocate L3 page tables to account for the split-2M-block
 	 * situation on unmap.
 	 */
-	if (va != ALIGN(va, SZ_2M))
+	if (op->va != ALIGN(op->va, SZ_2M))
 		pt_count++;
 
-	if (va + size != ALIGN(va + size, SZ_2M) &&
-	    ALIGN(va + size, SZ_2M) != ALIGN(va, SZ_2M))
+	if (op->va + op->size != ALIGN(op->va + op->size, SZ_2M) &&
+	    ALIGN(op->va + op->size, SZ_2M) != ALIGN(op->va, SZ_2M))
 		pt_count++;
 
 	ret = panthor_vm_op_ctx_prealloc_vmas(op_ctx);
@@ -3012,7 +3012,7 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 		if (op->bo_handle || op->bo_offset)
 			return -EINVAL;
 
-		return panthor_vm_prepare_unmap_op_ctx(op_ctx, vm, op->va, op->size);
+		return panthor_vm_prepare_unmap_op_ctx(op_ctx, vm, op);
 
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_SYNC_ONLY:
 		if (op->flags & ~DRM_PANTHOR_VM_BIND_OP_TYPE_MASK)
@@ -3232,10 +3232,14 @@ int panthor_vm_map_bo_range(struct panthor_vm *vm, struct panthor_gem_object *bo
  */
 int panthor_vm_unmap_range(struct panthor_vm *vm, u64 va, u64 size)
 {
+	struct drm_panthor_vm_bind_op op = {
+		.size = size,
+		.va = va,
+	};
 	struct panthor_vm_op_ctx op_ctx;
 	int ret;
 
-	ret = panthor_vm_prepare_unmap_op_ctx(&op_ctx, vm, va, size);
+	ret = panthor_vm_prepare_unmap_op_ctx(&op_ctx, vm, &op);
 	if (ret)
 		return ret;
 

-- 
2.54.0

