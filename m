Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E27CCF2C9
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACA2F10E697;
	Sun, 18 Oct 2026 14:53:56 +0000 (UTC)
Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com
 [74.125.227.138])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77EFF10E3CA
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 10:33:53 +0000 (UTC)
Received: by mail-pj2-f10.google.com with SMTP id
 d9443c01a7336-2e934c6c20aso4014965ad.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 03:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792233233; x=1792838033; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RJMiI3zn0Ah/6v7E7BqKNzfu3zqpMlEsQjtNsehcFhg=;
 b=LyKkubKJ/3WlQLVah54+5SRzW43jcScffE523jG6cy/hxjhFDBb+9EMPPkfHsOhdEA
 fv8Y9X8zrUm/cKZwORhqwXEzLPDZcgliW5ZBnnuCclLJjjogZg3DX6hu4cqynu9o20fE
 JVBcVJVS2zGZFzaVrR81aIzZyOkLufVWWeirl7A6ZZHVAVmIpjbweB1SVrZCesP422I+
 8i5ckvFiA+ASBTu6b7IgU8LkYxyBJ6hTY8SgI6jfmFJ2sB7GN40/ObrObqxF4buJo8oz
 tRhcxrYLLiNgelLpFGVAmEBn/cicVgvzqEXXPnBKKIYPZ5XoN9i4b3U9xhToMbF3RyVo
 Y5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792233233; x=1792838033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RJMiI3zn0Ah/6v7E7BqKNzfu3zqpMlEsQjtNsehcFhg=;
 b=vIYEKl2BxuN3/kMiFg+A80MCGuS2RBJ2J8MEL7MGT13J9dgGt+0oCtubjtnS4mU0zr
 YRIPMtuvzNQhQasW5qe4A9NU+g2J6kgCC4rpcRXUzc+fLxWTxcZn4VvvKvBSaWH7B5O0
 qR+KXg244AzwXR3Rs1zUJ96xI4V+/5yv+8HhW65v47Lfxf4AOpuVu4nft84bN2MkcDXY
 Tv/hoCIyu6npgU4IFAtrE1shk6HmJrkT0+MhqsZIXhCRqBPiwG9QlGs0ljyFvz8sxK3C
 eas524Rd7DCcXZP00zVtC1IIoPTQDVpTcA+iePXsNE+HO4KLW6hTnIEQ2kbDOIc9LBly
 b0AA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4XbZCeZODqsfng+MfR2OBCMdZ1Oh77zE4s87ip3yf3d+ZNypc6wSC7yDKEExbZbuNdMTvQppDzEQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKtLsY+IVjpDA3gCLsKUbpT7Mpq40zQyb2dzfY8BH3mO9Ko951k
 UDtC1pUE1ITDygALPbMniwsR/bjAEcWp32H3WS+KQBH9g8jopVxGwgIT
X-Gm-Gg: AYBFou3sNvHxiEiCHfPVamQnxObPzJFLk42YteklPG0TEHbKdG6pPwLanlkyB+rGJXD
 SCW/qKEASR1ebU7eyY3pd+RVuZt1zsKD5PB4pDOw803ilLncmguiBqkztB/FlUJKwUGvKFXAk2U
 +nRaRA9IWC186+qafeDmXVybJJPBxPfd98Ang0QTs5qLDJYgUcfo8jvhqd3yck+QZXn7YZfG3AT
 TCO3y7MsAeJQFA9/VuyXiiL1SEAlhMCAfAqquy6OdwzdqJVZiftASYiUUMxzEEWYggccuD9kXKg
 5Q7M0djcY/ulfiGktHhu9IrfYtJApEhXyixn69MUOgVzHXqeGbSiFFl5m5tNg9yX9+8xOcMb7Fx
 jofLb4BAJgw1fdwsptFJT+BXWe0a9qkQOFxcLDtg2ME6+Uo7BlT1YqMI6CFRnATAYeLpMyMM9yB
 IghiVKxu57/Tq46RoDIVNyGmRkYQ88to7wi5DiImteM5AyrtQWJpfTGB9b
X-Received: by 2002:a05:6a20:6f8b:b0:3e1:7249:e26c with SMTP id
 adf61e73a8af0-3e226057ed8mr1628852637.34.1792233232952; 
 Sat, 17 Oct 2026 03:33:52 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:372d::57f:4e])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-89f58414986sm2051585b3a.57.2026.10.17.03.33.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 03:33:52 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH v2 2/3] dt-bindings: display: panel: add Smartisan TD4362
Date: Sat, 17 Oct 2026 18:32:49 +0800
Message-ID: <20261017103250.800109-3-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017103250.800109-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
 <20261017103250.800109-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

Document the Smartisan TD4362, a 1080x2242 command mode panel
found in the Smartisan R1 (trident) smartphone.

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

