Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD5DCD342C
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:25:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68F0210E8E4;
	Tue,  5 May 2026 00:25:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JcLh5r+N";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SgT9/FpH";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6E810E8E9
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:25:32 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644JhhYK331121
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:25:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rWAgm8yZqkTEWO3E+Iv4QtTY54HVAbGewYLkSKrtuKw=; b=JcLh5r+NdnvDXCPH
 SiN8bTU7T2LYWQr3hx1QzJnaS3z5Sdwb8B+XSb0fjl/J8d9ptAouwR9lBJp6e9C8
 Vhc7IGi/89P+wfGWADGvSvVAUu17Q3PyVmIf5CBtLNh4SF/tRC5eVYDcljP/5v2A
 L3WPQudZERv6PSruEpBQ/y8SuzyG5u5jj60ShrTOuY9fiSedc6w8lEWWCpXyGMaV
 vYDCG53sZ8fQzNJ7YxAfaS9qbc5pjbSvtmIk0iAKcjgUbo0ObdEekw9pq3hM/Kj7
 akRnUcE6AArhWtGsTa7x/Slbpz1y/HezRXNADmQXDWvalNUTzaj/jkfwJZds1qRq
 7+HpZw==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvr1a4y4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:25:31 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50fbc49bef6so86053861cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777940731; x=1778545531;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rWAgm8yZqkTEWO3E+Iv4QtTY54HVAbGewYLkSKrtuKw=;
 b=SgT9/FpHrU3iniCcAP1tKVzDIqwiIG3N0vIupR19/TpjVrpmqDzXLFWVpcnY8iPExQ
 ybCrPcpNWa4wCHj9aFU13w0/nNIaAVoZ2DU/bS3SBJVI3IwinuvmNeW4RGF8cmoz2wiD
 mfZljcUay5IYEwzcnO+guDDIKZ7UlhXqWlQNWi2YhYRcA2hdEcPUr1/5E+ckzaJSfeSz
 MQ1cqJ3Sgtfojue8oRQGmZ9v7+4Qig2riMIj5zp3RaDqffMyhUBWog3H2fZzo9MDtNQk
 X/ydKa1q/8gISqCDyZ6V8d8KT7h41qPAELf+qV2mLrRfE0FyHjowLXpY+NOJ6SkRaFWy
 j1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777940731; x=1778545531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rWAgm8yZqkTEWO3E+Iv4QtTY54HVAbGewYLkSKrtuKw=;
 b=XLCvzUITvWk+wSa0A4+0BcvamNapO4f3kvl6LWFnrUpcfNa5c+S/y27N7T/5EkZbsl
 0rpBw/0sWUa1Q2k0Igf62EUyYrjUL25eaCPWx/kHUaZIGHhLYEvMYP9vbnC2CYFYfFTk
 Xt/tB7JtSFD7EHWHnNrAc7pt36u1ybRxY9cyp98N+ZGTVAUROqz6e4vYZLpsO4Rfz2fA
 k0rVE63j5x8/vfm0uRrXY0Avm+4+EjwpFHtu5u7UFrSDQ6qvcFbzaIDcdy/roqDGgzaa
 IFdwEklUjqvkJ+FlWTWtiGh+TyM2MapupGwdK1Cb27Le39alhq71RmgERLUrSNZU+cfm
 Yx+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uM0aI+TB7DaMUHNUh3U5SV8JVCwPPu81ALN2L10a1TMvPy48/9ASffh26ORXmUp3ZukMT/oYwcGo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBB5IgDeMyHVxihD/X8A4IlTCf1zzWX6a1A2UXhxGYQ4Yprs2b
 U0shEBSolPyHMeNvbrcwftYifCoqKgIofGu3kuiMVsWhl8Mnce7xo2TioIu88yoLBMR8cH4fFja
 Vqw1zqTjRHvsu8PkLb26p58nEujlj7bzz7rsgV0CUF6R0/zKk0VxuBG0U2ebFE8bXoPfm+iQ=
X-Gm-Gg: AeBDieu/daLAfO1y0BdGNKHGzeNUY8EDfpFMHqZkapFZH//99XiSm4vCyUFemH+U6ya
 r/aHZhkauqf5/7bJNwYUVh0yL45T+WUpONu0gXgX9ggg+vs7MWzFcrV16Au65OVIILuZxsHxIa1
 MSVzHjD1bRd1H+yRNqOYx19ZT6ncFeZHa0LyrPuAjBE3csiaECa3JNIwzbYIdIyHf1afV9ne97C
 T9502WsWbnk82XM7b9url4dhKB0igxxH/Snol4yZbalw3Wrmyoo6G8d3s+ZC1+Sag5fQWiqCMxV
 aNFHHDr+vo9yb7SGgK+2kql8Aeb0q8uo8bknXBSqTPPQQalCyPOzogVXMNd/wPTQrOXCDL+nZ6s
 eM6iNEUlEkaXGpsMH/D5MdBxmbt3/01Ssyj/5IpJ3ohEhdH7Zg41mTFkxmotAI7F6kwHVYD8YDk
 x9CfoYivEGyq21fDJ85U5kcxLh4Xy6bmuiB9iPF839AaAztQ==
X-Received: by 2002:a05:622a:90d:b0:50d:91e3:b668 with SMTP id
 d75a77b69052e-5104be76597mr167209281cf.20.1777940730804; 
 Mon, 04 May 2026 17:25:30 -0700 (PDT)
X-Received: by 2002:a05:622a:90d:b0:50d:91e3:b668 with SMTP id
 d75a77b69052e-5104be76597mr167208721cf.20.1777940730379; 
 Mon, 04 May 2026 17:25:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-393610ba09esm37132781fa.10.2026.05.04.17.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:25:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 05 May 2026 03:25:01 +0300
Subject: [PATCH v5 4/8] drm/mali: use drmm_writeback_connector_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-wb-drop-encoder-v5-4-42567b7c7af2@oss.qualcomm.com>
References: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
In-Reply-To: <20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
 "Kandpal, Suraj" <suraj.kandpal@intel.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2873;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FuBHZIwie1er5ktaJK0YV3oa/OgU1IZweJZeXfhYARA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp+TjcU1af0jhKXjV6ovGMeL570EFt5o7s8n1nn
 fsAtjt+HqWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafk43AAKCRCLPIo+Aiko
 1U8pB/422R8VMg8H+IB6Dm5C7Nrxv1ibTNuhkwFXdQ7AaJY61xdh0vXl6otVYKN+1y0dwFJmSxW
 3JKx++z5bAUk51vcm6jV3j/y8CHLhWXNVds+KLFlMo5N0VBbdGeLV4eWQdIP/NUpLTMBjSQDEp5
 AYF1h8DxpdRxGVF7t3yZKqSbGHFMUKtjFJ6YKX5VY1K/0HJzKm2ZYCB0SIxKAem3ztMYcW+rFay
 4F5x2Xvmt6HGtMBSA5Xwb31d/kzJNYih3pg1QGhM5mmXUt+lzRF7UIAz/Yc/XGGklPUKnxBmQzL
 cqMryMtUBc/TY7M6wUO1QpRFGIa0wJ+v+nQ+Dxr+y9LreE10
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: gRlFZZfRfnhXh1YV5JQzmEIG7YGW6wyu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwMSBTYWx0ZWRfXwwamHqfRSKFH
 vAD2VIt8yGRejKf35gZ3tsZdUS9rUn0FHqic01bhqKjRgL+eeJW0N2TYCaE43g4YUCTu/RRYmph
 pzljqbR327MEJImh7Y1xgqS6pM1UdS+irQNOIJlWBUDDlh6KY32sYHuVIAbzy5nOjiXpNrWAfJi
 dX6EWcpPFmHXGmT5h5MC5ObZhm8gwkxe1xsxzKtIG8CsOUE9eLYpoWFVAuM1uPqX88my4vKjz9Q
 hzG+26snory5G8Zld1OqfEReRRbqb2gSKK2L2TfSidAyZ777EauoYvigOuZIqEYkq2toBgMK03M
 K12mC0AceaVMDJfrcGmxusXu1idcq1NljSh8Tr8yyhogHpn3j0kq+mRPfdiCl7PIn4TAYw+JKfv
 CuemcuBohS8iDBfNCLEV+lUV3zzZfX/mcdaHmw1O0IIpMA7hPUH5I7+ndZgBQvqTqs/8WYmEMlQ
 LWhfLg1YPyrFGzGR2tg==
X-Proofpoint-GUID: gRlFZZfRfnhXh1YV5JQzmEIG7YGW6wyu
X-Authority-Analysis: v=2.4 cv=RvL16imK c=1 sm=1 tr=0 ts=69f938fb cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=P-IC7800AAAA:8 a=EUspDBNiAAAA:8 a=rEXDA0v2x0ZtafRnR6sA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050001
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

The driver uses drm_writeback_connector_init() instead of its drmm
counterpart, but it doesn't perform the job queue cleanup (neither
manually nor by calling drm_writeback_connector_cleanup()). On the
contrary, the drmm_writeback_connector_init() function ensures the
proper cleanup of the job queue.

Use drmm_plain_encoder_alloc() to allocate simple encoder and
drmm_writeback_connector_init() in order to initialize writeback
connector instance.

Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Louis Chauvet <louis.chauvet@bootlin.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/arm/malidp_mw.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index fad343842038..6e0c78e998aa 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -84,11 +84,6 @@ malidp_mw_connector_detect(struct drm_connector *connector, bool force)
 	return connector_status_connected;
 }
 
-static void malidp_mw_connector_destroy(struct drm_connector *connector)
-{
-	drm_connector_cleanup(connector);
-}
-
 static struct drm_connector_state *
 malidp_mw_connector_duplicate_state(struct drm_connector *connector)
 {
@@ -114,7 +109,6 @@ static const struct drm_connector_funcs malidp_mw_connector_funcs = {
 	.reset = malidp_mw_connector_reset,
 	.detect = malidp_mw_connector_detect,
 	.fill_modes = drm_helper_probe_single_connector_modes,
-	.destroy = malidp_mw_connector_destroy,
 	.atomic_duplicate_state = malidp_mw_connector_duplicate_state,
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
@@ -211,6 +205,7 @@ static u32 *get_writeback_formats(struct malidp_drm *malidp, int *n_formats)
 int malidp_mw_connector_init(struct drm_device *drm)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
+	struct drm_encoder *encoder;
 	u32 *formats;
 	int ret, n_formats;
 
@@ -224,11 +219,19 @@ int malidp_mw_connector_init(struct drm_device *drm)
 	if (!formats)
 		return -ENOMEM;
 
-	ret = drm_writeback_connector_init(drm, &malidp->mw_connector,
-					   &malidp_mw_connector_funcs,
-					   &malidp_mw_encoder_helper_funcs,
-					   formats, n_formats,
-					   1 << drm_crtc_index(&malidp->crtc));
+	encoder = drmm_plain_encoder_alloc(drm, NULL, DRM_MODE_ENCODER_VIRTUAL,
+					   NULL);
+	if (IS_ERR(encoder))
+		return PTR_ERR(encoder);
+
+	drm_encoder_helper_add(encoder, &malidp_mw_encoder_helper_funcs);
+
+	encoder->possible_crtcs = drm_crtc_mask(&malidp->crtc);
+
+	ret = drmm_writeback_connector_init(drm, &malidp->mw_connector,
+					    &malidp_mw_connector_funcs,
+					    encoder,
+					    formats, n_formats);
 	kfree(formats);
 	if (ret)
 		return ret;

-- 
2.47.3

