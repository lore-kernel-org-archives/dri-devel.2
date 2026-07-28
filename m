Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81F3C54EFC
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:22:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ED0810E858;
	Tue, 28 Jul 2026 10:22:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mSMYU6EH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SsQUYZn1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B157E10E85A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:56 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66S82DTL2480149
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1/CNkkoxPzmTqcV3geQdgp3jH0nws9bXiOI6xBcPdSs=; b=mSMYU6EHADD80vc/
 CBCns7NCD7yzQzT2BE4Dt+stmBRjkxUoQpN2M+N1WZkgpvGZZJ2ADU5ndoqVkLGI
 jI9njUKOCealGlfurQrblqCBZ60bZ+AvN6mFA2NXVCSLiTsCJX6rLtfhlcYPHUkg
 EyHebAyfiplT52QkxMkDahJc0Ryvne7K4l5erSL6IVHKw6+Ph7CqxmJ+vTNF4awP
 9xfcHWpXZBUbUQcctycwJu3PWS11sHRwkP8i3l/hmCNyDqYySmCHzLQyEuSD319Y
 71IyEhOq0RFBwTPc0jcBZBp0Qr7tSVZ4BSCCNhihv7lJ181njeR1j+QAq+e8Vfsp
 ya6LXg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpmy11f4w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:21:56 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92ac0a54110so480028785a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 03:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785234115; x=1785838915;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1/CNkkoxPzmTqcV3geQdgp3jH0nws9bXiOI6xBcPdSs=;
 b=SsQUYZn1vrzRGT69yWFLcnZp61GhA1LTVwXDW1cEHkp8DGylh9vTuA2dShDLhzEGDW
 EdN7Iqao7K59Ash0+XKDo8Zi7J+gpUxWTrby8CXw2yUX9FaK5RFtViopjE5Wyx0H9gxD
 ptfX14IKzlNvgmj5B89vqPdS+Yyv2+OtBI/GLSVmbB6ExzJpI+kkrFqn2uIrPjZRBl/S
 8/J42O12wWB59DqcwAX1ckB56ocCgzJgsjBItIr2/NFvgS6Rm/OdDjAAkX4cPtE0DbX4
 U3z+TdmxpYM7MuYMla8KtNunlX8mg+uUi+kEnyxzdCu2Tsxes+GEA9r9CA5uaW34O3Xo
 Ii1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785234115; x=1785838915;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1/CNkkoxPzmTqcV3geQdgp3jH0nws9bXiOI6xBcPdSs=;
 b=LXGVAa6OT5h6Y5fn//nNa9X2+lc4waQxVlIeeaMznuPFaZyrkBg9fDG5PwyQMat7v+
 WKbDVKiqDCKNMfFk2j0R/6HOsj4EKReaPMYMea59ylxCQSNYrQ9n+Qp8+xK3Sea9SSXL
 wOrbStSflYiGT7t0C1+40PUwYtmvCrQ6N2vw3Fud4uEtGyZyoF+RkjAgY+fPakTtRayT
 cKXeo2bG61bc8qCd+PAJoRyFypZGnLuurZQWuOw9hhTGLoD/XQlTXX+wD031GW0Qe3Vs
 BKTC4Z6CNq2cVeX8zSLIqeQ5xN9X298Qe2Si+b1XsFxlJLXl7cC5Be8Aq50Z80GnKO/L
 njWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQ/NZNOtypso9cuPBr2po/BJWCkaQ+ZgxU4uiI2ESr8Sz+NrTPEgLcI9M/4hQnO6hbPCfFmV10jeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySpEx7MVFAkFjNHOTnDPNyjpsCz9wp6LNi6VklWnv1N22ey3cS
 MOT0m8X7ndExifQZZVYpsnb+J1IVDDcavVQptuQH5c/dlXTQaipva4foCp7qR5aQBsA6SgeWwbw
 fCWT1iqDMUn1wo6tR/XxanS3ZC0CWNcAeSYaaNTK3Dc3xHZ3IbTktW0nF1NA8KkOvLHt3q4QcFy
 dygTea2w==
X-Gm-Gg: AR+sD13aKo2u8hLFZejdc1LbaayhG48MqVkmTLpMHSp2zCVmqLdN5X6IG05L6RHpmee
 oWh/tsCoHRWsNvwWoWfRBYglwxAFFxfWLi9uM2Qh0syod/RdQxS0jIO5fN/J14hYmE+o/tsL+bi
 1Q43Wx7gbE9N4OovtZvhWT2vi6JVci5Q+mmSPm2AJtgUBI7nhen6BF0iWITaN4GAVJVTEwtNfPh
 kxm88KdCNC61yFUFKvdfChm9KYg9/F3KuGmt7D18gV98ee9hlORKA0qIPYOIc3dYDrw+M+OgniM
 QX2zD6JyQcdImf17vMWOZPMohKlbfPwSeIA/OCZstsnZMnX1pNRzXKQfj6oJryZbXTGGA+LQUhL
 Oikut4Kilu8RIGISU0At1j+40w7SVZLsKWlKatWK7OmxcAm7Wx+E5mg24X79EN2A=
X-Received: by 2002:a05:620a:25d2:b0:92e:fd2c:6a1b with SMTP id
 af79cd13be357-93302772db3mr148310885a.50.1785234115122; 
 Tue, 28 Jul 2026 03:21:55 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:92e:fd2c:6a1b with SMTP id
 af79cd13be357-93302772db3mr148306285a.50.1785234114423; 
 Tue, 28 Jul 2026 03:21:54 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907e869ba73sm84791396d6.25.2026.07.28.03.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 03:21:54 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 28 Jul 2026 18:21:32 +0800
Subject: [PATCH v9 03/14] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-dp_mstclean-v9-3-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
In-Reply-To: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785234095; l=4086;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=zdWNJSWFz5V5YojG6YqSV9BinwceHFpFH/+uvdsQRcg=;
 b=jhWSadQyY6yBoyE8BcWDTckcwtI6tdSNYC7VvgCbt3BRGWE8SE7ykEk/oIr9xsYhykasls20E
 3EH+HDpYBF3CkDo33NSNkKvPg9S+CkE0q0GGFMKB7QJjZesWA1ft472
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: 7o0VJqrhlQe6pVWDBl4X5F6TOG8S9kTj
X-Proofpoint-ORIG-GUID: 7o0VJqrhlQe6pVWDBl4X5F6TOG8S9kTj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfX9eZ2pV5OWvkz
 7Tv4+ZUx4l4DCM1KwxqFifPSsmoWifk+yFQisrp0zZSUF0cQzdCyvVj3iCfB+LWeHfdRMkOICKi
 4wLM2xbiyYSYwb3kCpXD3+dhi+z1nV1MBSBgw88XTFhmV/3FnOIkizChZQofVaOjWnYiSF7mBG+
 bfCA3j78JZWfhAGoR6BtPX0KpKFf1w/qNl1K3jjVts9YR0sqUjKrJNL8TdEAl9O2Y3gnccstQ70
 HwfJpm4wbwAmN1+3oXUBdenb/AnwOyveVK4p+DMBQfr4lBzc/AWxAUvaXrRdvZ+3GSCxPtnmp5/
 cUeUqQhCPktRaCOXCC1rloOZ1QItGQMLfv4v4umsUONxtNi7jMp2We+nQJmIDilN/QaFjI96h3d
 wHjT6Qw6tlLu0ivGg4S2O27Chpg6lF4Vsh+2vu/OZvFhk4YVal9m280V+Ztt+xHOI5yDDP5CA3S
 TfoV5wHKQmCq+g5IlEQ==
X-Authority-Analysis: v=2.4 cv=PJo/P/qC c=1 sm=1 tr=0 ts=6a6882c4 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=RRF978PcF5p4qF5CYGQA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA5MSBTYWx0ZWRfXwp4wCcQJbHy9
 ViQAuYoGLquKsVnH2AUO5WSUPAB6mO7P2Ug927wr3a6vn19sohcXGf/oZ7PQ7VZ0m4Kxw5QD4Cw
 p7Jvq6T+RVD+dPERH82DNRF0qDCwY3s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280091
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

The display layer directly assigns msm_dp_panel mode fields (bpp,
sync polarity, yuv420 flag) instead of letting the panel manage its
own state. Pass adjusted_mode and bpp as parameters to
msm_dp_panel_init_panel_info() and move the assignments inside it.

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 11 +----------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 18 +++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_panel.h   |  4 +++-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index c106aabda588..2a84a6ffedbb 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -604,21 +604,12 @@ static int msm_dp_display_set_mode(struct msm_dp *msm_dp_display,
 
 	dp = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
 	if (msm_dp_display_check_video_test(msm_dp_display))
 		bpp = msm_dp_display_get_test_bpp(msm_dp_display);
 	else
 		bpp = msm_dp_panel->connector->display_info.bpc * 3;
 
-	msm_dp_panel->msm_dp_mode.bpp = bpp ? bpp : 24; /* Default bpp */
-	msm_dp_panel->msm_dp_mode.v_active_low =
-		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
-	msm_dp_panel->msm_dp_mode.h_active_low =
-		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
-	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
-		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
-		msm_dp_panel->vsc_sdp_supported;
-	msm_dp_panel_init_panel_info(msm_dp_panel);
+	msm_dp_panel_init_panel_info(msm_dp_panel, adjusted_mode, bpp ? bpp : 24);
 
 	/* populate wide_bus_support to different layers */
 	dp->ctrl->wide_bus_en =
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.c b/drivers/gpu/drm/msm/dp/dp_panel.c
index bde4a772d22c..e76dad0f6663 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.c
+++ b/drivers/gpu/drm/msm/dp/dp_panel.c
@@ -647,15 +647,27 @@ int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en)
 	return 0;
 }
 
-int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel)
+int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
+				 const struct drm_display_mode *adjusted_mode,
+				 u32 bpp)
 {
 	struct drm_display_mode *drm_mode;
 	struct msm_dp_panel_private *panel;
 
-	drm_mode = &msm_dp_panel->msm_dp_mode.drm_mode;
-
 	panel = container_of(msm_dp_panel, struct msm_dp_panel_private, msm_dp_panel);
 
+	drm_mode_copy(&msm_dp_panel->msm_dp_mode.drm_mode, adjusted_mode);
+	msm_dp_panel->msm_dp_mode.bpp = bpp;
+	msm_dp_panel->msm_dp_mode.v_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NVSYNC);
+	msm_dp_panel->msm_dp_mode.h_active_low =
+		!!(adjusted_mode->flags & DRM_MODE_FLAG_NHSYNC);
+	msm_dp_panel->msm_dp_mode.out_fmt_is_yuv_420 =
+		drm_mode_is_420_only(&msm_dp_panel->connector->display_info, adjusted_mode) &&
+		msm_dp_panel->vsc_sdp_supported;
+
+	drm_mode = &msm_dp_panel->msm_dp_mode.drm_mode;
+
 	/*
 	 * print resolution info as this is a result
 	 * of user initiated action of cable connection
diff --git a/drivers/gpu/drm/msm/dp/dp_panel.h b/drivers/gpu/drm/msm/dp/dp_panel.h
index 53b7b4463551..4519ac374220 100644
--- a/drivers/gpu/drm/msm/dp/dp_panel.h
+++ b/drivers/gpu/drm/msm/dp/dp_panel.h
@@ -43,7 +43,9 @@ struct msm_dp_panel {
 	u32 max_bw_code;
 };
 
-int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel);
+int msm_dp_panel_init_panel_info(struct msm_dp_panel *msm_dp_panel,
+				 const struct drm_display_mode *adjusted_mode,
+				 u32 bpp);
 int msm_dp_panel_deinit(struct msm_dp_panel *msm_dp_panel);
 int msm_dp_panel_timing_cfg(struct msm_dp_panel *msm_dp_panel, bool wide_bus_en);
 int msm_dp_panel_read_link_caps(struct msm_dp_panel *msm_dp_panel,

-- 
2.43.0

