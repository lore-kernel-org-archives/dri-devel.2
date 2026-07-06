Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 463B4C44501
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04D3510E336;
	Mon,  6 Jul 2026 11:47:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="LV0NzvAl";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F46510E336;
 Mon,  6 Jul 2026 11:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783338464;
 bh=W9LVkaWCJ6mz1Fpj26b8EiLt/bi8HRInnG4tcu+I5vE=;
 h=From:To:Cc:Subject:Date:From;
 b=LV0NzvAl/xYaq/AI2C7cMoXya0/fswznzObwhHJk1OM7BAKTA9QOD1nz3+8FArWNy
 HXM+AaaEPMpyO+uWgtMs0yI7yz/qlCBNnD0Xz52mbPdU9iKMDd3ylFqQlrZs8q9kNA
 FHhnkfv5LQv7c1RMWuUzl4D9XCS9vt08/3TcsI6zmgCAI/vFPOFIl01snLoObd4qEK
 GqI1aUszYvEaxFXOrUP33hblLBqLNcMYuD0x8bMU1/zxlTuGBJC56xaei7n63+J77I
 9yUFxtou2nTxwIBo43YL2XYHWhRKO+C1HCULZgU77KXQu85CaumSaF+7+wbaxnjS11
 U4EvRQQeXaa1Q==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Maarten Lankhorst <dev@lankhorst.se>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v4 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Date: Mon,  6 Jul 2026 13:48:16 +0200
Message-ID: <20260706114823.752313-1-dev@lankhorst.se>
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

Changes since v3:
- Fix some issues in last patch found by sashiko.
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

 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c   | 172 +++++++++++-------
 .../gpu/drm/i915/gt/intel_breadcrumbs_types.h |   1 -
 drivers/gpu/drm/i915/gt/intel_context.c       |   1 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c     |   2 +-
 .../drm/i915/gt/intel_execlists_submission.c  |  17 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |   8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h        |   2 +-
 drivers/gpu/drm/i915/i915_request.c           |   2 -
 drivers/gpu/drm/i915/selftests/igt_atomic.c   |   7 +
 9 files changed, 130 insertions(+), 82 deletions(-)

-- 
2.53.0

