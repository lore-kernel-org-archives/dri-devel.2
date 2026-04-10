Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E817FE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4721B10E901;
	Fri, 10 Apr 2026 09:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MpgWQYvO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L6vy5j4c";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D30910E8FF
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A7TPxW3935245
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 GqcPCZ24ofWAWeBuM8ErgKXhLzSDSp0ZGIFwAwEb1U4=; b=MpgWQYvOqw2aE2o/
 CG/R5gR+H0qzdusYxi/6AOGJMMk/XTVFochTBzXgv+QwZXqXEr1koGCKHM8xRA7d
 rs0BjploQWD5SjcHmoGSK1m48qrz8zVvwhoCPTHf1LVEdKaFSt+ReVFxtHxdetFH
 GmvRQk5CmlRvapu7yyQD7buor90lHR/LW9JEAFGNMuotVjUMjL06UbktB92pW1B9
 RzipVPvVw74f8ASmVliT4/RKsZF4xNpjbwoa3YiXCKh/phxRLtmk1HhZBlWypzrN
 xs0dYdYE4PDiWJTnI4tbdoChTqNlA1u9evJnaHo5AY5yZf7KaTpoQbFySJ/0gZOO
 FlRUUA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5sbfh5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:33:59 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a8ea3f1becso45451956d6.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813639; x=1776418439;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GqcPCZ24ofWAWeBuM8ErgKXhLzSDSp0ZGIFwAwEb1U4=;
 b=L6vy5j4cIZJ61/eW6Xidyqr6kTk/qBasbOjhX/S+ARBKVTsz40LtfyD4h6hwaU707F
 5MGGYigLhSc0ukOvcPHh+ZY8hk/xhjaWVAEnqCsOVJwGqWGz7R71Uize2ux2uocjHwAN
 M4E02LZnHNFEZnA1DUPcDx7gWwUvyqR0rjcNpsMeb1ld/Jmz1C2IUYvrM9ByBxqEcNuM
 k/z1FhlytDY0/z973qooEqNfd/AszLbYlOuC6qKkoffiCWvIOtr+QrKEv9kEyFhstDRi
 aAXiK4WJgoPoigf2hZRbxARvU+tgjtrxeQoOZOKnI9aAoQKpj0XI12Jn8jvzgBDGoUIh
 uAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813639; x=1776418439;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GqcPCZ24ofWAWeBuM8ErgKXhLzSDSp0ZGIFwAwEb1U4=;
 b=V5vbeBheJhPgB/7/zTTLeo1qihCh1PHbeZ9xwWHc01MfebpaMak0usSYRDBzzaP9/B
 OL7ipnUixYlAM+fawPyOZEdzrSWBPbzWwUYTaUZ7JjC6NLMqhx4ovHpZ8JAiVFiHzNYK
 eU9lq2cUIBvNVQB+DsrTOQ6EqoSUCGNq5wA6t7aM5Z6FFzEaXKt+OdouTBJiNX5FUpsb
 JAAVMLt52RBKnyAtrWLl93VxTtjfjqR3rn/hfSwwxVbUrcPqEJ1//24jDU+tni/gDqiz
 5kf2uVYQ0tfu+ZTLOY/yo/P95yWEnrxaDmQoMz5pdzK35SXTvImE2DV8+6NRlktP3npl
 ceiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW+jFxQWrtWs+9Ab09rWyUF+o+pGd94Kb/qRUAkA6rIf59+SCZg4hXKWyduzM2UtuM+lNzslUWWo8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznLkG4oB8gek+IPmkJ1nF1hOiv4ULaEY0pHnTC5vzI/keN7M4B
 DUWfchrTnGWYGnJL6Bbl+arr0aV6yoo5wqxPYc2s+WchBRvbqIrDUHbOKepwSL4f5Fyr2paCxzK
 ikpk0RAn3QUAD50NAAi0jZHkCmgx3oeZnjRKHcCNoOk3CXfCfuccXui2uNPqjjY36m1J9Qyk=
X-Gm-Gg: AeBDietLHw6uBp8ASfm/bLu3rf/FeMpnGMW403CllPvb6lzRbBuWIofQyG7I94ZAFxc
 VSKyFAVm2g4se5pCpDPmgqvObGTOb/oNwQ0hXdzOY1p3RrxUaP8SuDhP4ozkW/GoYpD/Q3erbw+
 T2m4DPxmfsOJYCq+b4gCwrolr3Vv4+jlnefMKiqoISIDSFo6RlB2cifg9XRmHFEVid1JAL24FX8
 KxB7mfq4fumIaYhaJkCFJNQUiAbMyXfNrTCSu247I0GzQeoFe5C1oYS7NjdNHtlV0SwucCyhiPi
 Su8/JT0fxeSPWRA6CeW+vSVDGhEQkVS4bg/5WLr10VX7qi2bZQKrDofsXzVi17wcXgXLAqhcOIu
 L5c8iyqTHlE18cOOIR7QauHOLN74xJ5u22TjznraZiTkLj/AzF+hwB/KKdpXlyNaIgBdvhPgpAw
 /lG5bXa4A=
X-Received: by 2002:a05:6214:ac6:b0:89e:f35f:79f7 with SMTP id
 6a1803df08f44-8ac862fde2bmr34170176d6.51.1775813638952; 
 Fri, 10 Apr 2026 02:33:58 -0700 (PDT)
X-Received: by 2002:a05:6214:ac6:b0:89e:f35f:79f7 with SMTP id
 6a1803df08f44-8ac862fde2bmr34169896d6.51.1775813638387; 
 Fri, 10 Apr 2026 02:33:58 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.33.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:33:58 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:36 +0800
Subject: [PATCH v4 01/39] drm/msm/dp: remove cached drm_edid from panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-1-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=8935;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=uZfqkKsyUuvhDJEMiuMHtPECSA2HOV7I6DmlDJNOZKU=;
 b=91kwcb+pVceGCT+BXif9ewyCmuomE5R+Bm5lwh4dd2WTN7KEd7DlCtm9Ac15c9VpVBlx+gesc
 wEG1PwqTFUYDj6HOpApvzyXIl515UCuMeD4AC8b17kAUZP+hXy3msM7
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: 62lt4XmFLn17OOWcte8z64uEm0QUM9Se
X-Proofpoint-GUID: 62lt4XmFLn17OOWcte8z64uEm0QUM9Se
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d8c407 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=Jn5Zs6sXaE638rALQFgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfXyV41OY6UkAvh
 dK81NzfAhaP6tuK+gn9PmG9YhSN/5K2LNzXFJjz0stil8CD6kXex5sbz4tGlrfkGRDq2OFMwFQR
 IEU7Qh0Kj0Rn1U4q9PTdyCij2eqWn0LPFE3sVqii3IZyxNxc8hal5U9igwNczNsvaNwbl85zOhJ
 NAPOdMbqfqPMsFkpWcq/xcsEuKQlcy4UjzxoyuedSYG1lB8CTnGcB7bzFDyIg2FuHcjt+g+umx5
 ILlodY+EjDRoS+PX8FyNRLUc5h5CTznzui1kavXUr84ytI2xh6BGqPYPY1489zM7Iguw4KKGQrx
 zoN9cGG50T651M2RoywoMWVrGeNzrNFcgXmbcPTTceES2p8KNLubWTXE5HUEhUymR4xjl5J0kcN
 82LFf3GgHAt8PBJYuTj3Io00+85fyjovqxIoMhtUDvkIBy95NDopRAS4H0Ar/MQs3BbXK2Wjz2x
 I9N49h8TKaXv1HLg8Pw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100088
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
 drivers/gpu/drm/msm/dp/dp_display.c | 27 +++++++++++-------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 57 ++++---------------------------------
 drivers/gpu/drm/msm/dp/dp_panel.h   | 13 +++------
 3 files changed, 26 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5c6a24ec140d..e28cc1bbb5b1 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -268,6 +268,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	const struct drm_display_info *info = &connector->display_info;
 	int rc = 0;
 	u8 dpcd[DP_RECEIVER_CAP_SIZE];
+	const struct drm_edid *drm_edid;
 
 	rc = drm_dp_read_dpcd_caps(dp->aux, dpcd);
 	if (rc)
@@ -275,10 +276,20 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 
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
@@ -290,7 +301,7 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	dp->msm_dp_display.psr_supported = dp->panel->psr_cap.version && psr_enabled;
 
 	dp->audio_supported = info->has_audio;
-	msm_dp_panel_handle_sink_request(dp->panel);
+	msm_dp_panel_handle_sink_request(dp->panel, drm_edid);
 
 	/*
 	 * set sink to normal operation mode -- D0
@@ -449,7 +460,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 
 	/* Don't forget modes for eDP */
 	if (!dp->msm_dp_display.is_edp)
-		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
+		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
 
 	/* triggered by irq_hdp with sink_count = 0 */
 	if (dp->link->sink_count == 0)
@@ -512,7 +523,6 @@ static int msm_dp_irq_hpd_handle(struct msm_dp_display_private *dp)
 static void msm_dp_display_deinit_sub_modules(struct msm_dp_display_private *dp)
 {
 	msm_dp_audio_put(dp->audio);
-	msm_dp_panel_put(dp->panel);
 	msm_dp_aux_put(dp->aux);
 }
 
@@ -563,7 +573,7 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 		rc = PTR_ERR(dp->ctrl);
 		DRM_ERROR("failed to initialize ctrl, rc = %d\n", rc);
 		dp->ctrl = NULL;
-		goto error_ctrl;
+		goto error_link;
 	}
 
 	dp->audio = msm_dp_audio_get(dp->msm_dp_display.pdev, dp->link_base);
@@ -571,13 +581,11 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
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
@@ -741,8 +749,7 @@ int msm_dp_display_get_modes(struct msm_dp *dp)
 
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

