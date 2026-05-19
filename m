Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94376CD4F52
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:09:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEE2D10EB08;
	Tue, 19 May 2026 08:09:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="UAR1q1Ic";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DF7210EB00
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:09:12 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so35470005e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779178151; x=1779782951; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Ty3MbPaO2vFwqPZjz6jT7S+J98csHl+q0+lwLd9Yl/k=;
 b=UAR1q1IcIE5RgmSkgXC6x9DKmL6rZ1k4bZxhtfObyYUjzbLEJHec0C4wrSXHmR+nzq
 mt63txZb1J0ALYQ/8iurdC2JahOGBZLx6F/MPTSU63h67+b+DG96RFy15aFbN+HFStLq
 QWIuhlgUwc0+RxTKhOkIf61jhAiDHG5513RgGyQryTDH3eKIycJx8aemZ0xfcCB0r041
 b90KGM2n/TB8K5/rCtBJJLIG56R4tUD2231VUCR5W5FLQODBAZDeOYJJ5JFU7fCUqJK5
 mSkfIbLZ+5AFNPO5aLUA7YI6xJtbHBCVokTiQjrq+6T8hpjFLsuxSdGxAUgEBf4S3xfc
 O2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178151; x=1779782951;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ty3MbPaO2vFwqPZjz6jT7S+J98csHl+q0+lwLd9Yl/k=;
 b=U3jvVIzukFiqueZxKQpsDnPA4ziWmixZne8BbN2P59kcSHQxwmXP434mx3K5uCu02I
 2CyWYqAEMvQBZns7al8VFTnfSO7+l599ks/2binOswRReyWLkfI4YWvMCzXgDU+DPCxq
 tCGnofUJMULBORsWXZK1u8G3kFqi1E9wXS36XWZhcxDcWjrL8TWNTIgQUxGDxplbLGOc
 cOCvzFkGUapBRWeG49aLEE8MdV/HlFVwiJHSPYV9xrGpdF0D8io2FbTQR4URZTPCa2uH
 G2Aavthqy/HHPpiyzTX8fVlhwuhHhW3sX/kOSiHr9rQHKiHhKE8a0GgI/6WfCfS285ni
 lcuA==
X-Gm-Message-State: AOJu0Yzv6MD+a/exUFoMLuLHEojQlviuwkarysWQrwd7YSm7sm1YRK2N
 nusHRZWJafqz4kBqTsHZuFFPw3Y+zCavaZXVda6dZZaIgne8DBGGpRqaFU/j+Maf5QI=
X-Gm-Gg: Acq92OGT/fqjZHv4sQFyS0pkYo0B8vRdRu9gC0tUITz/7pxdKFJeEWP085gIV9xIiPz
 vjGWp5EYx1yTMQQRgtcX3/5HSSz691VBucFLfdq5GdLqyhJAsigbQy4+DQ4+pQMnq/umOjEPYoM
 JWsB3WeIDuK2ozJk1bYxU1gu+mLmX08ZrHa/GbAc6AXHuoWlvkNbBAJJz4vItCdA58BVIIiMKvD
 ePfCwxG/6REzkc3wzxE6q7LjpmQr9eLuOE7tfv4pBT/yfjy/Tr96WZu4MLtzOt3T+tOESnr5fkN
 ld85eOcA2b5LjXB5Ti2GPy2u6bFd34SdLMgih+mpVeuTci9SZkqzban8DkK8eIhbQcYMqjMazQH
 sJnbd/cw5UsCA6A2Vkkm7WnNGXAW6uH/d1P0X+hNwtDiF0mW5qE3Org48TEyDR53Z+qtYBqEndS
 +mQTF1eEkVKusyZSthr1IVtvtmtcn8Vn1ywtLdzh0Iyrho
X-Received: by 2002:a05:600c:a4f:b0:48f:e230:2a24 with SMTP id
 5b1f17b1804b1-48fe66204e8mr265626475e9.31.1779178150834; 
 Tue, 19 May 2026 01:09:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a1a22csm42856373f8f.19.2026.05.19.01.09.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:09:10 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 May 2026 10:09:03 +0200
Subject: [PATCH v4 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-1-b8929af5e951@linaro.org>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org>
In-Reply-To: <20260519-topic-sm8650-ayaneo-pocket-s2-r63419-v4-0-b8929af5e951@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2860;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=74ON2gxJ2EbMlsMpx0629ZNhdQsnwZKCfK4Lcaq26K4=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDBqk73LPPYI327526USPaCyHJw20Vj/4ghKvO5P/
 Jr/lFtaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwapAAKCRB33NvayMhJ0RKFD/
 9Jfwj40U0BJVK1K6/jNsfgqHv2oeaPgZ4Gq91/o8rZDwuIKknD5e+MVYdb25pkr8xm92c66LqRSBcB
 NDMLfrfbOfQkdtUZi2ZQq9ktebe/N05dlEF6DBwCRxpTv9CGCWmtcyVrCfWWjcGrMA8rJtnU6GoTWa
 K935miaPSGwpx64Ag1Zg4vqMRN4lYrLQKW9d/Jkoo06532/kAqGcXpfmDAMqab20zWJNDq2ALEGZf1
 dbxypjJFbZgBsGfJXfva42ExqdR3OCmxbkl1PwFOYeuMrI5yeBUk2vQHfVcFgVXLIPSEn2/7wXCryb
 MzmBNvCrsP0BPcLGYLoHFkp5URrQjQAh8M4XsFjkfVMVwiAl7lfm1DG3nex501ZE1PRKFynTHv6OQy
 +Ta227jlmeWNeC1Qbwot1qyVKiHb6I8JURqDABOq9+NfQ4+sy9jaPvxfNsrZi8w/bJWDGkIS+1yNuj
 zsCeSLkv4pvGel6wBZPDYyc7DFWtV9Kwr3U+583dLSESPSXIZsXVgmZo6uDm9E4nMZjs8TavTpjAHA
 eB1Tusgbg9GIpQIGbyAZ0Nb05vU+RVR9bh2F7xFxdgvGuUnCHUHqFUgYfFcbAZdvtWyxAJBClza+GN
 rmeZV9oKdetkGPsGcj8GjTCqmJ8FR7UooXQLxTYzU0PD6fFzsz2Rocjs2OAg==
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

