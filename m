Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D74D1CDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4BCC10F1FB;
	Thu, 25 Jun 2026 09:37:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="keaMqzxd";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB19310F1E3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782380194;
 bh=RMYZKivovEOOsKi51GYB10RFfeZO58K7MGXJlOsglUo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=keaMqzxdf7SjZpFPcMgJkhSh/l2AQaLEFadaI9DUhD5qlWLuWNaNdHuHAU4u964zb
 0nVRKneKVxyDqryfOBfdE/bS95V/3GcxkbiE82beXhiSfOiidvPDMKSn+la77wFSKb
 1leh7Qdn2+Df67Gw9wf6dJVEYLlOHVkxtAtVNhfxUOBl+y5bRM7sBF1F6WmG9tA8+f
 MBg45nsYbIRZfsJTeaFLDlVxVoOYWL6Gkens91BHrflK8fhzdDu/cmqWdlx8Wgggk4
 7iGGxY+Fb/fVios85qwhsWuKgO440edKAjGpmk8ZRLmtR8alAmk0avq7sWWLEG7SZi
 ymaUkjOC7Hxqg==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 0F67717E1553;
 Thu, 25 Jun 2026 11:36:34 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 25 Jun 2026 11:36:26 +0200
Subject: [PATCH v5 11/16] drm/panthor: Don't update might_have_idle_groups
 in process_idle_event_locked()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-panthor-signal-from-irq-v5-11-8836a74e0ef9@collabora.com>
References: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
In-Reply-To: <20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782380187; l=985;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=RMYZKivovEOOsKi51GYB10RFfeZO58K7MGXJlOsglUo=;
 b=kh2qs7Nvx6FseCkjhfs+H5fS19LaYxsfs1i+WjKM4BBwG+Q1HYYLevDP4BbQfdp3Z8MLdjsoJ
 xkTTpCV1pCaA7+N9At/oPZqs9oTpxs57jH/mOp0ZEE9wNYLXiNGdh7L
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
index 237f6a75e624..a5dfb1beafff 100644
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

