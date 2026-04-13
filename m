Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E0D3F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91B5D10E48F;
	Mon, 13 Apr 2026 14:05:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGJNhAmc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TeWkUXQT";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E8C610E49A
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:54 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDxnDm479862
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=; b=oGJNhAmcqUVZFoGz
 dukV8+oOCJGEHlwJWl9l3UqJgQXRa8iuPSg5HUUL5unko/EhOMc2x2YhHIrWO1XJ
 HQuXjlbeGGz8obla8hctdJwUTD9cOch8nNJiPthXo6ndecoepBrEg7uZ2BFFAnCT
 SRV3W977XmuyJUcWD3mYHtVFk4KmmqqUPeJUyZz0mMZSC5tqYZq2zJ4w04fdrQFp
 LTWyJRZ2XqKs8QxlgF8DCdUr3rSRnTONb5CWiVd3g6TBoG6IrZ5KYhHJlurUykpx
 ydVMVeDLAt4xK7/WzTF/2YfFQHsKaEgpIH2bDrwuUVJ+CgbuBDJorpUNacBnOT6H
 +mcW7g==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dguuj9dmu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:54 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-471618e2082so2859746b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089153; x=1776693953;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=;
 b=TeWkUXQT6JTnLxUkbKCeFFmc+ySovSbQuA4qHgFvM79RHJ63C7l3sF3dbDtkth601u
 r0H5Z+zVo2ZHI7Af+MCVigRsQXAOkaO/cMe5o5qi71kLKwWDy2iIX/oDMx0HtRJS1JwK
 YEaeVIk5S6RLJ/BROEvIax6LXhDKvA+qIeJjIgkztfwmjkzvlnSTxLg1i+CgX6JfEIoe
 A7bof/I0CaSCDyReUU8dxIbtGMoGFzn/xLKEBzT8G92f3zTRDZNHaJfO2KuZapUfZ9jD
 wj46dMsbVjl+A/Y6IC7m0DN6kHHgE5UHniY7m4uv63virG97dGqbL7Vh+KPooAp49zIo
 g0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089153; x=1776693953;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zzlcIKXiRQAFXIYPSVS0Jyv6z26HXplRvWhk/69wTo0=;
 b=ppsde95Hs5tXvOqU3wbH4Js7gTb75WN0NKqwbRvZ+EYxPuhprlF8FVFTAYRU0Suacz
 e+AXuy9HFIBhZp0zB4pDp7nJvhf3C8i4JH2ArFdSfPrZiyC/+IVBtxQorLrBZNuOW4pv
 xkGg1ziQa0g25WI411H9tunvX2YSR1whKkM/nn8zfPnTNiQtybOUZH+DxWPw6+cmY0Sn
 9/DpQYWYyCXUFN0sRHz2Pvn7gqfDo3m9iE1sSBkfZFd+k0kHplWxcUKAUeKcpElfdb0S
 A6k8z9cH7iBee2m/Od4IE7lcw3wrmvljBH4Ff7T+Xbq/c052d/e22bKYwK+WPY7AbqaH
 bBhQ==
X-Gm-Message-State: AOJu0YyGZc8GluNU8QqtC+JleOuvC5+YWFZx52cKskZnXswSOhRj5Jze
 nVjfGHyk3C5HTPKGbhE3Ktoy9h7C1LnwNuaY5+axyV/J8iicZYWAQCHZn4WtCRvMdsAtgxH6BD9
 qOPX48EZqAhzOxq4UUU8ntuHo9rO1DKaGIbBGSQfTN6AgjIyZyBvsgFMOs8q4g6KOQpWg8ic=
X-Gm-Gg: AeBDieuvKT6rJR/5vbPhIRGKkQJ2uvXSnStOVSnRMRZlEnVDCC6yjSQRlQRHZOeZvmo
 imNO6RDIl/19O3B/dnI2Up6XccuC7edzKhNJXd0MuMUEDLqacdTwUoUlvRnLDTMmnCW8IhGJT65
 ytPXdVzqlsCYEAMUGrvnXHvG0pDWoTvcUagAlAG85ENrCax8H6HvHf5/3Fi6DSO33mmQnkSuO5+
 I//EILngu0fUKafB+qchYgZoEcW208yBLTbLbP4dfXx/Bo5Ir0TfZ/hmrdelxvHQq0/7Bc5TyeH
 XvZyFAOl0iLi6IJUyU2PiWwsiKUnRkDDR1zRWV+D7sLnnhB4JD7gmvJvJRI4n0j4Y2z6FTZzeyH
 rtfaDBNMbHFrfU/eTp72au4hC1QF56uXgq9EJ3VNPPtJ5DrKl82kjnEaPng5nNXpv5lWFdouVkB
 ZiP4zvqp6Qpl0BDLWxnWdD94Z6Sjv6sQXWBTU=
X-Received: by 2002:a05:6808:23cd:b0:468:48d:806a with SMTP id
 5614622812f47-4789c6495e3mr5922014b6e.2.1776089153209; 
 Mon, 13 Apr 2026 07:05:53 -0700 (PDT)
X-Received: by 2002:a05:6808:23cd:b0:468:48d:806a with SMTP id
 5614622812f47-4789c6495e3mr5921957b6e.2.1776089152744; 
 Mon, 13 Apr 2026 07:05:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:50 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:32 +0300
Subject: [PATCH v3 09/21] drm/panel: himax-hx8394: simplify hx8394_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-9-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2523;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=sQ69JX4wAjTsBAqHELNV+ZWRZ1CzDcUvy3hc2w/OnYg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3Pgnq9wrcj5XzE9oVZBrEZ73tbhQ0/6I45ZMe
 5cGUc3/NSeJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JwAKCRCLPIo+Aiko
 1QBSB/9KGQm1y1KQajg7NwOIhHN8WXXzrrS0RWTsSDRmNGY0j0OwvgRmyzjEYEMlApcJG5cGSW+
 MA+QpWn5TKdgsx3xafMHT7Mn4rPdD2MoT8RE+NT/v8ne1/0vBgFzeZ+FVz8Rvr6c0HAIXrO+nIy
 +zj6bEkP4rGqq0S4E0El3RBA5FH4C6GWsAXJCIZ0Ym65f4KIomZJcJ5Y05xNq1ZXxRAc16XYUNo
 Z7Xb9OUE8fD5A/4ARm7uWcXinFOVqhYd69y89t8OPZMmqr8/WaQvDaV/Pdyo+pyZWS29fKprvci
 byYPvo0iwqec96IDG9c0HZAx2dL5BzflsfNu46HVuLuVQHfp
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX2g553H64loXL
 hxIWcWCQh1xlzzmOBW/28WdJPAIE/7BRV9DcS3RzLA2uifSKKEWd+FWRQ32+C+37XKZAFYLBTON
 CLZYMioiVnzoGR26WXD5scIHxPJnGCSQwb620v7mpIPygLByp7tI6CmDNxmxkhHi+hALVLXl5iP
 /bdwxBDemMMfLQX/ux6OuRUBorSSamLDk3nLN5e/hCF4E+Ov+HmK6LzMOT9hb8fd6j7xFSvnxgY
 qDnyY7mMuAU/BIXZ47HySbME66/QOXkLNQpTEDpYj5GC1mR6eVBmoRuv/wZX9+okg/52QIn2Xyl
 T7ECFd5XU78BTkXUZ7R+t+S0tBETpeVuYd+BCh6HlDNjc1x3HnRUrXfRCfZ2GywV+Yjc3K+JV77
 cjCeB4BIMwtqD/giT823KmvQ9RM/9MPHf12UzZywVDDDA58LcJBdYdV4HPigTIOnZ0Wb5/4QmaJ
 sGsW5gpY0Yg+VTbcrLQ==
X-Authority-Analysis: v=2.4 cv=c/ibhx9l c=1 sm=1 tr=0 ts=69dcf842 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=jj6w_h7ptVUN3La3dRgA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: RGZHRqV-_0y_NH7wnuK8x7gb6fOH0AJ0
X-Proofpoint-ORIG-GUID: RGZHRqV-_0y_NH7wnuK8x7gb6fOH0AJ0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 impostorscore=0
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

Simplify hx8394_enable() function by using hx8394_disable() instead of
open-coding it and mipi_dsi_msleep() instead of manual checks.

Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/panel/panel-himax-hx8394.c | 41 ++++++++++--------------------
 1 file changed, 14 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index d64f3521eb15..1f23c50b6661 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -618,47 +618,34 @@ static const struct hx8394_panel_desc hl055fhav028c_desc = {
 	.init_sequence = hl055fhav028c_init_sequence,
 };
 
-static int hx8394_enable(struct drm_panel *panel)
+static int hx8394_disable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
-	int ret;
-
-	ctx->desc->init_sequence(&dsi_ctx);
-
-	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
-
-	if (dsi_ctx.accum_err)
-		return dsi_ctx.accum_err;
-	/* Panel is operational 120 msec after reset */
-	msleep(120);
-
-	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
-	if (dsi_ctx.accum_err)
-		goto sleep_in;
-
-	return 0;
-
-sleep_in:
-	ret = dsi_ctx.accum_err;
-	dsi_ctx.accum_err = 0;
 
-	/* This will probably fail, but let's try orderly power off anyway. */
 	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 50);
+	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
 
-	return ret;
+	return dsi_ctx.accum_err;
 }
 
-static int hx8394_disable(struct drm_panel *panel)
+static int hx8394_enable(struct drm_panel *panel)
 {
 	struct hx8394 *ctx = panel_to_hx8394(panel);
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
 	struct mipi_dsi_multi_context dsi_ctx = { .dsi = dsi };
 
-	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
-	mipi_dsi_msleep(&dsi_ctx, 50); /* about 3 frames */
+	ctx->desc->init_sequence(&dsi_ctx);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	/* Panel is operational 120 msec after reset */
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		hx8394_disable(panel);
 
 	return dsi_ctx.accum_err;
 }

-- 
2.47.3

