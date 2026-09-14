Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 829CDC88E6F
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:25:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7340610F21A;
	Mon, 14 Sep 2026 20:25:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="nh/J8ebe";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FC810F219;
 Mon, 14 Sep 2026 20:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=Af9lUnji9Dgkx9n4RYwhC9wo0UQzLfqlZc4AcIOYIqM=; b=nh/J8ebezpdS6zXOFy/CNmWUWq
 ljy2TEyhvnXBpIgzEVqS47OCjURJk2iAQmTzYZdtXH8rRVzrUVYO05TCCNniBMfI5oRQlZ8YuFn09
 keihKYS9vUQEvvJNCJ2zQOrwJZnOndUE/v1JQYJwtEOui5OKeRNeTYe6vzoE+PrgfW2xBFgnXrL7Y
 fw3zOH6Roz1vbz7VinGg3OVFmPJgMieL6lgkWtcF6a9y1wVMeJtAAj7g7BnK35mvBQB3ygohdnZWi
 X007T7j9nsBxSHZ16bH0Ceh9iX/Iyp0Q8PnanJUFCJBzgHZeeCy+OImFmBnYVvJQ9SsiGlCEwhWAt
 oc2DbSQw==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6DF6-00258e-MS; Mon, 14 Sep 2026 22:25:32 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 14 Sep 2026 17:25:06 -0300
Subject: [PATCH 3/4] drm/amdgpu: don't free mapping when
 amdgpu_vm_update_range fails
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-amdgpu_vm_fixes-v1-3-d6d835591e0f@igalia.com>
References: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
In-Reply-To: <20260914-amdgpu_vm_fixes-v1-0-d6d835591e0f@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Felix Kuehling <Felix.Kuehling@amd.com>, 
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>, 
 Shashank Sharma <shashank.sharma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, 
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>, kernel-dev@igalia.com, 
 Natalie Vock <nat@pixelcluster.dev>
X-Mailer: b4 0.16-dev-62088
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

If amdgpu_vm_update_range fails when called by amdgpu_vm_clear_freed,
the clearing of that mapping will not be attempted again. Later on, when
an IB tries to read that mapping, the read succeeds, leading to a
potential info leak, or even data corruption, if it attempts to write to
it.

If the mapping is left in the freed list, then clearing will be
attempted again during amdgpu_cs_ioctl, which will either fail and not
submit the job or will succeed in clearing the mapping, preventing the
invalid access.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 09037df76400..5bde36754607 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1594,16 +1594,16 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 	while (!list_empty(&vm->freed)) {
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
-		list_del(&mapping->list);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
-		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
 			goto error_free;
 		}
+		list_del(&mapping->list);
+		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 	}
 
 	if (fence && f) {

-- 
2.47.3

