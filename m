Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342C2CD4F5E
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:14:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 898D910F26F;
	Thu, 21 May 2026 08:14:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ErWhkJ37";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8D1610F26A
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:14:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so82490385e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779351263; x=1779956063; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xfn8fwroLe9/zD161wrcPghnqU9tQEqX2zqdv84MfM0=;
 b=ErWhkJ37yg3328O4HYiXT2MeVyLGdB625Wed+LDq8++QxdEhqabNXRTYm0jO2FSrh9
 3kUI15WNc/821zVxRi0Xl+23GVLBa8BKMDP7IMgjS1l7B4cZcbKfBuPl1b72QA16QhVL
 p8KoSMNsGf9UpqlhgLX4d2XSfZbgQZoHxo7CkZk009hyJV178dG12GFw15l3WWIz/kAQ
 H8sNWp7MslX1IMRI2jtBhGRIAe9zeuR2IZ0JqqJf5kO+Mf7rXsCNIgbG8st4jrj2Ilfz
 Pti6DlYprXL1TiCrvXLmMy+RhfGVv24nLK1tzaLCvcbDHgXTq7dj4zgXvmZiLSSR/B4R
 6KQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779351263; x=1779956063;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xfn8fwroLe9/zD161wrcPghnqU9tQEqX2zqdv84MfM0=;
 b=gZUd7PsrS1XVsLKIyS80+QlsrtTpMoA3SDWDESNCENVlVdQLtOVTvizs9jGJJSO2DV
 0plFf42WXqT9afK6AMtdt+vq0AdetPlkIhqDU/WQsPt+W625qbpHUbqpgfw50sxYc8Iw
 NtpD4uIXV+wDFmbnqfyL1scsOaiRAiRSV7+m6LDidG7EQ8ByILymoVjCK8KVm/f64PbR
 ra936H4wr/fzwvraeBsy37P11GLSz1KQzmZm9F58CBpDsgT2jvyPqxr9Vqk72F6aAK3n
 yHO3eqd07G3lwKTD9p36PcR88NJzZFm7HinS0vROafnc7D346a/Op6wloaCprDsRG9ls
 7N0w==
X-Gm-Message-State: AOJu0YxYY6hRSaNl0Vmb8lunoK8scSx7fFEKWboCKrqo5vese/Wa4ezt
 OZiXzaEla2hkCJgYr3nW2o8EEze//dPRHav/MzECH9C1hA47TBPi6kbAS0PoRTfD3vU=
X-Gm-Gg: Acq92OHu2DOhOkX5t+Z9rFkaAlS5/MDA04bPUBXsB+rV3nhetp/z+TOeF4h3WoS3njd
 NzqKnhLFUJU7CNMkpTrCA91+Y98gt/pKCDXkOkjdbgyvlMCYEPwO65X6dEzJVVlXt80Lvdb19ZN
 YMzQFRHlNME5Xae2EG3Iwg8W6Ji2soWHZxoISp8/NkCYaDa6MO4nx5OW7bweDg0EVktbVst0OF8
 pzJBOildG6eGuYGQ3l6I64mLg7iJLkrLKYxj4x3yktr9aV/jrft59m+zaZ635wyJYUxg/pKf6CE
 UFfRiuqFeI28VNlnhXKGO6gWObjiTeTVqQnQmkkymONWgSVovdf/EUyp8f2XsVF3KbevDGr5rmA
 PUJhGgZ59K43gf6EtC45Qeph/eeOY43AqmhLSJ3nIUXqsHH604O2fo9sJvjI0M810w1a2uTLDpd
 tc05O1xPB3pnhfD/fD3FhINY6iHjndlHJIkqZionzxYQnO
X-Received: by 2002:a05:600c:1f89:b0:48a:5501:7995 with SMTP id
 5b1f17b1804b1-4903606b594mr21078725e9.18.1779351263093; 
 Thu, 21 May 2026 01:14:23 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa7dab28sm1056384f8f.12.2026.05.21.01.14.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:14:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 May 2026 10:14:19 +0200
Subject: [PATCH v5 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-1-dd5700299390@linaro.org>
References: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-0-dd5700299390@linaro.org>
In-Reply-To: <20260521-topic-sm8650-ayaneo-pocket-s2-r63419-v5-0-dd5700299390@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2875;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=vFhP3FNbtu2wk3JAQk77ufguhpweIJKES0bOXeSkpV0=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDr7cxr1fRhPMxGRAc7BowL2W/SIwenTGbKS75sYb
 a8XBmMiJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCag6+3AAKCRB33NvayMhJ0ctoD/
 9cEh6BQJAMyFBbTUgaPFbzSw2ucaMOPuNgLinSPz9d+441wqtqlF4qXc35jaWlBrPx5f1ie6quYPZ6
 YKCIIQfWFzak8SIKcw37kjMJ2dK5Q90KnlrYJ49m2Jlhbh/ZLuS7hjjNzA0k+vB1wT6vsvV0tfq7w4
 g2E+X/ESqRB9QI2bjH6WQHMUrGe6Mr5CV4YGAiRCwvM/U6OgpzeAlGx7R3C9bN6VTOV7YWz88IUEpq
 RiEFpHxVaJzLQX2irLBKPq4aJ/jO0WIDfHKp1A6aiTFSiv8TEb647cCORkdZe+3opUZr4QeGxUDfvA
 9nXv/S6SVgJMaqUN8JLLi1oVMRbBQ1Md7ko5ZLl9Q7fbPQKLJgWgTAZJfjNp/lHpFyByunZpc8dsYg
 ge0ALs95TFF2mGA56XdHcQz0gDFogVhYPEW6+Fk0mo7wG/EUm7n6p1G4RE+6SOk4CCoAgSAsLvEMqE
 2axBoh3cnFP50WsxH0M8HazYB4J3JhEz5m1m7wZ3PA0mpPjY4UreXVPSvOujnQrXseWH2l/er0gu5G
 lfqzEr5ShL/snCXfcMT0F8OPP1wzMww4Zon71jO4yzBO4ttfJyJ3cbqgaVhluvGoKIIYcXkDBF7VdJ
 0E+ZhHKUUg7Zfkm6wXrZu/aTw1Ksj/EvA/mI18SA0Yn9iXOpsfvfOcCcVEVQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Document the Renesas R63419 based dual-DSI video mode Display Panels found
in the Ayaneo gaming handled devices.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/panel/renesas,r63419.yaml     | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
new file mode 100644
index 000000000000..adfdd2c300a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/renesas,r63419.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R63419 based dual-DSI video mode Display Panel
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  The Renesas R63419 is a generic DDIC used to control dual-DSI LCD panels.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ayaneo,wt0600-2k
+          - ayaneo,wt0630-2k
+      - const: renesas,r63419
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+  vsp-supply: true
+  vsn-supply: true
+  vci-supply: true
+
+  backlight: true
+  reset-gpios: true
+  rotation: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - vci-supply
+  - backlight
+  - reset-gpios
+  - ports
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
+            compatible = "ayaneo,wt0600-2k", "renesas,r63419";
+            reg = <0>;
+
+            reset-gpios = <&gpio 176 GPIO_ACTIVE_LOW>;
+
+            vdd-supply = <&vdd_3v0_lcd>;
+            vddio-supply = <&vdd_1v8_io>;
+            vsn-supply = <&vdd_5v0_neg>;
+            vsp-supply = <&vdd_5v0_pos>;
+            vci-supply = <&vdd_3v0_vci>;
+
+            backlight = <&backlight>;
+
+            rotation = <90>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+...

-- 
2.34.1

