Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 213DACA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 11:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8749F10EE4B;
	Tue, 29 Sep 2026 11:48:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FnZiF12G";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC0A10EE4B
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 11:48:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DB07C601FB;
 Tue, 29 Sep 2026 11:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4DC1F000FF;
 Tue, 29 Sep 2026 11:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790682519;
 bh=AonU/AJLf898mqei6BZExmDmc83WdKFP0llY4R7RD1k=;
 h=From:To:Cc:Subject:Date;
 b=FnZiF12GrREr3QxyD6B+1jDs94+Yrir+GbGQfCIcTBCXG3jVr2CvmYK9p63avXJCc
 0VrAqiFwUCRthNR2rj5aGUwjVxPYgKBv7E5pThePRrMpXTYVKydADto4pB5DSeCsmC
 A9sXaQ0hJjfakGJhqpe67xwpEsM8w7NScWtlTNEhb0P5HR88DDkbDAZUwYjCeVrg2A
 nCzGpVe3PW4vQihRzktZqvRvl9CfJduZOzKG4cL4ty7ckc9HwpfTUreBHqqRTuoQLB
 7w/ptJfo8iW/PwBep4xJmDCQUEmQRn0A99KzAo7b1/p8mMvFiyM+MzqCp7jjcSTACx
 pegurF49auRsw==
From: Sasha Levin <sashal@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Sasha Levin <sashal@kernel.org>, "kernelci.org bot" <bot@kernelci.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] drm/panel: select DRM_KMS_HELPER
Date: Tue, 29 Sep 2026 07:48:28 -0400
Message-ID: <20260929114828.3260345-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
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

Since the panel_bridge code moved into drm_panel.c, any config with
DRM built in but without the KMS helpers fails to link, for example
arc haps_hs_smp_defconfig with allnoconfig and the kselftest fragment:

  arc-elf32-ld: drivers/gpu/drm/drm_panel.o:(.rodata+0x28): undefined
  reference to `drm_atomic_helper_bridge_duplicate_state'
  arc-elf32-ld: drivers/gpu/drm/drm_panel.o:(.rodata+0x2c): undefined
  reference to `drm_atomic_helper_bridge_destroy_state'
  ...

With DRM=m, modpost fails the same way:

  ERROR: modpost: drivers/gpu/drm/drm_panel.ko: symbol
  'drm_atomic_helper_bridge_duplicate_state' undefined!

The panel_bridge used to live in bridge/panel.c, which was part of
drm_kms_helper and was therefore only built when DRM_KMS_HELPER was
enabled. drm_panel.c is built for DRM_PANEL instead, which
DRM_PANEL_BRIDGE selects whenever DRM_BRIDGE is set, and DRM_BRIDGE
is enabled for every DRM config. Nothing on that path selects
DRM_KMS_HELPER, so the bridge and connector helpers used by the moved
code can be missing.

The panel_bridge code in drm_panel.c is built unconditionally, so
make DRM_PANEL select DRM_KMS_HELPER.

Reported-by: kernelci.org bot <bot@kernelci.org>
Closes: https://d.kernelci.org/i/maestro:9ed7f4b210fa7c1d3bb109b0fcd62285e98c5b81
Fixes: aa8a8c7e4641 ("drm/bridge: panel: move all code to drm_panel.c")
Assisted-by: LLM
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 0a79a0558101b..53a1fc2913fee 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -2,6 +2,7 @@
 config DRM_PANEL
 	tristate
 	depends on DRM
+	select DRM_KMS_HELPER
 	help
 	  Panel registration and lookup framework.
 
-- 
2.53.0

