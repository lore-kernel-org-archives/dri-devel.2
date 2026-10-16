Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC04606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nVbxg/8N
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3ADD010F2E5;
	Tue, 20 Oct 2026 07:36:27 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E3F89F4F
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 16:29:22 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48c4be28b82so15545f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 16 Oct 2026 09:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792168161; x=1792772961; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F/XhYMGu1EQRHViVghAn6A1D98GsvwIcwrZbeCelmr8=;
 b=nVbxg/8NzDK7/Dm7yeClZPXUUPYbbfhg3dP7KlPc8/5JXIyGIexjnQKxYewV2qS2tW
 R/HSgsp24kQsGDZUEI0riHXzkm6zYOp6L3gUFAO1NiFlWegrK0tPI4Ckk5eU2mOsIrZY
 ClBqwzOf85aECm+H0A86I7Hv2v4CGtiFKOGGtJWX4zcZzUMNvWKb0iTw7jFoRqwapi4G
 +dKGurujmP/vU7uckCiVYk6fScFCIVavNVN5HJD3HABOCYmyUwAeO7cZLxHTc6V4HiY6
 72cuS57o75oYrUsSYypyli8Cv9khq+tL6VldxFcQYuTYapxa26qaqvQYpuVpwwhTOMXB
 Z7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792168161; x=1792772961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F/XhYMGu1EQRHViVghAn6A1D98GsvwIcwrZbeCelmr8=;
 b=x7JKZ9J+j+j1DOmtig6JNaCcOVfLgkaKATSBE6H9bTUK8t2BrdpCV38QO3IrnUPA88
 FlsXolhDRR1VgKfH0mH0mQgn2l/uAKp//qyOq2Ok0B6mflicObtZIjji9ZoNxgYvVHj5
 NZPmJMkNjv/OzhWPgwCKhoznpPc61l9p1B1UOFyOLiuyXU4OX4nACwEAP12QlaXELx81
 Do37R6TwVQWaFkXG36jKKhDLMHF9or4vgcB2Aohw9Map1lUcoH+g2B5qBIgPjXZ8SO1M
 DAZ9trMOQ6OAIS+JCSnN80PODMwe8YTrJZnqDb2QdK0M0uI5rhCuodLhBnogg2F7RSCU
 V+LQ==
X-Gm-Message-State: AFq9FYJ+uyALYXO2Cke8nGAABRRYt8O+xfuPnwUNJcHnqsatJktl4HdB
 EQ9dXiCd/ojhc/Je5bu6YQ+T7fT/uxLfSnF8JhlWKLUtRoyqohiN1OmE
X-Gm-Gg: AYBFou10X4JH4jdI+KrL+3IT6jW8gCOAzFFVF9DRFn9GePZwb05XBTZl3ZxpwdxMTsD
 6IKRQYTp27XGdm3v8ae0qV4ygGarKwKjlH3sOK3F44heOmIsuHXWF0pgR2R3GLpGgLEw7qlHIug
 z0nEuE3lbGXRYl8xH7upfHGN5Vdws2Vzfc21ULBzQDZEe0qltfTH+a8s/g1AufbHJ3ZQ5bkihlT
 oqhdL0khIKizz4yXhjRg4a0CMcL53R3dhGGBOPOAcW9vG3TLgbHK0N1txs67NVLXSgEO4hvlDKi
 kSmZRpKRQmftRgfsZylQtXHZtvCuhTHnzmKvAu8tPmKE6/vM6ojuwBEIjR4uWK6iWfh+4DZpjeQ
 vpmGOL0TcdyNv4swW7hm0azVKGz2JoWSGg9dPfR9mNToz7sxrMTVHqhYyd+iVJ/N9wcgGhKi4X3
 ngUzdqHb3wKI6VOzLPlGMtS5boVkSVRFH/FXng6WGZy8KqPjgoOQVwsAxL/wmxfC1fPfVtvEXfu
 zGQ10XLF5ySP6ipWZQjCOD9yv8l5oJzIYQnzKEYop70jDKukjHW3ksVNahy64sMuxEMfZ3U8rJg
 Iw==
X-Received: by 2002:a05:6000:4a0a:b0:48d:f14a:9183 with SMTP id
 ffacd0b85a97d-48e07bbc619mr219403f8f.15.1792168160937; 
 Fri, 16 Oct 2026 09:29:20 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::103c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5942sm9404317f8f.16.2026.10.16.09.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 09:29:20 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 1/2] dt-bindings: leds: backlight: Add Awinic AW99703 backlight
Date: Fri, 16 Oct 2026 18:29:11 +0200
Message-ID: <20261016162912.64581-2-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016162912.64581-1-lukapanio@gmail.com>
References: <20261016162912.64581-1-lukapanio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The Awinic AW99703 is a 3-string WLED driver converter with an
integrated boost converter and 11-bit brightness control over I2C,
optionally combined with a PWM input.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 .../leds/backlight/awinic,aw99703.yaml        | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml

diff --git a/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
new file mode 100644
index 000000000000..62e8cc3118f2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/awinic,aw99703.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/awinic,aw99703.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Awinic AW99703 WLED Backlight Driver
+
+maintainers:
+  - Luka Panio <lukapanio@gmail.com>
+
+description:
+  The AW99703 is a 3-string WLED driver with an integrated boost converter
+  and 11-bit I2C (optionally PWM) brightness control.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: awinic,aw99703
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to the HWEN pin.
+    maxItems: 1
+
+  awinic,led-strings:
+    description: Number of enabled LED strings, starting with CH1.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 1
+    maximum: 3
+    default: 3
+
+  awinic,iled-max-microamp:
+    description:
+      Full-scale current of each LED string, reached at the maximum
+      brightness code (and 100% PWM duty cycle if PWM dimming is used).
+    minimum: 4800
+    maximum: 29600
+    multipleOf: 800
+    default: 20000
+
+  awinic,ramp-on-time-us:
+    description: Current sink ramp-up time when leaving standby.
+    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
+           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
+    default: 8000
+
+  awinic,ramp-off-time-us:
+    description: Current sink ramp-down time when entering standby.
+    enum: [512, 1000, 2000, 4000, 8000, 16000, 32000, 64000, 128000,
+           256000, 512000, 1024000, 2048000, 4096000, 8192000, 16384000]
+    default: 8000
+
+  awinic,pwm-trans-time-ms:
+    description:
+      Transition time between brightness levels set by the PWM input,
+      for a change over the full duty cycle range.
+    enum: [2, 4, 8, 16, 32, 64, 128, 256]
+    default: 2
+
+  awinic,i2c-trans-time-ms:
+    description:
+      Fixed transition time between brightness levels set over I2C,
+      independent of the size of the change. When absent the brightness
+      ramps with a fixed slope of 1 us per brightness code instead.
+    enum: [128, 192, 256, 320, 384, 448, 512, 576, 640, 768, 1024, 1280,
+           1536, 2560, 4096]
+
+  awinic,ovp-microvolt:
+    description: Boost over-voltage protection threshold.
+    enum: [17500000, 24000000, 31000000, 38000000, 41500000]
+    default: 38000000
+
+  awinic,ocp-microamp:
+    description: Boost over-current protection threshold.
+    enum: [900000, 1800000, 2700000, 3400000]
+    default: 2700000
+
+  awinic,sw-freq-hz:
+    description: Boost switching frequency.
+    enum: [500000, 1000000]
+    default: 1000000
+
+  awinic,inductor-nanohenry:
+    description: Boost inductor value.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [4700, 10000]
+    default: 4700
+
+  awinic,pwm-input:
+    description: Combine the PWM input pin with the I2C brightness.
+    type: boolean
+
+  awinic,exponential-map:
+    description: Use the exponential brightness curve instead of linear.
+    type: boolean
+
+  default-brightness:
+    maximum: 2047
+
+  max-brightness:
+    maximum: 2047
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        backlight@36 {
+            compatible = "awinic,aw99703";
+            reg = <0x36>;
+            enable-gpios = <&gpio 7 GPIO_ACTIVE_HIGH>;
+            awinic,led-strings = <2>;
+            awinic,iled-max-microamp = <20000>;
+            awinic,ocp-microamp = <3400000>;
+            awinic,inductor-nanohenry = <10000>;
+        };
+    };
-- 
2.55.0

