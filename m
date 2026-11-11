Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B55606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 06:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B90E710E126;
	Wed, 11 Nov 2026 06:21:33 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Wed, 11 Nov 2026 06:21:32 UTC
Received: from twmbx01.aspeedtech.com (mail.aspeedtech.com [211.20.114.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96F4D10E126
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 06:21:32 +0000 (UTC)
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 11 Nov
 2026 14:16:27 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 11 Nov 2026 14:16:27 +0800
From: Jammy Huang <jammy_huang@aspeedtech.com>
Date: Wed, 11 Nov 2026 14:16:20 +0800
Subject: [PATCH] drm/ast: Get VRAM size from PCI BAR0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261111-ast-vram-size-from-bar0-v1-1-dff97e2f8ccd@aspeedtech.com>
X-B4-Tracking: v=1; b=H4sIADMI9GoC/x2MMQ6DMAwAv4I8YwmnCLX9CmJIidN6SEA2ilARf
 yfithvuDjBWYYN3c4ByEZMlV6G2gfnn85dRQnVwnRuogt42LOoTmvwZoy4JP147pMeTXiFSiK6
 HWq/KUfb7PE7neQGWqR5qaQAAAA==
X-Change-ID: 20261111-ast-vram-size-from-bar0-13819df1df24
To: Dave Airlie <airlied@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>, "Jammy
 Huang" <jammy_huang@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794377787; l=2662;
 i=jammy_huang@aspeedtech.com; s=20251124; h=from:subject:message-id;
 bh=T+gNJM9gWaGp5M6Zt1PpW3ZhSHLx8wYLQ9lvoLTijZw=;
 b=tNbfEgWa6rvkdqbUFPKbwcAMPiqYqexneNe11oxqAuG+vIY+0+r59coOEAAKcZ63CaJykQ0Wx
 4vZiJfra4T9CIt/ZqGJW9dTIHiohObTK5PlwwfbPMbuemDdQ1bnaEFq
X-Developer-Key: i=jammy_huang@aspeedtech.com; a=ed25519;
 pk=E5YwijeJZZcuDR6srvwNlXrNHvLxwipUg3Mb/xxUF9o=
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ast_get_vram_size() decodes the VRAM size from VGACRAA[1:0]. The size
of PCI BAR0, the framebuffer aperture, already reflects the VGA memory
size configured in hardware, so the separate register lookup is
redundant. Using the BAR size also guarantees that the VRAM mapping
never extends beyond the aperture that the device decodes.

Take the VRAM size from BAR0 and keep subtracting the reserved region
given by VGACR99[1:0].

Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
---
The ast driver currently determines the VRAM size by decoding
VGACRAA[1:0]. Since the size of PCI BAR0 already reflects the VGA
memory size configured in hardware, use it directly and drop the
register lookup. The reserved region reported in VGACR99[1:0] is still
subtracted from the result.
---
 drivers/gpu/drm/ast/ast_mm.c | 27 +++++----------------------
 1 file changed, 5 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_mm.c b/drivers/gpu/drm/ast/ast_mm.c
index 0bc14031946..6ef686cca5b 100644
--- a/drivers/gpu/drm/ast/ast_mm.c
+++ b/drivers/gpu/drm/ast/ast_mm.c
@@ -33,26 +33,10 @@
 
 #include "ast_drv.h"
 
-static u32 ast_get_vram_size(struct ast_device *ast)
+static resource_size_t ast_get_vram_size(struct ast_device *ast, resource_size_t bar_size)
 {
-	u32 vram_size;
-	u8 vgacr99, vgacraa;
-
-	vgacraa = ast_get_index_reg(ast, AST_IO_VGACRI, 0xaa);
-	switch (vgacraa & AST_IO_VGACRAA_VGAMEM_SIZE_MASK) {
-	case 0:
-		vram_size = SZ_8M;
-		break;
-	case 1:
-		vram_size = SZ_16M;
-		break;
-	case 2:
-		vram_size = SZ_32M;
-		break;
-	case 3:
-		vram_size = SZ_64M;
-		break;
-	}
+	resource_size_t vram_size = bar_size;
+	u8 vgacr99;
 
 	vgacr99 = ast_get_index_reg(ast, AST_IO_VGACRI, 0x99);
 	switch (vgacr99 & AST_IO_VGACR99_VGAMEM_RSRV_MASK) {
@@ -74,8 +58,7 @@ int ast_mm_init(struct ast_device *ast)
 {
 	struct drm_device *dev = &ast->base;
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	resource_size_t base, size;
-	u32 vram_size;
+	resource_size_t base, size, vram_size;
 
 	base = pci_resource_start(pdev, 0);
 	size = pci_resource_len(pdev, 0);
@@ -84,7 +67,7 @@ int ast_mm_init(struct ast_device *ast)
 	devm_arch_io_reserve_memtype_wc(dev->dev, base, size);
 	devm_arch_phys_wc_add(dev->dev, base, size);
 
-	vram_size = ast_get_vram_size(ast);
+	vram_size = ast_get_vram_size(ast, size);
 
 	ast->vram = devm_ioremap_wc(dev->dev, base, vram_size);
 	if (!ast->vram)

---
base-commit: 067c5c24cef23d913b67eaaf71ae67e7169a6620
change-id: 20261111-ast-vram-size-from-bar0-13819df1df24

Best regards,
-- 
Jammy Huang <jammy_huang@aspeedtech.com>

