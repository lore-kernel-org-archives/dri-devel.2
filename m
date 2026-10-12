Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2E62CA9EDE
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:19:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1264410F2D3;
	Mon, 12 Oct 2026 18:18:52 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A687C10E653
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:34 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHv5cu3466848
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sw8RZE7vSFZG1vO/uYgqWWGk6n7nko8KiavfyPAl2eQ=; b=fE4hAalxnWjSKUtK
 yphQJfoTZYgpMshM4D8ddx3i1Om+AEV/u40RjGOi32xYvqlIxQXl9q3cFpPowTG/
 SIEYKcJ7RAfyFhK0y8L07l80A/ozcwQ4Mo865DE8GCmOEudsHsiv4fxmQqwDV7qR
 JOQ9yHQ2M5ry1KXyJNENs3Gjx0RArji5Ue1gNGsn6JCJPjXC0ZGI7pV7cK4gB5nC
 wREyiSwm+IrCo4fUG134GEDdaPjcpflI0PxBdGJ46Usz2IzNK5vFy3CxipG4ix/O
 Roivrrtzg/vbU8a/C6HXyiV8zyXan4lPe1KGUZ+xXIsjfqsvxIaXT5GrnOYHt6Se
 Vba9Sg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8sd1udhn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:33 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-35a04491c56so1381578eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791829112; x=1792433912;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sw8RZE7vSFZG1vO/uYgqWWGk6n7nko8KiavfyPAl2eQ=;
 b=W9xa70pLbzOHSu0V7riycKPGml5jI311i8nIROjHhf48+CxukebhxzPhtdUgFyj1tc
 XtjZnub9ApnluDyyvPyoFjqW5iK57TT/WkExEZgmoKQ94OLdO9fCEQ27kYhj6yUiv6Yc
 94VCmlATAREiRGf8AODeC2d2r6IFu8byF7yI45I1yAZoC+0IRBmFBG4/mArUpe8+nEUD
 fxNazhU49gsiRlqfSkcj8JRakQp7g0ZAv0OYXQdn0pfitmMR68vqZ74pUDCwQti9/esb
 TJ/0ORqeycDXMhJl/GfQd9hVlbxExwMLeVGlGscqkDcf4AnJ0yC4reEOVEX9dDrDcgLd
 dv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829112; x=1792433912;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sw8RZE7vSFZG1vO/uYgqWWGk6n7nko8KiavfyPAl2eQ=;
 b=NbVj+SkOLP8DF6elWQC0dmNjSWbvgjsAw1StLWmxUW6/gEZLzmKRNA0yYXmTN/XeaZ
 7onadQoWlFk95JFRiAdlYydUu+So0z+rTnQqRCOnCMvkm7FxIBqe1BmjNoFWKPh9pqII
 xZLi+ToyjP7q80siJsu32HquoT+eomF1xO3hX26AwGwF0x72NRh8MlPcf0pvVOneIxin
 Vik0MrsA9PiYxlwS4enUISl2rxLMCj4a+GcfK+cqYjhGssAV+iV6QBPOSTgFww2AUcy7
 rBu10GEuLTSx1zYuqQR11vpCk1wejwx4V9OLP/G001UHkFAinLw8Fte3zsgjsRjpYpgK
 z4hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXIx570tS/qQq27UPnFOV/ODQTDEF0G8fg6zaiEr97uZat+SNlLQMdqdaKiTiHCzb3JDpKOQXqrjI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKLloETDBUO+yyLz5EtTdTUu4Xm/JUS1dXE3ZAdJTKT/B5DE5ws
 riu+QP2fFyCPRsSwieX4yK+uGcM+PGbe56YgT61NmnfNGY+VfivYIf3lPlxt3SVwwVkyh2OIcoh
 zJOt5P/BNqMaeDs8botPNmKjAfXtO/8MMYUZnzUJnpfsjk/46YxfVnb5Bcp0IJcQgcWtgXVI=
X-Gm-Gg: AYBFou3wfmILoIHAQEPcIllr4uWcxgIze0QISruq3bX0tOU3fpXOu5Lm+DLd6QWMmcg
 oekgCamftzM3O4kKi9A/OUEwiUIESuI1c879wOSI71Q7MImRu4qe9ItQuJ+6XSVHAhfsbfmpHep
 /QoHTVTL5x00WalillB5dmgubwM8RluIfMb+2+aFe6pdsCYPCqNbyhCnwmH3mFA9nKCBwgiIPpD
 PdN6m4FCLqprW5qkG0D+ArzOtQDGmtPDIXJziM3ArCu/pmrBYXJDTeRDigC/YC8ohaKRXCg4cg3
 Nq2I7K7XGPiMASGDulVW64P0/o8ppUuIfAd4QslbQwY3FIVNI2h4N/5CySVAnz+j/GV5XC22ktu
 xsnwi/07L3ztVoZi14ufKZvA3c5tb
X-Received: by 2002:a05:7301:550d:b0:353:ba38:789d with SMTP id
 5a478bee46e88-353ba388140mr13485326eec.0.1791829111874; 
 Mon, 12 Oct 2026 11:18:31 -0700 (PDT)
X-Received: by 2002:a05:7301:550d:b0:353:ba38:789d with SMTP id
 5a478bee46e88-353ba388140mr13485293eec.0.1791829111326; 
 Mon, 12 Oct 2026 11:18:31 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm22827311eec.31.2026.10.12.11.18.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:18:30 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:48:02 +0530
Subject: [PATCH v8 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-sahara_protocol_new_v2-v8-4-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791829086; l=5671;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=LI2epAdNTVUimdncg6NOtNOZI6PyMoXM1ZEtdy3pDbc=;
 b=wkC+OVvFRtY8UHddDtkJpmNFwHGJW7RpfoVcHn+HpC9M0lCTNm93O6U0Gn77n16mtWnzvZXCy
 Z9ybBBVceZ+CIUa02TCidoT1WSPyB5TW0Q3x/BelsiymE6APDmujaPl
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-ORIG-GUID: Psihqvl3wgQVCD8coylExrhXsi5nsU5o
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfXxELBrs2sj449
 OoDDSeJJND4L8GfHy++e1OKRVYE385zmWxxU0FzFWax+MRny7wmtjvwj1Pgv82kMTS+n8SZl7Iy
 HhBSuxjYDnhFmlt4pJCvRV4v1MVllFc=
X-Authority-Analysis: v=2.4 cv=QtHLTlyd c=1 sm=1 tr=0 ts=6acd2479 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=3TBL8zyTcm-CCHetwZgA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: Psihqvl3wgQVCD8coylExrhXsi5nsU5o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX1dIxcbj0D3TV
 4r7K7Gj6m96bbkYAGaUH/1HWiKHIHEaZabvk0vLuqoyFk8PKBZypeiwfH/5HdcFiE2t2u9wUycz
 GiznWNGGfWjK65mv2tc7R2W7AgCroBYsnJBhyFOQ+2F0LmTg7xwCsrJdwfbwxy6YdotHYhYanmZ
 ApMsPmWIbYsgwejUX4VukZZHADu7zwCYTC3uoEkr87h2Lgy01UiEaOXyJ7uCg0GM5Adixh3TO9e
 iyHcc+nie5zGPh2ySLpkOA6IKMQiZwsLfpHUw5TNw5AET8zr2eRw9Jq3wxlGWcVYdIMxVECV0YZ
 VHDLPiYeJlI3Gsqtgm3wm5nDgEzaAZSX9kEsDC/VEbwFFLfS0v6AQIN/UCIfFQHxv/efvlIldDG
 i9+mELF3S29dx+HsQT//Q9dH31Rzz3ZzDcYSz/PLlUurRhCHcoLDf0HIdCDpfGHOmrKOnnoxAtt
 QFMuxTCQlp8BHS27EXQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120072
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
index 74bf57f02873e463d0c2cfdd2673237840169df2..4baa47d0b94e326b5bfcaa80c8ddf008881c85c9 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -189,6 +189,7 @@ static bool is_streaming(struct sahara_context *context)
 
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
+	char *fw_path;
 	int ret;
 
 	if (image_id == context->active_image_id)
@@ -201,8 +202,28 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
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
@@ -870,8 +891,10 @@ static void sahara_mhi_dl_xfer_cb(struct mhi_device *mhi_dev, struct mhi_result
 
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

