Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B876CD98D2
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 10:49:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC60B10EE47;
	Thu, 11 Jun 2026 10:49:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CIPE11lN";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43F7E10E500
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:44:58 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-4600cbb06deso35423f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 09:44:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781109897; x=1781714697; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7tuZU5chW129Gn+ZceSGJIAdU7Oe7M+OtmrZzZzJOnc=;
 b=CIPE11lN2+/pG/DiQ/wXyMQjn4x2w4NsARQaBKNq7c5Fhly/lrB8nu8m+Ktwv3ekcF
 G9Je6lm7/6uZ8OLw50MZPB7j4My+vg6V5pWq+34zWzCBW8ItWpxAkTFLdPSw3SAkVLvO
 VQ/RXcFjr8Aqefw/OUj6GqkiM66lU8s7bzhDmrl73bMy3fzLy5fls2eWvmB2WVaniqAj
 5KCL2zY+5+lO0nSnVyFTTgeq9zoSqCmWh8gxPcr8xTQTOZKjpIHl0aDrClmlyE+D5WQJ
 eL3ikj7IBxuEhoF13XTQ+e71CA3bXJ9kz7+/8NCPHc1yCwnVG3bgm3VRVj+25Qb8DFfg
 V/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781109897; x=1781714697;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7tuZU5chW129Gn+ZceSGJIAdU7Oe7M+OtmrZzZzJOnc=;
 b=QMBcczrKXnBWg9rWbkx20pJY2BVE5X05m/2CssbzvANiIxeSz6KkpFc5IAorfSa4Th
 TGEasdXPdyuS1yafsR/ijsu/TCqjbeUH6HJxbkicCuqa6f+HaAM+wsDkw3KOqlb9THA2
 BpVr7ZJ3soMqD/XlsyRC03G4OsMEBNbPr8qScyMrt2dmsZG1BdoqSliR5LJZUAlqwwHA
 XaSZ0dbymuqNv4fX9WW9Ti56Gi6vUuhWxUNZE3gFOAIa/TVTYqEy12JT1aZRebqfq3w2
 sS2RZ1sxydbpmroTIrh5MpN9bgwsJeE4F8WydnD2MLlsgg2FYAT3IVnxWJGEYeTjedwv
 rkWw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y9uxtjVPGm4zHUnJtivA0qQKPgosR7Odu5v8eA1G2XwdukxaCFnaTfhj9EhcWdxTfYvjYQfGrckE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEi5NisJ/9ap9PAYoCUrHgeA1c63PwwI/GbPxPYP3HxLhz9sfN
 I3NzMDN0kb4AM5ZBKcwaKQiizzjFXSRWZXmvFEuga1r+WKih02vYX+RO
X-Gm-Gg: Acq92OFnBaYlP9nWL7IB4sCg/VoPca95lZc63tRMoEMkgEuAoKDjVUBV7ILHmMRSkF1
 lgvTO/xNGk9DNpZ9QezRRyrda9vfAOquML2bl5LVCJ/uwHingzIUPnu1oMtK2jkXfOLJLsAdjOk
 Y/PWGfuelH9ytrP6n+LDBE8S7ZcIvud3WUUF6gSMuvwTHeXa6PRDfP8DM/PTbfLrz0XdJjyc/gd
 PqiA9xRBfjhuU+S5ONX6xEeiHhB7HJGofscjONqCNvvhHbb98p/IKAhtLtgkdZrGyhRqFtaaJUF
 Om2I3k0gdR7t2LglQw5Wn/S606YQNSN5Wmj6I4E4DGtAOWTSWD6Nrobc6w9hezWk/KCmDrEq5La
 6xGi+DQ7UjX4YUoK+rPV0wkCsJFz+nGJ5Hau2iS8SUSweiV81+Z8GqTtCjaCFYgAFnwu9792Z36
 0y7PHWCEBrfW8NpK4/hvJhj1aGOHXNyNMXaevi7TUcVuNkPMTeCgo=
X-Received: by 2002:a05:6000:1785:b0:45e:daa9:f34c with SMTP id
 ffacd0b85a97d-46032dce5d3mr37114605f8f.26.1781109896641; 
 Wed, 10 Jun 2026 09:44:56 -0700 (PDT)
Received: from anthony ([2a06:c701:9cfb:2900:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46028a6dcbdsm61156733f8f.7.2026.06.10.09.44.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:44:55 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch
Cc: javierm@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH 1/2] dt-bindings: display: Add Solomon SSD1351 OLED controller
Date: Wed, 10 Jun 2026 19:44:27 +0300
Message-ID: <20260610164428.180091-2-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610164428.180091-1-amit.barzilai22@gmail.com>
References: <20260610164428.180091-1-amit.barzilai22@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 11 Jun 2026 10:49:05 +0000
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
 .../bindings/display/solomon,ssd1351.yaml     | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

diff --git a/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
new file mode 100644
index 000000000000..a7d77132faa6
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
@@ -0,0 +1,47 @@
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
+  solomon,width:
+    default: 128
+
+  solomon,height:
+    default: 128
+
+  rotation: true
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        oled@0 {
+            compatible = "solomon,ssd1351";
+            reg = <0x0>;
+            reset-gpios = <&gpio2 7>;
+            dc-gpios = <&gpio2 8>;
+            spi-max-frequency = <10000000>;
+        };
+    };
-- 
2.54.0

