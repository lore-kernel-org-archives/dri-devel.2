Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0F6606A321
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rwUtMXfD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D0510E4CD;
	Wed, 25 Nov 2026 08:41:20 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 566C110F02D
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:18:31 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb68c197c7so62997805e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795547910; x=1796152710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5SuSwraB3A2rJ+eef524bz9/G9zBRh88zfM0uLgHn3k=;
 b=rwUtMXfDBACAcHEbvim+50XPEGNJQHDhfGxcvA9ga7dUTepQvZO9fHirBqUlMsk6G+
 vCkfSl0lwXQzziFxPHRfX997eRCmRbJz4ee/hfQlHK8ElJr7UcQ3y675WP59URjFJ4Pt
 3f+TVr9vo+L4S0xETJ7pIo7MfhcJPLNhSZKYCIX0QTXnxnzHWamqo5IbQptrz1vmhKIq
 eBBQKUhN1GtERLyKBbZr4YNljV/sez5HwSApHNrk1KW7iyGwJjzbDCeniV7wNVd8eOmm
 X93mFd+q4e6qi2hJrc/ddITHKEWZKpn/i/j1Pt06GhLeYamsK0SEqIgQN4Ynwb7LAZgc
 wB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547910; x=1796152710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=5SuSwraB3A2rJ+eef524bz9/G9zBRh88zfM0uLgHn3k=;
 b=SGXV1ghO5QzTKqeiurGiqlUx8rKbJEynj07pADeDiwXJeN2JZsmCPKsYoGedVLyz3z
 bdk2+6vxfdxhzFDv6IrhS4mBAo/yEnVDTV3bUoKpJQWRkbp7JjW193yvhb3bDg3qZU84
 Pv50ABkduY8sWh1Up94gjhlrIxg6uOukKPz01UQeQTBU/gsJ5/vY5XU1VFKBs8tsM7Th
 BoFAnisvcF7bWo1c/+eUrMv7NdZE0EyyNARW6sMFTH8PlKb5WyRmAkgmj1cz8mkNto9Y
 a6LpSnEoZuARx1cGXu2nOPQynfjovfrlrv11tpZ1MtgchuKcK7BU+AEvKC5kYDiYB34i
 Iriw==
X-Gm-Message-State: APuU4Z8ywOKs4C2iAz6UT0NJgTmbEowLvs5ofpjJSyiuZRB9RAXVzsTs
 jZ2AlUnN23SmrxXrKUi7uNDABvWi4iW1F2y+OPKet7XKtr1EA3QEnf4=
X-Gm-Gg: AZFdTZdHIBN1I5r2u4h1bx8S/y9l2u4Y5FhBIbqcGjYUZKPuxqIhvv6ApD19oQboctK
 DajWqRYC5P63re3yK9qXGm030vFLXTpUtlxw7ufm2Sy8fhX9K9vHWZ2jIru8AqWvxxm/FhF9klr
 kcPihqHa8Ha1Mz227+QM+xxHsqn7ItEh81Szfwu8pEDXkX7TiRoSlQ1T3ISAG6WlXeCBOQkvcS1
 nhcyD0Z2f9Nx4qDW4Ekh25kv0dPi77o+GRkwEvGokj1ZkXzQoitVM/schDsZCVo0PeIs2SpBFKm
 EYniJj0708Z6+ATPdLIaSuRi9LdxTJC9lrXdKYsnyA8l0byaa3uysVLpgg0vHwSlWQAkdnGhnhR
 LEm+7LsK8DaFWlqrjlZWVwHc80HbWUvlpt7YHghETNNI1sY+uKfAsA/bHEReO7Pr3hHQ/iqQsGZ
 CDXYAo5wFKz3as87bMt8w6BJfUGmo1a3kSCh+o/8quCM8BUAYaYpyvrVBUVv7I7pl5tekiynBfN
 iVqoPO3EZf93axB/cfjzoB8aa2369gp1mUY2KgcAkopiyoVCJDIMZS5Sm66akOJeIgcLUuVV/Md
 cSTnafzX1V6ZnuCWqF4cGzO+3DNcphGtYP1Y8iIYRFdHSuYJVrJot1sXvLy73CTjHBQiqO5/1KU
 =
X-Received: by 2002:a05:600c:1d09:b0:4bb:6fd3:5ac0 with SMTP id
 5b1f17b1804b1-4bb88816c7emr344773725e9.28.1795547909651; 
 Tue, 24 Nov 2026 11:18:29 -0800 (PST)
Received: from localhost.localdomain ([93.145.31.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm463320985e9.15.2026.11.24.11.18.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:18:29 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: bridge: Add Lontium LT9721 HDMI to
 eDP bridge
Date: Tue, 24 Nov 2026 20:18:02 +0100
Message-Id: <20261124191803.283266-2-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
References: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document the Lontium LT9721 HDMI 1.4 to 1/2/4-lane eDP 1.4 bridge
device tree binding, including power supplies, reset GPIO, OF graph
input/output endpoints with lane/polarity remapping, and the DP AUX bus.

Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 .../display/bridge/lontium,lt9721.yaml        | 169 ++++++++++++++++++
 MAINTAINERS                                   |   7 +
 2 files changed, 176 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml
new file mode 100644
index 0000000000000..88c5c75c0d49c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml
@@ -0,0 +1,169 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/lontium,lt9721.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Lontium LT9721 HDMI 1.4 to eDP 1.4 Bridge
+
+maintainers:
+  - Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
+
+description:
+  The Lontium LT9721 is a bridge device that converts an HDMI 1.4 input
+  (up to 3.4 Gbps/lane) to a 1-, 2-, or 4-lane eDP 1.4 output (1.62 Gbps
+  RBR or 2.7 Gbps HBR per lane), controlled over I2C.
+
+properties:
+  compatible:
+    const: lontium,lt9721
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low GPIO connected to the RST_N pin.
+
+  vcc-supply:
+    description: Regulator for 3.3V analog and I/O power (VCC33_RX, VCC33_TX).
+
+  vdd-supply:
+    description: Regulator for 1.8V analog and core power (VCC18_RX, VCC18_TX, VDD).
+
+  aux-bus:
+    $ref: /schemas/display/dp-aux-bus.yaml#
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: HDMI 1.4 input port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              lane-polarities:
+                minItems: 4
+                maxItems: 4
+                items:
+                  enum: [0, 1]
+                description:
+                  TMDS pair P/N polarity inversion for clock and data lanes.
+                  The LT9721 applies P/N inversion globally across all four
+                  TMDS pairs, so all entries must match.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: eDP 1.4 output port.
+
+        properties:
+          endpoint:
+            $ref: /schemas/media/video-interfaces.yaml#
+            unevaluatedProperties: false
+
+            properties:
+              data-lanes:
+                oneOf:
+                  - minItems: 1
+                    maxItems: 1
+                    items:
+                      enum: [0, 1, 2, 3]
+                  - minItems: 2
+                    maxItems: 2
+                    uniqueItems: true
+                    items:
+                      enum: [0, 1, 2, 3]
+                  - minItems: 4
+                    maxItems: 4
+                    uniqueItems: true
+                    items:
+                      enum: [0, 1, 2, 3]
+
+              lane-polarities:
+                minItems: 1
+                maxItems: 4
+                items:
+                  enum: [0, 1]
+
+            dependencies:
+              lane-polarities: [data-lanes]
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vdd-supply
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        bridge@33 {
+            compatible = "lontium,lt9721";
+            reg = <0x33>;
+            reset-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
+            vcc-supply = <&reg_3v3>;
+            vdd-supply = <&reg_1v8>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    lt9721_in: endpoint {
+                        remote-endpoint = <&hdmi_out>;
+                        lane-polarities = <1 1 1 1>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    lt9721_out: endpoint {
+                        remote-endpoint = <&edp_panel_in>;
+                        data-lanes = <0 1>;
+                    };
+                };
+            };
+
+            aux-bus {
+                panel {
+                    compatible = "edp-panel";
+                    power-supply = <&reg_panel_3v3>;
+                    backlight = <&backlight>;
+                    no-hpd;
+
+                    port {
+                        edp_panel_in: endpoint {
+                            remote-endpoint = <&lt9721_out>;
+                        };
+                    };
+                };
+            };
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c00d3612c9acf..707cd862d4fc4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15790,6 +15790,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.yaml
 F:	drivers/gpu/drm/bridge/lontium-lt8912b.c
 
+LONTIUM LT9721 HDMI TO EDP BRIDGE
+M:	Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
+L:	dri-devel@lists.freedesktop.org
+S:	Maintained
+T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
+F:	Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml
+
 LOONGARCH
 M:	Huacai Chen <chenhuacai@kernel.org>
 R:	WANG Xuerui <kernel@xen0n.name>
-- 
2.25.1

