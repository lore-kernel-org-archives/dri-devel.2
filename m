Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9E1CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE60F10F296;
	Thu, 25 Jun 2026 12:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="g7++DTVO";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9871310E1FA
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782391230;
 bh=U/9uURAqeOPvchWGcfqGa/gIuEM9tjr7Dkjj8Z708jM=;
 h=From:Subject:Date:To:Cc:From;
 b=g7++DTVOWTiVoGs7MyV+2FQQI2drBj1243TzRRDjGXJFlbcK+eZxmnsNRFb6Kogc4
 Kc5T+UrOUo3mLe5ffY0jzTSM6rtKmzp+2UYkbTmMTDMYDu/PbGzNpVW/ZNqJ4CLFJT
 3H/uuF6sqOdEq2DKm/JGOKBvWyQgXWRtchhQ9IlUh5F83w1U/ebbnmsTTVadfyRMVZ
 r++4VHiJVN5KgzlgV6qbsLwmhaYYqqDtyDF/0cYdEV51cz63EYP5MiM9b9iau5LbrL
 QNV4oKG6NLoGnraEX0y6bUa+dRX67sMCXMZNZqQh7ZETSAGueNjYA+rjxUpH22pNUS
 6SbUR+xTWbOjw==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 95F2417E0909;
 Thu, 25 Jun 2026 14:40:29 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 00/11] drm/panthor: Misc fixes for bugs found by shashiko
Date: Thu, 25 Jun 2026 14:40:26 +0200
Message-Id: <20260625-panthor-misc-fixes-v1-0-b67ed973fea6@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQqDMBBFryKzbiDGVtCrFBdx/NZZJNpMLAXx7
 g11+d7n/YMUSaDUVwclfERljQXqW0W8+PiCkakwOeta27qH2XzMy5pMEGUzyxdq0Lh7zWgxW0s
 l3BL+Q+mew8UJ771850vS6BWG1xAk9xVPGB3z1HUNaDjPH8Js1gyUAAAA
X-Change-ID: 20260625-panthor-misc-fixes-e3241ce6ef00
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>, Karunika Choo <karunika.choo@arm.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782391229; l=1879;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=U/9uURAqeOPvchWGcfqGa/gIuEM9tjr7Dkjj8Z708jM=;
 b=5tCy137h53xJZkNVDb//tHUbxj3uJK6YE+x4GS6xBXvh4LKWxfeWXdWlxF00pc52YzCn6w1SS
 9Nvj5VJH7ezCB8xviQYxJ+tHy4eyLX96gS1sOknM6eWs2WRr6tueSLW
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

This is a collection of fixes for bugs found by shashiko during
the review of [1] and the previous iterations. Because shashiko
keeps finding new issues at each new submission, I decided to
extract the fixes out of this series.

[1]https://lore.kernel.org/dri-devel/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com/

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Boris Brezillon (11):
      drm/panthor: Always use the IRQ-safe variant when acquiring the fence lock
      drm/panthor: Keep the reset work disabled until everything is initialized
      drm/panthor: Fix UAF on works queued to panthor_cleanup_wq
      drm/panthor: Fix potential invalid pointer deref in group_process_tiler_oom()
      drm/panthor: Fix theoretical IOMEM access in suspended state
      drm/panthor: Don't overrule pending immediate ticks in sched_resume_tick()
      drm/panthor: Fix panthor_pwr_unplug()
      drm/panthor: Drop a needless check in panthor_fw_unplug()
      drm/panthor: Fix a leak when a group is evicted before the tiler OOM is serviced
      drm/panthor: Interrupt group start/resumption if group_bind_locked() fails
      drm/panthor: Keep interrupts masked until they are needed

 drivers/gpu/drm/panthor/panthor_device.c |   9 +++
 drivers/gpu/drm/panthor/panthor_device.h |  17 +++--
 drivers/gpu/drm/panthor/panthor_fw.c     |   6 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |   3 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |   9 ++-
 drivers/gpu/drm/panthor/panthor_pwr.c    |  10 +--
 drivers/gpu/drm/panthor/panthor_sched.c  | 108 +++++++++++++++++--------------
 7 files changed, 97 insertions(+), 65 deletions(-)
---
base-commit: cdeb2ccd993ed8647adbbda2c3b103aa717fd6f7
change-id: 20260625-panthor-misc-fixes-e3241ce6ef00

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

