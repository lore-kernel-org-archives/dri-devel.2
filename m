Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44737C44516
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79AC710F60C;
	Fri, 26 Jun 2026 13:42:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lankhorst.se header.i=@lankhorst.se header.b="WZPApR9o";
	dkim-atps=neutral
Received: from lankhorst.se (unknown [141.105.120.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ED6810F5D8;
 Fri, 26 Jun 2026 13:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
 s=default; t=1782481331;
 bh=0xLvIPUF7dUXs0cb7vXUK9dMYuEsI+fTHrltlGFTpL4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WZPApR9oaUOhMQ1DnQ0Xi9RuugATCAIy481Fl6fDlPdibX8jRrd9qBgBgHYEBOb9A
 +UMWNSyKvX4chFs7+bL7RcescoTAXmXcms3bhbtmVf9GIWugCTdvRUyhZCVrs9ok5J
 9S/LY2pyQ+Nyo8B+6teE457RN5jCFF2g5/4v9mDSFPMR+ZODjMwrTGMxly1mLY/Juf
 NUFeRBiFX+Y9hs4PZDsGkyJFxqXRDnkj1Pk0D7N4qidhS6TU6PzO3LDUppcNR3E4Jr
 uRFbFHz5iPUUB0RejlAI066vwN5QHVJFg0BZ3qojuGBegNWP9VeaQuqfHyq9Lf/gQK
 PdjXRwzwEsjmg==
From: Maarten Lankhorst <dev@lankhorst.se>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <dev@lankhorst.se>
Subject: [PATCH v10.5 21/29] drm/i915: Use sleeping selftests for igt_atomic
 on PREEMPT_RT
Date: Fri, 26 Jun 2026 15:42:12 +0200
Message-ID: <20260626134222.1198252-22-dev@lankhorst.se>
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

This makes the i915 selftests slightly happier, especially
related to GPU reset.

I believe this may be a better approach than trying to convert
uncore->lock to raw_spinlock

Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
---
 drivers/gpu/drm/i915/selftests/igt_atomic.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/i915/selftests/igt_atomic.c b/drivers/gpu/drm/i915/selftests/igt_atomic.c
index fb506b6990956..8ae39cf570b76 100644
--- a/drivers/gpu/drm/i915/selftests/igt_atomic.c
+++ b/drivers/gpu/drm/i915/selftests/igt_atomic.c
@@ -39,7 +39,14 @@ static void __hardirq_end(void)
 	local_irq_enable();
 }
 
+static void __maybe_unused __nop(void)
+{}
+
 const struct igt_atomic_section igt_atomic_phases[] = {
+#if IS_ENABLED(CONFIG_PREEMPT_RT)
+	{ "sleeping", __nop, __nop },
+	{ },
+#endif
 	{ "preempt", __preempt_begin, __preempt_end },
 	{ "softirq", __softirq_begin, __softirq_end },
 	{ "hardirq", __hardirq_begin, __hardirq_end },
-- 
2.53.0

