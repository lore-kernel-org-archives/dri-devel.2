Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AB0BF8D74B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:10:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7204910E8C9;
	Thu, 16 Apr 2026 14:10:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXJghhS5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GQcjj5sk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68F8910E8C9
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63G8Pu4m862169
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=; b=NXJghhS5Y94uTiXh
 vlaoOzTtkgnGrV/O/geMhThLlUVMw8E1bxPcKsZvAgXcoJPChVCz3IMqMo0wbfE0
 EySpjaAInNHKjpobrxamxOBMsbIdPCRSMh9oBk+C9LG0vhofKInNpjITY+Qz1Bay
 FreF+ohwj+wyWwe407n7DgHPNivediP6JqFGifIDQKMkeSBXKSqQF9a2nTgBbuGt
 IcqjyXefR6/DkUFclSaMwi963/nxTlVxtzidNvIrc6xVBozHmQ15fbmh6guJaUs1
 aIBR/WSgiF7tWlYcfW88XNVmR3grySvdTGisYgZmZTcydd71Lu1yVf9FzgX8GAdM
 kUtt6A==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4djd0ec6ev-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:10:24 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-651c15e69d7so10556389d50.0
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776348624; x=1776953424;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=;
 b=GQcjj5skhUqwslVxJn8Lm21N1Ye/BtSdrUyQWIfxx+tbF2R3PZJflM6zly8nFdfG0s
 UzJuxlgmPjclCYPCfwFUCqv7dwiBkwHTtCg/NKVyBtJ2Fr5Tv2mR8gnklqLPveFltcn1
 PhoTfqjUFogz/27G/jkO8InmK8TNzvM7lz2QQAdjMyDGSqLNmLNd+kI3eYJiMRnriYqN
 JAq0KNgUpLnd/ztyofmbQzR/1s3QQR9tniqo+wwKmmGxub3/JEnAXeGZyZOCekjE3sU7
 BEMnR3Cj3AbRlaipVNz4qRX+MXX6xswY9Of1VkvgXQ4SDKCcSg9quXkT/uwwjdMZY9vJ
 ZsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776348624; x=1776953424;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=;
 b=BBemLLk+kG42drxhICvWmmToQbr+uIaufYsksKVCcMjnwP0PJXyn/ebkNYY9NgQ0Kq
 SQb7Oupf2ksva4oST9HI/QIiLzpnf/IymJ1sRr52QHEd+bq4nmUGanBUj00+Qq2zyG2R
 7B/fZz9d4maZ8XxHyXJFcvduW1iO+CSXgOmI6LcHncYPUHTbwuFUzu1io1GoRuN62SJT
 p0lmPCEoFCTepknMSkxuZVstC8Wi9GDn8+9Q1s8AgWCNYd8zRoSGF5Nkr7tyNXFagq/W
 85gcS9bu5hqT3lFnkmLCM7D/PtEtMXWLckyEMgoLS4hQNB+OBPPs9LkrdrXhRSl+/+xn
 FGGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8J9VjE8xqbT7ErqZCxQL+hB7DxekTXLBUmg7AF/fu4MJ0WGaXYxf44oJruXusm5xfWbImV4GL5SpY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxoIfhqrMsThkbhcJBl+MSaIys1fSPCftx/4j/YVBJzfrbZodfz
 I6r7ZdeK/KpdSWlE+mIbMLIEEm6STDPwWSRiT1DpBZeg+qnCqHQWhez5QsMsgJ/b0/EoVpplDdl
 j04V9aM89vCn/fVnja6yvnCrmn3fAMMRn2tafsFCZQ1BRm6sx+KF8xax7rthPpB2F3+1rjC0=
X-Gm-Gg: AeBDieuQIpvzBKS7swryAjI4+OyMDUciFlob250BvQRIQdc5B/OPBN0MwnUe9/kOSTw
 IxBu/HI33byBasZIvxun/rr7cYT6vCBBaMem19GfarVek7g50rodaYnbEexTtNluKafdiI9MPe+
 qA49rohjkQ7gPuFfAzGuBldzpJR15PusFo6R9fq3nGJHfsXfaBAjKCxmF5eK1WVmKbbid635pY6
 EVOOjBiJKNZEeV3wwKU9VDhATM4fPdJTgntVMjp28Kt6CyaZXLKrQcapss3hyI4/4Fsb4rSzpo+
 VRmuj+BmEwTQ6v2Gl553UovLAKNp+bcTwqr6B562i1SRLo5W6af6C31r4IDzVDJkWCXVxjaxsPV
 5qBFbifx1+Tea9ZJfPSdJBgRkJLVZSYGPVsWIo0ykXk9Aa+L7XWk=
X-Received: by 2002:a53:b6ce:0:b0:650:7846:f326 with SMTP id
 956f58d0204a3-65198bb5341mr17653927d50.51.1776348623052; 
 Thu, 16 Apr 2026 07:10:23 -0700 (PDT)
X-Received: by 2002:a53:b6ce:0:b0:650:7846:f326 with SMTP id
 956f58d0204a3-65198bb5341mr17653845d50.51.1776348621719; 
 Thu, 16 Apr 2026 07:10:21 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-652e47ba4a3sm2084691d50.17.2026.04.16.07.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 07:10:21 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 16 Apr 2026 19:39:46 +0530
Subject: [PATCH v5 5/7] bus: mhi: Load DDR training data using device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-sahara_protocol_new_v2-v5-5-6aebf005e4ba@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776348592; l=2770;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=Ai7Oj6HYo2DVpdnuStjVjQuKPI6ELc1HNULGnu45Dq0=;
 b=WWlNVMISE32YzOacAObQV7dNIdXlO1BGZ6LObollUK2JIrhEPezGqcUbkpsBTUSpn3s2vLrDp
 UNhQYOZM7PhB+Q1nzHDwRgrwZHLL44tf02jQlSCFTctKmH9zRJSHFeq
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: li7muh_ZSklTl7CSaU8HJij6B3gJ1KZp
X-Proofpoint-ORIG-GUID: li7muh_ZSklTl7CSaU8HJij6B3gJ1KZp
X-Authority-Analysis: v=2.4 cv=GP441ONK c=1 sm=1 tr=0 ts=69e0edd0 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=ICgrKnnyuXbdZ-Zkjz4A:9 a=QEXdDO2ut3YA:10
 a=Epx66wHExT0cjJnnR-oj:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDEzNSBTYWx0ZWRfX5/tpu3H+k726
 uuVsbjSUiKMDdR/+xrNgkcPUQbsgaBTRVS002bCbGETwp9yoJOntp4tZrwYpr0z7NRcRntbqm/G
 tLgH/sdi2XRjf6B7n9DLjQRlXqW2vY7+L0QiXn5LXSIg2JpnSwskQ8mTtzX6xZDu9rvxnWjLqOO
 E26z28of1m7bysIF2Q5NSiL9O9dcR0M2ODLtBl013uj7rDoOg0Ta0CQaYQGkhYrH3TN09fFdY8J
 P7ESr6b2Q9/rC78aBkPQ3qbUFj49xaYFsVq0f//bUMtHais33t8LOJRSUDa2FbykL0445zWczEC
 seUYr2kYac47i045scO8Z7D/Xsrpl893n6YqQGHOeOPP8nL5svZve/vkqS6JewA7AYESqgI3o62
 iWPkhTyjvWy+2aG2/O4ZaDPvHpx29sKHLfoohfo1h3Y6VjJ7sLvg0lvehwehnjQljvnP8VxETtC
 V2ZFqwjHf/q/D9yirpw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604160135
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

Devices may provide device specific DDR training data that can be reused
across boot to avoid retraining and reduce boot time. The Sahara driver
currently always falls back to the default DDR training image, even when
serial specific training data is available.

Extend the firmware loading logic for the DDR training image to first
attempt loading a per-device image dervied from the device serial number.
If the serial-specific image is not present, fall back to the existing
default image, preserving current behavior.

This allows reuse of previously generated DDR training data when available,
while keeping the existing training flow unchanged for devices without
saved data or for all other firmware images.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/host/clients/sahara/sahara.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index 9adbd84859073d8024ba2a5fcfa33897439d6759..b5ca6353540dc3815db6539e7424afdb749fd3f6 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -59,6 +59,7 @@
 #define SAHARA_RESET_LENGTH		0x8
 #define SAHARA_MEM_DEBUG64_LENGTH	0x18
 #define SAHARA_MEM_READ64_LENGTH	0x18
+#define SAHARA_DDR_TRAINING_IMG_ID	34
 
 struct sahara_packet {
 	__le32 cmd;
@@ -226,6 +227,27 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
 		return 0;
 	}
 
+	/* DDR training special case: Try per-serial number file first */
+	if (image_id == SAHARA_DDR_TRAINING_IMG_ID && context->fw_folder) {
+		u32 serial_num = context->mhi_dev->mhi_cntrl->serial_number;
+
+		fw_path = kasprintf(GFP_KERNEL,
+				    "qcom/%s/mdmddr_0x%x.mbn",
+				    context->fw_folder, serial_num);
+		if (!fw_path)
+			return -ENOMEM;
+
+		ret = firmware_request_nowarn(&context->firmware,
+					      fw_path,
+					      &context->mhi_dev->dev);
+		kfree(fw_path);
+
+		if (!ret) {
+			context->active_image_id = image_id;
+			return 0;
+		}
+	}
+
 	/*
 	 * This image might be optional. The device may continue without it.
 	 * Only the device knows. Suppress error messages that could suggest an
@@ -235,7 +257,8 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
 				      context->image_table[image_id],
 				      &context->mhi_dev->dev);
 	if (ret) {
-		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
+		dev_dbg(&context->mhi_dev->dev,
+			"request for image id %d / file %s failed %d\n",
 			image_id, context->image_table[image_id], ret);
 		return ret;
 	}

-- 
2.34.1

