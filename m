Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D0FCC55174
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 21:07:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF1310E24E;
	Wed,  5 Aug 2026 21:06:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nwANh4vf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1984610E24E
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 21:06:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 567C960A63;
 Wed,  5 Aug 2026 21:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353701F00A3A;
 Wed,  5 Aug 2026 21:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785964017;
 bh=yV71WKEt/WAbV1xBlNtRxMHsWGPwbojddA+EY1CASxY=;
 h=From:To:Cc:Subject:Date;
 b=nwANh4vfV4fU6w4XrgSRt0FnRZpxHBUWwuhVflmL5efi6VNuouyjl6WzG2pgk0u+/
 y0no+UeqBWXqBtkigByV24OMWDbOmHE5Yd+eeiFmReoq+vyTzPzvHo71b3TUKaavQw
 64xHMnVWJ/Grc/w71Coggvqim6YeAjSMeuDePbqVnnkg2JR8QD8vB0cMVOlhSfEyIu
 7Kqvs+hWhcMcy6KKkUrHVl3aZB+5L/wbksJoamHtg0bNmZhF5Grg+3Cql7W+afwkH6
 ooUQBA3PJYRSFY5lXaRpfr7QrE0OrIVwZZKVPNrm9w3mu9CadPxqXBBaHmgzvsqgoD
 VAhjeW+6x9a1A==
From: Helge Deller <deller@kernel.org>
To: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: deller@gmx.de
Subject: [PATCH] sticon/parisc: Detect default STI graphics card for console
 output
Date: Wed,  5 Aug 2026 23:06:41 +0200
Message-ID: <20260805210641.21740-1-deller@kernel.org>
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

If a machine has multiple graphic cards, detect that graphic card
which is used to display firmware messages and use that one as default
graphic card for sticon and fbcon.

On parisc machines the default graphic card used for BCH (boot console
handler, aka BIOS menu) is stored in the stable storage (equivalent to
CMOS storage on x86) or in the console path in page zero. Extract that
path and store it as default STI path for later comparism.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/sticore.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/video/sticore.c b/drivers/video/sticore.c
index 0d37e4b10447..4eac672a4713 100644
--- a/drivers/video/sticore.c
+++ b/drivers/video/sticore.c
@@ -1148,6 +1148,25 @@ static void sti_init_roms(void)
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
+		if (dev)
+			print_pa_hwpath(to_parisc_device(dev),
+					default_sti_path);
+		pr_debug("default graphic card: %s\n", default_sti_path);
+	}
+
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
 	WARN_ON(pci_register_driver(&pci_sti_driver));
-- 
2.54.0

