Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F41DCDB479
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 13:27:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDE9610EB54;
	Tue, 23 Jun 2026 13:27:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="O6vdorvQ";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C07D710EB4F;
 Tue, 23 Jun 2026 13:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782221233;
 bh=MWINgKnez3Si9U+9oFKEzeA3B6yr8jWb5/gCHBL5Ulc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O6vdorvQFrswI5pQDiW+P7TtQaEFCmHGC+5oOEftnhK/vZ17Ufx6ti/U+kKXYrU6D
 dTCy4pkVunrV5yzSstgi5IZyX7l2lXEg1QC5YaTUK7+fEYDcPo8seEWwK/kSLg6b8L
 vJC7NtL40HhuvL6ovhnjTzy4KayIOpkJk+RDUZ66u+8pHqQMEuiaLxuUUaomHD025T
 o32L1aITl00BV5AX05TY++36v6i3AqXVZhtxRWCtbzUQKpSrI6bYAhtZ+5OEGmT32K
 5MUJW0vsDqFrDzIGlbQC48+jE2Fd6horAlC/HYmlZf1Xs/y6demnLubNPcMcaXTtLW
 TIYJn6ZMJDW6g==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v9.6] drm/i915: Disable "busy" pmu event on CONFIG_PREEMPT_RT
Date: Tue, 23 Jun 2026 15:27:34 +0200
Message-ID: <20260623132734.227322-1-dev@lankhorst.se>
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
index 65771e54b9b51..d5fc47dcde3e3 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -554,6 +554,9 @@ engine_event_status(struct intel_engine_cs *engine,
 {
 	switch (sample) {
 	case I915_SAMPLE_BUSY:
+		/* The guc submission engine->busyness() callback has issues with CONFIG_PREEMPT_RT */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(&engine->gt->uc))
+			return -ENODEV;
 	case I915_SAMPLE_WAIT:
 		break;
 	case I915_SAMPLE_SEMA:
-- 
2.53.0

