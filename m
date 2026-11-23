Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005F60A383B
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lTr6omkI
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC7B110F19A;
	Mon, 23 Nov 2026 19:38:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B3710EC70
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5656C44623;
 Mon, 23 Nov 2026 19:38:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795462690;
 b=3WON6jWbveOba1sR71S9i+MmHPHiA782rYlFQ372TIxD7NjOuTtKpNKfbCTQBjYX25Rd
 BKfDw9pesFoxhDocMGuxyYphS0EodvRQYKqzMTIGZS2boEOBZdHs7sXebtdz9RSXEyjR6
 JYbESV5FbVoZFALKx8s4nvzkwM1NGGz88RM0lPSZy7Fwqw2bftlrOhFhGR2EAOsJ5/lEV
 7xdPJ3jkoMjv/QGmw8WN6FoJ77pu2l/lPuvHttd+yMZV0WdW5PGCuRy5IzAjqioK94O+I
 L5DCJm/D4UyiHiVLTaP4La99wckwmFTZNlv7fw9YiTAD4ccA+vsdza1t5NomncfKreA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795462690;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 b=wev9q6RTNjXoWCmw2ZfYUoPH7bnhN511BUnV4ZxdkQNYi9iMUSVX4eAsi9kY+fLxM12G
 DBRiO/pTjyRHfkqFz7OY2Z/oFR8B194MO6UFYVSZDlownVcUHHnOCymAwRSGwy614zA41
 uVEIbVb1tsYF71LGTGe1Oyh2iARhYmspWeWz7jCOp8Vrg0drwX8R7GdHpAag3ZaspDUU5
 z17Gf52RsWFFoD5IKkOukPOnQiXPgb4MVfCLtKEXGkIAjdW8TFmWEwnIem0kf4rGu0ZcQ
 B/gnDnkeFzHtUsS84YwwTsunUJ2aSFF3Odl7SGlwrfDAQu9gGosQ0PTB9r5otoOMDvg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 766A21F0089E;
 Mon, 23 Nov 2026 19:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795462690;
 bh=09MIVVUaXPmTOAMRCrsbJMFWfzMJrvosN8N7XD44Bng=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=lTr6omkIeZZzCAyoLNTsOJkt0oPHEV+71NBV2O0Ubt7f7rme8RQWEStUbHn1GhlER
 ZQiK6Ck1uOTFVeXBvMPxK3YEh5eRBOKsAGrmDNFYo6YKtZejWxiaAuHH0HatQ8VsVK
 RkBxySLabDLVMIH67ERJD0F5n6q7otO1L8eL1sD6n6ZOWKVbeKJovKONMMRFE/JDxm
 XdGjNt+BUdGwyxySu719kFb9AYecTxAbjVautwX3QWQ6FK7z8diMZPuWs8ilFKymoK
 8ymAn91xPrVcoyPKaBlNxUN/JRxKmOw+8oiZY240iA25MugnLRNX0JitAeBDDuIzfD
 kMWJtk8mR70Rg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id F40EE4C695;
 Mon, 23 Nov 2026 19:38:00 +0000 (UTC)
From: Ronald Claveau via B4 Relay
 <devnull+linux-kernel-dev.aliel.fr@kernel.org>
Date: Mon, 23 Nov 2026 20:37:35 +0100
Subject: [PATCH v4 03/11] dt-bindings: soc: amlogic: meson-gx-hhi-sysctrl:
 Add hdmi-phy child node
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261123-meson-drm-create-hdmitx-phy-v4-3-3fb94f5534ca@aliel.fr>
References: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
In-Reply-To: <20261123-meson-drm-create-hdmitx-phy-v4-0-3fb94f5534ca@aliel.fr>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Vinod Koul <vkoul@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Ulf Hansson <ulfh@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-phy@lists.infradead.org, dri-devel@lists.freedesktop.org, 
 Ronald Claveau <linux-kernel-dev@aliel.fr>, linux-pm@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1884;
 i=linux-kernel-dev@aliel.fr; h=from:subject:message-id;
 bh=GJIY+ibCECHLmuzGiUiB/LupTZ5nNvm+rMxqh5qXGxg=;
 b=owGbwMvMwCWm1SvKXP3cUInxtFoSQzbLNK6/ITdMEzl4Vtf6yXxZpW4ryJ7ecebS0RO3Ngfr9
 fHu953ZUcrCIMbFICumyNI/1/LEu8tHz3zdo54CM4eVCWQIAxenAEzEsZXhf2mIisZd1Y91C36U
 rHrtx9SY1SPgkK9+NZO7wNxadJ6+AsM/u4OR0Qc3N73hDlLmTDZv+VVXLsgZrXPxoSbblL4vq0v
 ZAA==
X-Developer-Key: i=linux-kernel-dev@aliel.fr; a=openpgp;
 fpr=DFD863F61375BF917F0012173953305EF1D0EC3E
X-Endpoint-Received: by B4 Relay for linux-kernel-dev@aliel.fr/default with
 auth_id=744
X-Original-From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Content-Transfer-Encoding: 7bit
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
Reply-To: linux-kernel-dev@aliel.fr
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ronald Claveau <linux-kernel-dev@aliel.fr>

The HDMI TX PHY found on Amlogic Meson SoCs is a child of the HHI
system controller.

Add an optional "hdmi-phy" child node referencing the
amlogic,meson-hdmi-tx-phy binding, and add it to the example.

The node is forbidden for the other system controller variants.

Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
---
 .../bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
index 285edac4c082..97e47592aff2 100644
--- a/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
+++ b/Documentation/devicetree/bindings/soc/amlogic/amlogic,meson-gx-hhi-sysctrl.yaml
@@ -36,6 +36,9 @@ properties:
   phy:
     type: object
 
+  hdmi-phy:
+    $ref: /schemas/phy/amlogic,meson-hdmi-tx-phy.yaml
+
 allOf:
   - if:
       properties:
@@ -50,6 +53,7 @@ allOf:
 
         pinctrl: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -80,6 +84,7 @@ allOf:
 
         power-controller: false
         phy: false
+        hdmi-phy: false
 
   - if:
       properties:
@@ -104,6 +109,7 @@ allOf:
           oneOf:
             - $ref: /schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml
             - $ref: /schemas/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
+        hdmi-phy: false
 
 required:
   - compatible
@@ -155,6 +161,11 @@ examples:
                 clocks = <&clk_vpu>, <&clk_vapb>;
                 clock-names = "vpu", "vapb";
             };
+
+            hdmi-phy {
+                compatible = "amlogic,meson-g12a-hdmi-tx-phy";
+                #phy-cells = <0>;
+            };
         };
     };
 

-- 
2.56.1


