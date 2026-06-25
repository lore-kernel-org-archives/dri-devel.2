Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 895DFCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1C8110E18C;
	Thu, 25 Jun 2026 06:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="O5MthQ/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vWJhHJIl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O5MthQ/h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vWJhHJIl";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD94810E18C
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:57:29 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4ECFC6D657;
 Thu, 25 Jun 2026 06:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782370648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kuy+DjRoMpZxnjvh50ZtLtAigTPF82vLQB0yflVfNk=;
 b=O5MthQ/hwI3FAL6lCyZmLo5PlIDzyy1mSb9KUzjkX4qy2j3QZAFz4WP4lvj4Bcyse1WsGv
 LK/XQNDdQBMlaZx0eKPPMQplBjndo7uYxPvkqXAxpmJ3QkXHPo+ExD4BRtCGGjsw1/6a29
 7u/agUw2Xw1daKUYQ1Tbm3r1eBJ73lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782370648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kuy+DjRoMpZxnjvh50ZtLtAigTPF82vLQB0yflVfNk=;
 b=vWJhHJIlbi+oiyMZ58vd6qsWP32XivbeI3sPEagxHEQX38Mih0Zn4pJD/RQNdWq6VWIN0I
 LA2goXr1AAgAn8CA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="O5MthQ/h";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vWJhHJIl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782370648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kuy+DjRoMpZxnjvh50ZtLtAigTPF82vLQB0yflVfNk=;
 b=O5MthQ/hwI3FAL6lCyZmLo5PlIDzyy1mSb9KUzjkX4qy2j3QZAFz4WP4lvj4Bcyse1WsGv
 LK/XQNDdQBMlaZx0eKPPMQplBjndo7uYxPvkqXAxpmJ3QkXHPo+ExD4BRtCGGjsw1/6a29
 7u/agUw2Xw1daKUYQ1Tbm3r1eBJ73lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782370648;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6Kuy+DjRoMpZxnjvh50ZtLtAigTPF82vLQB0yflVfNk=;
 b=vWJhHJIlbi+oiyMZ58vd6qsWP32XivbeI3sPEagxHEQX38Mih0Zn4pJD/RQNdWq6VWIN0I
 LA2goXr1AAgAn8CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 13400779A8;
 Thu, 25 Jun 2026 06:57:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lTB+A1jRPGo1YgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 06:57:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, julianbraha@gmail.com, sima@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
Date: Thu, 25 Jun 2026 08:57:04 +0200
Message-ID: <20260625065724.15794-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 RCPT_COUNT_SEVEN(0.00)[9];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4ECFC6D657
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

Mark CONFIG_SYSFB_SIMPLEFB as deprecated. Enabling it allows to
run simpledrm and simplefb on EFI/VESA framebuffers. Doing this
is discouraged in favor of using efidrm and vesadrm.

v2:
- resolve conflicting help texts (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
---
 drivers/firmware/Kconfig      | 32 ++++++++++----------------------
 drivers/gpu/drm/sysfb/Kconfig |  7 ++-----
 2 files changed, 12 insertions(+), 27 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..637e3bb5549e 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -184,32 +184,20 @@ config SYSFB
 	select SCREEN_INFO
 
 config SYSFB_SIMPLEFB
-	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"
 	depends on X86 || EFI
 	select SYSFB
 	help
-	  Firmwares often provide initial graphics framebuffers so the BIOS,
+	  Firmware often provides initial graphics framebuffers so the BIOS,
 	  bootloader or kernel can show basic video-output during boot for
-	  user-guidance and debugging. Historically, x86 used the VESA BIOS
-	  Extensions and EFI-framebuffers for this, which are mostly limited
-	  to x86 BIOS or EFI systems.
-	  This option, if enabled, marks VGA/VBE/EFI framebuffers as generic
-	  framebuffers so the new generic system-framebuffer drivers can be
-	  used instead. If the framebuffer is not compatible with the generic
-	  modes, it is advertised as fallback platform framebuffer so legacy
-	  drivers like efifb, vesafb and uvesafb can pick it up.
-	  If this option is not selected, all system framebuffers are always
-	  marked as fallback platform framebuffers as usual.
-
-	  Note: Legacy fbdev drivers, including vesafb, efifb, uvesafb, will
-	  not be able to pick up generic system framebuffers if this option
-	  is selected. You are highly encouraged to enable simplefb as
-	  replacement if you select this option. simplefb can correctly deal
-	  with generic system framebuffers. But you should still keep vesafb
-	  and others enabled as fallback if a system framebuffer is
-	  incompatible with simplefb.
-
-	  If unsure, say Y.
+	  user-guidance and debugging.
+
+	  This option, if enabled, marks VBE/EFI framebuffers as system
+	  framebuffers so the generic simpledrm driver can be used.
+
+	  This option is deprecated and will be removed in the near future. If
+	  unsure, say N and select efidrm, vesadrm instead. The dedicated DRM
+	  drivers provide the same functionality plus additional features.
 
 config TH1520_AON_PROTOCOL
 	tristate "Always-On firmware protocol"
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index 2559ead6cf1f..f7e48178885e 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -67,11 +67,8 @@ config DRM_SIMPLEDRM
 
 	  This driver assumes that the display hardware has been initialized
 	  by the firmware or bootloader before the kernel boots. Scanout
-	  buffer, size, and display format must be provided via device tree,
-	  UEFI, VESA, etc.
-
-	  On x86 BIOS or UEFI systems, you should also select SYSFB_SIMPLEFB
-	  to use UEFI and VESA framebuffers.
+	  buffer, size, and display format must be provided via device tree's
+	  simple-framebuffer node.
 
 config DRM_VESADRM
 	tristate "VESA framebuffer driver"
-- 
2.54.0

