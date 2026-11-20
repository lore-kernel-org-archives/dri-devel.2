Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E850606A325
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 07:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IUAY5S4F
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE6E10E29B;
	Fri, 20 Nov 2026 07:34:14 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 356BE10E282
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 07:34:07 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so13344995e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795160045; x=1795764845; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=IUAY5S4FjG0bRFD94HNAATXvYPXQnF3kCXzCxNN79GpylmY8EKxjG0ecO4os+Nu6bZ
 t1JsG5hjXy60k53BrL/rosS705Cco/CbLA6fhor6QVhon2NMMAUZwwkFTjHVJ+1lWY4C
 ljECw56tVafTOwzwwcmfNMGr9NpGOEvHBopQ44qjN0x6S/2sD0hO9SbeDY33/bj1EecN
 w/SrbwuDXh1IuSeCI740WPHOZohMNN8yT/ziR6NGW4yZI1ZHAYlAHW1Uu3hc5XljgSo2
 No+skJ5rgc4338dCNmZKZbtZfL0sCyCIPH70lAxgwb1jZeAZ5lMwBGJNzB8Lh7mdoNrF
 PJxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795160045; x=1795764845;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VlPXjcEHW+lGnIptKKRSC5EQ8CQecxUOoIc+hyAGrok=;
 b=zjBZBzLd9KPELaEVLZ3/fKPGVs7KQ3R9F0AUHxuOT6t1yyKjAUE032bodKOTJKC/X5
 xTd295UPfMH0xXACuPV5jw1hrIrOhL039BcMeRSJDYdTZPJlNd71Fx6nq6LKzqwgrzfu
 +DWSaJk+2p16jOdsPSnWtNQwl9/FpfLwcnnWYyu6rSfh0mZ2eWf5M3NHbg8PJqdmleeu
 5yk3kb3y6pf23F1ngvwu4fMGbEes8dpoG0InMq1L5Hwz4lXOS5Ocj4Vd1e53j6sACCGe
 zZAm1iuo5kyrGh8o4DB0IGfKJVsbvl9AgTGvRo5IzpUDpZQsr5CjkXUsx7gdoIvAXXbX
 7nsA==
X-Forwarded-Encrypted: i=1;
 AL+hErGJ27bLKugbwIbuAZAg9FDzPgcjzrDoNseB5L/y9NOXa1Ns0z9iOSWGVOzy0crRKL2bBYx1SFMY5uE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8DpUvpt6rZ/hKDOXp1hitbLCFbaBLl41ax5zwZXuim9nY3Zj3J
 EgN5QOY1xmcmxwH6wqbftOjK3+sT1916r7Z3L2YNB2uBI+9/jR9YNfbY
X-Gm-Gg: AYBFou1MXvi7+TMZHjYbaXljTJWNZJAoYACBLOHHtCE+GctzIcubUNWVmqoKJl+QIwR
 L+cKzCsDcA2fl234VWnHXDZRr/eASR85XnW/+BhfCGToQj271tqINYPOerErgeEDNhCru8MBRZZ
 LwalFJh4k/Jui5MjLWKOZXv3xF1TheIXgMFvoQBz6BWXD0pk6JHOOP9WbB2i06MKJjbze/GBWUU
 lznWx6wH/FUmWN8IBtgaexY9Y+xf8a7bA0nsNsODrCzVxAr0HmJYLm9xEyLWlXTOYcE3VBqFj0/
 ZGHvsF7k0fY3/bu8a6bkUxzQf+DA7hN5oe7pliwKYUa6kkg3IwykAog0UfxO3M0Bevw9bZV9Y2H
 6iK/5bP5Pna8jeoi8RsaOfXrTc6Spmuuh50LG5B4qA5bBgj3AsXrecad+2QP/yIf2/nCHAqxxG/
 urgTVKAvGUeLOsacm3PsiHlNf7dJLeM6ICyyejNhL4PykYPmHbro4L8cSGQ/Ar4jwICZ3H99bhg
 kdT3GiG22EtWHKMtiBxfAl2rfnjN+Weu15VM95We+xFExCswTxy+jwmJEA0EBNTCSNCozT0rJ/d
 /msQCIPQN0AEZQaN1JVh1WSvHHyEtEzNxWg1e6tb7TgT+wHNQSgNjbZ2bK5bMQsrQlqJuakk6qR
 y/adY0/cvRe4AYBMxsLKO
X-Received: by 2002:a05:600c:6749:b0:4bb:5d38:259f with SMTP id
 5b1f17b1804b1-4bb8881099cmr44675865e9.12.1795160045388; 
 Thu, 19 Nov 2026 23:34:05 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a3a3dsm54154045e9.10.2026.11.19.23.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 23:34:05 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v4 05/10] dt-bindings: input: touchscreen: add Silicon Works
 SW42902
Date: Fri, 20 Nov 2026 08:33:53 +0100
Message-Id: <20261120073358.10267-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261120073358.10267-1-rofikcoga@gmail.com>
References: <20261120073358.10267-1-rofikcoga@gmail.com>
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

Document the Silicon Works SW42902 I2C touchscreen controller, including
its interrupt, reset GPIO, power supplies, and panel touch properties.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 .../input/touchscreen/lg,sw42902.yaml         | 73 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml

diff --git a/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
new file mode 100644
index 0000000000000..c5ec3bf4e545b
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/touchscreen/lg,sw42902.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silicon Works SW42902 Touchscreen Controller
+
+maintainers:
+  - Abdur Rofik <rofikcoga@gmail.com>
+
+description: |
+  The SW42902 is an I2C capacitive touchscreen controller used on the
+  LG V60 (timelm).
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
+    description: Active-low hardware reset
+
+  vcl-supply:
+    description: 3.3 V power supply
+
+  vdd-supply:
+    description: 1.8 V power supply
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - reset-gpios
+  - vcl-supply
+  - vdd-supply
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
+        touchscreen@48 {
+            compatible = "lg,sw42902";
+            reg = <0x48>;
+
+            interrupt-parent = <&tlmm>;
+            interrupts = <39 IRQ_TYPE_LEVEL_LOW>;
+
+            reset-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+            vcl-supply = <&reg_ts_vcl>;
+            vdd-supply = <&reg_ts_vdd>;
+
+            touchscreen-size-x = <1080>;
+            touchscreen-size-y = <2460>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 28e4aac18d44a..a29019d984393 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25835,6 +25835,12 @@ S:	Maintained
 F:	Documentation/fb/sm712fb.rst
 F:	drivers/video/fbdev/sm712*
 
+SILICON WORKS SW42902 TOUCHSCREEN DRIVER
+M:	Abdur Rofik <rofikcoga@gmail.com>
+L:	linux-input@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
 M:	Frank Li <Frank.Li@nxp.com>
-- 
2.39.5

