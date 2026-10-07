Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E99CA600E
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 07:42:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FE7F10FCDF;
	Thu,  8 Oct 2026 07:42:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="XRpf/lzU";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2EA10E6BD
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:19:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id E05803D81880;
 Wed,  7 Oct 2026 16:19:05 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id QwxMLK_a_tUf; Wed,  7 Oct 2026 16:19:04 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 04B3F3D8182D;
 Wed,  7 Oct 2026 16:19:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 04B3F3D8182D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1791404344; bh=pesBVhJa36Z9odWhO8ZlZqjh+VKIb/JO1NtpxS2F2Cw=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=XRpf/lzUzxXkFLDl+tqtJDWk9DTnC6vdP828pElDMJkzzif8BcCAgC9PlrB0Yuv8b
 cb+0Z6QLjXB23v8WNWOLhRK71w0lOhGk3wV5x9cCo9tJN6sqcdx3wnmqDaFA7TXBaL
 HfLqigJWbsQYeGqfc7L1ednaF47Xx5NXFpmLc4PPN/wX15HOq0oi1re+XWzLMJ9SKd
 ZjqlNrCgnNdMn9uKYy1ZWq59Lr9TL4sN6P3RkqiK0JyKf23Tmoc1+s2D7LcSUBGcgs
 qm5VERSG8obaVnCFUCyRKs+WJnJ3tvQGDQfzj8uABBDoi1ypsw5iVDoqeoQf/E3+66
 Ys5WPOh2VD3MQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id FB-jFHNDLHRD; Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 9AD4D3D81851;
 Wed,  7 Oct 2026 16:19:03 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
Cc: Ondrej Jirman <megi@xff.cz>, Purism Kernel Team <kernel@puri.sm>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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
Subject: [PATCH 4/4] drm/panel: st7703: Add DCLTek 300248 10.25in display
Date: Wed,  7 Oct 2026 16:18:59 -0400
Message-Id: <20261007201859.3709656-5-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261007201859.3709656-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 08 Oct 2026 07:42:48 +0000
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

The DCLTek dt300248 is an LCD panel using the Sitronix ST7703
controller. Add the panel to the driver.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/=
drm/panel/panel-sitronix-st7703.c
index f4635a7327de..b3abfe8c9ed9 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -768,6 +768,102 @@ static const struct st7703_panel_desc ayaneo_pocket=
_ds_lower_desc =3D {
 	.init_sequence =3D ayaneo_pocket_ds_lower_init_sequence,
 };
=20
+static void dcltek_dt300248_init_sequence(struct mipi_dsi_multi_context =
*dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETEXTC, 0xf1, 0x12, 0=
x87);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETDISP, 0xe0, 0x05, 0=
xf8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETRGBIF, 0x10, 0x10, =
0x28,
+				     0x28, 0x03, 0xff, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETCYC, 0x80);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETBGP, 0x0d, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETVCOM, 0x6d, 0x6d);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETPOWER_EXT, 0x25, 0x=
62,
+				     0x20, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETMIPI,
+				     0x33, 0x81, 0x05, 0xf9, 0x0e, 0x0e, 0x20, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x44, 0x25,
+				     0x00, 0x91, 0x0a, 0x00, 0x00, 0x01, 0x4f, 0x01,
+				     0x00, 0x00, 0x37);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETVDC, 0x47);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_UNKNOWN_BF,
+				     0x02, 0x10, 0x00, 0x80, 0x04);
+
+	mipi_dsi_msleep(dsi_ctx, 20);
+
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETSCR,
+				     0x73, 0x73, 0x50, 0x50, 0xa0, 0x00, 0x12, 0x53,
+				     0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETPOWER,
+				     0x25, 0x00, 0x32, 0x32, 0x77, 0xe4, 0x77, 0x77,
+				     0xcc, 0xcc, 0xff, 0xff, 0x11, 0x11, 0x00, 0x00,
+				     0x32);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETIO,
+				     0x10, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0xed, 0xc5, 0x00, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETCABC,
+				     0x10, 0x40, 0x1e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETPANEL, 0x07);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETGAMMA,
+				     0x00, 0x13, 0x1a, 0x2c, 0x34, 0x3f, 0x4f, 0x3f,
+				     0x06, 0x0c, 0x0d, 0x14, 0x15, 0x13, 0x13, 0x11,
+				     0x19, 0x00, 0x13, 0x1a, 0x2c, 0x34, 0x3f, 0x4f,
+				     0x3f, 0x06, 0x0c, 0x0d, 0x14, 0x15, 0x13, 0x13,
+				     0x11, 0x19);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_UNKNOWN_E1,
+				     0x11, 0x11, 0x91, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETEQ,
+				     0x07, 0x07, 0x0b, 0x0b, 0x0b, 0x0b, 0x00, 0x00,
+				     0x00, 0x00, 0x2f, 0x04, 0xc0, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETGIP1,
+				     0xc8, 0x10, 0x0a, 0x10, 0x0e, 0x80, 0x38, 0x12,
+				     0x31, 0x23, 0x4f, 0x86, 0x80, 0x38, 0x47, 0x08,
+				     0x00, 0x0c, 0x04, 0x00, 0x00, 0x00, 0x00, 0x0c,
+				     0x04, 0x00, 0x00, 0x00, 0x8f, 0x44, 0x60, 0x28,
+				     0xba, 0x02, 0x88, 0x88, 0x88, 0x88, 0x88, 0x8f,
+				     0x45, 0x71, 0x38, 0xba, 0x13, 0x88, 0x88, 0x88,
+				     0x88, 0x88, 0x00, 0x00, 0x00, 0x01, 0x00, 0x80,
+				     0x38, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_SETGIP2,
+				     0x96, 0x18, 0x00, 0x00, 0x00, 0xb4, 0x01, 0x0b,
+				     0x41, 0x01, 0x02, 0x00, 0xf8, 0x43, 0x17, 0x58,
+				     0xba, 0x31, 0x88, 0x88, 0x88, 0x88, 0x88, 0xf8,
+				     0x42, 0x06, 0x48, 0xba, 0x20, 0x88, 0x88, 0x88,
+				     0x88, 0x88, 0x23, 0x00, 0x00, 0x00, 0xd7, 0x00,
+				     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+				     0x00, 0x00, 0x07, 0x8b, 0x00, 0x00, 0x40, 0x80,
+				     0x81, 0x40, 0x80, 0x81, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, ST7703_CMD_UNKNOWN_EF,
+				     0xff, 0xff, 0x01);
+}
+
+static const struct drm_display_mode dcltek_dt300248_mode =3D {
+	.clock		=3D (440 + 8 + 32 + 40) * (1920 + 41 + 8 + 6) * 60 / 1000,
+
+	.hdisplay	=3D 440,
+	.hsync_start	=3D 440 + 8,
+	.hsync_end	=3D 440 + 8 + 32,
+	.htotal		=3D 440 + 8 + 32 + 40,
+
+	.vdisplay	=3D 1920,
+	.vsync_start	=3D 1920 + 41,
+	.vsync_end	=3D 1920 + 41 + 8,
+	.vtotal		=3D 1920 + 41 + 8 + 6,
+
+	.width_mm	=3D 58,
+	.height_mm	=3D 253,
+	.flags		=3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
+};
+
+static const struct st7703_panel_desc dcltek_dt300248_desc =3D {
+	.mode =3D &dcltek_dt300248_mode,
+	.lanes =3D 4,
+	.mode_flags =3D MIPI_DSI_MODE_VIDEO |
+		MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		MIPI_DSI_MODE_LPM,
+	.format =3D MIPI_DSI_FMT_RGB888,
+	.init_sequence =3D dcltek_dt300248_init_sequence,
+};
+
 static int st7703_enable(struct drm_panel *panel)
 {
 	struct st7703 *ctx =3D panel_to_st7703(panel);
@@ -1026,6 +1122,7 @@ static void st7703_remove(struct mipi_dsi_device *d=
si)
 static const struct of_device_id st7703_of_match[] =3D {
 	{ .compatible =3D "anbernic,rg353v-panel-v2", .data =3D &rg353v2_desc }=
,
 	{ .compatible =3D "ayaneo,pocket-ds-lower-panel", .data =3D &ayaneo_poc=
ket_ds_lower_desc },
+	{ .compatible =3D "dcltek,dt300248", .data =3D &dcltek_dt300248_desc },
 	{ .compatible =3D "gameforce,chi-panel", .data =3D &gameforcechi_desc }=
,
 	{ .compatible =3D "powkiddy,rgb10max3-panel", .data =3D &rgb10max3_pane=
l_desc },
 	{ .compatible =3D "powkiddy,rgb30-panel", .data =3D &rgb30panel_desc },
--=20
2.34.1

