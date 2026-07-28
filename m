Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0811C531F9
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10B4110E86C;
	Tue, 28 Jul 2026 10:22:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="WohDzA6B";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bw2V8OA5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D76610E55D
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:15 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S81vf22071256
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 OTx1v2sp2O92AoJjL5411r6vaqf4b2hlKoMzg6Uq2g4=; b=WohDzA6BdlDPGEtq
 YcE4gpqTi/m/gR5DNOv5Yn/ZXidSX1frLqHdX86uEisTnIDyu37AxTQOlo7NG3JS
 LMZkN424RuxCimuok8iPqv4oMCjOiK2cPpQFovYfeUmTdcIAm3RQrYI/J8VeAjYX
 xgG7jxemz8qdjywM3lUsf3Q/29hOwhv92M54WrWQ7MC7KvClLD6vDgtIzz8j5SL1
 F3sF3e7L8w37ddtKLwi5kHZ+Tnx0z1Bi6eu4C9CT0bWoeNyhd91i9+mP06F66n//
 gBl+KLOAWiPOFkt3cOMbbCF1ooc57bJF8EpMGWhIxbkGfbD2u+rFkzycv7fycDhm
 poyLXg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpqxjgqk7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:22:14 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f08560ea44so50245276d6.1
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234134; x=1785838934;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OTx1v2sp2O92AoJjL5411r6vaqf4b2hlKoMzg6Uq2g4=;
 b=bw2V8OA5rvD1NR3D50iDOza8o70ENIgogF054cojN9uoVBm02RtmmWizTFyGMsQtf4
 etX8PU652xK239QB85u8HaaRfGAXGRY+aw+jwj2cyWRDNb7YEOaeYY1ZBeZYh1GSwle0
 wi4aqR0nQsaOrOmf1fJeyzV8s9waazjUnKEHgVW5bAMkCwlTMwgdzInRgoBQcILojkBA
 sZyXm7SrdltALGAMimA3wqjWBygQ2d/GpGfO3j4WdgJxVDZEF1s5tRirpEhDHPAJeSY+
 3y7WklC1QKkpJfSVKY9vL5JZ/4hSS+EVTTo8aXCoHfPqHLAPghSJnvwmFWUBRr5rbgj1
 4csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234134; x=1785838934;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OTx1v2sp2O92AoJjL5411r6vaqf4b2hlKoMzg6Uq2g4=;
 b=YiJB3qagB31Q8eU8/b9IOGRH3yGUc3mGayRzQZCBugVbq9pdG5D6+QSsUlLkyZiByZ
 u6NBGPQkrk1nL/h+SQukvOloIF8w4j5ro43CEivYO/Epc+CWZ27SkCkHdIoiG1q17x8Q
 K/7bn5L9etDM5L8t/Odosk5JTT/i2xS1RmmJILMrjjyD/BpHL03gr3tMckyda6TihtaV
 sNW2dxSphMAfn0F9wFmByb5xwliEOf0LEb7OWD1MJ4eI2JirzFCALeeWqnBz9UKRulm0
 u43M/7d+qnXwoEUv7ArzWSnW6EpUKI6cwM9M80M8xTf7tb7xQ3eX+uCK2OJSAvqth8V+
 xEzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq9e+TGpv4l8Dpw+Hcnl10rO7fnyggs1P67AWQA6Dh1gfmpo44EdFv5yruHzF9jsmr8kLg4+Q+MKzo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFpN+ytTziEts7wbr+3sHLKHybZGlNRVHkRGk9+oYqkuNL+Fpg
 TgEcjIeR1blXJPi5k207sCZW4zW4DBkXqeERI7VU4QN8wxJeiABcYzDkTC7FPwWBtygVKik05/U
 pMdppyvO/IZkJqy4C0cgO1s5Wh92itqrGaN66oDGQBtya0WyJRVwYzTGY2PAbthOaqdi1tcc=
X-Gm-Gg: AR+sD12T6KNJqTEFl1HSeHvnLXVEHyGfCquACkIAtvz2BlbbLUsPe36S36WNsRSZWYj
 1ZZzSwZQciAyw53fnfArRrVWSqx52rpDkI3CD0WUqiLhD5m7XGVX4S8G55dtNHhcXtv+MQwjgf1
 Bp0bsN8jaBzy1ZXOViEnyBopFkX9MvhKfZX1ShF4ifEvmc6Y4+GvnWU65Lwx+g8fwns8gEWfJ4R
 7D+uuyOWkEouaZaj8Y+zZdbIUTasgZPboUCfMwBNNeXjUQkNIINk2viCbhhii60BGiPIMmBZnpq
 Pata9HoK4V5oSPEdkTof4YdZGHCEUz5b9gZhFUN/I2kQWGlKjdLfcO32gq/cQdZW4/tVhxclAcN
 g/TOkzrZEmwqoeW7DBOO8iScWWk1o+ZSNYnPz4TIJ0q0b6dEGdi2txavtcbcqGAE=
X-Received: by 2002:a05:6214:1cc9:b0:8f1:293f:abf3 with SMTP id
 6a1803df08f44-908172b1470mr16549806d6.6.1785234133865; 
 Tue, 28 Jul 2026 03:22:13 -0700 (PDT)
X-Received: by 2002:a05:6214:1cc9:b0:8f1:293f:abf3 with SMTP id
 6a1803df08f44-908172b1470mr16549456d6.6.1785234133291; 
 Tue, 28 Jul 2026 03:22:13 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:22:12 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:36 +0800
Subject: [PATCH v9 07/14] drm/msm/dp: move the pixel clock control to its
 own API
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-7-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=4071;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=A84OlDexxXirLha+d1Zdha/lr/GtldHWpxuKLBRgkU0=;
 b=APYvZ8OZtdbO5TNyeAjo4yF872ggq/+ZDbDszUDFth8OsVE9/8EpYSrWBDpemX/YSjz+ippqw
 DIMsssYqmyGDpcHOb3t2EyKwY0JTJ7pNP1mO2KCsO+4ufGKzTouLDPk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 1S9pGcrOyAT88KNgtvxd6Pq5_iDcHgEn
X-Authority-Analysis: v=2.4 cv=MORQXsZl c=1 sm=1 tr=0 ts=6a6882d6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=FjMX0bmgnFGAle5WrLgA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX6sGWkeM3sZ38
 LQbv7JuNxAmzZXoBnv7Gbz2j7MwJYK7ulEc/gFT9XVugEpDYMEFP2YXZ6qImmmWObNkA7gq3/E9
 X7yLu88PvJNeBmvX0eC0/uIIAf1oII4=
X-Proofpoint-ORIG-GUID: 1S9pGcrOyAT88KNgtvxd6Pq5_iDcHgEn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX6XmHwp73PWXz
 Pg6Qge1nGXUYXx8pGKjD1C653W9kc/a3yq3ErSD5cPcxvHngk2prfNW/tx3j3T/sPXHHp7+lq3F
 QQ5aKf4nVfIdVF1eXvU7MAiCaiF/C7qBcuqIMbk2kjVoi0eiclgrt2pE0z2qHHm808KqHYz8dZd
 KhdedFOfmZcisn0YfbY/84AyOf1KZp81bxL8/ctnavqQqCcKYfudT5kgMBGjOMdmIknevALktcI
 /DUys6zWkRPvIWvm8EYN+6tupUZ6BPannTqvYSGJPhIQASleWp2VMt4tKwyYJQ1t8xnDOKxGni1
 eXd9TuIhpJLQtFGOK1Qz1xwlmSuCeOS5LgSmhhMci7PMqem9BflVFQ8XqCU50ip+ftnUjn52OkD
 qZ7HHEXcx5Dd34Wgb2gKGiko6prAxzExhKTa8VTkSvfaOLLkTdGlE0inkUz5P6gafo3gjMPMpvn
 LumUmltNvdDyWoBcNRg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 80 +++++++++++++++++++++-------------------
 1 file changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index f343bd6c2b81..068d4f8b673f 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2176,6 +2176,41 @@ static bool msm_dp_ctrl_send_phy_test_pattern(struct msm_dp_ctrl_private *ctrl)
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
+	if (WARN_ON_ONCE(ctrl->stream_clks_on))
+		return 0;
+
+	ret = clk_prepare_enable(ctrl->pixel_clk);
+	if (ret) {
+		DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
+		return ret;
+	}
+	ctrl->stream_clks_on = true;
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
@@ -2201,22 +2236,9 @@ static int msm_dp_ctrl_process_phy_test_request(struct msm_dp_ctrl_private *ctrl
 	}
 
 	pixel_rate = ctrl->panel->msm_dp_mode.drm_mode.clock;
-	ret = clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
-	if (ret) {
-		DRM_ERROR("Failed to set pixel clock rate. ret=%d\n", ret);
+	ret = msm_dp_ctrl_on_pixel_clk(ctrl, pixel_rate);
+	if (ret)
 		return ret;
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
 
 	msm_dp_ctrl_send_phy_test_pattern(ctrl);
 
@@ -2519,26 +2541,13 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
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
@@ -2577,7 +2586,6 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, bool force_link_train
 	drm_dbg_dp(ctrl->drm_dev,
 		"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
 
-end:
 	return ret;
 }
 
@@ -2625,11 +2633,7 @@ void msm_dp_ctrl_off(struct msm_dp_ctrl *msm_dp_ctrl)
 
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

