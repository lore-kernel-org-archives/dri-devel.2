Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66151C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4C1910EBAD;
	Tue, 21 Jul 2026 22:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XeBAcRNr";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E3BF10E23A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:21:48 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-47640541585so5744469f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784632907; x=1785237707; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
 b=XeBAcRNrjxL8PD1iUlneD9Z8A0Z2LTlxzTAsA9khfrBFCxgSU5+6zGeKD8a4AsptNh
 pBB0pY/C4X0XckUd3jm9xdmENSAtrBnQDuB14zScmuCOYkRmMz4DeyQtLwNZrI+v82K4
 Vb/e3PZpwSkyKFLNa0ol6KsOYa1ZdBWKFhwI+ZyWWWzrOIJjH0uxvIqJs4TIZO9zQI55
 2oJ42ubozxczDPJLVbDBL2JERvKK1zfwSzg3I4pBvuAQMwZb+KLNOhZNjBTxTQFAmV0t
 xvhnBjpdYuuhQkAmQgMazn6GxRpXafwGOqnlMwcvcvFTTEAFEchjwHCS2fxRNi1TLkIK
 YC0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632907; x=1785237707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
 b=GE2B8GFcCTiPsphTsSBrbKhUFuqXNJcgCeP2atcjlph0PCcjjVqY77H2zSgOGMkhMe
 wnZKQ8C5pN3ZG0tBR2MN9vZchYHK0WUsWNKyzC24ZoY/HxnBmpmh8eENJ3mcSmL5sVXo
 NHXDGztN2eVyjHaUITP+2w7xVpbEyPG/wHpEhbndw3WbvWr3DQtHUuUHL6oLJZqZlHMn
 yI1vqW3wjTU6XqkkqwDUUgSDhatcYa3Zf6u0sjinp0FgJAAaMnv/WJ0hlgmUSf2JdjrV
 DJ0Nr0E/PKhx8y0UnFPUbBmIC5qGkDaA3s41lhjXbbAcq4PYM7pqUWSxu2oI9Jvh0jP9
 dGwg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr9MPrnEeG2PXEXenOPAzAVSUaqwt1EIiJZ3W+NgluY9DeIkgoKqDn7P2Uw4YTTZ0CuesXflTRUo94=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBCG3d1onidMmyWeQLHXBYvn9gQoflINpoWgR/3M8TmpGuAbHt
 lp64wOuIItZp3EVvG33cDdOJ8FswVHcP9oRuTeZEx59fkNiP+0nRFS8j
X-Gm-Gg: AR+sD13UzyjULAVQhWITKnBm875ASeJ/ipiq8wdfRDxBHuy9eRSbYtAtemR4AJGpNGL
 YivDrZTRSYi/wlDmBtr+nf6Uh+KtPywguVxh778OpfTAIAf7zUQYLgQes/CxzwbjA1W4UDuvssW
 hcIm/WYMGt3Nnu6Dkkoxj1lx6axqDa/xXUK/Lnjry/GlWqrWKqiF5l8QVEUsDvS72s2OSlAFbWU
 ViGBixYBNl8MJ+6NboU3otiaJ4Z4ECDpHsFDpZyaYeXSeLrt69lOGmcR3NoFEH9UtZFJ2ezsGfq
 dTVRVVB5gYNyBdiwrDJ8IHPXi2hgDjvjELjdZ8ChdU3qU/y0S4sYkzthF6WJT4TzfSwIUtaF4ww
 LUjjm1W4DP/I+PEzLCZnqoMwT0p7trZvti6PuvdmqQ0xNT4Blg5AL1sBbqKlF9U+pE/eqFyJYM8
 iHihlGf1qg/vuTCVhBq1H6kdWf/PjbaWcEJ9GKM0JwUxHbrQLdiP11B8A=
X-Received: by 2002:a05:6000:71a:b0:47f:48cb:ea5b with SMTP id
 ffacd0b85a97d-47f6233d615mr19569935f8f.43.1784632906622; 
 Tue, 21 Jul 2026 04:21:46 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:21:46 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-omap@vger.kernel.org,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/4] ARM: dts: ti: am335x-guardian: Drop unused isink-en
 property
Date: Tue, 21 Jul 2026 11:21:25 +0000
Message-ID: <20260721112133.70382-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721112133.70382-1-egbostina@gmail.com>
References: <20260721112133.70382-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

The 'isink-en' property is not documented and not read by any driver,
so remove it from the TPS65217 backlight node.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
index 6ce3a2d029ee..d595e79d6b05 100644
--- a/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
+++ b/arch/arm/boot/dts/ti/omap/am335x-guardian.dts
@@ -320,9 +320,6 @@ backlight {
 		isel = <1>;  /* 1 - ISET1, 2 ISET2 */
 		fdim = <500>; /* TPS65217_BL_FDIM_500HZ */
 		default-brightness = <50>;
-		/* 1(on) - enable current sink, while initialization */
-		/* 0(off) - disable current sink, while initialization */
-		isink-en = <1>;
 	};
 
 	regulators {
-- 
2.43.0

