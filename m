Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56B6E99065
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:34:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F22CF10E902;
	Fri, 10 Apr 2026 09:34:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJqiNuFM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XW9NLFie";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2AF610E90B
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:24 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A4kWnL2698454
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7h2ubxib4+P3xl/EpXUQFk46aXZCl+6yefZzWfhblSM=; b=UJqiNuFM6WXic0MI
 WUasUaEiZ5hkXkcs1ErQq/5N66CBJQNawudi0WM3HJV18na2iEQcGggRYa371pt+
 oaOBewQamRRUSDtrlXTpWaMavL8fVqz68Wtsr94HTVFrtvI3KUzsFNQRkld1g0EY
 ChUt6c9F2x+uQvxBsdsWiXyCFdKOa1W76OulD6NCTCAti6swYjsFFZCh/oix1euP
 vFf1xfypTE9lC5sfIXvyqgKR6iMop6DSa3z5mMZPVlpIfCGyxhn/QaqNJDx9giR5
 z2Z59r9WUMFuY/+VVh5n+q0kCNSOVt/rnAHLFQ1LOG2QLFI0IDZOlMIwQRU55Pwa
 pQHPgQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tje3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:34:23 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8a117472792so27704136d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813663; x=1776418463;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7h2ubxib4+P3xl/EpXUQFk46aXZCl+6yefZzWfhblSM=;
 b=XW9NLFie/WOnbnviCvv9xGQBfZITl/7xD6uX4ImR7+B/FZQkm5baRNK+dg5dI6aaAp
 2bLEzQCHgK6uWqschbA6/h2QCc8DJY0LPYs6UpHh0Lq5QDMdUBOwOXngQH6buzBzxg+B
 wY7bwe92qYRCaS1NOlLcPOGPEKAYFUXq8JKdtyrXyGQ0Aqz0aLVI6+2qjJoYZIgw20kN
 5sNuZZsoHfuRqodoVpIZqIQgSRm2aTppX8TmDhaNo+1sK9VqQa1P7mv7KS3WYHg+jus5
 OtAV3szwDmpGy36zUjnfDWKeir8651eiI/ZLTQhrjbnz+Tu+JqRL64dFlZtyTisGIFub
 ddZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813663; x=1776418463;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7h2ubxib4+P3xl/EpXUQFk46aXZCl+6yefZzWfhblSM=;
 b=bRALVqSHojwzOQSfMbGWaBR5upcjaAYusYNDB4GHVjWvyb5zM79rWC9DsLOIErQwwO
 WX8A2p3Vx2BvJjrcYOteCGGXmLdbD/a8Q/mWRqPDZr1ZDgx9+tXR6RBYUe0yTrURaqUA
 mITsnJmK0Ugi36dx3Zf5N888+3ZHyUA0H3y1mCKiEE4vWBOd3YOE8qvMlGjuMLjV+Elo
 ct5L2d5YdonvNYX0jEUubDdCiVUGDasyrXERExtjzwxTUWuMudqct+IpiML2rN0Y76pm
 hRlTDpNoUIsvibJQY2zDAKpLJY/OWSNFl8O1vuLkyy7z1wsqtVrPLW7Y8YrzWPnfaIoY
 SpzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVulMfT3D6pfpf59vLSI0coLN0MWwAiAFVrt/nkMlAw1JqUlJKcWuX8F7i0foVYlgq0weKaLswv9hE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/9dLyVnDwzJFunYNi6ZPHNoTUd9mbAl3LLi/I78jRQxysYd8/
 j7CAX8A6KyEyxJ/FHJx+Ws6DNQlmEClzStwiDxJwB6Gw6cvQwSGeD46VTI6tjgrOoJeoqbfyLBU
 hMtAUSxIobMYIy2rk77ekROnFm/4M/7Wup2EvPnfHufh9visE5gEbDMuzdFb7iT+RmdDRcaY=
X-Gm-Gg: AeBDieuWIQZu77BwF9yj45QMV6C8YOpmpt8aPFmJg+PQWX69pMBq76r4ZQvvCRkNGhq
 khnFQPO3kDxK8eA2dlZSJ9t6PZgQ2koNqFiEm5YqqNNxBDO+dqQKi1go70kicv879sNv6F/n6IE
 z7WwRAxlzmVI9LG0jRsGx6OFwkjSRln9tlZ6qyyyQ9wh4nZKy5Prz+GCufWlQ0kfuBDTgMknjV8
 vKE05lsTKhE2J/iiGFfRRdvItsG4TaLEsTg4JeRyo0GUOr7erOGvrRStytNdShBHM5LPVJK40h0
 EPf6EqJryOeTS8bt7hsHxgl4So03a6lS3PEaCK0j1rsPWf5cA8U/uq3KI4UWt1nna5RbWZcwynQ
 pfKMpGQS7KTpgq+fMPE1UIooNY8zUVsOGOd7fe4ExEdW5mBtIhTa9uDo0F94638vFcUqYfx7XA5
 pEjdG3agg=
X-Received: by 2002:a05:6214:3f82:b0:8a7:1498:5f67 with SMTP id
 6a1803df08f44-8ac86106cc5mr32395606d6.18.1775813663257; 
 Fri, 10 Apr 2026 02:34:23 -0700 (PDT)
X-Received: by 2002:a05:6214:3f82:b0:8a7:1498:5f67 with SMTP id
 6a1803df08f44-8ac86106cc5mr32395146d6.18.1775813662772; 
 Fri, 10 Apr 2026 02:34:22 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:34:22 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:33:41 +0800
Subject: [PATCH v4 06/39] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-6-b20518dea8de@oss.qualcomm.com>
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=+7cU1V6ZRhvWTG/SKpP6TFbrSez8ukI57faMvb2HD5k=;
 b=LCulurXQCSKN0x9TrouPq77gILySvl8E7N7vxJB4Uvnj+KQ5odYyAMqe4OUUvcle5+iaABwJw
 idu4XOz57scD+43PuOg3QQpZ9iIKJQ0ZFMzGW64oI+tK7hI6OSU+edt
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OCBTYWx0ZWRfX5S1b6aW9YDBK
 qj6+EZfIRcY4ECJFP2Kz9Do4ya2yQX1E9Bgtzn3Xl1HfwdPzpew2cW6S/dOxIovIPkL+oJzuBg2
 cwnN9FHDIoRuVenqg8xGMISdl5ieQp1Wvja3KX8aiJhWiwZoE/u9uaWyJqQLDgUmr1XcQmr+bye
 wSAlyQ2SrHzNEn0TD1+folLCNDdrkl61pbW5SjQaRuqWF6gYB8rGuWFhIPwdsSGgRsOOydPAJmz
 t7FUDrPETxbM29E+H4TlYEyHig8E+xf1nIeuN1tzFhRmoVuTdaKI+R8vY+Ke06fxpKZKzhdaNyd
 OYmjw+NtT+J5i6pGfiirCh1fKAYPtGsjPaWekUfAcsy6qGZZYZWQEANZfJQZqASRtRAoX627ltk
 1UayovGsmV7ry+diDu03fgJ8TKMNMAaoOLB2GgEcwuyqIMQMRvu63eaWAQMxud3aoD9HbEzKV30
 fqnlIBA38RPThqXs36A==
X-Proofpoint-ORIG-GUID: nnMJ_z0KiwSn1p4SSYgwtfE9HQl9q1_m
X-Proofpoint-GUID: nnMJ_z0KiwSn1p4SSYgwtfE9HQl9q1_m
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8c41f cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=kqER-IEIHq1TX1bzL54A:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100088
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

Refactor the MISC1_MISC0 register configuration into a standalone helper
function to support MST.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 85315467b5d0..fd6caebae148 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -455,17 +455,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
 			ln_mapping);
 }
 
-static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+static void msm_dp_ctrl_config_misc1_misc0(struct msm_dp_ctrl_private *ctrl,
+					   struct msm_dp_panel *msm_dp_panel)
 {
 	u32 colorimetry_cfg, test_bits_depth, misc_val;
 
-	msm_dp_ctrl_lane_mapping(ctrl);
-	msm_dp_setup_peripheral_flush(ctrl);
-
-	msm_dp_ctrl_config_ctrl_link(ctrl);
-	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
-
-	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link, ctrl->panel->msm_dp_mode.bpp);
+	test_bits_depth = msm_dp_link_get_test_bits_depth(ctrl->link,
+							  msm_dp_panel->msm_dp_mode.bpp);
 	colorimetry_cfg = msm_dp_link_get_colorimetry_config(ctrl->link);
 
 	misc_val = msm_dp_read_link(ctrl, REG_DP_MISC1_MISC0);
@@ -479,6 +475,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
 	drm_dbg_dp(ctrl->drm_dev, "misc settings = 0x%x\n", misc_val);
 	msm_dp_write_link(ctrl, REG_DP_MISC1_MISC0, misc_val);
+}
+
+static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl)
+{
+	msm_dp_ctrl_lane_mapping(ctrl);
+	msm_dp_setup_peripheral_flush(ctrl);
+
+	msm_dp_ctrl_config_ctrl_link(ctrl);
+	msm_dp_ctrl_config_ctrl_streams(ctrl, ctrl->panel);
+
+	msm_dp_ctrl_config_misc1_misc0(ctrl, ctrl->panel);
 
 	msm_dp_panel_timing_cfg(ctrl->panel, ctrl->msm_dp_ctrl.wide_bus_en);
 }

-- 
2.43.0

