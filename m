Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505BCC55179
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 13:53:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9556D10E040;
	Mon,  3 Aug 2026 13:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SNzVJbhv";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1576010E040
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 13:53:29 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-84eb992a881so2715516b3a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785765208; x=1786370008;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5Gx76VJyX4gBn4VLPhypngQoj/jr3IBftVHMJXbc1Po=;
 b=SNzVJbhv6hFbuljb9o4pU8RjC/E8qzRi4BmnVvPAvF+Sy8dwUMi1MfFeNd52vzPpya
 hwcRW+dQgoFfo4SejgEKAqI5lP/tMaKs+hf49L+MvkW5oGG+2fpYF/ijp/32hF/pUxWa
 Ebk5EsaYu63hDYylTXA6GUZmOM+UvgQJX4CZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785765208; x=1786370008;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5Gx76VJyX4gBn4VLPhypngQoj/jr3IBftVHMJXbc1Po=;
 b=qvA6NZ1xXgUIikKTDSxh8iycRbt4KVMVJLNzFt0swoktQccOb/p3uvqu++o/z85fOU
 CvvThdxOTaXmVpHgGD9GSzQ8xq3mh79scV5x2a2Iwx7Rpeq39Qn/e3L5tN8h39OftfBv
 sRrJIdp7H9oq6/rR6K352H+wnmQyy0VdEc7ASBVIJbRm1g0+lj34y2mgdWxcjfD/GnyF
 hKnA4abZ2tFAjFiQIfITe6xIrKU/dqJbhVIod59YA5yGWu3xxhsc9vKBXrLWfN2pvXQv
 0xOVVd9aT8kEAHnR7TdQdSNRixo3qOVBBx4iZH1wbY7yKMx3wxUlRYoQuLJT05Lqzeyl
 NnZg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqHM+0SeJKBDTIPrJGB2ReFpqFTfmJFtkKWq/92KKr2UY3c/ArawO8MWshkqxzcE+g9M4c7+J/8ETk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+PL7GwWgDGEGVFO8EaKDrFfE/7Z6LDkMR1s102m8sYaWHYtqv
 X9XXX+toXqcDvzH709n4XxSYobqWtZvIQTSiqV8xoVgje/WK0OCTu2lacjo7C00f6g==
X-Gm-Gg: AR+sD109YIQ9TyHeO0V+PUu6MMCS3QfbIleuZzKSGgVh/jIpk/4bqCT2KYrTdmCo1tr
 JTiTtRcnADx+SGrLzE25b79c+yirE8AQu2fpNg3olrBCEfMa610Qb+5Owe4XYTHmzBc+KS+Q7rb
 uVPE57MQKmC+hzHXiyVqdTkD9ZX3Zr2FUH7L9pj8uez9+TE396t3qcJAYuZmTOjSMIgAoulJobC
 y0BPOKytuYsiHx0iJqyOcoFYjdTp1Fc7miZEsXDrpeZpDY4DZbdmSHKes7AFLJ177VnlZai5pjp
 FqA2QyZW20omI39OhgPl7fqiIwzhXwWCSHDD/B4S9XiqT04IrEUMXFPyH+0e4BO4pXtuY1A12Sv
 6CyxX0LYWwiDYP5Op0+sdehYONsqH3Ec1ihBZ1w4O5s297g5YvI37DHq4kgFy79Tp7aCvJuri5U
 XodJsLej0loqt7ChIsvSmHebMBk1ojdmxSGi5nxd6kajr/afkEadG0luRbaifxqAWbkw0/nSacu
 7B+yGGBKJK0tiq45QwpvInrXNIq2eBYYnt+4bwsIvASXg==
X-Received: by 2002:a05:6a00:399b:b0:848:4ff5:5316 with SMTP id
 d2e1a72fcca58-84ee480a3c8mr9142674b3a.19.1785765208605; 
 Mon, 03 Aug 2026 06:53:28 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:1c0b:57ba:92e2:e178])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84edbe7a243sm3757511b3a.24.2026.08.03.06.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 06:53:28 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos/gem: Drop extra "0x" prefix in front of "%pad"
 format
Date: Mon,  3 Aug 2026 21:53:21 +0800
Message-ID: <20260803135322.2898247-1-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
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

The recent size_t format string fix for exynos DRM driver left the "0x"
prefix in front of "%pad" format around. Since the pointer format output
already provides "0x" prefix, this ends up adding an extra prefix.

Drop the redundant "0x" prefix".

Fixes: 3470274dca48 ("drm/exynos: fix size_t format string")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index 0208c9259572..acb8def747de 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -80,7 +80,7 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 		return;
 	}
 
-	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%pad), size(0x%zx)\n",
+	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(%pad), size(0x%zx)\n",
 			  &exynos_gem->dma_addr, exynos_gem->base.size);
 
 	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
-- 
2.55.0.571.g244d577d93-goog

