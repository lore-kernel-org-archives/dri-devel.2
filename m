Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42328C531C7
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 07:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFD4A10EFD8;
	Thu, 23 Jul 2026 07:07:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="MYpkq6Af";
	dkim-atps=neutral
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com
 [208.88.110.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B298010E0C9
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 17:38:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id 258443D81899;
 Wed, 22 Jul 2026 13:38:45 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id mj3Ra5C4g-Wn; Wed, 22 Jul 2026 13:38:42 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.savoirfairelinux.com (Postfix) with ESMTP id E82103D8166A;
 Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com E82103D8166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
 t=1784741921; bh=E96HWFwk8uqjRNKDycls8F8xTDAbs/VDBzpSFGdiLG4=;
 h=From:To:Date:Message-Id:MIME-Version;
 b=MYpkq6AfDoaZi6iw6rPB8OAt/GyW3730ud3IACrA7Q23N2A9sSkbaC0vOgs75OGmL
 EoX3rQ7wzBpn6Yk9Wq6eV2lrOLQ9Co8MudMHRMWiOLgHsxPIQwTU4SET9Tmqj9o2r2
 mCJkoep8hi0JYIjKFBo7XMfOiaQJCqVcApggQW+JgtoQnuWYqljZe9fv2dufxQD3lf
 vmPpTca+Jp55VTYyWX01qrSXQ1N4eA2D2ngISVQXdkSxwWTR1/fr/JeEAKOy/nxOjG
 hZWV8dKracBoA4zQzAN02Q6e6HnCSFeAXy1pPQUmeEJsKrwxHu3dDOgnYmqy7KYWnz
 BpK1wcaOEyAxQ==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 3-09zcr7BpmV; Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
 by mail.savoirfairelinux.com (Postfix) with ESMTPSA id A719C3D81895;
 Wed, 22 Jul 2026 13:38:41 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Jagan Teki <jagan@edgeble.ai>, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
 Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
 Felix Boucher <felix.boucher@savoirfairelinux.com>,
 Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH v2 4/4] drm: panel: jd9365da: Add DCLTek 300250 9.35in display
Date: Wed, 22 Jul 2026 13:38:40 -0400
Message-Id: <20260722173840.3576444-5-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722173840.3576444-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20260722173840.3576444-1-marc-olivier.champagne@savoirfairelinux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 23 Jul 2026 07:07:31 +0000
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

The DCLTek dt300250 is a LCD panel using the jd9365da controller.
Add the panel to the driver.

Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 246 ++++++++++++++++++
 1 file changed, 246 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/g=
pu/drm/panel/panel-jadard-jd9365da-h3.c
index a9183baa421a..5202c1ffc6e1 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2931,6 +2931,248 @@ static const struct jadard_panel_desc waveshare_1=
0_1_inch_b_desc =3D {
 		MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
 };
=20
+static int dcltek_dt300250_init_cmds(struct jadard *jadard)
+{
+	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi };
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+	jadard_enable_standard_cmds(&dsi_ctx);
+
+	jd9365da_switch_page(&dsi_ctx, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x2B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x74);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0xCF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0xCF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0xFE);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x5C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0xFF);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0xC8);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x66);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x8D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x59, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5A, 0x29);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x1A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x3E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x3B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x3C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x5D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x4D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x3D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x37);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x70, 0x7F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x71, 0x65);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x72, 0x53);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x73, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x74, 0x3E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x75, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x76, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x77, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x78, 0x3B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x79, 0x3C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7A, 0x3F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7B, 0x5D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7C, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7D, 0x4D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7E, 0x3D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x7F, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x80, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x81, 0x15);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x82, 0x00);
+
+	jd9365da_switch_page(&dsi_ctx, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x41);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x01, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x03, 0x4B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x04, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x05, 0x5C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x06, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x07, 0x49);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x08, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x5A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0A, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0B, 0x47);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0C, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0D, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0E, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0F, 0x45);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x10, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x11, 0x4D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x12, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x13, 0x5E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x14, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x17, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x18, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x19, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1A, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1B, 0x5B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1C, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1D, 0x48);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1E, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x1F, 0x59);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x20, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x21, 0x46);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x22, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x23, 0x4E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x24, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x25, 0x44);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x26, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x27, 0x4C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x28, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x29, 0x5E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2A, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2B, 0x5F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2C, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2D, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2E, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2F, 0x0C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x30, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x31, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x32, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x33, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x34, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x35, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x36, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x19);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x38, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x39, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3A, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3B, 0x1B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3C, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3D, 0x0A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3E, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x3F, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x40, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x41, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x42, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x43, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x44, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x45, 0x0D);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x46, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x47, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x48, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x49, 0x0F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4A, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4B, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4C, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4D, 0x1A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4E, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x4F, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x50, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x51, 0x1C);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x52, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x53, 0x0B);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x54, 0x1E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x55, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x56, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x57, 0x1F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x58, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5B, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5C, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5D, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5E, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x5F, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x60, 0x70);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x61, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x62, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x63, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x64, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x65, 0x56);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x66, 0x4F);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x67, 0xF7);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x68, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x69, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6A, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6B, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6C, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6D, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6E, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x6F, 0x88);
+
+	jd9365da_switch_page(&dsi_ctx, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x00, 0x0E);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x02, 0xB3);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x09, 0x60);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x0e, 0x4A);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x37, 0x58);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x2b, 0x0F);
+
+	jd9365da_switch_page(&dsi_ctx, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x15, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0x16, 0x76);
+
+	jd9365da_switch_page(&dsi_ctx, 0x00);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_exit_sleep_mode_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 120);
+
+	mipi_dsi_dcs_set_display_on_multi(&dsi_ctx);
+
+	mipi_dsi_msleep(&dsi_ctx, 20);
+
+	mipi_dsi_dcs_set_tear_on_multi(&dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK)=
;
+
+	return dsi_ctx.accum_err;
+}
+
+static const struct jadard_panel_desc dcltek_dt300250_desc =3D {
+	.mode_4ln =3D &(const struct drm_display_mode) {
+		.clock		=3D (600 + 48 + 32 + 80) * (1600 + 18 + 6 + 23) * 60 / 1000,
+
+		.hdisplay	=3D 600,
+		.hsync_start	=3D 600 + 48,
+		.hsync_end	=3D 600 + 48 + 32,
+		.htotal		=3D 600 + 48 + 32 + 80,
+
+		.vdisplay	=3D 1600,
+		.vsync_start	=3D 1600 + 18,
+		.vsync_end	=3D 1600 + 18 + 6,
+		.vtotal		=3D 1600 + 18 + 6 + 23,
+
+		.width_mm	=3D 83,
+		.height_mm	=3D 221,
+		.type		=3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+	},
+	.lanes =3D 4,
+	.format =3D MIPI_DSI_FMT_RGB888,
+	.init =3D dcltek_dt300250_init_cmds,
+};
+
 static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 {
 	struct device *dev =3D &dsi->dev;
@@ -3037,6 +3279,10 @@ static const struct of_device_id jadard_of_match[]=
 =3D {
 		.compatible =3D "chongzhou,cz101b4001",
 		.data =3D &cz101b4001_desc
 	},
+	{
+		.compatible =3D "dcltek,dt300250",
+		.data =3D &dcltek_dt300250_desc
+	},
 	{
 		.compatible =3D "kingdisplay,kd101ne3-40ti",
 		.data =3D &kingdisplay_kd101ne3_40ti_desc
--=20
2.34.1

