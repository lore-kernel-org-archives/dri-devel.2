Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738F4E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6CEC10E909;
	Fri, 10 Apr 2026 09:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hXYEG5vi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e5V/+fdF";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBCB510E909
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:49 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A6qQxG1730291
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TK62w54po4emc6XqNptEL14f3cpkiTkpHLzf3k/BVKA=; b=hXYEG5vi27ypTAlg
 +u5XjLfSH3qual8rVKiK8xxqGiyHdbM5qJVSq7hUQEdwCYEPuQAN8ZCWRrOVt3bM
 xxvNim2PmiJvGeT7FQ74QssWo9MF4wFLSPgiYEMjwKGD5yz4QNW+ugdfJ0owNK3Z
 ghwix0Nl5XjBW14zT+ICzb1Kfj0IQIhkqXZEXE6NgijO2mGQ+7y9t/xeCRFL1tHQ
 P8my6NwZCxwQObeo6ilAdw/vxutP3pL6XWMBenKeYpKyhP37Hk0Jpxi96AOKCwI5
 6C9d2+ZY8+lnIWIqb6fZQnpco+oMj2KYS6Tk+S4CimDRaqI6SksNDaKJ8MNzy1Fb
 MZwW+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckxkn34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:49 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8d5010ea6b5so353723185a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813688; x=1776418488;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TK62w54po4emc6XqNptEL14f3cpkiTkpHLzf3k/BVKA=;
 b=e5V/+fdFYw4Dow8kRNltxDEov1oJEesUvrwULbkcrEQQEmVJQLmwQmLu1a09rEt063
 Zr6Ftkt+HJPclzbPB3RHKfT/DL6+rBNf8YqD7uXmFBUWD6texiKVqAsM0nf4vEKYRg+s
 1yq9imZLtBtdM2cLyCfHciNV+crqEHUMTXgjDtmJGWiydoeJst0rOT8m315VCgz40T+/
 aofRuQFcc8/FWIb6eUhg5AMJjliy3jHoNHwdrHva1zZjJoUx2fag2GCTLWhlqfaouqH8
 2SZr+mQZbVfwePUcb/bXYTawZoOKO4Cx0P6kj4uSJi7z5I9nrzkQUuabvhbxaBctpuju
 hlKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813688; x=1776418488;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TK62w54po4emc6XqNptEL14f3cpkiTkpHLzf3k/BVKA=;
 b=TxZEGlk3nDQoPPQQokX0OV8XFCVUcaYHO4ij0KvDkEuY6sZm1LRAQQDK5qjoekKIho
 zOoQwbBYnxeOCFnLHOkEC/SyooO3Z4O7tFZecq6T3giqIM2A5jG+XAndpdOq6P5jMI/3
 7C+AyZNip2/lNAgJ29ium2e+emMdXn7bO1F60pxvmnXRdqSW/qEpsCIlvszlPV2Hw1aO
 pQYwym/vF61xZsSjO65/r+eKvG0Uy7Ui615E4XaBAU9k69W5zsdrWR7iNGQMocI2Dkdp
 qf0FVQQWpn3f2YM4J540dPxGe/Sd359a0T1r/etADsl4zvjTMxqHbp7qEMpwukhlyhaS
 nr5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5AznDMUiJKvVotvy6QoPD/8ZCTzdVPKdTdIxsI60nCuz+6+SMkqDgHQsC3nK34sSh6IuQFs+tBaQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxO2jqUbd58+8plXjPOEakWci4p0TfCKCSq4VfH+evs2vxnqWVZ
 JeihbhnsWlgOfA/1IP7pSr/KFw+wH5Up27w+U7j91Cz5mUn6SSIsOYVN9eCFsIdu+POXgigy+dS
 D7dUh80RZoEkjHA1PkK7HkxZZaC0pKraam9bMz0rhPLOzPA5WN3z4Zf5LAr3xLGmXUdml2pY=
X-Gm-Gg: AeBDiesJqge56vVgVcJMZ2SR7ujpnYGUnDmx5KFuIwkbvljn0DSn1cd8qB+kEhp8seX
 sg/+Oxi5xT/u/E6N5w08DeX0mc+/vxPqnlTMcEYGp4htgSh/KFIgNZTH73U0rGVXDjAMivW52PE
 eMsBiuh+cCbQWrXllUcol1miDTEYOWeeIJkjYqpXT0/rmwxffGSJev3WN5aQpAJkkuvMBF5F4vB
 xX0i2+lEP1vdfVSQbmXw8FlG7LiEbpSTi7qcOZuS5tvSZXk8gFX4BSynHzxojJ5/kj0S0x5Det0
 d/c++ws9UEAsG3Grav0kLrbAEbihldtkY+8Qbj/HxAaLKHZ95KsBKhWo78yT6aqi/4eNCNgf4aV
 TqBGGGL39UMEjMejHOZUEBPx6+N8HEBt4Az5eTGsOyJUbaH1hO7TwjDTLDY0J4+cvSUQ5ZZSJ8m
 P+P8yrTn4=
X-Received: by 2002:a05:620a:2586:b0:8cd:97de:bb52 with SMTP id
 af79cd13be357-8ddcd6fd7bamr292529885a.22.1775813688239; 
 Fri, 10 Apr 2026 02:34:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2586:b0:8cd:97de:bb52 with SMTP id
 af79cd13be357-8ddcd6fd7bamr292525085a.22.1775813687691; 
 Fri, 10 Apr 2026 02:34:47 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:47 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:46 +0800
Subject: [PATCH v4 11/39] drm/msm/dp: make bridge helpers use dp_display to
 allow re-use
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-11-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=8431;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=jzeTvQi7vuc6cxW8UWUPZDTFedkNgRaHOSc8OQfHLhw=;
 b=aOI7bMWddL63zn1zjtqswK/6/E+CznKH+N2JZ04tDdLJgvwf1b3DcGgEqsNpoXW6QoJNI1LwP
 FQWP59qg7xPDfbPZdsWAIDvnAKqaP+tO4CQOY8DyYife9nWC9wrRWOj
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: IwUEy06x91TtwVMaugewKqZKD87OITC2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX7vPjvGgAKRUY
 HyJizLelKsy/IM/5YyMfTxVGetbGgPxKPh/Dhv4t/6vqurtu5X+hOkO4OFGlAH+/nUP1GZEFdup
 RDoYX3ZNs/5s+gaX7lxhHGR+8dlwxBaCv/poLZS+6ovAfhHdPhS1UqEqJO2zu6d19wspI1AXntT
 fZqq5x7Y5d1L3rVzinVSIWw5SDehZrwbNkTrgLEtSwL2kceUVoNVpcx3jfnDBbCz+3CYpl14tYI
 4zd6JKUNPaPthhljzHC7q3Q61rqOqcIoiIyIuLhs0RLAiZyL4H+CZ9p4hi8gdaGD5/iQWmJ9TST
 N8OAKj5Tw2/ed2BsZjtXcD4kQqN0cK96L3BZ1l+lfpIaoaj9X4881CtIq5Hr5lNOw2S8dHtBaxF
 M9Xdpk8R/xHXmxke9C++1j1y7S78TTxttO6EARQ8kSphwKp/G6BWaWmEbQe+tkVrtyzlHu9tYyc
 ZQ63Hg26Ysh7sQ8BNAw==
X-Authority-Analysis: v=2.4 cv=OMcXGyaB c=1 sm=1 tr=0 ts=69d8c439 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=LmD7BKvqrCyCckpIDn8A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: IwUEy06x91TtwVMaugewKqZKD87OITC2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 impostorscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 malwarescore=0
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

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

dp_bridge helpers take drm_bridge as an input and extract the
dp_display object to be used in the dp_display module. Rather than
doing it in a roundabout way, directly pass the dp_display object
to these helpers so that the MST bridge can also re-use the same
helpers.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 29 +++++++++------------------
 drivers/gpu/drm/msm/dp/dp_display.h |  7 +++++++
 drivers/gpu/drm/msm/dp/dp_drm.c     | 39 ++++++++++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_drm.h     |  9 ---------
 4 files changed, 54 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 31e229ac2393..c7dc861301de 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -752,24 +752,21 @@ static int msm_dp_display_disable(struct msm_dp_display_private *dp)
 
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
@@ -1420,11 +1417,9 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
-				 struct drm_atomic_state *state)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
+				  struct drm_atomic_state *state)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 	int rc = 0;
@@ -1433,7 +1428,7 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	crtc = drm_atomic_get_new_crtc_for_encoder(state,
-						   drm_bridge->encoder);
+						   msm_dp_display->bridge->encoder);
 	if (!crtc)
 		return;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
@@ -1463,11 +1458,8 @@ void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 	drm_dbg_dp(msm_dp_display->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
-				  struct drm_atomic_state *state)
+void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
@@ -1484,11 +1476,8 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
-				       struct drm_atomic_state *state)
+void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 {
-	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(drm_bridge);
-	struct msm_dp *dp = msm_dp_bridge->msm_dp_display;
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0b65e16c790d..1a697fb305a7 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -33,5 +33,12 @@ void msm_dp_display_signal_audio_start(struct msm_dp *msm_dp_display);
 void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display);
 void msm_dp_display_set_psr(struct msm_dp *dp, bool enter);
 void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *dentry, bool is_edp);
+void msm_dp_display_atomic_post_disable(struct msm_dp *dp_display);
+void msm_dp_display_atomic_disable(struct msm_dp *dp_display);
+void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
+				  struct drm_atomic_state *state);
+enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
+					       const struct drm_display_info *info,
+					       const struct drm_display_mode *mode);
 
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index af3d3e3a2d84..cb54d7e71f8e 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -49,6 +49,43 @@ static void msm_dp_bridge_debugfs_init(struct drm_bridge *bridge, struct dentry
 	msm_dp_display_debugfs_init(dp, root, false);
 }
 
+static void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
+					struct drm_atomic_state *state)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	msm_dp_display_atomic_enable(dp, state);
+}
+
+static void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
+					 struct drm_atomic_state *state)
+{
+	struct msm_dp_bridge *dp_bridge = to_dp_bridge(drm_bridge);
+	struct msm_dp *dp = dp_bridge->msm_dp_display;
+
+	msm_dp_display_atomic_disable(dp);
+}
+
+static void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
+					      struct drm_atomic_state *state)
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
index 6d4cbb9f3918..da412c788503 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -27,15 +27,6 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 					       struct drm_connector *connector);
-void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
-				 struct drm_atomic_state *state);
-void msm_dp_bridge_atomic_disable(struct drm_bridge *drm_bridge,
-				  struct drm_atomic_state *state);
-void msm_dp_bridge_atomic_post_disable(struct drm_bridge *drm_bridge,
-				       struct drm_atomic_state *state);
-enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
-					  const struct drm_display_info *info,
-					  const struct drm_display_mode *mode);
 void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,

-- 
2.43.0

