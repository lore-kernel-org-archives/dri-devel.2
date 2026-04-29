Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091ACFF886D
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 09:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1CA10EF04;
	Wed, 29 Apr 2026 09:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gb/niX4z";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F2F610EEFE
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777455534;
 bh=6j20uIsC0wojMfhp5u4Z4DBXV8WgEm3tMPG6FW8fDBc=;
 h=From:Subject:Date:To:Cc:From;
 b=gb/niX4zDrQV2jCeX/dPCVBAMSCyydFsJ7iQdKflaedI/800zkojYOIvlqHqOtUgw
 W5b9ny1M+/yI8U4ZAv+Z52jd9ldx5pFA/0LI30PuEHEboy3wGV1V7As6CuU9Akt65K
 Lke8nBs+HGyPz7Yng6nFWfIW4qIZfFvYjXq7NXYCiwamXfeviaTJ+ultkVthNg3PEK
 G+m3Wh0RUMzVesxqlC3fgXi2hW/+qdrbX/jqqhd7zCqNYhK8D9ADV4VVR3OQQjqM+s
 DmFznK2ilOFE2qHW+HpZtHh/swagjvHAiKlpqpsTeVG+CMxkxUYnIt+L3mDIXjALcL
 emJcwB0bQC9Fw==
Received: from [100.64.0.11] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5253617E0610;
 Wed, 29 Apr 2026 11:38:54 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH 00/10] drm/panthor: Reduce dma_fence signalling latency
Date: Wed, 29 Apr 2026 11:38:27 +0200
Message-Id: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2NQQ6CMBBFr0K6dkgpLQoxxnsYFyMUmWhbmKIxM
 d7dCi7fT/57bxEtk42iyd6C7ZMiBZ+g2GSiHdBfLVCXWCipKqlVDSP6eQgMka4e79BzcEA8QVe
 W1U73ulO1Euk9su3ptZhP55XZTo8UmNdROBsjLoEm2//928KYutS5LiojFRRwQ354umHeDiEck
 V3eBnf4BS4YLSRwNDfZVhuD0uxKrKU4fz5fRBIeI9gAAAA=
X-Change-ID: 20260429-panthor-signal-from-irq-d33684f4d292
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777455534; l=3165;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=6j20uIsC0wojMfhp5u4Z4DBXV8WgEm3tMPG6FW8fDBc=;
 b=R5+nLDQqHQmpG18cq0lNzcKfyz+0a2I66THInR4MiidT+el5oNSWmXu6mKYvDb/bVmj1jU7ut
 PRylwGMzYS6AMZexT2lizKgUIM1uL/xntkZAKZuPxutTH35F+4xBo+u
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

Right now, panthor is one of the rare drivers to signal fences
from work items (not even from the threaded IRQ handler). We
could move that to the threaded handler, but that would still
leave the latency caused by the scheduling of the IRQ thread.

Instead, this patchset moves all the job IRQ processing to
the raw IRQ handler, which is fine because what the current
code does is demux the interrupts and deferring actual handling
to sub work items. The only bits we keep in the IRQ path is
the dma_fence signalling, which should be acceptable, in term
of CPU cycles spent in the IRQ context.

Pretty much all the patches except the last two are just
preparing the ground to get there. The second to last one
does the thread -> IRQ transition, and the last one is some
experimental interrupt coalescing support that I've added
because I noticed moving job IRQ handling to the raw handler
generates quite a lot of interrupts in some case, and having
the system constantly interrupted like that can be
detrimental.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Boris Brezillon (10):
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helpers
      drm/panthor: Extend the IRQ logic to allow fast/raw IRQ handlers
      drm/panthor: Make panthor_fw_{update,toggle}_reqs() callable from IRQ context
      drm/panthor: Prepare the scheduler logic for FW events in IRQ context
      drm/panthor: Automate CSG IRQ processing at group unbind time
      drm/panthor: Automatically enable interrupts in panthor_fw_wait_acks()
      drm/panthor: Process FW events in IRQ context
      drm/panthor: Introduce interrupt coalescing support for job IRQs

 drivers/gpu/drm/panthor/panthor_device.h | 358 ++++++++++++++---------
 drivers/gpu/drm/panthor/panthor_drv.c    |   1 +
 drivers/gpu/drm/panthor/panthor_fw.c     | 226 +++++++++++++--
 drivers/gpu/drm/panthor/panthor_fw.h     |  11 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  27 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  38 +--
 drivers/gpu/drm/panthor/panthor_pwr.c    |  21 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 475 ++++++++++++++-----------------
 8 files changed, 698 insertions(+), 459 deletions(-)
---
base-commit: 7455a0583a906533041a80e48c6a2e3230cce96e
change-id: 20260429-panthor-signal-from-irq-d33684f4d292
prerequisite-message-id: <20260427155934.416502-1-karunika.choo@arm.com>
prerequisite-patch-id: 70905a2eb09ab2b31d242a5ed5af3b42fb6a464c
prerequisite-patch-id: aa4c22669f80328039762f25c0b3942bbadbdc89
prerequisite-patch-id: 7f61bcee3c4bb5703900b18d5b6e0f52e622f29d
prerequisite-patch-id: 3402f4d60aa526d40113fc3d9b3e599f8f89e705
prerequisite-patch-id: 00ddbd3d455891f6950609614c1acd2baa78b0db
prerequisite-patch-id: 6a9928f609e3757cadebb2df6795d0da55745f4e
prerequisite-patch-id: fd91f68f25d4bc93eec405f0131f5ae4284bfaf2
prerequisite-patch-id: 553958a10a0ca2f20f7883ad4c752cfc7485c5a8

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

