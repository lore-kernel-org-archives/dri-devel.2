Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F93CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:41:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C389210EBD3;
	Thu,  1 Oct 2026 14:41:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIVWfdLu";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 236F910EBD3
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:41:38 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-39e57ee1cb0so999634a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790865698; x=1791470498; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Go8DGdYlWNQ1d6XhNdqWJy2/p+jQ4I2nLWIimGwFQbE=;
 b=YIVWfdLuqX6nELth186hVH345fXf8K8t0uNZQ/E/44yMfp0/rduyKK1j6vS9DOPhSc
 lIchBl9aJ/YBKRea/jNa4LeoCCl5TxrDl531s5d+XF9v0F5V0raPuO5oIRSoEDpFl9yG
 K+yqxT2BOsOENMesGtQCR2c44BQU277VgltsfBetflRVwSqw3S8GvKdOQYKlEqUVa7VZ
 kzIi918ecAgjMy3q1lnJGChqc5hF/7ipWQ8DWyDJvTWfop2kBd5OEc6+mEtCpznBowFp
 fDW3WwlJpE2XsMy533kQ4et85b4qH/bzeM3cRvypkvz7yf2Qs7yTXJjBXVrymyHv4EDT
 Zh/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790865698; x=1791470498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Go8DGdYlWNQ1d6XhNdqWJy2/p+jQ4I2nLWIimGwFQbE=;
 b=mDunV0WTh4T5iwNYtlufGureMcR2G7BIQA3PuA0DrN18czH7suandSir2El1r9DSIl
 H2nG+DayI7mLKzkYw6fRm3OxxIWBwcM2XpN3UCrI0KAoj4YQpq81MOOzmccKULiI0XcF
 i1iB5EEjulB/nyfvh9lKvvRREhw9Iu1prU7+HlgiY2EVItMt/7qlilogAZQx9ekQlRGp
 Ym/4mjqJAl9FLhJWr4uMfL8k7l2ViIo96drKSUuJSFmUNdTMng+tFIRWGvlqqL796DJt
 zAxGEasQuLNgxPi+FcMeKhxbTFRPZGE44VFITXY02ujCMOq4+Y1I3Hhxpw01KqGroDd+
 qvfQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx2rN2Hu+GLRVuD+xm0iGgiNR6V+4mNIaL4xJyuzx1/G0OmZg87t6OnG/VOdjpOaO4YERhMfMHq668=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKsHVbMtLq41xO94KoXur6bCjOJDty1SzojvZ0dwZRvxyo54vVT
 nlEYsP6uaGUBxKUiaey0dnLCZ4WZAhpWorLwNzISoIBasiUhpUdZd5oI
X-Gm-Gg: AYBFou07XU7XjB0Y4FNxo2H5DAYb2x7HZd9aeHggMeZOOCwKMkO0A0/rf1y7Sbg/byP
 NXlk7RLk93u4OUypxgx6MsHXufZX+wBcckrUJStkVzUhiZtj4nxg/3ry1oTZTOsm9i/iJj9Ykjy
 3Iq4XF702WSCKOxFkFfCfFKtv1veEw43C345JkvgZisNI/bOjFyHbLroTqu5vGWdJastCQx3ADU
 fiHKLVd8lI8iDz/fNZ5DZqdr3/0NK0uIc23R84+jxNTVdaq1amjr3FPqwW82vjllYqUnW2dlkmN
 B8tHW8EIogrlkkSnJCEcEvLIBhh/Zfx76CPzDpyUWty53v8Pdjdtyx9B7HmBu5IaR9njkCEhphu
 C87zqBziHkDBGFlc19Gb1kKybu9NddWqy3jcnmcaQob/DDNu/tfuABDb3v4MpNhOj85eAa2AGfM
 nU0RfcBAxENDMByzxZDq4FEM8Jbm8xNJi+/XK1j3EOXeilRO2PICiZhZnGZvJyEfKZWGmJcg==
X-Received: by 2002:a17:90b:588d:b0:3a0:e7ef:bc81 with SMTP id
 98e67ed59e1d1-3a4d19343dbmr6803741a91.3.1790865697501; 
 Thu, 01 Oct 2026 07:41:37 -0700 (PDT)
Received: from marchy ([2405:3800:8e5:44e3:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f445d356sm4976256a91.11.2026.10.01.07.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:41:37 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Thu,  1 Oct 2026 22:41:25 +0800
Message-ID: <20261001144128.2336301-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001144128.2336301-1-azuddinadam@gmail.com>
References: <20261001144128.2336301-1-azuddinadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The binding is for SPI-connected RA8875 TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 77 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..4283de927b13
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raio,ra8875.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RAiO RA8875 Display Controller
+
+maintainers:
+  - Adam Azuddin <azuddinadam@gmail.com>
+
+description:
+  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
+  It can be connected to the controller via 8080/6800 parallel interface,
+  SPI or I2C. This binding describes the SPI-connected device.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: raio,ra8875
+
+  reg:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      3.3 V supply for the IO pins, the oscillator IO pins, the ADC pins
+      and the internal LDO. The 1.8 V core rail is generated internally.
+
+  reset-gpios:
+    description:
+      GPIO connected to the active-low RST# pin. Optional, since the board
+      may instead use an RC reset circuit.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - display-timings
+  - vdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: display@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            vdd-supply = <&vcc_3v3>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+
+            display-timings {
+                native-mode = <&timing0>;
+                timing0: timing0 {
+                    clock-frequency = <25000000>;
+                    hactive = <800>;
+                    vactive = <480>;
+                    hfront-porch = <40>;
+                    hsync-len = <40>;
+                    hback-porch = <40>;
+                    vfront-porch = <10>;
+                    vsync-len = <10>;
+                    vback-porch = <20>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..99d5113fb035 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1395,6 +1395,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.55.0

