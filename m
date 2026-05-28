Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13DECD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 10:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 473B410EFE3;
	Thu, 28 May 2026 10:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vdfp1AQ7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="We2HuMt6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AFD810EFE5
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:52 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S8vcbc566557
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DoPyR1h87JFTyIOs+EVznBYVFvi1bbJRD7VDh6vzS7U=; b=Vdfp1AQ7dby9FMsw
 3b4QURfYyaZgBden7CCAd4G4LgUoKv65MIDAtXwszE/JTvJKXCoEqh6vU8Jt37pb
 P6+i+/UmaO5OCxvCIg9THmOhRYcrvCzCuTISIkKRzbYRNC1jEeInOiY976XU4VqX
 FhBThB9qnLUeXL9/9ajbDOcYrd+EpKioSpvnmPUZykmpC3aTVan7DKE3h2cqjYAx
 05O2Ga5NsvtMkygAG0oqz1OK1MsDiI7FtVVag3Phx8VAN8u3cp6D3U1ZThOZw9vm
 bqCRL56hsNlXDtL40sllxy41VC14hl733z/ePjafnh6Kh9vCcOuPwrkbRbKP2grU
 AnEWlg==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7ynjd7e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 10:40:51 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd7878566so5935266d6.2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 03:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779964851; x=1780569651;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=DoPyR1h87JFTyIOs+EVznBYVFvi1bbJRD7VDh6vzS7U=;
 b=We2HuMt6bKmH9FKReLRAnfTuOzJJYngNAArFllFY9RvBOdycSx5YzGgXgUhx6YSEh0
 gRuVXMeCFq2bq/Y8KQalKgTpR3P0tzyE76mqFjTfXTP2QrkyJ0WXmMcUt95nYn4d9Wmw
 1DYEKJprhYMTSvDqLAti/CvldpKR/kZAqQGNHN4zoZ7kfpJgxVx5a3WPaaQN1635qtir
 gH5BBlvoYbp9ty7zR519RZU/5Z8A4rA7kRuZbDtIF08bmUmUnqIhCoYUPAyp8Bq29tmM
 35b5IIZ4+ABQDw0fbwfnKkR0s7lkPRKHWIBghi1oOuU9uS+wseNcLvxy3o8dUTBEOjkQ
 grow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779964851; x=1780569651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=DoPyR1h87JFTyIOs+EVznBYVFvi1bbJRD7VDh6vzS7U=;
 b=gyNG71hTg9JDLlxin8zRU9jve4k3wB4jlADh4jY/b0DP6SCQ7YRiYWAuUiVMO3vFkd
 NA1MxLmPygAGmmU8C1CMrvmuxHYUwhl/+wnv4g4fFw9nEH56CHTl2Cjqz4k2UczaFR4O
 33b37ZuWVjDfRwxBDqtw80S7uPkSK0wJhejr/Z5X+zRJdNILJKI1hJ9A5gB/NaLQaRbW
 HLmeUyF8TpeLMpPoadv+cTFOZ1EkV8FO4NVvwAn5NsLH+Xrdcq/JMwstDEZx6n1kMNWT
 624AmyYNMV3/x9ROx7V8AFxLR+ofIJLFRva6RvxaytUs3kgSHu0L7MZODD7QE+9UpP4J
 WCFA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8buj1U63fKLm+AGyKGsl1qDSnpfl8T5vmp/fXR9MIB3oXv3vEeFmWr5iWoqWRqfsQGLbuL8Yt5gUk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMhP+8krLbFZgMK0E6xM+9CDJzSAD33DwpYD00D727Reec+NeD
 IfFSrsmKgsABtURfK7wNWl7WulLYi0Z5WD42MtxAoS5v61CAAJXerbNFm/9d1HnxNxbdYVwIMdq
 EFXbNCx3Vo2LsOmbtgV5wEBGT3+KoMCmU8NHGA+cUO15lNRhjwSMDv13Hv9PMxhgPLfewwB0=
X-Gm-Gg: Acq92OEKkv+p+z3wyrx1ZM1a8NUSHrV5nJaYs00t5AbR8tdaDdsrM1DISp8ivCfLo9C
 1IhwwctoBi7F/0XNJD7u5TDvWDJJ+Ft3pYMiuUcBdS4jUDKgp4Z75D8kz4AxDM6ufTPQj6Xdi6Y
 QkSMVufmVvt39TmLb5Dahn0ReVX6een9FKQGyj1mmTvQXXxEpFPvv+1sZnrT9amlf/FgsNsKyUE
 LW549Ujuhs7VsP7vP/Az0fvhpk1r/KzrjasH/cI9in9YJ3MiIfk73WOUli9Uh5LKOVz3eaFJt6B
 sPcdAY9Unp1ghc2SFvEncdifff8fidR6YRfQYYBJjVY2WixmeItK2tiaQ+dfIapyzKHKyvTMt24
 Ib1WEm+0yrS1rvhbkLyf5huskkeXnKn6aUkAy9MzDj3jvwxJv5Buff1kfENLwNMsQvimKJtSV2N
 U9Sh48K83qCNxcyOsKmA==
X-Received: by 2002:a05:620a:3199:b0:909:fbf2:52bf with SMTP id
 af79cd13be357-914b499f6d9mr3689904385a.36.1779964850749; 
 Thu, 28 May 2026 03:40:50 -0700 (PDT)
X-Received: by 2002:a05:620a:3199:b0:909:fbf2:52bf with SMTP id
 af79cd13be357-914b499f6d9mr3689901385a.36.1779964850302; 
 Thu, 28 May 2026 03:40:50 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f86fffddsm755148485a.12.2026.05.28.03.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 03:40:49 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 28 May 2026 18:40:24 +0800
Subject: [PATCH v5 03/15] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp_mstclean-v5-3-a9221c1f1f3b@oss.qualcomm.com>
References: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
In-Reply-To: <20260528-dp_mstclean-v5-0-a9221c1f1f3b@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779964831; l=4019;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Jwkj7158czrheThyT3gvtKTcpFQnoZihewC5ZY+b9zQ=;
 b=hVBOWnwS4GPtlOV/sdh48SQ5BJbvkZZ1sI8HBcpte896kE6d+6eRaQMnTN3v6XJeR8WBsPIQ/
 i79/qiTxDY8B5YE9VmuGgkLwZAJ9RaZJju1bNhPdGT4UAU8N+QEZFUW
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: aJ1qwX_4_OEvAjMeFPQ446SANRVEN2I4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDEwNiBTYWx0ZWRfX1Isgx35q8zRA
 kyM5PapwStuV645GtI4Yaf6cTB1FOmeyz/AQu5Ot0NBWiIgFoxzRRKoGFF+nhzJmfNfffUnNRJC
 4QMHR1MV7Gxo5+XeIgq2g5MxJNRdCjnYsYPasNE4ZT5qXGKTbWiYHARi4rLZleGtkqC+US2tJ6A
 3FVlBDylNVuxfzI/FZNHcVQS+tFnV1Z8B8NruhIXwydZLFT8/K4E2H4iVj0rGrsU7MTGTxFitcY
 lwJX9EqYDwz8YcneGbQ7ZklHucIbpnVJyNuOQlG+rUw+f93LaxBgzpO1FjuloeR2eFuKJuwLyXe
 5FdxNw9HvxNzfjRk0VQ6Gvqw/jvsQ6MxxlItZ3ccJXMx9//4WERO6ZWL0Mzgc6qCcVCtHCgd0DL
 qstrddE4UptryKkB3PThRYy4CrKkm52kvQ5a2yhhG+gEH6kkcBXLiRccUSIovroqqvKKOxmhBAQ
 rWG7dQuFLqrNVnhLQkQ==
X-Proofpoint-ORIG-GUID: aJ1qwX_4_OEvAjMeFPQ446SANRVEN2I4
X-Authority-Analysis: v=2.4 cv=Eo7iaycA c=1 sm=1 tr=0 ts=6a181bb3 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=RRF978PcF5p4qF5CYGQA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280106
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
---
 drivers/gpu/drm/msm/dp/dp_display.c | 11 +----------
 drivers/gpu/drm/msm/dp/dp_panel.c   | 18 +++++++++++++++---
 drivers/gpu/drm/msm/dp/dp_panel.h   |  4 +++-
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 181d238addfc..f33c754b83c3 100644
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

