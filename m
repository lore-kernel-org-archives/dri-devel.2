Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAC5606A32C
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0GajCzLf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E80A10E1D0;
	Sun, 15 Nov 2026 06:11:41 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4D1E10E200
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 06:11:29 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb5b8ef642so11995735e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 22:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794723088; x=1795327888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HyRQC7LCLt2aLLScf7p5/WBb90iUzNQpHgR+zoYi5DQ=;
 b=0GajCzLfxAAvGLiA2Oy5dPrhzfc33wjV+6FDQxHQ2yqxjKt077A3swUkDU9arCx1hE
 5lyRu9llBICKnIZ0Bvy+oZS8A0vPzGDoUKJRwUDo4DWMn9WJFgckMIyUcMOr/vjiIaf8
 5x+de/8MgKk+Rjrnhdhfni0kx5dxctAZPXvvRT3w7nHBsw05jHLbRJ6tzCfGik6KJye2
 k3vNYRB330YAPzUG5Xl+/IlPJapIdPaxmQFsy/zPqfLbWJF4L1Cm3Tz9RKB1T7lu3wn7
 pmX8AzCZY4xVoeXPJUpY0Hz6SBsKcDwnAcMqniYsN4SC6BE3M9qndz+FRfV3ivjKrnab
 t7sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794723088; x=1795327888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HyRQC7LCLt2aLLScf7p5/WBb90iUzNQpHgR+zoYi5DQ=;
 b=iMXz7YJRaLwps9KjgBQiUtqAUFLKdNI6ka9n1keHK5v2g+v7sfWKR9PCUjD9/i1lnd
 TlNS2MxWTgkgpCX6/J3SrsQqsb5jQ8T9VZ0FMF4p7cEe1yIn8lQ8rbzN5A9yvhy+4eYL
 z7ACsSRBFq+RIVM2COMU6T+wbtdyNNkxt303m+xIN72B1LsIg6ZTFLzWR7Pkepa/GwqT
 zs6Q1hxO5CFSwcuxnDO0oD/GlyTsAMtyGk0ixw42VjlZ11URu6YMlGEtO1HdEeYIa2Xw
 HABo+YkDptlAJ/qa9X+W3eOi6fYM9GP0dvGOOOYEX6uFpPhmotqqDiq2QhPlmLEH0rnz
 joVA==
X-Forwarded-Encrypted: i=1;
 AL+hErE3u7EoD/P/mxEAZH71WmgMTgEognWxHNyhwzzXsbrqxzaF9VfWoCkYpUpJONZ9o8XKsCEiNVLQ38E=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z86zN+eJcaAZO6+6NOckmd1ib07JJXdVRlP25FS44opj3cDQh52
 mmXrysTplm/dwyv84upO2CP+owtEpX0qgA7N/m3dmj9C0Pv+5Fdbq6b5
X-Gm-Gg: AYBFou1lbBOrpr9ahp8E7QaSby44h9qxhsY8xQyx2Yp8fJoEzCRjcoK4vKfrjsP9PqK
 4QcvAfNx0czL2kqfUdLYOxHJJGD5yqcHIDMnNUVjcgGbVzpaVWbw9HWJ+q6k8gXD+dngr+9cfKt
 L1JVwLe+eHAK22rZS00Fb5N+77w91Rqu+demSOJA9TSw60TRmd7Neh1nLQNHicYeBqqpoiF8xh6
 tRzsw1bLo7aq2MnXHY1rD07G2sTki6RG0yhd8ZAJW6t137mW2JGvBAir+yfutwO4K3rWoal07R7
 uLeFdjwIL+c0EQ058k2NecclmiUIAsuoJ33kcz4rIm2s3OK1RiLQ21SpyjGOqLAZ/148Gu4Zgys
 qii9UM91pNMudlMoQJd7BSVxWhGAmY8tGzS9zgQ/ndg8gVVmk3NAbG1havlWUrJWv1PEK9Lwsfq
 QOxlScM1q48ymQ8YHVcZYaiJyxj92T3+LCXZRt0aEyY4cZNpQTBNS77ZwkzpuaENLtjiYo6qcH9
 IGI4TZYWGtKasHLUcrW/EgkMmnpPqIk1/ZDhkhEI72pgH0VivjCWaY9I42/FE2D3OjatfTp/Bl0
 Ibg+5x/NnnYqPAHfU8TsNtdRdjCRsH+MDDUXS9RWUXD6pZaR1Dg7wGta3hJEhTKV1X/orBI4tm3
 93vxCFS2uAd5kPWA6lgeIHOiUQtP/h3TgEgTvYO6jnoPa2EadB+aFf8HaNxC2mnEB+wawdfIE9E
 ZdLuv+5A2O1arIAWSUc6Na9BsPLLjf6I9rmA/1YG+mkIQkpadnQdeeZi3PWyQGLBh44D3seOBPZ
 gVVb5KbS49hpA==
X-Received: by 2002:a05:600c:34d6:b0:4a8:f2ad:a9e5 with SMTP id
 5b1f17b1804b1-4bb559f609cmr135894335e9.3.1794723087765; 
 Sat, 14 Nov 2026 22:11:27 -0800 (PST)
Received: from jernej-laptop ([2a00:ee2:6a02:9300:bb69:6bcf:1b11:e85b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb5ba25b50sm139331075e9.14.2026.11.14.22.11.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 22:11:27 -0800 (PST)
From: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Samuel Holland <samuel@sholland.org>
Cc: mripard@kernel.org, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, bmasney+clk@redhat.com, jbrunet+clk@baylibre.com,
 sboyd@kernel.org, Andre Przywara <andre.przywara@arm.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 5/8] dt-bindings: display: allwinner: Add DE33 planes
Date: Sun, 15 Nov 2026 07:10:59 +0100
Message-ID: <20261115061102.229680-6-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261115061102.229680-1-jernej.skrabec@gmail.com>
References: <20261115061102.229680-1-jernej.skrabec@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Allwinner Display Engine 3.3 contains planes, which are shared resources
between all mixers present in SoC. They can be assigned to specific
mixer by using registers which reside in display clocks MMIO.

Add a binding for them.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
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
2.43.0

