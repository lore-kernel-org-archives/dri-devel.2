Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A4606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.a=rsa-sha256 header.s=default header.b=ifVmvqKT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DCAE1120CF;
	Thu, 26 Nov 2026 08:09:02 +0000 (UTC)
Received: from forwardcorp1e.mail.yandex.net (forwardcorp1e.mail.yandex.net
 [93.77.172.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACE1010FDD8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 17:08:42 +0000 (UTC)
Received: from mail-nwsmtp-smtp-corp-main-80
 (mail-nwsmtp-smtp-corp-main-80.yp-c.yandex.net)
 by forwardcorp1e.mail.yandex.net (postfix) with ESMTPS id A80E8100336;
 Wed, 25 Nov 2026 20:03:43 +0300 (MSK)
Received: from [127.0.1.1]
 by mail-nwsmtp-smtp-corp-main-80 with ESMTPSA id a3lrP22Zo8c0-sRAf1WTV;
 Wed, 25 Nov 2026 20:03:42 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1795626222;
 bh=D6e784RAfl1zWvIKf8VvIP9R0Xn4wVs0JRUhlpHhbJQ=;
 h=Cc:In-Reply-To:Message-Id:To:Date:References:From:Subject;
 b=ifVmvqKT+7d8cLgAMMnVyYRRibQhivvzVTfOsbHcwGY6thKnU6SohPfAebPCA5IEc
 7PK52KMI7IMwADqJ25ILkCbacC70sVC0GIW8AVFA0sPa65dm8lYp9FjEZZjdDy2bTR
 PIQplQ8qdAO1AkGxZBGrZbFrYhZZ500fP9Tz8cl4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80;
 dkim=pass header.i=@yandex-team.ru
From: Mikhail Rudenko <xyzzy@yandex-team.ru>
Date: Wed, 25 Nov 2026 20:03:27 +0300
Subject: [PATCH 3/3] video: aperture: hand off EFI earlycon on aperture
 ackquisition
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-efi-earlycon-v1-3-49ac2c0a430b@yandex-team.ru>
References: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
In-Reply-To: <20261125-efi-earlycon-v1-0-49ac2c0a430b@yandex-team.ru>
To: Ard Biesheuvel <ardb@kernel.org>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Peter Jones <pjones@redhat.com>, 
 Helge Deller <deller@gmx.de>, Hans de Goede <hansg@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, 
 linux-doc@vger.kernel.org, Mikhail Rudenko <xyzzy@yandex-team.ru>
X-Mailer: b4 0.15.2
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:08:58 +0000
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
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With keep_bootcon, EFI earlycon can keep writing to the firmware
framebuffer while a graphics driver takes over. Add a handoff option
that unregisters it after framebuffer/drm device successfully acquires
its aperture or when a conflicting-device removal helper is
called. The option opt-in, default behavior is preserved.

When handoff option is effective, unregister the EFI earlycon when a
graphics device driver ackquires aperture (unless it was unregistered
earlier).

Signed-off-by: Mikhail Rudenko <xyzzy@yandex-team.ru>
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++-
 drivers/firmware/efi/earlycon.c                 | 37 ++++++++++++++++++++++++-
 drivers/video/aperture.c                        | 13 ++++++++-
 include/linux/efi.h                             |  7 +++++
 4 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd94..829bb01cc10d0 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1532,7 +1532,10 @@ Kernel parameters
 			memory mapped framebuffer (if available). On cache
 			coherent non-x86 systems that use system memory for
 			the framebuffer, pass the 'ram' option so that it is
-			mapped with the correct attributes.
+			mapped with the correct attributes. Pass 'handoff' with
+			keep_bootcon to retain EFI earlycon until a graphics
+			driver acquires a firmware framebuffer aperture. Options
+			may be combined, e.g. earlycon=efifb,ram,handoff.
 
 		linflex,<addr>
 			Use early console provided by Freescale LINFlexD UART
diff --git a/drivers/firmware/efi/earlycon.c b/drivers/firmware/efi/earlycon.c
index 3a6eaf5481f40..9d65777d225e1 100644
--- a/drivers/firmware/efi/earlycon.c
+++ b/drivers/firmware/efi/earlycon.c
@@ -21,8 +21,20 @@ static u32 efi_x_array[1024];
 static u32 efi_x, efi_y;
 static u64 fb_base;
 static bool fb_wb;
+static bool fb_handoff;
 static void *efi_fb;
 
+void efi_earlycon_unregister(void)
+{
+	struct console *con = READ_ONCE(earlycon_console);
+
+	if (!con || !fb_handoff)
+		return;
+
+	if (console_is_registered(con))
+		unregister_console(con);
+}
+
 /*
  * EFI earlycon needs to use early_memremap() to map the framebuffer.
  * But early_memremap() is not usable for 'earlycon=efifb keep_bootcon',
@@ -219,6 +231,29 @@ efi_earlycon_write(struct console *con, const char *str, unsigned int num)
 
 static bool __initdata fb_probed;
 
+static void __init efi_earlycon_parse_options(const char *opt)
+{
+	/* Reprobe has no options; retain those parsed on the first attempt. */
+	if (!opt)
+		return;
+
+	fb_wb = false;
+	fb_handoff = false;
+
+	while (*opt) {
+		size_t len = strcspn(opt, ",");
+
+		if (len == 3 && !strncmp(opt, "ram", len))
+			fb_wb = true;
+		else if (len == 7 && !strncmp(opt, "handoff", len))
+			fb_handoff = true;
+
+		opt += len;
+		if (*opt)
+			opt++;
+	}
+}
+
 void __init efi_earlycon_reprobe(void)
 {
 	if (fb_probed)
@@ -232,7 +267,7 @@ static int __init efi_earlycon_setup(struct earlycon_device *device,
 	u16 xres, yres;
 	u32 i;
 
-	fb_wb = opt && !strcmp(opt, "ram");
+	efi_earlycon_parse_options(opt);
 
 	if (si->orig_video_isVGA != VIDEO_TYPE_EFI) {
 		fb_probed = true;
diff --git a/drivers/video/aperture.c b/drivers/video/aperture.c
index 2b5a1e666e9b2..249b037562103 100644
--- a/drivers/video/aperture.c
+++ b/drivers/video/aperture.c
@@ -2,6 +2,7 @@
 
 #include <linux/aperture.h>
 #include <linux/device.h>
+#include <linux/efi.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/pci.h>
@@ -240,7 +241,13 @@ int devm_aperture_acquire_for_platform_device(struct platform_device *pdev,
 					      resource_size_t base,
 					      resource_size_t size)
 {
-	return devm_aperture_acquire(&pdev->dev, base, size, aperture_detach_platform_device);
+	int ret;
+
+	ret = devm_aperture_acquire(&pdev->dev, base, size, aperture_detach_platform_device);
+	if (!ret)
+		efi_earlycon_unregister();
+
+	return ret;
 }
 EXPORT_SYMBOL(devm_aperture_acquire_for_platform_device);
 
@@ -284,6 +291,8 @@ static void aperture_detach_devices(resource_size_t base, resource_size_t size)
 int aperture_remove_conflicting_devices(resource_size_t base, resource_size_t size,
 					const char *name)
 {
+	efi_earlycon_unregister();
+
 	/*
 	 * If a driver asked to unregister a platform device registered by
 	 * sysfb, then can be assumed that this is a driver for a display
@@ -349,6 +358,8 @@ int aperture_remove_conflicting_pci_devices(struct pci_dev *pdev, const char *na
 	resource_size_t base, size;
 	int bar, ret = 0;
 
+	efi_earlycon_unregister();
+
 	sysfb_disable(&pdev->dev);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; ++bar) {
diff --git a/include/linux/efi.h b/include/linux/efi.h
index cc1df1577d5fb..44cff6fe53f90 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -720,6 +720,13 @@ efi_guid_to_str(const efi_guid_t *guid, char *out)
 
 extern void efi_init (void);
 extern void efi_earlycon_reprobe(void);
+#ifdef CONFIG_EFI_EARLYCON
+void efi_earlycon_unregister(void);
+#else
+static inline void efi_earlycon_unregister(void)
+{
+}
+#endif
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else

-- 
2.56.1

