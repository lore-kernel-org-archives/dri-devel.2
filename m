Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D81FCD3436
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:11:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBA5910EF2D;
	Thu,  7 May 2026 01:11:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePfdtdGx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hhVf7P1u";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D832610EF2B
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:10:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646KNWUb3036649
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SyQqdK9jmZKeNVXJQVvQIDZmFlPQgBoBYfDnZTubWOk=; b=ePfdtdGxMCS0JA5F
 yx5WxhNux3TR9r0AQrHStgqnf8SJUpCajgzo0j8nC6RkeQi4BRjb0fm3sV4neEVh
 jf82vWR9/sDIZf7HnUWzJOszkj6pfbIOrCRAGMVGwQg/g58yQJDWXZb6/MKerjpg
 ZKRdW71d3AFk+7ywimcdPQ3Yh0r2WzGZOs102fMxoJDhHNHELc97UwUXU7ucdZi0
 8Hf732ha9b0cYuHsr96v0H2mvLFplY8bg0jc7QeToskH2bNWzyBRu6qAxQdbovfn
 WiL8NXgX9R1KnqpakuTY2Nr/K3mqKyRVPQDE0dcJs9RukNOIKde/+AXnB+XndQmT
 /0acGg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e05bf2kn0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:10:58 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d8ed08aa4so8681681cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116258; x=1778721058;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SyQqdK9jmZKeNVXJQVvQIDZmFlPQgBoBYfDnZTubWOk=;
 b=hhVf7P1uh4xCZGt7LVEUrM/P/YjV/4szsbiVrzyRF2ilTQ4ggBh/wXpbn+87MH8jvc
 PMZQC2M/FDBLColILWXpTQB11cCLV74wnjK1OJibjtTHxrguvvcd8GyVoK7v4PCopVRM
 I8leC0Nn1OJRZbWbJJSwfFPE0lLzhS4QZjZzImBlxiSvsoDY/C1tEyTkwEXCOH5nTmWO
 wF0HrzZJkFGRmXzsefPk8zFjGK38E1jCHdr3cIg+SC+Funqt6l3PAD1swIFg988wfCG3
 liYujZo3R6JELoVrrqeqyVdWVxCEFv6G7CfjlQqinLioSGZpk8EQJfcwfp9bJi74FnDi
 aAyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116258; x=1778721058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SyQqdK9jmZKeNVXJQVvQIDZmFlPQgBoBYfDnZTubWOk=;
 b=q1ovqk7qYDvVOMjTZLoIfjPlowog1YJYsjwS1i6Bjnyh+WRjXFfuilVz94tJdvwz1Q
 R0FyerVbmxx0Aop+vDzlerSaxWpx3lBotN+XOLUm0n7NMOSBp7YedOAm6LtDJJCmBtvt
 EQ4uofhNJZbJuJR0aGV96yj4OrBe7oZFdVJMmpAqBaQP0rQR/R1IOWR3z++yccm2GtD5
 K41pOX4MQ65EOn4jnZQPvLB3T6FlzX7JKNiMXjnCk6h/k+FapN9rx3GippzULQ3QKA8Q
 IS8FEEsA18Dn3h2LgDN+xhRyuYNq1CfY2mrObsWFYVeoGGa3UHSPcJNvz4SNrenMC5X7
 Ez3w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Cj86IYdMpdk/gjOjSmjL1PoHVOG+mp78DgSX9OERnJVM1nXD5gy3A2X5Ct5npLeI/fRlIlc6FOq8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/2CZHpRyG+sOWnWRwFl2qH0qnIofS7MHP9fo2haYzcENiGY13
 lvqOTi99ONE98B1A0WyHERdMl2Lmkov4hMGGK6Z05Quf/WcbRrRpv41j65zFgDv+Hm88WjGzGJ3
 GXOU2Z9QVtClCgBJ0HuArHVKnEaAdu7brI3bBQ9HYMWcMWPVrDUvXAPJrbxWRuq6d1IxMJg45Jl
 f0yOo=
X-Gm-Gg: AeBDies4gUcDdNIGeiArcHN+gAGZhLUYsQnyDA7hgjpznTv7gxGrI7SjWi5RwtEaiXR
 MeRv5M7mOzLpkf0iChInq8BWYPdYgwxxohHi7cXWffkEJkcs1i9m78c2LzQxLbVlBO8hI4Epml5
 NfOTH4kE8Kh8t+m04uo0Xn7uRznPXylw2Sp6dhcKnVDyVc6/HaiBBrNapMFo6qzN7ZG+n1F9nTC
 t7TG0i13EdzUP1bB/97x9g20uBseebfoXjtwKsON5d8YApcWcpvJUMjMFN7pYGGAhqfaP1cA+B0
 4IyiYkkggzJp2VrstChRYI5B3EgloOhuJYBoelWzyj/659NM2lNXAU70i8yzFISb6tlo2G7iiwU
 RkhscKhHmM3t4RTGcL9oCEGHJ8MTj2iQcGC6UIG5biFJy3we9rfz0ghY/9rDd7oSHMvQK8K6SRM
 FcUm7bk8eIBL0d8FqkPizMbeNMek6NIL3NacnyYNgXOQ7Xmg==
X-Received: by 2002:a05:622a:8c3:b0:50e:5f71:62c3 with SMTP id
 d75a77b69052e-514621dffb4mr72549811cf.42.1778116257872; 
 Wed, 06 May 2026 18:10:57 -0700 (PDT)
X-Received: by 2002:a05:622a:8c3:b0:50e:5f71:62c3 with SMTP id
 d75a77b69052e-514621dffb4mr72549571cf.42.1778116257381; 
 Wed, 06 May 2026 18:10:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:55 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:43 +0300
Subject: [PATCH v5 4/7] media: iris: don't specify ubwc_swizzle in the
 source code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-4-e9a3aee53c49@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3286;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=I0GJCkT+M6rzwScGE2nHMtdPm0YonKxq+nwx5NI6V5w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aUre/t8KcqA8iF+dzqb+jfk/P8fCGpcHh7W
 c5lxfHndMuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlAAKCRCLPIo+Aiko
 1UoYB/41Mkd8BxBKnEtCaBmmwKRaMk4FvBk76Ws1YkAM3GZrAKe0YKnb/jjPIlYaH4GpR2e7wCN
 ixdSauHYdi4wtG4DvNdbgZkamw85A+9na54K8GHb1GUMfGRY6xcMCkncYQMuBT5UViYaJbuUGex
 ihdOveqy8QvS+aYovcZEgGtOi1MR3NuoUYpM4Xzeku1DAR9IbdBSn4Xj0bnTcI3L67jxLbHsUeA
 6yT/FtTn/iWyQHimRgjxs3JXY+a8OWpC7rCnQ1kXz/aXZk02k6IHjPnCci3csjR7jZCTBawMuBj
 oBPNIBwYKCj2Nu+nTLRrnLg7YEcnH68dwwc7qLkvxpnl5r2L
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfX1kmmzW80+/hG
 f7ACc6UG2bdYxa44jQ7aK1LDcicSe2z3AmPcfxbXc298W8hORAK8ALjw4AnDtcJk3TOMMSwwM4S
 WRxWvl0LqNFDr91aoR6ZMGAmuve1mR02G5hcCpKF1gkFYYEeRb7pce6xBBmLCeWtAlOfl3KFhEU
 wCRacyp6B/idie+CjvyXcPQVDSA9WThkDj3eNuqkI/9VwsTUp+nc+G+x8qQEvoo60FNJTYHBLI2
 BOD2MNrnn4tP5gp2q61wYDFKYfziMHNOTtaaRmnu8X0jgP8buh68LKSJkzrw+G68WU2RnS6EHem
 TCI+bDlWVcsYODnK+0NnDMIPSEvR1qrpasMzfAfzyDXg/o2KiP7pe+VzKed0BDM/dPiplKkxJY1
 2+D5TirOKFW4ZmcM1K0jrO7ox9rFt9n4lzbk+4UMDNUmkyXDHAXzYubuOB+/fkUWGnmgAA5x7mq
 6G4XO0a2PCPSe/3WA+g==
X-Authority-Analysis: v=2.4 cv=PqmjqQM3 c=1 sm=1 tr=0 ts=69fbe6a2 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=KKAkSRfTAAAA:8 a=4H5-pPW84uT1T8hsIVgA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: ivDyLuwxQqSbIDIY7AJp2bPwQV-_13W4
X-Proofpoint-ORIG-GUID: ivDyLuwxQqSbIDIY7AJp2bPwQV-_13W4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
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

The UBWC swizzle is specified both in the Iris driver and in the
platform UBWC config. Use the platform UBWC configuration instead of
specifying it directly in the source.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c | 6 +++---
 drivers/media/platform/qcom/iris/iris_platform_common.h | 3 ---
 drivers/media/platform/qcom/iris/iris_platform_gen2.c   | 3 ---
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
index 6dc0cbaa9c19..a4d9efdbb43b 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen2_packet.c
@@ -170,7 +170,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->bank_swzl_level;
+	payload = !!(qcom_ubwc_swizzle(ubwc) & UBWC_SWIZZLE_ENABLE_LVL1);
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_BANK_SWZL_LEVEL1,
 				    HFI_HOST_FLAGS_NONE,
@@ -180,7 +180,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->bank_swz2_level;
+	payload = !!(qcom_ubwc_swizzle(ubwc) & UBWC_SWIZZLE_ENABLE_LVL2);
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_BANK_SWZL_LEVEL2,
 				    HFI_HOST_FLAGS_NONE,
@@ -190,7 +190,7 @@ void iris_hfi_gen2_packet_sys_init(struct iris_core *core, struct iris_hfi_heade
 				    &payload,
 				    sizeof(u32));
 
-	payload = core->iris_platform_data->ubwc_config->bank_swz3_level;
+	payload = !!(qcom_ubwc_swizzle(ubwc) & UBWC_SWIZZLE_ENABLE_LVL3);
 	iris_hfi_gen2_create_packet(hdr,
 				    HFI_PROP_UBWC_BANK_SWZL_LEVEL3,
 				    HFI_HOST_FLAGS_NONE,
diff --git a/drivers/media/platform/qcom/iris/iris_platform_common.h b/drivers/media/platform/qcom/iris/iris_platform_common.h
index 5639eb5a75b6..e217f15ef028 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_common.h
+++ b/drivers/media/platform/qcom/iris/iris_platform_common.h
@@ -77,9 +77,6 @@ struct tz_cp_config {
 
 struct ubwc_config_data {
 	u32	max_channels;
-	u32	bank_swzl_level;
-	u32	bank_swz2_level;
-	u32	bank_swz3_level;
 	u32	bank_spreading;
 };
 
diff --git a/drivers/media/platform/qcom/iris/iris_platform_gen2.c b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
index bdeb92e0b7bc..8072f430bd26 100644
--- a/drivers/media/platform/qcom/iris/iris_platform_gen2.c
+++ b/drivers/media/platform/qcom/iris/iris_platform_gen2.c
@@ -792,9 +792,6 @@ static const char * const sm8550_opp_clk_table[] = {
 
 static struct ubwc_config_data ubwc_config_sm8550 = {
 	.max_channels = 8,
-	.bank_swzl_level = 0,
-	.bank_swz2_level = 1,
-	.bank_swz3_level = 1,
 	.bank_spreading = 1,
 };
 

-- 
2.47.3

