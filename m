Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C62C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02B7610E85C;
	Mon, 13 Jul 2026 08:48:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="b+lqLUIl";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7466D10E85C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:48:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783932511; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lrUlASr9GyE/5jOKp7grWMK9nPrPe/1KagMQULyAJejVyEjDocVL0EnA6RTJWP5Tr3iA29gsTLBkNEytd8GQfMH5kdrb1k45vA2pzUSgQJHOxeRYI8vNqwQgPzG9zEEbhU1+x1LKgh8IaSklRYDFQfwD7Q1I62yM+ITbNbLT2RU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783932511;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZBknGGTYquB8G0f7/2U9fS3UD9O4iTemdyZ8ldfWnkQ=; 
 b=PCwz63avdpOJ60Mu2fi3pE3fgx8BmOWoT8gOa5YFw9bcjnsgbxKtYatricATcnYIAQRR5Z2/UtK/2jqqOw6ngUvba8QXon6joXyJaHksEUjMwC4w970hBavY5Q4Gcv8P9Xu3WZ5vT+p9A3lMpZ87s7b7nD8Zn+HQb89BNz+yGP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783932511; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=ZBknGGTYquB8G0f7/2U9fS3UD9O4iTemdyZ8ldfWnkQ=;
 b=b+lqLUIl2MP9ODR/yOVZ+kqndYTNavbE+0ZIh7wch79C9/7JAPkef/kayxuR9027
 /R5vO2wvrzEfBPD+bkrxu7ijo86MiRGZFD8j62Et2zo4v00rnIQ87Pw6HRGmIB4iv6/
 qu2fekk9SGTOgrG8zu51muMAyw7yqy5gKsG5wPy0=
Received: by mx.zohomail.com with SMTPS id 1783932508375143.8027755852337;
 Mon, 13 Jul 2026 01:48:28 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 13 Jul 2026 09:48:01 +0100
Subject: [PATCH v5 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260713-vm_bind_checks-v5-1-0d2314af8d9d@collabora.com>
References: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
In-Reply-To: <20260713-vm_bind_checks-v5-0-0d2314af8d9d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2620;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=1gSi5uury5tTD+1Uf/ppdv9sT2n8DymsEJ+oK3Xa5uw=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqVKZTJ95s3IKDS/3toTiH3PruJ+W8DmaqbpT2/
 lNszI0rOF+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCalSmUwAKCRAOJn5M7lND
 PUreDACGfQcpTKsxDkvohhWGHdPdiuyzfqeAgvR5X9eWPYHRSgOExXKrfsb1yFhEgWSUg6MhR9m
 EwPA05cF09jYzeDyudWja2QkjLUYtvbvuNP0tnL1JC9E7u0nI8ujF00WHg5j/Ui4Wafq8cCnIpe
 kE2eqTUF6whA5/i5FsrTR32/2WqnZKD66Hcqy2arwskMMoAvAq1WapfnrCqNolI7S14tV5ES8+7
 3RA2VGVjlHmoHhWaZHfoHYof7Wk1Gayl+5XWYJSfGSeAhqrwGKXPBVohwmCcHTGDKlfRaes70Yf
 +bLNSzO5vQhvMuNeWqmimoDO68H7rH750F8J7dw3TdAGpxTbttMe3+5oHzMDYSJIZwiww9UME/u
 uypqY1v8RKlXpQBs8zYpCB+8VU40t51P3jfApF9ckz0MqCLK0ZS633Y5ZWhZIGNITxj03MnKVPJ
 30ZRv7Lhpq0SI48iT0lJADNYxXCLPHz+LCGNIJh8YVD+Ba8M6sYmoXgnFODPEwQxe2DqI=
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

The new check also makes sure vm_bind range doesn't overflow the size of a
64-bit unsigned integer. That was already being done further down the call
stack inside drm_gpuvm_sm_map -> drm_gpuvm_range_valid, but it's best to
fail early in the driver before GPUVM functions are invoked so that we
won't waste time allocating vm_bind context resources.

Fixes: tag and reference the relevant sparse binding support commit.
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..910c8e579770 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -310,6 +310,9 @@ struct panthor_vm {
 		u64 end;
 	} kernel_auto_va;
 
+	/** @user_va_range: Upper boundary of VAs VM users can map objects against. */
+	u64 user_va_range;
+
 	/** @as: Address space related fields. */
 	struct {
 		/**
@@ -2893,6 +2896,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		va_range = full_va_range;
 	}
 
+	vm->user_va_range = kernel_va_start;
+
 	mutex_init(&vm->mm_lock);
 	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
 	vm->kernel_auto_va.start = auto_kernel_va_start;
@@ -2981,6 +2986,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
+	/* We don't allow mappings that overlap with kbo's reserved range */
+	if (range_overflows(op->va, op->size, vm->user_va_range))
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.55.0

