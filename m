Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E17CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:08:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93ACA10E81B;
	Wed, 20 May 2026 16:08:09 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DB7310E81B
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:08:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C7EC767D75;
 Wed, 20 May 2026 16:07:54 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B78A593AA;
 Wed, 20 May 2026 16:07:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kHwtJVrcDWqwWgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 20 May 2026 16:07:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: deller@gmx.de, simona@ffwll.ch, airlied@gmail.com, lukas@wunner.de,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/4] fbdev: Do not export fbcon from fbdev
Date: Wed, 20 May 2026 18:00:39 +0200
Message-ID: <20260520160744.130841-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520160744.130841-1-tzimmermann@suse.de>
References: <20260520160744.130841-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C7EC767D75
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
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
index a80e7f0c25e6..d5058fa2cb54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10141,7 +10141,6 @@ F:	drivers/video/fbdev/core/fbcon_rotate.h
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

