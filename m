Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C73CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 14:49:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C67810F191;
	Mon, 12 Oct 2026 14:49:31 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96A810F191
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:49:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1791816560; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HrvjCOEC621Lj66IBQr8AvZvmZB7FZThnZvOpVGlzDyQvsGkmI5Sv4Z6okenYLbWErys+OmyeUjkh1ijvB1eHzKyYWtwLj4dwTz/ydsZ9fqpeP90nJ7NaSqaPf7IObt/CJCRihLnG6qHzIzN1hN1bZT91sWwurYAMNM5iVkQtx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1791816560;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=; 
 b=EL2mL4unNDfgP9Vtt0mVlYiG4bqpI7kvwWmgiIu2Tr+Gbgtc4Nhl7Ag+yXciJsRdi0ZpPKNC8TdtcrQS6mhgcwXhx1Ke15ABP77PRK6o3mLS/jMVa0EXfg7GIzg/1yhJ0XpLCoHi7QR6mJJqM+dI0nhqdA/NGfNdx5+e6J5Jmx0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=adrian.larumbe@collabora.com;
 dmarc=pass header.from=<adrian.larumbe@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1791816560; 
 s=zohomail; d=collabora.com; i=adrian.larumbe@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=n7LLmX7fwJoNAhkMWdIEr6M9fWaQ3kE6c5cMXkSE36Y=;
 b=enpiB3wR3HOHBRtJlba62Ko+EKXJiifTikn9xBZRk9tFd9koaUX0En1+Bk6lwLZ5
 Z7DVXpsMjD/ZVzaUqIeNlA8+5+WlZObTO2u0k13PTJW2oeT1r1crpBN/9M9snT3iyBm
 C7jDf9HU6q3hILsM53sEcKGI2LaVUr7BmaztZKA8=
Received: by smtp.zohomail.com with SMTPS id 1791816558150144.61417515044297; 
 Mon, 12 Oct 2026 07:49:18 -0700 (PDT)
From: =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Date: Mon, 12 Oct 2026 15:48:05 +0100
Subject: [PATCH v15 13/15] drm/panfrost: Avoid cache flush after perfcnt
 sample in fully coherent systems
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261012-claude-fixes-v15-13-bc0a6c498553@collabora.com>
References: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
In-Reply-To: <20261012-claude-fixes-v15-0-bc0a6c498553@collabora.com>
To: Boris Brezillon <boris.brezillon@collabora.com>, 
 Rob Herring <robh@kernel.org>, Steven Price <steven.price@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Faith Ekstrand <faith.ekstrand@collabora.com>, 
 "Marty E. Plummer" <hanetzer@startmail.com>, 
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>, 
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Collabora Kernel Team <kernel@collabora.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1138;
 i=adrian.larumbe@collabora.com; h=from:subject:message-id;
 bh=n0Xb7x+5EOLF5WqM4LToZmyqgsrYoh+WYeTYPUQjIWU=;
 b=owEB7QES/pANAwAKAQ4mfkzuU0M9AcsmYgBqzPMbHK5uwkP8qvP30ESa14sXjz3IZCm5Ftq+H
 K7oIL+O1hmJAbMEAAEKAB0WIQQyQDDowAUXXfk3B6QOJn5M7lNDPQUCaszzGwAKCRAOJn5M7lND
 PQH3C/46ju6dkcHR11d7k0pMwAf9quw7b20MDioBRT6bEF1nlvdqfJdq402cjcmDXAiUuUT3v08
 5ul+r16lzgdJx3ncARtUzvjk3osf4nJCnPmIBZgbg7hDHY4OlAMSu8vc05ihz6ZJUEJdyjx9I6Y
 Esm3VpVLD5KkvWPRl6cBM4BI3UHFhWEaPq7EsV6jbkVvyZZhT0Di1HfsUV3eKtdgqexBH3EpvaO
 j1GORPK6Ch3bG5yO8FSuZ/uI+FlEFt7Ov0mUa6IykXI27dB165+HFBarn/e6gBQAyduU7XRL1q/
 7N5VUfCsBZ+qNvKkjX4QyiKdQ9NPl7PsmKh8jj6x7f1fpopD+3kr0TB+WR1OU6J3ofAp/vCp4AE
 UBIMb0LuZ0c+Uq0p8EXXSaDeFtu2yVcx8tI+sfGHh+0tj6WqBRma38h4h8XjdqfyAS1Y7ryasFU
 y1aHQiCh9oe1PonOStjW7ORmp7o3ZIWDV2EUZj3lGmawPFuoSRZ+IHnvRzxKsJvCiDu6I=
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

If the GPU and CPU are fully coherent, then there's no need to flush the
GPU caches after a perfcnt sample is made available.

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Steven Price <steven.price@arm.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
index ffc77121070e..b3f71d7fd82a 100644
--- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
+++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
@@ -52,7 +52,10 @@ void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
 
 void panfrost_perfcnt_sample_done(struct panfrost_device *pfdev)
 {
-	gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	if (pfdev->features.selected_coherency != COHERENCY_ACE)
+		gpu_write(pfdev, GPU_CMD, GPU_CMD_CLEAN_CACHES);
+	else
+		complete(&pfdev->perfcnt->dump_comp);
 }
 
 static int panfrost_perfcnt_dump_locked(struct panfrost_device *pfdev)

-- 
2.55.0

