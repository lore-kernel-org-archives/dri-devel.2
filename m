Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B1FCD4F54
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 19:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEB3F112450;
	Fri, 29 May 2026 19:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XZ7Jo9th";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29027112450
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 19:23:15 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso74317005e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 12:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780082594; x=1780687394; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SY/pjFoVkR+l6EebkjB4dxdDrLLE9cCLnfyxSl7hmkg=;
 b=XZ7Jo9thdV+0BgE6mIZJ0z73i9qsIMFk7MCFQVU0GmxNcfgn5DWKBD1v0E57zthMKR
 aYKvFHFyCJcjbZEPI6Id5DACTsYUarzlrIYRHMWOJqabxL1kN1mxDH8eJoDge4x8s0Uu
 EMsWaMbDf7ZvkC4v43wE5NANBpIHMBFuyjz2y74MbKa9PohMOqJ7YohkB6ZS+H3isPWS
 fT3r5FOUTXE+KzzVflwxL/ccjKQxJLgNWex0mJx11s2jyyS/v0pVSh+XBD9Eski6xYXG
 JKk6GWwm+p0nmYa6ZMmmrMZSl+fSJ8H6kuJaQBUzWGorDwla0gKnBeoSGe4Y/O9472XC
 UwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780082594; x=1780687394;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SY/pjFoVkR+l6EebkjB4dxdDrLLE9cCLnfyxSl7hmkg=;
 b=h9JvU2/5PldXIcxXTNbwo4t/iChplveF0aXCPqc30VQeo4TrPjTfE7nhe7YNp+s9R/
 ndOcCzI4pTKUIzNXk0qOW1qdidI+NCWYBVafnlgCNIClS0ARrKHEr0csRb/kR9d0dGok
 YpH8cYdQhUP+iVv41dyumoC76AGy3yZ5qvu+fkdtZ7jGEjHdHcDDSxW9QijGnIkNYOMu
 8yojwsv+ZYJ1s7rdf4bpsBq5qEoM1n9kVnSJXyn9vt2hhCXxuUbnsqm0oRoGgVo0+a0g
 7T2k9QxcBa9X15aK4I7QAzXR3NJIBkoLoMlX0kpIluOSoLViche6GfDqvBpLewPa/Rl4
 5o5w==
X-Gm-Message-State: AOJu0Yx2CkEKBjjEP+WbemGpusQYCiQs49X6lMmWSvZ6EzkcYH6n7Ir6
 WvwLTp7Y/PZtwWYziBcY6iqvjaF5qIJSI37+hrDa2fGku8nocHlpLm7whemfc6DfGa4=
X-Gm-Gg: Acq92OFGPzwXqFUYj/SOLi6jsoIlg07UPiH+ggMmfMN5s9yOfDDbDzCUVDWEo6SG/kk
 cBrEMrFpA9LMYIX9H+/vDBMavtd5w8XTvDykQLQ6sCZ96O2XL1IkD64453/JQDuYQiaPwdgyfyH
 AsfsjXhMVzST9i3tifjxKniickiF/EU5QSF3icCqtEkdZDJcDoSgLqOkPyG/NuU1DWZZABRWopY
 qFlm+KrZqwt9BNT0XjubZ5BTi6eRp/4lWIko+QeYxunVE21p6GeHAUfPbJYmLoii6jbNI3+zDnI
 VrDBHyTVTSeEVTAhOTc2/EkWpyXQo6nrV++QuD44ocsftuFWya8g2pnKCrK3apSO1nDZt/lAS97
 6hg9stlqKeaNkUNQQ9A0BNpkTkogSA6OZPmOCahju4qNXPR8EreGAozJg2jI6AU6BiW01q1TUHV
 EhWkhgjoRPFbUh0pEezA1Ml986hp1WDUhmbdvCDVN66bYYwc5JJXqPj4Q=
X-Received: by 2002:a05:600c:1d11:b0:48e:8741:fd42 with SMTP id
 5b1f17b1804b1-490a291fa6fmr16006735e9.12.1780082593552; 
 Fri, 29 May 2026 12:23:13 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c152570sm28692545e9.9.2026.05.29.12.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 12:23:12 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 29 May 2026 21:23:08 +0200
Subject: [PATCH v5 1/2] dt-bindings: leds: backlight: document the SY7758
 6-channel High Efficiency LED Driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-1-03aacd49747c@linaro.org>
References: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
In-Reply-To: <20260529-topic-sm8650-ayaneo-pocket-s2-sy7758-v5-0-03aacd49747c@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1799;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=1lKQMpd6PjiypUs8OsPV66H2sccTnVhP4zdDuQTSTj8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqGeed1GduH+zhZEZfWhRDG5HUSICoERZsYkY7py4I
 4iauz6uJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCahnnnQAKCRB33NvayMhJ0Ux2EA
 C2/rldx7AzNQpSI6oGa6TVKXBueQo7tV06QD4RVu5M7Wh9MF24Se+5JfvyF7UoQJTxxgQK+NtrjfcH
 1FCcYQ2fse8Y/gwVjrPhqu2zJt8Svau12tMdhq5moU2Wd6A3q7O9/NsQYyTNeupEHACebcsaF+YVUY
 gRbQOQUChV30r625YZQwO0pmJ6cBuF78+RkhMtCl7faQTPyKCysz7aZ0DuJBL5fAnfCy+uZDMIGBDV
 HLFFfwK/Y1WSzyYKpJcIgHRmRORYu9LFnFfxaL0hX671eaYbdwBuliSY1yupcFsHV5YEfbc8QZlnU7
 3XI5T6PCmGepKbP0dnsYHoEepvwO/6yOCRHGJWvHYsJTIhIvrtLdF62NVhla/THvFfe5aPu76SYRF/
 ghUz8m3kj/x6AAYEX6jJiwtYBqo91LvdW6YUq9Nze32GU1NIn87YEU/+ZXTqV4QBqGsrmtpAXOm2Rx
 lbsmgfBsQk2tort4Mb/VIfcxfp7/P6ZMeNhfOs5qHhvDAOdvco2UyhzBw90OyHEB/sFkphVKFeQIsh
 XPYf+aLToFFnJyYxDNSmSlxFP/1JYf/YJuXmGkN8Hm3oCEh+7lpe5ywqNl9vGqSRu44ufXoGQwaba0
 ZfYx3+mr/DiaIMm7DGAM2nXygeDCW3eI1c7gbrn7ulkckq9f2RptCQwwCkng==
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
 .../bindings/leds/backlight/silergy,sy7758.yaml    | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
new file mode 100644
index 000000000000..64af6b34641a
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/silergy,sy7758.yaml
@@ -0,0 +1,52 @@
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
+  vdd-supply: true
+
+  enable-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
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
+            vdd-supply = <&bl_vdd>;
+            enable-gpios = <&gpio 16 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1

