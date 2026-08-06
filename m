Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4019CC56205
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 15:05:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7587B10F220;
	Thu,  6 Aug 2026 15:05:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="F8EpqDP/";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD3510F21C
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 15:05:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D5D2441768;
 Thu,  6 Aug 2026 15:05:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA171F000E9;
 Thu,  6 Aug 2026 15:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786028712;
 bh=1Z3Rij5Y2TDRcGbge5gJ16K4Ai71Dj0D517MtFEVucY=;
 h=From:To:Cc:Subject:Date;
 b=F8EpqDP/NZMcNWBNq4noLlupXQnF+W/i3Gc+5RcOJhOkLaR+ektD3WjacvDW+2Nda
 TTNZp1cEYJr1gE0/68MEOAtWOB4mTae23hMEfgIXo0M0k0IYflkdZuYkXYJgFB65PR
 pymSWrdLXTlCFm5kWOplWPyfR+15bGbwjgxcRqfwaz4Q2Jj990zVIMYObN0TUyq1sv
 lKzrOYXB67clExPvld6JCIFVdB8K7f7qjKjVpJ+Sk4DobMVPi4RKPAu59nO2fbx9wf
 trjoX1siXf6FjQsMiul76Oe+pScxgBuk273t1ryYcOEl/cuBXeXLs7C/ZAxCOgAKlg
 /W1kQASeNegGw==
From: Helge Deller <deller@kernel.org>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-parisc@vger.kernel.org
Cc: deller@gmx.de
Subject: [PATCH v2] sticon/parisc: Detect default STI graphics card for
 console output
Date: Thu,  6 Aug 2026 17:04:15 +0200
Message-ID: <20260806150414.7870-2-deller@kernel.org>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Helge Deller <deller@gmx.de>

If a machine has multiple graphic cards, detect the graphic card which is used
to display firmware messages and use that one as the default graphic card for
sticon and fbcon.

On parisc machines the default graphic card used for BCH (boot console
handler, aka BIOS menu) is stored in the stable storage (equivalent to CMOS
storage on x86) or in the console path in page zero. Extract that path and
store it as default STI path for later comparism. Take care that the graphic
card can be a GSC or a PCI card which use different path strings.

Increase max string size for default_sti_path to 32 chars as the
print_pa_hwpath() function formats a hardware path using unbounded sprintf
calls for up to 6 bus converter components and 1 module component (e.g.,
255/255/...), which can produce a string up to 28 bytes long.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/sticore.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

v2: increase default_sti_path and take care of PCU cards as reported by
    the Sashiko AI bot review.

diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 0d37e4b10447..1d4477f20450 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -325,7 +325,7 @@ static void sti_rom_copy(unsigned long base, unsigned long count, void *dest)
 
 
 
-static char default_sti_path[21] __read_mostly;
+static char default_sti_path[32] __read_mostly;
 
 #ifndef MODULE
 static int __init sti_setup(char *str)
@@ -1148,6 +1148,26 @@ static void sti_init_roms(void)
 	pr_info("STI GSC/PCI core graphics driver "
 			STI_DRIVERVERSION "\n");
 
+	/*
+	 * Find default console by hardware path which is either stored in
+	 * console entry in stable storage or alternatively from console path
+	 * in PAGE0 used by BCH and PDC.
+	 */
+	if (!default_sti_path[0]) {
+		struct pdc_module_path conspath;
+		struct device *dev = NULL;
+
+		if (pdc_stable_read(0x60, &conspath, sizeof(conspath)) == PDC_OK)
+			dev = hwpath_to_device(&conspath.path);
+		if (!dev)
+			dev = hwpath_to_device(&PAGE0->mem_cons.dp.path);
+		if (dev && dev_is_pci(dev))
+			print_pci_hwpath(to_pci_dev(dev), default_sti_path);
+		else if (dev && !dev_is_pci(dev))
+			print_pa_hwpath(to_parisc_device(dev), default_sti_path);
+		pr_debug("default graphic card: %s\n", default_sti_path);
+	}
+
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
 	WARN_ON(pci_register_driver(&pci_sti_driver));
-- 
2.54.0

