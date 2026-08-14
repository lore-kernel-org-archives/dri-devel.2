Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DC19C5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 05:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7F710E0F9;
	Fri, 14 Aug 2026 05:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AGHvo4sT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xb1Mev+P";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9311910E0F9
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:38 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E4QfTZ308291
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ce0j9kqec2BozQCWX/HU4Au7T9oVRbcvVr4ZTiOz7M4=; b=AGHvo4sTvRIsxhAS
 g4gjjAERmGalPLRoiXaXfORg8yaHEHsAGB44ORR2UD9TUfc1D4qXDXHcsh5PzZf9
 9uby9Gw7T77JzmGS+xJ83RESCUBuDf3fKzY/21eaeDvleMi38RFbD1PICMHUOgb3
 fbs8SY9OnqzV8DvZBmoLK5pfxjvy2+UAlCiTwgGO0GBRior7IG5Pv06qc9zFkmO2
 HU3u5DYoy7Hid0lDgqwwjmHFnjXy1oZtwvQ+5VVQ17EUS6nATqEpvcJC8sdwA058
 5OGai+wJX+Dx17wx14VbePkkDkwVRgdeR9WWOQuUm7brsQy7W/Wb+sr2wV4d/HIU
 4sDbrA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1j2f2fda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 05:25:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2cfd13d6d50so1362295ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 22:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786685137; x=1787289937;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ce0j9kqec2BozQCWX/HU4Au7T9oVRbcvVr4ZTiOz7M4=;
 b=Xb1Mev+PeIRBGX2foclUD1KkXj/kH+a8kt8S9JaLuCTlnRsnIx3W139AyjYVzAKkvv
 rnay//nZQ0jjfE96Fu0FONGROgnIQqSsvWzah/VDFJh60T0Ej0/9mJE3I2/m7USiLHMU
 ekiQTtHD2gGvHsiyUtGRm+GQzgfmoxv5IIhdmQRZxJH6+ECkP4CQtzo+kSQICImXif/N
 10jpq4aYd/H9h+FqhLpP3I+6dLRBIMPvffk4MGkKvVrJcpWiiufXN0UVPQxvEwCx6bHF
 wFQWoMZvUvCvzI8s1V//kzvEqVq+B85iLwYCOgadmg9PXuQmlQg8Cxn8PCB77w5nkCec
 v5Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786685137; x=1787289937;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ce0j9kqec2BozQCWX/HU4Au7T9oVRbcvVr4ZTiOz7M4=;
 b=CFK0QgoZfrAdy4K0qadrV6EMHAb3lPvo1t4CiEXhnvHa3zzQIcrUaiuMS9iiooVbcT
 kLqu5RW5EmqXhBfPjXOc1ln0gYHc78LhIJ69upso6foIUIuJQM1vHbsNwyz8YclK8V4Y
 yHJVtI24rPccpxYq8FjbBrwJpYsMIkHtHmiUUM9sMzGn45SQBd39pqCH32b3x3BlSArX
 E7V5CTkVDWXiIgzL/q0Mt6NgvrLArSXaLVGZ4LxJhbbNu+B66GByMeU48cxtz/k/vx/f
 Z3IWMUov/ZwbVh2qlC0QyCJFQuunCpXeojnlXpiesEHYX1zEtVbx0RVAaxx8I/TBADZW
 /I/w==
X-Gm-Message-State: AOJu0YwULxOBK74PVrSNve84qwiyUsYRlpOiAH4JCM83LrrZCEL3c/fI
 dHx/koi+7khD0l4OSQefwFfIwIeMMNShMDNMIR7eS8vb8nlsyCojAetsE8SKcHx94QHXcARjhC5
 OevmjNbhTc1vwtCuW/pprdrHP4WDspCbTEUt/lsacayr0XFJsOV+onyMImWU5300GL46p5CI=
X-Gm-Gg: AR+sD13TVY6xX1k6SiScUIodmwHLe8Vz25CUcaxCiQIfXCo6eZEvr44fc3SM2K8S2G8
 s73rpWufSRtwzJ40aXHkQmBY19+EVYGanUFWy74qMGB4PZmxnynpjpY9EP01XH8WjZdmBKX8o5u
 RY5I/EHSxZrJFaUMSnH6a6GaVQUjnRxaNnn62kMuCQCzSRoWii22b1IUrUvnzh7AeIljSQ/TRxT
 t7arPdQDrbzyyEnjR9qRWhreZh+YpPs0y/+vwIrBcSGRRPoTmN8rqg6Ak831da9oGadaMhqJKvd
 6spaOfGf7/Dd3fVhFeAqRZY++Ho43/HtJVrV2KQGGBRNOId0GrQYR+bLOXz3slxaYCMPdLeCcSm
 F3m0rVlUD1fxls/Kyof/Sr+6YZvD0BnJd9OIHztLDaGUYlHPa4+DYA3K6DQuDsdqo/aEF2uzQVQ
 Yp8qiKDHTBDFOTY5Jf2U/v
X-Received: by 2002:a17:902:c944:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d3b04fdcb2mr28535365ad.0.1786685136137; 
 Thu, 13 Aug 2026 22:25:36 -0700 (PDT)
X-Received: by 2002:a17:902:c944:b0:2c9:e846:a582 with SMTP id
 d9443c01a7336-2d3b04fdcb2mr28534395ad.0.1786685135117; 
 Thu, 13 Aug 2026 22:25:35 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d3aeb2a0b4sm4545835ad.53.2026.08.13.22.25.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 22:25:33 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Fri, 14 Aug 2026 10:55:14 +0530
Subject: [PATCH v3 2/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260814-b4-lvds-panel-doc-v3-2-1ad152a4d3ec@oss.qualcomm.com>
References: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
In-Reply-To: <20260814-b4-lvds-panel-doc-v3-0-1ad152a4d3ec@oss.qualcomm.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Liu Ying <victor.liu@nxp.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786685115; l=1815;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=IDfGdt05wbKpTqwcyV3ZKkZoOhDE/6Rs6DoHy4UqGl4=;
 b=Px9ZZvPD2msFkzIyxT52YmJ/GV7f4w+8Q0kG4oLoyF7LpDRhUIoupdm5dtgRfecVHBkJR9A6X
 CXIQB+079fECSncKXtc/wawq6cTLWbgnF7GADVMoFSjdwM0jZiF5GF4
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Authority-Analysis: v=2.4 cv=FeMHAp+6 c=1 sm=1 tr=0 ts=6a7ea6d2 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=bP93rsPOkRt1mgqf1Q8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: HxR570aNjhr58sr_GOZm_QwK2ocbwMD6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfX5Qtb221mYGfd
 2yOT2Fzn8sZAlNtJQMYZ3/BfIHqANk3RsNgyjeZJNa18CO+FrypBbiYJEalvKebhcC4MENwBiDy
 ppCnIQ+UNWCnwOPjENt6AUp1JqoGymYG9p3YPPsiQDraeTlBcNVy5SGX2qXAajSZO/hoFfxbkxi
 PXeyszFzkUcnBZX9ZWB569Lom3mzlJL26eGWhKzxaLR0kt8w4lHaZ4goX6IfMw7xcctiSpFophl
 +SB7BsWcAM0lQXlFmoVXddXCEHGsmX6DQsR4hsaCYgIMXAAWZmx/w3xM2JYh2qvLKD5ijf1ssr/
 IikRgUivuXfgR2IyAhESU6x9EB4z4pDgCXN+HCnCrQykDNwMnbrJLRQHHgEJxGSvpo+SnwUXSeN
 9O3+VkbkbYbPTWtHLkQAwWdUm1UL5Cy4Mg6kLoR6dvMgtp7y+MomEH6IbtM5QmLMt7TowuzMeF8
 Py4MN033S+xTIduwpHA==
X-Proofpoint-ORIG-GUID: HxR570aNjhr58sr_GOZm_QwK2ocbwMD6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDAzOSBTYWx0ZWRfX0aKWV4g84Q4X
 T6SbBFEVmgNOEuIm7G+XDgq1VUqYm3RxNlKLwKhaZBgFCowawXz/XwTdpzG0ajqoOgIO79Mf0GQ
 NIxTVRFNUNcAATKVJ0M/arno2mpi0Xk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608140039
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

Add the BOE DV215FHM-R01 21.5" FHD (1920x1080) dual-channel
LVDS panel.

Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 5c169fdf265c..d95f842c8980 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -1563,6 +1563,31 @@ static const struct panel_desc boe_bp101wx1_100 = {
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
+static const struct display_timing boe_dv215fhm_r01_timing = {
+	.pixelclock = { 148500000, 148500000, 148500000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 88, 88, 88 },
+	.hback_porch = { 148, 148, 148 },
+	.hsync_len = { 44, 44, 44 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 4, 4, 4 },
+	.vback_porch = { 36, 36, 36 },
+	.vsync_len = { 5, 5, 5 },
+	.flags = DISPLAY_FLAGS_DE_HIGH,
+};
+
+static const struct panel_desc boe_dv215fhm_r01 = {
+	.timings = &boe_dv215fhm_r01_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 476,
+		.height = 268,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct display_timing boe_ev121wxm_n10_1850_timing = {
 	.pixelclock = { 69922000, 71000000, 72293000 },
 	.hactive = { 1280, 1280, 1280 },
@@ -5726,6 +5751,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "boe,bp101wx1-100",
 		.data = &boe_bp101wx1_100,
+	}, {
+		.compatible = "boe,dv215fhm-r01",
+		.data = &boe_dv215fhm_r01,
 	}, {
 		.compatible = "boe,ev121wxm-n10-1850",
 		.data = &boe_ev121wxm_n10_1850,

-- 
2.34.1

