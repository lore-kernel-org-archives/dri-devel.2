Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9E99CDE00B
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1ABE10F29B;
	Thu, 25 Jun 2026 12:40:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="UmpAR7eQ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F91910E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391234;
 bh=l4G0WrXVngKha9UQ5nbyt/Cwn4XiR2SaOKpwKIgQPBk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=UmpAR7eQ3SjEDOoJLrs/tYLa3xOUnNM5h1Rd69UdL4tvov+ffImP88hl84951vAt+
 PM3lXaHSPGcsXO0cxKctJZDsvh8z5F6MS6CqgtJC+35YfbpTy0AIVzc6RkEJVlJN79
 mTW4vG5vouflo8Lw5WJAJROmyCpVj4TX+TDWj2DU15NVC4D1qgmcF1/WEpOtyB31dW
 8fCqmXhVqXN6F8scEY7H0TJJb8gtCkVCPknE1aRBSGBEh9Awp8HTSnoQj+sbbx1Z1w
 z40MAPWbg9fEbjkcqMW4Qrh2JeP2vpYECvgU2+SPTcZWXpoYTrQM9PQeDFQUinTsih
 weCIDm0dd3Dxw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9042817E1164;
 Thu, 25 Jun 2026 14:40:33 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 14:40:32 +0200
Subject: [PATCH 06/11] drm/panthor: Don't overrule pending immediate ticks
 in sched_resume_tick()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-misc-fixes-v1-6-b67ed973fea6@collabora.com>
References: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
In-Reply-To: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1771;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=l4G0WrXVngKha9UQ5nbyt/Cwn4XiR2SaOKpwKIgQPBk=;
 b=+n0e56lGMxPCfuW4bWyoDDfGZRH57ElpvYqQooLXi6+/jN4GgmUDC8U/dxf5SzEQRNEL2MRM9
 vMPGbU+RHMnA7+S9DKLaBsr7piCIEaM7EPeAFWVlHOh20CB3LDicyZB
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
index 8fd4d97b062e..ab3e13e44a26 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -2667,7 +2667,14 @@ static void sched_resume_tick(struct panthor_device *ptdev)
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

