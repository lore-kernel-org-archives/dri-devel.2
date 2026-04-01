Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAD26D3514B
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 07:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56FB710EC9F;
	Wed,  1 Apr 2026 07:26:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AFTt2puW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQKjN3ul";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716EA10EC9F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 07:26:42 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6317NADP3081342
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Apr 2026 07:26:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Zx/6+DXla+EZMiXJy/SeCR
 kIOHRL6ZlK26xm52LAe2Q=; b=AFTt2puWDVAQAv+JjOfPfO/T+H00SM+SofdIAm
 s+IWJTp4TNSKDdAOTYfkCYJQPhmKq4gTOxPCjieCIthdxyp4zcQ0wcT5xbCoOEC+
 zy2uRY3CeUXbc3zNc+HZafZEd/65yc0CB+ejVa+Tw3lO1zGUFxMg4xs2lmdiJk4i
 q0XU+n2dSLUKZ0YBAefHogPz/T5uql4dUKQSwn1KSu+xUVLAENAsvxKl3AjOLggh
 EQi7fztYz7MO/BTnj9/4SdKX6aB47bPoRV+c62LoUhegN/soY7gSteHAJf9eVLA2
 dYCm73da68jgoak9Pv7Dd7isFcfGMIEA5J/3k7azd8lHFRpA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d8kdkttp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 07:26:41 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50937cf66b5so336838591cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Apr 2026 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775028400; x=1775633200;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zx/6+DXla+EZMiXJy/SeCRkIOHRL6ZlK26xm52LAe2Q=;
 b=GQKjN3ulFp2SBZ8pCBnOjSHaRnXO9O59E5DYxDwrwgnx3qbiT1iEtatl92aJymOuZx
 a+mVi1t+S+5bISZf11VmeeLA5QeKrePY1DvmshHF/UqgPLfLUFi/9WpSPF/d46fhi9tm
 8hPVityQIwsL62hfMk5N83ZkKwARYljXxaI5y8uS4sp/GV05P4vv1jC4AnMwnJj3FND7
 d3WeGHBP5G0RsjEnZCo5oOMNqlXsE6byWvX+/bnnZ50290xXBBRF85ztqK2IFGvVNox/
 g6u3wOFyc1cnxJt9jfWUJbxdF4TrOtPO45qyO+8d0rSIBcU0TQeOHrgaXWAaMAZzq8jt
 5pTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775028400; x=1775633200;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zx/6+DXla+EZMiXJy/SeCRkIOHRL6ZlK26xm52LAe2Q=;
 b=ipU+Fsq3vA1F/Z1dXUvSF8tEiFmMfh9CmU3qlwIatpBGZJ4kHYi5bsoD/17sl9Vxhn
 4EZHALcjQv4Y/VZhuOvYkmjgF+F4efBFy8VfmHckPMvLeHKxb8OxttBQRwp5ZzU9iAY4
 CBd8xAQIRsZqtPzV7ggVZvAGLdznCvmxUyiQu6z/aCsGZy4prK2J8zy1bJzO2yU68ns1
 wGZcGE8Eybg6HWL8MyO3R4/YYiiYj2eRvReCfvHBruwCkWsPMoIe+gwX1pAt70hEuDFJ
 hfYvozAJzuSEzVePEZpEm7L26k86uSNMRhOiwQz1CtqbLQkYHj/V0hQWdbIGBsJUkYFI
 unYg==
X-Gm-Message-State: AOJu0YzeKvKGrbbQiXkAeMfNm5Dxp9Go7LcYxdB4+1QCNCGVjahR5Aek
 GnfJR9hrUf9HlX730REIHVuHvC2CAA24FGCL9snx0BY43Lic71+PMjYlihPNY31XkjLYNmRoazS
 M+VlPZqUWZKxn+77E8DggCE3vRk9yP41jSv5qmtKG7H3o9DZUwsDBD/0B8iWH5wm1pHUiqGA=
X-Gm-Gg: ATEYQzzkp4LOzvKMcyWaxig++bJWdcSaJwaz1avbb7RU9X4If+XVFKLcKQXUljnRAi6
 1lTIqEto3FSgtdZYeMjCQk1uLRO4wtumGWqIwv2b0wWfN+OmB2gI2KnzgBkPad4SNoOYg+zHOoX
 Yy5w7OHdUfGUHXwDXUURe9remJntdQ7EwIMrqVrTWtg79RfEuHtfm97B90madS7ZH4UpgkxeZbO
 1LQP3pDCDBTdf2qwy7NFd5Lt4EXKHi+YJRgEWuPp8viWpZbLiBAq0qQ4frmxepT3x5Y7x4TqrkT
 w0mFGlb/DVvxV9bGHlrsg8bx8qGDdTKhpi27DIw2tZeC4ITmvNKuCvfHgpUsaVWhnuHRLnPhLx3
 Dhvb9P9rwEY09V+THhSGz0VT1S53BQpnNVfyW2b1esyUX9yAmzKMTlt7tsggYqBQZaE3IbQlv9l
 rJnqLOTdfNFHNEvowp1IUf4iJeqnLVhqhWHtU=
X-Received: by 2002:a05:622a:18a4:b0:50b:3ff3:f4a7 with SMTP id
 d75a77b69052e-50d3bc8cd7bmr35884581cf.35.1775028400352; 
 Wed, 01 Apr 2026 00:26:40 -0700 (PDT)
X-Received: by 2002:a05:622a:18a4:b0:50b:3ff3:f4a7 with SMTP id
 d75a77b69052e-50d3bc8cd7bmr35884241cf.35.1775028399937; 
 Wed, 01 Apr 2026 00:26:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38cb9f31972sm8638421fa.12.2026.04.01.00.26.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 00:26:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 00/19] drm/panel: support Waveshare DSI TOUCH kits
Date: Wed, 01 Apr 2026 10:26:19 +0300
Message-Id: <20260401-waveshare-dsi-touch-v1-0-5e9119b5a014@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJvIzGkC/yXMywqDMBBG4VeRWXcgI6Lgq0gXafzTTBdaMl4K4
 rs3rctvcc5Bhqww6quDMjY1nacCuVUUkp+eYB2LqXZ16xonvPsNlnwGj6a8zGtIDOmk8xJjaBy
 V8p0R9fO/DvfLtj5eCMtvRef5BaR0hFN3AAAA
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
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3192;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=uu9o8NADvdeOLd4A6s7eBAhwO4ogsE0lTg/OwWLwDas=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpzMiq4WFJ8Dxjp+4X36YIJ0NK5WmevadjdTtez
 mPpKMNySpmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaczIqgAKCRCLPIo+Aiko
 1XN9B/sFhT31k096LM2EitmHCAK6iB+rQZ9+q+KIbQlE7eMcVgUawYSfZXcEWHZat9vqjZXG85X
 Im1vKtAv/D+u8I/Piox9p1Y1hpQj17t9E9vxt2DA+EsaFEu0/vgO5iZTAP3PT8GvULu49//KhtN
 U6ygVHhWqZ0jEqQl35w6xelxdiVVpFWrfqCUN7SpLCf4vLQe5tEV9aQccPjBAeiUEwhnx3MUlv6
 lMY70G2cq0BqoNwlO2ZDr1Bt29wqCYXy7V4stL+X6k7F2ha5WdLvVa+Hc7yKD4kd75fTr0UPVLg
 0R0feqyLQypesJK0gdmRUym9YzNhFopyPvP5oY7tJvOTj/G+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDA2NCBTYWx0ZWRfXwkaGfrUxhMlE
 cnZsc4DtajP852j/OKgS2nHw6n92aNOtWsTHbw6CKNhGBwe8ssrjl4l/RrZWdC/EoZiQml9HXGB
 pmuEmtqElmbNiggwWalrrO9e6myoUqj5ESGCXPF86zLzgumhn+mvIxfN94g2LvTA3i6mRufeRGd
 sby5YqK1yx6lbIJpoA383F0o3C0+u+zZWUG2KKkGQ48R8lBeW2jLtfq4cxLThboK4pSS2OUoMJx
 1cRR7ZM678BGVF84/Tl/wIxmugnXpwy2+wBgTMwxRhVxCgG+T9XqT6I+FYfwtN3k1Oirae+9ZXc
 QFdIHqNpcKHYcaExZ+oNj0ikqA6xCnscA8iMrUAsO3VawM6XuSoS+PfQFi91RiLQ1iUty4JLPgD
 1C7xZW7eTFe1U90eKrCbrQOCXC1MVHxYGNsVCqFI68nRY3qasZmbOR0pm6gSyhU5FgX64IshkQl
 jMA7ZRwOKd+T1sz8LIA==
X-Proofpoint-GUID: j71-kW5VD2MEnQUEmOiDNXwiBSQoHHds
X-Authority-Analysis: v=2.4 cv=YsQChoYX c=1 sm=1 tr=0 ts=69ccc8b1 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=oOvrkLZsNLQ3oAnAngEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: j71-kW5VD2MEnQUEmOiDNXwiBSQoHHds
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_02,2026-04-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
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

The Waveshare DSI TOUCH family of DSI panel kits feature different DSI
video-mode panels, bundled with the separate controlling circuit,
produing necessary voltages from the 3.3V and 5V supplies. Extend panel
drivers to support those Waveshare panels and also add GPIO driver for
the onboard control circuitry.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (19):
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
      drm/panel: jadard-jd9365da-h3: support Waveshare DSI panels
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
 drivers/gpio/gpio-waveshare-dsi.c                  |  220 +++
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
 20 files changed, 2813 insertions(+), 130 deletions(-)
---
base-commit: 3b058d1aeeeff27a7289529c4944291613b364e9
change-id: 20260401-waveshare-dsi-touch-e1717a1ffc40

Best regards,
--  
With best wishes
Dmitry

