Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8826260A5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:22:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF03510EF7A;
	Tue, 10 Nov 2026 10:22:12 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 762B510E209
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:59:33 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8CxKvDz3PJqxCAeAA--.21004S3;
 Tue, 10 Nov 2026 16:59:31 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxa87t3PJqCXQzAA--.20943S2;
 Tue, 10 Nov 2026 16:59:25 +0800 (CST)
From: wuqianhai@loongson.cn
To: chenhuacai@kernel.org, kernel@xen0n.name, tzimmermann@suse.de,
 deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 loongarch@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuqianhai <wuqianhai@loongson.cn>
Subject: [PATCH v3 4/6] LoongArch: video: Implement primary framebuffer device
 detection
Date: Tue, 10 Nov 2026 16:57:27 +0800
Message-Id: <20261110085729.2628009-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxa87t3PJqCXQzAA--.20943S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxXr4rCFy8Cw13uF43XrWUGFX_yoW5tFWDpF
 1DAF95Jr4kWrn7G3sxJa43Zr15Jr1kGr1agFyI9Fy8CrnxXrn5Zr93tryDJa4UJ398JFWF
 qF9xGw13WF45XabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPqb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
 14v26r4UJVWxJr1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
 kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
 6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
 vY0x0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_
 Gr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jI6w
 AUUUUU=
X-Mailman-Approved-At: Tue, 10 Nov 2026 10:21:36 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: wuqianhai <wuqianhai@loongson.cn>

The LoongArch port does not implement video_is_primary_device(), so it
falls back to the generic stub that always returns false.  As a result,
with CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y the framebuffer console
cannot map itself to the primary display device and instead binds to the
first registered framebuffer, which is not necessarily the one the
firmware used for the boot console.

Implement video_is_primary_device() by returning whether the device is
the VGA default device.  This reuses the VGA arbiter's choice instead of
matching the firmware framebuffer by address, so it is stable across BAR
resizing: the default device is fixed before any driver runs.

Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
 arch/loongarch/Makefile             |  3 +++
 arch/loongarch/include/asm/video.h  |  7 +++++++
 arch/loongarch/video/Makefile       |  3 +++
 arch/loongarch/video/video-common.c | 29 +++++++++++++++++++++++++++++
 4 files changed, 42 insertions(+)
 create mode 100644 arch/loongarch/video/Makefile
 create mode 100644 arch/loongarch/video/video-common.c

diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index 4b22f95aaafb..7fca93298cef 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -166,6 +166,9 @@ bootvars-y	= VMLINUX_LOAD_ADDRESS=$(load-y)
 
 drivers-$(CONFIG_PCI)		+= arch/loongarch/pci/
 
+# framebuffer console primary device detection
+drivers-$(CONFIG_VIDEO)		+= arch/loongarch/video/
+
 KBUILD_AFLAGS	+= $(cflags-y)
 KBUILD_CFLAGS	+= $(cflags-y)
 KBUILD_CPPFLAGS += -DVMLINUX_LOAD_ADDRESS=$(load-y)
diff --git a/arch/loongarch/include/asm/video.h b/arch/loongarch/include/asm/video.h
index 9f76845f2d4f..7b38881ea1d6 100644
--- a/arch/loongarch/include/asm/video.h
+++ b/arch/loongarch/include/asm/video.h
@@ -8,6 +8,13 @@
 #include <linux/compiler.h>
 #include <linux/string.h>
 
+struct device;
+
+#ifdef CONFIG_VIDEO
+bool video_is_primary_device(struct device *dev);
+#define video_is_primary_device video_is_primary_device
+#endif
+
 static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
 	memcpy(to, (void __force *)from, n);
diff --git a/arch/loongarch/video/Makefile b/arch/loongarch/video/Makefile
new file mode 100644
index 000000000000..f1b2a7e54033
--- /dev/null
+++ b/arch/loongarch/video/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+obj-$(CONFIG_VIDEO)		+= video-common.o
diff --git a/arch/loongarch/video/video-common.c b/arch/loongarch/video/video-common.c
new file mode 100644
index 000000000000..6fea46661cb6
--- /dev/null
+++ b/arch/loongarch/video/video-common.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Loongson Technology Corporation Limited
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/vgaarb.h>
+
+#include <asm/video.h>
+
+bool video_is_primary_device(struct device *dev)
+{
+	struct pci_dev *pdev;
+
+	if (!dev_is_pci(dev))
+		return false;
+
+	pdev = to_pci_dev(dev);
+
+	if (!pci_is_display(pdev))
+		return false;
+
+	return pdev == vga_default_device();
+}
+EXPORT_SYMBOL(video_is_primary_device);
+
+MODULE_DESCRIPTION("LoongArch video helpers");
+MODULE_LICENSE("GPL");
-- 
2.34.1

