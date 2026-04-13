Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DC7CF34C49
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:06:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82EA910E49C;
	Mon, 13 Apr 2026 14:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MbV555wZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JQZSDXPs";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ACF010E49C
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:26 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DC7a4L2186199
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7WjVXXDUz+b865LEXWgbJquW7AHByUWxUZ2e7FwcrFA=; b=MbV555wZ7gt/jskI
 8sJl+Yg4FtdsndyBJmwetOSOj68lMxTv0lOpFSp6ZhhQdoqBvGlz1QA8BgbKnbcv
 N3XRXapDFWTgy4TW0HGee0F24WsT953NTEyCcq+Y7cMzIdJU/ioRCb9r8r0f2s0F
 vyZy7XJ+UBx+GLRyG1gE1PA+ruxE7opnrfD3hgM8pb1GrOAoIWjkVBDhxJyrNKgD
 3AfjW66zLC9INGmVllEoLcJEYc7CKYo/NYcyRgCsuwq4F6E3ofrQCkojmwI0ScEa
 J4xibrmPH42iHUxFK65xIvvyoNVI8u8RyxeA4orjQJvscPzRJNjsRLRDDy1NMPOD
 ig4D9Q==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh07hgdbf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:06:26 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-479285e29ecso2465138b6e.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776089185; x=1776693985;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7WjVXXDUz+b865LEXWgbJquW7AHByUWxUZ2e7FwcrFA=;
 b=JQZSDXPsw9ARVQvqnQe+lcKxXzt7+5bul7y928nAsDPmMOLreEZE2eQ2q4y/nE0Gh+
 ILufWsVFPFq/Mj4eNyOl/ViXmYUAFsKC84IjaVe0+XFyV7lVHzGupbQ88YRkPUp9yyMI
 r4wLlTKD6Z92OI1Ry1Zj6A8RRxdtwthJARreJJLJY4VCnP1c5avQw1F60Ehh9SXqUxjU
 b4UGVmEzNykwCv7j4asndIkfKW0bl4+urVlIwa+s4kEKJgAVWHSDp+8G5WpJ4sFnmHkJ
 f7FhwfomKU3ITnI66Ip33ZPKRLbljE8uqB6jwxXng0l0mxIeP8yli0hrHkfzKpKomQwb
 MUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776089185; x=1776693985;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7WjVXXDUz+b865LEXWgbJquW7AHByUWxUZ2e7FwcrFA=;
 b=ntQN2oAC6VUkZGkKjHlhAKiPbZh8/1CqGHzi2MUe3lrU3TK3NLPWuDEOD07OZ/iMzs
 2OqpIK1Dj2s0FQMgnK134YIIB16vVvTYnwih+SUdHYile/8la1ONQ0vNxLmdRqi82X+H
 PkkmjRETWM1K9OWYafXIdcCd+YB5Qn3KWfgnKbfAj+Ftw1zablcskt8gXwbnJhkmkrA9
 aPl4o1ogAzZ9u6mhKv3cy32Lo2Q9W/P8v4G971BP57DKwowf5nLq6+v14Q8LxgBHxDAc
 n95vVwr46UXPFsThNUDGP+Gh0jgVx/16btdLCpSsxHvGghSA6MryimG2ONOJFmg3FLEy
 tgaQ==
X-Gm-Message-State: AOJu0YybOcVM1PgcIDTW5otWjyj3F04JwcSzk4aghsdMPsbN91hbeNv7
 vU3w0v0MPv9a1rE1G0psczxlhbIm+o1n9NdjvdHja8e62JD636Gy4g5Ky14Nl+DXRuBnDkqq16i
 K9I4PHr5q4WSejt9yKTBrEQZSaGdVh+COfPipkcF9UDw4vyajhqPwkcyxvCCQDA6Kwnr/2vs=
X-Gm-Gg: AeBDies8ddubwzc0u52/9PDSC6ZXPWVplVvkMZ+cMBO8Bb9mUZkyujSgQRgyvpdIn3I
 yHZ1L4rkAIzp4mDHKx013cyCu2bqEt+bB7QIgvgGSZBbTZxufE5Sgc4FO0jmKBu9cFsgaUThlKM
 IRM9+ZTjqc9FaOZ6tmep7FXib7oMnkXHFTHH4nQP5wkJ8aBNGdSkfkRfrUCDSOeMLbee9Pkszl6
 xiDdLi+Y9nMQaDWU6xAdPrhNTV7guornNuxGwfzBkUK4JvKTkog86f4WfWkPwMFyImn8MUJeUb+
 0ZacEab2PvXcPwSq67HoLIc5XD6g+bHa9oQu25EaUCFI5ij7iJSgq4PNxpizFvGszM4qh7cOFwX
 dKC3NWdLiJiuMY8MdcyXW8SHvrMINC8gyjmaekDcdz5xKQWR4CNEJRyfXkQfPbyJiKINERu2UaL
 PSYSktYtFTzUq7mH95MLLkxgFWUawJeP3oRfw=
X-Received: by 2002:a05:6808:1796:b0:467:db23:25c with SMTP id
 5614622812f47-4789f9008e6mr6468622b6e.46.1776089185103; 
 Mon, 13 Apr 2026 07:06:25 -0700 (PDT)
X-Received: by 2002:a05:6808:1796:b0:467:db23:25c with SMTP id
 5614622812f47-4789f9008e6mr6468565b6e.46.1776089184531; 
 Mon, 13 Apr 2026 07:06:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee8c91csm2687521e87.19.2026.04.13.07.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:06:23 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 13 Apr 2026 17:05:43 +0300
Subject: [PATCH v3 20/21] dt-bindings: gpio: describe Waveshare GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-waveshare-dsi-touch-v3-20-3aeb53022c32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3582;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NxOTOcbnEcq1UCCLVr2MVAq8PhJPaj6hbxOeziIVdG0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp3PgpJbQp7/Thx5AFbDZ3MJz1gCOh8B6IHEIIW
 fv5ZYu/LouJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCadz4KQAKCRCLPIo+Aiko
 1WlsB/9jCSy7PdUg/mLPbALC+8TGXtsfMpAIz+y/8wCXE020hB6PkIF3wXzJPj1fgghhVvm96+o
 V+llBWNzGIG6xJOLUaTAYK8aJ01D7Vxf5h6mjbldw9m3yFVyRI2yys5vSipyVw9Wk1/SzKxOxaj
 PgQVJh37OWIinWagd2PrA+gvCOLqEqRuGG0Kd8CT6oXMH7bBTNQLrVpKS7DfisGHcBMTEaJWvTM
 lwV9+R0HVmdkogNr0isj1DFP92rnsMQXDvdXXoFaAWuTqcbseOBKGVK2RKhsaPoRT7L+GuJ302l
 dI1npvbMOw+/Km9vf9Dzm8uGawi2mmG5y1OPEy+E3LpGkrAI
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: OfON9tnM1NOHqSZ_7G3_KS5wOrF4knEQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDEzOCBTYWx0ZWRfX6tCrXDFwmNfe
 ZapFM2uiCpc4mlaI7B2hUPxQLqNJiPysD5sbzVyTtDTb/9byRbJZTvJlrnv00JI7WUVX78EbsKY
 nN5swAUpngsfCXs85XANhgVQ1KIORBol0S9P528UavgxoA5/XWnj+YA5CgwXYuUmRH1w3TB1abN
 N5s/nwa2X+bwvV2BDYD5HnY4kdWh3Ufud+HWiV9fdvX6StGx1eFfq17Ceg9GfwBXSKGKPRgLXBd
 VEYshAO2Q5Fn2rSWErcKWr0FD3WiWl3EcniQIz3hoSyA2t3mM60WjobVlKYHrxVfn4sqWkESQSi
 k4CfN8oEsVn3oXP0PyenZpmcDowzKJOCRlui6unPzQdRA62mInGzgdmCaon+Ui/u5QS6PTF5f2y
 hzGHnd+FZNLFU8tETBHyAl9wnROqOM8UoDrllfRGu6tQy78AvyaKfq8siw6ux/X+KNt/PHr4Xd4
 onymdmSaSIYxGn7GTjA==
X-Proofpoint-GUID: OfON9tnM1NOHqSZ_7G3_KS5wOrF4knEQ
X-Authority-Analysis: v=2.4 cv=QtNuG1yd c=1 sm=1 tr=0 ts=69dcf862 cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=ClTKKeZw4Bcbv9k5X4IA:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0
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

The Waveshare DSI TOUCH family of panels has separate on-board GPIO
controller, which controls power supplies to the panel and the touch
screen and provides reset pins for both the panel and the touchscreen.
Also it provides a simple PWM controller for panel backlight.

Add bindings for these GPIO controllers. As overall integration might be
not very obvious (and it differs significantly from the bindings used by
the original drivers), provide complete example with the on-board
regulators and the DSI panel.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 .../bindings/gpio/waveshare,dsi-touch-gpio.yaml    | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
new file mode 100644
index 000000000000..410348fcda25
--- /dev/null
+++ b/Documentation/devicetree/bindings/gpio/waveshare,dsi-touch-gpio.yaml
@@ -0,0 +1,100 @@
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
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            reg = <0>;
+            compatible = "waveshare,8.0-dsi-touch-a", "jadard,jd9365da-h3";
+            reset-gpios = <&wsgpio 1 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&panel_avdd>;
+            vccio-supply = <&panel_iovcc>;
+            backlight = <&wsgpio>;
+
+            port {
+                  panel_in: endpoint {
+                      remote-endpoint = <&dsi_out>;
+                  };
+            };
+        };
+
+        port {
+            dsi_out: endpoint {
+                data-lanes = <0 1 2 3>;
+                remote-endpoint = <&panel_in>;
+            };
+        };
+    };
+...

-- 
2.47.3

