Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5A2FF886D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 13:59:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0FA10ED03;
	Tue, 28 Apr 2026 13:59:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PawsPU7i";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAF8810ED03
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 13:59:16 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso87914035e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 06:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777384755; x=1777989555; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3cNFpNsHWTlH2CArmHKw2g8Cqw++ZFKef2xJKHsmC7s=;
 b=PawsPU7iCPaDEWEZVvqnyHjkI0Qu/EWIHPfSQghYyWmQjzEEfHCERqPPFRJ6OFUYPC
 TpDWBNPNZ7Q0N3uqppZjUWczmxscrnkid9t3pWA5Ow0xKyftxVooE1PMlLo7zvq3ZVO6
 cNmBFxuO9cUMYDjW1LWryleFPVdYg2NPxg6pN+/Mdrtpsb4nAGPM25hdO9awBunBie1e
 BegTVzYXJFddG8swIy+/1L9Kfem9kg3p9Yad0QRrvSR0272T4HB6eQ6eoU9wjPg6Btox
 YHSaOLCN4F4Dt1WNoEyWaSyxH9YRF8FjnsQPAJQHk/OxYeBXJze3F/S5JGB9hdbBYcUZ
 XXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777384755; x=1777989555;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3cNFpNsHWTlH2CArmHKw2g8Cqw++ZFKef2xJKHsmC7s=;
 b=cbzVchZ2KBNBWMP+rn6G28pTaRPDbqlfYpEimBGYFRUzuzHqMPkRZEgP/mINSi4MBf
 7Lno6s4+hW0xL/Rza3rM7rqMswdjAgvqRtUzgHg0BooCCK4Aj+c7H+Gs1q+gsmEQ/imF
 1yAM6jhgbUn47In/QSmANuyN+r7TN+o58MbycZkypaJ1pfDs86+Qw+DxY8ItyaifTve5
 /xaCGNIJ1ykuC2DRmhtb1l17hMBCSefDYa/XTRw56LTVTjQNbbkQJ5ZrGHo5/BA+/f54
 VkK2oxWzYkFZd1ZACRgR6I7I0uyaXVpEiQY+6iirc5XHiXqNnkEQcaitfNC9cYyoM6PO
 84ZA==
X-Gm-Message-State: AOJu0YyNZhywYW7q/eYQf6xF+jodgr2kTk2xl24k0oAGm8Ce5CUtgpxx
 mshPqwOKjrCZD2s8FF4GCIS63bbIOX2m9SCuwVRvy6otktCPKz8HmYetqgUhhqbRUK4=
X-Gm-Gg: AeBDies43/yvwxncX9nqhIlGgwURj212xrywN9R1YE6I9NYBBOSlcqJuS3vKTLF1D1D
 DpK+CkmqlXmos970ihSZMxnAUcKO5cLi/K5wxvEz5ozNpHZyPoyPYWZjzFfMbCJ3IWiStB7bFeY
 Ue+YWirUFK3C4TM6T4nU/ulDk2qif9OXgxGnntUar7c597P4pLDQODVns7WZFqQOQyRzxQVemN/
 KQ5EK0mBDBd0ER6GmGCvHv3OX6ILNFt5uOfsroEBRPYgdCClq+dG1ZL5yYksh/in+5XB7reB0DS
 C425oPDQ/9Db9bnYbL2f2WmybvCIGaUjY6J8WE7I2koYiFzQNUgZyy/1+oDrvg4Q5hu5mk+pt+m
 COiWCmLmDQlD2AT0hqC9/Hbp2yLjhWDwGpmuzsTr0V6Lv1iBT02/qt/E/zOQbuIFtp0LKk7ISi/
 1arYvM3nqWbw4KF4XgUMRrt4cmdWsNv2NFZbOixvH0eoB/fTL+x4n7hxQ=
X-Received: by 2002:a05:600c:3507:b0:488:af7f:7707 with SMTP id
 5b1f17b1804b1-48a77b1db5emr53077915e9.18.1777384755114; 
 Tue, 28 Apr 2026 06:59:15 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773efe04sm60811155e9.12.2026.04.28.06.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 06:59:14 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 28 Apr 2026 15:59:11 +0200
Subject: [PATCH 1/2] dt-bindings: regulator: document the SY7758 6-channel
 High Efficiency LED Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-1-0caade5fdb32@linaro.org>
References: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
In-Reply-To: <20260428-topic-sm8650-ayaneo-pocket-s2-sy7758-v1-0-0caade5fdb32@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=333uUG2C6Ne2A4QjGhhNw1YJTlVuEP5rcGs1oRWNx80=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8L0wK6EZCu2c15EL7r3pT23eeIFET1SCFmxKUwzL
 E4ZkWL2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafC9MAAKCRB33NvayMhJ0X21D/
 9uPq2s4LaBUNeHgTZA6TA2qn8iA2HAkkGx+vn4HSGvvBXuk7CMpE6eC7Ib+dhvcNT6oN20/7nMCjiA
 l0iU6+x7sItuA8TueTBzkmSb6typOWrxFSMeEDPj7PPhnJNJOQXrEzVR5So4jaiUz19D9NEq+m2+Er
 ztoTSZNaNxbMAilz6bJXtRkhFTgrM7qsic1ZTLJho3d3LH7P0xWMBP2mY3bgw/7lF+pzhtIhYsEBD3
 9lgMXa9sbqm7UHbXePZ7uBDoYwMGeGK83+VC2SOxcTSgMdP4/1ox2BDC5niOpqayIKnfvB16zN873P
 rRKrjQg3aTnTWnoXG2n6eV0wDc/zowYZJg4BjEt/7scw3FqbDhniHS8QaYenAPcEt6VTwZIH6O7DDl
 zPkaa5NVUncIBKso8yhCRzxagqJ1bK9ju1hexM7qw5e4suNM7WBn5N0qKI3ym7Dgh6RbLU7iiVzhbI
 joVAwGp2Z7vBBMVvjV8FElPbXEuigqAp3e+daggvy6fgj6kc4/dYjatMY/EQaCJ7zlEFFZ7iDBiDU8
 9dI2lLspdfVJDk3XFkvsvI7ed1v7xvFc9Yunj4Lw0YGkBk289oBQO8AHgpV66DBkM1iTTs3S9uo5R6
 mJKYMYxqAgXmRILL0dPfslptoi1Iu6xMlinE9V/wBsEYNn1kbD0i5eT57gmQ==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
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

Document the Silergy SY7758 6-channel High Efficiency LED Driver
used for backlight brightness control.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..dc44b3b502e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/silergy,sy7758.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Silergy SY7758 6-channel High Efficiency LED Driver
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  Silergy SY7758 is a high efficiency 6-channels LED backlight
+  driver with I2C brightness control.
+
+allOf:
+  - $ref: common.yaml#
+
+properties:
+  compatible:
+    const: silergy,sy7758
+
+  reg:
+    maxItems: 1
+
+  vddio-supply: true
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - enable-gpios
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
+        backlight@11 {
+            compatible = "silergy,sy7758";
+            reg = <0x11>;
+            vddio-supply = <&bl_vddio>;
+            enable-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1

