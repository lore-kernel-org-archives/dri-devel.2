Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91E69CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D69D310E1A2;
	Thu, 25 Jun 2026 07:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="C6pPE8Ea";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F8F10E18B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 07:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1782373112;
 bh=u0A2OwNuXpFAZDRtLYtUS1sUf9CeIi7ESdPWHRqnph8=;
 h=From:Subject:Date:To:Cc:From;
 b=C6pPE8EaoJ2ZD5kZiD4byO/UjN87UNCYQ3/YFzqE5Spt8zXb13sGbeiy8nNbqU74u
 TTmkZ1wnGJ2hXtu1gEgmv9l7Mt2MUwRiErOb1xu+/x7PxF3IwkcNW3RN3jc7rdj1Tk
 iYbD6hYr1nc2OSePFGPPR7PufEh8t8XAlcNz8611xc0CGyvaBrxavPkeWXNAIKR2Jm
 f42zRBhDUpsCtufsH0VQSCrKzcRqS4gC19lwb8wRAunHIwV0Ila62XluMWY9yWPuuw
 9ijcC7obW/0hWrvu3L/6Jh0+0ao4DGzk4y9zRtD+e9q2+6n7u8n+n/aqv6CreXUnHd
 OYXs950q4IB2Q==
Received: from fedora-2.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 079FA17E02CB;
 Thu, 25 Jun 2026 09:38:31 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v4 00/14] drm/panthor: Reduce dma_fence signalling latency
Date: Thu, 25 Jun 2026 09:38:10 +0200
Message-Id: <20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwW7DIAwG4FeJOI8JDGGlp75HtYMDpkFKQgtZt
 KnKu5emh0rTqh1/y/9nX1mhHKmwfXNlmZZYYppq0G8Ncz1OJ+LR18xAgBEaLD/jNPcp8xJPEw4
 85DTymC/cK2V2OmgPFlhtnzOF+L3Jx89HznT5qgfmx5B1WIi7NI5x3jfoWnQCXZDSs/t+H8uc8
 s/22CK3wr8/LJILrjsLSFpq8HBwaRiwSxnf66HNXeBptRJeW1At2zojNX4o67q/LPW0DKjXlqo
 WkCNlTdgRid/Wuq43E7uIS4oBAAA=
X-Change-ID: 20260429-panthor-signal-from-irq-d33684f4d292
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>, sashiko-bot@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782373111; l=3786;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=u0A2OwNuXpFAZDRtLYtUS1sUf9CeIi7ESdPWHRqnph8=;
 b=gaeGhpWGPaMXmLlOliOnKRkE/xDgr4YfJi+VuLn94lHpPblvcDMWDAaXon3k23PGEhzCm9B1H
 1VBKNo+fvJBDnfLSTY1uqZbyA4ZWc1plD+dA97eJzLbWfdRVQgZvY4t
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
tried moving the job_completion check to hardirq handlers like
other drivers do, but the duration of this handler gets
slightly over the few usec (20+ usecs) we usually expect from
hardird handlers, and we're not sure we want to hold off the
processing of other interrupts for that long. So this series
just gets rid of the threaded-handler -> work_item indirection
and checks for job completion (and thus, fence signalling)
directly in the threaded handler.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
Changes in v4:
- Add a bunch of fixes for bugs reported by shashiko
- Link to v3: https://lore.kernel.org/r/20260623-panthor-signal-from-irq-v3-0-2ece396f8ee0@collabora.com

Changes in v3:
- Save/restore the irq state in the raw handler.
- Rename panthor_irq::mask_lock into panthor_irq::lock
- Use the __always_inline specifier on
  panthor_irq_default_threaded_handler()
- Use devm_request_threaded_irq() even when the threaded handler is
  NULL
- Drop the patch that dynamically enables request-related interrupts
  (FW-side race) after the polling period has expired
- Don't process FW events from the hardirq handler (too heavy for an
  hardirq handler according to our testing)
- Link to v2: https://lore.kernel.org/r/20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com

Changes in v2:
- Fix commit message in patch 4
- Move devm_kasprintf() before panthor_irq_resume() in patch 3
- Fix erroneous lockdep_assert_held() in patch 6
- Make sure events_lock is held when calling
  csg_slot_sync_update_locked() in patch 6
- Restore a csg_slot_sync_update_locked() call in patch 7
- Fix a potential deadlock in patch 9
- Drop the IRQ coalescing patch (formerly patch 10)
- Change panthor_irq_request() so we don't have to define a dummy
  threaded handler, and we can let RT kernels move the hard handler
  to a thread
- Add patches to transition GPU event processing to the hard IRQ handler
- Link to v1: https://lore.kernel.org/r/20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com

---
Boris Brezillon (14):
      drm/panthor: Fix panthor_pwr_unplug()
      drm/panthor: Drop a needless check in panthor_fw_unplug()
      drm/panthor: Fix a leak when a group is evicted before the tiler OOM is serviced
      drm/panthor: Interrupt group start/resumption if group_bind_locked() fails
      drm/panthor: Keep interrupts masked until they are needed
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helpers
      drm/panthor: Don't update might_have_idle_groups in process_idle_event_locked()
      drm/panthor: Get rid of panthor_group::fatal_lock
      drm/panthor: Protect events processing with a separate spinlock
      drm/panthor: Don't defer job completion checks
      drm/panthor: Don't defer FW event processing
      drm/panthor: Automate CSG IRQ processing at group unbind time

 drivers/gpu/drm/panthor/panthor_device.h | 280 ++++++++---------
 drivers/gpu/drm/panthor/panthor_fw.c     |  24 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  27 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  44 +--
 drivers/gpu/drm/panthor/panthor_pwr.c    |  24 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 524 +++++++++++++++----------------
 6 files changed, 463 insertions(+), 460 deletions(-)
---
base-commit: ac5ac0acf11df04295eb1811066097b7022d6c7f
change-id: 20260429-panthor-signal-from-irq-d33684f4d292

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

