Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53FBFC88E56
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 08:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D4BF10E0B5;
	Sun, 13 Sep 2026 08:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="guLF2s8U";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8321C10E0B5
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 08:58:27 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747ed9866so13322595ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 01:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789289907; x=1789894707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g12Q/omnE3PC2Amf1XAPg7bzaI1F+/7aB6gxdSUP4b8=;
 b=guLF2s8UD51XQJllZPgzeT2j6mUXOwoKUo6UZsDhAz7DjeqUql5qKd8J34S7SrqAPM
 m5tAR2xvNf7HIoYShLfyrSblkl4rRnYTii7qMo3Tbexx72v7mEKDCXmd4ArcYXy1N5nE
 mmgiL2es7822HyBkua/vhVKear0em0RqOzB2bS9GJhwX08d/4spFV/cN+LempijSFXS4
 5uMnVLsk0hrXmKB4NoMuZs63qjQvSJPYGbAVuE94v/4eTBuRpk1VuOaAQQhITphx/+oX
 jMaeq9ZeTDyxPq/wAPpKXUGqArdqtluTnKdmm8ogor9NyUhBqYbDPRQ0c+QpDtpDl+ga
 T9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789289907; x=1789894707;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=g12Q/omnE3PC2Amf1XAPg7bzaI1F+/7aB6gxdSUP4b8=;
 b=ZqXecUv97wdkXAFi6MLs6dT9qjpo4vvUqdrXohIhtlGhQ1s+nI901DcGpwfUGlICt+
 AwVlfe1GjUwXwaqdEEghbQutrSnW5cE/a/6WDc0Dv63C9bgL4WwgkMuhbnknhPFGOSh/
 2qaKRnFAkxrWOamL5I1OF0lCanORcT79lWLLPF6B03baSmWXIT8/rbJgvN1q5KPOVAYB
 4o/86udYgeUUbbElWbpjnbe2dIMRkpkBNwo76Xx/SxbL9QrecCdNNxvpLa6n4RuZAbNJ
 4lXim08A8k2A5WaWvjHc7j8USN6UXAfMUrTCVxgwdrQ56Oz+GMwLo6BOVcKlc/kycuBa
 XfFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnSGodE0DOi7+1VxOkYahc1p8As1hAzjr/4Z3Cvsr+1BYXgzXmy+TDWWqYTWm3Mozob0YeVI28KaM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhoz3EdPDiPlF0jMPivc4dGCqF72ice3UirSa1QxmfhgntBNa/
 QAPahNamPWpju88GCG3Pdq1B5vCHtviDhp3B71bkElhaxsRemKxyVxbz
X-Gm-Gg: AYBFou2HLKZ/yS+zbsX1/tKiW03KMjtI6Pnbf9W/bOx6OCRXNIe8u5aa9apqgmXvMW7
 on0cwTaEDNhoYML9FSTyglTNWS+W+h1HUtKP7luQQdpOp0pxOIdtC7ZVHeCRABeuyVgjAH/lgqj
 Pvc1JFsUH3XevTKRBM6wnIy8q+9DATmwMjJA1tCZOuZ6a6Bbqz1TdGM7HNHSY6FXWau0Z7/riZq
 2SGBH37beOaO/Z4jbS1Of/GKn6qTFSE5L2wBdN/DsGhzqau8YEO4frZQGHeoJgVaAO5y5deuFTU
 WHYJQOIGPzr957PBlcZIq4TB53crZPczPfwApcwICxnpJyP6eHh7ubFA+0rwMY0fAv+Q0PkPCNp
 xAMa7y05d6OaHimIk66nSS6HHbMloYkmpB121wCJQynfJxTX/pTkriJA7ZWnUFf0rvvxbdgfLXd
 8EZ9MBCK6zTBzwuMLNIzWuqV1B707DgSffq0IR9U6tvcWN8Pb9yvUDC3lO4KqGF+OU
X-Received: by 2002:a17:902:db0e:b0:2da:dcd8:713d with SMTP id
 d9443c01a7336-2dd2a34f6e6mr211164165ad.15.1789289907022; 
 Sun, 13 Sep 2026 01:58:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd48ae3cacsm17494875ad.26.2026.09.13.01.58.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 01:58:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guangshuo Li <lgs201920130244@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Archit Taneja <architt@codeaurora.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/msm/hdmi_phy: fix runtime PM cleanup on probe failure
Date: Sun, 13 Sep 2026 16:58:14 +0800
Message-ID: <20260913085814.1509352-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
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

msm_hdmi_phy_probe() enables runtime PM before enabling the PHY
resources and initializing the PLL, but failures from either operation
return without calling the matching pm_runtime_disable().

The remove path disables runtime PM, but it is not called when probe
fails. As a result, runtime PM remains enabled after an unsuccessful
probe.

Route failures after pm_runtime_enable() through a common error path
and disable runtime PM before returning.

This issue was found by manual code inspection.

Fixes: 15b4a4523859 ("drm/msm/hdmi: Create a separate HDMI PHY driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/msm/hdmi/hdmi_phy.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
index eb1088755cb3..77dce35cd45e 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi_phy.c
@@ -168,13 +168,13 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 
 	ret = msm_hdmi_phy_resource_enable(phy);
 	if (ret)
-		return ret;
+		goto err_pm_disable;
 
 	ret = msm_hdmi_phy_pll_init(pdev, phy->cfg->type);
 	if (ret) {
 		DRM_DEV_ERROR(dev, "couldn't init PLL\n");
 		msm_hdmi_phy_resource_disable(phy);
-		return ret;
+		goto err_pm_disable;
 	}
 
 	msm_hdmi_phy_resource_disable(phy);
@@ -182,6 +182,10 @@ static int msm_hdmi_phy_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, phy);
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(dev);
+	return ret;
 }
 
 static void msm_hdmi_phy_remove(struct platform_device *pdev)
-- 
2.43.0

