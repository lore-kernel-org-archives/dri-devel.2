Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49660F3026E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 14:46:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE3EF10E173;
	Sun, 15 Mar 2026 14:46:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MmBl1xOx";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E49910E173
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 14:46:17 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-35b97ed057cso171140a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Mar 2026 07:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773585977; x=1774190777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DtJRSPmUvgmNOu9vZgaeyPwZaZMDOKypdtTq/nu3S7c=;
 b=MmBl1xOxDMP/yikm7UvVwaNWVywCQKsv05g5NPvB5X7pC16tSjboajcEwM/P7p2x9T
 tqtsHks+evzxO2sW8a7cJuepsr/Y09q3S7n3LqkJmBZUlwYgK70ccgmre4V+XcWVKjYq
 XDz4bXr9krOUat8wOidoisFZhmow9TVVINy/EWHaj+xXppMWOjkMMWdssRk5HjJ1XgiB
 1o8ZseYrjm2TFJZR6AekhiBa6iRSz7ZRBHRf3j8VQwBP7B/7WkpNOErtwlvIj3XmeGkg
 cWlF+t6q8oaV63o4B5z66Smr4/WGq46aptulOOf4mVSEJ5or6sYHrQb4pueyr/xLbZkl
 F3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773585977; x=1774190777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DtJRSPmUvgmNOu9vZgaeyPwZaZMDOKypdtTq/nu3S7c=;
 b=LXb1eiSOVFFbTUkxhVb+bcuN+3UGcixGfBhQOObR14l7znnde6/lS+BnV3OUdIk8qF
 fS/Elb3HdRqHUD4jZkoaruZxvoxilt/C3gEBSys5Gx7Epz7Kqgu34g6aTjrJyKOQS/MW
 CIHMHglgn3jSVZwUqAEMozo418B5OcinLECUDs2utFHaJ5K2xLJGD4QRZs1GJoHGSmz2
 dDkkj/h146MjhOvkWHIfirGx0VqlJCP81HklSDqiy6dcK5LoeGe3+aU1Ax6+6yQGIirY
 8v/+OeqsC+VuwcZC7xwZlCXqfMEk/P1qICmkBdA9qfkfKwvtzn9h0qxG10Xx988XPdmd
 TYfw==
X-Gm-Message-State: AOJu0YyFoM6nj3vgE6NPbsDDipKJTo0OzIwCQExAuNOyTqJYV8NqTPJf
 W9drb0TJn0P8ZvNG0izQjJwN3FsRDZjfTLg8If3w+bAjyJIgzkqCI+7155nwQtnfRbA=
X-Gm-Gg: ATEYQzzCVf8fneBshC65iaoMI5R8tPJFy66IMds7Qyzn1FMzZCcGGxviEKwRke/CmzP
 zSedHdLXDMZGoasMuhVosGPf3PmDXnjNUmiqEzLeFZXKTnmaLWwYdEoQTGUpvsb4aWwIAQBqvNU
 zSnNv0T0ZhEKD2DALvpTr9EM4yoxPBpnQAXr1s6nCfphMUqOViuv0MqM1wv0RILmVRwhGxREx8D
 GEJoac4t4DebTVOU98tlGgPFBBed11X/KhKEiGFq4/NQCD3v+BUB8Jy6X5TQEF+rZy52m5xnSTO
 xhN9RFVIYcxpva0hiRC6SfxpHHUZHcRm2N/Dbs2P/zApC9QEQSz/cGQ8S3kfUY2l6Vm6SVXiknD
 49Tu89aMc2RsDgleEF4YPpG8huzo+/qTa8X0vCefvvAy7Il0kxNhz/XM6az7bdWDcULmSYLIy9J
 X8nUmL6siOKht6Ko7RxgicXtwu+9Vz
X-Received: by 2002:a17:90b:1d09:b0:359:94d8:34e7 with SMTP id
 98e67ed59e1d1-35a220554f9mr8970605a91.32.1773585977009; 
 Sun, 15 Mar 2026 07:46:17 -0700 (PDT)
Received: from nuvole ([109.166.36.159]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02e196fdsm14022887a91.2.2026.03.15.07.46.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Mar 2026 07:46:16 -0700 (PDT)
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
 linux-kernel@vger.kernel.org, Pengyu Luo <mitltlatltl@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Himax HX83121A
Date: Sun, 15 Mar 2026 22:45:35 +0800
Message-ID: <20260315144536.515032-2-mitltlatltl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260315144536.515032-1-mitltlatltl@gmail.com>
References: <20260315144536.515032-1-mitltlatltl@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
v3:
- remove '|' from description (Krzysztof)
- drop description for reset-gpios (Krzysztof)
---
 .../display/panel/himax,hx83121a.yaml         | 86 +++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
new file mode 100644
index 0000000000..603e3ad85b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/himax,hx83121a.yaml
@@ -0,0 +1,86 @@
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
+
+required:
+  - compatible
+  - reg
+  - vddi-supply
+  - reset-gpios
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

