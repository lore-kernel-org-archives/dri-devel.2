Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81547C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:15:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD81810E839;
	Mon, 17 Aug 2026 15:15:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PbFJvkes";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92EC310E839
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 15:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Cc:To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 Message-Id:Date:Subject:From:From:Reply-To;
 bh=D5WEBVZlleXcUuWjWuXZuDA39OZHw2wNuMXjyVebyhM=; b=PbFJvkesHRc6rIE3Z9PSnxxiZ/
 aRKKi5L2tPUv1q69ITtAi/1ia+1CaHLQTbg4yGOUVuJCeAe2dcTbJt8ZtXQyGwNFk7+Q+w0K+Lv3N
 0mYXSiL1QwqLloKfJu2YqKSNJLf0HqIvEF4hSe5QHFojgZrCtvCGlNiwkCpX6dcAzlbPvmFERt54i
 Wj5UmJ5Fr0QfKN8jyGEazFBI816CrEsYR4Bz91IqHnj+5CxPfGplQIZK+4D7xEzMsnk6XweLBm/4b
 9dnyA2czM0I84HEbDZ6k1I9EOQcKHcAofLAviunNUIvbfpd3efHmXQgUcw/zVUREALHf6eiW9Yl9V
 H6nnEOYA==;
Received: from [179.105.94.163] (helo=[10.0.0.1])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wvz3w-004eWD-3Z; Mon, 17 Aug 2026 17:15:44 +0200
From: =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
Subject: [PATCH 0/6] drm/vc4: Fix the V3D interrupt state across power
 transitions
Date: Mon, 17 Aug 2026 12:15:30 -0300
Message-Id: <20260817-vc4-irq-cleanup-v1-0-ee6c592b3836@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvILJGuEi1EpxoIM6UIxLsnL
 d/i/wyJIlOCqckQ6eHEp68QbQN2N34jZFcNfderTguFjx2Q44X2IOPvgNpI7YRaRyNHqFWItPL
 7H+ellA98Exe2YQAAAA==
X-Change-ID: 20260816-vc4-irq-cleanup-8a38d16f5a35
To: Maxime Ripard <mripard@kernel.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Iago Toral <itoral@igalia.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3392; i=mcanal@igalia.com;
 h=from:subject:message-id; bh=iUyLMa+09T/IvKOZeILr5iWQG2cxhrCy/CajvN+7L90=;
 b=kA0DAAoBP/MOinaI+qoByyZiAGqDJZejS3gz4CjuL0wAu40oRah8OGp9yCMbduKWAubkMVg9p
 4kBMwQAAQoAHRYhBPjkXX0BFncHKaZ30T/zDop2iPqqBQJqgyWXAAoJED/zDop2iPqqDR0H/R6n
 Yf1ir/MMd0U/WggjIIZsXSzJFhu/+mpKSEJ7fMUzdfcvJR3fDKjBUqel6TpHSJPF4rnB8CK1HYM
 aJX2G5oWzDrDOQn3sET0X5AEgpdCtGVHrGZa2lOKm70ot06QXfgcz0fB/wvAbe4NcPrVNnyhNFt
 65cVH0CIqUdT0mFVCB2nvArnAtltgVhdT2Y4U5qRyjDhuRXTml5sngCUwk3uv/CLFeP8k3ghOD7
 SQT+nIlLS779681/C3B06kS4f9NKtD+GwopMfpWI6xyQG5jiLY4V+ZV/cxTzNLMigPGUPEX3JUh
 R1EtJy9rrFS5stOauvckxcj5JUfSQSLZW6b/Mlk=
X-Developer-Key: i=mcanal@igalia.com; a=openpgp;
 fpr=F8E45D7D0116770729A677D13FF30E8A7688FAAA
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

The V3D block is runtime suspended whenever it goes idle, and the driver
does not put its interrupt state back together on the way up: the
out-of-memory interrupt is armed once, when the binner BO is allocated, and
never again. Two more paths reach V3D registers with no runtime PM
reference at all.

Although the patches address distinct problems, they touch the same
functions and share the common goal of making the V3D interrupt handling
survive a power transition.

This applies on top of the V3D reset controller series [1], which drops the
private runtime PM refcount that vc4_reset() used to rely on.

PATCH 1 stops a GPU reset from deadlocking against its own overflow work.
vc4_v3d_get_bin_slot() waits for a render job to retire with no timeout,
and vc4_overflow_mem_work() calls it from a kworker. If the job being
waited on is the one that hung, vc4_reset() never gets past the
cancel_work_sync() in vc4_irq_disable(), and the reset that would have
retired the job never runs. The wait now takes its timeout from the caller,
avoiding the deadlock. This issue was unveiled by masoncl's review scripts.

PATCH 2 takes a runtime PM reference around the binner BO allocation.
bin_bo_alloc() arms the out-of-memory interrupt once it has the BO, and
vc4_create_bo_ioctl() reaches it through vc4_grab_bin_bo() without having
powered the block up, so that write can land on a suspended device.

PATCH 3 removes the IRQ number argument from vc4_irq_install() in favour of
vc4->irq. No functional change, just clean-up.

PATCH 4 rebuilds the interrupt mask on every resume. Nothing re-armed the
out-of-memory interrupt across a runtime suspend: it was armed once when
the binner BO was allocated, masked on the way down, and never brought
back, so an overflow after an autosuspend raised nothing and left the
binner stalled until the hangcheck. Now, vc4_irq_enable() derives that bit
from whether a binner BO exists.

PATCH 5 takes a runtime PM reference in the overflow work itself. The
out-of-memory interrupt only queues the work, so the block can be suspended
before it runs.

PATCH 6 lets runtime PM tear the block down at unbind. vc4_v3d_unbind()
writes V3D registers on a block that has probably autosuspended already,
and everything it does is done by vc4_v3d_bind() and
vc4_v3d_runtime_suspend() anyway, so a runtime suspend replaces it.

Let me know your thoughts.

[1] https://lore.kernel.org/dri-devel/20260816-vc4-reset-control-v1-0-896444373716@igalia.com/T/

Best regards,
- Maíra

---
Maíra Canal (6):
      drm/vc4: Bound the wait for a binner slot in the overflow work
      drm/vc4: Hold a runtime PM reference while allocating the binner BO
      drm/vc4: Take the IRQ number from vc4_dev in vc4_irq_install()
      drm/vc4: Rebuild the V3D interrupt mask on every power transition
      drm/vc4: Hold a runtime PM reference in the binner overflow work
      drm/vc4: Let runtime PM tear the V3D down at unbind

 drivers/gpu/drm/vc4/vc4_drv.h      |  5 +--
 drivers/gpu/drm/vc4/vc4_irq.c      | 75 ++++++++++++++------------------------
 drivers/gpu/drm/vc4/vc4_v3d.c      | 32 ++++++++--------
 drivers/gpu/drm/vc4/vc4_validate.c |  2 +-
 4 files changed, 45 insertions(+), 69 deletions(-)
---
base-commit: 874ff27dcd2f38508b794763f56653c44ca12d03
change-id: 20260816-vc4-irq-cleanup-8a38d16f5a35

