Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E15CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 09:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9375510EC03;
	Mon, 14 Sep 2026 09:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dmpCl+k5";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3497A10EC01
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 09:00:21 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-4834977ae75so901671f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 02:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789376419; x=1789981219; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JkGTDT04pW78/8HwUzjAbakPSC/5O9ox51K5klLa3hc=;
 b=dmpCl+k5JMkLzmykzCgQlKgDvtgf2r+EGPGJYtrbD1NEXAVMnJOqDDLdCc7nRCtMOW
 svogB+zqQWApXIKqsfZYJTqHOgMvw7XTUlNx/MI6lIk2Pr3FZf0KNztWoJP0ZnqE7Agd
 cGrdwwla6dilX5bKcvcdPdzLL7wyvo4q7oCYnvUlOkAgoswP+RQGDZt64OWWBPPqQCDW
 QdHtWUXZpL3evqN1V7hDXdTl0jMgQHZpHibNTnBJA2QPf8TM/TIWBVeQsEUhtVBi1/vU
 UkKX167uSxRX2Je5Ue8NDzb5EdzMYYZ0eeUbFp7vBih97Q7L4M7pcNlWtlj1GgLYeDex
 00qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789376419; x=1789981219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JkGTDT04pW78/8HwUzjAbakPSC/5O9ox51K5klLa3hc=;
 b=Ig+hKwqrAGHQin1EVBp12SsPGHk2HWpz/E6vkwkQIXRcKDbn2BWVPFgWyCCZuhpwR1
 2q0i5qkZzUBkGmtTVF9V18TJAvUxGdqVkLESLmPpxZkUQaRtXfOKke0q/P7Zv/sWOk1K
 1VJl9vKeC4JchMAgWkSGtgiQH16gZqrSfCS4vTf2Acm/NNPDiGu879KwgF7DpWG6k/Eh
 7MBE2Hwl8XqReNi32taPmStgBuTF+G0vL6hnTaRCs8O0o7Kzzd4A6ta5CHeMq/m8tWtJ
 UYNjN9b8y5T+m6qNHyJCnL/n7If8i8g7F4PKdYc9P1rHHNll3zMz2tE6+uPmtnQVJLl/
 gJfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzbwQ8HXgsL5/63wT1+lqjjCvTNs0+VHDPeSSmq8X5NgiH3ZD6TTLoxcyTTbMoehYiqWT5W2yxE3NQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mhi/hLIkdpvqrh3+/5UrFmZ/sj2qpReTonvAl3V+1dVPY1brNu
 OGvqaXCv/tR41AESl45MP/baGSkuRiGAgtF1LimCXgvvCynIunhdufc4
X-Gm-Gg: AYBFou0sM/8PfxJhO3Y3jAhVbyxuZwCrjpNeUoDcgGuZn7331oAKB1J6LkkyGmx1ula
 Qb7IV92SJ65iIzjtzSlBRukrefSoTi/H2EiPacyPfznP2uO9yg1x9hLavi/kWip6BUCwAxR/+y+
 ymGodqB65SsWEaar+OotSkhDYGxBXpTkrlC3LayPObg6Vhj9mR6s7/XdWPyJPLC7fz0EmX3aLGT
 APlmSrokem8h03SdgETCeVEYNClyUxLB4dNSn+5BxV62YLwqce5Rt2l4t71xPuwJqB2ZP2ikxyY
 lHbmSJMenyzycQ4KsQkMWt1JfZn9+MT1SVcXcBGszZoNtnsW/BuX0EBmd9U+CriCaEg8/YQNkVx
 wVrkY54ULgfNE6Sv3akzANYHqNGP57efOn8uiY4aMPTtX8BdtBP+eNg0VgH4r7p8R6xy6LHlBPk
 nFn+BbrwfL10qnNgFQYeB14lh1jkhiFKpLLOvoQgxMTytfqCAhTihF1b1zYLX+YMp/ldJOew==
X-Received: by 2002:a05:6000:491e:b0:485:b1db:5a58 with SMTP id
 ffacd0b85a97d-48702b18bcdmr3736086f8f.14.1789376418642; 
 Mon, 14 Sep 2026 02:00:18 -0700 (PDT)
Received: from anthony.local ([2a06:c701:9cc4:c200:33d8:8ea2:e077:ebe1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb32e7f5sm25245851f8f.9.2026.09.14.02.00.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 02:00:18 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amit.barzilai22@gmail.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Mon, 14 Sep 2026 11:59:26 +0300
Message-ID: <20260914085931.66857-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260914085931.66857-1-amit.barzilai22@gmail.com>
References: <20260914085931.66857-1-amit.barzilai22@gmail.com>
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

Add a device tree binding for the Solomon SSD1351, a 128x128 65k-color
RGB OLED display controller driven over a 4-wire SPI bus. The binding
builds on the shared solomon,ssd-common.yaml properties already used by
the other Solomon display controllers.

Assisted-by: LLM
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/display/solomon,ssd1351.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
new file mode 100644
index 000000000000..80850c2ab5b3
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
@@ -0,0 +1,42 @@
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
+  - Javier Martinez Canillas <javierm@redhat.com>
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
2.55.0

