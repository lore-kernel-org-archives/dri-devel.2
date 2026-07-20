Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61A70C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B98C10E9A7;
	Mon, 20 Jul 2026 15:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="RIYukpdJ";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84DE310E722
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:48:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784562531; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VxbXTDWqtLfqiQtqBlubt4XnCopUE+V5aTsSyCqPBgdvhaA3LGtOrUD1uldGDfWTWOega+/PIzyLxvePyKc9/2wWf+lEOJipcATuMN77K9aFoKyUlXH016g0LEZYWWT/N80KHSsUzBE5ldQI8tSaugS/pQKeRU/jCov0tW8NcGg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784562531;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=lfOQExG+pWpqKpUyT8tIp7HtPn3wTEAIKqC8QWwsWfc=; 
 b=E6hJzbtKM78DdZUCjC9vAyxhYJQN7Tf6WWB4Qk5rAyxy20inwAPbUyeRg2tlSwooBOMZEVdaDlyRa5jWqKCUlnmDcs81bXkH7LhXGGQaRzjTdQEn/bgtJ9fUiymj4kMexhMHmAk/0vUbutVpAnLX7I1iprbxZKWHwA/ksZotm4U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784562531; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=lfOQExG+pWpqKpUyT8tIp7HtPn3wTEAIKqC8QWwsWfc=;
 b=RIYukpdJnCpCvwwoC2ffQFIbEyHDPVIYrKDTe4p+IBWqpdyuruZ8eiOcXk2X6acZ
 2RZzQth1pSnG1DF6UmU5hQzqRxx+sF6b59ck+Fja/6uaogwgIsMWqPZ0OBOj1fcGiXO
 p7SZAtNdUKTPjrddhWvhcF111bNDQO9q62jw46ao=
Received: by mx.zohomail.com with SMTPS id 1784562530366863.8435403310522;
 Mon, 20 Jul 2026 08:48:50 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 20 Jul 2026 16:48:41 +0100
Subject: [PATCH v6 1/2] drm/panthor: Add vm_bind region with kbo range
 overlap check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260720-vm_bind_checks-v6-1-c2c7dbe93a73@collabora.com>
References: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
In-Reply-To: <20260720-vm_bind_checks-v6-0-c2c7dbe93a73@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Heiko Stuebner <heiko@sntech.de>, Grant Likely <grant.likely@linaro.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2612;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=CWtceF5JvQfD4PazGjk1qh7kuH5YsnRgp3BI3bGLMPo=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqXkNZmETPi3n0ge8z5caZkBASXvPRYgCo9jnWD
 UFiCLRc/yKJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCal5DWQAKCRAOJn5M7lND
 PcHLC/9MWUo284cxeYwqtpQXZ9tPyiPF4GJp8Qj4k04XLFGkE9BWfzRVjDyGo9z4203iaRIEf2E
 4UGzNBMJ5YpmanjD/j5zNvwB7HiRo527KiE29hOKjMK+wuYSB0WdCgz0TX5Rl0JaLbQUzO+yiPa
 BkoJT7Vf+cd9QOzbuhIlLDMr2ArYpFiznZT3t+IkqQqeb1GKXRVqlKS1ytyvEGWReuDdT7LjaMm
 2uxtimlDdlOR2qxGTFmsameWGCY8J8Y4mn5cvHiVfPUlYb4huo0+WW3hs+UhgwH/rShvpQtXt0K
 LhuUZCLElxxz4CBMCvnxUWRJEN48QMDfKn5viaSKnOTPmsJrXMTnBFcQBgZ0k9HS79NiH9Ya5tl
 gtt+ceKJkM/r/JsQ/Dc7GFowgOswpbtqPWDNTg8c9mVLgHUdF0d2vcHaHsbJxpeeNew3RbijBhw
 bcMGwPHFuNM+2qb2TtFDRkbhNZzDJMBqVTtFEt+KXlrFvBTGDh4Qb9Jeyp6luixbtTj+Y=
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

Fixes: 12cf826bf1dd ("drm/panthor: Support sparse mappings")
Fixes: 647810ec2476 ("drm/panthor: Add the MMU/VM logical block")
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index f45ef5824ff2..80a1dac40a6a 100644
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
@@ -2892,6 +2895,8 @@ panthor_vm_create(struct panthor_device *ptdev, bool for_mcu,
 		va_range = full_va_range;
 	}
 
+	vm->user_va_range = kernel_va_start;
+
 	mutex_init(&vm->mm_lock);
 	drm_mm_init(&vm->mm, kernel_va_start, kernel_va_size);
 	vm->kernel_auto_va.start = auto_kernel_va_start;
@@ -2980,6 +2985,10 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
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

