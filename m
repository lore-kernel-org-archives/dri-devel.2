Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B827CD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 08:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9F110E488;
	Thu, 21 May 2026 08:08:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="F1TwRGWe";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 325E910E462
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 08:08:06 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so67628355e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 01:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779350885; x=1779955685; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=F1TwRGWeNmjaeLGU6t9xcXbSJ5eQqJc9ABIkboWW3I8zZDqThJQxpT9/lOKGvHxdp5
 Nf3dVhXygLG7i0xePq7ZUB+BWJ+t57Dx81m7NN9p6YPdZOZWTfvAtEEkgOoMQSLpNxUI
 4v+13bBpxKGel1f1CylYUvccBBe85Rlda1gcafoNcYHMNUS3vtEY6wUkkJO9/2JsUR4v
 cZnXsDD2r+CXA6vK50jv7iyVn4HBtzbQHa2XNEvPsNWxjvVX2gPyz9yLAJCe4t7z8Ikm
 mnEDljtrOeOSdP/x/oPnMgoiTh3fW4HVLIg2UJSJ0RxJM2EieN3xYVbfcTdnkuIzOouB
 YMGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779350885; x=1779955685;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=S6t2u71KAh7o3TdpVAmgo98+u1u9v0HtfIOFNeicX1wKjlP9OZKoL6nbXEhxWMk7D5
 rfw7barvbnCS36U61ordemP9OKwHAIUGhi1ruEColahwt/xh9Ac0wCOGjkJ7hLoidD2P
 TFprnsSUOcpyEXJWjeSDeco4NP9pGpQJGELFvSWf9XCX2jWPpmf+kswxgaEb45BzTSZh
 HZL9ASPBOhsKjtB7Sr/wMKF3emhzgdcck9mKUSjGZt71LVfdOioza/fjNJG2Hi5JPlLB
 wBWcygAfGhklrZ4Q76E42KCpaa/SUDMOEX8l7AV0d7Xd8QyQcil5unIHiKtXw4I2Yc1H
 pR4g==
X-Gm-Message-State: AOJu0Yx5PS9aAZ0KB/Yenzm88WGwCpZCGizG+zDxjhdkqvkg1zWVWRLn
 pAvNT70KR5iH2WlU40zH2Moao1J7gRDs2tKZe5s56uKt2AM2DqUoXnlEXGEGfLAF4oc=
X-Gm-Gg: Acq92OEYPWan9I4/ChazTRci5//amEFBjLitOX/yHAOInFj1G+drAyGJ2vMtlC+Nfr2
 ofsj8GHMbHnrbXrY6MmgdNw4KH4ZPhU3a5kH/gRpPJN8vTQLt8/mBYYt/962mbyLj2xnR+FX2dR
 Uk6kTtKeG2H+m/RuzBROFZ3TOra/vz9B0MmyoblDd2HfPdMLlN6MKC66YpZSnnLbzJiR3c01OM4
 kc2GfYD/hfZ6Jym564Wm5wretky63VFv/Cd04vg6FJoRgCVn//C+ArzgIshi0ZSWpQ4oMoTxpih
 mCW1mT8mU0VpajH7asDTyxQL8xMw0vYoKijjxdRZJ2gYUJSL4e1Qrio+bpvVRMMZ13ouOqAMmR7
 ojxHJUdOgQRnTJm1WxJrU173OHIEDl6Pe2RDWBVGzc/z7ne2qpJrBEhftAzt5/MhTN0Yfm/qqyG
 IZug7sOMSsmZ5I8Hmc8VW+/nXA7UNA4LqHiQ0Tgq58HMWBgWTRGUyoHVY=
X-Received: by 2002:a05:6000:2908:b0:43d:a37f:8d5c with SMTP id
 ffacd0b85a97d-45ea38c6abcmr3068464f8f.17.1779350884569; 
 Thu, 21 May 2026 01:08:04 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eaa92ca4esm814369f8f.22.2026.05.21.01.08.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 01:08:04 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 21 May 2026 10:08:00 +0200
Subject: [PATCH v4 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-1-73c732615e4a@linaro.org>
References: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org>
In-Reply-To: <20260521-topic-sm8650-ayaneo-pocket-s2-sy7758-v4-0-73c732615e4a@linaro.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, KancyJoe <kancy2333@outlook.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1824;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=8cCbXbkb6HowjU8II83CA2d+DXwOgvOAWQTPrH5Iibs=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDr1hbxFzE0LGxpw+DnlzsdozjsO+qCoWZ0ZTpcTy
 q+M/nAeJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCag69YQAKCRB33NvayMhJ0cCzD/
 9P0KBP/zTJ6nGmlwjWlNwROl2dERvX/SFSbXnIEh2rA1eW3NB/XqDkGznJ1xUIeVRX/PUMAwqYtDhZ
 uFwnR3PQ3qdx2nJ1BopB/+0SkUsN1uqay5VJz7hE61ypR+oKJHcgUxPOlMUlFznO7UgvWzc/x97H7R
 01R3o51yWvAygLpWkS1vbypHAEGZU2C/j4AyQT57b0WuL3f4hEDzM7jWMKJzAqwpDg1EZtdDbTgg3H
 boZhlwfW0zRk3SayixjO2+tLbWLXz16sSo0sRPKxF637WkW+tV13pX8mr0LVnt1zfm1J9WCe0ZKl3N
 24tBVKzXLTWpYVHdozTtdMCdAbSGBE4xdcXtHJrmydWLKI1mBh2/yldsY19AzPYykP4fT7tzabROpu
 f4g4e+fBHtgJXMGmgFoW1vQ7A/oVB/MDSX30VRoLwX4zgBCDvC/pbRcvOrnW3o7v1bGgpsu8IqsglZ
 5n42enEgiWXwE6+j/CxviJ8Zj/d1BQgiZKZFDhPZspOb8e9CxMIE222CSBpHnkKbg/p2ZKd8Fwm1HV
 2ZmBmYMlUIi0wrnBmESs6NBv8ATuYDNPknfM6Uzx59DLTVRcCyP2IOVlHNz9MbXo0ChPa5bJSV/wnW
 Z0ntz2XW9wV3yKoKqwGpfyt+hFq84JqYgXZlM0wUzlrIVr6SPHqtcFk5lr1A==
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

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..80e978d691c2
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
+description:
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

