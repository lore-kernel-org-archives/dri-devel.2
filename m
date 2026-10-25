Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE53606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=Y3n+JM1k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 714B310EC82;
	Mon, 26 Oct 2026 08:37:24 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B16D610E878
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:58:22 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c45111bebso954117f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918701; x=1793523501;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h//NBrBlTPDZB+A+b6lIo8U4diDkuBzgaFKaw1cfgXA=;
 b=Y3n+JM1kmWdL/rSaKsuii93jsPI2FjijJ84TJ2SKzxm57mfzvQRg2mX5q9CZg93Ere
 nPpXq3HBBuAeBvB6ntN4+HOIgOhuWEaEPGpVIDP5L9XogvM5oZE/Bb7XcsQJWcWzl+Mk
 hQy1MhaxrPuxNwKwlMCemHB0eBS3bKwkgAuUI9qI6zUhqXWB0RlXp7kL4hRHFriYanBf
 bAqAZgwfSrWnx1yTkExnYTS35pdTQFFRPYwSlOVzHj53vf8VYLZ7URGNH/fotqfsJBAJ
 BhSQB7hHcwoEJl7ZIJgbcOW6I8QEaLDhCCHUzwsdb2K7ifZ0NaVztzuPW+aJEeHt+Wk3
 K2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918701; x=1793523501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h//NBrBlTPDZB+A+b6lIo8U4diDkuBzgaFKaw1cfgXA=;
 b=1Aq5v7J87o0k9C9VwS/xnGSUjdOAM9WVoFsbh1M0Gwjpkhjg46F+9UzfQn/TrMem1x
 zGSBsyTCvAdahkFWQ6BNhhfJkTrutYMhP9NvzgMypPPdiKyYc9jSAFeJPD41E4mkW7Wv
 m+rQb0wL8SRjiub4yO8CJ6UTlzeknkRRSK4QgvmOnbBkEa/KDVladHv2QRQD8Ug/qgXr
 4aKvRlgscUKNWVG+36QlD7xCaPFFyWs2AcsIEndcjN2nRLWikxswwFzpKGydR3xoU5Eq
 exxhgj6w52/YzUUBdWZkCZTgZGbCpDmqzXi87L1xjcbaCsdPu3nKl92268826mwTNehx
 iw9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzLLfajbeKVJIpdZwQYnWcnnCnM8G/IB5WBUud4qDImsM5XHue3hdIHvLO0vr3PHsaXw/L7NoOOL4g=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKdH40Egyz0GQ9XrIAsOItW0iZeupjRTm/HmftEQaIMzdU9Yn0Y
 DHqrVipLfnOD6UJDRNkr37jKwn8zNS1Z9iVBrczhnqqYrggkNN6hyo5ERoLnAEQ8Z68=
X-Gm-Gg: AYBFou2gSorc85EfcpfrnVWF9APEHiISHDLzsZXs0G4btkf/7Tkwt0g9pqZrcDHsUeJ
 2NVzsVYyd7PYeLk+HdZzQujx+qaGO/lCjc925EnkBMSr0IZbNlPQtajCDgzfR6QkFMbw9JWSEMJ
 4jIFajJZbZ8VJS/fRbto4VOhpz2XOix6uvptnKzfQOuN1S7bvBzJYTHQP31oC/4oORLiPSsys/M
 IY6d4lpShl2Gx6ZrC1CqPRAtDDi38Bf1XUsVzAsqqZpixtOT99VQUG4VvqOVyJNpVcpG+G0cGNj
 tXelsqwnaS1ssBzz64BjEmujHg9NF3L/FVm0AifjzMTGK9DuqN21VfgaIueVGhF9Lwg3Pip0yOT
 N/C+HmbhXN2iHSws0xBvNbwI7y620dZKoIQTOSQL6UIsnUpa8ADTTd+TXHtTA77p5qB7WA0uBCJ
 UjnBuumm7X4byd/ITOGzISiC/eiX67QSsGrFf7s0hLhXKAq8DTHEpHqOaHW9FORAmHE5jpa7rDM
 XUpcVqm4dJ5le2UZQh/Dx/5v6j/5STZO9TXG0j75V2ii7EjUkZDjQ7rhVwbBUHsAefwWNN8zTKp
 PjJ7+8bqJ8ZWxn6eu0A39bJeL1QOkpG/YGLpQ6A+WuTZsZqzFDirSQwGK5nk9DXARRmZAbehMQ=
 =
X-Received: by 2002:a05:6000:4a0a:b0:48d:de0f:b79 with SMTP id
 ffacd0b85a97d-48e3eac8e4bmr6815931f8f.0.1792918701100; 
 Sun, 25 Oct 2026 01:58:21 -0700 (PDT)
Received: from localhost.localdomain
 (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr.
 [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm9094542f8f.17.2026.10.25.01.58.20
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 01:58:20 -0700 (PDT)
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
Subject: [PATCH 4/5] dt-bindings: display: panel: Add the HiBy LG35583
Date: Sun, 25 Oct 2026 09:58:15 +0100
Message-ID: <20261025085816.60405-5-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025085816.60405-1-olivier@mgcrea.io>
References: <20261025085816.60405-1-olivier@mgcrea.io>
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

