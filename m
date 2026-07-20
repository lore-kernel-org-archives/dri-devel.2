Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E151C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547CF10E695;
	Mon, 20 Jul 2026 06:11:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nfc0b8yc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XiZO2Eqo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FEFD10E695
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:51 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNstbQ408650
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lhiQV8OxOvmaAeJu25Jj+stsPzIy4U8Brw014ne08/0=; b=nfc0b8ycJqKhwX1V
 561eSKp5y8FsK24IQle6o8A8IY2nzy51gRhYdzDVwhTIxxd4lqFovZ0DitA+avkg
 IuaQvUtmrPEvhpTZQL3JQmHLSzRQeGPoQLxko9CtaO85s/LkKAeXwA0FWFhgQi0b
 ATiRhL/43wz+dlR7YbzgT3N2o0T8ll5f1nWe3g93ioopqcNWz60YF+BDuJKYfmPI
 tBBTj+COb4cGR+1NU6SNb5s1JYEvJqHXPvU/6E7iMQ6RGHXZTIG/NnZT9A9MDYxV
 J0UEyrh1oV7Fc6cobkZb5WXxs/45FDXtCCrypGnnVUXJQ4x0P6i2y60amzYWC/uf
 lIFETw==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2nhmmxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:50 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso216591666d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527910; x=1785132710;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lhiQV8OxOvmaAeJu25Jj+stsPzIy4U8Brw014ne08/0=;
 b=XiZO2Eqor19plkWvUd5+i2sq919+R1rpf5PFrkkoxZr0k1A9f2g+Wfz0X4DJCwu1Z4
 rr3mMGEg4Q8wA9JaGBINSoYNMOsvxQjzP/Gr3qL/IjoF69Jdx36Hu550fEtvwEPgGsOA
 vi2oo5uQe+7K1CpL0qpAO0AIRA3nzr9QyY+0tUpdLGiz/X/yByChMkktyVpPLSsdS8M/
 ktk25wmufCp1v/jD4c6mpnWebam9LDk3uCeeg9KJkDmt+f2B90jRpjqZMvVFa1Svpl37
 XDinPn0+Yse7EwGGGixvNMe8fveisWJCAUlmhdYU8LTNKarNYQFyE8glSpYNXNRkcUmy
 KCzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527910; x=1785132710;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lhiQV8OxOvmaAeJu25Jj+stsPzIy4U8Brw014ne08/0=;
 b=ovF81FyG6kONiWWFqdjhiPI+DApXSSAr2HQeSYxAzomeBDSTltzeH6q1feSzXfuE4K
 nxUPetNttq1Q0lrXNK5Corr0rSpDn0GvkQGYpApzvVa9ocSWM1zhob3HrvKKOS6ldiSI
 h89idim8dgKL9HRHHwGSDhYcnmQAhaE1m7ruO1VVbzi38sQy8chW3RbOwYKXJ9F/z6Z2
 chdkBEWRF0ZgDNC2rpVV3C43jHXO7H1qXY2Y1+2E8u/TesA89WRAxuAvnR5ncIJJJRBs
 M9idTvPieqdz1OmsHosTwCjXwFlELjXhCaZbvDfwVxz8SikJn2JajInub/6c7g80SQRD
 RTjQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqs5HtqvaOM35nmV/6WRAiseNPZ11omqH7IZdNoAOHgk+V4vsv7neNhER7UGTskrdP/QyrDIaNeJPk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy9MHNAbO+dTCeIgSTXE/zvnlntFllSuqHu2xAo9BxivlhAbw0O
 Pt88vrdZ7jLYmYhCYcxTNdsCwvMPiqpvVtPDJqh1/h/Gb9/9fClOleJl/Cyec+6cVzyGishL4dw
 7Viy67KNbBKiAS4wSuTzEx75iYpwMyb4JvDthSjcSRZeCPhd2qNj4FUJmob2wtgvL1TCbkUc=
X-Gm-Gg: AfdE7ckThoHFytxtL5cEdnaUKMsAKf7pYNCJN9KxAwQ+9bLJkNTnzg369S/Hv3YrNFI
 8l1NHGHmIVnnqW4DeQQ88C7zET7QqSMcz3n0J9aWl8ATeL4DmL8Ts/U+POR+XoacanNLQAuKlmt
 dXK7uwyTkGbt/69rVsZFmrFgn1fj7KKjNM9FtowXUYjlnrp4q6PCARiAbx7CMRNvZJm30Aq/4b6
 xc7QESqBY6L38fvA5F9cWiUEphTllJV4Dxv5QHv2FNK4aAI6d1tv6/EGehGK2HrjZvtzbdP4af9
 Wy/nFCYomhZX91YO5+Ih46mZaA9bE89YTZF/saTojHqAmu4hs+5pehYFjGdluCDv4RziPlzqz9B
 9bmWRzCg4BzeojB/7J2trn548jc4O4pJeWZ6kRlSxhj2W7px3/JBGonjiDWx9MB4=
X-Received: by 2002:a05:6214:c48:b0:8e9:78d7:6b98 with SMTP id
 6a1803df08f44-90778353e4emr120793856d6.6.1784527909690; 
 Sun, 19 Jul 2026 23:11:49 -0700 (PDT)
X-Received: by 2002:a05:6214:c48:b0:8e9:78d7:6b98 with SMTP id
 6a1803df08f44-90778353e4emr120793766d6.6.1784527909281; 
 Sun, 19 Jul 2026 23:11:49 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:11:49 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:20 +0800
Subject: [PATCH v8 13/15] drm/msm/dp: make bridge helpers use dp_display to
 allow re-use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-13-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=8509;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=DdyEaeCdVA9QEZM1o4gUYj/xzzxduNmsf5XNmE5oshE=;
 b=TQ1HKjVi2QpOVMyigPVcFMvgitfp52W/1+G1F0F9EQjeqDFFNC/ivzXG6THNvTfYwih7i0S9U
 l7S2uxAfNWbB5D3/UO+WFvA3lXbo08XfWOHY+V1eCYPBqH7pFxxTSHE
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Le0MLDfi c=1 sm=1 tr=0 ts=6a5dbc26 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LmD7BKvqrCyCckpIDn8A:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ZwAiwK_TuRBStNm12YykP8_ELGm3xZkX
X-Proofpoint-ORIG-GUID: ZwAiwK_TuRBStNm12YykP8_ELGm3xZkX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfXxh9q5sSZtGV7
 6v3KVgT9uhKolYTJFjRz0kS3E7dWTxZBsJ3YCIxH0X+qQ0RUYYo+Msmvw7a11e/dUbPdfzWV9aZ
 KCD7fvyzMzZknQDObHPLr/WRr9jNOvR5aJcOZcy4smqPXWpJICr7QbWm/RTrHEQNprSsnhagjM0
 3OvnKhfGMlDM2Dbcu1gGitgCr2c3o1V+KKBxJ4T+bQktNPv21xD5JKmPcdP8kW7HfelO1sHfUYH
 PRHYlF7iPaw1a7dVd+ZtsOzbdSRVGKRXaFfJfjGrbEcyKoveBDn+6Ig2QKK4TY2+JJTwhWuQQfj
 VlhdyAeg6sbcDYRg+t69FyJr7nVvhxnDoMTizsTVdBP7EAMqexUzvt21tkFR3dSX1dyOH9jEtpi
 5HrNZFLQQFx2o32oUa8CNhf3L3/EHPpirtwfBhFAG+XuEmuMRYxo5l44JsKTBwexI8g8k/xxkbs
 tG4R3XErIt5RW6guAag==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NyBTYWx0ZWRfX2f50FHeOZI9J
 WCsms/Im9KvRXbv0PAb2jiZix6+8DxDhY0woy9MS3i3zblgzJJh7+jjRHJUy8XGsnQ6cZYqpRAq
 vN5XeuXIoZ5eatSiGH9hXa2hfpf6rZI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200067
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

dp_bridge helpers take drm_bridge as an input and extract the
dp_display object to be used in the dp_display module. Rather than
doing it in a roundabout way, directly pass the dp_display object
to these helpers so that the MST bridge can also re-use the same
helpers.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 29 +++++++++------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  7 +++++++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 39 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ---------
 4 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d1a3a6f6c303..deb21cee1183 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -740,24 +740,21 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
 /**
  * msm_dp_bridge_mode_valid - callback to determine if specified mode is valid
- * @bridge: Pointer to drm bridge structure
+ * @dp: Pointer to dp display structure
  * @info: display info
  * @mode: Pointer to drm mode structure
  * Returns: Validity status for specified mode
  */
-enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
-					  const struct drm_display_info *info,
-					  const struct drm_display_mode *mode)
+enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
+					       const struct drm_display_info *info,
+					       const struct drm_display_mode *mode)
 {
 	const u32 num_components = 3, default_bpp = 24;
 	struct msm_dp_display_private *msm_dp_display;
 	struct msm_dp_link_info *link_info;
 	u32 mode_rate_khz = 0, supported_rate_khz = 0, mode_bpp = 0;
-	struct msm_dp *dp;
 	int mode_pclk_khz = mode->clock;
 
-	dp = to_dp_bridge(bridge)->msm_dp_display;
-
 	if (!dp || !mode_pclk_khz || !dp->connector) {
 		DRM_ERROR("invalid params\n");
 		return -EINVAL;
@@ -1408,11 +1405,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
-				 struct drm_atomic_commit *state)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
+				  struct drm_atomic_commit *state)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	int rc = 0;
@@ -1421,7 +1416,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	crtc = drm_atomic_get_new_crtc_for_encoder(state,
-						   drm_bridge->encoder);
+						   msm_dp_display->bridge->encoder);
 	if (!crtc)
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -1451,11 +1446,8 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
-				  struct drm_atomic_commit *state)
+void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
@@ -1472,11 +1464,8 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
-				       struct drm_atomic_commit *state)
+void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0b65e16c790d..5116f7bbbd02 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -33,5 +33,12 @@ void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display);
 void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
+void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
+void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
+void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
+				  struct drm_atomic_commit *state);
+enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
+					       const struct drm_display_info *info,
+					       const struct drm_display_mode *mode);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 763ae4239bd3..aa98f101b093 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -49,6 +49,43 @@ static void msm_dp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry
 	msm_dp_display_debugfs_init(dp, root, false);
 }
 
+static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
+					struct drm_atomic_commit *state)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	msm_dp_display_atomic_enable(dp, state);
+}
+
+static void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
+					 struct drm_atomic_commit *state)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	msm_dp_display_atomic_disable(dp);
+}
+
+static void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
+					      struct drm_atomic_commit *state)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	msm_dp_display_atomic_post_disable(dp);
+}
+
+static enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *drm_bridge,
+						     const struct drm_display_info *info,
+						     const struct drm_display_mode *mode)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	return msm_dp_display_mode_valid(dp, info, mode);
+}
+
 static const struct drm_bridge_funcs msm_dp_bridge_ops = {
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
 	.atomic_destroy_state   = drm_atomic_helper_bridge_destroy_state,
@@ -115,7 +152,7 @@ static void msm_edp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 		return;
 	}
 
-	msm_dp_bridge_atomic_enable(drm_bridge, state);
+	msm_dp_display_atomic_enable(dp, state);
 }
 
 static void msm_edp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 4bd788ea05d5..da412c788503 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -27,15 +27,6 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 					       struct drm_connector *connector);
-void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
-				 struct drm_atomic_commit *state);
-void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
-				  struct drm_atomic_commit *state);
-void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
-				       struct drm_atomic_commit *state);
-enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
-					  const struct drm_display_info *info,
-					  const struct drm_display_mode *mode);
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,

-- 
2.43.0

