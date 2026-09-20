Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC89C982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 171F610E28C;
	Sun, 20 Sep 2026 22:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CviMjVsT";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE78710E282
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 631FC600C8;
 Sun, 20 Sep 2026 22:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531141F000FF;
 Sun, 20 Sep 2026 22:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944538;
 bh=MmlbpVMmMHMs1r5j0DKbq3pvTJhWH+8jZjt/WcqFqsA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=CviMjVsTmnlEwtmzTXimVkEv5OXgZjl9UGdG5CKkQjrTRwr67GZxINRQklPdrTfko
 KbOISedK15hkr7YbctfybZKxaqWYesxdkmhzCPp0refkhyVoBWXOUQfKAXqeGLU3nK
 Sa1BQqeCbz9Ql4zVzeJYoFlxDuywYuSFPl2rhKimH2I9PoygJJjuO/t0Wi2QSQ9eYm
 yq5L9BkJhwZ9siijuzOeengTR41kb0jzIWu8ylT+McuZEQPAZapKMKsyh0ZDG3iw9C
 0/d7UNDf2dxx23vbkF63RMKsFOBI70swK+8T8HBQPd/H+lNVNpHau6SXxwwAKkNszX
 YPav3ywyXRwUg==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:16 +0200
Subject: [PATCH v3 10/18] dt-bindings: watchdog: arm,twd-wdt: Allow power
 domains
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-10-9352be6b86b1@kernel.org>
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

Allow TWD watchdog nodes to reference their power domain.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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

