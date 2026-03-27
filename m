Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D33A10F284D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C0D310EF12;
	Fri, 27 Mar 2026 16:12:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="i9z1A0MA";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1CCA10EF14
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:38 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b97e6e48b24so402672566b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627957; x=1775232757; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w2+QJfKRcmrV5A3/+Pu8IIk900YGksP7rXJkNHvnm5M=;
 b=i9z1A0MAsy6B1c/z8RhIt9lGBq5cgIi8PcgHiau+Y6Gd5NWOXabvKP+m1pNvdgdh/L
 XOQqU5lYpmZvYkpX6DeglbG9KTYBe+cSWDyvzbv1z0QOfHoZZSLhQAyCanf3B6D3Ko88
 jX8nJz2wy2uRb1eyVgCtUesJGZhPCRe3ARJwzWX4VbIDD1Uyq3mqTT3xUGalUrmh86y3
 vf+gKoPuUmaYp7RL9AJwU7oKMEklURfR4wFz9yIULGtwpQgnLo4JyIN8AJ52fAbcCQ7Z
 RzExhdOEUFLAdtJCSS1ibwd71AthZLHrM509/eM17oHkL0KwsE9pw0yL/Z3PmoM4zJ52
 YvIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627957; x=1775232757;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w2+QJfKRcmrV5A3/+Pu8IIk900YGksP7rXJkNHvnm5M=;
 b=OkM8aLhS4WrpvclYKdg8l9BCcQI6Ck/h5gIm1TflecgYYSn9Nz8ro94JxbKXeA318P
 I0ANKk6BBSoaV3w+Gx+rcqVNW8JuhzmvaONd8fk+zQ+q4n6w2rd98d7cYv86UoF83HlC
 73J3GlHhMfDnDMfYD8tFG36cSohdq3E+DHtXBSIwN6T4zXk9cXc251XSUuKXhy3W2hbu
 iIjIVERilX6NXdFuNOnBhhZzNmmtrykJ/Z+xfcC0LPNvKkOuZJS374mxr4WPC1d7nGji
 E1IeAUm3uGY9WhShLTtG+amrg5iGSJCIyvASIl/CM/+fzcmuEegBQgIRimmwofwWFEfn
 SaNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCURKiXHmHxF+u3h9If943tZvP0yhE4XYBfRew1+SublY8M9ewCummczudFeifiF2+m153PS0QZHIvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9cmWFPq+VN3TcQwjGitRcYCmT+zEfAPWFNKrJ7lDv2ZO3m1Qo
 1dSYhMFo8m7I3iU4Wbee8Vsj8ClP1kdgl2YRAMpeuZa22E9Hl+DEHmgFMkfKHLv9s8Y=
X-Gm-Gg: ATEYQzx0SgNm7NGzHsKhT6Cl/WYa145x/XJ9jTz7gzwjudB2WVUo0uBSZjd9XjayEPR
 XWYHaLJ3meQ8ALfVTQMgjOKk9WSxPOpTpTDh/d+MlL/ObtAKF+6+dSTaxemmZRvlh/U2/POdUxw
 600/YoiAMopra+YZSrR5IQ2YHFaf170iEGQaFfVfPGfv7/m2y2eSmEnceGi+s3JWhQMY3dCfPIj
 L7QCmNSIhMAH2sS9I7IPC2DEp7SmGIhy6zpcvtHaIOd2CgQoM0Tn+AUWwMcEgzEnsNFqnLIDFn5
 Nv2vmPz+r6+QOqyxgspGJz0Sp5+xoUK1kX07s3MPa2k7AuATQHP/gNohCfyhJ8H1Pr3P+l8Brp9
 q4Vtsf9usf4LmOClNNoZjB2XTOWzORVREMWINQafWbkU4OMvJ+trGV0GJd1Taus/SaRz2ncXVbX
 IVnaDH5AmMcr4sMeKdsj7/wiYiSo30HKFhJxgoDjahu4RWPabkSoDWGA/2W12XxQJrigQAmcOMA
 Fp6dxhk3Feiiehh
X-Received: by 2002:a17:907:388b:b0:b98:4850:3b89 with SMTP id
 a640c23a62f3a-b9b508fb15bmr201044366b.37.1774627957321; 
 Fri, 27 Mar 2026 09:12:37 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:37 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:25 +0100
Subject: [PATCH v2 6/9] drm/msm/dsi: add support for DSI-PHY on Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-6-bc586683f5ca@fairphone.com>
References: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
In-Reply-To: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
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
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=2987;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=MNrAIbdMcQ69eUABsCEhZ1TvMsJSWiKNRpYtVmTWOy8=;
 b=5SR/5qTBYNIDCGL8cuTNXwvhzYkYevnNbG5tqBVj6DaWvC5VwQFqUBefrvK3PQwf37OLko88/
 49lWJuZx0jPD32kD0ipHchOJxdTUSFwUd9ONcju8pYJK36i70aOoZXK
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
2.53.0

