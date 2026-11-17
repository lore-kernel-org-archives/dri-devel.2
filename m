Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6286F606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FfZH5qyD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE56110EA53;
	Wed, 18 Nov 2026 08:23:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADC2010E5C4
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:56 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a9a8d6cea8so11252765e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919195; x=1795523995; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=acRH3NbgLkYCK5iiPRFwHw3LXKQX8KfNDsHlQP+4/XA=;
 b=FfZH5qyDIAKB+CXJ0lTx0VBYbBFy6a0SF4EFq79vY9p6dZFhbVEzHXZcPPGNUaNkXP
 W/IpMVugpQLP4yZTyAtD2geusQuOPTO6/V7Zh9HonFWpnPFIMnASO4udpLokdPZN91xX
 1/SIl1AESz1O0QbrY3dVs3QP3AdlMnRa2/SkrknqxLuSKk9RJOd37fucb+1UeOmynkNM
 q9h2+cvYEI0CaTzcePZucCHh0znxJyhB5gAR+knLSGt4JdE35stJS7ugcebrtZxOeaQ4
 D1RbHBRF56RPg4nLbtsTEUNktVjA4T1dzNktt3c4MtKg5/EKcHIrUdJEVGPOfRm/fSit
 JOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919195; x=1795523995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=acRH3NbgLkYCK5iiPRFwHw3LXKQX8KfNDsHlQP+4/XA=;
 b=T9UEm2gJmC+5gXppbN/ZJI2zhRGOoyEhMFgdr/ewfOlqCsdhXuz4nQpbU9HGaRkEA8
 juE8TpVL4Ua3Fjbm7XuSG8ma/yKFt49yrCJ5f4vulSUgiJZ24sWym4qouy+lh+1k2y8u
 t0bZMRe8ELc7SYqeh1OGXeaNn9IhclQV1CPOugLo1VQwfvWoVCnmoPv2qhnqCe7k5cNj
 w59mpaEbBGOYMcv9V30wP0rAOCbKqtN/W6sTBjSTpPDMRDY02NJGcpzElLN62wpULret
 t4qR1emXNMkZj1scxKX1VeoYFIhJpSxyGwIsYlQNYW4Lqpn4x4X6FwnJ2fl0+3EzMr8y
 5ktA==
X-Forwarded-Encrypted: i=1;
 AL+hErGG0+VlO8uBnQ6yTAHpFc+Fz7YP9ZyzAfPW7Yi8a3iat7xNIEW1OtB+VRF0CcFwIfFeY9c+DRAVhME=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+MxlL3Er4iqw9LYHxTlIMiEj7aelAIYgsbhxBFEjpCEtuyPbpu
 dd71GiTbnIz/IRgtwsRJGi4k+dcXwMa4lqJYGRdxfNGLPDfUISXK1mZR
X-Gm-Gg: AYBFou1PUuGDPD+DkqsLc7zhEbRJaRqXhviUuRCaexmpropqmul/43vkbi0aWVt80X8
 oNBec63zAa80BwS/68Qi9GRP9LZzfkoFtnOo5E2dxk2458+55RCI/GbPctcpJ2ZElfl3aLEDl/t
 ZytpsKCcdLcroSrB5L+K39u+1Xgtfw/rmf68ho4yvmdJ2e0gYDnHbS8g4jOqp3avIds7HU3SNds
 vNmrpx9k9Z8SMuAEEVNttyrLoqvJsXbdIjO2StPzlCdNKWGBqiIMUdSR0EbI2nC7o8ps38EddGa
 DvC20IUSW+GWI6fMJtF9XBA2O+cMZaMmiJxb1aTiRucruu/4h06oVATkzYMlJXKSBe8pEda5bK1
 X11+uLPQFht6UwE3DqHXGdRkgFdwd8pQ5iI92NBxyGHMwWtvTqBp8QllE58PftP2QbF42pL2YDb
 H33EcCd+01YDA+yNnLxKWSHV7V381QzgVOqEbcliqTWg/BQvjnjXMlC2cJlqDsbQFxIJEohUSDU
 WW+BOY7BNfXu4g5HUUY2QEB1rD3JA35ufSDyk1Y9kyQCWYMulTNZEdtTwoySBr6m27A9FDSbxyv
 texU7JszmQUWGIXAcBEq11Q1aKBiyHsczb0RpaMioANNW0fIGCQ7HOjiPf7dB6bKIStsWg==
X-Received: by 2002:a05:600c:5012:b0:4b4:a551:681a with SMTP id
 5b1f17b1804b1-4bb7837264cmr55075555e9.3.1794919194974; 
 Tue, 17 Nov 2026 04:39:54 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:54 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 06/11] dt-bindings: input: touchscreen: add Silicon Works
 SW42902
Date: Tue, 17 Nov 2026 13:39:41 +0100
Message-Id: <20261117123946.668557-7-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Document the I2C touchscreen and its interrupt, reset, power-enable,
and panel-size properties.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 74 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 80 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c56cfb8530eeb
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 touchscreen
+
+maintainers:
+  - rofikkerneldev <rofikcoga@gmail.com>
+
+description: |
+  I2C touchscreen used in the LG V60 timelm JP DCM. The controller boots
+  its existing flash firmware; the enable GPIOs switch its 3.3 V and
+  1.8 V power rails.
+
+allOf:
+  - $ref: touchscreen.yaml#
+
+properties:
+  compatible:
+    const: lg,sw42902
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: Active-low controller reset
+
+  vcl-gpios:
+    maxItems: 1
+    description: Active-high enable for the 3.3 V rail
+
+  vdd-gpios:
+    maxItems: 1
+    description: Active-high enable for the 1.8 V rail
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-gpios
+  - vdd-gpios
+  - touchscreen-size-x
+  - touchscreen-size-y
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        touchscreen@28 {
+            compatible = "lg,sw42902";
+            reg = <0x28>;
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-gpios = <&tlmm 67 GPIO_ACTIVE_HIGH>;
+            vdd-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index abdaabe16ed53..f4c54d7d86bd8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	rofikkerneldev <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

