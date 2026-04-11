Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80A05F3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:11:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07CE10E1E1;
	Sat, 11 Apr 2026 12:11:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H2wHr1uz";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eitT2f/V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3735710E1E2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:13 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B40EuT516803
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=; b=H2wHr1uzFarsnWbr
 RWuyKjINp0F9L7cR4wBFNkE2CKeoiid1RufURMa91EV+DmM/G+Ufoo8CPps1rINw
 T8TwWVgoU7YggNUY2pLR3L3IKyEDEnYH1SMtScZsHqlLBQ/vCjirfTwQSN2Ibr4Y
 /UjgZRvYr7XgcMcklqcvoKZ36ncDkQcFbW2y06i4nMRVhncRKjYX7+PdH+Y8xr6g
 CEplf0vl8zMr0r0gifkSZPpr7bhYNvC4eJxg9tSNKQDHA5QhlFsk7lGlom5P6YFV
 yUjAEorKZSBNx94fkNWkTyevo5DysNIJrW5rdQ4fVVxFfiblonT55kJKrAWXvBEJ
 58Hpqg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtgnhd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:11:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50d76f460b2so66056531cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909472; x=1776514272;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=;
 b=eitT2f/VubHy8mgWeHQiQc8NARpBiK8GTPyoZq/ANPYRvQNqVEoGnMakJoC2KAwtgQ
 9iuBJz+T6Z6HMikPMFfYOVLZpGggNqHz/dtl9011j5gtQLPU4hQ6t6oh6DQ3QvPxsGUw
 qPKmZTlt3x/SCb+ibx5oqi7TiI7uyFykHfMLFo5dxawtTaN6eTnC7UeeA6Juk8wcqxwS
 NT/wpulRX9oOWdnFefRmJfymiKGfs5PwZfpbbk1A5I/et3CoodmdA1vIG0+6eY6rbTg0
 tN6pxEPvgqDA4s8Q0Zy8ixSkh0bqiMiB8sdbcb2VkIn/n2awvwwdOYrOwaHKCgD/WeIz
 4HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909472; x=1776514272;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=;
 b=rMQ7NK86LBfJVemfrD+nsGnSYxzKz31++yymotk16zqT9LTPyd4iDId1SjftPcz6ml
 tbTcLqLrQXjrQz0j0QsUbFJOzOY2oIn0XIxeE755cgPBL2vS65FJs8GW8FWMf2WeR8mJ
 P51Q1PGKW5oVV3FL2PZAKz95GJCff/7o1FBxsJfs3bMDyzC8MbNGrcJSWcjh1Ze6A+U1
 XXbqvHDCciK0K9PTDz58SRSey7VD3Xl6fhdZFM2lUyT5BZqX+7o2LIoc4VzsDR+pqbHb
 I28jWhnsN9dWoM6+2NEuePEHjFzTiaCJ3t+Ee6ciDTGNtWZt+Z5cdUp/ZDIDhgaAKCms
 D+DA==
X-Gm-Message-State: AOJu0YyU4I5I+uqa/ovDwtk7yBDnbCGF88xcigYTqXWWIK68sZtnQLMY
 B5Pg6wAqb/h46u4H/D7LJDwB+b25prHqYEiONssvMPJ5eM8gFTS+byk6LpaxfUB/oUTh2+g91ep
 ZE14tx2Dk8zlcfOfQqWdsNb1stZv7yBKs3PZupAMqYXPl63RCq7ooDu/MzAUptJiJLjkp5Vk=
X-Gm-Gg: AeBDietuA40vqwr9TbSX4GqvhQ8o3yZnrmgH0MjahMyc7NJnzsKJ7GWLg2y5jCBGvtM
 W02bKArTeSsJpQskZNqzavRdFQvltQcock2DxFr+jrlH7NyHUaTyJEPWArp43nHik6/OwFpmdRv
 wsUUC3yoKTb1L1n9IO1p793U0mv+nDGfPqTlHtR1JSiWwt3i4OWiGupbdjziI7lML9iFdIB7SMB
 AGFGAvrRClpmZcQ8X34+123eSuA3EBdGOyeWG8+7EYkaMq9cjRngcYXPX2eEcy32PYfoVEBxb/9
 2CcPLswWImzwvVZmj4qZ3fzgoQp87x5vGCRdqzupCyKCPPEe41mOFWt53gFUk6kOipWNSJFhJi7
 Jnu6PAbsrUWLFweYLD2cnnHyD3UvCYOeAPVK0HeMNrHr3htMN6k7bMLpuwCQ4M1tB/LqV7qqQRT
 bbyV/eUmbGL1+TV/bTMEiXx92WdSBnOLOnul0=
X-Received: by 2002:a05:622a:2b0b:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-50dd5b52faemr113980091cf.17.1775909471670; 
 Sat, 11 Apr 2026 05:11:11 -0700 (PDT)
X-Received: by 2002:a05:622a:2b0b:b0:50d:5a11:1b5 with SMTP id
 d75a77b69052e-50dd5b52faemr113979611cf.17.1775909471243; 
 Sat, 11 Apr 2026 05:11:11 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.11.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:11:10 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 11 Apr 2026 15:10:31 +0300
Subject: [PATCH v2 11/21] drm/panel: jadard-jd9365da-h3: use
 drm_connector_helper_get_modes_fixed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260411-waveshare-dsi-touch-v2-11-75cdbeac5156@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UaFNTqBtKso6xJSLFl/W79hsAPZIEJVjWT3TUsEBupk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpGp8PsS/O2FCpVORjQ8wZCgOK7n8tnCfIT4
 9ECz74fMDGJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RgAKCRCLPIo+Aiko
 1ROWCACOd00exKXMQSTte66G3uQdSbvQqD8KnyZbu+F1PqhFoHjoN/Y2KtbqtQogzyAlM1PZIfr
 sfGgRrt7l/KndKUUm37DqFEJlv9tt0v8WmdwSyxYSLq3FTb6BKGf2UGNiBvHUZQZE7yjZ8lQOLw
 IDUxvTpTPdFgORnWeqkP6LxGuzx7s62h1uxLtDdy60v5MQjR8SbTN5p1Mt6K+26KtHgoTKzsm8k
 w2PaC8gb+AN2kYeNkk3GFLky24wfNQT9WhZtU/Kx7zRIEIqL1KJwXvT/mXOwCqWSly8pxO3Cu/g
 CudT6YRygiFI24casp4MrxAZqYHa6AKL+0Fs7M9qDoyMHmeV
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69da3a60 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xve7C_kOZ5OF2CZn6hQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: v7n98bAT7cWW_hSqMS_K7cZ6nrmwRoH0
X-Proofpoint-ORIG-GUID: v7n98bAT7cWW_hSqMS_K7cZ6nrmwRoH0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfX8KmvLp23LtNH
 KhRu2LQ27PHa8FE5lJHYlz4xWccg9WF0mFRKh9MQjIY1eMh4iVbGxBOEyoCLhGxO4P3wWkbb6aV
 dAn80n2FgEIv1R7yJoZBgEyWUStF0VSEff10to/Uc9cJGrlXujIB9rXlp/kU8wV3g2LXvCnoro8
 kJD6ZxkQ79hI886TX0drheCCCpYNbDMqonVuz8Fpj7sAsnXmahpL0WxpwKcBS3Q6oksNKEg+wvg
 PctFwoLZabfmBJ8/aTHd9hLFdtZ7xuLqXOAnHQg9UIazDGvqem1YdaIEEbMOE/RjKbCBbWWbhKA
 Vbn950vAQgTPUGU0/1YhgbAAjudSe2pYInxQKgDBzQGLk1HIUoM3Pq21j4TGczqj9Dn8nZrvzO8
 0HTjwtp4MM0kDE3p1RLLxKlTrRpOgrPlt8V/iKpvd6CZuu5RFU4/6N4yuuD1vsvm3uEceLNRsyj
 3hRYx/Xsnhf/grZkAyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604110102
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

Use existing helper instead of manually coding it.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/Kconfig                    |  1 +
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c | 19 ++-----------------
 2 files changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index d6863b28ddc5..ba527b4d7737 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -337,6 +337,7 @@ config DRM_PANEL_JADARD_JD9365DA_H3
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_KMS_HELPER
 	help
 	  Say Y here if you want to enable support for Jadard JD9365DA-H3
 	  WXGA MIPI DSI panel. The panel support TFT dot matrix LCD with
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index c33c611e03c0..1884ad2404cd 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -12,6 +12,7 @@
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
 
 #include <linux/gpio/consumer.h>
 #include <linux/delay.h>
@@ -149,24 +150,8 @@ static int jadard_get_modes(struct drm_panel *panel,
 			    struct drm_connector *connector)
 {
 	struct jadard *jadard = panel_to_jadard(panel);
-	const struct drm_display_mode *desc_mode = &jadard->desc->mode;
-	struct drm_display_mode *mode;
-
-	mode = drm_mode_duplicate(connector->dev, desc_mode);
-	if (!mode) {
-		DRM_DEV_ERROR(&jadard->dsi->dev, "failed to add mode %ux%ux@%u\n",
-			      desc_mode->hdisplay, desc_mode->vdisplay,
-			      drm_mode_vrefresh(desc_mode));
-		return -ENOMEM;
-	}
-
-	drm_mode_set_name(mode);
-	drm_mode_probed_add(connector, mode);
-
-	connector->display_info.width_mm = mode->width_mm;
-	connector->display_info.height_mm = mode->height_mm;
 
-	return 1;
+	return drm_connector_helper_get_modes_fixed(connector, &jadard->desc->mode);
 }
 
 static enum drm_panel_orientation jadard_panel_get_orientation(struct drm_panel *panel)

-- 
2.47.3

