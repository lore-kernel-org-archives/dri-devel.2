Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECEC6EA71A1
	for <dri-devel@archiver.kernel.org>; Sun, 19 Apr 2026 19:37:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5780510E125;
	Sun, 19 Apr 2026 19:37:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="rBHIQCt1";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="l8x4Xy+l";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5307C10E125
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Apr 2026 19:37:56 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fzJmy5YFtz9tYm;
 Sun, 19 Apr 2026 21:37:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776627474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kerIpWs4ed0z7OiQKw7XLC1mV5Et0TeBc5iTrzRy2w=;
 b=rBHIQCt1CT508WBrV9/B/LA88ArwCh/J2l9DpZP2lZPqFAZ7D0HV7bx+85/uSL6OqfNlSf
 jVZAz6JdgjDQs/pYN2Kp67gK2EiK7ZPXHCCGLaCKmZP8P6tNJYVllQkTm2uidz4gzXM107
 DyTYpLdhjvP7K/ovEYeUEmow2Q193RRy9As0eVDTLiWxxCAG0rxQSqe2BQmt/w/lo4jauw
 gdohFhgyfPWq7D7uEiWEp8lS5aCRTPgAgrmO5TQFSB8RsE8XNp0ScZq6hRpmJMqaUDPjbc
 L5RzifLeG3sA97wX0k6V+XjDpLOjGhS0GDOVbtebj84A87qeE2xianhqAUZo0Q==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1776627472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5kerIpWs4ed0z7OiQKw7XLC1mV5Et0TeBc5iTrzRy2w=;
 b=l8x4Xy+lj/mdLG8jFFgtzqnJpKwQDQOsC3UTD27udtR4N0oZUMZMixypXHp9cmLWB72FSM
 HfPNRhE2Y5VtuaRgF+Zu4rI3quaI03Hd8BkkaRZ0imlL8RUY+Or3nby+TkoRnGFWHvWOFm
 FV8MOEspdlzyTVMBX4+S2f2fG5461wGkcYcGFB+vF6cTb07ZoIEypX9MPSksIf07FiJ68x
 nie9w99SwFBp+szO+CPi8a58GWv++UeBP/qprt7njBkStJa/zVqxCAtpjmBogrAVn0XK3e
 1y/OPEZjDWJhxWvhhah1Y0rPIvf+t9UIjSKOFrZFH6z7S/2kYhy1Vyof006Mhg==
To: linux-arm-kernel@lists.infradead.org
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Stephen Boyd <sboyd@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 3/7] dt-bindings: clock: cs2000-cp: document CS2500
Date: Sun, 19 Apr 2026 21:35:34 +0200
Message-ID: <20260419193718.133174-4-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
References: <20260419193718.133174-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 36e649b870f355af3cf
X-MBO-RS-META: zuy53sxh3x97kehzz717wbpq8pnhyido
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

Document backward compatibility support for CS2500 chip, which
is a drop-in replacement for CS2000 chip.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: David Airlie <airlied@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Rob Herring <robh@kernel.org>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-clk@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org
---
 .../devicetree/bindings/clock/cirrus,cs2000-cp.yaml    | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml b/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
index d416c374e8534..031c52b2e5cec 100644
--- a/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
+++ b/Documentation/devicetree/bindings/clock/cirrus,cs2000-cp.yaml
@@ -11,14 +11,18 @@ maintainers:
 
 description: |
   The CS2000-CP is an extremely versatile system clocking device that
-  utilizes a programmable phase lock loop.
+  utilizes a programmable phase lock loop. CP2500-CP is a compatible
+  drop-in replacement for CP2000-CP.
 
   Link: https://www.cirrus.com/products/cs2000/
 
 properties:
   compatible:
-    enum:
-      - cirrus,cs2000-cp
+    oneOf:
+      - items:
+          - const: cirrus,cs2500-cp
+          - const: cirrus,cs2000-cp
+      - const: cirrus,cs2000-cp
 
   clocks:
     description:
-- 
2.53.0

