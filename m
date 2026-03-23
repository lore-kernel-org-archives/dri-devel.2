Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B5D4F483C1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 16:04:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1391B10E592;
	Mon, 23 Mar 2026 16:04:33 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCBF10E565
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 16:04:17 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 571174D364;
 Mon, 23 Mar 2026 16:04:12 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A01343968;
 Mon, 23 Mar 2026 16:04:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sLwfBXxkwWlfBAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 23 Mar 2026 16:04:12 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/15] drm/ast: Move 32-bit register-access helpers to
 ast_drv.{c, h}
Date: Mon, 23 Mar 2026 16:56:15 +0100
Message-ID: <20260323160407.245773-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160407.245773-1-tzimmermann@suse.de>
References: <20260323160407.245773-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 571174D364
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
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

The helpers ast_mindwm() and ast_moutdwm() access the I/O memory of
the various IP modules on the Aspeed device. This is based on the
"P-Bus to AHB Bridge" interface.

Reimplement the access function with properly defined constants and
helper macros.

- Define P2A constants for the related registers and addresses. The P2A
interface is located in the memory range at [0x00000000, 0x00010000].

- Memory access is segmented. An address' upper 16-bit select the
memory segment, the lower 16-bit select the offset within the segment.
Implement segment selection in a shared helper __ast_segsel(). Validate
that the segment hs been changes. This logic has previously been part
of __ast_moudwm() and __ast_mindwm(). Relax the CPU while busy-waiting.

- Put intra-segment reads and writes in the helpers __ast_rdseg32()
and __ast_wrseg32(). The helpers set the segment offset automatically.

- Reimplement the existing interfaces on put of these helpers.

Put the new implementation next to the other I/O helpers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/ast/ast_drv.c  | 59 ++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/ast/ast_drv.h  | 59 +++++++++++++++++++++-------------
 drivers/gpu/drm/ast/ast_post.c | 38 ----------------------
 drivers/gpu/drm/ast/ast_post.h |  3 --
 drivers/gpu/drm/ast/ast_reg.h  | 12 +++++++
 5 files changed, 108 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/ast/ast_drv.c b/drivers/gpu/drm/ast/ast_drv.c
index b9a9b050b546..05ec3542ab62 100644
--- a/drivers/gpu/drm/ast/ast_drv.c
+++ b/drivers/gpu/drm/ast/ast_drv.c
@@ -47,6 +47,65 @@ static int ast_modeset = -1;
 MODULE_PARM_DESC(modeset, "Disable/Enable modesetting");
 module_param_named(modeset, ast_modeset, int, 0400);
 
+/*
+ * Register access
+ */
+
+/* Select R/W segment */
+static void __ast_selseg(void __iomem *regs, u32 r)
+{
+	u32 p2a04, p2a04_base;
+
+	p2a04 = r & AST_REG_P2A04_BASE_MASK;
+	__ast_write32(regs, AST_REG_P2A04, p2a04);
+	__ast_write32(regs, AST_REG_P2A00, AST_REG_P2A00_PROTECTION_KEY);
+
+	do {
+		cpu_relax();
+		p2a04_base = __ast_read32(regs, AST_REG_P2A04);
+		p2a04_base &= AST_REG_P2A04_BASE_MASK;
+	} while (p2a04_base != p2a04);
+}
+
+/* Read within segment */
+static u32 __ast_rdseg32(void __iomem *regs, u32 r)
+{
+	return __ast_read32(regs, AST_REG_P2A_ADDR(r));
+}
+
+/* Write within segment */
+static void __ast_wrseg32(void __iomem *regs, u32 r, u32 v)
+{
+	__ast_write32(regs, AST_REG_P2A_ADDR(r), v);
+}
+
+u32 __ast_mindwm(void __iomem *regs, u32 r)
+{
+	__ast_selseg(regs, r);
+
+	return __ast_rdseg32(regs, r);
+}
+
+void __ast_moutdwm(void __iomem *regs, u32 r, u32 v)
+{
+	__ast_selseg(regs, r);
+	__ast_wrseg32(regs, r, v);
+}
+
+u32 ast_mindwm(struct ast_device *ast, u32 r)
+{
+	return __ast_mindwm(ast->regs, r);
+}
+
+void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
+{
+	__ast_moutdwm(ast->regs, r, v);
+}
+
+/*
+ * AST device
+ */
+
 void ast_device_init(struct ast_device *ast,
 		     enum ast_chip chip,
 		     enum ast_config_mode config_mode,
diff --git a/drivers/gpu/drm/ast/ast_drv.h b/drivers/gpu/drm/ast/ast_drv.h
index 787e38c6c17d..3eedf8239333 100644
--- a/drivers/gpu/drm/ast/ast_drv.h
+++ b/drivers/gpu/drm/ast/ast_drv.h
@@ -259,26 +259,20 @@ static inline bool __ast_gen_is_eq(struct ast_device *ast, unsigned long gen)
 #define IS_AST_GEN6(__ast)	__ast_gen_is_eq(__ast, 6)
 #define IS_AST_GEN7(__ast)	__ast_gen_is_eq(__ast, 7)
 
+/*
+ * MMIO access
+ */
+
 static inline u8 __ast_read8(const void __iomem *addr, u32 reg)
 {
 	return ioread8(addr + reg);
 }
 
-static inline u32 __ast_read32(const void __iomem *addr, u32 reg)
-{
-	return ioread32(addr + reg);
-}
-
 static inline void __ast_write8(void __iomem *addr, u32 reg, u8 val)
 {
 	iowrite8(val, addr + reg);
 }
 
-static inline void __ast_write32(void __iomem *addr, u32 reg, u32 val)
-{
-	iowrite32(val, addr + reg);
-}
-
 static inline u8 __ast_read8_i(void __iomem *addr, u32 reg, u8 index)
 {
 	__ast_write8(addr, reg, index);
@@ -307,16 +301,6 @@ static inline void __ast_write8_i_masked(void __iomem *addr, u32 reg, u8 index,
 	__ast_write8_i(addr, reg, index, tmp | val);
 }
 
-static inline u32 ast_read32(struct ast_device *ast, u32 reg)
-{
-	return __ast_read32(ast->regs, reg);
-}
-
-static inline void ast_write32(struct ast_device *ast, u32 reg, u32 val)
-{
-	__ast_write32(ast->regs, reg, val);
-}
-
 static inline u8 ast_io_read8(struct ast_device *ast, u32 reg)
 {
 	return __ast_read8(ast->ioregs, reg);
@@ -349,6 +333,39 @@ static inline void ast_set_index_reg_mask(struct ast_device *ast, u32 base, u8 i
 	__ast_write8_i_masked(ast->ioregs, base, index, preserve_mask, val);
 }
 
+/*
+ * Register access
+ */
+
+static inline u32 __ast_read32(const void __iomem *addr, u32 reg)
+{
+	return ioread32(addr + reg);
+}
+
+static inline void __ast_write32(void __iomem *addr, u32 reg, u32 val)
+{
+	iowrite32(val, addr + reg);
+}
+
+static inline u32 ast_read32(struct ast_device *ast, u32 reg)
+{
+	return __ast_read32(ast->regs, reg);
+}
+
+static inline void ast_write32(struct ast_device *ast, u32 reg, u32 val)
+{
+	__ast_write32(ast->regs, reg, val);
+}
+
+u32 __ast_mindwm(void __iomem *regs, u32 r);
+void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
+u32 ast_mindwm(struct ast_device *ast, u32 r);
+void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
+
+/*
+ * VBIOS
+ */
+
 struct ast_vbios_stdtable {
 	u8 misc;
 	u8 seq[4];
@@ -517,8 +534,6 @@ struct drm_device *ast_2600_device_create(struct pci_dev *pdev,
 
 /* ast post */
 int ast_post_gpu(struct ast_device *ast);
-u32 ast_mindwm(struct ast_device *ast, u32 r);
-void ast_moutdwm(struct ast_device *ast, u32 r, u32 v);
 
 int ast_vga_output_init(struct ast_device *ast);
 int ast_sil164_output_init(struct ast_device *ast);
diff --git a/drivers/gpu/drm/ast/ast_post.c b/drivers/gpu/drm/ast/ast_post.c
index b72914dbed38..5cec5d735b6a 100644
--- a/drivers/gpu/drm/ast/ast_post.c
+++ b/drivers/gpu/drm/ast/ast_post.c
@@ -34,44 +34,6 @@
 #include "ast_drv.h"
 #include "ast_post.h"
 
-u32 __ast_mindwm(void __iomem *regs, u32 r)
-{
-	u32 data;
-
-	__ast_write32(regs, 0xf004, r & 0xffff0000);
-	__ast_write32(regs, 0xf000, 0x1);
-
-	do {
-		data = __ast_read32(regs, 0xf004) & 0xffff0000;
-	} while (data != (r & 0xffff0000));
-
-	return __ast_read32(regs, 0x10000 + (r & 0x0000ffff));
-}
-
-void __ast_moutdwm(void __iomem *regs, u32 r, u32 v)
-{
-	u32 data;
-
-	__ast_write32(regs, 0xf004, r & 0xffff0000);
-	__ast_write32(regs, 0xf000, 0x1);
-
-	do {
-		data = __ast_read32(regs, 0xf004) & 0xffff0000;
-	} while (data != (r & 0xffff0000));
-
-	__ast_write32(regs, 0x10000 + (r & 0x0000ffff), v);
-}
-
-u32 ast_mindwm(struct ast_device *ast, u32 r)
-{
-	return __ast_mindwm(ast->regs, r);
-}
-
-void ast_moutdwm(struct ast_device *ast, u32 r, u32 v)
-{
-	__ast_moutdwm(ast->regs, r, v);
-}
-
 int ast_post_gpu(struct ast_device *ast)
 {
 	int ret;
diff --git a/drivers/gpu/drm/ast/ast_post.h b/drivers/gpu/drm/ast/ast_post.h
index aa5d247bebe8..41cd753b7f67 100644
--- a/drivers/gpu/drm/ast/ast_post.h
+++ b/drivers/gpu/drm/ast/ast_post.h
@@ -35,9 +35,6 @@ struct ast_dramstruct {
 #define AST_DRAMSTRUCT_IS(_entry, _name) \
 	((_entry)->index == __AST_DRAMSTRUCT_INDEX(_name))
 
-u32 __ast_mindwm(void __iomem *regs, u32 r);
-void __ast_moutdwm(void __iomem *regs, u32 r, u32 v);
-
 bool mmc_test(struct ast_device *ast, u32 datagen, u8 test_ctl);
 bool mmc_test_burst(struct ast_device *ast, u32 datagen);
 
diff --git a/drivers/gpu/drm/ast/ast_reg.h b/drivers/gpu/drm/ast/ast_reg.h
index 30578e3b07e4..ca9403efc7f9 100644
--- a/drivers/gpu/drm/ast/ast_reg.h
+++ b/drivers/gpu/drm/ast/ast_reg.h
@@ -75,4 +75,16 @@
 #define AST_IO_VGAIR1_R			(0x5A)
 #define AST_IO_VGAIR1_VREFRESH		BIT(3)
 
+/*
+ * P-Bus to AHB Bridge (0x00000000 - 0x0001ffff)
+ */
+
+#define AST_REG_P2A_BASE			(0x00000000)
+#define AST_REG_P2A(__offset)			(AST_REG_P2A_BASE + (__offset))
+#define AST_REG_P2A_ADDR(__addr)		AST_REG_P2A(0x10000 + ((__addr) & GENMASK(15, 0)))
+#define AST_REG_P2A00				AST_REG_P2A(0xf000)
+#define AST_REG_P2A00_PROTECTION_KEY		(0x01)
+#define AST_REG_P2A04				AST_REG_P2A(0xf004)
+#define AST_REG_P2A04_BASE_MASK			GENMASK(31, 16)
+
 #endif
-- 
2.53.0

