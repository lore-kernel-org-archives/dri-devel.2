Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8347EF8D74E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E189010E8D3;
	Thu, 16 Apr 2026 14:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hpm0hb/b";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YHWV9kTT";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06B0310E8D3
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:18 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63GBiFAg1668253
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=; b=hpm0hb/bFNhRlhQm
 0sLAALK9V93qPCce9b7ucLX45C1dmbYi2MfOxGGbKdeMgk3bRnhiLISNPQVYGE8n
 bHXIbaoGh1O1bNQGXY6+pSU9PzeHuxb0BGwoiYG/8aZdmeYLbrVUMIPQAM4qP0kd
 24cTtIKc/8Rn9rbjW35pL37BsP+PbwRJmbpt+7Kkow+9z3nd+ZXLi+D993MvUGIQ
 soIQm3mXVTq+2n8ZqQbfGR+E0v9NoWG4E5FF9MwW0Ipb2iF63ZQQbx0NaTE4RpaS
 7awyScIBfjNsPSgM9EAVqmxrjztZ6B3xELGfZ9LwM12ZS5V4QdMJnF1mEib1+3fS
 66BY1A==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djtd91mr7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:17 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-799003e8a77so259030537b3.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776348617; x=1776953417;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=;
 b=YHWV9kTTkcb1OLEJtwWfvgM3Idx4tjB7EoCYQljYnhCPbn3sVeMSiYZE1Qw4vQh+n+
 gw3MM1zkFBIER5WyzAjEIy6tDdfv/CUKLxdof4MI5AKgrdnXI8IfoLvhbCwZRJuzjuSO
 dgvzF9ho5bVHzgql5jm/1Vsuq7dO8VOx1fE0kkW95ED+FCHLwq9D7vUZ9zxi0B2xN6kO
 xdHd5/fqgaKEPPKGEraWUrDNePF/r1VLVfSuDsYrobN0Wu0cHM5ubJ3KnmziNiiPwmOX
 stdQrbr3sQcjlqXVIS74UiK7kn82KUz/WSDm2upGl7gWMSbpHHtzAChskCaiKqIdH6J8
 yCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348617; x=1776953417;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eWnkB32rC8c/c1FmukfGJLAkXTQ/yzUwW5QZTJ1tuHA=;
 b=eNK6kq0KBZKVlOoKIZVVOA1ydbIZGBkd7IaC317/2XYCish5EbZxvzF6Lc4D9NS5Qm
 cdDV6Kk1XNa50xKjN9mRP3rkqwbEt5IfVasnFWX2uWtj3VUw/oxGVd6tA3/fveqFY7c0
 1Xn8qFLLfWLYuBAOtE22R5QsE8ZOz4D1rTdAgE8QrmyiKuYEr8bXvPuSpCFOzj5P7IA6
 6NlOZNzMMLbI1ockm8Nd3Zuc/ATnfQGpwK1Z+5ddSAqHqXJtifI2y2z4HXG+7MuL5Du1
 oglAcwf6aJXLwzvwuTPp/KgsgU4qmQWmFXwJMamYu5alfu4n+uIoVffVN7DhpA2hpa/5
 5gzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+08nz8yyWlWI+z2xzrYG2M+9sKH3FDaogdJUyLpxp2OqJcciG58XY9UzgG8gB4Sda8bNgSixJj5/A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypOiIvKPgEuksFvZeicaHFtcM3fJrzzolgEwKzcaNk8nt8B73O
 Gtmohi4kEIOW2VlXCIEGFcIGAcIhmYNJWMwifw251gdvxLf+VgriSUNyXcUNb2cWnlCYvH9dMyW
 E48J3cPNkb1Hd53QrSv9atZTLuYXrLsVTn4tv7pmYfj4TNUu7qucVNG0p5UZvPhv823UuFGs=
X-Gm-Gg: AeBDiesHL2sjjjG3ZhLl9SnE6uzVyITK4QPKcvNRMmIlhnzyGz9okeTfYscxwcFw4lu
 L7ExlRp8KeEPrtuUUsbzD4wvdFmJL2N7PHA5e21wAPOmLVD7q/bE9gGo/veQjAEwlMpcgqt8QDm
 TYbHON1SqyVQdzNjjtYr56eeq9Gos7QXMOhFwTRpcq4WyS8uNF9Jr9Z6tdTtS1QQIj71Mz2rbeU
 c/WMQ8VtFnXWG+hSor3KZe4Qi3qxl5bxQjS0NGk4U3w17SjUH93RAJZg6P+LPOg59qkcbGwiL+t
 G0JIrbqvIiEDSK/YywF/FiUUGmCUmG69gkx8Y8mzyAp+ZXeuyGZtmoOO0KYRZDic491IvxmmsVT
 bnwf52TqO9jDSl6OFajuFseez5cdCyK8hX5c66xmPfg6xEq855ak=
X-Received: by 2002:a05:690e:4093:b0:652:b4cf:5f4a with SMTP id
 956f58d0204a3-652b4cf6489mr9471033d50.37.1776348617306; 
 Thu, 16 Apr 2026 07:10:17 -0700 (PDT)
X-Received: by 2002:a05:690e:4093:b0:652:b4cf:5f4a with SMTP id
 956f58d0204a3-652b4cf6489mr9470976d50.37.1776348616813; 
 Thu, 16 Apr 2026 07:10:16 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-652e47ba4a3sm2084691d50.17.2026.04.16.07.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:10:16 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 19:39:45 +0530
Subject: [PATCH v5 4/7] bus: mhi: Add QDU100 Sahara variant and firmware
 fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-sahara_protocol_new_v2-v5-4-6aebf005e4ba@oss.qualcomm.com>
References: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
In-Reply-To: <20260416-sahara_protocol_new_v2-v5-0-6aebf005e4ba@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776348592; l=5296;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=y9g67LoOAK1zIYhgVoqMtpnLtPZtPHG+SZ4nbuUAoiw=;
 b=moq8nUJ0iUz8BQ2TQ8GG3ft1cyqL1DFfDQ3UYv2eS/Qyql41eeEq9JnLpiDH0cxJMFU/XU1RY
 QA9H7PAlju6BGFBKd2Mucqmhx7mTeCTRhGPO2W6QwUfnz1rrBJEfDSM
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNiBTYWx0ZWRfXyejurNabFd5Z
 dFsj4vuHzdymBRePvnUJDHidC/U/qpRhUAIgnI9Iif9jU+KDXB7bjiOhPqb21HQ2rqtQkefA+WQ
 iG+Eeq75OWPLFydVYNousWsJm2e/amvAhyX+TQqUwlmU7OguSx+KVPLocEWT6RJ2ovcLx6nBt2P
 0S7BpxhxnTdqw5IXyzvnLCZ3lZTyXANQh0Zruc4o0MIuedhc0ZUDGg2oUeLwjMdqElfVi1BFcAD
 1tgVamAS7pn6xlhA5XwqfCpumAy6ovxL6QwdcRWN/xJ4HmqbGNrhJAWXI0yLuJEXWpTh/DC4IZ/
 zQZ+Lp+VR2aRK8ZOGAbQqrW4MP/z3am+9R2WX55z3zsvFC+01RF3inLFHYn7PmtdAMqxPUg9Gme
 N6/FdAH5GjBPe4p5xT2hdWqVDA2lWMI872jG4YpfLrikz0zH6RJ9SdEErAhwoDaf3BK+07EJMaj
 BhksZWUVp+U+T2cyWhg==
X-Authority-Analysis: v=2.4 cv=avuCzyZV c=1 sm=1 tr=0 ts=69e0edca cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=3TBL8zyTcm-CCHetwZgA:9 a=QEXdDO2ut3YA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: cFROF1wRz3dpxmVMAvljnW-QvMyxvqK1
X-Proofpoint-ORIG-GUID: cFROF1wRz3dpxmVMAvljnW-QvMyxvqK1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160136
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

