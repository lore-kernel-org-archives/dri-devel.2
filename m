Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0BBAE9905D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2003B10E91D;
	Fri, 10 Apr 2026 09:36:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mBOS+Whi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XlJfzXHz";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B5BD10E923
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:05 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6IElx2866294
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RV1AlcKaV8PuYqnuzteL5m9c9kkZPleUlsYbxhWBzCo=; b=mBOS+Whi4L4/sIlf
 yuUWHnPSozRH+lXAe6wXVAGD2pihZHuF4iha2xJKGbaz+bd/EB3KZdoSewmzicyl
 iwnX974fokYKcXkg0wyxCLU2NlooIB4TDpojOq7IlrkAbCzddZbZ3kcxUWyuknH/
 12PHIo5c/1X1Sh3kakcPbPO5cYnLPsErdECAg9ob7BxnI57vtsl9jAfIl6kIb8bY
 FUkFtluXlZGiN5e7xGBtBoUwGFPFJwV2lVKvabFzVz5naQP12O3vqmb+0CAF7zYt
 g5Jo9+OV2/HqVoIldRfbhbNSkFgPGt31XEYly4YoxZ4dVkXWLwgqYFmA1rPFRnGo
 Dm/woA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4decaykt47-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:04 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-89463017976so46600806d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813763; x=1776418563;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RV1AlcKaV8PuYqnuzteL5m9c9kkZPleUlsYbxhWBzCo=;
 b=XlJfzXHzi07WpjixHTALY1HTgZ7zCg7EKRvyyrvObkZbVuqJyssP/HzQzU+5pnT0/7
 Vmsz80KFqJV/0a+uBk4PsE7VWAdoN0cDbEKcjtnA/pOaycH9nuPQCayZmA+CWmnDiw2T
 7Q1I/x1ylneaxjeAeK4A8696QNRn7vgpMhcNflIfu30PXGiN2qMz/rp5WlB8bLMEYkB2
 pzOPAWJWyAsXHoS+VsJ5pxNvCMBNok15VxnB4LcC2gPC912YWOZOKdBIp1xxQOPUH1VO
 O83SLZmvxSD9TohV9xizg59UoixTn7gxxfln5y7UoQQDE19wZ3bwQVjQOX+Amg7z1CrO
 81Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813763; x=1776418563;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RV1AlcKaV8PuYqnuzteL5m9c9kkZPleUlsYbxhWBzCo=;
 b=JD5CO/sRnAfGp5UhrYz7N80BvU3HftYP0H9qx8vIrUt0M5brpflICiN6gaoqzU+vmE
 8mtWeOY1Gg8l6cClyQOIg/qVNgI0lqgNIu7O9qm7AyVJX55v1LqozGQxWpg/97kZh+nO
 0VGUb6lFBJ7pJ/a2HRhiOGdeoA6eRLv7aaljqbUUooWm1OZaw2wuzjtQkdonSOLc9aL5
 lP8TYZx+JmybNq5jhZmwdSKl8uNkRR3u1gr6EkhaIbCKL2/4ITG+7ifRdgy78gDSv4ZT
 858aEApzBs1uEzJ5Byx34HzMlzzGZ50APdKVqlkVazjsMz2FJdCcY3giEFZbGL/mW9up
 tR1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmOR6NOCgfope0thD9lcEGkUC+Ie9Gw/8d0dwmy0aFhM0se++FpXzfNPxJD+hlfmH3AK1S+Gm1SmE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvjGPq0Z4hKwzGAmiKPcfUvocSaqBE7F6No/7byoZNAMYanEUf
 kjOicCcCp5fpHLfSfoQimpaixqtzyD4EKA1rzqrOMGdz0zD9mnILlWtL7ePqYiubd8QIq8OTbSD
 u2JQYedvi45p4/1NrfAUWjSX4AAUUJ1evrHeewMaBfvRIBDWpysJCAqzHrCbgePl+RmhCwu4=
X-Gm-Gg: AeBDietwxDIZXM6s4gLeiDqpSvFYq+kxF57k1KOKhr5P1eQVwjchfrskWF2Lg3y23Zb
 lch4OmUWrVvGki/GJM6SzLVMNVsxvUc8p8rb+Isdeq3BDZf2Yg0Ye01aIS7NdWFEPm6WMsNh0sS
 H8sv7rNm3uHgvTn9l9bPtNt1Pv+OKdsDqGd9+emfP+dDeodW+QIBw5rXGlZ4M8Kysqx+FuEJUSo
 Sg4E8NYr9hrNCEHFSzlol23CMMxkGh74j6fZg2zY54HymgpBS79DlJtb1/XBYOP6GaGJFx7QtpU
 PyUYDSGUMQfRI2FWnogVe3G10q0vIZRrNk7AyYd1qESasN/YmNs3zz61LOTlo3jgvL6LQ1JubRX
 eMn1V+n9re6bO5MNaNyPyWNe6vNjZtYsT4okoo6fqDn1WnMad8m8X2jE9eVwuPRe8vel5LDxqqG
 ZrcVByzDw=
X-Received: by 2002:ad4:4ee4:0:b0:89c:a2c8:9432 with SMTP id
 6a1803df08f44-8ac8602249dmr33789966d6.0.1775813763266; 
 Fri, 10 Apr 2026 02:36:03 -0700 (PDT)
X-Received: by 2002:ad4:4ee4:0:b0:89c:a2c8:9432 with SMTP id
 6a1803df08f44-8ac8602249dmr33789716d6.0.1775813762798; 
 Fri, 10 Apr 2026 02:36:02 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:02 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:01 +0800
Subject: [PATCH v4 26/39] drm/msm/dp: abstract out the dp_display stream
 helpers to accept a panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-26-b20518dea8de@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=8958;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=YrY14+ddBFFCc/xwaiRw3YH63VjU3LayV3GcWeqoNN4=;
 b=E3KU+5b0+HVeuI3fSLAWrsUSSGwYc1EQ3zwvkd1GDhF7OO5DFk9NBO77ZX13b2gRTepQuxbDz
 0lSE8EhfFJDCATYIIs/2Ewm23J6e5SZLGgVIl7mGIs6nrTdb0eaGLqL
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=69d8c484 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=8K8LDW8wUMBAfiAu:21 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mu3EkBhnCEQeHIwj90QA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX0fSCTAboGZrB
 ebIyQnM9mQg9pTd6rCrWDqp380sFobK1v9OaV4FYSbMvO2PxYudtiwC3G96vqkahI1sSvfS1t2R
 2CT/5ogfItRQHp4Ffx3wmq0rFj+rH0WNckoNUXJs6eyr9P6xqcqnG3iv8mH+6VxMymbfDjeXjW3
 zx7RkXLF0Loug1GQkL7nTogwKyymvbYn6KShr/usqXzO/ECjxiMW9LEVjqqKY3ZR1U2jZMVCZFI
 1iSKPgNxU6F1t8fyYanNAkp06ErTogg5w3bGN2A2CjoH4FR1iqZnKgmBbDolbxOR11tR5HEdCQT
 QP3ghpqEwA4hEBh4s/9rl3YIo+ITpOv2idy7FUkKLMvxIOT+VamXD3p0fr7L/KbFJVowRLN50Ve
 5RhjaKcd1DuO7igpLBVLKhkK8W3ZKcJwbAW3HXK7rC5/6n5iVY8k2kOx7oLF7sqMhKoUOiPzhiP
 jajqC4s5QY5U47uVh2A==
X-Proofpoint-GUID: pJkPzn4CHAf5bproWOtyf_tQGrFi1-Ap
X-Proofpoint-ORIG-GUID: pJkPzn4CHAf5bproWOtyf_tQGrFi1-Ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

Currently the dp_display bridge helpers, in particular the
dp_display_enable()/dp_display_disable() use the cached panel.
To be able to re-use these helpers for MST use-case abstract the
helpers to use the panel which is passed in to them.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 117 ++++++++++++++++++++++++------------
 drivers/gpu/drm/msm/dp/dp_display.h |  12 ++++
 2 files changed, 91 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 88a078e53dc1..33d8539afee7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -635,12 +635,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_prepare(struct msm_dp_display_private *dp)
+int msm_dp_display_prepare(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
 	int rc = 0;
 	bool force_link_train = false;
 
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
 	if (msm_dp_display->is_edp)
@@ -680,7 +682,7 @@ static int msm_dp_display_enable(struct msm_dp_display_private *dp,
 		return 0;
 	}
 
-	rc = msm_dp_ctrl_on_stream(dp->ctrl, dp->panel);
+	rc = msm_dp_ctrl_on_stream(dp->ctrl, msm_dp_panel);
 	if (!rc)
 		msm_dp_display->power_on = true;
 
@@ -738,18 +740,6 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp,
 
 	msm_dp_ctrl_off_pixel_clk(dp->ctrl, msm_dp_panel->stream_id);
 
-	/* dongle is still connected but sinks are disconnected */
-	if (dp->link->sink_count == 0)
-		msm_dp_link_psm_config(dp->link, &msm_dp_panel->link_info, true);
-
-	msm_dp_ctrl_off_link(dp->ctrl);
-
-	if (dp->link->sink_count == 0)
-		/* re-init the PHY so that we can listen to Dongle disconnect */
-		msm_dp_ctrl_reinit_phy(dp->ctrl);
-	else
-		msm_dp_display_host_phy_exit(dp);
-
 	msm_dp_display->power_on = false;
 
 	drm_dbg_dp(dp->drm_dev, "sink count: %d\n", dp->link->sink_count);
@@ -1495,76 +1485,116 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
-				   struct drm_atomic_state *state)
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_state *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
+
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_encoder);
+	if (!crtc)
+		return 0;
+	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
+
+	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
+}
+
+void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_state *state)
+{
 	int rc = 0;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	crtc = drm_atomic_get_new_crtc_for_encoder(state,
-						   msm_dp_display->bridge->encoder);
-	if (!crtc)
-		return;
-	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
-
-	rc = msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
+	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
+					    msm_dp_display->bridge->encoder, dp->panel);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	rc = msm_dp_display_prepare(dp);
+	rc = msm_dp_display_prepare(msm_dp_display);
 	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *dp;
 	int rc = 0;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
-
-	rc = msm_dp_display_enable(dp, dp->panel);
+	rc = msm_dp_display_enable(dp, msm_dp_panel);
 	if (rc)
 		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
 
 	rc = msm_dp_display_post_enable(msm_dp_display);
 	if (rc) {
 		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-		msm_dp_display_disable(dp, dp->panel);
+		msm_dp_display_disable(dp, msm_dp_panel);
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
 {
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_idle(dp->ctrl, dp->panel);
+	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0, 0);
+
+	msm_dp_display_enable_helper(msm_dp_display, dp->panel);
+}
+
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_ctrl_push_idle(dp->ctrl, msm_dp_panel);
 	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
 	msm_dp_ctrl_mst_send_act(dp->ctrl);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_atomic_disable(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
 
-	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_disable_helper(msm_dp_display, dp->panel);
+}
+
+void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+	/* dongle is still connected but sinks are disconnected */
+	if (dp->link->sink_count == 0)
+		msm_dp_link_psm_config(dp->link, &dp->panel->link_info, true);
+
+	msm_dp_ctrl_off_link(dp->ctrl);
+
+	/* re-init the PHY so that we can listen to Dongle disconnect */
+	if (dp->link->sink_count == 0)
+		msm_dp_ctrl_reinit_phy(dp->ctrl);
+	else
+		msm_dp_display_host_phy_exit(dp);
+
+	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1575,7 +1605,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
 	msm_dp_display_audio_notify_disable(msm_dp_display);
 
-	msm_dp_display_disable(msm_dp_display, msm_dp_display->panel);
+	msm_dp_display_disable(msm_dp_display, msm_dp_panel);
+
+	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", dp->connector_type);
+}
+
+void msm_dp_display_atomic_post_disable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_atomic_post_disable_helper(msm_dp_display, dp->panel);
 
 	msm_dp_display_unprepare(msm_dp_display);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0ccdddb223c8..0ede5505be58 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -46,5 +46,17 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
 				   enum msm_dp_stream_id stream_id,
 				   u32 start_slot, u32 num_slots, u32 pbn);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
+					       struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_state *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_prepare(struct msm_dp *msm_dp_display);
+void msm_dp_display_unprepare(struct msm_dp *dp);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

