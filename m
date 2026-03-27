Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 881FB10F284B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A169310EF13;
	Fri, 27 Mar 2026 16:12:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="P2rO6dbW";
	dkim-atps=neutral
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C09F010EF11
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:37 +0000 (UTC)
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-b941762394aso347708066b.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627956; x=1775232756; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9jDY2PYGbaZfyJpszHkpHZ5M00y7JZRiJojTTA2GybA=;
 b=P2rO6dbW2y3IxfLpitrOOBMxy1//rw5FCnyNXEByw6axDp+pxruLiK2Qs95a3PN+lL
 f7oeQPbj4Kh8Vhs14/jjYtag8rKdlxmr7fKN76y8VHifhkeEVTqo5tdnFEyRWr84/Dlm
 fusMhixOFZG1Wt6ck8vPtLnMR//jRC6U+sBD7y/rwUdnHLCLO+xWxg5oRF+zOlyarKEn
 wt0IN2UeQ9u4Ys/dKPqb4gn/ya/AouWHO+H94KJLhR+11B59y1jcqRi2KjKeqqp0uINs
 y4Wz0oqaCQCUcCyfwhV7ydSm1f19Gc9/PDzm4CUp5tIUqNMW1lYwIyZcjsx6oac1RxQl
 ta6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627956; x=1775232756;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9jDY2PYGbaZfyJpszHkpHZ5M00y7JZRiJojTTA2GybA=;
 b=tO6kAZJhLL9tfw1PkGalPVBXPCQsWUOQHqTYLLtJhDtQscgVnoDXApyJSfnRpPeigQ
 4MtQrvuOSD3wh53LzBclGh/0TSQhSfRzXnheobvSCiSweozBx+mOQU8V9Gqx4dkwOTJS
 hgyo9r0z6SKZuTu3rul9/sH8oLmB/hwZZdUOD4q4gmugIHwIBMyWyKNaZjJutmnskzrC
 GsQkAgCNznsqfVuOdavpNdOoHnWp96uz/u4J7wJJuwITjcPifz5k/M98BJ9c02sv+nfa
 nIk8TL7g+8y51nTK1e8sS7XpJPXNAy5yZhbiK6c6HWguILthHa33J/Lje/KYzbSVblhX
 rziw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmhMmpUxaEBl1Nn9NCJQCM+0HQveF1IwNTELtKe/9rZybixR4xkIPxjNZuqk544bNDYzdJK4K+zfI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw4Cjr+hlfv2BO8sNsvX0dVMvLZau41fpHABZllCeegCTABMyHC
 mJFrMnitD11BTpc0vOI7tBjhZpY35YTyyLPCecUT+LRpbq/eqiNOkQTAMoeDnup/Kp8=
X-Gm-Gg: ATEYQzzPFMjw8I4thvY8f4LBJzyspuWoeGlAozMN6wMjNlU/+BwuVjE2pzMkZGwUCxN
 D99CTS/RKokd10JDqwBkMEhgMuvLgntGIgjJxIdS9ZirEYos08fxK3VDmK0Ntrk02Yarj3qPYLd
 6jPI/Iq464P9z2y9K8XOXpaF8FqsD2204A0wF5rTuFCdEEkfy1wR7o+nP578Xnk4osA+/GXlf+L
 TKMgPC5Oiu/W3jfjyXuYzzUCPG2zYy2l8cyr5GG5t91NjSbWDxmlw1MeNlFcBCvP7hyUPIS9hEu
 S0q5wx2isyABpC/jdCD/ax0L9LHfBzmM1ymRXj0h2qSrHRec1DJd7lmQWJAJz/W32SKp7x8sFh2
 hPuURvVe6aHbvYqACCS6kqU6YtKJrRNEGTxXZIQ6HxrwOVg/s5ysFc6q9ctTxVQm0mUyHS0RNy1
 vHR5pIlK/u9RTcdng0hn/gQ7kfMjFf9DnFCAFxf0fEgR1URUYT474UlVpr0ipHq2e4RF07xsyxQ
 rydCA==
X-Received: by 2002:a17:907:9306:b0:b98:4abb:cc49 with SMTP id
 a640c23a62f3a-b9b502bfd00mr209569466b.5.1774627956162; 
 Fri, 27 Mar 2026 09:12:36 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:35 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 27 Mar 2026 17:12:24 +0100
Subject: [PATCH v2 5/9] soc: qcom: ubwc: Add config for Milos
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-milos-mdss-v2-5-bc586683f5ca@fairphone.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=1658;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=5cRqSrO9TWRQUaD7bTpD1ZxLquZmqnEMTYi63NVSawg=;
 b=aIVcCFwLleXDR6BbWbAVLdZGSgSQE3T0zkh07vYu6x6K/HU3SUHpaustvo0IrxX3T00BKLHOA
 f+oyhjM/FIkCWLIqvrDlNpWYSCHXcofk+OrlUQkx6J2XtUJlVtSdlnu
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
2.53.0

