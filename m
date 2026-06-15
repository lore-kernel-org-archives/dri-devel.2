Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735E5CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 00:17:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BA310E14C;
	Mon, 15 Jun 2026 00:17:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.b="gEWReboa";
	dkim-atps=neutral
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com
 [91.218.175.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DD410E14E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 00:17:49 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
 s=key1; t=1781482108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vuvqav2sU6zSRBZDHAzLQ2ucs28StDCHC2l3aV/G/U0=;
 b=gEWReboaLC9ILUVIVaLt9fW/I982/gpbCwY1HkbyuN+C9Q7dWlFCmRMIZOWLqD3gxf81CD
 dubMjf9Uz8KzqfFVbCvAru8FEl0vT5D8EiDxBdNSu2QRn7Qq/GIw0d/DH8X+VRGLWJfvdc
 CJWwRHmhPKmp1r4d8OnDN5WAfgA2MCw5/+XmZNRbcyE4ggcj4a/QMziAZKQLQ39lFWCAZs
 5vadsLAvFNRvTzp8rOlsZngI0TGRInKUUibq4LYKr5Nm++E3/7R5oekfTQ+3fDv0CjqHfs
 P/AEzDTiaTec84IN4NIRHpldfMGSUmEwg+Zj4dhTGHb+X0klyhmP45TbKcasCQ==
From: Paul Sajna <sajattack@postmarketos.org>
Date: Sun, 14 Jun 2026 17:07:59 -0700
Subject: [PATCH v3 2/4] dt-bindings: display: panel: Add documentation for
 lg,sw49410-lh609qh1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260614-judyln-panel-v3-2-07f4134441bd@postmarketos.org>
References: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
In-Reply-To: <20260614-judyln-panel-v3-0-07f4134441bd@postmarketos.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, David Heidelberg <david@ixit.cz>, 
 phone-devel@vger.kernel.org, Amir Dahan <system64fumo@tuta.io>, 
 Paul Sajna <sajattack@postmarketos.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781482095; l=2409;
 i=sajattack@postmarketos.org; s=20250422; h=from:subject:message-id;
 bh=Ks9/ggz0gsVtbuy3t9hg1UTiYS+A12Js0rYjwehxUPU=;
 b=TaxnqGmI3KdzfXiBJe5J0lfduQUw8XGGu66SUV6wR3T4yI6PCsarkN5kFltywOvESRe/X22oU
 o432i6+6lieB3zfduUwHO+HEYi/Ph/LlKNdaUqfNOXv8Bv/QubQIQyR
X-Developer-Key: i=sajattack@postmarketos.org; a=ed25519;
 pk=TwacvEOiRJ2P2oAdEqIDrtQTL18QS4FfcHfP/zNsxkQ=
X-Migadu-Flow: FLOW_OUT
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

Document how to use lg,sw49410-lh609qh1 in a devicetree

Signed-off-by: Paul Sajna <sajattack@postmarketos.org>
---
 .../bindings/display/panel/lg,sw49410.yaml         | 79 ++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
new file mode 100644
index 000000000000..4c4bf4d89353
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/lg,sw49410.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/lg,sw49410.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LG LH609QH1 MIPI-DSI panel with SW49410 controller
+
+maintainers:
+  - Paul Sajna <sajattack@postmarketos.org>
+
+description:
+  LG LH609QH1 6.1" 1440x3120 MIPI DSI panel with SW49410 controller found in LG G7 ThinQ smartphone.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: lg,sw49410
+      - const: lg,sw49410-lh609qh1
+
+  reg:
+    maxItems: 1
+
+  backlight:
+    description: Backlight device reference
+
+  reset-gpios:
+    description: Reset pin reference
+
+  vsp-supply:
+    description: Positive voltage supply
+
+  vsn-supply:
+    description: Negative voltage supply
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - port
+  - vsp-supply
+  - vsn-supply
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
+            reg = <0>;
+            compatible = "lg,sw49410-lh609qh1";
+
+            backlight = <&pmi8998_wled>;
+            reset-gpios = <&tlmm 6 GPIO_ACTIVE_LOW>;
+            width-mm = <65>;
+            height-mm = <140>;
+
+            vsp-supply = <&lab>;
+            vsn-supply = <&ibb>;
+
+            pinctrl-0 = <&sde_dsi_active &sde_te_active_sleep>;
+            pinctrl-1 = <&sde_dsi_sleep &sde_te_active_sleep>;
+            pinctrl-names = "default", "sleep";
+
+            port {
+              panel_in: endpoint {
+                remote-endpoint = <&mdss_dsi0_out>;
+              };
+            };
+        };
+    };

-- 
2.54.0

