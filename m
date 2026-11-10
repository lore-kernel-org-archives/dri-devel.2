Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF67960A5BD2
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:22:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2225A10EF7E;
	Tue, 10 Nov 2026 10:22:14 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 802B810E209
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:58:26 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8DxytGv3PJqdSAeAA--.20952S3;
 Tue, 10 Nov 2026 16:58:23 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJBxrM6m3PJq83MzAA--.21431S4;
 Tue, 10 Nov 2026 16:58:22 +0800 (CST)
From: wuqianhai@loongson.cn
To: chenhuacai@kernel.org, kernel@xen0n.name, tzimmermann@suse.de,
 deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 loongarch@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuqianhai <wuqianhai@loongson.cn>
Subject: [PATCH v3 2/6] LoongArch/PCI: Refresh screen_info after resource
 assignment
Date: Tue, 10 Nov 2026 16:56:13 +0800
Message-Id: <20261110085617.2626835-3-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110085617.2626835-1-wuqianhai@loongson.cn>
References: <20261029033440.973077-1-wuqianhai@loongson.cn>
 <20261110085617.2626835-1-wuqianhai@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBxrM6m3PJq83MzAA--.21431S4
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7uF1DKF13CF18Zr4kArW8AFc_yoW8GFWrpF
 ZIvrsrtrW8GF1xGFs8t34DXr4qqF1v93429FZrKFyrA39Fvrn0q397Crn8WF1DJw4Fva1r
 ZFZxCw4FkF4DAabCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAF
 wI0_Gr1j6F4UJwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
 xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
 Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x
 0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l
 4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
 WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI
 7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
 4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI
 42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxNeODUUUU
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

PCI resource assignment runs from acpi_init() at subsys_initcall time.
The firmware framebuffer BAR can be relocated, leaving screen_info's
lfb_base stale.  vga_arb_device_init() runs later at subsys_initcall_sync
time and reads screen_info to identify the firmware default VGA device.

Update screen_info through the generic screen_info_apply_fixups() helper
right after the root bus resources have been assigned, so both the VGA
arbiter and sysfb_init() observe the final framebuffer address.

Signed-off-by: wuqianhai <wuqianhai@loongson.cn>
---
 arch/loongarch/pci/acpi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/loongarch/pci/acpi.c b/arch/loongarch/pci/acpi.c
index ccbcea61fcd9..cb313ff67f7e 100644
--- a/arch/loongarch/pci/acpi.c
+++ b/arch/loongarch/pci/acpi.c
@@ -9,6 +9,7 @@
 #include <linux/slab.h>
 #include <linux/pci-acpi.h>
 #include <linux/pci-ecam.h>
+#include <linux/screen_info.h>
 
 #include <asm/pci.h>
 #include <asm/numa.h>
@@ -256,6 +257,9 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
 		 */
 		pci_assign_unassigned_root_bus_resources(bus);
 
+		if (IS_ENABLED(CONFIG_SCREEN_INFO))
+			screen_info_apply_fixups();
+
 		list_for_each_entry(child, &bus->children, node)
 			pcie_bus_configure_settings(child);
 	}
-- 
2.34.1

