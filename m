Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D65860A2616
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=U51F0DOM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ERFNt/kr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AA11112168;
	Thu, 19 Nov 2026 08:26:49 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9DB1112144
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vDmm2935509
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YFf2Z19bBJqtMogW3f09iqCLzDyyPYwXf07gNE1oOJc=; b=U51F0DOMPMFgelF9
 6GPUsrz0eDScXqqLJXIQbnG6LygpULrkY+gpy2Q+sW9Rv19NDzdak6hrz4lOTpKV
 kdnkNyHK4rUYPSpqolaOjFl0CJmnlmin1LJstLqudrEfFrFQtkokSB9Nx8RjFJeM
 O5URozk+qi6ENxUGwlIo/ZTN3GYcRzC9lQ7Azot6tQRq9SUfF8WcWg921d4UHZK1
 KPltiJS75Yx4cvWvlmh8OGzuzw4Ptt30WKrcilBbZQ9K7AzuDywJre129KD36MHi
 Iy9cTvkB37PLD8dv9jk6JWSUFCwx4BQyeQiCRDaMs9hkg0MR1LihUGe/qE40d68k
 7tXT2w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1g9ekcm7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:04 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-948d83322f6so354715785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076763; x=1795681563;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YFf2Z19bBJqtMogW3f09iqCLzDyyPYwXf07gNE1oOJc=;
 b=ERFNt/krZMp8Xj99EUveTARbbHNoqg1BcibR2Ks9C9cohmI6cqGpj1FyozkFPaVF+4
 GVhDbov71FHD6MaEjcuYGV/nDrqmcYUxdnBPw15xg8Z02+52IlGjVfaHAImdbZB3aldd
 minztoptyvS2LanbYzo7h1C57rgGMgWfhZgAJjMKgW+Im2O7VcDaSrYqczTXtOvBoiEu
 YjttoYvGZmYa7ALxFPzDUuNxkz+TUUepBXDTMtVq2ZTXRBDzTvqFZorMLF9a5FMnob0P
 QgWu4icQzTHy6vSkpVceJUE+HT2hLgWO8Yeh3QEHaruzlEv1GzDF4GWRiidFMESJ/TpI
 pXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076763; x=1795681563;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YFf2Z19bBJqtMogW3f09iqCLzDyyPYwXf07gNE1oOJc=;
 b=nei1RzWMeihuVwQ4UpKJisMdwCQmXppQFJ1hmsYvjPs0RR5Fnjmq6Mpt0u/eIxAWLj
 gdXZ7/h+BXU4gzGhO+I/4VUD1e8WB3yPrVX0Nu4I6TcripHV38UhprAgLL4KAQEI++wS
 1/USkb+oGVkQ5ZNdpf7xOd4wmaX/d5EnoyTW2Yl0fPT51zvoRsafV/83GVQDShyIV/jc
 6DeHQCZSwpcCAmvleVcLTA0nxHkSHXFhQUB1jRI2mWLcnWC9QoaJJFai9z3r++9ChBTA
 Hc8Dsp/9dJkkxYQ4UJHIUuxqudNN8VMZ32SHANv/nipy4ntV8sbgix7xKzK0g1FyOUkG
 lh7A==
X-Forwarded-Encrypted: i=1;
 AL+hErHE8j95fKOiRSqYvjjXR+f94w0B3zXf6fAYW2vf5351UL8nJmrZLDMDLAHPRY3t6l35Vy7s7MiwnZM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/ew/bEsCo9VEwyz2uaW+9oK4WnLecy201pxlft6+j/8mrrJ4qs
 YkSeMHM7wV/7Gxr6UC/ILsA34MueWfIsW9kfO5DBgiWn/PcUwmUKh65vVZsL7udu6gvMI6jms9O
 reILXuwkZZtZZkgRWP0UaZzWyv6aUwOAFA7yGHSi75ywBqikq/c0X6eroyZICI3ZZc37jmsY=
X-Gm-Gg: AYBFou3c2Kx3oj8M3vdUkCGrNK1Dz9isa4/sLNBouTHkWIgy4KJ8YxWlbh0hVJMTlkk
 lOXv0qjm1gWwG4qNSJeiooaTsw9ukYiiDQaBzOejVm859hH2As5t7I2ytIgWbHKkEARE2cmWXxu
 cxFDVBj9kuvIPgfvZ5hADFdq4ahZuD/doIO6AtEPebfsFCVd8COfmmXaJZiJRhiE/aJ8H49eVWr
 NY3YY/9gBa8UX3UEJhdnkn/YiwrWJwRZirephcKuSrhfQ1JgmNXvSGvtEyj16XnXnSiM3u9xRjw
 03/q1DHYswYDpdIR2B15XvIspaiGiTV/P/EHnDke/kbx8+W1sxpFW8/mzeI7NO3f/kxvFDqOYjQ
 tzZl6cRuG8qHGzJS4iZAD7Wyt5fxNrJpuAjHJaGFT1xyRiMStI/8IMo7aFtSyj7HcvWaYq40xsk
 /g7KqkGGib2wIEdviT1qYcTesBeZ6Ph9zX1HXA
X-Received: by 2002:a05:620a:1d09:b0:949:7311:a698 with SMTP id
 af79cd13be357-94999558378mr853145785a.8.1795076762906; 
 Thu, 19 Nov 2026 00:26:02 -0800 (PST)
X-Received: by 2002:a05:620a:1d09:b0:949:7311:a698 with SMTP id
 af79cd13be357-94999558378mr853143485a.8.1795076762255; 
 Thu, 19 Nov 2026 00:26:02 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:01 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:20 +0800
Subject: [PATCH v9 18/29] drm/msm/dp: add atomic stream handling for MST
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-18-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=17263;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=BmX4yJFTCQMcUR3LFs/6zxbThmBE6+PbKZETXNyp+PA=;
 b=Z1SGkXFLekKgODRJzqaZ8lbzzPzJair9a1pdbGo1iBSF8z8N8L/ZKiPR1ub4GXrYAlZP8+54k
 YMxbmexk3tqCO3vOE4IdvqLUSGgXEr4n281XQv0t5+zvapL1UPq9YwK
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX9v9zIe72Mvs4
 nrXC0qJAe1bjq9MKsBUZQe6kiiz+06Te+DsfRWUe1at35o0++iVEDPt5i5nkYoySFsEjUEEGRRD
 vm9AHYyOxmNLU4jH42FGiAvHdfJWxDEyypvFKTYPaZoppIay/pFodoikn6k1Ogr1Rz0U2D6zxnJ
 obHzLV0S/sDrKV9E2VnlGwtE9Uo1/YkzVlGnNuBn+XRzVj9cgZO0IHYWARiqX1PaVLLFXPNd8Cv
 Y7ogyOQFgj+ZEE7c/1M1FiWabt0iBiYeFwcYCWmoJlr5QMk0Sg2noOzPp/zx1dKWjDd8z6EH8A5
 riB36ouXTsv09a1xFwfZ2wITwNVh7bkkHNIhAcuQczq7ozCNVOr8hq9N4yiHHJctZYAfAH2Cr2p
 oq2KOAIMotebjd8dhw9i9gkTjiXxOR1ZmJOlBTMQ+vkXbQouSur9KncbvfuYoZ2+jNxpPJTQsrt
 p5uCRd+L3OzhGaSimug==
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6afeb29c cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=5XbiwH4P-ntBLZg0oosA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: qxlRsSIZB_iYWoJyhejX0b_7rweKdxI-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX2eQBglsEqmC/
 ttjc73t78XLNwA10CemSeGHPnalJR3Fq1kNpJaK0UI4Wa1bK0vyGTjNfMRCGZ84UWAneGj/7rCq
 1XOWlDmMPdYklBvu9xwZtLaSwZS5WkU=
X-Proofpoint-GUID: qxlRsSIZB_iYWoJyhejX0b_7rweKdxI-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add the atomic check, enable and disable operations for MST streams.

Reserve VC payload bandwidth based on the negotiated link parameters,
and update the MST payload when enabling or disabling each DP stream.
Serialize stream updates that access the shared MST link state.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  11 ++
 drivers/gpu/drm/msm/dp/dp_display.c         |  45 +++++--
 drivers/gpu/drm/msm/dp/dp_display.h         |   7 +-
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 197 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |   3 +-
 drivers/gpu/drm/msm/msm_drv.h               |  20 +++
 6 files changed, 264 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 802cb62fc010..edf30d7d3d16 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2745,16 +2745,27 @@ static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
 static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
 				      struct drm_atomic_commit *state)
 {
+	msm_dp_mst_stream_enable(enc, state);
 	dpu_encoder_virt_atomic_enable(enc, state);
 }
 
 static void dpu_encoder_mst_atomic_disable(struct drm_encoder *enc,
 				       struct drm_atomic_commit *state)
 {
+	msm_dp_mst_stream_disable(enc, state);
 	dpu_encoder_virt_atomic_disable(enc, state);
+	msm_dp_mst_stream_post_disable(enc, state);
+}
+
+static int dpu_encoder_mst_atomic_check(struct drm_encoder *enc,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state)
+{
+	return msm_dp_mst_stream_atomic_check(enc, crtc_state, conn_state);
 }
 
 static const struct drm_encoder_helper_funcs dpu_mst_encoder_helper_funcs = {
+	.atomic_check    = dpu_encoder_mst_atomic_check,
 	.atomic_mode_set = dpu_encoder_virt_atomic_mode_set,
 	.atomic_enable   = dpu_encoder_mst_atomic_enable,
 	.atomic_disable  = dpu_encoder_mst_atomic_disable,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index a77a286a2462..7bf24cd2bae2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -457,6 +457,16 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
 							plugged);
 }
 
+bool msm_dp_display_is_plugged(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display,
+			  struct msm_dp_display_private, msm_dp_display);
+
+	return READ_ONCE(dp->plugged);
+}
+
 static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 {
 	struct platform_device *pdev = dp->msm_dp_display.pdev;
@@ -1302,7 +1312,8 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_mst_mgr_init(msm_dp_display, msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
+	return msm_dp_mst_mgr_init(msm_dp_display, dp->link,
+				   msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
 }
 
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
@@ -1564,28 +1575,34 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 }
 
-void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
-				  struct msm_dp_panel *msm_dp_panel,
-				  const struct msm_dp_mst_slot_info *slots)
+int msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				 struct msm_dp_panel *msm_dp_panel,
+				 const struct msm_dp_mst_slot_info *slots)
 {
-	int rc = 0;
+	int rc;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (msm_dp_display->link_ready) {
-		rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
-		if (rc)
-			DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+	if (!msm_dp_display->link_ready)
+		return -ENOLINK;
 
-		rc = msm_dp_display_post_enable(msm_dp_display);
-		if (rc) {
-			DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
-			msm_dp_display_disable(dp, msm_dp_panel);
-		}
+	rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
+	if (rc) {
+		DRM_ERROR("DP display enable failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = msm_dp_display_post_enable(msm_dp_display);
+	if (rc) {
+		DRM_ERROR("DP display post enable failed, rc=%d\n", rc);
+		msm_dp_display_disable(dp, msm_dp_panel);
+		return rc;
 	}
 
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
+
+	return 0;
 }
 
 void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 7b6d76f33ac6..62400547e01a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -46,9 +46,9 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
-void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
-				  struct msm_dp_panel *msm_dp_panel,
-				  const struct msm_dp_mst_slot_info *slots);
+int msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				 struct msm_dp_panel *msm_dp_panel,
+				 const struct msm_dp_mst_slot_info *slots);
 void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
 				   struct msm_dp_panel *msm_dp_panel,
 				   const struct msm_dp_mst_slot_info *slots);
@@ -66,4 +66,5 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display);
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
+bool msm_dp_display_is_plugged(struct msm_dp *msm_dp_display);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index ef5fb70863b8..eae82e857c84 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -31,8 +31,11 @@ struct msm_dp_mst {
 	struct drm_dp_mst_topology_mgr mst_mgr;
 	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
 	struct msm_dp *msm_dp;
+	struct msm_dp_link *link;
 	struct drm_dp_aux *dp_aux;
 	u32 max_streams;
+	/* Serializes concurrent stream link-state access across streams. */
+	struct mutex mst_lock;
 };
 
 static void dp_mst_connector_destroy(struct drm_connector *connector)
@@ -135,6 +138,42 @@ static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
 	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
 }
 
+static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
+							   struct drm_encoder *enc)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		if (mst->mst_encoders[i].enc == enc)
+			return mst->mst_encoders[i].dp_panel;
+	}
+	return NULL;
+}
+
+static void msm_dp_mst_collect_slots(struct msm_dp_mst *mst,
+				     struct drm_dp_mst_topology_state *mst_state,
+				     struct msm_dp_mst_slot_info *slots)
+{
+	int i;
+
+	for (i = 0; i < mst->max_streams; i++) {
+		struct msm_dp_panel *dp_panel = mst->mst_encoders[i].dp_panel;
+		struct drm_dp_mst_atomic_payload *payload;
+
+		if (!dp_panel->connector)
+			continue;
+
+		payload = drm_atomic_get_mst_payload_state(mst_state,
+				to_dp_mst_connector(dp_panel->connector)->mst_port);
+		if (!payload || payload->vc_start_slot < 0)
+			continue;
+
+		slots[dp_panel->stream_id].start_slot = payload->vc_start_slot;
+		slots[dp_panel->stream_id].tot_slots = payload->time_slots;
+		slots[dp_panel->stream_id].pbn = payload->pbn;
+	}
+}
+
 static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 					struct drm_encoder *enc)
 {
@@ -147,6 +186,158 @@ static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 	return -1;
 }
 
+void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
+			       struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector =
+		drm_atomic_get_new_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp *dp_display = mst->msm_dp;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_port *port = mst_conn->mst_port;
+	struct drm_dp_mst_topology_state *mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *payload =
+		drm_atomic_get_mst_payload_state(mst_state, port);
+	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] = {};
+	int rc;
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_connector_get(connector);
+	panel->connector = connector;
+
+	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
+		return;
+	}
+
+	rc = msm_dp_display_prepare_link(dp_display);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
+		return;
+	}
+
+	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
+
+	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
+	if (rc)
+		return;
+
+	msm_dp_mst_collect_slots(mst, mst_state, slots);
+
+	drm_dbg_kms(dp_display->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, payload->vc_start_slot,
+		    payload->time_slots, payload->pbn);
+
+	rc = msm_dp_display_enable_helper(dp_display, panel, slots);
+	if (rc)
+		return;
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
+}
+
+void msm_dp_mst_stream_disable(struct drm_encoder *encoder,
+			       struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+	struct drm_dp_mst_topology_state *old_mst_state =
+		drm_atomic_get_old_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_topology_state *new_mst_state =
+		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
+	struct drm_dp_mst_atomic_payload *old_payload =
+		drm_atomic_get_mst_payload_state(old_mst_state, mst_conn->mst_port);
+	struct drm_dp_mst_atomic_payload *new_payload =
+		drm_atomic_get_mst_payload_state(new_mst_state, mst_conn->mst_port);
+	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] = {};
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
+
+	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
+
+	msm_dp_mst_collect_slots(mst, new_mst_state, slots);
+
+	drm_dbg_kms(mst->msm_dp->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, new_payload->vc_start_slot,
+		    new_payload->time_slots, new_payload->pbn);
+
+	if (!msm_dp_display_is_plugged(mst->msm_dp))
+		return;
+
+	msm_dp_display_disable_helper(mst->msm_dp, panel, slots);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+}
+
+void msm_dp_mst_stream_post_disable(struct drm_encoder *encoder,
+				    struct drm_atomic_commit *state)
+{
+	struct drm_connector *connector = drm_atomic_get_old_connector_for_encoder(state, encoder);
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct msm_dp_panel *panel = msm_dp_mst_panel_from_encoder(mst, encoder);
+
+	guard(mutex)(&mst->mst_lock);
+
+	msm_dp_display_atomic_post_disable_helper(mst->msm_dp, panel);
+
+	if (!mst->msm_dp->mst_active)
+		msm_dp_display_unprepare(mst->msm_dp);
+
+	panel->connector = NULL;
+
+	drm_connector_put(connector);
+}
+
+int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state)
+{
+	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
+	struct msm_dp_mst *mst = mst_conn->dp_mst;
+	struct drm_dp_mst_topology_state *mst_state;
+	int bpp, pbn, slots;
+
+	if (!conn_state->crtc)
+		return 0;
+
+	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
+		return 0;
+
+	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
+	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
+
+	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
+	if (IS_ERR(mst_state))
+		return PTR_ERR(mst_state);
+
+	if (!dfixed_trunc(mst_state->pbn_div)) {
+		mst_state->pbn_div =
+			drm_dp_get_vc_payload_bw(mst->link->link_caps.rate,
+						 mst->link->link_caps.num_lanes);
+	}
+
+	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
+					      mst_conn->mst_port, pbn);
+	if (slots < 0)
+		return slots;
+
+	return 0;
+}
+
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder)
 {
@@ -286,7 +477,8 @@ static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
 	.add_connector = msm_dp_mst_add_connector,
 };
 
-int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
+			 u32 max_streams, struct drm_dp_aux *drm_aux)
 {
 	struct drm_device *dev = dp_display->drm_dev;
 	struct msm_dp_mst *mst;
@@ -298,6 +490,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 
 	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
 	mst->msm_dp = dp_display;
+	mst->link = link;
 	mst->max_streams = max_streams;
 	mst->dp_aux = drm_aux;
 
@@ -312,6 +505,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 		return ret;
 	}
 
+	mutex_init(&mst->mst_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
@@ -324,6 +518,7 @@ void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
 		return;
 
 	drm_dp_mst_topology_mgr_destroy(&mst->mst_mgr);
+	mutex_destroy(&mst->mst_lock);
 	dp_display->msm_dp_mst = NULL;
 	kfree(mst);
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
index 3cbd2a674675..822d34cd6ff5 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -7,7 +7,8 @@
 
 #include "dp_display.h"
 
-int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
+			 u32 max_streams, struct drm_dp_aux *drm_aux);
 void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index cc665888ce7f..597728ec6f3b 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -362,6 +362,12 @@ int msm_dp_mst_register(struct msm_dp *dp_display);
 void msm_dp_mst_unregister(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+void msm_dp_mst_stream_enable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_post_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -415,6 +421,20 @@ static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline void msm_dp_mst_stream_enable(struct drm_encoder *enc,
+					     struct drm_atomic_commit *state)
+{}
+static inline void msm_dp_mst_stream_disable(struct drm_encoder *enc,
+					     struct drm_atomic_commit *state) {}
+static inline void msm_dp_mst_stream_post_disable(struct drm_encoder *enc,
+						  struct drm_atomic_commit *state) {}
+static inline int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+						 struct drm_crtc_state *cs,
+						 struct drm_connector_state *cos)
+{
+	return -EINVAL;
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

