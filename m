Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857831094484
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:23:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 985DD10E23C;
	Sat, 21 Mar 2026 15:23:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="tZcszYl+";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2BE10E234
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 71B35444D4;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2B92CC2BCB0;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774106591;
 bh=RXilof1gAfb4sHzRQIGyoky1lk3TJShq5kSjMd7XO7k=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=tZcszYl+KiIh9okNdYrXuWj30/YVPrrPL6hSEPK70wR4PUDtcCJvuOY95ePJyGiIg
 W+E36Ca+KRBsaV8eTt8AdtIatPNHAxkELse55mwitf/supVK+bER4+/sZkf3gBU2Z+
 pSGIZNqdPNtOtXsA3xS2LvJrmaYN7Pi8CfR/a7z49jfP0LuwryC/7xXgrvPCfwGrS3
 LyPs5B6rHxkzopITZ1BAKMXm+Pa88dzmnJAXyEsD75B/yEH1YSH2umFsgWTxJNDvz+
 boDqai3phhj2kDC6OIQ00proPAP9TyakSt1vdxZUyUFcMQ7XrOA6hmCQLvhuBlEmDO
 SYadCaFckJXYA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 1A6E61094483;
 Sat, 21 Mar 2026 15:23:11 +0000 (UTC)
From: Cristian Cozzolino via B4 Relay
 <devnull+cristian_ci.protonmail.com@kernel.org>
Date: Sat, 21 Mar 2026 17:23:20 +0100
Subject: [PATCH v3 1/6] dt-bindings: display: panel: Add Novatek NT35532
 LCD DSI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260321-rimob-new-features-v3-1-d4b8ee867de7@protonmail.com>
References: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
In-Reply-To: <20260321-rimob-new-features-v3-0-d4b8ee867de7@protonmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Cristian Cozzolino <cristian_ci@protonmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774110230; l=2947;
 i=cristian_ci@protonmail.com; s=20250620; h=from:subject:message-id;
 bh=PxFqeuqNj1VprUSP+bqkkKxxxmFjF1RLDaIlR7HIQTQ=;
 b=GDROwhLCa2Yuk8MyHRFlLqKznRGxgpl5vmEJjBb+x4hjGX4lNF19rHqIYtWXeSCLiNLc2xSdM
 hB6ukXIVg8JC9otKWwQZIYS8PEV8aZequ/glW78KqRDnx5zUlHF7IYl
X-Developer-Key: i=cristian_ci@protonmail.com; a=ed25519;
 pk=xH5IvIPUNHV1Q8R0/pq2CfuVFR/wTiAyuyi6IwedjZY=
X-Endpoint-Received: by B4 Relay for cristian_ci@protonmail.com/20250620
 with auth_id=438
X-Original-From: Cristian Cozzolino <cristian_ci@protonmail.com>
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
Reply-To: cristian_ci@protonmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Cristian Cozzolino <cristian_ci@protonmail.com>

Document Novatek NT35532-based DSI display panel.

Signed-off-by: Cristian Cozzolino <cristian_ci@protonmail.com>
---
 .../bindings/display/panel/novatek,nt35532.yaml    | 77 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
new file mode 100644
index 000000000000..c7928553681a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt35532.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT35532-based DSI display panels
+
+maintainers:
+  - Cristian Cozzolino <cristian_ci@protonmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: novatek,nt35532
+
+  reg:
+    maxItems: 1
+
+  backlight: true
+  reset-gpios: true
+
+  avdd-supply:
+    description: positive boost supply regulator
+
+  avee-supply:
+    description: negative boost supply regulator
+
+  vci-supply:
+    description: regulator that supplies the analog voltage
+
+  vddam-supply:
+    description: power supply for MIPI interface
+
+  vddi-supply:
+    description: regulator that supplies the I/O voltage
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddi-supply
+  - port
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
+            compatible = "novatek,nt35532";
+            reg = <0>;
+
+            backlight = <&pmi8950_wled>;
+            reset-gpios = <&tlmm 61 GPIO_ACTIVE_LOW>;
+            avdd-supply = <&lab>;
+            avee-supply = <&ibb>;
+            vci-supply = <&pm8953_l17>;
+            vddi-supply = <&pm8953_l6>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a626dee5c106..8ed2866bbd6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8171,6 +8171,11 @@ T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/novatek,nt35510.yaml
 F:	drivers/gpu/drm/panel/panel-novatek-nt35510.c
 
+DRM DRIVER FOR NOVATEK NT35532 PANELS
+M:	Cristian Cozzolino <cristian_ci@protonmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/novatek,nt35532.yaml
+
 DRM DRIVER FOR NOVATEK NT35560 PANELS
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained

-- 
2.53.0


