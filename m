Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A84D606D802
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vvJNajLh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D3171124A0;
	Thu,  5 Nov 2026 14:06:31 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11BB110E674
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:06:14 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-490f38e9688so632353f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887572; x=1794492372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3S01xD4JAgzzx2hQLx/xQm0YodbZuGxyyLtCeJj7JK4=;
 b=vvJNajLhSpJdNPURihQmxhId1gF+UPMAN7Nl54CgjbEeAWzo/eSx977o7G7b62yzni
 5brOH6Yf0iIL/pR4w6eGNtLfccfRLC7y+QzVwtGI7DFkSjphG4kNgu1WbiSLQv/5NOzd
 55sfS9mm/mtJbhKjy2OzG/Atnls9jxE9AGY/SCS7yjFnR0VHWRLHS4vqftPTFIejAc7V
 tFh6GxHNih20fPMaivuOpbwE5fHno01jHl7FOCXnqkl9NzqHzteqKyceRYSNUdK9uEQO
 HfelktnNkKx4+8PiIFo4RRqwH0GQcth6HlIBpsr2ZAlrOfj20QwN5aEmSW3tQtHJhgkh
 klUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887572; x=1794492372;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3S01xD4JAgzzx2hQLx/xQm0YodbZuGxyyLtCeJj7JK4=;
 b=vSvEoFnzsS+35Gmzf8ZJM7d0nr9hZ+PCA+W+X7jQdLYTN+h1DJnu8x3QLJ0RUldYub
 qJJVB8Oot9iOKEtPD/oiUgb3QRtwrnGeZqD4Y7UXrK4fOXKtodD4PrehCSvlNAJR0+lW
 aCfLgVm5Y6Tei+nxsHN5yarkOzznJMqvk/9gxaFSIqGME2OcP+/qIzjICwFSVA2KKCNv
 0McrWsGccYMV3+qF+cO+DSjwwsYfF47AHVM5XLO/G/fjBtW5DDBcwOTb6SIHFYBGbuzx
 mOlShfQBXXsgwu+dhAiu41KN0AY9klE7ctNteLfB5zL48tiah1gJsU4RTCGA6yuhTbXC
 GP7w==
X-Gm-Message-State: APuU4Z/DQS77iIdQSGGaoDVUp+4r+tDCfyYdw2EOZPKReH39gEEFhv0y
 1BohBQtJrV/nIG3EaymUDYxPK9QwzFTVUTH1Kdv8UKvGwO8rt8VjTR3y
X-Gm-Gg: AYBFou3DvkNQWV3wBp1VQ+jp+giKFHEXsvdeSF9cJVH55ASnSCSDXO84KjPNcXyUW9k
 /id+kbu/IQYrj7VO0Jj1/E2d8gGte88oO5tW9mdZgo/OCWu9s+jk1GLY4xgcnYYr2b+/bohtYyx
 BhX+d4fxw3opZ33o//8/jvPYiGFkhNYHdY6/5LK6pnnn7T32xVKEjWhlne63r2+4Xnn8Ex7PHru
 NTtFnAouztpGGsoDEcFAGYq36v4qBWeJ/AwgwZnU9Le15j5siOcKDbgv5lKrKBZDW7X5vwU6FUk
 YD35K7Xxa5ZqkUFqDWaQ2jEP912MQjHmBmFF+YVTp1Z0NKRCE4Iy0KesdcrI/eIceOhFxVZi14C
 DOCmrquJF2dtS+oTJIFHLHi7axnEmT10ML3qGZ0XSh1dEW4dhUmO7YxhX3KiAQeoJnlqfZlJhBf
 k9CbyykDHqC4xCe4ZHRRVBKfFAh2LC407tVPjJlCPLp/fzu6jMWmHNRoxMZ9Q05Hyx1/DA5QjXN
 fEnDGlN7boVNZm3WTf9aj2VlZw57Jjikd1xb2KSa3TJuwTI4Fd7CR6VdPnXBpoPL+NfXRjVxXVf
 fMhkOg2kP3Xvkd87TBHaZ1aXBHkSWDN58leo1MR/MlH9kRhNIDcY/9s4oybMYUSUdbavfbY=
X-Received: by 2002:a05:6000:3c7:b0:48e:7475:fe7b with SMTP id
 ffacd0b85a97d-4911906d185mr4750001f8f.6.1793887572221; 
 Thu, 05 Nov 2026 06:06:12 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.06.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:06:10 -0800 (PST)
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
Subject: [PATCH v6 09/10] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Thu,  5 Nov 2026 16:05:09 +0200
Message-ID: <20261105140510.165165-10-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105140510.165165-1-clamor95@gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
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

