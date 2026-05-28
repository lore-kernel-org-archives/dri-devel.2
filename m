Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D437CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44C010EFE2;
	Thu, 28 May 2026 10:40:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RGqVBEUx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dtTi6VU/";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BC810EFE3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vN3W3545335
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Z9XwZEQ5+kmC7bgxZS6w8ZlMkGdCxPjg4uYZj2oog8k=; b=RGqVBEUxLZqy8Gt8
 KsdK5telX709yAwJEzaHRPL9jB1TovgVD6Xrc22blNzZfyAUvgaZM5AekbYbaplm
 AZvXQ96ZVQcg/Ony2ru7D2pl7AnHn+bpANWQsZVZbFS9yVMgF+cDVm+tndPMGkFc
 eHGY+JKmmX6JtbWrVQZGaE/iPGUw5tkQv3a46xCT74Fzpir+FkKFsjh6Cul+N3aX
 A2csKswhRPMO30GKBvDUMnK6vEnxaG68+bCJD1i4WYlACOZesFTO9TpWWs5I0mBf
 qAUPya2LOwc/7JPVPCwIKN1pKB/oezHNg7wE9n5pf+ttWhhC8wbNeeMYGM72g9pD
 S0obFA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y3tdc7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:42 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914bddf7767so1019991185a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964841; x=1780569641;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z9XwZEQ5+kmC7bgxZS6w8ZlMkGdCxPjg4uYZj2oog8k=;
 b=dtTi6VU/GIw/LVpEfhRdzOpBnFNcFErVLg9T1C6FExwnEf0tl/ZxmBPTEeH9FMcwaT
 MrfVOZrMY/ip07/+G5VB1orWYhSW2uRHp3VR1RxjyQDoTlRy7VCVoIVVanI51/LB1nrM
 Lm77e77OjKqrxD79ZiVUHZn7zckQWEiLMMJKxS/vPLp7wrX4jUw2ARmT1Nitj8RR7pET
 DJipKsWdxh0wgGCg5Hx2wMjQUePyip4NxQWpWQFnk9qlNoPhIOvi+ZHoS4X9Zu19h+Ka
 fNeSK+hM4x1Uu8r7rptvNVTDa01emXGAxpbSXZUfpZY/NOh8F6VVAZKOIhVfBEaC7qJY
 QnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964841; x=1780569641;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z9XwZEQ5+kmC7bgxZS6w8ZlMkGdCxPjg4uYZj2oog8k=;
 b=PCUtdMCfDV+sEwb5qHT4VwFawHsYMBEyy6HY4mB0OE5u+gzudplsff6OWI2BRpXkfw
 1vbQsbAoITbfo3z1WRKpFV9KvIE0hJoT216Om2Yi/AMI5RMhl7e2JY8G9CydcI7LEs3W
 BKUSxjizKcvCyn9FTMLUCPxtUououmIYtk/ckKvqEnYAMBm1TEWIDkkx9Ja9WOQf62Dh
 2FPL5OO04pZqfa7M25YX146vSAry3rObugum20609DZrVQbGL6fymWWYHqnq9ahuVbF0
 F0OnUnTL65ivm78z3P3u3OuQazL6Zv9+iOJ9qTsUjp8pCmW07S1DaBvFjrBtFH/iL8Oh
 eyCA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+vmhGpGdDd7Wb44PUZ7nywkRF3PxPpoK1mhNLtWUHZhFEMK8RWJ4ZEqdMMRF5yjwaOKAyUALnVIo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwZGkN2QTO9El5lRVsM0fpssaFdaOYGwE+vkjhE8iBIkNB9380
 vRDnlPjj9MOZeGmJUPIwslcnRLFlRsGwSf3BZixg64r849OxMNG7fbouVWEaVSeIVCIullgk9dG
 1AW8KQyfJDWyXkYb+LjaJw6Nqo3tq1J1ugQ5fLa9uw8U5kurViDotOE1W6hl8EJeCmQ7WXQY=
X-Gm-Gg: Acq92OEHpBp3k4ZiWeQDDLODpoo8GKxHBe0NWGJc2hDgrbTcPcD4RL/cjI8dsxpt0+i
 Cy6rfXBdwrovU58GUutCTqkasDB5+FeT+z0p761B6iQ5VrOodCj1vM50DxQhmikTR8vi59eWJkL
 M2KMojdZSbQW6mMpO12TpEdRihOqNw5HEdOwgoQCG1mhI2sq+Er1f+qzoZWHXj7ih9iqS9hgE4y
 PunyNUQbv3fn4PZUc9/aD1j3pF1D5wwhqjuN0KKQ78+1iLAQp2WwXnGAfQ9YTjiBdCOXjkqII7/
 VUneljwJrM15JUWhvPErkM90sXVYeV0L61Ci0y3eNykwnRQ+Yo3V54KOWiex0Ra14+pntPxJy8K
 rlx+D8CgzDhxnjCzR6Ye/Nz6K6VHkBa26hKsZqc5zN+U+VUWJ/zu9oXGuIaCFFVbsohJygeUSTe
 CeMJKpLcSAuQkliNhPIw==
X-Received: by 2002:a05:620a:a184:10b0:90d:c28d:9666 with SMTP id
 af79cd13be357-914b49a10cfmr2719724485a.30.1779964841099; 
 Thu, 28 May 2026 03:40:41 -0700 (PDT)
X-Received: by 2002:a05:620a:a184:10b0:90d:c28d:9666 with SMTP id
 af79cd13be357-914b49a10cfmr2719722885a.30.1779964840667; 
 Thu, 28 May 2026 03:40:40 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:40:40 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:22 +0800
Subject: [PATCH v5 01/15] drm/msm/dp: remove cached drm_edid from panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-1-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=9149;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=8rfPXgL2BDNk/0IgYx87Y5lmOO0Suqj9LvpJBpt8Zac=;
 b=PjrvVBFjAgP+CuRRq8BAJEdz2CiqOt3sHEShuEBwMlFYyTvt/XXlcv+NpFv2bmqNsbfEyXWum
 PjiDSY+0RQDA2cvCH8HbLcaAXgWnKnaAMv3glHLWUVYGCJxMknUieLW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: tfVvCxIgllD-0Izbuexdy06pilGbLaVJ
X-Authority-Analysis: v=2.4 cv=JMYLdcKb c=1 sm=1 tr=0 ts=6a181baa cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=yBxTOPed86Cp7mhl67IA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: tfVvCxIgllD-0Izbuexdy06pilGbLaVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNyBTYWx0ZWRfXx8KJTMlGS/wg
 njcmcFrMwg9/hujhZvSyIJUhNvHZBdz6cJZBhJqkiRLABN/t2eQj9SIN7jqWGPN+vZvtIaiMWjn
 cdYGSpnOK7RByL4ua9B0189OFuYY9US4+O/kxgq3Av2iTv63UZ7PSeGD3ZlO+JYmkhhR8AeE7jW
 dteS6y5c7uw21WrM5lWoyAjwtaFEgdNt0SiZAFQjVyStyjYJz+/uf9jZMPGdM9rZfgvCFtfVg1B
 Ch2JRwuHKRIvaSwgMxP8ww1OvgQ51bpZi8i1+bWdO7lg5tY7HGXKSQqrg2cEJQq4B9TxbbQd3Tc
 ZWoq++t9OvJQh9apNVB54qRur+rS7X+oaRlOyDxbiVst6uyoMOieFnPLG2cdghCNBsUKvWkrbxd
 RsHWxbAxaZhg7MCQVsCNrQXrCzX6k+GJuHhbZwzePO+WYAf+s55l4AGTzlwrWYvFMqqqqsnx62g
 kaucbgbwFad5ZE5zShQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280107
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

The cached drm_edid seems unnecessary here. Use the drm_edid pointer
directly in the plug stage instead of caching it. Remove the cached
drm_edid and the corresponding oneliner to simplify the code.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 28 +++++++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
 3 files changed, 27 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6800c628adb4..e3682c4d6077 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -269,6 +269,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	const struct drm_display_info *info = &connector->display_info;
 	int rc = 0;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	const struct drm_edid *drm_edid = NULL;
 
 	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
 	if (rc)
@@ -276,10 +277,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
 	dp->link->lttpr_count = msm_dp_display_lttpr_init(dp, dpcd);
 
-	rc = msm_dp_panel_read_sink_caps(dp->panel, connector);
+	rc = msm_dp_panel_read_link_caps(dp->panel, connector);
 	if (rc)
 		goto end;
 
+	drm_edid = drm_edid_read_ddc(connector, &dp->aux->ddc);
+	drm_edid_connector_update(connector, drm_edid);
+
+	if (!drm_edid) {
+		DRM_ERROR("panel edid read failed\n");
+		/* check edid read fail is due to unplug */
+		if (!msm_dp_aux_is_link_connected(dp->aux))
+			return -ETIMEDOUT;
+	}
+
 	msm_dp_link_process_request(dp->link);
 
 	if (!dp->msm_dp_display.is_edp)
@@ -291,7 +302,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
-	msm_dp_panel_handle_sink_request(dp->panel);
+	msm_dp_panel_handle_sink_request(dp->panel, drm_edid);
 
 	/*
 	 * set sink to normal operation mode -- D0
@@ -302,6 +313,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
+	drm_edid_free(drm_edid);
 	return rc;
 }
 
@@ -453,7 +465,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	/* Don't forget modes for eDP */
 	if (!dp->msm_dp_display.is_edp)
-		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
+		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
 
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
@@ -515,7 +527,6 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
-	msm_dp_panel_put(dp->panel);
 	msm_dp_aux_put(dp->aux);
 }
 
@@ -566,7 +577,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
 		dp->ctrl = NULL;
-		goto error_ctrl;
+		goto error_link;
 	}
 
 	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
@@ -574,13 +585,11 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		rc = PTR_ERR(dp->audio);
 		pr_err("failed to initialize audio, rc = %d\n", rc);
 		dp->audio = NULL;
-		goto error_ctrl;
+		goto error_link;
 	}
 
 	return rc;
 
-error_ctrl:
-	msm_dp_panel_put(dp->panel);
 error_link:
 	msm_dp_aux_put(dp->aux);
 error:
@@ -744,8 +753,7 @@ int msm_dp_display_get_modes(struct msm_dp *dp)
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_panel_get_modes(msm_dp_display->panel,
-		dp->connector);
+	return drm_edid_connector_add_modes(msm_dp_display->panel->connector);
 }
 
 bool msm_dp_display_check_video_test(struct msm_dp *dp)
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index 6bb021820d7c..bde4a772d22c 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -232,8 +232,8 @@ static u32 msm_dp_panel_get_supported_bpp(struct msm_dp_panel *msm_dp_panel,
 	return min_supported_bpp;
 }
 
-int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
-	struct drm_connector *connector)
+int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
+				struct drm_connector *connector)
 {
 	int rc, bw_code;
 	int count;
@@ -271,36 +271,9 @@ int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
 
 	rc = drm_dp_read_downstream_info(panel->aux, msm_dp_panel->dpcd,
 					 msm_dp_panel->downstream_ports);
-	if (rc)
-		return rc;
-
-	drm_edid_free(msm_dp_panel->drm_edid);
-
-	msm_dp_panel->drm_edid = drm_edid_read_ddc(connector, &panel->aux->ddc);
-
-	drm_edid_connector_update(connector, msm_dp_panel->drm_edid);
-
-	if (!msm_dp_panel->drm_edid) {
-		DRM_ERROR("panel edid read failed\n");
-		/* check edid read fail is due to unplug */
-		if (!msm_dp_aux_is_link_connected(panel->aux)) {
-			rc = -ETIMEDOUT;
-			goto end;
-		}
-	}
-
-end:
 	return rc;
 }
 
-void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
-			    struct drm_connector *connector)
-{
-	drm_edid_connector_update(connector, NULL);
-	drm_edid_free(msm_dp_panel->drm_edid);
-	msm_dp_panel->drm_edid = NULL;
-}
-
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 		u32 mode_edid_bpp, u32 mode_pclk_khz)
 {
@@ -324,20 +297,6 @@ u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel,
 	return bpp;
 }
 
-int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
-	struct drm_connector *connector)
-{
-	if (!msm_dp_panel) {
-		DRM_ERROR("invalid input\n");
-		return -EINVAL;
-	}
-
-	if (msm_dp_panel->drm_edid)
-		return drm_edid_connector_add_modes(connector);
-
-	return 0;
-}
-
 static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
 {
 	edid += edid->extensions;
@@ -345,7 +304,8 @@ static u8 msm_dp_panel_get_edid_checksum(const struct edid *edid)
 	return edid->checksum;
 }
 
-void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
+void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
+				      const struct drm_edid *drm_edid)
 {
 	struct msm_dp_panel_private *panel;
 
@@ -358,7 +318,7 @@ void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel)
 
 	if (panel->link->sink_request & DP_TEST_LINK_EDID_READ) {
 		/* FIXME: get rid of drm_edid_raw() */
-		const struct edid *edid = drm_edid_raw(msm_dp_panel->drm_edid);
+		const struct edid *edid = drm_edid_raw(drm_edid);
 		u8 checksum;
 
 		if (edid)
@@ -755,10 +715,3 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 	return msm_dp_panel;
 }
 
-void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel)
-{
-	if (!msm_dp_panel)
-		return;
-
-	drm_edid_free(msm_dp_panel->drm_edid);
-}
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 9173e90a5053..53b7b4463551 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -33,7 +33,6 @@ struct msm_dp_panel {
 	u8 downstream_ports[DP_MAX_DOWNSTREAM_PORTS];
 
 	struct msm_dp_link_info link_info;
-	const struct drm_edid *drm_edid;
 	struct drm_connector *connector;
 	struct msm_dp_display_mode msm_dp_mode;
 	struct msm_dp_panel_psr psr_cap;
@@ -47,15 +46,12 @@ struct msm_dp_panel {
 int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en);
-int msm_dp_panel_read_sink_caps(struct msm_dp_panel *msm_dp_panel,
-		struct drm_connector *connector);
-void msm_dp_panel_unplugged(struct msm_dp_panel *msm_dp_panel,
-			    struct drm_connector *connector);
+int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,
+				struct drm_connector *connector);
 u32 msm_dp_panel_get_mode_bpp(struct msm_dp_panel *msm_dp_panel, u32 mode_max_bpp,
 			u32 mode_pclk_khz);
-int msm_dp_panel_get_modes(struct msm_dp_panel *msm_dp_panel,
-		struct drm_connector *connector);
-void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel);
+void msm_dp_panel_handle_sink_request(struct msm_dp_panel *msm_dp_panel,
+				      const struct drm_edid *drm_edid);
 void msm_dp_panel_tpg_config(struct msm_dp_panel *msm_dp_panel, bool enable);
 
 void msm_dp_panel_clear_dsc_dto(struct msm_dp_panel *msm_dp_panel);
@@ -94,5 +90,4 @@ struct msm_dp_panel *msm_dp_panel_get(struct device *dev, struct drm_dp_aux *aux
 			      struct msm_dp_link *link,
 			      void __iomem *link_base,
 			      void __iomem *p0_base);
-void msm_dp_panel_put(struct msm_dp_panel *msm_dp_panel);
 #endif /* _DP_PANEL_H_ */

-- 
2.43.0

