Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16058CD98F2
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B25210E759;
	Mon, 22 Jun 2026 15:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="izlzs++H";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A49710E759
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 15:25:22 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4903d730b1fso68207545e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782141920; x=1782746720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z0qw7KTWnyC881EwxaOjThj92Q0RuccaSWAdkHLFKrM=;
 b=izlzs++H4ulHdN454PMUhxBaF9Rj6MdpXvQ52nRn+sb5TCYjLM3lSLgZaHHd0z6l0F
 +g+3dwQSqTT13qt6kG4FA6pv5agHkVaXmUPsDaAdEQQnH0fqwAmQKYRs7RGjk/oYgLXK
 MpkSKCSrd9z6VSBQhP8T3UuzktlHIOYtgUTuFUsxPZM5TNZ5SFOkT/Tdixc+gDtilW93
 gpQoo+Id0B90nbBVNjvKp/B/rzBYoQYFVmzWZnDv9MiKnbkczR8UT/CJhOSaoI417J8m
 yGTJupcBo3WzKznvtytdu+atVdG8egzUX+nDGdG5rAymVO0qg+/3aovWaX9k6eWiO4Xu
 ziOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141920; x=1782746720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z0qw7KTWnyC881EwxaOjThj92Q0RuccaSWAdkHLFKrM=;
 b=Tx+f3T6GwJ7DOEleu1bdt3cH21BG1hH2fj4S/MogmoijUrUCIwrPKlZXLyL9Hn2bWt
 1zww0GV0U6p4nkB92jcZvd6NwT68f94QFQv6lCLEHiFBbxljDUfcmVj7X2fLTA79rRbH
 NeBqDUWlVvxlRv1dZu0akANnmY0jrvXOqJedcSa6bp7da/58JmKnYcMliZ1HKjkrr0zq
 uJvFYWNFXMZD/5FnC/a4AbpCxMyImr93V5L5XXvUu6QmpXMQp5C7CnGnFFRisyNGsC/k
 vhr4cenRhgkOjNmtRbrOULIz/+xY9qOpioeQ7trrUj6oVEBQaY8In2rsUJ9zP9fU+VNs
 ClJg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/ydxHUwTwgFKeRuBu4UoI69HSJPcbWcGWTdBMfAfbaGiIwGE3WoKCvP3YwEiZaQ1pL/AGlrVPrON8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzacRGUX9tjbcGS4r+mKlGcJLIyupqqkSqAP7GaQEhUfkqBUqn+
 UNm+anVJ5LQ/99VLFiD3YI+gAqlgmmbwNbcQxxxIKT6RDsNlIfe2RaP/
X-Gm-Gg: AfdE7cnEZRxxVpKmFsEShhFEMhrH6F08l2fcVQA6QbAQbd9i16lJ5fQW8iM4AaHHF96
 aJOqnjTeBEkrfRN0+DJg8+1geXV7qbXR6nzGjazV8DjcGAL6KZBDlm5PfxYnYV0h5aCp4vMYKvl
 VNwF8jlSzhUcJfA4DAzGaePdgTaaP0x3waIu6eou0t4x381lJ8/VbwnxPFvh1VOtGaCQKQsNhW/
 HrHIdvbWI5uwL4R4+AzZKcpOQ1V9NAe6hv2fcmfMRSUBaLQKjXWzU9fMQiwWpYL17fFECgs7kJR
 hiNv7xDkc3dzk1EhY6H0trMScwGDgqQhvH/cPSWcS8eUxuDJ4NXP0kcgJH2L/6xVfjzeU5jXtDA
 Qci7A3pClpgOpTDatXj6brGqW1EfuNvcw5NKIyr4/bVI75sxLD3giBeMNawYWAFYzPSBoU9JBm0
 T5XUmdC3magg8735qzc6buQSHwap0=
X-Received: by 2002:a05:600c:3b15:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-4923ef47e73mr298830265e9.3.1782141920248; 
 Mon, 22 Jun 2026 08:25:20 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:25:19 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de
Cc: azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 1/4] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Mon, 22 Jun 2026 18:25:03 +0300
Message-ID: <20260622152506.78627-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622152506.78627-1-amit.barzilai22@gmail.com>
References: <20260622152506.78627-1-amit.barzilai22@gmail.com>
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

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Amit Barzilai <amit.barzilai22@gmail.com>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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
2.54.0

