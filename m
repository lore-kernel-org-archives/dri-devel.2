Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77303FCD0C1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 07:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D52A610E6A5;
	Wed, 18 Mar 2026 07:34:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="MDuwfNf+";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70CCD10E441
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:34:09 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4853f2826f7so67690745e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 00:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amarulasolutions.com; s=google; t=1773819248; x=1774424048;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zo4QCx8aR6J7VFChxL1u3Y+zYNsaTehJkZimdyWgxLs=;
 b=MDuwfNf+F6W/QKyH2R4Xx+C7VQLvD0bTZUD3XM0rHJR1XYaG8zCWX1EX8sTgK3aqsN
 FVWYae/D/c4KyzL9HozbBmxns3U6jiWQZQLjbqKiCTxRfH24cXx3vnlWl4uzNhI8LDMY
 d6eXPVKM2DAEkiAiw7OFu3MbrXdsyv6kJ0Ks8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773819248; x=1774424048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zo4QCx8aR6J7VFChxL1u3Y+zYNsaTehJkZimdyWgxLs=;
 b=sCQcg/x35eclqyl0wPcQF3vaobSwH4dIf8dnjCMYimVMcfdtPc3hm4bhxGLxPTbfLg
 tMXNBkKFYue/Pgr2eiykD9ISL4hiOZHcW4AjPZESTouQv/U2ab2QC20mq6qIUjbyFRKy
 64FWW3ChZnqg8b9HCHoCMrEMQ0PDL+8oJkU/HlpfbvZ5OAPlJWJeDJi2iglCM1G5ZfZi
 pS1y15I0hs3IVgAqK6iUu/dGIlR7B3a4+pMwsVo/17JYiPzI20SdB7FS8HIABEmq8mtX
 xdE1CpZSrzvPuKqVU5adgJ+njAkX1GaWvXuM/ls9Wj3Arl+Nwaj4m6o0i675iZtEKflI
 f9/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTFU1M4tBMXlo3803rhXcdw/I2daQFSZTUXUP8T6N6BS4zzLdz+2sIkiyNCYoqyYyyFJb/5WQTT7I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+nWw5DB01aBA05rn2O4dkUn04AHj6DGZWaIs70mPtx+GY7crR
 YuoJLWx2jUgHI/3aAHm7BM6COPm0l4cEcxKTtHwLOSV2GsgyGM/OOUGKmMHfl0Ul2PA=
X-Gm-Gg: ATEYQzybuje+DH+vBNSICJcZ8nwCphzUbM3bzEi9XhBYdAUq1eF8FXERwC7huIedEun
 vMk/fRQzlIsbtiVhzxAPwMjvIDcPUE3W9pdudGrsaJwwgrmwjXdgaO84kKT4yQtd+TxthMQIR4V
 TiwQdjFd+b0+fKo5bhK1jxxcreXEs9hAzvO/jnqzC7Wz1bhfQpO5YJP/QvDK5RQhQOx2bNUps2+
 s3fQhcINtg7XkdpFqgQ+Gf4YDru715N7P5utBTJLtZq2yUjpxm96rypEKJotjc4TpwQM7SLlvAb
 IK/yHPj3rj9l8IUyMeEv0JdXibji9DdzfHN6jEu+CZmKEP/ugYq1EhbHXtcLXnDOrmHQkf/hOC0
 Fh8yk2tKtP5t2DlQf9ZiW0R8BO7qtn7xcYMKYlV6DNLI4OyvzNkFOQylgjyUq1xrScFQVnBum6g
 rhRvQAYxv+iqsl4flasK3KquyqUQBO5ZKBh5FeY3hP1jxlRjazyc1XwfM2DwOL22ojaZj/9nS6M
 UKocfmi8jIxofaVO72T9d5SBrFb4sljhdwyME0f+57PuK/UyG9yGFDzKzkokPZYEj3iqjq+0BMQ
 5ovWDNh8pTiOPgikKnsizQ==
X-Received: by 2002:a05:600c:8b65:b0:483:badb:618e with SMTP id
 5b1f17b1804b1-486f44377dcmr38308265e9.8.1773819247958; 
 Wed, 18 Mar 2026 00:34:07 -0700 (PDT)
Received: from dario-ThinkPad-P14s-Gen-5.homenet.telecomitalia.it
 (host-87-9-97-160.retail.telecomitalia.it. [87.9.97.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f45f7e96sm25615765e9.0.2026.03.18.00.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 00:34:06 -0700 (PDT)
From: Dario Binacchi <dario.binacchi@amarulasolutions.com>
To: linux-kernel@vger.kernel.org
Cc: linux-amarula@amarulasolutions.com,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Michael Walle <mwalle@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH v5 3/4] dt-bindings: ili9806e: add Rocktech RK050HR345-CT106A
 display
Date: Wed, 18 Mar 2026 08:32:52 +0100
Message-ID: <20260318073346.18041-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
References: <20260318073346.18041-1-dario.binacchi@amarulasolutions.com>
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

Document the Rocktech 5" 480x854 panel based on the Ilitek ILI9806E
controller.

This panel uses SPI for control and an RGB interface for display
data, so adjust the binding requirements accordingly.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

---

(no changes since v3)

Changes in v3:
- Add Reviewed-by tag of Rob Herring

Changes in v2:
- Restore vdd-supply as required for both DSI and SPI types
- Dop useless settings in case of rocktech,rk050hr345-ct106a

 .../display/panel/ilitek,ili9806e.yaml        | 38 ++++++++++++++++++-
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
index f80307579485..2080d9e0ffac 100644
--- a/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9806e.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/display/panel/ilitek,ili9806e.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Ilitek ILI9806E based MIPI-DSI panels
+title: Ilitek ILI9806E based panels
 
 maintainers:
   - Michael Walle <mwalle@kernel.org>
@@ -18,6 +18,7 @@ properties:
       - enum:
           - densitron,dmt028vghmcmi-1d
           - ortustech,com35h3p70ulc
+          - rocktech,rk050hr345-ct106a
       - const: ilitek,ili9806e
 
   reg:
@@ -30,11 +31,24 @@ required:
   - compatible
   - reg
   - vdd-supply
-  - vccio-supply
   - reset-gpios
   - backlight
   - port
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - rocktech,rk050hr345-ct106a
+then:
+  $ref: /schemas/spi/spi-peripheral-props.yaml#
+  required:
+    - spi-max-frequency
+else:
+  required:
+    - vccio-supply
+
 unevaluatedProperties: false
 
 examples:
@@ -60,5 +74,25 @@ examples:
             };
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
 
+        panel@0 {
+            compatible = "rocktech,rk050hr345-ct106a", "ilitek,ili9806e";
+            reg = <0>;
+            vdd-supply = <&reg_vdd_panel>;
+            spi-max-frequency = <10000000>;
+            reset-gpios = <&gpiob 6 GPIO_ACTIVE_LOW>;
+            backlight = <&backlight>;
+            port {
+                panel_in_rgb: endpoint {
+                    remote-endpoint = <&ltdc_out_rgb>;
+                };
+            };
+        };
+    };
 ...
-- 
2.43.0

