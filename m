Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB16CD6E4F
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 06:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC1B10F95F;
	Fri, 29 May 2026 06:28:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="TFFvbTRC";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 491F810F95E
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 06:28:42 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-36b0c968fe8so3189875a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 23:28:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1780036122; x=1780640922;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U1BXKQ5cO0sS+w6dWfKU1RmTE2+q5/z7tw+KfuVhcBA=;
 b=TFFvbTRCVC3/zqnPQhQa2Lcy9tPpJ7p8b3OTdR9gpxOhmHq/iRHTfFEYkDjoqRs9Ap
 ZBMX6VWBeb6duB+qDaBEljniiEbcYOUuG53woO6uDUW3lZ+dXMiG0JW8lHsroNt8ibrw
 vgdJXYwFUu2QknoSK5corwmf571Y2Pbg7hSl3+v4SenTD4F6j7IyauB/poFpe72arwxr
 lhr6V6hFru9Y/FTF5EH/X9AGW7a4JPRhOlKF52uZ2XEKE4AQzU8vZKmcKj7DstET2SqJ
 NVzL5rPlxDl4KkUTXER+bH4XNHydXXxgQi0LYVsmlULoiOcW/BY5C7yloQbvC6jDr2fE
 +eAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780036122; x=1780640922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U1BXKQ5cO0sS+w6dWfKU1RmTE2+q5/z7tw+KfuVhcBA=;
 b=VpbzrnPl9a4cg1ic1eNLS+E+WRQFVrd0AKiJJbL4vTJm6FQhe2f7JNpAjUzyZGaYjS
 mm7u0HsBeMbb8YvXD77PyYhjatSOrwoRh9WUfWNmfsI5qmDiN0o6aAw1rFO1QPWUYmUD
 Pyd39rFoUSWGazszHbVw4MJW0Oi6RUdAm8IqbEdX2UhkQKpp5ixrUP2nNN4mEQfzwvOR
 FDP+RBq+m6bDdj+2z/nbRI9Cll+UmwLzbFvzPkNREGuv8sKbK5YFMchPzPuvoGQP9zKJ
 In8FeovVXOMq/qT7YVGSg7XTH3XdmMMpZ1YzlajasMLFvW7nB0MBh2uygN5eJIgHNeMN
 jwyA==
X-Gm-Message-State: AOJu0Yx8QwvAtx2N8Z+NpGJlpZjDLZu3FQ1gUD7z/ZnM8ON/wusjy5v6
 qryhoR6tvRwuw+iExKjL8VQOt3RLw3uLOsHCfkEPopukcqw/vi0LazzkoiX0Bgu50NQ=
X-Gm-Gg: Acq92OHVConETy13CoQ0dKHkTmNoM04e7sq3H7lNG5wbfQyFYsCbx8u1l1Bt2RxKPua
 nZLd4YC0NLTD469KmsL2Rl2t1L0+7paWvNSk1znX3gJQ/hdlWAmH2gEX53sj94JI7B5yyEmv7uV
 K/657E6pb1VDu8s4GhDbH9PmG5FAjPkyZMhSAN1o53hzXdYHrslxNTcLv5Eu8BGGqPkgV/L7wvu
 GkV46Wpy5LMFgk7ctYkVlgH/Xz8VULh/5Hm2sheevhythZ9FpNylhIGXp6HT6w6DH/F0S9V0WOB
 5CB4xFh7xoN0++QcfoFSrqbmaECasEXxSxGuVAGE7/Gx3pFlPHQhaadUe8jMwtU5UgHe5wgWV9d
 xKfxAeADey4JJDh1IkowPmdmqZ9ChOA8AdTLYxEWbzvwBU3cVa27yXm6KiFb1XjhpfTxonIupL1
 7AH65MrYo+1JCep2qlkGC2stAQxg==
X-Received: by 2002:a17:90b:1dca:b0:368:a297:bd38 with SMTP id
 98e67ed59e1d1-36bbcd626b1mr2097204a91.7.1780036121753; 
 Thu, 28 May 2026 23:28:41 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36bc6a340b7sm717087a91.11.2026.05.28.23.28.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 23:28:41 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>, "Kael D'Alcamo" <dev@kael-k.io>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v5 1/2] dt-bindings: display: panel: Add Ilitek ILI9488 panel
 controller
Date: Thu, 28 May 2026 23:28:35 -0700
Message-ID: <20260529062836.203990-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529062836.203990-1-igor@reznichenko.net>
References: <20260529062836.203990-1-igor@reznichenko.net>
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

Add binding for the Ilitek ILI9488 panel controller which is found on
the FocusLCDs E35GH-I-MW800-CB MIPI DSI panel. Add "focuslcds" to
vendor-prefixes.yaml as it's a brandname and a website
(https://focuslcds.com/) for Focus Display Solutions, Inc.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../display/panel/ilitek,ili9488.yaml         | 63 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
new file mode 100644
index 000000000000..ea7449273022
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9488.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9488 based MIPI-DSI panels
+
+maintainers:
+  - Igor Reznichenko <igor@reznichenko.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - focuslcds,e35gh-i-mw800cb
+      - const: ilitek,ili9488
+
+  reg:
+    maxItems: 1
+
+  vci-supply: true
+  iovcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - iovcc-supply
+  - reset-gpios
+  - backlight
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
+            compatible = "focuslcds,e35gh-i-mw800cb", "ilitek,ili9488";
+            reg = <0>;
+            vci-supply = <&reg_vci_panel>;
+            iovcc-supply = <&reg_iovcc_panel>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+            backlight = <&pwm_bl>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 11c55b5df0e4..ce195c72db6b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -602,6 +602,8 @@ patternProperties:
     description: Flipkart Inc.
   "^focaltech,.*":
     description: FocalTech Systems Co.,Ltd
+  "^focuslcds,.*":
+    description: Focus Display Solutions, Inc.
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
   "^foursemi,.*":
-- 
2.43.0

