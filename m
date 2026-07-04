Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E2DC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 04:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE7D110E00D;
	Sat,  4 Jul 2026 04:47:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="k9ONpq/9";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E95810E00D
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 04:47:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783140426; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=S32IRAHnbaHUpthUvxbyur+wtmfVC8CU0yhQXjvXcJAl4MRkEBy7Y6acacmfdpB0e6kwQUWm+fdNfKVQN/2VKheHzJNnpvjKBs7IRMSs9bpXodE6AQEmJboQQCilVTAFAOPM9yrqxTFBYWp+MqRfnqFjBYuvVfOAjxGlTwiu9Qc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783140426;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=pvylX0U8iDrR/3+OZcNJ2A69JS13Y+9iVvuYUrG5uX4=; 
 b=a3n9tA7cR7DEiw1nMjF7TsPAPnpEkPNgrGMRwM+AsK9/5jFpw1NWzWRxIaeRc8vj9Rz4AtLfT7nF+9xdKXsdbXQa65sncrUcnMY+fJ//jyM8qax5/R3THiup6HH1t182Lhez9PpRlAT+uprbbax4hAs0RhbvelVMKFAgfnlwd58=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783140426; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=pvylX0U8iDrR/3+OZcNJ2A69JS13Y+9iVvuYUrG5uX4=;
 b=k9ONpq/9BRPIfq2Ok9XmfAoYuR1nUzHGnU+0wX2bWjMSxgICCR8s9su+XvOaXENw
 Sg4Nl3eIrQthbKhKTMSYv1bEXnmgFAOyzBHoEVkY3Eu67U/HIxOwKgkMAfyYQiLJGKU
 QW5bdAqN+GUOAwHmGfHGpOVQoOssMOowPcsck7pU=
Received: by mx.zohomail.com with SMTPS id 1783140424501839.3470693292096;
 Fri, 3 Jul 2026 21:47:04 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Sat, 04 Jul 2026 05:46:44 +0100
Subject: [PATCH v4 1/3] drm/panthor: Check for sparse binding range
 overflow
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260704-vm_bind_checks-v4-1-4705b6ca9f8a@collabora.com>
References: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
In-Reply-To: <20260704-vm_bind_checks-v4-0-4705b6ca9f8a@collabora.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1389;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=hex+1ndtyloKE61jMSJQjlILjaZhjyPu5Wi+5IFsGc4=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqSJA/S5oTtuuHGzngXEN0v/ZQbzI7IKvsFB/G9
 DoXo9yKUaCJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCakiQPwAKCRAOJn5M7lND
 PfQZC/9kNeAS1zfdDccSckd6YG5MB+sQoOJ0nfQm5GQyKe2s5/yT4efTBGOFiH4ccSzr7u0TjhZ
 xHL2DEikhZPY4p65o0JdOmCP3pFX0FiTMFe6tvdl0yWZfR+xqeOrNAzTpcuk8OHDXjwnThjcyPl
 DJgO0+B9sIiTOIQ92G370TV2Xg3ngFAFYFNuzxtzIwNiEf3eYGih0TXdzoGLO2S89OFwUQAEi/5
 wIZmY8uOoR1v+kOUgYvhmWt17q0XYmo7OfJdoq8wGElU77hNTCH0uCIC3+OMw+fahr0emmwtwlV
 hFy9OjxQnl42Py0IJNhNSwtZhI3bahbGvTBE15EOMzvgjfrf9POgF7ExieTcqUBN+0Sb1YBBzVL
 Y55H81Z6EMDPgFPHbmReRtR2eCvoEsWpdC6c5HJDksa+jD3q6aGOQ8tGdcPHjuOloX1bHSPCj9F
 +ml+/42UM1pDiBtU4CusNqwT9EWTUHJWy+WQOppMSQNrmiHgBoQePCMpFcBp+AmlnvTMQ=
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
 drivers/gpu/drm/panthor/panthor_mmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 31cc57029c12..163231c1703d 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2975,12 +2975,16 @@ panthor_vm_bind_prepare_op_ctx(struct drm_file *file,
 {
 	ssize_t vm_pgsz = panthor_vm_page_size(vm);
 	struct drm_gem_object *gem;
+	u64 end;
 	int ret;
 
 	/* Aligned on page size. */
 	if (!IS_ALIGNED(op->va | op->size | op->bo_offset, vm_pgsz))
 		return -EINVAL;
 
+	if (check_add_overflow(op->va, op->size, &end))
+		return -EINVAL;
+
 	switch (op->flags & DRM_PANTHOR_VM_BIND_OP_TYPE_MASK) {
 	case DRM_PANTHOR_VM_BIND_OP_TYPE_MAP:
 		if (!(op->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE)) {

-- 
2.55.0

