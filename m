Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E5DCDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BE0110F1CE;
	Thu, 25 Jun 2026 09:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="IWXKke4w";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0341710F1CE
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:29:13 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso20168095e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1782379752; x=1782984552; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=IWXKke4w1RW54+rq/EHMDehth2Lfjj5uRX4l0goqqni223zqdiq2KYLcQsRGAFbt/u
 v+n05l9PomCvKmj5j7BsAg2NwIVVBhRq+QJ8gogImaMj9MlGjpUe07vFETjjk+UjpNhp
 NpIsL/bMtkfb6juCiSGXFtlxNHPGs4CiFTdtjH7/sJsZuSHN36vXHj57hE7EvGRYbyz8
 /0VkYmBE1pR1qlGZbZud81YTXB/o7eRr3qL33H7TaZxrkQ+izDB1WGbgRD7XIV99+Pyu
 E6ujAdJzq9nANksD/opjdOgOvpZJH0eFxIIj9ULTxAOsKKAj6NOtZuAm3taxxgu2yhiD
 9Ing==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782379752; x=1782984552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=AQE+pTFwkB4IG66WszaCniSMiPvSycmG5s+CCA491BdL0H8k7LaoYs1UZwWGuf4S6r
 SY1CKr/s5e3vWP0BYGe0V7Yd65vVIVK55zb88C+5xDO7yemn+WVv5+EpJa7aS7px4O1S
 4R+U4D92qBv95dIoehjj3rmtf4tA5u4xmKeprY33pQ4najImRQ+CYLTB67BWEMAFACMZ
 8LXhkgUn4mNWaUJESoAOU4lGRZqZJfQO5Lbjx30VWR5FDP28UNDIwE+/IZe1qdntzBId
 PSzGfLUmV2JlhwZMAgyI8dSUbnJsIt8UGhV0+z35R5U/8VhLL6ZneIYIxsNdmlvj/nyF
 lZ5w==
X-Gm-Message-State: AOJu0YzQuBaT0qsg4VJ4NFQicXwZni9zFOAsjcHxTUC0QtQJXUDQ+jag
 hJTPh2vziLyR7nx2pxpQcF87h9/TBZ0ctCWGHbp52zm9SpvqUhoh7LaYuTY9w+Epaas=
X-Gm-Gg: AfdE7ckZwB1l71+cdcDFYIAhai7VKRuNyfmqCN1Q8piMXTu/Xk5mr5YRxFDPS/HoJZ2
 qFKVQX4E+0XOj42jfqZc4Kz1GsF15AAekUxRh1tSg2+ooyOVbnpnBsywcHybUnd/D3Q+ffPJcaW
 kgNcA4B4aw9bJ0rh4X0VhMIqf9/NA3fI/41DOLBJjdRAKN5bU25Fn5JO+YBNB4yWnNR9Fsz4+8m
 Palt2KFtdbToB0xbN5M56todwNp1w6n7Quf42ctjfRRyacAX9p7zbSQpeA3mFVQbCCqkqU4gU6D
 PVrJTMHL1V+G1rIam8cyQ55pR/mWxjscc2R82GpTjye8z3CWk/yI4TJRwvMBjLEJFJkgwxu1Qm5
 Oq95XsYthvOhmvXWAT4tVnXMiZtmudZS7109ZgChpCl7Pnp0rjLJUdAPeFe2g+Ei7o5XeKICE0h
 5dnn9wwMTS4fECOIidfKYkncGkXcqIYo9RQMuDlDfS8s2I
X-Received: by 2002:a05:600c:3e19:b0:492:4c5d:4db3 with SMTP id
 5b1f17b1804b1-492668322camr22201945e9.5.1782379752224; 
 Thu, 25 Jun 2026 02:29:12 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4926544dfaesm33846195e9.2.2026.06.25.02.29.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:29:11 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 25 Jun 2026 11:29:07 +0200
Subject: [PATCH v8 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-1-8570e692143e@linaro.org>
References: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
In-Reply-To: <20260625-topic-sm8650-ayaneo-pocket-s2-r63419-v8-0-8570e692143e@linaro.org>
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
 Doug Anderson <dianders@chromium.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Zq5948yoVNWLdfl4Pn1AIZbbP3FPXFuxs6toZA6iUAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqPPTkTeZqdgZmxqYH3uVuo1O4jxHMWl2Fsf2K52mL
 XcPjZkCJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCajz05AAKCRB33NvayMhJ0QZfEA
 DFwB+HpIp6G4Bo8rIlaXtFhEUrw2RIvmGm1WEliAXEYdOR6GgqRM/qhUGTUv91gUYufnqxOY+rV7TH
 VyiF0WTPqIAmZtkif6FpcWibzJpPNXDgTfkzONXv7L+qGrieHM3b/6tCDdVftMGj7Tn+VK1spfoPu5
 3dEGHeCQYoS0vss1uqyAAEVWGjKO4gpZXk/YFLmDguZD1aTIFPfcikuGpSmYPpp2a8bQv4FcjeCp1R
 i9zgixfJn4DJ0OEzA/gQZCSPhpWyFr5V3/SDdzfQJQvcz4rpAHlNJ69/7X3eL85WtuUXHuXF6uT1Y2
 1yKKC9X7v8ayyYkAOVpomABJ3ppZ55wbVlt/ExODC/n2gFLiKLuI8CXXU8K5LVurIqSCnmW7946IS0
 FwwinWnDJE2h4Q9Rq/FQF+Lw9egomlnrCGsUHGsO4icQTaJsAIn/XM27c06MK4xp/wT5FrkowV4ahu
 3TXlGQNHqo77Gsow+a0od3GfwYtyQeujXv4cEi3AgBeokDEV8WE3P+uODPLgUy/ULNxhu1TMdYXivP
 oQ5/e4bmv3ljFwB0HJw8p4XaSBRFo6Ce8plzbBMWL4WYMIdYmRyPqvbfdNPurJRQ/joLd7ygkXwqmQ
 kYDgNbQ+c3+Rg01Dv2oMlJiLh+tKlNQLzKCmE3NQ02cyXatj2vAkSNp5sTrw==
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

