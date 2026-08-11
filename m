Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2B04C5CFCF
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 11:23:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24A8F10E2F9;
	Tue, 11 Aug 2026 11:23:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="QIAYkyZe";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A53D10E2F9
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 11:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786447418;
 bh=uUn1zBH1I1j2VU7UGkygd3e15GyP36Xoxsnp1gDxcPY=;
 h=From:Subject:Date:To:Cc:From;
 b=QIAYkyZeC3kNs3vO2wAdu/Dm/7VZ0KEMap1hlJTt8MVBhRHl0wYkOitACaTqUPV3L
 tj+tIYSbQakgqfPfURM7+TNh5X+cQnCil4cYrFKDUTc6F84gUHdIbVS2NhQpYZv+ba
 wS5YpGp/b5BUSXQC2B1SeBXcI5kL71720V0BMi3zjWItjYpWPg81rbmO0sNQGDnzrS
 LqA9/vayyXpKxu6k9a0tp5MH87zcB2N/630KMkOyWTJ83x/WOJzjKn4lig0VeDhQek
 xYkP6KyKV0F/RK8Eho95ibTIDsu2uqx9oRALPyHFjiS9NQ6/sKo6TVIq2Ja+IVgHfk
 CZo3jG/RU/rTA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 4867817E08D8;
 Tue, 11 Aug 2026 13:23:38 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v6 0/9] drm/panthor: Reduce dma_fence signalling latency
Date: Tue, 11 Aug 2026 13:23:34 +0200
Message-Id: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43QwW7DIAwG4FeJOI8JDCGhp73HtAMQ0yAloYUs2
 lTl3cfSQ6cp0Xb8Lfuz5RvJmAJmcqpuJOEScohTCeqpIq430xlp6EomwEAxCZpezDT3MdEczpM
 ZqE9xpCFdaSeEaqWXHWggZfqS0IePTX59u+eE1/eyYL4XiTUZqYvjGOZTZbXiaIXqGsvId38f8
 hzT53bYwreBP29YOGVUWg0GJZfQwYuLw2BsTOa5LNrcBR5WzeHYgmLp2ikuTSO0s3uWeFgKxLE
 ligXoUGjlW0S2Z8mfVn1syWKJ8mXWag7Gmz2r/qdVF6tthTKNRIZe/7bWdf0C7WglWiICAAA=
X-Change-ID: 20260429-panthor-signal-from-irq-d33684f4d292
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786447418; l=3962;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=uUn1zBH1I1j2VU7UGkygd3e15GyP36Xoxsnp1gDxcPY=;
 b=KGwwDvaVmOKgmNWNIm4+fSZMsJCuryG5HGxjmlf/FpYSG1cNXi+SWC2jGpCjh6IDqW+nvCX7K
 NiQUXej2I4oCbibk7LEYlAiFM1PSh88Dt5Qd1kVQr9j2KZtAFNKNffW
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
Changes in v6:
- Rebase on drm-misc-next
- Link to v5: https://lore.kernel.org/r/20260625-panthor-signal-from-irq-v5-0-8836a74e0ef9@collabora.com

Changes in v5:
- Add a fix for a theoretical IOMEM access in suspended state (patch 1)
- Make sure we don't delay a pending immediate tick in
  sched_resume_tick() (patch 2)
- Make sure we initialize panthor_irq::state properly in the irq_request
  helper
- Link to v4: https://lore.kernel.org/r/20260625-panthor-signal-from-irq-v4-0-3d2908912afa@collabora.com

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
Boris Brezillon (9):
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helpers
      drm/panthor: Don't update might_have_idle_groups in process_idle_event_locked()
      drm/panthor: Get rid of panthor_group::fatal_lock
      drm/panthor: Protect events processing with a separate spinlock
      drm/panthor: Don't defer job completion checks
      drm/panthor: Don't defer FW event processing
      drm/panthor: Automate CSG IRQ processing at group unbind time

 drivers/gpu/drm/panthor/panthor_device.h | 286 +++++++++--------
 drivers/gpu/drm/panthor/panthor_fw.c     |  22 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  28 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  39 +--
 drivers/gpu/drm/panthor/panthor_pwr.c    |  24 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 517 +++++++++++++++----------------
 6 files changed, 451 insertions(+), 465 deletions(-)
---
base-commit: b961eb36d7b04147104cff2fd8bc0e94f4713324
change-id: 20260429-panthor-signal-from-irq-d33684f4d292

Best regards,
--  
Boris Brezillon <boris.brezillon@collabora.com>

