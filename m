Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2BDC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196DA10EC6C;
	Wed, 22 Jul 2026 06:37:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oePr3/Vt";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YbaR99xW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6817F10EC68
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:57 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53bmp3882940
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fnFqMPIwhl9ESQYxC7SAYAMToEfuxgRlxIUeZ483144=; b=oePr3/VtTbd/9p3c
 uQdXguzxISS9GGDiyM9ynFZJ/XjmVFomJ/lYsF256yZItM7PHTybpqPuxeg3RcYA
 uJdbMdEPaiBDKaCh+CWqMmYF3cqegN8jbvt0IaUosYcFVpFpd81klhg3pc2OjCQw
 dVXnyNKgR45lco22HhNjLA2tVtTMTZciIhPHWNDhxbM7nysyfv9hCKeKrdQ+So46
 2n2BuMFeUDzWKNA6MfKlg/DGwzbPZa1yP1Bde11UpExgs1UdFlTdC4KM94t80mDn
 wS+bI/+nH+gIspHnsoSbNVlfWqCHR0uPp3nB9rP1lWwMjYHPMCD1RHPeDlCtg0/c
 WcNKwQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn0nsk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c19493ac2so25705311cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702215; x=1785307015;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fnFqMPIwhl9ESQYxC7SAYAMToEfuxgRlxIUeZ483144=;
 b=YbaR99xWumr0s8/+hKwDuXJGGvtlUiOFUJ9rHX1fRc8znYx6BDNB98JikNzj2Jhtsi
 MKWkzoscM/CrEJx/wZq0NPSI6CxDrPpl+3tjsjTc7pxbIki5RDpwRUSFiWPycfxBFTfZ
 uoiJSM8xq/+eDa9M/4evr99Yh62qfic1XK2ZfXN2f8Xe1jgp3yTVkF8rIxUv7FaLtmYN
 mKz+jk5Lc68GsWrAgf4UoQWezfT0wBVWmIDH3tf1B/zjGGKQcwQNtUqdgaPzcLByYBu5
 CoHQHlJQZ//XccSsc5gCZQFjm46h2Wa0BgqWRSHhhgTH1nq5vUtryKPV9kvmV8xUuG9b
 gi+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702215; x=1785307015;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fnFqMPIwhl9ESQYxC7SAYAMToEfuxgRlxIUeZ483144=;
 b=Rp0eE5oAm+uOTfGs0vp4LRWISWNRddKXu1JsWQkRufJuEP6aVLD2WpImjaa6Rp4ZPV
 MK9m/sKwoA3Cwvamewy4aZTZ+Xf+qDPIkng7AVTD22biLFOf2RptWGB7DxrNWCNj8Q1x
 EvANaRhNJGv1vA5zzDRswzUFcT4kYxwuEeZDZN5ikUBcNVQ4meyXq1MZUJFPTkG1tsIT
 RCavaPW4bJ5amh15qle1LTIDtFo/RGyUkAUor/FTUsTeRZzRDs8fZgRUzxkn+skytDX6
 7IKe139Tp4jYqxik0f63YEP7mKho9qbEa+vOw0vT0N8RcnhaHXgTWLVAzMTLdLFNjhxJ
 Bpqw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq0tpp0RjLJV9zajY0ZQTXlrBdrQ4oLT5DyxW2yCkR4RStSrFCim4n+ir2nHPmBRHuCSSeAjoi9tPI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxC6IOunkx2JY65RkCkR4+vaHddt9fC/SVXvDnq1M4XybTrHamy
 ZU1I2vjL+S5jT7KxTUNwxzyfTU7VowCSTBgsEDVHI4vDcv2c5ZwFFfK6pq3cLuUMWiK6F5p8Nmy
 jBbbb+DvpNhrskEzI751Tt5iVuPvqGFMkOAJRkMVKx72/qn20B+h9GnTH4i0e33EJPvhfr1o=
X-Gm-Gg: AR+sD12gWT3frqtfGfuW2ENTf/ltZ96V8UrklnEZ7IdFMco35BAtffG4HScuu0XjrCX
 szy00pRqtQaKaWDYEfUAT8XiuNqpAItvddD1Npnrt2EduhkGDSW9hbVZv8UvGoaxZ1YEOiBEU7H
 eskazfDf6//ETcQXSShjIixJW6uIJWgi0Gvwy/9ypT8z36DSv+RnG3vnrA73QoE6/9gbGf2Jia4
 cMx8KrjbpkuWTt0mzbgRJYvHbmvtUfcBEnA0wtOBstS1upYDTN6NCkqdmBYSAxoaZDGHvjHhezA
 NnuABTAyHdMJWzUD2SCL08jQQKVye/+KpYce6f9m+Zwg9wU/oX9jKozwDC9FE+3Hm/Rc+7xfVX/
 NXLhC4ewNWVNsI/x9QgV0BfaxwJLY849jcvzNWhp28XKbZCpZrcN4MGI6Fde+Hu11x6VODid0tc
 jGtFthQeVpNa1QTg==
X-Received: by 2002:a05:622a:2517:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-5213c008207mr199181401cf.7.1784702215121; 
 Tue, 21 Jul 2026 23:36:55 -0700 (PDT)
X-Received: by 2002:a05:622a:2517:b0:516:dff5:68c4 with SMTP id
 d75a77b69052e-5213c008207mr199181121cf.7.1784702214660; 
 Tue, 21 Jul 2026 23:36:54 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:52 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:23 +0300
Subject: [PATCH 08/24] drm/msm: add the needs_periph_flush callback to
 msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-8-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7968;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2uXfUn5g7kRlwm21Pr9tBhdKWBQ199h8b1vj9ghErGk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTnXge1bBgGka1roOOJfkQGuKiQpSpfSTOp6
 wPoENWyq2uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5wAKCRCLPIo+Aiko
 1VwXB/90SZS2MJUkkk5cwpAYTgeoMq1uX2oGAQaTPQb6gpLSr6ud/GRotHgpeQPptSUkHivuVzy
 o/MTk2OpQJRy6jRwOLsNVNAqCafwhji9IM5A2rlEk5Vs6na3ESNVcpriGifUiZdlLlD1ZNfkJi7
 vHptat35d/gIyNsrDYNnL7sOgt6wYyrh1TjNFvZwc0t8+Uq6GSuk0qK72WcM/k8BMDB5mIBifgb
 JZJJ/wZsVUWIjGab3iNiM+gWHxbhwpc1vIk9H/RmVTObw92EPt6cTYto6BhcUUQavbEaxDHcLFX
 JPvgM/atAwFNbZ0QfobExXiPhsEQMlFn99JB6TN0FZ32WDp2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a606507 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=3NYe07cDTqo7tWFtHwUA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: dkzUVQOk-hfjIUiRRLmAp3D8fjN2Kah9
X-Proofpoint-ORIG-GUID: dkzUVQOk-hfjIUiRRLmAp3D8fjN2Kah9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX9cAp4McCMhKD
 h01WLL1vT7fnymxYOlPnA8R87CkshAM+wZQjHhYOEp9Ug4FF6qDbTJiOXL5VBfMEbqV7wQHNzVd
 C+ZqX8UV4oICCt3xY0HbIyjMfXGdslU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX7cHBOTtLlsa5
 DlrwzTTid5KzCavWBS1FQb0b/F8ji8k8uI4up7pdZWEfEpQQ6evVPGS7W7v65EXNrAnirk1Ann4
 MrmYFPD42a1bvUE4fYBbrUzBFLCnTSwtMT6FZPvkFul66MqJCchSc8RTi8Kl7WzTbfcySKm7qFj
 0bMdmyp8+Ygm/qnH0hyBq/vpveePcpiZ3zRopXNOMQonD3VU5D2Lqa0WV74RdOM//T/3QHEGic5
 R3JaObloClmcsWLrHI+dhMjb+dnE4J1SSZMvjmLX1sQzJo+dBBQDH0Riug+2I3GJHICxqipuXO9
 XkgX2Y5FTtWWOlBYwMHNu6QG/KE/Z90mD5bYZEJlqlpwL5zoqwdOmNMuI8QJzLuqpVL4GI5Z45K
 yCjqCIpAHFT1vKrPWHxlwLJzTWtQ9M02F1RUNCbtj63m/5CsTxE96xWeviIs/1UEKtVKm2Qpy9w
 jG0D9VT3f47UgLcYWMA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

dpu_encoder_needs_periph_flush() switches on the interface type to call
msm_dp_needs_periph_flush() on the DP sub-block directly, hardcoding that
only DP interfaces ever need a peripheral flush.

Add a mandatory needs_periph_flush() callback to struct msm_display_funcs.
DP implements it (keeping its internal msm_dp_needs_periph_flush() helper,
now declared privately); DSI and HDMI, which never need a peripheral
flush, return false. The DPU encoder now looks up the sub-block and calls
the one callback.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 49 +++++++++++++++--------------
 drivers/gpu/drm/msm/dp/dp_display.c         | 13 ++++++--
 drivers/gpu/drm/msm/dsi/dsi.c               |  7 +++++
 drivers/gpu/drm/msm/hdmi/hdmi.c             |  7 +++++
 drivers/gpu/drm/msm/msm_drv.h               | 11 ++-----
 5 files changed, 54 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index ce358c1c9757..09bf959b2ca7 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -245,29 +245,6 @@ u32 dpu_encoder_get_drm_fmt(struct dpu_encoder_phys *phys_enc)
 	return DRM_FORMAT_RGB888;
 }
 
-/**
- * dpu_encoder_needs_periph_flush - return true if physical encoder requires
- *	peripheral flush
- * @phys_enc: Pointer to physical encoder structure
- */
-bool dpu_encoder_needs_periph_flush(struct dpu_encoder_phys *phys_enc)
-{
-	struct drm_encoder *drm_enc;
-	struct dpu_encoder_virt *dpu_enc;
-	struct msm_display_info *disp_info;
-	struct msm_drm_private *priv;
-	struct drm_display_mode *mode;
-
-	drm_enc = phys_enc->parent;
-	dpu_enc = to_dpu_encoder_virt(drm_enc);
-	disp_info = &dpu_enc->disp_info;
-	priv = drm_enc->dev->dev_private;
-	mode = &phys_enc->cached_mode;
-
-	return phys_enc->hw_intf->cap->type == INTF_DP &&
-	       msm_dp_needs_periph_flush(priv->kms->dp[disp_info->h_tile_instance[0]], mode);
-}
-
 /**
  * dpu_encoder_get_display - find the display sub-block driving an interface
  * @dev:        the DRM device
@@ -294,6 +271,32 @@ static struct msm_display *dpu_encoder_get_display(struct drm_device *dev,
 	}
 }
 
+/**
+ * dpu_encoder_needs_periph_flush - return true if physical encoder requires
+ *	peripheral flush
+ * @phys_enc: Pointer to physical encoder structure
+ */
+bool dpu_encoder_needs_periph_flush(struct dpu_encoder_phys *phys_enc)
+{
+	struct drm_encoder *drm_enc;
+	struct dpu_encoder_virt *dpu_enc;
+	struct msm_display_info *disp_info;
+	struct drm_display_mode *mode;
+	struct msm_display *display;
+
+	drm_enc = phys_enc->parent;
+	dpu_enc = to_dpu_encoder_virt(drm_enc);
+	disp_info = &dpu_enc->disp_info;
+	mode = &phys_enc->cached_mode;
+
+	display = dpu_encoder_get_display(drm_enc->dev, disp_info);
+
+	if (display)
+		return display->funcs->needs_periph_flush(display, mode);
+
+	return false;
+}
+
 /**
  * dpu_encoder_is_widebus_enabled - return bool value if widebus is enabled
  * @drm_enc:    Pointer to previously created drm encoder structure
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 04d291a93d20..773dee9d0be4 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1290,8 +1290,8 @@ void __exit msm_dp_unregister(void)
 	platform_driver_unregister(&msm_dp_display_driver);
 }
 
-bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
-			       const struct drm_display_mode *mode)
+static bool msm_dp_needs_periph_flush(const struct msm_dp *msm_dp_display,
+				      const struct drm_display_mode *mode)
 {
 	return drm_mode_is_420_only(&msm_dp_display->connector->display_info, mode);
 }
@@ -1361,10 +1361,19 @@ static bool msm_dp_display_wide_bus_enabled(struct msm_display *display)
 	return msm_dp_wide_bus_available(dp);
 }
 
+static bool msm_dp_display_needs_periph_flush(struct msm_display *display,
+					      const struct drm_display_mode *mode)
+{
+	struct msm_dp *dp = container_of(display, struct msm_dp, display);
+
+	return msm_dp_needs_periph_flush(dp, mode);
+}
+
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
 	.snapshot = msm_dp_snapshot,
 	.wide_bus_enabled = msm_dp_display_wide_bus_enabled,
+	.needs_periph_flush = msm_dp_display_needs_periph_flush,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index ce3b261123ea..085e202bf7e6 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -24,6 +24,12 @@ static bool msm_dsi_wide_bus_enabled(struct msm_display *display)
 	return msm_dsi_host_is_wide_bus_enabled(msm_dsi->host);
 }
 
+static bool msm_dsi_needs_periph_flush(struct msm_display *display,
+				       const struct drm_display_mode *mode)
+{
+	return false;
+}
+
 static int dsi_get_phy(struct msm_dsi *msm_dsi)
 {
 	struct platform_device *pdev = msm_dsi->pdev;
@@ -282,6 +288,7 @@ static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.modeset_init = msm_dsi_modeset_init,
 	.snapshot = msm_dsi_snapshot,
 	.wide_bus_enabled = msm_dsi_wide_bus_enabled,
+	.needs_periph_flush = msm_dsi_needs_periph_flush,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 5f24f778c7ef..72f7403265f9 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -233,10 +233,17 @@ static bool msm_hdmi_wide_bus_enabled(struct msm_display *display)
 	return false;
 }
 
+static bool msm_hdmi_needs_periph_flush(struct msm_display *display,
+					const struct drm_display_mode *mode)
+{
+	return false;
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
 	.snapshot = msm_hdmi_snapshot,
 	.wide_bus_enabled = msm_hdmi_wide_bus_enabled,
+	.needs_periph_flush = msm_hdmi_needs_periph_flush,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 519571170207..806d72ed393b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -285,6 +285,7 @@ struct msm_disp_state;
  *                mandatory.
  * @wide_bus_enabled: whether the sub-block drives a wide (2 pixel/clock) bus;
  *                    mandatory.
+ * @needs_periph_flush: whether @mode requires a peripheral flush; mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
@@ -292,6 +293,8 @@ struct msm_display_funcs {
 	void (*snapshot)(struct msm_display *display,
 			 struct msm_disp_state *disp_state);
 	bool (*wide_bus_enabled)(struct msm_display *display);
+	bool (*needs_periph_flush)(struct msm_display *display,
+				   const struct drm_display_mode *mode);
 };
 
 /**
@@ -372,8 +375,6 @@ struct msm_dp;
 int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
 struct msm_display *msm_dp_get_display(struct msm_dp *dp_display);
-bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
-			       const struct drm_display_mode *mode);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -388,12 +389,6 @@ static inline struct msm_display *msm_dp_get_display(struct msm_dp *dp_display)
 	return NULL;
 }
 
-static inline bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
-					     const struct drm_display_mode *mode)
-{
-	return false;
-}
-
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.47.3

