Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 861F0FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 10:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30DE910EF18;
	Wed, 29 Apr 2026 10:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imd-tec.com header.i=@imd-tec.com header.b="cQRjuZ+x";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B08910E7B3
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:22:31 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso103189875e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 08:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=imd-tec.com; s=google; t=1777303350; x=1777908150; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kxIlr02u0245SQX0aOke1TpITzvCVNhVlaMNlcxWD0s=;
 b=cQRjuZ+xxApBoyPP04sksrRna03K0UyRy5ZYRex+we1+GWx9kfjQHWV01ccQMPwSfr
 qKMYVpEsMaBry4zwSofhVbgYC4bHNPXEwKJ2KP/7F2rh6KYGWGKY/MP4J7DjxS4Fw4rZ
 EsfIuk8lOX7ZQzX4erU4ZeGclQwbquBJIPc1Y00A4/EE78vuRJp+MteVwqgRVA8VjzXc
 gklbPOV4tYenaP2oJRS3FryB+/Yi2lckBkjjNvQgS48O0dj0bS5774WqpybNrx7t2Vab
 LRdFGXcOSAveEddo/2ozr8JUiyLK6PRfVpvxaXtpW9lMr54fm3ViAqaTgbIL/ecTEbKC
 zXjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777303350; x=1777908150;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kxIlr02u0245SQX0aOke1TpITzvCVNhVlaMNlcxWD0s=;
 b=gLieE6iCZyAsFH02UKvvDMRpKp7kiHNAXLijEp1S7TSOP7iEhmG5DJ87103bndN4pk
 sYV5VgwqMuRRQUrbLG+yi225qiB4TniAvaHGdCZuxLk/TYfB3s1AwASw/BrYPfLmpkNe
 +HBKEcbQrc9bFRUw/F2RQIOSnJScPpOybsnqpG793/OTwTh4WDSExnK/FlZUrZuLKSPH
 ovF8lmpSjrrZ235sC5c8+ZCPDtqpRw8S9fRvgm7FzNSMgcC2Q63iBcbHnyrkMLqv6dFu
 z4ZkLiivXjOJk3I4z+g5Mvzsk9ZGYrqv4yuDEPAjy7f0DPFi90Aw0/h41HEaYdQOlwup
 LhIA==
X-Gm-Message-State: AOJu0YzJMVPpqAUT8QRkoY+uiuosE/6Xu18dO9eaLHIPw82UGn7k51qJ
 oGb9UohxDDBkjRvg9+F46mn8F76vqVy5dFMLy14yTtI2LAj/wO4W1Y5B48OO77MQWUY=
X-Gm-Gg: AeBDievZRHVg7hELSSwQ1MKXAi430hT4Gk/BlucHyCTdVaaJf3UcKjpd9f0vl5Dg0Qh
 GGO6S7jgtviu/vMhRxy0cKGVVXRSc+xd45OFtU7dVEqlWjxhRGdPc7ZzLYzulvK8tqa5cSqzNrk
 9JSADgv5HGQand4m3h4UJJENHLtO59Xsn8bEgl9Cv70a1YhqAsOhH3YoW4nqq2fgDXrA/xuOnh1
 24vgRmhWZx1oiXikIVOA9ZI6L7XPLUje823+tdDDe71ZFNtWDxMUGV2Lad0oK3JgacxoHzJSKc/
 kHQIFLZKVaIvIQ87xwRiYT+luclMRvMeMLTMc42TmajmIJAB2AYWRfEXFl8s7HvqSxl8cohsMps
 mxJsMNXgFSka7nqtCnf8Z4F04HgTC6daGUa9qocQZQey51dy7KqILYhObNLsVl0g571ARGgKzjE
 5iZV1/n35ZUhD/eFMzs9qZU37dZ4EUogWqfqI1ZsC51Armaq3BO73nH+R4qee1ThgT/C9YWtLmf
 tZzQ1B298p50h5Ki3kEXqatIv60uw==
X-Received: by 2002:a05:600c:4f92:b0:48a:f18:ece4 with SMTP id
 5b1f17b1804b1-48a0f18edf7mr408561105e9.24.1777303349827; 
 Mon, 27 Apr 2026 08:22:29 -0700 (PDT)
Received: from [127.0.1.1] ([82.71.135.85]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc0f8188sm861247695e9.2.2026.04.27.08.22.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 08:22:29 -0700 (PDT)
From: William Bright <william.bright@imd-tec.com>
Date: Mon, 27 Apr 2026 16:21:09 +0100
Subject: [PATCH 1/2] dt-bindings: display: panel: Add TSD TST070WSBE-196C panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-imdt-dsi-display-v1-1-bb2768de120b@imd-tec.com>
References: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
In-Reply-To: <20260427-imdt-dsi-display-v1-0-bb2768de120b@imd-tec.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, William Bright <william.bright@imd-tec.com>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Wed, 29 Apr 2026 10:09:58 +0000
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

Add device tree binding documentation for the TSD TST070WSBE-196C, a 7"
1024x600 MIPI-DSI TFT LCD panel using an EK79007AD controller. The
panel is connected via a 4-lane MIPI-DSI video interface.

Signed-off-by: William Bright <william.bright@imd-tec.com>
---
 .../display/panel/tsd,tst070wsbe-196c.yaml         | 64 ++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/tsd,tst070wsbe-196c.yaml b/Documentation/devicetree/bindings/display/panel/tsd,tst070wsbe-196c.yaml
new file mode 100644
index 000000000000..fe3f45aa4575
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/tsd,tst070wsbe-196c.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/tsd,tst070wsbe-196c.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TSD TST070WSBE-196C 7" 1024x600 MIPI-DSI TFT LCD panel
+
+maintainers:
+  - William Bright <william.bright@imd-tec.com>
+
+description: |
+  The TSD TST070WSBE-196C is a 7" 1024x600 TFT LCD panel module with an
+  EK79007AD controller, connected via a 4-lane MIPI-DSI video interface.
+
+allOf:
+  - $ref: panel-common.yaml
+
+properties:
+  compatible:
+    const: tsd,tst070wsbe-196c
+
+  reg:
+    maxItems: 1
+    description: DSI virtual channel
+
+  backlight: true
+  reset-gpios: true
+  power-supply: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - power-supply
+  - port
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
+            compatible = "tsd,tst070wsbe-196c";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 133 GPIO_ACTIVE_LOW>;
+            power-supply = <&display_panel_pwr_en>;
+            backlight = <&backlight>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+...

-- 
2.43.0

