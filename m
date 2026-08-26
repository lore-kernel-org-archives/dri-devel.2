Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8767FC61DBE
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 21:19:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47F210E375;
	Wed, 26 Aug 2026 21:19:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=adrian.larumbe@collabora.com header.b="Q4hO2XAv";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C65F10E375
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 21:19:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1787779168; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VvBq2Y5S2aRXuoQ1zWX49lG18ncBIQzYVX79jhmh8qqQJpVWbwjIb0/PFWxMKslEDWfyDsp3xF1TtTSpWG6Bu1aaZVlWMmCGa0yu/fDIEA1FTG2+rpRXklWZYeLkIyx9KGxJ6cTItgUPvnUsIuJpXoxOYbrwQuI9/7YQgIYH+dg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1787779168;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=iTscRufj0y1CuqCTDcg3zlIOONoRR3vZY3r3L1e8kjo=; 
 b=gXS0xoRwBr+1P087sBcQXdy1Cz+pi2u+w1n+xuxWN1nI/OiV8s02ZpuhRcKLbgXR73Po4Y1CzZXLzAmIb46T6aACM0r3hscQg4UfFsvO/1kAQNAEoCY/zD6FQT6d2YtPHl5bHgKnf5llrIHW2QGGqO8KQDpfy4HFK6C+Pptv/yc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1787779168; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=iTscRufj0y1CuqCTDcg3zlIOONoRR3vZY3r3L1e8kjo=;
 b=Q4hO2XAvzkYUxwuoPGCi2ujjLP0IIYT+5abdyzVLs/880Bpfeo7cldtQpRHcChXK
 eP+qWjXmjm8JwD1KAvggdUwBgY0LmAJNiNbAo+aXMxPWU1Z0yj2TvgLEyXiA6JpxgNf
 Ck9WRTIbuXpxyI2gBeEe3DUWqbqKdsIHKaYpECTU=
Received: by mx.zohomail.com with SMTPS id 1787779167543598.8334119563925;
 Wed, 26 Aug 2026 14:19:27 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Wed, 26 Aug 2026 22:18:14 +0100
Subject: [PATCH v6 12/16] drm/panfrost: Skip cache flush/invalidate when
 enabling perfcnt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260826-claude-fixes-v6-12-78119af409e7@collabora.com>
References: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
In-Reply-To: <20260826-claude-fixes-v6-0-78119af409e7@collabora.com>
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
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqj1gMf4kK5sSCLj82Z32bZTx32n9pMBu1WlCpq
 /ZamlO18r+JAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCao9YDAAKCRAOJn5M7lND
 PVcSC/9Ezy6dIBOMp9hB0BTby8aXMPHJzzjIyImQn1wHnC5qr9SW0gT49aOOVZbK3vmErCPGpc0
 DLPl+AkmL4kFcjf+j87sWz/fYpt12JNBmOgZmrogx0NRbpFS2Txyi2gdpnp0tN+C0Hamu5213eJ
 LSAzeUfFOwIXHxlS0iPvuugD4aglRRE4gyN1rMzL/j1aVoJuJkYLUya13TMtGnBC7YUiSBK+wud
 Bh0Mro++DTxsY+Kc5HHC6HrLpeTEFT2wiAQHO/ERoyFk6pMUVGCUpP73EBpWyC+wustSHrVNH9A
 F2uKxX61BOypniRmvIIEQStAZLdVg/MfoqsJ72LMzpZgi9xihp7qFY25TVoII+gzyPOpIxSm341
 9+6UgBgB8THs94ExA9VfVn/BrfolWX6nCI/82Malv7NbxApl8O3Z/VVI8+FsSuk9WB+2idoz15Z
 1CTIF66RuRDutma3QSzos+E8qGP0R1J3GS9Mb0dN1h1qx+mWnq3Vcj0Cnv97RPHgj9EwQ=
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

