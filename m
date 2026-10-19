Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8836080ABB
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XU3x6L6;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4NvBHrrM;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2XU3x6L6;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4NvBHrrM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1412210EEB6;
	Mon, 19 Oct 2026 15:47:38 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48ACE10EE9A;
 Mon, 19 Oct 2026 15:47:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5E3CA21CE8;
 Mon, 19 Oct 2026 15:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792424779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACxUqLchSDqFg79x5G7fXNVlcAc+CFu7MScJYvXaE5o=;
 b=2XU3x6L6wBsU9NTbPA20qzM4oAIcmU1jEnkXXLxlw4eGwebjQAmogVJ3ddUNm73wyt+rks
 h3AxFHBGJLiXdCnCqm78+eITs8Y3N/WaNa1ZNDuE/fGgXmVRMo9unazeLPWLE5OKFt2gY3
 i8YTNDN8SdRqVVNmYrC0VYpYepfKX8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792424779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACxUqLchSDqFg79x5G7fXNVlcAc+CFu7MScJYvXaE5o=;
 b=4NvBHrrMFq6p1xAns53IfLiWRU4tZ0BqyrsNX1ZJfrmAOkcHHKHkBDktCj2h/38qqdziLv
 l7vtaRVWuMNQIrBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1792424779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACxUqLchSDqFg79x5G7fXNVlcAc+CFu7MScJYvXaE5o=;
 b=2XU3x6L6wBsU9NTbPA20qzM4oAIcmU1jEnkXXLxlw4eGwebjQAmogVJ3ddUNm73wyt+rks
 h3AxFHBGJLiXdCnCqm78+eITs8Y3N/WaNa1ZNDuE/fGgXmVRMo9unazeLPWLE5OKFt2gY3
 i8YTNDN8SdRqVVNmYrC0VYpYepfKX8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1792424779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ACxUqLchSDqFg79x5G7fXNVlcAc+CFu7MScJYvXaE5o=;
 b=4NvBHrrMFq6p1xAns53IfLiWRU4tZ0BqyrsNX1ZJfrmAOkcHHKHkBDktCj2h/38qqdziLv
 l7vtaRVWuMNQIrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBDAA137D4;
 Mon, 19 Oct 2026 15:46:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gYPgBkk71mrrPAAAD6G6ig:T5
 (envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 15:46:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 nouveau@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 virtualization@lists.linux.dev, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/4] drm/pixel: Link draw helpers into drm_pixel_helper.ko
Date: Mon, 19 Oct 2026 17:32:45 +0200
Message-ID: <20261019154612.777074-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019154612.777074-1-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWELVE(0.00)[16]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Move drm_draw.o from the DRM core to drm_pixel_helper.ko. Remove the
Kconfig option DRM_DRAW and provide the draw helpers unconditionally.

Having draw code in the DRM core is a left-over fro when panic handling
was entirely located in the DRM core as well. With all the panic drawing
in drm_pixel_helper.ko, the drawing helpers can go there as well. DRM's
log clients also uses the drawing helpers for output. Update the Kconfig
rules to select DRM_PIXEL_HELPER instead of DRM_DRAW for this client.

The format and the draw helpers share the per-pixel color-format code
from drm_format_internal. Putting it all into one place will hopefully
help with sharing more code in the future.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/Kconfig                           | 5 -----
 drivers/gpu/drm/Makefile                          | 2 +-
 drivers/gpu/drm/clients/Kconfig                   | 2 +-
 drivers/gpu/drm/{drm_draw.c => drm_draw_helper.c} | 0
 4 files changed, 2 insertions(+), 7 deletions(-)
 rename drivers/gpu/drm/{drm_draw.c => drm_draw_helper.c} (100%)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index bf7c59944340..1b16e6101a53 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -52,15 +52,10 @@ config DRM_KMS_HELPER
 config DRM_PIXEL_HELPER
 	tristate
 	depends on DRM
-	select DRM_DRAW if DRM_PANIC
 	select FONT_SUPPORT if DRM_PANIC
 	help
 	  Helpers for working with pixel data in DRM.
 
-config DRM_DRAW
-	bool
-	depends on DRM
-
 config DRM_PANIC
 	bool "Display a user-friendly message when a kernel panic occurs"
 	depends on DRM && PRINTK
diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
index 18a5a5baf029..ab9eb4c21264 100644
--- a/drivers/gpu/drm/Makefile
+++ b/drivers/gpu/drm/Makefile
@@ -91,7 +91,6 @@ drm-$(CONFIG_DRM_PRIVACY_SCREEN) += \
 	drm_privacy_screen_x86.o
 drm-$(CONFIG_DRM_ACCEL) += ../../accel/drm_accel.o
 drm-$(CONFIG_DRM_PANIC) += drm_panic.o
-drm-$(CONFIG_DRM_DRAW) += drm_draw.o
 drm-$(CONFIG_DRM_RAS) += drm_ras.o drm_ras_nl.o drm_ras_genl_family.o
 obj-$(CONFIG_DRM)	+= drm.o
 
@@ -100,6 +99,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) += drm_panel_orientation_quirks.o
 obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) += drm_panel_backlight_quirks.o
 
 drm_pixel_helper-y := \
+	drm_draw_helper.o \
 	drm_format_helper.o \
 	drm_pixel_helper_common.o
 drm_pixel_helper-$(CONFIG_DRM_PANIC) += drm_panic_helper.o
diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 6096c623d9d5..8d21edc4cc5b 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -3,6 +3,7 @@
 config DRM_CLIENT_LIB
 	tristate
 	depends on DRM
+	select DRM_PIXEL_HELPER if DRM_CLIENT_LOG
 	select DRM_KMS_HELPER if DRM_FBDEV_EMULATION
 	select FB_CORE if DRM_FBDEV_EMULATION
 	help
@@ -76,7 +77,6 @@ config DRM_CLIENT_LOG
 	depends on DRM_CLIENT_SELECTION
 	select DRM_CLIENT
 	select DRM_CLIENT_SETUP
-	select DRM_DRAW
 	select FONT_SUPPORT
 	help
 	  This enable a drm logger, that will print the kernel messages to the
diff --git a/drivers/gpu/drm/drm_draw.c b/drivers/gpu/drm/drm_draw_helper.c
similarity index 100%
rename from drivers/gpu/drm/drm_draw.c
rename to drivers/gpu/drm/drm_draw_helper.c
-- 
2.56.0

