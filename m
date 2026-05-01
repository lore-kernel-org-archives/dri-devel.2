Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71808FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B48F610E51D;
	Fri,  1 May 2026 07:15:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Fjxcfa/r";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7ADF10E519
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:36 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso14895035e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619735; x=1778224535; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DcRaxEDDkb3JD3v/suj0HVGZb78w7Xi1M1DpP43HiY4=;
 b=Fjxcfa/rKSNeDF83lav55b0vHl6qGA3iyYRoh91AqSRe5qjigBBrueZW/Bqp/pxhVf
 ecbcne3z7R5GsMO3Fau51a6mNR+LQzcxp/yPe1SOtic9wt1D7IauqNRriz5hmq9NiVQZ
 2ZttQpijLLyx7mpAoJ4TI11W8Ehx7n6ovkUkDhGPN/s1BYoO32Yga2Qv3gESSjCPGRSQ
 Ft+ktvnQIXcBJLJEUoytTWRLtevWj0NIiZ4u+MNgRbOJ/6nYOdURES0BBofl79CQKcJ0
 DSq0Lb6o/1t+4usQExx9kobRWO1I8pNK4yRazgQjCweDdUGlkt1QBMaUIZyy5P2G8XIY
 V/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619735; x=1778224535;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DcRaxEDDkb3JD3v/suj0HVGZb78w7Xi1M1DpP43HiY4=;
 b=QfN4gCLGIizuKwtiq1LVZ91fPWI6s/Wf/etVal5iUC4l/7SGJT1QZTfEv0b2lAoF5S
 FZhNG9454e59t0VNlf9+XxBO3kW1KX5TSRopTTkkl6xfaznhjBrBpCoB8wWXYZoJT3IF
 2pH6+GKvXpPywqM8WILWGhzflTy9iXl6fwn0KN9yfeR0pHLhHtGsoj3NKE6XEts+9l88
 SWadJ6zh13MWPsqKu/D5hA99z0QTGJUXc5wuuDu250ydUXFZ7YZXh93FJp32M8Its/wF
 TT7MgddvRxzlRlf5A5wz24DeSBskIj1lGdtNDSV3ynIQVW1RXVJob1Lctcn+KxugfPlx
 54jg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Xq5ctmH1LuzMF9s26sAVBpCr3Jufq9lEVwXpYF3Sxx/2667EUweSlPKp/x+IhHarfkxgDUldNdzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfNasbxN+NroDhPb1c5oxDIQ5OgzTtvb4JGkHDekczpAYaStJy
 Q5B+bErLdsBmwB/le21FkTwKv2rf1ZxDigmPDWtjnhBlQidEw9XiyNt79Pzn4NpeIMc=
X-Gm-Gg: AeBDieukLeowA4Xy3BTnTCwoeL6ohmknqN9O+OKj/vQZkyQ5OpnvtrW/JZi8N278FFq
 cEus2mRIDp7cIxGkzjhscT9AZGI/lC5N3uSi+v8Pb7ksjreloXrC61i8DbyYUiwzhf20zRtnNvd
 6FV302dQPnpTNlvFutigS8jBaCv/V7U2WXSkxsLcfuYSO6ToYwbWDdCZB/pl56JwdhaWxroxaU5
 tddyYhaMRw888OaztBWsXflv/RQYMTMHSUlyF3Cm5i5HoNsP41rl0EZ5ZwXKnJyu4uwJDWm0qxs
 WuCHx5FrviWOkf4bcW+DL1ch1iF31wRkeWFN4DnCpApHKOYAd5rS1sTe0BhV7GAxbVPErS/afYE
 F1joaq5AoPz4Rp2QhONj0A+WJo/S3QADHDBXvBic0IIgu0Jv6i9y2OalWQbg+zUpYEbuwqtwzhG
 uDkP6ccaH3FeL1Id+AMJYFlKJvsblC/yr3L/4vJi3O39P1gkFS79fD8zJR1kalV6ij9miLI4iVl
 gJA7AbcJ/js27qmLrU=
X-Received: by 2002:a05:600c:c049:b0:48a:5546:61a1 with SMTP id
 5b1f17b1804b1-48a844683edmr73734095e9.15.1777619735065; 
 Fri, 01 May 2026 00:15:35 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:34 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:48 +0200
Subject: [PATCH v3 6/9] drm/msm/dsi: add support for DSI-PHY on Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-6-58bfc58c0e13@fairphone.com>
References: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
In-Reply-To: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=2987;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=+OinyCwXS4Y2vYMDBUiIEDzwsNrg9k3i/PQu3jWxkfU=;
 b=SiQkl681uapJJ+uqBxGlRfO5q1AtnuHZPJC8JzrYe8Fk7kRLJyIsRWb0JSIR4rjf1Jv9SL4hj
 nPMtRiI/fR2DJlUQXHXfyEcjYDMgmdMJtNxhlZFToLqesXQZfRTZIrJ
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add DSI PHY support for the Milos platform.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c     |  2 ++
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h     |  1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c | 23 +++++++++++++++++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
index c59375aaae19..1fb3899b88bf 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.c
@@ -571,6 +571,8 @@ static const struct of_device_id dsi_phy_dt_match[] = {
 	  .data = &dsi_phy_5nm_8350_cfgs },
 	{ .compatible = "qcom,sm8450-dsi-phy-5nm",
 	  .data = &dsi_phy_5nm_8450_cfgs },
+	{ .compatible = "qcom,milos-dsi-phy-4nm",
+	  .data = &dsi_phy_4nm_milos_cfgs },
 	{ .compatible = "qcom,sm8550-dsi-phy-4nm",
 	  .data = &dsi_phy_4nm_8550_cfgs },
 	{ .compatible = "qcom,sm8650-dsi-phy-4nm",
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
index c01784ca38ed..21a59d66e8dc 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy.h
@@ -61,6 +61,7 @@ extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8350_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8450_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_8775p_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs;
+extern const struct msm_dsi_phy_cfg dsi_phy_4nm_milos_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_4nm_8650_cfgs;
 extern const struct msm_dsi_phy_cfg dsi_phy_3nm_8750_cfgs;
diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
index 8f4b03713f25..984a66085dfb 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c
@@ -1436,6 +1436,29 @@ const struct msm_dsi_phy_cfg dsi_phy_5nm_sar2130p_cfgs = {
 	.quirks = DSI_PHY_7NM_QUIRK_V5_2,
 };
 
+const struct msm_dsi_phy_cfg dsi_phy_4nm_milos_cfgs = {
+	.has_phy_lane = true,
+	.regulator_data = dsi_phy_7nm_98000uA_regulators,
+	.num_regulators = ARRAY_SIZE(dsi_phy_7nm_98000uA_regulators),
+	.ops = {
+		.enable = dsi_7nm_phy_enable,
+		.disable = dsi_7nm_phy_disable,
+		.pll_init = dsi_pll_7nm_init,
+		.save_pll_state = dsi_7nm_pll_save_state,
+		.restore_pll_state = dsi_7nm_pll_restore_state,
+		.set_continuous_clock = dsi_7nm_set_continuous_clock,
+	},
+	.min_pll_rate = 600000000UL,
+#ifdef CONFIG_64BIT
+	.max_pll_rate = 5000000000UL,
+#else
+	.max_pll_rate = ULONG_MAX,
+#endif
+	.io_start = { 0xae95000 },
+	.num_dsi_phy = 1,
+	.quirks = DSI_PHY_7NM_QUIRK_V5_2,
+};
+
 const struct msm_dsi_phy_cfg dsi_phy_4nm_8550_cfgs = {
 	.has_phy_lane = true,
 	.regulator_data = dsi_phy_7nm_98400uA_regulators,

-- 
2.54.0

