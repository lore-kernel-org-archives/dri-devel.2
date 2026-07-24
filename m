Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA7F8C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:00:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24BB210F282;
	Fri, 24 Jul 2026 03:00:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="SnxnK4K9";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E76C10F282;
 Fri, 24 Jul 2026 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784862017; x=1785466817; i=w_armin@gmx.de;
 bh=ovJi0UjSdsGD4/T+fxPFqvkdAjjSpbB5MCW5V7fshvg=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=SnxnK4K9eDHOtycNXzGlh863BWcQt1NnVr/wkGkj0e9rzWxWSt83JfZQruk82nE5
 IikWE/9XiBfS5PKjIy/ULFrIkR1AQCbix2/Wmjv2KQ5ICICQYFv+XncGyTc2qlXaA
 yT/FwEweV5F3ho7OJbd/R5Fv2PNCqUt8k/qQAB20lbqL7hVX+U3652Sor51cssfuy
 /2RkjgoCAY5fczFw2OYRmbF6zuVcm7u0yi2RdncJ7yPOGEN8QEH/i5VnRL10ChMyY
 pZSav2/nbLaZHrpw5BGkAfhjLclhQHnaqajNbax1uObn7ewlOjMZoYc8eLvINLaxe
 Z48fiKAQuiGAz8qyLw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8QS2-1wrTrl1Hii-00ACSd; Fri, 24
 Jul 2026 05:00:17 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@weissschuh.net, rafael@kernel.org, lenb@kernel.org,
 linux-acpi@vger.kernel.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com,
 tursulin@ursulin.net, intel-gfx@lists.freedesktop.org,
 matthew.brost@intel.com, thomas.hellstrom@linux.intel.com,
 intel-xe@lists.freedesktop.org
Subject: [PATCH v3 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
Date: Fri, 24 Jul 2026 04:59:58 +0200
Message-Id: <20260724025959.142826-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724025959.142826-1-W_Armin@gmx.de>
References: <20260724025959.142826-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dZfUtxnkcPwVTlzjUCQ/xt9BGxXUfnXT0Dt7PFm022luHHWqzFX
 kZNfo7S3MUbKYDMiRN9U6mEg122Km+4liVPvmu0lRGJrKCTEkZdkkcxZaQWwV0/aEwFjZer
 OIgFNeIykwYzmqePwQLFpEgCl4w37BAByK757kyUO5CKGvmCFCk5FjT3mVsmSHlIJViVZtP
 AwH5bMxJaE+4UxCPwp9zQ==
UI-OutboundReport: notjunk:1;M01:P0:qQnxKNf+8fw=;xGu1BNFZEvnE2+gc/xTM1AKFHLD
 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
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

The WMI-ACPI driver now supports architectures other than x86.
Remove the CONFIG_X86 handling from video-detect and the associated
drivers to simplify the resulting code.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/Kconfig               | 2 +-
 drivers/acpi/video_detect.c        | 8 --------
 drivers/gpu/drm/amd/amdgpu/Kconfig | 4 +---
 drivers/gpu/drm/gma500/Kconfig     | 1 -
 drivers/gpu/drm/i915/Kconfig       | 1 -
 drivers/gpu/drm/radeon/Kconfig     | 4 +---
 drivers/gpu/drm/xe/Kconfig         | 5 ++---
 drivers/platform/loongarch/Kconfig | 1 +
 8 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..cc1e58fa664b 100644
=2D-- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -224,7 +224,7 @@ config ACPI_VIDEO
 	tristate "Video"
 	depends on BACKLIGHT_CLASS_DEVICE
 	depends on INPUT
-	depends on ACPI_WMI || !X86
+	depends on ACPI_WMI
 	select THERMAL
 	help
 	  This driver implements the ACPI Extensions For Display Adapters
diff --git a/drivers/acpi/video_detect.c b/drivers/acpi/video_detect.c
index 458efa4fe9d4..af9280b244f1 100644
=2D-- a/drivers/acpi/video_detect.c
+++ b/drivers/acpi/video_detect.c
@@ -82,8 +82,6 @@ find_video(acpi_handle handle, u32 lvl, void *context, v=
oid **rv)
 	return AE_OK;
 }
=20
-/* This depends on ACPI_WMI which is X86 only */
-#ifdef CONFIG_X86
 static bool nvidia_wmi_ec_supported(void)
 {
 	struct wmi_brightness_args args =3D {
@@ -105,12 +103,6 @@ static bool nvidia_wmi_ec_supported(void)
 	 */
 	return args.ret =3D=3D WMI_BRIGHTNESS_SOURCE_EC;
 }
-#else
-static bool nvidia_wmi_ec_supported(void)
-{
-	return false;
-}
-#endif
=20
 /* Force to use vendor driver when the ACPI device is known to be
  * buggy */
diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdg=
pu/Kconfig
index 12e4a41bf1f0..50305630f533 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -30,9 +30,7 @@ config DRM_AMDGPU
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
+	select ACPI_WMI if ACPI
 	help
 	  Choose this option if you have a recent AMD Radeon graphics card.
=20
diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconf=
ig
index a2acaa699dd5..dc4c56638819 100644
=2D-- a/drivers/gpu/drm/gma500/Kconfig
+++ b/drivers/gpu/drm/gma500/Kconfig
@@ -11,7 +11,6 @@ config DRM_GMA500
 	select ACPI_VIDEO if ACPI
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
 	help
 	  Say yes for an experimental 2D KMS framebuffer driver for the
diff --git a/drivers/gpu/drm/i915/Kconfig b/drivers/gpu/drm/i915/Kconfig
index 5e939004b646..71426b9c91f0 100644
=2D-- a/drivers/gpu/drm/i915/Kconfig
+++ b/drivers/gpu/drm/i915/Kconfig
@@ -28,7 +28,6 @@ config DRM_I915
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select X86_PLATFORM_DEVICES if ACPI
 	select ACPI_WMI if ACPI
 	select ACPI_VIDEO if ACPI
 	select SYNC_FILE
diff --git a/drivers/gpu/drm/radeon/Kconfig b/drivers/gpu/drm/radeon/Kconf=
ig
index c479f0c0dd5c..3cd70aef770e 100644
=2D-- a/drivers/gpu/drm/radeon/Kconfig
+++ b/drivers/gpu/drm/radeon/Kconfig
@@ -25,9 +25,7 @@ config DRM_RADEON
 	# ACPI_VIDEO's dependencies must also be selected.
 	select INPUT if ACPI
 	select ACPI_VIDEO if ACPI
-	# On x86 ACPI_VIDEO also needs ACPI_WMI
-	select X86_PLATFORM_DEVICES if ACPI && X86
-	select ACPI_WMI if ACPI && X86
+	select ACPI_WMI if ACPI
 	help
 	  Choose this option if you have an ATI Radeon graphics card.  There
 	  are both PCI and AGP versions.  You don't need to choose this to
diff --git a/drivers/gpu/drm/xe/Kconfig b/drivers/gpu/drm/xe/Kconfig
index 4d7dcaff2b91..502c7b3c1f16 100644
=2D-- a/drivers/gpu/drm/xe/Kconfig
+++ b/drivers/gpu/drm/xe/Kconfig
@@ -4,7 +4,6 @@ config DRM_XE
 	depends on DRM && PCI
 	depends on KUNIT || !KUNIT
 	depends on INTEL_VSEC || !INTEL_VSEC
-	depends on X86_PLATFORM_DEVICES || !(X86 && ACPI)
 	depends on PAGE_SIZE_4KB || COMPILE_TEST || BROKEN
 	select INTERVAL_TREE
 	# we need shmfs for the swappable backing store, and in particular
@@ -29,8 +28,8 @@ config DRM_XE
 	# but for select to work, need to select ACPI_VIDEO's dependencies, ick
 	select BACKLIGHT_CLASS_DEVICE if ACPI
 	select INPUT if ACPI
-	select ACPI_VIDEO if X86 && ACPI
-	select ACPI_WMI if X86 && ACPI
+	select ACPI_VIDEO if ACPI
+	select ACPI_WMI if ACPI
 	select SYNC_FILE
 	select CRC32
 	select SND_HDA_I915 if SND_HDA_CORE
diff --git a/drivers/platform/loongarch/Kconfig b/drivers/platform/loongar=
ch/Kconfig
index 447528797d07..db7833842142 100644
=2D-- a/drivers/platform/loongarch/Kconfig
+++ b/drivers/platform/loongarch/Kconfig
@@ -23,6 +23,7 @@ config LOONGSON_LAPTOP
 	depends on INPUT
 	depends on MACH_LOONGSON64
 	select ACPI_VIDEO
+	select ACPI_WMI
 	select INPUT_SPARSEKMAP
 	default y
 	help
=2D-=20
2.39.5

