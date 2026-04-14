Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43AA0F9D0EB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 17:55:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABCC110E644;
	Tue, 14 Apr 2026 17:55:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dOYwXuf9";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C08EC10E64C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 17:55:22 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d72875729so1850610f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776189321; x=1776794121; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4R0CQZ/qrW+yRPLga1sILnx+THT1hscnrJSpkR4Elps=;
 b=dOYwXuf9sf06LRNnXZT+rr+8eZRCfT+LrSPvj3EOHPFto1zYmCGI03eaSTYqiqYN8R
 4tOpk7eIyKeYHx+ptMUy/VyL9pnDLlIrD0jjIi5WI2F+g5OohysieLEBXJsx8GXvC7iM
 IuepVZhvQL3gGKwKuj460KMu0JFByBzddS/IzyA4jpGQMzd232lz9tCg0RG+g/ZNaOR0
 jcg/ikmMT5I4ev/faS2VQaTjmFbCMty6/DalZ6P7bgGkWSNNUUbeepw3ojlj2RydsI7H
 v1mPK3vi7e6kK9GqXA3opBRpQluyGsHoM9cJwgWhjIi4UCi/iVuWztLGahlNzMYFABvQ
 ugYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776189321; x=1776794121;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4R0CQZ/qrW+yRPLga1sILnx+THT1hscnrJSpkR4Elps=;
 b=p55f3IAqrfi7QicyZPMXRuFymwN6zh/NrUvGSkkkMaaX3q1LElHxMYpCl5UKJLXk65
 I7KwkfgsQVNQ4RV/R6oSfdscR3X8WjNdEdAnIxTmMICmLHcQxc20UJIUkmgbWcp1Mk2G
 02j1HXQZ6AysusVtEed0OA3DIncU2cAsANkJIgy8SLoqWWYiw1RDgpCF1M9LvgWtF2at
 jU4IyUkDV294Ldfq5tIrYbTy8SFTEJ/0EgwPeMCebu/Bld9AYDACMwERVVCKuRoGCc4G
 9Um146plHdP8Mt0DxomwVTiueQtxD51X750NkYVKHQ8gbpko6jYzMCgfUZQZNnzdWbnW
 IShg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/6JmBvwhqPixRebWpwRkJo7ilTSAk0fr448k9Lz8b7GtkHaNUIjhxjMUP/tmGtyFSrSDu3RJpNciE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0G5HtaL4htbKE8fs4q6g7NrZs/mXNuhmstdc75nqmXeVuzFlZ
 5/c7q1vmHAiS4fOZvLmepToi3ouNyG9/Dr5PYCeeLzSiEZiP+lrYddjj
X-Gm-Gg: AeBDievgXeGz0vsUP1ldU6SOucTjtu99qojOuESq0H7YFrKSKga4fu5KxfL9mBz2K04
 959TdkTfkl/xRYjX6TL93ZZfBfoRyDLPv8t/DpUnXlFzxIHyflJ9KxwPgX2+3bF+sEpLLPyI5dH
 q0bPGBKHOA3yvuyy9nn24S10hoQqQZaEeE4iJfVnuV+su7StL1nXA9+Uq2qjKXpSABOqml/vYpz
 Tnexk1Lp+IzipNI4OAL783qJ4U4EA6ji/yO/jif5s1zMFt0Q6SfXaVOF0TxfqDPssfn3yto+51x
 eNr/uJxTMYaXwbXtJm3NZKLbgyjQ6VSdLzfB5FCYyqftCYDNyFdSGnwl0j85QPTFLDCm3xJQIqr
 2CiwBCqRY+3oqa6ULTOU1YTCk5OQcUW8AymvQT4eF8ur6OzasP6rDotYD6NEbzWTXWdH5bKP8zG
 Yhv9Qvvzzm6YN7Jmymfo5cfgFeVvrsT1AxGQi69/I7QRwI7nkoGlGfYv+1OqJU
X-Received: by 2002:a05:600c:c088:b0:486:f4d2:eac6 with SMTP id
 5b1f17b1804b1-488d67e6776mr181720905e9.13.1776189321058; 
 Tue, 14 Apr 2026 10:55:21 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:cb49:f403:bb20:cc84])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ede1df12sm150436425e9.4.2026.04.14.10.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 10:55:20 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Inki Dae <inki.dae@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v2 2/3] drm/exynos: remove bridge when component_add fails
Date: Tue, 14 Apr 2026 19:54:15 +0200
Message-ID: <20260414175417.144625-3-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414175417.144625-1-osama.abdelkader@gmail.com>
References: <20260414175417.144625-1-osama.abdelkader@gmail.com>
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

Use devm_drm_bridge_add() so the bridge is released if probe fails after
registration, and drop the manual drm_bridge_remove() in remove().

Check the return value of devm_drm_bridge_add().

v2: devm_drm_bridge_add instead of drm_bridge_add + goto remove_bridge

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_mic.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_mic.c b/drivers/gpu/drm/exynos/exynos_drm_mic.c
index 29a8366513fa..e68c954ec3e6 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_mic.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_mic.c
@@ -423,7 +423,9 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 	mic->bridge.of_node = dev->of_node;
 
-	drm_bridge_add(&mic->bridge);
+	ret = devm_drm_bridge_add(dev, &mic->bridge);
+	if (ret)
+		goto err;
 
 	pm_runtime_enable(dev);
 
@@ -443,12 +445,8 @@ static int exynos_mic_probe(struct platform_device *pdev)
 
 static void exynos_mic_remove(struct platform_device *pdev)
 {
-	struct exynos_mic *mic = platform_get_drvdata(pdev);
-
 	component_del(&pdev->dev, &exynos_mic_component_ops);
 	pm_runtime_disable(&pdev->dev);
-
-	drm_bridge_remove(&mic->bridge);
 }
 
 static const struct of_device_id exynos_mic_of_match[] = {
-- 
2.43.0

