Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA57BD3514C
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E15D10EE40;
	Wed,  1 Apr 2026 07:27:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z/dfkyvr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Uu7zwF9J";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81CC10EE40
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:27:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317CcbH3103857
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:27:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wxCLjYTUywbIG6hdVNRWMq6YPfiD70vfjtzHlxjSzdU=; b=Z/dfkyvr8gTlqdEK
 LqaeBk1oZg34b7VUi2n0VRf97nZ+SMyUwJC8MBNnaIeUC7EsHDKnyB8x4xLi7xVU
 cRafd+mj0jA/OmRyMQTBOL6z6Xl+9awEfnXt01OT7CtQr1XECAtpdQ38zoPrmJbQ
 OYG7QPbfTJIx21vpN0J4twIkFZBNnm8aHMoQj/fUEXwBradjmIAyoU0BVwvGmRDd
 l62YOLB6HZYxAmdoVUKWlGM/bKpsIckE+jzKZVFE5AtpNMOrvi/zHbO/Ef+hciAH
 /ZlNiAWEoPIIpX3QJzinC6t7n1wq7vTAxFsuKBirfgsT3m+7Ew45mfkGJTuzr8Y2
 /hrQ/A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8js233g0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:27:01 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50917996cfaso82323141cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028420; x=1775633220;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wxCLjYTUywbIG6hdVNRWMq6YPfiD70vfjtzHlxjSzdU=;
 b=Uu7zwF9Jw4bCvQZKru29JsN5MrPZ03ormIBgeBJEBIn5JeTFGxGz9lPUe/bsjWF6Vx
 lPRHBWGHn/ze98hhkKsoe/RTOQWuzHy+4eaNZstzagzVclvuswo7B3ZdmNumpZcn1tlT
 JY01poRu3rfUexaF2UQogCtrE4+Q3f+8FubPnYGqAZMNrmkfz9IieVcTyio4QI49NTh9
 BATJHvoYdFiBAYXE/8K3lZM+HIt3Svbn/wOnCALjaxyJchzJwLcFd5WtC8Y53Gbfsv9e
 8SQV1PzyrewQNoI4oDkvTqMQmuZtJseAZPBgT2thD+xEg65nYtTDpbtref+kG607fSD3
 4pmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028420; x=1775633220;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wxCLjYTUywbIG6hdVNRWMq6YPfiD70vfjtzHlxjSzdU=;
 b=gfPhahZiHsYABEEbw0pB+dcRHh7AvDtk9yCU3ffqXsE0JNpDZdlQjENOt6ExAOTPkE
 7K0/0yaoMsyV1GTIQuBj4vd16gTUokMGPQfovOoBK2+KpKkjRMUXg3S5zTJ8IjBodx2Y
 f92GXFk8lLuDn/rV4AQYzhpCRWqa08fcuxedo+PtlnVsnnTsGwdiuQs47otOK1QCy6C0
 p09tyAWM+7GlI9QJDWUmmF0AoVwgbxkAnT0JMYaAvveZLxTyAi1HaepdPbPPULE/+kPN
 zP9TPK8z4XX6daZzgW5CGmTE1rKmRkxURY2dZakZI8+MAU8Vv1zNYHub6CoqFfCWN+og
 D3Jw==
X-Gm-Message-State: AOJu0Yz1aiohKXKPI49MXkfUpgDx9GmgMOvn4v8Kl3baGaiNFOXFbyep
 WXoH1hBSWR9vVQdUZD0fBNRfxCfxBMIqKEZZEIurLXephos1vSI666poKpyW0sCkCa68KIh/BDE
 96T1cHE5KAIrGugwET3vgFTqNLrfuUOtl9FjMbHFOxPNZzv0sUoRUgkE8BvkAhhwrouGeKocGq8
 DhJ+g=
X-Gm-Gg: ATEYQzy5HUr20qyGgsHDxdpiHTib9jN5Fn7d1DXmCE5UvzaWMK7Zlhbp2uN507ePKiN
 acF3DfSzpEFzRqHeEATDVNiMQ5dFNkZzjpAXETr+Drqeclj62pxQgP+dBvCG4kFsQXijVn7kIGT
 DrWJopdtp3ojKoyv9VnHUqTCDhhY1TT5wZzwYyKoP0fJKZPtqxKDzxpLoDjINUyv3BdaqpLA0DB
 0NxYHrc6RZMUjcMby0oFv47DmMPkJY8ticGLD9RAzm0D6+0gS9LIbyKiKXiqdM+uCPTBD7oJhL9
 BxwpVwAsH2Aoaf/OCdGeGXcELvzvH1dHqAvHLxRIEeW7gVIxAXFEzFkghXukb6De/FFeGu1JPoq
 6qAP0TUP1bjZUZFb2W122O2UZe2lpDK95YCG4bDXt4mdmPrC3xA7spiQoI+4tNBfQqJCw/eqg9Y
 d5gaBck9vzta22cK9HsLyO4Ko5sc1gFu2Y+jw=
X-Received: by 2002:a05:622a:1f0d:b0:50b:48a6:6b96 with SMTP id
 d75a77b69052e-50d3bca54a5mr36269711cf.35.1775028419728; 
 Wed, 01 Apr 2026 00:26:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1f0d:b0:50b:48a6:6b96 with SMTP id
 d75a77b69052e-50d3bca54a5mr36269471cf.35.1775028419278; 
 Wed, 01 Apr 2026 00:26:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 01 Apr 2026 10:26:28 +0300
Subject: [PATCH 09/19] drm/panel: himax-hx8394: simplify hx8394_enable()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-waveshare-dsi-touch-v1-9-5e9119b5a014@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2415;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pOgZnrXub3GS8AZAw2xe2Lzvx6vQOVPendpRdgsMBpU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMisQHL6qbOb5oDSQPV+YXvWKyipTd8B0Ocuk
 17HKBDfjRuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIrAAKCRCLPIo+Aiko
 1VflCACGiFUAmeGHUxPcLUIE4mj8HiU/9RP/nPny3hspTKil+4vbxdnaL70iV5S02Kx4btVz9xj
 kSc2CXCuht6nRCvGonbIfT+msxpO3wWFuM7ddnlQKnBPDg4LEHIU7kCtiUIZwbQcHkFrz0x9A40
 cygjsanxfZAG/quPVwSweLsytvo2OTDuYIDzs//sFoLpLRg7Y8CI3I6Vyr2bAIPdprvp89Dm81A
 3h5oW/QNEPEFX4VWUUb7grbKtPzylGFf1AnLCH1WxJ64478Qq1CEAgNFpbP/KsZVvX9dLlORYYA
 RHBfXXP6q4cAygUm/lX2Qp8AqF+zoTslKi+fpcePPvQRb9U9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: U6DC-1o6rsbzrAYDXXsqMvB95ipH-mkm
X-Authority-Analysis: v=2.4 cv=XfqEDY55 c=1 sm=1 tr=0 ts=69ccc8c5 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=IHUbhB35yQ0xTmbSNgsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfX2XL0K7uaER2m
 8/GQKeDM0rayg14mVvHDz32+vl+apVaSN0he/yigqKDosQkJKdOPx+jK5ZGIx2vQa5mp5n3LjPU
 yiA0jjs8T/Yk/Wayz0cbGmxCQ2Hoy+SA+mgi9R+aW7TJeIfQNJPnQFMcAN9mn6KE4cZXGD8kpSv
 fD9EMNWzyLXCcv1uZ+3jW15QgVto+puedl0a/j9JJQojD3oQg6yNCiZmL20/zbN3uh8xAWHjFJ2
 lwPYcAxTpbcelx+URB8sYp1Z+NYFVCoFc14mT0IjC97uMM+m1Nqi4W7yXhMENlHb3Ept0AiypBP
 oR6cfow2UD5Pl0AV9s0KavpeNjee3iWzB/RS/P4fvn87bRyDCr/fuoZCg4zipEWprVTGpUorz5x
 wqhfuKOCn3iiXtuQ4uiLjsuxAf0EZMfzjGEiVdElSLmt144Sa+MSKRqqcYZb8OWTU/r+wKbWvhg
 /EBCVJoFCkuE6eZkdPg==
X-Proofpoint-GUID: U6DC-1o6rsbzrAYDXXsqMvB95ipH-mkm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010064
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

