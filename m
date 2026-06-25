Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E99E4CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:02:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F0910F273;
	Thu, 25 Jun 2026 12:02:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RfxJxfGc";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 846B710F273
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:02:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 475E5440F8;
 Thu, 25 Jun 2026 12:02:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189F91F00A3A;
 Thu, 25 Jun 2026 12:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782388938;
 bh=K8q43MUbMciGYSCM6pecJXC9Q62aTtfjPzj3NVC1XiM=;
 h=From:To:Cc:Subject:Date;
 b=RfxJxfGc8Dr2YTuyv8e03Wa5JGYpaDXNnIqEDOT4Y6eQ8ridWy1NO8KMa+OTX+QdX
 4PFj5g890cc+9EiFg6yGgNKJ8IYFVZJQL5T07RVt+Qum1Q1jbW5RGGzq3b5jJ/RE+n
 dvF5i4rgfKaa8Q9PFo62A8UO7YQhCX+PUk+rDoPpaK0nI9WGDkP5GJPBp1ochskNJP
 EPlpGwYwzE8Q1/R2SP1wPnWeOLCJ4NSRnw9hmBUift71dTb+kLqZ/MltSxqEmdvLU0
 /srxhRbgrCvBFF48BOZLYM1VK5OE6nQa2XUZrRvZcr4s3mu76JBT+hqgDjmEzWHpBm
 Oi4KWWIgCLwmw==
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
Subject: [PATCH] drm/sched: Remove useless BUG_ON()
Date: Thu, 25 Jun 2026 14:01:52 +0200
Message-ID: <20260625120151.1757146-2-phasta@kernel.org>
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

BUG_ON() should not be used anymore since it crashes the entire kernel.
Its remaining usage is in drm_sched_job_arm() to check the entity
pointer. If that pointer is NULL, however, the problem will become
visible through a respective NULL pointer exception anyways.

There is no advantage in crashing the kernel as a whole.

Remove the BUG_ON().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/gpu/drm/scheduler/sched_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index d2ca01b31ee4..4e1b6e79ae19 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -637,7 +637,6 @@ void drm_sched_job_arm(struct drm_sched_job *job)
 	struct drm_gpu_scheduler *sched;
 	struct drm_sched_entity *entity = job->entity;
 
-	BUG_ON(!entity);
 	drm_sched_entity_select_rq(entity);
 	sched = container_of(entity->rq, typeof(*sched), rq);
 
-- 
2.54.0

