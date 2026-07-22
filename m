Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C948C4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4494010EC50;
	Wed, 22 Jul 2026 06:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="j/DRue11";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fq3IItf9";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A9A10EC6D
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:45 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53ZJf3662150
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 orMX6Xv/umQ/GQKMS7aEJeoThKF81pS2FroIwcu9Ga0=; b=j/DRue11FJz22DVX
 16+sajVZvyN+RqmOE6BLxXK8PzM350ID9bMLiJjKr611RP3NKnm4nfRK86ET7HtZ
 Lri4s3k0AsryPz1oQUKBmaAUwvu3f1gm+ip6s2Z8K/XE4ZGW4WoLW5ppM6DIV6Cn
 xQh48/0WwJV/HriPhRllzdeEMLbLfu0pJeV8+N+g43SaHWnrNTx2u8YbDC8xSoM0
 9ZcZLJijbRXrt+rgPIr5NESOYpcwkgS2z/xxS5KLpnRE/iSVUg8qu5WribeQ3HTy
 t/E7hLwWSLfuNQflMVRlCnjwoBmo7ObPXzzKQSE1X0ZYm6v5YCAtu6TmMPp8QedL
 fwEjKQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd5e2jm1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:45 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c0e702df8so181835241cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702204; x=1785307004;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=orMX6Xv/umQ/GQKMS7aEJeoThKF81pS2FroIwcu9Ga0=;
 b=fq3IItf9aZRdBCbCeayqVanuk12+96K4e/Ybg7mlIO5OTvf4lMYraoLa24I7hBhgTj
 Hp6UyI0D5Pt29+XrcqAD+sHIEZj+oJmcbYeOAICaBpiIeEoeOnVT38LmSyRoFzmassA0
 b4Ju6d4G9y1PuuseVv08i3CwPk56PHs0XeQWUe27FCYcEzenpTvF1Tgb9PdpW3YVRYqY
 agnNJic7NR4OmbTJPqzjInwYOnQk9BvesWMbbpCtSFJL+slieK9xUn7IO2HVlrm/jveY
 2Uh3Ik+599DmooaTihDqRMq+5nZTnoJr8LC6TenC9EYKlYpi00uT0xlcPdq6IzDBZYk7
 KZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702204; x=1785307004;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=orMX6Xv/umQ/GQKMS7aEJeoThKF81pS2FroIwcu9Ga0=;
 b=UrXSUS94IV6kgz8TB/l5jL4PSBhypfz4tJUO/B5/JHWusX8rQfAnDluS0p2KBKgL0E
 w7e9y4z5Ozufj9TooUjW4IIBL4n++3hdRQYi8KU6VY70m11oQVC2uf0bWA8EGs5XioUJ
 oeAq+CZtNHwgo0a4zm+k1lBVpgtOPajGZRqBzuc6jIpzRr6BrBrCRELa46Id2lmJ6ogi
 9ORKKqR7iKW5yF6SCqUpduLdc9rJGpJJU6LbehLBhtHE94H9YXVXMfiq8Tccu/WuAvrI
 04tmX3k8vfasz6GbMaogHAZwvgCSpznzpfTW/6zku3W4MEfkcD3uaOQ/ZhOgjdEcscYe
 4ltw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpgLTi72MVcfYYULp+h4zNx/lsyJXjSqjhOzTWf6PBbZAni+4EpSnZu9VxCzVCzjB8EJaJ1Kvl39iE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzh84ASXLtyKRfJ3h8f9TDY0VdUi3DUbQjbG1sTEtw1xDSs1TIW
 Wpm8pueYbajyaQz5ScP3+AQVPEZUixevZJWiUvO3scskpZL5NDLYjZRqyzdO4F44eg/tPCnZcy8
 /1tmhc9hziyuVVlQbQfdvN0s0ubeTGBJj0AP6UlT+TMpEE6GLtRnLgAzrKzzjBMSwCHZRpXw=
X-Gm-Gg: AR+sD13vYwUVkx1E/upOEK/KZkPL8RePlnMZQfDJvgSKsOmmCOi8tfkVY4Wv5xZQjuf
 3O6n1d0n+yc/PqCreOyXA32Z5Z/VO9bKpUA09eRQn5d54L5jHZv2sMFvFbDiiRbpZtXT2hkF61m
 WmJnmjLr+RnjZVR764wNlF6nJxnDPWcs4P7Mxj/vIG6An7zALMyhXlqsvLKtTC+fP9DAo8FUa0P
 aYUTJfV1Pl9+rY2ZaHGybw/3I+Nb4j2W4neF010/xpd4vR0DYtrxh5a1aKQWLu5pmlYW9YaNgr+
 oSEav6FWD+U6+fxRaXJsyzTyALl0E12rvNK26djDGV1aofwVhJevEHKJkbCBNHcA/75f1FySFWv
 8Rxalt0QKnkDAviqjptFNz97DhLH4c1mKudWKeeL01LmQLw/S1mJsG1uNR60JOVsR0MwEX4/o0V
 JkVgqCH8GGb3g8Bw==
X-Received: by 2002:a05:622a:1816:b0:51c:13d6:b4f0 with SMTP id
 d75a77b69052e-5213e28e1famr204276711cf.47.1784702203996; 
 Tue, 21 Jul 2026 23:36:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1816:b0:51c:13d6:b4f0 with SMTP id
 d75a77b69052e-5213e28e1famr204276511cf.47.1784702203550; 
 Tue, 21 Jul 2026 23:36:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:41 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:20 +0300
Subject: [PATCH 05/24] drm/msm: route the display snapshot through the
 msm_display interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-5-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7703;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7l1TNDYd9/evXG4aQDhF4a5Sh4Vi7IaJGNioaNskXy0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTmgZ33GTCdA8gTzYYJcTRQq+WMF0WCFDbqO
 EeiMjh4VBKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5gAKCRCLPIo+Aiko
 1dYeCACCzg+5VE5TqEYdtmNPPUVEm+ouK1WhpQdv/3AGxwrZb4hQ0UlOYhV6mWJBf57z5eK0dGV
 FE5eufC76lW4kyjIxRpgl9nlmmVhug+Co3hbz8g2GiPGl7KXEvtrNCBTel+XwcT6BxlxsihNKjI
 RZIorpMsSw5Dg/rM/ROaYJBWDqhqvp9iYRQ2QB5wPOTV3uDMZhV4CIYok/2HArnREiGoxcKgFUy
 hpMwYTGyEJFRDak8PmkreLmLY8T1+VoXCrS/8Amh9XhtU5dyaaWqFvX2tL8Wrpik1XMUddtBc54
 zJ3JfXmmAhqx8AVtvMjN79QyzH21htHKYeS7cjefyXjColZf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: PmAd966AcThYjG3tkRUBtLHCkPKW7wug
X-Authority-Analysis: v=2.4 cv=CbE4Irrl c=1 sm=1 tr=0 ts=6a6064fd cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=hdl_M5XMN9aFjBodsmYA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: PmAd966AcThYjG3tkRUBtLHCkPKW7wug
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX4BWHG0HT2maa
 uQUBmugyGpsaA+n94gNGSY6Vg1Z85Lh+mNpTwEW8loMPCc6xWLYAC2Rwi14xwdZ+dJ/Gf0efPcE
 NST7EoZDEGVPrPMCf5OL6pimlttYMZZfqmGNhenBlDuBaY860Nwv58ShlxAq5Hq9oJ3991sxHqk
 BYupr0XaRCWpzQpj9FdX8S58RWKqr6Y/ydFEpk8Zblb3CIH1Dkt1HFmOa9Iv4/aajez7AhPB3PV
 XDnzHQW1rop0YsgnQhcRSFG+0rL6b6LXpAfNOdRLX9q5l11+73wvVHFAYhqUdG8lGhoxMYbrAHF
 6x66T10hh8EqNBliOf3j3xFkBblsZv+EK0pk4SipsqrvQZ1Om0zkm2mLlQzTece70jfbnmaTkNn
 PuYhXlB+WkuhRTCUXGNKNChk/7fD4QlT7hVfbWO9Th64HbEsnIZd2hqYwf92S24LI6w9wNzSw4r
 nyRSXYYahZN3jt4U0Sw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXx+Tikx5KKmCn
 690b6d6Hu2saX3anSjxTntAIeLzS4D/pU5CFBQTEKSTFpApht9+zt90P8AZ2TDZvFG4YYAsR8jW
 ZaVopp4Xmu5HjuIxrdaXibIQJj5ymHQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 clxscore=1015 spamscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607220060
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

The display snapshot code calls msm_dsi_snapshot() and msm_dp_snapshot()
directly, so it has to know the concrete sub-block type of each entry.

Add a mandatory snapshot() callback to struct msm_display_funcs and turn
the DSI and DP snapshot helpers into implementations of it. HDMI did not
have a snapshot helper before; give it an empty implementation for now (a
following patch fills it in). The snapshot code now dispatches through the
interface for all three sub-blocks.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c | 19 +++++++++++--------
 drivers/gpu/drm/msm/dp/dp_display.c               |  5 ++++-
 drivers/gpu/drm/msm/dsi/dsi.c                     | 16 ++++++++++------
 drivers/gpu/drm/msm/hdmi/hdmi.c                   |  6 ++++++
 drivers/gpu/drm/msm/msm_drv.h                     | 14 +++++---------
 5 files changed, 36 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index 850246fc89e1..b42a92c2ffad 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -131,6 +131,7 @@ void msm_disp_snapshot_capture_state(struct msm_disp_state *disp_state)
 {
 	struct msm_drm_private *priv;
 	struct drm_device *drm_dev;
+	struct msm_display *display;
 	struct msm_kms *kms;
 	int i;
 
@@ -139,19 +140,21 @@ void msm_disp_snapshot_capture_state(struct msm_disp_state *disp_state)
 	kms = priv->kms;
 
 	for (i = 0; i < ARRAY_SIZE(kms->dp); i++) {
-		if (!kms->dp[i])
-			continue;
-
-		msm_dp_snapshot(disp_state, kms->dp[i]);
+		display = msm_dp_get_display(kms->dp[i]);
+		if (display)
+			display->funcs->snapshot(display, disp_state);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(kms->dsi); i++) {
-		if (!kms->dsi[i])
-			continue;
-
-		msm_dsi_snapshot(disp_state, kms->dsi[i]);
+		display = msm_dsi_get_display(kms->dsi[i]);
+		if (display)
+			display->funcs->snapshot(display, disp_state);
 	}
 
+	display = msm_hdmi_get_display(kms->hdmi);
+	if (display)
+		display->funcs->snapshot(display, disp_state);
+
 	if (kms->funcs->snapshot)
 		kms->funcs->snapshot(disp_state, kms);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 79dd556e96c2..f4fa86d1b9c7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -783,8 +783,10 @@ int msm_dp_display_get_test_bpp(struct msm_dp *dp)
 		msm_dp_display->link->test_video.test_bit_depth);
 }
 
-void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp)
+static void msm_dp_snapshot(struct msm_display *display,
+			    struct msm_disp_state *disp_state)
 {
+	struct msm_dp *dp = container_of(display, struct msm_dp, display);
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
@@ -1354,6 +1356,7 @@ static int msm_dp_modeset_init(struct msm_display *display,
 
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
+	.snapshot = msm_dp_snapshot,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 6cd844d08733..c86142f66237 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -267,8 +267,18 @@ static int msm_dsi_modeset_init(struct msm_display *display,
 	return 0;
 }
 
+static void msm_dsi_snapshot(struct msm_display *display,
+			     struct msm_disp_state *disp_state)
+{
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
+
+	msm_dsi_host_snapshot(disp_state, msm_dsi->host);
+	msm_dsi_phy_snapshot(disp_state, msm_dsi->phy);
+}
+
 static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.modeset_init = msm_dsi_modeset_init,
+	.snapshot = msm_dsi_snapshot,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
@@ -276,9 +286,3 @@ struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
 	return msm_dsi ? &msm_dsi->display : NULL;
 }
 
-void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi)
-{
-	msm_dsi_host_snapshot(disp_state, msm_dsi->host);
-	msm_dsi_phy_snapshot(disp_state, msm_dsi->phy);
-}
-
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 03367c6ba428..350867ada0cf 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -211,8 +211,14 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 	return ret;
 }
 
+static void msm_hdmi_snapshot(struct msm_display *display,
+			      struct msm_disp_state *disp_state)
+{
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
+	.snapshot = msm_hdmi_snapshot,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index dbd955091ce7..d25d783b4f11 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -275,15 +275,20 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 #endif
 
 struct msm_display;
+struct msm_disp_state;
 
 /**
  * struct msm_display_funcs - ops provided by a display sub-block (DSI/DP/HDMI)
  * @modeset_init: create the bridge and connector for the sub-block, attaching
  *                to @encoder.
+ * @snapshot:     capture the sub-block's state for a display snapshot;
+ *                mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
 			    struct drm_encoder *encoder);
+	void (*snapshot)(struct msm_display *display,
+			 struct msm_disp_state *disp_state);
 };
 
 /**
@@ -319,7 +324,6 @@ void dsi_dev_detach(struct platform_device *pdev);
 void __init msm_dsi_register(void);
 void __exit msm_dsi_unregister(void);
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
-void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi);
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
@@ -337,9 +341,6 @@ static inline struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
 {
 	return NULL;
 }
-static inline void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi)
-{
-}
 static inline bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi)
 {
 	return false;
@@ -373,7 +374,6 @@ struct msm_dp;
 int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
 struct msm_display *msm_dp_get_display(struct msm_dp *dp_display);
-void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
@@ -391,10 +391,6 @@ static inline struct msm_display *msm_dp_get_display(struct msm_dp *dp_display)
 	return NULL;
 }
 
-static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
-{
-}
-
 static inline bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 					     const struct drm_display_mode *mode)
 {

-- 
2.47.3

