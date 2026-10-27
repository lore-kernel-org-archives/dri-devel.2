Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D395960A381F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WlqC05TG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D4810F574;
	Tue, 27 Oct 2026 13:53:59 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617A110F586
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:53:51 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48e0d885929so2819279f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793109230; x=1793714030; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=G1+nfUJ+NP0zqKdPIyJvkG8NMwha03wen6k4s/kDOuc=;
 b=WlqC05TGKRvojqneSpFV/WadjLkpo2oCd5i8nwzik6dIzY5rD5XFKy+M9QdDitIxY+
 TkI4ExmLF8CxVuTRufY97RHWI7tIFgvNNT7aZATNElG6NEYV/vMnoEP/M6GorgozyYCE
 t40FrL1zKJhdt0ZzXsBzr8I0fdY7Y1MI+6Tfv9Q+xMWgb403atGBKDguQiANoYSJ1qu8
 0XzP3S8WOCiWRgsfDkr8MSzg+hmjDfuNy8XhazRH8xn4pqJIBWfGqErbhn0/XzYH1j76
 z0jdoPoE1gp63Y+dXg5dwGd+FWV6PBwI0O1QEZpMc1w2jA2qW95XKeBPs008faa1HE4w
 q6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109230; x=1793714030;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=G1+nfUJ+NP0zqKdPIyJvkG8NMwha03wen6k4s/kDOuc=;
 b=lHGHqiAxAg8Ht2dPxMzQWVm9qD4PVRHW9K5QPFE1JrAo3DC57nqPVejTfQhQcTnAYX
 7XiB5gaI+TQ76fpvya5BGmKh7HHaS5re/d+XU8raA9bHkAgCYnFT5MroP/3687zogeAb
 QlFBWXmSEOiGxrAA8ono1owys2DJu5pNBsB5RoS7narLNWup4x7DDJviCKycp1cVm7lt
 E9YbJGdQEIuUJWe5kATKBHIB5Ee1tvg0BuVLlmqRt3cE7am70HSLqUmzoCbdQjqREPOK
 SdLGCVjqpRPTEl76PFfwtZaqO0DgcDZYt0Hl9dIYfs3R2qNwO2v45Jc3NpaGG+T4qZ3y
 rHkw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5ag4n0pb1an8qvvDBf4TeayN25c5ejNC8RZ0e8yWqFeMY//DEasebvFSJQH+XqJ96+282eYCV/zY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIgFfursXQmIPPBkglb3OLB2mA6oNLMN/outc/IqByfi4And8pg
 fB5v9yZ6yGCazcr8uHkaS5cpRTuJBYmE77xJuzNbWd3V12aX8Vv3lnQi
X-Gm-Gg: AYBFou3fCimrPRGr0Ul77z7hpZMdD6vCZNdycVT9ip9IENR+ffyLUgccszUWNoVjxQ8
 QBWOpHVomj8G89bOqS43jfQy1fp97JlgOXnNXgAPA72Fh/eX80eAVALCN9gnQnajYND/TaPhk6Z
 FEIgWP+ifWFir2xHvRxYvDwRaGWeSIANnqkW7vjy3WWi3BwuHudSYiC09Xe2PIjTUANt2YTSWE3
 leX2ukLfSsbJfVX/amAMKWubYHwmeROJhgGa4fGZjx0lhuB0Et029drkBhuRoajSR2YurSBz6PW
 7GhF5WpRSBDQspAwFN56JH4lhfizYENtsIHP2onQNzY8If8UO/rVHdDjOhfepTszWcD3ieRoV/1
 +ImChBZx1oubdpUzkZzjvxqbNb3ZfC/nZz2GJMNuv/nhMSU2NKVxPt5wSWPHyb7no70gltHVkMu
 PM3LmNuy+UsX9fHQ6JK/rxFqIn9RlNL3ecWo3dJLWCsgM2MnAJYRU6mR60W111h+9vX5Z/O56Ru
 y4UBEHxuJt8lEtyd7TobwdfkTEKqDWnqtLwTYrEloarBZuiB3HPdbrfoD/YpU+whrS8PIegy5Oz
 g/WqFNI=
X-Received: by 2002:a05:6000:29d5:b0:48e:f47:273c with SMTP id
 ffacd0b85a97d-48e3eb45747mr11349441f8f.8.1793109229602; 
 Tue, 27 Oct 2026 06:53:49 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.53.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:53:48 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
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
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 02/15] efi: bgrt: add accessors for the boot graphics
Date: Tue, 27 Oct 2026 14:53:29 +0100
Message-Id: <20261027135342.2003632-3-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
says yes when phys_addr_t can hold it, so that it never disagrees with
efi_bgrt_image_address() on kernels with 32-bit physical addresses.

Reported-by: Mario Limonciello <mario.limonciello@amd.com>
Closes: https://lore.kernel.org/dri-devel/5d7067de-97b7-4232-9cf6-e4b978696482@amd.com/
Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/firmware/efi/efi-bgrt.c | 75 ++++++++++++++++++++++++++++++++-
 include/linux/efi-bgrt.h        | 39 ++++++++++++++++-
 2 files changed, 111 insertions(+), 3 deletions(-)

diff --git a/drivers/firmware/efi/efi-bgrt.c b/drivers/firmware/efi/efi-bgrt.c
index 1da451582812..1affe5528139 100644
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
@@ -89,3 +89,74 @@ void __init efi_bgrt_init(struct acpi_table_header *table)
 out:
 	memset(bgrt, 0, sizeof(bgrt_tab));
 }
+
+/**
+ * efi_bgrt_has_image() - Whether the firmware left a boot graphic
+ *
+ * Return: true if the BGRT points at a BMP image, which efi_bgrt_init()
+ * checked and reserved, at an address that phys_addr_t can hold.
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
+	return bgrt_tab.image_address;
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
+	return bgrt_image_size;
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

