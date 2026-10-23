Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A194F606A321
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ExuxVVwF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D470A1129EB;
	Fri, 23 Oct 2026 08:21:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2796C1129EB
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:21:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EE5C043CD5;
 Fri, 23 Oct 2026 08:21:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792743681;
 b=gJwwxr/JTV5SsavDMzmYJGEKhGdTl4Uft/t7iRcZUAQde+1GwCwuij78G+QK/kbQHZ0V
 oFAYrcfZicCE18m4590H3NxPB+1o0E3FeqheRBpS25/ZBKZ9ZRVCIGnOXyscZc4+hLT3y
 UOM95IX4iwuyuhWbunwEGE3yhfaXhvuJJOh8doEquL4TQ6TJRr9bV7WytYPfa5XnXrDMK
 Nl3/Xh6+yvXaOCNwVDpaemHqICUT3IVTpeBQWVP4JqMUehWPBaRnN+3bc2CtqOYNf8tnx
 okMs5CLwXb9h9Vi0Z6AS7HyVimKSl4L5ZEYmmjRoJ7sCqOSNmS9UNuDPVz0io3JrGXg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792743681;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=9Ep0HE79/a9+3p5ZBtG4xFmSDb6r9PHiQif27zyrmII=;
 b=eb8RK/VM9yPik9gWpGFLUxBNgidplRKl0wF0M7/D0J6bFil0w3T0bB1Mv92YXFAH1Ikm
 HFXCu0y4wKdFrZGV8LN1XgWqSUoAwFO+6vJBquBgzEiwgkPu0RiSvamk2QCOvJLuzrUU5
 ex+bYQF07x485UDlVkPMUAcvT3dCAFsVrHaTweks/NpMH3qJp/GIKps8vypsF0h4VohRC
 05cjWZgQTI34g6XoWEtce3d/4p6Lf8ms/mZCnlVGUBiPaqKnr50ajnOEJXLvY5hMDrFzC
 ooHaFIGKlgZ6qyPAhhHRtb4oIp67Ht24CZynzfAC7Kreq2MOgt3/kijhj0L4Yp1qe0w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 3B2EF1F01829;
 Fri, 23 Oct 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792743681;
 bh=9Ep0HE79/a9+3p5ZBtG4xFmSDb6r9PHiQif27zyrmII=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ExuxVVwF2Is5feRimIBYjpSQnBydP3to/Y5x7TD5Aw1TuUq7KwKVagrp5VP8PW0YQ
 KZ2/rfod8F/b+lP8oJJPZEruDgZmbXFDsHZ5HUQFL7kexE22471VsdX1Q7TZRCylrJ
 5E02WN9P6xSE3Qp9FwVJp6t5l5rP9kHemyGsprbmseG9QEJMel0wp/uuBCUmKjFv+V
 oU8ItOCwWq5m/IEn8DQW/BI9d9CjBIXnNV6d4JXkcGhmi9yGuxVLWd5+eu5Qhv4QgG
 aAyuICgeoXSUjY7yxDnHt76fldz3htPvL2plqiEb/Mn3GfGGCKcTYeDCFiEjM+QCUR
 MJZOq+/U73JdQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C1B2144423;
 Fri, 23 Oct 2026 08:21:20 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 13:51:16 +0530
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS644VK04
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-panel-ams644vk04-v1-1-56096aecd0ff@brar.si>
References: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
In-Reply-To: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743679; l=3095;
 i=patches@brar.si; h=from:subject:message-id;
 bh=Tt1XsfnXS440HSGg/wswJNMW2cDPJCmbAVKWWsAuN2g=;
 b=o0Gqznn8TvZqQCsIDRMLvYNrNIirR2xp0Z7BhozECpMPgRKrnmjJvRoqtN1rcSdC1jdxyP7SP
 qe0ujG2FtpoBZOi6xSIfYl3P68RNeLyvT9XrpDjis+we2UuJLFYn+K0
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Document the Samsung AMS644VK04, a 6.44 inch 1080x2400 MIPI DSI command
mode AMOLED panel with DSC that supports 60 Hz and 90 Hz. It is used in
the OnePlus Nord (SM7250). The panel is powered by three supplies and
has a reset GPIO.

Signed-off-by: Ishu Brar <patches@brar.si>
---
 .../bindings/display/panel/samsung,ams644vk04.yaml | 76 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
new file mode 100644
index 000000000..50f8c516b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ams644vk04.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS644VK04 1080x2400 MIPI-DSI Panel
+
+maintainers:
+  - Ishu Brar <patches@brar.si>
+
+description:
+  The Samsung AMS644VK04 is a 6.44 inch 1080x2400 MIPI-DSI command mode AMOLED
+  panel with DSC, supporting 60 Hz and 90 Hz refresh rates. It is used in the
+  OnePlus Nord.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ams644vk04
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail (1.8 V)
+
+  vdd-supply:
+    description: Panel logic voltage rail (3.0 V)
+
+  vout-supply:
+    description: Panel supply rail (1.28 V)
+
+  reset-gpios: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - vdd-supply
+  - vout-supply
+  - reset-gpios
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
+            compatible = "samsung,ams644vk04";
+            reg = <0>;
+
+            vddio-supply = <&vreg_l13a_1p8>;
+            vdd-supply = <&vreg_l18a_3p0>;
+            vout-supply = <&vreg_l7a_1p28>;
+
+            reset-gpios = <&pm8150l_gpios 3 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index a08087fb6..1eec53b0e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8462,6 +8462,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
 F:	drivers/gpu/drm/panel/panel-raydium-rm69220.c
 
+DRM DRIVER FOR SAMSUNG AMS644VK04 PANEL
+M:	Ishu Brar <patches@brar.si>
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
+
 DRM DRIVER FOR SAMSUNG DB7430 PANELS
 M:	Linus Walleij <linusw@kernel.org>
 S:	Maintained

-- 
2.56.0


