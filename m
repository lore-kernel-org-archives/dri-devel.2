Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA731D39401
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 09:23:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E26510F1F3;
	Thu,  2 Apr 2026 09:23:25 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2223F10F1F0
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 09:23:24 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 84A0D5BD9A;
 Thu,  2 Apr 2026 09:23:12 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC1F84A0B1;
 Thu,  2 Apr 2026 09:23:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGM3OH81zmlVYAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 02 Apr 2026 09:23:11 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, arnd@arndb.de, ardb@kernel.org,
 ilias.apalodimas@linaro.org, chenhuacai@kernel.org, kernel@xen0n.name,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
 deller@gmx.de
Cc: linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
 linux-efi@vger.kernel.org, linux-riscv@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/8] firmware: sysfb: Make CONFIG_SYSFB a user-selectable
 option
Date: Thu,  2 Apr 2026 11:09:17 +0200
Message-ID: <20260402092305.208728-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402092305.208728-1-tzimmermann@suse.de>
References: <20260402092305.208728-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 84A0D5BD9A
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
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

Add a descriptive string and help text to CONFIG_SYSFB, so that users
can modify it. Flip all implicit selects in the Kconfig options into
dependencies. This avoids cyclic dependencies in the config.

Enabling CONFIG_SYSFB makes the kernel provide a device for the firmware
framebuffer. As this can (slightly) affect system behavior, having a
user-facing option seems preferable. Some users might also want to set
every detail of their kernel config.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/firmware/Kconfig      | 18 ++++++++++++++++--
 drivers/gpu/drm/sysfb/Kconfig |  4 ++--
 drivers/hv/Kconfig            |  2 +-
 drivers/video/fbdev/Kconfig   |  5 +++--
 4 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index bbd2155d8483..52f8253a46b1 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -179,14 +179,28 @@ config MTK_ADSP_IPC
 	  Client might use shared memory to exchange information with ADSP.
 
 config SYSFB
-	bool
+	bool "Enable system framebuffer provided by boot loader"
 	select BOOT_VESA_SUPPORT
 	select SCREEN_INFO
+	help
+	  Use the system framebuffer provided by the boot loader. This will
+	  create a device representing the framebuffer. The output depends on
+	  EFI, VESA, VGA, or some other firmware-based interface.
+
+	  The firmware or boot loader sets the display resolution and color
+	  mode. See your boot loader's documentation on how to do this. On
+	  some systems the display can also be configured during boot with
+	  the kernel's video= or vga= parameters.
+
+	  Besides this option, you also have to enable a compatible graphics
+	  driver, such as efidrm or vesadrm.
+
+	  If unsure, say Y.
 
 config SYSFB_SIMPLEFB
 	bool "Mark VGA/VBE/EFI FB as generic system framebuffer"
+	depends on SYSFB
 	depends on X86 || EFI
-	select SYSFB
 	help
 	  Firmwares often provide initial graphics framebuffers so the BIOS,
 	  bootloader or kernel can show basic video-output during boot for
diff --git a/drivers/gpu/drm/sysfb/Kconfig b/drivers/gpu/drm/sysfb/Kconfig
index 2559ead6cf1f..74be3c8e6657 100644
--- a/drivers/gpu/drm/sysfb/Kconfig
+++ b/drivers/gpu/drm/sysfb/Kconfig
@@ -26,12 +26,12 @@ config DRM_COREBOOTDRM
 config DRM_EFIDRM
 	tristate "EFI framebuffer driver"
 	depends on DRM && MMU && EFI && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SYSFB_HELPER
-	select SYSFB
 	help
 	  DRM driver for EFI framebuffers.
 
@@ -76,12 +76,12 @@ config DRM_SIMPLEDRM
 config DRM_VESADRM
 	tristate "VESA framebuffer driver"
 	depends on DRM && MMU && X86 && (!SYSFB_SIMPLEFB || COMPILE_TEST)
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_CLIENT_SELECTION
 	select DRM_GEM_SHMEM_HELPER
 	select DRM_KMS_HELPER
 	select DRM_SYSFB_HELPER
-	select SYSFB
 	help
 	  DRM driver for VESA framebuffers.
 
diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index 2d0b3fcb0ff8..af0ac6516159 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -60,8 +60,8 @@ config HYPERV_BALLOON
 config HYPERV_VMBUS
 	tristate "Microsoft Hyper-V VMBus driver"
 	depends on HYPERV
+	depends on SYSFB if EFI && !HYPERV_VTL_MODE
 	default HYPERV
-	select SYSFB if EFI && !HYPERV_VTL_MODE
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 
diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index ac9ac4287c6a..6f55bec8c207 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -333,6 +333,7 @@ config FB_IMSTT
 config FB_VGA16
 	tristate "VGA 16-color graphics support"
 	depends on FB && X86
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
@@ -424,9 +425,9 @@ config FB_UVESA
 config FB_VESA
 	bool "VESA VGA graphics support"
 	depends on (FB = y) && X86
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select FB_IOMEM_HELPERS
-	select SYSFB
 	help
 	  This is the frame buffer device driver for generic VESA 2.0
 	  compliant graphic cards. The older VESA 1.2 cards are not supported.
@@ -436,10 +437,10 @@ config FB_VESA
 config FB_EFI
 	bool "EFI-based Framebuffer Support"
 	depends on (FB = y) && EFI
+	depends on SYSFB
 	select APERTURE_HELPERS
 	select DRM_PANEL_ORIENTATION_QUIRKS
 	select FB_IOMEM_HELPERS
-	select SYSFB
 	help
 	  This is the EFI frame buffer device driver. If the firmware on
 	  your platform is EFI 1.10 or UEFI 2.0, select Y to add support for
-- 
2.53.0

