Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95BFC88E70
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 11:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2860A10EDB4;
	Mon, 14 Sep 2026 11:55:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IF+whjUK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AECF510EDB4
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 11:55:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 97B974362A;
 Mon, 14 Sep 2026 11:55:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDAB41F000FF;
 Mon, 14 Sep 2026 11:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789386910;
 bh=LFRLY70uQZ3XJlD8CeduqOmhhXpnOmwFSdP42ch1Xjk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=IF+whjUKRrGw9vmF3GYzSxrSJZUow6XfgXe0/6Kdq+yXDk/hQAqTybjuN2e9w0l76
 txMImshSIy4joz7LU2LSehuLSHyHgrYUN4e0aKrE942eC3Z9smo2an92xDqUEilSjF
 1xwm8+jj3TJkM6sh0PdjX0uADe28nTLu60+rc2zaU2uDkJg7recvAz2+izLac9pjqN
 5qAWvOrhNRGKoTdF56fN+JxK0TbOUPCS2mKv1RAhbPCXgpU3R0Ud1bN/KH+nx5giti
 bdu3+one6AEnVCsRxnTejFV+8l2D0trGXgER/L50r9G6sjx2YY1tOkCdKzC2IY8clm
 atiPIzowJ4XxQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 13:54:36 +0200
Subject: [PATCH v2 08/20] dt-bindings: cache: l2c2x0: Document power domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ux500-power-domains-v7-1-v2-8-9d0c17e1f816@kernel.org>
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

Describe the optional power domain for cache controllers.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/cache/l2c2x0.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/cache/l2c2x0.yaml b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
index ee604117ffb3..4e568c2a34ef 100644
--- a/Documentation/devicetree/bindings/cache/l2c2x0.yaml
+++ b/Documentation/devicetree/bindings/cache/l2c2x0.yaml
@@ -68,6 +68,8 @@ properties:
 
   power-domains:
     maxItems: 1
+    description:
+      Power domain controlling the cache controller.
 
   arm,data-latency:
     description: Cycles of latency for Data RAM accesses. Specifies 3 cells of

-- 
2.55.0

