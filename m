Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B84C4450F
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 366CA10F61C;
	Fri, 26 Jun 2026 13:42:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="OpAGGA1o";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B24A10F613;
 Fri, 26 Jun 2026 13:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481337;
 bh=XYNDq4eXOGhO09kEjocWzK9cHQLXrilgRy5+i3vFxPo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OpAGGA1oloyf6PX2hS2O7QEs/uosX+IaAdciS1qGd2FD8Xeoaa+amacrG6RLk0jHH
 1DF5+9fzWEPzuNyK3LK7gE39YoGOPv3bJa4ob7i4V4eDNL/0VN8Pnx52qQzmENmy5T
 ppCtIiRC0dv2FsA3lttIyWSIkEVukdH2m8DTUPJBap3/ueaG+p72FE90dnH2hDk+Xi
 PRCqfJ9FbTEL+xHTs8o0DnGD3hdSxSos1zr5eHFz4k4yHMkNMGnpuCHeZ//u2eeAQQ
 YzkW4L6ujyftWa4fjbcn4qZ1vYHaVFPdCF8Clkq0pVdXq9XnXm2rGciQeeoFL36eK4
 6E1Kd2ZKUEP9Q==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10.5 29/29] drm/i915/pmu: Disable on PREEMPT_RT
Date: Fri, 26 Jun 2026 15:42:20 +0200
Message-ID: <20260626134222.1198252-30-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626134222.1198252-1-dev@lankhorst.se>
References: <20260626134222.1198252-1-dev@lankhorst.se>
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

I tried to come up with alternative and lockless approaches
to make pmu work, but since the perf events are run in
atomic context on PREEMPT_RT, ordinary spinlocks no longer
work and forcewake and register accesses become problematic.

Disable perf events on PREEMPT_RT for now, without affecting
!PREEMPT_RT users.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/i915_pmu.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 1c3bafda9c708..c2ff315de4481 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -1156,6 +1156,16 @@ void i915_pmu_register(struct drm_i915_private *i915)
 	};
 	int ret = -ENOMEM;
 
+	/*
+	 * PREEMPT_RT has problems with forcewake. Forcewake is used by the
+	 * engine 'busy' event when guc submission is enabled, and to measure
+	 * rc6 residency.
+	 *
+	 * Disable pmu events on PREEMPT_RT entirely to prevent deadlocks.
+	 */
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
+		reeturn;
+
 	spin_lock_init(&pmu->lock);
 	hrtimer_setup(&pmu->timer, i915_sample, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	init_rc6(pmu);
-- 
2.53.0

