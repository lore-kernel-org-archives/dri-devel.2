Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE39EF327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:09:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2452810E809;
	Tue, 21 Apr 2026 07:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="fRrrdz/L";
	dkim-atps=neutral
Received: from out28-74.mail.aliyun.com (out28-74.mail.aliyun.com
 [115.124.28.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E86810E10C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1776652747; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=0F0EvAAE+CnWiQhcCA0mRZ4UGdtN6zmfX1qElHsMKOY=;
 b=fRrrdz/L8LVpz7q9pwO9KLgpqGsFYsHr7WsPmM7UuWfS2fokPbCKThjOvxiKnIH+nhv7ZDPCAL1BntIha8cNAF8vpOstzXWh0tgXF9RUEsKFEvxlnd9Zds2exWYSIMJPKTsX4YqyQD7z2+ET5m90f4zaox/hgzKO7V1QTFuRzJFQgB0hYDZnf33oDWmdioao6P+/8xJAixZOK+wFflQmYNafGIDg8C0JsxyQtj1mqhrpjfua0bcKw7nbRufCGk1hmHjlUGrmMETVhAfL2qwPCR0jRjNtDQ8jVydqOIaKB19kwyvwzHKPNJacgTmDB/KWX+Ur1mbGTCbpqsCDk4rY+g==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07761437|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.0631755-0.000267913-0.936557;
 FP=12538500463005234610|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033032023038; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=19; RT=19; SR=0; TI=SMTPD_---.hFmvE2f_1776652441; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hFmvE2f_1776652441 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 20 Apr 2026 10:34:04 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH 1/2] dt-bindings:bridge Add LT7911EXC binding
Date: Mon, 20 Apr 2026 10:33:53 +0800
Message-Id: <20260420023354.1192642-2-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420023354.1192642-1-syyang@lontium.com>
References: <20260420023354.1192642-1-syyang@lontium.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

-binding for lt7911exc.

Signed-off-by: Sunyun Yang <syyang@lontium.com>
---
 .../display/bridge/lontium,lt7911exc.yaml     | 91 +++++++++++++++++++
 1 file changed, 91 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
new file mode 100644
index 000000000000..54a73d41635a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
@@ -0,0 +1,91 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt7911exc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT7911EXC eDP to MIPI Bridge
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
+        description: Video port for mipi dsi output.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for eDP input.
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
+            reset-gpios = <&gpy8 8 GPIO_ACTIVE_HIGH>;
+            vdd-supply = <&lt7911exc_1v2>;
+            vcc-supply = <&lt7911exc_3v3>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_in: endpoint {
+                        remote-endpoint = <&edp_out>;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1

