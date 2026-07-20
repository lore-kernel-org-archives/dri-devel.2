Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 533B4C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B424610E683;
	Mon, 20 Jul 2026 06:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dXQCIhXU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GG1+4Q6O";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175A410E68D
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:02 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JNtVkS1913615
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IF3qUvx1/jD02Z3xEjWvYCh3QU/bPLh9lfZzorOGlGs=; b=dXQCIhXUG3EFYJ2K
 cQlfDIYdM11C3xeIWATqJ2mrrkhSvm6hGbrK6e5Zg7qNz2cqDYFe3jjesVdmDevB
 tFusiqpbIX9Fj6UTYAb0TuB/lzJ5VoDBbW7JwHrrx4/9WJFrwbulERI6AcCIO2Yg
 DMjzrfIgoqgBIuC8UoK9Ho2nmv9KO85khiJZWQo+hUdS37n+kuuq8bCO9fp26jKq
 DmO6aTnGAWUrnF1I+fvmPbqDlfxZghvJ+gh1GFrJ6Wvkq6X/qxk93BKjztMvOblm
 nt/k2f7cm2DpJytSGgzo/A7Duh3di9lSpq3O8NNk5VNUqNJ2AwkF2oo04WiWwdAU
 giy9yA==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2aavmgv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:11:01 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ec235c7c66so87115686d6.0
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 23:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784527860; x=1785132660;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IF3qUvx1/jD02Z3xEjWvYCh3QU/bPLh9lfZzorOGlGs=;
 b=GG1+4Q6Oc+/qc2iegfS5MqJtdKpH6W0p3ufl93UCiJrRAhJCkhaSZtBLIhkCY7IdvD
 Zj4PFDazhaW32qm+6cP9SmB9Klmo6NShLo/lWC0geVcy4xfUr3YsQNPs+Bz+BOnPmGFT
 ChLY5u9nQzCz579DMLtoA1pqU1BfiSCVNYF3XTvc6KkD2JqXkm4Bje7T3ZwA/w1zjInu
 p2SXJoCqshv1bt/bDQ4z1pXYVFd5ZWxMT3NElQa4JnPPY2jyyymsiIgrwOUjkv2y3lVT
 WHBO5XJy9qly56YeWho4Gn0xe4gjCjhzy+qIEdiYrZhrspqLd00pju0BuyAk9A+b/hp3
 0P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784527860; x=1785132660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IF3qUvx1/jD02Z3xEjWvYCh3QU/bPLh9lfZzorOGlGs=;
 b=VTZG94N3ZgUINeetaOZDdWa11HQ2SmV0hPpOadw0zWFjGDOmA9qQCRK2LZTiHlo6ZT
 YZ2GDHm/b2WlStxdpcIIzAKEKkdMOX6iuPPOaVawdUbzBFm3FSn47bXR3PkTyOF4oBMC
 xtVmQtxzIEMbjBkzY3UZIsMAPDmV9cfzJT1RzSi1jAyvYlx/CjoCZPeFOlPM1cZfzXA3
 P55L9apyLBMu5naHpT4DGnIbkVlEbuG671paRZMWfMoiILz+vxxEFezbSWpO3GHmi1SO
 TDH78/YaWlP9NrZFSlGXzs4698/jmihYgDFuljyYQE8hJyeur80V/K0VZhMHj9bhR/lX
 osbg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrJEl4R7sDuaoAnoZ9leS5K+5qIrSpmiX3jzMH8Kas5zinCI0gqaBn0ds/HjmsXKBbhQDKUWUEMFpk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkLpT5iXS7b2eaHA5VqlbcA0JFsgZjIjLhgG4SCn9akMuS3UNM
 uT5TFV8ITTGKPZS5ZpZ1CeH2HV29tjnyWBt0ahQTJzN3nPJNNrkIUT6EjN3xX3L1xWGdKNRev1M
 oRR3Ge39GIIKhcTfEVVEk0VXouYlf1VbluAg74/EUSafz1MZod62AULFNZYAsLWBd82Uv4O0=
X-Gm-Gg: AfdE7ckDwmk1e1vxjIdCPlv2BI8WXMm1i2htUYY/rWWkZQ9Lcm8zHGnarD35P723Nxb
 eaoHgTsk/x3SnwOUtKNC84pA7qn8JUtsA76XlvW/SsBqFtQESuWpEp9pL9N/iFa6JdVEgGf5ZA+
 oWMtP6WVvMV0zYXXOcjFyN90Q5DTNMb93kggt5DzM7fiI8WTz9pR1RxdaF5YJ+rMkulxP1I7hsn
 sAKLU82LFALccK7QqISwpbB+FZXtm9gk52w/QgMbm83YyQLuuASEWlGhchy92KJWN9W8VSNdg8C
 Jxv9Wj/i1NxPSQft5RmTJi/hrit+Pw3+6vFSSkaEvMILSIWkohPxRUF7Ln3qdQjeLwsRxJdb7ek
 a/f7x0YOAA6fBiAC+15S0qbj1olQWeWNXIl2yoXhkoa9s0PBPxUZp3kyheExyGI0=
X-Received: by 2002:a05:6214:5001:b0:8f3:6c2:222 with SMTP id
 6a1803df08f44-907783317b0mr130905316d6.14.1784527860432; 
 Sun, 19 Jul 2026 23:11:00 -0700 (PDT)
X-Received: by 2002:a05:6214:5001:b0:8f3:6c2:222 with SMTP id
 6a1803df08f44-907783317b0mr130905056d6.14.1784527860032; 
 Sun, 19 Jul 2026 23:11:00 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90778588a39sm84793216d6.20.2026.07.19.23.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 23:10:59 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 14:08:10 +0800
Subject: [PATCH v8 03/15] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-dp_mstclean-v8-3-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
In-Reply-To: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784527840; l=4086;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=fjfAwVLsdfXG3E29OVHK9sjfJONiXlZlAdNcpfnkhYY=;
 b=+IpbxiGAPbEa5G7QwCsrybPKxF3rVBed2emWYd4YGTPKSRh7Sh9ZaJmiW/wl6FVXGiTHxgGje
 9QRG/40n1KvC48AdQ2FbTnyAPmQTmRrs2uFhZlp0Yhu9TjmTFgfylea
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: MHUww830-XRZLwpd7TM9mq3igzNryKo1
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX/3Lx/evH+cw6
 LtmyyV40Vtv1/FZB+Az3TKfhjX09JDZqV3LXn0MnBPA+PcLQuwCNs9IsCeq/ZdjAegot33Dwt0e
 NLWI+bM36nJ3mVULS1gEeWqwZnUP9wU=
X-Authority-Analysis: v=2.4 cv=b9aCJNGx c=1 sm=1 tr=0 ts=6a5dbbf5 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=RRF978PcF5p4qF5CYGQA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-ORIG-GUID: MHUww830-XRZLwpd7TM9mq3igzNryKo1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDA2NiBTYWx0ZWRfX+5pv2LmG4uR1
 /Er9QXithDXQCPhbHwYEDnm4r/huMVQBLJ1cmQrWnuENTvwKZJuWpvizW1fyFD0be/HxgEk0o/N
 3AFwzEiUDSsyuuzjRlTcQh57kB4twduP7YiI57iKASSH8qfpwffpCm0EJmLO+5zjU1EqzeCil1k
 XI2HDhzwltg6GzCZoYJdOdzmV9lYyBq74lffrRhOk3oUVXCkewqJ2pR29x7oeF5cESuEDW2bRqA
 3HEQPMQlma3EUb+Am8Zzhry54eSo8A1r7QHynzYbbCvXYf6vYuTvL3InOjAEv+aFps3lfBd1mwF
 bWjYo9OUUASprKrwKGvuqv7R26SwkmORQq1NgUkoFl6Dtujh4KjU8daAc871YVSIwdwZk/QC/a0
 UQ1mbwKdQel5J2XXbjCGp12+x0GeyK3Zg4WiypwfHiJuEbX5OFDwxwWaOJ8s82OzCQRQr0IZZ5X
 E+g5Cr3UmiBHrehOptQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_08,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200066
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
index 57eafd472462..155beefdfdef 100644
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

