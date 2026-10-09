Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E80BCA6018
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 11:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036C7112085;
	Fri,  9 Oct 2026 11:25:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="5YdgMBv2";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 185A7112086
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 11:25:09 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6afe29c08ccso5294026a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 04:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1791545107; x=1792149907; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qgqhj3Epuh5RclDvybJ2oNFa673B4IjvzwU5Ux/nnZ0=;
 b=5YdgMBv2v4v2keiX910X9otyRDJfOOuHnYV++FPT66KT5b6Xu/KVvq5NHGGLRrzihX
 1SaUk28YgduwrXEv17DlfSPyLa1cHUy5WRHMtwhZBxzto0/aKZqjJXz0fGUrGpgH29Tw
 ooZg6uzaQuKffZJVAaMENk5I92Mj75F9ldZbopcpiiNWjswrzvoCKSZINDC6gFJXpo8C
 wgKUrdotXPycEbCGwueCGwTXNKMrxVZOuFNXojoytvUm6y2BEnQ9qQfL2LPXUzn+npK6
 RFmbRXdYhIw2lcmGfUA2fMfxdpuw4XL6AU8zEkEvA339+oJlYpS3TNjLhO5iTlg3qC46
 OOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791545107; x=1792149907;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qgqhj3Epuh5RclDvybJ2oNFa673B4IjvzwU5Ux/nnZ0=;
 b=bAj9KVxnZdJIhuWn16rj1w7dGunBLpj6/0fqlBxjgHa/k6ZGbzU7QgOBsCxSK0idru
 oCrHUc7xTcSEEJhS87GmT102LbOyW3yiwcAuaSolmBvac96ejgBuYNHTzV8JdxpXvKXZ
 z/9qi3sjhsK2TiPYzffyuS4pJwo4A8qbaz4bvDkUbWQDh5BrMvKSXQvBFKUMGu2/FcM8
 s2QsViOWOvgQv1X4amey3CgcnDxO6C1kOjzmPUwDmf4rmP4AQQvZ4UmP7cNxMg5Fgsw9
 GOhX30wL+c232mHtJsNCXSWqFeaw6Hj8Y8Y6WhHGXZrhcebm0UFFdVThyjMI8GKojRC9
 wCSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV0xbxIHlJrPbW/WKinrtY587z9cuBPqhqF/7Rpb0cyYkte3WNW/63Cs5omizn1CNFoYuZGGDBCrY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKSL/4/Qnn9DcVh/LPMlDhWUo9Fc1JZoFlHSg0M2QjRUH8Y1QaM
 hZ91DV52rYrnY+VgplItTHMxDw3I2JMnVMM06j1jkMJTnw4K4Zbj50vPaTXkUuiTKzA=
X-Gm-Gg: AYBFou2653zKi0H/y+R6/EIARvVuxaKo5LlxfLbLnGlUHIs9RFQk2vjDrZnpoaJlmRA
 KJBL4xtDEoTP5Pkum0t1Jsm8/PBirn+Uly9DX5+aRas8HjmOJmrCBUBABcbcybKn8ciPOwr/GwL
 SZXUDfEcyETjOrofJW9tk9/Bnl+gm5CsbOtcEriBmpyF/LKq7FQ1Jkx0aIZgU6AP+vCtDmotBlO
 S1dUHPZzCv4GecmdEz+HV22P61fOqNpFupB26tKYyvhzKFPaIMTyXEy3SXwkq0bzQOYo/1ciuNo
 iUz0PS9XwwOW5VhPt7iJ0gx3+xtl+FNR3yyerRjKYJnWz3huAFCNoEa3xmkFwhc8mysUqtJhRtb
 0h6+Jbz/yYqzo74ty+DvFULwMGr22KR161IBCPG/OQDBuvh4/dbCYdy6rCQs6hOkBzYT8jZDqMJ
 XuZE62hFW+uiRNChFrkzstOHC+27vWEoLY+JTKEGqMstmZ/9MZjpEgVvFvg7OlPKHubR18uzExR
 umTdhC8Gfeqxd44FfTDyiahxGes/mB35ShptA==
X-Received: by 2002:a05:6402:46c5:b0:6aa:9fd4:35fb with SMTP id
 4fb4d7f45d1cf-6b17c2a3a96mr1071864a12.8.1791545107423; 
 Fri, 09 Oct 2026 04:25:07 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b179dd3597sm985764a12.14.2026.10.09.04.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 04:25:06 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 09 Oct 2026 13:25:00 +0200
Subject: [PATCH v4 1/4] dt-bindings: display: panel: Add Novatek NT37705
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-fp6-panel-v4-1-7c3819664778@fairphone.com>
References: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
In-Reply-To: <20261009-fp6-panel-v4-0-7c3819664778@fairphone.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791545105; l=2354;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=ZXP6OkY2DxkiTYSnHO0CLOwn5hC6SXDi4hWyiPvZAl8=;
 b=C+M4NZ57qJgderrEKqwE1gICaP8nnZl/AfQkRQF9zw8yx5PfCq072o6iLhRO4Gg79d2Ci7KPe
 Wg1nfHk6yJXCzznwRDm1eNVnS3IC+4sMqtW8RAqWHzth9V7ZH1s9DQc
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Novatek NT37705 is a display driver IC used to drive AMOLED DSI panels.

Describe it and the panel in the Fairphone (Gen. 6) (BJ631JHM-T71-D900
from BOE) using it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Link: https://lore.kernel.org/r/81a3c207-4d8f-490f-8e2a-6f3f4c2acd35@kernel.org/
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 .../bindings/display/panel/novatek,nt37705.yaml    | 71 ++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
new file mode 100644
index 000000000000..850d91e25af5
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt37705.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt37705.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT37705-based DSI display panels
+
+maintainers:
+  - Luca Weiss <luca.weiss@fairphone.com>
+
+description:
+  The Novatek NT37705 is a generic DSI Panel IC used to control AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: boe,bj631jhm-t71-d900
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - dvdd-supply
+  - vci-supply
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "boe,bj631jhm-t71-d900";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 12 GPIO_ACTIVE_LOW>;
+
+            vci-supply = <&vreg_l19b>;
+            vddio-supply = <&vreg_l9b>;
+            dvdd-supply = <&vreg_oled_dvdd_1p2>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.56.0

