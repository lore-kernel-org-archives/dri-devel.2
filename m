Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8562F013DA
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:41:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FEE710E369;
	Mon, 16 Mar 2026 08:41:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FkcRDq7c";
	dkim-atps=neutral
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DC1C10E344
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 08:41:23 +0000 (UTC)
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so38404105ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 01:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773650483; x=1774255283; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l6XtG3AvTvkCvaM5JUgbGWufscX9JqZNMjL0RdIiJ6c=;
 b=FkcRDq7cDktF2RGTAwcHCcNlglDtOwfpLRrGi5cGZOBo9bBERyT9cfkdT7iXG9vR+5
 wNGC6ri3Gblv2bcTceo+PokZq3Kw67I4zivBqYfmEJCCpYfgjnY7FecdEGXf0U4Jk+KT
 PWfGElyFHKMvDeGhTppSQQ9ttKz4BZA1GjnS0+RS6q99j8GwnPB0onPfCwoEVEatf1c3
 HbZFm4SF7gYouH453i9E+Qae7dCQfBNtpUn5Zkb2eF3rCPwt6a1VExujkbY0eEzWIgCn
 B6xpdoTq+Sz2GDnSdrDwQt5QX3MLOKEq2RnUJ76gxXc6YJcQIut+3I5sFmI9Oc/3QYSc
 hqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773650483; x=1774255283;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l6XtG3AvTvkCvaM5JUgbGWufscX9JqZNMjL0RdIiJ6c=;
 b=JnwGWc+dBPDAEBMTxk4P09sW7Ithzt4kk5Ti27ywuc7TDxkYhKXLC6vbyPckMYv0qr
 V+eXWyQR3D3es0AuCbqBIueo4rTihVTLKv8TU5zcvF5Q5WnQtcNRk3aqEkyKhWJaCceJ
 d8N56DHn50yBvO+vIpBOHFZVWgTYAgEpuWl7ssZDGD6nkXoJ1AjZH1dzjrhbAXERuwkw
 Q+UnKioTOCAcEHK4SrGqLiMkox8AO/6aGb/6I3T26dmo8I7Vor98mRrDe7LL5O8RkGXh
 J1cBt1WIqNP3ayGB6zoqTU7kKA5QT2teGrQiE47xhbAGL8w6CIh2Nu+wz5pe+mR/Upm2
 Riqg==
X-Gm-Message-State: AOJu0Yz5R/FQ1gDr6imrwi3oeb+LFh9etcabD1aU59foXLiRnJO2JYpX
 Ovf113dEz9Zmg+y5UwOWJ76hPoWe5NY728/n2xFwhkPGJV3aJ9XIeA3K
X-Gm-Gg: ATEYQzxwXoRaRRuBNEP0Rq+UypZO7At+5A7vAFNUGdMX14NTaTexlCCJNOmjdpkdh7W
 zBV/3/ySKnqprBfhxouWj8sX3LzCNQvjSZJAtrVZvRmYe+WuIPSS1mTuREZgR0QG/cWGKOhLWFC
 N4mda8evYUOraFahMvs5GwHmQ9lovrtXkZcSDthBHYYXyJTRy/z791ptERngLsMlvJHjCNAKMUT
 oR6QckRg4z9APbvKcI26s8poA/qeSQDFaYlOvS8dwq6n75WMrSxISMVo2pO1HtKwp6XL3CMpY1h
 j5mVGqvbfwQ+AMipup+mjeAMBPOGjf0pmB8QBgz5cNpdv6r03C86iBp2MkGJMrIygd94la0tiUp
 sRpJFuKuSdbxuC/QumbahxYtpyMphPQTuOf5U0cXhzQK5V9BZZqlUHHUkNiIExsc5Y9HbjMOUyk
 X0IxhZtFVrlHPiTRcasKHWM3qvsmX/
X-Received: by 2002:a17:902:ec91:b0:2ae:4d6b:b2c7 with SMTP id
 d9443c01a7336-2aeca50068bmr112406065ad.9.1773650482642; 
 Mon, 16 Mar 2026 01:41:22 -0700 (PDT)
Received: from nuvole ([109.166.36.159]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83188csm101699045ad.75.2026.03.16.01.41.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 01:41:22 -0700 (PDT)
From: Pengyu Luo <mitltlatltl@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add Himax HX83121A
Date: Mon, 16 Mar 2026 16:40:39 +0800
Message-ID: <20260316084040.728106-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260316084040.728106-1-mitltlatltl@gmail.com>
References: <20260316084040.728106-1-mitltlatltl@gmail.com>
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

HX83121A is a driver IC used to drive MIPI-DSI panels. It is found
in HUAWEI Matebook E Go series (Gaokun2/3) with BOE or CSOT panels.

Signed-off-by: Pengyu Luo <mitltlatltl@gmail.com>
---
v4:
- use v2 as the base since v3 was using v1 as the base by mistake
- remove '|' from description (Krzysztof)
- drop description for reset-gpios (Krzysztof)

v3:
- remove '|' from description (Krzysztof)
- drop description for reset-gpios (Krzysztof)
---
 .../display/panel/himax,hx83121a.yaml         | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
new file mode 100644
index 0000000000..e067a2f6d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/himax,hx83121a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Himax HX83121A based DSI display Panels
+
+maintainers:
+  - Pengyu Luo <mitltlatltl@gmail.com>
+
+description:
+  The Himax HX83121A is a generic DSI Panel IC used to drive dsi
+  panels. Support video mode panels from China Star Optoelectronics
+  Technology (CSOT) and BOE Technology.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - boe,ppc357db1-4
+          - csot,ppc357db1-4
+      - const: himax,hx83121a
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  avdd-supply:
+    description: analog positive supply for IC
+
+  avee-supply:
+    description: analog negative supply for IC
+
+  vddi-supply:
+    description: power supply for IC
+
+  backlight: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
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
+            compatible = "csot,ppc357db1-4", "himax,hx83121a";
+            reg = <0>;
+
+            vddi-supply = <&vreg_l2b>;
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
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
2.53.0

