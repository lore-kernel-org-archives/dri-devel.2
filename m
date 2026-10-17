Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A1CCF2CF
	for <dri-devel@archiver.kernel.org>; Sun, 18 Oct 2026 14:53:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC2010E688;
	Sun, 18 Oct 2026 14:53:39 +0000 (UTC)
Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com
 [74.125.227.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A2310E24A
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 08:36:40 +0000 (UTC)
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-39569e136f9so220612a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 01:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792226200; x=1792831000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v7htvYaNC/HedOMza/ALRWxx354TzmGzWUI+IoOlx4c=;
 b=H+YhtM0hASVisBfMPZXFNZ/da9EctvdlMuRGmpc+C5erMuVQtrmt1+K+h8LLCv0z4M
 5uZhYZxFUzqf9yagWz2h+yJ6Yuwapg+0GgNuFuxSrUiSLTAAcAfjO4kIFGqQY9d9S9Ao
 g+1akHm56Z5Gho7KA2F2n6RS1LjjaM0jduZSGVE4Dfz0PUMEgTddXnqE27+G5oWay6r2
 bp/hG0jHZ0ellxRgijGk2LBh8TRqDxAtRbFcce872RKja4fJ0EDs6dv9BgGYKYBeOBih
 PoQl4hEcYw5WOqFYSqjCpUM8qJ24KNBnAAt0/aO5VM4haF5Zw52ayYIZyg0LZyijfTJg
 J9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792226200; x=1792831000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=v7htvYaNC/HedOMza/ALRWxx354TzmGzWUI+IoOlx4c=;
 b=S5spfBDAIhkK29+QxShxQoho0VqAQ46zDs0ICMgv6XsVUvC6yjBgRyUB8U8yxk+Tzq
 ZSTr5Ycj+1XKC2WNMkVCFei7OL+rH6FqTJaZXiDDmkOBZiJYBDuD63ngrbr1o6kKIQfQ
 X1seADTFhuJQTZgaqWGdt3lZQT7k3drh0u7cLOYojWIKsVad41RD1+z2AHU9HK61P0i8
 K2SRdMwMNeSZKDk/ns2YcEenzG6LX7FYVXw/frNTDAicqFOsNegj/WQ3QdwZ1pBuq4fH
 x+i6/fVoFiYFBxvGf75akwTOk8P+wshwMqbITvgr4rQ27LCGe6YF7ZPJXY21v2dgyV7q
 0A9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBy8pCBRrtGKfzxaYe7AGn1Y7D1dgIelaPRA13hshO1Oy66fNeeH68/57CijKouhu4g5Cs1ID2bXdew=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8MECTH2x7Wx73e4Di2X6sDVsvyvFDxQcMgHPQEtoisiXPzTwt
 6COdoV4y+faiOHKbtI2ggUswLRowwDRto9x3pfGrxBjBtBHCJoVVhYTQ
X-Gm-Gg: AYBFou3yEVOKRH3n0G+Z4z8m/qaDbtzgossk55oC/KusYweIxZ88vym39E83ek+gLbx
 E5BlSeFx+Xkq3jWb+mpL/6a0IUwE4HfaS8WazCrnuW41ysimY9aCDQSyNZgz2zA62/YetJ2CS9d
 OOo/hSVIjZIQG+kUw1oY0VEectoQQUa946qPdUPw4rca3Y4MioFCXuAT7M8wVegFsBHm0KavYw1
 YPKT0S/a1tOH4WDHQ6aD8x9a1ZZCH9VYiJTVgK8Iw7O5/4GfD87P+ZIGZ3uQYiYy1LDV8PVLPDA
 r29z9Ufr7QawBLOg0PzY87YK9gha03JrFyRgSQciy9EWd7EIwDknsZ0KTB+N7J++Dzxb1fqYZL1
 QF3aGkeZmu5fSxJjuu40O4ZKP7f7t9K8fsUzJNKi3N6i4xhvrCmmcJYHM1wVnIepp3UG5HPQz5u
 X/YtGEdHE28BZj5TJD6uxupSUeBZeAPlh9NPKucpnS1tm50IJWLxOAYYM=
X-Received: by 2002:a17:90b:574b:b0:3ac:9717:afd1 with SMTP id
 98e67ed59e1d1-3acef589989mr1825660a91.63.1792226199581; 
 Sat, 17 Oct 2026 01:36:39 -0700 (PDT)
Received: from Linux-PC ([2a09:bac5:1f0f:3141::4e8:8])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac9461d71esm12548544a91.7.2026.10.17.01.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 01:36:38 -0700 (PDT)
From: tianshi12127 <tianshi12127@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Lu Chen <tianshi12127@gmail.com>
Subject: [PATCH 2/3] dt-bindings: display: panel: add Smartisan TD4362
Date: Sat, 17 Oct 2026 16:35:30 +0800
Message-ID: <20261017083531.766557-3-tianshi12127@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261017083531.766557-1-tianshi12127@gmail.com>
References: <20261017083531.766557-1-tianshi12127@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 18 Oct 2026 14:53:13 +0000
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

From: Lu Chen <tianshi12127@gmail.com>

Document the Smartisan TD4362, a 1080x2242 command mode panel
found in the Smartisan R1 (trident) smartphone.

Signed-off-by: Lu Chen <tianshi12127@gmail.com>
---
 .../display/panel/smartisan,td4362.yaml       | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml b/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
new file mode 100644
index 000000000000..a46bc2f53030
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/smartisan,td4362.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/smartisan,td4362.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Smartisan TD4362 MIPI-DSI panel
+
+maintainers:
+  - Lu Chen <tianshi12127@gmail.com>
+
+description:
+  The Smartisan TD4362 is a 1080x2242 command mode panel found in the
+  Smartisan R1 (trident) smartphone.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: smartisan,td4362
+
+  reg:
+    maxItems: 1
+
+  vddio-supply:
+    description: I/O voltage rail
+
+  lab-supply:
+    description: Positive source voltage rail
+
+  ibb-supply:
+    description: Negative source voltage rail
+
+  reset-gpios:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vddio-supply
+  - lab-supply
+  - ibb-supply
+  - reset-gpios
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
+            compatible = "smartisan,td4362";
+            reg = <0>;
+            vddio-supply = <&vreg_l14a_1p88>;
+            lab-supply = <&lab>;
+            ibb-supply = <&ibb>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
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
-- 
2.56.0

