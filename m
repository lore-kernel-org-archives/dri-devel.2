Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2EC606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QLU8ATZS;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b0CHLr0X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14B0D11214E;
	Thu, 19 Nov 2026 08:25:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6773011214A
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6vFE71681166
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LJY+THSHqCuf+RAU1uSoXe2Y6KXUxOMH47A3vCh/njY=; b=QLU8ATZSbZJBvvXn
 +sOGjwB5yLXKHpsy8z5iXoaYWHo15cumIvA9OOaPW1JxHnYogePKjLQEN2iz2na4
 NM/OF2avAnA6T0vRqlkw98paoHrmYJelLGXn79spGIusWE3erbMRmRg9wFeDzve/
 yi+YSNqvDxjJdj3laIQSj/dO4B63UwnQ674b/P0GFvaK7sG08z8NtSqqILOduOtP
 v3CgKYVM7yr8Ra4iKK/PA025S/0nuvUN8hwTvVgsIJuyS6exP98FZn/cgbnNY4tt
 8tCLie7CVRS+4aHG0/WMnuw+4cJoz5PpV4sS01INFYfHd8h9J6H9qdn+rJGliylW
 WBu2og==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1pdcsrx7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:25:33 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-948d83322f6so354646385a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076733; x=1795681533;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LJY+THSHqCuf+RAU1uSoXe2Y6KXUxOMH47A3vCh/njY=;
 b=b0CHLr0XOyPmbRqwMwqWChkMbwA7DOTYG97Q9sJNBhPEVvaJtJBL+93QKfYa3Giht3
 0CWm0zICsgyMXllZaehccOXQ0UBbhVZpELFeGDyLFVt/nXtYFgaK1UxAd5CmMUFu6bGo
 +g6rDxB5FtclCkYKWUIir/DJYax33ttYId1LGCwchZfuR9/HqAfDNzEE0jlUOa4QBoCV
 dj7uNYAByE5Zp12koclBqzdf3bYuLstQ+bTSUjw46QCiBZX8Hy/PcbZ04dJWz330di14
 0uixvcez3oD3IKGyeZEdvsEIb7YKIwVYp7pGOACsaG3jJSi9qCRkFQgxcpBHgu5nltJ2
 MZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076733; x=1795681533;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LJY+THSHqCuf+RAU1uSoXe2Y6KXUxOMH47A3vCh/njY=;
 b=O7wYYefPScx/BsppS2wkjrP2in4wdVj5HYzmnI729Df9ucNs635OXSBgwiepEGmqEP
 fmqSOcKQzkbTCseZLtzHlkRjTgWh7pubqJviVXVimgk81tnPnfRmtDxF/t3UO2m09Jof
 +Rv/ZLQF6Wt1t/zP4fI8F/a1ndlJr7AB2RxapNUWfRDIXrQxc9HOiZEEQ5A38mGUO/Eb
 wfjuTb+wQV6HAVQeQAj4WG87ojMuZZnMUOwcNq5g4VexANPcEotfnvvmUZOGvdA8WjfZ
 Gb0CwoEPEEFaOE5q/Oq+dcAyjeJ2luOj0+3SHeobcFx6aMhbX8O9aTz1CddRq/DMuzu0
 tgaA==
X-Forwarded-Encrypted: i=1;
 AL+hErHYy0z38PMKko6jVoNeijR4k6T6pLvo9dQFBiJUOo5GsxtJ7DxlMIaPzNimuC6tblufTVul8geQqf0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ZyLq6JLq6BWV/bN08giC7dhGLYf9bbQgY8lkMj6hFoeprTybL
 pyk1hYks5KpASEP7oXkvCcX9HmyrYI9h3iBmuUimypUNFtS67c9AsOnv4nBcY/7cBkWMGvAzWGU
 OShahV2GUBTvcc8JCcEfR4SGinl+cq0KzcM0SAjMpbco5UVeZR02t/eWa6WfS62Wa0jggek8=
X-Gm-Gg: AYBFou2g1TUGUttkZCRSPNK8XEdjPn5RflphXJ4LgfNdrVb5AHIVQidJT7pYYRFnJF5
 HqjYke20NMx36tZR/dPBlMJJUEvYS7+LJGRv+YZheECPFhNj8/1S5AkOVSjgVZ8EaYyAJTOyTgU
 +e1vzsPQsqB6jcGPfFQZXPROFY8yyWJ47axxQB4r23fzeNg16meNliSNLp4aKBdEtVdYbjXWKsF
 ua6az5Q/0LoA7kEdrpvtpZXcRDgbRoW3mh2ffV/glmToaGNSTRG3ivsggODf54Z3PWvpBPmT06k
 nrClbFq1wkatTCEQZAjeB8I7KccOjqStfDyLrJ/935mgBv2BNg6ziuKOHDdYzUQKPLOPcsEPZtq
 +ZdLasSunX52QvHmxYWbCRXHgcYdfG7dUhV967onJISWFyWp+m2rL4VZ22eTYB0h9Ly8Cjmhpnw
 1xoZ3LMV9ucfjPbidCEHrJpSFm34UAohZkTBc0
X-Received: by 2002:a05:620a:2585:b0:949:727a:44e8 with SMTP id
 af79cd13be357-94999691795mr941476285a.35.1795076732362; 
 Thu, 19 Nov 2026 00:25:32 -0800 (PST)
X-Received: by 2002:a05:620a:2585:b0:949:727a:44e8 with SMTP id
 af79cd13be357-94999691795mr941471285a.35.1795076731712; 
 Thu, 19 Nov 2026 00:25:31 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:25:31 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:14 +0800
Subject: [PATCH v9 12/29] drm/msm/dp: introduce dp_mst_drm module
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-12-ca61be4edfc3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=8782;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=KYLMskzevPbh9zHtW5ZfWOC2Cg8azLSypukKyGVJXmU=;
 b=JcGRFK/SVacbCJBpMIFRJEVOHYlsJDkFlzVE7eRTVSI4bf0kxUHc+xG9NTu8wlws3ttMExNC0
 5M+ZFjP1ZYVBbsQKpdeRhABzGCulbCUOz5uD9mGuhppIKsSIlq1UKkR
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: X7InH-kXFSWo3DyBxRiblE1SgPUQoXKu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX14n5L4pOjkqd
 8bSvY5CLSDGG+z6nV1VujLYkcn2rG2ocYP2DkKaveZPwzcKF+QiBxWRDkCPL+ye/iZtldnfDDjB
 lcVJZAFMjnl2xrn0NOoLzAOY0vB+/hQ=
X-Proofpoint-GUID: X7InH-kXFSWo3DyBxRiblE1SgPUQoXKu
X-Authority-Analysis: v=2.4 cv=Ma/5KJ/f c=1 sm=1 tr=0 ts=6afeb27d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=kqK9UwV0UgyvWCtWq9kA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX+hsUXf9fPPVG
 x7sLhq+PTGMilMhBXZTU4sVsdSciXYlsxV48WdbyTDYz7/ABEvAQYln5DaFSz4vpi9zjJwiX+E0
 r2a2TSANrA1CBT0hqkjnMENIQFZcydRdvp/QIMVpXayGa3jVeZKA8Sz8Pt82tZ/LEtakscGvyhn
 a79ioYF3oxJEso2J3bT2eZZCjTN2HWSr9oN9xmGkWbMka/PImw21ZtFa1sodVGVY1cFgwdJv4oc
 T9x08COZj1+UpaiIVnHH9Im9NN/lB9Gt2vxGofSCsLYjv82nTqZ0ar3SN3mjlhm7fncLMjVVr+u
 rkHwgRcipb++kJii9mZw6mFfbFYL2YmAi/zY4bs4qmGtTUxUpridiwym5HE/Z6q+NzkQ5Imw8UB
 KE/dn9FjIR/1SGvpEnrUOnv5rVsww2eqFQkUFHUoBI6DZLR4kRBcC3WAx5E0dsImCgtKjUzeKA/
 Pi1uNaid8sVpQ2iuo7A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 22 ++++++++++-
 drivers/gpu/drm/msm/dp/dp_display.c     | 27 +++++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h     |  5 +++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 67 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 13 +++++++
 drivers/gpu/drm/msm/msm_drv.h           | 17 +++++++++
 7 files changed, 152 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 1e246616f83f3..48640d9bf7cb5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -147,7 +147,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
 	dp/dp_link.o \
 	dp/dp_panel.o \
 	dp/dp_audio.o \
-	dp/dp_utils.o
+	dp/dp_utils.o \
+	dp/dp_mst_drm.o
 
 msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc2..3c3203ca32c76 100644
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
@@ -905,6 +915,8 @@ static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 static void dpu_kms_destroy(struct msm_kms *kms)
 {
 	struct dpu_kms *dpu_kms;
+	struct msm_drm_private *priv;
+	int i;
 
 	if (!kms) {
 		DPU_ERROR("invalid kms\n");
@@ -913,6 +925,14 @@ static void dpu_kms_destroy(struct msm_kms *kms)
 
 	dpu_kms = to_dpu_kms(kms);
 
+	if (dpu_kms->dev) {
+		priv = dpu_kms->dev->dev_private;
+
+		for (i = 0; i < ARRAY_SIZE(priv->kms->dp); i++)
+			if (priv->kms->dp[i])
+				msm_dp_mst_unregister(priv->kms->dp[i]);
+	}
+
 	_dpu_kms_hw_destroy(dpu_kms);
 
 	msm_kms_destroy(&dpu_kms->base);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d3d798a1da1a9..fb72b77e9c95e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_drm.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
+#include "dp_mst_drm.h"
 
 static bool psr_enabled = false;
 module_param(psr_enabled, bool, 0);
@@ -1286,6 +1287,32 @@ static int msm_dp_display_get_io(struct msm_dp_display_private *display)
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
+void msm_dp_mst_unregister(struct msm_dp *msm_dp_display)
+{
+	if (!msm_dp_display->msm_dp_mst)
+		return;
+
+	msm_dp_mst_mgr_destroy(msm_dp_display);
+}
+
 static int msm_dp_display_probe(struct platform_device *pdev)
 {
 	int rc = 0;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 96be45c3dc923..7b6d76f33ac61 100644
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
@@ -59,6 +61,9 @@ int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 int msm_dp_display_prepare_link(struct msm_dp *msm_dp_display);
 void msm_dp_display_unprepare(struct msm_dp *dp);
 
+int msm_dp_get_mst_max_stream(struct msm_dp *msm_dp_display);
+int msm_dp_mst_register(struct msm_dp *msm_dp_display);
+void msm_dp_mst_unregister(struct msm_dp *msm_dp_display);
 struct msm_dp_panel *msm_dp_display_get_panel(struct msm_dp *msm_dp_display,
 					      enum msm_dp_stream_id stream_id);
 #endif /* _DP_DISPLAY_H_ */
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
new file mode 100644
index 0000000000000..5d22aa34c521c
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -0,0 +1,67 @@
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
+	mst = kzalloc_obj(*mst);
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
+		kfree(mst);
+		return ret;
+	}
+
+	dp_display->msm_dp_mst = mst;
+	return 0;
+}
+
+void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+
+	if (!mst)
+		return;
+
+	drm_dp_mst_topology_mgr_destroy(&mst->mst_mgr);
+	dp_display->msm_dp_mst = NULL;
+	kfree(mst);
+}
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.h b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
new file mode 100644
index 0000000000000..7f35e7524cfdd
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.h
@@ -0,0 +1,13 @@
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
+void msm_dp_mst_mgr_destroy(struct msm_dp *dp_display);
+
+#endif /* _DP_MST_DRM_H_ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 2840e8a5052d7..31ab50f620bcd 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -357,6 +357,9 @@ void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_displa
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
+int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_register(struct msm_dp *dp_display);
+void msm_dp_mst_unregister(struct msm_dp *dp_display);
 
 #else
 static inline int __init msm_dp_register(void)
@@ -389,6 +392,20 @@ static inline bool msm_dp_wide_bus_available(const struct msm_dp *dp_display)
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
+static inline void msm_dp_mst_unregister(struct msm_dp *dp_display)
+{
+}
+
 #endif
 
 #ifdef CONFIG_DRM_MSM_MDP4

-- 
2.43.0

