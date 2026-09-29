Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5580ACA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 09:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82FE710E9BD;
	Tue, 29 Sep 2026 09:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G3etLlL8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0010D10E9BD
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 09:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790674799; x=1822210799;
 h=from:date:to:cc:subject:in-reply-to:message-id:
 references:mime-version;
 bh=mYHd2x9gH2QrqNkIN6yVLhGCn/puXKYOmZh0XNuYC4Q=;
 b=G3etLlL8XXlUMaBWGmdyAxTCZvGatn0I/J5HMWkF0B7Q+24xAD/mEvll
 xGbXb9oG0XUB018nkAptFXUVbptum0CE0Ig6U8atnMUQ2aIMmD2GnI2mS
 ibBcFLu36Aw4vzsNtbHB+K49pASKI7ulRUtnH95fs2EjEJyH6W/jImZC6
 VK550wwmUycfEm3SfXSfmXgEE1MsuIIu6NZkFDb++NyNn7j385CqhGkxo
 gFoFqGBg8aRWwM70AY5JMMjkYnixpQ7tg5gFkkNQ/wDTp5z2jtyOT7waU
 7kRosw3+9KwooIIpZpdqh4gUngdbvBvTqnnZcguqlJ/KYr8D8SXCHojQ4 w==;
X-CSE-ConnectionGUID: saVRYswDR0CjB87hpo7l6A==
X-CSE-MsgGUID: juT67hUkSeyTetPQ1WQYWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90155116"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="90155116"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:39:58 -0700
X-CSE-ConnectionGUID: p2+jYi8cQ4aeKms3L6icWg==
X-CSE-MsgGUID: 0DgteiZ6Q4WQexaNFLOozA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273453717"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost)
 ([10.245.244.234])
 by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 02:39:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 29 Sep 2026 12:39:37 +0300 (EEST)
To: Sean Rhodes <sean@starlabs.systems>
cc: LKML <linux-kernel@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
 Corentin Chary <corentin.chary@gmail.com>, 
 "Luke D. Jones" <luke@ljones.dev>, Denis Benato <denis.benato@linux.dev>, 
 Prasanth Ksr <prasanth.ksr@dell.com>, Jorge Lopez <jorge.lopez2@hp.com>, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, 
 "Derek J. Clark" <derekjohn.clark@gmail.com>, 
 Joshua Grisham <josh@joshuagrisham.com>, Will Deacon <will@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>, 
 "Kiryl Shutsemau (Meta)" <kas@kernel.org>, 
 Huacai Chen <chenhuacai@kernel.org>, Chen-Yu Tsai <wenst@chromium.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 Tzung-Bi Shih <tzungbi@kernel.org>, 
 Brian Norris <briannorris@chromium.org>, 
 Julius Werner <jwerner@chromium.org>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, 
 Titouan Ameline de Cadeville <titouan.ameline@gmail.com>, 
 Laxman Acharya Padhya <acharyalaxman8848@gmail.com>, 
 Yidi Lin <yidilin@google.com>, Kees Cook <kees@kernel.org>, 
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, 
 chrome-platform@lists.linux.dev, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Geert Uytterhoeven <geert@linux-m68k.org>, Arnd Bergmann <arnd@arndb.de>, 
 Eric Biggers <ebiggers@kernel.org>, Luca Weiss <luca.weiss@fairphone.com>, 
 Michal Simek <michal.simek@amd.com>, Sven Peter <sven@kernel.org>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Linus Walleij <linusw@kernel.org>, Drew Fustini <fustini@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev
Subject: Re: [PATCH v14 1/5] firmware: Move firmware attributes class
 helper
In-Reply-To: <5682c2228fa4a784d3953664b56a06e0dd9ccdef.1788284852.git.sean@starlabs.systems>
Message-ID: <fd08c30b-c28f-2bac-f70f-143970de9a13@linux.intel.com>
References: <cover.1788284852.git.sean@starlabs.systems>
 <5682c2228fa4a784d3953664b56a06e0dd9ccdef.1788284852.git.sean@starlabs.systems>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-661677443-1790674777=:1173"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-661677443-1790674777=:1173
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 1 Sep 2026, Sean Rhodes wrote:

> Move the firmware attributes class helper from drivers/platform/x86 to
> drivers/firmware and expose its class declaration through a public Linux
> header.
>=20
> The helper is not x86-specific. Keeping it in drivers/firmware lets
> coreboot firmware drivers use the standard firmware-attributes ABI withou=
t
> living under platform/x86.
>=20
> Replace the affected drivers' relative helper includes directly with the
> new public header.
>=20
> Suggested-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Reviewed-by: Derek J. Clark <derekjohn.clark@gmail.com>
> Tested-by: Oliver Lin <oliver@liuxiaozhen.dev>
> Signed-off-by: Sean Rhodes <sean@starlabs.systems>
> ---
>  MAINTAINERS                                               | 8 ++++++++
>  drivers/firmware/Kconfig                                  | 3 +++
>  drivers/firmware/Makefile                                 | 1 +
>  .../x86 =3D> firmware}/firmware_attributes_class.c          | 2 +-
>  drivers/platform/x86/Kconfig                              | 3 ---
>  drivers/platform/x86/Makefile                             | 2 --
>  drivers/platform/x86/asus-armoury.c                       | 2 +-
>  drivers/platform/x86/dell/dell-wmi-sysman/sysman.c        | 2 +-
>  drivers/platform/x86/hp/hp-bioscfg/bioscfg.c              | 2 +-
>  drivers/platform/x86/lenovo/think-lmi.c                   | 2 +-
>  drivers/platform/x86/lenovo/wmi-other.c                   | 2 +-
>  drivers/platform/x86/samsung-galaxybook.c                 | 2 +-
>  .../linux/firmware_attributes.h                           | 6 +++---
>  13 files changed, 22 insertions(+), 15 deletions(-)
>  rename drivers/{platform/x86 =3D> firmware}/firmware_attributes_class.c =
(94%)
>  rename drivers/platform/x86/firmware_attributes_class.h =3D> include/lin=
ux/firmware_attributes.h (60%)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4dfc1fb14ef7..a8048eaf49e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10181,6 +10181,14 @@ F:=09include/linux/firewire.h
>  F:=09include/uapi/linux/firewire*.h
>  F:=09tools/firewire/
> =20
> +FIRMWARE ATTRIBUTES CLASS
> +M:=09Hans de Goede <hansg@kernel.org>
> +M:=09Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> +L:=09platform-driver-x86@vger.kernel.org
> +S:=09Maintained
> +F:=09drivers/firmware/firmware_attributes_class.c
> +F:=09include/linux/firmware_attributes.h
> +
>  FIRMWARE FRAMEWORK FOR ARMV8-A
>  M:=09Sudeep Holla <sudeep.holla@kernel.org>
>  L:=09linux-arm-kernel@lists.infradead.org (moderated for non-subscribers=
)
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index b7cc11e4fbfa..35dd6d422caf 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -8,6 +8,9 @@ menu "Firmware Drivers"
> =20
>  source "drivers/firmware/arm_scmi/Kconfig"
> =20
> +config FW_ATTR_CLASS
> +=09tristate
> +
>  config ARM_SCPI_PROTOCOL
>  =09tristate "ARM System Control and Power Interface (SCPI) Message Proto=
col"
>  =09depends on ARM || ARM64 || COMPILE_TEST
> diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
> index be46f1e1dc77..0e1e1b92a486 100644
> --- a/drivers/firmware/Makefile
> +++ b/drivers/firmware/Makefile
> @@ -17,6 +17,7 @@ obj-$(CONFIG_FIRMWARE_MEMMAP)=09+=3D memmap.o
>  obj-$(CONFIG_MTK_ADSP_IPC)=09+=3D mtk-adsp-ipc.o
>  obj-$(CONFIG_RASPBERRYPI_FIRMWARE) +=3D raspberrypi.o
>  obj-$(CONFIG_FW_CFG_SYSFS)=09+=3D qemu_fw_cfg.o
> +obj-$(CONFIG_FW_ATTR_CLASS)=09+=3D firmware_attributes_class.o
>  obj-$(CONFIG_SYSFB)=09=09+=3D sysfb.o
>  obj-$(CONFIG_SYSFB_SIMPLEFB)=09+=3D sysfb_simplefb.o
>  obj-$(CONFIG_TH1520_AON_PROTOCOL) +=3D thead,th1520-aon.o
> diff --git a/drivers/platform/x86/firmware_attributes_class.c b/drivers/f=
irmware/firmware_attributes_class.c
> similarity index 94%
> rename from drivers/platform/x86/firmware_attributes_class.c
> rename to drivers/firmware/firmware_attributes_class.c
> index 736e96c186d9..503ecc288086 100644
> --- a/drivers/platform/x86/firmware_attributes_class.c
> +++ b/drivers/firmware/firmware_attributes_class.c
> @@ -3,7 +3,7 @@
>  /* Firmware attributes class helper module */
> =20
>  #include <linux/module.h>
> -#include "firmware_attributes_class.h"
> +#include <linux/firmware_attributes.h>
> =20
>  const struct class firmware_attributes_class =3D {
>  =09.name =3D "firmware-attributes",
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 957034f39e4e..4851bf45157d 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -925,9 +925,6 @@ config DASHARO_ACPI
> =20
>  source "drivers/platform/x86/x86-android-tablets/Kconfig"
> =20
> -config FW_ATTR_CLASS
> -=09tristate
> -
>  config INTEL_IMR
>  =09bool "Intel Isolated Memory Region support"
>  =09depends on X86_INTEL_QUARK && IOSF_MBI
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefil=
e
> index 872ac3842391..cab20a4145e3 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -63,8 +63,6 @@ obj-$(CONFIG_X86_PLATFORM_DRIVERS_HP)=09+=3D hp/
>  # Hewlett Packard Enterprise
>  obj-$(CONFIG_UV_SYSFS)       +=3D uv_sysfs.o
> =20
> -obj-$(CONFIG_FW_ATTR_CLASS)=09+=3D firmware_attributes_class.o
> -
>  # IBM Thinkpad (before 2005)
>  obj-$(CONFIG_IBM_RTL)=09=09+=3D ibm_rtl.o
>  obj-$(CONFIG_SENSORS_HDAPS)=09+=3D hdaps.o
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/a=
sus-armoury.c
> index 93d9665717af..fb382de5b57b 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -21,6 +21,7 @@
>  #include <linux/dmi.h>
>  #include <linux/err.h>
>  #include <linux/errno.h>
> +#include <linux/firmware_attributes.h>
>  #include <linux/fs.h>
>  #include <linux/kernel.h>
>  #include <linux/kmod.h>
> @@ -35,7 +36,6 @@
>  #include <linux/sysfs.h>
> =20
>  #include "asus-armoury.h"
> -#include "firmware_attributes_class.h"
> =20
>  #define ASUS_NB_WMI_EVENT_GUID "0B3CBB35-E3C2-45ED-91C2-4C5A6D195D1C"
> =20
> diff --git a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c b/drivers=
/platform/x86/dell/dell-wmi-sysman/sysman.c
> index ab46a023cc34..ae89670f73b4 100644
> --- a/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> +++ b/drivers/platform/x86/dell/dell-wmi-sysman/sysman.c
> @@ -10,13 +10,13 @@
>  #include <linux/align.h>
>  #include <linux/fs.h>
>  #include <linux/dmi.h>
> +#include <linux/firmware_attributes.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/string.h>
>  #include <linux/sysfs.h>
>  #include <linux/wmi.h>
>  #include "dell-wmi-sysman.h"
> -#include "../../firmware_attributes_class.h"
> =20
>  #define MAX_TYPES  4
>  #include <linux/nls.h>
> diff --git a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c b/drivers/platf=
orm/x86/hp/hp-bioscfg/bioscfg.c
> index 309634c1cc20..d5a2d0963bbf 100644
> --- a/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> +++ b/drivers/platform/x86/hp/hp-bioscfg/bioscfg.c
> @@ -7,6 +7,7 @@
> =20
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> =20
> +#include <linux/firmware_attributes.h>
>  #include <linux/fs.h>
>  #include <linux/module.h>
>  #include <linux/kernel.h>
> @@ -14,7 +15,6 @@
>  #include <linux/string.h>
>  #include <linux/wmi.h>
>  #include "bioscfg.h"
> -#include "../../firmware_attributes_class.h"
>  #include <linux/nls.h>
>  #include <linux/errno.h>
> =20
> diff --git a/drivers/platform/x86/lenovo/think-lmi.c b/drivers/platform/x=
86/lenovo/think-lmi.c
> index a0e3fa766e37..ebfc6182986e 100644
> --- a/drivers/platform/x86/lenovo/think-lmi.c
> +++ b/drivers/platform/x86/lenovo/think-lmi.c
> @@ -14,13 +14,13 @@
>  #include <linux/acpi.h>
>  #include <linux/array_size.h>
>  #include <linux/errno.h>
> +#include <linux/firmware_attributes.h>
>  #include <linux/fs.h>
>  #include <linux/mutex.h>
>  #include <linux/string_helpers.h>
>  #include <linux/types.h>
>  #include <linux/dmi.h>
>  #include <linux/wmi.h>
> -#include "../firmware_attributes_class.h"
>  #include "think-lmi.h"
> =20
>  static bool debug_support;
> diff --git a/drivers/platform/x86/lenovo/wmi-other.c b/drivers/platform/x=
86/lenovo/wmi-other.c
> index fbb32bf404f2..b175971bb308 100644
> --- a/drivers/platform/x86/lenovo/wmi-other.c
> +++ b/drivers/platform/x86/lenovo/wmi-other.c
> @@ -33,6 +33,7 @@
>  #include <linux/container_of.h>
>  #include <linux/device.h>
>  #include <linux/export.h>
> +#include <linux/firmware_attributes.h>
>  #include <linux/gfp_types.h>
>  #include <linux/hwmon.h>
>  #include <linux/idr.h>
> @@ -50,7 +51,6 @@
>  #include "wmi-capdata.h"
>  #include "wmi-events.h"
>  #include "wmi-helpers.h"
> -#include "../firmware_attributes_class.h"
> =20
>  #define LENOVO_OTHER_MODE_GUID "DC2A8805-3A8C-41BA-A6F7-092E0089CD3B"
> =20
> diff --git a/drivers/platform/x86/samsung-galaxybook.c b/drivers/platform=
/x86/samsung-galaxybook.c
> index 99f72b204a51..88ef11004ad0 100644
> --- a/drivers/platform/x86/samsung-galaxybook.c
> +++ b/drivers/platform/x86/samsung-galaxybook.c
> @@ -14,6 +14,7 @@
>  #include <linux/acpi.h>
>  #include <linux/bits.h>
>  #include <linux/err.h>
> +#include <linux/firmware_attributes.h>
>  #include <linux/i8042.h>
>  #include <linux/init.h>
>  #include <linux/input.h>
> @@ -28,7 +29,6 @@
>  #include <linux/uuid.h>
>  #include <linux/workqueue.h>
>  #include <acpi/battery.h>
> -#include "firmware_attributes_class.h"
> =20
>  #define DRIVER_NAME "samsung-galaxybook"
> =20
> diff --git a/drivers/platform/x86/firmware_attributes_class.h b/include/l=
inux/firmware_attributes.h
> similarity index 60%
> rename from drivers/platform/x86/firmware_attributes_class.h
> rename to include/linux/firmware_attributes.h
> index d27abe54fcf9..d4026ba1fcc2 100644
> --- a/drivers/platform/x86/firmware_attributes_class.h
> +++ b/include/linux/firmware_attributes.h
> @@ -2,11 +2,11 @@
> =20
>  /* Firmware attributes class helper module */
> =20
> -#ifndef FW_ATTR_CLASS_H
> -#define FW_ATTR_CLASS_H
> +#ifndef _LINUX_FIRMWARE_ATTRIBUTES_H
> +#define _LINUX_FIRMWARE_ATTRIBUTES_H
> =20
>  #include <linux/device/class.h>
> =20
>  extern const struct class firmware_attributes_class;
> =20
> -#endif /* FW_ATTR_CLASS_H */
> +#endif /* _LINUX_FIRMWARE_ATTRIBUTES_H */

Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-661677443-1790674777=:1173--
