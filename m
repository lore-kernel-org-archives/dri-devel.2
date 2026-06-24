Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59362CDE039
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 18:05:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96F3F10F04C;
	Wed, 24 Jun 2026 18:04:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="ZDROC0MH";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C89A310F05E;
 Wed, 24 Jun 2026 18:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782324294;
 bh=N5KhZ0RSeZ3StdcSSUx6eMBPMdhBmpPkvQhNVsbfOxU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZDROC0MHByPb8J4rmZXNASFgSlWcWwgSKLxGdzQUc/9ghumYabdOsFjQgWBFR7PaO
 oLHetK57DWyk2/dfyisVO22/p8BBrck6CY9DhZMkmnzE2c4OBmh4qhqOVyhHkIayc1
 MW4qWN1vYzCNK3VE8DMJRq5+KuAtXTw+TUCdQxhnLglz9Yety0iHOK+3fwlpXM2rhy
 0ZxtjXhE1gVLaFPEmr5a3fli7jppgX5Jjw/sO/WfbRRH0utxyKu6dSiQZCUHgjt3LD
 jc7zXxGQ9zj1bEt5gPeAzyrP6PCcRunas3Q9Bgsb+4Q1YTYx+oQBmXQLQ1rlgLJF6m
 ygPGUIA/mNNUw==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10 30/30] drm/i915: Disable "busy" pmu event on
 CONFIG_PREEMPT_RT
Date: Wed, 24 Jun 2026 20:04:57 +0200
Message-ID: <20260624180459.1024068-31-dev@lankhorst.se>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624180459.1024068-1-dev@lankhorst.se>
References: <20260624180459.1024068-1-dev@lankhorst.se>
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
 drivers/gpu/drm/i915/i915_pmu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index 65771e54b9b51..f381e6f30d987 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -554,6 +554,10 @@ engine_event_status(struct intel_engine_cs *engine,
 {
 	switch (sample) {
 	case I915_SAMPLE_BUSY:
+		/* The guc submission engine->busyness() callback has issues with CONFIG_PREEMPT_RT */
+		if (IS_ENABLED(CONFIG_PREEMPT_RT) && intel_uc_uses_guc_submission(&engine->gt->uc))
+			return -ENODEV;
+		break;
 	case I915_SAMPLE_WAIT:
 		break;
 	case I915_SAMPLE_SEMA:
-- 
2.53.0

