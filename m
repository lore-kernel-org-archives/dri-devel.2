Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FD6606A31C
	for <dri-devel@archiver.kernel.org>; Sun,  8 Nov 2026 21:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=KBSlOmhZ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=l2uqiUZ6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EED2D10E0B8;
	Sun,  8 Nov 2026 21:52:58 +0000 (UTC)
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082DD10E0B8
 for <dri-devel@lists.freedesktop.org>; Sun,  8 Nov 2026 21:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1794174751; bh=ldyjCjRZaJMZqLlHkHwwP3p
 Nt4BYTwknpDL4CbSPepU=; b=KBSlOmhZHO4IvV7zDJh+7TdaZEPp4ktdEGhBUARU3KYOR8W/xA
 08TdHoO/CZuB+T08vxVRrMvNVvma010MxZyrprz/tyOe2COTiXieoIqT5rj/xpI04StZMu2RQ2q
 s2SZbiPj0PK9TSDncuJOj0KG1taxXYCu+H+sLHV24PJa5h7LWweOVOddT4IVihegqd6RyJtYwXs
 +N9pTr56uwpknq+GLDWgUChydUz/SoOU1b1/t4AnfWsmBDv0srWJUvUyHnimKb3cn6Qi9JF6iTA
 2YhjO38yj7iXnu7S7QoRyHj91zcNvlDi1SD+8oDAJ0BPf3HMTSGdLHnq2KgE4PlKltg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1794174751; bh=ldyjCjRZaJMZqLlHkHwwP3p
 Nt4BYTwknpDL4CbSPepU=; b=l2uqiUZ6oD79zJPSbLciQtrJ2sDyB11/MUlsDS6Sp+lboOkAhg
 hNdTVGU5Ti5HlZ6qDCy0Ga69ILkeLeSZgZBQ==;
From: Dang Huynh <dang.huynh@mainlining.org>
Date: Mon, 09 Nov 2026 04:51:43 +0700
Subject: [PATCH v2] drm/panel: boe-bf060y8m-aj0: Correct display pixel
 clock
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-pro1x-display-pixelclock-v2-1-670b1eeed6a9@mainlining.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NzRKCIBRGX8VhHQ2QlrbqPRoXiBe9RcCAOTqO7
 x7UC7Q88/2cjUQICJFci40EmDGiswnEoSBqlHYAin1iIpg4c84a6oPjC+0xeiNX6nEBo4xTT1p
 3jGnWNBehe5LmPoBOab6+tz+O7+4Basp/uTFinFxYv+6Z594fmplTTlXNy+qkZVdBeXtJtAYt2
 uHowkDafd8/t4pjFtcAAAA=
X-Change-ID: 20261109-pro1x-display-pixelclock-8b00f09972fd
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sam Ravnborg <sam@ravnborg.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, Dang Huynh <dang.huynh@mainlining.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794174749; l=1747;
 i=dang.huynh@mainlining.org; s=20250917; h=from:subject:message-id;
 bh=RDBzpND+UCztKO9+6AcOViXnFNhPPCIUlyoaVDr0S1w=;
 b=t3QoydIZm6OYXACMv2ygYsTQW2VAWKOKDNoWBLYGy9VcJr2OQ8WXng1pNUAm5E1eKlKuUbDcR
 KSUlDAIe6ddDRUilo9ZZDSA5X1nVYxoeh43iUcE4Rwx9iJB8tmW7OUI
X-Developer-Key: i=dang.huynh@mainlining.org; a=ed25519;
 pk=RyzH4CL4YU/ItXYUurA51EVBidfx4lIy8/E4EKRJCUk=
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The driver has been using the wrong pixel clock ever since it's
submission.

The panel is 60Hz, but the mainline driver ran at 165268 Hz
which is 61Hz and the following formula can confirm this:
(1080 + 36 + 24 + 96) * (2160 + 16 + 1 + 15) * 61 / 1000

This causes the touchscreen on the F(x)tec Pro1x to show heavy
signs of ghost touches, making the touchscreen unusable for
anything practical.

After the pixel clock is corrected, the touchscreen no longer show
any sign of ghost touches.

Fixes: a19125a28112 ("drm/panel: Add BOE BF060Y8M-AJ0 5.99" AMOLED panel driver")
Signed-off-by: Dang Huynh <dang.huynh@mainlining.org>
---
Changes in v2:
- The mentioned "panel" and "ghost touch" is the display unit on the F(x)tec Pro1x. Whoops!
- Link to v1: https://patch.msgid.link/20261109-pro1x-display-pixelclock-v1-1-c81453fab5e4@mainlining.org
---
 drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
index 84c21c62a43e..b1f428e0808d 100644
--- a/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
+++ b/drivers/gpu/drm/panel/panel-boe-bf060y8m-aj0.c
@@ -168,7 +168,7 @@ static int boe_bf060y8m_aj0_unprepare(struct drm_panel *panel)
 }
 
 static const struct drm_display_mode boe_bf060y8m_aj0_mode = {
-	.clock = 165268,
+	.clock = (1080 + 36 + 24 + 96) * (2160 + 16 + 1 + 15) * 60 / 1000,
 	.hdisplay = 1080,
 	.hsync_start = 1080 + 36,
 	.hsync_end = 1080 + 36 + 24,

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261109-pro1x-display-pixelclock-8b00f09972fd

Best regards,
--  
Dang Huynh <dang.huynh@mainlining.org>
