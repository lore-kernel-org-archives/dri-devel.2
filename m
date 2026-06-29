Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E747C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C79D710E113;
	Mon, 29 Jun 2026 20:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="iUiPz2tZ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5346A10EA0E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782764249; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FFDk5tBbjYCIq+DYkvI63Dn3HuosoBIfR+eF6azQfVjVhwy9LkbZAmSZftmqK6zrUWPwXOQH0hAB+nSCk3AnqmzB87XsHDOuBpZBZbdgj8V0Jen9HBu4FMO5LxsspW7SPeCCx2k30Fq2xagciTL+QmfdhVCrvXOtO7nkbRxjiHw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782764249;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=skcBfSeZPONe2o3Djh24lxLgkSwmdgz8Pb0lPRkydH8=; 
 b=c05cU+UlwUx3/iDl+xUpe+fqAuDUfTSdbUxhCnyuSfI7Su0euGTs8gCV+kSNMKqWrMe95g9YpcvjvANIWYIh22rbwsbzLpP4OzlTWyfWKZtMHm9OEUkV64JfwDsVKvOE42yeys13EI3lFu3ryEQ/+wKfCEbTfIQZgQL00q/7Y3M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782764249; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=skcBfSeZPONe2o3Djh24lxLgkSwmdgz8Pb0lPRkydH8=;
 b=iUiPz2tZPSOfs/3XWXgrIGLym+67VkEu8rMwbuEqhX8gNQu/qhGjxYeAjs29Ctk8
 TeRjr0ZY8+1XlKOkkfXYlOvEgsTJefXafDTSQbfi8VdiRnrfqNO/diFxYKxdNxW30De
 ZSmXwE60UzlIjvLiO2l3zYOzBEf6bj8q4UmhALKQ=
Received: by mx.zohomail.com with SMTPS id 1782764247563417.74878732894445;
 Mon, 29 Jun 2026 13:17:27 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 29 Jun 2026 21:17:08 +0100
Subject: [PATCH v3 4/4] drm/panthor: Check for sparse binding range
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-vm_bind_checks-v3-4-85e6740f6c2e@collabora.com>
References: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
In-Reply-To: <20260629-vm_bind_checks-v3-0-85e6740f6c2e@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Sashiko <noreply@sashiko.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2364;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=+mGRw7mVgUaPh96FfLsfP5ChuFDuncaGNjHDG8+Q/FM=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQtLDX2DXScNvQdaAPWzSBmrPlMG5HAkK46uNP
 ycdfzYQan+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakLSwwAKCRAOJn5M7lND
 PZRbC/9DYNVo2rpIcDEz6nsT+k+C/7+IpPvJ3u+NtsPyQX0dwDoxKqNGLus6ePa4uF7jEQCKfSV
 isZ3UVKEm4upy1ehbwF3qY0L2aL2O5FIg0vSPZWhV3RkuB+upCBoF2ppfq54471ajQIgOxwSn+m
 yvKvSTKTxlHI/cCwBsnWjWlN8+voWo2gzrhmAUc/SO44ygwNvKyN/dO0x5DMBihVO/dBLDbgZIi
 DWUbrjELhjI3i4NN7Bp+kLsjyQkhc3HAlL66cDWo0Ds1kriSaNNYIDmWwbXO8aRM1B7r6Tnpa/c
 9Cf0hZ0mUbjP9Ua5a55P9LGr5LZvZlnBse68C/h9GijrFqyzqhqt4SYkmTxJL+RNtloXBVHAp9i
 qPQxbM9uTorYTwMMi944S1meUn8iKwZkx/JttsjSQPWgvgwsFmF7JZmBVwqwbh0qXOyjjZH3gAF
 l+jpuEnzDREFBaxQkefEyq38TK4iqWO/hocqnMK00bduvr/jYZ4T7adybYYr/lVtNXjTE=
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

This check is being already carried out further down the call stack inside
drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to fail early in
the driver before GPUVM functions are invoked so that we won't waste time
allocating vm_bind context resources.

Reported-by: Sashiko <noreply@sashiko.dev>
Closes: https://sashiko.dev/#/message/20260623204220.CDB1B1F000E9%40smtp.kernel.org
Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 77fdad4e5166..8bd9b975e5ce 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -1328,6 +1328,7 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	struct drm_gpuvm_bo *preallocated_vm_bo;
 	struct sg_table *sgt = NULL;
 	int ret;
+	u64 end;
 
 	if (!bo)
 		return -EINVAL;
@@ -1353,6 +1354,10 @@ static int panthor_vm_prepare_map_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	if (is_sparse && (op->bo_handle || op->bo_offset))
 		return -EINVAL;
 
+	/* Protect against sparse VA range overflow */
+	if (is_sparse && check_add_overflow(op->va, op->size, &end))
+		return -EINVAL;
+
 	/* If the BO has an exclusive VM attached, it can't be mapped to other VMs. */
 	if (bo->exclusive_vm_root_gem &&
 	    bo->exclusive_vm_root_gem != panthor_vm_root_gem(vm))
@@ -1418,7 +1423,9 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 					   struct panthor_vm *vm,
 					   const struct drm_panthor_vm_bind_op *op)
 {
+	bool is_sparse = op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 	u32 pt_count = 0;
+	u64 end;
 	int ret;
 
 	memset(op_ctx, 0, sizeof(*op_ctx));
@@ -1432,6 +1439,10 @@ static int panthor_vm_prepare_unmap_op_ctx(struct panthor_vm_op_ctx *op_ctx,
 	if (op->va != ALIGN(op->va, SZ_2M))
 		pt_count++;
 
+	/* Protect against sparse VA range overflow */
+	if (is_sparse && check_add_overflow(op->va, op->size, &end))
+		return -EINVAL;
+
 	if (op->va + op->size != ALIGN(op->va + op->size, SZ_2M) &&
 	    ALIGN(op->va + op->size, SZ_2M) != ALIGN(op->va, SZ_2M))
 		pt_count++;

-- 
2.54.0

