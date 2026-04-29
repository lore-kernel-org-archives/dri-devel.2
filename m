Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27885CD3424
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 07:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CCA910F268;
	Thu, 30 Apr 2026 07:38:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=wp.pl header.i=@wp.pl header.b="JHtPYgh1";
	dkim-atps=neutral
X-Greylist: delayed 398 seconds by postgrey-1.36 at gabe;
 Wed, 29 Apr 2026 14:59:50 UTC
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCFF510E3D2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 14:59:50 +0000 (UTC)
Received: (wp-smtpd smtp.wp.pl 12595 invoked from network);
 29 Apr 2026 16:53:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
 t=1777474389; bh=2EzLsK3dPdwQhRqtgs1uQhBX7/rO+UXVSA0tgiKAW+o=;
 h=From:To:Cc:Subject;
 b=JHtPYgh1MlDjCXYn190Tbn9TSHTjqBI+dLtSyA1EAMun+KnAWbO+4fcomlbdI8Vgd
 hsLsuMLos6R8/O/i1IlQBA5j2VxCHq4MbJ72qhnMlP6p64EPAJNPxNRlpi5r6MZVZE
 cqpmXpvzROncxCn5UGLVapRteibqNB+PWObGI7hamDtuCA/QYwCIEH6eh+Y4K/ft1O
 y8rfFKq30unYi31igmEt7+tSAiOpntXU5ByOb+4jVkroA1LahMUkD8FWMnKbBU42DN
 xSeAjNLhPgFoala23XmCAtvJ6gXG+dZ3LnRGs/XdBD/p436Q/vGqFsznFMvekbkYv1
 rldRjzwpx1uOQ==
Received: from host18560247242.static.ssm.silesia.pl (HELO
 ad-Inspiron-14-5441) (adamszyma@wp.pl@[185.60.247.242])
 (envelope-sender <adamszyma@wp.pl>)
 by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
 for <dri-devel@lists.freedesktop.org>; 29 Apr 2026 16:53:09 +0200
From: Adam Szyma <adamszyma@wp.pl>
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adam Szyma <adamszyma@wp.pl>
Subject: [PATCH] drm/panel/panel-edp: Add CSOT MPP36 T9 eDP panel
Date: Wed, 29 Apr 2026 16:52:51 +0200
Message-ID: <20260429145251.8445-1-adamszyma@wp.pl>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl) 
X-WP-MailID: 52877e715a37717fcd09a35489c6c1be
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [YVPN]                               
X-Mailman-Approved-At: Thu, 30 Apr 2026 07:37:56 +0000
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

Add support for the CSOT MPP36 T9 eDP panel (manufacturer ID: CSW,
product ID: 0x143d) used in the Dell Inspiron 14 Plus 5441 laptop.

Without this entry the kernel logs:
  panel-simple-dp-aux: Unknown panel CSW 0x143d, using conservative timings

and brightness control is non-functional on affected devices.

Tested-by: Adam Szyma <adamszyma@wp.pl>
Signed-off-by: Adam Szyma <adamszyma@wp.pl>
---
 drivers/gpu/drm/panel/panel-edp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f3cdaea89..0d0072f29 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -2073,6 +2073,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1103, &delay_200_500_e80_d50, "MNB601LS1-3"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1104, &delay_200_500_e50_d100, "MNB601LS1-4"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x110a, &delay_200_500_e50, "PNB601LS1-2"),
+	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143d, &delay_200_500_e50, "MPP36 CSOT T9"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x143f, &delay_200_500_e50, "MNE007QS3-6"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x1448, &delay_200_500_e50, "MNE007QS3-7"),
 	EDP_PANEL_ENTRY('C', 'S', 'W', 0x144b, &delay_200_500_e80, "MNE001BS1-4"),
-- 
2.53.0

