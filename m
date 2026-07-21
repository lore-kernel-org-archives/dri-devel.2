Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C4FC4451C
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 12:25:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D933310E31F;
	Tue, 21 Jul 2026 12:25:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dB46ftBL";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F97C10E31F;
 Tue, 21 Jul 2026 12:25:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 48EC543F6C;
 Tue, 21 Jul 2026 12:25:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004811F00A3D;
 Tue, 21 Jul 2026 12:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784636723;
 bh=bZ6CrNt1h3fSjGPvsb+y6S3SjB/kGZ3lPPdIV0Hb5tc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=dB46ftBL5sj4qM0ZkIPHuf8nuR/sBiKXFIxjfRkIiw4Gnqz5d7tnjyagpHMewR0kY
 Jlbp/6s9iw5wohJZEUCtpIARBSFM8v0YIsIgVgMpAMEGS9VyvZG5a3POPTl1qMWCm/
 AOyRY7VRZ3LN0VAeuRVLSYksNzLtxjTdboqbEXEcxFjXI5C9xSP8Oyp5IbBFtDdLkq
 qnJeqhMMneWacI0Y9YTFPEpPC2Fs/vA0QHf7BjF010netP1jc5BtiW8eU3f8DF90Sd
 X0OmA5rYQ3bNPCU+hykhnFRK7DMM8ZePfhWYx6IzJQmNzFvJn7biDDgofB4okXymCB
 dnEE/Fl4y3NRg==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Tue, 21 Jul 2026 14:25:05 +0200
Subject: [PATCH v4 2/2] soc: qcom: ubwc: Get HBB from SMEM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260721-topic-smem_dramc-v4-2-748f992278a3@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784636706; l=2414;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=3LNXtkpagxbE+R6g/oNsy+x+7/74GUn/00p/SQ/cYlM=;
 b=tDUH1hw0QFIEWiWjDFyUIMtfLOxDDtsCIpahvBz1Jm7Dm1Q6j221/9K5JcFSYpAbTmd92sVbc
 9HZoC9AUnbLBveJrsOVMKNQj2+Tg1t48fQNUciwjADa/um0xSSc9rRR
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

To make sure the correct settings for a given DRAM configuration get
applied, attempt to retrieve that data from SMEM (which happens to be
what the BSP kernel does, albeit with through convoluted means of the
bootloader altering the DT with this data).

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 40 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 0209a02c390f..23901a4c51f7 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 
 #include <linux/soc/qcom/ubwc.h>
+#include <linux/soc/qcom/smem.h>
 
 static const struct qcom_ubwc_cfg_data no_ubwc_data = {
 	/* no UBWC, no HBB */
@@ -168,9 +169,25 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ }
 };
 
+static struct qcom_ubwc_cfg_data *cfg;
+static DEFINE_MUTEX(cfg_mutex);
+/**
+ * qcom_ubwc_config_get_data() - Retrieve UBWC data for the platform.
+ *
+ * Return: Pointer to valid struct qcom_ubwc_cfg_data on success, negative
+ * errno on failure. Note that this may return EPROBE_DEFER.
+ */
 const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
 {
 	const struct qcom_ubwc_cfg_data *data;
+	int hbb;
+
+	guard(mutex)(&cfg_mutex);
+	if (cfg)
+		return cfg;
+
+	if (!qcom_smem_is_available())
+		return ERR_PTR(-EPROBE_DEFER);
 
 	data = of_machine_get_match_data(qcom_ubwc_configs);
 	if (!data) {
@@ -178,9 +195,30 @@ const struct qcom_ubwc_cfg_data *qcom_ubwc_config_get_data(void)
 		return ERR_PTR(-EINVAL);
 	}
 
-	return data;
+	hbb = qcom_smem_dram_get_hbb();
+	if (hbb == -ENODATA) {
+		/* Lack of HBB data is OK - it was only introduced later */
+		return data;
+	} else if (hbb < 0) {
+		pr_err("Couldn't get HBB data from SMEM: %d\n", hbb);
+		return ERR_PTR(hbb);
+	}
+
+	cfg = kmemdup(data, sizeof(*data), GFP_KERNEL);
+	if (!cfg)
+		return ERR_PTR(-ENOMEM);
+
+	cfg->highest_bank_bit = hbb;
+
+	return cfg;
 }
 EXPORT_SYMBOL_GPL(qcom_ubwc_config_get_data);
 
+static void __exit ubwc_config_exit(void)
+{
+	kfree(cfg);
+}
+module_exit(ubwc_config_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("UBWC config database for QTI SoCs");

-- 
2.55.0

