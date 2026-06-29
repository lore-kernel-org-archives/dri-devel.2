Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E39C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA8AF10E8C0;
	Mon, 29 Jun 2026 13:17:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LyBlQY6m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JAoz4t02";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E6210E8BF
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:35 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TASxZJ2641127
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=; b=LyBlQY6msL0lZ1RK
 L6o7wHkawQeHaKROTbl+Yn+ngRVn656oMbq5TruDWSCWV6+l6bJ2NCf59nKWGs2c
 xUql3CCqcAIOTuBtS0wiR987o0jHU08Db/1jIU2jrnJTfR/tw+ppBuIjTRjUx1Sy
 bsSAFbwudTmaXDnljFgjkVfgRHXXFUn02Bz9V/8nFJ08FaJ+bV2vlJdI8qROrf7L
 kn2IU6ar2M/YCOULHW/jeBf+ZhvOOktW5225nTvh3D8sXTWd1rq76UM4FFRzaJIo
 Gn381ogH1s5Slc/gIr7v3QeUeVbaUEn+D2oASOix9MQ6bbTLFX59ArR+RbKhMOtF
 s2aMJA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3n5s14p1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:17:34 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4aeea5c3so155057585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739054; x=1783343854;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=;
 b=JAoz4t02Lrjk8AKnT5r4HNoNlR98kXtJgxbIX38epE7XaNXn125RJSdMh3CYOEEhIl
 zztYLRKR85AEovcReWYED1mjMpBmPv5OD4uaprwHXLlkf7q+p0q/TTHsmNC9sJi7h6h+
 B4hfjhoYLj0xX1+aqZkVTp9LXaC3SfMO9sNsdLs+MI1UJMD0SOwTgifaxknvuRlM/xit
 0DJjSAyqeC7khSCEbcZzJzu/8ZuDChbJ67wOl0rlvtJh87wvAsyjoHIQ5VEUgqONQkGG
 KTzinghvKJIU4gWrXBn1k/rtkxANPVqEhow6eLT5DS8hizSdyYa94hTT4lfMi9/Nh7rl
 bnPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739054; x=1783343854;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=9svuRAUWKf4Cq1A1NpmrcreySoHCCAmo74eRJpf7Vus=;
 b=ViyftmxIz2J3TuPZaJmcNDAgJYzYFac+2ZfYW+V1FdsLCW+wTvq3MTRrGxlHS9TdqC
 BgA5ok62gca5CbhQ80kxp5wLLGSwh5/0jf7o4qPFdQUrlMVL1hPAZJLoYqPsdJ9tsnqv
 pulqLY6u4xWHFbWAunETBgI5baB+qQShQuya+bziYKRZE8ZhpTkYXYko+0W6waeQ3kWQ
 zMxyzAQJKid7bqNGDoKKruvoWMI+xNv5mOwUZD9VhD7UZWEma6g5ItxF6eQ47VInFc8K
 odoHulLKNmc13w39LVMKRlMmPD00wvMFzB9usuJ8Oa3GmsspUklr3MHQudanh+D57ZXB
 qlGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+M/TbBOX4torfsw/zAIU2adFCRNia8ux7ZvILgoGrsjMr/p8K4MDkLfpyGjYmLHqT4i7OjoyORODQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySMm0Y53gp9UhXGyfKfvYmxZFyPVd0SQrIRaRUwRm+YIvH+3MC
 4BYaT8h/2Mkhy2X9irBE0pqP+0AAbDE3vQdKBzTnWT5p7jTNj2b4kZS/PeCj2S/VeRTbakhjAIK
 5V0ETskCx5cYsiGu0HhO8OXweas1vC2RRXyUOI1F5cuv7ksXI62XMhlnvsdWh9Nv1KMhIRIY=
X-Gm-Gg: AfdE7ckj5EgAhxP3O3DIzAKhcRX1uwUl2DEI7QYk/BD5+ir64XFtrZKm39qDOSJqKl9
 KM/4Q1xlfM4+uTU/EDeCQy4LyuLZoCYib+Vfmm1gdB16igY1g3K9MXZnjYbtFASCLxptkJvBJNM
 S3Rztx1OexIoKt9JPqU5/iVi+6gSSDWqvIYCf9EnaSTmZLlqY/4SaP1gqfcCiWM6SGa6o0EHQpI
 KeVw6wGTYqSVyNEb3qjk5vWP43OevyiflPwWpu7/z3t3DZwqpH6nYKl5UobN9y/1HO/eU1yMdsO
 XwnrFaRcMYxnci9ZgCydclwVstmvTom0xKcnl3Zc54er0icATaa7Uk2AcFXrLy9NaBPGhScQ82V
 WiXjX5t3mtmfew8dfWEbhayu5fhjmkWsTdgv6V0wiOqpmlkW5KQthRUx6EmteoNpre5Wg9o4+Pg
 ==
X-Received: by 2002:ac8:5a48:0:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-51a51b2e6acmr333456501cf.23.1782739053613; 
 Mon, 29 Jun 2026 06:17:33 -0700 (PDT)
X-Received: by 2002:ac8:5a48:0:b0:516:ddfa:b6b9 with SMTP id
 d75a77b69052e-51a51b2e6acmr333455711cf.23.1782739052899; 
 Mon, 29 Jun 2026 06:17:32 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.17.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:17:32 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:30 +0800
Subject: [PATCH v5 12/25] drm/msm/dp: factor out _helper variants of bridge
 ops accepting a panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-12-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=8495;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=euWeALUbmMzdGUkiE/Q/aV5WnjeW32f7QOdos3tj6qM=;
 b=BgnU+v+B0PK6FU8r58V/Aat/2Puy+/V8rnh+1cIZgkTV28bTLh7ENsEa/uV7sWMTi6QEnV9bs
 Hyzxcp7zR5oC5f/1fdRLxCbGFoZvOAiVGLIQ/CGf9M05SEEG+MZOE2Q
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX+wKLXB+6OszX
 4NYNBQHsIb4sLMhNoN3S2aF00XYZEsRkIfomEFsznIOXCaVkM3gKxjacgCzbwO7tFInfBGSh+pH
 WDw4KMZTSFElnqACWk6xHuKWTD56V7Y=
X-Proofpoint-ORIG-GUID: E3-S0ce3s0KDCTlFnRmxs__8JcgBCE-D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX8AIE/Wwyt3Wk
 myLIjL0iBGNqvT1nPur9lbNIO81/tlr6jxa2RyqAs30R8yO0UIxoR55NimDtTc8egpdspUGk2SC
 XofBmST5jxhaeP0VdIzoNeUe8sJtxLpN54LHLn4Gq8nsaTfvcmjVhuXUUczXbNo7VgJvFsOAZnq
 3w3ZIF+mBUtwj/zNMq02JGULV0ytC/5V3CHGnBOihfgL5CloszGcPFICN0PQpEDMHhUhLni8Zo0
 SxMay4BR9M7KQ6GyBTYBW3pp/+XLB2yzmqx7YcoYd4gv+TLmjjzVeXiDBtGzvGL+YDm0iKXtwUl
 Eu7Wbn+8OgOc6W12DiOr2tTToyvyonjzv7y0/dMJwYHiTbdC3PVWzVrVwsRepjXsoPMtQBls7wi
 +453qpUc5ErzimSiKpCOVntFh627fjB4HkvWpOOVSe410KiVgyEPueWo6m7meKyPJ6lmqHiPzij
 h+aD6pa1Q4Odl30nq0A==
X-Authority-Analysis: v=2.4 cv=NZzWEWD4 c=1 sm=1 tr=0 ts=6a42706e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=mu3EkBhnCEQeHIwj90QA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: E3-S0ce3s0KDCTlFnRmxs__8JcgBCE-D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0
 clxscore=1015 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606290109
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
---
 drivers/gpu/drm/msm/dp/dp_display.c | 93 +++++++++++++++++++++++++++----------
 drivers/gpu/drm/msm/dp/dp_display.h | 12 +++++
 2 files changed, 80 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 1680a67284a7..0e432f35cc51 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -628,12 +628,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
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
@@ -1457,69 +1459,101 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
-void msm_dp_display_atomic_prepare(struct msm_dp *msm_dp_display,
-				   struct drm_atomic_commit *state)
+int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
+				   struct drm_atomic_commit *state,
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
+				   struct drm_atomic_commit *state)
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
 
-	rc = msm_dp_display_prepare_link(dp);
+	rc = msm_dp_display_prepare_link(msm_dp_display);
 	if (rc)
 		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
 }
 
-void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *dp;
 	int rc = 0;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0);
+	msm_dp_display_set_stream_info(msm_dp_display, msm_dp_panel, 0, 0, 0);
 
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
 
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_set_stream_info(msm_dp_display, dp->panel, 0, 0, 0);
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
+	msm_dp_ctrl_mst_stream_channel_slot_setup(dp->ctrl);
+	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
+}
+
 void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 
-	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
-	msm_dp_ctrl_mst_stream_channel_slot_setup(msm_dp_display->ctrl);
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
 
 	/* dongle is still connected but sinks are disconnected */
 	if (dp->link->sink_count == 0)
@@ -1534,11 +1568,9 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1549,7 +1581,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
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
index 45e2cc2d6add..55ffa22bb233 100644
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

