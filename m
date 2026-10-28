Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B04606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B41D711206D;
	Thu, 29 Oct 2026 07:59:23 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5EA410E600
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:47:32 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8Bxb9OxxOFqwBQaAA--.10107S3;
 Wed, 28 Oct 2026 17:47:29 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJAxHs+wxOFqB+MwAA--.11789S2;
 Wed, 28 Oct 2026 17:47:28 +0800 (CST)
From: wuqianhai@loongson.cn
To: bhelgaas@google.com
Cc: wuqianhai <wuqianhai@loongson.cn>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, tzimmermann@suse.de, javierm@redhat.com,
 dri-devel@lists.freedesktop.org
Subject: [PATCH] PCI/VGA: Fix boot device detection after framebuffer
 relocation
Date: Wed, 28 Oct 2026 17:46:34 +0800
Message-Id: <20261028094634.766723-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJAxHs+wxOFqB+MwAA--.11789S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uryfKrWrAF43KF1Uur4kGrX_yoW8Ar1kpF
 Z3JF4ayFWkWr4xGrsFga4vvFyrZa1kCa4FkF4UKw1F9w13C34jya4rK3s5K34Dtrs3A3Wa
 vF13Jw1rCFZ8GFXCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lw4CEc2x0rV
 AKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
 wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc4
 0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
 xVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
 1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU2knYUUUU
 U
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

PCI resource assignment can relocate the firmware framebuffer BAR, which
leaves the base address in screen_info stale.  The VGA arbiter then calls
screen_info_pci_dev() from vga_is_firmware_default(), which fails to match
the framebuffer against any PCI device's BARs.  As a result, the boot VGA
device is not recognized and the arbiter may select the wrong default
device.

Fix this by calling screen_info_apply_fixups() in vga_arb_device_init()
before adding the VGA devices.  This relocates lfb_base to the assigned
BAR address so that vga_is_firmware_default() matches the boot device
again.

Tested on a LoongArch platform, with vga_is_firmware_default()
additionally enabled for CONFIG_LOONGARCH via local changes.

Fixes: 337bf13aa9ddab8ae47f2677ab75cf69ae33437b ("PCI/VGA: Replace vga_is_firmware_default() with a screen info check")
Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
 drivers/pci/vgaarb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 3e58b2c05c85..aca594651f58 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1527,6 +1527,14 @@ static int __init vga_arb_device_init(void)
 	int rc;
 	struct pci_dev *pdev;
 
+	/*
+	 * PCI resource assignment may have relocated the firmware
+	 * framebuffer BAR. Update screen_info's lfb_base so that
+	 * vga_is_firmware_default() can match it against the boot
+	 * device's relocated resource.
+	 */
+	screen_info_apply_fixups();
+
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
 		pr_err("error %d registering device\n", rc);
-- 
2.34.1

