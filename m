Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D320AEDB7D4
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:26:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B01010E392;
	Tue,  7 Apr 2026 09:26:20 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3819D10E393
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:26:18 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C7A124E3A6;
 Tue,  7 Apr 2026 09:26:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7FA5B4A0B1;
 Tue,  7 Apr 2026 09:26:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SOb0HanN1GmDVwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 07 Apr 2026 09:26:01 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 geert@linux-m68k.org, simona@ffwll.ch, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 04/10] lib/fonts: Clean up Makefile
Date: Tue,  7 Apr 2026 11:23:15 +0200
Message-ID: <20260407092555.58816-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407092555.58816-1-tzimmermann@suse.de>
References: <20260407092555.58816-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: C7A124E3A6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Simplify the Makefile. Drop font-obj-y and sort the fonts by dictionary
order. Done in preparation for supporting optional font rotation.

v2:
- sort Makefile font entries by Family/Size in ascending order (Geert, Jiri)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 lib/fonts/Makefile | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/lib/fonts/Makefile b/lib/fonts/Makefile
index 30a85a4292fa..b176af53d53e 100644
--- a/lib/fonts/Makefile
+++ b/lib/fonts/Makefile
@@ -1,23 +1,22 @@
 # SPDX-License-Identifier: GPL-2.0
 # Font handling
 
-font-objs := fonts.o
+font-y := fonts.o
 
-font-objs-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
-font-objs-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
-font-objs-$(CONFIG_FONT_8x8)       += font_8x8.o
-font-objs-$(CONFIG_FONT_8x16)      += font_8x16.o
-font-objs-$(CONFIG_FONT_6x11)      += font_6x11.o
-font-objs-$(CONFIG_FONT_7x14)      += font_7x14.o
-font-objs-$(CONFIG_FONT_10x18)     += font_10x18.o
-font-objs-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
-font-objs-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
-font-objs-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
-font-objs-$(CONFIG_FONT_6x10)      += font_6x10.o
-font-objs-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
-font-objs-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
-font-objs-$(CONFIG_FONT_6x8)       += font_6x8.o
+# Built-in fonts; sorted by Family-Size in ascending order
+font-$(CONFIG_FONT_6x8)       += font_6x8.o
+font-$(CONFIG_FONT_6x10)      += font_6x10.o
+font-$(CONFIG_FONT_6x11)      += font_6x11.o
+font-$(CONFIG_FONT_7x14)      += font_7x14.o
+font-$(CONFIG_FONT_8x8)       += font_8x8.o
+font-$(CONFIG_FONT_8x16)      += font_8x16.o
+font-$(CONFIG_FONT_10x18)     += font_10x18.o
+font-$(CONFIG_FONT_ACORN_8x8) += font_acorn_8x8.o
+font-$(CONFIG_FONT_MINI_4x6)  += font_mini_4x6.o
+font-$(CONFIG_FONT_PEARL_8x8) += font_pearl_8x8.o
+font-$(CONFIG_FONT_SUN8x16)   += font_sun8x16.o
+font-$(CONFIG_FONT_SUN12x22)  += font_sun12x22.o
+font-$(CONFIG_FONT_TER10x18)  += font_ter10x18.o
+font-$(CONFIG_FONT_TER16x32)  += font_ter16x32.o
 
-font-objs += $(font-objs-y)
-
-obj-$(CONFIG_FONT_SUPPORT)         += font.o
+obj-$(CONFIG_FONT_SUPPORT) += font.o
-- 
2.53.0

