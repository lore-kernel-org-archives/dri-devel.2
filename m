Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB4CCC61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC2E10E731;
	Mon, 31 Aug 2026 08:19:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nx0r306k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cjL2u0F0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E35510E729
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:16 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xkKg2824563
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5BdHh4OWTLUAl/9JW9arAi2BIKEdDPTCN3xniys2XcI=; b=Nx0r306kO+oECOex
 XQg7NMmrCTR8hnYjbgbRUhyzHa0lSTnAM7DKRRl+gS3VZHdE7cg8QwVR/7CHp4AQ
 L54xuUTgfm0+mGzZiM/UMQt+ACmLByr0MY+26+hZwOOWA0dmqJpCFT3McuQTQaRQ
 /SeWaafrNDrlcoW2TrzV2Y90Uf655KGaachDQ1YwqAHf9Mp5DYjF265pvAOBfePQ
 jx7vtH1sq7Bojfrw+GQjl1oIp4YQKJM66sD0B80zMWSOB3DGQ4a38jJhkOwa+tfW
 ji5vqBQIjd0Xb590JdIwJVVE1kcNx4K+rb9PAZKUx4uWw9AGDJebn3XIPNM6FmDy
 L1vShA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqe2ddcu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:15 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso25059436d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164355; x=1788769155;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5BdHh4OWTLUAl/9JW9arAi2BIKEdDPTCN3xniys2XcI=;
 b=cjL2u0F0tmvLUuwtfF5FvTUe4u7eSd6xR4LfZBCLt6iFdUmVkRou4z8XUK3EMi7Ohg
 2ffPZomIXCVDE1yIEiMg89JrKD84Ylsz5sSZ4HDh5MWkkq925eWgFC9SVlXVOIKmG+Bd
 zNcSPO6r/wns3FJnWMZ4pDn047kPQjzN5BgKyryssC81UYKfZR3/JgoVFKi5QG+8KIgq
 +WLDFKk/1ntP3UVQe3KpcOcJTCgBHSeRD2gTJ/HYICSgzVKFThr/lElGZHE3Dcu8+S/i
 A65NAqdSe/mJkT64OsezxK6FMXpTJFxewbCXNU0CMfgpiF5VclJydJ8FvqpjP0v/aLGE
 Tk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164355; x=1788769155;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5BdHh4OWTLUAl/9JW9arAi2BIKEdDPTCN3xniys2XcI=;
 b=FEvu97cCImzTwudfTqyRY4idxXCJRtmvEEMBj7+yG6APq3sMbpt8LXfukaxLyINR7E
 hv9/7xo1PAueR9GcaAUVYGYj5h4LOCq3FY2mdrqNj0Vwe/5LHE8xtBteqBWlifMAy2eo
 BSV+W9Q2WZQFf6oww0re4EIT8oZxFNNhnBpen00796GhfyYtoOXLlg6HoZ6gBpfHT+Ad
 sdO0ZDGTRvPdH/ysVDoNY63TsDyEG9hHgMrNnBrciMogjqRY/al3VvEl62f7SdMkHXyZ
 m/bJS2xZJq5Ujtl+/JNOWRJ0aOxYOk+sHj07COJfPZqCOsMjMeY+X2RZJi6liWMHVgMk
 ZUFg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpxsij1rPJDhD/LyXLuFMXfMPyp9zfpFDMNGX/6j915LZLyjqoUP2t43mbF2WwgQKB3VQDVDgp7zQY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ngT5DYrXNwgvJ9kUkedY4cV0Dtcq7Pw5epCy6/udUPiluhER66
 kFdCoM1SJJ/y/wHjBDMMYTtg19Ly4Wfqo+IT+1yGerPdi7unNkOuuzTXnFHv290OR5Pgof/ZOM9
 2idtGddtE5kGNuq55aT+m69PTRxu+ICAuRPWq5vIomtiopRjk5CymrSlxSCuSvmkPdDGzWgw=
X-Gm-Gg: AR+sD13v0DSwyYmrfMMKHFc/RHwwQWfBx2EQcQEALPfsBrggJsUzFo5C/VvD5so/mXI
 Wk+/PSAEJm2rViEKL+Slm3nC0hi8FRsAC3zYCJhtVhEPSTjkMf9IPusGXnWX5NHbXEhGersLhuK
 M+MC3+CmZnPCEypV6vc7Vr6KqV5JsZHIbH3RPNQ+CtV7CD6YKDSGwCIOQokurODzWtAc2tx1RF1
 +KnfNfsP8xcxejcxY2dlz3Bz91KvYJsF3k9eozyXE9UmPcYtateDFG/UuM847FMaVPq5t6RB4s3
 mqS7vuq+MZSD60pEY9RP3KZWcBj6On/vAldSDODpZA4rxkSAA2Qiz6i8kdmO7/7sR1aJJOpJf8U
 7j7VaiLOAVoE6w0Ew+F48OhaaRINzw3lcctXaxLLbIm1azGHDebFyt03QSCX82sY=
X-Received: by 2002:a05:620a:2608:b0:939:3885:3131 with SMTP id
 af79cd13be357-93938853498mr713344885a.3.1788164354534; 
 Mon, 31 Aug 2026 01:19:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2608:b0:939:3885:3131 with SMTP id
 af79cd13be357-93938853498mr713339385a.3.1788164354042; 
 Mon, 31 Aug 2026 01:19:14 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:13 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:35 +0800
Subject: [PATCH v6 18/29] drm/msm/dp: introduce dp_mst_drm module
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-18-c91d35d6fb9e@oss.qualcomm.com>
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
 Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=7475;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Oy4ARw4by0kYhD1OMSYIGPR7NRvIQSR0y1PyXC2S8d0=;
 b=cv4mVv8fysTUD1NECx0J/+HKVOjxbEKrANbL7lmNviNfPOcg8pNJLUTDlXbrC8itDrucGGVgs
 PR8TXeBkZ0VDBGXMMcSY1BP14K70OdGEP62vdBoCIFV/GnvyTQ8b5bJ
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=Iskutr/g c=1 sm=1 tr=0 ts=6a953903 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=YtzpOVx_IWpl17dmJv8A:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Kl1iVPVLyzkQBHoFD5IzwXAu_Q_NazFU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXzPg+Kwd3jI10
 I+2o3AhdNmzfPwySxxF5Ln2OBd4E9SAiQsTo1j0cCsFpvz5nbV+cQbUU0J/lHqAHNjPlkufI6hS
 5gtIlzkaQDxAMOUVwCbDklM15yKajmtY9ag5Fv1oL+JNSLk1sErB3VhoHPhBGx02oRF6wuePar7
 zsEYNwFXx18BQjleD49RixiCg664rSIv73X9VYLTmTd87vNLuwGTXsyQa+pP1eDzM0tIfKq7lvr
 z73LuLazTslUfvdnUyErYI+yun48gc2HplFgsoFWJs+4g6SZ58M9DAbQSM1KwB3FWRhmnu+cjBH
 +tN7ija4RfINniw3FfAU4Ka/i/NHGAMe2IRne7AhniAzAqyEr993Gh+qV2tGXodTLqsXKIgIV0L
 5YHee4Wb2M0JSiOpfnkVbT16Atl9RTLX+iWegjmMucxZI8IGJvzhv8sG+ElQJqAdQERUTP8BzIr
 kBriDdC4zarx3LRbTXg==
X-Proofpoint-ORIG-GUID: Kl1iVPVLyzkQBHoFD5IzwXAu_Q_NazFU
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX2zNgDgk02lRK
 KW7b+sitNSFoiv4Y/YhtvSm0TU4UkXK9f1yAFRhPJqo6GRUFU6iVTn8AWbskQlu0teCTE4dVw2J
 bQ3zPDKHdPtAdj66IGMCjLAO7NOcuNE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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

Add the dp_mst_drm module and the core MST manager data structures.

Introduce the MST manager object, per-stream encoder state and the
initialization path for creating a DRM MST topology manager associated
with a DP controller.

Also add the registration hooks used to initialize the MST manager
during DP device setup.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile            |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 12 +++++++-
 drivers/gpu/drm/msm/dp/dp_display.c     | 19 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h     |  4 +++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 54 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 12 ++++++++
 drivers/gpu/drm/msm/msm_drv.h           | 12 ++++++++
 7 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index d0c3a4c6703b..31a15636958c 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -145,7 +145,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
 	dp/dp_link.o \
 	dp/dp_panel.o \
 	dp/dp_audio.o \
-	dp/dp_utils.o
+	dp/dp_utils.o \
+	dp/dp_mst_drm.o
 
 msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..66cabac0a726 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -655,7 +655,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 	struct msm_display_info info;
 	bool yuv_supported;
 	int rc;
-	int i;
+	int i, stream_cnt;
 
 	for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++) {
 		if (!priv->kms->dp[i])
@@ -678,6 +678,16 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
 		}
+
+		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
+
+		if (stream_cnt > 1) {
+			rc = msm_dp_mst_register(priv->kms->dp[i]);
+			if (rc) {
+				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
+				return rc;
+			}
+		}
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 6952f83db006..c015af868801 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -27,6 +27,7 @@
 #include "dp_drm.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
+#include "dp_mst_drm.h"
 
 static bool psr_enabled = false;
 module_param(psr_enabled, bool, 0);
@@ -1270,6 +1271,24 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
 	return 0;
 }
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_ctrl_get_stream_cnt(dp->ctrl);
+}
+
+int msm_dp_mst_register(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_mst_mgr_init(msm_dp_display, msm_dp_ctrl_get_stream_cnt(dp->ctrl), dp->aux);
+}
+
 static int msm_dp_display_probe(struct platform_device *pdev)
 {
 	int rc = 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 4d4349068c2f..ca2faf478c95 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -24,6 +24,8 @@ struct msm_dp {
 	unsigned int connector_type;
 	bool is_edp;
 
+	void *msm_dp_mst;
+
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;
 };
@@ -59,6 +61,8 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
+int msm_dp_mst_register(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
new file mode 100644
index 000000000000..648d3ec72a1d
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <drm/drm_edid.h>
+#include <drm/drm_fixed.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/display/drm_dp_mst_helper.h>
+
+#include "dp_mst_drm.h"
+#include "dp_panel.h"
+
+struct msm_dp_mst_encoder {
+	struct drm_encoder *enc;
+	int stream_id;
+	struct msm_dp_panel *dp_panel;
+};
+
+struct msm_dp_mst {
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp_mst_encoder mst_encoders[DP_STREAM_MAX];
+	struct msm_dp *msm_dp;
+	struct drm_dp_aux *dp_aux;
+	u32 max_streams;
+};
+
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+{
+	struct drm_device *dev = dp_display->drm_dev;
+	struct msm_dp_mst *mst;
+	int ret;
+
+	mst = devm_kzalloc(dev->dev, sizeof(*mst), GFP_KERNEL);
+	if (!mst)
+		return -ENOMEM;
+
+	mst->msm_dp = dp_display;
+	mst->max_streams = max_streams;
+	mst->dp_aux = drm_aux;
+
+	ret = drm_dp_mst_topology_mgr_init(&mst->mst_mgr, dev,
+					   drm_aux,
+					   16,
+					   max_streams,
+					   dp_display->connector->base.id);
+	if (ret) {
+		drm_err(dev, "[MST] topology manager init failed\n");
+		return ret;
+	}
+
+	dp_display->msm_dp_mst = mst;
+	return 0;
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
new file mode 100644
index 000000000000..e54d49cf3499
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#ifndef _DP_MST_DRM_H_
+#define _DP_MST_DRM_H_
+
+#include "dp_display.h"
+
+int msm_dp_mst_mgr_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
+
+#endif /* _DP_MST_DRM_H_ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index eb4bbae8557b..8e98f7eb8724 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -357,6 +357,8 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_displa
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_register(struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -389,6 +391,16 @@ static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
 	return false;
 }
 
+static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
+static inline int msm_dp_mst_register(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

