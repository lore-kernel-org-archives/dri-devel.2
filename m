Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F05D2C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB7C10EDC4;
	Mon, 14 Sep 2026 11:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JtOyZpq1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7300F10EDBA
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5B29A40606;
 Mon, 14 Sep 2026 11:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82EF51F00898;
 Mon, 14 Sep 2026 11:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789386927;
 bh=2ErdF9zbcnYBBoFr2LO3F6wn1clGA4i7eH2E+6c0H98=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=JtOyZpq1Hhaq7VNsbGL3TUBK0A+uOjC4l63XYetDbuYHNvP8X7/kNNpJIHPECccb2
 q80v2JBQKSHyYAdFkRNMic8WHrZyHrei1R+gr/8k/97b5wNyP/wm+YRBjmj4Wm2CsS
 HOChWONdtXCFI7gI5jY9oGkmD5Enx+sciAbc2qGxkvdLGGWrVeGhEfgwudHVZ1lYXl
 Gu4gSGyxcZdCnMDAYwm+YqKAjYlG5JvR1LHaVnAtgz/nwkF5cYrlyVXmXQ9o18DDTF
 vgTyziKrxt3UM2V1eCV5ySxodsqjdYKzI8/9MToUqvXaiwOKNUE7LcPzLi9k3qmZNB
 WlOu5sG8R1ZgA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:40 +0200
Subject: [PATCH v2 12/20] dt-bindings: watchdog: arm,twd-wdt: Allow power
 domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-12-9d0c17e1f816@kernel.org>
References: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
In-Reply-To: <20260914-ux500-power-domains-v7-1-v2-0-9d0c17e1f816@kernel.org>
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

Allow TWD watchdog nodes to reference their power domain.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
index 9646ac72051e..5f6a9d6b9976 100644
--- a/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/arm,twd-wdt.yaml
@@ -33,6 +33,9 @@ properties:
   clocks:
     maxItems: 1
 
+  power-domains:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.55.0

