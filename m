Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2178109B495
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 15:44:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F79010EA78;
	Tue, 31 Mar 2026 15:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GXO4l/Wz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DmRbT7S/";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 473268912D
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:21 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62VDnmZu430876
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=; b=GXO4l/WzLi3xjhOF
 9OlbCHjTyzcklX/G3LNvTNkXc0Xh1hyBpv9mit3gwkWaCLxm6QADvOBEEVhI0WTx
 ikzbnCFxJDJ+K7IT+x/r8TyCljaAE0ahTDD9PQQw7nZRCFa93D7g149KxTzaD0f2
 0PoBxQVpqVDA3AUN/I+t/iBAAbFNPjZbvoKEPFCKVU27g4oYK4RtgQUPsZEX09ix
 kuUE6BHVpJtLp4G6fqWaQlUxKkz7HWDmC5zWBt4/gM3+xzYnxnQR1TMq9ElioD18
 xvhxokBnV+J2sqVCnZOSY+4lQRIcOQXMJlw0QB+A+H0XACdZBjJot4wMOerBWA73
 lTbF9A==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d84bfkbak-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 15:44:20 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b4987c698so711131cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 31 Mar 2026 08:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774971860; x=1775576660;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=;
 b=DmRbT7S/OhZgH9tRDBtXuSQ8Z0fQAYefeF1FMn/X1MLWbrI423+Vk/s/H6KhT1qI4q
 y6e5T2ddJlAC9ovgTPAlsoOeeJ62cE+J7y8LBII2MMelkXJwiIYX/NuXfZNS4W7UKpfi
 oNOt6qXlt92/opIBWaqM9aSHOvTQPc2hWPZdn4dTw0SWBldF4Rk9JXaOYm6LYJGO99OC
 KL9o8bbPjAnXsVP5ZO/V1IJBgv8kSsj73QivQVewhSkJo0Jztlx8NFiE4T3s738DUlVB
 bUugUjpQajWLDCadLFlpqaKHpi5XVm6GgX2SsthzakZVEdGICKM6zwnC9uQ1uqFufflq
 humA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774971860; x=1775576660;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=S/+lpfhPJyGKPek8uoVu5/C6sdT3Q8uum2gyN2ApDYY=;
 b=ZJSv48vsnMGi7YtIxJOmtQcppHzxSPP0ZpQUtXT6FSvovC6fZPvONVnq5HQ41TTgcR
 zQWmxrOL5BDFem1FvGFgxMgPn3zhNQdDTaAW2UD114xLETT2DRJmOvLyMU05rA+GRkjg
 SqpSWRfdsJtAuZSXgS5HjC8dLya1TiL3qvovM1xlDh/a4CLx1+uvjnsdwgiXaQXZQi36
 5l90e8PyGypH3Y0EFIUL/vao2AbcoiigyQnpqQpqcjjEp2TiJRnC8V5qOzjituW5U36p
 r4aAllmYfkZWqzSxizT0R9kOYDJQUw2cHpyitVJD52no+qdvwTrWIfeIUugCH0eKBzhR
 FvkA==
X-Gm-Message-State: AOJu0YyEwb4LHmxknqPkjeXrT8E7qn/kVjSarxhmVoyQbaFy1AoaeYyd
 IljSGTMshxxeYqlH+NhdMRfm1sxY4DjGeV0cCB9Wb/chz0foYksqLgeIzoS+yRAGnR5abyXBnT7
 K2tajjwAyijUCA+ZEV08BTztjUJ4O8PnpNFVLfss1TbAPRjLNy/M4h95Xo5ecYrb/aSAZuCo=
X-Gm-Gg: ATEYQzyWY8wrnAoN1LKMt5HEfDZuhO9PFJHFebZRyPbqUEOeIDAqdjRYSFcuejsdXqR
 aOihxKGztdEN5JiKVKqMAbN5JbIou+cwjupFg+7Bp56BzUpA+kaM82A1vm7BqeLDudf7ha6vHY7
 HGeRR0fm/1g6zwuPwaqjx81LL+FJjlNEqHBXaEh5ggh9DPm+YSn/JCrdQNnsuLMtXLO1YTKUQSj
 o0ntQc6Fv5PqSg/ZFeww1CnVCeRfzR7I4lBp9NjyeN+cIlABPmYv3OBSlikNASKbY7LqU5pmM9v
 UsLTWC+Zjx66n4X902296VGOhO22RLlauA/439rEuyt1lXvpCF/GLEvTD1CR3wWcSkjdM4x6yJU
 wIK4GbmUvVfazzswDJOcEJwZW7OkNJH70YtFWZjjZR9zoIt+UsctP1d8+gYBnwPFfVSZpmTdAEt
 VsspP+d98mcn7vvnh2IN3aSMGp4meolXZz+yY=
X-Received: by 2002:ac8:5a93:0:b0:50b:6fbe:62b9 with SMTP id
 d75a77b69052e-50d2dd48c33mr41618101cf.28.1774971859507; 
 Tue, 31 Mar 2026 08:44:19 -0700 (PDT)
X-Received: by 2002:ac8:5a93:0:b0:50b:6fbe:62b9 with SMTP id
 d75a77b69052e-50d2dd48c33mr41617431cf.28.1774971858934; 
 Tue, 31 Mar 2026 08:44:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38c838931b9sm25387461fa.23.2026.03.31.08.44.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 08:44:17 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 31 Mar 2026 18:44:13 +0300
Subject: [PATCH v2 4/4] drm/panel: simple: add Waveshare LCD panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260331-ws-lcd-v2-4-a1add63b6eb6@oss.qualcomm.com>
References: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
In-Reply-To: <20260331-ws-lcd-v2-0-a1add63b6eb6@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Joseph Guo <qijian.guo@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=11552;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=cARUtvGtD11vBtFkeSEutnYfrhEMM/CC1CsBezboId4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpy+vLSu+Lz5fmt8HY3IjtjdKGaVITqzpcrCO5B
 nBtSNVRT9WJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacvrywAKCRCLPIo+Aiko
 1StUB/0ReZKITPvKcdP/3A10AdoCeilgiTjnloKD7LSzy7fRezF5ZXJuLY9/+bw6mKpS7XYNd8i
 Izy80HkDPox9Q9zwjvhM4lErhEYKCaJWmsEhhTeLvMpuanNKniO0qwd8aizh9IXQfXjstH74qPy
 cg7nRZV/XzblqcpQHOuS8kD/iER8D354R8BRv5IiodhuITsiSLuL4wvfEQ80FX/QfJPZlYkSvjx
 57NX+EvM+EHINgO+8I7NPaUvX3JONoh0K/7d4bJXOxw6AxoEhnQ/vML0E4g+7oJv5XoY1HyV4wb
 i7D/pYMLzI6q9vgk3jR6CABCqJw+RUwpfNgSnmMhbn+0U9sL
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=INwPywvG c=1 sm=1 tr=0 ts=69cbebd4 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=cPmbVODp-joscUQKHs4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDE1MSBTYWx0ZWRfX2vkWfVYWf9jp
 gCUB6LiCpJ+R0h7o3GZkfRps45p5dIZ92rfmBUsDwmS2o+JH3kAPprsPpbaT4tPMxPJUm5wZV2r
 Nw/wIJu/QsQMWxFaT7Xe7mko2OZ82Z07R2UoO6rjs5prag2CWBQVom74GcvgIQc00ZowdFvF3Qh
 t0mirYoy6WUe53brryTJMZyfgP6GtvPE/7Uh9DwtK40qwPkKVbjsQl1Z8+zUR0CMeHA1OE7BN+6
 x3RVNazJ1ruDoG5ip7hN1MEMpxpjifAwNPJUY4cwHVLv009kZbDTq23mtMqZpdVXCdmQ/G1cMEI
 UpYMqNGcqydVYP05okjRBkGgBkZ6+qHXiBQY/SkkLyyw/T3kVxA9uyhFR0mbM2FseJG4O0V2tT3
 Wu3XrvijyRnTFCeDTUPgECDhRxkDielEc1yQPj1/qGWcAPAYVR1EZccBt3R0p45HqNLR/VzgAsr
 ZySZMP6c5gFucn2wYEA==
X-Proofpoint-GUID: YbSr1whf5mzTxooOupoVQaEyodA-cC0_
X-Proofpoint-ORIG-GUID: YbSr1whf5mzTxooOupoVQaEyodA-cC0_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_03,2026-03-31_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 adultscore=0 phishscore=0 priorityscore=1501 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603310151
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

Waveshare have a serie of DSI panel kits with the DPI or LVDS panel
being attached to the DSI2DPI or DSI2LVDS bridge. The commit
46be11b678e0 ("drm/panel: simple: Add Waveshare 13.3" panel support")
added definitions for one of those panels, describe the rest of them.

Note, since the panels are hidden behind the bridges which are not being
programmed by the kernel, I could not confirm the pixel format for the
panels.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 381 +++++++++++++++++++++++++++++++++++
 1 file changed, 381 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208cc..b2708a1fe464 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5061,6 +5061,342 @@ static const struct panel_desc vl050_8048nt_c01 = {
 	.bus_flags = DRM_BUS_FLAG_DE_HIGH | DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE,
 };
 
+static const struct drm_display_mode waveshare_28_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 150,
+	.hsync_end = 480 + 150 + 50,
+	.htotal = 480 + 150 + 50 + 150,
+	.vdisplay = 640,
+	.vsync_start = 640 + 150,
+	.vsync_end = 640 + 150 + 50,
+	.vtotal = 640 + 150 + 50 + 150,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_28_lcd_panel = {
+	.modes = &waveshare_28_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 44,
+		.height = 58,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_34_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 32,
+	.hsync_end = 800 + 32 + 6,
+	.htotal = 800 + 32 + 6 + 120,
+	.vdisplay = 800,
+	.vsync_start = 800 + 8,
+	.vsync_end = 800 + 8 + 4,
+	.vtotal = 800 + 8 + 4 + 16,
+};
+
+static const struct panel_desc waveshare_34_lcd_c_panel = {
+	.modes = &waveshare_34_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 88,
+		.height = 88,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_40_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 150,
+	.hsync_end = 480 + 150 + 100,
+	.htotal = 480 + 150 + 100 + 150,
+	.vdisplay = 800,
+	.vsync_start = 800 + 20,
+	.vsync_end = 800 + 20 + 100,
+	.vtotal = 800 + 20 + 100 + 20,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_40_lcd_panel = {
+	.modes = &waveshare_40_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 52,
+		.height = 87,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_40_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 720,
+	.hsync_start = 720 + 32,
+	.hsync_end = 720 + 32 + 200,
+	.htotal = 720 + 32 + 200 + 120,
+	.vdisplay = 720,
+	.vsync_start = 720 + 8,
+	.vsync_end = 720 + 8 + 4,
+	.vtotal = 720 + 8 + 4 + 16,
+};
+
+static const struct panel_desc waveshare_40_lcd_c_panel = {
+	.modes = &waveshare_40_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 102,
+		.height = 102,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_50_lcd_c_mode = {
+	.clock = 50000,
+	.hdisplay = 1024,
+	.hsync_start = 1024 + 100,
+	.hsync_end = 1024 + 100 + 100,
+	.htotal = 1024 + 100 + 100 + 100,
+	.vdisplay = 600,
+	.vsync_start = 600 + 10,
+	.vsync_end = 600 + 10 + 10,
+	.vtotal = 600 + 10 + 10 + 10,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc waveshare_50_lcd_c_panel = {
+	.modes = &waveshare_50_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 109,
+		.height = 66,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_50_lcd_d_mode = {
+	.clock = 83333,
+	.hdisplay = 720,
+	.hsync_start = 720 + 100,
+	.hsync_end = 720 + 100 + 80,
+	.htotal = 720 + 100 + 80 + 100,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 20,
+	.vtotal = 1280 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_50_lcd_d_panel = {
+	.modes = &waveshare_50_lcd_d_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 62,
+		.height = 110,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_625_lcd_mode = {
+	.clock = 83333,
+	.hdisplay = 720,
+	.hsync_start = 720 + 50,
+	.hsync_end = 720 + 50 + 50,
+	.htotal = 720 + 50 + 50 + 50,
+	.vdisplay = 1560,
+	.vsync_start = 1560 + 20,
+	.vsync_end = 1560 + 20 + 20,
+	.vtotal = 1560 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_625_lcd_panel = {
+	.modes = &waveshare_625_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 66,
+		.height = 144,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct panel_desc waveshare_70_lcd_c_panel = {
+	.modes = &waveshare_50_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 155,
+		.height = 87,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_POSEDGE,
+};
+
+static const struct drm_display_mode waveshare_80_lcd_c_mode;
+static const struct panel_desc waveshare_70_lcd_e_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 152,
+		.height = 95,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_70_lcd_h_mode = {
+	.clock = 83333,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 64,
+	.hsync_end = 1280 + 64 + 64,
+	.htotal = 1280 + 64 + 64 + 64,
+	.vdisplay = 720,
+	.vsync_start = 720 + 64,
+	.vsync_end = 720 + 64 + 64,
+	.vtotal = 720 + 64 + 64 + 64,
+};
+
+static const struct panel_desc waveshare_70_lcd_h_panel = {
+	.modes = &waveshare_70_lcd_h_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 155,
+		.height = 88,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_79_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 400,
+	.hsync_start = 400 + 40,
+	.hsync_end = 400 + 40 + 30,
+	.htotal = 400 + 40 + 30 + 40,
+	.vdisplay = 1280,
+	.vsync_start = 1280 + 20,
+	.vsync_end = 1280 + 20 + 10,
+	.vtotal = 1280 + 20 + 10 + 20,
+};
+
+static const struct panel_desc waveshare_79_lcd_panel = {
+	.modes = &waveshare_79_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 60,
+		.height = 191,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_80_lcd_c_mode = {
+	.clock = 83333,
+	.hdisplay = 1280,
+	.hsync_start = 1280 + 156,
+	.hsync_end = 1280 + 156 + 20,
+	.htotal = 1280 + 156 + 20 + 40,
+	.vdisplay = 800,
+	.vsync_start = 800 + 40,
+	.vsync_end = 800 + 40 + 48,
+	.vtotal = 800 + 40 + 48 + 40,
+};
+
+static const struct panel_desc waveshare_80_lcd_c_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 173,
+		.height = 108,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_88_lcd_mode = {
+	.clock = 83333,
+	.hdisplay = 480,
+	.hsync_start = 480 + 50,
+	.hsync_end = 480 + 50 + 50,
+	.htotal = 480 + 50 + 50 + 50,
+	.vdisplay = 1920,
+	.vsync_start = 1920 + 20,
+	.vsync_end = 1920 + 20 + 20,
+	.vtotal = 1920 + 20 + 20 + 20,
+};
+
+static const struct panel_desc waveshare_88_lcd_panel = {
+	.modes = &waveshare_88_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 56,
+		.height = 220,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct panel_desc waveshare_101_lcd_c_panel = {
+	.modes = &waveshare_80_lcd_c_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 217,
+		.height = 136,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
+static const struct drm_display_mode waveshare_119_lcd_mode = {
+	.clock = 50000,
+	.hdisplay = 320,
+	.hsync_start = 320 + 60,
+	.hsync_end = 320 + 60 + 60,
+	.htotal = 320 + 60 + 60 + 60,
+	.vdisplay = 1480,
+	.vsync_start = 1480 + 60,
+	.vsync_end = 1480 + 60 + 60,
+	.vtotal = 1480 + 60 + 60 + 60,
+};
+
+static const struct panel_desc waveshare_119_lcd_panel = {
+	.modes = &waveshare_119_lcd_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 58,
+		.height = 268,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode waveshare_133inch_mode = {
 	.clock = 148500,
 	.hdisplay = 1920,
@@ -5697,6 +6033,51 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "vxt,vl050-8048nt-c01",
 		.data = &vl050_8048nt_c01,
+	}, {
+		.compatible = "waveshare,2.8inch-panel",
+		.data = &waveshare_28_lcd_panel
+	}, {
+		.compatible = "waveshare,3.4inch-c-panel",
+		.data = &waveshare_34_lcd_c_panel
+	}, {
+		.compatible = "waveshare,4.0inch-panel",
+		.data = &waveshare_40_lcd_panel
+	}, {
+		.compatible = "waveshare,4.0inch-c-panel",
+		.data = &waveshare_40_lcd_c_panel
+	}, {
+		.compatible = "waveshare,5.0inch-c-panel",
+		.data = &waveshare_50_lcd_c_panel
+	}, {
+		.compatible = "waveshare,5.0inch-d-panel",
+		.data = &waveshare_50_lcd_d_panel
+	}, {
+		.compatible = "waveshare,6.25inch-panel",
+		.data = &waveshare_625_lcd_panel
+	}, {
+		.compatible = "waveshare,7.0inch-c-panel",
+		.data = &waveshare_70_lcd_c_panel
+	}, {
+		.compatible = "waveshare,7.0inch-e-panel",
+		.data = &waveshare_70_lcd_e_panel
+	}, {
+		.compatible = "waveshare,7.0inch-h-panel",
+		.data = &waveshare_70_lcd_h_panel
+	}, {
+		.compatible = "waveshare,7.9inch-panel",
+		.data = &waveshare_79_lcd_panel
+	}, {
+		.compatible = "waveshare,8.0inch-c-panel",
+		.data = &waveshare_80_lcd_c_panel
+	}, {
+		.compatible = "waveshare,8.8inch-panel",
+		.data = &waveshare_88_lcd_panel
+	}, {
+		.compatible = "waveshare,10.1inch-c-panel",
+		.data = &waveshare_101_lcd_c_panel
+	}, {
+		.compatible = "waveshare,11.9inch-panel",
+		.data = &waveshare_119_lcd_panel
 	}, {
 		.compatible = "waveshare,13.3inch-panel",
 		.data = &waveshare_133inch,

-- 
2.47.3

