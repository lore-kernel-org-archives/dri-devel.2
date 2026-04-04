Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4766E88D7E
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 03:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11ECA10E0DD;
	Sat,  4 Apr 2026 03:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="YxZMy/AU";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E229710E0DD
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 03:43:34 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id C7580113117; Sat,  4 Apr 2026 05:43:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1775274211; h=from:subject:date:message-id:to:cc:mime-version:
 content-transfer-encoding; bh=4hF/UZsnpFDnbqzEFubXStIBtyAjilEUCbOOhDOiXh8=;
 b=YxZMy/AUdnhgzCHYFnyX1go8N7BcNuUY2LtjG2QuG3xWosMyRYYxDlqJxB1lkMi/ajyf0A
 oJ6ZYkLhxe2qjhzzLvHhA1OE8jrn5fK2u5QKYJjwpa6BYnZglyZJOXnHG9cMQFMNaGBu/I
 x8e5j+5hhvUlxqSusWh6+InyiwwoICxgncVr5YYYVqz2C2nsqNE27+M6IuLzBHZPfdY77p
 5Rf+YHNZUmWQtAo4nHaFggA5hwJatotzLPUPwpFdl5ygxQT29K/nLRWGCowQgN84XjgEbG
 QYC9o8PlIwrCJdPnXnfnzfnH0e/4WmFAH36pmyu1k6+mhCfi+BJGRACEKgrGLQ==
From: Marek Vasut <marex@nabladev.com>
To: devicetree@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Liu Ying <victor.liu@nxp.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: display: simple: Move AUO 21.5" FHD to
 dual-link
Date: Sat,  4 Apr 2026 05:42:49 +0200
Message-ID: <20260404034321.341210-1-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

AU Optronics Corporation 21.5" FHD (1920x1080) color TFT LCD panel
is a dual-link LVDS panel. Move it into the correct schema, which is
panel-simple-lvds-dual-ports.yaml.

Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Jessica Zhang <jesszhan0024@gmail.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Liu Ying <victor.liu@nxp.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 .../bindings/display/panel/panel-simple-lvds-dual-ports.yaml    | 2 ++
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
index 548f5ac14500a..2215bc10bd67c 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple-lvds-dual-ports.yaml
@@ -40,6 +40,8 @@ properties:
       - auo,g185han01
         # AU Optronics Corporation 19.0" (1280x1024) TFT LCD panel
       - auo,g190ean01
+        # AU Optronics Corporation 21.5" FHD (1920x1080) color TFT LCD panel
+      - auo,t215hvn01
         # BOE AV123Z7M-N17 12.3" (1920x720) LVDS TFT LCD panel
       - boe,av123z7m-n17
         # Kaohsiung Opto-Electronics Inc. 10.1" WUXGA (1920 x 1200) LVDS TFT LCD panel
diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index 9b8fa03f7cbc4..eec78daf946cc 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -61,8 +61,6 @@ properties:
       - auo,p238han01
         # AU Optronics Corporation 31.5" FHD (1920x1080) TFT LCD panel
       - auo,p320hvn03
-        # AU Optronics Corporation 21.5" FHD (1920x1080) color TFT LCD panel
-      - auo,t215hvn01
         # Shanghai AVIC Optoelectronics 7" 1024x600 color TFT-LCD panel
       - avic,tm070ddh03
         # BOE AV101HDT-a10 10.1" 1280x720 LVDS panel
-- 
2.53.0

