Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063B8C531D0
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B959410E644;
	Fri, 24 Jul 2026 02:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="Dzzv8Xl5";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29EDD10E662;
 Fri, 24 Jul 2026 02:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784860289; x=1785465089; i=w_armin@gmx.de;
 bh=5VxiPprzspzEFP140Z6/uv8kfqLBbbbv/Zr5wSXUh0s=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Dzzv8Xl5tDqUd5dPrglAJNA/UVu7KxCJqyxnauQKrglPiYAyXTXTuufKgW70e0cZ
 FICLn4ovdpyBJ1+SyT5WkuNWwB4aCn1VoZfqCnV7O6nrJiiDQgZIHx6u2Rnw88d6v
 a2yHf3X4cG+fbwivU4FE6+GBVWPFcsiTCSbFDCrmbR+dS/9lnXFlR4jXcUP2oM+kS
 DqtdDQD41smStfoL5XhoAy6SGn/+uJeJ1+9L7HZmW8ejzGHHiHDG5f0tSzxZ83ed0
 vWAPPr7hGXirHw9vnegCCzOFDrtkNBKGBae292wC6rvpljQaUy1aF7qOoBVHlmbQz
 z3qKl1/iDZHU/I+Bpw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVvLB-1wO1hf20pR-00VBRN; Fri, 24
 Jul 2026 04:25:54 +0200
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
Subject: [PATCH v2 2/3] ACPI: video: Remove CONFIG_X86 handling from
 nvidia_wmi_ec_supported()
Date: Fri, 24 Jul 2026 04:25:25 +0200
Message-Id: <20260724022526.139370-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724022526.139370-1-W_Armin@gmx.de>
References: <20260724022526.139370-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6dj0A5FGhDOBqzpKuOL4VSh1nP2e5ndoZ/6jqS3pldrLEmbmIYM
 NKg+r2/Ga5q+ik0V/EAjWe52CJ4MWCh+aJrT9DatrOrfz9pN6z8SoNWfVDg8EinA+Rzn/r+
 GZanIjjigG6rcCl2N3qFASw2BDoHglsGTF0HvwB4tqOYudlCpModZfXpHsAvkuaAc61PU1j
 4QWgjAIfnBTggKFmSYKow==
UI-OutboundReport: notjunk:1;M01:P0:gd+f9aaT/9Q=;/2kDIAwY9UBtuSSk43dLU7n1INQ
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
GPU drivers to simplify the resulting code.

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
 7 files changed, 5 insertions(+), 20 deletions(-)

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
=2D-=20
2.39.5

