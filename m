Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D55D8FD5F7F
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 06:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 285A810E0C5;
	Wed,  8 Apr 2026 06:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lVlqRMS9";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B55010E0C5
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 06:49:45 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-c06cb8004e8so2229088a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 23:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775630985; x=1776235785;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q/MofJKHc8I+/Pub8F3lPg5UDKLJc1Wt+gTwGRRfhuM=;
 b=lVlqRMS9eWPGH3TiiyQzfD4dY4xaHnszHA2OdvR4/vyPxjVxTndwpmrbjLW/frF6O9
 x+Pem/0+MoIn95vxLHQcf69pZivVOTKV/QsmkMyua4D5gpgj3nZ8Q/EJOUrAfnSn4Tuj
 P+l1WOv73QVB8pSgebeiI4/a9AgZCX1NU4R5Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775630985; x=1776235785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q/MofJKHc8I+/Pub8F3lPg5UDKLJc1Wt+gTwGRRfhuM=;
 b=J9Vmt1MEdOFfnEHSIJQpWWfMo7CnEbxvC8ivRoJWZZn/k5/L1WdG9+zheh/8geGT29
 Vqa7n0+H3PO5r0Ko19Um2Dbr36wVBbIAnRdi9RnoKx+h0ZMNvtMEJARmLgzzuSCT9bEB
 wcnE1QVA3sp6eFpfDPl5zp9mZ7p4n6AIZvN5a2eFPCH0iTGI9M4eDCRmQy36LI6tiKro
 ek9eSB3lihhdlIu4fv9K/7X41ic4p1WlklfKwAmwMlq91YL1b59EgObLLK42XgTDlj3t
 lPRqPr0ia/QYfPdvGRELUI8wPK98WaYZB7Zmpf+MLC6plSlbbmIhRPDrWXgAsL7Dq42b
 RDJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCHYlqvMOiGRoRIGqVImuFhIN0MY4JAiWEfn4iOUs/dZz1yqefwuDQZUOib1VNw8fsWoNobpndNLQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxvPwQtv4BnN0aJk+ohB3YC6rawJvQW4/N4VHq/RDAftDV+pAt
 0AFLTTLAluZ2ZRJf+QoZXVuKMHG88F9CqcmTsw9uoaOXg5GFT/0dnhk5Am9qqXttjg==
X-Gm-Gg: AeBDiesd+B+j60OY8XflafBfXzxYFVc/cVc7sNQ+l2SAVefcQb4wMChzvwTIgbvRHVB
 7cMI9cMAIkbPaDvKOFGZuHcLu7JIKrZM+5oklFYfN51Lr/TGWG8OTNIztYmfhHK+QIKsOpvINqi
 N16fUydDDF20gNxP6Ijn4ANuZSK7j/nO438KWaTdQfnypqR7VwJVY3mLa270HtQbWAVd9l9EQ/i
 2ZXn5GLNyYfYoOOs5kEz4YpKdecNKB9QF2c7xk2FqJ89pF+9Y/jEV/PdQpwinfKT3ioKBLCtmFn
 +Bnr0WFBCyKdDLVXeenmW8KAs4p6iVgoKpCva6WGg+q53zQGjfXTXkMOpYSx36bFlT81GXa7nmj
 77bEYdZNujLtWxdfoF/GkcSmdR9XV313quZDtfp1Rjc1uykRx4aKyBSEEmfiwAuo03T8FBej4ca
 MODib49B5meiE4TzBT052xuub4xYRXm2bLQPsvYDl13HXBLNH6hKBhl/W80+AfSU+Bb5OY91keR
 ENZilMp
X-Received: by 2002:a05:6a20:7493:b0:398:9ae9:710f with SMTP id
 adf61e73a8af0-39f2ef7e3admr21007463637.13.1775630984895; 
 Tue, 07 Apr 2026 23:49:44 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:f0e3:c8b2:74ff:70d1])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6561fe9sm17036136a12.15.2026.04.07.23.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 23:49:44 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: [PATCH] drm/exynos/gem: Fix printk specifier for gem_object.size and
 dma_addr
Date: Wed,  8 Apr 2026 14:49:34 +0800
Message-ID: <20260408064936.1342321-1-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
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

In the recent change to use the GEM base object's size field instead of
the exynos_gem object's additional field, the printk format was not
adjusted for the change to size_t type. This causes a new warning on
platforms on which size_t is not unsigned long.

Fix this by using the correct "%zx" type.

While at it, fix the specifier for dma_addr so that the cast to unsigned
long is not longer needed.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202604081331.jSJQSVmg-lkp@intel.com/
Fixes: 11e898373fba ("drm/exynos: Drop exynos_drm_gem.size field")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
This is only compile tested. Build for ARM 32-bit confirms the warning
is fixed. Sorry for the noise.

The commit hash used in the Fixes tag is the current one seen in
exynos-drm-next.
---
 drivers/gpu/drm/exynos/exynos_drm_gem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_gem.c b/drivers/gpu/drm/exynos/exynos_drm_gem.c
index d9d42809a1a9..f264e170bc26 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_gem.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_gem.c
@@ -66,8 +66,8 @@ static int exynos_drm_alloc_buf(struct exynos_drm_gem *exynos_gem, bool kvmap)
 	if (kvmap)
 		exynos_gem->kvaddr = exynos_gem->cookie;
 
-	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
+	DRM_DEV_DEBUG_KMS(drm_dev_dma_dev(dev), "dma_addr(%pad), size(0x%zx)\n",
+			  &exynos_gem->dma_addr, exynos_gem->base.size);
 	return 0;
 }
 
@@ -80,8 +80,8 @@ static void exynos_drm_free_buf(struct exynos_drm_gem *exynos_gem)
 		return;
 	}
 
-	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(0x%lx), size(0x%lx)\n",
-			(unsigned long)exynos_gem->dma_addr, exynos_gem->base.size);
+	DRM_DEV_DEBUG_KMS(dev->dev, "dma_addr(%pad), size(0x%zx)\n",
+			  &exynos_gem->dma_addr, exynos_gem->base.size);
 
 	dma_free_attrs(drm_dev_dma_dev(dev), exynos_gem->base.size, exynos_gem->cookie,
 			(dma_addr_t)exynos_gem->dma_addr,
-- 
2.53.0.1213.gd9a14994de-goog

