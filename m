Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00CADCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614F110EEB1;
	Wed, 17 Jun 2026 08:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="CNeN5JzP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eIJON0xp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="r34xocFn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FF7VjZEP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0650B10EEB1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:18:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 794E46B0B8;
 Wed, 17 Jun 2026 08:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781684296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2TtoswugBtWLTyZu9WCP46btm2WvVd85BjtaTUVZdgY=;
 b=CNeN5JzPh0v6P/cW30YUfXl/HvXu5rsfvjpExaKprxEnfjlGvd+urTV7tTLAdah1UmqPJF
 2sItDL2QbklQyS2ZB9s4z2aAAxBTGVaVbWKTiVaAXP/No+5p2pJCXpwGpo8vjfe7ICEQut
 NY5cA9eprr7hwJ4fnfCZPfWqhQk8YXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781684296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2TtoswugBtWLTyZu9WCP46btm2WvVd85BjtaTUVZdgY=;
 b=eIJON0xp0Wdu/R6Tzv4x6UhPHDtebj2fXMfPHaRf5fz/EQaYmbRBvfXCXmVx1kBeIfeTC1
 6j89rOk/Tw4ZlNBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=r34xocFn;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FF7VjZEP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781684295; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2TtoswugBtWLTyZu9WCP46btm2WvVd85BjtaTUVZdgY=;
 b=r34xocFnSGcBYTku1RSpXjkzP91gF8XReNLbf1hxfrkCnJdry1ETnKzYlqeRjwPuwhegb2
 CC7k1p8wrKTdKo0bQGJ4i0BmW6zVvsvg6XcUoIjbiqqUeBkXnVm5I5NQdkHGwZ6HY1fQYw
 3CnUwvKuuchxDTRZipk6RcVsWvMnanA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781684295;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=2TtoswugBtWLTyZu9WCP46btm2WvVd85BjtaTUVZdgY=;
 b=FF7VjZEPsP0A52Taitc3UsjslK4inCzndqGDW6f/wLswBZ4M7EfChEwAyG6WwgI5TWwcED
 k+fLVIyVXMQNC1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 473D9779A8;
 Wed, 17 Jun 2026 08:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LnguEEdYMmrJIQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 08:18:15 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	sima@ffwll.ch,
	airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as deprecated
Date: Wed, 17 Jun 2026 10:17:29 +0200
Message-ID: <20260617081810.218168-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_TO(0.00)[redhat.com,ffwll.ch,gmail.com];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 794E46B0B8
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

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..b4e705abdc8f 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -184,32 +184,23 @@ config SYSFB
 	select SCREEN_INFO
 
 config SYSFB_SIMPLEFB
-	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"
 	depends on X86 || EFI
 	select SYSFB
 	help
 	  Firmwares often provide initial graphics framebuffers so the BIOS,
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
+	  framebuffers so the generic simpledrm driver can be used. If the
+	  framebuffer is not compatible with the generic modes, it is
+	  advertised as fallback platform framebuffer so regular drivers like
+	  efidrm, vesadrm can pick it up.
+
+	  This option is deprecated and will be removed in the near future. If
+	  unsure, say N and select efidrm, vesadrm instead. The dedicated DRM
+	  drivers provide the same functionality plus additional features.
 
 config TH1520_AON_PROTOCOL
 	tristate "Always-On firmware protocol"
-- 
2.54.0

