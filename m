Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8FF60A2637
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Y8q3MWo7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ZgDJKJUT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9656D10E0CD;
	Tue, 10 Nov 2026 04:55:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0B610E0CD
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:22 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A6I72275507
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=; b=Y8q3MWo7tBiBk8Kf
 sOboc8A13d5+0b0QNICn/y78XiEEhSEbBZBdExUeIAe0WtWbiLE/fArgmrURZ0s+
 ZUps06G8PTfxd2Qun3s4O5jESJF5zc/1VDWRQCeaUmB6NssvoAuYdsktKHXgX/GM
 KzB8zmTVrWkTb1bOJUbujWdPWCsJIFiztolV0hcAkhUPuZ1MEnvx+0RiOn+BSh0m
 Y3S1S1zRzkYO2dnE8XLq+ED7bPfrrEzlz78Cn7KlDEi6i0v7yNjcTgi6aY2ksIJl
 rySNXqjdrqWwG38mMs5z6BnbojNoXpuGHkbTaUB9EgZPdrLL8TbIcD1nq+4Cv4EE
 7Zim1w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hudf5bgwx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:55:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so351468485a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286521; x=1794891321;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=;
 b=ZgDJKJUTWBQghkgW/0ahvtY5h37txNYGKoFH1BJN5ujsWefDzKt8sp0CcEYFXyDimZ
 4QKkPffcI4rMpFrxAvmJLtLh7ZuUKp2UiYGlznjQHIaqciEltINPeL0CM+5leJMgaZk9
 6W2y2Q3Jh82jUHmREIopWnMMhK53LmlYGBHvTfpbEw6O0+q4so57BxbC/RMxGaLgrjRg
 JsxNrT6X6ny6igCo/va1FXI6AVh/hhuEkr96V/V138lfNVwujIloUTIFU/dxC3cbnXzd
 qjAx0tikUBQuLm5CXD0XyUBBwMBuwD8oOdqNGK3M6UKqiYiHGTgNF6VkzUF8ZTc8YDb4
 JdGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286521; x=1794891321;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XOHVnaPKkMDqdaS1cO+52v94uYEDVhjrO809duKaYuA=;
 b=YekpQH1s3BKEuZR2QZ9U7nZjAsxyXXlnVLTpBP0PFBwFvfUkow+xw6QIB6WZTS+sgH
 x+Cy4kwN7VBmHGIv+hNFWOGFKXVsEQlQVsbnEsdV4aDFV3LQLBTFIaKbHoSOjmW6dBOk
 efgJM85vdJ8/WEDxVayry8oBlOC6Jj96dGyB+BU0dcufhYESDox32x9QXz3cWeVTOP2k
 Xa7IDi8+gM0SZEB6DRYcp9eWT6lNjS+aNFURtEKv7YmSzjD4ZNb5y11b2iGq+ylaYdxX
 9rlftW3gmf6ObJQ7JVZ3behRR6MC7G4GNqD85FX4FW4hI53b+0Jh05QCVWrO267COUaM
 mtjQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHnDPvs/B3ZtWfcihnKzROlgCyZJe8kQ1YPZvuowv4E//gTvtBjgYoZJYuGHTXlNkNiw5a6HQ5desg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8uzq3h3pdvQeK3fX97+0/vsc225lOXQ7rG7ZB6q5imeDUFOSkK
 jbb+g4QWWW955O4QE4i1yfzJGbxZjdBEDaNSGjwoY1whCAvnTG6rtT5fyVOQsdYv96ZxG+7oUAj
 dV6sr26G2brTohhjiMpGWJUff5p076/G/ZEKMcr9klpo+Da7iBa79lDtfaADWx6ctNKylKkvzRu
 w30/FMvg==
X-Gm-Gg: AYBFou0mDAjCfvNdYrY3fK8oYYK7L92JOQIY0JxlE2QlhFajbnX7OPIhqjJUkaoILZj
 o5zqQ+19ptDtkzn4OP2ChuIM1KKlK/ncRKQZ2R8tTRWZDqURp/ctAlhFIT7G8URxqm2ki715aQB
 lxBInjdYWKSqZDBeY005kV12tpO/96x9kPp1fFel/6AHD3l3iYGP7x8/UhxZk1uCCXEH71LetpN
 9A6G/XHfssqNXnAvKjT8Rnxn0gywyTQ4N7bfRzrMGZRMLTBauGlJTv6dL92G+VQE7DbJtrPjNII
 /TRMsVNZxzIk1hO+hc4lsG7MpK36b46w2Y6kcPAeO0VLC50CaIuD+wyAVSWYMfT1R7FTDU1tv66
 /bT7Th4tWKsj8jAst7pGtdPJ0nZnlIFKGqpy1FdahZvCqv1iTfimWdP3Frr87FmK9RRVwmLc46I
 7LwzCMxdYimRYiiS/dY9EGtn/F5KgR4quUfOCW
X-Received: by 2002:a05:620a:1a14:b0:939:b099:d52f with SMTP id
 af79cd13be357-9479f28fbf0mr264564385a.20.1794286520838; 
 Mon, 09 Nov 2026 20:55:20 -0800 (PST)
X-Received: by 2002:a05:620a:1a14:b0:939:b099:d52f with SMTP id
 af79cd13be357-9479f28fbf0mr264561785a.20.1794286520219; 
 Mon, 09 Nov 2026 20:55:20 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.55.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:55:19 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:30 +0800
Subject: [PATCH v8 09/29] drm/msm/dp: factor out _helper variants of bridge
 ops accepting a panel
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-9-d040fb33db5f@oss.qualcomm.com>
References: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
In-Reply-To: <20261110-msm-dp-mst-v8-0-d040fb33db5f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=9551;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zite9a3phlMLvlDTVMJoeGqeBbIHHb3A2QWnia5l2xs=;
 b=6d3l0gTDgiQtD9zo5/IS1hsSkjmtUV0ktj7mzbOOTglRGAIn+iS4FHpvc4hCPgZq3T5wmlru/
 je/6pMKNw99CTVXYN3WgOiR1vOrbUwj1EYuYTJgAUdpKISM9rWiDcfo
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: e2mYHRejna0DbphwaG8Gt5hizgQxrpRA
X-Proofpoint-GUID: e2mYHRejna0DbphwaG8Gt5hizgQxrpRA
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX8kaPwARNQUEP
 x1oiKrbWQXhy9ejYYN4KGsPyaoR6jdErppluU4YmgXcIvOOIrfrgZzRdcj96roO9r7tB+BVA5xB
 KFya+bEntEwAQ/5YZ7LMDFd04HOAKmQ=
X-Authority-Analysis: v=2.4 cv=bar+w+PB c=1 sm=1 tr=0 ts=6af2a3b9 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=10mNmtCk2Ocqn4x3vjYA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfXy0GS4GSgQEgk
 mxo2Eh1eRIONFl2w5Rt1ytRfxRTOHE4LU+b7foEkddjkHxYbvLDONr7btEjj3GGW67F6JhQhJ+k
 uxsEabJvtmbvoBGmMsxUlFH5vLGBMlpdSboCwKnB0V6+4ARdunTPVwQ2Jkq+MSkLeibzZsr+3t0
 1c6peru/zkAUQnDNRmaPWIXZ47UFBwVQTjz735l0iroLa9ih02P7NgpEw8bx83U8gnpqZrZs4u0
 JdWCb0PMv69FXCCexlzhMdQLvXJcXyMP9CT0bVgruXbmLZdPXJ7nEEYczLR3/+3zDPnj7mPl+aS
 edgYglOd9PxRnkihGnnaDUQVBtQi1GP5vfyPteTFKRqZFO5P/gaxV/hxka2nPaOOaskEGrFO+Yq
 cuWNtxh9YmyswRxCTFN12c6Lmt3Ofyp/ZfBZ9oRsFiCDjF3IbNh6Mgwi0UR66LwoXudFE0VPsp/
 8EpYyuV4+PyVD7u1n9g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 spamscore=0 clxscore=1015 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100019
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
 drivers/gpu/drm/msm/dp/dp_display.c | 111 +++++++++++++++++++++++++-----------
 drivers/gpu/drm/msm/dp/dp_display.h |  14 +++++
 2 files changed, 91 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 169990c10b36..471085744c7c 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -632,12 +632,14 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
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
@@ -1457,60 +1459,81 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
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
 
-	rc = msm_dp_display_enable(dp, dp->panel, NULL);
+	rc = msm_dp_display_prepare_link(msm_dp_display);
+	if (rc)
+		DRM_ERROR("DP display prepare failed, rc=%d\n", rc);
+}
+
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel,
+				  const struct msm_dp_mst_slot_info *slots)
+{
+	int rc = 0;
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	rc = msm_dp_display_enable(dp, msm_dp_panel, slots);
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
 
-void msm_dp_display_atomic_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_enable(struct msm_dp *msm_dp_display,
+				  struct drm_atomic_commit *state)
 {
-	struct msm_dp_display_private *msm_dp_display;
+	struct msm_dp_display_private *dp;
 
-	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_enable_helper(msm_dp_display, dp->panel, NULL);
+}
+
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_mst_slot_info *slots)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	/*
 	 * If .atomic_enable() bailed out - link training failure is the common
@@ -1524,17 +1547,28 @@ void msm_dp_display_atomic_disable(struct msm_dp *dp)
 	 * TrustZone-level SOCCP/ADSP force-stop and a silent SoC reset.
 	 * There is nothing to push idle, so leave it alone.
 	 */
-	if (!dp->active_stream_mask)
+	if (!(msm_dp_display->active_stream_mask & BIT(msm_dp_panel->stream_id)))
 		return;
 
-	msm_dp_ctrl_push_vcpf(msm_dp_display->ctrl, msm_dp_display->panel);
-	msm_dp_ctrl_mst_timeslot_setup(msm_dp_display->ctrl, NULL);
-	msm_dp_ctrl_mst_send_act(msm_dp_display->ctrl, msm_dp_display->panel);
+	msm_dp_ctrl_push_vcpf(dp->ctrl, msm_dp_panel);
+	msm_dp_ctrl_mst_timeslot_setup(dp->ctrl, slots);
+	msm_dp_ctrl_mst_send_act(dp->ctrl, msm_dp_panel);
 }
 
-static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
+void msm_dp_display_atomic_disable(struct msm_dp *dp)
 {
-	struct msm_dp *msm_dp_display = &dp->msm_dp_display;
+	struct msm_dp_display_private *msm_dp_display;
+
+	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
+
+	msm_dp_display_disable_helper(dp, msm_dp_display->panel, NULL);
+}
+
+void msm_dp_display_unprepare(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	if (msm_dp_display->active_stream_mask) {
 		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
@@ -1554,11 +1588,9 @@ static void msm_dp_display_unprepare(struct msm_dp_display_private *dp)
 		msm_dp_display_host_phy_exit(dp);
 
 	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
-
-	drm_dbg_dp(dp->drm_dev, "type=%d Done\n", msm_dp_display->connector_type);
 }
 
-void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
+void msm_dp_display_atomic_post_disable_helper(struct msm_dp *dp, struct msm_dp_panel *msm_dp_panel)
 {
 	struct msm_dp_display_private *msm_dp_display;
 
@@ -1569,7 +1601,18 @@ void msm_dp_display_atomic_post_disable(struct msm_dp *dp)
 
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
index b163954deafc..f6ebb3d409cf 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -43,5 +43,19 @@ void msm_dp_display_atomic_enable(struct msm_dp *dp_display,
 enum drm_mode_status msm_dp_display_mode_valid(struct msm_dp *dp,
 					       const struct drm_display_info *info,
 					       const struct drm_display_mode *mode);
+void msm_dp_display_enable_helper(struct msm_dp *msm_dp_display,
+				  struct msm_dp_panel *msm_dp_panel,
+				  const struct msm_dp_mst_slot_info *slots);
+void msm_dp_display_disable_helper(struct msm_dp *msm_dp_display,
+				   struct msm_dp_panel *msm_dp_panel,
+				   const struct msm_dp_mst_slot_info *slots);
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

