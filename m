Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73462606A32A
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bFxcZb6w
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80BBE10E460;
	Sun, 22 Nov 2026 08:19:32 +0000 (UTC)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E9B510E4B0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:19:15 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-6ba12b00c76so2306945a12.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335554; x=1795940354; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1z7RmYK1NjDMEO9+xJDI+w73bgLEkLKZ4jmIOyAvUDw=;
 b=bFxcZb6wNcPn/ovVYBAEai5A/06o8brVeKWrZBK0NuDdDp10WVd8xTUskkW9x3yWsn
 A5QFtQI692NuULaNRfbDvgHvN2xujGNGHbKBNLJbmpEGfhAfI+J53X3Sl7Bc9FX1CbfA
 EbQfivLn9o3HdXmWNpTMxxrGJVh3CENS99ko/1IU3nNLFlWE28ddpPY2STh8IRDWXl6q
 Fv9m4D8v8OgLsza9U23rW4r2U0cbMjvl4IywIZIjxrUKl6klrJpzR3Lzeyn/OiTsdZuL
 K+03HgnvJwAU2W4nRASZZHylXwpx4wP/uXyPPldna21a3cUIbzSDV7tcR2c9h+jTOQ3W
 AH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335554; x=1795940354;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1z7RmYK1NjDMEO9+xJDI+w73bgLEkLKZ4jmIOyAvUDw=;
 b=VpM5RyyUnoDuz+lMw+KyqbBaPY7usnhr5O8vr+J6lP9LN0LotVe6nUV+pWtmWt3NiH
 0TOg8vQFWqZvBMIbnf4y+FQkAfzZ87tgoR2M+WUN3JDrKDywsTMAuGLkOcgXWraLaqhB
 /S69kQKOif4f8NGror4BI9dH52FnC8OecOIZ5Eq2tnd1yWtCBcy79ILDd//85erWa3ki
 uqLwtndS2WEz6ASvH5A7fqWEFdny3mGl9hIvLUmdD5jf57KV85QsiIEKoWFrMIO59zKI
 ICp+v8v1NrcTKpAtic7X3pALAncMbldRS7baEM9VYa73Wb3wm7EZk04eGZ6/FWQL46XO
 IvbQ==
X-Gm-Message-State: APuU4Z9CIZE4/DKv53Sep5s4TvSU2w51KhQzEyeceXE3go2MvLAmSi9H
 Swop4dAUbYz+9vvksornuq/XQzlPHQs7cqg0Q+YmIeKcdITp7V3oelRF
X-Gm-Gg: AZFdTZeH25B6JvqeubGJdFlQHdqhvclvhciDD/m3nemdVn1Cz+1JydXB0oi+cUDpFqB
 w5Vw3drjpn7lD4c4KfRkF+wmz5Ama/n8z8u/FAQZ5FDnOFlegdn2xGqArHENwqdQHB71l6NjRbH
 7mTBpeRdpiLTLcCQ2Zvg+EpEZd10ES4RNhP/qfVmpSbwofGcSVx40pNeobPk8ArHuxgoRMkv1tQ
 Ul/B7MwTLIJJ9h7JTFrql4zqGJupr38YSNvky9FW8sdNAsYyREy2Nt/mmWcW6GrNKYQOpl+BhlL
 tW4FLqMMcmp4E1ldhULk4fnroIXFU5B8cluk1VmQ2XeupAHSIds0tQaizaIQxGxHqBP/2URIIX9
 bxfdzn2EK5IdGOiWPST8bmy0+aQ0Zi3rCwskrRKYFS5pZ+Z0li35xR9Ctu1o+8mcaa4UlZsoAKR
 ljnVD1HrBSkGQM5afQJSnRcHjxKFLQ5Jetsw3KmmXGZVr/KnIWgQIqgAuBNhErkSnZ32opmxr5u
 WbP4bJ+5sy3GkD+oGN23eMFFJ1qEBJMm5/D9+Nc6kZ3HdDRhgsnb+1ulJjK8m/zX/5I/twNyK+7
 VsN4PhSQYfnhVpvdBbjJheXPYFcsD15GH0PiuT2a4TRasFNWR9PFayuKn2kFJx+kEcYVl8Y4sjG
 aDSMjd7ey2Nw=
X-Received: by 2002:a05:6402:13cb:b0:6ba:4bf3:4a2 with SMTP id
 4fb4d7f45d1cf-6ba4bf305c0mr4401281a12.17.1795335553806; 
 Sun, 22 Nov 2026 00:19:13 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.19.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:19:12 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Sun, 22 Nov 2026 10:18:19 +0200
Message-ID: <20261122081820.53199-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261122081820.53199-1-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Document 8-bit CPU parallel MIPI DBI Type B interface provided by
Tegra20/30 SoCs display controller.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/tegra/nvidia,tegra20-dbi.yaml     | 108 ++++++++++++++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 +++
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
new file mode 100644
index 0000000000000..6a34202f80765
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
@@ -0,0 +1,108 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-dbi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra Display Controller based MIPI DBI Type B interface
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+description: The display controller in Tegra20/30 SoCs features an
+  8-bit SPI interface that closely resembles the MIPI DBI Type B
+  protocol and is referred to as '8-bit CPU'. Each display controller
+  provides two such interfaces, which can be used to send MIPI DCS
+  commands to initialize and control the panel while image data is
+  transmitted via 16/18/24-line RGB.
+
+properties:
+  nvidia,interface:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of DBI interface used, 0 - primary, 1 - secondary. If
+      property is not set, primary will be used.
+    enum: [ 0, 1 ]
+
+  panel:
+    type: object
+    description: Node of supported panel driven by the bridge.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/$defs/port-base
+        unevaluatedProperties: false
+        description: Video port for RGB input.
+
+        properties:
+          endpoint:
+            $ref: /schemas/graph.yaml#/$defs/endpoint-base
+            unevaluatedProperties: false
+
+            properties:
+              bus-width:
+                enum: [ 16, 18, 24 ]
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for DBI output (panel or connector).
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - panel
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dbi {
+        nvidia,interface = <0>;
+
+        panel {
+            compatible = "hit,tx10d07vm0baa";
+
+            reset-gpios = <&gpio 175 GPIO_ACTIVE_LOW>;
+
+            avci-supply = <&vcc_2v8_lcd>;
+            iovcc-supply = <&iovcc_1v8_lcd>;
+
+            backlight = <&backlight>;
+
+            port {
+                panel_input: endpoint {
+                    remote-endpoint = <&bridge_output>;
+                };
+            };
+        };
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                bridge_input: endpoint {
+                    remote-endpoint = <&dpi_output>;
+                    bus-width = <24>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                bridge_output: endpoint {
+                    remote-endpoint = <&panel_input>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd5627..a014bf0dd508d 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -76,6 +76,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A list of phandles of outputs that this display controller can drive.
 
+  dbi:
+    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
+
   rgb:
     type: object
 
@@ -155,6 +158,18 @@ allOf:
             - const: wind
             - const: wint
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra114-dc
+              - nvidia,tegra124-dc
+              - nvidia,tegra210-dc
+    then:
+      properties:
+        dbi: false
+
 additionalProperties: false
 
 required:
-- 
2.53.0

