Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6185DC5B572
	for <dri-devel@archiver.kernel.org>; Sun, 16 Aug 2026 16:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D75210E2D6;
	Sun, 16 Aug 2026 16:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DlTLP4xQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5396510E2D6;
 Sun, 16 Aug 2026 16:11:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 226DA438D5;
 Sun, 16 Aug 2026 16:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0FD2C2BCFB;
 Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1786896683;
 bh=EyX93B7kBk3Vm+nJOx08mFmucBcQdi1SaFFZ9cZpeRE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=DlTLP4xQxDaw/7LDYclMUkOWrHnv0kLj/VzzxvOe0z8J0DER0ia7suJBGq6zv5CFP
 mO5BBKJAnw4dCYD8JRFtBespny4VMfdOAUDS71bQtX2u6ktE3WOd82IiYzXcDT2DAS
 xh+LYuQU2LkdT4O2b4zUC0FVTM5/CRjbpx5A4tHDrZtmLdRFKgYOpQEr1OIjIKj9+1
 rg70st5XSPeW0eatZGIvSHwk6yDJ6DzzGJSnOE7yBTvTRUSUEcPLS6WoLeLljbmVmb
 szKV1alWhfXg6b24zC/DblAtxS8OFhjNzaFxnPBlm1KMg0ZCKCvcoWRGTPutF7RcCr
 niCya8hy5NyXA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D7057C5DF6D;
 Sun, 16 Aug 2026 16:11:22 +0000 (UTC)
From: Junrui Luo via B4 Relay <devnull+moonafterrain.outlook.com@kernel.org>
Date: Mon, 17 Aug 2026 00:11:19 +0800
Subject: [PATCH 2/2] drm/amdgpu/userq: hold the doorbell xa lock during
 hang reset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-amdgpu-fixes-v1-2-36d5298da646@outlook.com>
References: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
In-Reply-To: <20260817-amdgpu-fixes-v1-0-36d5298da646@outlook.com>
To: Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Sunil Khatri <sunil.khatri@amd.com>, 
 "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, Junrui Luo <moonafterrain@outlook.com>, 
 Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3319;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=y3B8NHJuJxaEL+O3aaSutDQSpiooXLOV9M+cF0KhZRE=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGrMaHmvNWpKcX1nM8XNVawd7doT7RlVv6wqme30Ilo
 jlGYcvmdHeUsjCIcTHIiimyHC+49M3Cd4vuFp8tyTBzWJlAhjBwcQrARFItGBkOztW8c91v7x2W
 cIvJzO7cPNOCptfkGXTfdGKoLZqYw2rPyHBF7uXXn4bvj0XOvyd+q8tr98VTyVVRKfP/r9VlN2I
 +WcoKAI5PR9I=
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-Endpoint-Received: by B4 Relay for moonafterrain@outlook.com/default with
 auth_id=909
X-Original-From: Junrui Luo <moonafterrain@outlook.com>
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
Reply-To: moonafterrain@outlook.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Junrui Luo <moonafterrain@outlook.com>

mes_userq_detect_and_reset() walks adev->userq_doorbell_xa with a bare
xa_for_each() and dereferences every entry: it reads queue->queue_type
and queue->doorbell_index, writes queue->state, and passes the queue to
amdgpu_userq_fence_driver_force_completion().  That xarray is device
wide, so most entries belong to other drm_files.

Nothing keeps those queues alive for the walk.  The caller,
amdgpu_userq_mgr_reset_work(), holds no lock, and amdgpu_mes_lock() is
dropped before the walk begins.  Meanwhile amdgpu_userq_destroy() erases
the doorbell entry via amdgpu_userq_cleanup() and kfree()s the queue
after dropping its own uq_mgr->userq_mutex; that per-file mutex cannot
cover another file's queue.  xa_for_each() releases its internal RCU read
lock before returning each entry, so the pointer can already be dangling
when the loop body touches it.

Fix by holding xa_lock_irqsave() across the walk, as
amdgpu_userq_process_fence_irq() and amdgpu_userq_mgr_cancel_reset_work()
already do.

Fixes: 54d18bc6003f ("drm/amdgpu/userq: add a detect and reset callback")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Assisted-by: Claude:claude-opus-5
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
Found by code inspection; not tested on hardware.
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 4e44a581a78a..f4d12e4b2d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -208,7 +208,7 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	struct mes_detect_and_reset_queue_input input;
 	struct amdgpu_usermode_queue *queue;
 	unsigned int hung_db_num = 0;
-	unsigned long queue_id;
+	unsigned long queue_id, flags;
 	u32 db_array[8];
 	bool found_hung_queue = false;
 	int r, i;
@@ -230,6 +230,13 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 	if (r) {
 		dev_err(adev->dev, "Failed to detect and reset queues, err (%d)\n", r);
 	} else if (hung_db_num) {
+		/*
+		 * The doorbell xarray is device wide, so this walks queues
+		 * owned by other drm_files too. Hold its lock: the free path
+		 * erases the entry under the same lock strictly before it
+		 * frees the queue, so an entry found here stays allocated.
+		 */
+		xa_lock_irqsave(&adev->userq_doorbell_xa, flags);
 		xa_for_each(&adev->userq_doorbell_xa, queue_id, queue) {
 			if (queue->queue_type == queue_type) {
 				for (i = 0; i < hung_db_num; i++) {
@@ -238,14 +245,16 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
 						found_hung_queue = true;
 						atomic_inc(&adev->gpu_reset_counter);
 						amdgpu_userq_fence_driver_force_completion(queue);
-						drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
 					}
 				}
 			}
 		}
+		xa_unlock_irqrestore(&adev->userq_doorbell_xa, flags);
 	}
 
 	if (found_hung_queue) {
+		drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE, NULL);
+
 		/* Resume scheduling after hang recovery */
 		r = amdgpu_mes_resume(adev, input.xcc_id);
 	}

-- 
2.51.2


