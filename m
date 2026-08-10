Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64531C5AE49
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 14:57:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC7AB10E205;
	Mon, 10 Aug 2026 14:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SxNytXVp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Y57WVqoT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48E3110E231
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:54 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67ACj5WM1343208
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ulUX1PfhXzORXHlWABVwqkmMfOQ65Z5Tu2tsRkN5/wE=; b=SxNytXVpAxkuWwOP
 qah0ztxp5H8GDVJvce8eXo2FfOoFhFB8OfLe+wq1HjjxPl+nGFDXD6UYe1j0hbte
 Wa48GRaK7rVQ5l8iKAINf7fRiqjWxDMljVFBUvmAgmIStowruIGY1ByP9NMQdWqS
 Q/SBo6fjE9ckfvLm1Py9oLilEwanfhYBSFGzIBh/jRecLHCaeLeWA3Uc5t4Bae8k
 NzkSqDWOdLku8/xj7MpXjJmIMjyjHTIzm7u5IV21TfgVn4cKEJtzvsmX38Fsf6WA
 KQL1ZU2owtZ6pfiN3sM8D/im91SGMW+g7IUH4DCg0mfmwlDKZmTAhUAZs4o0qKNs
 tI5BrQ==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fy8v5a2bg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 14:57:53 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e9e8723ae1so250953a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 07:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786373873; x=1786978673;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ulUX1PfhXzORXHlWABVwqkmMfOQ65Z5Tu2tsRkN5/wE=;
 b=Y57WVqoTdknfdqiMGb8TXQ10R8wkFH9ucziux4pkCcRp+iWK/SHDWLLXq+WJGxtjmF
 G1V0DTxRcxdN9Bu1jow+cBAjzPFIdO+FHAGTKwm8q6MU7cShIRBReiKHN6lK6rjTrvfK
 f8XL9GBpgX5GdxI4SWe5p2/grQZug5YdEcjyygf69OeyfGhYzhkvbUjAnNA0ZTjCLqYU
 xbpAEqB2Tw83nAfCH9saJbeo982vsR3U7sV8XxjioQe77kJQv7OxvsuhnfrUfG53tMos
 IUC3k4bHxpvvUgm2nS8TsN1T6+n+Y/xCur6Ln9vIKRo8gG+34X5ndBCRyNXRXap8qi36
 D58w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786373873; x=1786978673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ulUX1PfhXzORXHlWABVwqkmMfOQ65Z5Tu2tsRkN5/wE=;
 b=spnNi+fchMTJUG4qtNc8u0NLyvEqFtSVHEiBcaAn4zjMHiXXaftFIC6DpbkEHXat06
 1iNmDEUSU+4kNbUsGp1EGP72H4qDWJgu3MTaXlPqfUhjShISwgY/63dE5WPf3Ibg8U4A
 YeWkMpOWt/fiUNIziS4MCWDcaeCRk+6SKhKdphZ9vD0T1hpEO8Y1sosY/Hpf25a5Jes6
 3JLwfo80yb4FvtbG9y9SlFaOLfedQMLYG+bITgX3eyTSrjgj7ul1qX5EY7fMOF1VHbuo
 qJn85vs/MGKIz7G7c9bHx1gQDM716Takqv+gKz8O4vMm72vvMnvxw9jVdNMhmiX3cLK6
 5ICw==
X-Gm-Message-State: AOJu0YxdRMTOoDhBAGprNAzAYrIBwnVOQm4giXGSUe/Suo0aB3VGSNNd
 Wn6U6LdleQtbbGBEjOhH8F1Ny7GfxUxucnmkVXcDWc7GeiQDCHxglkCHEnKRaT253IhhXaIvHwR
 7VN1+DEfPH58sqJMJquOubrb9yXXEw0SaH2rVJZbJjZxnBmBuQluqNvh2QGMMZQvuFpXofJU=
X-Gm-Gg: AR+sD13otPGFmsiui0qZAGEEayl3Kbs2m+HSlEu+a1hjfiHR4MznBB3Sfflbn4yRgo2
 t4QBIhBU7zEfOxHf1lUakQtuUwpXuMzjnJqQHCZxUUSibRixLMtbZ/Yb990Sfy5jkQ8i2ZoJzWj
 34XDutpB9rqzZmfcP8Yix1hAbBw9sSGkzbArWdjjpMm2wFZZNFfQ+ou2mp0JtYdriVc/iNLOJ28
 Aonvp1VHCvUXjUrCwIyNLedymYAy6WqCrnol7WjSanmdRAO8SsxdFjbaJre4DimwUGQEAj6v815
 1UDbfVu/fKtk1uSmffetRXNtpbEZGDRdvAvSvJ1OZR/i04E52VsrO4mgroN1R3qGjyD6saxLoTb
 8pEWkDdSlHMv9B/nsjwIzxQPaaOgcgk0D8+8xflJ2LUO6qDVHhui5DJTPE5P2VwCc0f4xEPGW8J
 nieDEOz9h9jhNq++573eWa
X-Received: by 2002:a05:6830:82f9:b0:7dc:c92d:977d with SMTP id
 46e09a7af769-7f1e5c99307mr15648208a34.1.1786373872738; 
 Mon, 10 Aug 2026 07:57:52 -0700 (PDT)
X-Received: by 2002:a05:6830:82f9:b0:7dc:c92d:977d with SMTP id
 46e09a7af769-7f1e5c99307mr15648180a34.1.1786373872313; 
 Mon, 10 Aug 2026 07:57:52 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f35b806fb3sm7609792a34.25.2026.08.10.07.57.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:57:51 -0700 (PDT)
From: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Date: Mon, 10 Aug 2026 20:27:29 +0530
Subject: [PATCH v2 1/2] drm/panel: simple: Add BOE DV215FHM-R01 panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-b4-lvds-panel-doc-v2-1-f2c2fe309989@oss.qualcomm.com>
References: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
In-Reply-To: <20260810-b4-lvds-panel-doc-v2-0-f2c2fe309989@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786373857; l=1817;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=cQ/G3aEhZWOPjiM3+RnoGE2b9r5TAm6tR5Aox6TLgqE=;
 b=Il+7fsXSCG1eYMlDZaExA1yvXek5wQjItDtpDvc6U+EwP53FIvp2frbKbqayhQSss3iBThapn
 9I69g9dhKXwBBmFTiycu1yth33UPaTlMA9E7ZWpJfjX5ORAnECkzsPE
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfX1oaJ+NqbJ2cx
 lxUEA0dbflGUFRw51/mKJYAjALWQ6XVZ7v4L27ByCqKK9CNpXmid2YM08+k4VvfiJh+FmsPvqEi
 q7pZKfdEEA2QiHa3gGnlluAq9QTfCcA=
X-Authority-Analysis: v=2.4 cv=J6qaKgnS c=1 sm=1 tr=0 ts=6a79e6f1 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=27YqphpXfrAMUR0MhhsA:9 a=QEXdDO2ut3YA:10
 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-GUID: 7V6g6jx8uNqJcDrSv1UW8kDBtLXnff1L
X-Proofpoint-ORIG-GUID: 7V6g6jx8uNqJcDrSv1UW8kDBtLXnff1L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEyOSBTYWx0ZWRfXx3BmIgCjFgUL
 kR2k5kKeOvNWAIxT6JE3S79JptRcsQXszItqKrkK7okcsXMVVMLe/hUlHxKiXMsCP5k6mSgskEc
 wFIzrie4gj9y7cfKa+N/0lalH4Mo1I3t3wM+KhKSP0jVrIcGhb7+VofJuFJVgJ3mH5f+pBoxg+O
 2P+d+pKDs/Z4NpYwCttwdXfbFG9hebIm2LSstnUe8N2rT569q89SJnnnuiZmmfD2k7qIIJmBV/+
 6a436FabNqA2cngPE+D65iJrvp1NBPyohlT1jk/vbd9bvTTeLAgGdchnniWObRYLK0fp7HLo8Bj
 TnvKtp6iXn1igGaO2acgEBj1K5fTtK9kJVE3hkGLvytDzeptZs4HOz9yAJ+y5f+YjvPrJ4R89lK
 PORWkS7EIGEeh2t0uFns7lNP1PSlk4o3kjW0DzfwlwV/WOJ//wD1YT3InqtaF1d+Opa2PD9TpLN
 Qprdc4WUz8rPoL1W2Zw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100129
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

