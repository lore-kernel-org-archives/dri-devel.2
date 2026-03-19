Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 850B11075262
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 06:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E83D010E722;
	Thu, 19 Mar 2026 06:32:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d92Vgpa8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ij7CJlIt";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6629A10E722
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:15 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62J5Y7ag3733425
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AWRwk+1b+0EakwPo+UxNIgaxtaiGjN34TJYH+DHiZ08=; b=d92Vgpa8NFRAuX3N
 +nVgU9lUwaxEKaSZTk8Ip21p7jgIRnlFt2pj+YV/dKyykHtdo44AtPfZlX56lW9U
 5lqSlEvCYqHloW2Ap+4rvIyGCCm4+zPBWNAFrIyXgCj4MjGZWQ3jLz7Oe8fe/hjw
 EOrAsa1/+1KdJMcPREs7jpW1vHobAUthvsLKwEXYFmpUQ4KIimafgaAIrf1YBace
 lNtth1WqAR20221Qv+DLLHhXVepNYmI+4Bj6cLOkGvzubuLWem/ITj4o0L8nEQmb
 WsvY4/cf1rNx7Uwr7i4AkUoR+knYHPM4/HiXyRTFjle8QrzyMnTyB6VHL3YcqSrU
 8AHjQw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cyut1bapg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 06:32:14 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b06395b7a7so8443975ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 23:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773901933; x=1774506733;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AWRwk+1b+0EakwPo+UxNIgaxtaiGjN34TJYH+DHiZ08=;
 b=Ij7CJlItYVEaThfDc7iw4FevbsJMY6SEi8pAxqDHlswBWU2PhT33Yfp1ELOBWIWUcN
 OAj3OgS32u42C6pE+6IfWOA678gZEuwnpXDVA7fMdjGC0/HPgQWhpyzSVf8m8eNGnCpZ
 4VEHyiKu9D9hyzYuTZcDSpPd98xyHZY8hEOSRBI5qmiTfS4tKOz6U/vl9t/Mo/X78W/B
 m9/Mpi1VALTKP3tnCBDZ5kMYpBh6i5JkcVu2gp9xX8mXTjQbuseoAJFWF6hfSP+NyuuL
 qFs26HITxNI8euuII22CV2Y+8vs4F/WfarBC1xwuo3qTbq9QZ8v2TEa2IkHoi7nfZFit
 DP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773901933; x=1774506733;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=AWRwk+1b+0EakwPo+UxNIgaxtaiGjN34TJYH+DHiZ08=;
 b=KibrHFYYGXIsvIEYAJdJcVoid5RFEAeiZBw6kqwN8YMDe61F7yEaM3QPAuzaOTZtAs
 fGPtGroottJoCZWLJ4xwd8NErh+Ogf3aUgTlkXA8NPW1If7MLlwf+p8gEAxRSzftey1s
 afXVFZdMpu6S9UUXwfrGGnkSZbpDzF+Vtfw19GP2p0dcqJvJj8dRaQq+ATJ9LiU2rC2r
 BNCzPLv/NqVyR/ziBb6qnNM1sExRCLobRXIetkJBmUZABcfUvHUqmZovH0VD9uYEd6ao
 rAPSlxctGdBc/IzRZ4LnrMIPOGEGvUM2pb8LpTjE9nVR1a28ggy/q4sgDUtf9oFs/ysL
 UmuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWpQiud96sJUcHlK8QatIau/WqujES7+ZA68HiadLtmk73uj0yIQaXKiDIe/wC89L4O8YQ+JkzeRXQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxU4oDdmELgttBnaWhe1my6ywm0kIre3nIVH1z7zUiUAt1h7vJ3
 3CsVWXdPomPlZ8IEG/LgaokoBKrg9aJpxKg8XaANMOPC6VPNAxGdevApkbpyEiKQsXDbqEQq4ds
 Ub/LBKEbcI7yGKvLzAu8AkHRHhL5FyXSJzp/SBfTqYt3+2OKcUQu+TMH/QLPJTtv32WN7NUc=
X-Gm-Gg: ATEYQzw9okT8J97E/nM4kn+MQV1Ia5A9ks7wNtHEpScXqjaDZQK4izT8oP5/Oz4sCsC
 A07oQAIdn+AlKfdE6O/7MKdvpfgkkyrctJpQMQddREh8vzedYsYwkShLIAydDzT7dA6YT8yJcG1
 67wbYbgIIAddD272/ZKf13RQ+QTdvwX45Zy3uFN/QOxa9+KhIvlXVqwDyQdUcnNg4tAePRRPMaR
 r1eOvwzbsXGrGkC+YKSaqI/EyIOIwkFiuuukuR9+dCChAWscko480mOdtTMQ8/2vm7tjaD67PdM
 GMZm/fzVmqo0GSTtE/aFSMIoHxnMFcMRWHqxFztmw4eAtJMXt6VhwNANVk1RsP4T+txOtfoywA6
 PVx19G4fiEZDM0RrvokJHfv7W+OaKICRiiaLj2KgobEHO37YatdU=
X-Received: by 2002:a17:903:1a67:b0:2b0:48ca:a641 with SMTP id
 d9443c01a7336-2b06e3c3abdmr57658495ad.25.1773901933440; 
 Wed, 18 Mar 2026 23:32:13 -0700 (PDT)
X-Received: by 2002:a17:903:1a67:b0:2b0:48ca:a641 with SMTP id
 d9443c01a7336-2b06e3c3abdmr57658205ad.25.1773901932969; 
 Wed, 18 Mar 2026 23:32:12 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b06e603937sm48572485ad.57.2026.03.18.23.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 23:32:12 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 19 Mar 2026 12:01:46 +0530
Subject: [PATCH v4 6/9] bus: mhi: Load DDR training data using per-device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-sahara_protocol_new_v2-v4-6-47ad79308762@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773901902; l=3154;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=Ap7TaXFPFmY7vxQioEQxXOj5gqr4VqCldx5s0gGK/Jw=;
 b=P/EiG/Ox8r4P5G4oR1MFzhur+NXMa2Gi7t1dDjAqXLD1FDiqn++C0jyKd+T01VGQHN0sFZPMr
 aMqQNJJLI4PDL60h+ifxRx6Hyyb0ReTpHexQOU9CjbMdJbAk1/mz+bD
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: MQJnfJ3WBnxylHAYfNA0J6vUTHTEQB_m
X-Authority-Analysis: v=2.4 cv=ModfKmae c=1 sm=1 tr=0 ts=69bb986e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=ygoVp7MZ-9MK0Bp9ExEA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: MQJnfJ3WBnxylHAYfNA0J6vUTHTEQB_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA0OSBTYWx0ZWRfX+tzwBhRsVy2Z
 tuDa1JSVanWPtDyMp4rSWSsK+vEbVPh6356kLh06PBczO/kf/4LHclLDrPph755f0DGHG2LgvXL
 z8MECFwFO/njZ0VkXfzn5q8ijliHDHeGL4SeULQma0ZFl4Y8MZzt7eN0l0WwSK3juiIDC7VGMJ1
 fAfh/JEEWrDJ2iMX8CguxbW7Ilv8AOdpGsGxY7n/k8ZYuEvLRIJmWaUyqBjTpkXSxoxH2OH3/Xc
 pPUPZS3hT+4VEFpKtATUg1dbznRE0GyCw2pc6UxInlJx+9dqCnaJCxs7LqdoXPhZvDH+xTKF1AV
 Gg9K5XW/ChbAo6T2ens9wT7vy7mTYwvaIiKg1excE6Ebr7TI+OrybL8DXW2MMvtotF5VL+UE/3P
 uW1DzQzYNReQBbC8s/wkmHMO8AXuxxnS+Og7QCLSwJyLh7LxEhyyouLUbLG4ubGc2He+649EvaD
 yEvnPG0cs4RPr9R77RA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603190049
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

Devices may provide device-specific DDR training data that can be reused
across boot to avoid retraining and reduce boot time. The Sahara driver
currently always falls back to the default DDR training image, even when
per-device training data is available.

Extend the firmware loading logic to first attempt loading a per-device
DDR training image using the device serial number. If the serial-specific
image is not present, fallback to the existing default image, preserving
current behavior.

This change enables DDR training data reuse when available while keeping
the existing training flow unchanged for devices without saved data.

Signed-off-by: Kishore Batta <kishore.batta@oss.qualcomm.com>
---
 drivers/bus/mhi/sahara/sahara.c | 47 ++++++++++++++++++++++++++++++++---------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/bus/mhi/sahara/sahara.c b/drivers/bus/mhi/sahara/sahara.c
index 4ea14c57774f51a778289d7409372a6ab21fea60..0a0f578aaa47ab2c4ca0765666b392fb9936ddd5 100644
--- a/drivers/bus/mhi/sahara/sahara.c
+++ b/drivers/bus/mhi/sahara/sahara.c
@@ -61,6 +61,8 @@
 #define SAHARA_MEM_DEBUG64_LENGTH	0x18
 #define SAHARA_MEM_READ64_LENGTH	0x18
 
+#define SAHARA_DDR_TRAINING_IMG_ID	34
+
 struct sahara_packet {
 	__le32 cmd;
 	__le32 length;
@@ -365,16 +367,41 @@ static int sahara_find_image(struct sahara_context *context, u32 image_id)
 		return 0;
 	}
 
-	/*
-	 * This image might be optional. The device may continue without it.
-	 * Only the device knows. Suppress error messages that could suggest an
-	 * a problem when we were actually able to continue.
-	 */
-	ret = sahara_request_fw(context, context->image_table[image_id]);
-	if (ret) {
-		dev_dbg(&context->mhi_dev->dev, "request for image id %d / file %s failed %d\n",
-			image_id, context->image_table[image_id], ret);
-		return ret;
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
+		ret = sahara_request_fw(context, fw_path);
+		kfree(fw_path);
+
+		if (ret) {
+			ret = sahara_request_fw(context, context->image_table[image_id]);
+			if (ret) {
+				dev_dbg(&context->mhi_dev->dev,
+					"request for image id %d / file %s failed %d\n",
+					image_id, context->image_table[image_id], ret);
+			}
+			return ret;
+		}
+	} else {
+		/*
+		 * This image might be optional. The device may continue without it.
+		 * Only the device knows. Suppress error messages that could suggest an
+		 * a problem when we were actually able to continue.
+		 */
+		ret = sahara_request_fw(context, context->image_table[image_id]);
+		if (ret) {
+			dev_dbg(&context->mhi_dev->dev,
+				"request for image id %d / file %s failed %d\n",
+				image_id, context->image_table[image_id], ret);
+			return ret;
+		}
 	}
 
 	context->active_image_id = image_id;

-- 
2.34.1

