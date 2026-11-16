Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07E9606A335
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SNOklIV+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 118DE10E078;
	Sun, 15 Nov 2026 23:22:16 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3649910E0AC
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:08 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso30652045e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784926; x=1795389726; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QRwRXLM89UnoOEjo9EGn9AE3PBFxJ1gHBO963ekwGoI=;
 b=SNOklIV+7zcAph7ogiraAwQWzScBdVmV9+H4k5JgR+p9QNT8ktmjlbGBW5E3LNkNSw
 LfQoBECz/In2JjxcQSfvrRLGFiyb502UeQP/XpE/hGR4YX9IAMhgYMjSzR4QuMFNhh6K
 XmqaSUN+mT/jZ70Pz8OtGERJwt7gFwKlz4HPw2zQLD+yVCbs8qHS/edOKJOc5xKF8HMK
 md2+hsqkAjdGlesCjJRzhiW3Nj8mRvuJqi4jvVtq4nzVPean5XnliA0Gvo1H75XnIVSS
 1B7oxWPgLZC8Us0CA+0HqX/gAcIYdVv6AkdEMp8N7ECRhhBnRrKwDTH52BSv0InYJhhl
 m5qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784926; x=1795389726;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QRwRXLM89UnoOEjo9EGn9AE3PBFxJ1gHBO963ekwGoI=;
 b=Lrnv59cfGj4P3kSaoryFsOj1WRehnc1aFRaQeCDRD/1uexjugtRZzOnH8gb3r5NtFj
 O9Sbh+2l9Iw6hkkX4Jk6qisptA7vB+a3kpCZZQ8r4b4p/aWsyxkn7eoj8yT52PXN6WWy
 GAPekAY68IIU9nMKeYRo7OlcK5M2pmHJ/hhxJPP2hGJEn8co8ZP0DbpgU0Z2Zs6yJYXG
 yQOeyIodPVENU8ma9vk3GHVSIL5yT6UXhAqWsoqc84XISaFOVVmspGJds42ZuSFxTKIs
 Y+Yj/W9uQEzq0f4BhMTp5x12bttZkfAL4NCXPEvOnqxc7HfVZqRxoj7owapkCQpg4WBB
 1AeA==
X-Forwarded-Encrypted: i=1;
 AL+hErFJ5F2txW3y6gIxo5mQ8vHE6AU3kde2PhQi3w+aVHBfT3ba9Zni19LfUEDMT1vzWDcyfvOzABWG+ko=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8CfqRsENwEiERJvLfZ44d/Z0j+aVgq1FkRhnzjW4q0XW/yIbug
 HP/sMinPtFxEUKh/d+h6sTB8aI8bO4ctwcYe2uMJHUsucYbUVdodd45u
X-Gm-Gg: AYBFou0Pyl5K2UJrz0QcwtQ0KAabGNOkxot6NMxsycxz9eCMiVavVrrUNzHCe5+ZiN1
 ZHSeDlnUAVXa74+aWJ9dQkgly9NzG8fcPFmF8epx9qiocdOnk2GdmMH4ptejso6lCQrCh0JswWp
 LvOXx5T6IB0GForBiQZJ9OZBjBFuHWpFQEnOhEOPXFW+SVn0Gaf3j1/o03J9wCX0sFbcaL7D448
 9Yuaawio0iCYi24Qrtg9lW3RDX18PqByncMx9p69ODmDPeQeekcO+TN9aWp+Sa7ozEHlylG8jZ7
 KwUHRjqRfVGy56dF+nGvj8J6oJSG1n7xYxLBonXWa2o8PXL7nMQv/w+o3nM8kyvGBidFEakvQ33
 OxB3daZq71rdtCzkWuUokxwPPO+hDoE0O+Jucp1MTOs1I+vu6dI7EdnJSFeGcqWTdEvoneTs9zd
 mHw6J01iyM2ildyzmHjRFuSVAGJ+as7tjmux0jJGWRjlAmWGO1zPef+rP2v9RaFTvAU44WpbP8j
 jkueUz9Io0DNDWJn/IfgLmwnx81WbwDdYUgpY7YgY9AckdzJ41MeKm+MBTrkH5HelJ1DuaGEDfe
 JHrHUktxPBdm4igqF75NaceI+OvP/hlvul9YxoHLA2I2/ikwqeAxRQk=
X-Received: by 2002:a05:600c:19d2:b0:4bb:60bd:53b2 with SMTP id
 5b1f17b1804b1-4bb60bd55eamr134252235e9.6.1794784926397; 
 Sun, 15 Nov 2026 15:22:06 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:06 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 2/6] efi: bgrt: add accessors for the boot graphics
Date: Mon, 16 Nov 2026 01:21:52 +0100
Message-Id: <20261116002156.1027726-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DRM splash client shows the boot graphics the firmware left behind,
and needs the image address and size, its offsets and the status bits.
Reading them from bgrt_tab and bgrt_image_size works with drm_client_lib
built in, but it can be a module, and neither is exported:

  ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bgrt_tab' undefined!
  ERROR: modpost: drivers/gpu/drm/clients/drm_client_lib.ko: symbol 'bgrt_image_size' undefined!

Rather than export the data, add an accessor for each of them, exported
GPL only, with stubs in efi-bgrt.h for CONFIG_ACPI_BGRT=n so that users
need no #ifdef of their own. The variables stay global for
drivers/acpi/bgrt.c, and are only written by efi_bgrt_init(): mark them
__ro_after_init.

The table gives the image address as a u64. efi_bgrt_has_image() only
says yes when phys_addr_t can hold it, and the address and size are 0
when it says no, so that they never disagree on kernels with 32-bit
physical addresses.

Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b978696482@amd.com/
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/firmware/efi/efi-bgrt.c | 76 ++++++++++++++++++++++++++++++++-
 include/linux/efi-bgrt.h        | 39 ++++++++++++++++-
 2 files changed, 112 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 1da451582812..8f5f5edf5ede 100644
--- a/drivers/firmware/efi/efi-bgrt.c
+++ b/drivers/firmware/efi/efi-bgrt.c
@@ -16,8 +16,8 @@
 #include <linux/efi.h>
 #include <linux/efi-bgrt.h>
 
-struct acpi_table_bgrt bgrt_tab;
-size_t bgrt_image_size;
+struct acpi_table_bgrt bgrt_tab __ro_after_init;
+size_t bgrt_image_size __ro_after_init;
 
 struct bmp_header {
 	u16 id;
@@ -89,3 +89,75 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 out:
 	memset(bgrt, 0, sizeof(bgrt_tab));
 }
+
+/**
+ * efi_bgrt_has_image() - Whether the firmware left a boot graphic
+ *
+ * Return: true if the BGRT points at a BMP image, which efi_bgrt_init()
+ * checked and reserved, at an address that phys_addr_t can hold. The
+ * other accessors only mean something when it returns true.
+ */
+bool efi_bgrt_has_image(void)
+{
+	return bgrt_tab.image_address &&
+	       bgrt_tab.image_address == (phys_addr_t)bgrt_tab.image_address;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_has_image);
+
+/**
+ * efi_bgrt_image_address() - Physical address of the boot graphic
+ *
+ * Return: the address of the BMP image, or 0 if there is none.
+ */
+phys_addr_t efi_bgrt_image_address(void)
+{
+	return efi_bgrt_has_image() ? bgrt_tab.image_address : 0;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_image_address);
+
+/**
+ * efi_bgrt_image_size() - Size of the boot graphic
+ *
+ * Return: the size of the BMP image, as its header gives it, or 0 if there
+ * is none.
+ */
+size_t efi_bgrt_image_size(void)
+{
+	return efi_bgrt_has_image() ? bgrt_image_size : 0;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_image_size);
+
+/**
+ * efi_bgrt_status() - Status field of the BGRT
+ *
+ * Return: the status byte. Bit 0 tells whether the image is still on
+ * screen and, since ACPI 6.2, bits 1-2 how far it has to be turned to show
+ * upright (ACPI_BGRT_ORIENTATION_OFFSET).
+ */
+u8 efi_bgrt_status(void)
+{
+	return bgrt_tab.status;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_status);
+
+/**
+ * efi_bgrt_image_offset_x() - Horizontal position of the boot graphic
+ *
+ * Return: the X offset, in pixels, at which the firmware drew the image.
+ */
+u32 efi_bgrt_image_offset_x(void)
+{
+	return bgrt_tab.image_offset_x;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_image_offset_x);
+
+/**
+ * efi_bgrt_image_offset_y() - Vertical position of the boot graphic
+ *
+ * Return: the Y offset, in pixels, at which the firmware drew the image.
+ */
+u32 efi_bgrt_image_offset_y(void)
+{
+	return bgrt_tab.image_offset_y;
+}
+EXPORT_SYMBOL_GPL(efi_bgrt_image_offset_y);
diff --git a/include/linux/efi-bgrt.h b/include/linux/efi-bgrt.h
index e6cd51005633..1c287e5fd388 100644
--- a/include/linux/efi-bgrt.h
+++ b/include/linux/efi-bgrt.h
@@ -9,7 +9,14 @@
 void efi_bgrt_init(struct acpi_table_header *table);
 int __init acpi_parse_bgrt(struct acpi_table_header *table);
 
-/* The BGRT data itself; only valid if bgrt_image != NULL. */
+bool efi_bgrt_has_image(void);
+phys_addr_t efi_bgrt_image_address(void);
+size_t efi_bgrt_image_size(void);
+u8 efi_bgrt_status(void);
+u32 efi_bgrt_image_offset_x(void);
+u32 efi_bgrt_image_offset_y(void);
+
+/* The BGRT data itself; only valid if efi_bgrt_has_image(). */
 extern size_t bgrt_image_size;
 extern struct acpi_table_bgrt bgrt_tab;
 
@@ -21,6 +28,36 @@ static inline int __init acpi_parse_bgrt(struct acpi_table_header *table)
 	return 0;
 }
 
+static inline bool efi_bgrt_has_image(void)
+{
+	return false;
+}
+
+static inline phys_addr_t efi_bgrt_image_address(void)
+{
+	return 0;
+}
+
+static inline size_t efi_bgrt_image_size(void)
+{
+	return 0;
+}
+
+static inline u8 efi_bgrt_status(void)
+{
+	return 0;
+}
+
+static inline u32 efi_bgrt_image_offset_x(void)
+{
+	return 0;
+}
+
+static inline u32 efi_bgrt_image_offset_y(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_ACPI_BGRT */
 
 #endif /* _LINUX_EFI_BGRT_H */
-- 
2.39.5

