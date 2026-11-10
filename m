Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090FF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ogXxMzjk;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=KzBWThPz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 358AF10ED8D;
	Tue, 10 Nov 2026 04:57:03 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE8C10EDC8
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:50 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AA4A2ta1207398
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 d+WYdt08Ufsm3x+Oe0Q0W8lqpRG0RHBqFyGwH/romlI=; b=ogXxMzjkUToWBYOF
 /DrV0VFSkGW6AMne8H+iaRpoagyvj1RY4N4OnsR5sisjxFOZnNMka/oFI2VeVKHt
 2IJJoc3XR2RsHix04GpPjpC+RqUl97rQFHg2gDrg6i9Y+oBEnrztGyRxVhSOrJDF
 Tns4EWFgKAxxK74K3MEpdzQMKQmnGSCm46U2EmO/zWlv37CixswUcHhzmXMnRHfZ
 aQI3YFThIMg8tfU+sQUk6j0MthuF4Fx5L+C6WKs+KIXwZUkqBJS+NVbByQbpZOYx
 +OfhHTla0k0opUFFeD6E0xNWtVThwX6Wp72R0aXciDFf81wX2BnZxSct2Wf9xaus
 P+WwHg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hunwkhfce-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:56:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93f1f2fafeaso259394885a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 20:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794286609; x=1794891409;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d+WYdt08Ufsm3x+Oe0Q0W8lqpRG0RHBqFyGwH/romlI=;
 b=KzBWThPzLYsWCfYrrE8lFM7zYco627ALCFhEXhrr8zmRg7NuTsZGVCA2u4LRtHJ7kr
 duH2+MEXh2k81Xa1FQW0buk+qZxa+1K/SU+PEI9Rv0ngAx3MplJzPZ6FoZrUDqqySdVW
 VedNw4jbY0DW60bSXUuTPuEZhz+hIbaq1ft3ZIhYorp0Tc+/O+Uwl2kHAmJR1IjQ2ep0
 bPw3CedPnYhcFNG1oMQwjGKSAAiAmlqW3duQxvQZKM6wS5Mi8jq30AvNwMWevOEax+TQ
 A9LUhb6wD4QdoRAwYBVCEA1JbzJql2HPrfaQgMT00i0EA4A1SK7AEHrifgQjPV9GXG9E
 n4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794286609; x=1794891409;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d+WYdt08Ufsm3x+Oe0Q0W8lqpRG0RHBqFyGwH/romlI=;
 b=OKtyH4sg8mLOSxChslF9y4WowjzEm4OPpL7w5NDxUibIlxyb1fXi/CbmQpLoSP/nNs
 NzruXIY17bs21e03Kj2kMkuSchaB8Cq70XnhIDBwDHS7CILs8tzKx8TBLOum/RUp2kY9
 u9MdmtvuV6zwlK62mPPOaSWYMtlyfHNmxFsmnSwo5FSwvukL55U5g7ozOrfq+6ftbWQJ
 XZUi9MMoeQqQ7DAW9E3pmITsHaCnktnF7rAkEYRlpYuvYNXaPBQ37iWrKZoPof0o4qL6
 xjXPJwA0YS5sGOhkFVSXMtCjyi6jjNuEvgXMyOg5rDAhhBIyWWnSRnnwOtKIoItDTzSe
 93Vw==
X-Forwarded-Encrypted: i=1;
 AL+hErHauah/IGf3RfRJzZ3urfwSxT85mLPgNZlGwxm0hFsSXk6sX638At1SAnPAAqENn4hacnUh4U327g4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/TVlyxjJ262eejlcyFZDl0yWQLcPx3O4rzhi9y+n3tC8G5Rj0L
 OKIyhQ9N1v++UBepw4xblRqfyO2akMerD82c0VSHz8+/7oSRTM5evNHbfev8ZnM4uy0IS35nF7G
 6tV2DVQLvQXy7/k/E8Hgc2yKxIplCDTszMqoF9uKQ0cDA9+1jddIqYW5Uu/PhhNrNsBm0b7XgOG
 B9gHx/qw==
X-Gm-Gg: AYBFou0M6PQM5f8LOPFiq6h2+yQ71/P3MtAWUN47MMM16sXiIaN/i/FU0PO/xItPOSn
 ARM+whFr6//oQWjFXvvPJin7tS9jbs6xG9zg6BybazydK7GF7+S3NWFfwJIwx0sqCDUTPrXIUNd
 6BN3zLjRIMEYCP2rjiD/6qnY+CSP2vG0l0OfrZ08MtdIfBnzbbsdNTDD55tYWDxbMWQTOQsQCY0
 5kVkN1bCp/vgYQR5Z3P2sNMBmGouttRBipD7Wtm7hUdeKL1a3/nzHZKJXn2MQOhnXmDDZgTj7rd
 nO4jNcSTVQuN2Noo66cvw6yxa+aBW86freY+p0rSZfScTDEV1N3LDSWdkQH0sC0UHOs/wi/XyWm
 0gdhlDp0CvNznAaRtag+UMA14uxZOTqQRGCm18mXtEzomZ3KSrv0aq6jzLwnNJMwIWAeGPaJ02W
 H5ckuWM9IG6ceBX0GdyY6/7wqYJMhPo0ynVFKz
X-Received: by 2002:a05:620a:46a7:b0:93f:5677:9950 with SMTP id
 af79cd13be357-9479f38a57emr252637585a.53.1794286609173; 
 Mon, 09 Nov 2026 20:56:49 -0800 (PST)
X-Received: by 2002:a05:620a:46a7:b0:93f:5677:9950 with SMTP id
 af79cd13be357-9479f38a57emr252634585a.53.1794286608628; 
 Mon, 09 Nov 2026 20:56:48 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e73b2d2sm138653985a.10.2026.11.09.20.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 20:56:48 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 12:54:49 +0800
Subject: [PATCH v8 28/29] drm/msm/dp: select MST stream bpp during atomic check
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-msm-dp-mst-v8-28-d040fb33db5f@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794286469; l=10659;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=CPwuoOmLN10Kr6wWpYVMMlD9otxVbPsvSEjJAEPgNKA=;
 b=FQ0zy+S7GNRXYJCUV/Vx2hfM4nirkoWyPewEtuHCfRbZlMXCz0+04bc5CkuX1zOJhXcxBMgRd
 Mqptn+wMrRDCYbYKwM4nGAVpMwgniBOyHThFcZ6j0/vZ0O/XDhDvAkO
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 1E1oTHrnojsy6HsrRRaoIrxhnF8cVLhN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX1LfuyaHmJ8Iz
 JNxhNe179Hwe45aIwKH5UYbUprJgjgRtmgFExoVR79f1NWBvt7E2g2S/0V4m8WKgmw6M39H+9k8
 Z0KEwiTYMgd6Z2xFX0DuAj9VeqNtxoI=
X-Authority-Analysis: v=2.4 cv=TOrQ2Fla c=1 sm=1 tr=0 ts=6af2a411 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=JPqAu_mP4Hh-pTAkM0kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 1E1oTHrnojsy6HsrRRaoIrxhnF8cVLhN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAxOSBTYWx0ZWRfX2dqKMxvSbgrD
 +AyYrNnzRO3w6K8OnFEMn78slUFOihbH/XdfeiIg64iCv8ijBx4ZyKnAqvspRBtxu7USNiE5bPM
 ZlUxQdqpOrZgJHOlm4pshVoDti6cWnwqm7xfj8CNr7g2RmymlDp+sllA06fPnHMTqyKawxC2ABU
 Bmh1jaSBdrbG7kAs/R4bdtAYJL7VVb88wcrOrw8raVQEN05h3xhwa3oIg3KD4/wt+mIzeXyJs6d
 0RdXeey5jFpIL3JyMjBOieqoD/s7Pnt95h5ivynB9CL3WiW80E/K1HZjl4VFICTEDB96FVCJ8vu
 91bLpaHbggq+txF24UvsutfIMKE5azD4DkvlGQyPF/ZHYdFagJRR2fofZ0mXX2Y4P0WNVUYjP32
 JGxgKhJrppwcTe4pfNqvEuhYC+ijB24wZcwzLRmgjtMruk+WKtlxkZpMpywnxyP/yPY1a1UM692
 V4GvP287nGADFM8ZqRQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 lowpriorityscore=0
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

MST streams share one link, so each stream reserves a share of the
link's time slots during the atomic check, sized from the bpp the stream
will be driven at. That size was derived from the sink's bit depth,
without checking that it fits the bandwidth of the MST port or the time
slots left on the link. When it does not fit, the modeset fails rather
than driving the stream at a lower bpp.

Try 30, 24 and 18 bpp in turn and take the first one that fits. This is
the sequence msm_dp_panel_get_supported_bpp() already walks for SST,
where the whole link belongs to a single stream. Carry the selected bpp
in a connector state subclass so the commit programs the bpp the
reservation was sized for.

drm_dp_atomic_find_time_slots() only records the request and does not
report a full link, so compare the time slots it returns against the
ones the link has. The aggregate limits are verified later by
drm_dp_mst_atomic_check().

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c |  22 ++++---
 drivers/gpu/drm/msm/dp/dp_display.h |   3 +-
 drivers/gpu/drm/msm/dp/dp_mst_drm.c | 116 ++++++++++++++++++++++++++++++++----
 3 files changed, 119 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 8e30420a017f..b9e01b74dc14 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -693,17 +693,19 @@ static int msm_dp_init_sub_modules(struct msm_dp_display_private *dp)
 
 static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 				   const struct drm_display_mode *adjusted_mode,
-				   struct msm_dp_panel *msm_dp_panel)
+				   struct msm_dp_panel *msm_dp_panel,
+				   u32 bpp)
 {
 	struct msm_dp_display_private *dp;
-	u32 bpp;
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	if (msm_dp_display_check_video_test(msm_dp_display))
-		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
-	else
-		bpp = msm_dp_panel->connector->display_info.bpc * 3;
+	if (!bpp) {
+		if (msm_dp_display_check_video_test(msm_dp_display))
+			bpp = msm_dp_display_get_test_bpp(msm_dp_display);
+		else
+			bpp = msm_dp_panel->connector->display_info.bpc * 3;
+	}
 
 	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
@@ -1604,7 +1606,8 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 				   struct drm_atomic_commit *state,
 				   struct drm_encoder *drm_encoder,
-				   struct msm_dp_panel *msm_dp_panel)
+				   struct msm_dp_panel *msm_dp_panel,
+				   u32 bpp)
 {
 	struct drm_crtc *crtc;
 	struct drm_crtc_state *crtc_state;
@@ -1614,7 +1617,8 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 		return 0;
 	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
 
-	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode, msm_dp_panel);
+	return msm_dp_display_set_mode(msm_dp_display, &crtc_state->adjusted_mode,
+				       msm_dp_panel, bpp);
 }
 
 void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
@@ -1626,7 +1630,7 @@ void msm_dp_display_atomic_pre_enable(struct msm_dp *msm_dp_display,
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
 	rc = msm_dp_display_set_mode_helper(msm_dp_display, state,
-					    msm_dp_display->bridge->encoder, dp->panel);
+					    msm_dp_display->bridge->encoder, dp->panel, 0);
 	if (rc) {
 		DRM_ERROR("Failed to perform a mode set, rc=%d\n", rc);
 		return;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 62400547e01a..7a50367c36a5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -57,7 +57,8 @@ void msm_dp_display_atomic_post_disable_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 				   struct drm_atomic_commit *state,
 				   struct drm_encoder *drm_encoder,
-				   struct msm_dp_panel *msm_dp_panel);
+				   struct msm_dp_panel *msm_dp_panel,
+				   u32 bpp);
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 2b96e003225d..a452b3d2ba22 100644
--- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -23,6 +23,14 @@ struct msm_dp_mst_connector {
 	struct msm_dp_mst *dp_mst;
 };
 
+struct msm_dp_mst_connector_state {
+	struct drm_connector_state base;
+	u32 bpp;
+};
+
+#define to_msm_dp_mst_connector_state(x) \
+	container_of((x), struct msm_dp_mst_connector_state, base)
+
 struct msm_dp_mst_encoder {
 	struct drm_encoder *enc;
 	int stream_id;
@@ -51,12 +59,51 @@ static void dp_mst_connector_destroy(struct drm_connector *connector)
 	kfree(mst_conn);
 }
 
+static void msm_dp_mst_connector_reset(struct drm_connector *connector)
+{
+	struct msm_dp_mst_connector_state *mst_state = kzalloc_obj(*mst_state);
+
+	if (connector->state)
+		__drm_atomic_helper_connector_destroy_state(connector->state);
+
+	kfree(connector->state);
+	__drm_atomic_helper_connector_reset(connector, mst_state ? &mst_state->base : NULL);
+}
+
+static struct drm_connector_state *
+msm_dp_mst_connector_duplicate_state(struct drm_connector *connector)
+{
+	struct msm_dp_mst_connector_state *old_state, *new_state;
+
+	if (drm_WARN_ON(connector->dev, !connector->state))
+		return NULL;
+
+	old_state = to_msm_dp_mst_connector_state(connector->state);
+	new_state = kmemdup(old_state, sizeof(*new_state), GFP_KERNEL);
+	if (!new_state)
+		return NULL;
+
+	__drm_atomic_helper_connector_duplicate_state(connector, &new_state->base);
+
+	return &new_state->base;
+}
+
+static void msm_dp_mst_connector_destroy_state(struct drm_connector *connector,
+					       struct drm_connector_state *state)
+{
+	struct msm_dp_mst_connector_state *mst_state =
+		to_msm_dp_mst_connector_state(state);
+
+	__drm_atomic_helper_connector_destroy_state(&mst_state->base);
+	kfree(mst_state);
+}
+
 static const struct drm_connector_funcs msm_dp_drm_mst_connector_funcs = {
-	.reset = drm_atomic_helper_connector_reset,
+	.reset = msm_dp_mst_connector_reset,
 	.destroy = dp_mst_connector_destroy,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
-	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+	.atomic_duplicate_state = msm_dp_mst_connector_duplicate_state,
+	.atomic_destroy_state = msm_dp_mst_connector_destroy_state,
 };
 
 /* DP MST Connector OPs */
@@ -142,6 +189,42 @@ static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
 	return drm_dp_atomic_release_time_slots(state, &mst->mst_mgr, mst_conn->mst_port);
 }
 
+static int msm_dp_mst_select_bpp(struct drm_atomic_commit *state,
+				 struct msm_dp_mst *mst,
+				 const struct drm_dp_mst_topology_state *mst_state,
+				 struct drm_dp_mst_port *port,
+				 const struct drm_display_mode *mode,
+				 u32 max_bpp, u32 *bpp)
+{
+	static const u32 bpps[] = { 30, 24, 18 };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(bpps); i++) {
+		int pbn, slots;
+
+		if (bpps[i] > max_bpp)
+			continue;
+
+		pbn = drm_dp_calc_pbn_mode(mode->clock, bpps[i] << 4);
+		if (pbn > port->full_pbn)
+			continue;
+
+		slots = drm_dp_atomic_find_time_slots(state, &mst->mst_mgr, port, pbn);
+		if (slots < 0)
+			return slots;
+
+		if (slots <= mst_state->total_avail_slots) {
+			drm_dbg_kms(mst->msm_dp->drm_dev,
+				    "[MST] bpp=%u pbn=%d slots=%d\n",
+				    bpps[i], pbn, slots);
+			*bpp = bpps[i];
+			return 0;
+		}
+	}
+
+	return -ENOSPC;
+}
+
 static struct msm_dp_panel *msm_dp_mst_panel_from_encoder(struct msm_dp_mst *mst,
 							   struct drm_encoder *enc)
 {
@@ -204,6 +287,9 @@ void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
 		drm_atomic_get_new_mst_topology_state(state, &mst->mst_mgr);
 	struct drm_dp_mst_atomic_payload *payload =
 		drm_atomic_get_mst_payload_state(mst_state, port);
+	struct msm_dp_mst_connector_state *mst_conn_state =
+		to_msm_dp_mst_connector_state(drm_atomic_get_new_connector_state(state,
+									 connector));
 	struct msm_dp_mst_slot_info slots[DP_STREAM_MAX] = {};
 	int rc;
 
@@ -212,7 +298,8 @@ void msm_dp_mst_stream_enable(struct drm_encoder *encoder,
 	drm_connector_get(connector);
 	panel->connector = connector;
 
-	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel);
+	rc = msm_dp_display_set_mode_helper(dp_display, state, encoder, panel,
+					mst_conn_state->bpp);
 	if (rc) {
 		drm_err(dp_display->drm_dev,
 			"[MST] stream:%u set_mode failed rc=%d\n", panel->stream_id, rc);
@@ -311,9 +398,12 @@ int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
 				   struct drm_connector_state *conn_state)
 {
 	struct msm_dp_mst_connector *mst_conn = to_dp_mst_connector(conn_state->connector);
+	struct msm_dp_mst_connector_state *mst_conn_state =
+		to_msm_dp_mst_connector_state(conn_state);
 	struct msm_dp_mst *mst = mst_conn->dp_mst;
 	struct drm_dp_mst_topology_state *mst_state;
-	int bpp, pbn, slots;
+	u32 bpp, max_bpp;
+	int rc;
 
 	if (!conn_state->crtc)
 		return 0;
@@ -321,9 +411,6 @@ int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
 	if (!drm_atomic_crtc_needs_modeset(crtc_state) || !crtc_state->active)
 		return 0;
 
-	bpp = (conn_state->connector->display_info.bpc * 3) ?: 24; /* fallback: assume 8bpc */
-	pbn = drm_dp_calc_pbn_mode(crtc_state->mode.clock, bpp << 4);
-
 	mst_state = drm_atomic_get_mst_topology_state(crtc_state->state, &mst->mst_mgr);
 	if (IS_ERR(mst_state))
 		return PTR_ERR(mst_state);
@@ -334,10 +421,15 @@ int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
 						 mst->link->link_caps.num_lanes);
 	}
 
-	slots = drm_dp_atomic_find_time_slots(crtc_state->state, &mst->mst_mgr,
-					      mst_conn->mst_port, pbn);
-	if (slots < 0)
-		return slots;
+	max_bpp = clamp(conn_state->connector->display_info.bpc ?: 8, 6, 10) * 3;
+
+	rc = msm_dp_mst_select_bpp(crtc_state->state, mst, mst_state,
+				   mst_conn->mst_port, &crtc_state->adjusted_mode,
+				   max_bpp, &bpp);
+	if (rc)
+		return rc;
+
+	mst_conn_state->bpp = bpp;
 
 	return 0;
 }

-- 
2.43.0

