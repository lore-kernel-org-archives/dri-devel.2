Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02132FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 08:02:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E099A10E404;
	Mon,  4 May 2026 08:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="FBOdcS3T";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF84810E3D7
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 08:02:12 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso25621835e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 01:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777881731; x=1778486531; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ty3MbPaO2vFwqPZjz6jT7S+J98csHl+q0+lwLd9Yl/k=;
 b=FBOdcS3TXSGH6ylKByXU0A535Lvl4U+KuHV2JWuxSd4ZwXrY5cmfYzVgEVCTdCh/KY
 mn5CnsKs0I/Uaul7bMahjB4JSW6tiqoBIsbS6CsEypQw1tkZqu/DB5aVawdC+2wE5pUA
 0C9mRHgyVE6Gwkl7/j+34V0vGEkVDPI3FbvFuMNUXsb3BT6jT6EETKdr3ufv4upWPquE
 vPFK/bjWikaChN0tT4XolkvmPJv3r3R7Y084XwJt55IQkraVkHCwszNDR478TD6dNw+F
 DIGbqAUzWum0wXcIEfsy+syiovTv08HU8jG4zHxcX8YWfXREZAAV4xNh0J6euSBTUriS
 ZUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777881731; x=1778486531;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ty3MbPaO2vFwqPZjz6jT7S+J98csHl+q0+lwLd9Yl/k=;
 b=OyyttEMWcWzeI8IOsI5c1kY8Lr1y8cBQHkybBtthmHuvIYZwYI1C1rX7Z07faG90zU
 Mh7fu5oW1rob1Bwff0BieBwXPYOYJsqK4focTbjYlNQsDCxD6vw9kCoVHICuE869PM+p
 4VoyLp9VeARTTJfvjeVX9hiyXhy2BwMZUxjvwNclhi+qKdFELM4uYMU/PPPTBdn/531o
 4GVr+tzr1BPOQslv/QR58DIuKFwVKT8XzSgDJoqXVOFNqjT8fbSd0v+IkHLvtr9hOTvD
 ZPiN3/Ht6hkm9vvVa/lQMUKFAguq0oFbX2ej5ENhPwiGJ9ER/B90wTtThzmZBtqV5V06
 OgCA==
X-Gm-Message-State: AOJu0YxfyE/DFTHT17jAtTJu0s1Ln7LmCsBlDFDCMggL/CgPKUF8hqwT
 0iOcIktQi2WUfk2RdAc0isIXJZXiQiJjVbpldvQup8RmvAVYZLR8TdbDsSshKey9MG0=
X-Gm-Gg: AeBDietZ63j9PVTZHMqm51vbRnU0A9EPhc5qbTJyAYV/Csm0NJUZBt0w2+gtt9yYLhH
 4PEMIE9w2KaSipqq7nzZfCOTiaefglORZrkQ2NvaqG03OK+2M/2D7f+TpSZT5oPkhPmtKqjqhNl
 2XulJWs9dQCKsp1ryL4zieoM5yECA3t5QSI9t+HjuPIqMGjQFAh2uwSqpdIqwqwDrVxrjwVPopa
 6vhl1SfmFOAmLsw5TUysMe1MEJaQk82ar6ElRxJTLXmnHXVN/YlY6jpWQa1lOOYqwF2gCIvvQHN
 HG8jsYdKIimOXAIJdQywWhKcyC4sZB5aF8yXcc9Sa8PhdheBqt4EuiM9F6afIlI4ssLF1fyNFZN
 hokOczB1fRyUYFd17itCVSUeIFE5EZazFheyo1bUjS65Q8aVFCkTWDDdWGlwcTV9u0gAe/CMk89
 0fcbC5pkHPmVFLe9NBbU8SilzOLkD2Ivq5N2m60CBa1+X7cfbDX+lXFtA=
X-Received: by 2002:a05:600c:c058:b0:488:ac01:72b6 with SMTP id
 5b1f17b1804b1-48a9866a998mr109269135e9.21.1777881731004; 
 Mon, 04 May 2026 01:02:11 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a981defb3sm32255216f8f.20.2026.05.04.01.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 01:02:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Mon, 04 May 2026 10:02:05 +0200
Subject: [PATCH v3 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-1-9f61cf24aebf@linaro.org>
References: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
In-Reply-To: <20260504-topic-sm8650-ayaneo-pocket-s2-r63419-v3-0-9f61cf24aebf@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=74ON2gxJ2EbMlsMpx0629ZNhdQsnwZKCfK4Lcaq26K4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp+FKAAoSVmjc09UHBFWojXT53v4Wtjy9ZpMZCZPMZ
 czCRDFeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafhSgAAKCRB33NvayMhJ0VbwD/
 9vZSbesQ3rGFgA55pV4KHq7cDalHuTSxYIF2sknWBGKqZ5CAR6o2gNybDs6d6pcA9/4RBBi+USXznD
 NSEVMoxYTrBxwsBFA0Ys9qpjI0l2OBS3L05zW2d+UAKpunTHnKo9C096RI4os1ovkSc579xTqHKz0Q
 6pqySgbfz8u4QfVBKpMleglnda86hhMQGyxYOmvpir/R8qBv5NMB+LrQPjunE48eA0Z6hqHTMNkc4Q
 db5omBweQ9iP6K22lhGUtjXQxfwk314R3EY+cS3uBNEm6irtf9wKGOAUWal9ptfKD5rkh4LnGzMwV8
 KMR/fmaucvwgqa03WbxUi4Kg3JsKrNjct5GydGMPm7UDqgg1MJpR9MP5uT5NZvYZKe/tJXUGJzKvmR
 Pz+/5YomVkzPJfLBfT7rs5j1a32akdOCIZR4CtSUCaTtNe/ImjXveKFcWITj2OaG3r/jNIXAsL2Mmf
 IfgfxSPWpBS2ypa5P/xwTKr9HlMpk3YhbQ88/yc1kmpfo0CWhhTeJpT5+q/+gUNOuBwMsJn0G5dzL+
 nLoxDacqiBS/sxCq5KiZ/hmA7WjgDbavCbedlRO53v96tp82oMrJWBUxvLm41yoQTbnpnuvZFxIg4C
 B2ws1HuxKNOhktqYOk2qe+jzlBdN8MNyslUsJW/MYQZueQuD5MGjbZQElxpw==
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
 .../bindings/display/panel/renesas,r63419.yaml     | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
new file mode 100644
index 000000000000..e4db01f88302
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
@@ -0,0 +1,97 @@
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
+  - $ref: panel-common.yaml#
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
+            vsn-supply = <&vdd_5v0_pos>;
+            vsp-supply = <&vdd_5v0_neg>;
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

