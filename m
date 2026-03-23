Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7D19F483D8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 17:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E93F710E5CB;
	Mon, 23 Mar 2026 17:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mC6Yq1N5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25DF310E5BF
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 17:08:40 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 60AB360103;
 Mon, 23 Mar 2026 17:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA4D1C2BC9E;
 Mon, 23 Mar 2026 17:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774285719;
 bh=9qexIOS+2Jxul6keX+xp+B+ZkzLLQx9RxmYp/GWG4tI=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=mC6Yq1N5NjZUEf0l5IMsBmYgiWv5uFMgmrucjQKOAPvR8mexSr18eH3LI1AOZWSdJ
 XB8++uqFKs8TTkzcOIhT0S7mbx1LjKqk4HeIH+hpBZgLQCfZe4A6Lmu2L4OfYtvoZA
 719NIPH/5DE1BBtZZGcam+WHENt9ZOoU4HpWZaT5US+JE9+5v/BUwsv/vA00EA1MFQ
 N0j9QHWZWGPXrLALZALP2i9dIYylYWeUfae8tJiQCPkGDiVB9urdDBns1nTQTSlGuc
 +hhwdzCgBgDtdEPWpoAx1SNKXF7Hv/gzXs4C9e83o+nPHcnUdj3zE2OI7TOh1tXVJK
 wT6luvKaVbMuA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id D95DEF483D7;
 Mon, 23 Mar 2026 17:08:38 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Mon, 23 Mar 2026 12:08:32 -0500
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add ChipWealth
 CH13726A AMOLED driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260323-ch13726a-v3-1-e28b6f97fe80@gmail.com>
References: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
In-Reply-To: <20260323-ch13726a-v3-0-e28b6f97fe80@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774285718; l=2207;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=m1gbP9xlX+JfXna4d2g22onWt9FebTUXJRHPr06dAlg=;
 b=sdhUJhJWlSEI9XGJDcNBWzx1JjIDC9xcG8mbZBjG7AF2ed9UZL6GJ/K+VCHYU2lY0RXU623uC
 w7QKXDdGKmSDSUhEwJ1DfHXFFJuhSuCqIAroKxEaPPOchw1Qx7V4YIC
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

The Chip Wealth Technology CH13726A AMOLED driver is a single chip
solution for MIPI-DSI. This is used for the AYN Thor bottom panel.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 .../display/panel/chipwealth,ch13726a.yaml         | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..5d964900795653401a871994bcf6403cdeaad64f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/chipwealth,ch13726a.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/chipwealth,ch13726a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Chip Wealth Technology CH13726A AMOLED driver
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
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vdd-supply: true
+  vddio-supply: true
+  vdd1v2-supply: true
+  avdd-supply: true
+
+  port: true
+  reset-gpios: true
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


