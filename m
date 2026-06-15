Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FEC2CD98E4
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 18:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BAA410EB09;
	Tue, 16 Jun 2026 18:17:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YhD1/zeL";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A181F10E572
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:57:04 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so2079185f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 10:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781546223; x=1782151023; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IObpZGW1nPLNyJWjL4oanYTX/zkpr/Wst7RNFyVlhkE=;
 b=YhD1/zeLpIjhQgkhah3ppzBz0aKtXU+njE5h05qBHBhk7MVJ6CSzDcDdd7jsgh3Hrg
 ZFjJRCrY37nOH/T90wJvPZIxpNg5pOUoiWHjjNAxIz8BtCQu63h1rrBV/nkW+aREGZPZ
 dDti63QvJIIxAY+kVZFsKjbQsYrwQXZnCu33J9dcHbJR/YlASWg3xdihdt80zGTUSvK7
 w2TtVEaH3LmDmT2ySNFjW8QFDrDUZG1jtDOXR1pHsb02w8FF7dbbRlXVorkZm6XRT5eD
 J+rgNdoSiCI5mYD38s18X5t/dtCqg8fKL3cuwIc9uSyzwhDsDwf8nz9ZocbX2PWWRkIU
 IfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781546223; x=1782151023;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IObpZGW1nPLNyJWjL4oanYTX/zkpr/Wst7RNFyVlhkE=;
 b=SnyYcek9QVhWDeu59cDEDVkfD7RfYbupFX8bIxWpod14isGMeusYbvcowpXb01ITKt
 0SrxcJzs1vF0E6WMQhqa4aL0ScF8bh/wtOq2EcMSUvAn1HykO4irmrnbPUwl7jIBRA9j
 KIxvsdmZIMjB36lYSNx8uXqRcOpx3Md5PXC+3fJ4Y2jkN72+Lnqmz9FwFaeHGhBTwfmI
 iy7AiNWgus8VV5N/LwpxSK8ugaYxrYPiuPxRAnyRo40KPHMlJrw0EZNMIQPZgsCtaW8Y
 GHJ/co9zM/O5Neax0ErpBfwd+NBrfHV+Bp2iUPZbGQzsjd1iBcb3mZGWOBcdzbEeXQhi
 hTdw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8tmCFX1Yqnpk70Uihk5iVQAkW2KoW+QyXOyFYsttyLhH9ZSnryBoyPN14/rcaCuT5bG17dmDPLQk0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzdLeOpfHg3j09Kr48W57ezSMsMAnBUqhNPjQny1Or0G8NhH7f
 CTfWJuvfylkNWaqG2X/7kUQW6bcI8aNLvvVPngGM+em9eUS5mq9PJvNX
X-Gm-Gg: Acq92OEKaKClTgUTReEgtwXrhe3wb2LJEKAB5eYjm9zeYUCcex/fQxy0Qev9kJ8aGT3
 l+6We2TzSbzWxhcqQvv5pVJ1hqnYXxJeehIKffCNujwMMD2jQGqw9jUSQFT8Hbc21dwM/763mwW
 My/SIgdc+p8VXdZROIdAK3WZbphtchB5cqvqht5isidKtdjhvVJhEthzNDSBeHpPTvX8vfszwO8
 EwjRvtugyJmktRyXk10VWYtyziLuKPBizEc9g+Sep2y5IIN9cCToEeu2uV3WIn6tkJ9Rfh1rInS
 cQcqeIzJr359T24bAUOnzQnmMs4PwIIi+//idGwKf73SRkaHTUEfu7zAnOmsk78fcebdA59vlm/
 BE7+7I1Kb5hDICdLxNtvNLK048HdopDhpqn0MSwfULvDxDqwTbioMAdCp+NfwOR5dDT1Q5UG+pC
 1DJOkzyKF6g3KbvDlx1aeGzPY436fDqA==
X-Received: by 2002:adf:e001:0:20b0:460:71e6:e3b with SMTP id
 ffacd0b85a97d-4619f3031a6mr650368f8f.27.1781546223003; 
 Mon, 15 Jun 2026 10:57:03 -0700 (PDT)
Received: from anthony ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26393asm38543721f8f.5.2026.06.15.10.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 10:57:02 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 javierm@redhat.com
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, airlied@gmail.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, simona@ffwll.ch,
 tzimmermann@suse.de, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2] dt-bindings: display: Add Solomon SSD1351 OLED controller
Date: Mon, 15 Jun 2026 20:56:20 +0300
Message-ID: <20260615175620.88828-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 16 Jun 2026 18:17:58 +0000
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

Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
RGB OLED display controller driven over a 4-wire SPI bus. The binding
builds on the shared solomon,ssd-common.yaml properties already used by
the other Solomon display controllers.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
---
Changes since v1:
- Drop solomon,width / solomon,height: both are deducible from the
  compatible and are already declared (as optional) by the referenced
  solomon,ssd-common.yaml, so a local override is unnecessary.
- Drop the rotation property: it has no consumer (rotation is being removed from the driver).
- Use dt-bindings/gpio/gpio.h flag defines in the example
  (reset-gpios active-low, dc-gpios active-high).

 .../bindings/display/solomon,ssd1351.yaml     | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
new file mode 100644
index 000000000000..39622d74a41d
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/solomon,ssd1351.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Solomon SSD1351 OLED Display Controller
+
+maintainers:
+  - Amit Barzilai <amit.barzilai22@gmail.com>
+
+allOf:
+  - $ref: solomon,ssd-common.yaml#
+
+properties:
+  compatible:
+    enum:
+      - solomon,ssd1351
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        oled@0 {
+            compatible = "solomon,ssd1351";
+            reg = <0x0>;
+            reset-gpios = <&gpio2 7 GPIO_ACTIVE_LOW>;
+            dc-gpios = <&gpio2 8 GPIO_ACTIVE_HIGH>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.54.0

