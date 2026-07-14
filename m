Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F97C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:13:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED48510ECB4;
	Tue, 14 Jul 2026 10:13:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KNZb95Cr";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC4910ECAF
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 10:13:07 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso16101535e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784023985; x=1784628785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NryLnlPMH6Hf3JNrq31VbojgpBro7QXUxTalZR3pyS4=;
 b=KNZb95CrSuQIN7kIyEAOFFr0Hosbvx9BL2o/Wc4A4RjUzcwU71TojqQd23VkZE23N4
 tmR8kiX1c9YP861xRuzFHFBTTwuBjhWzaiYzieCgAOYXNlp195fVOE4bfwRFbV3LTx8e
 eSkG/aXwuByjzkxD7llJgIMGJcVnIoHm+lCGO02trFgAABR2NxZv/fNFRgFvP9VY2n30
 ix7gp7Y4H6FF5pJg7MOFForhK26gtQFQQzS1Jb1JmKCIpnazIMIATmyxRBONivs/Or1s
 yBNx2KOYg6wqopBCW5D2p9/lf11Teewvdn9e05joSCTAQeir/9rX7SZfRPbsfZAzROvp
 dCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023985; x=1784628785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NryLnlPMH6Hf3JNrq31VbojgpBro7QXUxTalZR3pyS4=;
 b=MwH7CK5fadUr96u8Pv7TGfi8lt+ds0g5J8rgyzs4p28TAPNqbUPMD1Ei+Qd4F/sKGh
 r0ig+9h4dAH65xiQFh4YkX7x4dsggJL/1RuQ1elCp5CxpTSvkLrnd3yslw6terZa9PwZ
 yalCwdexrjOm7ML5GVpjx8jkcskQK36SS+2MS6CdJf/1ET3h+bU2vec1WiarlPk/xkHr
 1BpTMscWCnb94Z5cmo2b2ZEHcH3lQu0BLl4QDX7rzczy52npvqCFkcwUBpv5+pZQPke+
 7Xl8KHYe5PoEv6CWZfKyq6gfYxkqas9IhwFfnSS+nxOnKnMriffcWEdQ+tLC/oNoTwIT
 bx3w==
X-Gm-Message-State: AOJu0YzMS+lh3axvk8RNVRNsPI7mjgND0UQMm1Yf1Elip/8fPNEWLwN+
 +F1tHnuO5oyDEETxagU48MMboUR8kz68Ru3XurmZUnEvvIPDBwNdTvdcGwRqAzO7lOs=
X-Gm-Gg: AfdE7ckAADDUxAdG/9op9TsGynW+RVnCKCJ3Mghm5Z5MAiYnSyOPx4uGR2Fpf7PsLgB
 Ndjpu+4u/+ztvYnEhDsrZmNZm04lZPoHuZ2iIgqEVY0LtnyZExWJj2J9THSCNVgWUv+ud0CYYNm
 sVnheV8LaLQ4w6ih9hQFQydNsMshwt35R0CliIxiCSdODEMHUX7UflrnjaGhtb3DSnoCnt9Psvd
 p5wMI+tPNbUt/JCYi8H4Yd1tLeN0rhd4KCAlimQJoDXkOJSJtXtZ2jxKyB/BdEijqyl8Ubv04e9
 T0AbDH1gvhXPWdg/nj447z1sxedRpRqWAQIQULhBfjQVd5rZkMpSjW/4qgTNJCJ9WzfvFBB1psn
 vnIOGsLMUXwT3O+p0Dbj5iPl449VD7hP3ZIuBBVHHtfTlOeP+TQWkqqNGfkjjUFp7VcQLyXaXDr
 +zprdMpfrQBZVbRRCIIiaGk3RGZ1BzCtvjS9g+00V4wAyJl6RJZvU4gCuxjVCCFr8ig9Vf2twFT
 h0U7vbIpPZgQipZEush6m/1QAqSh9Q3FvRcmz9i0Ob1qV+fch5MfDg=
X-Received: by 2002:a05:600c:6303:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-495158c6a1bmr32455935e9.8.1784023985260; 
 Tue, 14 Jul 2026 03:13:05 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464a9879sm7788927f8f.22.2026.07.14.03.13.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 03:13:04 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [RFC PATCH 1/3] dt-bindings: display: Add GlandaGPU binding
Date: Tue, 14 Jul 2026 12:11:43 +0200
Message-ID: <20260714101146.200416-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260714101146.200416-1-kieweg.leander@gmail.com>
References: <20260714101146.200416-1-kieweg.leander@gmail.com>
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

Add Device Tree binding documentation for GlandaGPU, a custom
FPGA-based 2D display controller.

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 .../bindings/display/glanda,gpu.yaml          | 49 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/glanda,gpu.yaml

diff --git a/Documentation/devicetree/bindings/display/glanda,gpu.yaml b/Documentation/devicetree/bindings/display/glanda,gpu.yaml
new file mode 100644
index 000000000..40304e773
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/glanda,gpu.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/glanda,gpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GlandaGPU 2D Hardware Accelerated Display Controller
+
+maintainers:
+  - Leander Kieweg <kieweg.leander@gmail.com>
+
+description: |
+  GlandaGPU is a custom FPGA soft-IP core providing a simple
+  2D hardware-accelerated drawing engine (clear/rect/line) with a
+  VGA-compatible display output. The register window covers a
+  combined VRAM + MMIO region, with MMIO registers at a fixed
+  offset within it.
+
+properties:
+  compatible:
+    const: glanda,gpu-1.0
+
+  reg:
+    maxItems: 1
+    description:
+      Combined VRAM + MMIO register window (VRAM at offset 0,
+      MMIO registers at offset 0x00200000 within this range).
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: Bus and pixel clock provided to the FPGA IP.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    gpu@c0000000 {
+        compatible = "glanda,gpu-1.0";
+        reg = <0xc0000000 0x1000000>;
+        interrupts = <0 43 4>;
+        clocks = <&osc1>;
+    };
\ No newline at end of file
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b1af9deac..b8b7a5401 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -666,6 +666,8 @@ patternProperties:
     description: Giantplus Technology Co., Ltd.
   "^gira,.*":
     description: Gira Giersiepen GmbH & Co. KG
+  "^glanda,.*":
+    description: GlandaGPU
   "^glinet,.*":
     description: GL Intelligence, Inc.
   "^globalscale,.*":
-- 
2.43.0

