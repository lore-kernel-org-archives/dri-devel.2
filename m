Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1F2C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:08:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29DAC10EA02;
	Tue,  8 Sep 2026 07:08:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cdwSKYmD";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1BB810E7B8
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:52:41 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-485850cbac3so2194687f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 04:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788781960; x=1789386760; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tKFJorjn7zfsDROh07dztN5ti3ZHf/iVGFIzCs+Axs0=;
 b=cdwSKYmDMw5MaTCJFOUxFmNUvdp/kVyLlm2Z1ppa75t895u1tYQoSNStprPWEcAdWn
 mpXBpN08HwQUxY0G8ghmlA3+aNDvhW7ULLRDBOYa2ZzQcX8C1i2AnjQarK/bn8rbcc/C
 rlBLxABbuJO42/RFU/SEOzm2xsn41DNRplE6KBfy0EV4YpHDQ4s6kRDg5y/SyilOdzj0
 DhuNTsxoaqPlwB5uyN6stnF3hcqkNCsf5LfAT3/1CgZnctKkUvQB9TSxxB5c8oRmvc53
 jLPTApBdcZ/+GRByYHXDPWX27bTuNrB/N9XDWn9CYPot1AFU2wa6vsyHBjJvVrU0OK3Q
 4Cig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788781960; x=1789386760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tKFJorjn7zfsDROh07dztN5ti3ZHf/iVGFIzCs+Axs0=;
 b=dsmvCRLTVCrts/llAUZAVSE3tOl/PNcGmw+pR7jZt/uKFKeqaLa9w34vd4ImBSsXYf
 cCBtkYtxNjepjp35GFT7Jh5baJR68UNE0TNHQ2d0omFe/19TffuauBRa/t2GCzoMJBOi
 uHZB92Id7X1yw7ZmP8wo6CLV6cltXfOo/ZfCkI7MJehqJZBwb+p4JZW+f8XcOkV5X7+h
 sKVSFVKC8+BwleAbxzWNb07hBuguxQ8HHfUWknGg2mm4ElCF5AALUKtpT5PBuoHtllX1
 OkzMi72frOzK+I/pDoPm6xQI+MD46eHenRxfQenNJfUP2MyUA6SQrtt6lnbHaaCCFFU4
 qmtQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxTQnqA3ye000AlG8sC6IogibW3Q9ncZDuWNarij5QSnDYvrClOJBpxmFm7dn9ztipOp8jAoZRw0es=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lxh02jbzsOmwnVypyKYU4v/AN7tJLcaJskf1cDi6eWj73ahGA2
 ULI1Nb0bjdGSVypAVMYKHZABFcwi5jlnZhXnKvtFJ9aQUZFHxVdUHFIY
X-Gm-Gg: AYBFou1bjFJsTAfTUGTbD8S+FxxXGC17ni+1epaT9yr6HptgAt9sPsWmOR6Ps/xLwVm
 P+br7WZgPHQN2RS+Os+FmqdLEeSkCU7SIOQV5aI3vqqn0S0LE1l4uVB0o8fgwvfmDAQY3V+1//6
 CSd2qR+ydQAK+MLQcsughDRYtbCC6fQFz51Gp4AFsIGZ+74RlZPFs0f8eNeE/1Mz0bGLtdVXJQG
 ik60CxcpklJ+5Wl6LrIUTYjB7VDlP3XA9UVkbiczSPEZawuejVplVYu0OfnlHmUfoItMC/dRJkE
 iC0+JHAzbGkCbTDVn4wJe42Rd2KNhCRq+IQcetsYbzyazlGw2fMm3wciY8mE4aWtIQaRJAXXi3n
 ZYiM25eLFOl4sSG0qdY2ZUbz1K6LJg/bS4HZ/bAB6uAVqTuv4NXjlcVYv/tUYJkZKKEv5DWrVXG
 adwBkJGYtRm++eQaqFi6iwY5eLNXnZ61BEGxbbevnpV+AQDMnCfxs9lZy5qx/ljn1j
X-Received: by 2002:a05:6000:220f:b0:485:8c16:a350 with SMTP id
 ffacd0b85a97d-4858c16a62emr20292762f8f.40.1788781960074; 
 Mon, 07 Sep 2026 04:52:40 -0700 (PDT)
Received: from Empers0n ([193.23.219.104]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858d2693e8sm26830718f8f.3.2026.09.07.04.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:52:39 -0700 (PDT)
From: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
To: neil.armstrong@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org
Cc: jesszhan0024@gmail.com, conor+dt@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, mripard@kernel.org, tzimmermann@suse.de,
 maarten.lankhorst@linux.intel.com, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Vsevolod Nevorotov <sevanevorotov29@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: panel: Add Samsung AMS662ZS01
Date: Mon,  7 Sep 2026 18:51:29 +0700
Message-ID: <20260907115130.95394-2-sevanevorotov29@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907115130.95394-1-sevanevorotov29@gmail.com>
References: <20260907115130.95394-1-sevanevorotov29@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 08 Sep 2026 07:08:43 +0000
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

Add Device Tree binding documentation for the Samsung AMS662ZS01
FHD+ AMOLED DSI panel found in the OnePlus 9RT smartphone.

Signed-off-by: Vsevolod Nevorotov <sevanevorotov29@gmail.com>
---
 .../display/panel/samsung,ams662zs01.yaml     | 75 +++++++++++++++++++
 1 file changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.yaml b/Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.yaml
new file mode 100644
index 00000000000..b2697d140ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/samsung,ams662zs01.yaml
@@ -0,0 +1,75 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/samsung,ams662zs01.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung AMS662ZS01 DSI Display Panel
+
+maintainers:
+  - Vsevolod Nevorotov <sevanevorotov29@gmail.com>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: samsung,ams662zs01
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  vout-gpios:
+    maxItems: 1
+    description: Panel VOUT enable GPIO line
+
+  vddio-supply:
+    description: 1.8V I/O power supply
+
+  vdd-supply:
+    description: 3.0V core power supply
+
+  port: true
+
+required:
+  - compatible
+  - reg
+  - reset-gpios
+  - vddio-supply
+  - vdd-supply
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
+            compatible = "samsung,ams662zs01";
+            reg = <0>;
+
+            reset-gpios = <&tlmm 24 GPIO_ACTIVE_LOW>;
+            vout-gpios = <&tlmm 25 GPIO_ACTIVE_HIGH>;
+
+            vddio-supply = <&vreg_l12c_1p8>;
+            vdd-supply = <&vreg_l13c_3p0>;
+
+            pinctrl-names = "default", "sleep";
+            pinctrl-0 = <&mdp_vsync_active>;
+            pinctrl-1 = <&mdp_vsync_active>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&mdss_dsi0_out>;
+                };
+            };
+        };
+    };
-- 
2.55.0

