Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5163ACD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 07:42:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4666C10E6E6;
	Mon, 18 May 2026 07:41:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mariushoch.de header.i=@mariushoch.de header.b="t/GjFmdY";
	dkim-atps=neutral
X-Greylist: delayed 309 seconds by postgrey-1.36 at gabe;
 Sun, 17 May 2026 19:36:27 UTC
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A37689DC0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 19:36:27 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org
 [IPv6:2001:67c:2050:b231:465::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4gJWJL4k6Jz9vMJ;
 Sun, 17 May 2026 21:31:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mariushoch.de;
 s=MBO0001; t=1779046274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HtBGrCSyW2NnOwZk7qn0QEVN8bg/qGhu9x0TQGAPFWg=;
 b=t/GjFmdYeZY4av9rmEaIlmWesE/3j/2luN3vTpUoua1hGMTIypl0FMyrinyaO61fiAf/t8
 /5L7gVR91A3UxNAyr24tJpr2euAzacGK4KiceUzIGnFHB0EffcghDabQNyyA/1kgfwbZjZ
 AbbGTN3Iw0/D/KTPvZDn7f1PLBquPSN47p3pQUqZfIEPjWD7pIJzlG8hR2NSYJw//RKpzn
 WtR6GJXiaexYHzh71nZIeu2fldf6ukjuAYMfpCnA/AH5m/dp0oVuHyNcNC3LVhw4y6TMnL
 IpU5mbBxtijCGXnZGH/np7N5M4UTFhJZLgEmQ1qanwUF2KlwzMeSx68Hkef5og==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of mail@mariushoch.de designates
 2001:67c:2050:b231:465::1 as permitted sender)
 smtp.mailfrom=mail@mariushoch.de
From: Marius Hoch <mail@mariushoch.de>
To: linux-kernel@vger.kernel.org
Cc: Marius Hoch <mail@mariushoch.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH] drm: panel-orientation-quirks: Cover IdeaPad Duet 3 10IGL5-LTE
Date: Sun, 17 May 2026 21:29:15 +0200
Message-ID: <20260517193001.1741134-1-mail@mariushoch.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4gJWJL4k6Jz9vMJ
X-Mailman-Approved-At: Mon, 18 May 2026 07:41:36 +0000
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

The LTE enabled version of the IdeaPad Duet 3 10IGL5 needs the
same quirk as the non-LTE version. As these are the only two
IdeaPad Duet 3 10IGL5 versions, we can safely use non exact matching.

Tested on an IdeaPad Duet 3 10IGL5-LTE.

Signed-off-by: Marius Hoch <mail@mariushoch.de>
---
 drivers/gpu/drm/drm_panel_orientation_quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel_orientation_quirks.c b/drivers/gpu/drm/drm_panel_orientation_quirks.c
index 3a218fb592ce..b62f19af4642 100644
--- a/drivers/gpu/drm/drm_panel_orientation_quirks.c
+++ b/drivers/gpu/drm/drm_panel_orientation_quirks.c
@@ -415,10 +415,11 @@ static const struct dmi_system_id orientation_data[] = {
 		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "Lenovo ideapad D330-10IGL"),
 		},
 		.driver_data = (void *)&lcd800x1280_rightside_up,
-	}, {	/* Lenovo IdeaPad Duet 3 10IGL5 */
+	}, {	/* Lenovo IdeaPad Duet 3 10IGL5 and 10IGL5-LTE */
 		.matches = {
 		  DMI_EXACT_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-		  DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
+		  /* Non exact match to also match the LTE version */
+		  DMI_MATCH(DMI_PRODUCT_VERSION, "IdeaPad Duet 3 10IGL5"),
 		},
 		.driver_data = (void *)&lcd1200x1920_rightside_up,
 	}, {	/* Lenovo Legion Go 8APU1 */
-- 
2.54.0

