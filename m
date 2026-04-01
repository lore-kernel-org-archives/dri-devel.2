Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC11D3515A
	for <dri-devel@archiver.kernel.org>; Wed,  1 Apr 2026 08:32:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6E8A10EB57;
	Wed,  1 Apr 2026 08:32:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="F/JjfJl+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JroWuT3/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TYWNo6GM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NRpqMqRC";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E69C10EB57
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Apr 2026 08:32:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5FB34D282;
 Wed,  1 Apr 2026 08:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775032366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b7DQ7PreTDiaftRhaS42vmUDfpj962j1xAcBJ1gtvTw=;
 b=F/JjfJl+oJn94ACEgNHpAsrTgUNCa8iiuKMwLtEnL8c7W3QZ/jwTBeH77oma1kd+9FsUiE
 0wfKT4dETbtQdbwTbyVcyO7BBOgDlzMfD8ambH4iU2Jh/aR55PtdT7yUobBy63D/r947Or
 Zpwo0YSuifktZY+KV/qAEvxlTj2KCKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775032366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b7DQ7PreTDiaftRhaS42vmUDfpj962j1xAcBJ1gtvTw=;
 b=JroWuT3/nfAmQUeiyYo4Ha0af4Q91ZuJ8vEiBpKQGQkFSR3qcIqr1KqZ1l8WU/a4Ny5M5q
 JsvFdgex8wSRDfCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TYWNo6GM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=NRpqMqRC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775032365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b7DQ7PreTDiaftRhaS42vmUDfpj962j1xAcBJ1gtvTw=;
 b=TYWNo6GM4Rg3Pni9+63CZVEK3EK5QpNqxFUc6vuldkrleAtsXgH+hilOh/CJ+ZZQRRA1Qc
 uK/oFDpVtzydUu6NOGk91u/nnivTQ990pPQDE7kJk3SJqPXzY+iOZ/3voLgd9vDGVZjEnh
 j4EhMM6c6csxKfFGDSz/ovuS6y6zFMk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775032365;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=b7DQ7PreTDiaftRhaS42vmUDfpj962j1xAcBJ1gtvTw=;
 b=NRpqMqRCIQr+yBSsuPxCi7R991qq4bu9jJzsDSSO2IzGv79Ropi5GkFh8+SuEMqyqzCZtZ
 YLaVj2Deg4l1P7Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA8984A0B0;
 Wed,  1 Apr 2026 08:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e4VlKC3YzGndCwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Apr 2026 08:32:45 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de,
 arnd@arndb.de
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] arch/sh: Drop CONFIG_FIRMWARE_EDID from defconfig files
Date: Wed,  1 Apr 2026 10:32:34 +0200
Message-ID: <20260401083242.214492-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.de:mid, suse.de:dkim, suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E5FB34D282
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

CONFIG_FIRMWARE_EDID=y depends on X86 or EFI_GENERIC_STUB. Neither is
true here, so drop the lines from the defconfig files.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/sh/configs/dreamcast_defconfig | 1 -
 arch/sh/configs/hp6xx_defconfig     | 1 -
 arch/sh/configs/se7343_defconfig    | 1 -
 arch/sh/configs/se7780_defconfig    | 1 -
 4 files changed, 4 deletions(-)

diff --git a/arch/sh/configs/dreamcast_defconfig b/arch/sh/configs/dreamcast_defconfig
index dd58797e8298..b31bf17fe112 100644
--- a/arch/sh/configs/dreamcast_defconfig
+++ b/arch/sh/configs/dreamcast_defconfig
@@ -50,7 +50,6 @@ CONFIG_HW_RANDOM=y
 CONFIG_WATCHDOG=y
 CONFIG_SH_WDT=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_PVR2=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_FONTS=y
diff --git a/arch/sh/configs/hp6xx_defconfig b/arch/sh/configs/hp6xx_defconfig
index 04a9fcb4342a..b6116a203a27 100644
--- a/arch/sh/configs/hp6xx_defconfig
+++ b/arch/sh/configs/hp6xx_defconfig
@@ -35,7 +35,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_LEGACY_PTY_COUNT=64
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_HIT=y
 CONFIG_FB_SH_MOBILE_LCDC=y
 CONFIG_FRAMEBUFFER_CONSOLE=y
diff --git a/arch/sh/configs/se7343_defconfig b/arch/sh/configs/se7343_defconfig
index 2d4d1f974f14..b3ce8a502787 100644
--- a/arch/sh/configs/se7343_defconfig
+++ b/arch/sh/configs/se7343_defconfig
@@ -57,7 +57,6 @@ CONFIG_I2C=y
 CONFIG_I2C_SH_MOBILE=y
 # CONFIG_HWMON is not set
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_SH_MOBILE_LCDC=m
 CONFIG_SOUND=y
 CONFIG_SND=y
diff --git a/arch/sh/configs/se7780_defconfig b/arch/sh/configs/se7780_defconfig
index 13fa6a59b8f1..9e96b000cb99 100644
--- a/arch/sh/configs/se7780_defconfig
+++ b/arch/sh/configs/se7780_defconfig
@@ -60,7 +60,6 @@ CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_THERMAL=y
 CONFIG_FB=y
-CONFIG_FIRMWARE_EDID=y
 CONFIG_FB_SH_MOBILE_LCDC=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
-- 
2.53.0

