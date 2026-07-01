Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3047FC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CEAA10EEB8;
	Wed,  1 Jul 2026 10:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TXVD0JD3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CvjCtCL4";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 464D910EEB8
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:38:03 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8UFl680776
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:38:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W899JKnFZJ6i4LZoCOiJODPDV7JFYUGw4LZ0YibnRaI=; b=TXVD0JD3jHYJKhQZ
 g9/Nu8xk/yuVi8rFC7mNHpMcGpoSynlN/Y5bLuBhhAyw3WvVma8DTC4rfghMYO5z
 icSf7PmJdqU3YLaE9GdY9Tfz0T+h7yBojg6kQ6dF6Ijpw8lPwzwu7q8QpGiOD/+H
 ytPLsf++/BIov429xy/yz343NDP5YEHOl8oUYtMRM9KE0OizU0VBPIlCxthZlaxz
 eyE5RR5Zi76TUyQje0ySq1daiZWt6J7/ijav8Dfha+ScOF8vcPWqCwXySeirH47e
 2gjaxT3KfWzRRuv3UySS34woKzOkEuPHGX7tTNG156aCRXpKdMo1/rZ2Go0X9E92
 mfdQ9Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4k3skq44-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:38:02 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-38096521198so917088a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902282; x=1783507082;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W899JKnFZJ6i4LZoCOiJODPDV7JFYUGw4LZ0YibnRaI=;
 b=CvjCtCL4mfJfGa0p/v1qDKa0vm8QHLPrgKRSAn8G5ohPiGtzcEMpG2tCNMTcSE0WIV
 tTZibalItDIVI+07J8jOT2y1V0fcH75hCQmknLOTuM4GLv1Z0GqpAxmRWPjHLxdHoacn
 E0eYXO9SKYpPh5AfCKMtvAAfmppKtJKWl1fWyx1KObibRioK16iRYc6221kC7HFv7Hwz
 vXf7+0KTbYSHPYqwm152TbXyVSNyKJvHy/CEUe+drZ3gOeo5TzjebhXPg+e2b0a0GreM
 sSc92y5kqfIqzOWYcya2DwZzKOxKuXFARIm9gC8RHDTXu37AUxg2QHIfilUimZtFBFHg
 VvyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902282; x=1783507082;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W899JKnFZJ6i4LZoCOiJODPDV7JFYUGw4LZ0YibnRaI=;
 b=tEnguCbH1t+7espjnOkKFhukAPiok0dUFgSCV47B6h4ro37aNKIySMd6m37riz7c21
 3SxMIpBlJ2aeNSgQgb/VscXYUiOUF3/IqX1Q7T/CG9/ukfhAy6ED3nt+SRPQLkI/xdZ6
 eu0r+JtMlQKPOLSg9e0lSRwJjac8fjw2Ke2X5JjaYKQZShKGgcm03H2cj1j+kxrQZUg9
 udKUq+GnPVAILNfKBzd1Q3Ip8H2BvjR+ccfh9VJ0eOD44SXHZCt3DivNNAqVtHWUEY34
 HwVgIS4zXbsKxdq/5UnwB613CIImlbj8DY0uEoC00QjGhCwjB4qDoJP3Tw4aFEl+55IY
 wTJg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqFhJvkg0jtcKuifODEO2SQT/xvcbeUOmRp6jXw7kUbaWNOTdRNN0mVGUHlA5saVTAeA/c7bwwtlvY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoIo4CnuB4nAxBE8gRVzLfXwqWcg2Jpv7GqiS+Y3Rh3zhPI+VX
 UreUnpacm6ipfZoNqjw98qyRbNjFNcZIE3n6z7kex7wleEAfdUSn/49AyoieoZxH9HI0HSeX1eS
 TX0roAtQXzkd0A9T1PMaYZaAdQ6bd4bS5wK4rNMBTjFevWORgqkfqigdcvUK4+PUPQHOZCH4=
X-Gm-Gg: AfdE7cmZO8GVDQl35Tp8tNX4gWdQTxGNYcAQB5fHnkIGwH4BIqnRbdfdMI+nGYQIubi
 DKGyG12hFoNKOev2FyTlpihvADTA28JGMBJhiIU7VZD9UyzXd7W0ZJyYkLuEidi21vzDt7p/40K
 IoTvoJT9a0sm3TB8rfHIITCNoCAskzVAOwGg9KVBAJjBhx0pq+FVckhQOD43Wt/3kGjS+57yeL9
 u9JnzYwUFeRo43j2+IwyVEfetsKaXc3ynhRQ+woi0BuIszWAbhK/Huriz+wdZckRaCCAoPLCSY2
 RlbT89otzmydgP9AazzmpZH9cyb5kLYNbXyIAfQfc/ZAxpeX8kfEcWh3Rfo+2v6joCL39L9uL9J
 3wqWRqvgiD3gEGYrqtXdOgqs/9Qx9huzEEXZ4vBny
X-Received: by 2002:a17:90b:4c48:b0:37f:db06:228f with SMTP id
 98e67ed59e1d1-380aa0be8b5mr939766a91.14.1782902281852; 
 Wed, 01 Jul 2026 03:38:01 -0700 (PDT)
X-Received: by 2002:a17:90b:4c48:b0:37f:db06:228f with SMTP id
 98e67ed59e1d1-380aa0be8b5mr939747a91.14.1782902281259; 
 Wed, 01 Jul 2026 03:38:01 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095bc8a2asm765251a91.0.2026.07.01.03.37.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:38:00 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:07:37 +0530
Subject: [PATCH v6 3/7] bus: mhi: Centralize Sahara firmware image table
 selection at probe time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sahara_protocol_new_v2-v6-3-3a78362c4741@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782902263; l=8668;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=28E7Vcxz/zL/tJvNl4R7cGAC0IOtuHloTBJjNXp+ts8=;
 b=1qMdaCPQ4PGOsJEaVVsiUbSxsJ9ylr9cTCn+mHNvl8Ocw5dtHEpZsYOLJj8jWgSq+ozAfks2V
 zA9lMFc2dTODC8NOkSOg1E1m7JFFvsRRNlEX1nqktSB/rvBLMyWRmD2
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: 3bsoYQdquzEUh229GHzrJMKxDfOrE9LG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXzatIdhsoNVXM
 T8EaAXIOQBhewHPK1DDO49YacAev23NrMzLvIAFecqEPjeCRIcye/pcoE4mjbOMAMtiFGQ9rsiz
 Thb5B07yWDT0W3/RcMzLbPG4ukIRMk9axSnEkAdIyyAUUCkF/xUDLKg+YtqPP/Fvci88Lt60emR
 F9RLqVVSOnNqQqLP2jCU5MoQ8RPW8J8PjlQ8HySGdS+WvOKXxQWWzvZvrv2kzHmpLg5Ihw3ww4/
 N3w1mz5h+kcuKPMRmtz/W4wtqLLtnBw/CyjXUFLSkfjKtmhrMKVpg7DjFrf7phKCD3QvX7PNgMa
 uDsj1JNTHW70ccwKT6HEPS4yxgWcvQz33Z4T0mIP8qt9WPhp5TTEys6V4//RsYyhrnRU6/++KTv
 h0fHpVFciOJzjysdI/gd+Vb16s5Sj+3jON2NhLX/h3fzSLrBSIK56oFIo4Ff3e7vwEqibFjBP1J
 HQSlJXGSjCmk3zHP2zw==
X-Proofpoint-ORIG-GUID: 3bsoYQdquzEUh229GHzrJMKxDfOrE9LG
X-Authority-Analysis: v=2.4 cv=Ff4HAp+6 c=1 sm=1 tr=0 ts=6a44ee0a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=FaWmrOfgj8M-bvBoqZ0A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX08kUExf9vlvk
 AdN1f3OtFGYD4YqO/imr1NnvgWVVRXd/6c5xmOhxZ3m4xlnM/YRToLTLwVb6IDPloJlryWcoCM0
 M977zt8SVilN9x91QFVxmA0lnosrI2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 suspectscore=0
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

The Sahara driver currently selects firmware image tables using scattered,
device specific conditionals in the probe path. This makes the logic harder
to follow, harder to extend for new devices, and spreads device knowledge
across multiple code paths.

Refactor firmware image table selection into a single, explicit probe time
mechanism by introducing a controller provided firmware mapping table that
captures device matching, Sahara image tables, firmware folder names, and
streaming behaviour in one place.

This centralizes device specific decisions in the controller driver,
simplifies the Sahara probe logic, and removes ad-hoc conditionals while
preserving existing behavior for all supported AIC devices. This is in
preparation for adding QDU100 support.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/accel/qaic/mhi_controller.c          | 61 ++++++++++++++++++++++++++++
 drivers/bus/mhi/host/clients/sahara/sahara.c | 60 +++++----------------------
 include/linux/mhi.h                          | 17 ++++++++
 3 files changed, 88 insertions(+), 50 deletions(-)

diff --git a/drivers/accel/qaic/mhi_controller.c b/drivers/accel/qaic/mhi_controller.c
index 4d787f77ce419fcd2b250f9cabaec9c26f2da8dc..1f9ef871421b976c35cfad59aed715da96c1813b 100644
--- a/drivers/accel/qaic/mhi_controller.c
+++ b/drivers/accel/qaic/mhi_controller.c
@@ -20,6 +20,62 @@ static unsigned int mhi_timeout_ms = 2000; /* 2 sec default */
 module_param(mhi_timeout_ms, uint, 0600);
 MODULE_PARM_DESC(mhi_timeout_ms, "MHI controller timeout value");
 
+static const char * const aic100_image_table[] = {
+	[1]  = "qcom/aic100/fw1.bin",
+	[2]  = "qcom/aic100/fw2.bin",
+	[4]  = "qcom/aic100/fw4.bin",
+	[5]  = "qcom/aic100/fw5.bin",
+	[6]  = "qcom/aic100/fw6.bin",
+	[8]  = "qcom/aic100/fw8.bin",
+	[9]  = "qcom/aic100/fw9.bin",
+	[10] = "qcom/aic100/fw10.bin",
+};
+
+static const char * const aic200_image_table[] = {
+	[5]  = "qcom/aic200/uefi.elf",
+	[12] = "qcom/aic200/aic200-nsp.bin",
+	[23] = "qcom/aic200/aop.mbn",
+	[32] = "qcom/aic200/tz.mbn",
+	[33] = "qcom/aic200/hypvm.mbn",
+	[38] = "qcom/aic200/xbl_config.elf",
+	[39] = "qcom/aic200/aic200_abl.elf",
+	[40] = "qcom/aic200/apdp.mbn",
+	[41] = "qcom/aic200/devcfg.mbn",
+	[42] = "qcom/aic200/sec.elf",
+	[43] = "qcom/aic200/aic200-hlos.elf",
+	[49] = "qcom/aic200/shrm.elf",
+	[50] = "qcom/aic200/cpucp.elf",
+	[51] = "qcom/aic200/aop_devcfg.mbn",
+	[54] = "qcom/aic200/qupv3fw.elf",
+	[57] = "qcom/aic200/cpucp_dtbs.elf",
+	[62] = "qcom/aic200/uefi_dtbs.elf",
+	[63] = "qcom/aic200/xbl_ac_config.mbn",
+	[64] = "qcom/aic200/tz_ac_config.mbn",
+	[65] = "qcom/aic200/hyp_ac_config.mbn",
+	[66] = "qcom/aic200/pdp.elf",
+	[67] = "qcom/aic200/pdp_cdb.elf",
+	[68] = "qcom/aic200/sdi.mbn",
+	[69] = "qcom/aic200/dcd.mbn",
+	[73] = "qcom/aic200/gearvm.mbn",
+	[74] = "qcom/aic200/sti.bin",
+	[76] = "qcom/aic200/tz_qti_config.mbn",
+	[78] = "qcom/aic200/pvs.bin",
+};
+
+static const struct mhi_sahara_fw_table aic100_sahara_fw = {
+	.image_table = aic100_image_table,
+	.table_size = ARRAY_SIZE(aic100_image_table),
+	.fw_folder = "aic100",
+	.non_streaming = true,
+};
+
+static const struct mhi_sahara_fw_table aic200_sahara_fw = {
+	.image_table = aic200_image_table,
+	.table_size = ARRAY_SIZE(aic200_image_table),
+	.fw_folder = "aic200",
+	.non_streaming = false,
+};
+
 static const char *fw_image_paths[FAMILY_MAX] = {
 	[FAMILY_AIC100] = "qcom/aic100/sbl.bin",
 	[FAMILY_AIC200] = "qcom/aic200/sbl.bin",
@@ -871,6 +927,11 @@ struct mhi_controller *qaic_mhi_register_controller(struct pci_dev *pci_dev, voi
 		mhi_cntrl->name = "AIC100";
 	}
 
+	if (mhi_cntrl->name && !strcmp(mhi_cntrl->name, "AIC100"))
+		mhi_cntrl->sahara_fw = &aic100_sahara_fw;
+	else if (mhi_cntrl->name && !strcmp(mhi_cntrl->name, "AIC200"))
+		mhi_cntrl->sahara_fw = &aic200_sahara_fw;
+
 	/* use latest configured timeout */
 	mhi_config.timeout_ms = mhi_timeout_ms;
 	ret = mhi_register_controller(mhi_cntrl, &mhi_config);
diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index 858dc5bc39c1ad42922cabef3b1abcd43bc4f0f4..e339c67e236af271645ca81cc517efd9eead87e4 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -179,48 +179,7 @@ struct sahara_context {
 	u32				read_data_length;
 	bool				is_mem_dump_mode;
 	bool				non_streaming;
-};
-
-static const char * const aic100_image_table[] = {
-	[1]  = "qcom/aic100/fw1.bin",
-	[2]  = "qcom/aic100/fw2.bin",
-	[4]  = "qcom/aic100/fw4.bin",
-	[5]  = "qcom/aic100/fw5.bin",
-	[6]  = "qcom/aic100/fw6.bin",
-	[8]  = "qcom/aic100/fw8.bin",
-	[9]  = "qcom/aic100/fw9.bin",
-	[10] = "qcom/aic100/fw10.bin",
-};
-
-static const char * const aic200_image_table[] = {
-	[5]  = "qcom/aic200/uefi.elf",
-	[12] = "qcom/aic200/aic200-nsp.bin",
-	[23] = "qcom/aic200/aop.mbn",
-	[32] = "qcom/aic200/tz.mbn",
-	[33] = "qcom/aic200/hypvm.mbn",
-	[38] = "qcom/aic200/xbl_config.elf",
-	[39] = "qcom/aic200/aic200_abl.elf",
-	[40] = "qcom/aic200/apdp.mbn",
-	[41] = "qcom/aic200/devcfg.mbn",
-	[42] = "qcom/aic200/sec.elf",
-	[43] = "qcom/aic200/aic200-hlos.elf",
-	[49] = "qcom/aic200/shrm.elf",
-	[50] = "qcom/aic200/cpucp.elf",
-	[51] = "qcom/aic200/aop_devcfg.mbn",
-	[54] = "qcom/aic200/qupv3fw.elf",
-	[57] = "qcom/aic200/cpucp_dtbs.elf",
-	[62] = "qcom/aic200/uefi_dtbs.elf",
-	[63] = "qcom/aic200/xbl_ac_config.mbn",
-	[64] = "qcom/aic200/tz_ac_config.mbn",
-	[65] = "qcom/aic200/hyp_ac_config.mbn",
-	[66] = "qcom/aic200/pdp.elf",
-	[67] = "qcom/aic200/pdp_cdb.elf",
-	[68] = "qcom/aic200/sdi.mbn",
-	[69] = "qcom/aic200/dcd.mbn",
-	[73] = "qcom/aic200/gearvm.mbn",
-	[74] = "qcom/aic200/sti.bin",
-	[76] = "qcom/aic200/tz_qti_config.mbn",
-	[78] = "qcom/aic200/pvs.bin",
+	const char			*fw_folder;
 };
 
 static bool is_streaming(struct sahara_context *context)
@@ -796,6 +755,7 @@ static void sahara_read_data_processing(struct work_struct *work)
 
 static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_id *id)
 {
+	const struct mhi_sahara_fw_table *sahara_fw;
 	struct sahara_context *context;
 	int ret;
 	int i;
@@ -808,14 +768,14 @@ static int sahara_mhi_probe(struct mhi_device *mhi_dev, const struct mhi_device_
 	if (!context->rx)
 		return -ENOMEM;
 
-	if (!strcmp(mhi_dev->mhi_cntrl->name, "AIC200")) {
-		context->image_table = aic200_image_table;
-		context->table_size = ARRAY_SIZE(aic200_image_table);
-	} else {
-		context->image_table = aic100_image_table;
-		context->table_size = ARRAY_SIZE(aic100_image_table);
-		context->non_streaming = true;
-	}
+	sahara_fw = mhi_dev->mhi_cntrl->sahara_fw;
+	if (!sahara_fw || !sahara_fw->image_table || !sahara_fw->table_size)
+		return -ENODEV;
+
+	context->image_table = sahara_fw->image_table;
+	context->table_size = sahara_fw->table_size;
+	context->non_streaming = sahara_fw->non_streaming;
+	context->fw_folder = sahara_fw->fw_folder;
 
 	/*
 	 * There are two firmware implementations for READ_DATA handling.
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index 88ccb3e14f481d6b85c2a314eb74ba960c2d4c81..060dafffac67c5c920adc1562a61a7233e8d583f 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -234,6 +234,21 @@ struct mhi_channel_config {
 	bool wake_capable;
 };
 
+/**
+ * struct mhi_sahara_fw_table - Controller provided sahara firmware mapping
+ * @image_table: Sparse array indexed by Sahara image ID
+ * @table_size: Size of @image_table
+ * @fw_folder: Firmware folder name.
+ * @non_streaming: Streaming feature support (optional)
+ *
+ */
+struct mhi_sahara_fw_table {
+	const char *const *image_table;
+	u32 table_size;
+	const char *fw_folder;
+	bool non_streaming;
+};
+
 /**
  * struct mhi_event_config - Event ring configuration structure for controller
  * @num_elements: The number of elements that can be queued to this ring
@@ -360,6 +375,7 @@ struct mhi_controller_config {
  * @wake_set: Device wakeup set flag
  * @irq_flags: irq flags passed to request_irq (optional)
  * @mru: the default MRU for the MHI device
+ * @sahara_fw: Sahara firmware mapping
  *
  * Fields marked as (required) need to be populated by the controller driver
  * before calling mhi_register_controller(). For the fields marked as (optional)
@@ -445,6 +461,7 @@ struct mhi_controller {
 	bool wake_set;
 	unsigned long irq_flags;
 	u32 mru;
+	const struct mhi_sahara_fw_table *sahara_fw;
 };
 
 /**

-- 
2.34.1

