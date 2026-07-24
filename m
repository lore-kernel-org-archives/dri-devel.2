Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0932FC531CC
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 03:00:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D3E10F28D;
	Fri, 24 Jul 2026 03:00:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="Us8nBLLs";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F6BE10F28D;
 Fri, 24 Jul 2026 03:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1784862022; x=1785466822; i=w_armin@gmx.de;
 bh=mlNmyLlL1iW90B0H147Wg/d30JCyeRZzRozRUv+IOOA=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=Us8nBLLs2daoeYflEbg/gq+U0yg309JtkRCNklYcbH4XfFNyArHoBE1Kq2iG8gJQ
 XoR9KKw1Sd0tA3zA8BIUpsP9Edghge3Dx2DEM6jwd3kH4hCANYFLZzKHy9OGl+Yoy
 hqVgoE1yBd5eGqZZnz6uteMIDyoX4RhwePYWEA4d+BwPxzxHIi4x/2jziuUuqYpZg
 NYgRYpK/saAP4R7GOnHXYnTnTbZJ//IC+Q735WSpjGnp8mi8x0VkwzLOzeBwUlxWU
 KTp9z71gwLu+oamT38o5MA8JAj1OJ4SiW7TVQKBC6aNGxx4wNZ3P5ovpgre8Guz43
 zQPPC/UT0L17Sp0ktA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDIo-1xDOUQ0AYy-00fPFH; Fri, 24
 Jul 2026 05:00:22 +0200
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
Subject: [PATCH v3 3/3] platform/x86: wmi-bmof: Move to generic WMI code
Date: Fri, 24 Jul 2026 04:59:59 +0200
Message-Id: <20260724025959.142826-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260724025959.142826-1-W_Armin@gmx.de>
References: <20260724025959.142826-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lC8Nm23G2Ft5kDA4hIh2S4jguiXIFp8hY6klzZ5bPL/r62/IyIC
 y4Ent/gUu6OYSQOYs4rs82W8gkPbWi71h3sKHQr+5ftl/PbulBzPgaQfPOE2icvg0z0bfIb
 27171TN81Fq+pKwaSEaTgw0t6cn3rAw9EkR7uTL6yTMy9TdbD5Q0sQCq+qZ3bhjld0niVKv
 HvpR3E51qtyMwIA1+fryA==
UI-OutboundReport: notjunk:1;M01:P0:aHD8YHDmDEE=;3mw208v1Esw2YdMn4NfHIL1aAfE
 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
 KhHw0EN1Yz61hRkTi/RPi
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

