Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41CDC44519
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E701A10F603;
	Fri, 26 Jun 2026 13:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="WrEnaoC6";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B78210F5E5;
 Fri, 26 Jun 2026 13:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481328;
 bh=Oh1os3TsHNdW2Pq4AI0gYhWG24uRvSoJ0dx3b6zoRio=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WrEnaoC6FbrSPbruGhhufYYPc0Elst2sPqNbMv6K6PienLGWXwJiqCXmlTyPfpQb9
 7wjBUlnUAxyCmDoST9U9pJjvMcP4TPvv7m0nz2RauryK80zskhac4FUCcfSHwbVIK+
 lpo21epzqX6AWqHF26O5uwl9Lr7Z0Ig0oYt+sAzkCF0PFJEcieYPYLVURUznV554go
 gwCeJfG23gCBx+KsgDpnCwjfSYuIzHM94/zvvl5MXbNWlPgSRCdHU4wXJHayoZp1AF
 0uzHiYeRjJGX+x6cygPpx9zi/ty3dJMwR4qy4AnptkBXsq18N9KjzI9AogVwx5kksA
 8tigVXY/io2Cg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10.5 16/29] drm/i915: Drop the irqs_disabled() check
Date: Fri, 26 Jun 2026 15:42:07 +0200
Message-ID: <20260626134222.1198252-17-dev@lankhorst.se>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

The !irqs_disabled() check triggers on PREEMPT_RT even with
i915_sched_engine::lock acquired. The reason is the lock is transformed
into a sleeping lock on PREEMPT_RT and does not disable interrupts.

There is no need to check for disabled interrupts. The lockdep
annotation below already check if the lock has been acquired by the
caller and will yell if the interrupts are not disabled.

Remove the !irqs_disabled() check.

Reported-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Acked-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/i915_request.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_request.c b/drivers/gpu/drm/i915/i915_request.c
index d2c7b1090df08..f66f8efc70629 100644
--- a/drivers/gpu/drm/i915/i915_request.c
+++ b/drivers/gpu/drm/i915/i915_request.c
@@ -610,7 +610,6 @@ bool __i915_request_submit(struct i915_request *request)
 
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
@@ -719,7 +718,6 @@ void __i915_request_unsubmit(struct i915_request *request)
 	 */
 	RQ_TRACE(request, "\n");
 
-	GEM_BUG_ON(!irqs_disabled());
 	lockdep_assert_held(&engine->sched_engine->lock);
 
 	/*
-- 
2.53.0

