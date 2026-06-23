Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D13ABCDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33AD510EB3B;
	Tue, 23 Jun 2026 12:57:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="IRLI3ZAA";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F10510EB37;
 Tue, 23 Jun 2026 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782219449;
 bh=JS0M9r7CwPet/6DU8JqLngOA8EMgWZN5+is1R4jMjvg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IRLI3ZAAejrmZH7VDmRcARI23Kz1vLDQvdTnBzz3SGNzoFTLNt05T0eCQxNbNJuvv
 qqTRV1KNPJs7zl9ecIw4NHBtOehTpYcfOTypEZ1mbraYFy3CcH4ID2alexpg1aElxw
 pTu+b7zTOxEU36lTUL8urHif5dQps8N9FDbEvsnzRDiuo8p0TM0vk7BaJ+6sPV75q7
 hADRPcExXk5GRdHHtB5op3vExwxKkTigZeGGbsGjf3RFVWbWlXoGglsKSG+ksIzpCg
 GWtsYfjYqohiwtz4I09LM+Mnt9/zGIZVpoguu2P6Fj9K0zaD4H5Z9W7Nk1WmRqtmyq
 bGtZG2iYVl5GQ==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v9.5] drm/i915: Disable "busy" pmu event on CONFIG_PREEMPT_RT
Date: Tue, 23 Jun 2026 14:57:45 +0200
Message-ID: <20260623125745.179419-1-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622181044.39335-31-dev@lankhorst.se>
References: <20260622181044.39335-31-dev@lankhorst.se>
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

The busyness implementation for guc is incompatible with PMU,
so disable it to prevent upsetting lockdep.

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/i915_pmu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 65771e54b9b51..f8bea3ec458d9 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -554,6 +554,9 @@ engine_event_status(struct intel_engine_cs *engine,
 {
 	switch (sample) {
 	case I915_SAMPLE_BUSY:
+		/* The guc submission engine->busyness() callback has issues with CONFIG_PREEMPT_RT */
+		if (CONFIG_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(engine->gt->uc))
+			return -ENODEV;
 	case I915_SAMPLE_WAIT:
 		break;
 	case I915_SAMPLE_SEMA:
-- 
2.53.0

