Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAD1CD6E4A
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27E2F10EDCF;
	Tue,  2 Jun 2026 09:11:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JUufF27A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LVV/i6th";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B83CF10EDD0
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:46 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6528RCDj3430076
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=; b=JUufF27AjkSwlUqw
 Insnk7c+Z+YHrWCvAUts5brdKPfLi7qWo9keD74aDxhLFgg7sOpsIO+qKHt5WYhd
 5J2P4W2IJpiR98MjtgazuuHkCCoY8dg9p5y8Rfq/Qye6D1H1OzO8JJKOloRAI9wO
 rvaCZnnGLtV+8wOJm5sksgEmMeZz1B4B7pbU04cCLGKv1CbPcSFugsUcylk+u603
 4TwhqbUQooCWlT2zH8iC/6Of6dpWIVLGx57+uwQEBkl7bBPlRW7LYZN5q8WCerlm
 VCMDqh7IVNrO7Wq2RHklDgIzGwBKzZ+r+gMl8akkwX8aEAd/QPltqaOxfIkygtk7
 Rwnk3A==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehn8mhq2m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:46 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-5175842d1abso38453031cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391505; x=1780996305;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=;
 b=LVV/i6thWpZ3sS2qslK1V+6gOjPtue/hK/k05h+OrC6N6PH4Ni2lVYTCzxTH0aoi9I
 0IkKllZjoncQ6SU2EmXvVoTlGuzHbF/H2O5dpy1Ptc/BhPlS9NotNZHvnk+77f0rtB8B
 FYL+7+SVUlp3/pvEHayRB0HJb6xcFZl4aFKmGFS+Som5ox+04VeL+ZC3oZM/Sj45N2M4
 7RqZcHe2B0/5RZ3bBaZ+jLpc1ul34Qw+XvBZ6uh4BFT+Zuq35CQWeaLKX3O8MxNgQlVS
 2o1KHkyb6urkXTttilk92DC/V0sg7eNhTsGl73jx+jzr/NrolsrQiRFTMPTI54ef9FND
 3xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391505; x=1780996305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=w64aJR4GsiijIIC+qw1V7Ljp4DhfTK7YqGC8ys2CQuk=;
 b=Iv9aWmykZUEssJFz8gQiQ3VfD81E0gjLU06zQweg/JkUKte9xSrztW2Oag4CcWshbL
 4KDB4fzVTuMX3FuHeBPl1gCSnzMAZqQYXp9VipBqENqs7PCorFpHP6Y3PuLAGZwNJrMo
 zafsRdAyaQ8i5bsZbaF6SN+5yX0hQLA6eoDKwp2eZwpwNdo7pfzUueMTeEIEBu/fCyId
 f+dZggVd01R3wzlJ5OrWwaV8I6aPIcs6o8302Zu6WnSgJmwHTmt/xQAvq+NuWIGruzTZ
 i4lZIrfD+RYAHkRZUulnvv8ZoIY5/fgDGKr3dIqxxD5CbP1PhOhg75oYnkrHussGGAho
 VQyA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FsorE5edqHvw7BEnz4hkzIhfz09HF7jvy5y7FBlt+YunKuTTo+KWhs/ukTO/3iGOT36vuPXw2Z5s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsS7t+9teTTsssSStlpPf1vHOQ1hBdcQe4m3wUMO6mcRZi7+W9
 92r2UODL4G8BsuwrakMa4UtHUP1jrRUT2Lf5TmovexoAAkokHwrYhUE7BI5D+c1bMSM+dQjDSjF
 7Y8OL62OHoYTwjcx0Coo3b06IVumY0tq13rWjUHH5AJJapO115/fdWXGqfnx8U594xhpUI3g=
X-Gm-Gg: Acq92OGz//fSWXdlx8MJJ9dAWENWLb7b4JPrLtrKstYVoulcI/oZ9pLd9uWJKYf3use
 lRtJ/+9RZiUjNsfMBjFZmVdTcGNa5SUA+3ps5u+GIJavyEzojU+rdpe/drBQCgu9Vm7sRzUvJZ8
 iTARWH1Y2OSbek+7W83FcNycWsP0mJtwl2H9FB+vw9vkIkvOmWirIju7ThjgF4Pxt/4X+bGR5zg
 OAU9bkh+SdzwQ0agas/rK+cGecWjMu++sFc9xAZwPofFxi1x66kfY5MjXF1xkuvw901APODMkR9
 QVUZA4FTEMM6NFLYa30FtLFs4Nhn2dZHhfV2exS6t3EmLO4yd47/zkpDGDx8XaH0waon3bRKgE6
 KXB+I2kq5+HoxWDc82OzMrzZu1J7proLwmb0ZTszFcfxYR4AFSfA1E54bFLoaXloqm0jXAHb76w
 jfsTtQrokvu3WcxnFWAQ==
X-Received: by 2002:a05:622a:1812:b0:50f:c9a2:1643 with SMTP id
 d75a77b69052e-517662835efmr36172901cf.11.1780391505055; 
 Tue, 02 Jun 2026 02:11:45 -0700 (PDT)
X-Received: by 2002:a05:622a:1812:b0:50f:c9a2:1643 with SMTP id
 d75a77b69052e-517662835efmr36172701cf.11.1780391504654; 
 Tue, 02 Jun 2026 02:11:44 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:44 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:17 +0800
Subject: [PATCH v6 05/15] drm/msm/dp: extract MISC1_MISC0 configuration
 into a separate function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-5-2c17ff40a9b2@oss.qualcomm.com>
References: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
In-Reply-To: <20260602-dp_mstclean-v6-0-2c17ff40a9b2@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=2097;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=k2Fff3upCougTurRhx1qk32jaQDI5eLSE+rUossKmgQ=;
 b=i05DXxqApSBHDn24Y/faO64tUx0fwhQhNrJN23hr3yxu0q6ThLoselo9pXKhvx2pg3MCF6Xpc
 uOM/uL5oVQKBuNBbQTbinDYz8cOaqbhcNVc6RquNhHROUM7d9+u9qWU
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX4JVtIliut38L
 GurVjIJaCjUOpRjpksrN1o2qtTlsxzVQVfE/KZl59yGJMfG8K6GadhKSIiHX0GkjUcPh0ZJ/R2U
 cwEzVFR4Qzl4zoO/KfA7r3coRUi1N/0zJy+DOtrV8vSG/NRpnkqTTgY5IHlQD5EDelgTfz1NbLX
 ROy0JqDkep+RuPwQNyJRmVBtepwZc8ZzdsjKAlLKQp4Gk0rHM5ZPmGpvFPBWg96LkWdPCnFG4wI
 A8LU1/G81DIjHW+kla7z4P5KslVCA0T8lKSvXADxk1jHQubPw1JtiD3WeG8TbaJUjQx5h9+kxyv
 QNZHuyMQhKeVt5fPHNO7NA5RbqJrKpeMK+ybzHGGGdZD4S+bUJFqQMozmcKVCOx0gWpLQkmkk1B
 3lKlOnpXVxVop4tzGcLyQdFRyiC7YbUsYbCABot0s/xahV/hQJk54TlPUBfouTRKUuVOtJDj2xu
 aYYj/A560S8zs6RHc7Q==
X-Authority-Analysis: v=2.4 cv=d5nFDxjE c=1 sm=1 tr=0 ts=6a1e9e52 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=TC1OlXllJ9dbkp4NpB8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 03ZafrzQQBB4Q6Kj7Xy2PcmvIm4DjjLv
X-Proofpoint-GUID: 03ZafrzQQBB4Q6Kj7Xy2PcmvIm4DjjLv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020086
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
index ed2ba47881fd..71d45b2c4daf 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -458,17 +458,13 @@ static void msm_dp_ctrl_lane_mapping(struct msm_dp_ctrl_private *ctrl)
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
@@ -482,6 +478,17 @@ static void msm_dp_ctrl_configure_source_params(struct msm_dp_ctrl_private *ctrl
 
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

