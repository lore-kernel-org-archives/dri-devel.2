Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1461BC43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:38:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4950410EEB1;
	Wed,  1 Jul 2026 10:38:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qc5TLfBA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Of9Nq+Sc";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1046410EEBD
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 10:38:12 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 661A8u3X755504
 for <dri-devel@lists.freedesktop.org>; Wed, 1 Jul 2026 10:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=; b=Qc5TLfBAKJlWNBp9
 mU7w21Let2SxOXIDqvqX0LyDjJBsjPt2m9fp6yWijD5zg51WM3dAZz6iuZ1Ls94M
 vc4T0ErUVLN6KmCcCo+/zeVWvFjNxQldU8t0USPe2dkLLFsMGI03FipSF5btPFO3
 i2A8Frk+oQDtyDcfWBKVGfWvwWWTKT/gwgpEljRZCU74Jh5lYd5KfBHxsWokPlm5
 lsRSerEp0KB2LGINEsGouaqg40s4XVBuzBg7bOUP75g92E0Rrwi/LHkYLxdaWAo/
 UCBmbkSPrlRVm5Q8xyELPaEBkm3ztQ9nsEy4r42Hc0lg1/oUP36o3DWNoZP7Gg3W
 QX82DA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f50sqr5a5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:38:11 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9f452d260so8261025ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782902291; x=1783507091;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=;
 b=Of9Nq+Sc9wcHWmgqJ4/39owlrIhyT9f8Msi9ZUVrHLon3u2lr2KwU1VaucdPdGAyXx
 nDJsSRjdf/vm6+n/Cc5Q5pfOcLrPRfwIloJmyrTdGixgNalKvPHvkuIdd0mMwiVxAj6a
 i5WIoSE5xbdV9s+YryPOmM3tQA9fR9hGlbSrDMQfkqqaEl0yT7Eu5PT9nJ9VPMFdpY/F
 OAbz6+9KoO8a4HfSPXz5mLOFfGHWAf6GxhO1p2JnDG42Fl2zs4LMCr7iPcceBSS/sobW
 1nXNdx9qDntTlCRqwsdZKL98ZkRVC6AM5+XDZbTb4H9Tr09ULY+luPj9u/J4u6RRTJoz
 ZXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782902291; x=1783507091;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ILMb+mV5AdAqlIxF1QaEkI31w6HYyIF9XcVFgHuAyCo=;
 b=B10aBqD+dUBA+dd/UgNyQNFnwKOIMctC7LzoFi0Q2BK9hBt8kJwFYtbZut2AloEzhX
 lXw+XOte1EKiRrEnGvnQgg03FZa0VT2EukjhCJmsS65Kepnr8A/24MS7jALXehlfP1FS
 8UioIik+b7yIXSZg2BB3VQnv8Gcs12o0bkPNmWFjOLSDgstxDrmgjGdtfWe0TqNfl9gy
 gTUGazzmVCpdaJAY45pb+uqgm10jkA2X7a32EyfUHlX+AtvMsWpjgkm2sryHhlrXSNWF
 gOIvbnbNG8hnkRlzAjkCpRfrGQ/zd+KMvWoDj75nNULCVQBBC0ou1Wf3YG52Fz3XtHbU
 QbUQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro4NDVcH+vRh3DgHadT16IVwTnMlSoxyN/0A1FytWa+iuT6xiiYq2zxtef5OYymlvXfKlJR5uy6jn0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHajDlBJUcN5s3H5jBn1ZBi7HYyvKgo+ZwoLWqjewz/l1yMGaF
 Yv8+JPG8VqYqPxXEqTp+nygpER6Fjbz7sa0E7EacFwJMorUZlCHs02C55mi2LBjK161wuCAxqZj
 wqVohon/tVbHuQ2K6NfV+xMI+ycI//phBBjDOK6+tu5nq+tp/7sxx8kAKOxz9xcxfZwe2doA=
X-Gm-Gg: AfdE7cnVl1ylk2nretGnJKxvJc7HTnGHb0mHjepW1/OZksoQ6DiYrcsg1KJHdPjg/R6
 O28TZpQmiasgdDf6vl5RjY9hTC3k5Vj54qZVEQ9ToT2vZfLJKw7E43OfiidedOdptIu7+mGCaCi
 bPPMkEx1a9dVhXhvVXYkBGt2sQlpvCWI4fiyknCH9ayIMRdRTI3em9I5VJHn+xi0+8MuldEiNb4
 6XCRsxFoUDWpyssJ91h4mxgslcoxCYnRrXQ/bPhFVcE1f0ki723019kQial64KI0qgWLwn8ww8H
 FuseDXeBJANaQlP/yTX9J9JAJlQidjY2sCHAz2EqUupVxfldUDJh5p7m0zW8Zv0t5hvmDN4AgxD
 nSCjfFAC1AQ0ZSuFEbogoymlp39XB0nc2GJng8HCx
X-Received: by 2002:a17:90b:4acb:b0:37f:d6f3:450d with SMTP id
 98e67ed59e1d1-380aa1313ecmr1126582a91.14.1782902290423; 
 Wed, 01 Jul 2026 03:38:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4acb:b0:37f:d6f3:450d with SMTP id
 98e67ed59e1d1-380aa1313ecmr1126551a91.14.1782902289832; 
 Wed, 01 Jul 2026 03:38:09 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38095bc8a2asm765251a91.0.2026.07.01.03.38.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 03:38:09 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 16:07:39 +0530
Subject: [PATCH v6 5/7] bus: mhi: Load DDR training data using device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-sahara_protocol_new_v2-v6-5-3a78362c4741@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782902263; l=2770;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=Ai7Oj6HYo2DVpdnuStjVjQuKPI6ELc1HNULGnu45Dq0=;
 b=BKtlMZwrym34uRRohN8XfpdmrzJadvkke8EGBNPb2CtSD/iNT9JzObFZ63p+0UdfBGN2gBcjg
 vZCSL+IrFqhDaUq39Jju8Jp2hy+XGAwYBbHnN7Czqme0mSNZ0EQ3f31
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: N4ZscYtRK7C0kFkdXkWuknL60dlEoW1U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfX/s7sTRIKrggl
 Y7pkqosjuZ1cCoavrOzpkoZNAOMxDfpM/9vZW8e89oQ/iInuhBJHjEZCToBsXxuI9ai25a/VxAK
 2j7+Yl1Kkwwk+uLUNSuqPh5xDdEaJGY=
X-Proofpoint-ORIG-GUID: N4ZscYtRK7C0kFkdXkWuknL60dlEoW1U
X-Authority-Analysis: v=2.4 cv=ceHiaHDM c=1 sm=1 tr=0 ts=6a44ee13 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ICgrKnnyuXbdZ-Zkjz4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDExMSBTYWx0ZWRfXyaE7PVLO1jtP
 uLgr0WTws3ZnfxhKR3VH2I9IXmT6K0MUfGsISAJBugWwjYPNP5oHa3GS0YUxi/9w/VwRkjH6OTr
 ZP0WxL3hg+WWu6rOJM2qQ+UEsBPnxArmYXiE98IiIUxCkZGvbVlSfNhI6LwHSRgU+uWs9jeQOuy
 AIt+ceJCYSPymhpY6jcuiyTDWqnsjHHp2bqY/gPz0aPjhhqcF/f+2LbQDTYUxi5qfDl2CepTq3c
 ScEWxftLsxbZz9acsJHhhpfS8ACsP0Mby4y8aYrORbHMZgL4t4JrDO1sV9TporifIwIS2Imvq3Z
 KCBZvy+4hxUdNJB34MJ7oN2Khu+CRA61k6bdwj4sulSyRq4jWBbTDdVVYRUco+c49N1XQqLTQhr
 0EZ/wfH0t7hT0jRdE/GZlq2dAV51tdlfndS7QqRvSYULR6Q2/4cq8J7RT6DeLSDa1mQiGJ2OXln
 nug6HKO3LG4mumTQi0g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 phishscore=0
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

