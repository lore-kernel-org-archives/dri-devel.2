Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D787CCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BB9A10EFF5;
	Thu, 28 May 2026 10:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="O8vGy7DD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O+fiQ4Q6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0B47C10EFFC
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:40 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vkad298214
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PrpKel4Av768jUzNR25shjZmFALdbmxo17UJsOuCq8E=; b=O8vGy7DDtjjMieDd
 NUrh0YMhsJI9AIVKj6WTpHlCDtej65ALrxfMZR5F3Xq9hoJYOaN00FPumOQvH5yV
 an89aFXIxU/MiDcc9cgfx7dXYa+IGVKnjLhlv0y6yAnx7xXgzFDgWNq4iEc92Qy8
 dN6SS5lx5w0Semrbl6mEEhVIpeOxl3HS5AXWpwDTsWimCMxxvZMm3ezW5CZqCX6D
 +SimcPB+N63GZbcARyUg/HaU+b4KHmbGa4v7ARyfppkTwZo6f883/E5r+n4z0fon
 8JRx9qiwKFOpD/eGOOleopIfo3/e1a8A2jI3Q7asCNT24qDUzQysP880z+MEsjQ3
 /rJVvQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7yajd5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:41:40 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-914d0312a2eso480069885a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964899; x=1780569699;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PrpKel4Av768jUzNR25shjZmFALdbmxo17UJsOuCq8E=;
 b=O+fiQ4Q6/Dbe2elkITfHmShs7Tbvz8huTHRzsdBO0Ojehucc/04mLg2jePlCp0frtI
 nP1Hz5A4MvSS6dQd8tobf9Yq0pj7WCGkzIaHPubeemwmEd2D2La6hjH8w7v8wvBgDWvw
 mBcuaJeFH+CY7KyYl00nxaH7BO7BslEIXSy5NrCLGIivSzZqHfqdqHOe9yJI5YVppS9Y
 JDiEYRyxWohybr7W3tqLNa8sEHRbQJIc1spdmB4CtKqMFBbGuKE3OBdONgu0mZit02xT
 ypxiNhgEncxWSISsMZawPO/nDZrAZONMki+mDzlXut+gHk2w/MYE6pusReotup7gKrg8
 3OHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964899; x=1780569699;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PrpKel4Av768jUzNR25shjZmFALdbmxo17UJsOuCq8E=;
 b=mrRCScRML6/7rfZeDXFtQJ1s7uv22fao1GAgBJGxIXW+3t5MK6zxwfykbDPAAlJ7dg
 W2S8w55xyI5KcHChuSVlw4jzo91hch4e/G1DxrKPEGr8A9OCw3QgHkSbiUziYwgBoCXs
 yr/nU3y1WHTZSlUein7FjFJ/AtVCzNu7jrwI48gvN7p2TsLuV1k9btoaE0JJ7IlkZeGK
 U53OQggzvUhbkaWCa1GcDSvNq0oC9AVPvlTsss5Bs9m0TmENbUxBO1aLaKb0EfKRjopz
 L+cPrBHmzVlq6OOU+Do97UIy8x5riukuEHObR2p0BPy+MgZbETUnjNNo8jH/38wufY5F
 IoFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hVHTcLmiyqM9iD3VGjBPiJyJnSWjtO6mHKewossjMFJrxjyDQW43Vt5jKRSYHl3lQTuGInvuAH9g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAd1rWAUi/adlXT0JySLqioifKW0pyNChaG7oXn5UpzNSNpCR6
 m5LAIYx9qPaO9nNynFBvi9X69EkY1618ihMcxhTd/mQV73epI2YuksSDS11jjt+wan0jxODMiOH
 30r57U1frHrp5kSlDbV45DYR6rVf5CLhraeHl+x1HwZKV29g/4lJt94DAnDMiTwmXr9zqi3c=
X-Gm-Gg: Acq92OE2amCO4F8EmIT4LUhVNok8UOtOhPCiTDX2WdU56ngXl/WSzfCcZsHul8Tz1Ir
 z6wJAXbH9YcoG4lyRG2PPGEsQo9Penvlxdye+7aJSqiPQ67nJcxwEmFRgQfGbGzEHAwtapKoAr0
 TzfnrTvwEYUvhohu0erP38STHJDn67MOnf5tSOXRvZYG4WQKN26gHXsft4H/a1TbXrIcj3CUBFb
 dma6HpyiNCHBMaqXKzyd7o70nVUbUZamnI4r9kYwAiEJJnWkZ8FwzUL2NrYW8l5wH134yw80fUG
 54lSy/+uvS5c2uP3rT864JlrHBC9cnT/hhX9nRBbYQoBlP0wY2I7k0mOB0EGOORvnoL+sdwJYYp
 +Ua25CSS7mZpJqVA8z/V9wySt4r0FNUAmZnxUAJ/1iQ2BTbYgWSbtonVC3EVbkkWTutN+txoT/2
 64u5o6vX9LnWgv9OnUDQ==
X-Received: by 2002:a05:620a:608a:b0:914:c032:5870 with SMTP id
 af79cd13be357-914c0325e60mr3401993185a.38.1779964899427; 
 Thu, 28 May 2026 03:41:39 -0700 (PDT)
X-Received: by 2002:a05:620a:608a:b0:914:c032:5870 with SMTP id
 af79cd13be357-914c0325e60mr3401990285a.38.1779964898925; 
 Thu, 28 May 2026 03:41:38 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:41:38 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:34 +0800
Subject: [PATCH v5 13/15] drm/msm/dp: make bridge helpers use dp_display to
 allow re-use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-13-a9221c1f1f3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=8509;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=js7Ds0kDP3MA2PA3qJwTal/QoxqVBRyKdoKt/vuLT7c=;
 b=qPbwZc4gkkLq2J/drxcqZeHRgvRIK7bXezYuhoXiVSce0PUFJVrh+/KiZ4BZfdHP6vL/6so12
 OWCx52CHBhTCercqMZWXZjeg7E912Xd0582a/kYZIU/yBgig2ecIPrk
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: P8tOKQsw0u0cpNE2CCz1N9wYR23421K_
X-Proofpoint-ORIG-GUID: P8tOKQsw0u0cpNE2CCz1N9wYR23421K_
X-Authority-Analysis: v=2.4 cv=CaE4Irrl c=1 sm=1 tr=0 ts=6a181be4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LmD7BKvqrCyCckpIDn8A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwOCBTYWx0ZWRfX5eocdm5Opqrh
 /JbxtxmIPJSRmq2bECpm94xXiTu4GngYH+YMkvWch/k+g0Vx3n4tm07z9w7qERKD/gg3xFl5RKO
 tk03MJ5ojFq3WdRDtotp6M6ItacpyXKXj981S2Pdxz1+DBrPOY9gAheUl9ipyhzcPIW6x0wEuB4
 claVEaVk8RFDbHbsO/FoOMjapxL5VLpy1oeBWHngxh799y3VUbGUgdP4Jt/ABb5i67lvgeboH81
 izRLAfavEXBp+eahnTtQZjpr16onvTDACbaXuAlgR1PGtUW5XrPgjhQpCxtYZU+SYtzfGUND3Xw
 VJ8K0rau2iux/lQqG7dSB0fNoiUsYmPJ433QohOmN6AfB3oiKAqPwjuoIRdmAReE61XxjhIjOd8
 7Y9PC6q+Vi4UofeMQiTvIQk85FV6Mh9FFBOqF1Llmeb1+peRirx+jcGs9EMn6mjCfqNM+qDGTDF
 4J25NkoKKD1pmpa/n0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280108
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
index 63e5b191f95c..2d5ef087648c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -738,24 +738,21 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
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
@@ -1406,11 +1403,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
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
@@ -1419,7 +1414,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	crtc = drm_atomic_get_new_crtc_for_encoder(state,
-						   drm_bridge->encoder);
+						   msm_dp_display->bridge->encoder);
 	if (!crtc)
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -1449,11 +1444,8 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
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
@@ -1470,11 +1462,8 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
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
index 6ac5bac903d9..6b8923d9dff4 100644
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

