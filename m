Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31467C5DF8C
	for <dri-devel@archiver.kernel.org>; Sun, 23 Aug 2026 11:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4BE10E4E1;
	Sun, 23 Aug 2026 11:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oswUsN5d";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CAE910E4E1
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 11:20:30 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so451081366b.2
 for <dri-devel@lists.freedesktop.org>; Sun, 23 Aug 2026 04:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787484028; x=1788088828; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JlTQW/BF9URteLWdGLssLkReJV29Ip7yvpMIAoyvb8I=;
 b=oswUsN5dun091zPz/LqPFY5rgbRHqXWqQfUbSSGCTGYrd3C09LDTJCXFueVaYUjrwA
 x8zhB4rL5rEnNq/dkfY+p0DNkMOhZPFM3cGw+/b4VKarSIBLR80nHTvjQsPGCeiRm2Tv
 anhX0IKr6H0EYVa0m6ssZYZWG5VPWoyjPgthXzCuHP3bCiDV/w46JkOSCmqCWoAFz18K
 DJgNh0Gdba87bzOJ9fUzNMkNLiZoCYkC3uqYxFShLtg81MY6/FAeQt8thiPIysrvGdsC
 wvgruwzxpSphsvNTYwgETsbi4P17uMmW+GalLf3hN62dIoU85jjoVI+Wux9nG/gFm+iN
 c2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787484028; x=1788088828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JlTQW/BF9URteLWdGLssLkReJV29Ip7yvpMIAoyvb8I=;
 b=J4Mi4eLM/HqfbWTrAJnslM0sqBqvOqvGAABwq4r4q0M2r4eS/o24qlFNUuIHW7MJXl
 t160H11DgpVxUmLAe0Wf/t3HEMDm0bdg6TxjFHPJ2yj8O2sojkbQiFDDZf3tDvoZ2tH+
 8QSGmx7tf6qpsNMV+kZAuhYhd4cD9UJVYMDxBuWGIa51ctm1EaEzm1JtQGKN9M6Q6sZZ
 fDYlyADunUEgIArWT0YI4FnPQC1SX1AFvfZTrm0lkmOz03ARsiKW1z4Bp7h6W63IVziG
 HmdG637NFC9EiTEKs1IzzGiRtKTmMDcU2jTZYAmCi83sgsjltDbPUKpfipAyBS5ezJLE
 2bIA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqosyK2FE/UQF1eHumWvx9p98E2SZQ/Na4fW7zF5VJ6hjzPPMXFfIM2k9RcVM8eV6rhpcD+hLP+1+M=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lYzW9AAXtXXriVY29+JKkEXLsOWGbBwdcnwuGvPvguetnn+C7J
 QAIhEbHmSCvhmnAmULsxiPVfwfqVKJfFZBQgZdhY2rEAEhVv7Y+We3nM
X-Gm-Gg: AR+sD139/+dFoIwzQtMHx5Rq6z6mYUwt6I8xlk5NlPeSUQLnjzVTOknYApVJvBxFsbI
 vM+KYnERkbkLRnPUuMS9mii9ovuLtsd3rCu1V0tevbdM30dqHPAAEHE5bI0IRFaFzLrq6XvydSw
 7lDsbhr0XpnWxFtIjiCbT0k6ER1U+oIWRz19H1RApgS81iO+J+Xf6Qn6QN2NdwVeq4FORc+ingc
 r/yknh/iE5p8BNpKVqoFB/BuLWR7NNBnUNx6hoko+p7BxU1RRZ0EQ4BFuZeki2JiRJkZSlUmPXG
 KqLlqYLr5o8cZfg4l5skVukOGiX2Bp2wMCXj2RawHWr9DZZqF3ppRZbP6ZgIkltJIkDv9hU+zwQ
 7G1eObkjTDL9de8W2WNEAAU8upFBCgn4Fy1GHVxDlVvqtDM2ITsU3bZG0oSSziHVDP/sAGFoEhW
 cW+vG8vQNAFtPzWnIkZplqzFGuGvlOnIDzww8My51zzYvQEAiSpzC2r3bGWeWBU6ZqMg==
X-Received: by 2002:a17:907:3ea2:b0:c15:f598:60c0 with SMTP id
 a640c23a62f3a-c249238cd84mr1203250766b.4.1787484028294; 
 Sun, 23 Aug 2026 04:20:28 -0700 (PDT)
Received: from thinker ([2a13:54c2:f000:e268:6d0c:d746:2b12:231f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f58dfsm707233866b.38.2026.08.23.04.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 04:20:27 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: andriy.shevchenko@intel.com, holofermes@gmail.com,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Amit Barzilai <amit.barzilai22@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/6] dt-bindings: display: Add Solomon SSD1351 OLED
 controller
Date: Sun, 23 Aug 2026 14:19:54 +0300
Message-ID: <20260823111959.17029-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260823111959.17029-1-amit.barzilai22@gmail.com>
References: <20260823111959.17029-1-amit.barzilai22@gmail.com>
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

