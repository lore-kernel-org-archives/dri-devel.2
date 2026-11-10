Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D3DD606EF25
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 10:22:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82BE310EF74;
	Tue, 10 Nov 2026 10:22:02 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 318B810EEBF
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 09:04:06 +0000 (UTC)
Received: from loongson.cn (unknown [10.20.42.172])
 by gateway (Coremail) with SMTP id _____8Bx79IC3vJqVyEeAA--.21762S3;
 Tue, 10 Nov 2026 17:04:02 +0800 (CST)
Received: from ubuntu.loongson.cn (unknown [127.0.0.1])
 by front1 (Coremail) with SMTP id qMiowJCxe84A3vJqYXQzAA--.22085S2;
 Tue, 10 Nov 2026 17:04:00 +0800 (CST)
From: wuqianhai@loongson.cn
To: chenhuacai@kernel.org, kernel@xen0n.name, tzimmermann@suse.de,
 deller@gmx.de, bhelgaas@google.com
Cc: ardb@kernel.org, ilias.apalodimas@linaro.org, javierm@redhat.com,
 loongarch@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-efi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 wuqianhai <wuqianhai@loongson.cn>
Subject: [PATCH v3 0/6] LoongArch: Identify the firmware/boot display device
Date: Tue, 10 Nov 2026 17:01:57 +0800
Message-Id: <20261110090203.2631481-1-wuqianhai@loongson.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029033440.973077-1-wuqianhai@loongson.cn>
References: <20261029033440.973077-1-wuqianhai@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJCxe84A3vJqYXQzAA--.22085S2
X-CM-SenderInfo: 5zxtxtpqkdxqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw17XFy8uF1kWrW7Zw15ZFc_yoWruFWUpF
 4a9a9xJr4kWr4xGryIy34UXFn8Arn7G3yagFWakw18C345Jr18WF93t3yDXa4UJ393J3WF
 qF15Jw1xWF4DuagCm3ZEXasCq-sJn29KB7ZKAUJUUUU_529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUPmb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
 14v26r4UJVWxJr1ln4kS14v26r1q6r43M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
 kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
 6Fy26r45twAv7VC2z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
 vY0x0EwIxGrwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vI
 r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jw0_GFylx2IqxVAqx4xG67
 AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
 rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2IY6xkF7I0E14
 v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26F4j
 6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IUe
 JDGUUUUUU==
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: wuqianhai <wuqianhai@loongson.cn>

On LoongArch the kernel cannot reliably identify the display device that
was set up by the firmware and used for the boot console.  Two code paths
need this information and currently get it wrong:

  * The PCI VGA arbiter: vga_is_firmware_default() is compiled only on
    x86, so on LoongArch vga_default_device() may select the wrong GPU
    when several are present (for example an integrated display
    controller and a discrete card).

  * The framebuffer console: LoongArch does not implement
    video_is_primary_device(), so with
    CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y the console falls back to
    the generic stub that always returns false and binds to the first
    registered framebuffer instead of the boot display.

This series fixes both by publishing the firmware framebuffer information
through screen_info on LoongArch and consuming it the same way x86 does.

Patch 1 always defines and initializes sysfb_primary_display, and always
provides its EFI stub alias, instead of guarding them behind
SYSFB/EFI_EARLYCON.

Patch 2 refreshes screen_info from the PCI resource-assignment path after
the root-bus resources are assigned, so the framebuffer address is final
before the VGA arbiter and sysfb_init() consume it.  The call is placed
in the LoongArch PCI scan path because only LoongArch has this ordering:
acpi_init() relocates the BAR before vga_arb_device_init() runs.  On x86
the screen_info address is still accurate at that point.  If you would
rather have the helper called from the generic
pci_assign_unassigned_root_bus_resources() path so that all architectures
share it, that can be done instead.

Patch 3 removes pci_fixup_vgadev(), which overrides the VGA default
device to a discrete card after the arbiter has already selected the
firmware framebuffer device, so vga_default_device() consistently
reflects the boot display.

Patch 4 implements video_is_primary_device() for LoongArch by reusing the
VGA default device selected by the arbiter.

Patch 5 lets the EFI stub link directly to sysfb_primary_display on
LoongArch, so the firmware framebuffer information is always populated.

Patch 6 lets the VGA arbiter use CONFIG_SCREEN_INFO instead of an
architecture check and makes VGA_ARB select SCREEN_INFO on LoongArch.

Patches 1-4 are LoongArch-specific.  Patches 5 and 6 touch generic code
(the EFI stub and the PCI VGA arbiter) and are placed last so they can be
reviewed and merged separately.  Patches 3 and 4 depend on patch 6 taking
effect, but are ordered ahead of it only to group the LoongArch changes
together.

Changes since v2:
  - Split the screen_info refresh out of vga_arb_device_init() into the
    LoongArch PCI resource-assignment path (patch 2), following Thomas'
    suggestion to decouple it from sysfb_init().
  - Drop the per-architecture check in vgaarb.c and the select of SYSFB
    in favour of CONFIG_SCREEN_INFO and select SCREEN_INFO (patch 6).
  - Always define and initialize sysfb_primary_display, and let the EFI
    stub link to it directly (patches 1 and 5), instead of guarding them
    behind SYSFB/EFI_EARLYCON.
  - Remove the vga_default_device() override (patch 3) so the arbiter's
    firmware-framebuffer selection takes effect.
  - Implement video_is_primary_device() (patch 4) by reusing the arbiter's
    default device, so FRAMEBUFFER_CONSOLE_DETECT_PRIMARY works.

Build-tested on loongarch64 with GCC 8.3.0.

wuqianhai (6):
  LoongArch: efi: Provide sysfb_primary_display for screen_info users
  LoongArch/PCI: Refresh screen_info after resource assignment
  LoongArch/PCI: Remove vga default device override
  LoongArch: video: Implement primary framebuffer device detection
  efi/libstub: Enable direct sysfb_primary_display access on LoongArch
  PCI/VGA: Enable firmware default device detection on LoongArch

 arch/loongarch/Makefile                       |  3 ++
 arch/loongarch/include/asm/video.h            |  7 +++++
 arch/loongarch/kernel/efi.c                   |  5 +---
 arch/loongarch/kernel/image-vars.h            |  2 --
 arch/loongarch/pci/acpi.c                     |  4 +++
 arch/loongarch/pci/pci.c                      | 18 ------------
 arch/loongarch/video/Makefile                 |  3 ++
 arch/loongarch/video/video-common.c           | 29 +++++++++++++++++++
 drivers/firmware/efi/libstub/efi-stub-entry.c |  1 +
 drivers/pci/Kconfig                           |  2 +-
 drivers/pci/vgaarb.c                          |  2 +-
 11 files changed, 50 insertions(+), 26 deletions(-)
 create mode 100644 arch/loongarch/video/Makefile
 create mode 100644 arch/loongarch/video/video-common.c

-- 
2.34.1

