Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23923CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:11:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87FB110EDA6;
	Tue,  2 Jun 2026 09:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NhQ+nnwF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jdaNctFZ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6258510EDAB
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 09:11:37 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6525tnER1855104
 for <dri-devel@lists.freedesktop.org>; Tue, 2 Jun 2026 09:11:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=; b=NhQ+nnwFQIqLvsxK
 usM8NbLj3GXXjVo4WCpjg0VtXp6DyrpbRjRjtqzFR5HD0J0TiCOiyr1LjeS4tK+n
 g/Ia/ZNvBh4qkVaYkgfU+nzH72IDBZZ7FwCZh74q0cvyL4rN5xLYb3B6Z1FytBK3
 hRwCQGtoQjD2NLeV6i8dmg/5uOOkaxEXSaE0yJk2bJxnBfFyalolAbFFvATM4u+7
 LP2sq846VdAkUYYme4Xc+Y8xrJIWoAXorNuu6yj5plyWkT5qSB8PYTYzQH4U3LVP
 gwAOE1EeUw3dFHHkhZvqz/ClPvjDx00ccsOa0UFZoZ/v3SRyAiFxQ8NPdWlMbVsm
 JzkZCQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsf78suk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 09:11:36 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51749fb465fso51925461cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 02 Jun 2026 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780391496; x=1780996296;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=;
 b=jdaNctFZ+aqEsuklc5z6QFLQz5n2HS/nHfmTdQQetZyLHvr6f6yWzLLzrwJkW64ieX
 SuwESFLLNt41OGm3swBe5lPLr1H9R9kXAyw4SmRXb0OjsCmuvweC8kxHZHZkS6oKLdS3
 vAEErmlMPmf+2wSMmxH+Qz5tarZ3EKtMJImmqSSFQtngPEbx/mfUwB+xd9v653+tVIww
 twVUw5tsXwTrqrnZjNOVQ9SIytn9thVkus/W67t+yHXVEiVA6Yys8jtgQr8ihK0kmt86
 Xbj4y7oCu6kmQZF3GghGoRFTK5Wh8zArJ8U1jnp7XkrL/ZwtfN7wongGwh/QXknBIBqS
 OGMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391496; x=1780996296;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=;
 b=Z3LenSlISXbDktcQ8NRrWnDRPw1M/nI85UmzGQh3OnaY2fI7fgVz5og2/rFoDY0JXu
 aBpckOMlW4dyrnNyFBRm01ctDiTHUO/IQ5oEjRHi/ye22Cmwvypm3Fi5MBGplsc1wjnl
 ATK7Hbp3d+B10KhP0XDEJAVHAQ1omjGiYqNdOk/9u+esQDsTWzzAVwywWsuieZoXl5dq
 D5yaA94KSel0Mx7rV9sDDGbhxEq/+l6LkKBHLqq42M+t8LNRCANv76PhrdpxhOXYhcU+
 b1iXQJme1E727D4MJ9mV4tCYl1xnjYFWkYFaqK2wF65A5pL6pBAKL+RP7wy1yQikgDQB
 fUaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/685psjoAeFxt+/7NhQgVLzsKqKXfldBugSbOdQrK7Po/fYpedHzhHMToNhfb6i4FkbY029MOgyiw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgTOYvFZVuFdUeAlWHpbfT3sUGQs95ODW/JsGK7vMBwRiP0wCJ
 TiYp1Op2IIM9ONPNf+kOVt88eEFX+PlZJeTk9m9AHHdomgqeEYooR1nnuLrbkmse3BqQr8/E9op
 a6K4GTcF3o+343B+0zj0Ue/xPgQBfdSnRJ60rmhEWjshOnipMAAVrwR1liNvZPCD6R4XlSxo=
X-Gm-Gg: Acq92OGOQrr7ImmAUqaQxMgUNkxKn6H0yN7Ur11oEgiyXB2wZdrt6zDZDsMn8KJIcSj
 8vHxGD/DHlqf/+Vvw3D8jIz+M9p6Zr4Wc5oaW4mjd9jqDXNusZIUBJF2DqVpx5sn+rUv9qOazBr
 d0zgr2g/q4qm5oAhARYJZHYagyFGdgaepeSdAbFrpwAArAoljIMBiofslD8/hvpFttzI6qMOr/C
 1YneCGXTtNHItLHdnN5j7jTll4C3AN68Y/heUSQvUXEBnKXMq4KdFNYldTDXK+rmfvaPc9CK2mv
 O3XfhvIkMYZYe+HJ9Lz2QSMUcxVP3WoWrosQKm+OozRMNqFajfelIXqbJyZVoUKz+l4G2onfld4
 dKifxCb8G8KVyUu14+8DgoRcr1Ib8fii+Chi0vfy7FtV5fR0t3M/IEdNERp42qHi2BshHsq+cRc
 2jmxtq5Rbj+YShPpcfUA==
X-Received: by 2002:a05:622a:1802:b0:516:d84a:9f54 with SMTP id
 d75a77b69052e-5173a92542dmr191551841cf.38.1780391495865; 
 Tue, 02 Jun 2026 02:11:35 -0700 (PDT)
X-Received: by 2002:a05:622a:1802:b0:516:d84a:9f54 with SMTP id
 d75a77b69052e-5173a92542dmr191551491cf.38.1780391495356; 
 Tue, 02 Jun 2026 02:11:35 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51768c76e53sm12480851cf.4.2026.06.02.02.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:11:35 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 02 Jun 2026 17:11:15 +0800
Subject: [PATCH v6 03/15] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-dp_mstclean-v6-3-2c17ff40a9b2@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780391476; l=4086;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=utX2rWcnEK7sp26OqAqarcDBJ0uE50FzNeV/RPRB27I=;
 b=ag5SVemMbeu4yqDiCnBBxzstPdazchSBZyEVVnFxjr7GQDKrJBa+ZSo/vkMKzp4XCF+WVC/Es
 9Onj1rVceKHA+PvOr+gcCfs9ZoABWs6BqlU59zD+QW9fHZGn0M09lev
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=WKRPmHsR c=1 sm=1 tr=0 ts=6a1e9e48 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=RRF978PcF5p4qF5CYGQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: WytY_WSuFMBFedeamaZo_SyC0WwSObVX
X-Proofpoint-ORIG-GUID: WytY_WSuFMBFedeamaZo_SyC0WwSObVX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDA4NiBTYWx0ZWRfX0ctDsvFPGCVL
 f7ZbHMj9qyI7jYZSs0sdQeWa+JaOKHxtc/Cn3+CQovqsEXTecVTYbsKDzm04HzOHuuT6ljrjbW6
 lRsLr2Qa7/5mcUrRHxdHY55owvhpywj111wrRnUIP6VjW1n5ce/vkpdhS/mkfZY8j3kwPYddjZG
 T/C+K3uaoZFQPW8ltxGpMf8LlMSs4a0oOVETqNFGUKmAAFOvL+UY4F4RdJyf/KiWLqmwKjf38mM
 LNiTK37YF5g+6eEW7n0o1NPVJSbOjLWjAUfwA2UJ2TKTqWukC5qAIy+Nb8m5Q3eobK4bB3R9Ioo
 FaNYuZMNbGnKfEaXT6y1ADbWmOHAEWnxZjfbgPbuGdUE91xZrfpQXM2Nht8+b+088aIl7LZEBeS
 utWyaasZ4EoAkvhO09emeWGH9AQxiQW9FVGLTso3dF+ga/ne3+BXOLo1MyZhy3V/149KN3p8OGR
 sFFALE0r0/W+jr+vg/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_07,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 clxscore=1015 bulkscore=0
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

