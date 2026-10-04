Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D3DFCA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEFCF10EA88;
	Sun,  4 Oct 2026 16:31:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Up/5meUd";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DA7B10E4B4
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:31:34 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a169d33ef6so5372415e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131493; x=1791736293; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0rEldcoYDtpK/NBb1peZdgxu6IPeXXpzbTPYe4T4o64=;
 b=Up/5meUde9vqej7R180FKC+OgNKKlHgrIVCIMJgX95anW8mACFc9SG56vc8P7rxL9M
 Kup5B9RhDRp0TThxhEyEASwS0uIZ5PHoSbJ6zKomPxJFtq3DTQZyIPaES2WsST2V4qoT
 gzn8olj1//GwbRueyMJVCrO8zN7h6tzl9JVENuik1ecpDSQScCijZ5Ye0GjDh4Icss1q
 565cCXzUWWjUYVUCrWpAtEEJOfUYEd6lMRdI+Qcx28tmww9IoD3G27kXkuIQQ30lOBNn
 4xqUbvpdLOQj75pevsjYaFJVewY3qq+59KPTib99NM+/unpRufy9hXQQLlOcXxhyNebk
 ALbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131493; x=1791736293;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0rEldcoYDtpK/NBb1peZdgxu6IPeXXpzbTPYe4T4o64=;
 b=DEmhFVTAxAp3/XUylPOu12efzfBeQ1C3QtWSMsM6w3LA1iDJb56G0AwkbuNA/wnJWP
 mGO3V//+cw+ndj5AJVH+YYuPZIim4ZS4CnrikbKK98ftUtO1LK/wto4ny6Mu7H3gHKke
 w9xz5erDS0gHID1pIKDJY6Jp/Mlfe+8IOf8a+2yYPiUNz50T55UJoMCr1N7tyEzrndug
 V54bBnoMdBz0OGxqwtIHQ7nXG/PmBaPCO8+3dA4nwoTGVGmCzwt3q5AsKFZlnexAxFnm
 /hvf/q/A/DaEnlQbw4bZMZi6VQ9+eYjfC1lWz2SRhcTOvakYI1/WQ1rJBk6Xg8iHwabg
 XpRQ==
X-Gm-Message-State: AFuF++mvieYHo6ZkII9Vp0MBEfKKa2xcc+cqiXAjj26cLnKkDP+MNoal
 xAgOkmVy0t8WOUbDk8IO1VK22xk6iA4ntwHoDO3rurqLXLeIyaVlajpO
X-Gm-Gg: AYBFou03QrDjm5Lj+FVXkKn/sqO8lor7SymOEiCXxtMNKQg6iq6vms2VCGK4zJbWbLW
 rs5h/KNEJqxSh088LmSVdy21HQM2/T0zOOzWb/4tTuXERaXJpJMV+1h+eg5Eepy6xINqdwvtZ5e
 iImD/5HtKjGwxPtCb4d7sh2+SGMdlmVLl0OZIl+lSWM5xPXWd+1ybnkXelGdp8lS9Eij6mNvcxq
 WhyMME7rZ0YDKkOXnablEksFqoBdkkZ+73QR90Og1ooFuVYHESt7nSx6hb36vOIwjgVBpuEyPvb
 d2vu6I+bw/Jaa7uEjre1PCTYxcLHn+xD6ojbKKts9a7XnI7haV5lbVlzI2tTaTdh1H9qb5Ev7sV
 RRe78z3r8AjqAR+1IxGr1lN8dXvNhGFNbwcRgkTf6OmbOVVr/FJp+s8dmMcBO+h29MquWvTb0DX
 vVSje254SXoLM66YW4crrg5CqTTj+BSf/076uvAIQGzhd5c/I59x4Bajwkq+etk8JDgrJyodlm6
 vKrBumJDPxNPkOLJx8=
X-Received: by 2002:a05:600c:3490:b0:4a0:1723:2d90 with SMTP id
 5b1f17b1804b1-4a02751934dmr142272115e9.4.1791131492912; 
 Sun, 04 Oct 2026 09:31:32 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm315365035e9.1.2026.10.04.09.31.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:31:32 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 3/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Sun,  4 Oct 2026 19:31:10 +0300
Message-ID: <20261004163114.181800-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004163114.181800-1-clamor95@gmail.com>
References: <20261004163114.181800-1-clamor95@gmail.com>
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

Document 8-bit CPU parallel MIPI DBI Type B interface provided by
Tegra20/30 SoCs display controller.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../display/tegra/nvidia,tegra-dbi.yaml       | 143 ++++++++++++++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |   3 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
new file mode 100644
index 0000000000000..184c33d436308
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra-dbi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Nvidia Tegra DC based MIPI DBI Type B interface
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
+  dc-gpios:
+    description: Data/command selection pin.
+    maxItems: 1
+
+  rw-gpios:
+    description: Read/write pin.
+    maxItems: 1
+
+  cs-gpios:
+    description: Chip select pin.
+    maxItems: 1
+
+  data-gpios:
+    description: Specifies a set of 8 gpio pins used to transfer data.
+    minItems: 8
+    maxItems: 8
+
+  nvidia,init-sequence:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Device specific set of values used in DC DISP_SPI_INIT_SEQ registers.
+    minItems: 4
+    maxItems: 4
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
+  - compatible
+  - dc-gpios
+  - rw-gpios
+  - cs-gpios
+  - data-gpios
+  - panel
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dc@54200000 {
+        reg = <0x54200000 0x00040000>;
+
+        dbi {
+            dc-gpios = <&gpio 110 GPIO_ACTIVE_HIGH>;
+            rw-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
+            cs-gpios = <&gpio 108 GPIO_ACTIVE_HIGH>;
+
+            data-gpios = <&gpio 32 GPIO_ACTIVE_HIGH>, <&gpio 33 GPIO_ACTIVE_HIGH>,
+                         <&gpio 34 GPIO_ACTIVE_HIGH>, <&gpio 35 GPIO_ACTIVE_HIGH>,
+                         <&gpio 36 GPIO_ACTIVE_HIGH>, <&gpio 37 GPIO_ACTIVE_HIGH>,
+                         <&gpio 38 GPIO_ACTIVE_HIGH>, <&gpio 39 GPIO_ACTIVE_HIGH>;
+
+            nvidia,init-sequence = <0x0000002c 0x0 0x0 0x00005000>;
+
+            panel {
+                compatible = "hit,tx10d07vm0baa";
+
+                reset-gpios = <&gpio 175 GPIO_ACTIVE_LOW>;
+
+                avci-supply = <&vcc_2v8_lcd>;
+                iovcc-supply = <&iovcc_1v8_lcd>;
+
+                backlight = <&backlight>;
+
+                port {
+                    panel_input: endpoint {
+                        remote-endpoint = <&bridge_output>;
+                    };
+                };
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+
+                    bridge_input: endpoint {
+                        remote-endpoint = <&dpi_output>;
+                        bus-width = <24>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+
+                    bridge_output: endpoint {
+                        remote-endpoint = <&panel_input>;
+                    };
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
index 69be95afd5627..bb280f8dbfc7c 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -76,6 +76,9 @@ properties:
     $ref: /schemas/types.yaml#/definitions/phandle-array
     description: A list of phandles of outputs that this display controller can drive.
 
+  dbi:
+    $ref: /schemas/display/tegra/nvidia,tegra-dbi.yaml#
+
   rgb:
     type: object
 
-- 
2.53.0

