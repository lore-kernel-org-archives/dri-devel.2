Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97F606A8BE
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RTH1Mo2/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W7mv2tzX;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=RTH1Mo2/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=W7mv2tzX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C65F10EB62;
	Tue, 17 Nov 2026 08:45:32 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3EEF10F280
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 08:45:20 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3F1EB1F6E6;
 Tue, 17 Nov 2026 08:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794905119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HtQfSTCDo69KwjcGYAQjqOB4/Op9vfM277fQ3LSI5Ow=;
 b=RTH1Mo2/pGsyMVQ6MZkmn8Sne7L3PSATKzVEjORb85vQE4ASWcLdtZVlJMiBn1KbpzqSON
 EkO2cy9gnNWfiE5qYy3pi/drG3qXTVDOvziiCvavMnf2xd8ySHT+UBNmwPSqDHiCYX1/1f
 oVSl8S1Vhl34YEp7dtcwj28Rm8F2IEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794905119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HtQfSTCDo69KwjcGYAQjqOB4/Op9vfM277fQ3LSI5Ow=;
 b=W7mv2tzXxk/39zBlHT9iI910ZFYYrOnP1dYw3039aBTdW26qrLIFpRk3LI2qYJ0ivI0ov/
 90yh40VC+HmVviAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="RTH1Mo2/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=W7mv2tzX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794905119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HtQfSTCDo69KwjcGYAQjqOB4/Op9vfM277fQ3LSI5Ow=;
 b=RTH1Mo2/pGsyMVQ6MZkmn8Sne7L3PSATKzVEjORb85vQE4ASWcLdtZVlJMiBn1KbpzqSON
 EkO2cy9gnNWfiE5qYy3pi/drG3qXTVDOvziiCvavMnf2xd8ySHT+UBNmwPSqDHiCYX1/1f
 oVSl8S1Vhl34YEp7dtcwj28Rm8F2IEA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794905119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HtQfSTCDo69KwjcGYAQjqOB4/Op9vfM277fQ3LSI5Ow=;
 b=W7mv2tzXxk/39zBlHT9iI910ZFYYrOnP1dYw3039aBTdW26qrLIFpRk3LI2qYJ0ivI0ov/
 90yh40VC+HmVviAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D0BCC1334C;
 Tue, 17 Nov 2026 08:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jcr5JR4U/GrjUQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 17 Nov 2026 08:45:18 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] firmware: sysfb: Remove CONFIG_SYSFB_SIMPLEFB
Date: Tue, 17 Nov 2026 09:44:57 +0100
Message-ID: <20261117084514.367399-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 3F1EB1F6E6
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Enabling SYSFB_SIMPLEFB creates a system-framebuffer device on top of
a firmware-provided UEFI or VESA framebuffer. It is inflexible and lacks
support for various features, such as EDID and color LUTs. Therefore
commit cc79eaf8ee25 ("firmware: sysfb: Mark CONFIG_SYSFB_SIMPLEFB as
deprecated") marked CONFIG_SYSFB_SIMPLEFB as deprecated.

Remove CONFIG_SYSFB_SIMPLEFB and the related code. Remaining users are
advised to upgrade to efi-framebuffer and vesa-framebuffer with efidrm
and vesadrm on top. Also remove the outdated comment from sysfb.c.

Note that this change does not affect DeviceTree simple-framebuffer.
The kernel still parses them and creates a simple-framebuffer device
for each.

The MIPS architecture code creates a simple-framebuffer device for the
display output on the Nintendo N64. Removing CONFIG_SYSFB_SIMPLEFB does
not affect this code either.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig          |  16 ----
 drivers/firmware/Makefile         |   1 -
 drivers/firmware/sysfb.c          |  33 -------
 drivers/firmware/sysfb_simplefb.c | 140 ------------------------------
 drivers/gpu/drm/sysfb/Kconfig     |   4 +-
 include/linux/sysfb.h             |  25 ------
 6 files changed, 2 insertions(+), 217 deletions(-)
 delete mode 100644 drivers/firmware/sysfb_simplefb.c

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 43e2e2a64594..ab76a6f7f0ab 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -210,22 +210,6 @@ config SYSFB
 	select BOOT_VESA_SUPPORT
 	select SCREEN_INFO
 
-config SYSFB_SIMPLEFB
-	bool "Mark VGA/VBE/EFI FB as generic system framebuffer (deprecated)"
-	depends on X86 || EFI
-	select SYSFB
-	help
-	  Firmware often provides initial graphics framebuffers so the BIOS,
-	  bootloader or kernel can show basic video-output during boot for
-	  user-guidance and debugging.
-
-	  This option, if enabled, marks VBE/EFI framebuffers as system
-	  framebuffers so the generic simpledrm driver can be used.
-
-	  This option is deprecated and will be removed in the near future. If
-	  unsure, say N and select efidrm, vesadrm instead. The dedicated DRM
-	  drivers provide the same functionality plus additional features.
-
 config TH1520_AON_PROTOCOL
 	tristate "Always-On firmware protocol"
 	depends on ARCH_THEAD || COMPILE_TEST
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 50b338313152..6a9413454d10 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -19,7 +19,6 @@ obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
 obj-$(CONFIG_FW_ATTR_CLASS)	+= firmware_attributes_class.o
 obj-$(CONFIG_SYSFB)		+= sysfb.o
-obj-$(CONFIG_SYSFB_SIMPLEFB)	+= sysfb_simplefb.o
 obj-$(CONFIG_TH1520_AON_PROTOCOL) += thead,th1520-aon.o
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 obj-$(CONFIG_TRUSTED_FOUNDATIONS) += trusted_foundations.o
diff --git a/drivers/firmware/sysfb.c b/drivers/firmware/sysfb.c
index 8833582c1883..07738b9e89c5 100644
--- a/drivers/firmware/sysfb.c
+++ b/drivers/firmware/sysfb.c
@@ -4,33 +4,11 @@
  * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
  */
 
-/*
- * Simple-Framebuffer support
- * Create a platform-device for any available boot framebuffer. The
- * simple-framebuffer platform device is already available on DT systems, so
- * this module parses the global "screen_info" object and creates a suitable
- * platform device compatible with the "simple-framebuffer" DT object. If
- * the framebuffer is incompatible, we instead create a legacy
- * "vesa-framebuffer", "efi-framebuffer" or "platform-framebuffer" device and
- * pass the screen_info as platform_data. This allows legacy drivers
- * to pick these devices up without messing with simple-framebuffer drivers.
- * The global "screen_info" is still valid at all times.
- *
- * If CONFIG_SYSFB_SIMPLEFB is not selected, never register "simple-framebuffer"
- * platform devices, but only use legacy framebuffer devices for
- * backwards compatibility.
- *
- * TODO: We set the dev_id field of all platform-devices to 0. This allows
- * other OF/DT parsers to create such devices, too. However, they must
- * start at offset 1 for this to work.
- */
-
 #include <linux/err.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/pci.h>
-#include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
 #include <linux/sysfb.h>
@@ -145,9 +123,7 @@ static __init int sysfb_init(void)
 	struct screen_info *si = &dpy->screen;
 	struct device *parent;
 	unsigned int type;
-	struct simplefb_platform_data mode;
 	const char *name;
-	bool compatible;
 	int ret = 0;
 
 	screen_info_apply_fixups();
@@ -164,17 +140,8 @@ static __init int sysfb_init(void)
 		goto unlock_mutex;
 	}
 
-	/* try to create a simple-framebuffer device */
-	compatible = sysfb_parse_mode(si, &mode);
-	if (compatible) {
-		pd = sysfb_create_simplefb(si, &mode, parent);
-		if (!IS_ERR(pd))
-			goto put_device;
-	}
-
 	type = screen_info_video_type(si);
 
-	/* if the FB is incompatible, create a legacy framebuffer device */
 	switch (type) {
 	case VIDEO_TYPE_EGAC:
 		name = "ega-framebuffer";
diff --git a/drivers/firmware/sysfb_simplefb.c b/drivers/firmware/sysfb_simplefb.c
deleted file mode 100644
index 71f542e37732..000000000000
--- a/drivers/firmware/sysfb_simplefb.c
+++ /dev/null
@@ -1,140 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Generic System Framebuffers
- * Copyright (c) 2012-2013 David Herrmann <dh.herrmann@gmail.com>
- */
-
-/*
- * simple-framebuffer probing
- * Try to convert "screen_info" into a "simple-framebuffer" compatible mode.
- * If the mode is incompatible, we return "false" and let the caller create
- * legacy nodes instead.
- */
-
-#include <linux/err.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/platform_data/simplefb.h>
-#include <linux/platform_device.h>
-#include <linux/screen_info.h>
-#include <linux/sysfb.h>
-
-static const char simplefb_resname[] = "BOOTFB";
-static const struct simplefb_format formats[] = SIMPLEFB_FORMATS;
-
-/* try parsing screen_info into a simple-framebuffer mode struct */
-__init bool sysfb_parse_mode(const struct screen_info *si,
-			     struct simplefb_platform_data *mode)
-{
-	__u8 type;
-	u32 bits_per_pixel;
-	unsigned int i;
-
-	type = si->orig_video_isVGA;
-	if (type != VIDEO_TYPE_VLFB && type != VIDEO_TYPE_EFI)
-		return false;
-
-	bits_per_pixel = __screen_info_lfb_bits_per_pixel(si);
-
-	for (i = 0; i < ARRAY_SIZE(formats); ++i) {
-		const struct simplefb_format *f = &formats[i];
-
-		if (f->transp.length)
-			continue; /* transparent formats are unsupported by VESA/EFI */
-
-		if (bits_per_pixel == f->bits_per_pixel &&
-		    si->red_size == f->red.length &&
-		    si->red_pos == f->red.offset &&
-		    si->green_size == f->green.length &&
-		    si->green_pos == f->green.offset &&
-		    si->blue_size == f->blue.length &&
-		    si->blue_pos == f->blue.offset) {
-			mode->format = f->name;
-			mode->width = si->lfb_width;
-			mode->height = si->lfb_height;
-			mode->stride = si->lfb_linelength;
-			return true;
-		}
-	}
-
-	return false;
-}
-
-__init struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-						     const struct simplefb_platform_data *mode,
-						     struct device *parent)
-{
-	struct platform_device *pd;
-	struct resource res;
-	u64 base, size;
-	u32 length;
-	int ret;
-
-	/*
-	 * If the 64BIT_BASE capability is set, ext_lfb_base will contain the
-	 * upper half of the base address. Assemble the address, then make sure
-	 * it is valid and we can actually access it.
-	 */
-	base = si->lfb_base;
-	if (si->capabilities & VIDEO_CAPABILITY_64BIT_BASE)
-		base |= (u64)si->ext_lfb_base << 32;
-	if (!base || (u64)(resource_size_t)base != base) {
-		printk(KERN_DEBUG "sysfb: inaccessible VRAM base\n");
-		return ERR_PTR(-EINVAL);
-	}
-
-	/*
-	 * Don't use lfb_size as IORESOURCE size, since it may contain the
-	 * entire VMEM, and thus require huge mappings. Use just the part we
-	 * need, that is, the part where the framebuffer is located. But verify
-	 * that it does not exceed the advertised VMEM.
-	 * Note that in case of VBE, the lfb_size is shifted by 16 bits for
-	 * historical reasons.
-	 */
-	size = si->lfb_size;
-	if (si->orig_video_isVGA == VIDEO_TYPE_VLFB)
-		size <<= 16;
-	length = mode->height * mode->stride;
-	if (length > size) {
-		printk(KERN_WARNING "sysfb: VRAM smaller than advertised\n");
-		return ERR_PTR(-EINVAL);
-	}
-	length = PAGE_ALIGN(length);
-
-	/* setup IORESOURCE_MEM as framebuffer memory */
-	memset(&res, 0, sizeof(res));
-	res.flags = IORESOURCE_MEM;
-	res.name = simplefb_resname;
-	res.start = base;
-	res.end = res.start + length - 1;
-	if (res.end <= res.start)
-		return ERR_PTR(-EINVAL);
-
-	pd = platform_device_alloc("simple-framebuffer", 0);
-	if (!pd)
-		return ERR_PTR(-ENOMEM);
-
-	pd->dev.parent = parent;
-
-	sysfb_set_efifb_fwnode(si, pd);
-
-	ret = platform_device_add_resources(pd, &res, 1);
-	if (ret)
-		goto err_put_device;
-
-	ret = platform_device_add_data(pd, mode, sizeof(*mode));
-	if (ret)
-		goto err_put_device;
-
-	ret = platform_device_add(pd);
-	if (ret)
-		goto err_put_device;
-
-	return pd;
-
-err_put_device:
-	platform_device_put(pd);
-
-	return ERR_PTR(ret);
-}
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index f7e48178885e..05d4b3ab4d08 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -25,7 +25,7 @@ config DRM_COREBOOTDRM
 
 config DRM_EFIDRM
 	tristate "EFI framebuffer driver"
-	depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on DRM && MMU && EFI
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
@@ -72,7 +72,7 @@ config DRM_SIMPLEDRM
 
 config DRM_VESADRM
 	tristate "VESA framebuffer driver"
-	depends on DRM && MMU && X86 && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on DRM && MMU && X86
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
diff --git a/include/linux/sysfb.h b/include/linux/sysfb.h
index ed23d6516223..611c8f0d13da 100644
--- a/include/linux/sysfb.h
+++ b/include/linux/sysfb.h
@@ -110,29 +110,4 @@ static inline void sysfb_set_efifb_fwnode(const struct screen_info *si,
 
 #endif /* CONFIG_EFI */
 
-#ifdef CONFIG_SYSFB_SIMPLEFB
-
-bool sysfb_parse_mode(const struct screen_info *si,
-		      struct simplefb_platform_data *mode);
-struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-					      const struct simplefb_platform_data *mode,
-					      struct device *parent);
-
-#else /* CONFIG_SYSFB_SIMPLEFB */
-
-static inline bool sysfb_parse_mode(const struct screen_info *si,
-				    struct simplefb_platform_data *mode)
-{
-	return false;
-}
-
-static inline struct platform_device *sysfb_create_simplefb(const struct screen_info *si,
-							    const struct simplefb_platform_data *mode,
-							    struct device *parent)
-{
-	return ERR_PTR(-EINVAL);
-}
-
-#endif /* CONFIG_SYSFB_SIMPLEFB */
-
 #endif /* _LINUX_SYSFB_H */
-- 
2.56.0

