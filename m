Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F043B106F30F
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 09:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60CCC10EA22;
	Thu, 26 Mar 2026 09:31:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Znt5u9Ms";
	dkim-atps=neutral
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1B2010E03D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 09:30:59 +0000 (UTC)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-82748257f5fso944378b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 02:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774517459; x=1775122259;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AhfnsBmjL6PTqSJ6d1w99Feh6f2YhYZjbZMXjyNjc+Q=;
 b=Znt5u9Ms8obIp2nX4BzTHrY+ZKmTja8VEhVH+Z3iXtvuf/csdol8vRnVl9C4FFmrla
 5pTmVz9cIanqwteM0OJ2XGXRx6nrC1Z4rYmLJjieqyE7zKUTXNLC9arZWELtCZ3aYJjw
 PHiyZ6D2cyyY9QVcszAWfTMJCdVNL4zVLUJIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774517459; x=1775122259;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhfnsBmjL6PTqSJ6d1w99Feh6f2YhYZjbZMXjyNjc+Q=;
 b=esnrmn/wt78qW2mJkjkPIMZyKJQHDOBfsKT3ocX0o/NeP+tT1KvdiXNDQpn9IhsCtu
 K20XUj+iHryQnuA58D1mSl9JJtovK0bZvYNndd9PZnWa+2wRW/+f0XFrKZIIwKxMH4bU
 gmAJ929Ok/e6KGiLxPmwaj0ZoKerz3TezqOCUo2dmjGJiATy35bb/RBOB2+rr7MeN/OV
 XldRTdvPxBUKOhTS0kDM2j0W82ZIOdTD3T+SyjPVQT8hkgRpksRHaEXARSKuBtFlqQhy
 lxbbgm2XwuCST26753h9ML9b15fFi0VOGtYObdu6Zb13mRj5DjhKAHxqRpXiLcIGy560
 IKGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE3j0k2ATRJimuFICJLxYWHWw3MVeQXDv5XR2K+37Aud5zvQedlDxdOGOCagL7Hx47AZyT+lbQbSk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw3/qlskLCsp9LsjwQcVEWoWNDc5Nx1SC8e4SHeh+Kqh+sJMudQ
 S4sMhkB0oFZ4ysvKfDe+ZH6oga1ZT85i2ybtPQQ1FGQJXekBycfQ4mx5qCHkEAzSiw==
X-Gm-Gg: ATEYQzxgt5jsh1DXCmTYbcgcbgSGtstrqiIgbqAiUsaKutuJBt2W7YctPLHgx+AO6EH
 pSuPKyEA/ONih2SPpRFEUh6cEHKH2U+tLNARSfXA1JmnfROmg8IhUJ54pNzpx4wUFXyTH0rfiA6
 Isr9SZu9K9R7nC2pcAPAzjtlMnG5jbCaaXovUoAYDnunTe6aJ0c/8Ukvzj6PRwe+Lo6DH8dnfRv
 fjZAnyt+SMWf3o7Jv1D53kLCk7dLpHyOr7kazYiwwCn+FNEy0/TwdcPo90NTAOVbppVIa8UGwRb
 JBo9AwUaLZCRDcP/xr+YFG+Gir7g881aRDcBszx8btlx1rxBG6IAvXAAuSCW/0jN3Yk8MlnZOMs
 Oll/Vf3PUxzXHltQlp4tMpfw+F2S9iUWpJ/vhyaelMuSTLtvEntV6nD+HukWhVlVhHdifMezgBK
 sFDC6lMGnqoV82rPbnlU4kdMaA41Ftz9Qp1wUj/me5YXe3CtYGCo5oW7VSR2h5425kX8z2cEzwY
 AeDV5Bk
X-Received: by 2002:a05:6a00:2d99:b0:81f:ac1c:709e with SMTP id
 d2e1a72fcca58-82c86a1e9f4mr970524b3a.31.1774517459022; 
 Thu, 26 Mar 2026 02:30:59 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:3ed5:7e63:b37c:a7d7])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e1502sm2130970b3a.5.2026.03.26.02.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 02:30:58 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/exynos/dma: Drop iommu_dma_init_domain() stub
Date: Thu, 26 Mar 2026 17:30:38 +0800
Message-ID: <20260326093039.1152770-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
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

Commit 1feda5eb77fc ("drm/exynos: Use selected dma_dev default iommu
domain instead of a fake one") removed the code around creating a
custom IOMMU domain, but forgot to remove the stub.

Remove the iommu_dma_init_domain() stub as the function is no longer
referenced, and was also made private to the IOMMU DMA code.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dma.c b/drivers/gpu/drm/exynos/exynos_drm_dma.c
index 6a6761935224..ccc6b852ee7d 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dma.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dma.c
@@ -23,10 +23,6 @@
 #define to_dma_iommu_mapping(dev) NULL
 #endif
 
-#if !defined(CONFIG_IOMMU_DMA)
-#define iommu_dma_init_domain(...) ({ -EINVAL; })
-#endif
-
 #define EXYNOS_DEV_ADDR_START	0x20000000
 #define EXYNOS_DEV_ADDR_SIZE	0x40000000
 
-- 
2.53.0.1018.g2bb0e51243-goog

