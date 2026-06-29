Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBCDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F10E10E930;
	Mon, 29 Jun 2026 14:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JXFiJjnC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IfsRQhKv";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D146D10E930
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TB5Iar2728785
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=; b=JXFiJjnCoOH0JiAW
 fbz6LJ4Rq7zsariBN2F26SwD9Jk+OQX4C2EIr7YTPWMwejMSXEyD4wXGdLXTnCqS
 FP0DVLAtuVChwSTE3JzNP5xkha3+fVDyB2rbqmqHmehljZE3MP7xcKq0odvVl8eJ
 Zk07D2IER2QxZ7NQIVabE3bJoUlKOktW5HcBCUmeUZq4JAvdMLwWxQy2r7I4oXdX
 g2/XnR2fdrJRH3LwuXzdQoDALUq1hoGZeiJQlxDmxEZNBR420HZ/5txmRH/t+hWP
 rj0koHNwRSscV5QP0IWwSHhD5vX6NE4bEQ/IXIY2CWNZtgokQhAhz5viADKDEhmZ
 iM3zMA==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3qha8pkp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:16:49 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6798c46f723so2413479137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742609; x=1783347409;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=;
 b=IfsRQhKvnqkYcuZjR+GC1Ssx3PcKebYEeDcUUoScgZjTEdMjWoZX4fWIg2dczbpKh/
 8TbLhi4JBovqnmeNN+emWz7bNQDbyb4xJ0ylvxFbytFyoFaleFSwFHhgdR5PArueN71l
 D2JTCnvjxmg4DwQXblQIHOjLzIlP+d4TecELb/n6g/B3O3WL1K/LvAgecz1neSGpyr3w
 ySbuehWvtmyf3l/98GNtEVx1MYCj9ZPCs0sxGiv8U7Oat2xXIxGvayyimwG1hdMf1T8Y
 oYVeBCNxSEPqFANVAoDUaaM+nS4Ap8TiTOSeBdYW6gWydXKjPnaDou7HaUtM14mp7lWx
 44sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742609; x=1783347409;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=;
 b=W6As952MeP6VfK/e7aucMStoo6ophmxtNbUDuRH+fCL60EbB3dz6D9RoTI4y3ALLBg
 QkNeQZn1t5bogeMvdAwM2upzhd0jm1B+8/mj+UeefvajVJRFGV+QdhnAVcUEHZBNuaXh
 jwMK7QFuZGpdWYAOQlWRh+Pr7wI/NxCqecK70q7OB4X+83Yi+IeJPrEMvSeBV9bT4PDF
 bcYH8x5E9dSGWzRE534iE8r7ER+zSq4wHsQ4221PJtG43dggCre84flwOTPkFaRk0wt8
 Yzwt/BO8gaE+RA9fWmZNcQ35vMq1F/rfmTInA9Gu0Ru7xY//Lz7tEQeY4AbDamlT1YVP
 OvPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpU/rFN8FJMTI/QhJ4Nr3bK0kEvEFe0uDOa2D75/ZmOst7rSIzjBedCP/ILFmjTD+C/LwLIyeKXJKE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9vO8/0n8QLfQwesKhdkLmW4zgn/LL8H0IGH/ovYtBnKhJLyY5
 b6+Sf6Hmudwf5Q2exmd3twZ04NzA1omIQtPrku5zrnxdbyReo9ysF1KGA+jxpJQjgoBx/qBLnWQ
 IUyQSmBmTmFkeftM76FmXMfjOPb03Vlzy1BQFUTuMTIMpEy4RFuK2rR91fJOcYTO2VS0ZMzIGOm
 i2Qd+PQw==
X-Gm-Gg: AfdE7cnt6duKRYkOzZLz6Nqn/pmKxtCrhod0I78IMCalSA51bAww/s2qPXcu44XPYBr
 AHak5pTcJBKJTkWeun8uZRtAw2aSwFBpnO/gZPXIPgGu1wWfUsP6NeXVNT/16ae8LOG1P4u0tRd
 Ue8/e80a/K8FWnsupMO093SfRU+76qVuyDC3XgWHV4BwXhsD+hJLf9lXhzL0b+X1zJAniZancxo
 5y5lAhhqwK+gK/hTsFS6vC79AuDqcted3GQ3R8f6WAJ7Ctohfv0PNP3weX5US9W5vbbutf8yeb6
 w3QL0KdVBCu4ijBRJOdAYJpdlGw1IvzuA2UH4uFg1DIWpxroYM0rs8re3nZCrKnfna5Ek3vfbYn
 aWCc6bKsl0uxUvIpxZvM+fsR3saLg6+z0Os9jfPoZ/fp33Z3P+NiLhUQarDEtImBBvvVsgA==
X-Received: by 2002:a05:6102:6c2:b0:738:5e0:b40e with SMTP id
 ada2fe7eead31-73805e0c206mr2379944137.27.1782742608440; 
 Mon, 29 Jun 2026 07:16:48 -0700 (PDT)
X-Received: by 2002:a05:6102:6c2:b0:738:5e0:b40e with SMTP id
 ada2fe7eead31-73805e0c206mr2378903137.27.1782742602665; 
 Mon, 29 Jun 2026 07:16:42 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:16:42 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: [PATCH RESEND v5 19/25] drm/msm/dp: initialize dp_mst module for each
 DP MST controller
Date: Mon, 29 Jun 2026 22:14:40 +0800
Message-ID: <20260629-msm-dp-mst-v5-19-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=7456;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6XyUS6qRZs5X6/pKt4qoYuSBISthOP33nj+/4w99iLA=;
 b=Fo5ChQ3bWGgWBF0ZWi5k8jQ2i+CvNMg3W9DPQMRLKcyjDMZpjLyydl74DKrpXMWWhsVjDASs/
 ypflVn3ZpTvCDzXJiqZjye7acqdpx64YLx7BP+5FjeNxGLgIk8QVfet
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: SVGy6FgB4yXnBeTfTZxGCJbZWIDeGcCG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXwcBLS/1e7huY
 rvHR6DdhLaGj1tSbtEHrFn8HD/7OoFJirdrdlef/865LRmJEn/zR2muit8I+FIEJykNR4xE2HQL
 vISy3LvuvX3glE2gnbXYY1rwgf79nLwC+w4hBc+oXeGxT7622s7zWNfHF0MuhKqHHFPyJjXCU22
 G1rYdP2t7Eq/WnsJrtn0NX/cQMfjPJ/HfEHdr6YAb/ojiLucZpIm1WGdM1C9Cx8o9wOK4HLni2J
 SQtOg8NKhpMYjHui+7HyUW9PjVjCCn5fZj0+9CpHMBvfhTPtAg6pU/zhQMA0MGKbgSbCjfulGmM
 yg8DWSH5kbDSM9l8eTjcEIC5MCCa9c6FfG6axrnC35WBm/leVfpnFxziZ3+X7gHHZDbR5lYTtt3
 hnxibu2JFCQShQQYDU9aV6g1fy6oF9BZi11WxLLnSfwr/YS0KVQnU04mAKGztOmXKojNksRexze
 ydyVP6V1Z3PFNBGv9qQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfXxTtsK10f20/o
 8sWwgy/8hZrrAGxBLUDyByJDFHgYckIkDhaequ5OJgXZz6X+9trrCqZPl8BvMPvxiMC2J99HKUq
 ocHHtaoZpn2cJP0gRGY7JF9J84oQAJ8=
X-Authority-Analysis: v=2.4 cv=O9UJeh9W c=1 sm=1 tr=0 ts=6a427e51 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Tb4r1nT5KeEeR2f--GEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: SVGy6FgB4yXnBeTfTZxGCJbZWIDeGcCG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

For each MST capable DP controller, initialize a dp_mst module to
manage its DP MST operations. The DP MST module for each controller
is the central entity to manage its topology related operations as
well as interfacing with the rest of the DP driver.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile            |  3 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  6 ++++
 drivers/gpu/drm/msm/dp/dp_display.c     | 18 ++++++++++
 drivers/gpu/drm/msm/dp/dp_display.h     |  2 ++
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 60 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 13 +++++++
 drivers/gpu/drm/msm/msm_drv.h           |  6 ++++
 7 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index ba45e99be05b..d510be1c173f 100644
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
index 7a00c4094d5c..91d33b432427 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -682,6 +682,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 		stream_cnt = msm_dp_get_mst_max_stream(priv->kms->dp[i]);
 
 		if (stream_cnt > 1) {
+			rc = msm_dp_mst_register(priv->kms->dp[i]);
+			if (rc) {
+				DPU_ERROR("dp_mst_init failed for DP, rc = %d\n", rc);
+				return rc;
+			}
+
 			for (stream_id = 0; stream_id < stream_cnt; stream_id++) {
 				encoder = dpu_encoder_init(dev, DRM_MODE_ENCODER_DPMST, &info);
 				if (IS_ERR(encoder)) {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index d56ee10ee065..fc9c1e3e57ab 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_drm.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
+#include "dp_mst_drm.h"
 
 static bool psr_enabled = false;
 module_param(psr_enabled, bool, 0);
@@ -351,6 +352,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
 		msm_dp_display_mst_init(dp);
 
+	if (dp->msm_dp_display.mst_active)
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
@@ -522,6 +526,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
+	if (dp->msm_dp_display.mst_active) {
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
+		dp->msm_dp_display.mst_active = false;
+	}
+
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -1530,6 +1539,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
+int msm_dp_mst_register(struct msm_dp *msm_dp_display)
+{
+	struct msm_dp_display_private *dp;
+
+	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
+
+	return msm_dp_mst_init(msm_dp_display, dp->max_stream, dp->aux);
+}
+
 int msm_dp_display_set_mode_helper(struct msm_dp *msm_dp_display,
 				   struct drm_atomic_commit *state,
 				   struct drm_encoder *drm_encoder,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0464f8941e8d..a185819ec57e 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -24,6 +24,8 @@ struct msm_dp {
 	bool is_edp;
 	bool link_ready;
 
+	void *msm_dp_mst;
+
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;
 };
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
new file mode 100644
index 000000000000..78b8dffe111b
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <drm/drm_edid.h>
+#include <drm/display/drm_dp_mst_helper.h>
+
+#include "dp_mst_drm.h"
+#include "dp_panel.h"
+
+struct msm_dp_mst {
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp *msm_dp;
+	struct drm_dp_aux *dp_aux;
+	u32 max_streams;
+};
+
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	int rc;
+
+	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
+	if (rc < 0) {
+		drm_err(dp_display->drm_dev,
+			"[MST] failed to set topology mgr state to %d rc:%d\n", state, rc);
+	}
+
+	drm_dbg_kms(dp_display->drm_dev, "[MST] set_mgr_state state:%d\n", state);
+	return rc;
+}
+
+int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
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
index 000000000000..5d411529f681
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
+int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux);
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state);
+
+#endif /* _DP_MST_DRM_H_ */
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 5fee0b291059..963303079220 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -356,6 +356,7 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_register(struct msm_dp *dp_display);
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -377,6 +378,11 @@ static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
 	return -EINVAL;
 }
 
+static inline int msm_dp_mst_register(struct msm_dp *dp_display)
+{
+	return -EINVAL;
+}
+
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
 {
 }

-- 
2.43.0

