Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DB751075262
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0394110E86A;
	Thu, 19 Mar 2026 06:32:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GiVy1Vmx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NBRxnGzD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2073610E868
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:11 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5XX983171737
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qq0/fBoVIDcZl7c9idmvD5vhhJIbEk2C9ivXkYLSvdo=; b=GiVy1VmxXUBWGMVw
 rhBiReMM+VZlAF5Etd/nwMhrISpyo4tFZD26N2zTt4WQltNJOYewDgkfCQyjYiF7
 Dj6yC/Z6vNnG7c19WCxdYeb0ydErGZgWfT7gFZ49NrGIi/+BhF8RB9yljIzMmgl5
 8Hg0N/mUpIY85mlUM1/bjndxLwsHDEflDIELwmqB9eKSpzazjuyQ2GN+f9nflL2l
 XCxP+xzxwZfwPd5SBI6SwlEQCS+w1atfye01pJpCe1xwmkTh2DCaU7QxmjIR/Shk
 DA/VwLsZiEWBOk9gyN1UySyCxS+JK3zEzFCn5P+TZSPpCc3qPAtKuVr/lpik7Bqp
 QYM9Pw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d00f9j1uj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2aecfe69196so4717095ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901929; x=1774506729;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qq0/fBoVIDcZl7c9idmvD5vhhJIbEk2C9ivXkYLSvdo=;
 b=NBRxnGzDckKv9UmYxxUA4Rsod2BS0Cc0BMiJCny/hoB0Mgj2FafzX4X0KcN9+6+x/n
 VfkQuT1LV7RAh4Fk0k9DgLQ62h7R8DwhseQOSPQA9yCw9Idf6jbxVm+nt0xuYlsFBZud
 u9XDgfQCglJaH9ADOqPc1td/gsbr58TRTU6iy0sQYoUaJ5yx+WGNeaaFlan9Ptei4NRR
 PFy7r98Uudai5qZpKazrEXBsooP0HuioETEYsfIHaz6DciXEtNGlZWaRBKYhLCGa0oUU
 vHxp8wRsucyKHGGm06MiabpWlVgBzr34YY7DGWH0gKzNKQPL0o4SzN9J+1dL5BXvU2km
 /utg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901929; x=1774506729;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qq0/fBoVIDcZl7c9idmvD5vhhJIbEk2C9ivXkYLSvdo=;
 b=hgGXT/qrRhzWKUSAoPFaHca6mxVkyUOemwKDKTnPRo92qi6aUZh9DsPbKsvtGvL3L1
 tkKkW5t4HfvogNtwmDBYG5CCE37+23FqOqmFeNcBuNoHLphBIDG0rdsCmY4Dg2U/07II
 /Y9eijvGL4CDZxMw8og27F/secoTF9oeD+dnxjmgT+hCV8k+imAvDJeDg9UQhNalQMaK
 I7nFXTmswSOV5SP+/4MiL0L1brzUUU0TuBUxlFGwczsIAd57mSZlB4d/0/JYDVDOEYuM
 lt3jKroNwxHGajNbZUSZWREzGWKnqPt1/AX8JK9P37YQD4S+Z5TCWYTtoltIrSCZV0Dl
 uiZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnzqwJH2tIU5Gg2BIISxdFgz3F3njkKqCduG9J0Xz2hFWQn1kHggjfJw1MCYU3+ljZlLUtkA3iank=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtbsaH7PIxfCaeCPV2Ai4l0aFIEcWxg3mOJ6uLEkz75NzDyTk/
 brmkmKhYCb0TpzgAlkWua2Zc5+U+k7XG3BGIXNzLSCCJiaRDIy18NWZ7UL9EIP4Bb+bZqrVMAnG
 NfZKoQFeMNI3qV6bEDfSxWdUlyhgbxLomMd9KWOgpIa+XUZeF2qgJwhw8zhprRZfhBzKKuVY=
X-Gm-Gg: ATEYQzw6gfgXgY19AetCBGB5qh21z/QuESfipCWy15oWNop1deE35pZZQcGvaPdNiZC
 NZJ57GIqgLXJL3guUDnB4AiZKQCWZqmagO0+iwhY6qxQrxMBu853A8PL78aTbvNMp1nAaNbDRX/
 6Q741pL2vw41qkVzgBITVL4rDVeq5f0b/MQGXwVzLa/mWXNI8zPU6e9F12A/lMJl0cTDwW+fHo2
 rnFqsc4ilAVm95AgRLoGCkP3ryI2sCzqPlimC+disCwPS4ZBVqBwfQtR57ediVo5Nj2Vas96UsU
 KUlV+PlXipPDsGvTXGhFdBoSix4e1hy1R3k6IvGybQfKT1E3aVopLUKC5LVdeVJVp8KwnP1gBFS
 FH4IgmJ8p2xYL8WZvRvMUv4lTAh6HGeN0neXBPgenYLp3KSZujiA=
X-Received: by 2002:a17:902:f705:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b06e35b4demr63812585ad.16.1773901929108; 
 Wed, 18 Mar 2026 23:32:09 -0700 (PDT)
X-Received: by 2002:a17:902:f705:b0:2b0:5d60:7f3f with SMTP id
 d9443c01a7336-2b06e35b4demr63812295ad.16.1773901928598; 
 Wed, 18 Mar 2026 23:32:08 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:32:08 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:45 +0530
Subject: [PATCH v4 5/9] bus: mhi: Add QDU100 variant and image_id firmware
 fallback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-5-47ad79308762@oss.qualcomm.com>
References: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
In-Reply-To: <20260319-sahara_protocol_new_v2-v4-0-47ad79308762@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, andersson@kernel.org
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=5038;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=9iJZxHKj6ceRf6SQQXFuF0UcjhRsGt64qimhRUDtN+M=;
 b=/wsjS4Mb50XnI6cIGT6SBvW/dCirIKCjrFdPrSRkNy9DwEoc48RM2a7D6ERQqxMoFRMNyY6GT
 nS7kxdbRRAfB1mI2EAuRyKzKX0ZxgWz0uvulhmpiwIc51noTnTYm9+I
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfXz5/P/xQTrTkT
 Kxa1I50eoFZqckKHwcn3UsZLIoYGsKbYBDuj6OzoT7WE0WM25xQe8os7d41p/99O3S+jjsOzfoK
 ly7mn4hxwqxJtCcZdV7kH6BFieJnsBA27a5LJyiTczx9yC/OGTRZh2jxgmwBLw6DHpAlxuW34LK
 2wfy2Kvlifefk0AdtDGGjSGJUIPpeLU4w4R4fPbl1A5izfDUwnc+OEISmvorQecdWus7aTrP8kh
 mWejBea03y3dXpVzU5CH5GaUQKKKUQBRGXm5yv1ZH0GjlsJK/OgL3cNH4dXkHWcYUhuiAvjDhAc
 3h+D5iM0upC8jFcUE8TkqiqpTcU/Z8xLothm3T1jEO0+8bzXiKs4CEx7wi7hPQaHU96fHYTw44J
 YLJopSbhBWyqU6db5rn93jnxXnx4Ckf6/vFXjX8JJ2YL4C7A9L2ekvnvC6KKVQtK5wKAd+CwwNZ
 1+vTHYP/NDLfnUk4gBA==
X-Proofpoint-GUID: LkbhxEIZWn4xlkK8LQvR8VOsTGrfo_IE
X-Proofpoint-ORIG-GUID: LkbhxEIZWn4xlkK8LQvR8VOsTGrfo_IE
X-Authority-Analysis: v=2.4 cv=MJttWcZl c=1 sm=1 tr=0 ts=69bb986a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=g53SEPjKJ_zQRiRrflAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190049
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

Extend the probe-time variant selection to match the SAHARA MHI channel
and associate it with the QDU100 firmware folder. Add an image_id based
firmware lookup fallback for cases where an image does not have an explicit
table entry. This allows required images to be provisioned by the platform
without requiring device specific client drivers or additional registration
mechanisms.

This change only affects devices matched on the SAHARA channel and does not
change behavior for existing AIC100 and AIC200 devices.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/sahara/sahara.c | 77 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
index 8f1c0d72066c0cf80c09d78bfc51df2e482133b9..4ea14c57774f51a778289d7409372a6ab21fea60 100644
--- a/drivers/bus/mhi/sahara/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -234,6 +234,36 @@ static const char * const aic200_image_table[] = {
 	[78] = "qcom/aic200/pvs.bin",
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
 static const struct sahara_variant sahara_variants[] = {
 	{
 		.match = "AIC100",
@@ -250,6 +280,14 @@ static const struct sahara_variant sahara_variants[] = {
 		.table_size = ARRAY_SIZE(aic200_image_table),
 		.fw_folder = "aic200",
 		.non_streaming = false,
+	},
+	{
+		.match = "SAHARA",
+		.match_is_chan = true,
+		.image_table = qdu100_image_table,
+		.table_size = ARRAY_SIZE(qdu100_image_table),
+		.fw_folder = "qdu100",
+		.non_streaming = false,
 	}
 };
 
@@ -278,8 +316,21 @@ static const struct sahara_variant *sahara_select_variant(struct mhi_device *mhi
 	return NULL;
 }
 
+static int sahara_request_fw(struct sahara_context *context, const char *path)
+{
+	int ret;
+
+	ret = firmware_request_nowarn(&context->firmware, path,
+				      &context->mhi_dev->dev);
+	if (ret)
+		dev_dbg(&context->mhi_dev->dev,
+			"Request for file %s failed %d\n", path, ret);
+	return ret;
+}
+
 static int sahara_find_image(struct sahara_context *context, u32 image_id)
 {
+	char *fw_path;
 	int ret;
 
 	if (image_id == context->active_image_id)
@@ -292,8 +343,26 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
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
+		fw_path = kasprintf(GFP_KERNEL, "qcom/%s/image_%u.elf",
+				    context->fw_folder, image_id);
+		if (!fw_path)
+			return -ENOMEM;
+
+		ret = sahara_request_fw(context, fw_path);
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
@@ -301,9 +370,7 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
 	 * Only the device knows. Suppress error messages that could suggest an
 	 * a problem when we were actually able to continue.
 	 */
-	ret = firmware_request_nowarn(&context->firmware,
-				      context->image_table[image_id],
-				      &context->mhi_dev->dev);
+	ret = sahara_request_fw(context, context->image_table[image_id]);
 	if (ret) {
 		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
 			image_id, context->image_table[image_id], ret);

-- 
2.34.1

