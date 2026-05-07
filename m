Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F109CD342C
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 974A710EF21;
	Thu,  7 May 2026 01:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="A9f0awT8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HtgRSavj";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3110C10EF26
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:10:55 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646MNHWR3309065
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JXzLPzKJmMMfBleWuh+IFIAqE4Ffe4ls9p1aUztqIUU=; b=A9f0awT8VJX4k5QM
 m3yUA5bje7Z9ipB2kjAFeiwwxBKosM+JNHQRl25xxZChnjoxbj+NjHo82IcbaSXE
 i/o+osF4pBMLrXeisAlb+8RM9QpR4bKC8LROYSSOSB3FMlqyHzSogVjIt+7T6ySv
 NndNk1aI2WXjbtsUtdqQi0W8QY6Jr4d/v6qB+4B68SpkqMNU/erGi6YFICpjKHZR
 ImWFX9uBaLOnMZaD2M93siZ8xE9iON5fraBkBJIVYNDrMNhLnjY84+JyssJ48M5o
 UneUqTOfWfghuonXRJwa8MNgdfQ3WKU9XBkg9M0HBGJ3hJdgfBtjyPtmUNIQ6OXr
 m9/52Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e078sj2x9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:10:54 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eaaf673eb4so94494985a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116253; x=1778721053;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JXzLPzKJmMMfBleWuh+IFIAqE4Ffe4ls9p1aUztqIUU=;
 b=HtgRSavj3QZj4LrhU4uHCo8UHtozTvM/L0XhSFVmZyjF1jSjSfZklr5tcnqEeFI4pY
 ibo1BRNdpYDffe8d8Kp14t8sLt7oG43qGyV3PLnybciV4d84F5IEo0XcUjYudGsIuQxO
 vgMdPpoazYkhQwlrrGAnH8H2feQEgItJhdY1EV4Icv53PZhKKuvCj3HehI08phFMuNCW
 deem2ibbYNeOajmaZHSWcotlGwKBbFINGT5Neoo8DcPR2C/ri3UEIikxVovT8MW4sqFy
 AUh83pwGuURmo4fLSrJ+3kxQihDu/P9A74OUT6ncWfOjpbaWKjK2LVmyFVZ9/UQo7cxn
 fcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116253; x=1778721053;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=JXzLPzKJmMMfBleWuh+IFIAqE4Ffe4ls9p1aUztqIUU=;
 b=eZeJQ6YjG3RTDeAuToYeBC8oUKKu/Os2G8N1itKRzYr5EMe0B610WMPcRGNachiEKB
 v4q43z9090UQecc0Jhj3Yoxn0EbbUGu8jqbKptj6WgJ4F5a8/uobvEjhA3ND/3h1lj/7
 YlLfR1Xwcx3XxDBCO+mJaiisedMKwfEcLkSZdA6TtQCshbAmOj5xUfPnFi7EgXXHGrv/
 66kThnIemFC/iouYlL3+PuRg3eoNszRLTBMuF4u/zB467u4UTfUuLx8w3r4MpV3czVzm
 YtPiKSNv8MMpVSLIKjleuZsbvJF1XrFq4PVnqSqtuAmwQw346Q579sUBfSGNfZxf+REm
 MSfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RZmu0JWQEsltZXt7+DnuXGCZTo2bG/xVIgkFYDLHeWVD1zXDlCvbBHLlWEVZg8mW+MRZTMH9hr8I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ6k/HMKlZzJc6dCfv5rDpnnRAZhibr4FtJ5AZ2RTwPweUC/RX
 dKK9UGLKfOhyeBXgTjfKlOnQArRREsZOreKa7PtHfN4n6U9nOkpKA4o1RYN6YlqIy3XU+XeKk7v
 vGgdJoVJD698C1EEU152AAKjkXg9i7r07h8k6cO/0dvZDOX83MAd/6BGKisDz0Vdi79qPYOs=
X-Gm-Gg: AeBDieu8JrS7/rSKveVRU5dq5De3zE7XTWYZ1qOsub7HLEP6vAGmGyrmidY2WRqiAzb
 Fib4KKsyUBWk/G8E168G1J5DVpKlDYO1urVlcoRitDuWcH/HQF74O5ocEQAxJ9ABUQphduRkQbE
 Q+ynXXLZzQhQwnGt97ehrjYc0uA+lFv/mltFoofvuuNirKGRTyw+bitWfXAJ7VuXZg0VRyHreA6
 ws4gVYMwnAyQcZ53OtDE/o3c1ldwbYYgKKRynux6v2nLx5CfsuXUE7iZ7BYgllVnr807IQ74iZ1
 ykUCTWUYIMxVhkMOi32nNB2fj4m1tHsnRXDdqoTa3cfKUZFRYWomZgHRIItbWUfeL9wcl0LZx72
 WC2bxRgkvXxum2RPnPUAW62LqeZrLhSuOGXn3fsW7wnuOrKmbvq3upFQ9SdWj6FsDBw9mWirot2
 v4Ur2F4aOxTWVsYw+WTfjBFkxMqDiCdTpUl7rAPy6w4zVIWw==
X-Received: by 2002:a05:620a:4455:b0:8cd:c0b6:87f7 with SMTP id
 af79cd13be357-904d68db2bdmr902368585a.46.1778116253377; 
 Wed, 06 May 2026 18:10:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4455:b0:8cd:c0b6:87f7 with SMTP id
 af79cd13be357-904d68db2bdmr902362885a.46.1778116252824; 
 Wed, 06 May 2026 18:10:52 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:41 +0300
Subject: [PATCH v5 2/7] media: iris: don't specify min_acc_length in the
 source code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-2-e9a3aee53c49@oss.qualcomm.com>
References: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
In-Reply-To: <20260507-iris-ubwc-v5-0-e9a3aee53c49@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
 Bryan O'Donoghue <bod@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-media@vger.kernel.org, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Wangao Wang <wangao.wang@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3117;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vCjp6Otef/xE5vbuvwNoduQVTq2eHsexFqb6kzgabfE=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aUwStBP0KISULKId+sYvvMoEbkTcp0zpSJy
 8v4NGsGDxCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlAAKCRCLPIo+Aiko
 1Z/dB/46Ju/VYuPxTbeC2ZusqZ6QR4CkkUQN6vmmN9PRqyP7wbEiYIg0LHqvd5X1nnnLioUcxFE
 VcdyLvSlozvh9PxrG2EcozCgAlQS/asjo7ICWmmhOuJn0lfuwCHMZZTHvkaEf0eSPchuQVvnpv3
 lubrzIMV9yLsXTM3TQ4HOCv2R327Yx4TdgRKQs3TS47s3krjFLIorw/VcLHN10qPW+kb8jLoEQd
 xFf6oPs+J40B/Lhsv13fwq0gTSOjh9KB4IztHJdIf0VGh0YIIdaPe3dmYlvq1IIniBKypwCX3Hl
 g+99CYfaA1EKr8fHJnPwoE3KdWJGnjW4TxK4Uu7+9Cb/Eq0f
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=Lc8MLDfi c=1 sm=1 tr=0 ts=69fbe69e cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=qS6nuPEoivtXufaKKhMA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfXyx6cgWto8fR3
 2TkHBAvzitgfV0n5kjcwES7IEw+7r+qO2muiGopghTrRrkVnOZJxp/pG9DZHNsQXJiDBoEPFgPG
 lUoa9kfwlqx7nCgVh6u7/iBu0GlmHmEzcaaLPshwXpy7r/Z/xG5CXdqDHV5Jt9JZ/YZcWPIvq+d
 jnI+O2WDBKKyN78BfgatOcH69P4vUb7i1e8DXhxhINjV3PHS93WOwWTghQDsDDwyBm2xyWHWo56
 ZTbKcqt7UTeDr5fXCaJwodutBkn5K9klM8/a19E/yD8wPAHvJNoxoM8ibUQLy/Uv3yRYAzJeRgj
 kLVt0S2qfC6aYT/bDfkpj38yFLtZ13KkAdzWlqEm6qzZdoaG44IJT3riiWe+gZvyGjcyPSLDEnn
 u10WBAbS0rdI8zmAmnhwmli9DNmQplJgUQqkIzReYZamm96+QrBbtXREXcdNnZ9PgCFvMyls89Z
 JQEAXMsawFN+dgtHUow==
X-Proofpoint-ORIG-GUID: ONojeOVSVki5hFSRVG9aoOVTdcddbuKd
X-Proofpoint-GUID: ONojeOVSVki5hFSRVG9aoOVTdcddbuKd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070009
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

The min_acc length can be calculated from the platform UBWC
configuration. Use the freshly introduced helper and calculate min_acc
length based on the platform UBWC configuration instead of specifying it
directly in the source.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c | 6 +++++-
 drivers/media/platform/qcom/iris/iris_platform_common.h | 1 -
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   | 1 -
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
index d77fa29f44fc..aa4520b27739 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
@@ -3,6 +3,9 @@
  * Copyright (c) 2022-2024 Qualcomm Innovation Center, Inc. All rights reserved.
  */
 
+#include <linux/printk.h>
+#include <linux/soc/qcom/ubwc.h>
+
 #include "iris_hfi_common.h"
 #include "iris_hfi_gen2.h"
 #include "iris_hfi_gen2_packet.h"
@@ -120,6 +123,7 @@ static void iris_hfi_gen2_create_packet(struct iris_hfi_header *hdr, u32 pkt_typ
 
 void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_header *hdr)
 {
+	const struct qcom_ubwc_cfg_data *ubwc = core->ubwc_cfg;
 	u32 payload = 0;
 
 	iris_hfi_gen2_create_header(hdr, 0, core->header_id++);
@@ -146,7 +150,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->mal_length;
+	payload = qcom_ubwc_min_acc_length_64b(ubwc) ? 64 : 32;
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_MAL_LENGTH,
 				    HFI_HOST_FLAGS_NONE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5a489917580e..08a9529e599b 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -77,7 +77,6 @@ struct tz_cp_config {
 
 struct ubwc_config_data {
 	u32	max_channels;
-	u32	mal_length;
 	u32	highest_bank_bit;
 	u32	bank_swzl_level;
 	u32	bank_swz2_level;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 5da90d47f9c6..01c6ffa7e084 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -792,7 +792,6 @@ static const char * const sm8550_opp_clk_table[] = {
 
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
-	.mal_length = 32,
 	.highest_bank_bit = 16,
 	.bank_swzl_level = 0,
 	.bank_swz2_level = 1,

-- 
2.47.3

