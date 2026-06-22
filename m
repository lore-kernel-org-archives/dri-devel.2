Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FE5CDB477
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 18:11:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A3EE10E814;
	Mon, 22 Jun 2026 18:10:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="acAiKXA+";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3A7C10E803;
 Mon, 22 Jun 2026 18:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782151844;
 bh=aJ674jKfdfYzA1796ckniFKjkGKFKlysonuWe+TKQpQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=acAiKXA+bI/m9BvYsYkrT5cA4qzXvjlxCo5wkxMnoH2NCSjMdF6IQINOydgVbhLnY
 xSGNWdYns0tAJAMg1yFkQfolmgoQWF2/SPCVOGfig04eCtKRUlEGtmUKAZ7nqD8p+J
 TH+i1Em838f9XGTv7UasiRm61JubUFujtrP1l6qUl1TeN1UkIqvqmEwp6RiOOkk5RQ
 fCCW2RhY2lWfPy25bZHbdr2LJZFhSXHXAfrFh0QQ0ErLU79ZjoAwXz5Dskljicwrvs
 P7aT02xjT9vgdChX9EH/YQN525Kdo2gZlpLn9bepwqiu9Z7Oypqi+fCyFzKeTeX0Aj
 X2h+jXsB3rjLw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "John B. Wyatt IV" <jwyatt@redhat.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v9 17/30] drm/i915/guc: Consider also RCU depth in busy loop.
Date: Mon, 22 Jun 2026 20:10:30 +0200
Message-ID: <20260622181044.39335-18-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622181044.39335-1-dev@lankhorst.se>
References: <20260622181044.39335-1-dev@lankhorst.se>
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

