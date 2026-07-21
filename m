Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A21BEC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:25:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF29A10E325;
	Tue, 21 Jul 2026 12:25:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nEOX6+Xu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E58810E31F;
 Tue, 21 Jul 2026 12:25:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85189412C9;
 Tue, 21 Jul 2026 12:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6351F000E9;
 Tue, 21 Jul 2026 12:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784636717;
 bh=hpYSzopDaSp56bU488j8w7AhjKrKI8NYBPGtOLLLk5o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=nEOX6+XubeZA7cwiXKeneTW94e4r6PcWzFc2msqAshdJm5cXaGOqznNwVdnKp6oyB
 QeNCeDPuRTAquiCq3diIXGaPzG2koOOpimfyyxOTXFAOTV2qZKtFOdcPfvuHPdiKuW
 4Sc0wu7kaeBf6bRbpkNkgHFb14JS3DWSEkgHuxlO55HFlC6T7CdXCMhfrlYpH+xU6X
 ja6RJHV8BL3+j7mGV6zbKRxYHVQvcsG+QvvNX+qg64Vtk6QDxRRsH15idSSkLkrV3b
 iK20/DU+Vs6JGYI/Uj8Lbh8eOZc7917S6iOs6ORbvcUe8zSsDTh/nKMoc2p/jF1oED
 eCxzrJozNpr2A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 21 Jul 2026 14:25:04 +0200
Subject: [PATCH v4 1/2] soc: qcom: smem: Expose DDR data from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-topic-smem_dramc-v4-1-748f992278a3@oss.qualcomm.com>
References: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
In-Reply-To: <20260721-topic-smem_dramc-v4-0-748f992278a3@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784636706; l=16488;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=9su+Y3V7IuJptip8VtauUg/9EMVzqLkFazCqf0jfMRA=;
 b=MJsvA5y4bN7JVxvJPKUczOKK72RbDm1RuaNAxz3UXDKIqJ0HMrfrXae2m78x3wh5PTqe36eNA
 Bm3K1JPf2spDnPDjjoSsf4aMjwzy2UvUWwbphMGMLWfopwkKu6PCvaC
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Most modern Qualcomm platforms (>= SM8150) expose information about the
DDR memory present on the system via SMEM.

Details from this information is used in various scenarios, such as
multimedia drivers configuring the hardware based on the "Highest Bank
address Bit" (hbb), or the list of valid frequencies in validation
scenarios...

Add support for parsing v3-v7 version of the structs. Unforunately,
they are not versioned, so some elbow grease is necessary to determine
which one is present. See for reference:

ver 3: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/1d11897d2cfcc7b85f28ff74c445018dbbecac7a
ver 4: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/f6e9aa549260bbc0bdcb156c2b05f48dc5963203
ver 5: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/617d3297abe8b1b8dd3de3d1dd69c3961e6f343f
ver 5 with 6regions: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/d770e009f9bae58d56d926f7490bbfb45af8341f
ver 6: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/62659b557fdb1551b20fae8073d1d701dfa8a62e
ver 7: https://git.codelinaro.org/clo/la/abl/tianocore/edk2/-/commit/734d95599c5ebb1ca0d4e1639142e65c590532b7

Reviewed-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/soc/qcom/Makefile     |   3 +-
 drivers/soc/qcom/smem.c       |  14 +-
 drivers/soc/qcom/smem.h       |   9 +
 drivers/soc/qcom/smem_dramc.c | 430 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/soc/qcom/smem.h |   2 +
 5 files changed, 456 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
index b7f1d2a57367..798643be3590 100644
--- a/drivers/soc/qcom/Makefile
+++ b/drivers/soc/qcom/Makefile
@@ -23,7 +23,8 @@ obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
 qcom_rpmh-y			+= rpmh-rsc.o
 qcom_rpmh-y			+= rpmh.o
 obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
-obj-$(CONFIG_QCOM_SMEM) +=	smem.o
+qcom_smem-y			+= smem.o smem_dramc.o
+obj-$(CONFIG_QCOM_SMEM) +=	qcom_smem.o
 obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
 CFLAGS_smp2p.o := -I$(src)
 obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index afb21a778fe7..4315512d3a1d 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2012-2013, The Linux Foundation. All rights reserved.
  */
 
+#include <linux/debugfs.h>
 #include <linux/hwspinlock.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -16,6 +17,8 @@
 #include <linux/soc/qcom/smem.h>
 #include <linux/soc/qcom/socinfo.h>
 
+#include "smem.h"
+
 /*
  * The Qualcomm shared memory system is a allocate only heap structure that
  * consists of one of more memory areas that can be accessed by the processors
@@ -281,6 +284,8 @@ struct qcom_smem {
 	struct smem_partition global_partition;
 	struct xarray partitions;
 
+	struct dentry *debugfs_dir;
+
 	unsigned num_regions;
 	struct smem_region regions[] __counted_by(num_regions);
 };
@@ -1239,17 +1244,24 @@ static int qcom_smem_probe(struct platform_device *pdev)
 
 	__smem = smem;
 
+	smem->debugfs_dir = smem_dram_parse(smem->dev);
+
 	smem->socinfo = platform_device_register_data(&pdev->dev, "qcom-socinfo",
 						      PLATFORM_DEVID_NONE, NULL,
 						      0);
-	if (IS_ERR(smem->socinfo))
+	if (IS_ERR(smem->socinfo)) {
+		debugfs_remove_recursive(smem->debugfs_dir);
+
 		dev_dbg(&pdev->dev, "failed to register socinfo device\n");
+	}
 
 	return 0;
 }
 
 static void qcom_smem_remove(struct platform_device *pdev)
 {
+	debugfs_remove_recursive(__smem->debugfs_dir);
+
 	platform_device_unregister(__smem->socinfo);
 
 	xa_destroy(&__smem->partitions);
diff --git a/drivers/soc/qcom/smem.h b/drivers/soc/qcom/smem.h
new file mode 100644
index 000000000000..8bf3f606e1ae
--- /dev/null
+++ b/drivers/soc/qcom/smem.h
@@ -0,0 +1,9 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __QCOM_SMEM_INTERNAL__
+#define __QCOM_SMEM_INTERNAL__
+
+#include <linux/device.h>
+
+struct dentry *smem_dram_parse(struct device *dev);
+
+#endif
diff --git a/drivers/soc/qcom/smem_dramc.c b/drivers/soc/qcom/smem_dramc.c
new file mode 100644
index 000000000000..2998573a6e07
--- /dev/null
+++ b/drivers/soc/qcom/smem_dramc.c
@@ -0,0 +1,430 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include <linux/debugfs.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/soc/qcom/smem.h>
+#include <linux/units.h>
+
+#include "smem.h"
+
+#define SMEM_DDR_INFO_ID		603
+
+#define MAX_DDR_FREQ_NUM_V3		13
+#define MAX_DDR_FREQ_NUM_V5		14
+
+#define MAX_CHAN_NUM			8
+#define MAX_RANK_NUM			2
+
+#define DDR_HBB_MIN			13
+#define DDR_HBB_MAX			19
+
+#define MAX_SHUB_ENTRIES		8
+
+static struct smem_dram *__dram;
+
+enum ddr_info_version {
+	INFO_UNKNOWN,
+	INFO_V3,
+	INFO_V3_WITH_14_FREQS,
+	INFO_V4,
+	INFO_V5,
+	INFO_V5_WITH_6_REGIONS,
+	INFO_V6, /* INFO_V6 seems to only have shipped with 6 DDR regions, unlike V7 */
+	INFO_V7,
+	INFO_V7_WITH_6_REGIONS,
+};
+
+struct smem_dram {
+	unsigned long frequencies[MAX_DDR_FREQ_NUM_V5];
+	u32 num_frequencies;
+	u8 hbb;
+};
+
+enum ddr_type {
+	DDR_TYPE_NODDR = 0,
+	DDR_TYPE_LPDDR1 = 1,
+	DDR_TYPE_LPDDR2 = 2,
+	DDR_TYPE_PCDDR2 = 3,
+	DDR_TYPE_PCDDR3 = 4,
+	DDR_TYPE_LPDDR3 = 5,
+	DDR_TYPE_LPDDR4 = 6,
+	DDR_TYPE_LPDDR4X = 7,
+	DDR_TYPE_LPDDR5 = 8,
+	DDR_TYPE_LPDDR5X = 9,
+};
+
+/* The data structures below are NOT __packed on purpose! */
+
+/* Structs used across multiple versions */
+struct ddr_part_details {
+	__le16 revision_id1;
+	__le16 revision_id2;
+	__le16 width;
+	__le16 density;
+};
+
+struct ddr_freq_table {
+	__le32 freq_khz;
+	u8 enabled;
+};
+
+/* V3 */
+struct ddr_freq_plan_v3 {
+	struct ddr_freq_table ddr_freq[MAX_DDR_FREQ_NUM_V3];
+	u8 num_ddr_freqs;
+	phys_addr_t clk_period_address;
+};
+
+struct ddr_details_v3 {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_CHAN_NUM];
+	struct ddr_freq_plan_v3 ddr_freq_tbl;
+	u8 num_channels;
+};
+
+/* Some V3 structs have an additional frequency level */
+struct ddr_freq_plan_v3_14freqs {
+	struct ddr_freq_table ddr_freq[MAX_DDR_FREQ_NUM_V3 + 1];
+	u8 num_ddr_freqs;
+	phys_addr_t clk_period_address;
+};
+
+struct ddr_details_v3_14freqs {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_CHAN_NUM];
+	struct ddr_freq_plan_v3_14freqs ddr_freq_tbl;
+	u8 num_channels;
+};
+
+/* V4 */
+struct ddr_details_v4 {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_CHAN_NUM];
+	struct ddr_freq_plan_v3 ddr_freq_tbl;
+	u8 num_channels;
+	u8 num_ranks[MAX_CHAN_NUM];
+	u8 highest_bank_addr_bit[MAX_CHAN_NUM][MAX_RANK_NUM];
+};
+
+/* V5 */
+struct shub_freq_table {
+	u8 enable;
+	__le32 freq_khz;
+};
+
+struct shub_freq_plan_entry {
+	u8 num_shub_freqs;
+	struct shub_freq_table shub_freq[MAX_SHUB_ENTRIES];
+};
+
+struct ddr_xbl2quantum_smem_data {
+	phys_addr_t ssr_cookie_addr;
+	__le32 reserved[10];
+};
+
+struct ddr_freq_plan_v5 {
+	struct ddr_freq_table ddr_freq[MAX_DDR_FREQ_NUM_V5];
+	u8 num_ddr_freqs;
+	phys_addr_t clk_period_address;
+	__le32 max_nom_ddr_freq;
+};
+
+struct ddr_region_v5 {
+	__le64 start_address;
+	__le64 size;
+	__le64 mem_controller_address;
+	__le32 granule_size; /* MiB */
+	u8  ddr_rank;
+#define DDR_RANK_0	BIT(0)
+#define DDR_RANK_1	BIT(1)
+	u8  segments_start_index;
+	__le64 segments_start_offset;
+};
+
+struct ddr_regions_v5 {
+	__le32 ddr_region_num; /* We expect this to always be 4 or 6 */
+	__le64 ddr_rank0_size;
+	__le64 ddr_rank1_size;
+	__le64 ddr_cs0_start_addr;
+	__le64 ddr_cs1_start_addr;
+	__le32 highest_bank_addr_bit;
+	struct ddr_region_v5 ddr_region[] __counted_by_le(ddr_region_num);
+};
+
+struct ddr_details_v5 {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_CHAN_NUM];
+	struct ddr_freq_plan_v5 ddr_freq_tbl;
+	u8 num_channels;
+	u8 _padding;
+	struct ddr_regions_v5 ddr_regions;
+};
+
+/* V6 */
+struct ddr_misc_info_v6 {
+	__le32 dsf_version;
+	__le32 reserved[10];
+};
+
+/* V7 */
+struct ddr_details_v7 {
+	u8 manufacturer_id;
+	u8 device_type;
+	struct ddr_part_details ddr_params[MAX_CHAN_NUM];
+	struct ddr_freq_plan_v5 ddr_freq_tbl;
+	u8 num_channels;
+	u8 sct_config;
+	struct ddr_regions_v5 ddr_regions;
+};
+
+/**
+ * qcom_smem_dram_get_hbb(): Get the Highest bank address bit
+ *
+ * Context: Check qcom_smem_is_available() before calling this function.
+ * Because __dram * is initialized by smem_dram_parse(), which is in turn
+ * called from * qcom_smem_probe(), __dram will only be NULL if the data
+ * couldn't have been found/interpreted correctly.
+ *
+ * Return: highest bank bit on success, -ENODATA on failure.
+ */
+int qcom_smem_dram_get_hbb(void)
+{
+	if (!__dram || !__dram->hbb)
+		return -ENODATA;
+
+	if (__dram->hbb < DDR_HBB_MIN || __dram->hbb > DDR_HBB_MAX)
+		return -ENODATA;
+
+	return __dram->hbb;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_dram_get_hbb);
+
+static void smem_dram_parse_v3_data(struct smem_dram *dram, void *data)
+{
+	struct ddr_details_v3 *details = data;
+
+	for (int i = 0; i < MAX_DDR_FREQ_NUM_V3; i++) {
+		struct ddr_freq_table *freq_entry = &details->ddr_freq_tbl.ddr_freq[i];
+
+		if (freq_entry->freq_khz && freq_entry->enabled) {
+			u32 freq_khz = le32_to_cpu(freq_entry->freq_khz);
+			dram->frequencies[dram->num_frequencies++] = 1000 * freq_khz;
+		}
+	}
+}
+
+static void smem_dram_parse_v3_14freqs_data(struct smem_dram *dram, void *data)
+{
+	struct ddr_details_v3_14freqs *details = data;
+
+	for (int i = 0; i < MAX_DDR_FREQ_NUM_V3 + 1; i++) {
+		struct ddr_freq_table *freq_entry = &details->ddr_freq_tbl.ddr_freq[i];
+
+		if (freq_entry->freq_khz && freq_entry->enabled)
+			dram->frequencies[dram->num_frequencies++] = 1000 * freq_entry->freq_khz;
+	}
+}
+
+static void smem_dram_parse_v4_data(struct smem_dram *dram, void *data)
+{
+	struct ddr_details_v4 *details = data;
+
+	/* Rank 0 channel 0 entry holds the correct value */
+	dram->hbb = details->highest_bank_addr_bit[0][0];
+
+	for (int i = 0; i < MAX_DDR_FREQ_NUM_V3; i++) {
+		struct ddr_freq_table *freq_entry = &details->ddr_freq_tbl.ddr_freq[i];
+
+		if (freq_entry->freq_khz && freq_entry->enabled) {
+			u32 freq_khz = le32_to_cpu(freq_entry->freq_khz);
+			dram->frequencies[dram->num_frequencies++] = 1000 * freq_khz;
+		}
+	}
+}
+
+static void smem_dram_parse_v5_data(struct smem_dram *dram, void *data)
+{
+	struct ddr_details_v5 *details = data;
+	struct ddr_regions_v5 *region = &details->ddr_regions;
+
+	dram->hbb = le32_to_cpu(region[0].highest_bank_addr_bit);
+
+	for (int i = 0; i < MAX_DDR_FREQ_NUM_V5; i++) {
+		struct ddr_freq_table *freq_entry = &details->ddr_freq_tbl.ddr_freq[i];
+
+		if (freq_entry->freq_khz && freq_entry->enabled) {
+			u32 freq_khz = le32_to_cpu(freq_entry->freq_khz);
+			dram->frequencies[dram->num_frequencies++] = 1000 * freq_khz;
+		}
+	}
+}
+
+static void smem_dram_parse_v7_data(struct smem_dram *dram, void *data)
+{
+	struct ddr_details_v7 *details = data;
+	struct ddr_regions_v5 *region = &details->ddr_regions;
+
+	dram->hbb = le32_to_cpu(region[0].highest_bank_addr_bit);
+
+	for (int i = 0; i < MAX_DDR_FREQ_NUM_V5; i++) {
+		struct ddr_freq_table *freq_entry = &details->ddr_freq_tbl.ddr_freq[i];
+
+		if (freq_entry->freq_khz && freq_entry->enabled) {
+			u32 freq_khz = le32_to_cpu(freq_entry->freq_khz);
+			dram->frequencies[dram->num_frequencies++] = 1000 * freq_khz;
+		}
+	}
+}
+
+/* The structure contains no version field, so we have to perform some guesswork.. */
+static int smem_dram_infer_struct_version(size_t size)
+{
+	/* Some early versions provided less bytes of less useful data */
+	if (size < sizeof(struct ddr_details_v3))
+		return -EINVAL;
+
+	if (size == sizeof(struct ddr_details_v3))
+		return INFO_V3;
+
+	if (size == sizeof(struct ddr_details_v3_14freqs))
+		return INFO_V3_WITH_14_FREQS;
+
+	if (size == sizeof(struct ddr_details_v4))
+		return INFO_V4;
+
+	if (size == sizeof(struct ddr_details_v5) +
+		    4 * sizeof(struct ddr_region_v5))
+		return INFO_V5;
+
+	if (size == sizeof(struct ddr_details_v5) +
+		    4 * sizeof(struct ddr_region_v5) +
+		    sizeof(struct ddr_xbl2quantum_smem_data) +
+		    sizeof(struct shub_freq_plan_entry))
+		return INFO_V5;
+
+	if (size == sizeof(struct ddr_details_v5) +
+		    6 * sizeof(struct ddr_region_v5))
+		return INFO_V5_WITH_6_REGIONS;
+
+	if (size == sizeof(struct ddr_details_v5) +
+		    6 * sizeof(struct ddr_region_v5) +
+		    sizeof(struct ddr_xbl2quantum_smem_data) +
+		    sizeof(struct shub_freq_plan_entry))
+		return INFO_V5_WITH_6_REGIONS;
+
+	if (size == sizeof(struct ddr_details_v5) +
+		    6 * sizeof(struct ddr_region_v5) +
+		    sizeof(struct ddr_misc_info_v6) +
+		    sizeof(struct shub_freq_plan_entry))
+		return INFO_V6;
+
+	if (size == sizeof(struct ddr_details_v7) +
+		    4 * sizeof(struct ddr_region_v5) +
+		    sizeof(struct ddr_misc_info_v6) +
+		    sizeof(struct shub_freq_plan_entry))
+		return INFO_V7;
+
+	if (size == sizeof(struct ddr_details_v7) +
+		    6 * sizeof(struct ddr_region_v5) +
+		    sizeof(struct ddr_misc_info_v6) +
+		    sizeof(struct shub_freq_plan_entry))
+		return INFO_V7_WITH_6_REGIONS;
+
+	return INFO_UNKNOWN;
+}
+
+static int smem_dram_frequencies_show(struct seq_file *s, void *unused)
+{
+	struct smem_dram *dram = s->private;
+
+	for (int i = 0; i < dram->num_frequencies; i++)
+		seq_printf(s, "%lu\n", dram->frequencies[i]);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(smem_dram_frequencies);
+
+static int smem_hbb_show(struct seq_file *s, void *unused)
+{
+	struct smem_dram *dram = s->private;
+
+	if (!dram->hbb)
+		return -EINVAL;
+
+	seq_printf(s, "%d\n", dram->hbb);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(smem_hbb);
+
+struct dentry *smem_dram_parse(struct device *dev)
+{
+	struct dentry *debugfs_dir;
+	enum ddr_info_version ver;
+	struct smem_dram *dram;
+	size_t actual_size;
+	void *data;
+
+	/* No need to check qcom_smem_is_available(), this func is called by the SMEM driver */
+	data = qcom_smem_get(QCOM_SMEM_HOST_ANY, SMEM_DDR_INFO_ID, &actual_size);
+	if (IS_ERR_OR_NULL(data))
+		return ERR_PTR(-ENODATA);
+
+	ver = smem_dram_infer_struct_version(actual_size);
+	if (ver < 0) {
+		/* Some SoCs don't provide data that's useful for us */
+		return ERR_PTR(-ENODATA);
+	} else if (ver == INFO_UNKNOWN) {
+		/* In other cases, we may not have added support for a newer struct revision */
+		dev_err(dev, "Found an unknown type of DRAM info struct (size = %zu)\n",
+			actual_size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	dram = devm_kzalloc(dev, sizeof(*dram), GFP_KERNEL);
+	if (!dram)
+		return ERR_PTR(-ENOMEM);
+
+	switch (ver) {
+	case INFO_V3:
+		smem_dram_parse_v3_data(dram, data);
+		break;
+	case INFO_V3_WITH_14_FREQS:
+		smem_dram_parse_v3_14freqs_data(dram, data);
+		break;
+	case INFO_V4:
+		smem_dram_parse_v4_data(dram, data);
+		break;
+	case INFO_V5:
+	case INFO_V5_WITH_6_REGIONS:
+	case INFO_V6:
+		smem_dram_parse_v5_data(dram, data);
+		break;
+	case INFO_V7:
+	case INFO_V7_WITH_6_REGIONS:
+		smem_dram_parse_v7_data(dram, data);
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	debugfs_dir = debugfs_create_dir("qcom_smem", NULL);
+	debugfs_create_file("dram_frequencies", 0444, debugfs_dir, dram,
+			    &smem_dram_frequencies_fops);
+	debugfs_create_file("hbb", 0444, debugfs_dir, dram, &smem_hbb_fops);
+
+	__dram = dram;
+
+	return debugfs_dir;
+}
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index f946e3beca21..3249cbd2016b 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -17,4 +17,6 @@ int qcom_smem_get_feature_code(u32 *code);
 
 int qcom_smem_bust_hwspin_lock_by_host(unsigned int host);
 
+int qcom_smem_dram_get_hbb(void);
+
 #endif

-- 
2.55.0

