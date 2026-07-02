Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EDAC44500
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 08:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9218210F214;
	Thu,  2 Jul 2026 08:08:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="eDJCknLr";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8558F10F202;
 Thu,  2 Jul 2026 08:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782979719;
 bh=cELi72UXcmsxoDSqIeRcipM+x1a+26Tc3n9a0CDuv8s=;
 h=From:To:Cc:Subject:Date:From;
 b=eDJCknLrlx3iDzwLiSTTy/i+gZ4R2PtkG9P27BfordS+mOjr0Z6ISi+msb1lLa/TT
 RgCqQkQE8e6CQGDRI+VI1wmccR1wEko92Zay9dugVd/Nnh+CgADLRrVKXh0KBDqubs
 TfhQI7H8aX5oLMY5fZXbOrv2LZa1RYSXVV/AwqvkjiTpZ6ftkeIkeoUUrdhTEp1PPQ
 PaxL/PKTCRbu8YL24oMMBnIi6UYIJQpcC0f1pgFEahEKDClAqnjjHIm5VAu1z9oFhC
 PjEYKQbm25+Aw7dd/9OlVF6H8llTm728wSSWtagjRIe3kLGwlEECzVfIDW7zw5m65j
 dPdWDURERetMQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH 0/7] drm/i915: All fixes to make i915 work well with
 PREEMPT_RT.
Date: Thu,  2 Jul 2026 10:09:06 +0200
Message-ID: <20260702080913.434121-1-dev@lankhorst.se>
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

Maarten Lankhorst (3):
  drm/i915/gt: Fix selftests on PREEMPT_RT
  drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
  drm/i915: Use sleeping selftests for igt_atomic on PREEMPT_RT

Sebastian Andrzej Siewior (4):
  drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() +
    spin_lock()
  drm/i915: Drop the irqs_disabled() check
  drm/i915/guc: Consider also RCU depth in busy loop.
  drm/i915/gt: Add a spinlock to prevent starvation of irq_work.

 drivers/gpu/drm/i915/gt/intel_breadcrumbs.c     |  8 +++++++-
 .../gpu/drm/i915/gt/intel_breadcrumbs_types.h   |  1 +
 drivers/gpu/drm/i915/gt/intel_engine_cs.c       |  2 +-
 .../drm/i915/gt/intel_execlists_submission.c    | 17 +++++------------
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c    |  8 ++++----
 drivers/gpu/drm/i915/gt/uc/intel_guc.h          |  2 +-
 drivers/gpu/drm/i915/i915_request.c             |  2 --
 drivers/gpu/drm/i915/selftests/igt_atomic.c     |  7 +++++++
 8 files changed, 26 insertions(+), 21 deletions(-)

-- 
2.53.0

