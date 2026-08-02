Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F612C55162
	for <dri-devel@archiver.kernel.org>; Sun,  2 Aug 2026 22:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA7F10E469;
	Sun,  2 Aug 2026 22:41:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=humanlearning.ch header.i=@humanlearning.ch header.b="HnfVTHok";
	dkim-atps=neutral
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch
 [83.166.143.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F28F10E2A4
 for <dri-devel@lists.freedesktop.org>; Sun,  2 Aug 2026 14:00:22 +0000 (UTC)
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch
 [10.4.36.107])
 by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hCh6V1KWnz9x0;
 Sun,  2 Aug 2026 15:51:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=humanlearning.ch;
 s=20250828; t=1785678673;
 bh=o92P7F2EnB1nqviK68TQink9VVnTVZAei/XO4/eSimw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HnfVTHokDIKQOFebFbWR4gKHk0wU+IwlTmmSqIWdxmzZtjfNM0TSsusI3K2Y8VvPX
 sUwuLJ6xmCNnAZbxTp03AukNENhX5ZbrYL3jGvxs21uW8KpA+skask5cELFZMGkv9j
 vs5HJALP6a06s2UmALHqyJqiYH8NOW3mHxLneBd0P/snTRA+4y+ibefWBHExQzLHaA
 obtvWuemfEl5FSfIznBvz19Z7T38IcQZc6maWBT5B98CzCKvBNJwGyu3bAVecZyERW
 NVVELrL3SoDon8HuRFfuTTJ1bXyCsjwxRX0koUlnog2VlpdLu5Y34Qxl0qWdLPhWAg
 TNEgPdaEZhuIg==
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hCh6S66f8zk5t; Sun,  2 Aug 2026 15:51:12 +0200 (CEST)
From: =?UTF-8?q?Fran=C3=A7ois=20Roux?= <info@humanlearning.ch>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Fran=C3=A7ois=20Roux?= <info@humanlearning.ch>
Subject: [PATCH v2] drm/panel-edp: Add Sharp LQ120P1JX51 (Surface Pro 12in 1st
 Ed.)
Date: Sun,  2 Aug 2026 15:50:50 +0200
Message-ID: <20260802135107.4420-1-info@humanlearning.ch>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731115127.15140-1-info@humanlearning.ch>
References: <20260731115127.15140-1-info@humanlearning.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Sun, 02 Aug 2026 22:41:01 +0000
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

The internal eDP panel of the Microsoft Surface Pro 12in 1st Edition
(Snapdragon X Plus, X1P42100) is not in edp_panels[], so every boot
produces the deliberate WARN_ON splat in panel_edp_probe() and the panel
falls back to conservative timings:

  WARNING: drivers/gpu/drm/panel/panel-edp.c:814 panel_edp_probe+0x53c/0x56c
  panel-simple-dp-aux aux-aea0000.displayport-controller:
      Unknown panel SHP 0x15a7, using conservative timings

EDID, read over the panel's DP AUX DDC bus:

  00 ff ff ff ff ff ff 00 4d 10 a7 15 a0 00 00 1f
  31 22 01 04 a5 19 11 78 07 ee 91 a3 54 4c 99 26
  0f 50 54 00 00 00 01 01 01 01 01 01 01 01 01 01
  01 01 01 01 01 01 62 53 94 a0 80 b8 2e 50 18 10
  3a 00 fe a9 00 00 00 18 13 7d 94 a0 80 b8 2e 50
  18 10 3a 00 fe a9 00 00 00 18 00 00 00 fd 00 18
  5a 88 88 21 01 00 00 00 00 00 00 00 00 00 00 fc
  00 4c 51 31 32 30 50 31 4a 58 35 31 0a 20 00 69

  Manufacturer: SHP
  Model: 0x15a7
  Made in: week 49 of 2024
  Display Product Name: 'LQ120P1JX51'
  DTD 1: 2196x1464 60.001799 Hz 3:2 (254 mm x 169 mm)
  DTD 2: 2196x1464 90.002698 Hz 3:2 (254 mm x 169 mm)

Timings are deliberately cautious rather than datasheet-derived. The
conservative fallback sets unprepare=2000 and enable=200; unprepare=2000
is a safety margin for unknown panels only and is the single occurrence
of that value in the file -- no real panel entry uses it.
delay_200_500_e200 keeps the same generous 200 ms enable delay while
using the 500 ms unprepare shared by every actual panel in the table. A
shorter enable delay may well be fine, but has not been validated here.

Signed-off-by: François Roux <info@humanlearning.ch>
---
Changes in v2:
- Read the EDID over the panel's DP AUX DDC bus and included it in the
  commit message, as requested. My v1 claim that the EDID was not
  obtainable was wrong: the connector does not export it
  (/sys/class/drm/card0-eDP-1/edid is 0 bytes) and
  CONFIG_DRM_DP_AUX_CHARDEV no longer exists, but the AUX bus is
  registered as an i2c adapter, so a plain DDC read works:
      i2ctransfer -y <bus> w1@0x50 0x00 r128
  (i2cdump in byte mode does not: it drops a header byte and yields a
  block with a bad checksum.)
- The EDID carries a Display Product Name, so the entry is now
  "LQ120P1JX51" instead of "Unknown".
- Timings unchanged (delay_200_500_e200).
- Now sent under my real name, as you asked. v1 went out as
  "franzelverbier"; same person, same address.

 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 13ce277d7..4defef820 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2145,6 +2145,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x15a7, &delay_200_500_e200, "LQ120P1JX51"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0009, &delay_200_500_e250, "116QHD024002"),
