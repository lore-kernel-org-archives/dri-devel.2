Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2224AE99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CCDF10E929;
	Fri, 10 Apr 2026 09:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DpmeUKRG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IpPgED53";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5298E10E92C
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:39 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A5LdgB3352591
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MmC1jrH6R/pEttUTO6gaSkswPeGvo+UHEDKw4bXdq9A=; b=DpmeUKRGn85CoMxN
 Ze7ZMwGlgeuszclH9xbNbT4+Qs+r9pcpCUF3Z4ySr1v1LS96Fuorat5QOpaLQB/l
 BG6R+y0YVGuyirRamQ32EzX1v5TQkbhfVjbpN74VFRTpPfv3GSrgquVsvaZ5ExTy
 Z56+wOzVkskbhS5qUV/GP6D4/jo7f2jdO5hDZND9kSKDvwLa1gsgiixRbWtJVl2J
 ESdyn6/+h2LmIt9ywlwszOZkzAJZkk5D0Tk1yzf28lK487J0/xTTnlf634ITI4qR
 R7an6D3oS7J8U6Uc0fy2HWGcj9yhhUXY+OXpqrP2sKswgzu45eimRcvB6ywZidUv
 zmJisw==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dec1quve0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:38 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a5f6110cadso53299816d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813798; x=1776418598;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MmC1jrH6R/pEttUTO6gaSkswPeGvo+UHEDKw4bXdq9A=;
 b=IpPgED53wv1wuIL1Tbu6eD6TQ4hNZu4EXTNaG4dyEwRda3/0W1drEJnYZWQUz7WXQQ
 LphWIwZTLttpUBk/FKnxztITQh741vgUPnKnxWy43/1WvSpz+Ac999wUHdEzjeTbaAzm
 gipJGrCFo7hoJKWkIFlsRc840igOUHFAkiWXst9OAToFy9S0WSH1CFHOsOY5nZEwjh9w
 vFeDl8c1ynU0BxRoGvVBcYBEYxASCwYWHoonaptzFw7Tzo1+p5DXTQkNGXLrg46qijqZ
 f6D2P6hnxjpzCIOPXqmePS4mSu0lWE6p7bp0c18ETyFwaTSDc0BUKr/KfG58R5o8hDdy
 aKLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813798; x=1776418598;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MmC1jrH6R/pEttUTO6gaSkswPeGvo+UHEDKw4bXdq9A=;
 b=VjW8b++2mGqzzkGr92bI+w7wxc9i9HFeYkkYpEFK1ZT0d4fLGxGrElj8FomuapiPIK
 b3EH+2PcSbt96TS/AAKRoAOBCcgmQJDir/0utoVHKanFiV8cpWjI12JRoM90sqDRW9PR
 3R+auyisie9DKxiv/WCxdnf2otQUJyNToI7nN9SNnvbdc1OqTzSvx+liULqQGTENooeh
 3zTjW0SUAA0W4Xb8coBf3BJ/gZNQwhLwRRF2gB9Bc3Y/FlD2Wr8iSCPopzseIcWYHmSA
 q1ysF/+bKU85f+hbdI0stpVzJRvRsIncZpKCNSjoFlFx8dxYteJUB7y4N278VkOBYOFA
 f7+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnY2g1KGTNPRWiF8RO1o2EqRfEwEKbj4BruuF8c0oGDrGj51y8r/wd8ra1aYKvslXuhKL6K0zGU94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwaQL8MsZCl1i7YRirssC5yIsQ1eihmibbSRp/QHGOL/8+cBBeI
 5/mPpeZiAxrTA5RWVXKaKSaMcHEKriBABx06YFxnnZ49tqwr2JmP4+q4efJ5tSGlnKrkRm+ePg4
 QA++Nu3c+oZdEZULYzec/BMpJ0VJPiEz7idGbrFdEenNQWkS1/xYFNtJ+6DP3EOF161K/e1c=
X-Gm-Gg: AeBDietyuf6uNkWbXRmPis23QeOCHUcAQ1dzgv6Yps4aK80Y2FriG5AZ4+0tBkp017+
 LpwE/zdobBp0WRLzB68AacczrFnroE3i5yD2W9w32Mw0hI5LWWphlemrYrU2KdyNJTYoG+IZ1iQ
 CN4dSOjVrEYBCg35ElATPk+zfsdpv+KT3dodvQcWCCIFEWiPPQlaBvUvA092nOyqp9hjT+3QKgy
 Y0FWRBS1fzacNHSmr2KicRfldRVqNeadAeOiZJZeXocnRIwkbWrLm1dn4qYGJRkDKyh4T1k+DHF
 tRHJ8UKrgR/ZOh53gfm5Eckv4zpx9M/ZNekPcH4lyWXii54F59a3YWapZwycqCigABtFD47kVv7
 +kY/2y7zBHd9L3stT5HIX3JYaJYZ3owE9YPszKkbYMFquhpJ9iqku6pdPtHEFaRvLq5sUMkio8D
 PYh9ldiYg=
X-Received: by 2002:ad4:5f8e:0:b0:89c:e4c3:dc2d with SMTP id
 6a1803df08f44-8ac861632e3mr35335326d6.2.1775813797702; 
 Fri, 10 Apr 2026 02:36:37 -0700 (PDT)
X-Received: by 2002:ad4:5f8e:0:b0:89c:e4c3:dc2d with SMTP id
 6a1803df08f44-8ac861632e3mr35334956d6.2.1775813797186; 
 Fri, 10 Apr 2026 02:36:37 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:36 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:08 +0800
Subject: [PATCH v4 33/39] drm/msm/dp: initialize dp_mst module for each DP
 MST controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-33-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=7877;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=3YFcKvp4gwFyNQoOPReMX/pBKXIsYYad0fVFQsjwdrw=;
 b=xzEHEx9LRP4bApsuxgDPtfUxqCk950DPbkP8A4bTihZLWfXceaygJ2EfZGU8QtOIETfQC08cq
 KJUvJXOcnn6DRKMlZCH21IZSwJgVLsfDmSCFx4sb4bWgfJBvrZfL9fl
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX7Qq49KjGVcLD
 WmHOm9z1JF4JjQanN+4gOuHjQooOnA6Y2hiCfNIRSE0Vjbmv872tRG7hgrXgTlJv5JB21QryCQI
 9T9beF9qPUOLKx6e1JN29Bi6K4OSirGXxSqKue9FucWyu1c9kIbF6vfMrYKdSLsfDks8VYCN2zV
 O3fx+Wcvem7RSx1/SlQ333QE3vaYAS5tShVzpe+M1iMXvMssIlwNAPLzJ8JF3kg2rrMVECSO4i4
 XyNEm6QdzJJICSP+KeFuitwcc92qVTudnFJEcvDbfREyl/a6V7Lb8VHDWnAuogCHIMO1sOas0jy
 z0i35yGyKVISnuQ/2yT8YfSRJkgYxMu7bUnHUPSDf+nmZoA2BspgG9aPgsgyzkwh5YRcxxkjKmm
 icnoI1Ix1Aq4F8UL0NOd0kmxNAPPeCgcpeFSfIKbEcO8glErVkdA9uuD+mfTOJtYQQTMSiHNzLq
 4S5tQlBpDmVXRbYHdWg==
X-Authority-Analysis: v=2.4 cv=eOcjSnp1 c=1 sm=1 tr=0 ts=69d8c4a6 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Tb4r1nT5KeEeR2f--GEA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Rdx2la7One74qKIhH2bLO8qDTgR1rr0C
X-Proofpoint-ORIG-GUID: Rdx2la7One74qKIhH2bLO8qDTgR1rr0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604100089
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
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c |  6 +++
 drivers/gpu/drm/msm/dp/dp_display.c     | 18 ++++++++
 drivers/gpu/drm/msm/dp/dp_display.h     |  2 +
 drivers/gpu/drm/msm/dp/dp_mst_drm.c     | 73 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h     | 13 ++++++
 drivers/gpu/drm/msm/msm_drv.h           |  6 +++
 7 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 8b94c5f1cb68..1d8426876aa1 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -144,7 +144,8 @@ msm-display-$(CONFIG_DRM_MSM_DP)+= dp/dp_aux.o \
 	dp/dp_link.o \
 	dp/dp_panel.o \
 	dp/dp_audio.o \
-	dp/dp_utils.o
+	dp/dp_utils.o \
+	dp/dp_mst_drm.o
 
 msm-display-$(CONFIG_DRM_MSM_HDMI_HDCP) += hdmi/hdmi_hdcp.o
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 090e7d790593..d7ce13a4586d 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -680,6 +680,12 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
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
index 9eaf6994a350..919767945ba5 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -28,6 +28,7 @@
 #include "dp_drm.h"
 #include "dp_audio.h"
 #include "dp_debug.h"
+#include "dp_mst_drm.h"
 
 static bool psr_enabled = false;
 module_param(psr_enabled, bool, 0);
@@ -360,6 +361,9 @@ static int msm_dp_display_process_hpd_high(struct msm_dp_display_private *dp)
 	if (dp->max_stream > 1 && drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
 		msm_dp_display_mst_init(dp);
 
+	if (dp->msm_dp_display.mst_active)
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, true);
+
 	msm_dp_link_reset_phy_params_vx_px(dp->link);
 
 end:
@@ -527,6 +531,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_display_private *dp)
 						 dp->panel->dpcd,
 						 dp->panel->downstream_ports);
 
+	if (dp->msm_dp_display.mst_active) {
+		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
+		dp->msm_dp_display.mst_active = false;
+	}
+
 	/* signal the disconnect event early to ensure proper teardown */
 	msm_dp_display_handle_plugged_change(&dp->msm_dp_display, false);
 
@@ -1556,6 +1565,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
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
 				   struct drm_atomic_state *state,
 				   struct drm_encoder *drm_encoder,
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index bda76319c459..55874daf41c4 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -24,6 +24,8 @@ struct msm_dp {
 	bool is_edp;
 	bool prepared;
 
+	void *msm_dp_mst;
+
 	struct msm_dp_audio *msm_dp_audio;
 	bool psr_supported;
 };
diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
new file mode 100644
index 000000000000..b6c7b8211025
--- /dev/null
+++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2025 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
+#include <drm/drm_bridge.h>
+#include <drm/display/drm_dp_mst_helper.h>
+
+#include "dp_mst_drm.h"
+#include "dp_panel.h"
+
+#define MAX_DPCD_TRANSACTION_BYTES 16
+
+struct msm_dp_mst {
+	struct drm_dp_mst_topology_mgr mst_mgr;
+	struct msm_dp *msm_dp;
+	struct drm_dp_aux *dp_aux;
+	u32 max_streams;
+	/* Protects MST bridge enable/disable handling. */
+	struct mutex mst_lock;
+};
+
+int msm_dp_mst_display_set_mgr_state(struct msm_dp *dp_display, bool state)
+{
+	struct msm_dp_mst *mst = dp_display->msm_dp_mst;
+	int rc;
+
+	rc = drm_dp_mst_topology_mgr_set_mst(&mst->mst_mgr, state);
+	if (rc < 0) {
+		DRM_ERROR("failed to set topology mgr state to %d. rc %d\n",
+			  state, rc);
+	}
+
+	drm_dbg_dp(dp_display->drm_dev, "dp_mst_display_set_mgr_state state:%d\n", state);
+	return rc;
+}
+
+int msm_dp_mst_init(struct msm_dp *dp_display, u32 max_streams, struct drm_dp_aux *drm_aux)
+{
+	struct drm_device *dev = dp_display->drm_dev;
+	int conn_base_id = 0;
+	int ret;
+	struct msm_dp_mst *msm_dp_mst;
+
+	msm_dp_mst = devm_kzalloc(dev->dev, sizeof(*msm_dp_mst), GFP_KERNEL);
+	if (!msm_dp_mst)
+		return -ENOMEM;
+
+	memset(&msm_dp_mst->mst_mgr, 0, sizeof(msm_dp_mst->mst_mgr));
+
+	conn_base_id = dp_display->connector->base.id;
+	msm_dp_mst->msm_dp = dp_display;
+	msm_dp_mst->max_streams = max_streams;
+
+	msm_dp_mst->dp_aux = drm_aux;
+
+	ret = drm_dp_mst_topology_mgr_init(&msm_dp_mst->mst_mgr, dev,
+					   drm_aux,
+					   MAX_DPCD_TRANSACTION_BYTES,
+					   max_streams,
+					   conn_base_id);
+	if (ret) {
+		DRM_ERROR("DP DRM MST topology manager init failed\n");
+		return ret;
+	}
+
+	dp_display->msm_dp_mst = msm_dp_mst;
+
+	mutex_init(&msm_dp_mst->mst_lock);
+	return ret;
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
index 3061eca49cb2..5f73e0aa1c2f 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -363,6 +363,7 @@ bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
 bool msm_dp_wide_bus_available(const struct msm_dp *dp_display);
 int msm_dp_get_mst_max_stream(struct msm_dp *dp_display);
+int msm_dp_mst_register(struct msm_dp *dp_display);
 #else
 static inline int __init msm_dp_register(void)
 {
@@ -384,6 +385,11 @@ static inline int msm_dp_get_mst_max_stream(struct msm_dp *dp_display)
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

