Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028C4CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 09:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 218BF10E596;
	Thu,  7 May 2026 09:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nbONzyc7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z/OnatPJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 364F010E596
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 09:01:47 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6477pfCb1424581
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:01:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cRa6k2yGNWTv2u39mO+7rvnN9ZODp7GRurjicrpgf9w=; b=nbONzyc7Dl1xsX65
 raPyO7Bz2IFfjkNwR28WjPYmvQgkmo+qIxOfg/K8NEIr7YYkc6vD3Sc45qpVo9Qs
 hUylzDXmpM7Wyn7964ddUzOzQNpd2Cx+DnJkL/Udxda0rDEZBqmSpd7Ar8SeY5sa
 uvIdtiOC5y3aGkQj4WodVIVdGzvOGNxKIfGLrregX0nnmnaaGEQKlYxTOtqCg4DW
 dO2SseyCfJ+rMgyDvhON/iFeQB9WvS8oLBcg2ezuAO+rGIdsOgqN7VV82D84sPrV
 5iBeaXUSRFE1qOeHpe/mwSX7eomkP93YZqZaYTVNuihchgRQEr6jv+uSX3QMOWYl
 TErgiw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0pqfr98k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:01:46 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-6961e8fa90bso1127473eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 02:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778144505; x=1778749305;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cRa6k2yGNWTv2u39mO+7rvnN9ZODp7GRurjicrpgf9w=;
 b=Z/OnatPJbe1qW5yKrNIPSsUZvSl5aoqEEWFSFKLDGIMVFa2RM+TNtCYUli5687dY46
 GX/gY5O4woTFH9u8XvEXBkFsoaLYkpjZBSXs+QIbY414vKxBmRrN6owQnzoNVhqtqEBD
 TyGB3lVP3WlW6snNBG1WBqc8Bzze9pcMj2s9vNFgAxKUh5dNE8BN6rtC1ZSLK5EQE7vR
 2d+Xcf+AgK/QBqADFhwopQi1S3PaFXYZeHKJQ4y9k6LwMNf9N1tl8iHN4qr4KQ0qc4xN
 t6I5bdxxGRyJV+cf7ZQf2qeEckTpYHkPg+kXJvs+8tw3YGXr7koCWCSdv6gCht7tzzAf
 D1Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778144505; x=1778749305;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cRa6k2yGNWTv2u39mO+7rvnN9ZODp7GRurjicrpgf9w=;
 b=gXMFOJi42vfPSVQroGclOCkz6iNWtD0vFC35uy9ui5KV4sPJz7dl2RndYVuAnmhkwm
 8wh9JFD0G3qNQIVpQtDcwmE3Me1Nu0njNdlnjzXAmnNQppVfjYg/LacHRIzAHdUS+yVA
 BQ0An6M/4o8anPiW+FO6ouZiM0+tlh/BpoO5NmSg9Fb62QZuhp/Uu4D4iFS9jSQh/jY3
 e44e3HMVEi302u14aSanL/wTUr5vM+ziNjZj4OeqkcqoJr6GbIdCNsWfr34JoWsVjGR+
 trcMS9KWDD9as2ZpUp5wpj+RGL2t2nM/sz1g7oN3BlhE5+OY4MYzvJmBt9ILC+NKCyc/
 1cLA==
X-Gm-Message-State: AOJu0Yzl7JpJHdx5915KeawWSgCszIk3ap7VPVvYFHfSQyqXjFiI7v+A
 3PsbJQcBxdSo+MRdLkj1KtVc0JH5BE2bI+yEYmyOoxRak1iwmTLPM1z9EAcadn21WvqC4r0PX9c
 KDKUEf4j5WnZD3m/VfvmsIzvuW71SogaFF+Qs+ccGZnPXOFcRk5MMnbKmATQ0Up62Y4UkK4GN2U
 CLnVQ=
X-Gm-Gg: AeBDievmUPdD/yiZG1/KT+AmARLkqbTsprY2TKoJnn5k+dW97OpjOkIpv0a1cZviVPz
 UPhtzYUBv/LrZJKcINn8Jy/QGxvm2Zpy8A20NLO+FGOwf4CTUBc/ZMtaRxwO3DK3QrAW/70niU8
 4xXvxJYAb9W1MCRut3Jt6LjUJblxw3QWL1G3NKRADNQgejhJLIOT89BqVuddhcitCPjhPUzYkLc
 KdFg/nIX5/l4R/U1FexTgXegWeW3Gn5bFs01LDW4YCq20ZUMJ6yOe705iCrjf5Oeo9Bk4tbI5ly
 d/Uq+ykW4cDyLcqYIT0YTB7LTSPNbV2ObIiXEweIHYmmHHXZ2j+hEKQBCrgqWrau1Dx9wr+iuP5
 ipI6JpBqPqJ6ERGaZJzfA9DzWf5irTq+dyrHWkSJm6GQa1OkxwFFn404TMEcqoQXQDSo7FCyHGU
 7S/yOKS/EEYbSwgfnc22A0y2jIJ5J5TZQMVXQuQWTVvJkk6NLSKsT6bgaW
X-Received: by 2002:a05:6820:1352:b0:696:2cb1:a019 with SMTP id
 006d021491bc7-69998d0fc71mr3582184eaf.28.1778144504721; 
 Thu, 07 May 2026 02:01:44 -0700 (PDT)
X-Received: by 2002:a05:6820:1352:b0:696:2cb1:a019 with SMTP id
 006d021491bc7-69998d0fc71mr3582151eaf.28.1778144504236; 
 Thu, 07 May 2026 02:01:44 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a870f96cb1sm3480516e87.22.2026.05.07.02.01.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 02:01:42 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 12:01:32 +0300
Subject: [PATCH v5 1/2] dt-bindings: gpio: describe Waveshare GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-waveshare-dsi-touch-v5-1-d2ac7ccc22d4@oss.qualcomm.com>
References: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
In-Reply-To: <20260507-waveshare-dsi-touch-v5-0-d2ac7ccc22d4@oss.qualcomm.com>
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
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2894;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=w48Zy9gh5QY1c+XBDez5fRMIM+TtMcaQ5hJ5uAZ3v3w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/FTuy7mfOfX5kl07Us/qpiAyzHwTLGyx9ydu7
 NTUppEPARqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafxU7gAKCRCLPIo+Aiko
 1fdWB/wPpnOVm0D7aCjD77DcG2BIksrTgqtu9mc4m1QefgIzAtXub3PGmjaGDderabja1f83ALp
 zo8EPN+tQ0rC+z0iODQc5GXSI9+tts3VhNMtFdsA6RD+zIy8TQhbOH+UQPKrih7HfahBpuOtaJu
 QLSuBephxSEjUKCXAKnVBk+XLwW2Z3qrr2hn0OcHcSftvkMCWOaaRnMADPaO3zOK3C+4h5QZp81
 DxAPUVe2/UnLBw5mbDUVNd1tzbOqwRCv/12pRB1/CZ6/QHVEaP8JaYAgTYdGYl4t3GXiuIAf1Yv
 fVOpqEJXCR9qr1WOCaratjm5n3XioAimdHG3GVbfk2gwfd0d
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=TJB1jVla c=1 sm=1 tr=0 ts=69fc54fa cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8
 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=btNYDYKGUqI20VIe7WUA:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA4OSBTYWx0ZWRfX9FsalDvXuM9I
 0y6gX5frsNKMcJ4HgRPq9qwjr0PGkdCGLO6qeiPQddigY06I3KxR6OjkQ/b6o6X9TonqLVATqAF
 GRes/fYsPNfCOnj8bXYhOZSBbvpXumt433e4YJC5aQVj+cnrrNSs/nJPe8JQ1+9Btv9h4/RpMJR
 vdxVqMna480r/qhIPkWOq98TCpAxUKPNg0np0NfSpl3huYj99FqYiD4nB6Y6pgoopXLKATEJY8s
 uCsGI/xR4uULnUyZUY5yXKucGPESbhMiI8yVzJhPBb4EifwwNNNqrSVY0448uIPRGtO1Oi/RyYg
 sokpYwoVfKP2Pc+Dvx0EbZeUc/oRAGc5pq+YFXIlCRCXwcp9IJnSOQEMVq3BqvTfyktX0IpG6KK
 eooQ/5E/QwsNUnotQrbyC0FsHUvLad+0YA6kOOYSs57uOcdi4Rf5Hqq4TtZMuHniODob9yfPk/K
 asIxpFPHY6PZUTzDXyw==
X-Proofpoint-GUID: 2FkdFkkMl3Ny-YJ3Nrx7oYRelAk969NL
X-Proofpoint-ORIG-GUID: 2FkdFkkMl3Ny-YJ3Nrx7oYRelAk969NL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 phishscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070089
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

The Waveshare DSI TOUCH family of panels has separate on-board GPIO
controller, which controls power supplies to the panel and the touch
screen and provides reset pins for both the panel and the touchscreen.
Also it provides a simple PWM controller for panel backlight.

Add bindings for these GPIO controllers. As overall integration might be
not very obvious (and it differs significantly from the bindings used by
the original drivers), provide complete example with the on-board
regulators and the DSI panel.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
new file mode 100644
index 000000000000..091e1fffcd47
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/gpio/waveshare,dsi-touch-gpio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Waveshare GPIO controller on DSI TOUCH panels
+
+maintainers:
+  - Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
+
+description:
+  Waveshare DSI TOUCH panel kits contain separate GPIO controller for toggling
+  power supplies and panel / touchscreen resets.
+
+properties:
+  compatible:
+    const: waveshare,dsi-touch-gpio
+
+  reg:
+    maxItems: 1
+
+  gpio-controller: true
+
+  '#gpio-cells':
+    const: 2
+
+required:
+  - compatible
+  - reg
+  - gpio-controller
+  - "#gpio-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wsgpio: gpio@45 {
+            compatible = "waveshare,dsi-touch-gpio";
+            reg = <0x45>;
+            gpio-controller;
+            #gpio-cells = <2>;
+        };
+    };
+
+    panel_avdd: regulator-panel-avdd {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-avdd";
+        gpios = <&wsgpio 0 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+    };
+
+    panel_iovcc: regulator-panel-iovcc {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-iovcc";
+        gpios = <&wsgpio 4 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+    };
+
+    panel_vcc: regulator-panel-vcc {
+        compatible = "regulator-fixed";
+        regulator-name = "panel-vcc";
+        gpios = <&wsgpio 8 GPIO_ACTIVE_HIGH>;
+        enable-active-high;
+        regulator-always-on;
+    };
+...

-- 
2.47.3

