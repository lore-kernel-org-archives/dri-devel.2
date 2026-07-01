Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83771C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E377210EEBB;
	Wed,  1 Jul 2026 10:38:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cpbEpQKY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A9ND774R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6299810EEBB
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:38:07 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8t4V762327
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:38:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=; b=cpbEpQKYeJAibeQw
 DF/pYebaDlq3kYo/OPlezrMmkbtB6HKnIvcZnKq7/Uh0zSHdvpfOyepU7UY0/qJL
 oEseZXD5mMrlJAK4uD/xXudLJbf9dKPglADPs2AVOJo5id7HDRP4SaAoCLVDFVE2
 QohC+zc7CKE2QUntNlQFdxP4Y1AxlMMEuatAX4mGAaxZJMzFvlg/8Z4fVGehZzFS
 ra1u84e/bpbRSFwME5y+dHge3mAyLIUyKohwqKRgFaVLkai8OJo0TdGlI7DbhzVa
 Q7l1eg/sLgcHyA3Dnu1COBxvzH0/75VQAGGxiLOyyE1r+2j9Y+9Ssm85CTGbra+s
 qcC/VQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sd05fn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:38:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38096457d3aso708455a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902286; x=1783507086;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=;
 b=A9ND774RmNVTFkJsJSEYiADQ+DASDTMb0CSJEfmexppOTPCkD8+5L8wUtLgRE4yL65
 1EWGFbWOn1Gb4y98jK8DrBmEuU6L2aNWUdn42UDvvoeQfPebfn+OyhhlHcNzr/5zyXzJ
 KmJ0brc6skBjDy0cdrIB1reWJGED+xYSg+nGAv1y2r+Hv1iJRxHegdUYHymLcID6FqVV
 jMQnqAeN/10aggB4rn5DsLQ5dY2PC/PdWsLkPRIshmC5hjAovdrBx8IpSxOehrFrfaXb
 +kYQp17Aa624gihoYzEfoUzQd4qS9X/dC5XXfGmm/TLUwxN09cGaoZTGSQRLyn90Szth
 B0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902286; x=1783507086;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=;
 b=IY7cg9Z82qr00wPsoKWHcN4CbTWl0oGHWyeZDocm9SAukdDTkrI++yYt/yDwMJK7HB
 1IrDhp6Ab1a75gMHudzM0X98CEMlv8RhTMBnaRRwHwnCCE2QBL1HMr4riwjHR0kbhviR
 cq+RM03NQCLMiJos9aU7J17GuhtcYJWn+fQXPlF5a05annBzYGmv5+VHvvWOg/dWnOMj
 PLc29x6JPKRaSOhYE6YH653ehohVnMQAK8J4ETStyTec/sVv17oMwaBM7i/m36X4Iuly
 QcNCe9qQBXGeVKvhjYuF0RXMeMJOOtlTBv/7CYB0gJwk2iOe4r3UlfxrxdFXRicumMTC
 +OsQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOZKnSShTuH6OHwcKdvMn5of3iDMEOcvZzY0pq6woR4u/oNJp+eX/qCQ/DWWT2Dfx7RLDeuqRwpDk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwVah0kuQ9TbFaMLdVJ5J/0Q1OEXzU6Xq/9RGZUOLOWgBXh1tPa
 xtRJjk5fKZvoX+I22C96d8XhNjog1MvWqFxD6XDiHIZ7HyYN4pBTyWzrp9KWoZvZQABKDeGazhz
 9WmNHxjs54oVAtmRL2y+af70U3ox9gYxZ9CWpOSCtG9FJRrjufLDzXDDxL2zarm1cKlagUTM=
X-Gm-Gg: AfdE7clpfMGsVqScsKbXXLBBwCLN6kR/xPUdEbjTQzOAGRarGgh5Q4sSzdRl9L7a+i+
 V2zC0UklLvSS4NePkEwn+sMycbRbtq3JjVlXFO/GMygyiVNF7x2s+lkOQzlWQ0uoWSE7GoUci5o
 AUePdQDOUYR+l/A2ppoLPN3f8HoitapXTkpFK62Ewl6ADI2qwIBs82cwJOugbJXaHxZIPCAZr2r
 Ivd6hwTQQqbl3bvQmSAlGy7F3p5GSkPHh6zJU6kEE5bM3oPH5QuAOVLcgv4XHQuYY3PH+PDaPji
 HN9QHXBcAFZtYjNgI0IG/FX4shUhbAKODG52eJSUmjgk3QmqefYdvygbeVzBaLkxAFzM3Dh6U96
 GZVt+w/vLayC842e8TeFV/Rcg6f6ZuSZu4PorR8hu
X-Received: by 2002:a17:90b:562c:b0:37f:9ce3:ca97 with SMTP id
 98e67ed59e1d1-380aa20e0cemr953622a91.32.1782902286105; 
 Wed, 01 Jul 2026 03:38:06 -0700 (PDT)
X-Received: by 2002:a17:90b:562c:b0:37f:9ce3:ca97 with SMTP id
 98e67ed59e1d1-380aa20e0cemr953589a91.32.1782902285554; 
 Wed, 01 Jul 2026 03:38:05 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095bc8a2asm765251a91.0.2026.07.01.03.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:38:05 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:07:38 +0530
Subject: [PATCH v6 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sahara_protocol_new_v2-v6-4-3a78362c4741@oss.qualcomm.com>
References: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
In-Reply-To: <20260701-sahara_protocol_new_v2-v6-0-3a78362c4741@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782902263; l=5296;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=y9g67LoOAK1zIYhgVoqMtpnLtPZtPHG+SZ4nbuUAoiw=;
 b=jnKA84aJ1sECKLlROc87nix/+fJvHhxdehrww1VkOlAbyhF3aSuQQrLie42XItz0ub6ZmN/ZB
 r689bN1jkB9CaoIdFwF+Sin8UMVYjo36Y1sA5IsNj8RHzmnCNZTo7W3
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Authority-Analysis: v=2.4 cv=Z+3c2nRA c=1 sm=1 tr=0 ts=6a44ee0e cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=3TBL8zyTcm-CCHetwZgA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: QC6hpHTfHN-MHSI48u3sunmqMeSctxPt
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX5l7GJ5nQVyDD
 h1pDREy/F0U8nKlk3JNW/jecXf17z8Gb+jswfbzztNlqFsoMJVx12/9ldY8/Nu8fa7Bc5k2JTTk
 X5eqhz6eOVZcQPzVZq9DKkVflItlbWk=
X-Proofpoint-GUID: QC6hpHTfHN-MHSI48u3sunmqMeSctxPt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX9/+QPQoE6S6g
 BybMfNCUsALNbNtIiKBHcKHNeY0KeRa2oiS1Oxa59jmxlg1YoeYi1Ib/FsHN7utVfEPpcla19Eo
 6JCkAmkwCSL6iS5jgVXFrtG0DLq1fezc3Ygkq7YHDCLPuCDHJAV438vJ0WeDPlqERUXHcFzikSL
 IqoAbZu1OVLL8c1Tck9VLFifbUvsACVCP9YuHDcyBcGUEZ7sRW4KjSDG5qYv9Ceue0Dyqo8EyD4
 0K+GrlP4xBzUxddzAD86ifD41JcWhOQW2lAnXjxgOCFTgrZqe+GUOPjuBrsSwkwrtJyIil7A+Q+
 VkWFYWYrorB6oSQWn20gKQ/GMgnHNY6s61/h7GP5Mu/qLqQP5EXCD072mvx79n/XC6W4r0J9mNA
 re9/4UdkXo7EH3rWUEu8zkxDE+X1uY/6MAGvAqP4/XMbURU1t+Waz713VRlrFsi+UWnznxrEW00
 wAh5VkPzdBcUIR+iRew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010111
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
 drivers/bus/mhi/host/clients/sahara/sahara.c | 27 +++++++++++++++--
 drivers/bus/mhi/host/pci_generic.c           | 45 ++++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index e339c67e236af271645ca81cc517efd9eead87e4..9adbd84859073d8024ba2a5fcfa33897439d6759 100644
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
+	{ .chan = "SAHARA"},
 	{},
 };
+MODULE_DEVICE_TABLE(mhi, sahara_mhi_match_table);
 
 static struct mhi_driver sahara_mhi_driver = {
 	.id_table = sahara_mhi_match_table,
diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
index 391ab146f501c6ce1c81f6138f7c491a49c2f264..82e41632afc555a53dec3d8395558ae039b33bbd 100644
--- a/drivers/bus/mhi/host/pci_generic.c
+++ b/drivers/bus/mhi/host/pci_generic.c
@@ -300,6 +300,43 @@ static const struct mhi_pci_dev_info mhi_qcom_qdu100_info = {
 	.reset_on_remove = true,
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
 static const struct mhi_channel_config mhi_qcom_sa8775p_channels[] = {
 	MHI_CHANNEL_CONFIG_UL(46, "IP_SW0", 2048, 1),
 	MHI_CHANNEL_CONFIG_DL(47, "IP_SW0", 2048, 2),
@@ -1399,6 +1436,14 @@ static int mhi_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	pci_set_drvdata(pdev, mhi_pdev);
 
+	/*
+	 * Provide Sahara firmware mapping. Sahara consumes it via
+	 * mhi_dev->mhi_cntrl->sahara_fw at probe time.
+	 */
+	if (info == &mhi_qcom_qdu100_info ||
+	    (info->name && !strcmp(info->name, "qcom-qdu100")))
+		mhi_cntrl->sahara_fw = &qdu100_sahara_fw;
+
 	/* Have stored pci confspace at hand for restore in sudden PCI error.
 	 * cache the state locally and discard the PCI core one.
 	 */

-- 
2.34.1

