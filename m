Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA37C61DCB
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 20:58:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 700D410F47E;
	Fri, 28 Aug 2026 20:58:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="b2o9D1tK";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5E510F47D
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 20:58:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787950718; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=RDJvtmeNxlKAPFz4rgVImrW1gtZA/lvFrwmR2EtmEhxKXAJj4HnUCses+RHI8hkD+Rk3QKHdn6WLqujpe3i37W8gd4lhToU5Pacljh/9XARPCuMD0c1K0Faj1keKWMQ752AlHaWVOAII9eojQb7FEv+h5Z/0LnL1YNvoHIy5Xks=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787950718;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iTscRufj0y1CuqCTDcg3zlIOONoRR3vZY3r3L1e8kjo=; 
 b=A/EpLmUIq2slPylt6wu9lNNqI3HTUkkptL5oED/D+hvKNUnYDmccOAz6phB3B5xD+NFQPOjVioETdBmR0EpRRL9SVAW9qx7uDUpClmzcdX9i+k4CZOJOMWPLabAfdimhogUMRNp4V2LDqGVGbDLaurtmgbH454GpqphmyDHvtdg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787950718; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iTscRufj0y1CuqCTDcg3zlIOONoRR3vZY3r3L1e8kjo=;
 b=b2o9D1tKTjsmaGBdkS2YzdZOjVzh8QgnGNgzQRwd9LhTbe+Tu1K4SCVf11W0eNoA
 i7QyJolz62uutlFJ3Nj/uEqjNSkkEP1p3WdP/ztdXIX4zqpO/tJDwmRqGYgtyUlxOaT
 1Z9gA+GnwSs+K++9oRplj38Nu92IXIRpmypaLS1o=
Received: by mx.zohomail.com with SMTPS id 1787950717289548.8674924881506;
 Fri, 28 Aug 2026 13:58:37 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Fri, 28 Aug 2026 21:56:53 +0100
Subject: [PATCH v7 13/17] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-claude-fixes-v7-13-72a13b2c125d@collabora.com>
References: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
In-Reply-To: <20260828-claude-fixes-v7-0-72a13b2c125d@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=x8OlekE2MZnjNXVk39ugXBQV79er9Wj2YPeLWA8TxG4=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqkfYtsFHAf5bx9QnG2RklsUYQV9t1iF439NjgR
 iw8hZQ1RrOJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCapH2LQAKCRAOJn5M7lND
 PWrKC/9Zp9VOVZFq1/LWg1dP4mW3Mo1dFCu+V6xVBmcuEPZfqlB4QWREn1FCHnUvbaHGZ0sQBuX
 +Hh96S8vbmHrthSxgAiUHKYfd+qF/6XN2F7h6kTOSpbYkasMeCKxT0dNChhASJlB9rsudPeVM6l
 VFRaHEisuoyjswfdTXYab3KfEJ2jsg+pJ1Ml+qaj1rJJaOHsc1Gv5byUTtHaUfdRW1BKEMWp1VP
 pb+kECVvppfDu/cCaj/CdLIoKO5ODK2m4he80Gkxy5pytIHHT0K9MnFetmLgrHtRO8n9ThZpCq+
 M9+YSNiXpyzf7WNl1cLkCOJE0y8BNvFT8Kdzw99rgWz5N2iXtC+i2r0HL/UNhTESmfGV/MP7wPd
 TR6cxbyLzTuGR/8Y/yW6Ex6xK3ld/xCFEwco+hbCcrgvEWf8RZBpVq4B2WdzgEsluvm12mXyMga
 zSbkfPYpjWVajU4tQzLF7BiwLoi5+K0lj7F/xABGMsoarMnLRg1E3t/qa+QuNVbvUEhkc=
X-Developer-Key: i=adrian.larumbe@collabora.com; a=openpgp;
 fpr=324030E8C005175DF93707A40E267E4CEE53433D
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

The GPU cache flush/invalidate operation is unnecessary, because at present
all counters are always enabled for all sessions, and there are no plans to
expand the uAPI so as to let UM select specific counter groups.

If the above was ever implemented, then different counter groups being
selected between sessions might leave stale data in the GPU caches, so
the flush/invalidate would have to be reintroduced.

Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index f71534e741b6..ffc77121070e 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -124,21 +124,10 @@ static int panfrost_perfcnt_enable_locked(struct panfrost_device *pfdev,
 	panfrost_gem_internal_set_label(&bo->base, "Perfcnt sample buffer");
 
 	/*
-	 * Invalidate the cache and clear the counters to start from a fresh
-	 * state.
+	 * Clear the counters to start from a fresh state.
 	 */
-	reinit_completion(&pfdev->perfcnt->dump_comp);
-	gpu_write(pfdev, GPU_INT_CLEAR,
-		  GPU_IRQ_CLEAN_CACHES_COMPLETED |
-		  GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
+	gpu_write(pfdev, GPU_INT_CLEAR, GPU_IRQ_PERFCNT_SAMPLE_COMPLETED);
 	gpu_write(pfdev, GPU_CMD, GPU_CMD_PERFCNT_CLEAR);
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_INV_CACHES);
-	ret = wait_for_completion_timeout(&pfdev->perfcnt->dump_comp,
-					  msecs_to_jiffies(1000));
-	if (!ret) {
-		ret = -ETIMEDOUT;
-		goto err_vunmap;
-	}
 
 	ret = panfrost_mmu_as_get(pfdev, perfcnt->mapping->mmu);
 	if (ret < 0)

-- 
2.55.0

