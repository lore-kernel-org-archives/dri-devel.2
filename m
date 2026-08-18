Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2D6C5DF67
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 08:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA6C910E1BE;
	Tue, 18 Aug 2026 08:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddpjdtLZ";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39FAD10E1BE
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 08:06:45 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so47894365e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787040403; x=1787645203; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlTQW/BF9URteLWdGLssLkReJV29Ip7yvpMIAoyvb8I=;
 b=ddpjdtLZrwtDkIVCx3RhzrOcl1ZApGEVcgFEv0xaZH54yQRXlrA3V7iSf8I66OIuEI
 uc/w8KHv3hINmmgZgyd8mb7KzWrRTWDacfsIG4ZojZR72n0qendXNQ0V5EIhfTv1HPoR
 XV9lvf8u7YwmcSMaYAfWr+uzXfXrfEh2z0Pe5FgoHbokinDLMwm+5WP1O1cKQbTlNIOc
 C3vANVBgXktI6PZtRJ+tOkMeajZhGlUX6OiI+koa5BgY44x2TRBYqo0FuRGTgNkYZ5Y+
 j3I7EuGy2YYXvBqDyZoj3Klrj9HdfH6VRDi6xzomfyNe5aAAPw7Rn+SLF8Uz9RYHeq8f
 Pfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040403; x=1787645203;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlTQW/BF9URteLWdGLssLkReJV29Ip7yvpMIAoyvb8I=;
 b=PEKrfrqsYpXzzB9lal4fPiIzmyQiSBudik35n9INU+sVj20fuL2gu48sruK0GQBllb
 7rrsjPuH4lHqlX9N/TSBMDWAPQoPHcK+q9HvklpbjeYqjBlgHWflhvlqkvwu/Y7G64z/
 KWD2nZ+jcHzsqbXYineveV1AymmtF+fk36dchxleAvdfQL/v8CuALcyUXO/YTRYgekOB
 PgXjtRMosXHOHKlum85NoEIm+gWKadFkkcPFyBpziWsFXBrdP0iwCzdhl3RPyOH8njnT
 pdHCBck0iS4Nb8MbUvri4EzoFf0BNriCc11yUbncCP1mIWWSNgpb2p1E6A/NDRDLEZSL
 4d0A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoXa1d+1IXgYzFkMXeakHvdpDZKOaGdLDFzzAeuKMigxHQoqTCZgOtFWwnniUDLfhYGaDxUMyQ7WtM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxUo450PKzS6m4+4Cmyngf/iZuezU6o0K7JT/0jxh/dDuvml5TP
 tA9xy4G3eA7v01HBWX5CPolG4vM++RzEjxVW1NipvxVGPKydRXTWM2Ou
X-Gm-Gg: AR+sD11V6LdtJHSceUpeccE5SHze7ybKI71tiK8JSufxW6y7EzSUL6qwN4RvJmFicm3
 8PasgagyGDN7gPIuTCz/fTxFs1fCHtckZsZ3RWq4a9CfuV29SvAO+ATHhQZJIbHCcBmUjTIAovi
 va9tFhtoEOL2V8ZOSL/+Hh3be9VjuU7RWYD6At4ZZ2eUHMD45d2xfHFLATFxu4myaErdc19EJJQ
 xNZwsTHLyfB/AAU/oTHz2u5BQDorQMnOLvMKELWolNixYBvaJPoL/j5hcQKoDBL6SEvLPODOG8V
 9bCblwfIkApX2UqGnZgnH57Uk1R21I/zIlPnVutHjL4/FJ8FEx+n4UhEqQeVXvtMr+RCmGDJIh6
 WaFAyv4nKquagKnpmvMcGWFpKTn8JIrMGUoeU7X3i09qeM8TEgGK6GjkB+SQR1VFkSltJMDZWHw
 EK3A5fqkoF16CG+Ijd6WaZqayjQCQfo7SFz7/DMqBtwohUd2yU9QTjqfpZ408ogwyqixcAh1bCK
 04=
X-Received: by 2002:a05:600c:528d:b0:499:900c:9c69 with SMTP id
 5b1f17b1804b1-499900c9e99mr376832095e9.9.1787040403473; 
 Tue, 18 Aug 2026 01:06:43 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5a3b2e9sm10367223f8f.9.2026.08.18.01.06.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:43 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Fabio Piparo <holofermes@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Tue, 18 Aug 2026 11:06:21 +0300
Message-ID: <20260818080626.30430-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260818080626.30430-1-amit.barzilai22@gmail.com>
References: <20260818080626.30430-1-amit.barzilai22@gmail.com>
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

Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
RGB OLED display controller driven over a 4-wire SPI bus. The binding
builds on the shared solomon,ssd-common.yaml properties already used by
the other Solomon display controllers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/solomon,ssd1351.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
new file mode 100644
index 000000000000..80850c2ab5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd1351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD1351 OLED Display Controller
+
+maintainers:
+  - Amit Barzilai <amit.barzilai22@gmail.com>
+  - Javier Martinez Canillas <javierm@redhat.com>
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - solomon,ssd1351
+
+required:
+  - compatible
+  - reg
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
+        oled@0 {
+            compatible = "solomon,ssd1351";
+            reg = <0x0>;
+            reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+            dc-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.55.0

