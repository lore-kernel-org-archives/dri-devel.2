Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F85FCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC6BA10EE71;
	Wed, 13 May 2026 13:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="jEjCxvLj";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4412B10E309
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:00 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EADDA2A4D;
 Wed, 13 May 2026 15:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678270;
 bh=0e6peuqhySdYeaoZMj9jOuIaG6XOd9RtU8xKk3jk8Ec=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=jEjCxvLjF2IlvUx5li+OA0O8KvbkDomipGTBE41CqCFj8x6e+OG/RYu4aZp+h3vTy
 PKHN+G69iAx25KaNa/2l8PWOwX/IpoZQlJM4logzGPhc97wQvjYrUZB5mbXCeMOnVX
 WikDY02ZeEwNgivDUiiBNYJEc5Vtp/1Dd+SknWH4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:25 +0300
Subject: [PATCH v2 03/16] dt-bindings: display: ti,am625-oldi: Add optional
 power-domain for OLDI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-3-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=980;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=0e6peuqhySdYeaoZMj9jOuIaG6XOd9RtU8xKk3jk8Ec=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn9IE6hM/DrxR4zT65+kA4xd2Q3EuCCex3zr
 iy/I+BKDriJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/QAKCRD6PaqMvJYe
 9fDoD/4xxCpHRjAFxnwf2ews0ODjwo3fi2IzPzZ1RafNH+aXavbemDPJZ2SfimzaU8dGStBUsnI
 pb2G6YECcy2FTc210x/zLUPsui2biU5igYQNDqaapeQ/3x8PDJW6dlzjaHGtRgQp/gkxWjXne+n
 UE6nrhuv18XprQviLDy2JYGabQx0thzvdDUt7FapuCTygWordzusHfFPx5zo7zYIw+yO/D9LTny
 dwQFBZj/0H8+MT0Rz17uvD1ZHd3GP3aeUL9Gi3ydJie1ELrcbqkxo/U8tWP/obY6OpuNzTPK8q9
 FVmd5qfH46DMQtEpLzwBOOKDuXtjU6HWKMX1xaXOfw57ZHXILPNHuhRiXvxARyA+FaUaQQH604t
 xrhrQsEoCDi2cSvHR4KBv9s62EtSANABZ2D3IOdWS33m/ZnJhXxT8jp730wBN79+joNK4GopcwJ
 50OUyx/B7XxegM9BDeuRnit2srcqYUcNWLpUbwm0ZglE65IZ/dxb4uLoq53V/eqcNdMVVZSrYp5
 vRv2/djY0NMkbMKBJhaT2cdUiCzYAY98ekylMoUlS5Ew7Eq1H2LdfrTUvGaM9wYh/qj/qyNhpnM
 +2MNxILklDs1LUlLdyr9ZN+GZy8+EmQE6UtRPffkbAaPkrHhl7ENaRxIS6jkxzXTOr/ruZGQ7sU
 38VEqflS3h4wHcg==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

On some SoCs the OLDI blocks belong to the same power-domain as the main
DSS block, but on some more recent SoCs the OLDI blocks have a
controllable power-domain.

Add the power-domain to the DT binding.

Tested-by: Swamil Jain <s-jain1@ti.com>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
index 8203ec5e5bb3..5dbf1f76dd3f 100644
--- a/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
+++ b/Documentation/devicetree/bindings/display/ti/ti,am625-oldi.yaml
@@ -29,6 +29,9 @@ properties:
   clock-names:
     const: serial
 
+  power-domains:
+    maxItems: 1
+
   ti,companion-oldi:
     $ref: /schemas/types.yaml#/definitions/phandle
     description:

-- 
2.43.0

