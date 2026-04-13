Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA06F34C55
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA4310E4BF;
	Mon, 13 Apr 2026 14:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DsbWhOA8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bhDymlhy";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D550710E4BB
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:17 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DCX8sM297551
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p78UaevwLARzSkVeb+KKl39OUhhXUBe8MTm1QeWZ/mE=; b=DsbWhOA8XusaIl8O
 usjZ+kEZGI5cP6EIhe9puAgLsLwD7emeJRaBO68gBkkucnMicByHZwS91nlB9P1m
 Ai/B6mvVLM/53C1oV5/gSsZAgufPyqs423wQCrL2edfTAjHGy1hPdOBUEFGWsMKX
 roErFXsi9YBazCHm2Ppz/HX90Cc51dOJIeYFc+NiE0v8eyMlqkD/VWZ+wvaAdKXC
 eklB1//5gvCwNM7I9BXLoMOItMA4jEPI4saO3W2oynFvke9YZNxGSZDD+WzYUdq+
 GNbuobljwaZaYhIh63p28f1HLx7NOC7t2esdm2D2xC2dfzmW0PTH6649mPNse8mj
 u9Feiw==
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh0kd0byj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:17 +0000 (GMT)
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-46ef241b62aso2681948b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089177; x=1776693977;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=p78UaevwLARzSkVeb+KKl39OUhhXUBe8MTm1QeWZ/mE=;
 b=bhDymlhys5eTEAAYi4ZtvKxrogVfpG6e7hIMsSllOMGejvFJnHlL/YkOaQwit0wgN/
 DAaO7uSH+oF0Bg34LQjQSLoLN+ysuxT4m431Xt9JIrxB8XUn9DFe5kxIron72cBVDguY
 mH1R77pFqAr3ekffInX6EbHsFf8GAaoeh7Q/B+fCZ37CfkOvkePaCEvpF29QrN+wuqqQ
 YPSAqNKOzJhYPdvRcbDvr7lDvySZrpjeBNJbf7PfEmFNjUIrRsF5KXrchp6xuZY/0Gzt
 nCaA7eCCIqt6m/6OCq037267HhLk/xkA4/SBRKMWlPvb01egzg/1oU/UZH9g3Fm+eH9v
 cTSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089177; x=1776693977;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=p78UaevwLARzSkVeb+KKl39OUhhXUBe8MTm1QeWZ/mE=;
 b=eYLt0zalQDAH2QtxldJ/lI03t43FZZ7RRHA+J9EApKrltXOwUfeZoQkbYvc0SmvINA
 1T09pi30G6PpEx3q+AKnT6YHp9MhHlo3QxXAsNkSHZz62w16hrVY58/cvGKUTy5owcYB
 79BHgHjQW1ZLlWvzwBPVeFvU4j4bJuDftrujmyO1PcTaHhVS+BTVL+55q8xOYw2vJqgN
 cYluk3VPcj1yYbzkVWlCfdXDHh5fIz687IjXCwCDU7krJfPnpGFGN8PNKm0oTwfQYDEM
 XQ1qT8xodvFRQAKGm7Xzpp0jfXx2LG7IqcQhgSMAlcLI98B8KhUKFEjF41IV1VmbtCWc
 05eA==
X-Gm-Message-State: AOJu0YwaI/bFbsqFiIcGSV9ndSczW0E1DI5RLNjgzun5rfqw3McfzBWM
 kyr7Do8T1Cn86Bnmdt6Ug15dS1CbtlnPKFZjwKprN7+OKZjDNR0XrDvql9Q6Df5eaqKiaz2lime
 226SwuZk3WC6EBlHSGFc2KozKHib84fxVRdIyS8y1EAjeVE3QdInka4W/2TywBG7o59MUNoE=
X-Gm-Gg: AeBDievGXc2RTWBT48NNXdO7WuTskYGY0jq15GFWvZ5kp5IRuRY0qKPemUBI042KXFW
 y1/OY1TU7eysqPlGz8lFroS/KpXvbg0lYB9T1lvJVZKyr6bMRZmKZZuRf8HQRYgXqkeGZogmkX6
 /TezyKzL4z9f1jhDdXwT57gvKkeqIsizS6nZzOmnlYCxbldPv9qbl5vUF4WvNiI7+d+e8Z1Hq7U
 5YVN2cgF0zgtpRDtMj0mTj3hCKMwnv7rzRKxzKvmQs/o8U5JUR2pEywP/K8Zf6ab2IU3Xy18GTr
 k21x2/ZDcZkamUNTjiC66wL3P2b+lWRBGi+P7PFpWm+CAcLlyh8l6nAtfti87VG8MAIQR/bY9VH
 Nea5zrjaiLJW6udyglcn7Z9Ut8NJBymom4uxRJp0rY11voFehpPr65cayMqA0AYLH5yx+S6XwwE
 wu+vI7CKFlrfnGM5vkZqNSQ9iWRgE2b7opz6I=
X-Received: by 2002:a05:6808:5293:b0:468:2a6:e32c with SMTP id
 5614622812f47-4789e42ba5amr6087955b6e.10.1776089176370; 
 Mon, 13 Apr 2026 07:06:16 -0700 (PDT)
X-Received: by 2002:a05:6808:5293:b0:468:2a6:e32c with SMTP id
 5614622812f47-4789e42ba5amr6087894b6e.10.1776089175704; 
 Mon, 13 Apr 2026 07:06:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:39 +0300
Subject: [PATCH v3 16/21] drm/panel: jadard-jd9365da-h3: support Waveshare
 720p DSI panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-16-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=15643;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=i/SoNHcSayVBIBioV2QuYYiEm2da1S4Pj0J5C0tmjFM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgo2lBnKTQi8guyD+eeglC2fjYuNeeZ2GpgB
 f9iUPrSNO6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KAAKCRCLPIo+Aiko
 1RfSCACsy9QBg7E9w5/7KiMfyfj4e4mq5epA+CkvHgYhx9Jp6KfkQumujQ2hlXcK5rYjT31CPLZ
 aL23RqEAlVCtwjCrffCLdDSIgt3i7+RxsWMciMyoCstFdtHUKxAc4zZ4jkBoyK2XBbBPHMNSHYf
 8TNnwy3XnkH1AyKR/rRhIedHq2QXByUXQ6VKBdWp2VfCAKoEnZVI3IhmqdWe3mZJiPQCRa5fbsr
 GTOZCmq7U0S+Npg014/2y+a6Y3Jr4D97j4q7ReYhGs621U9krEM+02XlBA70IP2xnd4oKUs84JN
 0w+Y4uH4HDECKDQsnw6/k1p4ZgEEX6i4QO4GS3DrNIL/f4ow
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX25voy3Sb4Fn+
 S/edpYCj3wUqAcRA/CF+t0uPW3Vj6dx6bVM7Igoe4+k+OSZ/K8WCq5NZAeuk5keDYpylUBMP/Vn
 6FXRyv/PCFINnHk6VtgZQOh8t8OrBNLapnwRh2J0NsICw9Excuvzoue2BVhKkdS8pcI+AMh6sGC
 Qb1eTCqjZIThzQSAZAIbQV8UOP5UgMfuOeGirba8ZDAdFOa5JHB03hbRD8Xx2b7JwyYua/4VUGh
 udHZgsnw7obGb05WRgVuo2KUfwedjcCFWUaxR93nkYmAa0yM2D1nUGalh7a3u+ppbm0Gmphir/z
 JIyEMVyXPeggje3F4PwSBdYVMOIwvzUkd+glKeHL4aVHovddK/clqEo0CK3PRLYe9vrTJQ7T39D
 QX1iPQHbg3v8261cErYE9VJHF/cn//jJ8+Scz0NxW5+Q9BvU7qHXPvihmb5rtb5UeOaCCvmAVVm
 uVXfQksZcAA1ds51dfw==
X-Proofpoint-GUID: FivTNStZiwn4TxrDEdlHftBO3DmXjd_2
X-Authority-Analysis: v=2.4 cv=D7x37PRj c=1 sm=1 tr=0 ts=69dcf859 cx=c_pps
 a=WJcna6AvsNCxL/DJwPP1KA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=qgCH2gcBsTXXTDX92PcA:9 a=QEXdDO2ut3YA:10 a=_Y9Zt4tPzoBS9L09Snn2:22
X-Proofpoint-ORIG-GUID: FivTNStZiwn4TxrDEdlHftBO3DmXjd_2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
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

Add configuration for Waveshare 9.0" and 10.1" 720p DSI panels using
JD9365 controller.

Tested-by: Riccardo Mereu <r.mereu@arduino.cc>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 312 +++++++++++++++++++++++
 1 file changed, 312 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 7744c66514c9..6fff3299f4ad 100644
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
@@ -2762,10 +3066,18 @@ static const struct of_device_id jadard_of_match[] = {
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

