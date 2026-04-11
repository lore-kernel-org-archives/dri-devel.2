Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A293F3ED43
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB5210E1E9;
	Sat, 11 Apr 2026 12:11:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cv0KP0Wj";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O7hfp531";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6989410E1E7
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:25 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B48NSK1201965
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bLXfSDjoekZbd9bvQLrfW3Wspu0HUUR8lVk8k9/UCMc=; b=cv0KP0WjdhnxJJkz
 X4stA4ndlJqAiGjQw4CJJENEAjPwbz/L/2IwVvYlliiPxmiCsRewNS6jmPQfHSaW
 ouk0hinEni9zKvCp68z/Yd8dEdtjHddbyOpPBumXXAn6jrEy3coU5FJgSHGSDvuf
 2sFUeW/uhox8A0r5rJXS6G0+4kbapb1mlsnoONMxiASrqkGsxcRJvyu/3M3Qi11m
 VhC/BneoiZooRosvyG2myoKz7+dLFe6usJVmhx+mP1OfP1Ol3ewxCkde4JsirTZp
 YqPENdftZ72dmud9kik/60EpTeWxVtBtdS+vXYb2jyh50q3g8vLb4iuuimCRlkQW
 aEUaQQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dff0jrna5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:24 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8ac7ff4a18aso57868106d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909484; x=1776514284;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bLXfSDjoekZbd9bvQLrfW3Wspu0HUUR8lVk8k9/UCMc=;
 b=O7hfp531ymq1Q1A0h78l4L9Nb4ElnGpGS4edmzbTvoXwzaJVDBF3AWBpz+/foHzu8K
 QPFI7XGALAvisv/SXR/O9l3C+sUTa+MjFgfbLiIQ9gjHycAyrrHcHGOt0jxn4QY/3H4+
 BeiZsSugf9Z9v3dPS5aeBzORf6LABtZ2y7IrAnfSNmVSkM3Apa5kfMVwsYnamwPprjaI
 P/X2Fd2Qc5vem44fYAz3x2nUgQ4Gplk3JzXlf1cfpwAdtiNdSznMa7l7zo9aw9K2hJ2h
 d/3kXbKoFp2cz46DMF7fRfcmVC8vehwzHsPzllkSF4DeTeIGSkTtBMPpuBYShWcPYGbX
 dCBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909484; x=1776514284;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bLXfSDjoekZbd9bvQLrfW3Wspu0HUUR8lVk8k9/UCMc=;
 b=Ijdn69XGmGG4RoVOh+c2XDyxZsKgwTb8YiZOL07ESGJvU1o1ankk8oXrvhMfpDh4qh
 s2IUffwetspXDPjE4wxlfgjZIOoJZQwO/aH8oSq7585D4+MDX1QbhlupiEPyVx45M6l9
 p+FsCIXGPyJ3b2ToXIrYtnfyptRDxU2swzWeAa6aKATFINNQr2FxNFOIRC1QB6fyI6o5
 jXaKx8PEmZFwvIVVR2TBOSNj40lD6kzmzy148rCfPc1YeKa3FDGXn34BsBIom9TooeCd
 Rx9FFpPz2/gDSLN3RK2Klu/oPvUdGRG/1LodxBBECDteEniBuvI55gIEYvNrlgqX3bZF
 AX1w==
X-Gm-Message-State: AOJu0YxRBcuyyeYee76CTQXiPFM0pmjU3kgyNOYEZ/oVmX/srcKa+Cpx
 Zq2qb+X+5tuyW1X1YLG6XzySKdWtMG2ZJUstDqAvhKExQFCaTNU5B7L+T9GDVC0JXGJAFca9Uu7
 tmxpC1Y8VtAFWPm6Z7IYrtqKbj4lrWNHK2Vdlt4jrkWqtiOAXXL76uUuqjEcslJezx3pzqd8=
X-Gm-Gg: AeBDietJoRvYaRgXYyLRoJHYgytrcNmw3XN7RTlZleOwPG3lTj2jbfzgJsk7mc5xPzu
 LlgIW4u71X0WAVKbj/aOOdfxB2vNaKHlQzklHZzIR8VtIdwTo8y6U1thVAIXzhty38Mx12Hbly/
 l5ufehJfTQ19Hq5goMzf2GzC9PteB63nizbfLWHofiX6Go/YH1VP8XkHusHcGR2DYgHGArC0ycH
 yuO3n/nnzPjI9LkGWe2uNrnd0nU8wdRoDIbvbtJU0iiGjCRVCf1FF5P6CTjzrYOH0Cq0Xl0kpNx
 Y4h/CIu2k18Uz7fXAa90GMOo2pH/E/vTXi+Uvzx0iW6+OrU992LojumLYUKPS1v4km0VMOpynii
 XVtJAfMXnpfHzYTiM13NhGwLIUBlQ0OsNjUThcFO4kYCxyQLV5EVsF8MWH0qhmqJFuCr65LZsPs
 uOnwcNOM373e9/vAqMZSywV5PU05xvqeTaMNY=
X-Received: by 2002:a05:622a:994:b0:50d:8656:3e60 with SMTP id
 d75a77b69052e-50dd5bbe54amr99622471cf.50.1775909483496; 
 Sat, 11 Apr 2026 05:11:23 -0700 (PDT)
X-Received: by 2002:a05:622a:994:b0:50d:8656:3e60 with SMTP id
 d75a77b69052e-50dd5bbe54amr99621791cf.50.1775909482951; 
 Sat, 11 Apr 2026 05:11:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:36 +0300
Subject: [PATCH v2 16/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 720p DSI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-16-75cdbeac5156@oss.qualcomm.com>
References: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
In-Reply-To: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
 Ondrej Jirman <megi@xff.cz>, Javier Martinez Canillas <javierm@redhat.com>,
 Jagan Teki <jagan@edgeble.ai>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=15643;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=JvqF2f/cZCMhRUTLLZ3SJuKR9e2V75AVI9tJJQKChzE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpHxs0Q1JzRrabrpyj4PDSGdzcs9h82ZlLLi
 s+VFTYhiKSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RwAKCRCLPIo+Aiko
 1W2uB/9Ud0l6ZOaZ4qPQ9Pio9PlHlDlQmZvIw2SR9EV+0zZlfBW2Uz5Id6eCb9Q+2r/cyvvrx76
 gl5h8Z22nIfTi20bGWBb5wZXG6PAdTynJqJYhQoZY0tFtUZ2TL2TRJ/sTemEjf0ShhtYnO6l8Js
 5iOWj4tuRBpDv0YVvC1YQUeqsMwf7N1t3jqjKQbtuKfP7O8N2rpIlgjw25Meqm04c5QQL+YvBA0
 U/0r20BxjIQHOubkZsvTHZthfIK27YbuWh1/r3rq/dOpzkMU03VqL8GNiq2HKqOPj37uors7Fnh
 k3Jd+af8fQAZ4j9pEg58o4CZPoL11mpFr7f4ngjkwmGrPq8i
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX9iUsm7ay24PB
 1xYsTeVB72aqJB/guLt4qmLTETCLmz+uzMFSAmnKKiFI9qK/vvR7Ph4k8JQverKzfBl4Da0UAzN
 VljOwcy5MGNB8VA7iA6q8fmP14V3Li1WDcdypvn68fTgR0Axxs0RS4XgrVMXVtwe8iA4RK9P2et
 sXuW10eTK0WfBJf6U4j+D7/lkIrCmASTbQlbA4090SmZluh4a1iA6hvp4CrzwGxOURe548TxYyB
 CDCH2hADlCxGBvLFlQ3z4rVPBdNaOPqj9xKpTd0aoXmPUsvPBvyQELpR2PZ4ZDAnDQ0pqm6mFhL
 yxKgtqhI36sz9+W/2Yxhm75plr2s7I30cJZXzWDmoq1FKUctC5pRiUZHdycezwApWJjgLxG8d69
 7BEXNaR9igWCvUWIpRT8MNpr3UDd/PeE5r3mB3GNJE2lGvZxh1Jp8G944RjzL6osOnQJXQKQsXc
 UrnZb77SKHoCuVGgwQA==
X-Proofpoint-ORIG-GUID: lcZj__FP-3ejStH3QjiB7w-_Mdf07_NL
X-Proofpoint-GUID: lcZj__FP-3ejStH3QjiB7w-_Mdf07_NL
X-Authority-Analysis: v=2.4 cv=d/LFDxjE c=1 sm=1 tr=0 ts=69da3a6c cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qgCH2gcBsTXXTDX92PcA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604110102
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

Add configuration for Waveshare 9.0" and 10.1" 720p DSI panels using
JD9365 controller.

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 312 +++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 49c47f2bfbb9..e9a461239301 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -21,6 +21,8 @@
 #include <linux/of.h>
 #include <linux/regulator/consumer.h>
 
+#include <video/mipi_display.h>
+
 struct jadard;
 
 struct jadard_panel_desc {
@@ -2283,6 +2285,49 @@ static const struct jadard_panel_desc waveshare_8_0_inch_a_desc = {
 		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
 };
 
+static int waveshare_10_1_b_init(struct jadard *jadard);
+
+static const struct jadard_panel_desc waveshare_9_0_inch_b_desc = {
+	.mode_4ln = &(const struct drm_display_mode) {
+		.clock		= (720 + 60 + 60 + 4) * (1280 + 16 + 12 + 4) * 60 / 1000,
+
+		.hdisplay	= 720,
+		.hsync_start	= 720 + 60,
+		.hsync_end	= 720 + 60 + 60,
+		.htotal		= 720 + 60 + 60 + 4,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 16,
+		.vsync_end	= 1280 + 16 + 12,
+		.vtotal		= 1280 + 16 + 12 + 4,
+
+		.width_mm	= 114,
+		.height_mm	= 196,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.mode_2ln = &(const struct drm_display_mode) {
+		.clock		= (720 + 50 + 50 + 50) * (1280 + 26 + 12 + 4) * 60 / 1000,
+
+		.hdisplay	= 720,
+		.hsync_start	= 720 + 50,
+		.hsync_end	= 720 + 50 + 50,
+		.htotal		= 720 + 50 + 50 + 50,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 26,
+		.vsync_end	= 1280 + 26 + 12,
+		.vtotal		= 1280 + 26 + 12 + 4,
+
+		.width_mm	= 114,
+		.height_mm	= 196,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_10_1_b_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
 static const struct drm_display_mode waveshare_10_1_a_mode = {
 	.clock		= (800 + 40 + 20 + 20) * (1280 + 20 + 20 + 4) * 60 / 1000,
 
@@ -2627,6 +2672,265 @@ static const struct jadard_panel_desc waveshare_10_1_inch_a_desc = {
 		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
 };
 
+static int waveshare_10_1_b_init(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xbf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0xbf);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x7e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5a, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x27);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x52);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x14);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x25);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x23);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7b, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7c, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x27);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7f, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0a, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0b, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0c, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0d, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0f, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1a, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1b, 0x77);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1c, 0x57);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1d, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1e, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1f, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2a, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2c, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3a, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3b, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3c, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3d, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3f, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x17);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4a, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4b, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4d, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4f, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5b, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5c, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5e, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5f, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x66);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x13);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6a, 0x66);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6e, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6f, 0x88);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0xe3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0xd5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7d, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7e, 0x66);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xb3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0f);
+
+	jd9365da_switch_page(&dsi_ctx, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x1d);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+	msleep(120);
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	msleep(5);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, MIPI_DCS_SET_TEAR_ON);
+
+	return 0;
+}
+
+static const struct jadard_panel_desc waveshare_10_1_inch_b_desc = {
+	.mode_4ln = &(const struct drm_display_mode) {
+		.clock		= (720 + 60 + 60 + 4) * (1280 + 16 + 12 + 4) * 60 / 1000,
+
+		.hdisplay	= 720,
+		.hsync_start	= 720 + 60,
+		.hsync_end	= 720 + 60 + 60,
+		.htotal		= 720 + 60 + 60 + 4,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 16,
+		.vsync_end	= 1280 + 16 + 12,
+		.vtotal		= 1280 + 16 + 12 + 4,
+
+		.width_mm	= 125,
+		.height_mm	= 222,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.mode_2ln = &(const struct drm_display_mode) {
+		.clock		= (720 + 50 + 50 + 50) * (1280 + 26 + 12 + 4) * 60 / 1000,
+
+		.hdisplay	= 720,
+		.hsync_start	= 720 + 50,
+		.hsync_end	= 720 + 50 + 50,
+		.htotal		= 720 + 50 + 50 + 50,
+
+		.vdisplay	= 1280,
+		.vsync_start	= 1280 + 26,
+		.vsync_end	= 1280 + 26 + 12,
+		.vtotal		= 1280 + 26 + 12 + 4,
+
+		.width_mm	= 125,
+		.height_mm	= 222,
+		.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.format = MIPI_DSI_FMT_RGB888,
+	.init = waveshare_10_1_b_init,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev = &dsi->dev;
@@ -2748,10 +3052,18 @@ static const struct of_device_id jadard_of_match[] = {
 		.compatible = "waveshare,8.0-dsi-touch-a",
 		.data = &waveshare_8_0_inch_a_desc
 	},
+	{
+		.compatible = "waveshare,9.0-dsi-touch-b",
+		.data = &waveshare_9_0_inch_b_desc
+	},
 	{
 		.compatible = "waveshare,10.1-dsi-touch-a",
 		.data = &waveshare_10_1_inch_a_desc
 	},
+	{
+		.compatible = "waveshare,10.1-dsi-touch-b",
+		.data = &waveshare_10_1_inch_b_desc
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, jadard_of_match);

-- 
2.47.3

