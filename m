Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B16606A333
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 22:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1114810E69D;
	Thu, 12 Nov 2026 22:59:43 +0000 (UTC)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com
 [209.85.128.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A27611123C8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 22:59:17 +0000 (UTC)
Received: by mail-yw1-f174.google.com with SMTP id
 00721157ae682-8b350d5fe3aso12299407b3.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:59:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794524356; x=1795129156;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KBBIgF1vez+pj8ttZD5gVBzVMPrmRY5jqYb7BJ0/LmM=;
 b=sfA4wu0oE/2CmJNjPKpZ7NRSXCpgndVuQZBKsC/f+oV+iNOOKyv+ex0ZNHQK1IyKle
 JeLCSj+XWHvsTFRdy5tXhO3fZJ7eoVZMeDwziWBvqER1TWXbXsSzeX8gdfkHk5kbJZjh
 R5A9bwDD3cwaVf1X0hEssivhiyH17HSUUApG+drjVzFbUf2PLWoI/1bGC3ToSM35LQAm
 JeZ5BeVj17KSCMy+Yr0qYODdy9L2g4UTIOGBJqNnYps0lgnO88jo+XNcWsMoS5KCMADE
 1Kqwk7RdVSSKLsXPN5OTEKCGE23BkA6rjJ7ThHezrI0J+ZeDkU/K+J/b8dUB8uP1lXzj
 QrTA==
X-Gm-Message-State: APuU4Z9wwGIgkSlIYiTLWokIAZhp2xZ0VyvSdioKcLamGwy5qnkzm2px
 bM9FbHBzMFDbUo+X57c1cYjC6/sxGpV4aj3IQJwkiGVQXergWomlLXiH
X-Gm-Gg: AYBFou2FPdFemTD8Xrjsjy1iczKBQ2wJo3PZbs0tJ5XuzcW+dWzv8rshL1VMAfSlWn3
 IXURZlDjto6ar567ysoq3UVFDM3JCcHYQnAyvVtskpeoi9CKcwsSpdRfyFJwylwLq1vJU0m+XKc
 AofEtXsChZzFH8a7j2UuyUnkZf+FJjFOn7kMLFgLkz4s/VuP870ycKnasnjBUIWCCxds9azdhvU
 I+/1CO+3LwuWmMqsggWUH3mE8WSQ42nLKLG9U7dv1lwsPT9J6/xbbZpqU3X+FlWLT5MLDs1AIyN
 TaFufEvasIEZdHi0Skxa7gYJepva7mV1nQN+9uKtHLZGa9Yi8Se6byvp5EGwZBcHgba4IrXsao3
 FZdoClpobXdouDpW9485tf9GanIDW9eJUh2wF0Gj+wjy+LVnFA0sjFk+YlhwtTsOEcO34//Qqsr
 UMXvIiUomEF9vv8s4QVxr+UF6aupSXjuHQBSQGSkw7P9T5kC6zbzzrrvOhrAIICJvPmmQHalZDW
 6hnPnWgNU1i8+CQtLeJPQVxYOFrNOZvXXpn9hSlQsALRGPyaBlmJ4IRqpx5KbwJcPIGPYrncsc9
 C+1YDw7TXC/I+JHd4JlC9xyjiGGH9xEsf3CbxXtTLsLkfkTx5nSRRqLLadOlVH9CxasxpFiolvL
 GiwYSKQzHgESI1NCS3uTqU1MgMgEnqJimrb62h7R14U2r8QCRKNiodNPftpoZ2sLvseIuTaMGe6
 OYlqzcTNamRAWNySO/45XzBHfz
X-Received: by 2002:a05:690c:f8f:b0:8b3:4911:2dc4 with SMTP id
 00721157ae682-8b4aa248369mr6113487b3.16.1794524356041; 
 Thu, 12 Nov 2026 14:59:16 -0800 (PST)
Received: from
 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa
 ([71.68.170.161]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b4aa8f354asm7261077b3.14.2026.11.12.14.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 14:59:15 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Thu, 12 Nov 2026 17:58:55 -0500
Subject: [PATCH RFC 05/13] drm/powervr_sgx: Add the core table, registers
 and device bring-up
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261112-powervr-sgx-v1-5-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
In-Reply-To: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
To: dri-devel@lists.freedesktop.org, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: imagination@lists.freedesktop.org, Frank Binns <frank.binns@imgtec.com>, 
 Gabriel Gama <operatingsystemsdepression@gmail.com>, 
 Matthew Brost <matthew.brost@intel.com>, Danilo Krummrich <dakr@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
 linux-media@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.16.0
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

The first part of powervr_sgx, a render-only DRM driver for the PowerVR
SGX5xx (Series5) GPUs. Nothing builds until the Kconfig entry, in the
last driver patch of this series.

- A core table names each supported core: its ID, the registers that
  move between SGX5xx cores, features, instruction set, directory lists
  and init script, and per part its revision, clock and firmware file.
  The bus says which core to expect, and a core the table doesn't have,
  or one the driver can't run, is refused before any register write.
- Each core's heap layout, quirks and register fields come from its
  entry, and nothing writes a register a core doesn't have.
- The register names come from the GPL SGX545 headers, through a
  generated pvrsgx_regs.h.
- Kernel memory and the GPU's two-level page tables, below 4 GiB and
  write-combined in every CPU mapping.
- The reset sequence: every directory list cleared, list 0 on a scratch
  directory that absorbs leftover faults, the microkernel's directory on
  the last list.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h  |  66 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_core.c   | 296 ++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_core.h   | 196 ++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_device.c | 461 ++++++++++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_device.h | 354 +++++++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_hw.h     |  55 ++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.c    | 281 +++++++++++++++++
 drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.h    |  28 ++
 drivers/gpu/drm/powervr_sgx/pvrsgx_regs.h   |  79 +++++
 9 files changed, 1816 insertions(+)

diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h
new file mode 100644
index 000000000..76ccee62e
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h
@@ -0,0 +1,66 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_CACHE_H
+#define PVRSGX_CACHE_H
+
+/*
+ * The SGX doesn't snoop the CPU caches. Memory the CPU writes for the GPU is
+ * written through uncached (write-combined) mappings. On x86 the linear map
+ * of those pages is made write-combined too. Elsewhere (ARM) the linear map
+ * stays cacheable: the lines the page's zeroing left are written back once,
+ * and the CPU only writes the page through its own write-combined mapping.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/mm.h>
+#include <linux/vmalloc.h>
+
+#if IS_ENABLED(CONFIG_X86)
+#include <asm/set_memory.h>
+
+static inline int pvrsgx_pages_wc(struct device *dev, struct page **pages, unsigned int n)
+{
+	return set_pages_array_wc(pages, n);
+}
+
+static inline void pvrsgx_pages_wb(struct page **pages, unsigned int n)
+{
+	set_pages_array_wb(pages, n);
+}
+
+/* A page table's CPU mapping: its linear map is already write-combined. */
+static inline u32 *pvrsgx_table_map(struct page *p)
+{
+	return page_address(p);
+}
+
+static inline void pvrsgx_table_unmap(u32 *cpu) { }
+#else
+static inline int pvrsgx_pages_wc(struct device *dev, struct page **pages, unsigned int n)
+{
+	for (unsigned int i = 0; i < n; i++) {
+		/* Mapping for the device writes back the page's dirty lines. */
+		dma_addr_t a = dma_map_page(dev, pages[i], 0, PAGE_SIZE, DMA_TO_DEVICE);
+
+		if (dma_mapping_error(dev, a))
+			return -ENOMEM;
+		dma_unmap_page(dev, a, PAGE_SIZE, DMA_TO_DEVICE);
+	}
+	return 0;
+}
+
+static inline void pvrsgx_pages_wb(struct page **pages, unsigned int n) { }
+
+static inline u32 *pvrsgx_table_map(struct page *p)
+{
+	return vmap(&p, 1, VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+}
+
+static inline void pvrsgx_table_unmap(u32 *cpu)
+{
+	vunmap(cpu);
+}
+#endif
+
+#endif /* PVRSGX_CACHE_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
new file mode 100644
index 000000000..dd8fd14eb
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
@@ -0,0 +1,296 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * The SGX5xx cores this driver knows. A core that is not listed is refused
+ * before any register write: on an unknown core the driver can't tell which
+ * register writes are safe.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sizes.h>
+
+#include "pvrsgx_cmd_defs.h"
+#include "pvrsgx_core.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_hw.h"
+
+bool pvrsgx_allow_unisolated;
+module_param_named(allow_unisolated, pvrsgx_allow_unisolated, bool, 0444);
+MODULE_PARM_DESC(allow_unisolated,
+		 "Run a single-context core (SGX530), where clients can reach the firmware and each other's commands (default off)");
+
+static const struct pvrsgx_core_regs sgx545_regs = {
+	.core_id = SGX_CR_CORE_ID,
+	.core_revision = SGX_CR_CORE_REVISION,
+	.clkgatectl_units = SGX_CR_CLKGATECTL_UNITS,
+	.clkgatectl_dpm = SGX_CR_CLKGATECTL_DPM_CLKG,
+	.clkgatectl2 = SGX_CR_CLKGATECTL2,
+	.clkgatectl2_units = SGX_CR_CLKGATECTL2_UNITS,
+	.clkgatestatus = SGX_CR_CLKGATESTATUS,
+	.clkgatestatus_dpm = SGX_CR_CLKGATESTATUS_DPM_CLKS,
+	.soft_reset_bif = SGX_CR_SOFT_RESET_BIF_RESET,
+	.soft_reset_cores = SGX_CR_SOFT_RESET_DPM_RESET | SGX_CR_SOFT_RESET_TA_RESET |
+			    SGX_CR_SOFT_RESET_USE_RESET | SGX_CR_SOFT_RESET_ISP_RESET |
+			    SGX_CR_SOFT_RESET_TSP_RESET,
+	.event_kick2 = SGX_CR_EVENT_KICK2,
+	.event_kick2_now = SGX_CR_EVENT_KICK2_NOW,
+	.use_code_base0 = SGX_CR_USE_CODE_BASE_0,
+	.pds_exec_base = SGX_CR_PDS_EXEC_BASE,
+	.bif_int_stat_fault_req = SGX_CR_BIF_INT_STAT_FAULT_REQ,
+	.bif_int_stat_fault_type = SGX_CR_BIF_INT_STAT_FAULT_TYPE,
+	.bif_fault_addr = SGX_MMU_ADDR_MASK,
+	.bif_bank_set = SGX_CR_BIF_BANK_SET,
+	.bif_bank0 = SGX_CR_BIF_BANK0,
+	.use_code_base_dm_shift = 25,
+	.use_code_base_addr_shift = 7,
+	.cr_b30 = 0x0b30,
+	.event_pds_enable = SGX545_CR_EVENT_PDS_ENABLE,
+	.event_pds_enable_all = SGX545_CR_EVENT_PDS_ENABLE_ALL,
+	.event_pds_base = SGX545_CR_EVENT_PDS_BASE,
+	.event_pds_data0 = SGX545_CR_EVENT_PDS_DATA0,
+	.event_pds_data1 = SGX545_CR_EVENT_PDS_DATA1,
+	.edm_task_reg0 = SGX545_CR_EDM_TASK_REG0,
+	.edm_task_reg1 = SGX545_CR_EDM_TASK_REG1,
+};
+
+/* Each heap runs to the next one's base. */
+static const struct pvrsgx_heap_layout sgx545_heaps = {
+	.params_3d = { PVRSGX_HEAP_3D_PARAMS, PVRSGX_HEAP_TA_DATA },
+	.ta_data = { PVRSGX_HEAP_TA_DATA, PVRSGX_HEAP_SYNC },
+	.sync = { PVRSGX_HEAP_SYNC, PVRSGX_HEAP_PDS_PIXEL },
+	.pds_pixel = { PVRSGX_HEAP_PDS_PIXEL, PVRSGX_HEAP_KERNEL_CODE },
+	.kernel_code = { PVRSGX_HEAP_KERNEL_CODE, PVRSGX_HEAP_PDS_VERTEX },
+	.pds_vertex = { PVRSGX_HEAP_PDS_VERTEX, PVRSGX_HEAP_KERNEL_DATA },
+	.kernel_data = { PVRSGX_HEAP_KERNEL_DATA, PVRSGX_HEAP_USSE_PIXEL },
+	.usse_pixel = { PVRSGX_HEAP_USSE_PIXEL,
+			PVRSGX_HEAP_USSE_PIXEL + PVRSGX_HEAP_USSE_PIXEL_SIZE },
+	.usse_vertex = { PVRSGX_HEAP_USSE_VERTEX,
+			 PVRSGX_HEAP_USSE_VERTEX + PVRSGX_HEAP_USSE_VERTEX_SIZE },
+	.general = { PVRSGX_HEAP_GENERAL, PVRSGX_HEAP_TEXTURE },
+	.texture = { PVRSGX_HEAP_TEXTURE, SZ_4G },
+	.pb_max_pages = 0x8000,
+};
+
+/*
+ * Init script part 2, written in this order. Most of these registers have no
+ * name in the GPL header.
+ */
+static const struct pvrsgx_core_init_reg sgx545_init_regs[] = {
+	{ 0x818, 0x7ff }, { 0x810, 1 }, { 0x814, 0xffff },
+	{ SGX_CR_EVENT_HOST_ENABLE, SGX_CR_EVENT_STATUS_SW_EVENT },
+	{ SGX_CR_EVENT_HOST_ENABLE2, 0 },
+	{ 0x13c, 0 }, { 0xa7c, 0 }, { 0xa80, 0 }, { 0xa74, 0x208200 }, { 0x4e8, 0x100 },
+	{ 0xa78, 0x2c }, { 0xaac, 0x45 }, { 0xabc, 0xe }, { 0x800, 0x30 }, { 0x804, 0xffff },
+	{ 0xa00, 0x7c000 },
+};
+
+/*
+ * SGX530 (TI OMAP3630), from the GPL sgx530defs.h.
+ * It has no CLKGATECTL2, EVENT_KICK2 or BIF bank registers. The event PDS
+ * registers aren't in the GPL header: the SGX545's offsets, a guess here,
+ * checked by reading back before the first kick.
+ */
+static const struct pvrsgx_core_regs sgx530_regs = {
+	.core_id = 0x0010,
+	.core_revision = 0x0014,
+	/* 2D b0-1, ISP b4-5, TSP b8-9, TA b12-13, DPM b16-17, USE b20-21 */
+	.clkgatectl_units = 0x00333333,
+	.clkgatectl_dpm = GENMASK(17, 16),
+	.clkgatestatus = 0x0004,
+	.clkgatestatus_dpm = BIT(16),
+	.soft_reset_bif = BIT(0),
+	/* 2D b1, DPM b2, TA b3, USE b4, ISP b5, TSP b6 */
+	.soft_reset_cores = GENMASK(6, 1),
+	.use_code_base0 = SGX_CR_USE_CODE_BASE_0,
+	.pds_exec_base = SGX_CR_PDS_EXEC_BASE,
+	.bif_int_stat_fault_req = GENMASK(13, 0),
+	.bif_int_stat_fault_type = BIT(14),	/* read or write */
+	.bif_fault_addr = GENMASK(27, 12),
+	.use_code_base_dm_shift = 24,
+	/* 256-byte units: the EDM fetches at field << 8. */
+	.use_code_base_addr_shift = 8,
+	.event_pds_enable = SGX545_CR_EVENT_PDS_ENABLE,
+	.event_pds_enable_all = SGX545_CR_EVENT_PDS_ENABLE_ALL,
+	.event_pds_base = SGX545_CR_EVENT_PDS_BASE,
+	.event_pds_data0 = SGX545_CR_EVENT_PDS_DATA0,
+	.event_pds_data1 = SGX545_CR_EVENT_PDS_DATA1,
+};
+
+/* Init script part 2 for the SGX530: the host's interrupt, and one SGX545 write. */
+static const struct pvrsgx_core_init_reg sgx530_init_regs[] = {
+	{ SGX_CR_EVENT_HOST_ENABLE, SGX_CR_EVENT_STATUS_SW_EVENT },
+	{ SGX_CR_EVENT_HOST_ENABLE2, 0 },
+	/* Unnamed; without it the PDS fetches nothing. */
+	{ 0xa74, 0x208200 },
+};
+
+/*
+ * 256 MiB, every heap on a 4 MiB directory entry. From PDS pixel up, the
+ * bases of the GPL SGX530 sgxconfig.h: kernel code above both PDS
+ * heaps, within the 64 MiB the EDM reaches past PDS_EXEC_BASE. The texture
+ * heap, which that layout lacks, is the top of its general heap.
+ */
+static const struct pvrsgx_heap_layout sgx530_heaps = {
+	.general = { 0x01800000, 0x05000000 },
+	.texture = { 0x05000000, 0x08400000 },
+	.params_3d = { 0x08400000, 0x0c400000 },
+	.ta_data = { 0x0c400000, 0x0d400000 },
+	.sync = { 0x0d400000, 0x0d800000 },
+	.pds_pixel = { 0x0d800000, 0x0e000000 },
+	.pds_vertex = { 0x0e000000, 0x0e800000 },
+	.kernel_code = { 0x0ec00000, 0x0f000000 },
+	.kernel_data = { 0x0f000000, 0x0f400000 },
+	.usse_pixel = { 0x0f400000, 0x0f900000 },
+	.usse_vertex = { 0x0fc00000, 0x0fe00000 },
+	.pb_max_pages = 0x800,
+};
+
+static const struct pvrsgx_core_family families[] = {
+	{
+		.name = "SGX545",
+		.core = 545,
+		.core_id = 0x01150000,
+		.regs = &sgx545_regs,
+		.features = PVRSGX_FEATURE_MULTIPLE_MEM_CONTEXTS |
+			    PVRSGX_FEATURE_MULTI_EVENT_KICK |
+			    PVRSGX_FEATURE_PDS_DATA_INTERLEAVE_2DWORDS |
+			    PVRSGX_FEATURE_EDM_VERTEX_PDSADDR_FULL_RANGE,
+		.isa = PVRSGX_ISA_SGX545,
+		.num_dir_lists = 16,
+		.va_bits = 32,
+		.heaps = &sgx545_heaps,
+		.cmds = &pvrsgx_cmd_core_sgx545,
+		.init_regs = sgx545_init_regs,
+		.num_init_regs = ARRAY_SIZE(sgx545_init_regs),
+	},
+	{
+		/* One memory context, one kick (BRN_22934), 28-bit addresses. */
+		.name = "SGX530",
+		.core = 530,
+		/* Read on an OMAP3630 board. */
+		.core_id = 0x01120000,
+		.regs = &sgx530_regs,
+		.isa = PVRSGX_ISA_SGX545,
+		.num_dir_lists = 1,
+		.va_bits = 28,
+		.heaps = &sgx530_heaps,
+		.quirks = PVRSGX_QUIRK_BRN_28889,
+		.event_pds_guessed = true,
+		/* Its task's stores to EDMPROTECT pages fault. */
+		.data_no_edmprotect = true,
+		.cmds = &pvrsgx_cmd_core_sgx530,
+		.init_regs = sgx530_init_regs,
+		.num_init_regs = ARRAY_SIZE(sgx530_init_regs),
+	},
+};
+
+static const struct pvrsgx_core_info cores[] = {
+	{
+		.family = &families[0],
+		.name = "Intel CE5300 (SGX545 1.0.14)",
+		.core_rev = 0x0001000e,
+		.clock_hz = 400000000,
+		.fw_name = "powervr_sgx/sgx545_ukernel.bin",
+	},
+	{
+		/*
+		 * The same core one revision earlier: same features and instruction set, the same
+		 * microkernel. Its clock depends on the part (400 or 640 MHz);
+		 * the microkernel's timer only needs the order of magnitude.
+		 */
+		.family = &families[0],
+		.name = "Intel Cedarview (SGX545 1.0.13)",
+		.core_rev = 0x0001000d,
+		.clock_hz = 400000000,
+		.fw_name = "powervr_sgx/sgx545_ukernel.bin",
+	},
+	{
+		/*
+		 * Revision read on our OMAP3630 test board. The microkernel's
+		 * timer needs only the clock's order of magnitude.
+		 */
+		.family = &families[1],
+		.name = "TI OMAP3630 (SGX530 1.2.5)",
+		.core_rev = 0x00010205,
+		.clock_hz = 200000000,
+		.fw_name = "powervr_sgx/sgx530_ukernel.bin",
+	},
+};
+
+MODULE_FIRMWARE("powervr_sgx/sgx545_ukernel.bin");
+MODULE_FIRMWARE("powervr_sgx/sgx530_ukernel.bin");
+
+/*
+ * Without EDM_VERTEX_PDSADDR_FULL_RANGE, a heap the EDM runs PDS code from
+ * lies within 64 MiB above the PDS pixel heap (the GPL sgxconfig.h).
+ */
+static bool pds_reach(const struct pvrsgx_core_family *f, const struct pvrsgx_va_range *r)
+{
+	u64 exec = f->heaps->pds_pixel.base;
+
+	if (f->features & PVRSGX_FEATURE_EDM_VERTEX_PDSADDR_FULL_RANGE)
+		return true;
+	return r->base >= exec && r->end - exec <= SZ_64M;
+}
+
+static bool heaps_fit(const struct pvrsgx_core_family *f)
+{
+	const struct pvrsgx_heap_layout *h = f->heaps;
+	const struct pvrsgx_va_range *r[] = {
+		&h->params_3d, &h->ta_data, &h->sync, &h->pds_pixel, &h->kernel_code,
+		&h->pds_vertex, &h->kernel_data, &h->usse_pixel, &h->usse_vertex,
+		&h->general, &h->texture,
+	};
+
+	for (unsigned int i = 0; i < ARRAY_SIZE(r); i++)
+		if (r[i]->base >= r[i]->end || r[i]->end > BIT_ULL(f->va_bits))
+			return false;
+	return pds_reach(f, &h->kernel_code) && pds_reach(f, &h->pds_vertex);
+}
+
+/*
+ * Whether the driver can run the core, not only identify it: either a
+ * directory list per VM, or exactly one; a heap layout within its address
+ * space; the event PDS registers that enter the microkernel; and the second
+ * kick register exactly when the core has one.
+ */
+bool pvrsgx_core_family_usable(const struct pvrsgx_core_family *f)
+{
+	const struct pvrsgx_core_regs *cr = f->regs;
+	bool multi = f->features & PVRSGX_FEATURE_MULTIPLE_MEM_CONTEXTS;
+	bool kick2 = f->features & PVRSGX_FEATURE_MULTI_EVENT_KICK;
+
+	if (multi ? f->num_dir_lists < 2 || f->num_dir_lists > SGX_BIF_MAX_DIRLISTS :
+		    f->num_dir_lists != 1)
+		return false;
+	if ((f->va_bits != 28 && f->va_bits != 32) || !f->heaps || !heaps_fit(f) || !f->cmds)
+		return false;
+	return cr->event_pds_enable && cr->event_pds_base && kick2 == !!cr->event_kick2;
+}
+
+/*
+ * The core the bus says is there (545 for an SGX545), or NULL if the driver
+ * doesn't know where its registers are. Whether it can run it is
+ * pvrsgx_core_family_usable().
+ */
+const struct pvrsgx_core_family *pvrsgx_core_family_get(unsigned int core)
+{
+	for (unsigned int i = 0; i < ARRAY_SIZE(families); i++)
+		if (families[i].core == core)
+			return &families[i];
+	return NULL;
+}
+
+/* The entry for this part, or NULL if the driver doesn't know it. */
+const struct pvrsgx_core_info *pvrsgx_core_lookup(const struct pvrsgx_core_family *family,
+						  u32 core_id, u32 core_rev)
+{
+	if (core_id != family->core_id)
+		return NULL;
+	for (unsigned int i = 0; i < ARRAY_SIZE(cores); i++)
+		if (cores[i].family == family && cores[i].core_rev == core_rev)
+			return &cores[i];
+	return NULL;
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_core.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.h
new file mode 100644
index 000000000..58c1d4613
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_CORE_H
+#define PVRSGX_CORE_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+struct pvrsgx_cmd_core;
+
+/*
+ * Core features, as the SGX_FEATURE_* names of the GPL sgxfeaturedefs.h.
+ * Only those the driver's design depends on are listed.
+ */
+/* One page directory per client: BIF directory lists beyond list 0. */
+#define PVRSGX_FEATURE_MULTIPLE_MEM_CONTEXTS	BIT(0)
+/* EUR_CR_EVENT_KICK1..3 next to EUR_CR_EVENT_KICK. */
+#define PVRSGX_FEATURE_MULTI_EVENT_KICK		BIT(1)
+/* The PDS data store interleaves DS0 and DS1 two words at a time. */
+#define PVRSGX_FEATURE_PDS_DATA_INTERLEAVE_2DWORDS	BIT(2)
+/*
+ * The EDM reaches PDS code anywhere. Without it, the kernel code and PDS
+ * vertex heaps lie within 64 MiB above the PDS pixel heap (PDS_EXEC_BASE):
+ * the GPL sgxconfig.h refuses any other layout.
+ */
+#define PVRSGX_FEATURE_EDM_VERTEX_PDSADDR_FULL_RANGE	BIT(3)
+
+/* Errata the kernel works around (the GPL headers' FIX_HW_BRN_*). */
+/* A BIF directory or table invalidate and a data invalidate never in one command. */
+#define PVRSGX_QUIRK_BRN_28889			BIT(0)
+
+/* The USSE instruction set, for the shader validator's tables. */
+enum pvrsgx_isa {
+	PVRSGX_ISA_SGX545,
+};
+
+/* A device-virtual range, [base, end). */
+struct pvrsgx_va_range {
+	u64 base;
+	u64 end;
+};
+
+/*
+ * struct pvrsgx_heap_layout - Where every heap sits
+ *
+ * Device-wide, the same in every VM. The kernel heaps (kernel code, kernel
+ * data, sync) are whole 4 MiB directory entries.
+ */
+struct pvrsgx_heap_layout {
+	struct pvrsgx_va_range params_3d;
+	struct pvrsgx_va_range ta_data;
+	struct pvrsgx_va_range sync;
+	struct pvrsgx_va_range pds_pixel;
+	struct pvrsgx_va_range kernel_code;
+	struct pvrsgx_va_range pds_vertex;
+	struct pvrsgx_va_range kernel_data;
+	struct pvrsgx_va_range usse_pixel;
+	struct pvrsgx_va_range usse_vertex;
+	struct pvrsgx_va_range general;
+	struct pvrsgx_va_range texture;
+	/* The largest PB, in pages, the 3D parameters heap holds. */
+	u32 pb_max_pages;
+};
+
+/*
+ * struct pvrsgx_core_regs - Registers that move or change between SGX5xx cores
+ *
+ * The other registers in pvrsgx_regs.h sit at the same offsets with the same
+ * fields on SGX535, 540, 544 and 545 (the GPL sgx5xxdefs.h). A register
+ * a core lacks is 0.
+ */
+struct pvrsgx_core_regs {
+	u32 core_id;
+	u32 core_revision;
+	u32 clkgatectl_units;		/* every gating field of CLKGATECTL */
+	u32 clkgatectl_dpm;		/* CLKGATECTL's DPM field */
+	u32 clkgatectl2;
+	u32 clkgatectl2_units;
+	u32 clkgatestatus;
+	u32 clkgatestatus_dpm;
+	u32 soft_reset_bif;
+	u32 soft_reset_cores;		/* every unit's reset but the BIF's */
+	u32 event_kick2;
+	u32 event_kick2_now;
+	u32 use_code_base0;
+	u32 pds_exec_base;
+	u32 bif_int_stat_fault_req;
+	u32 bif_int_stat_fault_type;
+	u32 bif_fault_addr;		/* BIF_FAULT's address field */
+	u32 bif_bank_set;
+	u32 bif_bank0;
+	u32 use_code_base_dm_shift;	/* USE_CODE_BASE's data-master field */
+	u32 use_code_base_addr_shift;	/* USE_CODE_BASE's address unit, log2 bytes */
+	u32 cr_b30;			/* unnamed, 0x100 at start on the SGX545 */
+	/* Not in the GPL header (pvrsgx_hw.h). */
+	u32 event_pds_enable;
+	u32 event_pds_enable_all;
+	u32 event_pds_base;
+	u32 event_pds_data0;
+	u32 event_pds_data1;
+	u32 edm_task_reg0;
+	u32 edm_task_reg1;
+};
+
+/* One write of a core's init script. */
+struct pvrsgx_core_init_reg {
+	u16 reg;
+	u32 val;
+};
+
+/**
+ * struct pvrsgx_core_family - What one SGX5xx core design has in common
+ *
+ * Every revision and part of the core shares these. The bus says which core
+ * to expect, since even SGX_CR_CORE_ID moves between cores.
+ */
+struct pvrsgx_core_family {
+	/** @name: The core, as "SGX545". */
+	const char *name;
+	/** @core: Its number, as the bus glue names it: 545 for SGX545. */
+	unsigned int core;
+	/** @core_id: Expected SGX_CR_CORE_ID. */
+	u32 core_id;
+	/** @regs: Where its registers and fields are. */
+	const struct pvrsgx_core_regs *regs;
+	/** @features: PVRSGX_FEATURE_*. */
+	u32 features;
+	/** @isa: Its USSE instruction set. */
+	enum pvrsgx_isa isa;
+	/** @num_dir_lists: BIF directory lists (SGX_FEATURE_BIF_NUM_DIRLISTS). */
+	u32 num_dir_lists;
+	/** @va_bits: Device-virtual address bits (SGX_FEATURE_ADDRESS_SPACE_SIZE). */
+	u32 va_bits;
+	/** @heaps: The device-virtual layout, within @va_bits. */
+	const struct pvrsgx_heap_layout *heaps;
+	/** @quirks: PVRSGX_QUIRK_*. */
+	u32 quirks;
+	/**
+	 * @event_pds_guessed: The event PDS registers are a guess, not yet
+	 * confirmed on this core: refuse to kick if the program address
+	 * doesn't read back.
+	 */
+	bool event_pds_guessed;
+	/**
+	 * @data_no_edmprotect: Map the kernel data arena without EDMPROTECT. A
+	 * bring-up stopgap for the SGX530, whose microkernel task's stores to an
+	 * EDMPROTECT page fault. It runs only with allow_unisolated, which
+	 * already gives up client isolation on such a core.
+	 */
+	bool data_no_edmprotect;
+	/** @cmds: What its client commands are checked against (pvrsgx_cmd_defs.c). */
+	const struct pvrsgx_cmd_core *cmds;
+	/** @init_regs: Init script part 2's register writes, in order. */
+	const struct pvrsgx_core_init_reg *init_regs;
+	/** @num_init_regs: Entries in @init_regs. */
+	unsigned int num_init_regs;
+};
+
+/**
+ * struct pvrsgx_core_info - One SGX5xx part this driver supports
+ *
+ * A new part of a known core is a new entry; a new core is a new
+ * &struct pvrsgx_core_family as well. The microkernel host interface and the
+ * client heaps are the same across the family.
+ */
+struct pvrsgx_core_info {
+	/** @family: The core design. */
+	const struct pvrsgx_core_family *family;
+	/** @name: What the part is called in the log. */
+	const char *name;
+	/** @core_rev: Expected SGX_CR_CORE_REVISION. */
+	u32 core_rev;
+	/** @clock_hz: Core clock, for the microkernel's timer. */
+	u32 clock_hz;
+	/** @fw_name: The open microkernel under /lib/firmware. */
+	const char *fw_name;
+};
+
+/*
+ * One memory context: the microkernel, TA, 3D and 2D all translate through
+ * directory list 0, so the firmware heaps are in every VM's directory.
+ */
+static inline bool pvrsgx_core_single_context(const struct pvrsgx_core_family *f)
+{
+	return !(f->features & PVRSGX_FEATURE_MULTIPLE_MEM_CONTEXTS);
+}
+
+extern bool pvrsgx_allow_unisolated;
+
+const struct pvrsgx_core_family *pvrsgx_core_family_get(unsigned int core);
+bool pvrsgx_core_family_usable(const struct pvrsgx_core_family *f);
+const struct pvrsgx_core_info *pvrsgx_core_lookup(const struct pvrsgx_core_family *family,
+						  u32 core_id, u32 core_rev);
+
+#endif /* PVRSGX_CORE_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_device.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_device.c
new file mode 100644
index 000000000..9328e8e06
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_device.c
@@ -0,0 +1,461 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+#include <drm/drm_managed.h>
+#include <drm/drm_print.h>
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
+#include <drm/gma500_sgx.h>
+#endif
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/jiffies.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "pvrsgx_ccb.h"
+#include "pvrsgx_core.h"
+#include "pvrsgx_device.h"
+#include "pvrsgx_fw.h"
+#include "pvrsgx_job.h"
+#include "pvrsgx_trace.h"
+#include "pvrsgx_kobj.h"
+#include "pvrsgx_mmu.h"
+#include "pvrsgx_render.h"
+
+int pvrsgx_poll(struct pvrsgx_device *sdev, const u32 *addr, u32 mask, u32 val,
+		unsigned int timeout_us)
+{
+	ktime_t end = ktime_add_us(ktime_get(), timeout_us);
+
+	for (;;) {
+		if ((READ_ONCE(*addr) & mask) == val)
+			return 0;
+		if (ktime_after(ktime_get(), end))
+			return (READ_ONCE(*addr) & mask) == val ? 0 : -ETIMEDOUT;
+		usleep_range(20, 50);
+	}
+}
+
+/*
+ * Kernel-owned memory at a fixed device address, mapped in the firmware's
+ * directory. Pages below 4 GiB, write-combined in every CPU mapping. gfp adds
+ * to GFP_KERNEL: __GFP_ACCOUNT for what a client's ioctl allocates.
+ */
+int pvrsgx_kmem_alloc(struct pvrsgx_device *sdev, struct pvrsgx_kmem *km,
+		      u32 dev_addr, u32 size, u32 pte_flags, gfp_t gfp)
+{
+	unsigned int i;
+	int err = -ENOMEM;
+
+	km->dev_addr = dev_addr;
+	km->size = PAGE_ALIGN(size);
+	km->npages = km->size >> PAGE_SHIFT;
+	km->pages = kvcalloc(km->npages, sizeof(*km->pages), GFP_KERNEL | gfp);
+	if (!km->pages)
+		return -ENOMEM;
+	for (i = 0; i < km->npages; i++) {
+		km->pages[i] = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA32 | gfp);
+		if (!km->pages[i])
+			goto err_free;
+	}
+	if (pvrsgx_pages_wc(sdev->base.dev, km->pages, km->npages))
+		goto err_free;
+	km->cpu = vmap(km->pages, km->npages, VM_MAP, pgprot_writecombine(PAGE_KERNEL));
+	if (!km->cpu)
+		goto err_wb;
+	if (!km->mmu)
+		km->mmu = sdev->kernel_mmu;
+	err = pvrsgx_mmu_map_pages(km->mmu, dev_addr, km->pages, km->npages, pte_flags);
+	if (err)
+		goto err_unmap;
+	return 0;
+
+err_unmap:
+	vunmap(km->cpu);
+err_wb:
+	pvrsgx_pages_wb(km->pages, km->npages);
+err_free:
+	while (i--)
+		__free_page(km->pages[i]);
+	kvfree(km->pages);
+	km->pages = NULL;
+	return err;
+}
+
+void pvrsgx_kmem_free(struct pvrsgx_device *sdev, struct pvrsgx_kmem *km)
+{
+	if (!km->pages)
+		return;
+	pvrsgx_mmu_unmap(km->mmu, km->dev_addr, km->size);
+	pvrsgx_kmem_release(km);
+}
+
+/* The memory of kmem the caller has already unmapped from the GPU. */
+void pvrsgx_kmem_release(struct pvrsgx_kmem *km)
+{
+	if (!km->pages)
+		return;
+	vunmap(km->cpu);
+	pvrsgx_pages_wb(km->pages, km->npages);
+	for (unsigned int i = 0; i < km->npages; i++)
+		__free_page(km->pages[i]);
+	kvfree(km->pages);
+	km->pages = NULL;
+}
+
+/* A few core clocks for a register write to take effect. */
+static void reset_sleep(struct pvrsgx_device *sdev)
+{
+	sgx_rd(sdev, SGX_CR_SOFT_RESET);
+	udelay(1);
+}
+
+static void soft_reset(struct pvrsgx_device *sdev, bool bif)
+{
+	sgx_wr(sdev, SGX_CR_SOFT_RESET,
+	       sdev->cr->soft_reset_cores | (bif ? sdev->cr->soft_reset_bif : 0));
+}
+
+/* BIF_CTRL is 0 whenever the microkernel runs: its invalidates pulse a bit, then write 0. */
+static void inval_dc(struct pvrsgx_device *sdev)
+{
+	sgx_wr(sdev, SGX_CR_BIF_CTRL, SGX_CR_BIF_CTRL_INVALDC);
+	sgx_wr(sdev, SGX_CR_BIF_CTRL, 0);
+	reset_sleep(sdev);
+}
+
+/*
+ * The reset sequence for a single-core SGX5xx: reset everything, clear the directory
+ * lists, take the cores out of reset with list 0 on a scratch directory that
+ * absorbs faults left over from before, then give the microkernel its own
+ * directory on the last list (list 15 on the SGX545).
+ */
+void pvrsgx_reset(struct pvrsgx_device *sdev, bool recovery)
+{
+	soft_reset(sdev, true);
+	reset_sleep(sdev);
+
+	sgx_wr(sdev, SGX_CR_BIF_CTRL, 0);
+	sgx_wr_opt(sdev, sdev->cr->bif_bank_set, 0);
+	sgx_wr_opt(sdev, sdev->cr->bif_bank0, 0);
+	for (unsigned int i = 0; i < sdev->family->num_dir_lists; i++)
+		sgx_wr(sdev, sgx_cr_bif_dir_list_base(i), 0);
+
+	if (recovery) {
+		sgx_wr(sdev, sgx_cr_bif_dir_list_base(0), pvrsgx_mmu_pd_addr(sdev->reset_mmu));
+		reset_sleep(sdev);
+		soft_reset(sdev, false);
+		reset_sleep(sdev);
+		inval_dc(sdev);
+
+		/* Let each faulting request complete on a scratch page. */
+		for (int n = 0; n < 32; n++) {
+			u32 stat = sgx_rd(sdev, SGX_CR_BIF_INT_STAT), addr;
+
+			if (!(stat & sdev->cr->bif_int_stat_fault_req))
+				break;
+			addr = sgx_rd(sdev, SGX_CR_BIF_FAULT) & sdev->cr->bif_fault_addr;
+			drm_warn(&sdev->base, "reset: page fault 0x%x at 0x%08x\n", stat, addr);
+			soft_reset(sdev, true);
+			pvrsgx_mmu_map_pages(sdev->reset_mmu, addr, &sdev->reset_page, 1, 0);
+			sgx_wr(sdev, SGX_CR_EVENT_HOST_CLEAR, sgx_rd(sdev, SGX_CR_EVENT_STATUS));
+			sgx_wr(sdev, SGX_CR_EVENT_HOST_CLEAR2, sgx_rd(sdev, SGX_CR_EVENT_STATUS2));
+			/* The reset page's PTE is in memory before the cores leave reset. */
+			wmb();
+			reset_sleep(sdev);
+			soft_reset(sdev, false);
+			reset_sleep(sdev);
+			inval_dc(sdev);
+			pvrsgx_mmu_unmap(sdev->reset_mmu, addr, SGX_MMU_PAGE_SIZE);
+		}
+	} else {
+		soft_reset(sdev, false);
+		reset_sleep(sdev);
+	}
+
+	sgx_wr_opt(sdev, sdev->cr->bif_bank0,
+		   FIELD_PREP(SGX_CR_BIF_BANK0_INDEX_EDM, pvrsgx_dirlist_edm(sdev)));
+	/* With one directory list the EDM's is list 0, set below. */
+	if (pvrsgx_dirlist_edm(sdev))
+		sgx_wr(sdev, sgx_cr_bif_dir_list_base(pvrsgx_dirlist_edm(sdev)),
+		       pvrsgx_mmu_pd_addr(sdev->kernel_mmu));
+	sgx_wr(sdev, sgx_cr_bif_dir_list_base(0),
+	       pvrsgx_mmu_pd_addr(pvrsgx_idle_mmu(sdev)));
+	inval_dc(sdev);
+
+	sgx_wr(sdev, SGX_CR_SOFT_RESET, 0);
+	reset_sleep(sdev);
+}
+
+/* The microkernel raises SW_EVENT when it wants the host. */
+static irqreturn_t pvrsgx_irq(int irq, void *arg)
+{
+	struct pvrsgx_device *sdev = arg;
+	u32 status;
+
+	if (!READ_ONCE(sdev->powered))
+		return IRQ_NONE;
+	status = sgx_rd(sdev, SGX_CR_EVENT_STATUS) & sgx_rd(sdev, SGX_CR_EVENT_HOST_ENABLE);
+	if (!(status & SGX_CR_EVENT_STATUS_SW_EVENT))
+		return IRQ_NONE;
+	trace_pvrsgx_irq(status);
+	sgx_wr(sdev, SGX_CR_EVENT_HOST_CLEAR,
+	       SGX_CR_EVENT_HOST_CLEAR_SW_EVENT | SGX_CR_EVENT_HOST_CLEAR_MASTER_INTERRUPT);
+	atomic_inc(&sdev->irq_count);
+	/*
+	 * The microkernel may interrupt at TA and 3D completion too: wake the
+	 * thread only for a finished job or a lockup report.
+	 */
+	if (!sdev->fw_running || pvrsgx_job_oldest_done(sdev) ||
+	    (pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_FLAGS) & HOSTCTL_INTERRUPT_HWR))
+		return IRQ_WAKE_THREAD;
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t pvrsgx_irq_thread(int irq, void *arg)
+{
+	struct pvrsgx_device *sdev = arg;
+	u32 flags, clear;
+
+	if (!sdev->fw_running)
+		return IRQ_HANDLED;
+
+	flags = pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_FLAGS);
+	clear = pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_CLEAR);
+	if ((flags & HOSTCTL_INTERRUPT_HWR) && !(clear & HOSTCTL_INTERRUPT_HWR))
+		drm_err_ratelimited(&sdev->base, "microkernel reports a lockup (%u)\n",
+				    pvrsgx_fw_hostctl(sdev, HOSTCTL_UK_LOCKUPS));
+	/*
+	 * The microkernel's idle notice: acknowledge it in the interrupt clear word.
+	 * Powering down is runtime PM's business, so nothing else happens here.
+	 */
+	if ((flags & ~clear) & HOSTCTL_INTERRUPT_ACTIVE_POWER)
+		pvrsgx_fw_hostctl_set(sdev, HOSTCTL_INTERRUPT_CLEAR,
+				      clear | HOSTCTL_INTERRUPT_ACTIVE_POWER);
+
+	pvrsgx_job_process_done(sdev);
+	return IRQ_HANDLED;
+}
+
+/*
+ * Which core this is (pvrsgx_core.c). Anything else is refused before the
+ * driver writes a register: its errata, clocks and microkernel are unknown.
+ */
+static int identify(struct pvrsgx_device *sdev)
+{
+	if (!sdev->family) {
+		drm_err(&sdev->base, "not an SGX core this driver knows; not touching it\n");
+		return -ENODEV;
+	}
+	sdev->cr = sdev->family->regs;
+
+	/* Safe on a core in any state. */
+	sdev->core_id = sgx_rd(sdev, sdev->cr->core_id);
+	sdev->core_rev = sgx_rd(sdev, sdev->cr->core_revision);
+
+	if (!pvrsgx_core_family_usable(sdev->family)) {
+		drm_info(&sdev->base,
+			 "%s core id 0x%08x revision 0x%08x: this driver can't run an %s yet; not touching it further\n",
+			 sdev->family->name, sdev->core_id, sdev->core_rev, sdev->family->name);
+		return -ENODEV;
+	}
+	if (pvrsgx_core_single_context(sdev->family)) {
+		if (!pvrsgx_allow_unisolated) {
+			drm_err(&sdev->base,
+				"%s has one memory context: every client could reach the firmware and the other clients' commands. Not running it; powervr_sgx.allow_unisolated=1 runs it anyway.\n",
+				sdev->family->name);
+			return -ENODEV;
+		}
+		drm_warn(&sdev->base,
+			 "%s has one memory context: clients are not isolated from the firmware or from each other (allow_unisolated=1)\n",
+			 sdev->family->name);
+	}
+
+	sdev->core = pvrsgx_core_lookup(sdev->family, sdev->core_id, sdev->core_rev);
+	if (!sdev->core) {
+		drm_err(&sdev->base,
+			"%s core id 0x%08x revision 0x%08x is not one this driver knows; not touching it. Please report these two values.\n",
+			sdev->family->name, sdev->core_id, sdev->core_rev);
+		return -ENODEV;
+	}
+	drm_info(&sdev->base, "SGX core id 0x%08x revision 0x%08x: %s\n",
+		 sdev->core_id, sdev->core_rev, sdev->core->name);
+	return 0;
+}
+
+/*
+ * On a single-context core the microkernel runs on the job's directory, so
+ * every VM maps the firmware heaps. They get their page tables now, so the
+ * directory entries every VM copies never change.
+ */
+static int share_fw_heaps_init(struct pvrsgx_device *sdev)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+	const struct pvrsgx_va_range *r[] = { &h->kernel_code, &h->kernel_data, &h->sync };
+	int err = 0;
+
+	if (!pvrsgx_core_single_context(sdev->family))
+		return 0;
+	for (unsigned int i = 0; i < ARRAY_SIZE(r) && !err; i++)
+		err = pvrsgx_mmu_prealloc(sdev->kernel_mmu, r[i]->base, r[i]->end);
+	return err;
+}
+
+/* Point a VM's directory at the firmware heaps' page tables, on a single-context core. */
+void pvrsgx_share_fw_heaps(struct pvrsgx_device *sdev, struct pvrsgx_mmu *mmu)
+{
+	const struct pvrsgx_heap_layout *h = pvrsgx_heaps(sdev);
+
+	if (!pvrsgx_core_single_context(sdev->family))
+		return;
+	pvrsgx_mmu_share(mmu, sdev->kernel_mmu, h->kernel_code.base, h->kernel_code.end);
+	pvrsgx_mmu_share(mmu, sdev->kernel_mmu, h->kernel_data.base, h->kernel_data.end);
+	pvrsgx_mmu_share(mmu, sdev->kernel_mmu, h->sync.base, h->sync.end);
+}
+
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
+/* Behind gma500 the hard handler runs from gma500's; its thread is a work item. */
+static irqreturn_t pvrsgx_gma_irq(void *data)
+{
+	struct pvrsgx_device *sdev = data;
+	irqreturn_t ret = pvrsgx_irq(sdev->irq, sdev);
+
+	if (ret == IRQ_WAKE_THREAD) {
+		queue_work(system_highpri_wq, &sdev->irq_work);
+		return IRQ_HANDLED;
+	}
+	return ret;
+}
+
+static void pvrsgx_gma_irq_work(struct work_struct *work)
+{
+	struct pvrsgx_device *sdev = container_of(work, struct pvrsgx_device, irq_work);
+
+	pvrsgx_irq_thread(sdev->irq, sdev);
+}
+#endif
+
+static int irq_setup(struct pvrsgx_device *sdev)
+{
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
+	if (sdev->gma_sgx) {
+		INIT_WORK(&sdev->irq_work, pvrsgx_gma_irq_work);
+		return sdev->gma_sgx->set_irq_handler(sdev->gma_sgx, pvrsgx_gma_irq, sdev);
+	}
+#endif
+	return request_threaded_irq(sdev->irq, pvrsgx_irq, pvrsgx_irq_thread, IRQF_SHARED,
+				    "powervr_sgx", sdev);
+}
+
+static void irq_teardown(struct pvrsgx_device *sdev)
+{
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
+	if (sdev->gma_sgx) {
+		sdev->gma_sgx->set_irq_handler(sdev->gma_sgx, NULL, NULL);
+		cancel_work_sync(&sdev->irq_work);
+		return;
+	}
+#endif
+	free_irq(sdev->irq, sdev);
+}
+
+/*
+ * The software state, at the DRM device's release: after unbind, and after the
+ * last file is closed, so nothing a file can reach goes before the file does.
+ */
+static void pvrsgx_device_release(struct drm_device *drm, void *arg)
+{
+	struct pvrsgx_device *sdev = arg;
+
+	pvrsgx_job_fini(sdev);
+	pvrsgx_ccb_inval_reap(sdev, true);
+	pvrsgx_pb_put(sdev->pb);
+	mutex_destroy(&sdev->pb_lock);
+	pvrsgx_kobj_fini(sdev);
+	pvrsgx_fw_fini(sdev);
+	__free_page(sdev->reset_page);
+	/* The reset directory still names the scratch page's tables, never the page. */
+	pvrsgx_mmu_destroy(sdev->reset_mmu);
+	pvrsgx_mmu_destroy(sdev->idle_mmu);
+	pvrsgx_mmu_destroy(sdev->kernel_mmu);
+}
+
+int pvrsgx_device_init(struct pvrsgx_device *sdev)
+{
+	int err;
+
+	mutex_init(&sdev->ccb_lock);
+	mutex_init(&sdev->done_lock);
+	spin_lock_init(&sdev->ccb_spin);
+	spin_lock_init(&sdev->inval_lock);
+	INIT_LIST_HEAD(&sdev->inval_waits);
+
+	sdev->kernel_mmu = pvrsgx_mmu_create(sdev);
+	sdev->idle_mmu = pvrsgx_mmu_create(sdev);
+	sdev->reset_mmu = pvrsgx_mmu_create(sdev);
+	sdev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA32);
+	if (IS_ERR(sdev->kernel_mmu) || IS_ERR(sdev->idle_mmu) ||
+	    IS_ERR(sdev->reset_mmu) || !sdev->reset_page) {
+		err = -ENOMEM;
+		goto err_mmu;
+	}
+
+	err = identify(sdev);
+	if (err)
+		goto err_mmu;
+	err = share_fw_heaps_init(sdev);
+	if (err)
+		goto err_mmu;
+
+	pvrsgx_kobj_init(sdev);
+	mutex_init(&sdev->pb_lock);
+	err = pvrsgx_fw_init(sdev);
+	if (err)
+		goto err_fw;
+
+	err = pvrsgx_job_init(sdev);
+	if (err)
+		goto err_fw;
+
+	/* From here the release frees the software state, on success or failure. */
+	err = drmm_add_action_or_reset(&sdev->base, pvrsgx_device_release, sdev);
+	if (err)
+		return err;
+
+	err = irq_setup(sdev);
+	if (err)
+		return err;
+
+	err = pvrsgx_fw_start(sdev);
+	if (err) {
+		pvrsgx_fw_stop(sdev);
+		irq_teardown(sdev);
+	}
+	return err;
+
+err_fw:
+	pvrsgx_fw_fini(sdev);
+	pvrsgx_kobj_fini(sdev);
+err_mmu:
+	if (sdev->reset_page)
+		__free_page(sdev->reset_page);
+	pvrsgx_mmu_destroy(sdev->reset_mmu);
+	pvrsgx_mmu_destroy(sdev->idle_mmu);
+	pvrsgx_mmu_destroy(sdev->kernel_mmu);
+	return err;
+}
+
+/*
+ * The hardware, at unbind or when registration fails: no job reaches the GPU
+ * again, the firmware stops, the interrupt goes. Open files keep working
+ * against the software state until they close.
+ */
+void pvrsgx_device_unplug(struct pvrsgx_device *sdev)
+{
+	pvrsgx_job_unplug(sdev);
+	irq_teardown(sdev);
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_device.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_device.h
new file mode 100644
index 000000000..0342b45d4
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_device.h
@@ -0,0 +1,354 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_DEVICE_H
+#define PVRSGX_DEVICE_H
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_mm.h>
+#include <drm/gpu_scheduler.h>
+
+#include <linux/device.h>
+#include <linux/idr.h>
+#include <linux/io.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <linux/workqueue.h>
+#include <linux/xarray.h>
+
+#include "pvrsgx_cache.h"
+#include "pvrsgx_core.h"
+#include "pvrsgx_hw.h"
+
+/* Device-wide ranges for kernel-owned objects. */
+enum pvrsgx_krange {
+	PVRSGX_KRANGE_KDATA,	/* firmware only */
+	PVRSGX_KRANGE_KCODE,	/* firmware only */
+	PVRSGX_KRANGE_SYNC,	/* firmware only */
+	PVRSGX_KRANGE_3DPARAMS,	/* firmware and the owner's VM */
+	PVRSGX_KRANGE_TADATA,	/* firmware and the owner's VM */
+	PVRSGX_KRANGE_COUNT
+};
+
+struct firmware;
+struct pvrsgx_core_info;
+struct gma500_sgx_device;
+struct pci_dev;
+struct pvrsgx_mmu;
+struct pvrsgx_pb;
+struct pvrsgx_vm;
+
+/**
+ * struct pvrsgx_kmem - Kernel-owned memory at a fixed device address
+ *
+ * Mapped in the firmware's page directory only, never in a client's. The CPU
+ * mapping is write-combined.
+ */
+struct pvrsgx_kmem {
+	/** @mmu: Directory it is mapped in; NULL (the default) is the firmware's. */
+	struct pvrsgx_mmu *mmu;
+	/** @dev_addr: Device address. */
+	u32 dev_addr;
+	/** @size: Size in bytes, a whole number of pages. */
+	u32 size;
+	/** @npages: Number of pages. */
+	unsigned int npages;
+	/** @pages: The pages, below 4 GiB. */
+	struct page **pages;
+	/** @cpu: Write-combined kernel mapping. */
+	void *cpu;
+};
+
+/* Firmware-visible buffers, in allocation order. */
+enum pvrsgx_fw_buf {
+	PVRSGX_FW_CCB,		/* kernel CCB: 256 commands */
+	PVRSGX_FW_CCBCTL,	/* its write and read offsets */
+	PVRSGX_FW_KICKER,	/* EUR_CR_EVENT_KICKER target */
+	PVRSGX_FW_TA3DCTL,	/* the microkernel's control block */
+	PVRSGX_FW_HOSTCTL,	/* host control block */
+	PVRSGX_FW_MISC,		/* misc info the microkernel may fill */
+	PVRSGX_FW_UKERNEL,	/* USSE microkernel */
+	PVRSGX_FW_PDS0,		/* PDS programs that enter it */
+	PVRSGX_FW_PDS1,
+	PVRSGX_FW_PDS2,
+	PVRSGX_FW_PDS3,
+	PVRSGX_FW_PDS4,
+	PVRSGX_FW_NBUF
+};
+
+/**
+ * struct pvrsgx_fw - The running microkernel and what it reads
+ */
+struct pvrsgx_fw {
+	/** @data: Kernel data heap: control blocks, CCB. */
+	struct pvrsgx_kmem data;
+	/** @code: Kernel code heap: microkernel and its PDS programs. */
+	struct pvrsgx_kmem code;
+	/** @pdtable: Single-context cores: the directory of each VM by slot, GPU read-only. */
+	struct pvrsgx_kmem pdtable;
+	/** @pd_slots: The @pdtable slots VMs hold. */
+	struct ida pd_slots;
+	/** @addr: Device address of each buffer. */
+	u32 addr[PVRSGX_FW_NBUF];
+	/** @cpu: CPU address of each buffer. */
+	void *cpu[PVRSGX_FW_NBUF];
+	/** @cache_control: Invalidates to request with the next command. */
+	u32 cache_control;
+	/** @interface: DRM_POWERVR_SGX_FW_IF_*. */
+	u32 interface;
+	/** @name: Firmware file the image came from. */
+	const char *name;
+	/** @image: The microkernel as loaded, for restarts. */
+	u8 *image;
+	/** @image_size: Bytes of USSE code in @image. */
+	u32 image_size;
+	/** @features: PVRSGX_UKFW_* the microkernel's file header declares. */
+	u32 features;
+	/** @entries: The microkernel's entry table (PDS program, offset), or NULL. */
+	u32 (*entries)[2];
+	/** @n_entries: Entries in @entries. */
+	u32 n_entries;
+	/** @patches: The microkernel's patch table (offset, value), or NULL. */
+	u32 (*patches)[2];
+	/** @n_patches: Entries in @patches. */
+	u32 n_patches;
+};
+
+/**
+ * struct pvrsgx_device - The SGX545
+ */
+struct pvrsgx_device {
+	/** @base: The DRM device. */
+	struct drm_device base;
+	/** @pdev: The SGX PCI function (CE5300), or NULL behind gma500 (Cedarview). */
+	struct pci_dev *pdev;
+	/** @gma_sgx: The gma500 auxiliary device behind which the SGX sits, or NULL. */
+	struct gma500_sgx_device *gma_sgx;
+	/** @irq_work: The interrupt's bottom half behind gma500, which owns the line. */
+	struct work_struct irq_work;
+
+	/** @regs: The core registers (BAR 0). */
+	void __iomem *regs;
+	/** @irq: Its interrupt. */
+	int irq;
+
+	/** @family: The core the bus says is there, set before the probe reads a register. */
+	const struct pvrsgx_core_family *family;
+	/** @cr: Its registers that move between cores (@family's). */
+	const struct pvrsgx_core_regs *cr;
+	/** @core: What the driver knows about this part. */
+	const struct pvrsgx_core_info *core;
+	/** @core_id: SGX_CR_CORE_ID. */
+	u32 core_id;
+	/** @core_rev: SGX_CR_CORE_REVISION. */
+	u32 core_rev;
+
+	/** @kernel_mmu: Page directory the microkernel translates through. */
+	struct pvrsgx_mmu *kernel_mmu;
+	/** @idle_mmu: Empty directory for list 0 while no job runs (multi-context cores). */
+	struct pvrsgx_mmu *idle_mmu;
+	/** @reset_mmu: Scratch directory that absorbs faults during reset. */
+	struct pvrsgx_mmu *reset_mmu;
+	/** @reset_page: The page every address of @reset_mmu maps. */
+	struct page *reset_page;
+
+	/** @fw: The microkernel and its buffers. */
+	struct pvrsgx_fw fw;
+	/** @fw_running: The microkernel has started and takes commands. */
+	bool fw_running;
+	/**
+	 * @powered: The SGX is clocked and its registers may be read. Off between
+	 * a stop and the next start: a read of an unclocked CE5300 block can hang
+	 * the bus, and the interrupt line is shared.
+	 */
+	bool powered;
+	/** @fw_started: The microkernel has run since load; later starts are restarts. */
+	bool fw_started;
+	/** @fw_gen: Restarts (resets and runtime resumes) since load. */
+	u32 fw_gen;
+	/** @lost: Firmware failed to restart; every job fails with -EIO. */
+	bool lost;
+	/** @reset_lock: Serializes a GPU reset with unbind. */
+	struct mutex reset_lock;
+	/** @faulted: The BIF reported a page fault; the running job ends with -EFAULT. */
+	bool faulted;
+
+	/** @ccb_lock: Serialises kernel CCB writers. */
+	struct mutex ccb_lock;
+	/** @ccb_spin: Keeps @ccb_issued and the write offset in step for readers. */
+	spinlock_t ccb_spin;
+	/** @ccb_issued: Commands written to the kernel CCB since load, across restarts. */
+	u64 ccb_issued;
+	/** @inval_lock: Protects @inval_waits. */
+	spinlock_t inval_lock;
+	/** @inval_waits: &struct pvrsgx_inval_wait for invalidates not yet taken. */
+	struct list_head inval_waits;
+
+	/** @sched: The one scheduler; one job on the GPU at a time. */
+	struct drm_gpu_scheduler sched;
+	/** @fence_context: Context of the hardware fences. */
+	u64 fence_context;
+	/** @done_lock: Keeps completions in order while imports are flushed. */
+	struct mutex done_lock;
+	/** @fence_lock: Protects @fence_seqno and @active. */
+	spinlock_t fence_lock;
+	/** @fence_seqno: Last hardware fence seqno. */
+	u32 fence_seqno;
+	/** @active: Jobs handed to the firmware, oldest first. */
+	struct list_head active;
+	/** @last_fence: Hardware fence of the job last sent to the firmware. */
+	struct dma_fence *last_fence;
+	/**
+	 * @wq: Runs @poll_work, which signals fences: the queue has a rescuer
+	 * and never waits on memory reclaim.
+	 */
+	struct workqueue_struct *wq;
+	/**
+	 * @free_wq: Runs @reap_work and the jobs' final puts, which take
+	 * reservations and free memory: never the queue that signals fences.
+	 */
+	struct workqueue_struct *free_wq;
+	/** @poll_work: Checks completions while jobs are out. */
+	struct delayed_work poll_work;
+
+	/** @reset_count: GPU resets since load. */
+	u32 reset_count;
+	/** @reset_logged: @reset_count at the last "started" message (resumes are quiet). */
+	u32 reset_logged;
+
+	/** @pb: The parameter buffer every render context shares (pvrsgx_render.c). */
+	struct pvrsgx_pb *pb;
+	/** @pb_lock: Serializes @pb's creation. */
+	struct mutex pb_lock;
+
+	/** @kobj_lock: Protects @krange, @graveyard and @kobj_unmapped. */
+	struct mutex kobj_lock;
+	/** @krange: Allocators of the device-wide kernel object ranges. */
+	struct drm_mm krange[PVRSGX_KRANGE_COUNT];
+	/** @graveyard: Released kernel objects the firmware may still read. */
+	struct list_head graveyard;
+	/** @kobj_unmapped: Unmapped kernel objects waiting for a BIF TLB invalidate. */
+	struct list_head kobj_unmapped;
+	/** @renders_submitted: Render jobs handed to the firmware, for reaping @graveyard. */
+	u64 renders_submitted;
+	/**
+	 * @done_seq: Jobs signalled since the microkernel started, against its
+	 * count (pvrsgx_fw_ta3d_ctl.done_seq; under @fence_lock).
+	 */
+	u32 done_seq;
+	/** @restarts: Microkernel restarts; graveyard entries from before one can go. */
+	u32 restarts;
+	/** @coredump_work: Hands a hang's dump to devcoredump, outside the reset. */
+	struct work_struct coredump_work;
+	/** @coredump: The dump waiting for @coredump_work, or NULL (@fence_lock). */
+	void *coredump;
+	/** @coredump_len: Its length. */
+	size_t coredump_len;
+	/** @renders_done: Render jobs the firmware has finished. */
+	u64 renders_done;
+	/** @reap_work: Frees @graveyard entries a later render made safe. */
+	struct work_struct reap_work;
+
+	/** @irq_count: SW_EVENT interrupts taken (debugfs). */
+	atomic_t irq_count;
+	/** @pm_pinned: Runtime PM is held active (single-context bring-up). */
+	bool pm_pinned;
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+	/** @test_wr: KUnit only: sees every register write before it lands. */
+	void (*test_wr)(struct pvrsgx_device *sdev, u32 reg, u32 val);
+#endif
+};
+
+#define to_pvrsgx_device(drm) container_of_const(drm, struct pvrsgx_device, base)
+
+/*
+ * A file's limits: every context and RT dataset takes kernel memory from
+ * device-wide ranges, so one client may not take them all.
+ */
+#define PVRSGX_MAX_FILE_CONTEXTS	64
+#define PVRSGX_MAX_FILE_RTDS		64
+
+/**
+ * struct pvrsgx_file - Per-open state
+ */
+struct pvrsgx_file {
+	/** @sdev: The device. */
+	struct pvrsgx_device *sdev;
+	/** @vms: VM contexts by handle. */
+	struct xarray vms;
+	/** @contexts: Contexts by handle. */
+	struct xarray contexts;
+	/** @rtds: RT datasets by handle. */
+	struct xarray rtds;
+	/** @usage: GPU time, for fdinfo. */
+	struct pvrsgx_usage *usage;
+};
+
+static inline struct pvrsgx_file *to_pvrsgx_file(struct drm_file *file)
+{
+	return file->driver_priv;
+}
+
+static inline u32 sgx_rd(struct pvrsgx_device *sdev, u32 reg)
+{
+	return ioread32(sdev->regs + reg);
+}
+
+static inline void sgx_wr(struct pvrsgx_device *sdev, u32 reg, u32 val)
+{
+#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_KUNIT_TEST)
+	if (sdev->test_wr)
+		sdev->test_wr(sdev, reg, val);
+#endif
+	iowrite32(val, sdev->regs + reg);
+}
+
+/*
+ * What list 0 holds while no job runs: an empty directory, or on a
+ * single-context core the firmware's, since the microkernel translates
+ * through list 0 too.
+ */
+static inline struct pvrsgx_mmu *pvrsgx_idle_mmu(const struct pvrsgx_device *sdev)
+{
+	return pvrsgx_core_single_context(sdev->family) ? sdev->kernel_mmu : sdev->idle_mmu;
+}
+
+/* The core's device-virtual layout. */
+static inline const struct pvrsgx_heap_layout *pvrsgx_heaps(const struct pvrsgx_device *sdev)
+{
+	return sdev->family->heaps;
+}
+
+/* A register from the core table: 0 is one the core lacks, never written. */
+static inline void sgx_wr_opt(struct pvrsgx_device *sdev, u32 reg, u32 val)
+{
+	if (reg)
+		sgx_wr(sdev, reg, val);
+}
+
+/*
+ * The microkernel translates through the last directory list; TA, 3D and
+ * host requests through list 0, which the microkernel points at the job's
+ * page directory.
+ */
+static inline u32 pvrsgx_dirlist_edm(const struct pvrsgx_device *sdev)
+{
+	return sdev->family->num_dir_lists - 1;
+}
+
+int pvrsgx_kmem_alloc(struct pvrsgx_device *sdev, struct pvrsgx_kmem *km,
+		      u32 dev_addr, u32 size, u32 pte_flags, gfp_t gfp);
+void pvrsgx_kmem_free(struct pvrsgx_device *sdev, struct pvrsgx_kmem *km);
+void pvrsgx_kmem_release(struct pvrsgx_kmem *km);
+void pvrsgx_share_fw_heaps(struct pvrsgx_device *sdev, struct pvrsgx_mmu *mmu);
+
+int pvrsgx_device_init(struct pvrsgx_device *sdev);
+void pvrsgx_device_unplug(struct pvrsgx_device *sdev);
+void pvrsgx_reset(struct pvrsgx_device *sdev, bool recovery);
+int pvrsgx_poll(struct pvrsgx_device *sdev, const u32 *addr, u32 mask, u32 val,
+		unsigned int timeout_us);
+
+#endif /* PVRSGX_DEVICE_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_hw.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_hw.h
new file mode 100644
index 000000000..acb0c09d8
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_hw.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_HW_H
+#define PVRSGX_HW_H
+
+#include <linux/bits.h>
+#include <linux/types.h>
+
+#include "pvrsgx_regs.h"
+
+/* Gating modes of the 2-bit CLKGATECTL/CLKGATECTL2 fields. */
+#define SGX_CLKG_ON				1
+#define SGX_CLKG_AUTO				2
+/* The same mode in every 2-bit field of mask. */
+#define SGX_CLKG_ALL(mask, mode)		((mask) / 3 * (mode))
+
+/*
+ * SGX545 registers not in the GPL header; the names are the driver's, from
+ * what the microkernel and the init script do with them. Code reaches them
+ * through the core table.
+ */
+#define SGX545_CR_EVENT_PDS_ENABLE		0x0a58	/* host events start the event program */
+#define   SGX545_CR_EVENT_PDS_ENABLE_ALL	0x2204b00f
+#define SGX545_CR_EVENT_PDS_BASE		0x0a68	/* the event PDS program, 16-byte aligned */
+#define SGX545_CR_EVENT_PDS_DATA0		0x0a6c
+#define SGX545_CR_EVENT_PDS_DATA1		0x0a70
+#define SGX545_CR_EDM_TASK_REG0			0x0b14	/* where the microkernel is */
+#define SGX545_CR_EDM_TASK_REG1			0x0b20
+
+/* Directory lists 1 and up are consecutive; 0 sits apart. */
+#define SGX_BIF_MAX_DIRLISTS			16
+
+static inline u32 sgx_cr_bif_dir_list_base(unsigned int n)
+{
+	return n ? SGX_CR_BIF_DIR_LIST_BASE1 + 4 * (n - 1) : SGX_CR_BIF_DIR_LIST_BASE0;
+}
+
+/* MMU: two levels, 4 KiB pages, 32-bit device addresses and entries. */
+#define SGX_MMU_PAGE_SHIFT			12
+#define SGX_MMU_PAGE_SIZE			BIT(SGX_MMU_PAGE_SHIFT)
+#define SGX_MMU_PT_SHIFT			10
+#define SGX_MMU_PD_ENTRIES			1024
+#define SGX_MMU_PT_ENTRIES			1024
+#define SGX_MMU_PDE_SPAN			BIT(SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT)
+#define SGX_MMU_ADDR_MASK			GENMASK(31, 12)
+#define SGX_MMU_PDE_VALID			BIT(0)
+#define SGX_MMU_PDE_PAGE_SIZE_4K		0
+#define SGX_MMU_PTE_VALID			BIT(0)
+#define SGX_MMU_PTE_WRITEONLY			BIT(1)
+#define SGX_MMU_PTE_READONLY			BIT(2)
+#define SGX_MMU_PTE_CACHECONSISTENT		BIT(3)
+#define SGX_MMU_PTE_EDMPROTECT			BIT(4)
+
+#endif /* PVRSGX_HW_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.c b/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.c
new file mode 100644
index 000000000..7f204e7bb
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.c
@@ -0,0 +1,281 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright © 2026 Joseph Telaak */
+
+/*
+ * SGX MMU page tables. One page directory of 1024 entries, each naming a page
+ * table of 1024 four-KiB pages, so 4 GiB of device address space. Entries are
+ * the physical address with flags in the low 12 bits, so every table and every
+ * page the GPU sees must sit below 4 GiB.
+ *
+ * Tables are write-combined: whether the BIF snoops the CPU caches is not
+ * known. Callers order the writes before the GPU uses them by kicking the
+ * firmware, which issues a write barrier first.
+ */
+
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/mutex.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
+
+#include "pvrsgx_device.h"
+#include "pvrsgx_mmu.h"
+
+struct pvrsgx_mmu_pt {
+	struct page *page;
+	u32 *cpu;
+	unsigned int used;
+};
+
+struct pvrsgx_mmu {
+	struct pvrsgx_device *sdev;
+	/** @lock: Guards the directory, the page tables and their use counts. */
+	struct mutex lock;
+	struct page *pd_page;
+	u32 *pd;
+	struct pvrsgx_mmu_pt *pt[SGX_MMU_PD_ENTRIES];
+};
+
+static struct page *table_page_alloc(struct pvrsgx_device *sdev, u32 **cpu)
+{
+	struct page *p = alloc_page(GFP_KERNEL | __GFP_ZERO | __GFP_DMA32);
+
+	if (!p)
+		return NULL;
+	if (pvrsgx_pages_wc(sdev->base.dev, &p, 1))
+		goto err_free;
+	*cpu = pvrsgx_table_map(p);
+	if (!*cpu)
+		goto err_wb;
+	return p;
+
+err_wb:
+	pvrsgx_pages_wb(&p, 1);
+err_free:
+	__free_page(p);
+	return NULL;
+}
+
+static void table_page_free(struct page *p, u32 *cpu)
+{
+	pvrsgx_table_unmap(cpu);
+	pvrsgx_pages_wb(&p, 1);
+	__free_page(p);
+}
+
+struct pvrsgx_mmu *pvrsgx_mmu_create(struct pvrsgx_device *sdev)
+{
+	struct pvrsgx_mmu *mmu = kzalloc_obj(*mmu);
+
+	if (!mmu)
+		return ERR_PTR(-ENOMEM);
+
+	mmu->pd_page = table_page_alloc(sdev, &mmu->pd);
+	if (!mmu->pd_page) {
+		kfree(mmu);
+		return ERR_PTR(-ENOMEM);
+	}
+	mmu->sdev = sdev;
+	mutex_init(&mmu->lock);
+	return mmu;
+}
+
+void pvrsgx_mmu_destroy(struct pvrsgx_mmu *mmu)
+{
+	if (IS_ERR_OR_NULL(mmu))
+		return;
+
+	for (unsigned int i = 0; i < SGX_MMU_PD_ENTRIES; i++) {
+		if (!mmu->pt[i])
+			continue;
+		WARN_ON(mmu->pt[i]->used);
+		table_page_free(mmu->pt[i]->page, mmu->pt[i]->cpu);
+		kfree(mmu->pt[i]);
+	}
+	table_page_free(mmu->pd_page, mmu->pd);
+	mutex_destroy(&mmu->lock);
+	kfree(mmu);
+}
+
+u32 pvrsgx_mmu_pd_addr(struct pvrsgx_mmu *mmu)
+{
+	return lower_32_bits(page_to_phys(mmu->pd_page));
+}
+
+static u32 *pte_get(struct pvrsgx_mmu *mmu, u32 dev_addr, bool alloc)
+{
+	unsigned int pdi = dev_addr >> (SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT);
+	unsigned int pti = (dev_addr >> SGX_MMU_PAGE_SHIFT) & (SGX_MMU_PT_ENTRIES - 1);
+	struct pvrsgx_mmu_pt *pt = mmu->pt[pdi];
+
+	if (!pt) {
+		/* A directory entry with no table of ours is another directory's (shared). */
+		if (!alloc || WARN_ON(mmu->pd[pdi]))
+			return NULL;
+		pt = kzalloc_obj(*pt);
+		if (!pt)
+			return NULL;
+		pt->page = table_page_alloc(mmu->sdev, &pt->cpu);
+		if (!pt->page) {
+			kfree(pt);
+			return NULL;
+		}
+		mmu->pt[pdi] = pt;
+		mmu->pd[pdi] = (lower_32_bits(page_to_phys(pt->page)) & SGX_MMU_ADDR_MASK) |
+			       SGX_MMU_PDE_PAGE_SIZE_4K | SGX_MMU_PDE_VALID;
+	}
+	return &pt->cpu[pti];
+}
+
+static int pte_set(struct pvrsgx_mmu *mmu, u32 dev_addr, phys_addr_t pa, u32 flags)
+{
+	u32 *pte;
+
+	if (upper_32_bits(pa))
+		return -EFAULT;
+	pte = pte_get(mmu, dev_addr, true);
+	if (!pte)
+		return -ENOMEM;
+	if (WARN_ON(*pte & SGX_MMU_PTE_VALID))
+		return -EEXIST;
+	*pte = (lower_32_bits(pa) & SGX_MMU_ADDR_MASK) | flags | SGX_MMU_PTE_VALID;
+	mmu->pt[dev_addr >> (SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT)]->used++;
+	return 0;
+}
+
+static void unmap_locked(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size)
+{
+	for (u64 off = 0; off < size; off += SGX_MMU_PAGE_SIZE) {
+		u32 a = dev_addr + off;
+		u32 *pte = pte_get(mmu, a, false);
+
+		if (!pte || !(*pte & SGX_MMU_PTE_VALID))
+			continue;
+		*pte = 0;
+		mmu->pt[a >> (SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT)]->used--;
+	}
+}
+
+int pvrsgx_mmu_map_pages(struct pvrsgx_mmu *mmu, u32 dev_addr,
+			 struct page **pages, unsigned int npages, u32 flags)
+{
+	int err = 0;
+	unsigned int i;
+
+	mutex_lock(&mmu->lock);
+	for (i = 0; i < npages; i++) {
+		err = pte_set(mmu, dev_addr + i * SGX_MMU_PAGE_SIZE,
+			      page_to_phys(pages[i]), flags);
+		if (err)
+			break;
+	}
+	if (err)
+		unmap_locked(mmu, dev_addr, (u64)i * SGX_MMU_PAGE_SIZE);
+	mutex_unlock(&mmu->lock);
+	return err;
+}
+
+int pvrsgx_mmu_map_sgt(struct pvrsgx_mmu *mmu, u32 dev_addr,
+		       struct sg_table *sgt, u64 offset, u64 size, u32 flags)
+{
+	struct sg_dma_page_iter it;
+	u64 skip = offset >> PAGE_SHIFT, done = 0;
+	int err = 0;
+
+	mutex_lock(&mmu->lock);
+	for_each_sgtable_dma_page(sgt, &it, skip) {
+		if (done >= size)
+			break;
+		err = pte_set(mmu, dev_addr + done, sg_page_iter_dma_address(&it), flags);
+		if (err)
+			break;
+		done += SGX_MMU_PAGE_SIZE;
+	}
+	if (!err && done < size)
+		err = -EINVAL;
+	if (err)
+		unmap_locked(mmu, dev_addr, done);
+	mutex_unlock(&mmu->lock);
+	return err;
+}
+
+/*
+ * Allocate the page tables of [dev_addr, dev_addr + size), so that a later map
+ * of the range can't fail for memory. Tables stay until the directory goes.
+ */
+int pvrsgx_mmu_reserve(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size)
+{
+	u64 span = SGX_MMU_PDE_SPAN, end = (u64)dev_addr + size;
+	int err = 0;
+
+	mutex_lock(&mmu->lock);
+	for (u64 a = round_down(dev_addr, span); a < end && !err; a += span)
+		if (!pte_get(mmu, a, true))
+			err = -ENOMEM;
+	mutex_unlock(&mmu->lock);
+	return err;
+}
+
+void pvrsgx_mmu_unmap(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size)
+{
+	mutex_lock(&mmu->lock);
+	unmap_locked(mmu, dev_addr, size);
+	mutex_unlock(&mmu->lock);
+}
+
+bool pvrsgx_mmu_range_empty(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size)
+{
+	bool empty = true;
+
+	mutex_lock(&mmu->lock);
+	for (u64 off = 0; off < size && empty; off += SGX_MMU_PAGE_SIZE) {
+		u32 *pte = pte_get(mmu, dev_addr + off, false);
+
+		empty = !pte || !(*pte & SGX_MMU_PTE_VALID);
+	}
+	mutex_unlock(&mmu->lock);
+	return empty;
+}
+
+/*
+ * For a hang dump: the directory and table entries for dev_addr, or false if
+ * the directory is busy. Never allocates.
+ */
+bool pvrsgx_mmu_lookup(struct pvrsgx_mmu *mmu, u32 dev_addr, u32 *pde, u32 *pte)
+{
+	u32 *p;
+
+	if (!mutex_trylock(&mmu->lock))
+		return false;
+	*pde = mmu->pd[dev_addr >> (SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT)];
+	p = pte_get(mmu, dev_addr, false);
+	*pte = p ? *p : 0;
+	mutex_unlock(&mmu->lock);
+	return true;
+}
+
+/* Give [start, end) page tables of their own now, so their PDEs never change. */
+int pvrsgx_mmu_prealloc(struct pvrsgx_mmu *mmu, u32 start, u64 end)
+{
+	int err = 0;
+
+	mutex_lock(&mmu->lock);
+	for (u64 a = start; a < end && !err; a += SGX_MMU_PDE_SPAN)
+		err = pte_get(mmu, a, true) ? 0 : -ENOMEM;
+	mutex_unlock(&mmu->lock);
+	return err;
+}
+
+/*
+ * Point dst's directory entries for [start, end) at src's page tables: src's
+ * mappings there show in dst too, and dst never maps anything there itself.
+ * Both ends 4 MiB aligned, src preallocated.
+ */
+void pvrsgx_mmu_share(struct pvrsgx_mmu *dst, struct pvrsgx_mmu *src, u32 start, u64 end)
+{
+	for (u64 a = start; a < end; a += SGX_MMU_PDE_SPAN) {
+		unsigned int i = a >> (SGX_MMU_PAGE_SHIFT + SGX_MMU_PT_SHIFT);
+
+		dst->pd[i] = src->pd[i];
+	}
+}
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.h
new file mode 100644
index 000000000..7ad63a4db
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_mmu.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright © 2026 Joseph Telaak */
+
+#ifndef PVRSGX_MMU_H
+#define PVRSGX_MMU_H
+
+#include <linux/types.h>
+
+struct page;
+struct pvrsgx_device;
+struct sg_table;
+
+struct pvrsgx_mmu *pvrsgx_mmu_create(struct pvrsgx_device *sdev);
+void pvrsgx_mmu_destroy(struct pvrsgx_mmu *mmu);
+u32 pvrsgx_mmu_pd_addr(struct pvrsgx_mmu *mmu);
+
+int pvrsgx_mmu_map_pages(struct pvrsgx_mmu *mmu, u32 dev_addr,
+			 struct page **pages, unsigned int npages, u32 flags);
+int pvrsgx_mmu_map_sgt(struct pvrsgx_mmu *mmu, u32 dev_addr,
+		       struct sg_table *sgt, u64 offset, u64 size, u32 flags);
+int pvrsgx_mmu_reserve(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size);
+void pvrsgx_mmu_unmap(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size);
+bool pvrsgx_mmu_range_empty(struct pvrsgx_mmu *mmu, u32 dev_addr, u64 size);
+int pvrsgx_mmu_prealloc(struct pvrsgx_mmu *mmu, u32 start, u64 end);
+void pvrsgx_mmu_share(struct pvrsgx_mmu *dst, struct pvrsgx_mmu *src, u32 start, u64 end);
+bool pvrsgx_mmu_lookup(struct pvrsgx_mmu *mmu, u32 dev_addr, u32 *pde, u32 *pte);
+
+#endif /* PVRSGX_MMU_H */
diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_regs.h b/drivers/gpu/drm/powervr_sgx/pvrsgx_regs.h
new file mode 100644
index 000000000..21e5e2098
--- /dev/null
+++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_regs.h
@@ -0,0 +1,79 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) Imagination Technologies Ltd. All rights reserved.
+ * Copyright © 2026 Joseph Telaak
+ *
+ * The registers and fields the driver uses, generated by gen_regs.py from
+ * Imagination's sgx545defs.h, which is GPL-2.0; both live in the driver's
+ * source repository, https://github.com/The1TrueJoe/powervr_sgx.
+ */
+
+#ifndef PVRSGX_REGS_H
+#define PVRSGX_REGS_H
+
+#include <linux/bits.h>
+
+/*
+ * SGX5xx core registers, from BAR offset 0. On a core nobody has initialized
+ * only CLKGATECTL, CLKGATESTATUS, SOFT_RESET, EVENT_STATUS, EVENT_HOST_ENABLE,
+ * BIF_CTRL, CORE_ID and CORE_REVISION are safe to read; some others hang the
+ * bus until the reset sequence has run.
+ */
+#define SGX_CR_CLKGATECTL			0x0000
+#define   SGX_CR_CLKGATECTL_DPM_CLKG		GENMASK(11, 10)
+#define   SGX_CR_CLKGATECTL_UNITS		GENMASK(15, 0)
+#define SGX_CR_CLKGATECTL2			0x0004
+#define   SGX_CR_CLKGATECTL2_UNITS		GENMASK(23, 0)
+#define SGX_CR_CLKGATESTATUS			0x0008
+#define   SGX_CR_CLKGATESTATUS_DPM_CLKS		BIT(5)
+#define SGX_CR_CORE_ID				0x001c
+#define SGX_CR_CORE_REVISION			0x0020
+#define SGX_CR_SOFT_RESET			0x0080
+#define   SGX_CR_SOFT_RESET_BIF_RESET		BIT(0)
+#define   SGX_CR_SOFT_RESET_DPM_RESET		BIT(1)
+#define   SGX_CR_SOFT_RESET_TA_RESET		BIT(2)
+#define   SGX_CR_SOFT_RESET_USE_RESET		BIT(3)
+#define   SGX_CR_SOFT_RESET_ISP_RESET		BIT(4)
+#define   SGX_CR_SOFT_RESET_TSP_RESET		BIT(5)
+#define SGX_CR_EVENT_HOST_ENABLE2		0x0110
+#define SGX_CR_EVENT_HOST_CLEAR2		0x0114
+#define SGX_CR_EVENT_STATUS2			0x0118
+#define SGX_CR_EVENT_STATUS			0x012c
+#define   SGX_CR_EVENT_STATUS_MASTER_INTERRUPT	BIT(31)
+#define   SGX_CR_EVENT_STATUS_TIMER		BIT(29)
+#define   SGX_CR_EVENT_STATUS_SW_EVENT		BIT(14)
+#define SGX_CR_EVENT_HOST_ENABLE		0x0130
+#define SGX_CR_EVENT_HOST_CLEAR			0x0134
+#define   SGX_CR_EVENT_HOST_CLEAR_MASTER_INTERRUPT	BIT(31)
+#define   SGX_CR_EVENT_HOST_CLEAR_SW_EVENT	BIT(14)
+#define SGX_CR_TIMER				0x0144
+#define SGX_CR_USE_CODE_BASE_0			0x0a0c
+#define SGX_CR_PDS_EXEC_BASE			0x0ab8
+#define SGX_CR_EVENT_KICKER			0x0ac4
+#define SGX_CR_EVENT_KICK			0x0ac8
+#define   SGX_CR_EVENT_KICK_NOW			BIT(0)
+#define SGX_CR_EVENT_TIMER			0x0acc
+#define SGX_CR_EVENT_KICK2			0x0ae8
+#define   SGX_CR_EVENT_KICK2_NOW		BIT(0)
+#define SGX_CR_BIF_CTRL				0x0c00
+#define   SGX_CR_BIF_CTRL_PAUSE			BIT(1)
+#define   SGX_CR_BIF_CTRL_INVALDC		BIT(3)
+#define   SGX_CR_BIF_CTRL_CLEAR_FAULT		BIT(4)
+#define SGX_CR_BIF_INT_STAT			0x0c04
+#define   SGX_CR_BIF_INT_STAT_FAULT_REQ		GENMASK(15, 0)
+#define   SGX_CR_BIF_INT_STAT_FAULT_TYPE	GENMASK(18, 16)
+#define   SGX_CR_BIF_INT_STAT_FLUSH_COMPLETE	BIT(19)
+#define SGX_CR_BIF_FAULT			0x0c08
+#define SGX_CR_BIF_DIR_LIST_BASE0		0x0c84
+#define SGX_CR_BIF_DIR_LIST_BASE1		0x0c38
+#define SGX_CR_BIF_BANK_SET			0x0c74
+#define SGX_CR_BIF_BANK0			0x0c78
+#define   SGX_CR_BIF_BANK0_INDEX_EDM		GENMASK(3, 0)
+#define   SGX_CR_BIF_BANK0_INDEX_TA		GENMASK(7, 4)
+#define   SGX_CR_BIF_BANK0_INDEX_HOST		GENMASK(11, 8)
+#define   SGX_CR_BIF_BANK0_INDEX_3D		GENMASK(15, 12)
+#define   SGX_CR_BIF_BANK0_INDEX_2D		GENMASK(19, 16)
+#define SGX_CR_BIF_MEM_REQ_STAT			0x0ca8
+#define   SGX_CR_BIF_MEM_REQ_STAT_READS		GENMASK(10, 0)
+
+#endif /* PVRSGX_REGS_H */

-- 
2.50.1

