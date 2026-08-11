Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F60C5CFDB
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1535510EB54;
	Tue, 11 Aug 2026 11:23:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="Xy+TMNvJ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555D110EB4D
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447421;
 bh=iIMz/Di+4zcqXSuXP3GGrXJfNht/Ir8iTOqKqD7xE+E=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Xy+TMNvJEqjpNtnqaAG+nvmo7opqeWpNmGfThbMYBIDBdC7s39+D2BHTP4CGsA2ip
 5yR3kJ30Du2JEjCeaN8I9YeNOnL5DIQhYGGQnW7GFRmAIA+LAJNOIVhH5anLvC70fI
 CJvl3TZhaqbvJmES8PcsRrF16g/v5b0LAN5JanwMlikMsnwEEcrQlUEw+Pm2bynRar
 q8wbKD5OKtEtFIWh/eCS/Q4xH8hqGpCazTdxL2Egr6uXwsGoxmzk7FPe3R32V06hHN
 tJC4Ug1wIeBB8dQ7OH/PrOr9JqBadqpCYZuSRayAyWdqAunBpgeOl1RiIziq0QIWYL
 gge9q+E8+IhaA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 92FF317E0F35;
 Tue, 11 Aug 2026 13:23:40 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Tue, 11 Aug 2026 13:23:38 +0200
Subject: [PATCH v6 4/9] drm/panthor: Don't update might_have_idle_groups in
 process_idle_event_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260811-panthor-signal-from-irq-v6-4-12f2ab53d735@collabora.com>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
In-Reply-To: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=985;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=iIMz/Di+4zcqXSuXP3GGrXJfNht/Ir8iTOqKqD7xE+E=;
 b=KEhG7IFni8njEuFJbnY/WDR4EEGm8nx+ZuUT+jv84ya4QGx2mPLeV/muuYOOHtmfiDTEiHJxb
 3eFHYzt2ZcUCJ61PQ/sXxgXnvK7f+eDE8nbl2afwosVY2ixveezYFK6
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

By scheduling an immediate tick, we already force idleness re-evaluation,
which gives the scheduler the opportunity to evict idle groups
and schedule onces that have jobs pending.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 5832dccfc093..baa06731797c 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1733,8 +1733,6 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 
 	lockdep_assert_held(&sched->lock);
 
-	sched->might_have_idle_groups = true;
-
 	/* Schedule a tick so we can evict idle groups and schedule non-idle
 	 * ones. This will also update runtime PM and devfreq busy/idle states,
 	 * so the device can lower its frequency or get suspended.

-- 
2.55.0

