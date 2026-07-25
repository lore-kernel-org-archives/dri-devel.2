Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC08C54EFC
	for <dri-devel@archiver.kernel.org>; Mon, 27 Jul 2026 07:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D43310E313;
	Mon, 27 Jul 2026 07:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KvQgiiKo";
	dkim-atps=neutral
Received: from mail-pj2-f3.google.com (mail-pj2-f3.google.com [74.125.227.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E08A010F50F
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:17:22 +0000 (UTC)
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2ce7ac92dfcso10191175ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 22:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784956642; x=1785561442; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Fhok3rvowf2V2ZvTr/zIVWuKYiTyiporNQXpy3ArInQ=;
 b=KvQgiiKo8lUlhz/LRO81WGGTmY9t5sFQrAvmoQSBA+/6svmCJo9U2jKCZOI4UYaJUB
 g5ClFlBNtJjf6YPIODcbkcNr8x51+0l78a8k+XQJTdFp5g9Fghtgu3wWEoRzNLUQgq6W
 TqUXLBYtetbM4Cabd9xREgWIXuYTLqbCFXhZYMQVrdPwFiktzu3pcQ8DRggtW2gpPwsU
 7Mu6EwWlB2qzLN+iY7b4aScVAFBVn7mX8XyZZuNxIxBYdpk00Ml8p+xJuFOCqd5pEeeI
 QACBXYYM5HnTIo6yHaslGUG9iCFWCelsl1vT1vu8NbOmr+o6hd63QBJUNfjUfJCVG5Vj
 CMLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784956642; x=1785561442;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fhok3rvowf2V2ZvTr/zIVWuKYiTyiporNQXpy3ArInQ=;
 b=XG5gT4pBfIQ+uvror8RWrd1QD8m+3ov77OExvnvJan1Y2xTVwOHi3P6xjR6vXed4No
 Z0FGtp9EGEBfXtJa9Bm5a/XFO22FlIXx9IGzJdUVrZWT2Hc0zP6bm4zxqX+I7LXddoLn
 Tx15zbkRH9SuHorsbyXrEKN6ZwLGX1HLBRb43WJfKwxDqu1C8rPzVNac7vXzmLOoKzMJ
 jMT3OEVMxFt5ECTYOgmYiJ0be8yAWaiuphDRSJU8Yq2Y6gRiCTKFuV2LYrAAtdgDPEgU
 kr14dRouOVBbi8vnAczRhqTYDv3mpBbt5kt8YAy8TNuFq9MPFugmj9yf6j4FOEXVkZGd
 QRxA==
X-Gm-Message-State: AOJu0Yz7WQ6X8BUOpAyh2pc+L9NZaWN1rXHtWjLBbhO/9g21cy9GBuc8
 AVhgNOa+b+rcemTwFadu5ygbsTKn36j/LEiznfVScW7uJhve8Y528fZdwLHz/Km1ZRojmA==
X-Gm-Gg: AR+sD13Vm7xaazJ7/NE8ZLOsWdSrg4EFh0yljspSczo8KAA+/ZlM5XGt/VimG0tudRQ
 ExxdLqXU8DiBzSJ/l//t7U8YLRj0Uwi7hLHTxw3TuMVO7jfxitI08Jt5g8Wa2d8iV9bneBNnyC6
 P0+Gpd2yYRM2WV760ZKKh/rsulEenkCN4epg3On2kQzlAO+1AzBNaRKrKvd/vHP9fFziV1+i4Zw
 Aanv+uRtXy/rF1sTQB2RgRtjpFjE6wdUVfnPZ8OcCMD15TClCEzaVF8vb86qmWe9kWL9Y7KVLA4
 ckfphEauVk6qM2XXfDOZ1pckuOV66/KFJIwxiJGlOGtzbd+IcRIgm52qRAbOkawufwR/T7Xo7EC
 ndVH3Vxm41NYXIT8JrcYMBbfJmy9VR5RWCqkMquTqBbU0I8gLXG9yM+8=
X-Received: by 2002:aa7:8885:0:b0:84e:2bb:2d3e with SMTP id
 d2e1a72fcca58-84e594330edmr623584b3a.9.1784949446508; 
 Fri, 24 Jul 2026 20:17:26 -0700 (PDT)
Received: from [127.0.1.1] ([2a12:a305:4::403c])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84e53432834sm640542b3a.50.2026.07.24.20.17.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 20:17:26 -0700 (PDT)
From: Cody Kang <codykang.hk@gmail.com>
Date: Fri, 24 Jul 2026 23:16:34 -0400
Subject: [PATCH 02/17] dt-bindings: phy: add SpacemiT K3 Innosilicon DP PHY
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-k3-display-v1-2-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
In-Reply-To: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Yixun Lan <dlan@kernel.org>, 
 Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Haylen Chu <heylenay@4d2.org>, Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: dri-devel@lists.freedesktop.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, spacemit@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-clk@vger.kernel.org, Cody Kang <codykang.hk@gmail.com>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Mon, 27 Jul 2026 07:16:35 +0000
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

The SpacemiT K3 DisplayPort controller drives its four transmit lanes
through an integrated Innosilicon DP PHY, one PHY per controller. Add a
binding so the controller can reference its transmit PHY and the pixel
clock the PHY's PLL sources.

The PHY's registers are interleaved with its parent controller's inside
one MMIO window, so it owns neither a reg nor a reset and is modelled as
a child of the controller.

It exposes its PLL-generated pixel clock through #clock-cells, so the
APMU pixel-clock mux can select it as a parent through the clock
framework.

Signed-off-by: Cody Kang <codykang.hk@gmail.com>
---
 .../bindings/phy/spacemit,k3-inno-dp-phy.yaml      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/spacemit,k3-inno-dp-phy.yaml b/Documentation/devicetree/bindings/phy/spacemit,k3-inno-dp-phy.yaml
new file mode 100644
index 000000000000..f8f1ef372951
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/spacemit,k3-inno-dp-phy.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/spacemit,k3-inno-dp-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SpacemiT K3 Innosilicon DisplayPort PHY
+
+maintainers:
+  - Cody Kang <codykang.hk@gmail.com>
+
+description:
+  Innosilicon four-lane DisplayPort transmit PHY integrated in the SpacemiT
+  K3 SoC, one per DisplayPort controller. Its registers are interleaved with
+  the controller's own inside a single register window, so it is described as
+  a child of the controller and owns neither a reg nor a reset.
+
+  The PHY provides the pixel clock its PLL generates, which the APMU
+  pixel-clock mux takes as one of its inputs.
+
+properties:
+  compatible:
+    const: spacemit,k3-inno-dp-phy
+
+  "#phy-cells":
+    const: 0
+
+  "#clock-cells":
+    const: 0
+
+  clock-output-names:
+    maxItems: 1
+
+required:
+  - compatible
+  - "#phy-cells"
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy {
+        compatible = "spacemit,k3-inno-dp-phy";
+        #phy-cells = <0>;
+        #clock-cells = <0>;
+        clock-output-names = "edp0_pll_pxclk";
+    };

-- 
2.43.0

