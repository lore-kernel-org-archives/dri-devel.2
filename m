Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E150606A320
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OrDkgHP0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B843311261A;
	Thu, 22 Oct 2026 13:23:53 +0000 (UTC)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 054C711261A
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:23:45 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-6b40fc523faso1848030a12.3
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675423; x=1793280223; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6BEc3XMlABHl329Fy0hgFM4B7kKL6YNMCLfGD4LbgGM=;
 b=OrDkgHP0VsnGQDORkzAVNOXZ/g/3aTdBS4vhHmCpX/Q/Oxu0qaSrwLsIpjc4cmaJnY
 +1du7wVGccZ97EzBnlieWgZQuqjr0qo611po2X/AhmzSJs9rWg4elZWFJOMPfTC4XL2L
 6gqoHhPM97sE6SiClDbxHDgEoIhDek0U0/vJzI3JGiN5uJj1H5LSJwbqJAm1nzUYSdHw
 I+A1ufnz6fKza8u8ajiZAGfuTqG0FyeFhmoLx223EXkqKrBM/bteGvq6Rr1trENUxxLB
 HCFTleKiuFflDxakXiUCFGqnBpK0J9yW3FU1cpojVwrtACBiyEnGxqUfoga6AYhrzWvZ
 HS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675423; x=1793280223;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6BEc3XMlABHl329Fy0hgFM4B7kKL6YNMCLfGD4LbgGM=;
 b=2AisPc3AdwJnm6c1dJ+hZ01GmYqTcdQYiKApAEPIGN89t92V1NbvcG1qfzOx/guoFf
 qFokpqGOAexMDO9bVbYp01n3UFV2xN/7Kt8T6GTE08NdI/C5OsiIADuwu6OoNlaMH8XL
 OK1IJNhYihN6FfR7C+du9gLVf/2YaYly+HdyHQNYMUTH18IWMyzCQKORhrHbD3vDdOUS
 LHXpr/7a4isKViw7VMqmXeX9+xr/h/grXxLD4wPBqhVfOrSKw/d8DIN1iFcPUJS7ekG2
 o05qjaiZDmDviKocJRnd2e7NYIgWXf1mry7hsQo+yOFNEYwrUtixbU55iFActuc5A5mV
 12JQ==
X-Gm-Message-State: AFq9FYJon0wzVVEPWq4992KAS8JJYPGnEO94VEgL7qcfWOmTjgi0ucKw
 sdRLT7DjOGvIdn5T2MTxV+EWBjDHfWxlAVd8gnzvqBJ4PReDzq8l189g
X-Gm-Gg: AYBFou3faq/HN+678a4dyM5n9tyyk12VE4K2/OSunrUz7FthM3EvYU1X/jI/MKGmXLp
 cmAv3aJgbFS19FS+pHp9cWb9x/aAiJE+Z+jDaeDUn+zHTAiOKIfwtuwsvScAm/Z1gRt45Ohv6Do
 KfmVa5b0Azig7w1WX4fvIw3VO7G7or5xTox5OnOJG7wNPopM2xI6dm7YQ4TdW5pqO02hJl971sr
 PzBsQNmxzNrSJK+WTzTCPuoVPZ39Zot06te9NoyLpPdkgxNleT6SO0hK+HJbJg6GuqdDxmcgfwO
 +pxKiJww9TFg1RVRu6TvjDi6iNZ6YUQfYJ/7lkB3qpeZO1evWxDeoxWFsLWCIFUCcj9+tdZbWb9
 UG5yJgqNlMRGzNgCr1xbTup+10lsb1rIWUHckBy83WTgy4h3VKaLJdvII2V0RcsAURYbuRg434D
 yJ1OgZO5rp9roCGdOq8meRy7B11KKxXpbmuERc6VRIeoF80d2cRDRckYdFuVhm6xYQvaM/nXLEb
 0cX3io14SAD2KRiqE1KztttW/TTE3cI+KXrRoBJDxrQ87E23wLfM6U+eg5VSBI+/1k1x0Etj6Bz
 BOdsnAtPzyl4/jgGVPU4MA==
X-Received: by 2002:a05:6402:2b88:b0:6ac:b013:8648 with SMTP id
 4fb4d7f45d1cf-6b408ee9375mr5181594a12.35.1792675423238; 
 Thu, 22 Oct 2026 06:23:43 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40313074esm1818061a12.27.2026.10.22.06.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:23:42 -0700 (PDT)
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
Subject: [PATCH v4 6/7] dt-bindings: display: tegra: Document 8-bit CPU
 parallel interface
Date: Thu, 22 Oct 2026 16:22:58 +0300
Message-ID: <20261022132259.240717-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132259.240717-1-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
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
 .../display/tegra/nvidia,tegra20-dbi.yaml     | 108 ++++++++++++++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 +++
 2 files changed, 123 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml

diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
new file mode 100644
index 0000000000000..6b4fd20c5817c
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
+  nvidia,index:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Number of DBI interface used 0 - primary, 1 - secondary. If
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
+        nvidia,index = <0>;
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

