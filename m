Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C8CC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 10:40:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D515810E80B;
	Mon, 29 Jun 2026 10:40:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j8k6dQtW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE1F10E80B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:40:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1291B4376D;
 Mon, 29 Jun 2026 10:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25471F000E9;
 Mon, 29 Jun 2026 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782729648;
 bh=e4CJr+Rttc5tORlmqCxSyqpExr+08QeOgr/xICyMK2o=;
 h=From:To:Cc:Subject:Date;
 b=j8k6dQtW9tSFlSk3+dfOauWTBKYOkxlc+Vxt/L3EVerOP1ADLVqgxVmC1hu7LyntJ
 OML74/3SDJvikAsMK8DB4CTQiVJLl4z+YhHWAJE0N4DcwD+orBTBXi/95ISs6+9uEO
 Kk/oxnUp59SQNXnX8DrMp0mvJAuJaRAwLEsRsx8vcVJwZThUhHnHIKczXwrTaEdHcO
 kMoyVMV/WFW51jwPSz41tssW0HxrM2xkYbyKR9+BLm7Zz0J6PzqbbJEjAzwdMwB1MF
 GeZYXSSuQaGG0h+yd43JR8knxCPsUiE22E0wdYn9EktFDxKquPa+n0ZmnwHzp0+wxF
 NbhA3OS5s+YZw==
From: Philipp Stanner <phasta@kernel.org>
To: Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] drm/sched: Guard sched->ready with ACCESS_ONCE()
Date: Mon, 29 Jun 2026 12:40:40 +0200
Message-ID: <20260629104040.2695163-2-phasta@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

commit faf6e1a87e07 ("drm/sched: Add boolean to mark if sched is ready to work v5")

moved tracking of the hardware ring's state from the driver (amdgpu in
that case) into drm_sched. To do so, it added a 'ready' flag to the
scheduler.

This flag is currently being accessed through drm_sched_wqueue_ready()
and, even worse, directly through the scheduler struct. Since drm_sched
does not have a consistent locking design, all these accesses are
potentially undefined behavior as they are subject to compiler
optimizations.

Make the code base more robust by guarding access to the 'ready' flag
with ACCESS_ONCE().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..c4e4ac436a86 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -929,7 +929,7 @@ drm_sched_pick_best(struct drm_gpu_scheduler **sched_list,
 	for (i = 0; i < num_sched_list; ++i) {
 		sched = sched_list[i];
 
-		if (!sched->ready) {
+		if (!READ_ONCE(sched->ready)) {
 			DRM_WARN("scheduler %s is not ready, skipping",
 				 sched->name);
 			continue;
@@ -1143,7 +1143,18 @@ void drm_sched_fini(struct drm_gpu_scheduler *sched)
 
 	if (sched->own_submit_wq)
 		destroy_workqueue(sched->submit_wq);
-	sched->ready = false;
+
+	/* The 'ready' flag only exists in drm_sched because amdgpu uses it to
+	 * represent the state of its hardware rings. This problem is related to
+	 * the fundamental issue of drm_sched not having a solid, consistent
+	 * locking design.
+	 *
+	 * Obviously, it does not make sense at all to set this flag to false
+	 * here, but since it's unclear whether it can ever be removed from
+	 * amdgpu's point of view, we guard it here with WRITE_ONCE() to make it
+	 * slightly less broken.
+	 */
+	WRITE_ONCE(sched->ready, false);
 
 	if (!list_empty(&sched->pending_list))
 		dev_warn(sched->dev, "Tearing down scheduler while jobs are pending!\n");
@@ -1195,7 +1206,7 @@ EXPORT_SYMBOL(drm_sched_increase_karma);
  */
 bool drm_sched_wqueue_ready(struct drm_gpu_scheduler *sched)
 {
-	return sched->ready;
+	return READ_ONCE(sched->ready);
 }
 EXPORT_SYMBOL(drm_sched_wqueue_ready);
 

base-commit: 6648301c5bb2ef23f0fb15bcb01d21ff66f36799
-- 
2.54.0

