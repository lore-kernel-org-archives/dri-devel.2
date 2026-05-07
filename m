Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4055CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:01:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08BE210E1D9;
	Thu,  7 May 2026 09:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aBHwSjxS";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KlaCfdiB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A96EE10E1D9
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:01:44 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475LejU1068275
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:01:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=QvsauNTq3rUboIdRUovFsE
 quKr6TllKsvzUgfaR9kbo=; b=aBHwSjxS6EJ2z88l7pE4wXiR0iON5CG+5SY7ze
 rOc6ER0R4wQLE/c08P7ZPW5zibUnSxtoriKanBGCmUg6qBR7erkNQM0AyCJ3AF8i
 O+XZJTtbK1UsaCQH5OCiawc4WDX46+vz8VtZGHDL54FEFCFOHbOVkYJT90wVnWbH
 r7lOf3vz6EPsxq5QgPj7M8kzSW4AatiJRyFU2OuZsU5f2AL6RZtH7nqvXGtox//w
 lZRrHRlw+h8fK9XgjYt9hW40xmyvSXp6Di34uS7WDgIOJ58wXrAOVVFoyNU/4Xlm
 GOMh8xyVO540xPNtANvqXTx/8HspWBAIH8/vVFBDONAquP5g==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mh18tcd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:01:43 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-95d5f0ac7bfso182980241.1
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778144502; x=1778749302;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QvsauNTq3rUboIdRUovFsEquKr6TllKsvzUgfaR9kbo=;
 b=KlaCfdiBXa+fMzzZ7mkmIhWdf2dWOMHfrxg92ofqNXZB3JFpgpdyYOu9nmeVJsX/Sd
 ZS0Ki6hVbBF64qe6kPhrOIYhZ6tDpH6VK4e+uR55Z/DasCjaxhIXGV/4guxGNCJ3hGrr
 d0CbUKuIufKF9PGw5W1T1zqDdS12v507OZrpmiuDrpwLC4OgWxkuPQ84lKIPrbKHR90M
 4aC9S/KELUrNlM45jlMLFPk0vJyPcPzKKeSyiXtjdrvBnj5ZpVaWQIRwsc2VzCEJ8g/X
 ZvS7q7ud4vfX5hAaA/rd6ZNNLHIJFJ+xPQPb48P+nhtpmTI4y1b8C1rZespXW35fJwtx
 mqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144502; x=1778749302;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QvsauNTq3rUboIdRUovFsEquKr6TllKsvzUgfaR9kbo=;
 b=L1cZUC95zALnUYhxfDajoLrwwLqS/HKj+rCE8I9zo4Pgf758IkfLRvnzpOb0OMRzHQ
 Kg8MuhDni5zr+rAv1mvUi7mgY2wIVyJObnDqRIsXPjIj4MDyAz/1WN897GCfuNyyZC91
 HzZOZlMYdPE5v1GED7LTJxcFGVo4z7lgAFldOjHyJYUp2T2REjSOVJ/h+/LerGpxBa+R
 K6aCAu4wHkD8rLq9JF9A0EpF/QY/CRzmG9AYVskwhQqESBBH5aSBOMvGcynSLFpCF9yb
 JO6oxuuJaQh0DET1i3cJP1M0bkYwA2Ee3M4l/4FokwRJ7+7RBmX8yWaTKAcgrniPfOzu
 nyAA==
X-Gm-Message-State: AOJu0YwV77qVW/WNhjU3bFhHpM77EE40ZV3dvwDrv0Zv/NgJ9mRkmOug
 qfCppTNfZ5VZl8kVZ8nopvZapIzJLgFvp/1ewnAFniKCPGayqsdWAizsLqcaMHPpZU5oTprNeWh
 pAo/lGtfvgXi0V61dVN4R4uOhFptgYSbJRvXlvb01sfpj8/oIHZ10GZY0CUHOCyt7wvMGvxRL94
 4mGhg=
X-Gm-Gg: AeBDieuRlNtOEJ8d5Gk/egQoXLR/UPBrT6yEQHLR+HloeEpwC7IqCUYqiwsnfggKh8z
 dx70L0tpC7ZXlozbD3cNQes2ZIbAIFK5bb8FDafF2aNQUXTBaoaMwXY816p/OGqRMEavEfj5OJ2
 J3WtHSkA6iijlEoEOK5n5WyhoTJG0Jwr5lToaMM8iOhPw8GAAD3kR9/NmzFCklrnxQESphMKm8S
 9qJ/hjl40+MktzB0dxut3rMZZY4byv90HeCe2XYsCabnN9mEZArg0AcF/xbeEGkeCd4gCP9c5Cv
 0bP01TJytLH8QokyyMZp/EbMrquzJyMAKiORnwVOyzj2vj95qMb6L5pMeutdgCqKsG82PBh4sFQ
 7AWd0CeRrmkzbf9iEsAvMLgssyTBOIbu5ihsjdLXdfRr4KkPmZXy9blJUVO0QcyZzs5d3xfa4QP
 7a7WhZXIDx7e4A+lx/2t5UD9rUuJhknKZmVVyG3HLDe7KMBA==
X-Received: by 2002:a05:6102:84da:20b0:631:23fa:38d7 with SMTP id
 ada2fe7eead31-63123fa65c9mr117601137.14.1778144502103; 
 Thu, 07 May 2026 02:01:42 -0700 (PDT)
X-Received: by 2002:a05:6102:84da:20b0:631:23fa:38d7 with SMTP id
 ada2fe7eead31-63123fa65c9mr117553137.14.1778144501588; 
 Thu, 07 May 2026 02:01:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a870f96cb1sm3480516e87.22.2026.05.07.02.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:01:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/2] drm/panel: support Waveshare DSI TOUCH kits
Date: Thu, 07 May 2026 12:01:31 +0300
Message-Id: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtU/GkC/33NQU7DMBAF0KtUXuPKM7Yb0hX3QCxsZ0KMaA2ex
 ICq3B2nbLJI2Iz0pT/v3wRTjsTifLiJTCVyTNca7MNBhMFdX0nGrmaBCk/KKJBfrhAPLpPsOMo
 xTWGQBA00Dvo+GCXq50emPn7f1eeXv8yTf6MwLtTSGCKPKf/cZwssvf8XCkglLbUArbdOgXlKz
 MfPyb2HdLkc6xHLUMEVBTsUVqqxofPkggV72qH0mtLblK6UduStVohB4w5l1tTjNmUq5dG0vaZ
 Goe82qHmefwH3TFB9sAEAAA==
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
 Conor Dooley <conor.dooley@microchip.com>,
 Riccardo Mereu <r.mereu@arduino.cc>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2331;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=hC8gKxPAIzgcAiCj4HFnCCX8CcpOJ7V8eE3rHascLoE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/FTujaLZhqlfcwayX7sT39yXXp3nnbfAwrNYB
 MNe/6xhaHqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafxU7gAKCRCLPIo+Aiko
 1ThICACuFYxF7qCax7SDv5ziEm5eOGVJeGWP+9tZXlWlKK7NvYNaNHOnmCivZN+0/u/nhYJCsva
 w6G7P48wuUeeVjexqKW6DlO4nIhNh/1GKpJl657YW0DhnK5TmEUpaPuWvDDI0z+FEjHZWxk72Qh
 nEvbLK0MiFWDIOuxveejtaPqSSVmCk3tpNEYA5cM9LDMZPOEZcLaXVHdprOSp681D/jLGxjNHTx
 R5m4cpZthxG0gP0ng86u+YoT9BidjySLMVQ77cbBO3nP9wyuHxuSt/yVMS1KyhT4qaoVF4tBK/w
 nqOuoAMwn+G3R6hNsbOc+8Wjlt8byBDC/uH//rWXBWKMvb9d
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 6PbhGBxagTq_ehCLM9qMZHH8I4U40v8Y
X-Proofpoint-ORIG-GUID: 6PbhGBxagTq_ehCLM9qMZHH8I4U40v8Y
X-Authority-Analysis: v=2.4 cv=P9gKQCAu c=1 sm=1 tr=0 ts=69fc54f7 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=woyZ9DH24JpTQh7i3M0A:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4OSBTYWx0ZWRfX7W3NKGlI3pvL
 ln64p3uHjGF3I7HXuQxiO7Jw4mnegcivk3zyrw1qH4AuxoLwAwFJRvaOIswxmuqJR10PhVdjPfz
 5dw2c+4wvLdYw4/ZlcCmaxX55xH0ldsBNEw8jOAu05BQ8AUCLsDZwQwB5qihvTWvREYiBsq2Kjf
 OwvWwnN6n82GbNyLzOQVX/WFFC3MGnEayhIw7V6VRhUTIXkbE+VO5rTEdgc5tQ1sHzZSEby6SoE
 nvnzGBeMhTV5opDPZsSko4Ib4obIjBjO5VOCe+hGdqgQgwx+pFbJz5jrQlRmTFoi6ZDZgrdR5TZ
 3jIXwcC1Xt6e1nwDjI5NAvCL4x6+C3ESZp1AlfV9WN75MMUiXYVqx+ITMDXjmmjAbkLcztLIa8u
 UePqrSugKmTugz1sx2jW/vW+2Aj59pe/Ho8O4W3tadmbG+NgRhsb00F6DSnCrLlxsT3LWf0O2ww
 yJXMjy0w+yOx41HOUzA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070089
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
Changes in v5:
- Dropped applied patches, leaving just GPIO part.
- Dropped panel example from the GPIO controller node, it's has no added
  value.
- Link to v4: https://patch.msgid.link/20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com

Changes in v4:
- Dropped patches applied to drm-misc-next
- Link to v3: https://patch.msgid.link/20260413-waveshare-dsi-touch-v3-0-3aeb53022c32@oss.qualcomm.com

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
Dmitry Baryshkov (2):
      dt-bindings: gpio: describe Waveshare GPIO controller
      gpio: add GPIO controller found on Waveshare DSI TOUCH panels

 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    |  73 ++++++++
 drivers/gpio/Kconfig                               |  10 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-waveshare-dsi.c                  | 208 +++++++++++++++++++++
 4 files changed, 292 insertions(+)
---
base-commit: 735d2f48cadaa9a87e7c7601667878de70c771c5
change-id: 20260401-waveshare-dsi-touch-e1717a1ffc40

Best regards,
--  
With best wishes
Dmitry

