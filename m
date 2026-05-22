Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1339CD5BB0
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 12:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D09110F5A5;
	Fri, 22 May 2026 12:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nV3u6bDq";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAFE510F5A5
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 12:51:32 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48e6db3ff7eso38250945e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 05:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779454291; x=1780059091; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=nV3u6bDqzbupXEGKElv4smy1xBpjpcEQ970RgvhesOAhy3rFW3nBno2TyCAN6+B2V6
 m8IqvNLEpWTBH8EqDQ4JoFBz9iVroU8tTHbGfhmeTEoM/d+Oorffv69ieNWEzA/0MZw8
 5/f//QbZcz5Joxyfw/cornRUI//SQE0xdGVuMMSDuLk786PpolRJ6H8vpUXGlDgigU9W
 06QWvouK5w0hV0SkpK5x9rbPmbbx09X1mZYv7ILhB8ZFnYf8uMH3bXlKPAu2qUtKeLEY
 9H2NI8iOmXebCd7BohdWN0+kwZI3W/WEQ7a/xdc/5GxJpOFYX7gjnXXNkwJlr6RKK64A
 OInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779454291; x=1780059091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=BVE02gLisGTMD+xaoV9SdaPHnAt2AlY6wTCn79krm44sOfhy4o3O2rMddZbkKlBaN3
 +SYauXAAMGIxk327wSWb9wMyowbqLoAoqDLC4eAGnsWfC0LVx+r1pcLsDvl2iY8+JUoj
 RqIdPrVJUv7tkmtLg9Fz7bdeCncCJuzHZ/tW1rIu+3jDfqQdEEcj7g8kfFhjyzJyHi2O
 AehljdendhrkXAAyaYp76Gps3bRMxDUKvLTuBEg4vBGKlTpKYPHAaYZS3ajqUsfYRyay
 h+pNHxxUozftBXXjR82nCfkpcnaLDb56N8unKVFFOqJFaWYtEWkn9iD5OT4DzupfKLj7
 BGvQ==
X-Gm-Message-State: AOJu0YxkeZrrsVIN4DsAbgD5B833aw4tUZJu3tl7IbzY7JDOiwMUxuLp
 PFVJv8uj116p9tRsnH9RlZsIl3gPor5aMy9U5rw/Lq8WLa2d69N+aEESWhGWOm0famw=
X-Gm-Gg: Acq92OFktSdR7GcRwird9hSaOTSLQkhHXk/iOJzvx5LnKZhu9aLZ2kK6v53pg4Mhfs0
 jWKnxFPb0MLmwHPs7YVwOAc50of3arTfhMUHkWsVUYp0tI3nkL7FDg6hnB14lsfJaGdbdH0Acby
 6D2Vovx5YY2ssu7M2ecLKEQYaPzIRb5pPVx/czjlnasLYmWn7H3EppN+s0ooWmrYlK7x9yDtxU5
 0w6VyOT3qqJYAh2ZRF28lmZSNOhPkFEdlhr7GGrhgzVunDgoi1WWp0T8ONXFpucKs1RsxoHNN+o
 es1B4TCx/knfGSbeU1eyd9asxJh/BqBUd9DQN7ZclbmjYbdM7ck0NS45TlTpbd0bSTSp/oHFwz/
 ioJtzo7sJ2k4p/flxucL8dALWxvWEQHGH/tmdMYZ1ZHPURGYnbVND1jJT28ZceuiAE1W9fCZF9P
 YI13Ng1NCyqRfUFM4DhmjUFPp2BKivxEq1bTbQaZ2DHI0n
X-Received: by 2002:a05:600c:4706:b0:485:3abe:ab86 with SMTP id
 5b1f17b1804b1-49042487e09mr43922615e9.4.1779454290883; 
 Fri, 22 May 2026 05:51:30 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042af0ac1sm15046735e9.31.2026.05.22.05.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 05:51:29 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 22 May 2026 14:51:24 +0200
Subject: [PATCH v6 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-1-16edddda9951@linaro.org>
References: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org>
In-Reply-To: <20260522-topic-sm8650-ayaneo-pocket-s2-r63419-v6-0-16edddda9951@linaro.org>
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
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Zq5948yoVNWLdfl4Pn1AIZbbP3FPXFuxs6toZA6iUAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqEFFOfq3UCxutsZFfJbNgQzCr9Pe9JF3OWtJqZU44
 xvvV1MKJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCahBRTgAKCRB33NvayMhJ0e6pEA
 DHEMP2sMN6Kwla6g4alCmQmwvGarksv0qU0DyHFEQi2R+b2n9eyrQwhBHywtzG74qB3VjYU6ge1BNa
 8mZDfyBFrQzFNN2ozaxfNxeUZ4fBjUCT2ajqiVAWsF3ac9VlG+uvxI4qyaWgKq1pREaMNHBhF/utx1
 18dv+/t5fwwWhqYjb5BBEobcQrns3GcsAaSkf17EMIOk510mWnKvqgOlbCiQqqrx4YdOt8JsN1Dtna
 ZAZp9kJ++c0g3kePMS5FNYQxbipdwwCu8j4MYry4s1LRwLkVqd+QVM4IztkKWp9JF02OewZqnwBhmS
 4bjw+TA7ZpheQ1LUiP3P3Areg5QexTgEYwLP6jshKrA38OR00HBWS4ZMA2jqgjdqXli2e/JrXuOc74
 lvg2XaisFqqSs7E7XhcPQhD70c3gAt8TR1qzuV1jLKEo7zxqDOZi5DSS4Aj7OZxx4zCt01j3/OMa1+
 oinZfnWRGXHmF4jse2IHOHc5RZC/cb3fCo1SKPydbUqWNg5VkYk2pI6+HofhyH7xXjtjNPDvP30KUb
 XymewUHMWuS8s4cg1tLUcgsrHAzCd3ilaD605RDiVVZT4tl+Nlri8vIc1FZr8omtBhaxfBNFmWwjyY
 Ph0KN7c4lLuLnvmIQj3/QO+YooeeLbAZp15e8HHHX3R3rd+jn2E/7ZxZz19g==
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

