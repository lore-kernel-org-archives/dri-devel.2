Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F300CC6B14
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02ED610F61A;
	Tue, 13 Oct 2026 08:46:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E515D10F61A
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:04 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D8J6en922862
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hPMzbv/4wi4ODfA9XRSPX8ue5WbPDcJwnRMdAkV9P04=; b=d3WVv2WPID92/+my
 EBZkCwi7mvJbrTP/7xGwePIzSROWL8Dv5arppVeaG5wTdCr930+p5ADCfh6OXb1f
 UxHJTalSwWXW20z8MbmWI6lkkIs+Zoaf2F1/yqJVt7n24u31eYKy1oqHifUC91gZ
 Jw1Pll2iL+vuSJVRmBIZsbdNw60Rvm7Zfqis8ANZc6uB1oxi5BTwEYUa5pXnlF57
 Mx1KMRpSsXyezzyYEjC4swu7gBagk6QvJdJdAQK/MbJa/mdBpTQmdh44cEzrLwS6
 3yYs0k8ZNlWJUcwOfLjAtuZSV0yda8CzrIe2QUf1z8fOg+h/NAMKA9E/ATPuKS8B
 Fe4pdQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h98h1t0w5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:04 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd3e7a65fa8so1672222a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881164; x=1792485964;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hPMzbv/4wi4ODfA9XRSPX8ue5WbPDcJwnRMdAkV9P04=;
 b=Jy208hwcOijTIX8U1yZc95OXUJiMsYYPMbtxaZb4RAZGUNNs8KP/DmQLIySYsZnSep
 ZiIjDQ4PuI0BbhdY1A8rtEbAw8WURhZ/TXmf6YNgWS7OTSL8F/bbj/b3xwwY27VVa+Cn
 Lo7DTKOOX1ZD6XUq4fJ0dRt+JV/Ck5NVsLahEI3tmuW/1a3Jtj8ZSjTKPdKV4JmOyQ0i
 /5bmfR5zi9kSJK/wfCuMHbPQ300qEf7NVT0RA9RQbxqwFNdzjISWPbM0METgaIfPZtJ+
 3L/2000ywlviqbXTFeBUcaanoTA1JMiAZCV0KZnduECiZqtNkjP1jAqUNkGStVaWm8V0
 268A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881164; x=1792485964;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hPMzbv/4wi4ODfA9XRSPX8ue5WbPDcJwnRMdAkV9P04=;
 b=EyKkZioSqOr6viLI+TqysF71h5he4BTguVvWWORBa9uDD3e186YQ2laVORYzMaoqs0
 20Q2lBBGq3BT4HpZmCoWjvIBmchvgFiBOQ8bClafgcHiKbfUx0GQZ7kS7AVZsxlekUIJ
 HIy8sD+63wUcUBnRX1OyEZnHHM9XtAGGHihInUrisS0n0yGieudkUOEWgnSreXC+jWsO
 RoC4TEuHGveB+ROdhb50Zb1AD11r4t29IjhLumyxtppBi6ofCDiIjRSzPBmm0BnY1m7j
 EGaW1e/QS3RIhXLntH6lM+rKMZkrO6JnZwFRvu4AsvvlsJtiZgb3TVPYoY/q37MXE2uv
 ib5w==
X-Forwarded-Encrypted: i=1;
 AKwUvBwUBy1lrPxVpfofQLKwla85gH0VvpPVCmDPgYDPnVNSGaCgPRxvWTOSzHAPT3MV3pqJyoWTWw1wn0w=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKJ/QGIVZ9eJQVYVM8SjV6yVd+UEfkOXPGnneZjbt9bSQ62LepY
 G0Y7j/9U0kX+8S9nJcP61tFbGRro4d3Eu7aCj9d7xRZAzzeLJ+jdhKaNabXddXcn0kku0ADFLST
 OyBrosUi2x3WmNzETH+pHAoa1b/+Ll4Y+qweaAOQUXC0mlS7ssLD7glmg4HBZT6gbrQTdQSA=
X-Gm-Gg: AYBFou05DeaKJR0oJmlySW0RLDDH72xeEYJgmuOmvJWZgYpDXVZj9eCyVv+el8fxE3E
 Jz4qR9w8J2jHc8V5iyZdd6DajCW/5TRMcsYS003L1/IC3AfYqUPxrrsq9/jpxO9/owlm3++20X5
 dvY2QtX8VFUbx0Qiqn1vbfSrDEpI27iMcC4rsH5MhUYQkf7PbPCSKecJWnD92IroqMcn4YJxE81
 N8A2CPcz0kQnZFRi+gOR4xmt5YAlHWAlHgl+MeumCwBFDNY9kbZmVtDnoCIVLjEaWSQ4RS4ruzS
 riKPWdZmkHhsSTobbXabj8rxT9nH09M4bSn0dRsHWuWYDbMNEuLCY9AtmzMWv2rLTmCvcbA/OBD
 n4947VCDwCrVyM8QNA1cjf65g3HH2
X-Received: by 2002:a05:6a20:d80f:b0:3de:5a86:9dca with SMTP id
 adf61e73a8af0-3e16bd92915mr11238291637.19.1791881163613; 
 Tue, 13 Oct 2026 01:46:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:d80f:b0:3de:5a86:9dca with SMTP id
 adf61e73a8af0-3e16bd92915mr11238257637.19.1791881162540; 
 Tue, 13 Oct 2026 01:46:02 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5384721a12.31.2026.10.13.01.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:46:02 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:15:35 +0530
Subject: [PATCH v9 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-sahara_protocol_new_v2-v9-4-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791881139; l=5671;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=D6ORrR4WZCXe337DEAaoy6vLh2qom8bYpV8ibq3sUAI=;
 b=cEwEItZ/aATGDCtMC/IMrT3jaZb6dpHYBZq2vC/waUlcZ7wIK+wlAP4SywG/I48UQvIQC3YhZ
 pxVgVNGofNQC2mKIdvz7xAIDhtzAaM55jywh9knYnFS9wci/wTYMkp9
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Authority-Analysis: v=2.4 cv=VqC2kO2n c=1 sm=1 tr=0 ts=6acdefcc cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=3TBL8zyTcm-CCHetwZgA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: H3GIJfahniGeQggrt_b6mSttS4eiR85R
X-Proofpoint-ORIG-GUID: H3GIJfahniGeQggrt_b6mSttS4eiR85R
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfXyOLL/6bJgpsY
 Ho6+NycNXCpX6G3naDP4jB4699EfSrQigT1Ik8D8NnDb1QMN4JnWNvcTOkHud7I0n1uahMP3F0s
 Ac9o0gCDiQNB4Y9HCXXd3rokmuEye9A=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX7LZeuEmnOgFv
 ehWgk9cE3h7A3ko6P3xGMdvLoItS8ixs3Yo/VbgahDl97Tgwz70jLPKrzV7OcDZYP2SCCNBqHNm
 ipynJwbR0zWKx1twCrwJiffhpX+82g04ia2/DxtcyHNeZWJqFvbQb6w3BRHTc5TATpTOjJwrQIC
 RocUvpVxkiercV6yDipCSLnLMOAA7Mum/rtrnbUFq5yFY4cNWq6eTl9Vd2lav5ZhcayIpPXaa8w
 pI8Aa7QJOYm7yGyYEohGo+L44oPmJh79pGQezKma3djH9W1n1o8SBjn4eaNRm5opiwnzRu3xTbU
 RYXSFlSdk9zbtg3ybu5Hu+kxe1OfSmBHkJXAQ3rLdLYLIgvlyLsJaKx0tBk4YgdkU+mEe6Nc/AM
 G0zA2/cZKw12LqRMy9f7HcggGYsm6C+hPHw4jSQO2i8BzZ3pPwDrPI7wGh8Q846u4lAguROtfc5
 mBzfKgP7T7BaSnku71A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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

The Sahara driver currently selects a firmware image table based on the
attached device, but it does not recognize QDU100 devices that expose the
protocol on the SAHARA MHI channel. As a result, the host cannot associate
QDU100 devices with the correct firmware namespace during image transfer.

Extend the probe time variant selection to match the SAHARA MHI channel and
associate it with the QDU100 firmware folder. Add a firmware lookup
fallback for cases where an image does not have an explicit entry in the
device's firmware table. This allows required images to be provisioned by
the platform.

This change only affects devices matched on the SAHARA MHI channel and
does not change behavior for existing AIC100 and AIC200 devices.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/clients/sahara/sahara.c | 27 ++++++++++++++++--
 drivers/bus/mhi/host/pci_generic.c           | 41 ++++++++++++++++++++++++++++
 2 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index ce4fcbd40baa1b3a3d65d0d10fc9e54b1c7eb04d..a4b3ef197b303cce5a36cbeda272119f0430e619 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -188,6 +188,7 @@ static bool is_streaming(struct sahara_context *context)
 
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
+	char *fw_path;
 	int ret;
 
 	if (image_id == context->active_image_id)
@@ -200,8 +201,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
 	}
 
 	if (image_id >= context->table_size || !context->image_table[image_id]) {
-		dev_err(&context->mhi_dev->dev, "request for unknown image: %d\n", image_id);
-		return -EINVAL;
+		if (!context->fw_folder) {
+			dev_err(&context->mhi_dev->dev,
+				"Request for unknown image: %u (no fw folder)\n", image_id);
+			return -EINVAL;
+		}
+
+		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/%u",
+				    context->fw_folder, image_id);
+		if (!fw_path)
+			return -ENOMEM;
+
+		ret = firmware_request_nowarn(&context->firmware,
+					      fw_path,
+					      &context->mhi_dev->dev);
+		kfree(fw_path);
+		if (ret) {
+			dev_err(&context->mhi_dev->dev,
+				"request for unknown image: %d\n", image_id);
+			return -EINVAL;
+		}
+		context->active_image_id = image_id;
+		return 0;
 	}
 
 	/*
@@ -869,8 +890,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
 
 static const struct mhi_device_id sahara_mhi_match_table[] = {
 	{ .chan = "QAIC_SAHARA", },
+	{ .chan = "SAHARA", },
 	{},
 };
+MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
 
 static struct mhi_driver sahara_mhi_driver = {
 	.id_table = sahara_mhi_match_table,
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 7193a384cca477be9e4f48cdf5f67e680ef55fc5..dcd49cd15074a20cab62a304143abbd0c0614cec 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -47,10 +47,12 @@
  *		   of inband wake support (such as sdx24)
  * @no_m3: M3 not supported
  * @reset_on_remove: Set true for devices that require SoC during driver removal
+ * @sahara_fw: Sahara firmware mapping
  */
 struct mhi_pci_dev_info {
 	const struct mhi_controller_config *config;
 	const struct mhi_controller_config *vf_config;
+	const struct mhi_sahara_fw_table *sahara_fw;
 	const char *name;
 	const char *fw;
 	const char *edl;
@@ -287,11 +289,49 @@ static const struct mhi_controller_config mhi_qcom_qdu100_config = {
 	.event_cfg = mhi_qcom_qdu100_events,
 };
 
+static const char * const qdu100_image_table[] = {
+	[5] = "qcom/qdu100/uefi.elf",
+	[8] = "qcom/qdu100/qdsp6sw.mbn",
+	[16] = "qcom/qdu100/efs1.bin",
+	[17] = "qcom/qdu100/efs2.bin",
+	[20] = "qcom/qdu100/efs3.bin",
+	[23] = "qcom/qdu100/aop.mbn",
+	[25] = "qcom/qdu100/tz.mbn",
+	[29] = "qcom/qdu100/zeros_1sector.bin",
+	[33] = "qcom/qdu100/hypvm.mbn",
+	[34] = "qcom/qdu100/mdmddr.mbn",
+	[36] = "qcom/qdu100/multi_image_qti.mbn",
+	[37] = "qcom/qdu100/multi_image.mbn",
+	[38] = "qcom/qdu100/xbl_config.elf",
+	[39] = "qcom/qdu100/abl_userdebug.elf",
+	[40] = "qcom/qdu100/zeros_1sector.bin",
+	[41] = "qcom/qdu100/devcfg.mbn",
+	[42] = "qcom/qdu100/zeros_1sector.bin",
+	[45] = "qcom/qdu100/tools_l.elf",
+	[46] = "qcom/qdu100/Quantum.elf",
+	[47] = "qcom/qdu100/quest.elf",
+	[48] = "qcom/qdu100/xbl_ramdump.elf",
+	[49] = "qcom/qdu100/shrm.elf",
+	[50] = "qcom/qdu100/cpucp.elf",
+	[51] = "qcom/qdu100/aop_devcfg.mbn",
+	[52] = "qcom/qdu100/fw_csm_gsi_3.0.elf",
+	[53] = "qcom/qdu100/qdsp6sw_dtbs.elf",
+	[54] = "qcom/qdu100/qupv3fw.elf",
+};
+
+static const struct mhi_sahara_fw_table qdu100_sahara_fw = {
+	.image_table = qdu100_image_table,
+	.table_size = ARRAY_SIZE(qdu100_image_table),
+	.fw_folder = "qdu100",
+	.non_streaming = false,
+};
+
 static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
 	.name = "qcom-qdu100",
 	.fw = "qcom/qdu100/xbl_s.melf",
 	.edl_trigger = true,
 	.config = &mhi_qcom_qdu100_config,
+	.sahara_fw = &qdu100_sahara_fw,
 	.bar_num = MHI_PCI_DEFAULT_BAR_NUM,
 	.dma_data_width = 32,
 	.vf_dma_data_width = 40,
@@ -1426,6 +1466,7 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mhi_cntrl->runtime_put = mhi_pci_runtime_put;
 	mhi_cntrl->mru = info->mru_default;
 	mhi_cntrl->name = info->name;
+	mhi_cntrl->sahara_fw = info->sahara_fw;
 
 	mhi_pdev->no_m3 = info->no_m3;
 

-- 
2.34.1

