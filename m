Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2372C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 10:40:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435B810E8B1;
	Mon,  6 Jul 2026 10:40:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="UYAhwL/I";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34D2E10E8A0;
 Mon,  6 Jul 2026 10:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1783334407;
 bh=aJ674jKfdfYzA1796ckniFKjkGKFKlysonuWe+TKQpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UYAhwL/IIqFFNJqFY237V/Du2BYi6wdppD+r0PXlvH4vB0US0oTDyS4G1Gt2HYSyr
 ZECrq9Hq84EngHze8GyuIqsNKXTkFtlCSLXqHqWGpJ+aSLldw5T9WC2IP7Q2mEUIW+
 zwytVZqWwSxoRmcq/y1Qu+FIE1yUk7E83uapU5ekbjpVGKpkAtCOKk9i3fqrHHasL1
 j6hBpmEbItfS8PIbzb3cjg3+hmiJGEJsNx6FprCS4OYOnUV4gP/H44ysatol/v06HA
 mQvyhrK36hLW3EjIYlDH85Tc2L4rkZ4CSaK65Zhd2rccQFByGu0wfwc0hc++OxHBop
 qhGBHyzw53oYw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v3 3/7] drm/i915/guc: Consider also RCU depth in busy loop.
Date: Mon,  6 Jul 2026 12:40:38 +0200
Message-ID: <20260706104043.726178-4-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706104043.726178-1-dev@lankhorst.se>
References: <20260706104043.726178-1-dev@lankhorst.se>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

intel_guc_send_busy_loop() looks at in_atomic() and irqs_disabled() to
decide if it should busy-spin while waiting or if it may sleep.
Both checks will report false on PREEMPT_RT if sleeping spinlocks are
acquired leading to RCU splats while the function sleeps.

Check also if RCU has been disabled.

Reported-by: "John B. Wyatt IV" <jwyatt@redhat.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
index 053780f562c1a..b25fa8f4dc4bd 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -362,7 +362,7 @@ static inline int intel_guc_send_busy_loop(struct intel_guc *guc,
 {
 	int err;
 	unsigned int sleep_period_ms = 1;
-	bool not_atomic = !in_atomic() && !irqs_disabled();
+	bool not_atomic = !in_atomic() && !irqs_disabled() && !rcu_preempt_depth();
 
 	/*
 	 * FIXME: Have caller pass in if we are in an atomic context to avoid
-- 
2.53.0

