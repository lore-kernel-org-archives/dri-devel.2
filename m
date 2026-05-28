Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE8A2CD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A0CE10EFE7;
	Thu, 28 May 2026 10:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aXMXYWMb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jn4zu4p/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303ED10EFEA
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vcdG4184598
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 nCzF/BAbpM3MIYUV+Gka1e1dqq+2SdVn4ec2UIWEPrA=; b=aXMXYWMb4cYNpePg
 r4MEH69Op7w/ntZjp/FD9dJw1rAJO1D/wSnIn3EP3Frmf/rzNaVg0+dI1JC6HXDQ
 f2wrtFdbGLBatNGmGO/jDGXNn6xuLc0GyIwjv+BGIOBRSAi16yuf0oEgokiLWm+w
 +38+TvZ5gBZBqWUdN41qr4xPjDdG/nI6PkgzMpxwIRfE9+40Tx47atEsK3g8dhEU
 d91Q/lqQUbmpigDAwKq7WBMepYH4BQ1jjFV5qa0dYHcO7aYG3C3pX2iIbIH811uU
 K+KeOamN8jAV0kPNGl+Z9Bd0fxgLyAAEylp66AH+A8duVAauGJXW7vFFKnmESkJh
 0FSfpg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yf2e0y-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:10 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914aa174c3aso1222980185a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964870; x=1780569670;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nCzF/BAbpM3MIYUV+Gka1e1dqq+2SdVn4ec2UIWEPrA=;
 b=Jn4zu4p/xbzSMNToDeaHe7RPdZUcOGlTv1xc3lTlm8Am1XW5mzOzsKJiUBIc4hetb2
 m1NDdn6YHmDk+QpvUzaG0HHvRIVpJbugp/i22XC18M2QLTIp8IBRqxpa5ycKKFlZEfZv
 zv+mBrTW4PuTxWpAVW6qJDpy2AtB+J9IsWLb7z8V7n4k6vdHjQGzKfAZlbkj6uxTA+E2
 dlPGS0pRm/nZCNOxVXisBvFLWykWXnz12WXAVeco4D49DCo+EtmZlTDkDuxwYxjaamJN
 AqhF4zKl7v/t4d4nOClm3vX0PishUMgJZNAIzB4zSULEaE5KpIVL4PQh0EyaKp0wEp3G
 XZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964870; x=1780569670;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nCzF/BAbpM3MIYUV+Gka1e1dqq+2SdVn4ec2UIWEPrA=;
 b=cYxmTky3KwOJyUi4GLhvQ9luiGA6vdBCo4xvgTaHTvhoeJR7ALLdT8Z5SJs66Zi6ys
 nBwRsLZO92xX8QS1sELPMFvP+B8w5XK9GPzktZZvTCACJoLvESBXw9ugrwraUvH9cUJt
 u2VPsNy7BtXfEqIisLaES0/LygqCBmUuqy6DRDihWSclV4hjiA2K2SGKPoFFwGqm+Gun
 tldwXJGX8KJRX65PJn4Bn7qpmrs1HX11/5oORF5teYFPUzH2eQoAhoo8O8qmSAKtOTgl
 iUBRMqw1mrXPry6lemRnIhnlL8JrqHqDxn8fJusY6VotTPv678S85t86ASx17He5y0HI
 jDJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QyHgPsjb/fr8LjT4BktwKUC3CenM/sJUnPypXn+TqCwQ4ddoqPqZzQNNJaSNVlMydQcwUH54vtRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxYX1JXDlxf9elch3BntmOrVuqx2Zr/DoaLyq28LUBKt37RyRFw
 NBXHzeWxBsVmuR+U3lBbeyWjqXfOFOsbiD4yo6S5zctbR6thHhwavWytV1C8jBMDw/dEg/7DR5T
 DfBs5PjhEgKbk9BgVa7090qXrwAIxmy6VuJ/1UShZZhWAn76BBdcrd9p6hhminaBWkuqeZGw=
X-Gm-Gg: Acq92OGVHbf64c+w8ZC3Qx1iSyqCAg6DC0bcd0NFfW2lE5aWV2VO6KX8OHcY8Fndzbb
 7lEkWeoiseJ1OQ6ORTdZrMHXEx6Bk7PVYOFpvfHGA7eSQdwSvEvT1enecDF7NXQuJWht1XXuCmH
 bEuCV0hsm9ERP7mt5m++CDcTLyKsvw8bMVLgEYz6eFyVgC/VViJqBhMmHPj/v7jkUnmn998c5AN
 DTP8vfyl9AV5vhtYAVahRjDULLAGBTeTw8FCjFwHwIpn8cKxrSIHqqKAMss5V4KQec3CwNYieY9
 utlsmHKhCykcJN+KSwU3v+zfJPlNS9+lpm8jClHO4Sywa2fDVW3eFN8+bP4D404OIdlIsUuqJg7
 CJterWW9Y7PSIdNzIaLi3NNuABs3QetkEZ2ora047moNCj/9x+pi+TH1J4uy2All6Y2Y/bdOzmn
 iwqYB4EzuROyEscrDjgw==
X-Received: by 2002:a05:620a:2985:b0:913:e5bb:3dce with SMTP id
 af79cd13be357-914b4a19222mr3865544985a.55.1779964869616; 
 Thu, 28 May 2026 03:41:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:913:e5bb:3dce with SMTP id
 af79cd13be357-914b4a19222mr3865541885a.55.1779964869091; 
 Thu, 28 May 2026 03:41:09 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:08 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:28 +0800
Subject: [PATCH v5 07/15] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-7-a9221c1f1f3b@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=4116;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=dqm2wxnPXKuUOtXFQoqNoFAR91dDq9Gi7fN2pM8QF+U=;
 b=C7XW/755Gv6aBYMrZBo3qAA5Ghpemv8GPlk8myph1CMqgy1gXzmDw1wibAqkiIWl3kz47dTDT
 4HaBYYTjj7OBDyKALicnx2HTf0y3nxefpr1zNZ0udDcPnmAANgjCLv3
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: XsgISWLj1YoMnIX4_Kpwzjt9n4BPldVD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfX8ZoQJOxmaTEs
 MVNVJ9F/9YCdmVjUtcNjkHiJAZN7L7vuy47JBIiIrb/cwfQFPRhRUsdtAZC6hhPTGwhjmVBoDXf
 SDMkUCPeBGx8wEunTOPxRssf3AtqDHYt+cvHBiChw9W+avCKDmeWATOKFU8TSNbj2Y7LhG4Glhe
 S2zQH0H6l2m6DPb+pEw/58YQhZlAilR7Ufm9HUzKdqQlHTIUN5BjvIMee3u1duJYu1PdQnfgHux
 x7c9SfC1KfMVpAJRQ8MS17c6VGAx7o+hRSIElBGkL7wS/kFwT3zw6nftmf5qsHi64rR0ASb3Js2
 bHB5sGvZ94LJoTLinAkFy2555YBHmerig9ZxdNW4N/B0I/3BGjVayEFlmlbNG4wQ6BS+QBF3gZs
 GVB6YXV8XAVyBg2Fdwu3a6//0TU/QV2kdPXv8LGj+R7YPBU/u9QGspRxXlJESRswv5a3Ikg9Hh4
 3wifTDNqrYbgLGv534g==
X-Proofpoint-ORIG-GUID: XsgISWLj1YoMnIX4_Kpwzjt9n4BPldVD
X-Authority-Analysis: v=2.4 cv=G8gs1dk5 c=1 sm=1 tr=0 ts=6a181bc6 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 impostorscore=0 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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

Enable/Disable of DP pixel clock happens in multiple code paths
leading to code duplication. Move it into individual helpers so that
the helpers can be called wherever necessary.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 81 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index b22b3a0df313..d502ddbc4bdf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2172,6 +2172,42 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
 	return success;
 }
 
+static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, unsigned long pixel_rate)
+{
+	int ret;
+
+	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
+	if (ret) {
+		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+		return ret;
+	}
+
+	if (ctrl->stream_clks_on) {
+		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
+	} else {
+		ret = clk_prepare_enable(ctrl->pixel_clk);
+		if (ret) {
+			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+			return ret;
+		}
+		ctrl->stream_clks_on = true;
+	}
+
+	return ret;
+}
+
+static void msm_dp_ctrl_off_pixel_clk(struct msm_dp_ctrl *msm_dp_ctrl)
+{
+	struct msm_dp_ctrl_private *ctrl;
+
+	ctrl = container_of(msm_dp_ctrl, struct msm_dp_ctrl_private, msm_dp_ctrl);
+
+	if (ctrl->stream_clks_on) {
+		clk_disable_unprepare(ctrl->pixel_clk);
+		ctrl->stream_clks_on = false;
+	}
+}
+
 static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl)
 {
 	int ret;
@@ -2197,22 +2233,7 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		return ret;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			return ret;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2515,26 +2536,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 		ret = msm_dp_ctrl_enable_mainlink_clocks(ctrl);
 		if (ret) {
 			DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
-			goto end;
+			return ret;
 		}
 	}
 
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
-		goto end;
-	}
-
-	if (ctrl->stream_clks_on) {
-		drm_dbg_dp(ctrl->drm_dev, "pixel clks already enabled\n");
-	} else {
-		ret = clk_prepare_enable(ctrl->pixel_clk);
-		if (ret) {
-			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
-			goto end;
-		}
-		ctrl->stream_clks_on = true;
-	}
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
+		return ret;
 
 	if (force_link_train || !msm_dp_ctrl_channel_eq_ok(ctrl))
 		msm_dp_ctrl_link_retrain(ctrl);
@@ -2573,7 +2581,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2621,11 +2628,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
 	msm_dp_ctrl_reset(&ctrl->msm_dp_ctrl);
 
-	if (ctrl->stream_clks_on) {
-		clk_disable_unprepare(ctrl->pixel_clk);
-		ctrl->stream_clks_on = false;
-	}
-
+	msm_dp_ctrl_off_pixel_clk(msm_dp_ctrl);
 	dev_pm_opp_set_rate(ctrl->dev, 0);
 	msm_dp_ctrl_link_clk_disable(&ctrl->msm_dp_ctrl);
 

-- 
2.43.0

