Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C3A2C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:48:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75DA310E262;
	Sun, 20 Sep 2026 22:48:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XXdOR/Ik";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C791B10E24B
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B151940048;
 Sun, 20 Sep 2026 22:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1C71F00893;
 Sun, 20 Sep 2026 22:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944529;
 bh=XA4FIDvCYy0BQ/rMAtKvbtPxkdDgnG7QQZ5e1dIml+o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=XXdOR/IknJe33d4peh0RN/kTPQU6vmxouThi1kj9TVw6BOOAFve8zpRcdm0g2tujD
 hXWPqn8GvkroKOBfeA2mlaLedelOjoS2140AMHSa09IdzRhaR3gmZSE4MC77DCpJ2I
 TobztOTYRsrw56mcnEwfsbsfjTHKVCb0AYswn5qLv8sRmbkbK9PGSI/8eLFvP0QwBk
 wkctwHa12OhWsEOwSL5N7f2tgwmBHMsE/+SdBcOeA+wmUkIOPjViwX7i+kDOjg6Bxv
 dXjmUjUnGksaDJc94ceFj+2ehj21yoidqlOr08Z7GkV/xxO8GTzgHlq/rLaCvveqRq
 zvn98dVD+rMVQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:14 +0200
Subject: [PATCH v3 08/18] dt-bindings: clock: stericsson,u8500-clks: Allow
 power domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-8-9352be6b86b1@kernel.org>
References: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
In-Reply-To: <20260921-ux500-power-domains-v7-1-v3-0-9352be6b86b1@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Mark Brown <broonie@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, 
 Lee Jones <lee@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
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

Allow the DB8500 clock controller node to reference its power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
index 4ebfa5a8d524..75e5e1107ebb 100644
--- a/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
+++ b/Documentation/devicetree/bindings/clock/stericsson,u8500-clks.yaml
@@ -34,6 +34,9 @@ properties:
       - description: PRCC 5 register area
       - description: PRCC 6 register area
 
+  power-domains:
+    maxItems: 1
+
   prcmu-clock:
     description: A subnode with one clock cell for PRCMU (power, reset, control
       management unit) clocks. The cell indicates which PRCMU clock in the

-- 
2.55.0

