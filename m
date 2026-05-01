Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F847FF885A
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE26410E51F;
	Fri,  1 May 2026 07:15:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="mqAViYpV";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FBC10E522
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:38 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso13938765e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619737; x=1778224537; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OsX2W4L4Pc+PK+L7HBoqtgzXsJuoR5ute9g48CW5Zxo=;
 b=mqAViYpVMBLHkpCGl0qfVTZ+MF5Mr2FQaQ6XaZ+3X/CJUK4cM1bzUhvmAuFdE2Crdv
 JuJngOnHxG5ngHZhUHYWVM//HHrgxnWz1X6hHQC93DU8r20CCbhSaUQ3u1+q1GVT09JR
 znorWZS4dPK1OoBsMLfM3m2lneKYaWbWJ3eA3n0CYBsHS07FJXEADaF2u9Q+5okbrnv2
 VX7FNMsRLjlujnulpJcjEdRqA83GZEmuQtR6Le/uoPUFE3iOGX6a12aQQz6UhC9y3Eui
 Nx10G9fCzoLDez+bLJWucB/GZE6vpwLjGvmNApZ5go3faiLfLBDdgEcK1kIyV4fFAE0U
 xCFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619737; x=1778224537;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OsX2W4L4Pc+PK+L7HBoqtgzXsJuoR5ute9g48CW5Zxo=;
 b=YRWrnY6PK4970nD27oGLSbEVCFqClCPDZCmiaWOku45axo5w0AoPWFkLjOuTe2Gko+
 J2FRn5OK3JlgWIqkQBCwYcTeWCpbH5W5xCG45JuObK99pDiKTekETvRkhVCzX6SM9RpY
 lMH0Y6rUHfFwxHkqeF7T7y8R6UUOT0ysgLgD+/MoBPRww2R8KlXde+3wZzOmd+v3qows
 9ydGZclZtP6oD9ZFXkbqqUN1JrcxmXVChed8ENKSla5QdJiwtKV5rZko9oHGiMZOoypo
 jP9VK3dV5xPzp+hMQekTHEBkSXkq9TTiBdUUclztXg2YhNpKZ5fKDMpWhmPDLhavj8XL
 kehQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bCBTYLKatro8Nkylrz9t++y1KgVPZysFjRUhKPUHAFUYl1BKSHIyxq8wjWh+IHWACeLEjb4Q7iuA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGS93R2JqOzzhBmYCLm3pfxwIiNvv0y/a/FiEF5nb5xTu3cFrs
 pMoWpXhkonFgBRkO5Z+UHGD6Fl6mH4Edwzmwsl4eUPcfjui1NWiWZicGl91glTCGlKM=
X-Gm-Gg: AeBDiesFF8NPyK+KOfkAE0B8jYOqrBGQZQiXIk9wt8C2JiEjrDMHLGidqp+II6P2OMj
 Kw8ySWVCkd35fYlZoKea23qyFfUTnREpaHal7sqJo5EacytIxDLb/pawmF2w1JRNaOtyOK4UDnb
 2T1Gh8PWkcaqsr20KTgkd8bJNXZhHNdpgM8yuaYzdRc8c4SFapmXKbUqCVnL79l8Fv+b7eKetzZ
 Fex1kt/V9uYE6fQ0iuFhKZ4ItkF5nXv3ONMfa6/zNYvu5eqXOTPjOSSCzPeJ0lzHnxzTQp5Gg/o
 Hej60f5cljHpLWybAKH5wbOWTGmBML78WcXce4QO3OUc3md4QGFXomuSxPTvvFvVTJMAOQAVRop
 OHY/iGNhAxy2jzzM53ciLWBTBCLeW4FPjTMg25IrK4NZpxqLBubEI/mHLtDda0cEPW9Qe8i0Gn1
 CUOikjY1OnRBcq0ey/dcaT5U4YgDxtYh3wa7ei9TcJ3EmmebaTPrAnv8V5HIL8RvwrXSmO6AE++
 V7LAPNb
X-Received: by 2002:a05:600c:19c9:b0:488:af7f:775f with SMTP id
 5b1f17b1804b1-48a844526dcmr98733175e9.18.1777619737268; 
 Fri, 01 May 2026 00:15:37 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:37 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:49 +0200
Subject: [PATCH v3 7/9] drm/msm: mdss: Add Milos support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-7-58bfc58c0e13@fairphone.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=1279;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=Z9bS166QYqGuxxGdDpSdVqzIGY06OJ66UfzmgQnotbY=;
 b=JpEHF1l8ODIp8MebnEB3AbFVnv0KVA+IcJJ32Mp5KyhODYhgLLQWK9Ht4vJGZz+QkWSZhhF6T
 yXb6WAD8kMuDqu9cW70IpWCOT1FDTY49lbMcQvuFFZ1fa1WcLUnHuMw
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

Add support for MDSS on Milos.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index 90c3fa0681a0..754ceef38717 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -550,6 +550,10 @@ static void mdss_remove(struct platform_device *pdev)
 	msm_mdss_destroy(mdss);
 }
 
+static const struct msm_mdss_data data_14k = {
+	.reg_bus_bw = 14000,
+};
+
 static const struct msm_mdss_data data_57k = {
 	.reg_bus_bw = 57000,
 };
@@ -571,6 +575,7 @@ static const struct of_device_id mdss_dt_match[] = {
 	{ .compatible = "qcom,eliza-mdss", .data = &data_57k },
 	{ .compatible = "qcom,glymur-mdss", .data = &data_57k },
 	{ .compatible = "qcom,kaanapali-mdss", .data = &data_57k },
+	{ .compatible = "qcom,milos-mdss", .data = &data_14k },
 	{ .compatible = "qcom,msm8998-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcm2290-mdss", .data = &data_76k8 },
 	{ .compatible = "qcom,qcs8300-mdss", .data = &data_74k },

-- 
2.54.0

