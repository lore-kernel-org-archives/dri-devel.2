Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 898CACD3424
	for <dri-devel@archiver.kernel.org>; Sun,  3 May 2026 16:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 219E710E339;
	Sun,  3 May 2026 16:39:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rnys0le/";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09E710E339
 for <dri-devel@lists.freedesktop.org>; Sun,  3 May 2026 16:38:58 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-baebe98afa0so473589766b.3
 for <dri-devel@lists.freedesktop.org>; Sun, 03 May 2026 09:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777826337; x=1778431137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8zyB3mnhxYbuCPwW5Ny1cCWwB0U69BU8Ai2teNpQO6Y=;
 b=rnys0le/77tIvVe05sd7pAZ05gM13fHWISq4ygrhq5ZE81Xtx03DvsDQA8iUMZMIuu
 IdZeftislbYx7xbxhnyOUyvs8aZccqYtJ3MwPfXTODDOcXIcqgCuOK5nhFMeOWzlj6sk
 I2zD6Y2NqZhQRv9KogEPmQ8Zi+fZtrdZ74cbR5VBBLLNVnKFv68PNuBgtAhvmRTkWc7v
 edFAhOpaxdIHj8oxujxcR9+PuqhvaOjoBhvplMTaZaUPusssDQvfSy5qOTkpUArBhsts
 3p8tuX0t0iZYvGQbYZ0cdhsWBAZ05uGUdX/ROhNLx6YyLYvP3H5SsnwQmW0qmQjgpYW6
 2muQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777826337; x=1778431137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zyB3mnhxYbuCPwW5Ny1cCWwB0U69BU8Ai2teNpQO6Y=;
 b=mTqLtVSfrFNhhD7fg0Hln84N/KLp7QBOP5o97VDuAp05CWCrULG6SXviPOJUukmKBJ
 fjzZsX86Z5PGeqlGpZR2oe4Wtyrlg26yTfm5w0budCTYPEstw6pULlgp47JGQ3ozAsGT
 +QqV2zXoC+A7z2b1BgDLw7qMKQ/FzcHL9ASWqnYY/9OPvVwcG+svArt7VGJbHZ9xye8D
 YhKlN2GXON/sHrSmyJXALL4J8X4hoWwGD84lA4K+WO+5kJqLu5NcazDm7db8wol7PIiD
 IoEu1jYYSwuo3O5h8LtaJtxZV0sEai3G3XGn6E3GaQNtJ2+ZgQVhkD6PIqijMBuUu1Zp
 1h6w==
X-Gm-Message-State: AOJu0YyXSwMgtEOK4r62WmOGrS40g5eoCPi24mcLAWVJ0pqsdYHH1loX
 jJmrrl9SD0TpsrAnhxLfaS1Udi+AeojTSQ6ONsS46bYwUp+Mb+HbBy1LBSHepw==
X-Gm-Gg: AeBDietI475DNxpSpTR+tI2JlZyTz1hX5RJXtGYSjbTPAnW5BEhd8hToFot/QKs9APd
 mPFDbsoe82IN8RoyZLnvyjylWkfxjSYdjDQ40E17WUtbboHWCo3MgFkaOCZCwQF6mjM29lQDYY3
 WWDC2IL7Fc25DkaajxzJL8183dKJFdbF/rr3HUPMHinGj46Ln46OjqlPyRnDxhopruYaxDyqm9k
 gx2GaGLtWaC6zAmK7IjO0ZIlM5bBzIIHWL10OTgbEuVvlb/G+VHRM7CwavfKbS6lnSRe00W06Ul
 zHVDEHrPE9puoZVhE6i+nowplOPScf+iHBPTw4CxADHAGRQEFLeEgS+JIT2NWHTForrluhV0f5f
 fOJqq9BeAGmL24bVvyBLzfrH3Q95sIB1PCSnA7gubSCp1Obc28QQZKcQYNBqHqfZkfS2YbksVSV
 c/yptmYlJmk9dnLxnh9dnp8p4=
X-Received: by 2002:a17:907:1ca1:b0:bc1:baa8:1857 with SMTP id
 a640c23a62f3a-bc1bab76a36mr109324266b.36.1777826337001; 
 Sun, 03 May 2026 09:38:57 -0700 (PDT)
Received: from xeon ([188.163.112.56]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bc1ffd6f8e9sm44126066b.13.2026.05.03.09.38.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 May 2026 09:38:56 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] drm/tegra: gr2d/gr3d: Contain PM in the
 gr*d_probe/gr*d_remove
Date: Sun,  3 May 2026 19:38:42 +0300
Message-ID: <20260503163842.213489-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260503163842.213489-1-clamor95@gmail.com>
References: <20260503163842.213489-1-clamor95@gmail.com>
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

From: Ion Agorria <ion@agorria.com>

The current power management configuration causes GR2G/GR3D to malfunction
after resume. Reconfigure all PM actions to be handled within the GR*D
probe and remove operations to address this.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Ion Agorria <ion@agorria.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 11 ++++-------
 drivers/gpu/drm/tegra/gr3d.c | 11 ++++-------
 2 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index e4148b034af7..ffcd076b5831 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -100,9 +100,6 @@ static int gr2d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
-	pm_runtime_force_suspend(client->dev);
-
 	host1x_client_iommu_detach(client);
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(gr2d->channel);
@@ -286,6 +283,10 @@ static int gr2d_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pm_runtime_enable(dev);
+	pm_runtime_use_autosuspend(dev);
+	pm_runtime_set_autosuspend_delay(dev, 500);
+
 	return 0;
 }
 
@@ -367,10 +368,6 @@ static int __maybe_unused gr2d_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 500);
-
 	return 0;
 
 disable_clk:
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 47b0c6c56bfd..cd5554e2117f 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -109,9 +109,6 @@ static int gr3d_exit(struct host1x_client *client)
 	if (err < 0)
 		return err;
 
-	pm_runtime_dont_use_autosuspend(client->dev);
-	pm_runtime_force_suspend(client->dev);
-
 	host1x_client_iommu_detach(client);
 	host1x_syncpt_put(client->syncpts[0]);
 	host1x_channel_put(gr3d->channel);
@@ -517,6 +514,10 @@ static int gr3d_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
+
 	return 0;
 }
 
@@ -578,10 +579,6 @@ static int __maybe_unused gr3d_runtime_resume(struct device *dev)
 		goto disable_clk;
 	}
 
-	pm_runtime_enable(dev);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, 500);
-
 	return 0;
 
 disable_clk:
-- 
2.51.0

