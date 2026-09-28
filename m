Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92790C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB7910E831;
	Mon, 28 Sep 2026 08:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="QZ0azpTr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DJtgF+8E";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PKFV5mH3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mFQmUFK6";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CC710E828
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:57:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5480520184;
 Mon, 28 Sep 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790585852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+CFfoxPrLCAxyuqx44AdMDDOG8phcKJFrTpu0tdUarM=;
 b=QZ0azpTrQOuR8TyUpTWZ0hyooiLr0N2mn62/qEbtW2clXc9tzAJy6WcjafNpw77nNimGUV
 e+oHDcccUd1t6Udg3lByLmFkzu6P7ty+YcauKzVLK6KCKjdPm3ketQXCHv8OX5aHlfh6sq
 R6195IDxw2s1c9PxrriqEEUXx7OxhAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790585852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+CFfoxPrLCAxyuqx44AdMDDOG8phcKJFrTpu0tdUarM=;
 b=DJtgF+8Ed8i4i8HuGP+W/bS3Ba7/u1QDJqFA3rZOVf9VgQTxYNV9aHFQyCmenPLjEMSkIU
 pNksXTiH9mIbICAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PKFV5mH3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mFQmUFK6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790585848; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+CFfoxPrLCAxyuqx44AdMDDOG8phcKJFrTpu0tdUarM=;
 b=PKFV5mH3Lo7XdVmfHD6To39xHkMq0LAgl2Gkxub+qJmIV9MbrxWDa5QOy1gKkEoOLJ4zCC
 ZCjBLHsdMXB9pvlx3bsjEwtP8Lw0/QW/uOcL4se7mpY/aV+X0aJF1IC/iO8BVQI9ZqeR/V
 J3plMLR/IHX6i4FDkmq9JI8trypiFxU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790585848;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+CFfoxPrLCAxyuqx44AdMDDOG8phcKJFrTpu0tdUarM=;
 b=mFQmUFK6/Sh31y3o7z5+Y/lQDtjGs33F2s8mWZ5dt0L5XgSPyXVBIEi0heH4/ESpBWOrJZ
 UBNFzLd/02AtCmBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E73C0133F1;
 Mon, 28 Sep 2026 08:57:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Kr86I/crumo3HwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 08:57:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 simona@ffwll.ch
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/5] fbcon,vgacon,vt: Share helpers for text cursors
Date: Mon, 28 Sep 2026 10:55:23 +0200
Message-ID: <20260928085724.41660-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5480520184
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmx.de]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,kernel.org,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[9]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]
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

VT consoles fbcon and vgacon implement various cursor sizes (i.e.,
underline, block, half-block, etc). Share related code and harmonize
the look and behaviour.

In patches 1 to 3, move VT cursor-size calculations to the VT subsystem
and use the new helpers from vgacon. Replace similar code in the console.
The new helpers also take VT's default cursor size into account.

Fbcon implements a custom helper that creates a cursor glyph for the
given cursor size. In patches 4 and 5, move the code into the font
library and update fbcon to use the new helper. The cursor-glyph shape
rendering is tied to the font in use. Hence move them next to each other.
Also update fbcon to use the shared cursor-size helpers.

Tested with fbcon under bochs (qemu) and with vgacon on an old SiS
6202 VGA card. Other consoles (newport_con, sticon) don't support cursor
sizes, so leave them as-is.

v3:
- mention user interfaces to control cursor size in commit message (GregKH)
- elaborate defaults (GregKH)
- move retry logic into helper
- handle CUR_DEF
v2:
- restore vc_cell_height in vgacon
- avoid interference from concurrent user space
- fix docs

Thomas Zimmermann (5):
  vt: Add cursor-size helpers
  vgacon: Remove trailing whitespaces
  vgacon: Use vt_cursor_{start,end}()
  lib/fonts: Add font_glyph_cursor() helper
  fbcon: Replace fbcon_fill_cursor_mask() with fbcon_cursor_glyph()

 drivers/tty/vt/vt.c                  | 104 +++++++++++++++++++++++++++
 drivers/video/console/vgacon.c       |  43 +++--------
 drivers/video/fbdev/core/bitblit.c   |   3 +-
 drivers/video/fbdev/core/fbcon.c     |  45 +++---------
 drivers/video/fbdev/core/fbcon.h     |   2 +-
 drivers/video/fbdev/core/fbcon_ccw.c |   3 +-
 drivers/video/fbdev/core/fbcon_cw.c  |   3 +-
 drivers/video/fbdev/core/fbcon_ud.c  |   3 +-
 include/linux/console_struct.h       |   7 ++
 include/linux/font.h                 |   4 ++
 lib/fonts/Makefile                   |   3 +-
 lib/fonts/font_cursor.c              |  56 +++++++++++++++
 12 files changed, 199 insertions(+), 77 deletions(-)
 create mode 100644 lib/fonts/font_cursor.c


base-commit: ff831af91674990f9f1814340860e96943d5df1a
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
-- 
2.55.0

