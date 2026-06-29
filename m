Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481AEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 20:17:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A942C10E11B;
	Mon, 29 Jun 2026 20:17:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Yw4a7qDI";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A74710E113
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 20:17:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1782764237; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FD+W8bHx6p2I4J8c/+xzTuLr3pA3p9skJXA1mXspMh2ZwgJClD9RKuZSu9hpKeGMc63RMgy7kAFCzxSU0yR1YhPrUACtMd732Dd8558NgM7r8qFt6YU2IWVennZ0IlzReK3RlqtglhulSCyuNbCrXTOVqsOfZY6ElOeULlb4VzI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1782764237;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bTlU1o1C+8ICOwb8d5fnxhmOk1sXncLKEWjHHsur1M0=; 
 b=Xc5cuPHwEcdrZIt/Y264ZdefQuYqAAHtW5PszKHLeVduKVoRE6uftiWxcbouKjSmcGA9SFEEkqu5EMK+yskXjJPsVtmFKzUdWEesWp8HEfjTydSdTKs5DBXFsEZVkDcHaI268yBHKEyuBJNlB31nRA7ZjBgnNJZZBl9sYKoSmUE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1782764237; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=bTlU1o1C+8ICOwb8d5fnxhmOk1sXncLKEWjHHsur1M0=;
 b=Yw4a7qDIRp+X4YB6AebGrKv+sBJRaV8/zd/LykoVRhwqdx08UJQ0GfmLmFZ2P73J
 p3h3JnFBNansdTBIGgH1IR7IHW3IQ8G2nq6i0txx4G6qr1YJa5bXoxDJ4NG/F5T5ljd
 V/5Pk3TlBhezFQAaYvimeoAnTMi4wDJ3Xgxma5mQ=
Received: by mx.zohomail.com with SMTPS id 1782764235389579.3079032521514;
 Mon, 29 Jun 2026 13:17:15 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 29 Jun 2026 21:17:05 +0100
Subject: [PATCH v3 1/4] drm/panthor: Add vm_bind region with kbo range
 overlap check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260629-vm_bind_checks-v3-1-85e6740f6c2e@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2249;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=zKQ6JRfXr3K84E8hapDCWxUaonecc8V2ju4X+F4Stkc=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqQtLC07BZ3sZWI6q0bOcuH8geBQ44rfUp22Muc
 KbVefeYXSeJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakLSwgAKCRAOJn5M7lND
 PXj3DACRCnrwYzNYwkc8UUR79yGOrpjfMQuoo28n0VWOGt4Y4OSAnqJ7VUrVx4BiZrX++8bSbhC
 93N+c1kb8sUYXQH5lhb4lAr07KksCbjm5/zH6N/O+k4royfgq3EHieEeV6M9CTHV8UsfshV3g+Q
 OMg40CqxfiAKQwOpV073ph7I7G7y4aTZlrdzvlkIK0mxuKM/KqiIa17t0jdVBMDdF5bQ6bidRiz
 i7ueZn4uW/NU+V8xWSk3BOW+A6FfrjCPuDKWO5jztT8iBbuUds3SN/aIBbbRn2dFio+nINI3BkK
 CJmtbc7eGgDxJgfoSaS0l0K7q2gr8RfQJpKlHcCaewSs4OS1QP4pL/XWQ3sEg0cKyzuq6Dd1TQC
 uoBC/Mejrlw3iIlcJtp0KSm+XWWBp4EbLkirSSFRfpQshelzhJC+XX53kIXhFJJN9SEFnMsvmSe
 0ZzGvVSkGVp37DK01k7j7p+UjFYaUezUyjJJaJGTBJPXJAA+imcckWVYBpUBtLfHm0ujU=
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

Fixes: tag and reference the relevant sparse binding support commit.
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..94789777aac4 100644
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
+	if (op->va + op->size > vm->user_va_range)
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.54.0

