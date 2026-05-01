Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF99CCD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7031E10E519;
	Fri,  1 May 2026 07:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="Mw3zD7aF";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DE3C10E519
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:35 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4891f625344so18175695e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619733; x=1778224533; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yOClhrJ15xoCIS1DoMdb7YME2yq0/VJyl12Zk7EZgH0=;
 b=Mw3zD7aFrna/T0kMCh/Dras6RD6vFl5uquqPWzzqEnlzz126r4nRBs7Bu1PGB0IjdG
 s2pxXhYhUXxWhMjnZdpKdTRKfbHWYi7N2w9Ep9u42GU0Bst4Wm0JhaabEAdcPc7V1aBi
 I8cT6EaJBQJrEOUCabdlllNEo6Wf1LL1V0AnYwYtNOtdFrndy/xn5ZYCgSz40GUhvXnv
 XNpJJwL8Mgd8WYJWm6TFWpYBEv4Z8gGNU2miPWlurty6b6KPoQSTyOaV3blZK3WHwZDH
 uAO6N7E4SVgRPEBUPFJy7tUWiL5yUwCqaPG+c7hUgvn2VVjYlurTsdsXP/JJaEpP1bqy
 zoyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619733; x=1778224533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yOClhrJ15xoCIS1DoMdb7YME2yq0/VJyl12Zk7EZgH0=;
 b=BO9bndWs5X4cgfrhQZxFlEvU0r6iKwYPPKs1WffYakpEHqgPY9BU8hSLLlrZAyPBU4
 sJn/KunTBZHoN6fukYSuJaLmHPb1thiqmTejQXgHp42M9Fy0XGT8eoHM7s8zKPISvW/S
 /Xovj6aARgfDPGOvc4/A5GNKMTQwTkgOIgVzWg0wiSML6cflHWW8Q3XmE+VUcKVAwDdn
 6XfPzIAKmOuF6uCEGgJE7bFSPn/dXKRpEzwQ4yA/2vlVdx86HZQoqQbaQqEfyBWypUJ6
 qcpFZNPynKjzYEV1g58sXzE6ajNgQGWn5XjsDryOnd4yJTXBVZrXQSVX9ghT0BY1fV6K
 Q7hA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6xY4EU0wEpDa4WqthWVZcIhCCamGg32PfFoj2DTyrYG5QMIHmqdvwZYWvJ6l0T+oID5WZ4bn4GlU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0XLgIIGcTkfWLor0qjI1VWQO4+7UsKIei4y8QHGb7UiXbjHh6
 QWAps4Y4WzX8Erj2nuhqd95BL5eZiBZmdmEL2Xm46Kqg/6r9m+Y24KJEUCDeRc/h6U0=
X-Gm-Gg: AeBDietTLZA1hVND6xx+D8DgwRH1YdgEYTDqbWvddQBYyC8VeO5bTk5xdyVRFKxQ6sr
 +IJpyvjFUTNNlvGTXuZPe/tUoRvCSNHzavwpTGNeEWh1e37PId7ZCGhiYja5mtGBLzerciPUXb6
 EBU/Dptfm67VVgkZkRtCGZl6Hnm4BjzEvCpnj85/PCBzQu0Qo3UpRYdqyPJefNyi7eJX5OPyCJb
 EKS8LzsEEJier3bT3PVBuIhuGMrgaXiY/o8C7plu5mWkK7Msv4vtZFznP+7jtR6FiJyI6caJ3ry
 XwtzgDQjam2/gFIoS6R2BCRulcys5imB1z6DVBip4jltk1LBDqHsY+l3O07ogbSKYPZFauNh6Ba
 aZrHPZ5gaQ03nH+4IRO+1kMkbkEHsL4Z8I/dWzc4cFD4N2qLvIKC4BiN0QVYzouEy8SbZr0FoXN
 Eet1EQ4ctETUO5SjvQ2xghyYPh3XR6JUkl4dNieCGEcEUa8SvnLz33yrU+N5hV+aFmIFv8e3efB
 j3PzdQNKVX+RrIUcDU=
X-Received: by 2002:a05:600c:4e8e:b0:486:f893:56c6 with SMTP id
 5b1f17b1804b1-48a860758c7mr85960465e9.10.1777619733040; 
 Fri, 01 May 2026 00:15:33 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:32 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 01 May 2026 09:14:47 +0200
Subject: [PATCH v3 5/9] soc: qcom: ubwc: Add config for Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260501-milos-mdss-v3-5-58bfc58c0e13@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=1658;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=M4levVKqvb3E1M9kQrx1UfApgZmV6eS0fxmbvwGU/sM=;
 b=ACM2ohFxIVpVweQ73Py4edYjMY/+UctWWAm6q415d5l1h+x9zkwG1+1YDlS7uWPHXVnGqVgvg
 70I2MgwnnolDWVS0T80Y9qdtwDKYYSlgrRpbeRegXvb76KPmYt8sMpI
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

Describe the Universal Bandwidth Compression (UBWC) configuration
for the Milos SoC.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/soc/qcom/ubwc_config.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 3fe47d8f0f63..1551f270afce 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -37,6 +37,17 @@ static const struct qcom_ubwc_cfg_data kaanapali_data = {
 	.macrotile_mode = true,
 };
 
+static const struct qcom_ubwc_cfg_data milos_data = {
+	.ubwc_enc_version = UBWC_4_0,
+	.ubwc_dec_version = UBWC_4_0,
+	.ubwc_swizzle = UBWC_SWIZZLE_ENABLE_LVL2 |
+			UBWC_SWIZZLE_ENABLE_LVL3,
+	.ubwc_bank_spread = true,
+	/* TODO: highest_bank_bit = 14 for LP_DDR4 */
+	.highest_bank_bit = 15,
+	.macrotile_mode = true,
+};
+
 static const struct qcom_ubwc_cfg_data msm8937_data = {
 	.ubwc_enc_version = UBWC_1_0,
 	.ubwc_dec_version = UBWC_1_0,
@@ -247,6 +258,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,kaanapali", .data = &kaanapali_data, },
 	{ .compatible = "qcom,glymur", .data = &glymur_data},
 	{ .compatible = "qcom,mahua", .data = &glymur_data },
+	{ .compatible = "qcom,milos", .data = &milos_data },
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },

-- 
2.54.0

