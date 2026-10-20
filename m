Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1F4606A319
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jz4qkjqS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4771A10FCAF;
	Wed, 21 Oct 2026 08:51:53 +0000 (UTC)
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B9910F11D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:10:28 +0000 (UTC)
Received: by mail-pj2-f2.google.com with SMTP id
 98e67ed59e1d1-3ad6011ecebso324911a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792501828; x=1793106628; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMXtQLb7sV43jXsaXOJM86dQ9CSAx4ee+JilsAAN6V8=;
 b=Jz4qkjqS3sD4CYlChfnnc7IGW5Ye+sYMLcL84wkNxa4K40qF1yf8E7hsgtoUQ+Yv2/
 +A+NZHsc94rTs1JD8c3RMXSb3rnyn+wHl0Hwgg+qBarKiydaHHsy8/02zK7ajBEXiGBt
 4xmt8Uai5pHKKMgKVVtR0Jhz00UahZSohOQZVSKzPbZBLWpN+HM4Ml/qD63XTQlOObio
 dFRx/6smHLNDIYC5Pv3MGSrCcGIERsqd7q4qIl1hS3p1QWPiU43sCar+AQMbQv5XDpHJ
 tLytzQ+0SrdNbktGaJTNjTyRG6Y65r7KWZpo3rOcXg51L+90cdbl7mGXq4LYWRr5bdiM
 LJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792501828; x=1793106628;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMXtQLb7sV43jXsaXOJM86dQ9CSAx4ee+JilsAAN6V8=;
 b=yjKNvmk5aNqYhox+WUQNuH73vOXl+ZRxHsYrj15k+ky/86uwk2PmJqIDhglMnEqibU
 DS/8AVyP2oN2t0l7jNHzYD5XvodglBmVrqehErJuEcfdjxf5xUaG0BNKad4dwJAz/QxX
 lxIAUjTvXFl0ZX2pGWH+xiZv3P5e+zB3sd9VDzlwZ5VDt9/wkcCalqkiT7JU9itoRtlx
 K1Zh90Kv0hAAwxrZOwM52nMSxGF8cc9ZMun/+ybg5VYGh/uuxQv+twbZIubIa3zSYmx+
 1KH9/ZQ1fZjRZZbPrMfQu8vwm5hsupQIkF2LgHXLktcnglwEFZeKqc12BV8ZE9+mFTxT
 Nrzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwW6I13VTcIetn/jRnFOOfALe0X+jaU07OnKu9pt7YyghDiRiqoks3uuYIUJ4ikplGbjn4wppRyO2s=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJTrc0q7F4W4JFD/ddfsl9m7wyVCuUEw6c6bl/uwh0jmiBQ/JDJ
 PUN5BdflCchj8qLhjUypcvlIBlEQegsMy10zxy9Q2y6m4xdNIlIrawsi
X-Gm-Gg: AYBFou1Tjf6mXjKma26hgx9HIBtwPjVW4TjC18zqneWTCxv8i1anAAmYGVzz1zU5p7G
 iVAGZd1OB751uBJd30b5v3EFziJmfYRg8+9l03F5BWy2BuNb3UWNWH9wFQGdK5XFb07xayOSY8p
 XI8XK3cOVgE94xwGdB05UxqZX6LQhz2DvQ7uIgamfLClXPHyOywzDlCF1gIkNnTLRBgDQ7BDZjB
 qn02qdyAQrKJKAEUARmK1lwP9GVMfE4yyVquxD80m6cU2xosmOaq4sExb7h09LM4a1lxY+NBbXp
 RCsgLQceMBwiuxBg5+wm6D04wmo/J8FqXqX63xhZ9qpOGil7FCfFFuP31fiyoQZ3IGStqb2BV69
 SbH/i5AOVAn/ntECBlwgcJEb0WRfHYsQqN3Keg21zXgSjjFcZ05TW/KfElEDMfmElw7cYHrKAWy
 pcn3x4vvwwJOeuIOBPmfUSwqNwhmzzB76kY9QA9KgTZnLmaaTIqgXIgeM=
X-Received: by 2002:a17:90a:d00b:b0:3ab:f38:2b41 with SMTP id
 98e67ed59e1d1-3acef29e6ccmr8123502a91.39.1792501827888; 
 Tue, 20 Oct 2026 06:10:27 -0700 (PDT)
Received: from Linux-PC ([2a09:bac1:1980:20::1d3:a8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3acd3cc73c7sm10131496a91.4.2026.10.20.06.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 06:10:27 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 linux-kernel@vger.kernel.org, Lu Chen <tianshi12127@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 2/3] dt-bindings: display: panel: add Smartisan TD4362
Date: Tue, 20 Oct 2026 21:09:33 +0800
Message-ID: <20261020130934.2289011-3-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020130934.2289011-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261020130934.2289011-1-tianshi12127@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 21 Oct 2026 08:51:51 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Lu Chen <tianshi12127@gmail.com>

Document the Smartisan TD4362, a 1080x2242 command mode panel
found in the Smartisan R1 (trident) smartphone.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 .../display/panel/smartisan,td4362.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml b/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
new file mode 100644
index 000000000000..d9a18cbe635a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/smartisan,td4362.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Smartisan TD4362 MIPI-DSI panel
+
+maintainers:
+  - Lu Chen <tianshi12127@gmail.com>
+
+description:
+  The Smartisan TD4362 is a 1080x2242 command mode panel found in the
+  Smartisan R1 (trident) smartphone.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: smartisan,td4362
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  vsp-supply:
+    description: Positive source voltage rail
+
+  vsn-supply:
+    description: Negative source voltage rail
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
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
+            compatible = "smartisan,td4362";
+            reg = <0>;
+            vddio-supply = <&vreg_l14a_1p88>;
+            vsp-supply = <&lab>;
+            vsn-supply = <&ibb>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
-- 
2.56.0

