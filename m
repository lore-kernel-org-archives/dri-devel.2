Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C52CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C6810E1B8;
	Thu, 25 Jun 2026 09:36:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="quKBCrF8";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8808410E1B2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380189;
 bh=+q2NlCVkHE6DdKqspINdYYOn4PX1J+qSuG77S9jRzgE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=quKBCrF82Yf5pGo2U/zbJ9ePX/OpjIrmHCX+LxCxPmRuUdMatoXqI6c20WTcostJ8
 7GY15fpizUdKCU0akGfLVmuP4w7fphlx1MMnM9JQlsAina7Xmn+rmpw2EVnZDU4PA/
 h3+XXhZDtWl8WG/VzmpeVKL+6U+wUqpIA1oINvSZykMArrG7xuIdqjUsOQEbP1CsZ0
 E1llvgngoYQPJH0il98eSFROY/6H+nGSc1r8scrbzEaP1ysjKMNtkSOH/eAb8H6/26
 Q9e2lTVv29jsqdVzejqTd1rd8wdGFRNYpcogVb1jn+OsO/Pjy4YTXi5gm07Ou/5apK
 6827mfjV481Ug==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C66B317E027B;
 Thu, 25 Jun 2026 11:36:28 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:17 +0200
Subject: [PATCH v5 02/16] drm/panthor: Don't overrule pending immediate
 ticks in sched_resume_tick()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-2-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=1771;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=+q2NlCVkHE6DdKqspINdYYOn4PX1J+qSuG77S9jRzgE=;
 b=gW75tCC9xP6QBkIxRZc0oKMoE0UJGQnc8RH/5oRWdbyDuUJtVBGCAJCdCbw3n0K5+JbSg/P4p
 8gD0gu9NmPODpt2EGBKjsrj0gxVDQkPjutyFwZMIOmnB+6J/z6EPY8q
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

We schedule immediate ticks when we need to process events on CSGs,
but those immediate ticks don't change the resched_target because we
want the other groups to stay scheduled for the remaining of the GPU
timeslot they were given. Make sure these immediate ticks don't get
overruled by a sched_queue_delayed_work() that would delay the tick
execution.

Fixes: 99820b4b7e50 ("drm/panthor: Make sure we resume the tick when new jobs are submitted")
Reported-by: sashiko-bot@kernel.org
Closes: https://sashiko.dev/#/patchset/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com?part=9
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5b34032deff8..1913bc8a6297 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2668,7 +2668,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
 	else
 		delay_jiffies = 0;
 
-	sched_queue_delayed_work(sched, tick, delay_jiffies);
+	/* We schedule immediate ticks when we need to process events on CSGs,
+	 * but those don't change the resched_target because we want the other
+	 * groups to stay scheduled for the remaining of the GPU timeslot they
+	 * were given. Make sure those immediate ticks don't get overruled by
+	 * a sched_queue_delayed_work() that would delay the tick execution.
+	 */
+	if (!delayed_work_pending(&sched->tick_work))
+		sched_queue_delayed_work(sched, tick, delay_jiffies);
 }
 
 static void group_schedule_locked(struct panthor_group *group, u32 queue_mask)

-- 
2.54.0

