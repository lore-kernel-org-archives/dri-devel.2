Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EA1BCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 12:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927C610E0AB;
	Fri, 19 Jun 2026 12:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="h/YPvt2l";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94CFA10E0AB
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 12:41:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1781872893; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=OccyjIOPvbqeTi/bi2ZPOmYfqsuDqVrkvrsqNE/jY6OC/m58tJm4FiVafLmBuuwo/vCgNlee36yPRpsQXI2+WFHLuyii54Vnkq5Cf0faWkYL3bLCXe5QDSR5HxGJFOFCzA8ttfzuDnq8enEijfq1qTPQEvHrmXTqwJ6srIvXnpI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1781872893;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=sx+MBR3FeUumqjnLB3CfPkW/JUAnlvdVecoQ0DF6dy4=; 
 b=dIrjVszGBghAIkygv0DVZkr+UjsZgn9UreA6XfYtFie6mLBqtQQJyC6UgHdj4PJW8FPdSLjDzJ4UwDU/e3UYTvXVhN+3SH5tEAkUhjaFn8IUEbna/oa60zSh4V+1ownrpZNNhRApAdHgLzoIJFGQC0dhA1R2/uXeXoDa2r8oLnU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1781872893; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=sx+MBR3FeUumqjnLB3CfPkW/JUAnlvdVecoQ0DF6dy4=;
 b=h/YPvt2l8M7KY7pH80todBjqB8SZQDiFF1Qshdqu6DzB+wyL40Z+XQmmR2Wvq8YA
 aOzKt67EUSRRd2IevXEc7uid3R0O3pV5kuLiAZJNi5Kl9BLeYv+lF4yUGbRJpL1AXUN
 STVeVwPaxaOCNGsK+AOpsTMQv57m+dRyIIAMveos=
Received: by mx.zohomail.com with SMTPS id 1781872892581979.7830300575799;
 Fri, 19 Jun 2026 05:41:32 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 19 Jun 2026 13:41:22 +0100
Subject: [PATCH v2 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260619-vm_bind_checks-v2-1-b51abab35f71@collabora.com>
References: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
In-Reply-To: <20260619-vm_bind_checks-v2-0-b51abab35f71@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2053;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=MgNRYA+1NLCU6oiLdsjT3Gs9F4MtSzgAEYq17acMFsg=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqNTj425TdgatwQT2ZeYlBJ9TceL2woxGqPuMS/
 2K7L9UOvPKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCajU4+AAKCRAOJn5M7lND
 PVU+DAC6fO5pn/k1KhBW9hsrIZm1LfXWMnYPpHPgNGMRHt+5Oq/ex0vTi/RFYByB5cBEbHG6XlK
 ze5K0/+s7UlXcy1tPFY/kLRVj7Y7mtAC9Se/5r4bkXlj1WMYwIrFAt0WgXu4ODKhK3Qim4LO2zB
 KpI/4SDTEYzhkHcoa1PgBrSBAOlrJpnbOXsGR+YQg9xmtL8CiMk5zkf1xi23B5cF5m24id+KIDa
 AZ51jirtj8kSFEQSyv2CfOUoklcMqpe22xFEwM1QzqyHDmghudfDNEfYBj/jkNU0qVWTzVndp8Y
 L5O29V26T/6cQOn2har9Yb/7UnlLkC5oDCH5QsqB9Hhcv9mP9IMQZcHX9zw1FaEEXjFIWfEIGuo
 cOQHMwMljcikxeeDgp/6OHYH1Ezfy3vq40+nYsJChWdd4GEraTMHyXntu7aV1x0jd53RNqNqghx
 z0FC+zuyMusFUSQildrSEJBVC1qJ+sVaE4UYRUaQ4mNp9Yh6mJl8VZpU0a2T2+QsqdwEo=
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
circuit, so storing the end of the user VA range at VM creation time and
doing a quick check in the vm_bind ioctl path was the simplest workaround.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..a8de4fe6b231 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -310,6 +310,9 @@ struct panthor_vm {
 		u64 end;
 	} kernel_auto_va;
 
+	/** @user_va_end: Last VA in the address range VM users can map objects against. */
+	u64 user_va_end;
+
 	/** @as: Address space related fields. */
 	struct {
 		/**
@@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		va_range = full_va_range;
 	}
 
+	vm->user_va_end = kernel_va_start - 1;
+
 	mutex_init(&vm->mm_lock);
 	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
 	vm->kernel_auto_va.start = auto_kernel_va_start;
@@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
+	/* We don't allow mappings that overlap with kbo's reserved range */
+	if (op->va + op->size > vm->user_va_end)
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.54.0

