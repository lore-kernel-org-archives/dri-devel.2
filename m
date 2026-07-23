Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7746C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2128E10F067;
	Thu, 23 Jul 2026 10:06:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AE7csgfI";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9D9D10F065
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:06:19 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4954afac04bso5205835e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784801178; x=1785405978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
 b=AE7csgfI4er1GUR+u/uK7KEQP46cG7vxgnu6n2R4obbwlqaJrDmS+lcNlUPUNQZM5g
 tLLLtPXOrlHcNwJy6SdMRtnxBTnovuQkkimm+wi56vD61y7xLadjEwicWvpa/O4zXrw7
 G8GcwOGHbbE9CdM4sZ1rhnrpZQ9rkCS6R/FIzgAmM5578iEyY1EEW4PwFEhYWI0P+hKN
 dAloQqzTFOD1wiQ7TOESmhDWrOEBvEgoX951d1W0h04h0jvjgK4j6AvJ1T4gjKw5z8Wm
 YuaT9mAdMm6BrGvMXR/bdpsWwCESlxVFa2r0xF3LnRsLsQv55ADHtGiOMh1NqjclKDPr
 8x6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784801178; x=1785405978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6g+koxDLN1Chjep218/XBMsTlfwQifOiOfABmvTzX4A=;
 b=hT/rqzjkcYUvTAKCsHpiilCiOgz6oukUnB0aMHthFbYngOSZ2ECx2nFYQQpCliqUh1
 E/fNNTWFjlMTvnkE01D8Gk0sdSZJ5hrvBTV910iUaoCQU0jlIlikjvBD2FXzetnNW8Z8
 +R4CqybtgsNga1U47XwC22G4ROFl4eeQJEye7LYlmpd7W83biK8HmF27d/DaJbvmm97j
 CxGmNmPrtBKbbWsmNEdpgisKljRcJKWWgU6nvU8ZVpLXYrrWey4h1a6oR2LI87IP1XJK
 IbNfooMT+GjiAOUP+bhR6oSNqzgp0tn0Ntu0ielu25TQ24Ds4fCO7x3kgrOBlHlg2Jv7
 0RaA==
X-Forwarded-Encrypted: i=1;
 AHgh+Ron2wcJumWOFZih6viWfqAhlvs9Q6MD3lVgGqJOxhvBTwsTltnkbSNCpjjheGSFFO2/PGUNPobrqC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/4YC1P0IwVfPPJLwzlz5tI5eOvlijXfTVEEm6qv18Ilqt4oYf
 A3ADveqpK9tffnMyWvPLQf8FD9ZH5yygtPc1k1hDUWJzYvWAEAuZU6rF
X-Gm-Gg: AR+sD11AvWMsTpvt5Y5cYxdNWK5snumXa/JR6ZI0Qpzj03K2IIb0zEXH3FbUR/KTTbO
 0i68paGdlOx59n+ZAycRAQlrx/C19Jv4t+H2EcMoFNX8zZWgrskMxi2jpWVF/uFIaxY/5HOEAWx
 8g57MYET+SiiLQ15C340/V7EdB1dnXz+YZo1+kl4R3dKXovsQlSCPayijff1tyXcdbKBxwGeU32
 Z4Zfc7uEQo/I2PVM1KqTR3PbO+feA4PATKoa3nl4KllNsierLwarbtJWEmXJh7ow6Oz4PW+MTl5
 1XGUyPRcwckWg3nlnFcXeJxqBId4QRi0/hyMqZFVN0em+9zT0dSzt4rssvL6GTWgwH2Rccqubug
 srfbnJvWz5EBg4TVHBVP095MTvpMLbaCELLiFBevpnjyigO4YDMZcdcVAcLxjUfx47XQAJOpVrg
 N1YtrtFvLhe+GN1CwDRmTX7gOtjC/o3qLCfeWS7L/xMZSW
X-Received: by 2002:a05:600c:4689:b0:492:6f6f:fa42 with SMTP id
 5b1f17b1804b1-49573d37f29mr28050145e9.37.1784801178079; 
 Thu, 23 Jul 2026 03:06:18 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:06:17 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 1/4] ARM: dts: ti: am335x-guardian: Drop unused isink-en
 property
Date: Thu, 23 Jul 2026 10:05:59 +0000
Message-ID: <20260723100605.628882-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
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

