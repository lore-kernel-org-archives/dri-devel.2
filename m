Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF67FF99C6B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 23:16:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D04310EAD7;
	Fri, 17 Apr 2026 23:16:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EKfs5IuE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfXltdgG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3E710EAD7
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:38 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63HG4OXY1985539
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k/MReTiZ3YyWJtzTaefEwes+g38rRRobC1lXjVxZm/g=; b=EKfs5IuEqeYFGoiH
 VpEIJMmAG6oQaB5BWZ+EBd67Afhq/3BWr5T7r4KpAlw+ChVQGry36vHXnztX1glq
 s5zrcMXHC0p8fVoIuHPXqXq0eoOSLtQql50DMgH5bm0aLBS3cL/AK5nYDr71sTNR
 /hJ2q6kqfjaR7vEWFTNgz5R9LZtBYjpD+Ra8uGq48qisCmZLsnLWQR0MR0jIkKIm
 Q94qGYAAKNq8LtKnqfAZvK+QhBxkzC2KMqEFds8lze/eXvYjzzpuiSBymc4hmNH2
 0/D2DoTnzZ5nSrqE1yZKafELNlkp51PptJ0R9ZWT1qgChWlB75sKWTyG9FBjDl48
 aBod3Q==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dkfyqu3mc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 23:16:37 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b34223670so20859631cf.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776467797; x=1777072597;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/MReTiZ3YyWJtzTaefEwes+g38rRRobC1lXjVxZm/g=;
 b=FfXltdgGDG+VfziYmSlyWXew9otds45g2bf3x9ktxKziVxp+KUX+3EOV/YhEMzJFVa
 B1FQRs9u2p/a3bJAbyOO/34mDTlKUm8uxPTWW7XYeCPhDtAYYRobkF2CTjriRXPF2zaV
 UsCcpviZlfm/bnEZjL+BFJKeiJVK8ehZH6PWORlBG+C1TE+Uh0jSQc56Sovhyv8xPrsA
 JhCt8IddHHwH0Y2dnz50cwEgTbXY0jT9pGcQasGk23Eyt0iR8bqX3KAwXcp4mPGQqpYd
 qcVXx1daQlkdEx5YZ0wJCvZkYZmA5wOIwkgNQ6mDOWsjKdCKX2JpdrQckg1ryp7NCiwI
 hKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776467797; x=1777072597;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/MReTiZ3YyWJtzTaefEwes+g38rRRobC1lXjVxZm/g=;
 b=GzjALchjEvbg+eQEB0klWWRdFvKIpRykBDaJ80KlMJ7AKT/VKaXM4pNn5ujLDPg2xN
 V/KTgLwdbTU4JQe8Upx9iKgDujN7njQgpoIsydE1xzrC88KPoCC/6/qni0YL6lsk0wWF
 P7L92d8Q0McPn0+DzyzTEcoalItFrKkVxgJQF0W4FYLILNq34aWuIr0yWCoFI2qfbSxA
 1pX5EYRgJAiuiIpW841+aAu0GFHexBfxqNXnFsHbjUfbjlegszor/9S+tRM8sOmtEoxb
 CSM1JXqjCB7hl0Qyg65D6oNhhNBaxo2Qge5OW8La1wERbm9smisQKRWr6YcG026mFeTG
 QD+Q==
X-Gm-Message-State: AOJu0YyIc2s69uEXyZocDrpjqcBBxDyBFl2MUGWe6M9X7Jol+Q71ad3Q
 7pV5xAtsSU2yIfEwoE2tgx06w/cXIc7oTCUnPf9YRPNcCbCSQghK2vZH9OFbTNKv8GTuAsqJxi9
 ojlRglN4v1ZmHFmVXmhDZGl/0nUSE49CJcBMKEj+UZJN03LmKR3F+MJ07qGkXsbWWGBuxWb+mQJ
 rEhe8=
X-Gm-Gg: AeBDietDHHL9RRP6Bn2kXOJ48gW8uKkiElRIIrX+GEZBvatudgZme66p2njo2BXiRq6
 RVqd43rYnI49vjhKTQgErYfIUIfa7MEmsUSK067xPNbYON+qm9EC90XAsdhrQAYIgKtIc2cHDpS
 glWVwPeSPZJVjhHLMd7LJB3LsoBq/6gum/jvSc/mMi96qljkCGGv+CtMQT18cguPtgiFHP0q/0Z
 0evRySJo9EMijifZrzNJlUKM7aVTRQKz5jvgMj8WwWoSMsgRQBs11blyhhFlKWIYcDGzl34mI0x
 69HWK1N0husvbVts9pYihAt5vGIHyGgKiAVDAXudUPp/GVY4l5FlaLQ5vysE1FAmqQv1ymQczJZ
 RgWO6sQjqtpTncm/DOJbAveQoVRXPTlVf+T83LG+5fQqT3gF5S36xnJNGyc+99ngVPyhlkDWj4w
 rCFsFGnyT34FnFkshpPMnpI52a3LCFFkga7rmnJs/kOhBbuw==
X-Received: by 2002:ac8:7f16:0:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-50e368281ecmr75066701cf.6.1776467796856; 
 Fri, 17 Apr 2026 16:16:36 -0700 (PDT)
X-Received: by 2002:ac8:7f16:0:b0:50d:7135:5631 with SMTP id
 d75a77b69052e-50e368281ecmr75066231cf.6.1776467796412; 
 Fri, 17 Apr 2026 16:16:36 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4185ad12asm815695e87.1.2026.04.17.16.16.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 16:16:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 18 Apr 2026 02:16:22 +0300
Subject: [PATCH v4 3/4] dt-bindings: gpio: describe Waveshare GPIO controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260418-waveshare-dsi-touch-v4-3-b249f3e702bd@oss.qualcomm.com>
References: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
In-Reply-To: <20260418-waveshare-dsi-touch-v4-0-b249f3e702bd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3635;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=QFyGUBjpv4MqdXiM8mWmHDArDsRkJpFYDlFfKXrJ+qM=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp4r9Iv5xhufaEtYkC6QvNv+yB79Xjg8tcucfbU
 GPpWXq7U4GJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaeK/SAAKCRCLPIo+Aiko
 1QZdB/0Xirv0hja+h/Eg/Im/1sajcD2PL4HsG86Wjhg1rSgIoZlF5In2wlN4qEL4vWYsVMEttQa
 GuVRQfn8ZmQgIZeL3X4omDRYw6THCiyRf//j2VpVlrsYVGVpe91zhd380Lu5MNeZC9CXgkXs76W
 mmvX/I3QVYVICneKBYxiBtOF3VPi54RApWS6/vFWw7rCXV3tw+OCLlcvtBrbKoy6d8bDzt7nLNF
 Qwtaevb2ikOh2d3QaLzFVSluoYI6Ji6Ah8ZfvbYx9BlsAmyy1Kj3pn3vntdMLjoxOkZIvC4N1Vz
 Z8py20gICNPtXnkD1WNp8bLxJoK+9Kk9HJjA6hLvEkFZkK/i
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE3MDIzMSBTYWx0ZWRfX9hyc5X9JdeGw
 h8VKNYGN/y7A2fbJkXUHto3IhHZ6NDrn0wuZG/C/VDDNAa2/+l+i6lN4IAyVCK0f3FUFMGAiR4K
 cRgpsKObWNFaMEB+LYOxOgdgI0O63ElZIcB1+rfyGEoidI3KrfSoWJvbcMuOR9RpEH34yCxniGW
 HTfoXgFTRpykiNzoSUvRmYFNQu3RtpbNasbR3q9KI2139EY4YoGS0Q1u+Z0CPw64lcu1Hi9uk2q
 fe5GQp1fPSCjETQ9p1lC9qo3quVJmECZ8KkuaewPLEwu/LyIeEHp/czGwFTeoW01Li+pehvxaJw
 qlULGOiCSVJGPct4srR9G0E3a5KORlS/FVexoQ9fe4U2VpcOdCtsoC6zonyjOqaaXPp1UknwEuL
 jksOGaxjAZNtbKSt7RxCHkSEAT61cGGIGRiMq5cuW43GC9PkQ6FDdsiLEVPCbJC5pMllqkti7Lw
 J8i5F1yIvmZgy3yGqZw==
X-Authority-Analysis: v=2.4 cv=BZPoFLt2 c=1 sm=1 tr=0 ts=69e2bf55 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=gEfo2CItAAAA:8
 a=XYAwZIGsAAAA:8 a=EUspDBNiAAAA:8 a=ClTKKeZw4Bcbv9k5X4IA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=sptkURWiP4Gy88Gu7hUp:22 a=E8ToXWR_bxluHZ7gmE-Z:22
X-Proofpoint-ORIG-GUID: SyX0abvr0RMyLybdzkWRXud0mvu8e89E
X-Proofpoint-GUID: SyX0abvr0RMyLybdzkWRXud0mvu8e89E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-17_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604170231
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

