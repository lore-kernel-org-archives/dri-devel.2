Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CBDC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 15:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402C910E182;
	Sun,  5 Jul 2026 15:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bf95ErHu";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C71810E182
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 15:37:04 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8475eca3a66so3269244b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783265824; x=1783870624; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OMHOwB1gJgFIEhx9jNa5p0baI/PKUY5J0BR5RvxnEJA=;
 b=Bf95ErHujeqP+NE17K01wihGron2yx070pO0wFT3gmM+T0kpy02Ftg9Dyi70258WkW
 XgnFfGrXIXSRxuy0HgQRI9+vluWcvHKPdHvtu/0VVIQMV+8hGLMkMQ+BUb+5pZ6MjCQg
 FMylgkYWByktbb0Iw65VxS7EOLJ2U1+f7g5u0Fremod/KwuLV8XhdTbPuf02BxwH6Dr6
 tUk92PSgaWPf6bPpb7yAq1ss9P1m2dGWHOEEyUwNNTD4LAqu0hg2X7kbzVlXaB4x3DvF
 Q7kAYXiYCyeqvHkw5dQ2nvwRxN715zqPlT/ymFlnqmoNwG9iI07gBVAnwWJhEHv2LvVo
 GKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783265824; x=1783870624;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OMHOwB1gJgFIEhx9jNa5p0baI/PKUY5J0BR5RvxnEJA=;
 b=deSVPypR6pSRpBmGtaaYBS8CFf1kA6lQcIny8qCMP1UeBOZw5bgnYsZjCpxjtLhumF
 i6Syn3ks7ERdo2Ajjf1sXn6jWZwRi6xTTbh9lnUi0W/TEIS/uq8c8Xkb3+PITx+oxdSV
 EGIZEEnnAXECzUhhXAcvmGu3ShTSnTGk3akNHMWxGQ1e6QKRkddP4cRR9SjGU15bdjk7
 h6yNscy9FerpjZHGTfJ4ydgkZymjjuh+j75WZBcRuMaHzNAGghPSrZ1N0lObIpxRzhUR
 S0E4vp4lEODNd2f7f9Pk/B5Mmcc9NgW9vKSTuwN9fKU9CUVvGBUZKfPCC+Sqgw1nw8Od
 T8Fw==
X-Gm-Message-State: AOJu0YysbVsSpIpxykQ4+iut85F5Iees5eqyty80e4NyukavSIqCXK9u
 Iw0PQxq8cpxR8w8VOtN2hPlx0NMDDXzUSbkxrQlGREaj/yuiGqjlMg42
X-Gm-Gg: AfdE7cn3Oi4u7WxF/j0Fd1sfpIbN1m916N3kOU6xrLNq2wK8JN09cMfjb8DB9Y9mCWk
 DLP0BXddM/P8U/IKOb8Sk85XFPdoHY8KV5OvQQ89BnFic72ittZnrrYg0IjMUwd3Y9LeqLQIIqo
 kCp2spTWB3XVrcAQsW4U3bs163iEirDYdr9zUkX1QckTLM6RW8bJlAPbJbdXih+7CobTXWK1UQc
 vKbpCrZcTppEHxaDGdZv/3MmeumwIJULGy/eDWa81/7gcHej46/yKUAXF6bF7gD6HxYrA5zzHvM
 p59g7hUNLT9hgNDGYSwQLddA+3RQeTkmknckpYDbWJ30z4AY9vpHJlkBcxtMvCqA4d+UwB+iLob
 Hu48cHilmku6egCXL+Xb29ugQIx2u07JKUILgynvcfIXvj8TSwklCSLpMU6zPQpczXtL2btEM2m
 DWQWt6IdN+Uce/bvUvLmmfXdQdAl1VjG49+FPprmc=
X-Received: by 2002:a05:6a00:44c6:b0:847:8d56:1f71 with SMTP id
 d2e1a72fcca58-847f6dc2c53mr5948118b3a.21.1783265823618; 
 Sun, 05 Jul 2026 08:37:03 -0700 (PDT)
Received: from nuvole ([144.202.86.13]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6db29d1sm2402076b3a.53.2026.07.05.08.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 08:37:02 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Novatek NT36536
Date: Sun,  5 Jul 2026 23:35:14 +0800
Message-ID: <20260705153515.46147-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705153515.46147-1-mitltlatltl@gmail.com>
References: <20260705153515.46147-1-mitltlatltl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

NT36536 is a driver IC used to drive MIPI-DSI panels. It is found in
LENOVO Legion Y700 Gen4 with a dual-link 10-bit CSOT panel.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
v2:
- Collect tags
- Mention the CSOT PP8807HB1-1 is a dual-link panel (Krzysztof)
---
 .../display/panel/novatek,nt36536.yaml        | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
new file mode 100644
index 000000000000..0862998cc6ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36536.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36536.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36536 based DSI display Panels
+
+maintainers:
+  - Pengyu Luo <mitltlatltl@gmail.com>
+
+description:
+  The Novatek NT36536 is a generic DSI Panel IC used to drive dsi
+  panels. Support video mode panels from China Star Optoelectronics
+  Technology (CSOT), such as PP8807HB1-1 which is a dual-link 10-bit
+  panel.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - csot,pp8807hb1-1
+      - const: novatek,nt36536
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O source voltage rail
+
+  vsp-supply:
+    description: Positive source voltage rail
+
+  vsn-supply:
+    description: Negative source voltage rail
+
+  backlight: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - ports
+
+additionalProperties: false
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
+            compatible = "csot,pp8807hb1-1", "novatek,nt36536";
+            reg = <0>;
+
+            vddio-supply = <&vreg_iovdd_1p8>;
+            reset-gpios = <&tlmm 98 GPIO_ACTIVE_LOW>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in_0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1{
+                    reg = <1>;
+                    panel_in_1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+
+...
-- 
2.54.0

