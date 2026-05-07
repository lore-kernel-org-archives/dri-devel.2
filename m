Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B17E3CD3436
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108AB10EF38;
	Thu,  7 May 2026 01:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EXy8xgsR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jBOM4HKK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ABFA10EF35
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:11:06 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646Ln9hv2427834
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:11:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 W/n8lIy6TJAx0t/SbpKSBMWtMGWB6AELaqSTzQbbTRI=; b=EXy8xgsRBbltMzUU
 9/w5mfj709mmiwudJx1TszpPTa986/WfdXQScANdHdhZj8CvRrBrDm5t9YGh0Z+E
 76HNIQvo467oL5ayyhLZ1L4RacGuu5VIn6Z9djmz7H1IudDinwHW3el3D4O3OL8t
 mufFritKotu32BNt2JHdKfDt2RzZdKTBxTgP5ufp9W8DVw1t9sz+lJUP1vb3TaH5
 fn/3UwCyndlvTcn/7intSSjdeFbUV1LVGZdvHxaa/kJUyiOrI7hZPuRNSJ1zP93d
 IN/kFaspDCBZzwhv5Q5kbyO6frRvXetRsVLA/+h62Z1Dl65eXjoS9hmcV1sebb5z
 LlDtuQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph3j92-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:11:05 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50f13da9684so3429681cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116265; x=1778721065;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=W/n8lIy6TJAx0t/SbpKSBMWtMGWB6AELaqSTzQbbTRI=;
 b=jBOM4HKK8aWEXzGqycVuvo6aGNr5mq14Jrqu3b58oZnb9LK5BMTWl/NaRRkg6RhF+f
 KoDdm8grm4qgGFzaOWtOnpF1ff6tOGcunPH5c/K0QU6v1IELa2Fas10VWoWzEj/zF3oS
 r+UbbYz4KY7XhwU/XQaBvqNexgbU8NdTqjeNW3J629bflXAPqDCH3X1CL9/c/CoaYwE3
 gI0B8/394GWg6eAk4p/i8G218KOQA9tP73UKxj8sLovvQBCUVXvKY7IoFaGrq/LgUXyI
 rwEPfP7Ao4FviNRwRYxW4Nik5li76aQ5NIs7nH4OujjVmbe8a5S4YFWbKJgqFXKyS+zt
 gPaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116265; x=1778721065;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=W/n8lIy6TJAx0t/SbpKSBMWtMGWB6AELaqSTzQbbTRI=;
 b=qKp/tmPrTaGShJzpMf+Bbs2lDR4TJ6ReeVTR9ymd9eWMfMBJnMdGENYrWgk78ULKLq
 UdlKnCaLYNX5OMW/42p/DMkq4X9ffs+v4o0pyJDnmWG0vUrS0MYXo/9KT1fLOcfWvOfo
 K5bBcORQJe8wh3tZHNSqNagv3gkjczm12QsOnTXTorLw3g4nGOfDNReD07cXmtbpAmmv
 gJBM2mbARYX4ZpOxALyhT2X3OoEMfq6B/yMxMVu8ewyA6rLnE+RCH4BFEJIc+hvLF0qL
 7bjolfL++A4MlwYrh43LP/e+9/uLsEgm7VD+y/KM0sAQ1tZ8VBFfs10AXNuKoLUAaMPU
 1RgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WDeiZdTMyoAF86pMnofis5Dyljm8ES18vnzqFgKzgicQDiXavjR0zfJOKh7evsAGwIQzqfMSDV7A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YywJi1ExMgpqODbR32EKxpuTJ4zZTl1JPcCL6WxmQbgzRbUoKwV
 lm2P35GfzFtzMGR6hnAQ8uyMftZfw+2eQ2kYiZOVFRvk0FD+UEGfBcJSuI/7eRW5i2rz1o0jtsl
 3cwoWWV1EFz996A/KofNbwcx1/xO0YzvMVBm6WIaoKjuT6LEHhYug2gUwqhWqmZEqC5pXPUg=
X-Gm-Gg: AeBDietSOPXDPXrvnim2B4NE55YbgKKI0KC6nv7pvanzMBIe7dPSHP29ayouv3ywdna
 rCDmjTIclO6XZxgHZnyzXzKEDyQyYEjXDkRK0NLITzUQyNz4tEsPtS+q6zuioAMqypd6dZ9iyOI
 JwHX7nGV0hcr6+MQ7v1tsURvxtvRa50M+TfOJOW0x68UZTWRx/N3y8YtVg966+Y88p2dPx2gVoZ
 hQVDnLZ1rvH7wdF3FOxJyNSGE42HTU7HGC3AXo9bMDTkshA2vxpagw5WiiwB60yinaMqpphAra9
 ZZuTF/f9IryDJvLZ86+17s7Z9MlXKkeU2eNz1JEolKuWE1z7xUEjK8SPJ6kELCHYkZPCVl8RvXH
 2B2LkgRAcYGpvLB9L28aXKHLXFqFH8xM/hXYCIJkm6i9Jz339ft6lexdAiGIWrMauhiFDHGtW8C
 aGWqdALm/n8O8isUyGzxjrgSPnQ3aacRm2//74Weg/Iu2CXHG3+ceXcNjr
X-Received: by 2002:a05:622a:5a9b:b0:50e:6139:492b with SMTP id
 d75a77b69052e-51461c3620dmr77944791cf.23.1778116264681; 
 Wed, 06 May 2026 18:11:04 -0700 (PDT)
X-Received: by 2002:a05:622a:5a9b:b0:50e:6139:492b with SMTP id
 d75a77b69052e-51461c3620dmr77944191cf.23.1778116264100; 
 Wed, 06 May 2026 18:11:04 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.11.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:11:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:46 +0300
Subject: [PATCH v5 7/7] media: iris: drop remnants of UBWC configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-7-e9a3aee53c49@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3291;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/9nEVbBbZylkYnurLYSAS/hZukhtGTEGsaxE9DNa3To=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aVh6IZ+jV2o5J5RH1giNT3lNZ1unZ8Ayvb3
 s7MFeQ5VAOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlQAKCRCLPIo+Aiko
 1QaSB/90X34ni4hJpeXgAwDtXwokYiXk4Qv46OD4sJcnHVYnKzUaWG8aTLWdHZSGoXcn4Na1BiE
 EJmtv4sxv20sxG8H0B5IdBfP6g4dRWr2z3Ot7JdPRDT5Y/pDe5dVaQ5bbDALrpUruyN8Xh0FmSd
 MSc9KjQYKVeI4EmCKbOxrRG19fx/rAJqtP7DRSIMBNxGBRd7Goo7PmN05FKpoGeNq9uYYc6DHLx
 5ajgaJlR6hsdeWo/g/EmKW2m1OMhQG8YRjWRZx08yYolcNBoMO7UvbxGbX8ddQf15zFO1cBFrFy
 g6F0LQ97Nvdni0nFdGahwz8hxdLjofJNWqErd/EWxqgjnQ89
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfXyWPw+YRPZWEJ
 +wKgwZVobBC4myNPdhnFJDdEaDxiQOC8JOxq81wuc52NW8GPRnkne0iLZWKaHuJUgy+xFaPuIPX
 Z99Lc3wyuauZK3Abr49YqyPYANAmI/FuPZK0W0R36bwytTvbPGJClmC1TjeG8xiBIiJZBhFb2Od
 wkvf+Zmcvd4iTQhBvvWVwyl4eZ33RPyErbAe0JG499JIL16ErJa1sgkppd2if8GQArVEzgOcXXW
 /fbVXPZ2EV9Pn9RqUnZeHZYV/KcJrTTidyaq97BZTHLFQGG5NnwJD+gaFtpFaDqCVOR8DdWMw0H
 mAF/X91DUsrhimTdlBoynWQJBUMvj6ulEXq0aYoddNQYZPQcz1vKeHix0pByRZE+x1zssnEy7h+
 xbBBX/h83DyyYUbXihksgMnYSYhwowhZTuPH/JNdfcTUe2xOV8ooSPHg2BVHF7CZgfdB+QTNXdC
 16rWgT/izYVXwV7KTHA==
X-Proofpoint-GUID: -qfiu750HcsbtsbTOnReqb3BWxXIL0fU
X-Proofpoint-ORIG-GUID: -qfiu750HcsbtsbTOnReqb3BWxXIL0fU
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fbe6a9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=0TfDEXg-tPZCovj8PBUA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
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

Now as all UBWC configuration bits were migrated to be used or derived
from the global UBWC platform-specific data, drop the unused struct and
field definitions.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_platform_common.h | 4 ----
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index e8b5446dce76..f42e1798747c 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -75,9 +75,6 @@ struct tz_cp_config {
 	u32 cp_nonpixel_size;
 };
 
-struct ubwc_config_data {
-};
-
 struct platform_inst_caps {
 	u32 min_frame_width;
 	u32 max_frame_width;
@@ -241,7 +238,6 @@ struct iris_platform_data {
 	u32 tz_cp_config_data_size;
 	u32 core_arch;
 	u32 hw_response_timeout;
-	struct ubwc_config_data *ubwc_config;
 	u32 num_vpp_pipe;
 	bool no_aon;
 	u32 max_session_count;
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index 05b1dd11abce..a526b50a1cd3 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -790,9 +790,6 @@ static const char * const sm8550_opp_clk_table[] = {
 	NULL,
 };
 
-static struct ubwc_config_data ubwc_config_sm8550 = {
-};
-
 static const struct tz_cp_config tz_cp_config_sm8550[] = {
 	{
 		.cp_start = 0,
@@ -949,7 +946,6 @@ const struct iris_platform_data sm8550_data = {
 	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
-	.ubwc_config = &ubwc_config_sm8550,
 	.num_vpp_pipe = 4,
 	.max_session_count = 16,
 	.max_core_mbpf = NUM_MBS_8K * 2,
@@ -1054,7 +1050,6 @@ const struct iris_platform_data sm8650_data = {
 	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
-	.ubwc_config = &ubwc_config_sm8550,
 	.num_vpp_pipe = 4,
 	.max_session_count = 16,
 	.max_core_mbpf = NUM_MBS_8K * 2,
@@ -1150,7 +1145,6 @@ const struct iris_platform_data sm8750_data = {
 	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
-	.ubwc_config = &ubwc_config_sm8550,
 	.num_vpp_pipe = 4,
 	.max_session_count = 16,
 	.max_core_mbpf = NUM_MBS_8K * 2,
@@ -1250,7 +1244,6 @@ const struct iris_platform_data qcs8300_data = {
 	.tz_cp_config_data_size = ARRAY_SIZE(tz_cp_config_sm8550),
 	.core_arch = VIDEO_ARCH_LX,
 	.hw_response_timeout = HW_RESPONSE_TIMEOUT_VALUE,
-	.ubwc_config = &ubwc_config_sm8550,
 	.num_vpp_pipe = 2,
 	.max_session_count = 16,
 	.max_core_mbpf = ((4096 * 2176) / 256) * 4,

-- 
2.47.3

