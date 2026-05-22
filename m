Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AED83CD5BAB
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 01:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E217610E645;
	Fri, 22 May 2026 01:57:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="LKwmOWhs";
	dkim-atps=neutral
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com
 [115.124.28.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4797710E21B
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 01:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1779415061; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=eVZn7MAONGMHowrlbF8Q4henpwp8Ya3lVGmR/icgdNU=;
 b=LKwmOWhsoeBIOZSrY+w0yj0DOMEWRHx0kdm9WDHhio6GUb7tlo8kkf+1U7uSXcXy1nisLylZTcSqpmjGMoT4N+EzwVEZ5gmCmgkiUrZQnraqv/L+zdESuA0f5OFgIMYXbFq+ZbL6hG1bAuanm31lQJKULULNPoYEStocRQ5cJdXTKjVTRrVLMvu0YHhLhHe73pKUc1HFez2keWF/asN8XgirmC3qYgIcImFjSWyQ1aF9w8f3B2DLjjvSMLOtMSmnqHiqULD2bsOhBnryroIYA/R27A4xaufizrGbxphtv+rRCw9VgLOPvTQcda2zVClUMULsj1hQoXP00SXhhjkG0A==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.0852786|-1;
 BR=01201311R181S36ruler364_34042_170522; CH=green; DM=|CONTINUE|false|;
 DS=SPAM|spam_ad|0.867174-0.00121929-0.131607;
 FP=12538499638350538162|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033032053168; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=24; RT=24; SR=0; TI=SMTPD_---.hdTsrrJ_1779415059; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hdTsrrJ_1779415059 cluster:ay29) by smtp.aliyun-inc.com;
 Fri, 22 May 2026 09:57:40 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com, rlyu@lontium.com,
 xbpeng@lontium.com, qdchen@lontium.com, llzhang@lontium.com,
 Sunyun Yang <syyang@lontium.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v11 1/2] dt-bindings: bridge: Add Lontium LT7911EXC eDP to
 MIPI DSI bridge
Date: Fri, 22 May 2026 09:57:34 +0800
Message-Id: <20260522015735.2833-2-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260522015735.2833-1-syyang@lontium.com>
References: <20260522015735.2833-1-syyang@lontium.com>
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

From: Sunyun Yang <syyang@lontium.com>

This commit adds the device tree binding schema for the Lontium LT7911EXC.
This device is an I2C-controlled bridge that converts eDP 1.4 input to MIPI
DSI output.

Signed-off-by: Sunyun Yang <syyang@lontium.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../display/bridge/lontium,lt7911exc.yaml     | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
new file mode 100644
index 000000000000..3290b10ce883
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
@@ -0,0 +1,89 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911exc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT7911EXC eDP to MIPI DSI Bridge
+
+maintainers:
+  - Sunyun Yang <syyang@lontium.com>
+
+properties:
+  compatible:
+    enum:
+      - lontium,lt7911exc
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO connected to RST_ pin.
+
+  vdd-supply:
+    description: Regulator for 1.2V MIPI phy power.
+
+  vcc-supply:
+    description: Regulator for 3.3V IO power.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for eDP input.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for MIPI DSI output.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vdd-supply
+  - vcc-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        mipi-bridge@41 {
+            compatible = "lontium,lt7911exc";
+            reg = <0x41>;
+            reset-gpios = <&gpy8 8 GPIO_ACTIVE_LOW>;
+            vdd-supply = <&lt7911exc_1v2>;
+            vcc-supply = <&lt7911exc_3v3>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    bridge_in: endpoint {
+                        remote-endpoint = <&edp_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    bridge_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1

