Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F0A8CD8C81
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 14:50:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80DF710E36E;
	Fri,  5 Jun 2026 14:50:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="dZ4JF2ke";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D658F10E47A
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 14:50:54 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490b8a97b11so22218365e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 07:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780671053; x=1781275853; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=dZ4JF2keS894oilFAPN5UV91pusP5w0CpkweShMUBMZmka7p6br8c9143koCXdQGVO
 5PodcXMF3TlnM3ltMfRi3p+xwZGAVUg306X/rz92oU/N3VGhYzNzMQ/V9Xe3if0x2G4e
 bGGCtFkx4plC75eFphnFL5huFwftA5gyqepZOvm9Xczy7Eljoh9i9mXPAbPL/fT+AXY6
 4gwEFFMPqIxQcCMRn8XXB14l0/6fEdrc4u/Ka+UpZMl3KigG9VMpbR9NP82kX1pWYXJi
 2E71vnVNONztfXB7dH3zIOUj29LLCQdn6QUSRO3o+15niXskDldDQ1sP5Zdi+X3oo0DP
 H3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780671053; x=1781275853;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hvOvrszp2Uvv8rX7bLK7ODaTkPYIPo5Pf15awE1QSpg=;
 b=Z8Qj9bFe/xcwGZSEIVaI82U/rOU/aJs/IuU+ko++i4DYSk+4MJF0/GhwgoZEXpOyc0
 Ywvp10tzKLPWAyPRDFL7yi47MTXaVutl77dQ7Lk1RvAQkVS870jEVkDSwL146MxtvIQ4
 cG2IYtCyD6niO91+SPupOXJZsfw3GUEdvHux/hpD3K4oYTocl2xrsKllzj2/okvcaOpF
 FPKMXrl4JhJHJaT5A0XwFjcjtnP/9jH4NvTQEvw3S+o86fjukIWk04NdwK3jVwyHHfBb
 XW2G8on7anZxR7kPAHAnofThHXCd5b96pDFXj4uP5fs3c30b6dt/2Q1HWKdbdXMFv97E
 PtrA==
X-Gm-Message-State: AOJu0YxvCkiXuOF+CAJejfkxL/aWIo46oOc+XW0o1YosCkUX0JXcv+r0
 mr3DEhzaVo2iPGn5ef8DVABPUUrAn6B6t/VuJsRzq6Wth+Fgr4AwsG5eUePUMguYrCw=
X-Gm-Gg: Acq92OHkhfmPGgjwsP3cLGZfXLZ2SSXBnAOtrIiGftUQSSiQm/1pTT5sFvzAErD77NV
 YBSk734/DwUD9YbYMWZn1C3ERUQo1ds10VFxlHdyOnsvsOnosIHXtWoYGNYwYrNoc/M9fm6T8Sz
 P3IZxi0pU9xFi0TLrNA+0yvkssrDgzo6nXWdtAKq1XDj+ASTGaDhP4QkO6Ve+wYQoXk2ek2hifL
 96o5zsrBYyvoXTrADB+q18zEWbZHwCNWfRJvjbuDp5HLrdIU/Z+5F3X48GhZrtns3v2rp/uWWMQ
 HZjQRlt7EDbNTdkT4B3yiNisDFUn4ifWsMqq+1AQAdwYyu/141uZQD8875e0Lc0RSsgM+ef4fFP
 +YEl6BCsbUwIy5CTjz/kP5Jw5BImlE+TfeeKD7Xwhk40kjYE47kTIn+RP9hua7LiCr9PNSPtkne
 nPTBTOYDhvSFyA9fCl8tgK6KLU9TPQKAioA47kufqfea4Y7RX8xMKCWDk=
X-Received: by 2002:a05:600c:1d2a:b0:490:bbc1:d508 with SMTP id
 5b1f17b1804b1-490c258f3femr63175265e9.1.1780671053233; 
 Fri, 05 Jun 2026 07:50:53 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:8261:5fff:fe11:bdda])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3d663csm176178315e9.11.2026.06.05.07.50.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 07:50:52 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Fri, 05 Jun 2026 16:50:48 +0200
Subject: [PATCH v7 1/2] dt-bindings: display: panel: document the Renesas
 R63419 based dual-DSI video mode Display Panels
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-1-b84b6da84293@linaro.org>
References: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
In-Reply-To: <20260605-topic-sm8650-ayaneo-pocket-s2-r63419-v7-0-b84b6da84293@linaro.org>
To: Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2928;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=Zq5948yoVNWLdfl4Pn1AIZbbP3FPXFuxs6toZA6iUAM=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqIuJKaC6NnAOgXUpHx2SGqu6VbQSUlcXpB3nOZamO
 e5huDv2JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCaiLiSgAKCRB33NvayMhJ0Up7D/
 9r4ovOAYIVK3WcNFHk9qeDgV9eLJu/wIf37wDry0xRxkzvRmC6Cxgs6TF1QcrcsteEf/pSWwYG6Cti
 8UHPLE/vEo5petdxaZHa5MQzI+uWKlSiC7ibXpIGSvWvw7M+HtvU90jPY2ugT3fEz+DY4sLrpjTEe4
 5KpYHE5rwWJfXpywOinAwxBHpejy+HLECbyaimr3GO89A/GB2IKgVGJpv6jp3ufIEIUySd98ID0abj
 +nbkRM9rtzswEUx8bmB9n4e5MjHjbKQP1CjPcksdpJQdGVYYXYuL3d0kBmQJV/FueW3s+s6iQffCsh
 3zLqyWDB17EKdTorb4laMx16T66xKLtJOcItLy3WS8IMdQvF5x3fcQn4CneKS0U4NjTeFOAntywHi/
 32YsArVDPT3Wlk6oC9lpySjkmBKSVR0VQuwlhdYPChz8JjkSwPENMUC/11mWWrJnBg1x7b7OZ095Ps
 sU5nWEv1wd81lveWNhTz3/NjWPouhIv+05Y/ZjQjju6iPbfY9ft1oWuSV3HSddtfn4sqQW1ZtYMlSM
 k1S1xamAvJCZtV9tCS6E/EZWue2xUiXkcLUoRP9ARtC1qq71dcMU7VqSkNUeUokcm9tcOZKkIz6/Ol
 RzYfRPa8WJxgQsGlP8w2ZO8ZQKnycKEReAnEjlLsdFisFmUUH6GWBTMi4LYw==
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

Document the Renesas R63419 based dual-DSI video mode Display Panels found
in the Ayaneo gaming handled devices.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/panel/renesas,r63419.yaml     | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
new file mode 100644
index 000000000000..adfdd2c300a3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/renesas,r63419.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/renesas,r63419.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas R63419 based dual-DSI video mode Display Panel
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  The Renesas R63419 is a generic DDIC used to control dual-DSI LCD panels.
+
+allOf:
+  - $ref: panel-common-dual.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - ayaneo,wt0600-2k
+          - ayaneo,wt0630-2k
+      - const: renesas,r63419
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vddio-supply: true
+  vsp-supply: true
+  vsn-supply: true
+  vci-supply: true
+
+  backlight: true
+  reset-gpios: true
+  rotation: true
+  ports: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+  - vsp-supply
+  - vsn-supply
+  - vci-supply
+  - backlight
+  - reset-gpios
+  - ports
+
+additionalProperties: false
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
+            compatible = "ayaneo,wt0600-2k", "renesas,r63419";
+            reg = <0>;
+
+            reset-gpios = <&gpio 176 GPIO_ACTIVE_LOW>;
+
+            vdd-supply = <&vdd_3v0_lcd>;
+            vddio-supply = <&vdd_1v8_io>;
+            vsn-supply = <&vdd_5v0_neg>;
+            vsp-supply = <&vdd_5v0_pos>;
+            vci-supply = <&vdd_3v0_vci>;
+
+            backlight = <&backlight>;
+
+            rotation = <90>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    panel_in0: endpoint {
+                        remote-endpoint = <&dsi0_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    panel_in1: endpoint {
+                        remote-endpoint = <&dsi1_out>;
+                    };
+                };
+            };
+        };
+    };
+...

-- 
2.34.1

