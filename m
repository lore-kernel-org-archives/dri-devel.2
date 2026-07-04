Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0FCC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B507A10E059;
	Sat,  4 Jul 2026 09:34:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aVfBmDNY";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EC110E03F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:37 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-493c00f74baso8344415e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157676; x=1783762476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lXSXtsaOb98EsKaQXza0t57The+nbXRGOe9BEUF2+xM=;
 b=aVfBmDNYuyjzWB34oa+WCyHgiA+bDKOlHXsdLsAdLyGrisDFe6OnGH4cEYY5WvNuMX
 NS85mHEXoaWHCYRXau5ZB0lSHUuwrG24fWRatdBJjzRdwPu2KU0AJZJ+Xq6HBTZf8/0z
 14UXo9ZIovlNLc2H772bDqAZBrcxgR11xAudmsM2c6n3c3U0FOgc4UO/70eYGAXc/UF0
 iRSF+l/Kjhtk4WoLPpw7Ja9PqHXqcRU8a/Ofe9jgDVgeADZG00OJYRaznp8cuQ9pprqn
 5ELPFRzZbe8p1F+5VSH71UOvFgIGZK1yYtvCEAl+pzgv5ZUIztISMmpHa9Cg+TXSJ2Ih
 aL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157676; x=1783762476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lXSXtsaOb98EsKaQXza0t57The+nbXRGOe9BEUF2+xM=;
 b=cKbLHoCOkVqIIIr/iULDWy1nG39atamcLeyd1G9CLDwS2uUS9odvxaBJo858zEzUIP
 X68sIjuxF+1fRqDSpzbVRLLtO4TgAnjuxiHL7T0/DiFfTM0TcsbgNEgTDyU6297TBZww
 uJSUmkIYR1P7+1BKYfNbO46Q6X6zNS7iecWAOwCwbmvKGJTEpP8BipUkVi4alUIb2Acp
 STZPMkPiwrfEAHptpvSJacq6ZrTkBdJMWq2qDZhcIwNXZTnP5lvHPDVNZj6AbPuMU0XE
 CJTDlj2t29IyyUxxuaYYG34wGKAQgmFeHLFcZjeXfUgzRrqtqY91dcqOSf4fBgDZIOaW
 zQMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/bSEhOPYj/YygkJljS7U351wFowYyP1pM6NiwmAAKKUMbpxTPtBuqxRzSeyfsO9wy1hokN+vYJzoA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuxMuqPBN7dklBtinWBcOfMI0DqVt/AssriRu7W+ucO/5zUOcW
 ygpQJzfROqJXBIs8Fq4w0Fz9v0Mwwh3lPZoo7+zN+BQBgQKbNpguPk62
X-Gm-Gg: AfdE7cmLdnChEVPW6qRIXCuhKpRdEtU7P771Y5MNifIjenoojK3WgH1/cqfvHW6TmSQ
 WOzgvChw/d43jFLpjGgiWwKjeHuiZW+iYnZlhyBTOyi012izp6zbwNa/JC7VcAPhtCOc1JSSHVs
 3rs5DM94Wi1fOyLtOcNw2MW+tsFtrlheHvWZXd2bzRwCUMfCm+HNMgh6HtfQYhuG5jbVLaJtbT+
 s1O9z2peAwviz/1y49DTdhE7MySbJG+ftyfyi51wACUDmnTqgUq2QYoJ6v1LuYlcDmCAnjQJzgI
 D0zqM1pXmQm2+z/N/kbx5srBcEytlC3+wqKKHg0mF29Qb2JoejDUQG5v1u6eyByMOVzAUMQWWUf
 ALiA86dYLpuioj1zmGTlvJK9eOB+PU99AMQ8Wd7ATDYizTgXhveb3RGhnjUUvWXhthEv6LPhEm4
 8hElo+80/rBuNnS2IfmZOB
X-Received: by 2002:a05:600c:d7:b0:492:437a:a653 with SMTP id
 5b1f17b1804b1-493d11f7b3cmr19319105e9.26.1783157675922; 
 Sat, 04 Jul 2026 02:34:35 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:35 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 01/16] dt-bindings: display: bridge: renesas,
 dsi: Document RZ/G3L
Date: Sat,  4 Jul 2026 10:34:11 +0100
Message-ID: <20260704093433.273672-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

The RZ/G3L DSI IP is similar to the RZ/G2L but has different global PHY
timings and also the PLLCLK is ungateble clock. Add the compatible
string "renesas,r9a08g046-mipi-dsi" to handle these difference for the
Renesas RZ/G3L SoC. The power to DSI region is controlled by SYSC block.
Document renesas,sysc-pwrrdy property to handle the power control.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/display/bridge/renesas,dsi.yaml      | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
index c20625b8425e..b114ac3b111a 100644
--- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi.yaml
@@ -28,6 +28,7 @@ properties:
           - const: renesas,r9a09g057-mipi-dsi
 
       - enum:
+          - renesas,r9a08g046-mipi-dsi # RZ/G3L
           - renesas,r9a09g057-mipi-dsi # RZ/V2H(P)
 
   reg:
@@ -108,6 +109,20 @@ properties:
   power-domains:
     maxItems: 1
 
+  renesas,sysc-pwrrdy:
+    description:
+      The system controller PWRRDY indicates to the DSI region, if the power
+      supply is ready. PWRRDY needs to be set during power-on before applying
+      any other settings. It also needs to be set before powering off the DSI.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description:
+              System controller phandle required by DSI driver to set
+              PWRRDY
+          - description: Register offset associated with PWRRDY
+          - description: Register bitmask associated with PWRRDY
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
 
-- 
2.43.0

