Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A8D0CD5BD5
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 15:16:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFECF10E27B;
	Wed, 27 May 2026 15:16:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="VVnVTMVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8jo1ekQu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VVnVTMVc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8jo1ekQu";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2256710E22B
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 15:16:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BE40666E4A;
 Wed, 27 May 2026 15:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHqLZ2GvcUmtifBg8VJOPlaQl701/Z9Y7J0m1EOmzqM=;
 b=VVnVTMVcWSRb0L8sXIUg2uEVgPIMgmxaiAaekeLks9Hah8A3TMi3VUymKeLsKn8HcXzYDN
 4B26nOQQPMSb6MoiVQi8GcvTL+NKQLx+3+9cbGSmbRk6WKMu5Dnl3X5OyGHnjzgnokJGKH
 usj8LZwIiQ0Gnu3hOCMMlmZtj8iohhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779894956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHqLZ2GvcUmtifBg8VJOPlaQl701/Z9Y7J0m1EOmzqM=;
 b=8jo1ekQuh9DR7FzXkjkibIBVuBvq7R34A2kyQ9gGxJkBcMhTpw8PvUDL/7JGqf1lARtVF6
 bpry/6LTeIehe+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1779894956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHqLZ2GvcUmtifBg8VJOPlaQl701/Z9Y7J0m1EOmzqM=;
 b=VVnVTMVcWSRb0L8sXIUg2uEVgPIMgmxaiAaekeLks9Hah8A3TMi3VUymKeLsKn8HcXzYDN
 4B26nOQQPMSb6MoiVQi8GcvTL+NKQLx+3+9cbGSmbRk6WKMu5Dnl3X5OyGHnjzgnokJGKH
 usj8LZwIiQ0Gnu3hOCMMlmZtj8iohhw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1779894956;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fHqLZ2GvcUmtifBg8VJOPlaQl701/Z9Y7J0m1EOmzqM=;
 b=8jo1ekQuh9DR7FzXkjkibIBVuBvq7R34A2kyQ9gGxJkBcMhTpw8PvUDL/7JGqf1lARtVF6
 bpry/6LTeIehe+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A4155A8C1;
 Wed, 27 May 2026 15:15:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2Nt+GKwKF2p6FQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 27 May 2026 15:15:56 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, geert@linux-m68k.org, simona@ffwll.ch, airlied@gmail.com,
 lukas@wunner.de, maddy@linux.ibm.com, mpe@ellerman.id.au,
 npiggin@gmail.com, chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 4/4] fbdev: Do not export fbcon from fbdev
Date: Wed, 27 May 2026 17:14:05 +0200
Message-ID: <20260527151551.258659-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527151551.258659-1-tzimmermann@suse.de>
References: <20260527151551.258659-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 RCPT_COUNT_TWELVE(0.00)[13]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[gmx.de,linux-m68k.org,ffwll.ch,gmail.com,wunner.de,linux.ibm.com,ellerman.id.au,kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RL3i8gi83d8iemn6cxmyh4cqsd)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
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

There are no callers of fbcon outside fbdev. Move the declarations
into the internal header.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 MAINTAINERS                          |  1 -
 drivers/video/fbdev/core/fb_chrdev.c |  2 +-
 drivers/video/fbdev/core/fbcon.c     |  1 -
 drivers/video/fbdev/core/fbcon.h     | 50 +++++++++++++++++++++++++
 drivers/video/fbdev/core/fbmem.c     |  2 +-
 include/linux/fbcon.h                | 55 ----------------------------
 6 files changed, 52 insertions(+), 59 deletions(-)
 delete mode 100644 include/linux/fbcon.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 4ae6919454c3..a795628ff46a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10150,7 +10150,6 @@ F:	drivers/video/fbdev/core/fbcon_rotate.h
 F:	drivers/video/fbdev/core/fbcon_ud.c
 F:	drivers/video/fbdev/core/softcursor.c
 F:	drivers/video/fbdev/core/tileblit.c
-F:	include/linux/fbcon.h
 F:	include/linux/font.h
 F:	lib/fonts/
 
diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 035e67d2c28f..ba1d0bc214c5 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -3,10 +3,10 @@
 #include <linux/compat.h>
 #include <linux/console.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/major.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
 /*
  * We hold a reference to the fb_info in file->private_data,
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 50b84cd32938..853b52b40d01 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -70,7 +70,6 @@
 #include <linux/printk.h>
 #include <linux/slab.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/vt_kern.h>
 #include <linux/selection.h>
 #include <linux/font.h>
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 321cc7f44baa..407d207b14f1 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -11,6 +11,7 @@
 #ifndef _VIDEO_FBCON_H
 #define _VIDEO_FBCON_H
 
+#include <linux/compiler_types.h>
 #include <linux/font.h>
 #include <linux/types.h>
 #include <linux/vt_buffer.h>
@@ -19,6 +20,11 @@
 
 #include <asm/io.h>
 
+struct fb_blit_caps;
+struct fb_info;
+struct fb_var_screeninfo;
+struct fb_videomode;
+
    /*
     *    This is the interface between the low-level console driver and the
     *    low-level frame buffer device
@@ -233,4 +239,48 @@ static inline int get_attribute(struct fb_info *info, u16 c)
         (void) (&_r == &_v); \
         (i == FB_ROTATE_UR || i == FB_ROTATE_UD) ? _r : _v; })
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE
+void __init fb_console_init(void);
+void __exit fb_console_exit(void);
+int fbcon_fb_registered(struct fb_info *info);
+void fbcon_fb_unregistered(struct fb_info *info);
+void fbcon_fb_unbind(struct fb_info *info);
+void fbcon_suspended(struct fb_info *info);
+void fbcon_resumed(struct fb_info *info);
+int fbcon_mode_deleted(struct fb_info *info,
+		       struct fb_videomode *mode);
+void fbcon_delete_modelist(struct list_head *head);
+void fbcon_new_modelist(struct fb_info *info);
+void fbcon_get_requirement(struct fb_info *info,
+			   struct fb_blit_caps *caps);
+void fbcon_fb_blanked(struct fb_info *info, int blank);
+int  fbcon_modechange_possible(struct fb_info *info,
+			       struct fb_var_screeninfo *var);
+void fbcon_update_vcs(struct fb_info *info, bool all);
+void fbcon_remap_all(struct fb_info *info);
+int fbcon_set_con2fb_map_ioctl(void __user *argp);
+int fbcon_get_con2fb_map_ioctl(void __user *argp);
+#else
+static inline void fb_console_init(void) {}
+static inline void fb_console_exit(void) {}
+static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
+static inline void fbcon_fb_unregistered(struct fb_info *info) {}
+static inline void fbcon_fb_unbind(struct fb_info *info) {}
+static inline void fbcon_suspended(struct fb_info *info) {}
+static inline void fbcon_resumed(struct fb_info *info) {}
+static inline int fbcon_mode_deleted(struct fb_info *info,
+				     struct fb_videomode *mode) { return 0; }
+static inline void fbcon_delete_modelist(struct list_head *head) {}
+static inline void fbcon_new_modelist(struct fb_info *info) {}
+static inline void fbcon_get_requirement(struct fb_info *info,
+					 struct fb_blit_caps *caps) {}
+static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
+static inline int  fbcon_modechange_possible(struct fb_info *info,
+				struct fb_var_screeninfo *var) { return 0; }
+static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
+static inline void fbcon_remap_all(struct fb_info *info) {}
+static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
+static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
+#endif
+
 #endif /* _VIDEO_FBCON_H */
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index ecadbc58abff..e5221653ec2b 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -14,13 +14,13 @@
 #include <linux/console.h>
 #include <linux/export.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/lcd.h>
 #include <linux/leds.h>
 
 #include <video/nomodeset.h>
 
 #include "fb_internal.h"
+#include "fbcon.h"
 
     /*
      *  Frame buffer device initialization and setup routines
diff --git a/include/linux/fbcon.h b/include/linux/fbcon.h
deleted file mode 100644
index f206370060e1..000000000000
--- a/include/linux/fbcon.h
+++ /dev/null
@@ -1,55 +0,0 @@
-#ifndef _LINUX_FBCON_H
-#define _LINUX_FBCON_H
-
-#include <linux/compiler_types.h>
-
-struct fb_blit_caps;
-struct fb_info;
-struct fb_var_screeninfo;
-struct fb_videomode;
-
-#ifdef CONFIG_FRAMEBUFFER_CONSOLE
-void __init fb_console_init(void);
-void __exit fb_console_exit(void);
-int fbcon_fb_registered(struct fb_info *info);
-void fbcon_fb_unregistered(struct fb_info *info);
-void fbcon_fb_unbind(struct fb_info *info);
-void fbcon_suspended(struct fb_info *info);
-void fbcon_resumed(struct fb_info *info);
-int fbcon_mode_deleted(struct fb_info *info,
-		       struct fb_videomode *mode);
-void fbcon_delete_modelist(struct list_head *head);
-void fbcon_new_modelist(struct fb_info *info);
-void fbcon_get_requirement(struct fb_info *info,
-			   struct fb_blit_caps *caps);
-void fbcon_fb_blanked(struct fb_info *info, int blank);
-int  fbcon_modechange_possible(struct fb_info *info,
-			       struct fb_var_screeninfo *var);
-void fbcon_update_vcs(struct fb_info *info, bool all);
-void fbcon_remap_all(struct fb_info *info);
-int fbcon_set_con2fb_map_ioctl(void __user *argp);
-int fbcon_get_con2fb_map_ioctl(void __user *argp);
-#else
-static inline void fb_console_init(void) {}
-static inline void fb_console_exit(void) {}
-static inline int fbcon_fb_registered(struct fb_info *info) { return 0; }
-static inline void fbcon_fb_unregistered(struct fb_info *info) {}
-static inline void fbcon_fb_unbind(struct fb_info *info) {}
-static inline void fbcon_suspended(struct fb_info *info) {}
-static inline void fbcon_resumed(struct fb_info *info) {}
-static inline int fbcon_mode_deleted(struct fb_info *info,
-				     struct fb_videomode *mode) { return 0; }
-static inline void fbcon_delete_modelist(struct list_head *head) {}
-static inline void fbcon_new_modelist(struct fb_info *info) {}
-static inline void fbcon_get_requirement(struct fb_info *info,
-					 struct fb_blit_caps *caps) {}
-static inline void fbcon_fb_blanked(struct fb_info *info, int blank) {}
-static inline int  fbcon_modechange_possible(struct fb_info *info,
-				struct fb_var_screeninfo *var) { return 0; }
-static inline void fbcon_update_vcs(struct fb_info *info, bool all) {}
-static inline void fbcon_remap_all(struct fb_info *info) {}
-static inline int fbcon_set_con2fb_map_ioctl(void __user *argp) { return 0; }
-static inline int fbcon_get_con2fb_map_ioctl(void __user *argp) { return 0; }
-#endif
-
-#endif /* _LINUX_FBCON_H */
-- 
2.54.0

