Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6633DFB5EBE
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 05:23:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F7910E48D;
	Tue, 17 Mar 2026 05:23:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W9glFbx1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4C710E21B
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 05:23:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B019944069;
 Tue, 17 Mar 2026 05:23:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 758FBC2BC86;
 Tue, 17 Mar 2026 05:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773725021;
 bh=FK+G92G7k2Ab54zT1nugqRs23c6TUh6PpjiXtF3RnE0=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=W9glFbx1VnMxAlsipfZ3lz1WUR5jLFfbsfjbqc2oXsnEVdGP4j+g/e0Y7LtY8Li6l
 4gyPcggfiXoTCIBLRRS66R4i+bmEtAVDn8oBgZg+BP8cvPcEwnh2oMIYR04D5wZd0X
 ILuaHLVdpH94dxknjJN4gMKfianJYPnAIn8TDQ/7O60JvZEdgC44RVI55MZnAjbaED
 Lcbh4flXghvTKgNEluxA6ejKaPxjyqSASI9t+tTqd//C9AwxabebYx/jvtS5glqwGM
 rolCkJYPuQ6KkPGFKE15eBfrD0RTNGPTBLJJE9DIKVTxKQFpSucBHUh+1AFb4ProYc
 0ZIH3KMo4P+EQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 6522BFB5EBE;
 Tue, 17 Mar 2026 05:23:41 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Tue, 17 Mar 2026 00:23:07 -0500
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver bindings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260317-ch13726a-v2-1-28aa46bcd6d0@gmail.com>
References: <20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com>
In-Reply-To: <20260317-ch13726a-v2-0-28aa46bcd6d0@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Teguh Sobirin <teguh@sobir.in>, 
 Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773725020; l=2226;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=HoyWD2jkf4xCy515SWrSieQpbdHFlSZWlbu93PkDP+k=;
 b=Ur1UZGhaW1sGDhqg46w1R+Cv9Bprvmajepyw7Z9GScijq3EKRNK3P+1Vopt4trvgpMHwhFhom
 g4jI3ADdPaEDeB8ADtxQ70DqiQ7vS9ksx25F9KpsacZ/sTm7d5O4cbf
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
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
Reply-To: webgeek1234@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Aaron Kling <webgeek1234@gmail.com>

The Chip Wealth Technology CH13726A display driver is a single chip
solution for AMOLED using MIPI-DSI. This is used for the AYN Thor bottom
panel.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../display/panel/chipwealth,ch13726a.yaml         | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..b490c6757bb98c0752ded78b8fea3aaec853c7b2
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chip Wealth Technology CH13726A display driver
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  Chip Wealth Technology CH13726A is a single-chip solution
+  for AMOLED connected using a MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: ayntec,thor-panel-bottom
+
+  port: true
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vdd-supply: true
+  vddio-supply: true
+  vdd1v2-supply: true
+  avdd-supply: true
+
+  reset-gpios: true
+
+  rotation: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - vdd1v2-supply
+  - avdd-supply
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
+        panel@0 {
+            compatible = "ayntec,thor-panel-bottom";
+            reg = <0>;
+            vdd1v2-supply = <&vreg_l11b_1p2>;
+            vddio-supply = <&vdd_disp_1v8>;
+            vdd-supply = <&vreg_l13b_3p0>;
+            avdd-supply = <&vdd_disp2_2v8>;
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_HIGH>;
+        };
+    };
+
+...

-- 
2.53.0


