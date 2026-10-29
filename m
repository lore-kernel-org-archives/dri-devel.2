Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFC7606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EE911204F;
	Thu, 29 Oct 2026 07:59:11 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB1510E18C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 03:35:44 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8CxfdILv+JqxFMaAA--.10966S3;
 Thu, 29 Oct 2026 11:35:40 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJDxzM4Lv+JqVhAxAA--.11788S2;
 Thu, 29 Oct 2026 11:35:39 +0800 (CST)
From: wuqianhai@loongson.cn
To: bhelgaas@google.com
Cc: wuqianhai <wuqianhai@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, tzimmermann@suse.de, javierm@redhat.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] PCI/VGA: Enable firmware default device detection on
 LoongArch
Date: Thu, 29 Oct 2026 11:34:40 +0800
Message-Id: <20261029033440.973077-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028094634.766723-1-wuqianhai@loongson.cn>
References: <20261028094634.766723-1-wuqianhai@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJDxzM4Lv+JqVhAxAA--.11788S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Zr1UZF4UJw15Cw1rKw1rGrX_yoW5JrWDpr
 WfJFWIyFW8WFsrG39rJ34DuF90van7Ca4YkF45Kw13ua47C3yUJa4ftr98trnrJrs5JF4S
 yF1fJ3WrAFyDGagCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
 Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
 kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
 twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
 8JM4kE6xkIj40Ew7xC0wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2Iq
 xVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU83PE3UUUUU==
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
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

On LoongArch, PCI resource assignment completes during subsys_initcall
(acpi_init), before vga_arb_device_init() runs.  By that time the
firmware framebuffer BAR may already have been relocated, leaving
screen_info's lfb_base stale.  Enable vga_is_firmware_default() for
LoongArch and refresh screen_info in vga_arb_device_init() before the
boot device is matched.

Unlike x86, sysfb_primary_display is only defined when CONFIG_SYSFB is
enabled on LoongArch, so have VGA_ARB select SYSFB there.

Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
Changes in v2:
- Add VGA_ARB's select of SYSFB for LoongArch to avoid an undefined
  reference when CONFIG_SCREEN_INFO is not set.
- Restrict the screen_info_apply_fixups() call to CONFIG_LOONGARCH so
  x86 and other architectures are unaffected.
- Enable vga_is_firmware_default() for LoongArch.
---
 drivers/pci/Kconfig  |  1 +
 drivers/pci/vgaarb.c | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
index 0c7408509ba2..55cc60f5d312 100644
--- a/drivers/pci/Kconfig
+++ b/drivers/pci/Kconfig
@@ -256,6 +256,7 @@ config VGA_ARB
 	default y
 	depends on !S390
 	select SCREEN_INFO if X86
+	select SYSFB if LOONGARCH
 	help
 	  Some "legacy" VGA devices implemented on PCI typically have the same
 	  hard-decoded addresses as they did on ISA. When multiple PCI devices
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3e58b2c05c85..1b7e915629f9 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -566,7 +566,7 @@ EXPORT_SYMBOL(vga_put);
 
 static bool vga_is_firmware_default(struct pci_dev *pdev)
 {
-#if defined CONFIG_X86
+#if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 	return pdev == screen_info_pci_dev(&sysfb_primary_display.screen);
 #else
 	return false;
@@ -1527,6 +1527,16 @@ static int __init vga_arb_device_init(void)
 	int rc;
 	struct pci_dev *pdev;
 
+#if defined(CONFIG_LOONGARCH)
+	/*
+	 * On LoongArch, PCI resource assignment completes during
+	 * subsys_initcall (acpi_init), before the VGA arbiter runs.  Refresh
+	 * screen_info so vga_is_firmware_default() can match the relocated
+	 * BAR.
+	 */
+	screen_info_apply_fixups();
+#endif
+
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
 		pr_err("error %d registering device\n", rc);
-- 
2.34.1

