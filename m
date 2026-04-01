Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7F5D3514C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86FC710EEED;
	Wed,  1 Apr 2026 07:27:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XqV4iPUS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ja93qslu";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8BCC10EE9D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6313VTer1459610
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XYgkyJPQYnM/gelnCPu4vbxoPThepd6pRjAGrQkZhJE=; b=XqV4iPUSpsD+anTu
 IYck91RTks0ZooYyW1QSXoXMWdi4fbUD10dwLwIu54kAMFbZ0u+qlPv9tKBEAW2a
 7y9Zb7FPiKBbjCFHIPt5tDILTR5s3EuVx58iKSyy1EmEzXxFa6g8z+XTvymBcJhZ
 tlX8YSbquq2AjoWwUNSVxWYY+FAGgY/qcGOSmKWMfzuZRxYV7WPRMzdyBz2EBDdA
 2cfeR6Cej4JD6VQZ8+1x1A6nSGpGsRFunB8hAA7lJAET1mtZjgb67ZqH56Av9Syh
 ng7D7iOPglhgWNSurV5w6/FcBgkTszQa0pe9ITZ02xflLahnS/RLfDni+1bM+Njw
 87Xn/w==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8uhg0uuq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:05 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-509219f94b0so80213951cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028424; x=1775633224;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XYgkyJPQYnM/gelnCPu4vbxoPThepd6pRjAGrQkZhJE=;
 b=Ja93qslu5V7P1nZ2B+dG7Y07BLic1dGbz0X2X3FgnHbLuWqckY8nRBJBCmPdfixBHF
 +XX4I8A5/dzdg4PY1eek0UhWTiQZeEqPibI8iQv8Bozlh/1carZ5I23aK/5du8v4ajdH
 dJLMNWTS7O1/MiThVY43CxRO2gCDRI8oBkKh6Jbc+PXnTI4wtmPetz6+LSHubjpIr1RA
 NxNhb42JdGTFtNNCa36mu9FJttiJSWTdGPy8CK5CPKHlMSCw5W3Cr2AeSWhUeoDht5yY
 swLgSw1Mnn+6B5WUBh2szjhgzYX6QpyhG/P60Tq1zlxGRg0F00wNTfb9s8aCXM3JwnrS
 YEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028424; x=1775633224;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XYgkyJPQYnM/gelnCPu4vbxoPThepd6pRjAGrQkZhJE=;
 b=mg5fCqYUBJqFrczmlFqfMitnPfXT8VXylz1qiZeELMpU3r4J8+qvvGjl80lOt4r0Bk
 ICPxstPepuozreKE65xbqNXX/TrDAKpeSNy+KNeYaAadTNhkHdAfJOuMIkICtcbJpaiJ
 TQsxTORepNIiIHKiTSLwVbvwVlyIV/4Q1CxGsC7TGPPN6oBNyNMQJHSJsO/tFOtKMC/D
 rJ1/MSDXAz776MKBr42TlxpvpVYzJnxeCYBtHdIaAv95xlpCE3Hn1Ix4ELm4x+O8xO4e
 MTSSe4IAwq9P3mOOZn0JbctMRgRsm7TzmPJYTJcQeJU66gypCUXrxOrOEOs3vx67zeXt
 wQoQ==
X-Gm-Message-State: AOJu0Yxmc/eeTJt9abcB+KiBo6e+kn3I+lq8sHEviWuzyyfSuUuOZF4C
 uFOzmbQWfLhxqSe7LHtQPqxvvWajxUX/Mh+posf1BJ2EGqaF3+tdbj/elVF+tPwqq34MbIxWZW7
 h8maHUDzPw3cCpzW29FyiTCYRVEUxUwHE9GKjKOG5OA9WDIbWS8qD4Xu8godgR+r4+wyeQuw=
X-Gm-Gg: ATEYQzwgCTB0l3bzAa652AF+ANyTc9apT2JkCsm1wa7oklF2/0+8ipU2k9nZqdV5ook
 AKDw+b5S/qcnYHs408aWzSPTloZ1dBWNDM8DK3kYDcwEBgBQrWx7SZSEIXwP/BHuZFv5CXofP9o
 xQhxKbUbjQrAfJAZvancUs69jwl6WYtJSi1lLSSNHpgWOAbS51YFdFv+BYgpihtI9KWDzpnsrq3
 FJpcpkqOx7oQvVvpBOTyGwx67C+PQiqvbpjkiD/2DiQ2UzKBxMcihWLU0JmIbWVN5HC2NO8m6AV
 UqkSlvx145xhHHRdMcNe3E9hDQiV8dJc2rsTiDJDSzVIyh3lE9+54pNXoQTn4hYMzu2qM2LNGkt
 TyvIEUB9s0csOSBzatt0Nw9keUmTSJHDIcnOqs+MFY3Vfbc4+QzanaYk7HiIIc89OZsALo7thy0
 bES5vkasAuA3AA72lASTLDaE/0VDTIieN77io=
X-Received: by 2002:a05:622a:1f92:b0:50b:4226:9250 with SMTP id
 d75a77b69052e-50d3bca3ef9mr33564811cf.44.1775028424023; 
 Wed, 01 Apr 2026 00:27:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1f92:b0:50b:4226:9250 with SMTP id
 d75a77b69052e-50d3bca3ef9mr33564381cf.44.1775028423522; 
 Wed, 01 Apr 2026 00:27:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:27:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:30 +0300
Subject: [PATCH 11/19] drm/panel: jadard-jd9365da-h3: use
 drm_connector_helper_get_modes_fixed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-11-5e9119b5a014@oss.qualcomm.com>
References: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
In-Reply-To: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2222;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=8tZscVF4LDTph0agFYVE6JixtCC92BuTMt6rtWJ2nVU=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+aZE2ueBWfYLpmo2dTDwR3qESfD9bzvyo/9cS8Wf3qu7
 viqqntXJ6MxCwMjF4OsmCKLT0HL1JhNyWEfdkythxnEygQyhYGLUwAmYr6H/X85Z73Aa2WN3/zG
 V2VUbntaLtG5fLpR7MXSo7+eej3Js2SPDVRhnG8Uyy0kuqD99EoLpqYmkZUFnHUnVjio2XTaXWZ
 bFl6xwjGhZOutTuYbIemNTvtvFnosF+364WugcLS6bYfoxqyE1rbzHHkp8ydVsnxUVg7dtvSKVE
 9LseqhY+HiDfFB9oFP87O6I4M/XDQ+/XNb8+w717/pXvMo5DHOeD/vfdAlW7cVgUsLQtMKbbwL/
 tndm7jHzfq6W2rfqptbP2VM7ZK/pTkzvtUurUxb1yAx7OlrVqezmREBZe8nZR5/NPvgg8nbDTok
 dmzLqndyPMf3k13KNeXlP7lpd48vWlJrIBHAWWv4TDUWAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX+6bpaJFV9vWC
 lGqM3xlf6GhK2DXsWciY3/tH9VRABxVBiXxHB3F4Gr6wjPg1yaorgrgsoEi0MooVW1oNnQQKcxA
 qf5r+RFV56sm/6DqS5TUVeZNwJgjLfCj5aPovHkVvNbT2IA/GXSLDK5Nz38d901viBLO5fwK96s
 cMb6PDscgXR7oaF/ZvKnI2rR0ivaFGxs2qSv9Pez7w0nTVh8biYLjn0u2v1N9bgXwTYUnozCMx4
 vzaBWXTuOLiKDq5vejvzMVl0YnOzj7p9htUwvgQW2NUeHcocVT5xZW6DQgoZv+wJdckUSPysBuF
 HJVC7hJbCrX93Alu3G5U+sUWjqFO2w1TKbi61xYNhE0nXbPWdLKZ+iLNPTW1hthHSRBMTZnjsKw
 Q9WX1UrFalLGnE61omxuEHRvjaMggdpC/CNiM6zNHXmQM2pHbspSCn9FPqqU6jZPj+JiO3d1hmn
 +FOr5nIoPtgknTKAkCg==
X-Authority-Analysis: v=2.4 cv=YcawJgRf c=1 sm=1 tr=0 ts=69ccc8ca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=51Y2UJ0wBrkUc3uRPtwA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: A78iYME2rMmYjv-L85L_GGFz1mA1riAN
X-Proofpoint-ORIG-GUID: A78iYME2rMmYjv-L85L_GGFz1mA1riAN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010064
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

