Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B2FCD3436
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 01:10:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA5C010EF25;
	Thu,  7 May 2026 01:10:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmE4suFL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IoyDodzD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B557F10EF16
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 01:10:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646JrAoL1527742
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 01:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bra7g2q0HW951sIO8bL8XJstduNpKmclsTNcEgSH384=; b=HmE4suFL6jSUT4uU
 SudBvpmnnUrwtQyCrnx1DbiC4j3ZJDYAFd/wSw1CunBkmUBoUhLfSJFCoFHiORks
 I7ZjDHliT6G8Sh/S6Zdp5Wt3+tjJuhjmTxJt4/aZgOxKCRYjKJZ92DBXXSgQwtYM
 2y5eVR6gXTUaHOs+HFNgYcc6jvnTPF2KB1eKrqZ9rMQhF9lS3pVWTpfSagsFgEf4
 YwyVeQZel7fEgF7lAvippSK4Y9x4rSojjFyuF+owZZHcN6vMyIAEN1qYJgRW+lsa
 92/wyhwerFzLgNZkORh49XxJJqzwd2/9ImndZSf/mEC6iHbd9Hnc0zeHvPOWknDT
 7C9Fkg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128br34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 01:10:51 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50d84b5f73bso8916091cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 18:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778116251; x=1778721051;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bra7g2q0HW951sIO8bL8XJstduNpKmclsTNcEgSH384=;
 b=IoyDodzDlfVR+SAFBtTlTp4T7AmVlB75BBvp0sV+EAtGKyC5sSSvCgi/xDfI4ny4oE
 J7cFfVYU4/WrkM0rS1XZWp1bUzlD8mRGjmxE0EJ8osxHEQ1DZlWyKghPPRgAeg9VVSen
 WfG7UGdnoRzzSPMPPLHN2EdnN4GSmv3LRFweOsnjInDmhGHxjJvIIo4U+5JWJncGe/LE
 OJcdoyadxY9ZTAIAWlp2mfv2bNAwzGaaXWBxm5uSpWmaM/7/GFJQycJlUQZ6krOkPgEL
 egQZO88jDVXcXpspYCUvGaHYrPxC14KvccZv00WHvlrMKKqe3vDUXXeDABNctWJ92po7
 KtKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778116251; x=1778721051;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bra7g2q0HW951sIO8bL8XJstduNpKmclsTNcEgSH384=;
 b=CQEMFYv8S443WDBuOun4soS2kyYw+sRqdx2VIloOlNdNb4z6CtL2Fv9H00Ucx/Qihv
 tuvbSX2735umXd4NHAeODABiHFF3lgJY8Bgq1R4YOuEMxAQBsO7xDizXaZyYmIVYJSMZ
 8fCUEv2mcDdDk2nlV9PSzOokbqAFKvewWYipfGS3hoai3q1SwW/7tm6snd/73Ig1vVIq
 zJXQbxHGBh4yc5L7nZYlvGcFk55REYcZBACphJSt+g8FHpEONfo3ZiEabIYY5OZ+I0f4
 x8uQYAK6/dq8+HzEvx0Knvhhc3WBy51VCuR4CJU9twAUYwNudSxrMSjEZrOYPrVRFucE
 0NgA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dMdrd5cFFtYwhnGOHSIsw0esCwUn2WMec5uKfNbO01S3Ao1NVkz0u6Kjac5cyeWzw/8J1i1j6Ns8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzgorV0dB8eyS9Pi1IZ2tOpfGEC/NbZpXXtVz1oWN60zJTSz7fV
 Abq/Q8RyAvUQXBdQTqgt4LIlvEQ9klp4Bc0oiN8jZ+5F5k4L2vwdbbcUYh+WS+N6E5jtkRTJLn1
 F4w0z41iRjpW9sWSf9LN92ny0pV8BJJVXC4mCxsRyIqhlPI7Gh9dEpVArsGch3DEWN/o6oms=
X-Gm-Gg: AeBDietJVCAKs2mQZUaoOd5hIv3+gzxBFuXB8uprwr/P+Nik3R643OSjRNnAr4XNkwQ
 o0Bf0HEkKySIciKpyRjf4SykYSa1dMX/DeZKUMfyqSNVJ/m5GzXhq00jSnO0iXzYoiIwkP+byJl
 dBB6KN/IJwq84Ay8m4j2VfIu64z3ZZahMg5cJMfRci4BZDsnZwzP5pkCoYVsRFRgIGi9TJQ4Z8K
 NQ7bO1YVW+otVcgryWmHAj9P24Gx7kxYe2Kkok75xdjdFdj7V8N+Y1JjceSrBFzVAnq2iTrXZiR
 BPn1PSC1dJaIXdQw31YXGofQyAXC/u92tcLIW47QkEQAEIsWvS8KvDmlZuY1FCFDNNJiZV+ecW0
 42+DhLEpgYZ9aSF0Vy9DQNjd7ntM1UHlC2wxvzoHA7h/aZDi2vnyJki3tcbgO5CblqewgVt0JUQ
 XJG66dr7LOXwK9EJwGnvrHno+KROTKxl+Iy01eT7hnYb5vAYEOCeHMvEnA
X-Received: by 2002:ac8:5952:0:b0:509:4198:5468 with SMTP id
 d75a77b69052e-51461c1e10dmr86160281cf.8.1778116251073; 
 Wed, 06 May 2026 18:10:51 -0700 (PDT)
X-Received: by 2002:ac8:5952:0:b0:509:4198:5468 with SMTP id
 d75a77b69052e-51461c1e10dmr86159891cf.8.1778116250603; 
 Wed, 06 May 2026 18:10:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230e00sm5221967e87.29.2026.05.06.18.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 18:10:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 04:10:40 +0300
Subject: [PATCH v5 1/7] media: iris: retrieve UBWC platform configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-iris-ubwc-v5-1-e9a3aee53c49@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3331;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mcq8fy61nNX/KrrW1JUbvq89CB28wRxCq24uyk1o/ls=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp++aUuM5v4RogJfQkV3BmKwBztUcMWiNXUwe+5
 yNCUV+TVLaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafvmlAAKCRCLPIo+Aiko
 1ZWPB/47QjrczU8G247AzlV+ITfriITNk8BpRACt9S6dyVshzhlADn0Mlv2DUXPLylF+7eVQz4F
 1u0MtEydrPxGXo2/76J5J7R/v2opSTw9lc3em85NbyIiv4q3Mw7B1qyxb30DKI4qnH0qJw1snYO
 U/8VlPbI2DOBoKJYMFsQAn1rYasOGMqbpIhq7uQsw3kyfy6nWnZ70bZHW3e0l4Oz2j0Kzv4wqdQ
 aNhLSj2I5KQWfcDrA3x6S6GtKrYOGFQ8f0cZGvtyATTz41J7GY1UaIEtMk4kpiQRb9Zvg2fpNhB
 IE87F20jhPz+D3p1Mqn+ocyEfGcosaW++bdLIflSzST8ErUy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: a6JE3_RLn6b3h3hPC-HSgFIWK3gAeHPa
X-Proofpoint-ORIG-GUID: a6JE3_RLn6b3h3hPC-HSgFIWK3gAeHPa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDAwOSBTYWx0ZWRfXyg0b2cnLqlLG
 oAzWuZaBW3gMD7+eDH2kxI98612jJYwkT0S6XvE6tLthkavKg4DJm6WSlTLVLYIaYBMLvdpLRaM
 QStZcioBzzzvy73EEs8o4kOQZhWfLKFMEqP5L7H0KFKhwvUIBBG2c0vYpXdp3KnLwsruqUNO8BV
 YIAc5ihG2RZ1rpoGBNV/G2DiA6Iil0GYDFFqBD6dm43dcIJqpQjKExbi3KlDhMJZoMTsEb1ivKo
 bGC2HtfO6k16szCSy5MB3iUdJF/S0JjmAQbXwCAYMnhVeV41CfZ2jzQoR9EucQkzdWvNXPwJprm
 DvkPHRh+EZT1gqzwYs16IlP3yQqoDlNFC1iuTcyrn1xdhcePUEFqgyfZXP9yXyLuliJpPsgTaoM
 5R8BC7ObL6uD5Yen1BCsSO7D0Zk6DbscSu+GlsMxgTO8R7bJum9d+dU7WoEnTVDL7aBcmwopvhI
 uklgHD5p2WnUUZBJvrw==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fbe69b cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=KZIT3C-7-F78qrtZtU8A:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070009
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

Specifying UBWC data in each driver doesn't scale and is prone to
errors. Request UBWC data from the central database in preparation to
using it through the rest of the driver.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Tested-by: Wangao Wang <wangao.wang@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/media/platform/qcom/iris/Kconfig      | 1 +
 drivers/media/platform/qcom/iris/iris_core.h  | 4 ++++
 drivers/media/platform/qcom/iris/iris_probe.c | 5 +++++
 3 files changed, 10 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/Kconfig b/drivers/media/platform/qcom/iris/Kconfig
index 3c803a05305a..39b06de6c3e6 100644
--- a/drivers/media/platform/qcom/iris/Kconfig
+++ b/drivers/media/platform/qcom/iris/Kconfig
@@ -5,6 +5,7 @@ config VIDEO_QCOM_IRIS
         select V4L2_MEM2MEM_DEV
         select QCOM_MDT_LOADER if ARCH_QCOM
         select QCOM_SCM
+        select QCOM_UBWC_CONFIG
         select VIDEOBUF2_DMA_CONTIG
         help
           This is a V4L2 driver for Qualcomm iris video accelerator
diff --git a/drivers/media/platform/qcom/iris/iris_core.h b/drivers/media/platform/qcom/iris/iris_core.h
index fb194c967ad4..d10a03aa5685 100644
--- a/drivers/media/platform/qcom/iris/iris_core.h
+++ b/drivers/media/platform/qcom/iris/iris_core.h
@@ -30,6 +30,8 @@ enum domain_type {
 	DECODER	= BIT(1),
 };
 
+struct qcom_ubwc_cfg_data;
+
 /**
  * struct iris_core - holds core parameters valid for all instances
  *
@@ -52,6 +54,7 @@ enum domain_type {
  * @resets: table of iris reset clocks
  * @controller_resets: table of controller reset clocks
  * @iris_platform_data: a structure for platform data
+ * @ubwc_cfg: UBWC configuration for the platform
  * @state: current state of core
  * @iface_q_table_daddr: device address for interface queue table memory
  * @sfr_daddr: device address for SFR (Sub System Failure Reason) register memory
@@ -95,6 +98,7 @@ struct iris_core {
 	struct reset_control_bulk_data		*resets;
 	struct reset_control_bulk_data		*controller_resets;
 	const struct iris_platform_data		*iris_platform_data;
+	const struct qcom_ubwc_cfg_data		*ubwc_cfg;
 	enum iris_core_state			state;
 	dma_addr_t				iface_q_table_daddr;
 	dma_addr_t				sfr_daddr;
diff --git a/drivers/media/platform/qcom/iris/iris_probe.c b/drivers/media/platform/qcom/iris/iris_probe.c
index ddaacda523ec..492f85f518eb 100644
--- a/drivers/media/platform/qcom/iris/iris_probe.c
+++ b/drivers/media/platform/qcom/iris/iris_probe.c
@@ -10,6 +10,7 @@
 #include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
+#include <linux/soc/qcom/ubwc.h>
 
 #include "iris_core.h"
 #include "iris_ctrls.h"
@@ -244,6 +245,10 @@ static int iris_probe(struct platform_device *pdev)
 
 	core->iris_platform_data = of_device_get_match_data(core->dev);
 
+	core->ubwc_cfg = qcom_ubwc_config_get_data();
+	if (IS_ERR(core->ubwc_cfg))
+		return PTR_ERR(core->ubwc_cfg);
+
 	ret = devm_request_threaded_irq(core->dev, core->irq, iris_hfi_isr,
 					iris_hfi_isr_handler, IRQF_TRIGGER_HIGH, "iris", core);
 	if (ret)

-- 
2.47.3

