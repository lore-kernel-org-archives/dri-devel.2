Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0399FC54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 09:18:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F0DE10E565;
	Tue, 28 Jul 2026 09:18:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="POG3+hIb";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F187810E54F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 09:18:21 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2ceb096e675so43972525ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1785230301; x=1785835101;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0T75/EutYIQThS/ZfnwY3OlWCqIaGeaNzqSXOb58pGA=;
 b=POG3+hIbVTThJ+qtHZhzuxwB1suPU7JUSpX5Iob6pvKUwKnzHNh7Dn4T7dbs8tAG5J
 0TbJsnRt1eYH93h8ndedivcuAVW3uHLZYvqDU+zd0ZYVbOfM6DoETUnxnYLtC7cucvFi
 0fUgPObgPpp9uMbjsfCtaRs7ADeVRC7jYgxzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785230301; x=1785835101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0T75/EutYIQThS/ZfnwY3OlWCqIaGeaNzqSXOb58pGA=;
 b=qI5lhFyBXi/hHhZFxu5PeuOL4AMUJpcTOmcDJsz3bdqbACdn6351rR7M0G3ihvWXkc
 m2jIvd5aXYD0ukxFFuiEjs+9K22i6sog1Tc+RcJ/eMsUqyfltYBW/vQOs2W2jWOve/9A
 T+Zgbki+rg4+M/4HX2pV9Ut1o3ZndfRLoCBStv0C1PTP0eDKQ7l8HZ9SWGnGxYGObeCu
 XFWVAO3tcL6DmzqDrz+y9uAhxv6Bxzgwu6fCryQZ9Go2HoopcWGb4pfcqNpO9EU/ZeUB
 VlWPek+q8kuBmM78Zq4c8ZVZCsejKOsQ2N/GgyvVEqo+q+q9+FvQkkpcjNDjv1MGZL/Y
 9KQA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/MgdnBXCweorQ3ZcKd6fd7zK9FrMkizt8ocW5sa2/inW3sWte+KKfCn0SgMXBf7PlY7KiSqRb5pU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzWXdpQ7W/JM27F/ICD1F7hfw4OdsNYgZxbfMNMhl08j/P1r391
 wK6qVioBWWT2qV6Ytf42+L+gihj28MkCBdW81nayCqUvF2cgyakOqHWTxaTJH/PqFS0BPkU74r6
 n0zQ6FA==
X-Gm-Gg: AR+sD12PitdAGg1MKoC0Qm4lP/KtZ6pfHBFGSXnQT20vjhTyoT0EADjexgqGDHQpZs7
 hB+883X5o2ThFiVc8h2IFHQSbm1ZL6vyB3Ej4ueKiiEuAMK4GE157QpSaYkDh49rMnhK6OXp57j
 k+PmZJGmgBKSLL0lJ0fJ/9qqdfuIU7hamQPIDyDXADoAjegylTPjIIg1VLpjYuz1PNxImOIhbJG
 pr16DXxyqomYjkTvctoyFPqSa1pYpAyAf64+n2KO1LO1dIozf4dMEwtDk7lxFWyXmPzKDsTiy12
 lA2wHhAe6piUxacBFTmgWI1LZje9wG+mXyCRV0fSSj65PkMUA9rpUMUR0dsyaVAFO+T300ZyAH/
 s76rn3DZ3hF7tWGhG9S2OLhgIp6M8Nc3TCVdJk4EA7C3dci9FIRv2rLzDCBFa2lBgzhH8LgBKSK
 duE/Bikhofy5GWQl16GweKHCeoBequ9gw5V2gL8vpbAhkQBn5/RlJwm0Th09tnWVOZmx9gyA==
X-Received: by 2002:a17:903:fb0:b0:2ca:e565:7b15 with SMTP id
 d9443c01a7336-2d015c91d62mr18424095ad.10.1785230301466; 
 Tue, 28 Jul 2026 02:18:21 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com
 ([2a00:79e0:201d:8:c85f:b2bb:a077:d544])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cfde81dcc1sm48616965ad.84.2026.07.28.02.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 02:18:20 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Chen-Yu Tsai <wenst@chromium.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, imagination@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Icenowy Zheng <zhengxingda@iscas.ac.cn>, YoungJoon Lee <getfeus@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: clock: mediatek: Add mt8173 mfgtop
Date: Tue, 28 Jul 2026 17:17:59 +0800
Message-ID: <20260728091804.382753-2-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
In-Reply-To: <20260728091804.382753-1-wenst@chromium.org>
References: <20260728091804.382753-1-wenst@chromium.org>
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

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
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
2.55.0.229.g6434b31f56-goog

