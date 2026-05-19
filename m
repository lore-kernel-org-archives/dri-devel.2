Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 061B3CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 08:43:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51AF610EB67;
	Tue, 19 May 2026 08:43:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lmIg+Vrz";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2ADB10EB6B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 08:43:45 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490229aa522so515625e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 01:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779180224; x=1779785024; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=lmIg+VrzaiiOg+5PXk6jojE0A5b5XLJYqd7313/zZYPpH/HcK9IRuFOtTdhzpNw3f3
 luUORhyIDWjrKjmaHJ9WIHJT6B+CA0mrS+54fueWWQ1c7jE1NxUVZBFfPTHH9G5MnS/T
 HDb1Xp0WZrKE5sYyzcNukVGb8/R/JClHo4QQlk4A/PphOthXdbt5XbycswyGMbXEl+dk
 JreNZBpPukUxEQYu0Q+jHRbJa5Cq1o7LlqQM8cayW0qhcCVrwO8YO9kxqxx7O9xh34UN
 ehtWHqqz1FRuswCwpwzojH+eWe07hW3yavy7KSjRsFQDowqjOgA3vosV+ybZ3vG15gsc
 kc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779180224; x=1779785024;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fFOILrRBRgckVtvDGiEi9gDf/W6MgY2gnxmqTdTmRWk=;
 b=C2kFaZa/HhRhYqWHfgqv8Q906HAkYYOeeSqe5+lZdnqd9phAcLeJYKiCnwzsMjW87W
 e15qNP8SJjTux9a/R2k7MNUHX7ykXn3iqVK6wVQJ8GP2HhDUYobqQc4uodiEnJZwffIu
 1xqYNGS1gqVz1SdWr9i9ArZ4spw8irVLGWijexFHZcYnSgYDvHEeUBl6wWn0nylrgZXP
 D42PtHHkKr52X0gPN1HDCZVUkZGVLjRJmxoU0AMcNG1QAOE666hX3OQqIDtCLhwXKpUg
 UGqd+dDTr9VqGD0Ytx7lK0W+kV1fg92E05ZYevnfJYuwKhzCqBBZsQldgVi3XbkwW9TE
 +pYQ==
X-Gm-Message-State: AOJu0Yy8/TI0NFPkQv94HNTBiKJfvEJHPKcCKfCngArlYR+U/lTO//Xi
 fCifPhznJJD0ARPUROr3SyXu+CQVhxMPhEiqyUxiKK0Sa7FmUgNKDMZ99Qlov94q9QU=
X-Gm-Gg: Acq92OGiwlYVMWTMnlKA6m1RFQ6xaOCh27oTgSNMg1+QLKIskII8Tm+60FbLHiLYuvw
 0bUsg/kAD5Mdos2VnyjYkcNUMw5gwfFv1yRaOKPTOB0EETuZel2V6INdevsvKPiIZp5AMeGEsWN
 tA8t0ffqEX4nXvqR25N3alWd+u5njME3ubUrdnoNZZtuYIDWwHvcBaWhUgb+aTzD9tQ2m9WZt+q
 ECPvkE45aG+NkVskFqdqDhX8hpvggOxd0dG7kW56/9kwAqrC20Jt8SKVDurqbC1+fa0GBPevD4O
 ihplRVvg/GGpe7PnEzHe2XxE2sswYSbo0xQQIJ/bk0ay8Y/0GCIW96uGQ3EQx8V7o8k+uc0VWi4
 Jfqf/0DYZUgEyfyJ0sKGXpd/GaH8I1CVdvzotPpMeNvzcocQ9//zcjXH5JH16eoXu2ZwAhm1K8c
 ioSxWAXLFBuQqYoKS6LOR0fAb55HMfs/F/dRzmpFGL0TMC
X-Received: by 2002:a05:600c:8485:b0:486:fa35:aef2 with SMTP id
 5b1f17b1804b1-48fe5fcdec2mr293014265e9.4.1779180223901; 
 Tue, 19 May 2026 01:43:43 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe1a41sm47709855f8f.31.2026.05.19.01.43.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:43:43 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Tue, 19 May 2026 10:43:38 +0200
Subject: [PATCH v3 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-1-ec8194bbc885@linaro.org>
References: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
In-Reply-To: <20260519-topic-sm8650-ayaneo-pocket-s2-sy7758-v3-0-ec8194bbc885@linaro.org>
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
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqDCK96WwH4hgb3wMp/YLCG0boCUSM8fPKp7kUCNHx
 leNu4Y+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCagwivQAKCRB33NvayMhJ0QArD/
 wNtM06BNVLHlOhCE1L1Qhmq4FyldFL2yOXfAbSOsnHWfnbxsf/NCSW5jx5Mn1yGLM8SYB+oj3Fb1ou
 U0bNBZDCeO6B4P1cI8VhwADxeew7DUQyiqFzuMzzrdgznPwsN4PqmLCXDcHeA0Ue6W3KY5IDYJvgc1
 5ZXU8Z1xY9vK6CXQGnz5FCbonIY5CUsJZWPI6ZdW83trF4lLb5XxC4h3J/xnjpT1Xn/cEvAHgiDfUw
 lsQeAh6cX1APzyzVUWz4esNhKEHkZcKPXrbM67DZpikLNfXbMq2PFodXyiDFf5Wqe2nOb7ZgWVKVym
 yGlgKnKgy1tFeNLrFUKKQpeLiY3x/FooJ8Y3Cc7dDBSe73h+MTWL5lRQnPOtJfMxJ+JwCK4ikJOMOq
 PZ3M0SEpU+IHaxSfo7V7cn0WD3l68dS8dt4S9BSdhbkdTWeFhFFlPpObn5DY4MYOt79OejVmFquhvD
 2iOpSUYFgBjy025KSDSuyL+ankye2q3M/l/PPU2XpvzM2kH9t7zc9wMELyq9XqwfG3WkhsTkPyxg71
 ff8FuNjTVwQH4/YyYmOaH0NX83RS6rHnmdtxpIYje+zu5ah5ea9pvGwtewgmqxIIZxqPg3JUTHn5bn
 RoaSG7rLlGwG5IaeXXCtMMAkWr5Jfy85JvVNmDkjb8VjJmNJJVYwHuXPZ0CA==
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

