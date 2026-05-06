Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E178CD3424
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 06:25:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D05510E1F8;
	Wed,  6 May 2026 06:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sIeZOJ4C";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FCAB10E1F8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 06:25:52 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c6dd5b01e14so2103293a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 23:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778048752; x=1778653552; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=FzcBT6AuCoQj4AfTL/xvE8aMkT5NRGY46LoscvrSBko=;
 b=sIeZOJ4Cq1QtEzLrlJKTI5rtJHWD2/z7udXQVX88VlyWIGpwC7aaUIVpzG2VYa6/6w
 3lLc20XfQNFtkKMQcT3JOk09yMZX1uan99zMhgyflf5CNwYAjx+DY2bi+nmFy8hZkXvS
 +Z4ExK9PBvBjvM3GWiZRqUOWqzDJEjsioSg/MukKO9bqinB8nNtGiDTG/YmUdFgjYQCI
 WvFpEpOuxKDT1wgRjRH1GGojfskRMBlvN840k/MpfmW/ygoo99DKdNnzIECMky6SqWqb
 604zYwjWboNUGtMxrtKgqLOoebnKJu38FqV+jaXAWAiFwrE317/+IINSFuBE/T+7N4KB
 xXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778048752; x=1778653552;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FzcBT6AuCoQj4AfTL/xvE8aMkT5NRGY46LoscvrSBko=;
 b=iJd7q73nB1jfjuHlKSd2IzcJiAMQiS2k65KUXktFUAf80sYLUs3HK/wy2r0HD2q59S
 PUQJcY89w/ZmIqaH5qTjQIS9Ie4+4QI7+5APEq8hmoiKmBfMgOC6gOFI42NgyzJE5EVP
 JZsRN60uA7cL8+i87Aj9tzHScHbgk482sAkdSyDoGHNKh3Lv+hwoPdH5YcvtssGcuOa8
 3rcQRYmr0BpvL+ohTtSvk+G/t4ikZuzcef5caeYbw00urLhskiFW+/wQSB5Ob2AB70V8
 LIenx/L0EGAphElRBLpVvNSeYlGFTmlCKJmKz+6M4TQOU7Hi4+bAtdQvbXACW832PF1l
 vieg==
X-Gm-Message-State: AOJu0YzfBRXG5t1BIRfMQKBDFzDOy99ZwE5M2Q/mTJpLKgd5fq2e/72X
 n4O2UXU21zMBLz/6elqdkZAyQCmH9obpT2vYzcjmhI2sA8/1wj5rhJuc
X-Gm-Gg: AeBDiesZcwL6wyaCIxMN9iiyn/4JZgR0gJdw5f3jGZsjxiGPgKLLrLGo0ZNYCj92jrt
 Ofk6l7lTdtIHvEIRf+MP1usQjrEG5GNw+a5mKWbDmg+OdVdC/TRAPyC3KLGqVmW7VigC9Gzhdr4
 Run5O3d0fNY3KcsEzRYTczFp5ZAoUjzZqfxZJ6pJwsqqZtTY7f+ryMX1WDA6EI0Sfh+GWVClhUY
 2bK4ZH+gODW75vtThDAqotzp3gLappYQXXNounKKiqzcTzCtTM2P7qBIGDploB9W0Wn/gXZTRTx
 4Q4fhERaikOKtP0G1Wk8UrfGNv5JLN9kLsutTmj6sTIM7V6p4ZrPMUxDG6KFON989jOJbxTycax
 O+PXC64//gWMNmFGepGd7dyMBpZZt8n4Zem02w71CSLDRyC0WTp1TBx7Q5AuecWWPf0gx2wDHdj
 w4RhRn0vxBCBR14dd3VzFcokkN07UJSbY3KpzQN8Rd9of3A+nHC+ZGetlzNo26+giWEzPu4NWsc
 OYc801uihmSfs9vznAyzQ==
X-Received: by 2002:a17:902:ef11:b0:2ba:60a:3108 with SMTP id
 d9443c01a7336-2ba79bfcbe3mr18857875ad.34.1778048751750; 
 Tue, 05 May 2026 23:25:51 -0700 (PDT)
Received: from [127.0.1.1] (211-23-39-77.hinet-ip.hinet.net. [211.23.39.77])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7bd2ab2esm16330865ad.4.2026.05.05.23.25.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 23:25:51 -0700 (PDT)
From: LiangCheng Wang <zaq14760@gmail.com>
Date: Wed, 06 May 2026 14:25:37 +0800
Subject: [PATCH 1/2] dt-bindings: display: mayqueen,pixpaper: add pixpaper-426m
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260506-bar-v1-1-12195406f4ef@gmail.com>
References: <20260506-bar-v1-0-12195406f4ef@gmail.com>
In-Reply-To: <20260506-bar-v1-0-12195406f4ef@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Wig Cheng <onlywig@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, LiangCheng Wang <zaq14760@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778048746; l=2408;
 i=zaq14760@gmail.com; h=from:subject:message-id;
 bh=Od/U653CYr2uV9LuMXpvcbgLnqmkdoHQYdxApWWdjZI=;
 b=2Qc4tvZiVcWV5lqAfHk54NzvvVQ3T+uZL7e+d1WtUUUKEKKVI3LCqKOoMzvTvk9NeO/rj6nqO
 GlAsPn0m1RSAX4zo0ZoPEGlq9nDjsjU3OCUwiytCaT3ANzFipmn8Chc
X-Developer-Key: i=zaq14760@gmail.com; a=ed25519;
 pk=5IaLhzvMqasgGPT47dsa8HEpfb0/Dv2BZC0TzSLj6E0=
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

Add the compatible string for the PIXPAPER 4.26 monochrome
e-ink panel to the Mayqueen Pixpaper binding.

The new panel uses the same SPI and GPIO control interface as
the existing Pixpaper panel, so extend the existing binding
instead of adding a separate schema. Document the new compatible
string and add an example node for pixpaper-426m.

Signed-off-by: LiangCheng Wang <zaq14760@gmail.com>
---
 .../bindings/display/mayqueen,pixpaper.yaml        | 25 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
index cd27f8ba5ae1d94660818525b5fa71db98c8acb7..4b0db2b079ebea244eb149a52ee1d8dbab0f60bb 100644
--- a/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
+++ b/Documentation/devicetree/bindings/display/mayqueen,pixpaper.yaml
@@ -4,22 +4,23 @@
 $id: http://devicetree.org/schemas/display/mayqueen,pixpaper.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Mayqueen Pixpaper e-ink display panel
+title: Mayqueen Pixpaper e-ink display panels
 
 maintainers:
   - LiangCheng Wang <zaq14760@gmail.com>
 
 description:
-  The Pixpaper is an e-ink display panel controlled via an SPI interface.
-  The panel has a resolution of 122x250 pixels and requires GPIO pins for
-  reset, busy, and data/command control.
+  Mayqueen Pixpaper e-ink display panels are controlled via an SPI interface
+  and require GPIO pins for reset, busy, and data/command control.
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
 
 properties:
   compatible:
-    const: mayqueen,pixpaper
+    enum:
+      - mayqueen,pixpaper
+      - mayqueen,pixpaper-426m
 
   reg:
     maxItems: 1
@@ -61,3 +62,17 @@ examples:
             dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        display@0 {
+            compatible = "mayqueen,pixpaper-426m";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+            reset-gpios = <&gpio1 17 GPIO_ACTIVE_HIGH>;
+            busy-gpios = <&gpio1 18 GPIO_ACTIVE_HIGH>;
+            dc-gpios = <&gpio1 19 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1

