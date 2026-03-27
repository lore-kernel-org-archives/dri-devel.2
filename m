Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3664810F284B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EA7910EF19;
	Fri, 27 Mar 2026 16:12:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="i5TIVNKU";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4356310EF19
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:40 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-b8d7f22d405so377044466b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627959; x=1775232759; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lCn+lBmcgEXVlegTG5stGMNFyfFJRP/RG0o4ix+DR90=;
 b=i5TIVNKUxGqQyrgvs3nv205QgTYKDViO9X/iC96WFvJ1yNUomAiwUImXHdnST/FrMn
 +MZBD/CdKphXpqVLFr4EJCRjc4WbRlUvXoYRvBRMAQ/uINEj4cT2PNM3vfotWeACxZXq
 9CMjXyQhmRE5anCUr18I4MjFxK4y11uFSkV4Svklon7K0lFejt3kh27VFjP1dSidOEsE
 H/iat+LLLE9W3yk2dflThBNv122IsEOZwmx2JCbldNy2zH3rwTqh0yORRMO9DtKGcArj
 OJS8UTLKJfX5rWWSB6ZQ6YfsKmuMr+Xg69dGRiWdiCwZMUxeJFAF8jCUQRneOfuGIQyR
 892Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627959; x=1775232759;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lCn+lBmcgEXVlegTG5stGMNFyfFJRP/RG0o4ix+DR90=;
 b=kkM2meMFkuuThknculnnbZR0D3fsyrb8VZ+B+H9Dhoh/mlYbJMYJYf2UZQuvrEjsV7
 xeI2+QJ/rdCqDU5S13BFaZF/52xDrptsNkrt8CP/PRNYkZ5xIqrZzx4QMy9ldXz97X+6
 lys0aNCboc5eXrB/sO8pHadf8jO2iLJ6MKWqgzXfSDHDa59PfI1dacU6kBJTVPihBQMC
 5giyHydupyefbAVkAhTSu99F+HgbNP41jOYaANtTrG0Ty8ZltABmhyQGRfXTCU4iJkqJ
 a8zFiBZNUQuUY6bGHWIdj3HkKRjNJcjh11FzV+K1Zz4mBQB5CFO7XhOqW5ro+ZW75j6V
 dEAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvhFclZm2WR+OohsBgx81eHtKpdBchY4Ks93lFTI9aaEYo9VW/4QiJFCDoUUn2B8aG4G6NG9IQH2E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNr7yZP2Xu5H0NfwZ9xSCBUkguZwZooGiY/8J4I9JYB7Ivqs7W
 cshOdIwtOuDKqzL9R+LWfBsZoQEJ4OQB8qIKe9ohfWKH4OSYlrkAVFx7Ot1jZzrx/dU=
X-Gm-Gg: ATEYQzwMrc5tLZa4bMpmayM6MXzvG89LLzsZAuw8ck9hESm3ohqNXQyT/bxwmIYS6v/
 LefC2nCI2pzavrGM0JVy1J81a7gFuLbk644PAO44Ts3tqglDpVj2v5uOwlhqZHjAyqzL2DNbfiM
 qI7mp1Xf4pJDmE+ACB0bIG5PQKN7ABXu6HPCgogMkV/qM6gI6LSGqxeIJ5zD5sW7k9ArQPa5xXE
 AKEzaYEGlSiuxWxXcuip6BWA5IASQ1KGD/e7sXiQWPjOcrG+xrvwv73uZ3IPjAD7gesKmyQkXE4
 nlr9idJ3Afb6IQrIKLu9vdlDOtpWv7Q3p/JQI4Vf+ww/5648Qq5IaeDJSSZjiaFc0TdyN/I5nI8
 zbMNMnooAS1N3Xon738GMraNbET0vlzVP5VCY4o1r3vYiLQHkpTkFt7o5iMeHbhMRD6Yx+ucODw
 qpsywUXGpNTqcTCZT2HAj0adXbqKFwj1on8nsMs5eoUwS3mxRy+o3jqvZLvOM/er2gw8gTQzIlf
 d0MbQ==
X-Received: by 2002:a17:906:4795:b0:b97:2a5:8a48 with SMTP id
 a640c23a62f3a-b9b507b0eb8mr213828466b.37.1774627958502; 
 Fri, 27 Mar 2026 09:12:38 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:38 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:26 +0100
Subject: [PATCH v2 7/9] drm/msm: mdss: Add Milos support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-7-bc586683f5ca@fairphone.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=1279;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=toygxQND4Dvsy39S8g07OI0f5dr6V9bZ0QRD2HmiADE=;
 b=MTo0qnVzdsDxWJw6LPXjTeAFhO1XjHbxDt9eTdhNKswtYL3oWLKUwMh414oCixoltSCdD3INv
 Ta4gVCK2Mt8Cy4DLoMIVZZLGJiG+ZtoSJ01hm9y9sRRduDaP2HNEDo9
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
2.53.0

