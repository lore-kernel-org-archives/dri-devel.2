Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9B606A332
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=xqucjfFt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D31131123DE;
	Thu, 29 Oct 2026 15:30:05 +0000 (UTC)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D24D31123D5
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:49 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c414e5d282eso314296566b.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287788; x=1793892588; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3S01xD4JAgzzx2hQLx/xQm0YodbZuGxyyLtCeJj7JK4=;
 b=xqucjfFtGcpEki65DP5vkJBbGN0jkgcmN0iYZhlgLDpw6RSjuASAHGKHYMF9CAE4QF
 e85n79/FcY9oVTlJYOF7Oii4p3NKywrGH8bBjYPz8jqlyiQhDLafKwa3O4LFyS57ybru
 2t/ZC3kx/rHWhNuFBSXk3aGfeE6++wuOijfclpIfudPlEDXN/bgRZ1rgJBXLfRQea2qG
 B6NOK5GAVuVHrXAAvzOQF34DMayIYMzJAEj7Mbo2CT7CQiLoBX7Okow1rn/6XLiD91eb
 nmfWSdf9YbANlmEAw14PDefOx5RPx3N9rChfBW0LR9ARPzsK47mcyS3sSqP5oTVx4Abm
 tzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287788; x=1793892588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3S01xD4JAgzzx2hQLx/xQm0YodbZuGxyyLtCeJj7JK4=;
 b=bLoXrRyMj8FjaWClZUWdXFU2kQ0Smm1OwU8XuPchJx4O0fwHMOEElrEVrLt7OFE2j6
 1JFGVMZCY14KX7txFYCr6rEHEjWLoD0d4TjSj7ILGXno54JJDX27ihZgB3hr6Egd4N9R
 7DppivwRDylmW+NvC08WWAw4onNDrkefL1pylYBy7Wj4ww3Sbzx4ID0CrkG2vwFe3Lij
 j+1BY7YKMyWKUp8Fk3INlHXGvI1nFnfuX6IUYh/CacZJju1Yy7EDyYDLF+rhmRbkFzYp
 wzsm1WlWHRbktr62naaDLLlx8kS56ICrBiVPA9N+2QkjRhuAO5fdXT2RX/p9DSrGVZiM
 whGQ==
X-Gm-Message-State: AFq9FYJty07mlnMhKX1M2/tDZxQGYUS1RGiCN6kXyuCJUgQhCu13Jq46
 gEdKfZXN1vs1HHB/xEIhmSbNT3K/qlWQGm6oinIj4m6f7fh09a8Qh2OH
X-Gm-Gg: AYBFou1kwKzTnm+YaDpDRL6O6+YUe6unsJK2jpaTg2jNO8kTiS+4Zg9VvJ6qXZP4zDb
 dNnplto3c7VNFFFnuhmBuUpOSEX7DMGppr2BfgFZH5PlMXsjHcSckPQmxUMz1aK28AlZAhsdkU6
 oMy/KnIVA6RFtOPs53MlAvahYuaY8o0Z4R6dYzMmF4TPQpa1kzrLGf432QYshSLG1u7uCNeUCKW
 d+JN58L1um+RoXEoMMJiIHi1Bc0qf5SrUxgaVYS5o6h5rAuux6Nc97kDF/XSRBRSe+PKoPBydS3
 rW2rNnzm0r+yQNwLqGoN7Y/nBAHVh1INnRmFvONv2gFrka/8NKg8mREpiaT5QiUqt3HdQmAhTSs
 An+9jPRPYJwM9iiG2RMSKxJ8swIqoz/vsfb8WXoqn+SRASqns+8jl8d70WM7N+IcWNuC30zqYB5
 lxBoJOBeiwJvJw/AUrc+WYuuhtrHge9/n1cWfOKl9LWpnBJ7FOlk+2TOIuDKBavwi09jzZCkLP7
 67kUUeJLpXzSCuHJOxCHPIeGPFZznLl3FNqATXq/YP/TGUep6yQB1NIs5mt1HagUXenohFodPFA
 zFqHlUmr+wwu8iMUhAnmNHwrK7MIE6FrbLSncMeFNxWiiiUSiw==
X-Received: by 2002:a17:906:97c5:b0:c49:cfcd:69e5 with SMTP id
 a640c23a62f3a-c49cfcd6a52mr239044866b.32.1793287788116; 
 Thu, 29 Oct 2026 08:29:48 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 10/11] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Thu, 29 Oct 2026 17:29:08 +0200
Message-ID: <20261029152909.234584-11-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029152909.234584-1-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
 .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 ++++++++++++++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  22 ++++
 2 files changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
new file mode 100644
index 0000000000000..cd568d19c363a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
@@ -0,0 +1,113 @@
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
+  reg:
+    maximum: 1
+    description: DBI interface used 0 - primary, 1 - secondary.
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
+  - reg
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
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        dbi@0 {
+            reg = <0>;
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
index 69be95afd5627..ffeb124905dbf 100644
--- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
+++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml
@@ -79,6 +79,16 @@ properties:
   rgb:
     type: object
 
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^dbi@[0-1]$":
+    $ref: /schemas/display/tegra/nvidia,tegra20-dbi.yaml#
+
 allOf:
   - if:
       properties:
@@ -155,6 +165,18 @@ allOf:
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
+      patternProperties:
+        "^dbi@[0-1]$": false
+
 additionalProperties: false
 
 required:
-- 
2.53.0

