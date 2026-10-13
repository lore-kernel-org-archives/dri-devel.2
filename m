Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E86BCA9ED2
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 08:46:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5773910F616;
	Tue, 13 Oct 2026 08:46:23 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AD3510F616
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:12 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69D6CU2G949467
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vxnCH0NNfcKcGsDeYn21MBx17/efcxQrfrVWQPGiIVQ=; b=KhE/ct0opXgywKQF
 zc9DGwJVrVbYEoKdqAp29DikI3MOBwcyyKUiIoISqPSefq/Ju9sEMHFz7mKSRhTY
 S/ewT2kuej3w6UF+EsDs857gctQ3OjyUGwYvFWV3P5rNKJAdzcE5jF53piODgLMG
 zmWNZBpkDEL6CTjtKO17ZLy6P+ICwCOh4Y6BeaQyhmjT2/1RbHa4BnuFmXsv2srE
 UDTXVapAX6i9DRHLEceyman4Epgmm+gCil7kkxs7IhmV1xmJJJC8MbhQDxxYfBU4
 cabnedPnHFcG1qWFYv2ZpW2XLlkXlstppT2Vq4zL8H3I/olUhTScccYBH4wBQDvq
 WA40bA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9f628kp3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 08:46:11 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-892ccb01fbfso2523598b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 01:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791881170; x=1792485970;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vxnCH0NNfcKcGsDeYn21MBx17/efcxQrfrVWQPGiIVQ=;
 b=ETg0uByDhkv26G97B0n8F/HwYm+0+95WslOGHDQ4K05jw7Z7IykhCGVZxhQzpN2Gbs
 WL7H+NtoX2hbYyBXATih8Fdcb3FM03JfW2o5/GWghjXB5Cntafjh5v3AYkRUEzJ2utog
 k7egnr87bbl5Ge6AraGJEM3u854khRZL0XNHXBN0QFh+jxHxUIqEONj35htQs2DU9cQW
 j9n8u7N+39bxovBptkmbyNCD1BkgmsfbIjTOXwREkxhS66AAAKPINiA5BMRHQWD1dQ77
 W7CK7Aivj1ZhFpwI4jesk2cunTdR8yYYSm46apISBxVGb9la+U9rHpXQpXKb7ubHk1af
 rkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791881170; x=1792485970;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vxnCH0NNfcKcGsDeYn21MBx17/efcxQrfrVWQPGiIVQ=;
 b=vpO22vAgGv4tCJ+0Y74S6mmBf/yoU7mNE7c/4EYPCwoCgTGsdZI4HY/gT3SRPv3ny/
 87IipzoNntxBmeGp+8xmb5T/NTz3KdTOFulUJw6vPQp5A+JKm79zruYYj2iQTXzm+oky
 +F/s1SZbmS6JNdNbj/dvuW0sIIiZ2oO6VLQkd5+6HQICnBUy6g0u5ze7454Zxyk79zup
 6sxDYGBZZniP8sPsp7KHO5KgDFBZTuOSsYZplMNJMta/BVInevHFDaMRMuvxbz7T2E4b
 n2C2WVmV9MfH3522Y72m9Fth2LSkIgJDy38XaPXM464x0SdqirNYG6fsh1AChCfJSA5N
 WKxw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxhFXwiVnhswvg0ttpOXUv0x30y1xfFbDEXQ6YNihHWIadahQVVX9Dj88SXQNM0TUXFAjzJuqtDCik=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKj99uhb6HnPENwZL+PHEJlHCkGUzmMSzZfmCRePICTc71jNfUa
 sJjEIXSJRP2SyjFF34MjjMiBfuUhr0vORMO1pp6v6Cl7wzOFHs3RpC2CfpdnI+cVKhyMEu+c9Zm
 vAAMzHjYxamy0H9/FePpWg+9IqY95cgcmh0bNTpLtga2C5KRrly0LLrgPOMuMZ00g0O8YJcs=
X-Gm-Gg: AYBFou18pZl8YEoEV2NTxgpCBVsivu1b5xDMuejHE/mABum8tjATk+gI9XcQWInyoCg
 LAH7OA9sZYwP1Zh3JbSM4NXL+Z94zkaBfN+n5ueQh7ZOWArwgDPHpnrKpRnjFOjfnpXpgBJrFGm
 CAxTdyespJS4pIdiOHtgsjOQshgJeR3EOPdA7c8940/hst+K1vaH15dwJJzmhF5cmP3/ePzZqkG
 KD6nLOy+xb906GeXKGQOouZ+TCF1AE8K1I03BjC8Zdk8v/AZiP/MdbXpoap2+JADms9e16u+KK1
 foevX0vvAvStaHkjslyx+sJk6DxDt+X5Hrve5UXAVAzW97yRyfeGXMA6qm0DS9DbLpfXUT604C/
 xk+ea4C61nChPeYQorsDgtKMLqIEd
X-Received: by 2002:a05:6a21:a4c9:b0:3dd:a197:735c with SMTP id
 adf61e73a8af0-3e16c052430mr9179238637.53.1791881170203; 
 Tue, 13 Oct 2026 01:46:10 -0700 (PDT)
X-Received: by 2002:a05:6a21:a4c9:b0:3dd:a197:735c with SMTP id
 adf61e73a8af0-3e16c052430mr9179215637.53.1791881169627; 
 Tue, 13 Oct 2026 01:46:09 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3da0596f9sm5384721a12.31.2026.10.13.01.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 01:46:07 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 14:15:36 +0530
Subject: [PATCH v9 5/7] bus: mhi: Load DDR training data using device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-sahara_protocol_new_v2-v9-5-dc9f24357c4a@oss.qualcomm.com>
References: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
In-Reply-To: <20261013-sahara_protocol_new_v2-v9-0-dc9f24357c4a@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791881139; l=2312;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=2+l0SnJ6xQbWmIt7CHKhLtT8Hjx827L4qCZBd+DMmbE=;
 b=HnyiFaueBTA9ATyK3dZXMfV2qee62iFqJG+G8cD7P1CuCfQJ+ClZ4AvpSZ0L1UuLOmrq5ceAB
 ADA5An6WtpHC0J7SJF1weIXvXe7vLzFi7gTZcnmhKd1n/BXCyjtx803
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Authority-Analysis: v=2.4 cv=FOKOVOos c=1 sm=1 tr=0 ts=6acdefd3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=ICgrKnnyuXbdZ-Zkjz4A:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX3mVKl94e/hn4
 ZzPqcHXQC4DC5XYTN5cJnMf/ujJ00epBc3xKSyxhrJnCdQcIaPqNkIRd21ZDaH6pmq32yObmP21
 aA6QOnrltkkB/SXazV5L111Sv3rq2Ew=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNCBTYWx0ZWRfX8IANvvaY5P/g
 bC43FUmaf42ZbBsmYO4lbtzoK5nF8RszL9ppwNRAbLmCYoDGVrUY28jY7nVQFPExg7oJg8CSAOh
 x+QDbrwn3bhLy4JnTYevV+A2ee4MDTb8tgydiv3b3ZojdiHSZf3Ec56RYefdjsXvDUFjQnOIuBa
 oBtFMz/XGIUPmdtb0wa1iJuqHxtj7s2CJ1dXCUUnGXnnUv6coVjw9elcMVdVqfXEWAPZYmgClD1
 5aMudEsBJFsSZxLySF8b36QEosXkSGeacGXyrN2eYWMOoX22mPHHI9tAQTG/OEK+qvyOyxivHX2
 pGTnKh82eh5tIb41iZ3T3iwXBnhS360yIenEIMpYaqXB8fT37hlEQYtIcQVwbraqSKsODiqnIRD
 pMcaXVGxT7B0Pa4XH2xDxEZyp0LTnCsCf7AqU1XZBOLamxZIM+kZAFJxGWD3AwaqgSQ2mT5rOeI
 YuirjfnAKS5IsGEIe3g==
X-Proofpoint-GUID: Z9cUQMWgTEalCxlIYys1facA8qeaKz5v
X-Proofpoint-ORIG-GUID: Z9cUQMWgTEalCxlIYys1facA8qeaKz5v
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130034
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
 drivers/bus/mhi/host/clients/sahara/sahara.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/bus/mhi/host/clients/sahara/sahara.c b/drivers/bus/mhi/host/clients/sahara/sahara.c
index a4b3ef197b303cce5a36cbeda272119f0430e619..62b9c72e826801a77a321991f9bb91af37e0cc8c 100644
--- a/drivers/bus/mhi/host/clients/sahara/sahara.c
+++ b/drivers/bus/mhi/host/clients/sahara/sahara.c
@@ -58,6 +58,7 @@
 #define SAHARA_RESET_LENGTH		0x8
 #define SAHARA_MEM_DEBUG64_LENGTH	0x18
 #define SAHARA_MEM_READ64_LENGTH	0x18
+#define SAHARA_DDR_TRAINING_IMG_ID	34
 
 struct sahara_packet {
 	__le32 cmd;
@@ -225,6 +226,27 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
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

-- 
2.34.1

