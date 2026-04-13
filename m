Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20399F34C54
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:05:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74B3F10E464;
	Mon, 13 Apr 2026 14:05:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OvOJjp52";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URWSiwX2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18E1510E464
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DE3wsc1367778
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Jw/M6fkhmg0a+f6VUfUMit
 ttuOygKbZKhL1zBRtA9yI=; b=OvOJjp52uEvm5Y5DDLq/CTpd4HC6BFWItJGbu6
 otX9UV6voIlwUO/2sJW7znm2ZwGZ7MTUaq6BVsZen6hZKrSp4Jl38I45LQRlebUf
 IJyMe77todaXzBqoGqP8Etdfe+CRA5khumz2lsIVKxRsX+odFMQu4+CLSnohFAC0
 vh242/Har2Ra+uOuF+C8mb1b1XGYTpfZQKeyvDk62SBTTV/9yTT4dR9VyKHqMaAf
 2HQANFRtrV3VmOV/WSGnQAkUjJQlYfUTZBdcQq8V+L7NoX2yDBrjOSmWnkOvki6k
 Sj+TflhI0mnQpB/i2kPMnicSVD2MIZiGj0uasV4FFmEaTULA==
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfevtnqrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:05:32 +0000 (GMT)
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-45a8cdc7e01so5307426b6e.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089132; x=1776693932;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Jw/M6fkhmg0a+f6VUfUMitttuOygKbZKhL1zBRtA9yI=;
 b=URWSiwX2d59/2WutEpHnhHCJWjPXOr8wkMqO6kWdcaXF2JqOuPnYHOovz/7m5NG58q
 /ocfd4rcwMlz9aGMGq3PqJeZX8OtbaKPH8aRSGGLJqREQY/Z2OWo0Vqrk7DZKJL8wsd9
 n+PasGFkKGXXD6ZcSTwNttNCddfUAHFc46qOCek6JvWAL4HHQaVTAkcrK3kNVwPJAfBJ
 /IN7KzK9Es8ecrKGxCsr5YGU6MpYeEVpOxk/S0J8sGmjVIJD6jvq1SA6gL6tq8DLWPGH
 /IvmPRz+2mMLvmDGYlg7ZKJRPuiFkUqgkxch2hdeyDjnZktY/xq2LvNiyAlcaGeED+GF
 tp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089132; x=1776693932;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jw/M6fkhmg0a+f6VUfUMitttuOygKbZKhL1zBRtA9yI=;
 b=BUxvDme+6K+NlMcUxjvgrbEn23P5p7e9E+47rmrQeqjMMx8oPJ5NDSzsTKcCu+hpQL
 aevFedEu3liAQeM2bZm3UQW8bIK1v03C6ztp0uS9v4hLLk4SeRWdBArfgK+ibzNs44OF
 ePdTfJ3QIsMUun4D6OBVVqHkBYjWbIN7AWUNEg2Ja0neHGeTY0qiTCEVWiXbcgRYznRo
 DL8v9Yc7ZdrLcaysiZvsayk/jHpos144bFwD0OKxk1WrZK0WstjZWEwzziTVPrqPEAtx
 xMu/6EcppOpienS3Zn2yZYjDqSYeZcns82i9MJjyFcfreYdgOTiKlMJBZJspUJTcmOJE
 BABg==
X-Gm-Message-State: AOJu0Yz5UXvDBiX2grJsiG63MLASPSu5dwohKiibOmTI5W0mBhJPL0XF
 xK8qXdxqSYa006OxRcjCdkvJ3T4Qdm/sNGxPnPBvxE5pnwhfQDjIOLONhGfMZyE48gXhrNJ+YLx
 bKv64Hxn7Ak+Yj3eWcGcfU82w4gVoCA8GgYQrx3Q27wU4YJe8vn/fz1q1YH0WE6zdBlaZNEk=
X-Gm-Gg: AeBDiet/cJR7DAdeHnFFLlXtyGKSL02d6/9DUnZSm8myyZQ/JQBYQLJbMiHsqDiSzcg
 LaNqcGjILhXkC0Ev/rGXUY2iQcJAY32UuZH6DlBTSfTAepJhoJx+5VDdLdtgoNMTScUhJ+rBvEK
 LA28JW7F87kdq8Wyp8cXLAOV40QwIEOWLD/u9/HoSg4j1fooYGXywf740oExUIcNZWAk9mWJzzV
 yIHFqnuNXhU2lECDPukIAWGTg2PVyteX/Xr/eY6rqIiuz7K++/mFxwB6vnGfm1diAESoQMuLK05
 0ygCazPIswUxRjVTVcjWQO7fX9r6vfM7c46uo8FsL1SOHY/+1SZPxSqrfJ1EJookQQf6EoQ/oe3
 hZ17pDOTSHz8Xd1mUugdenxHclH343mJzIk7aOGQjhkyyppDF/lGxtu9w12mbFvu+0LbVrMkIuO
 Y/cDNCye2eOZva5EkyIDewD+X+aqdUrjffdWA=
X-Received: by 2002:a05:6808:d4e:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4789c847f10mr6644075b6e.4.1776089132247; 
 Mon, 13 Apr 2026 07:05:32 -0700 (PDT)
X-Received: by 2002:a05:6808:d4e:b0:467:13b5:8ae6 with SMTP id
 5614622812f47-4789c847f10mr6644014b6e.4.1776089131622; 
 Mon, 13 Apr 2026 07:05:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.05.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:05:30 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v3 00/21] drm/panel: support Waveshare DSI TOUCH kits
Date: Mon, 13 Apr 2026 17:05:23 +0300
Message-Id: <20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACP43GkC/32NQQ6CMBBFr0K6tqRTKQRX3sO4KGWQGqHagaoh3
 N2CGxfqZpKX/HlvYoTeIrFdMjGPwZJ1fYTtJmGm1f0Jua0jMylkLjIB/K4DUqs98posH9xoWo5
 QQKGhaUwmWPy8emzsY7Uejm+msTqjGRbVsmgtDc4/12yAZfe/EIALrrAEKCulBWR7R5TeRn0xr
 uvSeNgSCvJDBT9UMqoKZeoKtVGg8i+qeZ5fzy5TjhoBAAA=
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
 Bartosz Golaszewski <brgl@kernel.org>, Jie Gan <jie.gan@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4231;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wEdTAfZhA3dRyKgeejvoD2oVmXK92LCOSWr9CbXRIC0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgmJKF3OmQH1Pf6JKciyG+7b56afxoPJdlI2
 4/U/TnbN9yJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4JgAKCRCLPIo+Aiko
 1T64CACv/CiSlNnPJd1kNBob5X55JIYxKmStTn8ebkJWcVcKFm/q4MWr+1aVntdfd3BHbhOpxV7
 1MZpSe4DPvW+NZQsKdw11AUkv9D44LRnEeyGMav27neOQfRyQxRJtVwcWzbTlJAtsvxXV2hM0AL
 JRVrxxp/193oCoVZ0uvSqCdc/MZ5yJ5kylKzadx1rekxpEDfLwqWCh9k2/0uVsfSjK8+6m9uKq0
 kok2mECUudNoh6JhXkfWe+zeNvZVbJXOyUypI/yMvHhInUGgNalzT1CA6YwRn1tSFUhM5cwFlbM
 P3yLBgip9HtumdM/8QOg9UjaiLhkufol44Z70Zo++TKCaqiv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=RYWgzVtv c=1 sm=1 tr=0 ts=69dcf82d cx=c_pps
 a=4ztaESFFfuz8Af0l9swBwA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=DTMZbMRqsfAL1qRoJ20A:9 a=QEXdDO2ut3YA:10
 a=TPnrazJqx2CeVZ-ItzZ-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: YNOPQlEoK_2TlhFkKU3VraJJQ5q21p87
X-Proofpoint-ORIG-GUID: YNOPQlEoK_2TlhFkKU3VraJJQ5q21p87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfXz3cvNxmURdxO
 ui/DvjbvziOMCIRUEJwmIZ2NCkWdKCAPA5NsPj5Xc8xK57Hr4vEvHP02ugP1ddgYDbw8n0Mu4sT
 lqnn8dqwUGYX/yBbt/Ni3hAztSJJ3wmjYuCcLGCycgrWyRyRcqI3fRJpdo5EDNwDtprwR0QRdyY
 oBFw+UEMKMjJyY1ET3kmBNck1xDbd0ArvahGTO9VPoiItWdY+G714LZ/jDA3Wh6aJsyuJ2G8uiB
 TXc2yLmKWuGPiFThGho2ShLJtsgE4wHg3zqgtrcEhxDd4n1S9F2GP5Egd2VJ/ym3xFMNJgd6TOd
 lYPYsZi42cgWHrTGLNuVxTWtsC7DtSpmi9cXunz+J00P2/EPDjaPz4bwbl33Yh+yD27uc/sIZqI
 dOzXzcIYxCxqWdzq177+ST9XhXQMGVv2brqlVHD1bPJ87kZ2uQdxO6hilkrm/eKspC/Wdd19r4H
 QvidFXbV8I91CMutikg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604130138
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
Changes in v3:
- Fix another typo in the focaltech,ota7290b schema, sorted out voltage
  supplies in the schema and in the driver
- Dropped Ricardo's T-B from bindings patch (Krzysztof)
- In the Waveshare GPIO driver bumped max register to REG_VERSION (Jie
  Gan)
- Add a lanes vs config check in the JD9365 driver (Jie Gan)
- Link to v2: https://patch.msgid.link/20260411-waveshare-dsi-touch-v2-0-75cdbeac5156@oss.qualcomm.com

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
 drivers/gpu/drm/panel/panel-focaltech-ota7290b.c   |  226 +++
 drivers/gpu/drm/panel/panel-himax-hx83102.c        |  144 +-
 drivers/gpu/drm/panel/panel-himax-hx8394.c         |  279 +++-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c      |  251 +++-
 drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c   | 1577 ++++++++++++++++++--
 include/drm/drm_of.h                               |   13 +
 include/drm/drm_panel.h                            |    1 +
 20 files changed, 2833 insertions(+), 130 deletions(-)
---
base-commit: efcd474ed273ae7da614b30e798651c6d57d3109
change-id: 20260401-waveshare-dsi-touch-e1717a1ffc40

Best regards,
--  
With best wishes
Dmitry

