Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B391C531D0
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D34A10E30C;
	Mon, 27 Jul 2026 07:19:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l7MZ6CPf";
	dkim-atps=neutral
Received: from mail-oi2-f1.google.com (mail-oi2-f1.google.com [74.125.231.193])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A0610F511
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:21:35 +0000 (UTC)
Received: by mail-oi2-f1.google.com with SMTP id
 5614622812f47-4960a23d5e1so417535b6e.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784956895; x=1785561695; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6a/x50Eo6kNHLlYGVZSsuYw6cqPBcO8EXP5O0WJGjSk=;
 b=l7MZ6CPf7YZF2EMQkr/iRUFECjr2rQ+loUoF/Yl0WDlJBa5f0T3bn6rVn9XtmnjIW1
 JU5wcZGcbEiBY0KUnl3K+zTblNoUiEnxcD7D6BKDzXRHXdPSsDotPG/xt2imRes0JnvS
 jwa3tq3pWuRO/Nl9C+Q9uJkePAk72iUd+47Q2lbAs7tQphbRGDrz2dTYhJY8ESZjLsUo
 66BSdPbDaga04BlaPcUGd2C551QFoIflujZ2g48UEsXlcRDd4JMEhaUsXWde6/Yh6hyS
 luktNz0DYEFDHMwIh/b75u4xN09qA3oPfCkUD07/I7+Mh/3L/S36SPbvspYkNITqbfOk
 zk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784956895; x=1785561695;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6a/x50Eo6kNHLlYGVZSsuYw6cqPBcO8EXP5O0WJGjSk=;
 b=cTrLcQsFnIItKcV19g3q2kV2tGjPmcI5Jrj2l47it7DK8aRMxbpziUEcY0Ka1ahI+1
 1s0hc6Lo6FnWV9dOvTuoTvQ6D3WzaEUijoxEroYrYFA7W0KeHuA5iEAlvWgV0lzACLWh
 dl2ZzbhWmG4R5NtAYFYu0/Tj5w3gE7CF494EKUwMQwR2XuXEIfHM7D9fgDtxFf/htg8m
 tQ04pMkWp2OrCFwyt2TgdlEA9nhKKD4ntN5MWzwO7eWMuljMDv6UjBEoudbYyCkmf7/q
 EP1F2KJbXMyYuQgc4qCPJa3Kj+IPat/GTnGmUsTSXaN+eDZJ3fa022gzauwWtl1ePA5K
 vPdw==
X-Gm-Message-State: AOJu0Yw2xJeezzV0x06FgcFE24HBhjSYEkQCzFlkI9xzb7tyVE4HXk17
 oaZca9cuTDJ0nqJcstTKttZRv3CEcbvHMW0514QUayeBprsgaMO+zj2emDunaDNsBdpnig==
X-Gm-Gg: AR+sD10lY4NnG7UXgzil3b5+h6YgzJRb4dI6MrBUnH03fJDUbW/5yOGtErTW+q3mrFh
 QJPZSbcURAlmyy3WAI+SS5SK/tfsnLk/e7iGqmjWrUpH2JXCLERzdoPuxWvvjF//3tjIl/orPsj
 LV1lIJrpspQRBu4gtT0WjZEWdzAnq+Gef5FgGmWigrOgs9W4M5Yv9nL8IrMS13jl1rdAeFP8NqM
 +X6Bv8D3X8+y/GTGtU6/j9xNlAaBc8Qn9x9sBBtDMqe6oe+Js2Y8UPnbEF3qQ7arBFnqUOdxfyT
 F4M1UAFFC0dYA8n7FQZRrxIJoybx8GgfAa2aLCA+99M7Q23gRI4PjodsrHy0+lt5pazbmNedf46
 8/lQgBLrTbCfKzDMdRdmd27gRyAXVzAVG9zhsBjsi6d1cMJB310CyWng=
X-Received: by 2002:a05:6a00:a21a:b0:848:727f:2c8b with SMTP id
 d2e1a72fcca58-84e5959f3c3mr660746b3a.68.1784949456147; 
 Fri, 24 Jul 2026 20:17:36 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:17:34 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:35 -0400
Subject: [PATCH 03/17] dt-bindings: display: spacemit: add K3 Innosilicon
 DP/eDP controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-3-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

Both K3 instances are the same IP and share one compatible; which one
behaves as eDP is decided by what its downstream port is wired to, not by
which register window it sits in, so the binding does not distinguish them.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 .../display/spacemit/spacemit,k3-inno-dp.yaml      | 140 +++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
new file mode 100644
index 000000000000..865ea310daaf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/spacemit/spacemit,k3-inno-dp.yaml
@@ -0,0 +1,140 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/spacemit/spacemit,k3-inno-dp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K3 Innosilicon DisplayPort / embedded DisplayPort Controller
+
+maintainers:
+  - Cody Kang <codykang.hk@gmail.com>
+
+description:
+  Innosilicon DisplayPort transmit controller integrated in the SpacemiT K3
+  SoC. The K3 has two instances of the same block sharing one compatible;
+  each acts as embedded or external DisplayPort depending on whether its
+  output port drives a panel or a connector.
+
+properties:
+  compatible:
+    const: spacemit,k3-inno-dp
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: Link and hot-plug events.
+
+  clocks:
+    items:
+      - description: Pixel clock for the controller.
+      - description:
+          Pixel clock generated by the DP PHY PLL; the pixel clock above is
+          parented onto it in use.
+
+  clock-names:
+    items:
+      - const: pxclk
+      - const: pll
+
+  resets:
+    maxItems: 1
+    description: Controller-wide reset signal.
+
+  phys:
+    maxItems: 1
+    description: Phandle to the K3 Innosilicon DP PHY.
+
+  phy-names:
+    items:
+      - const: dp
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video input from the DPU.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Output to the panel or to the DisplayPort connector.
+
+    required:
+      - port@0
+
+  aux-bus:
+    $ref: /schemas/display/dp-aux-bus.yaml#
+    description:
+      The DisplayPort AUX bus. Present when the output drives an embedded
+      panel, which is described as a child of this node and identifies itself
+      over AUX. Absent when the output is a connector.
+
+  phy:
+    $ref: /schemas/phy/spacemit,k3-inno-dp-phy.yaml#
+    description:
+      The DisplayPort PHY. Its registers live inside this controller's
+      register window, so it is described here as a child node.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - resets
+  - phys
+  - phy-names
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/spacemit,k3-clocks.h>
+    #include <dt-bindings/reset/spacemit,k3-resets.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        edp@cac84000 {
+            compatible = "spacemit,k3-inno-dp";
+            reg = <0x0 0xcac84000 0x0 0x4000>;
+            interrupts = <132 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&syscon_apmu CLK_APMU_EDP0_PXCLK>, <&edp0_phy>;
+            clock-names = "pxclk", "pll";
+            resets = <&syscon_apmu RESET_APMU_EDP0>;
+            phys = <&edp0_phy>;
+            phy-names = "dp";
+
+            edp0_phy: phy {
+                compatible = "spacemit,k3-inno-dp-phy";
+                #phy-cells = <0>;
+                #clock-cells = <0>;
+                clock-output-names = "edp0_pll_pxclk";
+            };
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    endpoint {
+                        remote-endpoint = <&dpu0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };

-- 
2.43.0

