Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692EFC982EB
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 22:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDE710E163;
	Sun, 20 Sep 2026 22:48:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Lj7WbB8d";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B068D10E14E
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 22:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 987D6438A0;
 Sun, 20 Sep 2026 22:48:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558701F00898;
 Sun, 20 Sep 2026 22:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789944503;
 bh=GlUeiKqBy40E+344jIcqfAa3hwlFrXZHKHXpJHntRnQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Lj7WbB8dmxhxIG6kakpsInEh1xjuyykvGQz9EkXx72XadH/nqBbyRCa55D5WxyZYF
 6XOsSE98KShPD/FUhZ/Z9V8MtwCAa0xJMaIxyCMYLDptfc1WfWJQsISyG5G6NPeFTd
 TReMZRaUTMr+Mdn5lQrx86xcpgGdD5uVnC9GjsAkFQnFuWLKk+8aqJQUmRO6GA6kfc
 nJ/H0jsBe04Ay0mdXSN00KxB2TqrKXNH1XqWqMDA+TA9oJlJa5lR9GAzNolHZb2nSI
 LGwk4izQp6cT76xxlXNEuKsrUXsOkqn4TTioh97rjKfH+kO1Brtm5Ryi/0c8njF0Uq
 kFzZHh97RoXLA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 21 Sep 2026 00:48:08 +0200
Subject: [PATCH v3 02/18] dt-bindings: arm: ux500: Drop NR_DOMAINS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-ux500-power-domains-v7-1-v3-2-9352be6b86b1@kernel.org>
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
 dmaengine@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

Keep the internal Ux500 PM domain count local to the only driver
that uses it.

Do not expose this implementation detail through the DT binding header.

Assisted-by: LLM
Suggested-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/pmdomain/st/ste-ux500-pm-domain.c  | 2 ++
 include/dt-bindings/arm/ux500_pm_domains.h | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/st/ste-ux500-pm-domain.c b/drivers/pmdomain/st/ste-ux500-pm-domain.c
index 6896cb4a7b71..c9129a3b1805 100644
--- a/drivers/pmdomain/st/ste-ux500-pm-domain.c
+++ b/drivers/pmdomain/st/ste-ux500-pm-domain.c
@@ -17,6 +17,8 @@
 
 #include <dt-bindings/arm/ux500_pm_domains.h>
 
+#define NR_DOMAINS		(DOMAIN_VAPE + 1)
+
 static int pd_power_off(struct generic_pm_domain *domain)
 {
 	/*
diff --git a/include/dt-bindings/arm/ux500_pm_domains.h b/include/dt-bindings/arm/ux500_pm_domains.h
index 9bd764f0c9e6..9d94801d8b89 100644
--- a/include/dt-bindings/arm/ux500_pm_domains.h
+++ b/include/dt-bindings/arm/ux500_pm_domains.h
@@ -9,7 +9,5 @@
 
 #define DOMAIN_VAPE		0
 
-/* Number of PM domains. */
-#define NR_DOMAINS		(DOMAIN_VAPE + 1)
 
 #endif

-- 
2.55.0

