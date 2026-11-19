Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF00606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 19:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJnsEKzT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D7210F0DA;
	Thu, 19 Nov 2026 19:01:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B02E210F0DA
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 19:01:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9225843B1E;
 Thu, 19 Nov 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795114877;
 b=HzTR0zaAd8pqVm0hfpxcIqblupogJddEuk6pB2+mLwgQg024eZXGcBGi3wVCP/oEHOc9
 Be0JWpVC0wourCy9FZHq2+rYKhud0rSkcwtqhNFtJcsgwph7w1IAzHqXh7yKORgcQy3qp
 X5Y/2YIp4uLfmOH7D83uOZ2LiaUeY7pFv9ZPDdQE4ZPG4L+Msn8nHXHGq7bJ5oYux6IpE
 mPvHuRUVIW02EiDHmaDz8Fda126yadsCtUgI9a+6J3lmH70tkYUE+etAAh9jOddm4pQOd
 FeauRjIAz4iC6BmxOCL7Lno24sAVu+Y/pSQOsMbVQTSf9IgDUNnguPa7LKhaRFJpJVw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795114877;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=tTw2kFuvywgIUR4xINRvQyeh53+KN4qnrt55NrFhdow=;
 b=BK5ekFzwWJwwJIyj45LnIWHFNtMLgfGQIp8K8NrGEbVlCSPXAEFsjAdzUuKZlK5Ijcgr
 qz0Ss5JRtcwbmwUEfnHhSGRwOAcSJMbkurgqJCOS+dJolUZv9Jg/Zjkp21cm1fCZ0wHa+
 NoZH8iiFPBK7RZZwf7d6ZBVPhoEnA5BNsZmTBVcO2Z4TdnnrP3X3VcP/uTf7F3ojS7Bql
 adOJvGaSyiQ9ulNXndyexCnv+jLL4aXifqPr/dCQs1sWTdnTTdjZo4U2NffWwO44Y8rSR
 sNCvZCUoRky5hwSiQpOox3Cr/twyGNcVfGGp80PZwpZ9rBW6AdneJmdNAMzDrn7wlsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 59D041F000C6;
 Thu, 19 Nov 2026 19:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795114877;
 bh=tTw2kFuvywgIUR4xINRvQyeh53+KN4qnrt55NrFhdow=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=AJnsEKzTAX3bf/AlANUJ1aKaaF2IAaCuVlKMRXRsWoQW7a8sSQwvzMS0h2SCJjcWF
 RF9L/ABQeHmc99rAr2ciFOUqtfN7pQMRjUQL7aU501vH1bXhUhGkcOsH4g/edufyyB
 HHHEaDu0nmj1Cq7GlgpkB6lPvzrLuB6cADVGKmE0DGKFLay+huqsXNi72mifMYurbA
 dQjJs/h6PGs9NBBMZYGkIF1o3PxvBTEkjnr6ZaXM2KqlwvVpmZ2YaAEkl5IkVrDita
 xuVpyymipi51/ifLNPj/OPGkV63lVhbR7ilYaVL53ATYqvRF9uvdFRPO9jUWwrYrh5
 lc8RNulx6TwSQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id C92EE4B3E2;
 Thu, 19 Nov 2026 19:01:15 +0000 (UTC)
From: Nizat Mikayilli via B4 Relay <devnull+nacht.dxdmail.cc@kernel.org>
Date: Thu, 19 Nov 2026 20:01:13 +0100
Subject: [PATCH v2 2/3] dt-bindings: display: panel: Document Anapass
 ANA38407 DDIC
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261119-b4-ana38407-v2-2-bddc251bd43f@dxdmail.cc>
References: <20261119-b4-ana38407-v2-0-bddc251bd43f@dxdmail.cc>
In-Reply-To: <20261119-b4-ana38407-v2-0-bddc251bd43f@dxdmail.cc>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, Nizat Mikayilli <nacht@dxdmail.cc>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795114874; l=2686;
 i=nacht@dxdmail.cc; s=20261004; h=from:subject:message-id;
 bh=Vc7GWKoAIzq9GzojXTrkIbSyMezk2qqPaz6Iw8WRLJ8=;
 b=xHnINgjLttYaOs9C8YL4X/4dczu+rpVXzgyplRavOTclyKCbFSR4u8pcDPtFnZuLx6XrNO13l
 8CP7GyZDOGLBs10uywhjJib4SmKsSxq1EcppmOOLvFaGHVKR5gNq7Yj
X-Developer-Key: i=nacht@dxdmail.cc; a=ed25519;
 pk=Kay3P3pOJq5klUD+0/I8QX8JGOh0CeQXEwRVv7CMm4k=
X-Endpoint-Received: by B4 Relay for nacht@dxdmail.cc/20261004 with
 auth_id=1111
X-Original-From: Nizat Mikayilli <nacht@dxdmail.cc>
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
Reply-To: nacht@dxdmail.cc
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nizat Mikayilli <nacht@dxdmail.cc>

Document the Anapass ANA38407 DDIC and the Samsung AMSA10FA01 panel
found in the Samsung Galaxy Tab S9 Wi-Fi.

Signed-off-by: Nizat Mikayilli <nacht@dxdmail.cc>
---
 .../bindings/display/panel/anapass,ana38407.yaml   | 68 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 73 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/anapass,ana38407.yaml b/Documentation/devicetree/bindings/display/panel/anapass,ana38407.yaml
new file mode 100644
index 000000000000..7811ea355026
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/anapass,ana38407.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/anapass,ana38407.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Anapass ANA38407 based MIPI-DSI panels
+
+maintainers:
+  - Nizat Mikayilli <nacht@dxdmail.cc>
+
+description:
+  The Anapass ANA38407 is a DSI panel controller used to drive AMOLED
+  panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - samsung,amsa10fa01
+      - const: anapass,ana38407
+
+  reg:
+    maxItems: 1
+
+  vci-supply:
+    description: Analog voltage rail
+
+  vddio-supply:
+    description: I/O voltage rail
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - vddio-supply
+  - reset-gpios
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
+            compatible = "samsung,amsa10fa01", "anapass,ana38407";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 125 GPIO_ACTIVE_LOW>;
+            vci-supply = <&panel_vci>;
+            vddio-supply = <&vreg_l12b_1p8>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 93abbb315065..e282fbb04e6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8228,6 +8228,11 @@ S:	Supported
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/sun4i/sun8i*
 
+DRM DRIVER FOR ANAPASS ANA38407 PANELS
+M:	Nizat Mikayilli <nacht@dxdmail.cc>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/anapass,ana38407.yaml
+
 DRM DRIVER FOR APPLE TOUCH BARS
 M:	Aun-Ali Zaidi <admin@kodeit.net>
 M:	Aditya Garg <aditya.garg@linux.dev>

-- 
2.56.1


