Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BB97C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C45410E724;
	Mon, 31 Aug 2026 08:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cnKM+3BL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J/9Q/4eY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D5D10E728
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xsc51844183
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LMyEdhB9hAoWIOwYXdxQtMumg611UNkuzOON363+IMI=; b=cnKM+3BLbXlaLBTn
 0UbSbKSRGESQpg+DTlF0UvLMCYU7gp5OjefJFA1iIYLXKw1wjtad8uNwW9TQod2+
 1vMX6g9ZtwXQ+wqQekXx4UcUsCPmWoO54cyr5SM0TNXvjB973+CbmSIClXXVCvWT
 WbHiB9XXxjRPSARED258b/iiJjResexXciLIR+8PB9UExUKsjZheKomSRFzRagam
 WVtyJn5JR3vosCd0fhiXzlBSUgc55xmsYEGxXCyueu4eC4jcOzehrmOfHp3mbfQj
 HIn5GYAxvs+kXyrDpeGFde2aFK23VIjHqwq4ZENRGXc9LZ2v7hxusrxakTRyg0vJ
 iPOGdw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbrkgw6w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:18:59 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-930edb4362dso423404785a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164338; x=1788769138;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LMyEdhB9hAoWIOwYXdxQtMumg611UNkuzOON363+IMI=;
 b=J/9Q/4eYvASRnUwKRr0Z1zWG8ImQ55nF/6Doz/ZVZBcyOVMlAUJK1VVYCYwFQNDivU
 fs162iZlCGkDIdu8qEmvl2YIpLOT8P15OsOItagT7Txs3X1BDjBS8CDFPFjOcXYFwFvy
 HmL1q7Uslla1E6b4ITHR6sBwy6zUgQCpcanpXH3GnrmO+kBCVH0w5f00S8M/3DiFYEIa
 LGf8d2/j+yng98C0Xh0qcRe5QG+GDTx2Hc5tCm/RwWhMSi2gtze/BhOHkIC9ej3eYo+M
 aScYhqRmuwfWDscsxuypzK9wx7hir5YaeH8nxemt2e5z61F9hkAR5BZxubGak3UYTMnV
 sikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164338; x=1788769138;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LMyEdhB9hAoWIOwYXdxQtMumg611UNkuzOON363+IMI=;
 b=Q3LQg+cGJ85bsfQfkCsie1tm0hbPSUe3wlWjf6EoLCyzJ1viY/IuaZQj9XF7OMA7cB
 MmE3kXSY126pnjEcV5rvIEDB42zDWeQB7vIEhLHD8/ELkwus5hGtwlWofvtSdxpuKsjm
 9kV8xuh7kOSFVZJ2dW7RSiteMcNj7oeJ6dRamajiVIb6Re6+72UeujJ1apQ5GHfyeVw6
 vhXUGxX2YiChVtoacUJZgBxdhxP0Bvfe6nsxSgU8PmczDca9Zo6ivvps+cbO9BBndflC
 VAErqmxYkCpEFuN1Lt/tKtmbrHbEraZs9UQ3p8JNcL0Fn57NPAqTdc7mzdVi4IbddgMC
 QuSg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrYWMYRxYQMSSG9xo77azbmJ5UgMf00P14P1YaQN4Uge8PT0b8JfjMGAkiaA0MN6URJkqvY6wgwnYA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mf3qxaFm9eRg4GhVPKilUfGkp9Elr6hxV/+95uK42/YL9np8pC
 l0WREiH+zApBtw0PGmRr+zzirGirV1IAN2cTKvRG1eApvXJYp7UNrA86BXOaW/ylGnzLlWdtRfc
 GSR75NlK4Ib6br2CIrqsiV4D/P6CinCT6sdJV4dk8KM6V3jk7znXdCmLx249+MfUYx7EYlso=
X-Gm-Gg: AR+sD10oo7/FTQI32zImf9cKNsOtSdtOKY7HvHzt1hFl6/kqqE+uNUPmnGDHhq6y3Ra
 9c1ZNCSmCsAHm+yD7jGqrtqCDIEE6HngEOQ/c8B6Try0XpkTENfr7TS8cM9c9cMqPHCrwRR9o9K
 +q/h0Aq6l5/2SUuwbiX8oa54FVtOosxdvzC7MSbMpSrSyTWwYhyz9+635yd7SyT8/JVv5vg7iyY
 7qrfsq/3M97QAPolVb6Jrf5wKS6gA+MphL6WIghXcTOYxquW+MKlSG15FoT+GwySrG4eSGodKxQ
 klvc2EiVJck9YCUVe+A/Hu+zf2x6+8k9yAS0LNlhurJapgVTv1nWwuzFCfvCicviJZMpVcEDx2P
 JPbu+yz0g1n81Vpeasm+2VsgIGd9O+d2LPk7WOHRJ47EMOw2f8PrjKfNbL/Zg/0w=
X-Received: by 2002:a05:620a:a806:b0:939:773:bb2d with SMTP id
 af79cd13be357-939138df464mr2362140285a.31.1788164338095; 
 Mon, 31 Aug 2026 01:18:58 -0700 (PDT)
X-Received: by 2002:a05:620a:a806:b0:939:773:bb2d with SMTP id
 af79cd13be357-939138df464mr2362136185a.31.1788164337511; 
 Mon, 31 Aug 2026 01:18:57 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:18:57 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:32 +0800
Subject: [PATCH v6 15/29] drm/msm/dp: factor out _helper variants of bridge
 ops accepting a panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-15-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=8728;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=1N9xzYGqZoDTt/jPgVPDArOtr64Id99x27L296/XRaI=;
 b=6o4QOJEGHLdVKFONb9/sm1Dq0+aodwMvWEDe/v0b6jKNzBgmf1MFhvcUg/jvHj41L/Mur5xot
 XQ2SUAf4oKiB4HftA/sxCdlWdRHLIJBjKS8ZRzFTfnoQOTjaiBwv012
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX18B/IcD5spk7
 NbKar2g4aISm6EZu1nHvIBkYnidELbKd2zmn7JZF8UpXDUYfdWUuUBRxxVj9fFAW9gie+Ggpor6
 rb5KNu+2Zg4P4TMJcIfSjJDxNBFX7DdG6cSeim1cndWMLwFHfbpL1ZCjRmU7hxgMeYB9NzI5/Qu
 SXLkE+e4p3fzqBq5ixZQ7DeYGhULZ/FNTGozdYcHEa9hb/nZWDFiyc3yQA3IIR/lPmOBV1L6gEK
 avPM9K60idJm7/OdIGOq017Np9iN7Evqn/IwMguaQzaunTQTsdhk3v0CX4pM8C5Cfa59VdDviGi
 KsENriBSqPfv9FobyfVHh3Q8KqUS0lt+dMR0tfIWB4CcpvE72bfMoH8w9+kIuqw4pGrlXBGSgvG
 pLUru17792EzpNGRqt+1AQBaIyhVpdk2WOWfPbOe3JbkjKtNOb4OtpW+SEpwKls6hZikcLVq6lo
 q25WPRKzg8GRL1660Dw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXwA6owWy2ZK9x
 Lvrt2JTA64+uX1H91QKYLxI3n8dYnTUGSHYvwmONvz3BYJizR5iX23xWdcXf+MQL7wntsEQF6wF
 Y8plZUVciWcmtiPrdK3s3nCmSgfyEsA=
X-Proofpoint-ORIG-GUID: mcdTwy7ACFlZC8EtrMEDpGiLsoWxsNIu
X-Authority-Analysis: v=2.4 cv=Cr6PtH4D c=1 sm=1 tr=0 ts=6a9538f3 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mu3EkBhnCEQeHIwj90QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: mcdTwy7ACFlZC8EtrMEDpGiLsoWxsNIu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310070
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

The atomic bridge callbacks (set_mode / enable / disable /
post_disable) on dp_display currently hard-code dp->panel. For
DP MST every stream has its own msm_dp_panel that the MST
encoder owns, so the same enable/disable sequence needs to be
invokable against an arbitrary panel.

Introduce *_helper variants that take struct msm_dp_panel * and
reduce the existing atomic_* callbacks to thin wrappers that
pass dp->panel. No SST-path behaviour change.

Also drop the static qualifier from msm_dp_display_prepare_link()
and msm_dp_display_unprepare() and change them to take
struct msm_dp * so the upcoming MST encoder code can drive
link-level prepare/unprepare uniformly through the public API.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 100 +++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_display.h |  12 +++++
 2 files changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 9c5563dcb856..6103fa67f3ee 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -625,12 +625,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 	return 0;
 }
 
-static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
 	int rc = 0;
 	bool force_link_train = false;
 
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
 	drm_dbg_dp(dp->drm_dev, "sink_count=%d\n", dp->link->sink_count);
 
 	if (msm_dp_display->is_edp)
@@ -1448,69 +1450,98 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
-				      struct drm_atomic_commit *state)
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel)
 {
-	struct msm_dp_display_private *dp;
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
 
-	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
-
-	crtc = drm_atomic_get_new_crtc_for_encoder(state, msm_dp_display->bridge->encoder);
+	crtc = drm_atomic_get_new_crtc_for_encoder(state, drm_encoder);
 	if (!crtc)
-		return;
+		return 0;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	/*
-	 * The DPU encoder's .atomic_enable() reads the mode's YUV420 / wide bus
-	 * state and runs before the bridge's .atomic_enable(), so the mode must
-	 * be programmed here, in .atomic_pre_enable().
-	 */
-	msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, dp->panel);
+	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
-				  struct drm_atomic_commit *state)
+void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
+				      struct drm_atomic_commit *state)
 {
 	int rc = 0;
 	struct msm_dp_display_private *dp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	rc = msm_dp_display_prepare_link(dp);
+	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
+					    msm_dp_display->bridge->encoder, dp->panel);
 	if (rc) {
-		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
 	}
 
-	rc = msm_dp_display_enable(dp, dp->panel);
+	rc = msm_dp_display_prepare_link(msm_dp_display);
+	if (rc)
+		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+}
+
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
+{
+	int rc = 0;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
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
 
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
+				  struct drm_atomic_commit *state)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
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
+	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
+	msm_dp_ctrl_mst_timeslot_setup(dp->ctrl);
+	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
+}
+
 void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
-	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl);
-	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
+	msm_dp_display_disable_helper(dp, msm_dp_display->panel);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	if (msm_dp_display->active_stream_cnt) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
@@ -1530,11 +1561,9 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1545,7 +1574,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
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
index 7bd510cecb44..9ecd5025fe4a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -45,5 +45,17 @@ enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_mode *mode);
 int msm_dp_display_set_stream_info(struct msm_dp *msm_dp_display, struct msm_dp_panel *panel,
 				   u32 start_slot, u32 num_slots, u32 pbn);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel);
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
+					       struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
+				   struct drm_encoder *drm_encoder,
+				   struct msm_dp_panel *msm_dp_panel);
+int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
+void msm_dp_display_unprepare(struct msm_dp *dp);
 
 #endif /* _DP_DISPLAY_H_ */

-- 
2.43.0

