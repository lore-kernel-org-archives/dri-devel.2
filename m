Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6C7CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:37:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2130D10EA44;
	Tue, 12 May 2026 11:37:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="DFzhZS83";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484E710EA41
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778585861;
 bh=GJdxBrIxPGziB4qn+jrRJCI9MAdTeNwgOxkP6BJkwiE=;
 h=From:Subject:Date:To:Cc:From;
 b=DFzhZS83D8/EplfoLUn/CBzND907MpUYrGY/+Fh9fTFE2dl3BNicYkmv86btOoNGY
 2VZ7/tFh4wfuDNPtyH6eKSJfyJYvCNu4K//C0wJAlYxTAVr4Zn+IaTZ3B7Agdlplww
 KBn5gC82x5zM9YZOPDmOzE1k8znwfIzUFs0bOxQYaMlYgahzH3zvd/HQ1ap0sEnQcV
 UHS4KPeyRhtc/7On0kS/VG2kR86ZY+KK7Yi+QAOXOOgDU/sSnEczKYMYWwWNLwWvnc
 XLPORCglt8FG4FVKiAs8nZwQXw9kHZDR157vxvAmtaDweSv/fogHtZq4gBTRlNR38X
 XM4vcn+EnjkGQ==
Received: from [192.168.1.38] (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 5274317E12BF;
 Tue, 12 May 2026 13:37:41 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Subject: [PATCH v2 00/11] drm/panthor: Reduce dma_fence signalling latency
Date: Tue, 12 May 2026 13:37:30 +0200
Message-Id: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4WOTQ6CMBCFr0Jm7Rg6ViOuvIdxMbRFJgGKUyQaw
 92teACX38v7e0MKKiHBqXiDhlmSxCEDbQpwLQ+3gOIzA5V0KC1VOPIwtVExyW3gDhuNPYre0e9
 2h6NtrKeKIKdHDY081+bL9cca7o88MP1EqDkFdLHvZToV7PbsSnaNMR6+/lbSFPW1HpvNGvj7Y
 TZYoq0r4mCNJU9nF7uO66i8zUNwXZblA0kauVTyAAAA
X-Change-ID: 20260429-panthor-signal-from-irq-d33684f4d292
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778585861; l=3187;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=GJdxBrIxPGziB4qn+jrRJCI9MAdTeNwgOxkP6BJkwiE=;
 b=M9Nm5YRHZY9swpDnmA3Eg3f8ympz574wkWs9b57fpv61pAtO4lmhr7ZSBV6nP5V4JzFffRmxM
 EjchD1rgU/YA52dKhZ5Y/rAfrWbdcN2tkBkQ2YbPig4rJjz65LO3cvN
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

Instead, this patchset moves all the JOB/GPU IRQ processing to
the raw IRQ handler, which is fine because what the current
code does is demux the interrupts and defer actual handling
to sub work items. The only non-trivial thing we keep in the
IRQ path is the dma_fence signalling, which should be acceptable
in term of CPU cycles burnt in IRQ context.

Note that the MMU event handling is left in a threaded handler
because it requires acquiring sleepable locks and fixing that
is non-trivial.

Still very basic testing done, but glmark2 and gfxbench's
manhattan test show a ~5% perf improvement on a rk3588 with this
patchset applied.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
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
Boris Brezillon (11):
      drm/panthor: Make panthor_irq::state a non-atomic field
      drm/panthor: Move the register accessors before the IRQ helpers
      drm/panthor: Replace the panthor_irq macro machinery by inline helpers
      drm/panthor: Extend the IRQ logic to allow fast/hard IRQ handlers
      drm/panthor: Make panthor_fw_{update,toggle}_reqs() callable from IRQ context
      drm/panthor: Prepare the scheduler logic for FW events in IRQ context
      drm/panthor: Automate CSG IRQ processing at group unbind time
      drm/panthor: Automatically enable interrupts in panthor_fw_wait_acks()
      drm/panthor: Process FW events in IRQ context
      drm/panthor: Use the irqsave variant of spin_lock in panthor_gpu_irq_handler()
      drm/panthor: Process GPU events in IRQ context

 drivers/gpu/drm/panthor/panthor_device.h | 281 +++++++++---------
 drivers/gpu/drm/panthor/panthor_fw.c     |  76 +++--
 drivers/gpu/drm/panthor/panthor_fw.h     |   9 +-
 drivers/gpu/drm/panthor/panthor_gpu.c    |  31 +-
 drivers/gpu/drm/panthor/panthor_mmu.c    |  38 +--
 drivers/gpu/drm/panthor/panthor_pwr.c    |  21 +-
 drivers/gpu/drm/panthor/panthor_sched.c  | 483 ++++++++++++++-----------------
 7 files changed, 476 insertions(+), 463 deletions(-)
---
base-commit: ac5ac0acf11df04295eb1811066097b7022d6c7f
change-id: 20260429-panthor-signal-from-irq-d33684f4d292

Best regards,
-- 
Boris Brezillon <boris.brezillon@collabora.com>

