Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DAAC88E53
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 01:35:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C1810E7BC;
	Sun, 13 Sep 2026 01:35:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Wp8trpfE";
	dkim-atps=neutral
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com
 [74.125.230.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C4B810E7A7
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 01:34:59 +0000 (UTC)
Received: by mail-qv2-f12.google.com with SMTP id
 6a1803df08f44-90cdfc9b6ebso12294276d6.2
 for <dri-devel@lists.freedesktop.org>; Sat, 12 Sep 2026 18:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789263298; x=1789868098; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=olNBNDsUgs4Oen6UYhKmbkEp8czeJg52l/oC6o3L080=;
 b=Wp8trpfEEJrlzQ6lRm1OxMxWTVWeL1geVriMzIrfpEXiYAPeQE/E2ltlRzR1Jp4HNh
 v7P2JAPwLOADlFYcoLj2Aqpbb3m88RhdxD5CNEnGhwUVDFreez9lTZn36DZfeiXgRI0y
 4jDdt6JpXcbQMhK1jGRgvYPji9Gc7rth4N8wQWnYovwU3bsJy3+lSq0khSDski4sJY1O
 0j8PUVPfcobBGq3sLcrjmS4RDprKUo4M+glPZ1jsi4EYiLHPOSFk41GKMKyH6Y887Jvi
 kYDy//CDivxmngm8fsWM9QasJIwEZ8Z/ego+cm0FDYNd+Vffk62NOgtRIxG/CXjbO7dZ
 W4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789263298; x=1789868098;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olNBNDsUgs4Oen6UYhKmbkEp8czeJg52l/oC6o3L080=;
 b=bqIjEnD/W4r29eZxQUS8Gz1ycv7jLdV0tD+SBeCq+b3xYtrq88LF3lw9ykRa2Zok5y
 OUtFBqx4q0KNXFoXki0VwUGHAsdR5VaPIm+hZY5BeZ8WvNwem+V7lzy/2DpIMcaN/84+
 +LjPUHodunfMIKk1Jyi6GDi/nU7ITwslipI0kBZyd+9lUA4i3UjDKvT1+qY/QNUpUM+h
 oOpcnchtMKTOTIRpKFSx4fZzVWKb+Nk+u2oFKotto49c9udFPWYoEStBzCv//4Q59v4B
 yv0bGvwkdRiqy7TTfgKYMPvvTHoBGX/adB+1x3uOKjHPhnjKJlH+QeB0Wcbl8KXjcJ4U
 FTWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzCZbvrYFEiwm188O9miGDSWv0jB193sE8EuCfK9LKG1lGZjWkdHZPAu/pN6ijmdlYVA/SyjfEbpxA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kNZXnfHWmkpfZTQ0Ck5OnRqt7TQF7dQubbq4Vcx1Em+BR5Pr1x
 0rafQdGsScb7iubZRTmFGIIQyeoCDF76PSDeogBLpTs+vsxxDyxpkjk=
X-Gm-Gg: AYBFou273DgcOcm6buciF4kKDvpNxc3DxMBZBXfKn6jR/rmXK0gjmUez72cVcIgYFzg
 ZVsdnYCFqednsPxexDDiEM7/fiqFupLlouLPWCrFLup0m165Ul62OkgW9pcxmFDiiyxO0QOYv6k
 F6aMxenPS9cLGQ47VuXj0207mUqLRu8ah6JbPvv4ZmsZmCAvOPjgSByyn4F6rDnz+3+ox0Bis3r
 NEMuKWgEQfpDba2uWHPUVUOhp8ELh2kkxSew6x24DTyJtil0S7+IuVYlXor2UETPUuVZ0u7eQjj
 pmHyxVblCbwzqomsZrqZmKLvLZNheN4i3j+rXbN44RafQovhI0MLJ5fFr25yB9fekUU1lr4dlB2
 /A1/DOUZNPHMf0ZL2r7ddAnietnSiVxKUNwpGXjROd5Qa/REifh/j+j1CgAG945wf4DlMs2xsn/
 eXjJT8+AW08XyHCk3xPY5wkwMysWJWkpuas5jJH+5DzKdMeI2nFf4M7ay28EbwQpmF9voy8vlFG
 QhkLRoxprm+dW3MEwq5OsWZLToWmSZzq9T+V83eDgSD9TDDg36OjPU8v6FU6IAYhH37/ZcVoUhP
 pyv0YicIBZTMM27GzKA4BSDmVNMYa0YhGQ==
X-Received: by 2002:a05:6214:1315:b0:90e:9a7c:e5a0 with SMTP id
 6a1803df08f44-912120f0444mr161688246d6.17.1789263297899; 
 Sat, 12 Sep 2026 18:34:57 -0700 (PDT)
Received: from localhost.localdomain ([104.39.73.78])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9120f4920c5sm58866936d6.32.2026.09.12.18.34.55
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 12 Sep 2026 18:34:57 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Inki Dae <inki.dae@samsung.com>, Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] drm/exynos: fimc: disable LCLK during cleanup
Date: Sat, 12 Sep 2026 21:34:50 -0400
Message-ID: <20260913013450.20786-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.50.1
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

fimc_setup_clocks() prepares and enables FIMC_CLK_LCLK after acquiring
the clocks.  The later component_add() failure path and normal remove path
only put the clock references, leaving LCLK prepared and enabled.

The runtime PM callbacks manage only FIMC_CLK_GATE, and component bind and
unbind do not change LCLK ownership.  Disable LCLK at the cleanup sites
that are reached only after fimc_setup_clocks() succeeds.  Keep the setup
failure path unchanged because it can put the clocks before LCLK has been
enabled.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: e5f8683923af ("drm/exynos: rework fimc clocks handling")
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_drm_fimc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fimc.c b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
index 09e33a26c..58214abb5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fimc.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fimc.c
@@ -1362,6 +1362,7 @@ static int fimc_probe(struct platform_device *pdev)
 err_pm_dis:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
+	clk_disable_unprepare(ctx->clocks[FIMC_CLK_LCLK]);
 	fimc_put_clocks(ctx);
 
 	return ret;
@@ -1376,6 +1377,7 @@ static void fimc_remove(struct platform_device *pdev)
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
 
+	clk_disable_unprepare(ctx->clocks[FIMC_CLK_LCLK]);
 	fimc_put_clocks(ctx);
 }
 
-- 
2.47.1

