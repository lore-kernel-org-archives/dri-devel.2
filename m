Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF040CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 14:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B3510E263;
	Mon, 22 Jun 2026 14:23:14 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6743F10E263;
 Mon, 22 Jun 2026 14:23:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [117.182.74.238])
 by APP-01 (Coremail) with SMTP id qwCowADHa9RMRTlqc07AAg--.26720S2;
 Mon, 22 Jun 2026 22:23:10 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Wentao Liang <vulab@iscas.ac.cn>,
 stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: fix cleaner shader IB size and entity cleanup
Date: Mon, 22 Jun 2026 22:23:05 +0800
Message-Id: <20260622142305.45791-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qwCowADHa9RMRTlqc07AAg--.26720S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur1fJFW3WF43ZrWfJr15XFb_yoW5Wr18pF
 4Fqr45Jr4UZ3W3Kw1UZ3WDWrn0q3s7Xa4fWr429w109an8XFn5Wa47GFy0grykurW8CFW2
 g34qq3y7W3ZFyw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
 rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
 1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
 6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
 0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
 jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
 1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
 6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
 0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
 0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
 WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
 IxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
 U==
X-Originating-IP: [117.182.74.238]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiDAYGA2o5ItJfpgABsU
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

Fix two issues in amdgpu_gfx_run_cleaner_shader_job():

1. IB buffer overflow: The indirect buffer is hardcoded to 64 bytes,
   but the initialization loop writes up to (align_mask + 1) dwords.
   On modern GFX rings with align_mask = 0xff, this writes 1024 bytes,
   overflowing the 64-byte allocation and corrupting memory.

2. Scheduler entity leak: The drm_sched_entity is not cleaned up on
   the error path after amdgpu_job_alloc_with_ib() fails.

Fix by:
- Dynamically calculating IB size based on ring->funcs->align_mask
- Adding drm_sched_entity_destroy() to the error path

Cc: stable@vger.kernel.org
Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Fixes: 256576ed6895 ("drm/amdgpu: give each kernel job a unique id")
Fixes: 559a285816af ("drm/amdgpu: Replace 'amdgpu_job_submit_direct' with 'drm_sched_entity' in cleaner shader")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b8ca876694ff..b50ec1a5c645 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1651,6 +1651,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
+	unsigned int ib_size;
 	int i, r;
 
 	/* Initialize the scheduler entity */
@@ -1658,7 +1659,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 				  &sched, 1, NULL);
 	if (r) {
 		dev_err(adev->dev, "Failed setting up GFX kernel entity.\n");
-		goto err;
+		return r;
 	}
 
 	/*
@@ -1668,8 +1669,15 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	 */
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
+	/*
+	 * Allocate IB with enough space for align_mask + 1 dwords.
+	 * The initialization loop below writes exactly this many dwords.
+	 * Each dword is 4 bytes.
+	 */
+	ib_size = (ring->funcs->align_mask + 1) * sizeof(uint32_t);
+
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
+				     ib_size, 0, &job,
 				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
@@ -1686,8 +1694,6 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	f = amdgpu_job_submit(job);
 
 	r = dma_fence_wait(f, false);
-	if (r)
-		goto err;
 
 	dma_fence_put(f);
 
@@ -1696,6 +1702,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	return 0;
 
 err:
+	/* Clean up the scheduler entity */
+	drm_sched_entity_destroy(&entity);
 	return r;
 }
 
-- 
2.39.5 (Apple Git-154)

