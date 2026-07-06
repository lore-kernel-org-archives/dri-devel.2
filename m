Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0FE9C43602
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BA4910E89A;
	Mon,  6 Jul 2026 10:16:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=pixelcluster.dev header.i=@pixelcluster.dev header.b="cHeSgi80";
	dkim-atps=neutral
Received: from smtpout6.mo534.mail-out.ovh.net
 (smtpout6.mo534.mail-out.ovh.net [54.36.140.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D86810E889
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 10:16:47 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net [51.255.22.22])
 by mo534.mail-out.ovh.net (Postfix) with ESMTPS id 4gv0SG4RP3z6JNt;
 Mon,  6 Jul 2026 10:08:46 +0000 (UTC)
Received: from director6.derp.mail-out.ovh.net
 (director6.derp.mail-out.ovh.net. [127.0.0.1])
 by director6.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
 for <alexander.deucher@amd.com>; Mon,  6 Jul 2026 10:08:46 +0000 (UTC)
Received: from mta6.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.188.61])
 by director6.derp.mail-out.ovh.net (Postfix) with ESMTPS id
 4gv0SG3D58z7tKd; Mon,  6 Jul 2026 10:08:46 +0000 (UTC)
Received: from pixelcluster.dev (unknown [10.1.6.11])
 (Authenticated sender: nat@pixelcluster.dev)
 by mta6.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 658228E1900; 
 Mon,  6 Jul 2026 10:08:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R00590834597-f52e-4f2b-b839-ae2bddae85b6,
 F224CF1D020274B13B21E639C91833BCDAC0997A) smtp.auth=nat@pixelcluster.dev
X-OVh-ClientIp: 88.133.252.134
From: Natalie Vock <nat@pixelcluster.dev>
Date: Mon, 06 Jul 2026 12:07:45 +0200
Subject: [PATCH v2 03/10] drm/ttm: remove ttm_lru_walk_ops
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260706-ttm_2_drm_exec-v2-3-4bf6bfc0d320@pixelcluster.dev>
References: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
In-Reply-To: <20260706-ttm_2_drm_exec-v2-0-4bf6bfc0d320@pixelcluster.dev>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Matthew Brost <matthew.brost@intel.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org
X-Mailer: b4 0.15.2
x-ovh-tracer-id: 9128233496850358588
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTF2rMupFDtSz5VGJXaGrwYUaRUbsc9Nn7nc8ghpwc35VyZFauYARogcas+VOSD8wf0IhZl41F2o83TSTJEqn1M70AEfTiU3uOfrR34AN46Y0JjeW4xo6cV+rH2TUD4SE1NDtof+377HjW5jUw1vYYddQq9f46CIv1pXDMg+OvLcv0mAeBq8idZd3/oeDOqFYW+mp/D/hf65ucF8pcrq4BoeAZT2yueghykMKcN1pOaBvVNRQXaTXALuE+8w2Owws5LoK70lx9jAX+i5vFCotZFddZWqe5L2MI0ywEcZRGnxLB/PRWCfMsAV61ff3CxEAEQBj4aCGHb8mrffVRaINrHzcRpKKoY7Gtf57EkJJ2EJ2On7AWz6HYmAqPwk0Ji9fkrtOutngurpFhVNgszUI/SLQtmkCdJMToQTjJW5Ju5ErW7FkPFXHDtcgHcOovBmnVMxv3QguXn8YjMgyBCx6jN7Uf65EiTwYZ/JUpTeM2g8Dj6r2JbJfEJPaFvQp3UUycCxIUVfE3LH2+kCvad2ao+ij+NXwb0S/jJpSM/dx5cmpikbkRhPGhAWiFROqgNsfB54ibFc9TJUCKzU3SMekKBxBCfKGwHO51GcwMCxNxIB8LimCZu4eqjnIA+CksDmmcor4vKUYJ7jvwMPGAZKJm6SfWexZqjVtmT6bLrBitMnLw
DKIM-Signature: a=rsa-sha256; bh=jmgO1VqoCmbZK7RpvAI9AVCGbRxKc/AL/4JQ8AkCTDk=; 
 c=relaxed/relaxed; d=pixelcluster.dev; h=From;
 s=ovhmo-selector-1; t=1783332526; v=1;
 b=cHeSgi801Q1TZkJKx1CF7btk76tysmEH+/ubEWnddIH1wZsMdu+KnRQu+E4XPEDuCC2KlHlY
 LODHMaswSF79Hm25kxtF9j9wPuO0NqDlvPSdfd8EIb6uEWg1qY2fmCD5cl337mzBQHfOKUBDm5n
 umubUhMTpE+tsvsMp6lBENKGb3Cq+01v1xm6XbjS2Yzk69zZ7g2PS+dK8/8Rz1aZRraMW5izgIL
 RC6HOih8gqkDBfuAB2y/LkYeV60QHe88u0v4iISTe73TMkaLT3rrn+atRco3vwQCrg0ZWPrr4vQ
 N22CXcfw9oNvVjUNtj6OgCt2ywC21pS1NBbCk+5fAjGTg==
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

It's just another layer of indirection.

Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/ttm/ttm_bo.c      | 12 ++----------
 drivers/gpu/drm/ttm/ttm_bo_util.c |  2 +-
 include/drm/ttm/ttm_bo.h          | 34 ++++++++++++++--------------------
 3 files changed, 17 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 2b470c1746f60..1fb8c53da0362 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -545,10 +545,6 @@ static s64 ttm_bo_evict_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *
 	return lret;
 }
 
-static const struct ttm_lru_walk_ops ttm_evict_walk_ops = {
-	.process_bo = ttm_bo_evict_cb,
-};
-
 static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 			      struct ttm_resource_manager *man,
 			      const struct ttm_place *place,
@@ -560,7 +556,7 @@ static int ttm_bo_evict_alloc(struct ttm_device *bdev,
 {
 	struct ttm_bo_evict_walk evict_walk = {
 		.walk = {
-			.ops = &ttm_evict_walk_ops,
+			.process_bo = ttm_bo_evict_cb,
 			.arg = {
 				.ctx = ctx,
 				.ticket = ticket,
@@ -1187,10 +1183,6 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 	return ret;
 }
 
-const struct ttm_lru_walk_ops ttm_swap_ops = {
-	.process_bo = ttm_bo_swapout_cb,
-};
-
 /**
  * ttm_bo_swapout() - Swap out buffer objects on the LRU list to shmem.
  * @bdev: The ttm device.
@@ -1209,7 +1201,7 @@ s64 ttm_bo_swapout(struct ttm_device *bdev, struct ttm_operation_ctx *ctx,
 {
 	struct ttm_bo_swapout_walk swapout_walk = {
 		.walk = {
-			.ops = &ttm_swap_ops,
+			.process_bo = ttm_bo_swapout_cb,
 			.arg = {
 				.ctx = ctx,
 				.trylock_only = true,
diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 7ed085adf1c9b..29f068944a972 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -919,7 +919,7 @@ s64 ttm_lru_walk_for_evict(struct ttm_lru_walk *walk, struct ttm_device *bdev,
 	s64 lret;
 
 	ttm_bo_lru_for_each_reserved_guarded(&cursor, man, &walk->arg, bo) {
-		lret = walk->ops->process_bo(walk, bo);
+		lret = walk->process_bo(walk, bo);
 		if (lret == -EBUSY || lret == -EALREADY)
 			lret = 0;
 		progress = (lret < 0) ? lret : progress + lret;
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 1eae9eea5ff32..0fcd5082a7080 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -189,24 +189,6 @@ struct ttm_operation_ctx {
 	uint64_t bytes_moved;
 };
 
-struct ttm_lru_walk;
-
-/** struct ttm_lru_walk_ops - Operations for a LRU walk. */
-struct ttm_lru_walk_ops {
-	/**
-	 * process_bo - Process this bo.
-	 * @walk: struct ttm_lru_walk describing the walk.
-	 * @bo: A locked and referenced buffer object.
-	 *
-	 * Return: Negative error code on error, User-defined positive value
-	 * (typically, but not always, size of the processed bo) on success.
-	 * On success, the returned values are summed by the walk and the
-	 * walk exits when its target is met.
-	 * 0 also indicates success, -EBUSY means this bo was skipped.
-	 */
-	s64 (*process_bo)(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo);
-};
-
 /**
  * struct ttm_lru_walk_arg - Common part for the variants of BO LRU walk.
  */
@@ -223,8 +205,20 @@ struct ttm_lru_walk_arg {
  * struct ttm_lru_walk - Structure describing a LRU walk.
  */
 struct ttm_lru_walk {
-	/** @ops: Pointer to the ops structure. */
-	const struct ttm_lru_walk_ops *ops;
+	/**
+	 * process_bo - Process this bo.
+	 * @walk: struct ttm_lru_walk describing the walk.
+	 * @bo: A locked and referenced buffer object.
+	 *
+	 * Return: Negative error code on error, User-defined positive value
+	 * (typically, but not always, size of the processed bo) on success.
+	 * On success, the returned values are summed by the walk and the
+	 * walk exits when its target is met.
+	 * 0 also indicates success, -EBUSY means this bo was skipped.
+	 */
+	s64 (*process_bo)(struct ttm_lru_walk *walk,
+			  struct ttm_buffer_object *bo);
+
 	/** @arg: Common bo LRU walk arguments. */
 	struct ttm_lru_walk_arg arg;
 };

-- 
2.55.0

