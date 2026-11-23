Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4EC606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YU6k+T/9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CD310E621;
	Mon, 23 Nov 2026 07:30:03 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 809DB10E64C
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:29:57 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2f04bea9a93so24547255ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1795418997; x=1796023797;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=//n+yXTTWwOoj53xnhWaCufs+Tzw/vagwNxTFu40FWk=;
 b=YU6k+T/9LIh8qdYYwgy9Uv9q4EOO9CkFsZIidbKnsVF9xS7EaX2Zz63xt5K/qFGu/Y
 CVpXp9MWfRZpD18h873sH9tB/B16gyUjlP5EsYqRuIePiRdFQKrvXXDwxG1xCiEDfwzZ
 NW29mUWIXlZ2PciMlpuf1cKGqCswFeSIk68KY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795418997; x=1796023797;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=//n+yXTTWwOoj53xnhWaCufs+Tzw/vagwNxTFu40FWk=;
 b=EOQ42VacmBZZ6jtuFaSgLez7X3VGZm6gB926NJdRGB0+cxuT6mjSY7QHw69DWaJJf8
 13Isd9x8Nswdzhmmgkf3NQmSJZjlVujodnq4pLnlfUlDvMRxatyiiQSacJC8+Q3pBgcO
 Nlv70ixbMnxlHCaS67/oqcsF8IkMnqA7ya3NaymRqopGN7rpBbGWDZ57g1nXhF9JPZrA
 3OSXPoPxcfynpBKa/IRDQ6WsTCr8uU0G0F4ijzxUQEyIy4flFOfUhXYVcDSMFXbHhPM4
 pez6Z3OZMjeptDYsXsBrhpI/mDshMFJp3894X0JmF3a488dliXYQudhlw5JluN6f25o9
 FoBw==
X-Forwarded-Encrypted: i=1;
 AL+hErE/kT8Qc0Hx1wShimNZzjf3ikBY7V763GP0TAEFcJTC8YUr7QGO63MFeIKIbAZRim2w6rLVOiLFxzU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/wHUhsRgc6wYfZ2DcijFlH7JwJ5KsymPrTu4/+yDu44uLGbtce
 lVV5oFu6roKaxjCBfHifp/+IK2hGYGANzCh+aTeNJGpli5tHhDczY2vBlrSo7xk5Gw==
X-Gm-Gg: AZFdTZfFwk/8xbLdIHYj7gwFOWglanwSHMxq7Ca8WeA6nwHAziBxmfo7KS3VSAni95n
 iu/iqScBel0KZXJNBCOi1M3eOWncycIpOyqcSMxWfAZFr6CZFUVuNozGYt/e/bBGsKmG3u2DGq4
 PgLhpAJiFid4SKDK/ZdB+560A15DBTxfpLo/6QP71cAkqOs0UZu8a/HhYxR6ez7iCas+5giHKlF
 hf7rYPYAhjVH3zxGs8nXJwTniW+TFPdFl5LCXts9v9OFC57/xBtz02RbqTbZI8c7SPGUp9/s3ji
 e40kJGcJs/HAplvJP9koI3Vtj3hdz1m9cjNbrZ3I8Oolg4B5VqZoXUj9EnI32Y8Pk7OijNrAMUw
 bYCiwQ0oauudkTo1ItAZg/yX5gfT/oSDj6wbPGsdACL7jUvdqunMrlpFWkXb860qsT+DT0aYyaN
 7CK1Sy/5/NWy4Ein2u4Pv6VzilLGE7GDZmX2STItcwEXIhtwKaScfFo/UbFZm+Pj2cvr74tNTaG
 WGGVQYX2KFLFoMb5bIkq9j+OBwpxp3YD5+/Y4pN9CZAodkMwP4zdQffjWXZKjaYOfyfyOBS0xBy
 1XEPoAonj386oU0oN51G1AeRcXRikkj+mflcRP2d7Gr36pzjny/T22r19Yo4EA==
X-Received: by 2002:a17:90b:4b:b0:3ab:e588:c2a8 with SMTP id
 98e67ed59e1d1-3b41c9ba0e4mr9010636a91.64.1795418996993; 
 Sun, 22 Nov 2026 23:29:56 -0800 (PST)
Received: from localhost ([2a00:79e0:203d:7:ceb5:5e59:832f:d16b])
 by smtp.gmail.com with UTF8SMTPSA id
 98e67ed59e1d1-3b41adcafe0sm17780221a91.16.2026.11.22.23.29.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Nov 2026 23:29:56 -0800 (PST)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH RESEND] drm/exynos/gem: Drop extra "0x" prefix in front of
 "%pad" format
Date: Mon, 23 Nov 2026 15:29:50 +0800
Message-ID: <20261123072951.2239442-1-wenst@chromium.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The recent size_t format string fix for exynos DRM driver left the "0x"
prefix in front of "%pad" format around. Since the pointer format output
already provides "0x" prefix, this ends up adding an extra prefix.

Drop the redundant "0x" prefix".

Fixes: 3470274dca48 ("drm/exynos: fix size_t format string")
Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
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
2.56.1.831.g720f3f5937-goog

