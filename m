Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69B43CDE007
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3AE710F171;
	Thu, 25 Jun 2026 07:38:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="AwhtcOPL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E9710E1B5
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373118;
 bh=gvVJwitGNAjT05IbeVOO4z8pIthBP2UjW0j3Lxfb5Fk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=AwhtcOPLvJWjPrlb5RPjlt9fiS0O+zFA74lc5UdWiVJnHSDonsRGJFfnT6FXJsG1D
 RCHbpUup+ZgZe/LSVlPvK+pf+oMrKxbu9xrFpG0Em3fogvsANhOIGiiWd3aWGAeDVl
 wcTwptiC3qOXWwrjCmGMh0AmkSV0mttU/ZmcnIKJ/ryJ1fOHfAXpVF28IFke1DUGUG
 V+6RexCHeAnVmIhMgxBTNY0GM66lFfgrrDuh6b4C/Mci3kmzDhRhjYaCR8qQsSRNIc
 AoQx7Z8DZSJFEpvLefzFIkSv15NzpJOQKR6GA6N1zhQQE0LeKVuqDfUt/JXwSqkE+C
 VuWEkOVrAU6VA==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1320F17E1270;
 Thu, 25 Jun 2026 09:38:38 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 09:38:19 +0200
Subject: [PATCH v4 09/14] drm/panthor: Don't update might_have_idle_groups
 in process_idle_event_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v4-9-3d2908912afa@collabora.com>
References: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=985;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=gvVJwitGNAjT05IbeVOO4z8pIthBP2UjW0j3Lxfb5Fk=;
 b=FyIh3/QK183C+7NK4Mips0fwZZUg+NxJbxxxeZ7Sat+txhAhImX/DlI2N26kTkmNoKNCjOSiV
 fbo7nZ6JZY2CNRBmDlYDJBSGxxQFkp4/gUFwaU4ihOsMa8ZTGWUm2CN
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
index 1caa803c2850..99381b71dd58 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -1734,8 +1734,6 @@ static void csg_slot_process_idle_event_locked(struct panthor_device *ptdev, u32
 
 	lockdep_assert_held(&sched->lock);
 
-	sched->might_have_idle_groups = true;
-
 	/* Schedule a tick so we can evict idle groups and schedule non-idle
 	 * ones. This will also update runtime PM and devfreq busy/idle states,
 	 * so the device can lower its frequency or get suspended.

-- 
2.54.0

