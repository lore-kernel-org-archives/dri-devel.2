Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811B0F327BC
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:48:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C05A310E195;
	Tue, 21 Apr 2026 07:48:39 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 235A710E195
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:48:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 19B3B60018;
 Tue, 21 Apr 2026 07:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC1AC2BCB0;
 Tue, 21 Apr 2026 07:48:34 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Thomas Zimmermann <tzimmermann@suse.de>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/color-mgmt: Typo s/R332/RGB332/
Date: Tue, 21 Apr 2026 09:48:32 +0200
Message-ID: <c413e45c8f752a532a4ff377f7a8b9eaab4a082a.1776757681.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Fix a typo of "RGB332" in kerneldoc for the drm_crtc_fill_palette_332()
helper.

Fixes: 7ff61177b7116825 ("drm/color-mgmt: Prepare for RGB332 palettes")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/gpu/drm/drm_color_mgmt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_color_mgmt.c b/drivers/gpu/drm/drm_color_mgmt.c
index c598b99673fc1515..e7db4e4ea700fe11 100644
--- a/drivers/gpu/drm/drm_color_mgmt.c
+++ b/drivers/gpu/drm/drm_color_mgmt.c
@@ -831,7 +831,7 @@ static void fill_palette_332(struct drm_crtc *crtc, u16 r, u16 g, u16 b,
 }
 
 /**
- * drm_crtc_fill_palette_332 - Programs a default palette for R332-like formats
+ * drm_crtc_fill_palette_332 - Programs a default palette for RGB332-like formats
  * @crtc: The displaying CRTC
  * @set_palette: Callback for programming the hardware gamma LUT
  *
-- 
2.43.0

