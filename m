Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7CBC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C3EE10EC79;
	Wed, 22 Jul 2026 06:37:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SvqVDo1k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kA5Zsx2J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CAFE10EC75
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:30 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M54GBT3474603
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RkBsQAWB9soKsoLrvCV1NtPiFvCgA8F8m7591cr4bVk=; b=SvqVDo1k0aC+hWx9
 mj7liaY+to0Mp4vspuNWeID2pX5m8amrD0BHR+vXtYZdiA59nhYIvL9vnqIIl/B7
 wl8J+UuEecS3loZwwve7Qp0/1QzndntHHVt5jkU2LKd+QK2WGKkciwaCoAVPb5Ui
 LUsN1nHx/03t7+7hAbYCLvQafn+tp4rZxDZebgfK/N7Zk1lARSqBxNVZTO3vfoCh
 5vqqxnkQ6D6NXdagserTw7egeNoBdZT/5xG/zOdkFDnZhaao6DdHf31XuRe/JFJZ
 R4ZGMzyKIlRgjJ5TsC7ACYsviix0cBXgHMTmon6vN1GeKyUQ7PDCpbRQ6uAMxWIO
 qaXI5g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftmd5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so193872831cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702249; x=1785307049;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RkBsQAWB9soKsoLrvCV1NtPiFvCgA8F8m7591cr4bVk=;
 b=kA5Zsx2JDA5Tef3ur19G6oEoCRhzbRB4ESw64AzeZ8FZK35T8TCnFFgANjkUusYrU1
 s0i+ROqVXiJatDQ2yc440M0Gf/i+UVHEP2/bAzH6GZNno7xMKoHDyJ3W6RmcJhLBhhAe
 0omUaMqdeOQZTO/3qyIMLKYahhWBoqfcmYAmv6pMnCVZrC6dRYvfncGF9P1ZLMLbT5kY
 hOIYrusRPhdHtUsIi6LQsDU/ae+OjzLK+CQmoNtWxfpYgRECWRx+r5XopDFXcnIvM/4S
 hhhlIpD4xMsvwDQRL2qVq8LWUjAaL8L4bu6Mai6Cy2AAvWVLt22cN8qQmNOubiQ0wj+u
 zgFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702249; x=1785307049;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RkBsQAWB9soKsoLrvCV1NtPiFvCgA8F8m7591cr4bVk=;
 b=ZDniecBGMGOMvLRuUxk+z0Gc+D/x+AZlYxMz3wWGvrS1o6kPDDhQIlJ10ZowjfZa+X
 37JKkdTz+Yc5SLhhs1ZGpoTEoMY7fVLZlkvoHx7Uq6fmXEal8nrVx0DnUnxJpfIk+G/X
 yWuk32KSFjPFCybIsMgcz/0KuBsQCUfgdNK032zIdT0/57Yd+jbbtTrorJYpE97eWEgL
 O+aoVBXvV3qNr5KPH7XSJ1s9aTrnF7oN7+NkEH4iQqnbxKvtK8cebGbT269B76GGDH0C
 X+gV581W96AccjTztD+HepjE85UA2ftDKTeLbPm8VpBreCLrZz0qf8P7NvEN8zRHqk3x
 ST8A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAYlVykZzh8mPAxH5W94YOthC6tRCFwXWZaY47j9+wKM7Z4KH0Kx79Jitp2v38rzDnX8qjyrY+sp0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxJ80uatjNApHxDrGx+vKMtM6UZ+JXfelXaKMNzaDX9NRluKO1m
 FxgzOe7CuhiV1X2ijwH9PzxjvzQvV3HvqdihQho+Yn9FgUlXvtlKU0+JzVxpBDTX76n7EFw9/Nm
 cjotatxq24FMD0mzOEUeHewh5e1dmdIk1axdxMmuZPv9I7WLHP+5KhCrCB6JhHlj5bixE1zI=
X-Gm-Gg: AR+sD13GDC1vPyyBQFrTnLRz74TGtU10rW2SIk2d3DV+1siJi2odgsyz7utKnPRZY9O
 kIn/ICCVLQk9R/KUWur2zBxL1d7W/ZH4Lz27nVfMNS060LlXAT11exHnAgjStQ6kt8eIugxZc0R
 8281qYR62WndUVBE3rtg/cGFJG9wd9zXUd35OSAZiMYzBjItygRQ2n1BmOTmLx2/+qCxXhgQwFL
 K2jBRfobQkqvKCmT6KGofK/iwcFAcy5QvBkkMu9Rkn96mo99ZTvanQn1Za6xE55aLb+sZM1Wi1/
 IZMZpbtUIiqFdkV8xTXXF3y1FQyBlzuqZ52nCnJIr1Oytg8qD2zEJHMh+tyI9sRRIKOHUdYTJxr
 gbw00MgbMluj/S0jkeOJi0zLUtFt4NFlo4eDgGi3NFoLgrt9dUbA1qPyTgEDrzCI3zQnWaNRp2G
 ntIfksOhguxgaRAg==
X-Received: by 2002:ac8:5a86:0:b0:51a:329:e802 with SMTP id
 d75a77b69052e-5213f66c60amr209094951cf.41.1784702248624; 
 Tue, 21 Jul 2026 23:37:28 -0700 (PDT)
X-Received: by 2002:ac8:5a86:0:b0:51a:329:e802 with SMTP id
 d75a77b69052e-5213f66c60amr209094831cf.41.1784702248174; 
 Tue, 21 Jul 2026 23:37:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:35 +0300
Subject: [PATCH 20/24] drm/msm/dp: use drm_display_info in mode_valid callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-20-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ru2Wb6WusJrEqzG9fcYZvfqNT3ibrquiqxYIOULpW3A=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTpm9cXV4806bVBAhjFnRwAnQLIwryFRMcY/
 YP0nY0FHzGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6QAKCRCLPIo+Aiko
 1TzoCAClTRqjxWI6IzRO/17UiIDa4gaX3f+NszHxiYQEom48W2TfKB8mGh9fsRKRnstpmfgPPzO
 fH6WvlGb2eutiVuEOieqlgFatmgNuZPmCuoZdnrFXKQYXeh7IUvQiuwvF9ZanX862b9NojoXefo
 EZ7mXokIAdN/tyI6s1EVEBjr3NhsGPq+/K6sWvlWhFEb+qcLvKumZJOqyD/8it5jnP6NxeUpKGq
 HvVbWWv0GY2cb2nQBlqUfsZObXK6e+8nkrsVXHNAJLWADwOMuU449p1JRPfQO4kz+DXrKrcf+bt
 YLqojqDPX7hIT/gx/7HcbnLPzWOlzQJhZsKnYJAF/Fe/pW4d
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: n1rGsRrusff75Z57bDoc3LeL-j7BiJoS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX3ZDFq3oaboQ1
 CtngnKca5VTrIw2cYuEGBIb1MAx+S+7YbpoWqzuOrFPhJZBuuXSPSSSZV16POEEzQ0NYXfcSKnB
 VvqcE2vr1oZQIZ74UypM5AVKIF0JG9172qwdf1dgzS+Axzeg1yZf05D5IGiKaVxiJBQViMBLm3f
 kdyG7Bh3i5O5+DXuZOv+9B5aa3GRZgczu0S7nuiUtVjAcIyoYX0maIobncxB7FRVxsinWR8fSuP
 giZ3p/xJRR+sRwj+LR0PPd0Wb5UjkfGlnuKwDvJD5CDhwi7TQgqlos81BJnIzlxdcoiSFNwWs+/
 EzvvmFxbUB4SKfqd7H6DAvYCEk1jK0RNNQX+2Zqouqg/gF5WaTuxVuVM09HPKppSME6UeJIQknE
 EH0QRceUIruvcK+xdRgFgR5nntdhyhM6OGpiMQzpq6avStvob0y7XE3plnQxmublz2k9gTJZeN1
 AyHAYMG5cjslkB/hpSw==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a606529 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=oESPpdQVtlo-kY4fL14A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: n1rGsRrusff75Z57bDoc3LeL-j7BiJoS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX6icZwWIfBCBZ
 oPwkzDQpTmWPWtspupkqvuSbvlBWCEzs37mW7hKeQ7sNhlCMwwdpFqreMSIv7jsa272GrxhgO1A
 pL6LNoHz3lW2LVcf4TQLE1seT348kdA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

The .mode_valid bridge callback is passed the sink's drm_display_info
directly, so msm_dp_bridge_mode_valid() and msm_edp_bridge_mode_valid()
have no need to reach into the stored connector for it. Use the supplied
info pointer and drop the now-pointless !dp->connector guard.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 6 +++---
 drivers/gpu/drm/msm/dp/dp_drm.c     | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 461420a72820..3397a3a47ef3 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -731,7 +731,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
-	if (!dp || !mode_pclk_khz || !dp->connector) {
+	if (!dp || !mode_pclk_khz) {
 		DRM_ERROR("invalid params\n");
 		return -EINVAL;
 	}
@@ -739,7 +739,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	msm_dp_display = container_of(dp, struct msm_dp_display_private, msm_dp_display);
 	link_info = &msm_dp_display->panel->link_info;
 
-	is_yuv_420 = drm_mode_is_420_only(&dp->connector->display_info, mode);
+	is_yuv_420 = drm_mode_is_420_only(info, mode);
 
 	/*
 	 * YUV 420 is carried over DP by signalling the colorimetry through a
@@ -754,7 +754,7 @@ enum drm_mode_status msm_dp_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode_pclk_khz > DP_MAX_PIXEL_CLK_KHZ)
 		return MODE_CLOCK_HIGH;
 
-	mode_bpp = dp->connector->display_info.bpc * num_components;
+	mode_bpp = info->bpc * num_components;
 	if (!mode_bpp)
 		mode_bpp = default_bpp;
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 8dbe7d682ddf..6b55753da0f7 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -203,7 +203,7 @@ static enum drm_mode_status msm_edp_bridge_mode_valid(struct drm_bridge *bridge,
 
 	dp = to_dp_bridge(bridge)->msm_dp_display;
 
-	if (!dp || !mode_pclk_khz || !dp->connector) {
+	if (!dp || !mode_pclk_khz) {
 		DRM_ERROR("invalid params\n");
 		return -EINVAL;
 	}

-- 
2.47.3

