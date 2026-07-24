Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B540C531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 02:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B89A10E639;
	Fri, 24 Jul 2026 02:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="IKwMdT9p";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7626010E642;
 Fri, 24 Jul 2026 02:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784859956; x=1785464756; i=w_armin@gmx.de;
 bh=mlNmyLlL1iW90B0H147Wg/d30JCyeRZzRozRUv+IOOA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=IKwMdT9pJk5j1qoFcxtePmFo820vMOFNz2hyU4Yl/ldhWC9IVd5YrrwVv+nVlUrI
 kiG1acqRhGZiqDYevIOtqUODi9rmLr5b/xhhsgsZSavIm4cBmUgO6ejKBCraw1iD4
 UOx9fu8iY68eGsfzPSoZcBHmzFFrUFL9Qay9V8EG/OC+BB58GzgaVsw4lr+XYGl/4
 LYxi6GTQBk/WItSulYhvMwLPrcIB0DizNSZbbCMxAbzmlHnq7e8p3peUi+FF1w1e0
 K1u3pS25sjjq4eHZoUxBRaVxr7lZSQYga+0m65TjJpfBEEdp3t6DrQN+FcezmN5Eh
 eFdVLxbUY32djjNPEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MA7KU-1wfy3t4214-00H6B3; Fri, 24
 Jul 2026 04:25:56 +0200
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
Subject: [PATCH v2 3/3] platform/x86: wmi-bmof: Move to generic WMI code
Date: Fri, 24 Jul 2026 04:25:26 +0200
Message-Id: <20260724022526.139370-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724022526.139370-1-W_Armin@gmx.de>
References: <20260724022526.139370-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rea/9GZYvVTY9VQKVZnqhDzvVKz/9wxXCmGKJItDDFnjO67r62u
 QvtZuL/Tdv8jH1WJkdKQvAFH21MG1hSWcw2GKOm6Qi00YgD5wHxb4gJZkQzfi0VC2PkzxkP
 puFhYCWjQQf6cP4mZnSpZrZoR16qRD14d4MIN4iLPqun1er7ukQY20dR/5cyDSzB3ir2+EV
 WdCL+dx9UnXn3DnSI+Mfg==
UI-OutboundReport: notjunk:1;M01:P0:CwBWMzow/xg=;n/PNXhehUC4kAMNjhFH2QBhztMV
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

Some Windows-on-Arm notebooks contain embedded Binary MOF data,
accessible using the WMI-ACPI interface. Move the associated driver
to the generic WMI code to make it possible to build it on arm64.
Also rework the Kconfig help text a bit.

Link: https://lists.linaro.org/archives/list/aarch64-laptops@lists.linaro.=
org/thread/U2IZENSIOOHZHGXVN7GM5HX5O3FD5KCF/
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 MAINTAINERS                                     |  2 +-
 drivers/platform/wmi/Kconfig                    | 12 ++++++++++++
 drivers/platform/wmi/Makefile                   |  4 ++++
 drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} |  0
 drivers/platform/x86/Kconfig                    | 12 ------------
 drivers/platform/x86/Makefile                   |  3 ---
 6 files changed, 17 insertions(+), 16 deletions(-)
 rename drivers/platform/{x86/wmi-bmof.c =3D> wmi/bmof.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3820b286f09f..bbae729a6012 100644
=2D-- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29106,7 +29106,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/stable/sysfs-platform-wmi-bmof
 F:	Documentation/wmi/devices/wmi-bmof.rst
-F:	drivers/platform/x86/wmi-bmof.c
+F:	drivers/platform/wmi/bmof.c
=20
 WOLFSON MICROELECTRONICS DRIVERS
 L:	patches@opensource.cirrus.com
diff --git a/drivers/platform/wmi/Kconfig b/drivers/platform/wmi/Kconfig
index 36934b5f0194..11c221a58e04 100644
=2D-- a/drivers/platform/wmi/Kconfig
+++ b/drivers/platform/wmi/Kconfig
@@ -34,4 +34,16 @@ config ACPI_WMI_LEGACY_DEVICE_NAMES
=20
 source "drivers/platform/wmi/tests/Kconfig"
=20
+config WMI_BMOF
+	tristate "WMI embedded Binary MOF driver"
+	default ACPI_WMI
+	help
+	  Say Y here if you want to be able to read the firmware-embedded
+	  WMI Binary MOF (Managed Object Format) data. Using this requires
+	  userspace tools, see Documentation/wmi/devices/wmi-bmof.rst for
+	  details.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called wmi-bmof.
+
 endif # ACPI_WMI
diff --git a/drivers/platform/wmi/Makefile b/drivers/platform/wmi/Makefile
index 2feff94a5594..ee2f27ea20d1 100644
=2D-- a/drivers/platform/wmi/Makefile
+++ b/drivers/platform/wmi/Makefile
@@ -9,3 +9,7 @@ obj-$(CONFIG_ACPI_WMI)	+=3D wmi.o
=20
 # Unit tests
 obj-y			+=3D tests/
+
+# Binary MOF driver
+wmi-bmof-y		:=3D bmof.o
+obj-$(CONFIG_WMI_BMOF)	+=3D wmi-bmof.o
diff --git a/drivers/platform/x86/wmi-bmof.c b/drivers/platform/wmi/bmof.c
similarity index 100%
rename from drivers/platform/x86/wmi-bmof.c
rename to drivers/platform/wmi/bmof.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 957034f39e4e..889979034391 100644
=2D-- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -16,18 +16,6 @@ menuconfig X86_PLATFORM_DEVICES
=20
 if X86_PLATFORM_DEVICES
=20
-config WMI_BMOF
-	tristate "WMI embedded Binary MOF driver"
-	depends on ACPI_WMI
-	default ACPI_WMI
-	help
-	  Say Y here if you want to be able to read a firmware-embedded
-	  WMI Binary MOF (Managed Object Format) data. Using this requires
-	  userspace tools and may be rather tedious.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called wmi-bmof.
-
 config HUAWEI_WMI
 	tristate "Huawei WMI laptop extras driver"
 	depends on ACPI_BATTERY
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 872ac3842391..94a5fe4075cb 100644
=2D-- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -4,9 +4,6 @@
 # x86 Platform-Specific Drivers
 #
=20
-# Windows Management Interface
-obj-$(CONFIG_WMI_BMOF)		+=3D wmi-bmof.o
-
 # WMI drivers
 obj-$(CONFIG_HUAWEI_WMI)		+=3D huawei-wmi.o
 obj-$(CONFIG_MXM_WMI)			+=3D mxm-wmi.o
=2D-=20
2.39.5

