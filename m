Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C445606A7EE
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b8ZIK74L
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E999410F6B5;
	Tue, 10 Nov 2026 13:05:34 +0000 (UTC)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A39010F6B0
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:05:27 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2edcf6c3a57so5835ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 05:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794315927; x=1794920727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PxKXA0tpiiR3QW65ttMlpI5LiL6zJ2kSzmT6W+PdFjA=;
 b=b8ZIK74LCjxIH/iqpSfTHqhGB26WnckhhcVkSaT3Q3EDG1ugglRQP5YWUKibAPl4UJ
 40Vojo7zx3JcsjvBEfc0SOo7W8An3nQpkh05hDa+6Dnb+b52zhcCWX3gBWNWCotnbuDP
 2Od+rNo4xUGTrjtSK2B1iwF+Mb6ATa7rVmYlGfmoh4nHqw8LAi9cgLSDR0s8tvNrpNic
 8yxHGUgEarDYwuIx9BbV1yukdyH1JDq5jp9b0TmaaEYdENd+EkrpGNhUSvOadh11tT7q
 xgQ2MHeXDcyug9uOPDljj6cC6ClJomQrA+RVrXwNGpK6eyvUWvhelgDYzDvsDUPaqtto
 zQkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794315927; x=1794920727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PxKXA0tpiiR3QW65ttMlpI5LiL6zJ2kSzmT6W+PdFjA=;
 b=Q+FrJsspTbJXbUoUgU1uZ43dUQShdB7tbZSL+nyuQIXWBMTs9f+xnRi941inW2aDxk
 /9CSelwIBGieLqIxcFvRHk2vW9s6UD0dYVi+RJMIkInXzAa9/tWdCVJOjLSiwn5GnORG
 b2xWPHKEzATREex8plo0ENjm1boE9Uynmk8zWJoMRjhzp2kHljpPeXjLRJ/eqA12VwFE
 uQQprCSdoVbb0ZIY2RD3tVsJzG3ZMXSakUT5330R1KAgC2RWpD4gH7ap4fa0U0FX51xg
 8NLgg9wfWGTdsv+RFoYko6UChK2OzusHTALYX0wVpPrEPxcDpee7cCtCMZRR9/nNrAxA
 qO5w==
X-Forwarded-Encrypted: i=1;
 AL+hErFqy0jtNlJBJjZNiL4r+75DysLaN4ax1MRwXmPEgkT3zcewio1xzsJ1brtaWFpaWZoAlbXtbT/TgE0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pKbesngfR6j4aQrB2iM2ZppaJ8eCnZGcGhENE3+8yQG6QBKEr
 rRjFzYp7cP8SlXJnG7UGqlIssPPcy7KgN5OTHKVIxoxJgGjiXE1bcyI7
X-Gm-Gg: AYBFou17m2zsxHgmO+zTfI5rBDahm05nogKC/gR6eiJWad4j0lROIMYoh0yYBnnnHKU
 BmReMCqxdKgFu9OOu2Ds37iJvlZmgDWjp8BJf7b/b/tDtHWz6KnLmWdqg4dkIwLnYKxPhHa3gFe
 vSdfgMPatuTVsGaj9TidtseGlJChUa+AhvSshpSBrpWXmIzS97h2I8teOLhMtFSoc3HQWkdXEC8
 1hfWNPwQAJfGawnXj+97qskimTfvfFglosU0nHTxVUXsRzzw/0VpgvR+mm0+r+SOayg9Ip6DM4I
 QDgSwzlkq2PGulzcr16xinY4HOPjQ/itquNSvznpk9ddocIZojgJrcR1rtjmeq+Ctb1Eo0J99V2
 5f54Cbh1MlEL/1smbiQ9bLYGqsmhnHa9ir88FtwHL8j+w4nmR2AXOVpj6PXL5XQY1EYO11XHuTC
 i+etzUC8keGaSQz4OJIe3H/pwiHnspkeogqXnaMMeC+nB2VqlAUURlJiNHa6LRXsx9KcBxysLR/
 Upr5cUT+XozY/E/+WdzV8jsZHRkRFxnrREofa9NcnpXTsZ/ltgtla6+cS56/ilT59L6MFcR1HRt
 UbyCLA/4d3fmMLMi4k/iCZarMcjX
X-Received: by 2002:a17:902:d502:b0:2dd:b95a:e1db with SMTP id
 d9443c01a7336-2edb91382eemr40097465ad.3.1794315926694; 
 Tue, 10 Nov 2026 05:05:26 -0800 (PST)
Received: from marchy ([2405:3800:918:486f:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2edbc1b81f3sm6274425ad.26.2026.11.10.05.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 05:05:26 -0800 (PST)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v6 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Tue, 10 Nov 2026 21:05:13 +0800
Message-ID: <20261110130515.45819-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261110130515.45819-1-azuddinadam@gmail.com>
References: <20261110130515.45819-1-azuddinadam@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 86 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 88 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..4c72130f0dbe
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,86 @@
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
+  It can be connected to the host via 8080/6800 parallel interface,
+  SPI or I2C.
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
+  interrupts:
+    description:
+      INT# pin, active low. Signals RA8875 interrupt events such as touch
+      panel, key scan, DMA, BTE and font access completion.
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        display@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            vdd-supply = <&vcc_3v3>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+            interrupt-parent = <&gpio>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
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
index 7602034374d7..c834ad2eb582 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1411,6 +1411,8 @@ patternProperties:
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

