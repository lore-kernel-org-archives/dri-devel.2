Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE017FEA82F
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 07:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2559E10E802;
	Wed, 25 Mar 2026 07:58:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="G8tQ9zdV";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BA110E800
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 07:58:27 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3585ec417f6so296724a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 00:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1774425507; x=1775030307;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ToMAIYfDdLF98AYL+fgRMtnkblofR9bxvds0Kk+i8wY=;
 b=G8tQ9zdVlKOjCf0oUO8T5XjmwM6XNZT6OhBFQCzLtpQvBRPlckV5YWzhIznb0A8EkZ
 3/e/sXjlHK1SJWLE7A+tmb28r4hplBZtRgpoqSBhm+0xB1tP6GXVvgigtFOkI7mW7aWI
 InX8yFAbwcono7eOdEVohxAZWdQgMWTMjMkuU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774425507; x=1775030307;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ToMAIYfDdLF98AYL+fgRMtnkblofR9bxvds0Kk+i8wY=;
 b=WD/QieZqiG0SoV6367j/nsqxZzOpwtEBE2g1HuNS90YMMIlt2H6I2L6fdOF604odcq
 1AT2z2yniI72cC3DyRUiEYl0gJm+CNPs0NdEJcl6z8D5EVb5K5toadJcwcdFRpQfdg7W
 idfGdNhOv88NdYsxi+McNBO6Lyy0UYnPxtgBnMPzmy6MUo0TPLDy9jfp/r87KxCgHZFa
 wkHQJIEC35EW5GlmEJg7X9wLgQD1Gp+REr3HwWObd89OTih9nbkg3cxDipF5OP9VtRcl
 YLrZMs1rcO4/nr7ZRzs2fpgI11Z7bWRbIiKKuNxfDYvSSyIeJbWTL7jKB3YZ0D7jk2kT
 T/3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzbnBccRP5naFfKhWJBim2VxDeGyysnLBH2wThRA1I68+07AzHvT5ZE8F0Te8YiIzjFndWXamZXnY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YweycA8AcAGf+8slDVBT5mkLOt7UkLbvCbqoGQcvBobq7oUR+7O
 +CwTPxSWwhwDPNr8fqrK9MqvlFVhMuQcWwNofj9oPQftMYT/A89wTGW1gjowwoJTAA==
X-Gm-Gg: ATEYQzw9d6QICAUowCELVIWWCqjZC/ZNnwjZYC7fnsXwaX5uBHn3OGTAi71AkfQ3WpJ
 wrUhxIkzxG1HTy78WS2VjeKkUHnt54b+ZQHGX7C3cFKS4uR8OxLSIMsk5uoCGW1fdVD38f3YBuV
 ijBre5z/mutPloUwxnLqTHFE6FkSUPS5qBzXp4K3/Jgi1m2tnN1e3wab0KoE5UUkUCUrUcnEW0U
 9gDZ1a3ub3TdsoG0+nJlzh0MCG3W0SpDwdfF7pZ9pqXrzcpcw1n/OEopcjL6DNHig+ir9/0y+DO
 q4imCv1dpmJfnno2LRFBCbqV0G8PoVbHe6wvPnuYxMsBEbMunVorqNDdOKpK2+bt7CScGcMLHAb
 QSxcJo/a0B3MdtpSAPQaH4ojvha3WDSfqfkkq2YOxvJud322pSjqDoXAGbNLIyjnWoIdQ+KCxt7
 veGoPpDnqiKYcLGnXY8Ct35c7bfeT2iYRPR7AZYgXBg6/rXPt3SiXwBAjElCeJtWjxPpfdXV5Ah
 rOPkLc=
X-Received: by 2002:a17:903:3bcf:b0:2b0:4d5f:1f6e with SMTP id
 d9443c01a7336-2b0b06cc697mr27079345ad.8.1774425507438; 
 Wed, 25 Mar 2026 00:58:27 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:7ff0:bee3:7d45:eab])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b08366c3f7sm219682465ad.60.2026.03.25.00.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 00:58:26 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Icenowy Zheng <zhengxingda@iscas.ac.cn>, Icenowy Zheng <icenowy@aosc.io>,
 Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/5] dt-bindings: clock: mediatek: Add mt8173 mfgtop
Date: Wed, 25 Mar 2026 15:19:45 +0800
Message-ID: <20260325071951.544031-2-wenst@chromium.org>
X-Mailer: git-send-email 2.53.0.1018.g2bb0e51243-goog
In-Reply-To: <20260325071951.544031-1-wenst@chromium.org>
References: <20260325071951.544031-1-wenst@chromium.org>
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

The MFG (GPU) block on the MT8173 has a small glue layer, named MFG_TOP
in the datasheet, that contains clock gates, some power sequence signal
delays, and other unknown registers that get toggled when the GPU is
powered on.

The clock gates are exposed as clocks provided by a clock controller,
while the power sequencing bits are exposed as one singular power domain.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
Changes since v1:
- Dropped minItems for clocks
- Dropped label in example
---
 .../clock/mediatek,mt8173-mfgtop.yaml         | 70 +++++++++++++++++++
 include/dt-bindings/clock/mt8173-clk.h        |  7 ++
 2 files changed, 77 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
new file mode 100644
index 000000000000..03db1ee9e594
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8173-mfgtop.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/clock/mediatek,mt8173-mfgtop.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT8173 MFG TOP controller
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+description:
+  The MFG TOP glue layer controls various signals going to the MFG (GPU)
+  block on the MT8173.
+
+properties:
+  compatible:
+    const: mediatek,mt8173-mfgtop
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: sys
+      - const: mem
+      - const: core
+      - const: clk26m
+
+  power-domains:
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - power-domains
+  - '#clock-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+        #include <dt-bindings/clock/mt8173-clk.h>
+        #include <dt-bindings/power/mt8173-power.h>
+
+        clock-controller@13fff000 {
+            compatible = "mediatek,mt8173-mfgtop";
+            reg = <0x13fff000 0x1000>;
+            clocks = <&topckgen CLK_TOP_AXI_MFG_IN_SEL>,
+                     <&topckgen CLK_TOP_MEM_MFG_IN_SEL>,
+                     <&topckgen CLK_TOP_MFG_SEL>,
+                     <&clk26m>;
+            clock-names = "sys", "mem", "core", "clk26m";
+            power-domains = <&spm MT8173_POWER_DOMAIN_MFG>;
+            #clock-cells = <1>;
+            #power-domain-cells = <0>;
+        };
diff --git a/include/dt-bindings/clock/mt8173-clk.h b/include/dt-bindings/clock/mt8173-clk.h
index 3d00c98b9654..89e982f771db 100644
--- a/include/dt-bindings/clock/mt8173-clk.h
+++ b/include/dt-bindings/clock/mt8173-clk.h
@@ -243,6 +243,13 @@
 #define CLK_IMG_FD			7
 #define CLK_IMG_NR_CLK			8
 
+/* MFG_SYS */
+
+#define CLK_MFG_AXI			0
+#define CLK_MFG_MEM			1
+#define CLK_MFG_G3D			2
+#define CLK_MFG_26M			3
+
 /* MM_SYS */
 
 #define CLK_MM_SMI_COMMON		1
-- 
2.53.0.1018.g2bb0e51243-goog

