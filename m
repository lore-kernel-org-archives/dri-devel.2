Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B81E10ED661
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:35:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEDDB10EE6A;
	Fri, 27 Mar 2026 13:35:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="Qsit5AL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rypOmzMj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Qsit5AL5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rypOmzMj";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8C8610EE58
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 13:35:42 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AC9EC5BDD3;
 Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0i0FRRcROmKGGR4Pe0O2DX0iaejrINpqINE3t1R3zU=;
 b=Qsit5AL5Ouei3xhK+7Ch76AWC421u2OTvYfxx08y83ZVeqzbtvPJvEggveB/XtMB8K5rtx
 YtWK9Lzob9A20vVWdGufxJrsButPRSKq8BCl251zR++jNVf7vwrmJoURfCfz2zd5Pp1wl9
 cQNQzL4A8zOakzsRtQ+V838fc+Mf/Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0i0FRRcROmKGGR4Pe0O2DX0iaejrINpqINE3t1R3zU=;
 b=rypOmzMjsQMQyuQSrF5rOV1Ezn5XFfRtmkqBb0Ki5nOctJ4EYh4sQBWHCHImBk3BxgBXxb
 rZzgweimuzMrxTDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Qsit5AL5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rypOmzMj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0i0FRRcROmKGGR4Pe0O2DX0iaejrINpqINE3t1R3zU=;
 b=Qsit5AL5Ouei3xhK+7Ch76AWC421u2OTvYfxx08y83ZVeqzbtvPJvEggveB/XtMB8K5rtx
 YtWK9Lzob9A20vVWdGufxJrsButPRSKq8BCl251zR++jNVf7vwrmJoURfCfz2zd5Pp1wl9
 cQNQzL4A8zOakzsRtQ+V838fc+Mf/Tk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774618536;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a0i0FRRcROmKGGR4Pe0O2DX0iaejrINpqINE3t1R3zU=;
 b=rypOmzMjsQMQyuQSrF5rOV1Ezn5XFfRtmkqBb0Ki5nOctJ4EYh4sQBWHCHImBk3BxgBXxb
 rZzgweimuzMrxTDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B1B54A0A2;
 Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yEy5GKiHxmleGgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 02/15] drm/ast: Move 32-bit register-access helpers to
 ast_drv.{c, h}
Date: Fri, 27 Mar 2026 14:32:54 +0100
Message-ID: <20260327133532.79696-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327133532.79696-1-tzimmermann@suse.de>
References: <20260327133532.79696-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: AC9EC5BDD3
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

- Reimplement the existing interfaces on top of these helpers.

Put the new implementation next to the other I/O helpers.

v2:
- fix typo in commit description (Jocelyn)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
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

