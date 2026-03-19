Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F710108E1F7
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:54:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA09F10E9AB;
	Thu, 19 Mar 2026 11:54:12 +0000 (UTC)
X-Greylist: delayed 505 seconds by postgrey-1.36 at gabe;
 Thu, 19 Mar 2026 11:54:11 UTC
Received: from ni.piap.pl (ni.piap.pl [195.187.100.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A3B410E9AB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 11:54:11 +0000 (UTC)
Received: from t19.piap.pl (OSB1819.piap.pl [10.0.9.19])
 by ni.piap.pl (Postfix) with ESMTPS id 10210C3EEAC9;
 Thu, 19 Mar 2026 12:45:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 10210C3EEAC9
From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Frank Li
 <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: i.MX8MP: Fix HDMI LCDIF FIFO underruns
Date: Thu, 19 Mar 2026 12:45:40 +0100
Message-ID: <m3ms04caaj.fsf@t19.piap.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Running (and terminating) Weston on i.MX8MP sometimes produced black
or grey screens. The LCDIF3 INT_STATUS_D0 register showed a FIFO underrun:

32FC6024: 1000002

The PANIC0_THRES register was set to:

32FC6238:  AA0154

which apparently meant low =3D 2736 bytes (0xAA * 16 + 16), high =3D 5456 b=
ytes
(0x154 * 16 + 16).

With this patch (based on NXP's driver) the watermarks are only 16 bytes
higher (register values increased by 1) and the underruns are gone.

Tested on Solidrun Hummingboard Mate with a 1080p60 HDMI display.

Signed-off-by: Krzysztof Ha=C5=82asa <khalasa@piap.pl>

--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -353,8 +353,8 @@ static void lcdif_enable_controller(struct lcdif_drm_pr=
ivate *lcdif)
 	u32 reg;
=20
 	/* Set FIFO Panic watermarks, low 1/3, high 2/3 . */
-	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, 1 * PANIC0_THRES_MAX / 3) |
-	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, 2 * PANIC0_THRES_MAX / 3),
+	writel(FIELD_PREP(PANIC0_THRES_LOW_MASK, DIV_ROUND_UP(1 * PANIC0_THRES_MA=
X, 3)) |
+	       FIELD_PREP(PANIC0_THRES_HIGH_MASK, DIV_ROUND_UP(2 * PANIC0_THRES_M=
AX, 3)),
 	       lcdif->base + LCDC_V8_PANIC0_THRES);
=20
 	/*

--=20
Krzysztof "Chris" Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
