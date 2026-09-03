Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C45B4C624DD
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:10:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F069C10F554;
	Thu,  3 Sep 2026 12:10:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gtBKyLFP";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D41F10F554
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 12:10:23 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B61DF26D7;
 Thu,  3 Sep 2026 14:08:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788437330;
 bh=DZTpN/Kyhf4bRkFzUAQGO14hUtawOjNVMmq4AUheIMo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gtBKyLFPHlGCYwkRafUb3up9btSAP4wM6Lt8d1P7qlHZuOKsU7vArxvwgxO3KjzMa
 j0yhXGsugiXuent58IH8kjgd0EyWt+RuO7wqmk9ScRFDE4l3DZi7sfQBP2TTzSBa2u
 6FHqvLXNErKDG/shqBRJk9bB5pn+2D61yDddBt54=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 03 Sep 2026 15:09:53 +0300
Subject: [PATCH 03/10] dt-bindings: display: ti,am625-oldi: Add optional
 power-domain for OLDI
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-tidss-pre-beagley-v1-3-93928baa8b12@ideasonboard.com>
References: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
In-Reply-To: <20260903-tidss-pre-beagley-v1-0-93928baa8b12@ideasonboard.com>
To: Devarsh Thakkar <devarsht@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1009;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=DZTpN/Kyhf4bRkFzUAQGO14hUtawOjNVMmq4AUheIMo=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqmWOnmJTYMj0YgBALTZI/eS9kKNKF/Lk2QJVe4
 THoGDNqDGeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCapljpwAKCRD6PaqMvJYe
 9a/uD/0U0fOvjSmcdjugqX7cCrroNsuwn1IIfFzxQLKkNJ/LezBqxszDHYa/DJVi140JF9AiDtH
 WTC8AKy8SCfFGEtE+iZpIzYyF45Miq0//NjoAabvcj3OQRGBtauXZL+c/JjKotMdk93nDRK9EGB
 EOlbN1v4Lo7b0HP/72SV7yitlJKsQSOSGUZNEMWAXeSOPd+wN+8ln04mNVuRMgwRyBWiKuYKGam
 Fj8EX2MVtPn6y8jjKCrTpD9JxBbYDrv+kTVgfp7hHTcYRZ3ymqoBOUMVeqi1LlU2EOkaG3427qz
 HlpgZb8GBSKI9ryawL/HwisP40Oa8sTKmt9cbpNN0t61qfnWBU6tU6KTLygbXn8RY2DfgexQMw2
 kFdZUMxOMKoBVOaQdbh4wCnS4SJx3vw8MDE8qSNlOxKvPAe0kCA1lpSYWaChhNroyBnUEPxjKrm
 aGdJko0au3au0E5K7ZjFvIBEozpxnKUlA3xIG2NHUAYgVKsqoJpIyUUGeyZ0FxR23SDWp3BT0vo
 OSw+/KrNq9qmI9/GSewHfucs8jp3AAMWFb8r+KBUo6Daw0++kmn3sm1VtBoOxI3Ski8/ZGfWpc8
 seM84NuMNB4DRA8xpnfqq/iVKVX3SSxdcaz3+HrEfKysgPIqTjvY5oGvVkXhAT2t2yOjY0SQhA8
 vS0XMIbjsul8PZw==
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

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

