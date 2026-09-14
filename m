Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A62AC88E73
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 20:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4084110F217;
	Mon, 14 Sep 2026 20:25:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="HtRnEm46";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C943310F217;
 Mon, 14 Sep 2026 20:25:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Message-Id:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:From:Reply-To;
 bh=mJrts+4KNWw+Qpn1jq6RnZXLVwPNNYne7gXKHU9E03c=; b=HtRnEm46Q8JauGgpN6SYHjKGHv
 o/KFNChwDJwIfwaUcETfGJCbfYpjPk5lVUKfPhV/fBZEJbjHMTIyM6J/wGoCXq8omCtOhgpOIxW6s
 20vmRJnpeaiY0jyIqYE7g/0g9KQdL5b+P9qoski1/8CpaL1WhdBc9JQPoBKUIS0QD660m2MHiActg
 YA2k2yoR2egQ0lzEHAhitJTfGPKGT6QOCL8BwnHToJCuf0qhqsDfY1N1GPF1xVcZdMb0HoFz/FsT7
 xkCuSWT7XISr9yhaXb4rwddj9pwmoH9mvhGjIbNpCfefcC/5ATtCeWtJ6hUDdWCVASv7RqlpefrhE
 OH/OYrrQ==;
Received: from 179-125-70-185-dinamico.pombonet.net.br ([179.125.70.185]
 helo=[127.0.0.1]) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1x6DEy-00258e-6L; Mon, 14 Sep 2026 22:25:24 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Date: Mon, 14 Sep 2026 17:25:04 -0300
Subject: [PATCH 1/4] drm/amdgpu: make amdgpu_vm_sdma_commit handle NULL or
 empty job
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-amdgpu_vm_fixes-v1-1-d6d835591e0f@igalia.com>
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

When amdgpu_vm_update_range hits a failure at amdgpu_vm_ptes_update, it
will skip calling update_funcs commit, which might lead to a memory
leak.

Prepare the commit function to be called in such error paths, where job
might be NULL or empty.

This allows the following commits to prevent the job leak below in the
presence of such failures.

[ 2877.877264] kmemleak: unreferenced object 0xffff89b1f3cf0800 (size 1024):
[ 2877.877273] kmemleak:   comm "vm_always_valid", pid 3027, jiffies 4295714403
[ 2877.877275] kmemleak:   hex dump (first 32 bytes):
[ 2877.877277] kmemleak:     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
[ 2877.877279] kmemleak:     00 03 da 52 b1 89 ff ff 38 25 5f cb b1 89 ff ff  ...R....8%_.....
[ 2877.877280] kmemleak:   backtrace (crc d52b9041):
[ 2877.877282] kmemleak:     __kmalloc_noprof+0x4b3/0x770
[ 2877.877288] kmemleak:     amdgpu_job_alloc+0x69/0x280 [amdgpu]
[ 2877.877668] kmemleak:     amdgpu_job_alloc_with_ib+0x55/0xf0 [amdgpu]
[ 2877.878023] kmemleak:     amdgpu_vm_sdma_prepare+0x4b/0xa0 [amdgpu]
[ 2877.878350] kmemleak:     amdgpu_vm_update_range+0x24f/0x940 [amdgpu]
[ 2877.878668] kmemleak:     amdgpu_vm_clear_freed+0x13b/0x290 [amdgpu]
[ 2877.878983] kmemleak:     amdgpu_gem_object_close+0x1ac/0x270 [amdgpu]
[ 2877.879300] kmemleak:     drm_gem_object_release_handle+0x35/0xd0
[ 2877.879305] kmemleak:     idr_for_each+0x70/0xe0
[ 2877.879310] kmemleak:     drm_gem_release+0x23/0x30
[ 2877.879311] kmemleak:     drm_file_free+0x217/0x2a0
[ 2877.879314] kmemleak:     drm_release+0x61/0xe0
[ 2877.879317] kmemleak:     amdgpu_drm_release+0x62/0xd0 [amdgpu]
[ 2877.879630] kmemleak:     __fput+0xfb/0x2d0
[ 2877.879634] kmemleak:     __x64_sys_close+0x3d/0x80
[ 2877.879637] kmemleak:     do_syscall_64+0x12d/0x6c0

Fixes: 81417bea8755 ("drm/amdgpu: explicitly sync VM update to PDs/PTs")
Fixes: c3546695830e ("drm/amdgpu: use the new VM backend for PTEs")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340..975e26a48cd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -90,6 +90,7 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 	if (r) {
 		p->num_dw_left = 0;
 		amdgpu_job_free(p->job);
+		p->job = NULL;
 	}
 	return r;
 }
@@ -106,14 +107,24 @@ static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
 static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 				 struct dma_fence **fence)
 {
-	struct amdgpu_ib *ib = p->job->ibs;
+	struct amdgpu_ib *ib;
 	struct amdgpu_ring *ring;
 	struct dma_fence *f;
 
+	if (!p->job)
+		return 0;
+
+	ib = p->job->ibs;
+
+	if (ib->length_dw == 0) {
+		amdgpu_job_free(p->job);
+		p->job = NULL;
+		return 0;
+	}
+
 	ring = container_of(p->vm->delayed.rq->sched, struct amdgpu_ring,
 			    sched);
 
-	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
 
 	if (p->needs_flush)

-- 
2.47.3

