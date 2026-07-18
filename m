Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D17C44533
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 779AF10E7A6;
	Mon, 20 Jul 2026 07:15:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tIGUhax8";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A119810E604
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:56:56 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49557167508so2295195e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784411815; x=1785016615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ix301uMLUVdMn58C2UIAphmLJhOXCWVoJrX02MWxSZA=;
 b=tIGUhax8KG8E3l1vhCz07Eyjw8RTwmwUIa73pdr9s9PweaROK047tuvcwgx20oyvVL
 y1LbrGLV7yUlsUHTy7QrJ+B7zkvI1K53Ps7eDe7ldUfsUTXj2GvcvrTeiFOMaGrxrVam
 30IuBOfeUynDJQzTdRRJ71SICF3YRI8VT79UP1/1AgyPycGaGSWRGxGBrxf+l2Mr4AUD
 fgMVsmXqTHmXl+2cejcXMleA8Pgtr5aYHd9/1lghtan25HgoH5apamHiESf54CcgyGF6
 PxfMYny/f8M5i/lFbZFiQWSldQBvCYpBfucglLt8WU+Of3hYw/XBOFHQfoca9cufl7/c
 9ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411815; x=1785016615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ix301uMLUVdMn58C2UIAphmLJhOXCWVoJrX02MWxSZA=;
 b=ifGoR7rkRlWoS1DUbF9mxE2oVIwi7+XiOHokHndbqvLlyTMdf7VG27rrJFJHhsvq6q
 4Li4u1QcBFIO9NAGVWcDD1fdHSqOkyhqabuS15OIEuA8w8EirGF46xTI2w0jiM1J3lU6
 Sp8c90Dx7wBK/3kiTr5wx1P/Ds36QN7v4sI7ObnLpcMRL0K17Z0q9OMaMl4c80xqLdwh
 wyNCbF7W2PPH2M67yzdUSdaxu/L9aXXT4MaCjkINXXxrCs7HP0GX+AsVtEYJvkneZvDV
 UIclpocNoPullb4DSvjyCgiq5F5xH07mZjnO6+3pGtDBkOTFK+MA6Zu6mZP1KdXABwt6
 LiIw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpFKB0InFod7k7xac+ssqieYx5oK/4TwjgZa7BtdBD3Jzv3+/F8ByvtoONSNKkAWvzUEqwG51Xuws0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRQ5FlknTvnR9Fr8t7+710aaU91uoGYbB42MVRLAXMoi9yoXEh
 dItObWifVSjrI+FhfB3KE+TOIvArLDWCpkwTdIVMP9/UgOopHoI3EMc1
X-Gm-Gg: AfdE7clM/CbYBlxSA7488uFtcAYh0uUH740rMWwYvgtDs6C5PbuvrgaqxjtWtPGEw2T
 WgLzcLKFKk7+CfwfyLnv0wcemFO9he3W0QgOKdXXk+Lc5Ge9uQ/upvGk1n//vbxyEd8vbmt4BEM
 aKyhe2CBGeJq6oZT1qchMu8b0a4vwhmN91K8F10XEH7kw8P0mt1oRCub7VmM+cNVjvtFGiF7P9O
 MvSrSFn+LjFK7e3eEd1OtDZZI83dZowPKQK/Fm41Xp9+rHQqjoFNquSje67+P4RwtpKj4OBX6s4
 vD8h1WL4UHaDNSQoS+9+XmMUmTxb0W5RvfoUUlvRZDoE4xWHVK9/RDU6Th9jV9zIpo08CCQ5t6A
 dozy0nwz4Q7qlmxdSDk1Mo04gn5V0bTg7zHAYeZYIyIloUsihH2HCucHYvnFoC03liVBbSg3DWn
 jcjKzhlhNA7xobInAQtCkF7hyMQF1F/g6ThnunXXa5Kt7g
X-Received: by 2002:a05:600c:4e86:b0:495:3b8a:5e17 with SMTP id
 5b1f17b1804b1-4954a3e41d5mr90987515e9.16.1784411815010; 
 Sat, 18 Jul 2026 14:56:55 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:56:54 -0700 (PDT)
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
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v2 1/3] ARM: dts: ti: am335x-guardian: Drop unused isink-en
 property
Date: Sat, 18 Jul 2026 21:56:30 +0000
Message-ID: <20260718215632.3295049-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718215632.3295049-1-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

The 'isink-en' property is not read by any driver, so remove it from the
TPS65217 backlight node.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
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

