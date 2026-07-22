Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB660C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 575EC10EC7E;
	Wed, 22 Jul 2026 06:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BMVVYsR3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eSm9gm1g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E94FC10EC79
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M61sWt984434
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aQWkOjb7s1/Nv6UGotHwKuaoEbTsQknHkswMzc3hyws=; b=BMVVYsR3DuBHH0Q1
 hiqS08YCfOqcHDBjxhsSJrxH5PYamaxjoBGu5de0zleuTdvJMmwljvcNRD632yBM
 1jkRCVwq00B4CG97JgOq4vc6AKYOpGY7EH9Ayvd2yfcVipy/2YEkR91ZEpKZwX7/
 1+JhiMKxn8l0kGE6UTeOF6U5LMKud/pQwRfjpAo6EvHimDkvFfjUMpD1p4k7Hjgj
 E3wWqgj4W7qKbwhsj8vNZAM+8OWovqC+oorm2E0e9VTRFIjVFEHc+LmPk44U28wZ
 C8LTPoKjvB8/cqzJl32CepnViUofalE1V9rvJIOcLgigH8WA6SLKpPkzxEyk52TP
 ijZkAg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjr8384ap-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:31 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0e702df8so181841621cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702246; x=1785307046;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aQWkOjb7s1/Nv6UGotHwKuaoEbTsQknHkswMzc3hyws=;
 b=eSm9gm1guyGFJCDripUrq9qosv1l9VHW7ta6Kfni3innzlpebvoAyy/A9osSUmEtqM
 1GTK5A6J1VJyYfJ3MZ1GTOyveox/ufOqYZ32kSPD7eSGxPpLLCchiLW+kKGfu9QyAKuW
 GGBTZ8OPyTqb1jdkpFjLJUQOmmzBPhcE0Bm0Pqmx2qo2wn64RhR3MqegKgxOBpDASWTX
 y/F+rAZ/jdJQ1mlEF9gNc5BwlqaM5eYux8W4xpZHh5ww/cFmzucbQ8S/2VWDdrK+4WVW
 lwA2h1+hxQsFjC8Pk+KBtgKVwLpzSuorqb1X3ZHlFjY0BEtPFDaf5+leVUpYOJSbKqCm
 cIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702246; x=1785307046;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aQWkOjb7s1/Nv6UGotHwKuaoEbTsQknHkswMzc3hyws=;
 b=Xm0sw7tmwnhpxks3KKgjoLRMUwybsw8URqDjFFGSe+6YKpgdaZpj7BW3uKhpFwEgZI
 KhaMquRyoLD72qmpIUSJ6fz2BmKYtCnIkXvpKlnX0b6qxe5P8F6hh2GNUGUSD6T57/sT
 snVhGuGxpKkHklrS4QHuXLFyCW+JXEWAboTxa+T6nhGybjGtzgzoglN1bxRQV+cLvK4D
 Jpxw4eHdrptxv2fSDgOkZxVvhgsN3JIuI7QVBxSQmdqshfxkwJI3n23Er7iCC1qj/qTr
 QlZ+TeXg8HCBCKiACAdsOZVAPi5XTUxOBHbnKoBLMPWx2zrdJdiYeYufGGOENoc1rQ34
 BM4w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrdii4Pqa2bS0pGoOSdq/07ZtBmrAfoN/518vqiKJD/opU4O9mm6nGQb218RGtIsW/aWRmehk31h0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9ayb9aLFIaLF6rGOZb0ZGar+544bvVtN7vWSDtpnoMDtVbAdB
 x8RWbH7MxMJ/g6jW2HtoI/UyIAhs88ex+v4NblYPPKx2OO1qGOUyZUx79nrF9nlswbxEhsJH0iM
 39MMbixMrVxW/QTnqDo8vbss+Ltc66lWswv8O/xXDnsTSN/TdNe0wRc3KUr3mxE8CqIbkuWA=
X-Gm-Gg: AR+sD11Bcpor+SbJqHh+JZ9828eHLSKak8lfgrTQ4cBHXAMuFFKjD7/fbHOmdYbkbHS
 Q3/h90XqthrBS0+eIa+FMr7hVra8vOhdgdXG4CA+IBzIuy+xOD9HdTjuCKLfEdQ4TZOIgh4IKcS
 0TYDkPAyW6xV7K8ZxoliaaJ3JTqXnJFjgNnZUgDxs5a4hu67/XvaHoRrKdR46HPPHW4qrNk0VMr
 QNF+aqB0sP56Qwz39I3V6eMaFz0w6hKH52u0Z581lCfy85shsb/lsCNuN9YC7QPp3LlpY6eZU6Z
 Nkv2Q6MKHF+S0/eNevkpCo6bPMnHBQXJAAXTH++RJiYHC0QhXKfyZqQugbX3zyJYkAxwh0ByWRI
 8w9rB5sMxY2U2jm8R1L01yGDOmHoHamdlrCSNO4kQKlFrD3ZKNaDnU49sJc8gF/Dk/CJZ+kto2B
 yzQb6fyWYKMdppuQ==
X-Received: by 2002:a05:622a:4111:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-5213c5f3e47mr203448141cf.25.1784702245886; 
 Tue, 21 Jul 2026 23:37:25 -0700 (PDT)
X-Received: by 2002:a05:622a:4111:b0:51c:257c:8164 with SMTP id
 d75a77b69052e-5213c5f3e47mr203447931cf.25.1784702245372; 
 Tue, 21 Jul 2026 23:37:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:34 +0300
Subject: [PATCH 19/24] drm/msm/dp: drop redundant panel->connector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-19-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8683;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vrk0zAkx3XteBl/zMHSAsYalFx0A87dpjiTf4rSceZk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTpwZg19pnYNYwwmnZyD1Iob53kPueOk/9S7
 uTOir7FvBCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6QAKCRCLPIo+Aiko
 1RCxB/0TJAx9rW7Zo9Jif7MP7sO3ErixKjMLFJOIMSqd4qeLuC8qaWCWIYEB++ScRJK/GMGWyvL
 WpJDEmQN87EgZEYdLlCY9WdkWskvFO16fdNDhLZi0Mu+LsKdHaVfLVV9LHDYFEAYMpGQQLwaVi/
 uYwbEbe7G3WZeyxBS8eEDIu/eb6inaDxpmbVqzSR/Hh9CUXnZ0ogFEO9/eb4xS85IRnDbrqeOgO
 8XbKPkEeX9xlQVRC7lW1Cr9JZLdUetjYfmBtyoy8dO2DsUlPVckwaRvedkb94aUBsahuFLkiRad
 jLRlABsrcKywTcvp4wCEhv7ro5fkwf0DEqnNK7ixylMgiFit
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: O5floc9Y4mnSeRgMWd63dqci6JVnmyr1
X-Authority-Analysis: v=2.4 cv=VfrH+lp9 c=1 sm=1 tr=0 ts=6a60652b cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=zDF9bxl-6Y4pHeVFKNQA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-GUID: O5floc9Y4mnSeRgMWd63dqci6JVnmyr1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXwJJX98TlTy4S
 UQkCUhqTbecp54WmidhwPKtBllJ7iNwF3ugz5XQHdzJOtj0Ap7N4qGpRWf9wBGXtJvtF0A/V//t
 DM6LCsUQU2ScBqIqMUmciVlcv9iLLDN6AvDNyN65cbnskRxo8NAMeQ62Jfic9vQToEMktJxvd4t
 kPtysNNCa6GOj1amIuof38mWNEd5OgY6i4us3uTLAQX1BpGCmSV+7ZFHcuR21pwqTXnxHrARU1P
 gLwqHOAMtbyjrj4iTZ6D8zgD01hNn6JNQPgcc6rexEv65qnBh/EkDvne7Sv1+Yu4A2Utoc1Oh9l
 bdlQFpPLoeKIiMyLaApR9vh3Jc2so4lTiAbKDXBqdssVasnmwJLSxrIKYWRtDa71m/lYowt+Tpl
 LvTVvWKa78ECRRGGdttjH3A4Wx2MqJ7txVuYmXieNQa3tcwjP52dYeylbx2Nfj0MDuuuJ0A+R6I
 PvnBh4P6GKJZZz4Rbvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXx/5mdUqXwkNw
 4qtGkxeqDQLN10+95c7q5txwgSN/PxNqzvHRW7YyF0/3q5p+P9zpZLVpgdtOhj2lwHXA2uAidpU
 FD/UkWq2fbVaiyPX/91kDiLadEDo5sc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0
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

struct msm_dp_panel kept its own copy of the drm_connector, a plain alias
of msm_dp.connector assigned once in msm_dp_modeset_init(). It was only
dereferenced in three places, each of which either already has a
connector at hand or is reached from a caller that does:

 - msm_dp_display_set_mode() runs from the .atomic_enable bridge
   callback, which can fetch the connector from the atomic state;
 - msm_dp_display_get_modes() is called from the .get_modes bridge
   callback, which is passed the connector;
 - msm_dp_panel_handle_sink_request() is called from
   msm_dp_display_process_hpd_high(), which holds the connector.

Pass the connector down to those functions and drop the duplicate field.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++----------------
 drivers/gpu/drm/msm/dp/dp_display.h |  3 ++-
 drivers/gpu/drm/msm/dp/dp_drm.c     |  2 +-
 drivers/gpu/drm/msm/dp/dp_panel.c   |  5 +++--
 drivers/gpu/drm/msm/dp/dp_panel.h   |  4 ++--
 5 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 7f55cace596f..461420a72820 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -304,7 +304,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
-	msm_dp_panel_handle_sink_request(dp->panel, drm_edid);
+	msm_dp_panel_handle_sink_request(dp->panel, drm_edid, connector);
 
 	/*
 	 * set sink to normal operation mode -- D0
@@ -600,7 +600,8 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 				   const struct drm_display_mode *adjusted_mode,
-				   struct msm_dp_panel *msm_dp_panel)
+				   struct msm_dp_panel *msm_dp_panel,
+				   struct drm_connector *connector)
 {
 	struct msm_dp_display_private *dp;
 	u32 bpp;
@@ -611,7 +612,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	if (msm_dp_display_check_video_test(msm_dp_display))
 		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
 	else
-		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+		bpp = connector->display_info.bpc * 3;
 
 	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
 	msm_dp_panel->msm_dp_mode.v_active_low =
@@ -619,7 +620,7 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	msm_dp_panel->msm_dp_mode.h_active_low =
 		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
 	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
+		drm_mode_is_420_only(&connector->display_info, adjusted_mode) &&
 		msm_dp_panel->vsc_sdp_supported;
 	msm_dp_panel_init_panel_info(msm_dp_panel);
 
@@ -769,18 +770,14 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	return MODE_OK;
 }
 
-int msm_dp_display_get_modes(struct msm_dp *dp)
+int msm_dp_display_get_modes(struct msm_dp *dp, struct drm_connector *connector)
 {
-	struct msm_dp_display_private *msm_dp_display;
-
 	if (!dp) {
 		DRM_ERROR("invalid params\n");
 		return 0;
 	}
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
-
-	return drm_edid_connector_add_modes(msm_dp_display->panel->connector);
+	return drm_edid_connector_add_modes(connector);
 }
 
 bool msm_dp_display_check_video_test(struct msm_dp *dp)
@@ -1350,13 +1347,10 @@ static int msm_dp_modeset_init(struct msm_display *display,
 			       struct drm_device *dev, struct drm_encoder *encoder)
 {
 	struct msm_dp *msm_dp_display = container_of(display, struct msm_dp, display);
-	struct msm_dp_display_private *msm_dp_priv;
 	int ret;
 
 	msm_dp_display->drm_dev = dev;
 
-	msm_dp_priv = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
 	ret = msm_dp_bridge_init(msm_dp_display, dev, encoder);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev,
@@ -1373,8 +1367,6 @@ static int msm_dp_modeset_init(struct msm_display *display,
 		return ret;
 	}
 
-	msm_dp_priv->panel->connector = msm_dp_display->connector;
-
 	return 0;
 }
 
@@ -1438,9 +1430,12 @@ void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
 	struct msm_dp_display_private *msm_dp_display;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
+	connector = drm_atomic_get_new_connector_for_encoder(state, drm_bridge->encoder);
+
 	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_bridge->encoder);
 	if (!crtc)
 		return;
@@ -1451,7 +1446,7 @@ void msm_dp_bridge_atomic_pre_enable(struct drm_bridge *drm_bridge,
 	 * state and runs before the bridge's .atomic_enable(), so the mode must
 	 * be programmed here, in .atomic_pre_enable().
 	 */
-	msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel);
+	msm_dp_display_set_mode(dp, &crtc_state->adjusted_mode, msm_dp_display->panel, connector);
 }
 
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 8c34a473c7db..f1523dbe33d5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -28,7 +28,8 @@ struct msm_dp {
 	bool psr_supported;
 };
 
-int msm_dp_display_get_modes(struct msm_dp *msm_dp_display);
+int msm_dp_display_get_modes(struct msm_dp *msm_dp_display,
+			     struct drm_connector *connector);
 bool msm_dp_display_check_video_test(struct msm_dp *msm_dp_display);
 int msm_dp_display_get_test_bpp(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index da005babe411..8dbe7d682ddf 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -32,7 +32,7 @@ static int msm_dp_bridge_get_modes(struct drm_bridge *bridge, struct drm_connect
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
 	/* pluggable case assumes EDID is read when HPD */
-	rc = msm_dp_display_get_modes(dp);
+	rc = msm_dp_display_get_modes(dp, connector);
 	if (rc <= 0) {
 		DRM_ERROR("failed to get DP sink modes, rc=%d\n", rc);
 		return rc;
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index bde4a772d22c..30a44e7e8e62 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -305,7 +305,8 @@ static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
 }
 
 void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
-				      const struct drm_edid *drm_edid)
+				      const struct drm_edid *drm_edid,
+				      struct drm_connector *connector)
 {
 	struct msm_dp_panel_private *panel;
 
@@ -324,7 +325,7 @@ void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
 		if (edid)
 			checksum = msm_dp_panel_get_edid_checksum(edid);
 		else
-			checksum = msm_dp_panel->connector->real_edid_checksum;
+			checksum = connector->real_edid_checksum;
 
 		msm_dp_link_send_edid_checksum(panel->link, checksum);
 		msm_dp_link_send_test_response(panel->link);
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 53b7b4463551..f73e11e57ced 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -33,7 +33,6 @@ struct msm_dp_panel {
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 
 	struct msm_dp_link_info link_info;
-	struct drm_connector *connector;
 	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp_panel_psr psr_cap;
 	bool video_test;
@@ -51,7 +50,8 @@ int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
 			u32 mode_pclk_khz);
 void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
-				      const struct drm_edid *drm_edid);
+				      const struct drm_edid *drm_edid,
+				      struct drm_connector *connector);
 void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
 
 void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);

-- 
2.47.3

