Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59142C4452A
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3E3E10E7B4;
	Mon, 20 Jul 2026 07:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mieulab.com header.i=@mieulab.com header.b="dDvWpZ9C";
	dkim-atps=neutral
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com
 [95.215.58.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D61A10E56F
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 11:25:19 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mieulab.com; s=key1;
 t=1784373476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s0L/CvyUhmFHnr8ZdmxcBtUe6vtszqB/KJYG8quybbM=;
 b=dDvWpZ9C5oZyJar+uUTs4hmEtNIhJMTY6rjb6zyg3K7IDsgqkeaqozlMLWsBBPFAD41QJ8
 FTzb3xhfF7CNK2ktGMMIzOCaP03q/LiLBoAFueIozDdt+l9FYq7s7rJ2xzk4Onhe++PZR1
 5og3NPL+dwVeB3t0HoLgIxrxeDW/a5xsnQnO5OCKu5Z1NKG+2G1A8kbdwKMnpes6k3nFBx
 xENiHUDdkjdSQ9drg6slecE+L+/J13/2hsyhZqoE7pX6WXlq2jhGme9MLlNGlXKHU9qQKF
 6NwkJw/L794RhfQ4NydNsGCtJRNJxc8LQQMUyxI0uuPf7FwteZYApm6kLnbJIQ==
From: Zinan Zhou <zinan@mieulab.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Zinan Zhou <zinan@mieulab.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] dt-bindings: display: meson-dw-hdmi: add GXLX2
 compatible
Date: Sat, 18 Jul 2026 20:15:26 +0900
Message-ID: <20260718111527.119231-2-zinan@mieulab.com>
In-Reply-To: <20260718111527.119231-1-zinan@mieulab.com>
References: <20260718111527.119231-1-zinan@mieulab.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

The GXLX2 HDMI transmitter uses the byte-addressed DesignWare controller
registers and directly mapped TOP window also present on G12A. Its display
pipeline and HDMI PHY programming remain GXL-like, however.

Add a dedicated compatible with no fallback. The generic
meson-gx-dw-hdmi interface uses indirect address/data registers and cannot
operate this hardware, while meson-g12a-dw-hdmi would select incompatible
PHY initialization values.

The one-resource representation is proposed for RFC review; DWC and TOP
occupy one contiguous MMIO range on the tested HG680-LC.

Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Zinan Zhou <zinan@mieulab.com>
---
 .../devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
index 416fe263ac92..4a17eccabea9 100644
--- a/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-hdmi.yaml
@@ -29,8 +29,10 @@ description: |
   The HDMI TOP block only supports HPD sensing.
   The Synopsys HDMI Controller interrupt is routed through the
   TOP Block interrupt.
-  Communication to the TOP Block and the Synopsys HDMI Controller is done
-  via a pair of dedicated addr+read/write registers.
+  Communication with the TOP Block and the Synopsys HDMI Controller uses a pair
+  of dedicated address/data registers on GXBB, GXL and GXM. GXLX2 and G12A
+  instead expose byte-addressed controller registers and a directly mapped TOP
+  window.
   The HDMI PHY is configured by registers in the HHI register block.
 
   Pixel data arrives in "4:4:4" format from the VENC block and the VPU HDMI mux
@@ -54,6 +56,7 @@ properties:
               - amlogic,meson-gxm-dw-hdmi # GXM (S912)
           - const: amlogic,meson-gx-dw-hdmi
       - enum:
+          - amlogic,meson-gxlx2-dw-hdmi # GXLX2 (S905L3)
           - amlogic,meson-g12a-dw-hdmi # G12A (S905X2, S905Y2, S905D2)
 
   reg:
-- 
2.43.0

