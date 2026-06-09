Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3245CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C67710E1E1;
	Tue,  9 Jun 2026 09:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HdKfR2oi";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cdTyecfu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6582310E1F0
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:46:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6599JlVi2223170
 for <dri-devel@lists.freedesktop.org>; Tue, 9 Jun 2026 09:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=; b=HdKfR2oiPO5h+fm+
 TMqC4xzUt1k//m4c2C3bv6HWlZ90p8eca7S8umejkhW6BvMXuvAAnwTIztvMop7P
 ykiyBaiTEHbBKBsJ2baKbTAYdNgYvorIc0zQoqyKdSFIN5QKwBxTD+PEB5IiAOZF
 syJ4vzrdGpjaVoQ5rgnEjZcTMZ0Z/CtoeyPdOHOqhZ4fIP119R9+6ZR3acQ/mLKr
 WTA5lR3+x/4X66d01ariOMq/5hlLwD5QppiF2Bh3HsElLNkmnaKKIZDGRRZ5zDb/
 SZQkt7xuEXrDki/bd/9iPT1Egly+ClSSgVUwU2lS64Urp8BhIzavOt9LUyZ8JJ+C
 K7CPbw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epg3v03gs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 09:46:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91576c147a4so1393963385a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780998414; x=1781603214;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=;
 b=cdTyecfuyqhbaZ/xq0lEhdjF9WMjyuv5Ib+59H6TjyFroXVvazoqbkj9EiPmCePeIl
 b/W95BexJKFOPN+/EKv6Bf5ZwnArCCM3BPOM6VsSzS1RA33nnNpwVWCsR2jWdLn+jKbI
 8Ly8dO4aiDpAZ6juHHSIpWHIE9qUAFu4ZvwrDz77gWwM3JfSgK+YkTW2zpYqcPEQETy7
 fSndpwk91IsvagUU/7wDVZjwVi5AQ8Z/fztwUsAl0mWDuRRTvYCT3mi9NlIPfLNqyUmW
 QIhlaT5zoVD5ufbfB9YeZeWAd1SrQoARGV9NsscgM9viYmLCOrvkT8cx3tX/yZk3bZS3
 aH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780998414; x=1781603214;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gsb2m0YYMxi0oazQhslfYqgxjuHbp4QxtyHnC/SdYhY=;
 b=HZogDEPHX5FV4C/JXgcdTtFS62gf8VuvowJw9dgBilY/8J8Lh33e4rI5A8jlDXyfii
 iKjngtyWFN7rqN2IEphg127RUZ0cqJvtId/MEoPdjdI5A4IbxTkKE6PbiVhFeHY2O3vA
 FMPq+VgneYc4ldZEPtfeHnAtdBhkKiRu9Vsw53UaOYZ0JcjoqSPAGVmA2zjLVI+Y/RQt
 U/cDhL1XxGshYS9HztM4YvbIJ3EdW5oJw7kI2U0r2n5QUIi11ou/hIjD0/j1OcivcHym
 ccsFOWHRibbNSyvUpu6ZnI6w7rk7Hnj1YH6F8e0uKJBzff7ee2UIiLGdU7HpBWrb2iwU
 0NWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9S6zllRfAMLIjYk5F4OOQDIbiRmY9UNIQIQ5wWhatiIjdovUTzbWgg0v1CbQbJPt4hqB/7yM29PEg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyHX10UGb1OJWi8vvzsVgExSXiqFI6vItZP7bDfNXcaPVUHtq20
 VHNXsJh7d/UuiE5PeJDO+gw6VE0FU3si7q2k7J5o6WtYCfF3XFPNRgrGoJxRVHucPbChSEvqC/t
 hWrIccX8jN1Upai8fYeN23ka8tNZ/8Vz9hFudFYs4MfpmOkqREhCdWoth3L6DRli5FMXoBCw=
X-Gm-Gg: Acq92OFg2/ksm9tLBv1dpY3j3tdS1/CJlBMml6qODm3XhjWtRZ+dZ2K9zVCfQ+bFFIS
 aFHPlNZehiWl5/D4UqOP0AUNsJ4PE9St9MvIPkad/sxLwg2jipH0S1oHtxcQZmWm0WXdXdJwzp8
 L1XSiVVoW1pjIORWWKDzd5J7DmRbEYUrRcvheOhMRczgfkeKu8lhIZvC94k8kqDmHGTmHxM3FLI
 XG89tYymiza95c2fUedwD5FLS8/S9KI6RD90zREB5WsajX/Fe58dfXyVi2DqKYmU6P5ZvGkf2Hz
 D3cLGUtwdR75QMak18tNaBWWHKKf1uLdX4oljbGhEYse6r37TEfPVZ4uWYebblWOVPCnpKAZ1Lk
 qSSvXqOXLDmiTT4XCrnBP80mCe/ZBG0fSIlFFmQcY7QhE+523UlG/d8L7NF5tnoYs59QccK2N6y
 QTnEBeP+JGQX2IQPrSWw==
X-Received: by 2002:a05:620a:1988:b0:915:7f6f:c8c0 with SMTP id
 af79cd13be357-915a9cadf7cmr3172255885a.15.1780998413775; 
 Tue, 09 Jun 2026 02:46:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1988:b0:915:7f6f:c8c0 with SMTP id
 af79cd13be357-915a9cadf7cmr3172251785a.15.1780998413402; 
 Tue, 09 Jun 2026 02:46:53 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00afafsm2047489485a.2.2026.06.09.02.46.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 02:46:53 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 09 Jun 2026 17:46:25 +0800
Subject: [PATCH v7 03/15] drm/msm/dp: move mode setup into
 msm_dp_panel_init_panel_info()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-dp_mstclean-v7-3-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
In-Reply-To: <20260609-dp_mstclean-v7-0-ea04113e8233@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780998392; l=4086;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=utX2rWcnEK7sp26OqAqarcDBJ0uE50FzNeV/RPRB27I=;
 b=A2HR27xzrxB/wtBy9J4YOlebtXmWevEbShlDriMz70kcp3Sdwz1vvlnqBVe4axQgYqNt3cYm5
 YkDp/8ZE8ASC74VUieDHxuPw3McqqpcuhhX8FM0bcqRR7QD40GtxQAD
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=St6gLvO0 c=1 sm=1 tr=0 ts=6a27e10e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=RRF978PcF5p4qF5CYGQA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: v5SVpp8lq_vpTXRrlJP5DLH3yrf5uTGy
X-Proofpoint-GUID: v5SVpp8lq_vpTXRrlJP5DLH3yrf5uTGy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDA5MCBTYWx0ZWRfX9w+0wAxGFBLY
 IzsftNNrunilNVK25JQ9k6Vj6H2nNzD2DlsTjH/Q/dAy5pumYUo656j1ame+GdBM9CFlWqplW1M
 B/HZHTh7hI1iHIKazeA4+7Xe05+yZdKllXkNgXqhoat3Qi01lMZl+Z5gAiajv5tfXUYWUNNG+my
 fDqidUChxabu3KR6Cj1nL+5AkixTScKrJ333t7KZLfrTOMsxdCM5Tze+4Dy7d22xyOIcDaWcstv
 bDacJIqo0sppJKRYPzduINJLr+NSTS81BirFaSKpT9xpXxGOM/j92PwPetOxKU6KHpqlZX4bEeb
 kApORTdqMGrDDYLc+3K1Y3871wD0MCc0kJesQt/k/ORZ0W24Pwz8LguVOJnfneSW2Y0dwoyWv6E
 phLiiFpjrhz0WdKTAjt3zEYjayccACUfQYRLqmR6D/djwdrAtkFHrTZZHTSzAaIzA7BlA/fld59
 rZId+G1idJ1BTaXWiBw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_02,2026-06-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090090
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

