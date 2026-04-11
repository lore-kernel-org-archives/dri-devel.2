Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DC1EF3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0067710E1E2;
	Sat, 11 Apr 2026 12:11:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGo2FMSp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DOFxFIM6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E554210E1E2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:15 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B40LrY3909843
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VffLj0dx4ChWNgZbhFjLmDZu+t4dULnpnscDgkywfYA=; b=JGo2FMSpMoW/BmT/
 jT26NL8tz9/2MECla3xT7mmednM2lrOtKO9YkYxRJbKBw4/ZUKhHu2z2hd4e4s0X
 uHpTefQzmTO1Gk5zxoBKaRFv+7UzvZuQaavXqM4TW2mrGZC1rxu2Iq+cu5wdvBbz
 2NKAdW+HbtVByVa0UcvJmQs/rWdfbjOswExwlENK5eCvgjzaTzCnGtFDBuJVqiK/
 8Pxxfg8t6Zg9SdXB8LvhjJKQQPh0YTQkqRBMEBXM1+nqg5QAYcoQbvTmBCmXvA7t
 NX9tOY/fOMEawj5I+D6trObkEtQSX77gbF9Ng69VZ/SVIR8ByCZNZwV2xQmX9nkO
 Bi8JZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfew00nc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d831e8083so26152411cf.3
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909474; x=1776514274;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VffLj0dx4ChWNgZbhFjLmDZu+t4dULnpnscDgkywfYA=;
 b=DOFxFIM6iPs7gexltnq+/T/Hlz+7eYy20d2eIfBlqL5lbX+dm0JMK2GvVu97cDXMJ8
 BrhmoD/CwcBxKySjyginQofhTAIAIqU4ltyReYgh0XKjTbfI7DU69x/krxU+GAQmHsaB
 YS5jUEKCAcPTcusRDgT40XGeQ+zB1sMOLKYfGp3j9RWrX4ZAZgvZrCpUo6s/Plo6M9I2
 f7osqPW/Uv6cLf7pCF8QSCjfy6Uz2zbQAd4weh/3ge5Cv5ia2ERoynqczVgEBD0EOMX8
 HCNJCm5go0qlgSDT21Ab4S3/3bIlBhzDVbeZJPo8WnJGFCiiDgioDlwUThZPUCtr4KSQ
 gdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909474; x=1776514274;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=VffLj0dx4ChWNgZbhFjLmDZu+t4dULnpnscDgkywfYA=;
 b=Sbq9Eyga7gFeA9re0eIppzaykC+pTmfzaAF1qD0Vzmz2cmXQJ05lNP7uT9vxYTfLJz
 B4W5AOX2csLYIQRF7XbW4d4vcdVgVStTp+GxRz3H99/L8+uRWLAJX+hIYLVDKWZ7fv9s
 20+G9qeSdY/XBGzy1sXKPPbZAf8HDxydfy4dRIe7zwKqEXHxLvE4fjZ63y3692hPNomd
 JYSGYuQhU5qIXAjOGCdW7TqBlMkuzeceCqn+xqG/SdWDVrXxLKcGclqrcPRo6eT5AX0n
 ob5RclS5eR1XSDBvJbSWTs9OBE8jDkC+7B864jGZ5pLhT4Pixed31E5LNgPtM2Ghz5p8
 emAA==
X-Gm-Message-State: AOJu0YzkSZDRhtp37KtjI+RhWhFS6CGlslQNPx9Qq1oQjRvxLJNw/MCw
 yfX4A+VRMwb48qmbNOfipKOiyZQc/dem48gTKqDrNo9xGcdAnzjw3TXsh8KKF0qvj1twIcsNz60
 b83g2s0VThy79FdYuuqmkR5NSo2VEpzVARxUher54ZFPzaLstRaMi91KOPB+1BHac/X5lw6w=
X-Gm-Gg: AeBDieuc35qGIew9nFcq9LI8q6us2hmvwmJ1NfoBXlpdMDkjuuJ0qjAURsvM9AX/Cgu
 NNbxO6VTV6cys2XSvad3AIsXQxHXeLYIE8m9FxQdM8pNCAXn3JyVe9gNroBYq1R0uKN7+vLpTZS
 mV4/Hrh2A6GFOkx36PkR8W/sjP2H6UjWby9l21qEtR/NNwwdtMosCrMfiCzMJPbHj9onRwuivE4
 M3vpErPzgIRB3MWUXurPBg8h0K3B8qKpH1yy7o5hh5xxcBvY8q/Bs7IHPSG2YGtzHA8zPrHXpcT
 MZCE5QcobnsmJkc/HP2Z3F8nRB89e4GUi7wEh6qcmXIDVzg5xCM3NyUP/ptaL1j1IuvRGxJlJJb
 sIIX92peEyR6ynnbHO2olx51ThnEdG9+Nb0ijkGIBg0kV1hsjdcUMi0rlcoV1ud5FYOmR+4u2F4
 /r6KrmyjP/kyZGChfOxEtZj1UluwNYA9Fj6Pg=
X-Received: by 2002:a05:622a:a410:b0:50d:e1c8:5ed with SMTP id
 d75a77b69052e-50de1c80b8amr43323171cf.52.1775909474420; 
 Sat, 11 Apr 2026 05:11:14 -0700 (PDT)
X-Received: by 2002:a05:622a:a410:b0:50d:e1c8:5ed with SMTP id
 d75a77b69052e-50de1c80b8amr43322671cf.52.1775909473977; 
 Sat, 11 Apr 2026 05:11:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:32 +0300
Subject: [PATCH v2 12/21] drm/panel: jadard-jd9365da-h3: support variable
 DSI configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-12-75cdbeac5156@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4724;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qxvBzNbPk5EGLmpGBUzeeM1J6/sQ4P9lHmhYV6FObtE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGCyNgWS/VQHaa0ne99WdMtW70FVv8Vqmq6
 FSQjKx5p5CJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1e35B/9opzvZiiuLKmiI1OJgaoCwVAxBS6CoXFP8o0c8sZMNFgzUBiqEY+ts0wffKKWllGxqLto
 EHogyQkv6gmrZs/tHz1n+QB2WM+e1LhzMAMvH3QtbFewJTU8kdsIy4Tjq6z5BP1vfspcOf+rLNB
 gp010f7ELFnKYmzALFbopIxREP2+WHURp2n17Jr6U5DliXqsuuv1HQ5yR/JPC0V/IFCLB1VQSi/
 fBFsBFkbeE8Xm6ETVo26S5iS64uxXCHMSn9iQvNZdm6zNplJdZ3tknF/n16AmJJOEHDaEYMcZzD
 UJkJ5BQ76D6+K8JeD6NMz3UgBfL78rE5HDMPIV97GdnoDP5G
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX0iu8Qpea8C7X
 c6u55fuoibIkp/0Y2/Rqt4SUrw0xE2ubIX3d5Tvx5z3NnQi8RRJaZCLNbWnr5eFmdypB0D0XpA0
 6pQzSd/HwAcc2IqItAa3lqMDxehOVk/dOVq+HByGtEQRjvrrjOEQx7dJaRwZK7hN5cBt6Wo4a1Q
 sJ5im6Do1fUQkF+oJtjycNhjX90du1nozVDL6n3lDVeURp7sTZON6bvS2v7RZGgn55YMyj+h4Cq
 RXvryjRVm9+1qjOghTAfDW3O81ObAI56MOfIMJP67cMepsj7nZ5B2YVm6ljZvo2yLQ3t8/3xqdC
 DbKxntnuLweOy8yyuwOKZQmJPWaIG6cuUiCO/eNJpAcYrJhitVXba/dszjD/3ATPEvBO+1oyGED
 +HUGM4tudCig+4eDGRWjDSdLdnDglZ7/Dso8b/H+MYDt0GPLjzXV0SDQdIplmtAFHgg6E0hhpn3
 EyltbgejrMBaQRPc8/g==
X-Proofpoint-GUID: w-NRiX8bFdNCuUEufaU_Ryd8TDeLdaxz
X-Authority-Analysis: v=2.4 cv=AofeGu9P c=1 sm=1 tr=0 ts=69da3a62 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=hyEcIN-V0XolZWHaHNkA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: w-NRiX8bFdNCuUEufaU_Ryd8TDeLdaxz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
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

Several panels support attachment either using 4 DSI lanes or just 2. In
some cases, this requires a different panel mode to fulfill clock
requirements. Extend the driver to handle such cases by letting the
panel description to omit lanes specification and parsing number of
lanes from the DT.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 32 +++++++++++++++++-------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 1884ad2404cd..5d9db2e1f28f 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -23,7 +24,8 @@
 struct jadard;
 
 struct jadard_panel_desc {
-	const struct drm_display_mode mode;
+	const struct drm_display_mode *mode_4ln;
+	const struct drm_display_mode *mode_2ln;
 	unsigned int lanes;
 	enum mipi_dsi_pixel_format format;
 	int (*init)(struct jadard *jadard);
@@ -57,7 +59,10 @@ static void jadard_enable_standard_cmds(struct mipi_dsi_multi_context *dsi_ctx)
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe1, 0x93);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe2, 0x65);
 	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe3, 0xf8);
-	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
+	if (dsi_ctx->dsi->lanes == 2)
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x01);
+	else
+		mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x80, 0x03);
 }
 
 static inline struct jadard *panel_to_jadard(struct drm_panel *panel)
@@ -151,7 +156,10 @@ static int jadard_get_modes(struct drm_panel *panel,
 {
 	struct jadard *jadard = panel_to_jadard(panel);
 
-	return drm_connector_helper_get_modes_fixed(connector, &jadard->desc->mode);
+	if (jadard->dsi->lanes == 2)
+		return drm_connector_helper_get_modes_fixed(connector, jadard->desc->mode_2ln);
+	else
+		return drm_connector_helper_get_modes_fixed(connector, jadard->desc->mode_4ln);
 }
 
 static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)
@@ -354,7 +362,7 @@ static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc radxa_display_8hd_ad002_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= 70000,
 
 		.hdisplay	= 800,
@@ -586,7 +594,7 @@ static int cz101b4001_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc cz101b4001_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= 70000,
 
 		.hdisplay	= 800,
@@ -819,7 +827,7 @@ static int kingdisplay_kd101ne3_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc kingdisplay_kd101ne3_40ti_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
 
 		.hdisplay	= 800,
@@ -1070,7 +1078,7 @@ static int melfas_lmfbx101117480_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc melfas_lmfbx101117480_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
 
 		.hdisplay	= 800,
@@ -1326,7 +1334,7 @@ static int anbernic_rgds_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc anbernic_rgds_display_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= (640 + 260 + 220 + 260) * (480 + 10 + 2 + 16) * 60 / 1000,
 
 		.hdisplay	= 640,
@@ -1562,7 +1570,7 @@ static int taiguan_xti05101_01a_init_cmds(struct jadard *jadard)
 };
 
 static const struct jadard_panel_desc taiguan_xti05101_01a_desc = {
-	.mode = {
+	.mode_4ln = &(const struct drm_display_mode) {
 		.clock		= (800 + 24 + 24 + 24) * (1280 + 30 + 4 + 8) * 60 / 1000,
 
 		.hdisplay	= 800,
@@ -1614,6 +1622,12 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
+	if (!dsi->lanes) {
+		dsi->lanes = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
+		if (dsi->lanes < 0)
+			return dsi->lanes;
+	}
+	dev_dbg(&dsi->dev, "lanes: %d\n", dsi->lanes);
 
 	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jadard->reset))

-- 
2.47.3

