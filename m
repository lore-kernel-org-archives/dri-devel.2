Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E24DCD3447
	for <dri-devel@archiver.kernel.org>; Sat,  9 May 2026 19:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2272110E3E8;
	Sat,  9 May 2026 19:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YPQjWKUp";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE2E310E3E8
 for <dri-devel@lists.freedesktop.org>; Sat,  9 May 2026 19:00:28 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d77f6092eso1860809f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 09 May 2026 12:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778353227; x=1778958027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zfXcef4xsSF9aS7bEgNrFEzEGtCwPTxISiBE2oLRk0A=;
 b=YPQjWKUp/irvlVmLrVyNL1ooyq4bbCfWshof32CsKHSAtGeEjTrw74k4U2dKEQdguQ
 MMMeB7xkCgQcyxGti/5208poUdLRczAX3yj4INF/TRChQ2MhC8XIIvgYWuJfMExGKxpg
 HI4+PckLKKtY+LucuBpKwfxfGkfWJaGae+HpfcappqefraFvf+4wO56NhfYTMhv6TWnz
 YDVCpLMorkEWJdI0dVXipNPmrI32DEaldarj8ym0edSDHBe9m5swPqOzMTuxRmBYCwz9
 x4FhU+pCv2jQqXB7wCkHR+NsC1s9zP1BMzSaXEXG6+HDBEJyuzUiULwM0drr6gPQ3Kb1
 6btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778353227; x=1778958027;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zfXcef4xsSF9aS7bEgNrFEzEGtCwPTxISiBE2oLRk0A=;
 b=hCL9W4T+7918iHfz4OWpsOeLfdMmqMRY5tKC6ZJ/J2iUVbG8hQ2lyZ9IXF4RGgBlDQ
 Be+PW5PaD1L+aj0K27h2/30TTjZrjH8Esa6eKhvCfy9a1kdishvJweOqVV8gI/sRR39o
 6qP6vPK87Mkaw/OlUkDnGlMQ3RlCrBQnp8epkh4BFTZ3B1Fi3RfhLwc6biY/Dkrrdw1r
 6uKIyq4Ef0fW+/KY7tceXZOg+hjRdSxDJCsRmE0bxAXWm1MhL+Xf+pRFgz0Z5sK6h7rt
 3sEuAihfGXtKT+xjlOt+7+vwOFgmUguIrecvBLLNEsiGyb+rLIBvku9o0vKnNGCtoL8O
 K9bw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+IR5+NLDZJt1+ivfu6iEUmPlAs9AKi0S3k2bXyyz+Zh0D16QzhyDxWeoJiujRUplT36hyDazdq23o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywN9VYLaUYR3jxyl+NhYu5Md45imGiXILp8QNMYZBnluG3PLTv
 mdlsFx23cLP5G8YlYU1z4uuutfwPMS4/gYe+TJ9HXBIpvcJnCnxiBSJi
X-Gm-Gg: Acq92OGTTxf1edbbJAFKeOrGmtr3kem/FolU05O3TQwoAuoSxrxSyE+okxKadUqLYi+
 2GFOleAAHpQmPUhYtKqrM7AgJpEVbvKyP5K6g9d6ga5dnpznTSVlDPhPc77nNl/tNXO575pWjPL
 B6jwxPTt7UDDxpcvYRJev1Oa9HIGzbtg2MQSdzxOmnREVxMXSZLA6rLy5rweMYRDMW96sLlH1en
 a0CYW7JGH7nNT11IJo/xAFqSil3A0igCHcdyMfkEb8tTcgG6JKauSzSXj6E3U8NG6GVnJYpb5zT
 0UNpFy+apv5EdJQpmBuQJwniNg94hY+Wcw1G2VeLmJuotunNnk2DDI4BMd29K91ZlbwAlxIUxOZ
 YvHReXWX91sZi0S3CUJjk0QtHg+s/Jh+bvJCwS/NAUezgC7ciGkNyjtqfhbXSCTcwLwhG6qPc5r
 RXhTEHNaje0FR0Rk4ZHDkTv9lDbx+bGpH7mX02vzp5sTpaXinOyMULAiKIot7+hq2BSWhQj9aLO
 8K+FA==
X-Received: by 2002:a05:6000:2dc6:b0:439:c661:3245 with SMTP id
 ffacd0b85a97d-4515cc31e43mr28677269f8f.34.1778353227339; 
 Sat, 09 May 2026 12:00:27 -0700 (PDT)
Received: from jernej-laptop (46-150-62-216.dynamic.telemach.net.
 [46.150.62.216]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454913049ecsm13254407f8f.19.2026.05.09.12.00.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 May 2026 12:00:27 -0700 (PDT)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
X-Google-Original-From: Jernej Skrabec <jernej.skrabec@siol.net>
To: wens@csie.org,
	samuel@sholland.org
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 jernej.skrabec@gmail.com
Subject: [PATCH v2 5/8] dt-bindings: display: allwinner: Add DE33 planes
Date: Sat,  9 May 2026 21:00:12 +0200
Message-ID: <20260509190015.79086-6-jernej.skrabec@siol.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509190015.79086-1-jernej.skrabec@siol.net>
References: <20260509190015.79086-1-jernej.skrabec@siol.net>
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

From: Jernej Skrabec <jernej.skrabec@gmail.com>

Allwinner Display Engine 3.3 contains planes, which are shared resources
between all mixers present in SoC. They can be assigned to specific
mixer by using registers which reside in display clocks MMIO.

Add a binding for them.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
Changes from v1:
- dropped | for description
- better description for allwinner,plane-mapping

 .../allwinner,sun50i-h616-de33-planes.yaml    | 46 +++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml

diff --git a/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml b/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
new file mode 100644
index 000000000000..0a07cb8a5f79
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/allwinner,sun50i-h616-de33-planes.yaml
@@ -0,0 +1,46 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/allwinner,sun50i-h616-de33-planes.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Allwinner H616 Display Engine 3.3 planes
+
+maintainers:
+  - Jernej Skrabec <jernej.skrabec@gmail.com>
+
+description:
+  Display Engine 3.3 planes are independent of mixers, contrary to
+  previous generations of Display Engine. Planes can be assigned to
+  mixers independently and even dynamically during runtime.
+
+properties:
+  compatible:
+    enum:
+      - allwinner,sun50i-h616-de33-planes
+
+  reg:
+    maxItems: 1
+
+  allwinner,plane-mapping:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle of the device responsible for assigning (mapping) planes
+      between mixers.
+
+required:
+  - compatible
+  - reg
+  - allwinner,plane-mapping
+
+additionalProperties: false
+
+examples:
+  - |
+    planes: planes@100000 {
+        compatible = "allwinner,sun50i-h616-de33-planes";
+        reg = <0x100000 0x180000>;
+        allwinner,plane-mapping = <&display_clocks>;
+    };
+
+...
-- 
2.54.0

