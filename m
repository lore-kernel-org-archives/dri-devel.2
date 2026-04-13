Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE38F34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7BF810E499;
	Mon, 13 Apr 2026 14:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vs0pyw6I";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LTTlReqc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D24510E498
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:02 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7Z1el602445
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 soWGaZBES8tfQvM623FQdy4oD0NG4+O2a7JZZa/XJ4o=; b=Vs0pyw6Im6wAPJ4E
 jbtfa40XFGRGis9oQnahi489qW0/Eeoc+1vjFhjsq7M77woyyoAOcpHikjNREySG
 DvDoYBifhgSTX93MQaUg/TXzgeMEG99KNt7UAeVmaVWItkLBFFpVpVHGe9q6eo14
 sA91zcaWmPdGayvWsHW62EnwyDyDbQwcK1fnocWu65hSi+Heu6pENK6n4fOMNAb1
 GZ68lPEEGXATisCiSjxEum3g8yAvel4EBCCZKRUIBsWhDQxOqRrMGbfY3semyCuK
 KOWZtf6fXyaHJxNysAa7+Rs7Ni3cPihjMgyZOondPagQRsgmYClSIvSO7zQgmlix
 yjpChA==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfffhwjsp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:01 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-471618e2082so2860048b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089161; x=1776693961;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=soWGaZBES8tfQvM623FQdy4oD0NG4+O2a7JZZa/XJ4o=;
 b=LTTlReqcMCBmNJW/qUePWhR/mww5cU+cJXy05k9YBAmP4zTMQR7imOmAvY0s4eXeRk
 HJb7FztjDmdygs294c28B4tO8ffsXbfSWOz7PGroGwTSvnz+jh3VA0mPSxHVSMgru7TW
 33iWwsLG3s06ovFkjvaJEKvVkwJTU8cQqvztGCA02xSpT+FTiWAu24tKeonwF6oJ7Xa0
 zsuV7yVKG/g1QYjw0T8u/5p1qugs1kXILSJnJ0+SBJXvelC3VAIkjSZNm+wy7IXFMWqf
 vLojPvjc+l8Yl/yJu+rJ4YVH0ySsdV0jNWx0fLAwQ4UO+feec0BUvokQYANw2xhQeRN/
 ss6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089161; x=1776693961;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=soWGaZBES8tfQvM623FQdy4oD0NG4+O2a7JZZa/XJ4o=;
 b=tYA/sbGromY2O5+o2OkSdaEu+1RJDXDhxWySZHaygPy5BuXyBT/vz7Ua1RoJLyiHsq
 WCA98tESAaIQfMSSEsshImmJ241js2KgTvvjT1qHGr20Pa81YUG3sR7Hz1L9j3nKUNVz
 CMDPjBdfHPjTZ9IJTtUzmhf3EBd/g2oNU2ZDiHI1eSo02Wb+72kE997OXIEt3EAtmqfa
 +kpFn/nD1I3uBZnZ9fHtXB3MxZBLMbJpgz5N4auNxEIxYVw80Sw/bRhURGyONuVwPyz1
 fRu1QBCjnezoshE05dkk5UjQOhmHTrhg93XPddIfBtN9pLeqM0vDL99rgqea0hlQ51vB
 Poeg==
X-Gm-Message-State: AOJu0YyoedYtXBmrnE4PDukXxmv/79S62CZ056N6TGkMiHxiMA/AsQ33
 GA37SFnN1SBhtNIKypg6vk2RQxC3srVnDVrDiplFI6RFTnDSKc1v2D/C2Z3NMZqez9qYAgd2LwE
 InPO1tDvnbN98BTG3jni1tcfqOV19uX/sfCqD6OcC/nhCSynH1TcrfQmXviH0+pD7p1sHeUw=
X-Gm-Gg: AeBDiethJ/2T708UqcmhK35elpHXZpbRKub0vGuW1T9U9ORfT4gQHac1ONEviN0PQUe
 3OgAe4i0B8w1I1e0dnwWIt0s5AVRs0od7TUpwVaO443tKBFzGEGoY7tDqGo+o9g+jQuDWe9ASdk
 4GWg56s5qVEDkJkoU/i1SzmzvIPhlqKjO50WpCk3gnSxB+CMWYBVCd/PfKlGJgqqXp7RrR+5ZS/
 pZwodQ/uI6HElvIq19Zu/U8vKquawqP4tf4L32nZK4ZujOC6sY3ebYdZeVhLnnza21u7K9sWP0p
 tDq9IpoMrLpsMzJelHd1cmhdoncRIcWWQR5Qc7nyVpDlW61Yr6xrB9963l95r41u3Go+by3Qd5q
 cEWmZ7TM4RaZKtyu6Ps/KMklv3iDxtWz/eEp9yKBjKsx0A1bnXlrNfgFpGpN446v3pzGrIGIj8D
 6KB0wMI5kzrY6W8hysxt/7LILDqKN9qZC45oA=
X-Received: by 2002:a54:4e83:0:b0:467:143c:7733 with SMTP id
 5614622812f47-4789f50b735mr5120159b6e.46.1776089160772; 
 Mon, 13 Apr 2026 07:06:00 -0700 (PDT)
X-Received: by 2002:a54:4e83:0:b0:467:143c:7733 with SMTP id
 5614622812f47-4789f50b735mr5120104b6e.46.1776089160147; 
 Mon, 13 Apr 2026 07:06:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:35 +0300
Subject: [PATCH v3 12/21] drm/panel: jadard-jd9365da-h3: support variable
 DSI configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-12-3aeb53022c32@oss.qualcomm.com>
References: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
In-Reply-To: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5137;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=FkFZggJQ4487S25zzpLFnL1lJQsN5zZZyfnh6wkem6I=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+adHxq2eeveiwqWcClanL2hcLHQrfJyBEPZ7hxZ4yPMC
 TWMQZc6GY1ZGBi5GGTFFFl8ClqmxmxKDvuwY2o9zCBWJpApDFycAjARAx72v0JxNX9C2ouXmS7p
 80/WWq84y5Y3+fIxjuePXiVM/1uwPPzRvoTPCq/OXJ3m9D2JX+t+4EalHXZuK0I1KnJOTD0U0zt
 n86IkwRijIjeHlhzbnzfUjJxTTS/NPMG525fPb+an7RNmdLk0hvGdyF0WYFJg6f7sh3fACvWWfw
 37zDbO0XLeUFOxoa3083Qp5XnMc3gr+3Y1XJPtdor+VWukev2D8SFvT+sVcw7KORcX71db/kt/q
 lbf1YywI84OsYVaKtm5HrqbszmP+HNofWD/prBr3pc/9UmvOwu6j6fsyD2WtObBSTEJ7Uf8bsza
 V29PPnZlQgGjwm3LW/eztCavCngv1NYvkZ++Yab/7V3FAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXwuI/jYnPwiqo
 +P9Vf94+aRGU5b4mYU87KCssfdsVuOxjlQnnEt+T66PyyQR5PJRCps59Baz0BHToQiYLv302GRu
 BVstSZ271k69ZOWDZWWDufcri/nG+9rIzTegZPXFHLZu041gxZk+DQqAFxM3roPLnBPZMZ74Fz2
 QoPqzheMxqoxK42PU5smdGv/u9pMEhQx/kGc4XrXW472z7z0Zurd6o19lUJm06WPKrI1WcnNWho
 usEL+0fWTN9LO+BCjO0sRMjXdPWPZsUZFFTSjR21nb+suWo7do1zjTdXdjLnOkTIBRstIOjMMKT
 ZGMJ9zdceeOcjJbZg7w7AthSHKLa9tHmdID9RMuR0HUDBVUx/7GdJjGO2NaIBXvrteJzEllmrEv
 ayB3b+WM+nQbgbqcjFHG0o36FOSHmfNuTZwsvo0N7C+LaHsUX4sYvLFPXPYvAsY1O86HlN0Psbf
 N/lvDUZ557KaHsgEt7Q==
X-Proofpoint-ORIG-GUID: CXX7GQVYU5iwXn0K_BKS8bd1l9ySHDq6
X-Authority-Analysis: v=2.4 cv=FOkrAeos c=1 sm=1 tr=0 ts=69dcf849 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yD_1ZbJdsTQQo2FcdCwA:9 a=QEXdDO2ut3YA:10
 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-GUID: CXX7GQVYU5iwXn0K_BKS8bd1l9ySHDq6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130138
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
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 46 +++++++++++++++++++-----
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 1884ad2404cd..796cc2368477 100644
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
@@ -1614,6 +1622,26 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 
 	dsi->format = desc->format;
 	dsi->lanes = desc->lanes;
+	if (!dsi->lanes) {
+		dsi->lanes = drm_of_get_data_lanes_count_remote(dsi->dev.of_node, 0, -1, 2, 4);
+		if (dsi->lanes < 0)
+			return dsi->lanes;
+		if (dsi->lanes == 4) {
+			if (!desc->mode_4ln) {
+				dev_err(&dsi->dev, "4-lane config is not supported\n");
+				return -EINVAL;
+			}
+		} else if (dsi->lanes == 2) {
+			if (!desc->mode_2ln) {
+				dev_err(&dsi->dev, "2-lane config is not supported\n");
+				return -EINVAL;
+			}
+		} else {
+			dev_err(&dsi->dev, "Unsupported number of lanes, %d\n", dsi->lanes);
+			return -ENODEV;
+		}
+	}
+	dev_dbg(&dsi->dev, "lanes: %d\n", dsi->lanes);
 
 	jadard->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(jadard->reset))

-- 
2.47.3

