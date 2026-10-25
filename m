Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593B6606A323
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=z/RtBZxv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B53210EC78;
	Mon, 26 Oct 2026 08:36:51 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A135C10E27C
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 19:16:45 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso8403115e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 12:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792955804; x=1793560604;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h//NBrBlTPDZB+A+b6lIo8U4diDkuBzgaFKaw1cfgXA=;
 b=z/RtBZxvlAVm3W51q28d19UVEqcJovyRSxdrTSGcqyGVDHbSIa4AVWwZHBmEIPDXsS
 19QlPm9kkcRowmeIgYVbClEoYD1j/im/GHoJaTzl0a0wMfAr4p1huG12YL4k+OgCLt70
 at5GOlxoE0YXHObTECTuyJtLSFpGIOd3I7uCILTOlLZGrj32lcmpcVB6cjvbNIIPmnPY
 uid0n1eTzobig4PeFD0v7+x0ISVWELXOrzOIux9aoWxvBpCZEsBANy4AoQRmOBb9GCu3
 GrIgAqeg8vFdUCXSUdmQBk/cK9ZpPZErcL4LNyaazBFf7q/8wwlmG1ybe7pKdnqgfr3z
 E26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792955804; x=1793560604;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h//NBrBlTPDZB+A+b6lIo8U4diDkuBzgaFKaw1cfgXA=;
 b=zctZIBPTD7xgrmwJfeYIhq9oDq44AJsLkLuLGcpVQjXU3Bx7YVFVbkNJDg5tT9IbvO
 ZzG+iDZ3OcE7kVMTZy8S4nRHGlbNsM3EfP8ZIg41UPs6aRFIiJcA8OYKHALXjuQPKj2F
 k2L3Lxzsm2ht49jc7pJGQl8v2mnxQlYezjfvcDBxZ3huMLnjYYxQaiIYAn66FISkJnuP
 w9nRRRozJKRzWdwgpQ/zQazAmLFP7sScfYzSOTqGVDmHsMzWzpoSAastC918GkHma34I
 lj0r2gZ/nDC4w0LA32TcCedMgfE3RNicmstq6Q6g7wisGIwhafz4ts7MZTHHbGd0vDEE
 GDWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxnAHFTQD0ixKamZOc+HEClPiQxEAFjfbnA++CPonRpT95/W8RzkZN8vQMvudCdOnrdL5ptOrumvmI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKWhmgNT1HkNn1nd78mYgJrDc7qUEUsXsPu8ihYibMgVlut+2cQ
 XiyoNuWSGLsIYNYdr1pQ2/foIvGjXKXh4DLhFW5ZHxQwwCYIQp4A45SQ34x2uzgYVtU=
X-Gm-Gg: AYBFou3T4I3cKADHQvuHsH7AL79rMOQIhIpxfCQ/0VlkrXHwBs3Fo1RYLz90eZ0Kjgu
 MstSq3dfcMGzM8mkYVz7LIizyWKTSmbBlPuLx7ck28mlFLZ/mJoBCobwcBIAlVFgpFe+tCp6HYW
 6kczl09G+m+kR1r2DLcnPU7OemosA9wJTU1v95OzSB0g0k67nIwOlnkz9Pql6CNa4QtqN+okYbX
 JQkL8yDH5v7Hj4UYfH1PJYM6umW7W7WQXSWy/jd3iGOs4rmuM2+QP6YCBj0BTGdcL+WU1w0TKXE
 XLDAuitymtaBVBic0xulperZ7x/YR1/rrIYe+4/zLcKZ/Eeql9I3xJvdzs+KHwICWsy2+ixX1r3
 cbIsTX2tbKBUIU8saXNWSRJMGQbxErT7UQBMRETM/qAgjMmtSEH1OAwCGbVYcQgGZzCCHeAN9nE
 WKkobCtC3qb0KtpP6qjOOFsWFeCOqOJOXxXl9PUIR0ijUPDKL86i1t05Od1senixWSwe8h2Envu
 5JTNlzRxlDHtDcLiaENsxr6HvLd5a0Hn4vjWVVC4IWD6iTFP8OVz3nw9P0aMJRMQt0wPC3iz1Y/
 qYJUc0xMVXh7mg==
X-Received: by 2002:a05:600c:5397:b0:4a2:a9:ed56 with SMTP id
 5b1f17b1804b1-4a35ac99b8fmr81985055e9.8.1792955803985; 
 Sun, 25 Oct 2026 12:16:43 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:9d2:5a71:6dfc:5715:ead7:7540])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a5822a7sm144560865e9.11.2026.10.25.12.16.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 12:16:43 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH v2 4/5] dt-bindings: display: panel: Add the HiBy LG35583
Date: Sun, 25 Oct 2026 20:16:39 +0100
Message-ID: <20261025191640.13592-5-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025191640.13592-1-olivier@mgcrea.io>
References: <20261025191640.13592-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 480x800 parallel RGB panel of the HiBy R1, set up over a 3-wire SPI
bus with 16-bit words.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 .../bindings/display/panel/hiby,lg35583.yaml  | 71 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 76 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
new file mode 100644
index 000000000000..19498910629c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/hiby,lg35583.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiBy LG35583 480x800 panel
+
+maintainers:
+  - Olivier Louvignes <olivier@mgcrea.io>
+
+description:
+  The 480x800 parallel RGB panel of the HiBy R1, which HiBy calls the
+  LG35583. It is set up over a 3-wire SPI bus with 16-bit words.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: hiby,lg35583
+
+  reg:
+    maxItems: 1
+
+  vcc-supply:
+    description: Panel power supply
+
+  vccio-supply:
+    description: I/O power supply
+
+  reset-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+  - vccio-supply
+  - reset-gpios
+  - port
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
+        panel@0 {
+            compatible = "hiby,lg35583";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            vcc-supply = <&vcc_lcd>;
+            vccio-supply = <&vccio_lcd>;
+            reset-gpios = <&gpa 31 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&lcd_out>;
+                };
+            };
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 57313163e59e..e65500a70c9d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8152,6 +8152,11 @@ S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	drivers/gpu/drm/tiny/gm12u320.c
 
+DRM DRIVER FOR HIBY LG35583 PANEL
+M:	Olivier Louvignes <olivier@mgcrea.io>
+S:	Maintained
+F:	Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
+
 DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
 M:	Ondrej Jirman <megi@xff.cz>
 M:	Javier Martinez Canillas <javierm@redhat.com>
-- 
2.39.5

