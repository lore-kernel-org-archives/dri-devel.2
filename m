Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF1FC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37A2A10EC7A;
	Wed, 22 Jul 2026 06:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lmG6/wqA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UnrdZqD8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67F5410EC5B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53kmd4045687
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oGW1zFzCpiJIZJA57ARRLMmK4sTskI8VOnNO41WxLkA=; b=lmG6/wqA+eIjqDC6
 XzkC3OiF0xPoO61nYfiZKACkTC/dc3CtpqmQX5ZIqLy4QtyzcdPDFLDha5z0F67H
 fpignWTIsjpwsi9IMqnlvvcMpY5eQSqn8seNiH464id7Xc/8XvZWKVtpCMfJuyYI
 CvdfTUvF+AyG+VnjVWr6lqeCMQoV2fTXhGm7/AAIQBKkocy6kr2D3DP34JLKTwcG
 QjfuwTTsg689zeTu8rRuUrwYZuK340vntHoZjLg7VpWDBBqZXD8iA57Mr71NBnXo
 gzPyEEgsU3lc9XW5kFVqhN08hefoAAfLpbnqvUZxjGe8vJ2PeinrZ4HBHaZNY+N7
 /PEKpQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6dan38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:10 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c07f25de2so120141161cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702229; x=1785307029;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oGW1zFzCpiJIZJA57ARRLMmK4sTskI8VOnNO41WxLkA=;
 b=UnrdZqD895H41aMz6gSSV0Kdv6sayvC4EB0w28O0BMv5Dikz6MxpQeF8nhnKnfZ1Nw
 QA0TLJEmoag+iYWPm8wMCI20rz5sarl18YdMNO2zdyUMtPXyQI789A1VywjrUg4/qNv6
 oJvM/RmnlLVy4EmT9Gkki+8nrMRXECAzZXll2MLIRWJqEEAJ5gAul2CnCxc2WXc7zycm
 v5H6NaPtu2eGLVcKdpEumhwCTXv+aRFxBhRFPuDNSqqZfnz3fGXMH2WeXCNmHW6TpLJv
 ym1h2274VkGbceIGUJzKb2/lbS4h9D42UVtLMbzw8aZ1jmfU/599ZXLNFUNAdP9A/Zhx
 FIeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702229; x=1785307029;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oGW1zFzCpiJIZJA57ARRLMmK4sTskI8VOnNO41WxLkA=;
 b=c/70fsGKDR3SDydti4vzmc6Gunn9Q0Y7Ta+vtdv5gg6Bn0RCXJrLXO44+qeC+4aTza
 oG00WfapwgosPbyR8f0J/nALmf5Paj75oDzyXp2767nWJGhHCXckWqKDSh46+kCfKmQH
 sGCGObVdinbGwrYYiumL68A/zN1mcIkagKWuINSKgISr5aMC2DIbBxmQRyHym3bHbwlj
 uipxfg25apaQ6LnjzzwhooOVtpe00umhIK0TvjjfEm11nauy6WOT/JrEOqrFBHU0LZO2
 Ipc6tErLwYezhL0XhSPIF4WRgvVuWaYuJYSYXkmenu17vejGsDZrpEaHixpLXtFSgcnn
 kmzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6jZbm5TqY/3vaX8lNb/CRHTO7TFdX03KpUK8KzevU4mo0q4MWF6taLbkngXZF5MdoSA/iz7UmIcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyrfTgprlxJoebeJzz0mGxpdbnKgDsvstZNtAOj/QpKliKx+HEE
 Q3ObmlBeZZvmjTXj785HQIXN3jUH/KW2LcflOktU8ajiTf9jThU5tsYoUjiVBQd7wK/xrkosLsL
 MiOyDE4IO0zYqGwDgSNhL4AQ35IeRHry/Y+0oj7Cnrunw8BBFNL80jHgttns1CcMI/fuSeGA=
X-Gm-Gg: AR+sD13ddPi+MJslzcLUjp6kJ/MEuG269cvPmNmJS7tEKSeOs7O/z9oV2HjQJjLFrIZ
 IgOxGDb3QY6VJJCxbrS8/GzHPrdO0U9lnxNGHzxIfkVElkJ9IhTbd2RToBhGRvRR1mXhsARqCM8
 0FLKEGpn6oP6rAS+Dk+yHMxp7SyXoXHsg+M5eOSJKwnig2GFtZDdyHo0WwNGyVlpQjGYO6U/kDT
 fn9FLCYF60Mw3r8soiY3xSnr5i+UtKFWiqPf7ldpnpqPq/4o4cEfFTXUYGHbwhjf99Ytjm8XuhM
 N4a3tXVqQvcWhw61qqVZgxhteqrEDYTpTUT9MXNmtZO/n4ILxzaCRa97d5aemDZR0eQ7UaEY0lb
 JsG3aCxA2Gp7BbKYpLceiyW+Age8nEl11xu+RgUAvu1ndxVjWtS+ZvZD0dX/oei5QB+xrf55tyw
 R+e4vpI/DhBq5DVw==
X-Received: by 2002:ac8:7f53:0:b0:51c:7b12:5ff9 with SMTP id
 d75a77b69052e-5213d7abfc0mr208199991cf.85.1784702229320; 
 Tue, 21 Jul 2026 23:37:09 -0700 (PDT)
X-Received: by 2002:ac8:7f53:0:b0:51c:7b12:5ff9 with SMTP id
 d75a77b69052e-5213d7abfc0mr208199691cf.85.1784702228839; 
 Tue, 21 Jul 2026 23:37:08 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:29 +0300
Subject: [PATCH 14/24] drm/msm: store the display sub-blocks as struct
 msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-14-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10011;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=2gZIjt+CW7BgzLYsCIE9YAc5XmD7te0tRFqzurdAo68=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTojVumxCAb/menMez1MJQjApmx7tpHl7KyR
 yhEZLS/4seJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6AAKCRCLPIo+Aiko
 1a72CACjUO43qEeNKr/ZzJA9xLX8XkrW8tjs8HyPWuSk0oNsgXoWzNle5FwhTyVoJTbBQLcDxjA
 nTrq39DN/OP1cFUcibOF23bbPFlvwHRLJR1vIc5uMF7/YjxLx+XsPC+kke4ox4GrpggCkIDb3ye
 ldrKzKpVHzImBxybw6yw5IvHJ0medyrDn5c5r7KCHKcgrfXXNcsssn0g/m64NmZ+HE1BZaSd7Z7
 0oAcpDn9B46B6SYtWj/Md9LnCDWSGJHWOJWzwgE7CYVBaE0QjSbAml9Yy2K4U/BEEwaPvi1EFpu
 a/303zhwdyJMvN/anIhVWjO87VWJHg3j79Fa0YP//P1+Q3j3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX1kZLyHOu4Pt6
 d3/3dwC9j9ScY7/OO9ePgDuOtt9bDIo5+/VbLy0WLYPxpTtwGnEV1qlgFoJKJvaKJYgLjeQCgru
 RRFYQjOMtyjh/3v/GBvaeNADz57anF8=
X-Authority-Analysis: v=2.4 cv=Ipsutr/g c=1 sm=1 tr=0 ts=6a606516 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=v7Gipn9cxXP9LZtw54EA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX6eMNq8T+b/4e
 SOLqQxj8epJWAytz+Mxt9znNCS/nFaxwGzeDUrv4/+ars0xwyIhy3p9JOXHm+G2Y/CYABwQ6Lsu
 UtT/HXJixOQu/T4PIDTdLzYxMWXayn7vWEseTwgF86m/lZbVAms03VZAzDdp24//8DT4VjVdmrM
 Wp2MJ6h6bsbdr7FhHzWOcM7usUzwquvI2wE4FKHnfZ3d3N642zGfdomu5l2hoHK7NUy6gZ/hhWB
 pB/r0thPUWcsYhx3BKPle6ibLLDLJSgdaYLEJmeMONodDeP2cbMKsZkPnsRPnOVE2S6a0G7Rq49
 lgMX9LCK6PkWXdlg2oUyoNo0WFc3cd9jgmyq51/HnTX3xOvruvUB9XO6hCFsl6r96LCEJ0LKMpp
 Ij2f8Jls1cWdzPeoEgP3lf1GWhQg6dhJHH4odJAlbiO3NsFyWqjhuOIc9B5AqqSZD1lAnM4KxMu
 CrQJqLhqx+Jyn524KsA==
X-Proofpoint-GUID: PgaWEQc6T0dDzJtlPzKu1H49o67iCSw2
X-Proofpoint-ORIG-GUID: PgaWEQc6T0dDzJtlPzKu1H49o67iCSw2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
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

With every cross-module query of the DSI, DP and HDMI sub-blocks now going
through the msm_display interface, struct msm_kms no longer needs to know
their concrete types.

Store the sub-blocks as struct msm_display pointers in struct msm_kms;
each sub-driver registers &obj->display. The msm_*_get_display() accessors
are no longer needed and are removed, and callers use kms->dsi[]/dp[]/hdmi
directly.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c       |  6 +++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c           |  2 +-
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c          |  2 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c |  6 +++---
 drivers/gpu/drm/msm/dp/dp_display.c               |  7 +------
 drivers/gpu/drm/msm/dsi/dsi.c                     |  7 +------
 drivers/gpu/drm/msm/hdmi/hdmi.c                   |  7 +------
 drivers/gpu/drm/msm/msm_drv.h                     | 15 ---------------
 drivers/gpu/drm/msm/msm_kms.c                     | 11 +++++------
 drivers/gpu/drm/msm/msm_kms.h                     |  6 +++---
 10 files changed, 19 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 569f3759d02c..aa8a9b7c1beb 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -261,11 +261,11 @@ static struct msm_display *dpu_encoder_get_display(struct drm_device *dev,
 
 	switch (disp_info->intf_type) {
 	case INTF_DP:
-		return msm_dp_get_display(priv->kms->dp[index]);
+		return priv->kms->dp[index];
 	case INTF_DSI:
-		return msm_dsi_get_display(priv->kms->dsi[index]);
+		return priv->kms->dsi[index];
 	case INTF_HDMI:
-		return msm_hdmi_get_display(priv->kms->hdmi);
+		return priv->kms->hdmi;
 	default:
 		return NULL;
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 2eeaef963e1a..ec5e02c395f6 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -603,7 +603,7 @@ static int _dpu_kms_initialize_dsi(struct drm_device *dev,
 		if (!priv->kms->dsi[i])
 			continue;
 
-		display = msm_dsi_get_display(priv->kms->dsi[i]);
+		display = priv->kms->dsi[i];
 
 		if (!display->funcs->needs_encoder(display))
 			continue;
diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index e372d295b80f..c91915030111 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -361,7 +361,7 @@ static int modeset_init_intf(struct mdp5_kms *mdp5_kms,
 			break;
 		}
 
-		display = msm_dsi_get_display(priv->kms->dsi[dsi_id]);
+		display = priv->kms->dsi[dsi_id];
 		priv->kms->dsi_encoder[dsi_id] = encoder;
 		mdp5_encoder_set_intf_mode(encoder,
 					   display->funcs->is_cmd_mode(display));
diff --git a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
index b42a92c2ffad..d376c3cdd8b5 100644
--- a/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
+++ b/drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c
@@ -140,18 +140,18 @@ void msm_disp_snapshot_capture_state(struct msm_disp_state *disp_state)
 	kms = priv->kms;
 
 	for (i = 0; i < ARRAY_SIZE(kms->dp); i++) {
-		display = msm_dp_get_display(kms->dp[i]);
+		display = kms->dp[i];
 		if (display)
 			display->funcs->snapshot(display, disp_state);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(kms->dsi); i++) {
-		display = msm_dsi_get_display(kms->dsi[i]);
+		display = kms->dsi[i];
 		if (display)
 			display->funcs->snapshot(display, disp_state);
 	}
 
-	display = msm_hdmi_get_display(kms->hdmi);
+	display = kms->hdmi;
 	if (display)
 		display->funcs->snapshot(display, disp_state);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 914cf9dd0f21..1baeb9401cfa 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -215,7 +215,7 @@ static int msm_dp_display_bind(struct device *dev, struct device *master,
 
 	dp->msm_dp_display.drm_dev = drm;
 	dp->msm_dp_display.display.funcs = &msm_dp_display_funcs;
-	priv->kms->dp[dp->id] = &dp->msm_dp_display;
+	priv->kms->dp[dp->id] = &dp->msm_dp_display.display;
 
 	dp->drm_dev = drm;
 	dp->aux->drm_dev = drm;
@@ -1406,11 +1406,6 @@ static const struct msm_display_funcs msm_dp_display_funcs = {
 	.needs_encoder = msm_dp_display_needs_encoder,
 };
 
-struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
-{
-	return msm_dp_display ? &msm_dp_display->display : NULL;
-}
-
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state)
 {
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 69e57ab47258..3bcea5f5b5a3 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -170,7 +170,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 	}
 
 	msm_dsi->display.funcs = &msm_dsi_display_funcs;
-	priv->kms->dsi[msm_dsi->id] = msm_dsi;
+	priv->kms->dsi[msm_dsi->id] = &msm_dsi->display;
 
 	return 0;
 }
@@ -319,8 +319,3 @@ static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.needs_encoder = msm_dsi_needs_encoder,
 };
 
-struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
-{
-	return msm_dsi ? &msm_dsi->display : NULL;
-}
-
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 0327098287d1..1d5a4b63f3c8 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -276,11 +276,6 @@ static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.needs_encoder = msm_hdmi_needs_encoder,
 };
 
-struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
-{
-	return hdmi ? &hdmi->display : NULL;
-}
-
 /*
  * The hdmi device:
  */
@@ -315,7 +310,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 	if (err)
 		return err;
 	hdmi->display.funcs = &msm_hdmi_display_funcs;
-	priv->kms->hdmi = hdmi;
+	priv->kms->hdmi = &hdmi->display;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 378d2cc80b66..3d9ae49cba49 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -324,14 +324,9 @@ struct msm_display {
 
 struct hdmi;
 #ifdef CONFIG_DRM_MSM_HDMI
-struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi);
 void __init msm_hdmi_register(void);
 void __exit msm_hdmi_unregister(void);
 #else
-static inline struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
-{
-	return NULL;
-}
 static inline void __init msm_hdmi_register(void) {}
 static inline void __exit msm_hdmi_unregister(void) {}
 #endif
@@ -342,7 +337,6 @@ int dsi_dev_attach(struct platform_device *pdev);
 void dsi_dev_detach(struct platform_device *pdev);
 void __init msm_dsi_register(void);
 void __exit msm_dsi_unregister(void);
-struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
 #else
 static inline void __init msm_dsi_register(void)
 {
@@ -350,17 +344,12 @@ static inline void __init msm_dsi_register(void)
 static inline void __exit msm_dsi_unregister(void)
 {
 }
-static inline struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
-{
-	return NULL;
-}
 #endif
 
 struct msm_dp;
 #ifdef CONFIG_DRM_MSM_DP
 int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
-struct msm_display *msm_dp_get_display(struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -370,10 +359,6 @@ static inline int __init msm_dp_register(void)
 static inline void __exit msm_dp_unregister(void)
 {
 }
-static inline struct msm_display *msm_dp_get_display(struct msm_dp *dp_display)
-{
-	return NULL;
-}
 
 #endif
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 3f855f9b3d06..1a081e15a0a8 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -286,21 +286,20 @@ static int msm_kms_init_connectors(struct drm_device *ddev)
 	int i, ret;
 
 	for (i = 0; i < ARRAY_SIZE(kms->dsi); i++) {
-		ret = msm_display_modeset_init(msm_dsi_get_display(kms->dsi[i]),
-					       ddev, kms->dsi_encoder[i]);
+		ret = msm_display_modeset_init(kms->dsi[i], ddev,
+					       kms->dsi_encoder[i]);
 		if (ret)
 			goto fail;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(kms->dp); i++) {
-		ret = msm_display_modeset_init(msm_dp_get_display(kms->dp[i]),
-					       ddev, kms->dp_encoder[i]);
+		ret = msm_display_modeset_init(kms->dp[i], ddev,
+					       kms->dp_encoder[i]);
 		if (ret)
 			goto fail;
 	}
 
-	ret = msm_display_modeset_init(msm_hdmi_get_display(kms->hdmi),
-				       ddev, kms->hdmi_encoder);
+	ret = msm_display_modeset_init(kms->hdmi, ddev, kms->hdmi_encoder);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/msm/msm_kms.h b/drivers/gpu/drm/msm/msm_kms.h
index 06646091604a..cbb9c9dcc193 100644
--- a/drivers/gpu/drm/msm/msm_kms.h
+++ b/drivers/gpu/drm/msm/msm_kms.h
@@ -139,13 +139,13 @@ struct msm_kms {
 	const struct msm_kms_funcs *funcs;
 	struct drm_device *dev;
 
-	struct hdmi *hdmi;
+	struct msm_display *hdmi;
 	struct drm_encoder *hdmi_encoder;
 
-	struct msm_dsi *dsi[MSM_DSI_CONTROLLER_COUNT];
+	struct msm_display *dsi[MSM_DSI_CONTROLLER_COUNT];
 	struct drm_encoder *dsi_encoder[MSM_DSI_CONTROLLER_COUNT];
 
-	struct msm_dp *dp[MSM_DP_CONTROLLER_COUNT];
+	struct msm_display *dp[MSM_DP_CONTROLLER_COUNT];
 	struct drm_encoder *dp_encoder[MSM_DP_CONTROLLER_COUNT];
 
 	/* irq number to be passed on to msm_irq_install */

-- 
2.47.3

