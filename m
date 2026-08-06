Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00EC0C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 06:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2312010F392;
	Fri,  7 Aug 2026 06:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=starlabs-systems.20251104.gappssmtp.com header.i=@starlabs-systems.20251104.gappssmtp.com header.b="QqwhGIvR";
	dkim-atps=neutral
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com
 [74.125.224.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95A8210E124
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 20:28:41 +0000 (UTC)
Received: by mail-yx1-f50.google.com with SMTP id
 956f58d0204a3-664b05d408bso2615737d50.1
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 13:28:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786048120; cv=none;
 d=google.com; s=arc-20260327;
 b=g42EIxe6uuwCK6yrxtGKj5GKiOxyThilPJs7Syf2GCUD/PYUnEINx9OWd5OfteA7ky
 ZnJ23JD0etJiGRGyaH15sIs7wI9pbQJUTA1ZGvlONr8hexeB+QzI27Dg32lMGCmoSnOO
 YNqlyq8hgvZBpqC1h/NhSia3NIt00/4Xq8DBO3d+/txwZ8T772A25zPAQLbF3v8RxfXu
 LZDltNPYPcr/6Sq2zWBDNja/gEESKKZWn3bzbNKrlAHB8wPiN1Gr+4CjOwvn/Bp03XBj
 VNhWXeP/lqemb2QGyQd1Dkb0YYHHnNE4+mC2Vdku1oKVc9SY07Ew8YpTxTRW+azHoxzS
 6r8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=3TNGtkZrJZMTa7BVrBgE0cCezgn0J9vttJ69hoLRvOk=;
 fh=rR20LzofSIrXecxG+e/9Wix5YqlPFzouOMNo6x2EUsc=;
 b=OMq3MXFSI4ukH2tWGiDTJKY5W3mfLzEivzGw3oWCFsZkugMpwMcq6FDQDAE6GiswO5
 FyJQ3IqLMK6YotMQYPKm6eJwjQMwy8s7L9dxFAGyjsEMvJOERVLPlQcOQAtZYyC5i63R
 n3g5wfYqYeAznS+GNCVCz/IOJwUWjyMb9skiWK8wgNbGShfv1F/g666JWqLoRwI5HIRF
 JXhSqg9TdGSJtZWuD8mmZW3UExgvzDC/hZIpezCkM38WY2bu11brhNDvSmD2Y/YwTHYc
 kg5VW7yQ1qPVBTtyRTTXZ7UHorstIq057OGMQZIaWQcpIQfg1R+eYS45esLPHpD7PgJa
 a+dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=starlabs-systems.20251104.gappssmtp.com; s=20251104; t=1786048120;
 x=1786652920; darn=lists.freedesktop.org; 
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3TNGtkZrJZMTa7BVrBgE0cCezgn0J9vttJ69hoLRvOk=;
 b=QqwhGIvR1nSYn+2/gttoVgvi53md7eO5xQGwKF1fTJ+zimsYZa0+EILgk1CpfUnXoc
 wr/D8e5oBKwdHcDkqFtvvA9Il2B/w3LLM+kUZlmB0gtPUnP/Mu54S/cv277N9JeUGJIp
 uixXbTlHFpZrhhgAhC7xxzlH/0av0AUKfL4LIGsesypLWJutrgonheLi0klBUco5Edwg
 oX0mYvFP9jGRQDX5l14T5d/1K9GdpPg7B24Anfqx9JfPsbfWBs6hBL+iO/ylMTsm3yda
 BT/rKn3pK/fc3vlNPnzOdVKT87IeIu5qbLSXhdx0VDkBOV/yDCmWAS32CglntDgyARws
 6g4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786048120; x=1786652920;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=3TNGtkZrJZMTa7BVrBgE0cCezgn0J9vttJ69hoLRvOk=;
 b=jYp4LmMqQr6O9/dJQR1FARdQ9JiPTrbHpGCBRyikXPoCp+/i9jCJmpussn7zueoGd/
 xzQJxM7jtDr197x/CPMeQc0TKHRoziVILHopTYj53Y6UqpMtGx41P222p0fX2w3UKVBV
 ChzP4V37mI/KXC/7KXbY3Ar5nSREMCL5J5QgC0ZrhVbk62gQI3j0tRLOfrzU6rFTG5rP
 oOT7Fg5keURQfc3UD+X3bdmM5O59xjym2FbmrGVk3HORMuwqgM5mn1tpFrRNdRkkqziA
 N/n7Bj9yczV8WrHjLCC9X0OnCyqPqAYQNbeYYGRgtX83rZMcdLz3BbpthIb4UxwjzQqh
 dRfg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp3l7zJeMBPUwjFyk/5y8axkECw/KtohJXOkgyTO9G4DpLIfgcJ22t2c+l+e2CY4389/Kp5aFPim9U=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzrA1TlMJSRV/7sKV1E4jguP0vrp01uZtBv292nQSAlCQOuKylt
 p0CfEeU0wgTdfHxV+z/WiH7SloRRsWnqQTXBzeBLYcMRn5xtdXVq6pO/VuQV0IclQDw8y9FXgme
 56uXVdEzes9u1ke4KU6+Ok26fkTKrS3R30Qmcj1RE
X-Gm-Gg: AR+sD13eokcuLe02EaJnmGnjiSlaPHnYdc/iBsTT1xjANuvClKIzUWJP2QUcO/VsAWz
 UjGFTprHKfLuTut0xC5OWWMn8bqRa//mNo4XBz2n6Hk4m6vmV0pcwa2kvG5Rbuz3tQpHG+27ieI
 vGoVb7MVI/rY5rOFiniLSsMLtRuMmTfv2U4aWt7Tyz7jff+DDhC3yR04aYK0gjtAQmIjb/RvR+8
 ouE4YrDz0z1Hf5QHD73qUViZfCbEmEeNLpXyCrYPzsYUhfvaSl88wr+6ReA6VYrfqLQFV133NNx
 e66ALpxagosTjN1NfUvoRGiVNdniI1EDfQegutpexCJvyyCYljRfX/3VFzzzHsRoEquOCwJeCQ=
 =
X-Received: by 2002:a05:690e:250b:10b0:667:a95b:59f0 with SMTP id
 956f58d0204a3-6699abcfe28mr8412043d50.34.1786048120103; Thu, 06 Aug 2026
 13:28:40 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:39 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST; 
 Thu, 6 Aug 2026 13:28:39 -0700
MIME-Version: 1.0
From: Sean Rhodes <sean@starlabs.systems>
Date: Thu, 6 Aug 2026 13:28:39 -0700
X-Gm-Features: AUfX_myiLt_h0WcpX8lOUgnJy9ZTuM66XUJB4yBHSgF1Gffx17pNczfeWWTd7vM
Message-ID: <CABtds-2qyH84oOG_JhXN6eNQOV9H9vhQvSG4JCv5E+r9VdwKcw@mail.gmail.com>
Subject: [PATCH v12 4/4] firmware: coreboot: Add CFR firmware attributes driver
To: chrome-platform@lists.linux.dev
Cc: corentin.chary@gmail.com, luke@ljones.dev, denis.benato@linux.dev, 
 hansg@kernel.org, ilpo.jarvinen@linux.intel.com, prasanth.ksr@dell.com, 
 jorge.lopez2@hp.com, mpearson-lenovo@squebb.ca, derekjohn.clark@gmail.com, 
 josh@joshuagrisham.com, platform-driver-x86@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 florian.fainelli@broadcom.com, chenhuacai@kernel.org, mst@redhat.com, 
 wenst@chromium.org, tzungbi@kernel.org, briannorris@chromium.org, 
 jwerner@chromium.org, tzimmermann@suse.de, javierm@redhat.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com, 
 simona@ffwll.ch, krzysztof.kozlowski@oss.qualcomm.com, andersson@kernel.org, 
 geert@linux-m68k.org, dmitry.baryshkov@oss.qualcomm.com, arnd@arndb.de, 
 ebiggers@kernel.org, luca.weiss@fairphone.com, michal.simek@amd.com, 
 sven@kernel.org, u.kleine-koenig@baylibre.com, bhelgaas@google.com, 
 dakr@kernel.org, o-takashi@sakamocchi.jp, titouan.ameline@gmail.com, 
 kees@kernel.org, dri-devel@lists.freedesktop.org, oliver@liuxiaozhen.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 07 Aug 2026 06:47:17 +0000
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

coreboot can publish a CFR tree in its coreboot table to describe
firmware setup options. Add a firmware-attributes driver for that table
entry under the coreboot firmware driver directory.

The driver exposes runtime EFI variable-backed boolean, enum and integer
settings through the firmware-attributes ABI. It only registers settings
with readable runtime EFI variables, skips suppressed, volatile,
dependency-gated and non-runtime options, and keeps read-only or inactive
options read-only in sysfs.

For settings with an APM_CNT runtime-apply record, write the EFI variable
and ask firmware to apply the setting immediately on x86. If firmware
reports a failure, restore the old EFI variable value. Settings without a
runtime apply hook, or non-x86 builds, keep the EFI variable update and
set pending_reboot.

Tested on a Star Labs Byte with firmware 26.07: runtime APM_CNT apply
was verified with power_led, and reboot-needed behavior was verified with
debug_level.

Link: https://doc.coreboot.org/drivers/cfr.html
Link: https://doc.coreboot.org/drivers/cfr_internal.html
Signed-off-by: Sean Rhodes <sean@starlabs.systems>
---
 MAINTAINERS                              |    6 +
 drivers/firmware/coreboot/Kconfig        |   14 +
 drivers/firmware/coreboot/Makefile       |    1 +
 drivers/firmware/coreboot/coreboot-cfr.c | 1208 ++++++++++++++++++++++
 4 files changed, 1229 insertions(+)
 create mode 100644 drivers/firmware/coreboot/coreboot-cfr.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 62ddee473f55..50638f37e023 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6666,6 +6666,12 @@ F:	tools/testing/selftests/cgroup/test_hugetlb_memcg.c
 F:	tools/testing/selftests/cgroup/test_kmem.c
 F:	tools/testing/selftests/cgroup/test_memcontrol.c

+COREBOOT CFR FIRMWARE ATTRIBUTES DRIVER
+M:	Sean Rhodes <sean@starlabs.systems>
+L:	chrome-platform@lists.linux.dev
+S:	Maintained
+F:	drivers/firmware/coreboot/coreboot-cfr.c
+
 CORETEMP HARDWARE MONITORING DRIVER
 L:	linux-hwmon@vger.kernel.org
 S:	Orphan
diff --git a/drivers/firmware/coreboot/Kconfig
b/drivers/firmware/coreboot/Kconfig
index b248bafe8b6b..5c37bdc9c9fd 100644
--- a/drivers/firmware/coreboot/Kconfig
+++ b/drivers/firmware/coreboot/Kconfig
@@ -44,6 +44,20 @@ config GOOGLE_COREBOOT_TABLE
 	  device tree node /firmware/coreboot.
 	  If unsure say N.

+config COREBOOT_CFR
+	tristate "coreboot CFR firmware attributes"
+	depends on EFI
+	depends on GOOGLE_COREBOOT_TABLE
+	select CRC32
+	select FW_ATTR_CLASS
+	help
+	  This driver parses the coreboot CFR table and exposes runtime EFI
+	  variable-backed options through the firmware-attributes sysfs
+	  interface.
+
+	  If you have a system running coreboot with CFR runtime
+	  configuration support, say Y or M here.
+
 config GOOGLE_MEMCONSOLE
 	tristate
 	depends on GOOGLE_MEMCONSOLE_X86_LEGACY || GOOGLE_MEMCONSOLE_COREBOOT
diff --git a/drivers/firmware/coreboot/Makefile
b/drivers/firmware/coreboot/Makefile
index 8151e323cc43..1b9d0c0e7593 100644
--- a/drivers/firmware/coreboot/Makefile
+++ b/drivers/firmware/coreboot/Makefile
@@ -2,6 +2,7 @@

 obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
 obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
+obj-$(CONFIG_COREBOOT_CFR)		+= coreboot-cfr.o
 obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
 obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
diff --git a/drivers/firmware/coreboot/coreboot-cfr.c
b/drivers/firmware/coreboot/coreboot-cfr.c
new file mode 100644
index 000000000000..54aae1442bcc
--- /dev/null
+++ b/drivers/firmware/coreboot/coreboot-cfr.c
@@ -0,0 +1,1208 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * coreboot CFR firmware attributes driver.
+ *
+ * Parses LB_TAG_CFR_ROOT records from the coreboot table and exposes
+ * runtime EFI variable-backed options through the firmware-attributes class.
+ */
+
+#include <linux/array_size.h>
+#include <linux/bitops.h>
+#include <linux/cleanup.h>
+#include <linux/compiler_attributes.h>
+#include <linux/container_of.h>
+#include <linux/crc32.h>
+#include <linux/ctype.h>
+#include <linux/device.h>
+#include <linux/device-id/coreboot.h>
+#include <linux/efi.h>
+#include <linux/err.h>
+#include <linux/firmware_attributes.h>
+#include <linux/io.h>
+#include <linux/kdev_t.h>
+#include <linux/kobject.h>
+#include <linux/kstrtox.h>
+#include <linux/limits.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include "coreboot_table.h"
+
+#define DRIVER_NAME "coreboot-cfr"
+
+#define LB_TAG_CFR_ROOT		0x47
+#define CFR_VERSION		0
+
+enum cfr_tags {
+	CFR_TAG_OPTION_FORM		= 1,
+	CFR_TAG_ENUM_VALUE		= 2,
+	CFR_TAG_OPTION_ENUM		= 3,
+	CFR_TAG_OPTION_NUMBER		= 4,
+	CFR_TAG_OPTION_BOOL		= 5,
+	CFR_TAG_VARCHAR_OPT_NAME	= 7,
+	CFR_TAG_VARCHAR_UI_NAME		= 8,
+	CFR_TAG_RUNTIME_APPLY		= 13,
+};
+
+enum cfr_option_flags {
+	CFR_OPTFLAG_READONLY	= BIT(0),
+	CFR_OPTFLAG_INACTIVE	= BIT(1),
+	CFR_OPTFLAG_SUPPRESS	= BIT(2),
+	CFR_OPTFLAG_VOLATILE	= BIT(3),
+	CFR_OPTFLAG_RUNTIME	= BIT(4),
+};
+
+enum cfr_runtime_apply_method {
+	CFR_RUNTIME_APPLY_NONE		= 0,
+	CFR_RUNTIME_APPLY_APM_CNT	= 1,
+};
+
+struct lb_cfr {
+	u32 tag;
+	u32 size;
+	u32 version;
+	u32 checksum;
+} __packed;
+
+struct lb_cfr_varbinary {
+	u32 tag;
+	u32 size;
+	u32 data_length;
+} __packed;
+
+struct lb_cfr_enum_value {
+	u32 tag;
+	u32 size;
+	u32 value;
+} __packed;
+
+struct lb_cfr_runtime_apply {
+	u32 tag;
+	u32 size;
+	u32 method;
+	u32 id;
+} __packed;
+
+struct lb_cfr_numeric_option {
+	u32 tag;
+	u32 size;
+	cb_u64 object_id;
+	cb_u64 dependency_id;
+	u32 flags;
+	u32 default_value;
+	u32 min;
+	u32 max;
+	u32 step;
+	u32 display_flags;
+} __packed;
+
+struct lb_cfr_option_form {
+	u32 tag;
+	u32 size;
+	cb_u64 object_id;
+	cb_u64 dependency_id;
+	u32 flags;
+} __packed;
+
+#define COREBOOT_CFR_OPT_SKIP_FLAGS \
+	(CFR_OPTFLAG_SUPPRESS | CFR_OPTFLAG_VOLATILE)
+
+#define COREBOOT_CFR_OPT_READ_ONLY_FLAGS \
+	(CFR_OPTFLAG_READONLY | CFR_OPTFLAG_INACTIVE)
+
+#define COREBOOT_CFR_EFI_ATTRS \
+	(EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS | \
+	 EFI_VARIABLE_RUNTIME_ACCESS)
+
+#define COREBOOT_CFR_APM_CNT_PORT	0xb2
+#define COREBOOT_CFR_APM_STS_PORT	0xb3
+#define COREBOOT_CFR_APM_APPLY_CMD	0xe3
+#define COREBOOT_CFR_MAX_FORM_DEPTH	16
+
+static efi_guid_t coreboot_cfr_guid = EFI_GUID(0xceae4c1d, 0x335b, 0x4685,
+					       0xa4, 0xa0, 0xfc, 0x4a,
+					       0x94, 0xee, 0xa0, 0x85);
+
+enum coreboot_cfr_setting_type {
+	COREBOOT_CFR_SETTING_ENUM,
+	COREBOOT_CFR_SETTING_NUMBER,
+	COREBOOT_CFR_SETTING_BOOL,
+};
+
+struct coreboot_cfr_enum {
+	char *label;
+	u32 value;
+};
+
+struct coreboot_cfr_setting {
+	struct kobject kobj;
+	struct list_head node;
+	struct coreboot_cfr_drvdata *drvdata;
+	enum coreboot_cfr_setting_type type;
+	char *name;
+	char *display_name;
+	struct coreboot_cfr_enum *values;
+	unsigned int n_values;
+	u32 default_value;
+	u32 min;
+	u32 max;
+	u32 step;
+	u32 runtime_apply_method;
+	u32 runtime_apply_id;
+	bool read_only;
+};
+
+struct coreboot_cfr_drvdata {
+	struct device *class_dev;
+	struct kset *attrs_kset;
+	struct list_head settings;
+	/* Serializes EFI variable writes and the matching runtime apply hook. */
+	struct mutex lock;
+	bool efi_writes_supported;
+	bool pending_reboot;
+};
+
+struct coreboot_cfr_iterator {
+	const u8 *cursor;
+	size_t remaining;
+};
+
+static struct coreboot_cfr_setting *to_coreboot_cfr_setting(struct
kobject *kobj)
+{
+	return container_of(kobj, struct coreboot_cfr_setting, kobj);
+}
+
+static bool coreboot_cfr_string_is_valid_name(const char *name)
+{
+	return name && name[0] && !strchr(name, '/') &&
+		strcmp(name, "pending_reboot") != 0;
+}
+
+static bool coreboot_cfr_string_is_valid_label(const char *label)
+{
+	return label && !strchr(label, ';') && !strchr(label, '\n');
+}
+
+static char *coreboot_cfr_string_dup(const struct lb_cfr_varbinary *str)
+{
+	const char *data = (const char *)(str + 1);
+	size_t len = str->data_length;
+
+	if (len && !data[len - 1])
+		len--;
+
+	return kmemdup_nul(data, len, GFP_KERNEL);
+}
+
+static const struct coreboot_table_entry *
+coreboot_cfr_next_entry(struct coreboot_cfr_iterator *iterator)
+{
+	const struct coreboot_table_entry *entry;
+
+	if (!iterator->remaining)
+		return NULL;
+
+	if (iterator->remaining < sizeof(*entry))
+		return ERR_PTR(-EINVAL);
+
+	entry = (const struct coreboot_table_entry *)iterator->cursor;
+	if (entry->size < sizeof(*entry) || entry->size > iterator->remaining)
+		return ERR_PTR(-EINVAL);
+
+	iterator->cursor += entry->size;
+	iterator->remaining -= entry->size;
+
+	return entry;
+}
+
+static const struct coreboot_table_entry *
+coreboot_cfr_child_entry(const void *base, size_t len, u32 tag)
+{
+	struct coreboot_cfr_iterator iterator = {
+		.cursor = base,
+		.remaining = len,
+	};
+	const struct coreboot_table_entry *entry;
+
+	for (;;) {
+		entry = coreboot_cfr_next_entry(&iterator);
+		if (IS_ERR_OR_NULL(entry))
+			return entry;
+
+		if (entry->tag == tag)
+			return entry;
+	}
+}
+
+static const struct lb_cfr_varbinary *
+coreboot_cfr_child_string(const void *base, size_t len, u32 tag)
+{
+	const struct lb_cfr_varbinary *str;
+	const struct coreboot_table_entry *entry;
+
+	entry = coreboot_cfr_child_entry(base, len, tag);
+	if (IS_ERR(entry))
+		return ERR_CAST(entry);
+	if (!entry)
+		return NULL;
+
+	if (entry->size < sizeof(*str))
+		return ERR_PTR(-EINVAL);
+
+	str = (const struct lb_cfr_varbinary *)entry;
+	if (str->data_length > entry->size - sizeof(*str))
+		return ERR_PTR(-EINVAL);
+
+	return str;
+}
+
+static const struct lb_cfr_runtime_apply *
+coreboot_cfr_child_runtime_apply(const void *base, size_t len)
+{
+	const struct lb_cfr_runtime_apply *runtime_apply;
+	const struct coreboot_table_entry *entry;
+
+	entry = coreboot_cfr_child_entry(base, len, CFR_TAG_RUNTIME_APPLY);
+	if (IS_ERR(entry))
+		return ERR_CAST(entry);
+	if (!entry)
+		return NULL;
+
+	if (entry->size < sizeof(*runtime_apply))
+		return ERR_PTR(-EINVAL);
+
+	runtime_apply = (const struct lb_cfr_runtime_apply *)entry;
+	if (runtime_apply->method == CFR_RUNTIME_APPLY_APM_CNT &&
+	    runtime_apply->id > U8_MAX)
+		return ERR_PTR(-EINVAL);
+
+	return runtime_apply;
+}
+
+static efi_char16_t *coreboot_cfr_efi_name(const char *name)
+{
+	size_t len, i;
+
+	len = strlen(name);
+	if (len >= EFI_VAR_NAME_LEN)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	efi_char16_t *efi_name __free(kfree) =
+		kcalloc(len + 1, sizeof(*efi_name), GFP_KERNEL);
+	if (!efi_name)
+		return ERR_PTR(-ENOMEM);
+
+	for (i = 0; i < len; i++) {
+		if (!isascii(name[i]))
+			return ERR_PTR(-EINVAL);
+		efi_name[i] = name[i];
+	}
+
+	return no_free_ptr(efi_name);
+}
+
+/* Caller must hold the efivar lock. */
+static int coreboot_cfr_read_efi_value(efi_char16_t *efi_name, u32 *value,
+				       u32 *attrs)
+{
+	unsigned long size = sizeof(__le32);
+	efi_status_t status;
+	__le32 data;
+	u32 attr;
+
+	status = efivar_get_variable(efi_name, &coreboot_cfr_guid, &attr,
+				     &size, &data);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+
+	if (size != sizeof(data))
+		return -EINVAL;
+
+	if (!(attr & EFI_VARIABLE_RUNTIME_ACCESS))
+		return -EOPNOTSUPP;
+
+	*value = le32_to_cpu(data);
+	if (attrs)
+		*attrs = attr;
+
+	return 0;
+}
+
+static int coreboot_cfr_read_value(const struct coreboot_cfr_setting *setting,
+				   u32 *value, u32 *attrs)
+{
+	efi_char16_t *efi_name __free(kfree) =
+		coreboot_cfr_efi_name(setting->name);
+	int ret;
+
+	if (IS_ERR(efi_name))
+		return PTR_ERR(no_free_ptr(efi_name));
+
+	ret = efivar_lock();
+	if (ret)
+		return ret;
+
+	ret = coreboot_cfr_read_efi_value(efi_name, value, attrs);
+	efivar_unlock();
+
+	return ret;
+}
+
+/* Caller must hold the efivar lock. */
+static int coreboot_cfr_write_efi_value(efi_char16_t *efi_name, u32 value,
+					u32 attrs)
+{
+	efi_status_t status;
+	__le32 data;
+
+	if (!efivar_supports_writes())
+		return -EROFS;
+
+	data = cpu_to_le32(value);
+	status = efivar_set_variable_locked(efi_name, &coreboot_cfr_guid, attrs,
+					    sizeof(data), &data, false);
+	if (status != EFI_SUCCESS)
+		return efi_status_to_err(status);
+
+	return 0;
+}
+
+static int coreboot_cfr_apply_runtime(struct coreboot_cfr_setting *setting)
+{
+#ifdef CONFIG_X86
+	u8 status;
+
+	if (setting->runtime_apply_method != CFR_RUNTIME_APPLY_APM_CNT)
+		return -EOPNOTSUPP;
+
+	outb((u8)setting->runtime_apply_id, COREBOOT_CFR_APM_STS_PORT);
+	outb(COREBOOT_CFR_APM_APPLY_CMD, COREBOOT_CFR_APM_CNT_PORT);
+	status = inb(COREBOOT_CFR_APM_STS_PORT);
+	if (status)
+		return -EIO;
+
+	return 0;
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
+static int coreboot_cfr_write_value(struct coreboot_cfr_setting *setting,
+				    u32 value)
+{
+	efi_char16_t *efi_name;
+	u32 attrs;
+	u32 old;
+	int restore_ret;
+	int ret;
+
+	if (setting->read_only)
+		return -EACCES;
+
+	efi_name = coreboot_cfr_efi_name(setting->name);
+	if (IS_ERR(efi_name))
+		return PTR_ERR(efi_name);
+
+	mutex_lock(&setting->drvdata->lock);
+
+	ret = efivar_lock();
+	if (ret)
+		goto out_unlock_mutex;
+
+	ret = coreboot_cfr_read_efi_value(efi_name, &old, &attrs);
+	if (ret)
+		goto out_unlock_efi;
+
+	if ((attrs & COREBOOT_CFR_EFI_ATTRS) != COREBOOT_CFR_EFI_ATTRS) {
+		ret = -EOPNOTSUPP;
+		goto out_unlock_efi;
+	}
+
+	if (old == value)
+		goto out_unlock_efi;
+
+	ret = coreboot_cfr_write_efi_value(efi_name, value, attrs);
+	if (ret)
+		goto out_unlock_efi;
+
+	ret = coreboot_cfr_apply_runtime(setting);
+	if (ret == -EOPNOTSUPP) {
+		/* EFI changed; firmware will consume it after reboot. */
+		setting->drvdata->pending_reboot = true;
+		ret = 0;
+	} else if (ret) {
+		restore_ret = coreboot_cfr_write_efi_value(efi_name, old, attrs);
+		if (restore_ret) {
+			setting->drvdata->pending_reboot = true;
+			ret = restore_ret;
+		} else {
+			goto out_unlock_efi;
+		}
+	}
+
+	efivar_unlock();
+	kobject_uevent(&setting->drvdata->class_dev->kobj, KOBJ_CHANGE);
+	mutex_unlock(&setting->drvdata->lock);
+	kfree(efi_name);
+	return ret;
+
+out_unlock_efi:
+	efivar_unlock();
+out_unlock_mutex:
+	mutex_unlock(&setting->drvdata->lock);
+	kfree(efi_name);
+	return ret;
+}
+
+static const char *
+coreboot_cfr_label_from_value(const struct coreboot_cfr_setting *setting,
+			      u32 value)
+{
+	unsigned int i;
+
+	for (i = 0; i < setting->n_values; i++) {
+		if (setting->values[i].value == value)
+			return setting->values[i].label;
+	}
+
+	return NULL;
+}
+
+static int coreboot_cfr_parse_value(struct coreboot_cfr_setting *setting,
+				    const char *label, u32 *value_out)
+{
+	unsigned int i;
+
+	for (i = 0; i < setting->n_values; i++) {
+		if (!sysfs_streq(label, setting->values[i].label))
+			continue;
+
+		*value_out = setting->values[i].value;
+		return 0;
+	}
+
+	return kstrtou32(label, 0, value_out);
+}
+
+static bool coreboot_cfr_value_is_valid(struct coreboot_cfr_setting *setting,
+					u32 value)
+{
+	u32 delta;
+
+	if (setting->type != COREBOOT_CFR_SETTING_NUMBER) {
+		/* Enum and bool values are valid only if they have a label. */
+		return coreboot_cfr_label_from_value(setting, value);
+	}
+
+	if (value < setting->min || value > setting->max)
+		return false;
+
+	if (!setting->step)
+		return true;
+
+	delta = value - setting->min;
+	return delta % setting->step == 0;
+}
+
+static ssize_t type_show(struct kobject *kobj, struct kobj_attribute *attr,
+			 char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	if (setting->type == COREBOOT_CFR_SETTING_NUMBER)
+		return sysfs_emit(buf, "integer\n");
+
+	return sysfs_emit(buf, "enumeration\n");
+}
+
+static ssize_t display_name_language_code_show(struct kobject *kobj,
+					       struct kobj_attribute *attr,
+					       char *buf)
+{
+	return sysfs_emit(buf, "en_US.UTF-8\n");
+}
+
+static ssize_t display_name_show(struct kobject *kobj,
+				 struct kobj_attribute *attr, char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	return sysfs_emit(buf, "%s\n", setting->display_name);
+}
+
+static ssize_t possible_values_show(struct kobject *kobj,
+				    struct kobj_attribute *attr, char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+	ssize_t len = 0;
+	unsigned int i;
+
+	for (i = 0; i < setting->n_values; i++) {
+		len += sysfs_emit_at(buf, len, "%s%s", i ? ";" : "",
+				     setting->values[i].label);
+	}
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+static ssize_t min_value_show(struct kobject *kobj, struct
kobj_attribute *attr,
+			      char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	return sysfs_emit(buf, "%u\n", setting->min);
+}
+
+static ssize_t max_value_show(struct kobject *kobj, struct
kobj_attribute *attr,
+			      char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	return sysfs_emit(buf, "%u\n", setting->max);
+}
+
+static ssize_t scalar_increment_show(struct kobject *kobj,
+				     struct kobj_attribute *attr, char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	return sysfs_emit(buf, "%u\n", setting->step);
+}
+
+static ssize_t default_value_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+	const char *label;
+
+	if (setting->type == COREBOOT_CFR_SETTING_NUMBER)
+		return sysfs_emit(buf, "%u\n", setting->default_value);
+
+	label = coreboot_cfr_label_from_value(setting, setting->default_value);
+	if (!label)
+		return sysfs_emit(buf, "%u\n", setting->default_value);
+
+	return sysfs_emit(buf, "%s\n", label);
+}
+
+static ssize_t current_value_show(struct kobject *kobj,
+				  struct kobj_attribute *attr, char *buf)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+	const char *label;
+	u32 value;
+	int ret;
+
+	ret = coreboot_cfr_read_value(setting, &value, NULL);
+	if (ret)
+		return ret;
+
+	if (setting->type == COREBOOT_CFR_SETTING_NUMBER)
+		return sysfs_emit(buf, "%u\n", value);
+
+	label = coreboot_cfr_label_from_value(setting, value);
+	if (!label)
+		return -EINVAL;
+
+	return sysfs_emit(buf, "%s\n", label);
+}
+
+static ssize_t current_value_store(struct kobject *kobj,
+				   struct kobj_attribute *attr,
+				   const char *buf, size_t count)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+	u32 value;
+	int ret;
+
+	ret = coreboot_cfr_parse_value(setting, buf, &value);
+	if (ret)
+		return ret;
+
+	if (!coreboot_cfr_value_is_valid(setting, value))
+		return -EINVAL;
+
+	ret = coreboot_cfr_write_value(setting, value);
+	if (ret)
+		return ret;
+
+	return count;
+}
+
+static struct kobj_attribute type_attr = __ATTR_RO(type);
+static struct kobj_attribute display_name_language_code_attr =
+	__ATTR_RO(display_name_language_code);
+static struct kobj_attribute display_name_attr = __ATTR_RO(display_name);
+static struct kobj_attribute possible_values_attr = __ATTR_RO(possible_values);
+static struct kobj_attribute min_value_attr = __ATTR_RO(min_value);
+static struct kobj_attribute max_value_attr = __ATTR_RO(max_value);
+static struct kobj_attribute scalar_increment_attr =
__ATTR_RO(scalar_increment);
+static struct kobj_attribute default_value_attr = __ATTR_RO(default_value);
+static struct kobj_attribute current_value_attr = __ATTR_RW(current_value);
+
+static struct attribute *coreboot_cfr_setting_attrs[] = {
+	&type_attr.attr,
+	&display_name_language_code_attr.attr,
+	&display_name_attr.attr,
+	&possible_values_attr.attr,
+	&min_value_attr.attr,
+	&max_value_attr.attr,
+	&scalar_increment_attr.attr,
+	&default_value_attr.attr,
+	&current_value_attr.attr,
+	NULL,
+};
+
+static umode_t coreboot_cfr_attr_is_visible(struct kobject *kobj,
+					    struct attribute *attr, int n)
+{
+	struct coreboot_cfr_setting *setting = to_coreboot_cfr_setting(kobj);
+
+	if (setting->type == COREBOOT_CFR_SETTING_NUMBER &&
+	    attr == &possible_values_attr.attr)
+		return 0;
+
+	if (setting->type != COREBOOT_CFR_SETTING_NUMBER &&
+	    (attr == &min_value_attr.attr || attr == &max_value_attr.attr ||
+	     attr == &scalar_increment_attr.attr))
+		return 0;
+
+	if (setting->read_only && attr == &current_value_attr.attr)
+		return 0444;
+
+	return attr->mode;
+}
+
+static const struct attribute_group coreboot_cfr_setting_group = {
+	.attrs = coreboot_cfr_setting_attrs,
+	.is_visible = coreboot_cfr_attr_is_visible,
+};
+
+static void coreboot_cfr_free_setting(struct coreboot_cfr_setting *setting)
+{
+	unsigned int i;
+
+	for (i = 0; i < setting->n_values; i++)
+		kfree(setting->values[i].label);
+
+	kfree(setting->values);
+	kfree(setting->display_name);
+	kfree(setting->name);
+	kfree(setting);
+}
+
+static void coreboot_cfr_setting_release(struct kobject *kobj)
+{
+	coreboot_cfr_free_setting(to_coreboot_cfr_setting(kobj));
+}
+
+static const struct kobj_type coreboot_cfr_setting_ktype = {
+	.release = coreboot_cfr_setting_release,
+	.sysfs_ops = &kobj_sysfs_ops,
+};
+
+static ssize_t pending_reboot_show(struct kobject *kobj,
+				   struct kobj_attribute *attr, char *buf)
+{
+	struct device *dev = kobj_to_dev(kobj->parent);
+	struct coreboot_cfr_drvdata *data;
+
+	data = dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", data->pending_reboot);
+}
+
+static struct kobj_attribute pending_reboot_attr = __ATTR_RO(pending_reboot);
+
+static int coreboot_cfr_copy_bool_values(struct coreboot_cfr_setting *setting)
+{
+	static const struct coreboot_cfr_enum bool_values[] = {
+		{ .label = "Disabled", .value = 0 },
+		{ .label = "Enabled", .value = 1 },
+	};
+	unsigned int i;
+
+	setting->values = kcalloc(ARRAY_SIZE(bool_values), sizeof(*setting->values),
+				  GFP_KERNEL);
+	if (!setting->values)
+		return -ENOMEM;
+
+	for (i = 0; i < ARRAY_SIZE(bool_values); i++) {
+		setting->values[i].label = kstrdup(bool_values[i].label,
+						   GFP_KERNEL);
+		if (!setting->values[i].label)
+			return -ENOMEM;
+		setting->values[i].value = bool_values[i].value;
+		setting->n_values++;
+	}
+
+	return 0;
+}
+
+static int coreboot_cfr_count_enum_values(const void *base, size_t len)
+{
+	struct coreboot_cfr_iterator iterator = {
+		.cursor = base,
+		.remaining = len,
+	};
+	const struct coreboot_table_entry *entry;
+	int count = 0;
+
+	for (;;) {
+		entry = coreboot_cfr_next_entry(&iterator);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
+		if (!entry)
+			return count;
+
+		if (entry->tag == CFR_TAG_ENUM_VALUE)
+			count++;
+	}
+}
+
+static int coreboot_cfr_copy_enum_values(struct coreboot_cfr_setting *setting,
+					 const void *base, size_t len)
+{
+	struct coreboot_cfr_iterator iterator = {
+		.cursor = base,
+		.remaining = len,
+	};
+	const struct lb_cfr_enum_value *enum_value;
+	const struct lb_cfr_varbinary *label;
+	const struct coreboot_table_entry *entry;
+	struct coreboot_cfr_enum *value;
+	int count;
+
+	count = coreboot_cfr_count_enum_values(base, len);
+	if (count <= 0)
+		return count ?: -EINVAL;
+
+	setting->values = kcalloc(count, sizeof(*setting->values), GFP_KERNEL);
+	if (!setting->values)
+		return -ENOMEM;
+
+	for (;;) {
+		entry = coreboot_cfr_next_entry(&iterator);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
+		if (!entry)
+			return 0;
+
+		if (entry->tag != CFR_TAG_ENUM_VALUE)
+			continue;
+
+		if (entry->size < sizeof(*enum_value))
+			return -EINVAL;
+
+		enum_value = (const struct lb_cfr_enum_value *)entry;
+		label = coreboot_cfr_child_string(enum_value + 1,
+						  enum_value->size - sizeof(*enum_value),
+						  CFR_TAG_VARCHAR_UI_NAME);
+		if (IS_ERR(label))
+			return PTR_ERR(label);
+		if (!label)
+			return -EINVAL;
+
+		value = &setting->values[setting->n_values];
+		value->label = coreboot_cfr_string_dup(label);
+		if (!value->label)
+			return -ENOMEM;
+		if (!coreboot_cfr_string_is_valid_label(value->label)) {
+			kfree(value->label);
+			value->label = NULL;
+			return -EINVAL;
+		}
+
+		value->value = enum_value->value;
+		setting->n_values++;
+	}
+}
+
+static bool
+coreboot_cfr_possible_values_fit(const struct coreboot_cfr_setting *setting)
+{
+	size_t len = 1;		/* Trailing newline. */
+	size_t label_len;
+	unsigned int i;
+
+	for (i = 0; i < setting->n_values; i++) {
+		if (len >= PAGE_SIZE)
+			return false;
+
+		if (i)
+			len++;
+
+		label_len = strlen(setting->values[i].label);
+		if (label_len >= PAGE_SIZE - len)
+			return false;
+
+		len += label_len;
+	}
+
+	return true;
+}
+
+static int coreboot_cfr_setting_is_usable(struct coreboot_cfr_setting *setting)
+{
+	u32 value;
+	int ret;
+
+	ret = coreboot_cfr_read_value(setting, &value, NULL);
+	if (ret)
+		return ret;
+
+	if (!coreboot_cfr_value_is_valid(setting, value))
+		return -EINVAL;
+
+	return 0;
+}
+
+static int coreboot_cfr_register_setting(struct coreboot_cfr_drvdata *data,
+					 struct coreboot_cfr_setting *setting)
+{
+	int ret;
+
+	ret = kobject_init_and_add(&setting->kobj, &coreboot_cfr_setting_ktype,
+				   &data->attrs_kset->kobj, "%s", setting->name);
+	if (ret)
+		goto err_put_kobj;
+
+	ret = sysfs_create_group(&setting->kobj, &coreboot_cfr_setting_group);
+	if (ret)
+		goto err_put_kobj;
+
+	list_add_tail(&setting->node, &data->settings);
+	return 0;
+
+err_put_kobj:
+	kobject_put(&setting->kobj);
+	return ret;
+}
+
+static int coreboot_cfr_add_numeric_option(struct coreboot_cfr_drvdata *data,
+					   const struct lb_cfr_numeric_option *option,
+					   bool parent_read_only)
+{
+	const struct lb_cfr_varbinary *name;
+	const struct lb_cfr_varbinary *display_name;
+	const struct lb_cfr_runtime_apply *runtime_apply;
+	const void *child_base = option + 1;
+	struct coreboot_cfr_setting *setting;
+	size_t child_len = option->size - sizeof(*option);
+	int ret;
+
+	if (!(option->flags & CFR_OPTFLAG_RUNTIME))
+		return 0;
+
+	if (option->flags & COREBOOT_CFR_OPT_SKIP_FLAGS)
+		return 0;
+
+	if (option->dependency_id)
+		return 0;
+
+	setting = kzalloc_obj(*setting, GFP_KERNEL);
+	if (!setting)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&setting->node);
+	setting->drvdata = data;
+	setting->default_value = option->default_value;
+	setting->min = option->min;
+	setting->max = option->max;
+	setting->step = option->step ?: 1;
+	setting->read_only =
+		(option->flags & COREBOOT_CFR_OPT_READ_ONLY_FLAGS) ||
+		!data->efi_writes_supported || parent_read_only;
+
+	runtime_apply = coreboot_cfr_child_runtime_apply(child_base, child_len);
+	if (IS_ERR(runtime_apply)) {
+		ret = PTR_ERR(runtime_apply);
+		goto err_put_setting;
+	}
+
+	if (runtime_apply && runtime_apply->method == CFR_RUNTIME_APPLY_APM_CNT) {
+		setting->runtime_apply_method = runtime_apply->method;
+		setting->runtime_apply_id = runtime_apply->id;
+	}
+
+	name = coreboot_cfr_child_string(child_base, child_len,
+					 CFR_TAG_VARCHAR_OPT_NAME);
+	if (IS_ERR(name)) {
+		ret = PTR_ERR(name);
+		goto err_put_setting;
+	}
+	if (!name) {
+		ret = -EINVAL;
+		goto err_put_setting;
+	}
+
+	setting->name = coreboot_cfr_string_dup(name);
+	if (!setting->name) {
+		ret = -ENOMEM;
+		goto err_put_setting;
+	}
+
+	if (!coreboot_cfr_string_is_valid_name(setting->name)) {
+		ret = -EINVAL;
+		goto err_put_setting;
+	}
+
+	display_name = coreboot_cfr_child_string(child_base, child_len,
+						 CFR_TAG_VARCHAR_UI_NAME);
+	if (IS_ERR(display_name)) {
+		ret = PTR_ERR(display_name);
+		goto err_put_setting;
+	}
+	if (display_name)
+		setting->display_name = coreboot_cfr_string_dup(display_name);
+	else
+		setting->display_name = kstrdup(setting->name, GFP_KERNEL);
+	if (!setting->display_name) {
+		ret = -ENOMEM;
+		goto err_put_setting;
+	}
+
+	switch (option->tag) {
+	case CFR_TAG_OPTION_BOOL:
+		setting->type = COREBOOT_CFR_SETTING_BOOL;
+		setting->min = 0;
+		setting->max = 1;
+		setting->step = 1;
+		ret = coreboot_cfr_copy_bool_values(setting);
+		break;
+	case CFR_TAG_OPTION_ENUM:
+		setting->type = COREBOOT_CFR_SETTING_ENUM;
+		ret = coreboot_cfr_copy_enum_values(setting, child_base,
+						    child_len);
+		break;
+	case CFR_TAG_OPTION_NUMBER:
+		setting->type = COREBOOT_CFR_SETTING_NUMBER;
+		if (setting->max < setting->min)
+			ret = -EINVAL;
+		else
+			ret = 0;
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	if (ret)
+		goto err_put_setting;
+	/* possible_values must be returned completely in one sysfs read. */
+	if (setting->type != COREBOOT_CFR_SETTING_NUMBER &&
+	    !coreboot_cfr_possible_values_fit(setting)) {
+		ret = 0;
+		goto err_put_setting;
+	}
+
+	ret = coreboot_cfr_setting_is_usable(setting);
+	if (ret) {
+		/*
+		 * CFR may describe options without a matching, readable runtime
+		 * EFI variable. Skip those, but propagate transient EFI failures.
+		 */
+		if (ret == -ENOENT || ret == -EINVAL || ret == -EOPNOTSUPP ||
+		    ret == -ENAMETOOLONG)
+			ret = 0;
+		goto err_put_setting;
+	}
+
+	/* The kobject release callback owns setting after this call. */
+	return coreboot_cfr_register_setting(data, setting);
+
+err_put_setting:
+	coreboot_cfr_free_setting(setting);
+	return ret;
+}
+
+static int coreboot_cfr_parse_records(struct coreboot_cfr_drvdata *data,
+				      const void *base, size_t len,
+				      unsigned int depth,
+				      bool parent_read_only)
+{
+	struct coreboot_cfr_iterator iterator = {
+		.cursor = base,
+		.remaining = len,
+	};
+	const struct lb_cfr_option_form *form;
+	const struct lb_cfr_numeric_option *option;
+	const struct coreboot_table_entry *entry;
+	const void *child_base;
+	size_t child_len;
+	int ret;
+
+	for (;;) {
+		entry = coreboot_cfr_next_entry(&iterator);
+		if (IS_ERR(entry))
+			return PTR_ERR(entry);
+		if (!entry)
+			return 0;
+
+		switch (entry->tag) {
+		case CFR_TAG_OPTION_FORM:
+			if (entry->size < sizeof(struct lb_cfr_option_form))
+				return -EINVAL;
+
+			form = (const struct lb_cfr_option_form *)entry;
+			if (form->dependency_id ||
+			    form->flags & CFR_OPTFLAG_SUPPRESS)
+				break;
+
+			if (depth >= COREBOOT_CFR_MAX_FORM_DEPTH)
+				return -E2BIG;
+
+			child_base = form + 1;
+			child_len = entry->size - sizeof(struct lb_cfr_option_form);
+			ret = coreboot_cfr_parse_records(data, child_base,
+							 child_len, depth + 1,
+							 parent_read_only ||
+							 (form->flags &
+							  COREBOOT_CFR_OPT_READ_ONLY_FLAGS));
+			if (ret)
+				return ret;
+			break;
+		case CFR_TAG_OPTION_ENUM:
+		case CFR_TAG_OPTION_NUMBER:
+		case CFR_TAG_OPTION_BOOL:
+			option = (const struct lb_cfr_numeric_option *)entry;
+			if (entry->size < sizeof(*option))
+				return -EINVAL;
+			ret = coreboot_cfr_add_numeric_option(data, option,
+							      parent_read_only);
+			if (ret)
+				return ret;
+			break;
+		default:
+			/* Ignore unsupported, child-only and future record types. */
+			break;
+		}
+	}
+}
+
+static void coreboot_cfr_unregister_settings(struct coreboot_cfr_drvdata *data)
+{
+	struct coreboot_cfr_setting *setting, *tmp;
+
+	list_for_each_entry_safe(setting, tmp, &data->settings, node) {
+		sysfs_remove_group(&setting->kobj, &coreboot_cfr_setting_group);
+		list_del(&setting->node);
+		kobject_put(&setting->kobj);
+	}
+}
+
+static int coreboot_cfr_probe(struct coreboot_device *dev)
+{
+	const struct lb_cfr *root = (const struct lb_cfr *)dev->raw;
+	struct coreboot_cfr_drvdata *data;
+	size_t payload_len;
+	int ret;
+
+	if (dev->entry.size < sizeof(*root))
+		return -EINVAL;
+
+	if (root->tag != LB_TAG_CFR_ROOT || root->version != CFR_VERSION)
+		return -EINVAL;
+
+	if (root->size < sizeof(*root) || root->size > dev->entry.size)
+		return -EINVAL;
+
+	payload_len = root->size - sizeof(*root);
+	if (crc32_be(0, root + 1, payload_len) != root->checksum)
+		return -EBADMSG;
+
+	if (!efivar_is_available())
+		return -EPROBE_DEFER;
+
+	data = devm_kzalloc(&dev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	ret = efivar_lock();
+	if (ret)
+		return ret;
+	data->efi_writes_supported = efivar_supports_writes();
+	efivar_unlock();
+
+	INIT_LIST_HEAD(&data->settings);
+	ret = devm_mutex_init(&dev->dev, &data->lock);
+	if (ret)
+		return ret;
+
+	dev_set_drvdata(&dev->dev, data);
+
+	data->class_dev = device_create(&firmware_attributes_class, NULL,
+					MKDEV(0, 0), NULL, DRIVER_NAME);
+	if (IS_ERR(data->class_dev))
+		return PTR_ERR(data->class_dev);
+	dev_set_drvdata(data->class_dev, data);
+
+	data->attrs_kset = kset_create_and_add("attributes", NULL,
+					       &data->class_dev->kobj);
+	if (!data->attrs_kset) {
+		ret = -ENOMEM;
+		goto err_unregister_dev;
+	}
+
+	ret = sysfs_create_file(&data->attrs_kset->kobj,
+				&pending_reboot_attr.attr);
+	if (ret)
+		goto err_unregister_attrs;
+
+	ret = coreboot_cfr_parse_records(data, root + 1, payload_len, 0, false);
+	if (ret)
+		goto err_unregister_settings;
+
+	if (list_empty(&data->settings)) {
+		ret = -ENODEV;
+		goto err_unregister_settings;
+	}
+
+	return 0;
+
+err_unregister_settings:
+	coreboot_cfr_unregister_settings(data);
+	sysfs_remove_file(&data->attrs_kset->kobj, &pending_reboot_attr.attr);
+err_unregister_attrs:
+	kset_unregister(data->attrs_kset);
+err_unregister_dev:
+	device_unregister(data->class_dev);
+	return ret;
+}
+
+static void coreboot_cfr_remove(struct coreboot_device *dev)
+{
+	struct coreboot_cfr_drvdata *data = dev_get_drvdata(&dev->dev);
+
+	coreboot_cfr_unregister_settings(data);
+	sysfs_remove_file(&data->attrs_kset->kobj, &pending_reboot_attr.attr);
+	kset_unregister(data->attrs_kset);
+	device_unregister(data->class_dev);
+}
+
+static const struct coreboot_device_id coreboot_cfr_ids[] = {
+	{ .tag = LB_TAG_CFR_ROOT },
+	{ }
+};
+MODULE_DEVICE_TABLE(coreboot, coreboot_cfr_ids);
+
+static struct coreboot_driver coreboot_cfr_driver = {
+	.probe = coreboot_cfr_probe,
+	.remove = coreboot_cfr_remove,
+	.drv = {
+		.name = DRIVER_NAME,
+	},
+	.id_table = coreboot_cfr_ids,
+};
+module_coreboot_driver(coreboot_cfr_driver);
+
+MODULE_AUTHOR("Sean Rhodes <sean@starlabs.systems>");
+MODULE_DESCRIPTION("coreboot CFR firmware attributes driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("EFIVAR");
