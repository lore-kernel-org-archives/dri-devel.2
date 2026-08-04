Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1CDC5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:39:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E45289AAE;
	Tue,  4 Aug 2026 07:39:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="VGm8sWce";
	dkim-atps=neutral
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7071D89A5D
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:39:38 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1785829175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ksSHwp132uHGThlbNgyf5HwZ9dfAc/nnIU5yUnzrGXE=;
 b=VGm8sWcezOHtrmBvxwDqFpBGsoMqiO4+Mqt/W0Jtv6PRRDp2INtlvbABC2lOnkoC5g1506
 7mdV9bFo32SLB9E2ZpgimLv7PfgRlGhSRomdGNWOkZoaHtiYkpEOAv1BOwXmTZxaNL57d2
 8eUYBC2olD7cHAfrs0UsgqxXmdjTaKo=
From: Junjie Cao <junjie.cao@linux.dev>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add Novatek NT36532
Date: Tue,  4 Aug 2026 00:39:20 -0700
Message-ID: <20260804073920.85191-1-junjie.cao@linux.dev>
In-Reply-To: <20260804073419.84727-1-junjie.cao@linux.dev>
References: <20260804073419.84727-1-junjie.cao@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

NT36532 is a driver IC used to drive MIPI-DSI panels. It is found
in OnePlus Pad 2 tablets with CSOT panels.

Signed-off-by: Junjie Cao <junjie.cao@linux.dev>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../display/panel/novatek,nt36532.yaml        | 83 +++++++++++++++++++
 1 file changed, 83 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
new file mode 100644
index 000000000000..c1ab793dd718
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt36532.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt36532.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT36532 based DSI display Panels
+
+maintainers:
+  - Junjie Cao <junjie.cao@linux.dev>
+
+description: |
+  The NT36532 IC from Novatek is a Driver IC used to drive MIPI-DSI panels.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - csot,ppc100hb1-1
+      - const: novatek,nt36532
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA
+
+  vddio-supply:
+    description: regulator that supplies the I/O voltage
+
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - reset-gpios
+  - ports
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
+            compatible = "csot,ppc100hb1-1", "novatek,nt36532";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+
+            vddio-supply = <&vreg_l12b_1p8>;
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
+                port@1 {
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
2.43.0

