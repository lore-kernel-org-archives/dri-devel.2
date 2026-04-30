Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77AFAFF8873
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 12:22:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4427C10E420;
	Thu, 30 Apr 2026 12:22:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="h/RcyB5p";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36F410E156
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 12:22:24 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so540849f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 05:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777551743; x=1778156543; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=mqSPEVNWdzhGnvF/jE5y61/ywNE5WHuXEKLUJIFyprQ=;
 b=h/RcyB5pu5iZFMZy3zsXXd96r6w/4PIFo+WGETYkZ/oecVZ1HTuuq/MKkD9L14nbtF
 xQ/vCONghGqIzP/LaMiBGdUXXQn0Ig9+lQBs5vrbKEyzwZOdWtYA2Qx1jQS9rtmpfm4y
 QOzWhrdkYFYMX1uY/inRTLJm64PudCUri2FaqdSm+wNfLLVlrc82XWNqVZt9aW+evKkY
 HUip1/V5bkMhvG0C9GfX4pYI/cW96xE8vHkEAFWn5HeYn+gi8ue7Mhtv2f32O/cfXDcT
 12V87KWxTdopdK6fbHQRt1NLFUuhpnyXuluZdZy+dG+kFZtuppZuzQGx6Z45nk8Fv5zF
 Tscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777551743; x=1778156543;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=mqSPEVNWdzhGnvF/jE5y61/ywNE5WHuXEKLUJIFyprQ=;
 b=iIEYvNc2HS0UA5U0R52i4MsgmOpiGSH7G7YbMWsE3X2xw/2l5EvwInm2D5GQZPGOcl
 OLgMuEH99tlFifkG6gDIkrRjiThFzfk2MUZa3s0sNerVJlez/FmBpVXHPw3T6mUvkC+S
 Xbj94mvuOysENhL0u7DpRAvYhjOMIaZlmOlFi2Sh7G7oHprFQm0FOJG4HHg141Njs1qp
 LSLwxQkzqE0ddI2HOeH9a3hkT1YnJlc14xdQRze6uGNUbiDp0d9UkXDBpP6sXhRCg3ue
 xmAbUCcJztBQhRu8bmFrMRPTtBPfAL/GRyudbtVrpmEmdjhMSN3kNj84mpPu7lOO3CCj
 wUeA==
X-Gm-Message-State: AOJu0YwLdCdke0TmHuVq2P7d6Viu/W8JZccDLTHYlf9OYQ1o4cOwXlZD
 urSlcV/f9wdnKtJCF5QU96DZiax59npxNm6CbZnqh25DIBiItQ4t3re9qfBTyj97rK8=
X-Gm-Gg: AeBDies3W+ayFQj6s9C6G3WiowglTth79Y2HfVdXw0IpGcu7a6xAGid919ctEsrqEV0
 c+cbSXjQ04YHFR3/iEXMugfBaWnS05TeX2jbstSoXpEOWe4tOTXZcV/oF9k6qVenKRe3dtSFUKs
 /wPi3eH8ac7MT5Bi5mzNLzBl9JRdGnNbcAwT5KJcyBqVKJWMZggK76uFyUNWOpuMAXEH4FtgiPk
 R3yxSSmhcttA8xFlH0FrJHYNOjGDtsyciyfgj1ppLBZrCSCdKmJoHktavDV3jrM9H5s9Td+gbzi
 YtZWBdFB9zOIGc0XxALgTh9oCwOVRMyGxziY8+OSjjbSh201Q5gqqn4qytUq1lxuiF2uU0k9AG7
 hrUguQPzdswy3Z7dMAty2EtgbbcLvnCktIlWsmS/oBdGlCzwwOXaFCbRrMGbSo77jjmPFtGibJ7
 JeqCV38eL2sb1s+Y223sbxCkQXG1ulhH1l2UUTAex2Rp5Aeamxeez2GLc=
X-Received: by 2002:a05:6000:2c11:b0:43d:775b:c9bd with SMTP id
 ffacd0b85a97d-4493cc3f4e1mr4471272f8f.10.1777551742666; 
 Thu, 30 Apr 2026 05:22:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5afesm11163639f8f.30.2026.04.30.05.22.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 05:22:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 30 Apr 2026 14:22:17 +0200
Subject: [PATCH v2 1/2] dt-bindings: regulator: document the Renesas R63419
 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-1-91ac10453d0c@linaro.org>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-r63419-v2-0-91ac10453d0c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2751;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=+V9qQskvFnz+tQNPmsOKTsUJcit54OEmV1aigZgDvfc=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp80l62HKL9K4J8hvdijJJZG2PHZDyEsO6Po4qCx5N
 qYlggpaJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafNJegAKCRB33NvayMhJ0VJpEA
 DJz3x/HNbPOOaSDgi5ma3eRfbo34RgGYD2BONqYCSL937K4MZUoE+Qtu37N4o8LMRJFit9LCBvUmMZ
 bQrYz1slpPxDrB5JiF6TGRJbEwMfT12naqh9PFIcltOXA7Si120DWsUlkscR5QV54SXCOpe7BJdgYc
 pkNounhKOyYPEwxKBJo4mT6nUvp4JsQe1bO8BCuJDqj9xko+biYTbHmUJXfHTg3qhWSmPkrby+GtH/
 YB8RgKXTwx/YL/m9AcPlNNT0bOfFUvtufyPdVvXm32YZZg2B4J2QOlMCl7sMdFLrswEThE1kQ+y8Cm
 MviQow9MWZpguavEO43ZwJuOz1GxdIMCKtmQ634eMDljyrfF6UcEr+VtndWP8F4eiuZqViFXjhugxT
 5viWPg6BDNAQ1XzeUKHQ2UK95U5ID7qP6jEdtZFztD5yydyKN6NXi7HQhlEyMN4svunIwCqrFBjs9Y
 Nt8T8wPyFC/MtRDqzGa08O3bBeyYc42Gpc4JYWwHDULSzryGRF/Bh2IhLW4pPOhUbgrCuwgtEpP2d7
 gPhrxKf/n0pkPmgHds331IEKc8pkHN9GkipVpC+5nloeiVbFUrv+HKYq6Z/t4/FEVCHZSwbAJobvMa
 YbfIxfi1Mm3mOpxFPnkBW5v6sfmKLla8oRxwGmDXvPzsQ8C3Du3B6eocPiDw==
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
 .../bindings/display/panel/renesas,r63419.yaml     | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
new file mode 100644
index 000000000000..17f166db3ca3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
@@ -0,0 +1,93 @@
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
+    enum:
+      - ayaneo,wt0600-2k
+      - ayaneo,wt0630-2k
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
+            compatible = "ayaneo,wt0600-2k";
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

