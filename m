Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B16AEBFD08
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 07:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E42B10E0C5;
	Mon, 13 Apr 2026 07:10:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W/LJEWte";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26CE10E0C5
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:10:50 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 2480D6111B;
 Mon, 13 Apr 2026 07:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F5BC2BCB0;
 Mon, 13 Apr 2026 07:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776064249;
 bh=MNWSsg/88qubx/JUWiradxGijtUKdcc6SPiyStv+qH8=;
 h=From:To:Cc:Subject:Date:From;
 b=W/LJEWteA71mLlBzcJQQgaU9QRzsg7RSsTOllBNugnFl6OAcTyUnc5LOTXkmq2J5S
 k7b3bPM8m0xTQyFV81qVHINqjhqMTwlotCkM6UdrNvWM41g0s8UKN/nQ1Bxag3IrDj
 /LHYvqghaoTfN1UtGJTwUFns4ZTIfJjeLjJ+5WrDN7Q6WpjaFByLU1grKwBGKZp9V6
 QnuRmZxvyg4sPk8JGMenGEMFpqNP5PXQ7OTaeq2eP03s1XsIHQwzqEFW+1O1cLT2pr
 9En/X16eZRkoB8YzY7tun2Wq5fKY7gEMuZjbiz4hK9UnOtZVK05ViPf0mRWWWwUwCt
 G5DP2CIr+d34Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Pengyu Luo <mitltlatltl@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Jessica Zhang <jesszhan0024@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, David Heidelberg <david@ixit.cz>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: hx83121a: select DRM_DISPLAY_DSC_HELPER
Date: Mon, 13 Apr 2026 09:10:19 +0200
Message-Id: <20260413071043.3829868-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

Like a number of other panel drivers, this newly merged driver
needs DRM_DISPLAY_DSC_HELPER to be enabled:

arm-linux-gnueabi-ld: drivers/gpu/drm/panel/panel-himax-hx83121a.o: in function `himax_prepare':
panel-himax-hx83121a.c:(.text+0x1024): undefined reference to `drm_dsc_pps_payload_pack'

Fixes: a7c61963b727 ("drm/panel: Add Himax HX83121A panel driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index cc8c8a066bb9..ce6098c0343a 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -208,6 +208,7 @@ config DRM_PANEL_HIMAX_HX83121A
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
 	select DRM_KMS_HELPER
 	help
 	  Say Y here if you want to enable support for Himax HX83121A-based
-- 
2.39.5

