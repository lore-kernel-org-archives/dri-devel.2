Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE2BC982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E113F10F380;
	Fri, 18 Sep 2026 14:40:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="lPpeShyB";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2740310EFC2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:40:11 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c2953a01240so127868166b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1789742409; x=1790347209; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i/IatM9vHTABSDwa1SOgukfIbmpJsWxfSXbs/7yaZiE=;
 b=lPpeShyBzox9zHu1ngwzV29ThZAFQrgNFKclAFGq59ojKNI8eYog/1LIa1LGn7Rxwj
 QZKESH4FCbGZ/eQhvRLkoSk7+pdKuDcEMWgCGfI+9U7l9nKDdKedselfNYlEl0t5VG17
 nG88v1CtNPS4H/v+at1Yya3u2QAGBoscFWb4j7cG2fQAyoxAle4bIt9rVtVu4YYvH983
 IfHJ4DyssfseaACPHvlG7YejL0IgHa0bjGx9Uxety0kJX2ckd8QynafTmNJ92uEU6Tiz
 CmfGP2Db53pUiamcVwlUcR10vVaH6xi6fthqZfGhbfzFUUpy6QssuY+kkJVAsIsWb1W0
 mXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789742409; x=1790347209;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i/IatM9vHTABSDwa1SOgukfIbmpJsWxfSXbs/7yaZiE=;
 b=kKFMtKDMC7tSbg1KorR5wPT2AEFu0fJ5Ra91QjGmWh6txG6eINQW6kXrdQzMPrL2sD
 NjZtjY9H37C7U10BoDm5380WqheTz3SPGmuHxufhJFdQ6Xst94xnMpi6MQsaqdLKW4vm
 M4iyc7TYXSxnE80NINCNzBh5BPIMrk6XGA/6gtKCdSPlfZPY+UQkC6qOTbyw6nrLglO2
 iXMA+6mIE39KTFz+3QPoycLbL7wa5zRhfl+cg4b26jMH0eM9gyCEKuCmfLgQ1ndgcyyE
 AgG6/Juo1wbZf8pJ4s2EeHW97TG9ehhpaiqQItIOiCx5hu4OkyLPOnv+hlFKDqp74EQc
 33kg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrbxK579GX9X+jMWHhfA/3fRPmJByQKPxspdZPW+/LEAnyFOqt/WyXEcAyyFzBGbQUi5m2yZiSqqg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nO/Vt+mutD/kgpI51R17A+2JrcWr4u8smKnVND+F94pnKxjNAf
 uXfv0ELrAxAcgrn33pI2AfaoQpj4vjrvMIxtcAQSnHVPpejrGAU8NegeHdKqRtMFdKA=
X-Gm-Gg: AYBFou3UNbEr16GeVdDHCMLvwo+PsNRKvtkIYpgOyvvk6FizLkB/CIGMa11Blpt0Y5s
 YSu9Zg1uRFd4xA/IcZd1qQaCQXrkBixqWIqNrfasJhwAaQczaLLPPU+7D8uHeCn3V82DrSFSbq6
 GpGL5tLkjqL1J4JdlwvllshfrotlSyWtptERO58A6AqY/bKpukCfTkVP/d33wgcnbfdUix5pX7A
 X29IYZq7BSGuHvYRhBUzWiGQT6ds7JKpHH90P7CAOYglqU3vY+ZGke6IKIxk/7mPT+nwPsmkny0
 wmR47xxwgzW4FK/gFOKXM9m69VHeuzQP8o1IX5Ds4Wm7vUC0RqfJgcdw+QbVMEO/Sx4O9vF5Gmr
 tNZ4kF1Xd/kOByZsbBVjHfvNFL6SW/LdE3gbAlBWwilGwq+V/AfRuUvqFBXHVMZ6tP0TO2YsXXl
 10biInOEC0aFxDaD+d2ryypNXC020ttr1xzSWRepE7BYIv2CGwGBAFBIz2zGG0uSMQKmG07KxQF
 E/IdPDQTNhDQzzuDwaFnIlb7n8Jayxl5ggpOMxsrQLrwFgPkbTv
X-Received: by 2002:a17:907:3f24:b0:c29:439b:d5c1 with SMTP id
 a640c23a62f3a-c2a1585a618mr282179166b.16.1789742409410; 
 Fri, 18 Sep 2026 07:40:09 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1b7a369esm64244966b.9.2026.09.18.07.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:40:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 18 Sep 2026 16:40:04 +0200
Subject: [PATCH v2 1/4] dt-bindings: display: panel: Add Novatek NT37705
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-fp6-panel-v2-1-6695c4008920@fairphone.com>
References: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
In-Reply-To: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789742407; l=2372;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=XhMyap36SF3JF1+9wLSfeQ7OCyB4xUGjcggtykCnHpw=;
 b=zDpWdXo+ogYNi4ESfbfwF3oJmTY6LAq8995rP1tN3uxmV+O2gFbbKUT8WcCAAYO84wGfj3gmo
 ZGbpua155biBy68yvD0D4ykBtKSEAE2seq6/VmZvCjM/RGc0JEsb4OB
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.

Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
from BOE) using it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/panel/novatek,nt37705.yaml    | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
new file mode 100644
index 000000000000..1c796599f6fc
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT37705-based DSI display panels
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    contains:
+      const: boe,bj631jhm-t71-d900
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - dvdd-supply
+  - vci-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "boe,bj631jhm-t71-d900";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+            vci-supply = <&vreg_l19b>;
+            vddio-supply = <&vreg_l9b>;
+            dvdd-supply = <&vreg_oled_dvdd_1p2>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.55.0

