Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCC60A5BC7
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABTcK5PE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8610410E980;
	Mon, 16 Nov 2026 07:40:20 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5955F10E7AD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 362C445ED5;
 Mon, 16 Nov 2026 07:40:14 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794814814;
 b=YoXBuFHPFW8iTe45MvhRr5ADJE1j9KSTALQamE+Y4QqcpXS58SL03yznWLlVoaYiaoAn
 OIL38iBxaUJbrqyMNA0R4zQkcI5mYQ17Oyc+n6pcH3uF+jSjcq4S9+4C8CFfB2+C4L+48
 z0qqrLEWGyqvN4u9t1xmxGesM0TpSt9pa7zcha9TxZtsfSsSLPQtEAybdSqTxZrhZt/B9
 97+uQIJ7ALiIRpTud/kF3bN+GNT/k9sMnjytWqW8nziqG0nho6Yw1seL1jRBtap8yLdCc
 vkO90lIlkxDyu7++4wnorEBJw6IIpWmWj9yXm3FicRKzucde4XTh14vcop4qeTLSPfw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794814814;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=mb9rHos8tHcP6+kunMSZSY6J85Jw9A8LptIrsB7iGLc=;
 b=exTiH+0KWblyQ9ZZh+CVrO2u0ADkzIDizKTN2zz+Pvd/13MBa33g3muJ1akXLP6p09a7
 UR3qGfcrwp5dQvL4WkkEWSknNM1M+FjUF3XVMrNUnUgbFzafB4yelXtlLSk9n8OLd6rWv
 INheIUzBhNRwJsQMEaLg1xOSUc4bNhaz18U267AZYjbYKIRYUJYEB4yOCXysbfd0WriWx
 16vHx03PF1MIycOLdzF20yq0E9Si6j45YoxmmeHSETcSHcMQ+++AZz/BFtp9iEEORFIk/
 o/ui4KDFGfTKKoxRCnJ5p1GLfNjH9K4BuLxUoLGplmyW3jcuCPhn6r5yfPa7jI0H4YQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 624501F002C2;
 Mon, 16 Nov 2026 07:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794814814;
 bh=mb9rHos8tHcP6+kunMSZSY6J85Jw9A8LptIrsB7iGLc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=ABTcK5PEz1PaM6P2sfNE+f27Wcmt5wNqyMidRbSLibr5pzsfhM7f0TDCyVHLO9DOM
 dQ0XcfQGrsVB7VA1hjiswK1q4gafXHFH2FV3wibnSMAA4c0PEjUjJ1PRUg/2c6IF9/
 OM4k/5VR1g6IFYd2WZvnEg7NDWgPMhDPNhd313dB8znce+bqij5zZ3/O4p3t/eAr41
 kx2xTHxm4Tm+DfuMhlJlTJb3ghi7gQfqC+0S3JpatyCovCHJ7bAmINz+Hee3o+Enj4
 K6UpEbY50+kq68Rc6/YN2uzy6d4+HnNW2JaCvYpg4uGTGODl8/q1+TZJwOqI8RYI1+
 wXpbW2XE3cOMQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id E70BB4A3AD;
 Mon, 16 Nov 2026 07:40:12 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 13:10:12 +0530
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Add Ilitek ILI97680A
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-vantage-panel-v2-1-e2ab48645e2c@yahoo.com>
References: <20261116-vantage-panel-v2-0-e2ab48645e2c@yahoo.com>
In-Reply-To: <20261116-vantage-panel-v2-0-e2ab48645e2c@yahoo.com>
To: Venkat Yadlapati <venkat.yadlapati@yahoo.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794814811; l=3218;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=/i7bQzzWSOyoUoPNVeSXBs8XdBsv/giMTK78lHZdqTw=;
 b=YxkREBkmEyYZm6u8PpmMZDOLQ7R9WsxC1tLrmerVmm38oeacUVq0/I9pekUa+qgt6iUDeQOeT
 lfipp6EyC5dAE2kG+H3o9obOuIwGkk3nOo/lEvT14OttX0WMBs6EvkZ
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

Document the Ilitek ILI97680A based 1264x2780 AMOLED panel by BOE, a
MIPI DSI command mode panel with DSC 1.2 compression found in the
Motorola Signature.

An LLM was used to help write this commit message.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 .../bindings/display/panel/ilitek,ili97680a.yaml   | 75 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 81 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
new file mode 100644
index 000000000000..c098b44fef3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili97680a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI97680A based AMOLED DSI command mode panel
+
+maintainers:
+  - Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+
+description:
+  AMOLED panels driven by an Ilitek ILI97680A controller over MIPI DSI in
+  command mode with DSC 1.2 compression. The resolution, DSC settings and
+  initialization sequence depend on the panel, so each panel has its own
+  compatible with the controller as fallback.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          # 1264x2780 BOE panel of the Motorola Signature (vantage)
+          - motorola,vantage-boe-ili97680a
+      - const: ilitek,ili97680a
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  vci-supply: true
+  vdd-supply: true
+  vddio-supply: true
+  port: true
+  reset-gpios: true
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - vdd-supply
+  - vddio-supply
+  - port
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
+            compatible = "motorola,vantage-boe-ili97680a", "ilitek,ili97680a";
+            reg = <0>;
+
+            vci-supply = <&vreg_l13b_3p1>;
+            vdd-supply = <&vreg_l11b_1p2>;
+            vddio-supply = <&vreg_l10b_1p8>;
+
+            reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&mdss_dsi1_out>;
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c4f4e48774d0..e2a8093c328a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13040,6 +13040,12 @@ M:	Stanislaw Gruszka <stf_xl@wp.pl>
 S:	Maintained
 F:	drivers/usb/atm/ueagle-atm.c
 
+ILITEK ILI97680A PANEL DRIVER
+M:	Venkat Yadlapati <venkat.yadlapati@yahoo.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/ilitek,ili97680a.yaml
+F:	drivers/gpu/drm/panel/panel-ilitek-ili97680a.c
+
 IMAGIS TOUCHSCREEN DRIVER
 M:	Markuss Broks <markuss.broks@gmail.com>
 S:	Maintained

-- 
2.56.1


