Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32412CD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF1710FB13;
	Fri, 29 May 2026 08:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="CRAxuqhC";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F0F10FB03
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:47:19 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C7861337;
 Fri, 29 May 2026 10:46:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780044418;
 bh=5YxUz6t3BXJWUpNuKRYQwWhOjTfHf/XO0P/Y8t9xq0U=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=CRAxuqhCyy0hKdFEdWOhxWyGdseJ+JNIy4pFSr6DytelAKX+/x99moTNG+I6yh621
 DpsQzUoLF77lIvrh5zBpbAvEDi1ITqEkNT+GnmeDX/Qm1LEPxVW8HG5Y56bDW45YJz
 6CZvoKa92kIC3mPOGROmW1sSafazk5+w9cEwB9kI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 29 May 2026 11:45:33 +0300
Subject: [PATCH v3 03/15] dt-bindings: display: ti,am625-oldi: Add optional
 power-domain for OLDI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260529-beagley-ai-display-v3-3-7fefdc5d1adf@ideasonboard.com>
References: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
In-Reply-To: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=939;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=5YxUz6t3BXJWUpNuKRYQwWhOjTfHf/XO0P/Y8t9xq0U=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqGVKMTj/FUyRipkwsdk72Ss6R7PRhPUsMoVJZ8
 LCgzs65T1uJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCahlSjAAKCRD6PaqMvJYe
 9U+RD/4m6jAQuBSloXMV8SWmCRgUkW3VaAIDeBY4Q/enD7xkwLyiXj/Liiz/uzwa/QXXj+cV0w+
 gqefzcfjvSplemjRn4r7t0Rh+u9FbT1IpskWQDfBy99PSxY8jdw2CDjozXfTQ7Oc6QQg8Du9Nqt
 KKNYRO/oOPg3fqucOFml++5/Ktyc0Pj/em41KQnM+jUp3f7VeKkYskfJa3X2Eu0pZgm40VSAej/
 hZlS+yn91hIibSCNkoS/nisZd7/rg+vYUByDeuTW/NaSwCFqkzEVEqKODt89PxAdhtlPuXsxp9D
 FW64dCvzjMppmcItyB7lozMU8exWu3HCxecHWfB2m5jzjb4BGUPawS4wPGzKu778OLP1lj4F/zI
 T8agNerWcBugPMvZSEgwAavcCuGaX3a7XbAj53H7nCtnRz4Leo6jLuoONZgyDoCjrOA4tvrQiZm
 95xl9kWaSLMgih+UDR2XZmdydxUkTgxDdtYbuHGxCw93VE4wNc4YyCnFeG1qbk8Ll4cIEb2/mkL
 XSrEB1FWwvzUidpM0YFIF2qHgobPb0jzO+KOwhSwJmgy3hUggC7RxdFvruVpYcQoE1WTb5hzi8/
 2NOYB6glu1ZJDdIVcpUycL2PSltIcIVYEh9hvKpmsnVc7fLyIWCx+G7pKZOy6uUfwq15x+t2fwb
 S1xuCzkCae9AGIA==
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

