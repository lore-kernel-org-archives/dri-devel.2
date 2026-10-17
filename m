Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D55606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rJKscpMk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E70E10F2E1;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2811C10E0E1
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:45 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a19cba5c14so8098605e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246123; x=1792850923; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xhG+wnkOUndHgFqi7q5mTZCxcyMx8su188FBsGRE7dU=;
 b=rJKscpMk5d4YjP8uaaFl/KcRG2rMfe7WFVmANFhuS8ix/MVRuwdNlezmM0Y3hFBbdp
 a0EEkr6AxYOpO8RSwVZ2YqQ2V/U9cRbPdYZHcmOp5RRmSMSgrVgzCkHx4Pykq0eWgJ4T
 feSkM1vHsDQcye+6C3KTP1MVkUIbcMoJiz/OclgiRKMVnVgPJaOMoF+0kIQ+Au0myfJ1
 7tb+8BR3hBwA+oV1DPxR/aUXrjfzOraHS1S6IBUiGBTxHJnb4WQSsxtoo1Gq9jKAwtKm
 WGI1OcPK16PCc7mGcyzMM7oDUG44pRYKg2g3uanKy+UV7oWxrSJPDRs3EYE1n5SVI6qG
 R/7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246123; x=1792850923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xhG+wnkOUndHgFqi7q5mTZCxcyMx8su188FBsGRE7dU=;
 b=dUZS02JjpCMV6MZonoyh/hMA4EL+cKtkUyGZY8AuhBMECEHXFhouY1giJVMkui68z1
 JQWUimiOYYEBQkm1x8jAVet4wxx6zSskm584b0xzV4QX/2vUEjLqKguZakeqUmwL1aoX
 ubRxj+yE+gY/euSXeYKpRCvY6MvT5wk0XYixAKNqjC8SdxeAl4q4lYKRTVdqUHVuTFLn
 0V5Y5nkdrC3L187GpsxORgKMuAX/bH0hoeFcC0v3PG3ijMQD7oIU6JNonnWtnzen/YFv
 j/o4NHRseyxtqcpBctLG5zfNiwissP+QBnDRagYA6pPXlLyaiViIcHTc/5qQLCNDCuSP
 hd3A==
X-Forwarded-Encrypted: i=1;
 AKwUvBzS/6JlxsBj15uixT6J91qlQKUzs2SZafT4gNBolwcXjxoHxYPZivnMON2a30O8vwTZTMd8uPGL50A=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLz0UlNZ7nhhEOYf6kBNRU6Kyy2d4IOmOY2GpITeZuyxz5avaHL
 XNX6bgJgADBJycqvaLbAx3ec3hZrHP9ZS5YkcpSsHSX9XGq3dI5TPjIb
X-Gm-Gg: AYBFou1CL3IxyjQnGDFT3gj869zr7QjT4wb195+etx4x9RWtNiJCQbKjVX858j+KMiC
 KuqTfqjFlLznnJ1Bz666yJFH7N+CSQz4qoJ4GBIhacs8wNp0UjiaB0dKdQC2Lu7/GRYDLCXo+iL
 whY1J282j3TrcVfSPnGkeOJvM4aKX+XDXQ8Cx/UT7QFySSKfUB9o6NxrzKz/hvrTAr7VPvLdglG
 3Z0Ahp3x4H9Q9Lp3zzcKcMTmuIMHAB8uM7a7hsebCSX2B7uQNvTf7+BUW4Ox9020OybRo6kVz/j
 mbQMPY3BfazH2UrhHHR0NzVkmQZ+ApjAsGq425MGU/XzzOwcKXEgA8lStx+rxPxg3MKRaX/fDHO
 d+kt7kRBsJTcG44PeyIs20FuFSD6U0FKPkHVJWxbQ013HO1zDLm4UfIyBpZzCvamvttId9M3A8C
 7UERZAxIoFkNEuTwGRGpITTvfmXVnKY68uKcIbrYQMa0xKNNjwQwgs70mdiSRrIdemcW2dlOYsR
 8wVKtIq8yjRVJaaJyt05Tl4FNkav9+P9OYnfO07iGRPF0ikN45BjbynfaNqe3DbCANiiajvAX57
 Mw==
X-Received: by 2002:a05:600c:1913:b0:4a1:ad01:f8dc with SMTP id
 5b1f17b1804b1-4a1d7628d95mr60095115e9.21.1792246123223; 
 Sat, 17 Oct 2026 07:08:43 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:42 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 5/7] dt-bindings: input: touchscreen: edt-ft5x06: Add
 FocalTech FT8722
Date: Sat, 17 Oct 2026 16:07:53 +0200
Message-ID: <20261017140827.290666-6-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The FT8722 is a touch and display driver (TDDI) whose touch controller
is connected over SPI and runs its firmware from RAM. Document its
compatible, allow the SPI peripheral properties and add a
firmware-name property for the firmware to download at power up.

The "-ts" suffix keeps the compatible distinct from the one of the
display side of the same chip, which is a separate DSI device. The
reset GPIO is required, as the firmware can only be downloaded while
the boot ROM is running right after a reset.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 .../input/touchscreen/edt-ft5x06.yaml         | 37 +++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
index 68b2f1601654..51d22ff42675 100644
--- a/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
+++ b/Documentation/devicetree/bindings/input/touchscreen/edt-ft5x06.yaml
@@ -19,6 +19,7 @@ maintainers:
 
 allOf:
   - $ref: touchscreen.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
   - if:
       properties:
         compatible:
@@ -30,6 +31,17 @@ allOf:
       properties:
         offset-x: true
         offset-y: true
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: focaltech,ft8722-ts
+    then:
+      required:
+        - reset-gpios
+    else:
+      properties:
+        firmware-name: false
 
 properties:
   compatible:
@@ -47,6 +59,7 @@ properties:
           - focaltech,ft8201
           - focaltech,ft8716
           - focaltech,ft8719
+          - focaltech,ft8722-ts
       - items:
           - const: focaltech,ft3519
           - const: focaltech,ft3518
@@ -60,6 +73,12 @@ properties:
   reset-gpios:
     maxItems: 1
 
+  firmware-name:
+    maxItems: 1
+    description:
+      Firmware to download at power up, for controllers that run their
+      firmware from RAM, such as the FT8722.
+
   wake-gpios:
     maxItems: 1
 
@@ -134,5 +153,23 @@ examples:
         wake-gpios = <&gpio4 9 GPIO_ACTIVE_HIGH>;
       };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      touchscreen@0 {
+        compatible = "focaltech,ft8722-ts";
+        reg = <0>;
+        spi-max-frequency = <6000000>;
+        interrupt-parent = <&tlmm>;
+        interrupts = <81 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&tlmm 105 GPIO_ACTIVE_LOW>;
+        firmware-name = "qcom/qcm6490/nexphone/ft8722.bin";
+        touchscreen-size-x = <1080>;
+        touchscreen-size-y = <2408>;
+      };
+    };
 
 ...
-- 
2.55.0

