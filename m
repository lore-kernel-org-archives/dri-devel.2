Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72AF3C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79ACF10EC64;
	Wed, 22 Jul 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mx06ZQ5c";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZCxcdtpo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C28A110EC6F
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53idP3473730
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yaFuNCRXAnSBOSZbKpBDQZFE6PEtYKAhtV7IE6fz5U8=; b=Mx06ZQ5cHMSTVUJA
 NgVYJxtuOH3q+cprAmcBhKy6pUnSr8eOcsPQr5wMKznZ1/wBvQOKtM+CSOCjHKDH
 exW5wQOjbwvuZgMPoh8M5CahkuR4dxvWu5nVsM/10rnwdn+LJk85lMLzmCaLO9zj
 ayyQz37QmyGTIO3IiGjb+8GPM48XbKhHrQGb9GveF8cGI2KyRXHUVcewml84nnZC
 v307/+68a4Uk360TyziE8baem0rTDix0gUoUdtZ6vmbVkH+L8yywkUHZPw2hdLRS
 iZrXn1zJ6A8nMlAToN744pqeWtq3kRODMUL4XQmyyd9hwntI1AKnEGBuzA5+q1qB
 RepVwA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftma6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-520a00c7a03so154715711cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702224; x=1785307024;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yaFuNCRXAnSBOSZbKpBDQZFE6PEtYKAhtV7IE6fz5U8=;
 b=ZCxcdtpo2MiO+BoDdBTOCmHYbQouAaBnGXJAU+/qjpwFgArpLezc645Vh5mB0WNYuA
 ss5BWSOa8U20VS43aJtLq+V7KNQZyozDJbgx528Yo2eV8NZDCFtuvK7OMp51c7/CCNs+
 MLe9QpABRnad30yvUeFO8/4r1BQ71nIbbVYzpgPnuq+QwpYOvCWLhC+/3bSTW65YG9d9
 NghBpxhJ8jUDcbZ8ZbwBH3j9ev8JudYtUahmRFHlvd4i9Pkn4tLxeaedFjkWSMVfulyJ
 BdQGIEgvhP3l4V+/LhnOlQ/eU4IcwJa77LPJ/w1t2LvCP+uPR5wueHqrRFCvok+e6e6U
 HicA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702224; x=1785307024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yaFuNCRXAnSBOSZbKpBDQZFE6PEtYKAhtV7IE6fz5U8=;
 b=hmN5a+0Bn526ObeX9amldjWV01YG34lRFrbjtvbe7MogiDzVL12QLFw8/tDGA0zYoc
 F7XsP+Khk6HAiUf0FOxLPvfNnH1RCyH0371+57iD7p9p2AIGI4X0rsgTXGexZtp67xh3
 QLYRO7zwuaunL3UbZgUD+jT+VfIGdu5a102V6xrPVzgymX0VzWeSD3DgwUlscqJeHCxA
 u5lx1QBj8JZMMW2ncfHhQbYCgzII34StRQiMibRcqKiN1iGm/vz6m+IULbnBFFADxfwW
 vILpTiU0fYN2C3+V9Wt5jl124br9m5lYrYsurOc310Ghhs27/T41m3h41PXooJA6loal
 XOtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpbb7eUuyjdurc3hgOqcoo9P5koiOOS5Rgf/VeHCH+QZ7DLMh3y0+chhCtVtMV9uWMg7ZdtHoLQs8U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YydI8WrPYwwszmJyDLwzzG7QZwT18r4TlQ5zTwQbWTEx7yS1eqr
 8pm9oJ4MxcMT6fUDB+kesWboJtjWF+rNFmwIEFdBrYzFhKDipybbBWHOTBMDm53FN8MOM04608p
 Fs//wxnkJGFgx1vq+c1nXr55hYhrt97O7+RT4IhUYyvkoca1Do5aP5hg+sVz5S2UyFnaMbYc=
X-Gm-Gg: AR+sD10Cnp7BwmZd5JBmH0nB2lllEy1eqDL1JAX8ZlcixYLtAj8nzwXsTFr3WJDsC3w
 4c1Ggg8mtyk76IqBSZdfH9wAnuY4SRgXA1LAfEh+zh/a/uZQFdxigeiT1pssURul7wa6++OsV4S
 osOn8gyvjb760rnW3vGB4mg8LPNM1K+gVKlJdakfUWwoVm2GsDdwffagBSkDYW/H3tWk4PqzWlH
 ynsf4E/zOG70HNCblUXoDxwNCgZMWKgGE7RhEo3pys/f7d9gk29YWGYxbsJnEYMQaH4tT0bdeoI
 8W9GQARpA+conP3O1ZQeV14BuvYuU3perZqR0mpa0Wg+81eUKT4yKB4xzhEHAFeLQnS095JTs/H
 tShPmgh+hWEyu0vK1KF4MryKvUkiH9q6VM7hlF/pM2bEqyuJC17AIvjzQYyY28w7wPGr7gViYTL
 dT1YSYzYR9ogFnGg==
X-Received: by 2002:ac8:5948:0:b0:528:2e9:c0e8 with SMTP id
 d75a77b69052e-52802e9cb3fmr13547061cf.79.1784702224119; 
 Tue, 21 Jul 2026 23:37:04 -0700 (PDT)
X-Received: by 2002:ac8:5948:0:b0:528:2e9:c0e8 with SMTP id
 d75a77b69052e-52802e9cb3fmr13546751cf.79.1784702223696; 
 Tue, 21 Jul 2026 23:37:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:26 +0300
Subject: [PATCH 11/24] drm/msm: add the get_te_source callback to msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-11-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6856;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=iW1HxeBV/OI9ywvqkNJiv6+quKkZPYuL+t2SrY2ZMEk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTnw1h0vZ/U19qP9/PsZqlqJC1adcirKYutC
 5BZP5dFV6GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5wAKCRCLPIo+Aiko
 1SO9B/43+hlIiu2z8gpg4OwbpHLYJYpOfC4IFQ72OIXq4yxPiC4131IQIllEtx7uhIBV+8SB+9G
 /UlJKn2TwpCVGJnoavS1DqpuSQF+bPu+WMCstxSJZ2Mvh0KctK4KX8BXKSNGHVKwpYQTVz8c0yq
 rfAVw3a+IjW35ykK6HsVwF3zolXhnVFO1v4CuCMMmPqlp0ohP8oql9Etl3ojOh5djwqdHyUz+e7
 Sor1NjCmE0KZ8vpFSzaCdiY7Pknd5Zrm8y/rhHSMfy2keblcuzE16X/p1W3EU2ruMV3tYyVhxAL
 DOeW8XkHS9N1jJi7nyqP8b74To7TuHmP5jS6KBaofMS3k+iL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: gx5XhNd_FVHsFNLUZ32uf4AZ0L9u8U4Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX9hc4gVIOx1zW
 n/A037dzf33Bja5+deKkhHcSX9d0JHv4+3yxGT07NfiR4T9uds4PydBb7Y+kN6coLuZZvXd449x
 HndLKj2ODTD97XyQ3jfJ6918k5EaT8MQ1PZKSkd3PtEPGiQRLdzpJJP8L1jSGGwEY5tp6c5DbHx
 +aai+G9+XrSjdjmrligOPosvUcqEHjfnZif9Cd6RKpo66QHFkoCNDfjGq39J/Cs/ReizVwqGvd0
 2RBG7kcSrWi/4Cw1vrb6UOIxxsYwqDTlc8L8Xx6gB4sPhARdHmD6VmdzkP7mfNz1bFtkZAT48/a
 xiJxgZPVYHlqyjtCHslACvcztVvLDiTyocshYKDZEO7yytLChil+qg0uE3I2fEfiA6NNM9xVawV
 ex6fNZ8d4Uuct21zBCqJ5WTQwjNDklEpPYWV701P7kf0NX+M7dAuK7dNtl9lmG51i3FYOwwHkp7
 LgzjATzdkFwGHJW0DCA==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a606511 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=5UgVsPALq_5EqvSQFhsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: gx5XhNd_FVHsFNLUZ32uf4AZ0L9u8U4Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX6qYgID1SeySr
 5M+0v2UiXae8A+Q9HSSxlFOdXPd1nLcOEjC21Oydwa8ksyCp+XNuULBRO6r+K1tG1Mho9oidYjq
 6iJbfoYhkiy+zaopeVvvh0DdF6isI4E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
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

The DPU backend reads the tear-check source name of a DSI link through
msm_dsi_get_te_source() on the concrete sub-block while building the
display info.

Add a mandatory get_te_source() callback to struct msm_display_funcs; DSI
returns its te_source string, DP and HDMI return NULL. dpu_kms_dsi_set_te_
source() now takes a struct msm_display and dispatches through the
callback.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 6 +++---
 drivers/gpu/drm/msm/dp/dp_display.c     | 6 ++++++
 drivers/gpu/drm/msm/dsi/dsi.c           | 8 ++++++++
 drivers/gpu/drm/msm/dsi/dsi_manager.c   | 5 -----
 drivers/gpu/drm/msm/hdmi/hdmi.c         | 6 ++++++
 drivers/gpu/drm/msm/msm_drv.h           | 8 ++------
 6 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 7928bc1a73f3..8dacde316033 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -555,9 +555,9 @@ static const char *dpu_vsync_sources[] = {
 };
 
 static int dpu_kms_dsi_set_te_source(struct msm_display_info *info,
-				     struct msm_dsi *dsi)
+				     struct msm_display *display)
 {
-	const char *te_source = msm_dsi_get_te_source(dsi);
+	const char *te_source = display->funcs->get_te_source(display);
 	int i;
 
 	if (!te_source) {
@@ -617,7 +617,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 		display = msm_dsi_get_display(priv->kms->dsi[i]);
 		info.is_cmd_mode = display->funcs->is_cmd_mode(display);
 
-		rc = dpu_kms_dsi_set_te_source(&info, priv->kms->dsi[i]);
+		rc = dpu_kms_dsi_set_te_source(&info, display);
 		if (rc) {
 			DPU_ERROR("failed to identify TE source for dsi display\n");
 			return rc;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 047295d46c02..95810e3b01a7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1379,6 +1379,11 @@ static struct drm_dsc_config *msm_dp_display_get_dsc_config(struct msm_display *
 	return NULL;
 }
 
+static const char *msm_dp_display_get_te_source(struct msm_display *display)
+{
+	return NULL;
+}
+
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
 	.snapshot = msm_dp_snapshot,
@@ -1386,6 +1391,7 @@ static const struct msm_display_funcs msm_dp_display_funcs = {
 	.needs_periph_flush = msm_dp_display_needs_periph_flush,
 	.is_cmd_mode = msm_dp_display_is_cmd_mode,
 	.get_dsc_config = msm_dp_display_get_dsc_config,
+	.get_te_source = msm_dp_display_get_te_source,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index e42f5b929b84..e07d1a964c7c 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -20,6 +20,13 @@ static struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_display *display
 	return msm_dsi_host_get_dsc_config(msm_dsi->host);
 }
 
+static const char *msm_dsi_get_te_source(struct msm_display *display)
+{
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
+
+	return msm_dsi->te_source;
+}
+
 static bool msm_dsi_wide_bus_enabled(struct msm_display *display)
 {
 	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
@@ -294,6 +301,7 @@ static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.needs_periph_flush = msm_dsi_needs_periph_flush,
 	.is_cmd_mode = msm_dsi_is_cmd_mode,
 	.get_dsc_config = msm_dsi_get_dsc_config,
+	.get_te_source = msm_dsi_get_te_source,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 959daa88b1d0..2a5326f1fa8b 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -614,8 +614,3 @@ bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
 {
 	return IS_MASTER_DSI_LINK(msm_dsi->id);
 }
-
-const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi)
-{
-	return msm_dsi->te_source;
-}
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 918fc9c88a19..6e077747ebce 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -249,6 +249,11 @@ static struct drm_dsc_config *msm_hdmi_get_dsc_config(struct msm_display *displa
 	return NULL;
 }
 
+static const char *msm_hdmi_get_te_source(struct msm_display *display)
+{
+	return NULL;
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
 	.snapshot = msm_hdmi_snapshot,
@@ -256,6 +261,7 @@ static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.needs_periph_flush = msm_hdmi_needs_periph_flush,
 	.is_cmd_mode = msm_hdmi_is_cmd_mode,
 	.get_dsc_config = msm_hdmi_get_dsc_config,
+	.get_te_source = msm_hdmi_get_te_source,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index cda9849811b1..989b0a37d6aa 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -288,6 +288,7 @@ struct msm_disp_state;
  * @needs_periph_flush: whether @mode requires a peripheral flush; mandatory.
  * @is_cmd_mode:  whether the sub-block runs in command mode; mandatory.
  * @get_dsc_config: return the DSC config for the sub-block, or NULL; mandatory.
+ * @get_te_source: return the tear-check source name, or NULL; mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
@@ -299,6 +300,7 @@ struct msm_display_funcs {
 				   const struct drm_display_mode *mode);
 	bool (*is_cmd_mode)(struct msm_display *display);
 	struct drm_dsc_config *(*get_dsc_config)(struct msm_display *display);
+	const char *(*get_te_source)(struct msm_display *display);
 };
 
 /**
@@ -336,7 +338,6 @@ void __exit msm_dsi_unregister(void);
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
-const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi);
 #else
 static inline void __init msm_dsi_register(void)
 {
@@ -356,11 +357,6 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
 {
 	return false;
 }
-
-static inline const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi)
-{
-	return NULL;
-}
 #endif
 
 struct msm_dp;

-- 
2.47.3

