Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E7EFF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9146510F2D9;
	Thu, 30 Apr 2026 09:47:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ZupO04eT";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 610C110F2CD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:47:24 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso5953095e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777542443; x=1778147243; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=ZupO04eThmVNHqFsN82EMGrk702EKILKdQQc098dOHi+ZE2MFGWhEmD+NLaF68Kbx+
 5Ve+UoAH2vQOELHqzWlpAqOgfHttfDsagNjoexWRZiFsQUYFw5cdXT4znYOi9C6+mKdM
 bvbayqVGpA7I0+M/efgGEsvYYIT436mh482b7uFS/YT4gaB+1j+igxwyuI1YU9cPaBPQ
 rGfqLvmIE1T+PpCO2tyO2z/TtlQA/avcIvdlgnGn7wTrzALCo8yN+A8DNjNfVTAbok+T
 dPjY8YkXeUmvWEddMa6Yera4gsnhe66o5JcbtrUZ8UgJtQ0TLt+3MA+YRzMVh1O5UnzO
 7LUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777542443; x=1778147243;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=Y+wIDCXYTB5Us/db4q7Nh08F4DksWpV6BO+YQuQjaYwIH3PygXUfQu6Z1mqA5cBwdq
 mTDbV9lqu4d5/1qIZYHCGR3z1Kj2UAcxgN9JZhZDyyQYJROetyBHe33km9TyQluyp9hZ
 7AjnuyFIl2Ogs5rL1aXbwEMzlHTPg5AvTnTYOCi+6hinb6TlrYwfC5UoNFpJMM3Z4Hcg
 fzTYkHwilXa9h0mijHN9Rd8jtckdByZi0ym16qWE/Km8mlpm9B7xzKZ7b7XTTHra64Mo
 avIrfgxLq3/+TJPZX7A9nmV/3AI9A/zhCirEMEirkVbOITBcPBGGbjPsHrDFwUGPlazp
 hvuQ==
X-Gm-Message-State: AOJu0YwPSwTnog/Hcic+LuPrOwkBCxWbJv7vGIbTWzFP4/cbkB2061ns
 tbo887NHvU91TK7VHFYZt0E3L6n7QiLTSQAs8IyW0AOUdNZTehjut3BnvN/QffCeg48=
X-Gm-Gg: AeBDiesZ4q4DFVFS5TY1+BY5oXj1gxEdBrswdPdQEwFwOg2qACgZYCPg/nDV0z4c81t
 9gHZOyx57AAQVI29C0pbefXDFFnvHF24HDRl0JJI0TZYfsLTv8n3+f+0lV+sFZiIjMIY0thyndf
 6FhUZDA0hMuyUcM7RO2Yeor5HesC4Et9NK4xLGtQMMAUKAXNwhHiLm1AkFBMQYZ7KJijtZa4cfC
 ZStxor50it1nqQeHyX5t5+nawePfSq/8zYrjEDKKnQsZEjwiocRivv3Gbb36hcl2LNUxF1fevew
 ZvAv/SAbfbnWelm2K5/7DO9PLrqKP7M1Iz+8UZyYjG57p3Af5zOVwOWtk7nONCTU1LjehFlMCU4
 QS3N58Zpk+NfMN6iDVkNzXvmNbKTiW10lRG8RP46/sREfE+wfO8Rm2Y2FxyL0Op7t8tTIij1kJE
 Zt04rqj6CmnB2a6WcNa2z/KInJSl5NciQZV+EAJFfYPP23zc3n6NloGb8=
X-Received: by 2002:a05:600c:1d1a:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48a84458d16mr38530725e9.21.1777542442688; 
 Thu, 30 Apr 2026 02:47:22 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a81b9493bsm48984745e9.0.2026.04.30.02.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:47:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 30 Apr 2026 11:47:15 +0200
Subject: [PATCH v2 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-1-308140640de9@linaro.org>
References: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
In-Reply-To: <20260430-topic-sm8650-ayaneo-pocket-s2-sy7758-v2-0-308140640de9@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBp8yUnzS9s/rNYIg4dn9FI8VZvUMuIuqoBd+WZtYZI
 QPZ3Z6eJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCafMlJwAKCRB33NvayMhJ0eVOD/
 4iGxCE+8I/QFYrllxJKnhUZFHl8HMTtdxoFG7PFzk+6AybCIPeTgtXhV628A+jBtobbwOmpa8lYmTw
 bw5tb0FkOZw/kL6p6ukGxjwco5q5ugX0hz9/FynTkud8ZA9audIzPz71rbv12BYNHSWZ99usLzVm7K
 DGQhfdRnczkmhK9O87HOO/dLd4rk/t6PRwYcy9WIKUawl11vZnvxePmBid56ePdc/JvP5+21nv+QtQ
 b9cH7qagTCEqGjMzbJKXMISqn4yYYQUvVww4UDmuUleN03Fe6F/4xzKK987/Z9+/8fbl2ZG+I39RB6
 wnwXNWQ+jDAU4r7Hv46jh2eriog2NLULu1KmbV5vtc87au1OYzUKjxcRmOPoVZgE8roCwI5apcZQri
 uC709c3kvzNVFIhLHnRomoTHAleHemKFNJobfAOaj0JGZE2FERK443MmcB20oKSNcl4EE8pV7wDpq5
 R9xYgmrskFChg35b6q0CygN7e1AA6Zn0Mnwd8b0NH251vrv8FZFIdMz3jCyUWkN+EtzHKXELoo7Uz6
 9mporJIAv7Sk8deTPHunmWbKkkdfUfFcunUPy3gdhcfFm4cqZhyAXV6oHB0Dra3jIhQqFf1fVK15QQ
 y4bGSD4xh54d5p5ngNo55iIK0Pr9Wao00VF+bLK4PUxzFnWYVVQjXKAxlDfg==
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

