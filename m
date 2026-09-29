Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449A3C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42E1410ECB5;
	Tue, 29 Sep 2026 04:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c0udi7MR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bBysUp30";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FD710ECB4
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:22 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T46xlb2685982
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7LJSCrYx5dwBDnf56R7yDbjm03ET2r6JIThUX1qNaxQ=; b=c0udi7MRrSNldbyO
 vp2c31+7cJVdIAhA6/f66AoEeMjUXvDBoa6UjSP5WbG6tq+vjYZl/nv8jqUDG30s
 1exgbEjWOWqaPoTcWvzOTh/2GLKlrtY2x1mE04UF/EpTfAlZ3jdaNpxjmnC3h0qe
 nIN1jBk75Y5/+aUCjhxHPqmbQsN1KDGXr/uCX2nOlKqH7qhdCePveprcDMsxpseG
 SPNsqEOLRsebf9JtOzLqV+dbAsH6FvB+epe6jtsF9/xRU5Bh4/VaETQfFg+10Xr4
 5SZzf+hybOYbg+LqM7SXA6NeUiirQIdBURLkPJxDkyOFu5tgZvvU6CMmREZolzHb
 DqvBwQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h02mjgr5r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:21 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-91433a91ee9so70616036d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656101; x=1791260901;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7LJSCrYx5dwBDnf56R7yDbjm03ET2r6JIThUX1qNaxQ=;
 b=bBysUp30ANmp/JbdViCKY+GLuVJvezQjoSfrSm0qkpLZ8Z0Y8h1wzMi6NEEalqDs3x
 GDAGPgZUxSzINKTI4b0Br8BcieIYrlff1mqf2VEcoHb5d5OnThXPaNUn7Zf7kSfJY7hl
 t0EeYBDdRtCCUEtsenOM8T/OF2NhM3e+d+T6U9fCtmQdjwkY+Lj/vq7IVLmklz+fPeuD
 Gip2g/li9xi4c3v1bRfbQx/lkIpDq1DKsyewthFX+2fKUlpYKZOIP19gg/fh4GBeu+to
 JkmdTe4Qlscpi31m8pSPq34ObdSRVpN9BALhQXtORtxoxSmZqsB+tU+2YqEyhXt5Y5SB
 Py2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656101; x=1791260901;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7LJSCrYx5dwBDnf56R7yDbjm03ET2r6JIThUX1qNaxQ=;
 b=WMGxwMRgQ2wst+0j2JX0BkjUukjVi6MlRI13SZdiWP8e1rjhlO15Ki6tGziKQk1+Mk
 8r2pqagAKhHyBApTDRo15P+a6bYrFB3OntSvibb+T/f6Ng3WUv3Tz/S1VaoMhujdVZkh
 XTsbX9ZYYqMQJKPBqq+u+eN9KIJ5xCaRDIR6KCeUNAR4Fj4CPvnGhFma54nVrdpvHYJb
 j3S0cGu51yTDw6C92y8fr8nuTdEyxwG2MmBjLRre3ZgWe0JKbL3aVm/QGKOmTlx06FEe
 lfU8GJfzRY5AkQYvyfh96kZx5iNFGGsjota8lCa+Zh7HLC4tccKxs3wPp08sANrR9HV9
 XAsw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV5+e0UkJdfJ02YALb8YD9469HPDCTYFPZ16qfwgI5EKKSAz4lYLSgciu03c/m45LnrE8/tN9j1HU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKlKI+TTdc1NuRn6ufAGqm2sEVDLV81A6R3J6OsGmjX2l4YoZh0
 d937RDClaXpP03c5+akR+ve13gN1/eCS/RLSNVWp4SrT2RjcFc+YXPGbM4ABcOo8dtpB/mrTI2/
 QH/XnQ5LcSGc+mF4rskKSyAj+rmPOLRyWDs0SSQK8LN5qYoZGqiqJLt5iI8KbNpsv9ZqfLhY=
X-Gm-Gg: AYBFou0ytu2Ntww8t0zGtUYn0zq2fT5LIznMX38fkTcr0qdhUC5nJQpwJd7chMCfLSN
 /4Mqp9ZTx73QA4DxSkGK9DvZFqNgQL+iBgu973Eo3xEgvBB8SITW0b10PF1PYTKIzluqWpPIkGg
 JYWGlzJn9XXUijMHhNHS6HSlTtQmpTzz5w5bSbsNuiFJ4qlP5UroO7i3UjP4Uo10X3X1QH2Icvz
 e6E22v+uPgMn+YyQqDeH3yN24FFGmH6qFIh4iEdGI2DP8bueca0+q2VUwneeiGSHkv59j7Rt47P
 myhPGNOqwn2k+KAr7DEbz/A2s9P12IM48yvZ0Awpitgtto+SapIkU/2s2988CKJMf2UD67oB+qY
 T3Y2Be76F80MNY0bbNF8c6nLD4zFB1QSW38NesINFpUB8SgzEvB/KZjabkVXPWj4=
X-Received: by 2002:a05:6214:f22:b0:914:4a49:9ad1 with SMTP id
 6a1803df08f44-9144a499eccmr179964506d6.9.1790656101048; 
 Mon, 28 Sep 2026 21:28:21 -0700 (PDT)
X-Received: by 2002:a05:6214:f22:b0:914:4a49:9ad1 with SMTP id
 6a1803df08f44-9144a499eccmr179964276d6.9.1790656100557; 
 Mon, 28 Sep 2026 21:28:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:20 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:48 +0800
Subject: [PATCH v7 24/35] drm/msm/dp: add atomic stream handling for MST
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-24-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=15053;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=SN+dkgRSxpF2IZTqvM/BPQNlsRDYvRLLL0stb9WMlwk=;
 b=XaZcY+YeWGVWbgNUHZOaP+Ef073hfe8zfKf64ZMmOHa7x0ujYWznVeTB/b3Yx5U65fyx6nglF
 9MoCbwA+YLKDSCYxYkQPI9YfcyhjEdas3ak48QMcuXiEsnnQ3wPOP1S
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX/BqrenQfxjDM
 MpywT+rAgQCjbn7SMWvcIvaNzibUFrG0kfALbCv353XCavls3juRAi7tbY5K371n2MI67YZnn0A
 K1Tv+HuLFeXnuOWYCgOLjEQtmRwJ7tNqBnVGAhCO+P858H0TVeFajOl5+aVSZym7g6qM8PB6FX1
 d3571tBXP2YnNo4MXJN3LLZj+/XMj5DmQVSAnB4Bys2sXETlQPUNBhakyBYJ3yhXiuyr97SRj4R
 d/5Lz1hWUDxRpIbvV1bQWNiyQtzGixC0esVjD4qrmQn8ptVCJJYqfDTmh4mDxLKpEbElllcXsHK
 o2pysL9lINkRco2WMPaq5DuI+5PApI5kGpit7uOMW2o/aVlYxd3iDj0JoUXDaG2CCfJzme2pGPR
 BvCMRvGpgYOU5EcfP7cz133znmlbDhtJHI6IcNKv0U7vVzhUn5xGoilAbg8biSuGB0CFIZrbvz/
 fps/2ES0gb3vJdfHllg==
X-Authority-Analysis: v=2.4 cv=OdgNnRTY c=1 sm=1 tr=0 ts=6abb3e65 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=rZU0s2GuZPBXI8FFSQwA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXzXyg8uNt/e+C
 iZl0wWC2zFSz6J/zKOOLbRL66vIlbIikpGsUCG/cbU/rPkiKmcgRlEljshrOv9g/ghHYDvqbAM4
 unO3cPMNBWT7gaYA9IVq5BT+auQ3khE=
X-Proofpoint-ORIG-GUID: uFTE2enl6rkM-opTTA6FCVBhxMZzifpA
X-Proofpoint-GUID: uFTE2enl6rkM-opTTA6FCVBhxMZzifpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290017
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

Add the atomic check, enable and disable operations for MST streams.

Reserve VC payload bandwidth based on the negotiated link parameters,
and update the MST payload when enabling or disabling each DP stream.
Serialize stream updates that access the shared MST link state.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c |  13 ++
 drivers/gpu/drm/msm/dp/dp_display.c         |  13 +-
 drivers/gpu/drm/msm/dp/dp_display.h         |   1 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c         | 198 +++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/dp/dp_mst_drm.h         |   3 +-
 drivers/gpu/drm/msm/msm_drv.h               |  22 ++++
 6 files changed, 247 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 533109b4365c..933dbfd30b56 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -2747,16 +2747,29 @@ static const struct drm_encoder_helper_funcs dpu_encoder_helper_funcs = {
 static void dpu_encoder_mst_atomic_enable(struct drm_encoder *enc,
 				      struct drm_atomic_commit *state)
 {
+	if (msm_dp_mst_stream_enable(enc, state))
+		return;
+
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
index f5947233ab96..4a3ca1bf05a0 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -453,6 +453,16 @@ static void msm_dp_display_handle_plugged_change(struct msm_dp *msm_dp_display,
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
@@ -1293,7 +1303,8 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display)
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	return msm_dp_mst_mgr_init(msm_dp_display, msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
+	return msm_dp_mst_mgr_init(msm_dp_display, dp->link,
+				   msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
 }
 
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index df5021ba7c15..0bf5ff5e7815 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -66,4 +66,5 @@ int msm_dp_mst_register(struct msm_dp *msm_dp_display);
 void msm_dp_mst_unregister(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
+bool msm_dp_display_is_plugged(struct msm_dp *msm_dp_display);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
index 88687b97ed6e..fd8fd6fd10bd 100644
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
@@ -133,6 +136,45 @@ static int msm_dp_mst_connector_atomic_check(struct drm_connector *connector,
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
+static void msm_dp_mst_remove_payload(struct msm_dp_mst *mst,
+				      struct drm_dp_mst_topology_state *mst_state,
+				      struct msm_dp_panel *panel)
+{
+	struct msm_dp_panel *dp_panel;
+	struct drm_dp_mst_atomic_payload *payload;
+	int i;
+
+	msm_dp_display_set_stream_info(mst->msm_dp, panel, 0, 0, 0);
+
+	/* Apply the slot shift to the remaining payloads. */
+	for (i = 0; i < mst->max_streams; i++) {
+		dp_panel = mst->mst_encoders[i].dp_panel;
+		if (dp_panel == panel || !dp_panel->connector)
+			continue;
+
+		payload = drm_atomic_get_mst_payload_state(mst_state,
+				to_dp_mst_connector(dp_panel->connector)->mst_port);
+		if (!payload || payload->vc_start_slot < 0)
+			continue;
+
+		msm_dp_display_set_stream_info(mst->msm_dp, dp_panel,
+					       payload->vc_start_slot,
+					       payload->time_slots, payload->pbn);
+	}
+}
+
 static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 					struct drm_encoder *enc)
 {
@@ -145,6 +187,156 @@ static int msm_dp_mst_encoder_stream_id(struct msm_dp_mst *mst,
 	return -1;
 }
 
+int msm_dp_mst_stream_enable(struct drm_encoder *encoder,
+			      struct drm_atomic_commit *state)
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
+		return rc;
+	}
+
+	rc = msm_dp_display_prepare_link(dp_display);
+	if (rc) {
+		drm_err(dp_display->drm_dev,
+			"[MST] stream:%u prepare_link failed rc=%d\n", panel->stream_id, rc);
+		return rc;
+	}
+
+	drm_dp_mst_update_slots(mst_state, DP_CAP_ANSI_8B10B);
+
+	rc = drm_dp_add_payload_part1(&mst->mst_mgr, mst_state, payload);
+	if (rc)
+		return rc;
+
+	msm_dp_display_set_stream_info(mst->msm_dp, panel,
+				       payload->vc_start_slot,
+				       payload->time_slots, payload->pbn);
+	drm_dbg_kms(dp_display->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, payload->vc_start_slot,
+		    payload->time_slots, payload->pbn);
+
+	msm_dp_display_enable_helper(dp_display, panel);
+
+	drm_dp_check_act_status(&mst->mst_mgr);
+
+	drm_dp_add_payload_part2(&mst->mst_mgr, payload);
+
+	return 0;
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
+
+	guard(mutex)(&mst->mst_lock);
+
+	drm_dp_remove_payload_part1(&mst->mst_mgr, new_mst_state, new_payload);
+
+	drm_dp_remove_payload_part2(&mst->mst_mgr, new_mst_state, old_payload, new_payload);
+
+	msm_dp_mst_remove_payload(mst, new_mst_state, panel);
+	drm_dbg_kms(mst->msm_dp->drm_dev,
+		    "[MST] stream:%u timeslots vc_start:%d slots:%d pbn:%d\n",
+		    panel->stream_id, new_payload->vc_start_slot,
+		    new_payload->time_slots, new_payload->pbn);
+
+	if (!msm_dp_display_is_plugged(mst->msm_dp))
+		return;
+
+	msm_dp_display_disable_helper(mst->msm_dp, panel);
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
@@ -284,7 +476,8 @@ static const struct drm_dp_mst_topology_cbs msm_dp_mst_drm_cbs = {
 	.add_connector = msm_dp_mst_add_connector,
 };
 
-int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, struct msm_dp_link *link,
+			 u32 max_streams, struct drm_dp_aux *drm_aux)
 {
 	struct drm_device *dev = dp_display->drm_dev;
 	struct msm_dp_mst *mst;
@@ -296,6 +489,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 
 	mst->mst_mgr.cbs = &msm_dp_mst_drm_cbs;
 	mst->msm_dp = dp_display;
+	mst->link = link;
 	mst->max_streams = max_streams;
 	mst->dp_aux = drm_aux;
 
@@ -310,6 +504,7 @@ int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_d
 		return ret;
 	}
 
+	mutex_init(&mst->mst_lock);
 	dp_display->msm_dp_mst = mst;
 	return 0;
 }
@@ -322,6 +517,7 @@ void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
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
index 2ada4a7c1c08..9d67425fecee 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -362,6 +362,12 @@ int msm_dp_mst_register(struct msm_dp *dp_display);
 void msm_dp_mst_unregister(struct msm_dp *dp_display);
 int msm_dp_mst_attach_encoder(struct msm_dp *dp_display, unsigned int stream_id,
 			      struct drm_encoder *encoder);
+int msm_dp_mst_stream_enable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+void msm_dp_mst_stream_post_disable(struct drm_encoder *enc, struct drm_atomic_commit *state);
+int msm_dp_mst_stream_atomic_check(struct drm_encoder *enc,
+				   struct drm_crtc_state *crtc_state,
+				   struct drm_connector_state *conn_state);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -415,6 +421,22 @@ static inline int msm_dp_mst_attach_encoder(struct msm_dp *dp_display,
 	return -EINVAL;
 }
 
+static inline int msm_dp_mst_stream_enable(struct drm_encoder *enc,
+					    struct drm_atomic_commit *state)
+{
+	return 0;
+}
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

