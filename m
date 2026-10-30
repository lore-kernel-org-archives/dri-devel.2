Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30D3606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sikMJ2/v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04C0D10E885;
	Fri, 30 Oct 2026 08:49:31 +0000 (UTC)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC7310E86A
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 08:49:22 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cd6b9a2735fso28051a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 01:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793350162; x=1793954962; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HW7rHhE169McYx8Jxy2QMfjdkASLa9iCRSpVlpE36RA=;
 b=sikMJ2/v97VzJVIRXxrKQSzYdGOf3OKXpLm9TuHQxWZD2PGdXLS6FeYuBicEf7Mvu9
 f4ogD88oiprlr3LlMUot/V90hiXfdN28OVtrrAjbWJNGweUD5rnTp/3Q6RlDraU7Eggh
 242oiHxoVjZIZ/acg5s0Rud6Ru/v3JCG7nxIrKw6pYep0R5uGgdClnyLE6k7LzWA5Z0L
 uTGMGDfxCAA+2KKl9Lozg5TQ/EJqbtzUW8QV6CcMa1SNCqswhCB7upwbshBpemqrLrWR
 3GfHblFm4iUGlLWTmaDf9ZL+VFY6b+03JoNH22wG/qUk2pfldKPp9Np14BHxitYfgAp8
 yi1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793350162; x=1793954962;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HW7rHhE169McYx8Jxy2QMfjdkASLa9iCRSpVlpE36RA=;
 b=HnA3w8IHe5mNc8SqbF6QE/T/lLlNO5o2ub0uubOQ3bV7yL++QCH0a2AF9ccEo3VWTE
 xZCkzvaa8jZ0dKovYjRdqPU1Y32LHRmtsOgakf9rWk4Q1OzuVm0qEP40ANceUxWa0GLb
 LECaDiex25dI3X22IImPzwKSUib5TzCzhcF5kXNYojz3AlsqZcL3QoA+AjEN6IMrWtx+
 37JsneL3h08YdjoxU5YPMXTmrNQvCyhAvw/ezJbsidr7apS/ZeUodvzWE0leG3fppNM9
 dl07rnDlTaCZrXsBU4qPtk+Bjg06GnzxFTHvfxQ8UDVfZ6y3dbY21N2P88vQW+0uzYZ7
 SM7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzIb0EN6JpJbkLLgwdgOuN5EpcRHt15e7Lhjeleb1/frH0Bx8/sWV3svu7f42Ganf6gIWpH3BWI9Lg=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLdYvKHHXVJXQh8hI9bLNVuCuG60oqMIQVhw7qRwfAfpToisjpC
 WuiW9kFn5+IeFVaRTVUvOVhdm+l49lhM5F0A6KZbBrDpEY6I7zbIk4SL
X-Gm-Gg: AYBFou2zJgc1PWyX2ha4VbqvgZPKvir5AhSzDKKaEtaqaxhWAKVbXFtaPQxQ7MM5d2R
 urIIo2KWXUPorO6bgHtd554jWmQbzEHNabPQl8Gv5YXA5GT1Q33pwMSGEbLSBJewz+1e31XuZXW
 jvoJVII/wwRILUu7bxeCUfBG76htaoXKsCqjeads8hr4JKORk81NaAQkVoR8ujKaQkFZJix1SLc
 p/vmulubJL41GWX0zf8bVZ9NA8v8FjChB+8OyI5Rzys9sT5f/ucuyjVeh2q9DNCRC5kdAK6rhQd
 8X/zaKqBHKIQ5LBDhNfNw4V79ehJmYpGb8bLlXq4cneD1T9DbrixEPa8ybVEiUaDgHTlTX8A+YU
 ZwDNjYClm5Xw0A3L4KSnRVJ285nQFPI7hIR4lqkD3jlialxT0hgtBEYRp0XC23vnv4vlr4FyWou
 mgxHwQBYewgMIcYQqnfv1dkF9Cfh9CeW8NdMJvc3CK7WbcTsTq2cgyBLNebXYrqIuVQgbJREvPI
 t2cVAIJC/Xu8M6MK2Yh/EelfX6jGrqWyFNB8Fm6ELrwGi7xv3+kxJ31wENYLPax+8gQlfpszZSR
 97lnpR/a1khAb+8NaOsCfQ==
X-Received: by 2002:a17:90b:28c7:b0:3a7:fef3:8561 with SMTP id
 98e67ed59e1d1-3ae89822b55mr2355088a91.5.1793350162228; 
 Fri, 30 Oct 2026 01:49:22 -0700 (PDT)
Received: from marchy ([211.24.73.58]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845ae5b9sm3229716a91.12.2026.10.30.01.49.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 01:49:21 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Fri, 30 Oct 2026 16:37:35 +0800
Message-ID: <20261030083737.47188-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261030083737.47188-1-azuddinadam@gmail.com>
References: <20261030083737.47188-1-azuddinadam@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 87 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 89 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..661398bda0ee
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,87 @@
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
+      panel, key scan, DMA, BTE and font access completion. Optional, since
+      the host can poll the interrupt status register instead.
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

