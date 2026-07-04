Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF5DC44500
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F33010E03C;
	Sat,  4 Jul 2026 08:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R44P48TA";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F50B10E03C
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:09:47 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47640541585so812517f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783152585; x=1783757385; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nV/B8hZtMepwD+PMiYNg4MREiS1D+m5zq5m6OKaCARw=;
 b=R44P48TAtnyTYmUS1v+CJUg/yVBnI5H8UoC+cSAuZTIdvv0rfkBX02kT9c5Uycxmdk
 ESow0+34im2JT3yahrqyMXfr3DqBldoeF85pC7yuYfCFNX6o5nlthFc8jLY1aZiDL57L
 iv7J/4lwKSzfslOb3/68ca8POhrM4vXXk7GFnQa+1OIJj83ac+L3+amLClIG8uQHrf4j
 tbEW0SNSq4SlrcgqXHkgri/JpKcqYPZYLXa1esd2vRh8221IfPiE8xsxbIv5shPOEIiW
 u+Q69OvcR22CqJO1ZGMEd6/ZVEhcKeDdH93kM5zfvNo3lYTXI1AmeZrWSuvO2i/1Ksk9
 gJKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783152585; x=1783757385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nV/B8hZtMepwD+PMiYNg4MREiS1D+m5zq5m6OKaCARw=;
 b=aVDxsGIbAH0gPhcsFBfkts+iq7JvHbrPecv4+1dQV9mLdsyJq7beimKeFA04xCFGbF
 TWffDayVh904W+zm0atY52Cm92gEPNTyKxObHeL+NA3EBq2SeS4ANkyKjhF2Af6AIGY8
 Md+PfFx6n/SqePuL6X7xtiYi6Q2l0Bk4szB+tTBhLYrXD/ryFDIqEzt3G7VMIz+tNgx+
 7HdhfDXX1G/+nMpXnPHoeaW1P3alSu3EWQ39FlKB+8DU7sNMUJ3cUq1kVepIP/eCFFfk
 lmk5uZod/qt1TNAz9v8lHlqBt3m0zIX2zoCM+Ypyo7WZsHeZrHpURZWDHhJAMUZ7TEv3
 v01g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpyNE9KpiBYaA22YOoPb41BvFPOqln/SsUQLX8SfNnrTdW6hNlRTHmc3di6YHQmxAqztmoNcatthI8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw1j5QgkcMgRj2+64jQjOq9p7hGB8W2iKq38yBnw3Z2AIX+rQ8n
 TSaSHUf9o0DPj38eduA4n8yK3EymXULA89fzGU3PB21fqPv3PdgbJkGAi/56g2Gm/04=
X-Gm-Gg: AfdE7ckgiWMg6S+0j7a8nWb76rkxaWAcNbi3DmX86fFVZvRhecg0kchMqMfcCX3hoyU
 WX3IsowJkzQGExL/Uiv1t8Xmiu6lvSCdu//Zeq3R7Jo4T31FFMzBVWf1K3HmwlRSOnYrH7nVIhX
 R2C3Gip4ec7MYvQuyo6Ad3DCr2qQjfLsZeja0Iyf/gBTSPHUcNbtUmUe65W+gptEQ+mKmKTjd1h
 D18hFAX8p7HZB2SPv2AkWpcNWSJ/RgixLfq/BjwpXJJG1dZDMFKSYGnMsliVnukXlqanVUOiQ1C
 JXxcqNquxb2bJwEHZw36sGrpRdO0L38D2Rj3GuO29hvGGPOY5R108LcXFPosuzY9JeNkzxQf4Dx
 BJIs07Bn1aQIJ+hcwiR+1FE+qV4mzA4JdfB+YBvXaBjRgJTU8O5jSeiEpRIhHgUQngbQtZ/LgKW
 UcNGtFCQ1YggyGBGMnGHf+evn86R0=
X-Received: by 2002:a05:6000:2283:b0:46a:168c:3795 with SMTP id
 ffacd0b85a97d-47aa9b77caamr3073043f8f.16.1783152585397; 
 Sat, 04 Jul 2026 01:09:45 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm6143055f8f.26.2026.07.04.01.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:09:44 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/3] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Sat,  4 Jul 2026 11:09:23 +0300
Message-ID: <20260704080925.75113-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260704080925.75113-1-amit.barzilai22@gmail.com>
References: <20260704080925.75113-1-amit.barzilai22@gmail.com>
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
2.54.0

