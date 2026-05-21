Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D94FCD5BB5
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0164210F379;
	Thu, 21 May 2026 14:47:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="LtHI7ptB";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECE8410F361
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:47:28 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-36974221f93so3403248a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374848; x=1779979648; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=MPjL0X/X6YgpMCLcCHGKLym9NxiiWm8gzz8E+L90JHc=;
 b=LtHI7ptBD1dDS7u6iKylnlruufqr1vz96xlRaMIgOSQK6yTkxLi3IwAiowMG1urHhU
 dDTSgnuZFoq9IFlQWTXAqPsNfqvaGeGcRyZ8YGo2JK3hwfmVc4J7uw+G3991WhLzY97L
 HEQpRaz+ODl9W53Dbi276M0GguTRuq5mQZwEXMFYIouLkbFBC3j+bd0tl4MbD2QTD8yw
 WqwAOPdNoscDvBY7xO0QnKG4tB9PTiMj0aMQJbJPn8tynfHezN2JG1AncXfZwS7Wy/OC
 C1AwQflPHgyumuJnD5yUaKCX6OWRAbCFIogNg0wUbfq2Mdv2n12pYkccDy5b3BL24vMC
 03aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374848; x=1779979648;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=MPjL0X/X6YgpMCLcCHGKLym9NxiiWm8gzz8E+L90JHc=;
 b=NTs2MhmCAJPIpJtaq4Ef7DXsHyOggR+is3A6U4iF8DgtvEExraTdZjsNpz61ybR1GZ
 Q34WpJJQIWlMzl6Cxm4SDdRtJv291KRkIrUx0YB6ax/f8NbnxnZRwow/30+P6/4IQDli
 TbS6SPBSK604G0786t6W3CVe6hITwckAQu+cR4ow9/gPwRYfGssF1Ag2ijxjzytPqsQQ
 M4VIPgdny7FPxqWzIXALmor4EqlXVldNLQQmUFOmfOF9ZUuaJcgIgAGVZpPjNL2QABnP
 N7r1mpuUYBEZyHveS1est6LNdaE22ejmOVriWHHEYT8ONgjqaM3yw4IflMe695Uhs4eR
 pYGA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qMqhSOoqZI5C8higc8zaAyFi3bEGW73jvw2mC+plBtHR7HAdG2lQ/mJC/08sS2dnQSVGm7zkT5m0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfdOaE0oU3K6SzjGcE8E7/e/ZlEaFmdsUUA6Va/OUZ8TML17S0
 9Rvqut1buu8BQjF4LhNUcD8NqQUWtF8wo4Ofp9clR6LE8U9pQof6+ypdFyy+pdMECx0=
X-Gm-Gg: Acq92OHnP2/O52Cs3/4Ud4B6XpHgY8Jt6DHK9Ldjpvp9p1rnWXr8KX0NkRKKRRyKJ7b
 ePmvXJwyznTEYIOwta0zu43d0EvNg8qyO7tGFYLcBCVRtBO4IxAqM0CNihevAZMON3lKOwJh0oo
 AH58x5XwMajhgp9Zea86ZFDYaa0gdXToEgToMkxtYNCRyBHIy8PmwtuEF7kFzHuV7ZzEDJsPW7v
 Kq+4jZnnzYBsymbaWJ05P2Q3E5APX1unOLKL1VeBZFiT8GCuHDKES07omxBTcVFUaoJfi1XfopG
 vaIQrNfqgKucJWRFdxX22gLcDavsTjkkvIc/Ul35VAjOOheFA7xIMkmIUo8Mr4suieF80ROb+Dp
 XA2OqEVPWvJGzPTHgBNp6JHvz/4rIZ8NV1Oep75aFnZjWw2iwSJzN5p7qbb+WnicR92o2fA==
X-Received: by 2002:a17:90b:3d47:b0:362:e826:cefe with SMTP id
 98e67ed59e1d1-36a457566acmr3539155a91.23.1779374848359; 
 Thu, 21 May 2026 07:47:28 -0700 (PDT)
Received: from [127.0.1.1] ([2a11:3:200::109e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5bff3ef3sm476527a91.4.2026.05.21.07.47.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:47:27 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Date: Thu, 21 May 2026 22:46:06 +0800
Subject: [PATCH v4 4/5] dt-bindings: display: Add Synaptics R63455 panel
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-sm8650-7-1-bonded-dsi-v4-4-a4dd5e0850f1@linaro.org>
References: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
In-Reply-To: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779374785; l=4249;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=hIuDotw+GX5XbmOdxDTJx395z7b2RsR58qNFPRHASYc=;
 b=mGMAqj08bFdadIsaW7gwyfQxIqW2VhchrrwDKjJ7yi/lAwPWhQ9H5h5lXi2nTdUAqCK+wS9pG
 ya6svtBUFxCBqLgW95ChM2ub19tnbouMniUCfgpzNM1EF0HycM6c+R+
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=
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

Add support for the dual-panel system found in the virtual reality device.
This system consists of two physical 2160x2160 panels, each connected via
a MIPI DSI interface. The backlight is managed through DSI link.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 .../bindings/display/panel/synaptics,r63455.yaml   | 125 +++++++++++++++++++++
 1 file changed, 125 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
new file mode 100644
index 0000000000000..a94b355ed9557
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/synaptics,r63455.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/synaptics,r63455.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synaptics R63455 based dual 2160x2160 MIPI-DSI Panel
+
+maintainers:
+  - Jun Nie <jun.nie@linaro.org>
+
+description:
+  Synaptics R63455 is a Virtual Reality Display Driver and VR Bridge, used in
+  pair in Headset devices. The Virtual Reality Display complex is composed of
+  two strictly identical display panels, each driven by its own DSI interface
+  but forms a single virtual display for the human eye perception and thus
+  requires a strict synchronization of the two display panel content update.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+        - sharp,ls026b3sa06
+        - boe,vs026c4m-n52-6000
+      - const: synaptics,r63455
+
+  reset-gpios:
+    maxItems: 2
+    description: 2 reset pins for 2 physical panels
+
+  left-pos-supply:
+    description: Positive 5.7V supply for left panel
+
+  right-pos-supply:
+    description: Positive 5.7V supply for right panel
+
+  left-neg-supply:
+    description: Negative 5.7V supply for left panel
+
+  right-neg-supply:
+    description: Negative 5.7V supply for right panel
+
+  left-backlight-supply:
+    description: Backlight 21V supply for left panel
+
+  right-backlight-supply:
+    description: Backlight 21V supply for right panel
+
+  vdda-supply:
+    description: core 1.8V supply for panels
+
+  ports: $ref: /schemas/graph.yaml#/properties/ports
+
+required:
+  - compatible
+  - reset-gpios
+  - left-pos-supply
+  - left-neg-supply
+  - right-pos-supply
+  - right-neg-supply
+  - left-backlight-supply
+  - right-backlight-supply
+  - vdda-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    &mdss_dsi0 {
+        vdda-supply = <&vreg_l3i_1p2>;
+        status = "okay";
+
+        qcom,dual-dsi-mode;
+        qcom,master-dsi;
+
+        panel: panel@0 {
+            compatible = "sharp,ls026b3sa06", "synaptics,r63455";
+            reg = <0>;
+
+            reset-gpios = <&pm8550_gpios 3 GPIO_ACTIVE_HIGH>,
+                          <&pm8550_gpios 11 GPIO_ACTIVE_HIGH>;
+
+            left-pos-supply = <&vpos_left>;
+            left-neg-supply = <&vneg_left>;
+            right-pos-supply = <&vpos_right>;
+            right-neg-supply = <&vneg_right>;
+            left-backlight-supply = <&backlight_left>;
+            right-backlight-supply = <&backlight_right>;
+
+            vdda-supply = <&vreg_l12b_1p8>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+                port@0 {
+                    reg = <0>;
+                    panel0_in: endpoint {
+                        remote-endpoint = <&mdss_dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel1_in: endpoint {
+                        remote-endpoint = <&mdss_dsi1_out>;
+                    };
+                };
+            };
+    };
+
+    &mdss_dsi0_out {
+            remote-endpoint = <&panel0_in>;
+            data-lanes = <0 1 2>;
+    };
+
+    &mdss_dsi1_out {
+            remote-endpoint = <&panel1_in>;
+            data-lanes = <0 1 2>;
+    };
+...

-- 
2.43.0

