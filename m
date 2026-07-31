Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76734C55175
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 07:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F6E310E2C3;
	Sat,  1 Aug 2026 07:58:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=humanlearning.ch header.i=@humanlearning.ch header.b="gt2nED50";
	dkim-atps=neutral
X-Greylist: delayed 633 seconds by postgrey-1.36 at gabe;
 Fri, 31 Jul 2026 12:11:08 UTC
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [83.166.143.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8150C10F23D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 12:11:08 +0000 (UTC)
Received: from smtp-4-0000.mail.infomaniak.ch (unknown
 [IPv6:2001:1600:7:10::a6b])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4hBPb56BzGzSVq;
 Fri, 31 Jul 2026 13:53:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=humanlearning.ch;
 s=20250828; t=1785498785;
 bh=mcYTy2HUkE85PNUNK6bLabAB0KpvYXZIPEVAc6pR1e8=;
 h=From:To:Cc:Subject:Date:From;
 b=gt2nED504Ah3cNcBxmi1Hz8lA5luWOO53pcg+n8XaVK82TRcNXW+M9C9phW9FY4Au
 HtKdnZJ7WpL9A+Eh8C9DYl0YFyGf5wedqURMLapSvwTsUUSMxtPkt+d242AKctNvGM
 rvTy4BxFcX5bkDCfQGLnOSwD6TorqnC3Nz9mO44IyoLSDfKLG58DnuezUoshwt5agY
 UrMKLKhcgQOD0nvxS+lde16OoCeuvu4djtE5kk60c7KI9KTD7Hv2QGA/Aqq+vVqpbv
 cTkauMJCiaFohyByIHbtFfqHrVxjM9vRaChUs0WzCdRgq0JLijRx57Y9h7vdpFIxD7
 t9kcvgEBD7BSA==
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4hBPb46rWBzKjV; Fri, 31 Jul 2026 13:53:04 +0200 (CEST)
From: franzelverbier <info@humanlearning.ch>
To: Douglas Anderson <dianders@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jessica Zhang <jesszhan0024@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, franzelverbier <info@humanlearning.ch>
Subject: [PATCH] drm/panel-edp: Add Sharp SHP 0x15a7 (Surface Pro 12in 1st Ed.)
Date: Fri, 31 Jul 2026 13:52:53 +0200
Message-ID: <20260731115253.15234-1-info@humanlearning.ch>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Sat, 01 Aug 2026 07:57:53 +0000
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

The exact model string is not known: the device tree uses the generic
"edp-panel" compatible and the driver does not expose the EDID it reads,
so the entry is named "Unknown" as is done for 32 other entries.

Timings are deliberately cautious rather than datasheet-derived. The
conservative fallback sets unprepare=2000 and enable=200; unprepare=2000
is a safety margin for unknown panels only and is the single occurrence
of that value in the file -- no real panel entry uses it.
delay_200_500_e200 keeps the same generous 200 ms enable delay while
using the 500 ms unprepare shared by every actual panel in the table. A
shorter enable delay may well be fine, but has not been validated here.

Signed-off-by: franzelverbier <info@humanlearning.ch>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 13ce277d7..3cc7d916a 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2145,6 +2145,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x154c, &delay_200_500_p2e100, "LQ116M1JW10"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x158f, &delay_200_500_p2e100, "LQ134Z1"),
 	EDP_PANEL_ENTRY('S', 'H', 'P', 0x1593, &delay_200_500_p2e100, "LQ134N1"),
+	EDP_PANEL_ENTRY('S', 'H', 'P', 0x15a7, &delay_200_500_e200, "Unknown"),
 
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0004, &delay_200_500_e200, "116KHD024006"),
 	EDP_PANEL_ENTRY('S', 'T', 'A', 0x0009, &delay_200_500_e250, "116QHD024002"),
