Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14355F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76FBE10E498;
	Mon, 13 Apr 2026 14:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="puUlI4+D";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c/QGcDXY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56C2C10E497
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:00 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63D7ZWCo1662303
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=; b=puUlI4+DX4qwGTH5
 RHMURzdt0Lpv1Sw2CFZE3g9NmPvy5smxeDnIavis57cNzhPLcBPhCNYFBmHxSjAf
 3+YG+omEAAdN8ulT34BlMfVwjB0FEHrnKEueZhCKn9MZndzL0e3AyvPbzBzOegA3
 c2uDGPE7hQOk7zY8/6lOH/XzosEKupk+17cfwQtG2fDhQ1Ob4d+MO6WqVM6PfS6E
 uCgaxmH0F3JnuojDEe0aaIgWJ5i7a8EiYG4VDdgunsQerY2xC8HJcb1VdjD6/96U
 v8yC5zdiKTJUdfkIiDIVgnPWKXrfvud/u6ibuMpKd63nWau3Jy2fo1hiFfz+ka/B
 gwxsqw==
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfwnwd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:59 +0000 (GMT)
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7dbbecac478so8290829a34.2
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089159; x=1776693959;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=;
 b=c/QGcDXYABnPTSyzlK8OAGpCOgvxeFK4hDdE5XRdbHAXz0YbFbr0ahaZK5ztdB9yVD
 o1zyzxW3w72Cq9okFz2HuFl2Whnee9ydvw50JyIqgs0CW0ojfp5WfqSyAybdN/aWvfXv
 qnCB0t9WlP4t3OIAJLVWSpGU2549ai2HgzJExGIx7gto02tSxXn6tHJfgt2iUPWIX0UB
 Zv/3GQ+0Gq080XKEYxljyoHmIqD9nTXiq3RJfAh/ObOx8GkxdSMqQp2dV1/lvpPfBzpW
 nrjxwuUTybbGbdixa1RGUqWinyYYgLXYDdaba4Em6331CCdJRWel9N2vt2UOCucjq6xn
 8G6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089159; x=1776693959;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YpKBdNEr1u1AKChljvnO5kynR6OA2izQM/2xPpjPVvg=;
 b=bEFhMsQ/Y9glV3Bh/bX+JoH9/J8BjDMWqE7p8j0v5EctEUsb13sfLpdxxvHWRQ9Bqe
 pLpeYie/5MOJvpwMtvKsRmeCmw5Wgq/kVRjrtUuxlXLkppRopHR5fh+1SL5yT+Rl01Lr
 nYBVV1uY85Ta8y+Qq/z5l0SoH2/vpXPJVSm0gzbxOLqnwb7I2ZNbYL8mfvsbEgP1MVgR
 1Us6Qvf5PFb5N349/CIScJL1Z5kQ0D0zcnllhMY4JCw+Z2og80AjexKhjKJTfsFJZ6sY
 QzVTdK5Y07PbldMCahgeZh6imBptXs2ZKHKnadNOXz7/29mrzZ9RaF07/ZqB3vbuetr6
 dKmQ==
X-Gm-Message-State: AOJu0YxTQ7iV4uy5/+0k7S17yVHVuFipvStYzfwZ6w69rtx6igebTcAM
 y3jlMNRkoEVZSoUmuwUC+APMOllZBul00ndH3ZlvVqBAxD44KQuPzhbnfkT0oFCmTaAZTGYKy/B
 JEg6eo6QjNj+dRWJKoJz1auR+zuRbkgVgg6GL4J8KTtvHS5h4V+eKrBi1YKZxIjGs6x48ngo=
X-Gm-Gg: AeBDieufLEseDM1GuEygQZuJLEpxju0yVi+Rokm0HVq7ZJ356xvQHDDRP/qZBgpklN/
 0b/MvuG178Mqb4O0Y2FgVnyNir4vTjWhb7r6KWtAcp26GLWni9Y02A42aQ56upm2UYDSmHTkWpl
 G4DtBKnvF44CxwlvysVlA3+hK8zbRqXquFn+cHSdUfMytOdL9SwtYW6MZIh7zVJVQyiOE40EvWb
 NQaw2eNpKtcDpFg8uf7UQOei+R8k4lorW9J5tw8TfZqfHMUy4KNNhSHajeXbGwzS52iZOMIKOwo
 KrEROjzORSGfU8VweGqNVQluB30jjt6W36gbaWFy6a/FDM/a8GUqHknbvvb28c9ABjlhUxcE1Fj
 QmKTgSClzOcHpf+jhAKNT3vjCi7lZFWMgLh/1AO3szCz0XOpqU4iwAdUG8r+adeUNSRRbt2KQLG
 xoxhbbpWqMnaquPR4kSJLdjAo7Mc07DZZsSLo=
X-Received: by 2002:a05:6808:e8b:b0:467:f36d:a08a with SMTP id
 5614622812f47-4789ca3af45mr6286633b6e.5.1776089158729; 
 Mon, 13 Apr 2026 07:05:58 -0700 (PDT)
X-Received: by 2002:a05:6808:e8b:b0:467:f36d:a08a with SMTP id
 5614622812f47-4789ca3af45mr6286600b6e.5.1776089158117; 
 Mon, 13 Apr 2026 07:05:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:34 +0300
Subject: [PATCH v3 11/21] drm/panel: jadard-jd9365da-h3: use
 drm_connector_helper_get_modes_fixed
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-11-3aeb53022c32@oss.qualcomm.com>
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2270;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=UaFNTqBtKso6xJSLFl/W79hsAPZIEJVjWT3TUsEBupk=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+adH+pVL1xYlbIFuwo295yVeTVtlm5Yj1+raPRrAZF1w
 gaau890MhqzMDByMciKKbL4FLRMjdmUHPZhx9R6mEGsTCBTGLg4BWAiEw9yMMzaLRsi+61Q0PWz
 0tkp+z5L+JnyNeosVTzJNcnfU2hFQZPp5yPlR2rrjlq/uvNfNF1089kJVr0/pskLlAu+qWHY4WN
 p+VK0V+Dyq4CiVntnoU6zhOWMpq8kmF8yHEsrOnN4trSfeuUVxvUf151LYc1aLm7SpnGZRUDElO
 Nh3IRdjee3TT34ZbPU1Fsfwo/ld6ibPuZSPRi7NHBZUWbJ5+xc/firnAbNcwN+lCW6OK/dsNmBZ
 ePh9/J7D90wD4y+ZBbD+iLKJ2vHxrvzcoNbGAN6DDJWPGLWlKzdyO58RtPz/KIVD9xeyLkZ+7Cd
 5FatTbIVZWRfnGAbu1yve/las8NHPBnc1HqnrjpleOgjAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: J0myNjf8YF1hFhgq7TTJa1LuC9rNWREu
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dcf847 cx=c_pps
 a=z9lCQkyTxNhZyzAvolXo/A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=xve7C_kOZ5OF2CZn6hQA:9 a=QEXdDO2ut3YA:10
 a=EyFUmsFV_t8cxB2kMr4A:22
X-Proofpoint-ORIG-GUID: J0myNjf8YF1hFhgq7TTJa1LuC9rNWREu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX6mU4jz6cVr1z
 yokG9wb5xZdl7YF/vtxrPoYwQUBmXZtxRc9+dFAjBjBIVwbUN/SjXWgElipP9Bu4A27xPBlsKPP
 HLdGBCzypOnLxol4cIwUm3lN+STGhF7MXyMzYjpYEwrzdi0cjJx7Kv3Yh9YjLPFWRTSySV1F81f
 j/rODn2NzjeFjNuxRbadYXFnyaSJcG6ICes7kTB6/y9HjBK+hJEF7s+MnNGe+X7VB0MGm9mEvWZ
 hmJuU+/4mch2HWLn2EegM/mekPI+T2nm81z381d+SuAXT2REZ05aV5JNUQpp3ZZCqnLBYRmFyVe
 ygcl3FEIlAWWFk9aTOsXOYrbYOcY72xEyNzLgzb1/u0ix3RRGVdgdPwq7XHjInv2F5SeaP+B1Db
 +yGPEsaYby4m45tVKR+oqpKNUmOGIAUGJduXZLM22+JnVqQ61CAN4U8oQHEEiRETOaZ/Bn/0MlF
 ERDVTKYfV685gnSsr2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
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

