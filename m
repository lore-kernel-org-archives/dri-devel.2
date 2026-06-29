Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128F2C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B91210E8CA;
	Mon, 29 Jun 2026 13:18:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dEJwNika";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bSLl97K8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AA6610E8C8
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:08 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATOhY2619318
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=; b=dEJwNikavyA6bXL4
 SNw47lnNppd/bM9glrfv0J4e6p2pVFgTRmcBrq8AjsF3pSje8MzFQ5Zi015Lw0T6
 6W4XMmCd+rzFrTHsY2uHgdduftiQc2C0Y1BwjCOPyZe3bELiKWPQri+L8NTi7eKD
 SYpybFNd7VU/26ojk1Fe5NBYdYDFD7ZxjXxVomaBOYT/kB+8hWPxUpPQ2b9FRkuv
 O3duwTr0itkrcV+DIVrx7ZAjdbGGmGFu8AK4shprYYGyDXgPzJC1elaAioLCSkcQ
 2g6kmKNNv/AChMWSl88wpX1Mx6XqKyplnxfJSYApCX1tf8j6kfgK0g1QPLoMv8AC
 ZwRf+A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3pdkrrrr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:07 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-915d3261c5cso699282285a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739087; x=1783343887;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=;
 b=bSLl97K8gcc/FMaVfZHAWc4vYOpVeps+5dJWiVHslSKh6z9LDpeWgm7zlZyuZ0D/a5
 2iHT1htx1UY42BWYHhcXruwcU0914c4EqHXV/Ae658kpeB8IBQpRFoj6kIwpWx7Uqb7r
 DPT2vEsL4BcWBBhKAfBpMps2lal5LQWB/lYR//9zBTiajl94yv4ZiVsj1Upq2p6A1A/g
 2oLVyzfdOXRvt3K3rX1M4LprXhRuQ0CSK3uduE5ojdHaiWfWuxB8/cg9BK9WLbxZj9a2
 JX9DtW42g0cY1/9Nie3v+7Ckr7iHkij9+7btygDswHzFZbxGid4aX6tOt6MGOjVEDHoG
 /GCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739087; x=1783343887;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RTRODGoRdiTbi9v1uwQEXTif90CmJA2jnvlNqKTiqQE=;
 b=cHc3xLZLn/My4/WblkCBsThbuxUMwyW4pfEFY0V738FLzG19qnFF6b+i+MpzxhJ4x2
 RuNR7KGEmG2ts8RwSb/vetKDJgUv8tc79g8LvFrRlMIoe5MEkgfDLOAqffn4CkMw5zl4
 y/Biyj9RBS2cSOYYTIKWKjA2+1HAmQmqe/kHybAoz5Cm6SaY/xelV/eQt0cdWmCBgswS
 8dPDptLQy9TPfJlzrh6i5SRoKsQwpoMv3FU4lHkVj3gzTPM1tzsTyLuNpVphkG0pAQb3
 qTuzZ1vaqcVJNYzkGlIMIYTxljmpwc8ED+ITkaU2ztftoSRbzpaHlYPYVsnLYPAe587U
 aFsg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SgmBJaRL482FKaK08LWBTkC3PY/E8eA8r/xfQjjvo1KsbmUqk3zv6LWsxjkFgpu2Ga9wEmv1NVho=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyPWPY1YPWr6CXuBv8s45skkfCETunySFNUjX0ZrQtX5Ia2sJnC
 Nhp7cWl2x/oU724C4+nCU9DdsPy4m/JH/jao/pBnAZ/BMlpcQFgiB8GV5+G/XhyIFIjrz/kWFcT
 /mJh2v2l8UUcgMvSY2y0HA97xEez7b0jLRtYKJ9ItlK1HozaTlvYwppSh9yMiD5rirXa07Ow=
X-Gm-Gg: AfdE7clHop9LNNVAZRXGu92uFmt7WE1EKfTeIx1ocNne15s8OgHwiuxAV7gDUu6IED1
 37e/EJtkW0a+dGAUmNVNzaE8WoHKuJBWaC6imp9LmFrknaQzA5/Dz1HrclxztlRQjpE0JxJHWRV
 OzaIpRYePLXJxls1Gj0BmdhXWgYesQbAimqzYMo0sVaFuo3kHsFLSuagV4FWqlJ9usl4n8xoNS0
 mTFV3nCXPhMT7cS2mht9XI7kiQLg1oLhWU8AQhET6/XsjbZXBlMSslMdp2vdEw+ZpVYKFPiB939
 dNZEVtnTsGfUUXWzbSgJXMMSR73llujhaa7zYGD/aHz8Xxyi9eZUQr5gryyLudvA4SPXmgxM9pz
 TbuqZFjERm0Z8cuQxDHLNl9bYDx1KnZZLqB1XeQwR9dZTkwS2AupG14B4y1VNumPPA5VnCP0GSw
 ==
X-Received: by 2002:a05:620a:318f:b0:915:a457:bf94 with SMTP id
 af79cd13be357-9293ddae9c5mr2651653085a.48.1782739086574; 
 Mon, 29 Jun 2026 06:18:06 -0700 (PDT)
X-Received: by 2002:a05:620a:318f:b0:915:a457:bf94 with SMTP id
 af79cd13be357-9293ddae9c5mr2651643885a.48.1782739085994; 
 Mon, 29 Jun 2026 06:18:05 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:05 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:37 +0800
Subject: [PATCH v5 19/25] drm/msm/dp: initialize dp_mst module for each DP
 MST controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-19-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=7456;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=6XyUS6qRZs5X6/pKt4qoYuSBISthOP33nj+/4w99iLA=;
 b=50jbqliHDtGlXbwJhIhm/V5+mXrBDp2j2PNZemFj0YuQimRgyFsYJa+UsI9mvdPcbz34NzROT
 s9l55lC7vhgDSNmEvClQl0lrXEmMeQybjnD2N5MUHNlw4xY9v2l1VYe
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=R8Uz39RX c=1 sm=1 tr=0 ts=6a42708f cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Tb4r1nT5KeEeR2f--GEA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: ynygXhCm0MqIJtibsniCI5_IIRtOxa97
X-Proofpoint-ORIG-GUID: ynygXhCm0MqIJtibsniCI5_IIRtOxa97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX2MaQl99GK9C3
 ikg0ZAHY8u4gf2kI9yxW44rqErzFehdzhpd9qbAXrNg0V/EX6MDMSBnGjBIHCRnXR7qJv/1qj9L
 qy4ctKM0wsIzZtpx1MHxVNlwmberebqwOUXMFe3bLBXPt5ItC+OkUlnPLcTt364jniwQJC4mAyj
 dqCa/CMKUuO/4X3bkRgo6DxCVui0QT3vteJZeiTak43I/JKJjumekqBIUUn8jUxh9ivx7CAIHQd
 t6w5VPXEz5A6Y+T82lWk+HuVXVdLiYiYf/ksv2XBfJu0lWnCGk7PORwKU9bXlk6CWf8L0BbcKdO
 MKAVv2+OuVINNP+t15u9XH6do/qy0UT5nHRvuAhe2/rh/lBzU25I2gWHaZFT4yhAaBB9tw+2B1g
 OyspQj9+O9Xee+1szcT3gaYRFTyx3I/k+fYtSe7VJFji6kMqHBCqAJXwehqZtdaTDu9JTP8omuR
 lxeB+ZLKFfw0OYb2oeQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX5BAC7bz6EIpF
 Hr6TTAlr08uFTniOub0B12PIyptDQqg8XBemm+F9/5UAeM+vikdqOp1+wOytEvySHO8s2UGuLlo
 seOZ/BjayHb/fWGyjsh4NoudBzYVBi8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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

