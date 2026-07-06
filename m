Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C06C44500
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2291C10E8A9;
	Mon,  6 Jul 2026 10:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="QLWPp0Oq";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 074B510E8A0;
 Mon,  6 Jul 2026 10:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783334405;
 bh=i/YyU9d0Ww8cBNKyIC3Xr7/m83lJ0xdL3Nlgzk28BBQ=;
 h=From:To:Cc:Subject:Date:From;
 b=QLWPp0Oq54Hztbuyb2SjnBXTE/yEVcZBKWsO5nZse9I50PP1U4Qv28wrJeOeQun4N
 UMuJnFp/ED16Vb/JrBa9qTQVLnhrx2V3sIXMEmmIuEdKO7zy6dqWrnA/gtwqIYbeT3
 7wd4hoIiRESLYI3Obs9uGE/OOjVbevWl4O7h+EDjdXIImRYGfTHzC2gWLQjY4ZAqwn
 9V3h+zvvSTl+zybWat+UADVDlm85QXpnQ7EEMDDdysXIRUc8+DDNBc9ghGbI6Ot5+E
 cMeIHRDy9MvPXiWnp5IldhX/0Vw3eRtU18Dbw5GJsRjebubOp8edlEFYQB7VUF68Ri
 d7pI3hlS4fBHQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v3 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Date: Mon,  6 Jul 2026 12:40:35 +0200
Message-ID: <20260706104043.726178-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

All fixes to make the core i915 module (without display) working correctly on
PREEMPT_RT.

Some fixes are still needed, as the selftests still fail. But otherwise the
test results were looking good on PREEMPT_RT.

It looks like the patch that added a spinlock caused a regression on !PREEMPT_RT,
and may even have caused similar test failures on PREEMPT_RT, so to fix it
I removed RCU entirely, and converted to a locked implementation instead.

This time at least, i915 live selftests pass on !PREEMPRT_RT for at least 1 machine
with same config as CI.

Changes since v2:
- Remove the extra signaler_active lock, it broke because
  it didn't protect anything, instead use signalers_lock.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Maarten Lankhorst (3):
  drm/i915/gt: Fix selftests on PREEMPT_RT
  drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
  drm/i915: Use sleeping selftests for igt_atomic on PREEMPT_RT

Sebastian Andrzej Siewior (4):
  drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() +
    spin_lock()
  drm/i915: Drop the irqs_disabled() check
  drm/i915/guc: Consider also RCU depth in busy loop.
  drm/i915/gt: Use signalers_lock to prevent starvation of irq_work.

 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c   | 169 +++++++++++-------
 .../gpu/drm/i915/gt/intel_breadcrumbs_types.h |   1 -
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |   2 +-
 .../drm/i915/gt/intel_execlists_submission.c  |  17 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |   8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |   2 +-
 drivers/gpu/drm/i915/i915_request.c           |   2 -
 drivers/gpu/drm/i915/selftests/igt_atomic.c   |   7 +
 8 files changed, 127 insertions(+), 81 deletions(-)

-- 
2.53.0

