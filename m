Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F9A4CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 09:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AF610E1D6;
	Sun, 17 May 2026 09:15:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qGxBV4z7";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2334210E17F
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 09:15:15 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso1020777f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 02:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779009313; x=1779614113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1GuFtyrSu06bTVmesqPXmePmrs3EAUNX6oaNcPtvvmc=;
 b=qGxBV4z7ZKtdVP0yU7pMVxKHW/7jHy3FtkxpRz4sbAhbZqGz5N9fOZZDDVU5LCW3RE
 v+zmiy+8jtMXtA5pfaTNkfRH6xPlZBJuAjV7IR72wDQuLlGB11fTvZXxaPupDHQS87GE
 BBQNikAeoteQ/ZPbcqoQlEHokC7IFHD5IdAaleHs17sexQ0oXylYP1PdVedMNwUieMjv
 kLH694KTdkfa6UhsYSUZfM/O6EYdES+K437D7mtBRn7hPJF3hY37krNZ+rxSIcz1pVgR
 9ho+mnmtYUATtj6LhiO9QblzcG3s6G/zxGTjS9hjc1re1Cf4wyZ2S2eqMpuUhTQDkmyD
 jXJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779009313; x=1779614113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1GuFtyrSu06bTVmesqPXmePmrs3EAUNX6oaNcPtvvmc=;
 b=J3XuRTBNVlGE6bZx469t7O8ikC8YEYkeNSZql16ePH2DDP9EjZ2+6L/QmPVImFxWeA
 V6YAwxkOD32uLZ6YYrKgX8wUKefCzkDdKwScePbHRo4SJzFB2JFfclnUc2OLWMuqezfI
 2ktCe8mKemwBCI0icPUjSCfCqIFQsEutgYRrIF36EzRim6H3SRtD4pBEi/8iFA7/MNS6
 NSycTeBB0H/bNLOrGVbAKsdZI0fR1GeI38hSes7WVbl1KCD5kIk4uQpmV6EB8XKtfUp4
 XWko2oNtjP4QXdLEHyOZh5/GMXMrDV32JnDihaSKJjA64PYrby+UrXtQN83yBoH8ZYzp
 f7PA==
X-Gm-Message-State: AOJu0YzCcDg5bRbE7ztOnRsM7S19h4j+V/ON4KtRjZoJv1UZAO2AhNyr
 wL0c5rWN4Crdm7EZOvDzFTsTY4wLNoo5FkaaygUx1eLu/VcqJTuYrd4l
X-Gm-Gg: Acq92OGrGgZ+DK0ck9lGocPSaIwnSFDb1hog1JcvHV3DPk18WPqO3pY7UHVaKnaUJeg
 Rfkfy7Koz7i3iPOqn2RznAkKEFLZSBg/iuqZLni2OyLbxNofgAYjIPdqlkpGKDjd5lEGZ08wu/D
 7VVwMMS/7yT9zNlEsx4MY9M7x/d9bTzuWzXkPr1w26PiN7UKHLfYHScxsv61pc8+UWFMAW1ktbm
 9Sboy5i1cAtNObQZ6joY6SpTmviiLbdlVHDzFg4/TIS/HF6nLd8RVpm9iHX+tYoANDSzmvzU0Mb
 dA+f0eSIwZpK9gaXyXt1gLqIKSSe355CRiLRcaa2rA7yfkvMCplJkAM2HJiTmdXZe0WRfpQenAT
 hpTK34PmIfb4ZgYHOwAJ+IKFoYtLcgrg3jV3HJl4PatBNifQKeGeoJGDdD1RtHd0jCh6xXLzp6B
 mXedjTJAjkd0iXlYbkOQq60DLC0cc30lz6RQ==
X-Received: by 2002:a05:6000:4010:b0:43f:df1b:9e07 with SMTP id
 ffacd0b85a97d-45e5c5a5580mr15716198f8f.42.1779009313403; 
 Sun, 17 May 2026 02:15:13 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm29560235f8f.22.2026.05.17.02.15.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 02:15:12 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] drm/tegra: gr2d/gr3d: Initialize address register map
 before HOST1X client is registered
Date: Sun, 17 May 2026 12:14:49 +0300
Message-ID: <20260517091450.46728-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517091450.46728-1-clamor95@gmail.com>
References: <20260517091450.46728-1-clamor95@gmail.com>
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

The host1x_client_register() function is called just prior to register map
initialization loop, making the device available to userspace. This may
result in userspace attempting to submits a job before the register map is
initialized. Address this by moving register initialization before host1x
client registration.

Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
 drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.c
index 21f4dd0fa6af..e4148b034af7 100644
--- a/drivers/gpu/drm/tegra/gr2d.c
+++ b/drivers/gpu/drm/tegra/gr2d.c
@@ -276,16 +276,16 @@ static int gr2d_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* initialize address register map */
+	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
+		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
+
 	err = host1x_client_register(&gr2d->client.base);
 	if (err < 0) {
 		dev_err(dev, "failed to register host1x client: %d\n", err);
 		return err;
 	}
 
-	/* initialize address register map */
-	for (i = 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
-		set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 42e9656ab80c..47b0c6c56bfd 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -506,6 +506,10 @@ static int gr3d_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
+	/* initialize address register map */
+	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
+		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
+
 	err = host1x_client_register(&gr3d->client.base);
 	if (err < 0) {
 		dev_err(&pdev->dev, "failed to register host1x client: %d\n",
@@ -513,10 +517,6 @@ static int gr3d_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	/* initialize address register map */
-	for (i = 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
-		set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
-
 	return 0;
 }
 
-- 
2.51.0

