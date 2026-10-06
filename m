Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65C92CA6004
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 13:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7974110F5DB;
	Wed,  7 Oct 2026 13:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="DMAleC8e";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08FF710E3F1
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 18:42:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id B6ABE3D8189B;
 Tue,  6 Oct 2026 14:36:17 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 5OAxWsRJn-R7; Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 8E3763D8181A;
 Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 8E3763D8181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1791311775; bh=pPwds9orn0zywC9UcxF6DhLudXbpgrTYR5kJrji9dy0=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=DMAleC8esKLeub/wpChxTdvAyQ/mgAlVsj+QQS24lp4xasjPNT/++HcMkr2Ea5nur
 Vvg0zh1ZpRK/3YgLzzSmebOHKLxSuWBnVOEVern/TyFpnzPcZ9aastPvS8lHg/9X/+
 soobk/7nYdpExpIBlcf6W7Hxg3hgKlE4O94aJO8kjisz0WY/jHvH1fNkjoXLN6BecW
 gAw/tcUOcmf0RO1tBfC9oC+5alRmQZKLbXpffzGlKL9qttbZ2bLfusqYX1H2eInpVO
 VzgGngnSh/VDDMwB2oqsG/DFY9DDd8/Kkv7gnvp+JD9tn3QnioCWst3xBg8JVqmuAe
 +NX4MkwFTy1Mg==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id ma4RZqOj-GXA; Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3AF573D81665;
 Tue,  6 Oct 2026 14:36:15 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 2/2] drm/panel: ilitek-ili9881c: Add DCLTek 300249 5.5in
 display
Date: Tue,  6 Oct 2026 14:34:55 -0400
Message-Id: <20261006183455.2350966-3-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261006183455.2350966-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 07 Oct 2026 13:51:21 +0000
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

The DCLTek dt300249 is an LCD panel using the Ilitek ILI9881C controller.
Add the panel to the driver.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 216 ++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/=
drm/panel/panel-ilitek-ili9881c.c
index 7bf38e96678a..acc560dc5ea5 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2198,6 +2198,195 @@ static const struct ili9881c_instr waveshare_7inc=
h_a_init[] =3D {
 	ILI9881C_COMMAND_INSTR(0x36, 0x00),
 };
=20
+static const struct ili9881c_instr dt300249_init[] =3D {
+	ILI9881C_SWITCH_PAGE_INSTR(3),
+	ILI9881C_COMMAND_INSTR(0x01, 0x00),
+	ILI9881C_COMMAND_INSTR(0x02, 0x00),
+	ILI9881C_COMMAND_INSTR(0x03, 0x72),
+	ILI9881C_COMMAND_INSTR(0x04, 0x00),
+	ILI9881C_COMMAND_INSTR(0x05, 0x00),
+	ILI9881C_COMMAND_INSTR(0x06, 0x09),
+	ILI9881C_COMMAND_INSTR(0x07, 0x00),
+	ILI9881C_COMMAND_INSTR(0x08, 0x00),
+	ILI9881C_COMMAND_INSTR(0x09, 0x01),
+	ILI9881C_COMMAND_INSTR(0x0a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0c, 0x01),
+	ILI9881C_COMMAND_INSTR(0x0d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x0f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x10, 0x00),
+	ILI9881C_COMMAND_INSTR(0x11, 0x00),
+	ILI9881C_COMMAND_INSTR(0x12, 0x00),
+	ILI9881C_COMMAND_INSTR(0x13, 0x00),
+	ILI9881C_COMMAND_INSTR(0x14, 0x00),
+	ILI9881C_COMMAND_INSTR(0x15, 0x00),
+	ILI9881C_COMMAND_INSTR(0x16, 0x00),
+	ILI9881C_COMMAND_INSTR(0x17, 0x00),
+	ILI9881C_COMMAND_INSTR(0x18, 0x00),
+	ILI9881C_COMMAND_INSTR(0x19, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
+	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
+	ILI9881C_COMMAND_INSTR(0x20, 0x05),
+	ILI9881C_COMMAND_INSTR(0x21, 0x02),
+	ILI9881C_COMMAND_INSTR(0x22, 0x00),
+	ILI9881C_COMMAND_INSTR(0x23, 0x00),
+	ILI9881C_COMMAND_INSTR(0x24, 0x00),
+	ILI9881C_COMMAND_INSTR(0x25, 0x00),
+	ILI9881C_COMMAND_INSTR(0x26, 0x00),
+	ILI9881C_COMMAND_INSTR(0x27, 0x00),
+	ILI9881C_COMMAND_INSTR(0x28, 0x33),
+	ILI9881C_COMMAND_INSTR(0x29, 0x02),
+	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x30, 0x00),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x32, 0x00),
+	ILI9881C_COMMAND_INSTR(0x33, 0x00),
+	ILI9881C_COMMAND_INSTR(0x34, 0x04),
+	ILI9881C_COMMAND_INSTR(0x35, 0x00),
+	ILI9881C_COMMAND_INSTR(0x36, 0x2a),
+	ILI9881C_COMMAND_INSTR(0x37, 0x00),
+	ILI9881C_COMMAND_INSTR(0x38, 0x3c),
+	ILI9881C_COMMAND_INSTR(0x39, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x40),
+	ILI9881C_COMMAND_INSTR(0x3b, 0x40),
+	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
+	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
+	ILI9881C_COMMAND_INSTR(0x40, 0x00),
+	ILI9881C_COMMAND_INSTR(0x41, 0x00),
+	ILI9881C_COMMAND_INSTR(0x42, 0x00),
+	ILI9881C_COMMAND_INSTR(0x43, 0x00),
+	ILI9881C_COMMAND_INSTR(0x44, 0x00),
+	ILI9881C_COMMAND_INSTR(0x50, 0x01),
+	ILI9881C_COMMAND_INSTR(0x51, 0x23),
+	ILI9881C_COMMAND_INSTR(0x52, 0x45),
+	ILI9881C_COMMAND_INSTR(0x53, 0x67),
+	ILI9881C_COMMAND_INSTR(0x54, 0x89),
+	ILI9881C_COMMAND_INSTR(0x55, 0xab),
+	ILI9881C_COMMAND_INSTR(0x56, 0x01),
+	ILI9881C_COMMAND_INSTR(0x57, 0x23),
+	ILI9881C_COMMAND_INSTR(0x58, 0x45),
+	ILI9881C_COMMAND_INSTR(0x59, 0x67),
+	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
+	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
+	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
+	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
+	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
+	ILI9881C_COMMAND_INSTR(0x5f, 0x01),
+	ILI9881C_COMMAND_INSTR(0x60, 0x00),
+	ILI9881C_COMMAND_INSTR(0x61, 0x15),
+	ILI9881C_COMMAND_INSTR(0x62, 0x14),
+	ILI9881C_COMMAND_INSTR(0x63, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x64, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x65, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x66, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x67, 0x06),
+	ILI9881C_COMMAND_INSTR(0x68, 0x02),
+	ILI9881C_COMMAND_INSTR(0x69, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6a, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x07),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x70, 0x02),
+	ILI9881C_COMMAND_INSTR(0x71, 0x02),
+	ILI9881C_COMMAND_INSTR(0x72, 0x02),
+	ILI9881C_COMMAND_INSTR(0x73, 0x02),
+	ILI9881C_COMMAND_INSTR(0x74, 0x02),
+	ILI9881C_COMMAND_INSTR(0x75, 0x01),
+	ILI9881C_COMMAND_INSTR(0x76, 0x00),
+	ILI9881C_COMMAND_INSTR(0x77, 0x14),
+	ILI9881C_COMMAND_INSTR(0x78, 0x15),
+	ILI9881C_COMMAND_INSTR(0x79, 0x0e),
+	ILI9881C_COMMAND_INSTR(0x7a, 0x0f),
+	ILI9881C_COMMAND_INSTR(0x7b, 0x0c),
+	ILI9881C_COMMAND_INSTR(0x7c, 0x0d),
+	ILI9881C_COMMAND_INSTR(0x7d, 0x06),
+	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
+	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
+	ILI9881C_COMMAND_INSTR(0x80, 0x02),
+	ILI9881C_COMMAND_INSTR(0x81, 0x02),
+	ILI9881C_COMMAND_INSTR(0x82, 0x02),
+	ILI9881C_COMMAND_INSTR(0x83, 0x02),
+	ILI9881C_COMMAND_INSTR(0x84, 0x07),
+	ILI9881C_COMMAND_INSTR(0x85, 0x02),
+	ILI9881C_COMMAND_INSTR(0x86, 0x02),
+	ILI9881C_COMMAND_INSTR(0x87, 0x02),
+	ILI9881C_COMMAND_INSTR(0x88, 0x02),
+	ILI9881C_COMMAND_INSTR(0x89, 0x02),
+	ILI9881C_COMMAND_INSTR(0x8a, 0x02),
+	ILI9881C_SWITCH_PAGE_INSTR(4),
+	ILI9881C_COMMAND_INSTR(0x6c, 0x15),
+	ILI9881C_COMMAND_INSTR(0x6e, 0x2a),
+	ILI9881C_COMMAND_INSTR(0x6f, 0x33),
+	ILI9881C_COMMAND_INSTR(0x3a, 0x94),
+	ILI9881C_COMMAND_INSTR(0x8d, 0x1a),
+	ILI9881C_COMMAND_INSTR(0x87, 0xba),
+	ILI9881C_COMMAND_INSTR(0x26, 0x76),
+	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
+	ILI9881C_COMMAND_INSTR(0xb5, 0x06),
+	ILI9881C_SWITCH_PAGE_INSTR(1),
+	ILI9881C_COMMAND_INSTR(0x22, 0x0a),
+	ILI9881C_COMMAND_INSTR(0x31, 0x00),
+	ILI9881C_COMMAND_INSTR(0x53, 0x84),
+	ILI9881C_COMMAND_INSTR(0x55, 0x8f),
+	ILI9881C_COMMAND_INSTR(0x50, 0xae),
+	ILI9881C_COMMAND_INSTR(0x51, 0xae),
+	ILI9881C_COMMAND_INSTR(0x60, 0x28),
+	ILI9881C_COMMAND_INSTR(0xa0, 0x0f),
+	ILI9881C_COMMAND_INSTR(0xa1, 0x1b),
+	ILI9881C_COMMAND_INSTR(0xa2, 0x28),
+	ILI9881C_COMMAND_INSTR(0xa3, 0x12),
+	ILI9881C_COMMAND_INSTR(0xa4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xa5, 0x28),
+	ILI9881C_COMMAND_INSTR(0xa6, 0x1b),
+	ILI9881C_COMMAND_INSTR(0xa7, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xa8, 0x79),
+	ILI9881C_COMMAND_INSTR(0xa9, 0x1b),
+	ILI9881C_COMMAND_INSTR(0xaa, 0x27),
+	ILI9881C_COMMAND_INSTR(0xab, 0x69),
+	ILI9881C_COMMAND_INSTR(0xac, 0x19),
+	ILI9881C_COMMAND_INSTR(0xad, 0x18),
+	ILI9881C_COMMAND_INSTR(0xae, 0x4c),
+	ILI9881C_COMMAND_INSTR(0xaf, 0x21),
+	ILI9881C_COMMAND_INSTR(0xb0, 0x28),
+	ILI9881C_COMMAND_INSTR(0xb1, 0x52),
+	ILI9881C_COMMAND_INSTR(0xb2, 0x65),
+	ILI9881C_COMMAND_INSTR(0xb3, 0x3f),
+	ILI9881C_COMMAND_INSTR(0xc0, 0x04),
+	ILI9881C_COMMAND_INSTR(0xc1, 0x1b),
+	ILI9881C_COMMAND_INSTR(0xc2, 0x27),
+	ILI9881C_COMMAND_INSTR(0xc3, 0x13),
+	ILI9881C_COMMAND_INSTR(0xc4, 0x15),
+	ILI9881C_COMMAND_INSTR(0xc5, 0x28),
+	ILI9881C_COMMAND_INSTR(0xc6, 0x1c),
+	ILI9881C_COMMAND_INSTR(0xc7, 0x1e),
+	ILI9881C_COMMAND_INSTR(0xc8, 0x79),
+	ILI9881C_COMMAND_INSTR(0xc9, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xca, 0x27),
+	ILI9881C_COMMAND_INSTR(0xcb, 0x69),
+	ILI9881C_COMMAND_INSTR(0xcc, 0x1a),
+	ILI9881C_COMMAND_INSTR(0xcd, 0x18),
+	ILI9881C_COMMAND_INSTR(0xce, 0x4c),
+	ILI9881C_COMMAND_INSTR(0xcf, 0x21),
+	ILI9881C_COMMAND_INSTR(0xd0, 0x27),
+	ILI9881C_COMMAND_INSTR(0xd1, 0x52),
+	ILI9881C_COMMAND_INSTR(0xd2, 0x65),
+	ILI9881C_COMMAND_INSTR(0xd3, 0x3f),
+};
+
 static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel=
)
 {
 	return container_of(panel, struct ili9881c, panel);
@@ -2493,6 +2682,23 @@ static const struct drm_display_mode waveshare_7in=
ch_a_mode =3D {
 	.height_mm	=3D 154,
 };
=20
+static const struct drm_display_mode dt300249_default_mode =3D {
+	.clock		=3D 62000,
+
+	.hdisplay	=3D 720,
+	.hsync_start	=3D 720 + 10,	/* HFP =3D 10 */
+	.hsync_end	=3D 720 + 10 + 20,	/* HSYNC =3D 20 */
+	.htotal		=3D 720 + 10 + 20 + 20,	/* HBP =3D 20, htotal =3D 770 */
+
+	.vdisplay	=3D 1280,
+	.vsync_start	=3D 1280 + 10,	/* VFP =3D 10 */
+	.vsync_end	=3D 1280 + 10 + 10,	/* VSYNC =3D 10 */
+	.vtotal		=3D 1280 + 10 + 10 + 20,	/* VBP =3D 20, vtotal =3D 1320 */
+
+	.width_mm	=3D 68,
+	.height_mm	=3D 121,
+};
+
 static int ili9881c_get_modes(struct drm_panel *panel,
 			      struct drm_connector *connector)
 {
@@ -2698,9 +2904,19 @@ static const struct ili9881c_desc waveshare_7inch_=
a_desc =3D {
 	.lanes =3D 2,
 };
=20
+static const struct ili9881c_desc dt300249_desc =3D {
+	.init =3D dt300249_init,
+	.init_length =3D ARRAY_SIZE(dt300249_init),
+	.mode =3D &dt300249_default_mode,
+	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		      MIPI_DSI_MODE_LPM,
+	.lanes =3D 4,
+};
+
 static const struct of_device_id ili9881c_of_match[] =3D {
 	{ .compatible =3D "bananapi,lhr050h41", .data =3D &lhr050h41_desc },
 	{ .compatible =3D "bestar,bsd1218-a101kl68", .data =3D &bsd1218_a101kl6=
8_desc },
+	{ .compatible =3D "dcltek,dt300249", .data =3D &dt300249_desc },
 	{ .compatible =3D "feixin,k101-im2byl02", .data =3D &k101_im2byl02_desc=
 },
 	{ .compatible =3D "startek,kd050hdfia020", .data =3D &kd050hdfia020_des=
c },
 	{ .compatible =3D "tdo,tl050hdv35", .data =3D &tl050hdv35_desc },
--=20
2.34.1

