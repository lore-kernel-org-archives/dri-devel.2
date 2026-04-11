Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D6CF3ED4C
	for <dri-devel@archiver.kernel.org>; Sat, 11 Apr 2026 12:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B78C510E13B;
	Sat, 11 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iGXVTkKg";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AvKaT+zo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EAAD10E13B
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:52 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63B43HBD2736978
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=5O/dxjvokdyBHMUsNmLLbX
 Mzc9mz5c+6oNW9h17WMCY=; b=iGXVTkKgXSxictZ7WEfkbaw1tn8n5e44v06nT+
 64yp/LLrdZ2Le6+DbrES0iF8QMiB2I8iNfN1Zc2Ajp3SlSqsx4raO6sO1m0zF0rd
 9BMHK8UMYpXT0XsAwayGoT7k+SlPFY2pLEIKiI9Z0e4V4WL72mizeBCgTo7UZBWd
 AjB456yobLJo9/CRhm6tr/6z+5xxHLdZBIiI7dk2LI4AraZV38Yq9HW4Hdanboso
 FLHKkzIfiDIXcrQJrx4+HVUmc933rYmcDEEx4/Q2jZFF4BN5QgW7N8RGyr6nyEHW
 KNOIwu13+xT+W2IhxNV6gkDmHZ/XyavBygBNEbAopuZIuPZg==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexcrmyt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 12:10:50 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b323c43fdso53417801cf.2
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Apr 2026 05:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775909450; x=1776514250;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5O/dxjvokdyBHMUsNmLLbXMzc9mz5c+6oNW9h17WMCY=;
 b=AvKaT+zoDxv5BiaO7q4fh3gY0tQGGAIdMMtgHJz36hRuwTEf0pGZTXYGw+kdadhrqQ
 +hfscIITn1KQgBfNGW9munBgowdevlpBqaBmZ2FnAufxbfPUA/HX5JCgmQJlJx0Ax6cP
 jeT68ElZcjzo+ofWw37pQSng8nWUhT/uCQbqNMQ5TmE+/lqReBoEDzfTgqkT7fHSotux
 quAy1n0BBCon8OjY9wo7cGDf922+3rWHcDW/vv+41tsM99B2dvPIO2JBpKw8zcVkilk2
 HCeD+qos3abGY2Zpeo/lNGFUAAM2N5lzX/dTFZl8gSPM+OqV0H6tyatUc2B6JdcudwBz
 KRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775909450; x=1776514250;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5O/dxjvokdyBHMUsNmLLbXMzc9mz5c+6oNW9h17WMCY=;
 b=LbnaaLjrHEJPqnZgpVVOYadmJH4Z/R0k6Coh5iB6ogJ918F0ZYwv9RfNq9Uz+Q1LL4
 6VeSIrWPmAdPmmgH7W7bNNHY5BXRyKBE4iywAEFJE63Bk2jq0e788dBh/JLcMQu7UAm4
 p+vlXhmtnfRmcelsqOOVnt/naKG1NLXX5QvDUi0RBnXdBYLE4dmukpnzd4/WN+/dSQLV
 5eOOeBkK0mGnatW5B7Dk4EoisMtxffTjWCOAB3Zux8YOy4hIwrRKe5nLquRt/8eZIuJ2
 i0EgKZARjkXv9Iv0pNAMR+fKqgnMFxeirDQfjrusrRLwSCwRFmcGcocb4SmnwIC1YN45
 wd1w==
X-Gm-Message-State: AOJu0Yxq42boHPUQHIQYv36iP7GMvi9gM1fY/UWqIOOrl64V1UcE06DN
 W+gy/94sP47C07jTnRWKMuU5e87+Xz0dqkeWiUwR+ErNYf+NjC4n69kXl9IbJJwRVqCvxUjZEUt
 BU96lA0ENzkEieawuzMjiGJ14ll9b95VT9laJJF1njbSU2btDo+ufjUPc/JCFfT4tHH/NK9s=
X-Gm-Gg: AeBDieu5nFLt1ThF7KeVtKeGuFclicVsPoa3Qsz3x0c8DLrC8CoVAYw1fi/wkfy9dN/
 UjgqTR0cPblTF2OJQa6LNy6yEHDklUuQTnliRZ6ocWPV1jO+YQI1QRHaChl4GN3iU9g95mPO9Dk
 mZ03MUqxelhrhPFRj8GZIGR0us6LMbWyz2H562eUJHxonOlu72pdDfWowATUmksSmM6426JVnit
 /F6yCAh1z6Mqm0NTohwBlvB2Ucp+X7fAmXsZwPCe11Ctu8b9gR9P9FDU3LPn3DGXrdiVttxPznj
 PikLNV+cvWpCFS+wUarUUa3CyVHvjPNGN7P0JhdqAmNn72Oj4+Jq01SB0H8DwH+VzpkIZ3ZtTA1
 dSlKnX9xrsLYSvxadFt4+HQfqAkHhvcVZvNHphOtNt6rTEAtJbhdQExY5r79cVq4+wwry+/1RKU
 PB1nx6SmAVOFL8LpP+LNFLWfr6yN5Ian1qVSs=
X-Received: by 2002:a05:622a:a18:b0:50d:6557:5caf with SMTP id
 d75a77b69052e-50dd5b05425mr105146681cf.28.1775909450291; 
 Sat, 11 Apr 2026 05:10:50 -0700 (PDT)
X-Received: by 2002:a05:622a:a18:b0:50d:6557:5caf with SMTP id
 d75a77b69052e-50dd5b05425mr105146011cf.28.1775909449759; 
 Sat, 11 Apr 2026 05:10:49 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e495b4e73sm11906291fa.41.2026.04.11.05.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2026 05:10:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/21] drm/panel: support Waveshare DSI TOUCH kits
Date: Sat, 11 Apr 2026 15:10:20 +0300
Message-Id: <20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACw62mkC/32NwQ6CMBBEf4Xs2ZJuAxI8+R+GQymLrRGqXagaw
 r9b8O5lkpfMzFuAKThiOGULBIqOnR8TqEMGxurxSsJ1iUFJdZSFRPHSkdjqQKJjJyY/GysIK6w
 09r0pJKTlI1Dv3vvrpfkxz+2NzLRdbQ3rePLhs2sjbr3/hohCipJqxLottcTi7Jnz56zvxg9Dn
 gKadV2/1V9Gkc8AAAA=
X-Change-ID: 20260401-waveshare-dsi-touch-e1717a1ffc40
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3793;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=CXXPzEZBwQFoyAeoLk/sqEJFPJ8wqdICzZMEUpK6xc4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp2jpE1KjblteWFTrO/ZNvpQl8RnIFiu1+M1eRo
 jMPZx/hGwiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCado6RAAKCRCLPIo+Aiko
 1aSHB/4oAN2PUYhWkqReBpp3xtgk843VREa/honY2sAf+sOMSVdzA2C+LJlF8f3Mtu7nGuVNYbj
 M4UHxfmsGskNBhhOv+m0L5WBugfEH4Lp4H9tuXGIvJu80dKvmBLHwJdX3dX9XA9V+MCrExAIz7s
 8Dh/Htrx44bJEwDlQ+hUOAR7MLKEyFVCV8C4hLba0EnzNCLZKnmsnku/oARtjBnUu43MszIAok2
 CZfSGl/mdKmlJz8Q6BJ/9H5/+rCXo+b9gGrWZ9mAQKiWDikyu42u3cudTyJ27msY33u/cuORCuW
 WHubAuyxSD0cZbxJir63RIG0crZgtYKLHL0FStzYdap8xaS9
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDExMDEwMiBTYWx0ZWRfXy1w2er3gKcHU
 eZJs1yJFoM2QWY68J0PQBzv936PCE1T+XaML66O4rTZRrJwSiyJhYOw3k392r8AG4boKvqOtnQ0
 dOf9Wdi3AQGC8hxVlVf8wRZSzbdARKG95XO3FHIFqHXQZPS5RtRFDAF2pfP2Qh44o9H/YvFcbBK
 bn60MKGzug/5RZQSThKWSWCDRDN4KK0u4hcKOERtOH8RYrjIhoccmaCxhXu4WBSSMfiV1F1ahdj
 La3LxZ9Bc0yMbnZmGhfuJIaxJNn8rEF5SDStUT8I809Q8FWaDpeVr/AZvzCdit+KqXQygkCHEVG
 D14+NIoMXaEllaXoL42Pp+nsfdTVFbwEkFU7WPXd8pPyYug6oJr3RYtkNnxuruk2rTCX66Twvlc
 anJDDMxo37HSm8B+qYOUfEDRC1rqbixXFPIK4B7pLMcnUbmegL4Ei2AtuhFtMSpuPm/uZCt4Mcw
 GvXT1dhZKopTlW55m4Q==
X-Proofpoint-GUID: ymaGAHJCZ97YWsRzo9tH6yz1HMUGAzdR
X-Authority-Analysis: v=2.4 cv=MqliLWae c=1 sm=1 tr=0 ts=69da3a4a cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=WOO-qr4TJnSisU2av9sA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: ymaGAHJCZ97YWsRzo9tH6yz1HMUGAzdR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-11_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0
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

The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
video-mode panels, bundled with the separate controlling circuit,
produing necessary voltages from the 3.3V and 5V supplies. Extend panel
drivers to support those Waveshare panels and also add GPIO driver for
the onboard control circuitry.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Fixed errors in focaltech,ota7290b and waveshare,dsi-touch-gpio schemas
- Split the JD9365 patch, making the changes more obvious (and
  describing panel classes)
- Cleaned up GPIO driver: moved NUM_GPIOS from the enum, switched to
  guard(), added regmap error handling, dropped
waveshare_gpio_i2c_read() (Bartosz)
- Link to v1: https://patch.msgid.link/20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com

---
Dmitry Baryshkov (21):
      dt-bindings: display/panel: himax,hx83102: describe Waveshare panel
      dt-bindings: display/panel: himax,hx8394: describe Waveshare panel
      dt-bindings: display/panel: jadard,jd9365da-h3: describe Waveshare panel
      dt-bindings: display/panel: ilitek,ili9881c: describe Waveshare panel
      dt-bindings: dipslay/panel: describe panels using Focaltech OTA7290B
      drm/of: add helper to count data-lanes on a remote endpoint
      drm/panel: himax-hx83102: support Waveshare 12.3" DSI panel
      drm/panel: himax-hx8394: set prepare_prev_first
      drm/panel: himax-hx8394: simplify hx8394_enable()
      drm/panel: himax-hx8394: support Waveshare DSI panels
      drm/panel: jadard-jd9365da-h3: use drm_connector_helper_get_modes_fixed
      drm/panel: jadard-jd9365da-h3: support variable DSI configuration
      drm/panel: jadard-jd9365da-h3: set prepare_prev_first
      drm/panel: jadard-jd9365da-h3: support Waveshare round DSI panels
      drm/panel: jadard-jd9365da-h3: support Waveshare WXGA DSI panels
      drm/panel: jadard-jd9365da-h3: support Waveshare 720p DSI panels
      drm/panel: ilitek-ili9881c: support Waveshare 7.0" DSI panel
      drm/panel: add devm_drm_panel_add() helper
      drm/panel: add driver for Waveshare 8.8" DSI TOUCH-A panel
      dt-bindings: gpio: describe Waveshare GPIO controller
      gpio: add GPIO controller found on Waveshare DSI TOUCH panels

 .../bindings/display/panel/focaltech,ota7290b.yaml |   70 +
 .../bindings/display/panel/himax,hx83102.yaml      |    2 +
 .../bindings/display/panel/himax,hx8394.yaml       |    2 +
 .../bindings/display/panel/ilitek,ili9881c.yaml    |    2 +
 .../bindings/display/panel/jadard,jd9365da-h3.yaml |    6 +
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    |  100 ++
 drivers/gpio/Kconfig                               |   10 +
 drivers/gpio/Makefile                              |    1 +
 drivers/gpio/gpio-waveshare-dsi.c                  |  208 +++
 drivers/gpu/drm/drm_of.c                           |   34 +
 drivers/gpu/drm/drm_panel.c                        |   23 +
 drivers/gpu/drm/panel/Kconfig                      |   13 +
 drivers/gpu/drm/panel/Makefile                     |    1 +
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c   |  208 +++
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |  144 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |  279 +++-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |  251 +++-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   | 1563 ++++++++++++++++++--
 include/drm/drm_of.h                               |   13 +
 include/drm/drm_panel.h                            |    1 +
 20 files changed, 2801 insertions(+), 130 deletions(-)
---
base-commit: f3e6330d7fe42b204af05a2dbc68b379e0ad179e
change-id: 20260401-waveshare-dsi-touch-e1717a1ffc40

Best regards,
--  
With best wishes
Dmitry

