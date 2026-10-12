Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B26FCC6B01
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 18:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F1C210F2D1;
	Mon, 12 Oct 2026 18:18:49 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F3C310F2D1
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:38 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CHuhfA2722755
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lLxL9awAk419qzBctCiH67jNF66X+ZqDVOqGlMQ9peA=; b=HYGolGSlwfYtoBjN
 Tx0Q/JUifUU5LAzpZViLLH5uxn1PVr6PNzSBa/D4gJfQiPtE6rh2ED9L4JTbMOSG
 bI014oW9Ri40/EHZJdP2Srtts7wOkY33q0L/5dvXHoIJONmBrpnqo+MAWSABN05A
 vf6qjNCtwfTQhD8GFtXc5zRO6xtV5dKm10ylVEbKjH2dzAzWc+uk1zk8cu/iJTsz
 FyMLkgR2k3K3kGJkz7Btjpe+fqUaZoWiRlMMCifx+36xqMJPBBBFNcHNHiBi//9k
 67P8QWk3nORt8hWfXsOUq5+PnhT433WaHeyTfpfve0+YXDULXLDCCZimN6DB6xws
 44Ifeg==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w06yq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 18:18:37 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso3479551eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 11:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791829116; x=1792433916;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lLxL9awAk419qzBctCiH67jNF66X+ZqDVOqGlMQ9peA=;
 b=JL6QzrX3KjX16Fbg6PFiZhzYLgUjHY0KIB3N0653O3B6vlWABNZCFLv3pk45dlEKJ/
 1ywSHSfQv9GC0gfoAESxzXvLpKmPr9ExcwISD6GG0X04kgLFEL9zmJqpdcxJMDUZdeyn
 Tkku7ey+lu51/3FbtshwgYymmC9JxTkweMgLLVC4xXBfSXSmEYUrWpBSNO9MihqAfEmt
 qsWSbHF2EDIVypQtxDSULYwdN3wFW+HEw1leVV0UIx0yFfzr3Wsi42umz/qnnqx1rNKL
 dyPy0sYSySSf2fJgyGPCXdhvIMChAxoTCaOnqrxSd7skuGhWqqvOb8llu7uLYCYThyC5
 lG0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791829116; x=1792433916;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lLxL9awAk419qzBctCiH67jNF66X+ZqDVOqGlMQ9peA=;
 b=U/jXB3Xw6OgHYJ6oubXmXzkjVEjav4Qa6yHHXV54ZqVSx3VUuy1sgh58C+iFh0J+3S
 fbhcN+FrS9FDE1BRrosmZdlBorahtorIoj+g+o3rYppuWDrc021kmy4YjNhbgPluNyQw
 58Lhqt78bpdK4pecWT5bSjKnZp4HPrkh1YCc7Qw99xsOfYWepA40KiRojezoQcGzpL4j
 P21y9KN6Em4tJqWG3eIw/wI+uVf9/Bjpgx8QG91FQfdTVDj+gImyDRIGYJMSCB0SVYnZ
 R0U1UXkciXoLf/2v/Z0vnn63C+55E/phJXadP/gxFbO2nVf/2U4dd1U/2IbB8iNAI8sk
 9W0Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/DTC9kn9upgBZ+g2bAuNOu0NHqJobj6QQeOEdd9qqPKy4s9IniZOpq1LXyoYEY46tlJzTLT8nZbc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJmMsW6ZXAQQSDPe3b1PPvP9UzapbRsa3n5rc3CXHHB6vwxMIaV
 l5WNs/7z2Qfj9M2fbdMfp8NDT6ipqquHoP4rnSfXOGeqMTlIEIl2mPX1R9MAum6/I9mRYM7bWQi
 cYf9adUD/roxdrh2EKZo4w5BEIZouFD61IWfQK4aU8mQFe5KYg8WDaC8/NvyKZj/U6XqOs8I=
X-Gm-Gg: AYBFou0IrhFQXfOMGZIJGJu43bZC8IdLJtgLGXYSbYn/aI/q/v997x3z5OkjdHrZ6Fn
 85JOLsvx0vmQUWDM8w6b743zM1HRa+/hyJudaXbib1NZZOpCgf0s+LOErc0ilqIpTqFk3YJSekC
 83Xa+W1vT+HSqK+etCGhAxsNG9/Q67P6Vk/09cOM/mI6h/S2qZtvXMd0N0/VpZ9cMOOBOTiYuRL
 QXil6kB3d38zp5ndcQmnB+NufKCAANv0fqDwHa0+HmrKOfXXfaRBIUmLTjPdL52LYZn9W2LUWRA
 3pyHRok0VJUrvYL0QlT+1qk/39QG+kvoawlgHpv+EwFOTGKSpsrjLZEFh52pqotC+oMUyxCxmfg
 DMq/Plcjf0t7mImrTBQzg5m08cwyY
X-Received: by 2002:a05:7300:ac81:b0:353:7e33:664c with SMTP id
 5a478bee46e88-3537e3369c5mr21147273eec.37.1791829116477; 
 Mon, 12 Oct 2026 11:18:36 -0700 (PDT)
X-Received: by 2002:a05:7300:ac81:b0:353:7e33:664c with SMTP id
 5a478bee46e88-3537e3369c5mr21147215eec.37.1791829115791; 
 Mon, 12 Oct 2026 11:18:35 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-358de54fe47sm22827311eec.31.2026.10.12.11.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 11:18:35 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 23:48:03 +0530
Subject: [PATCH v8 5/7] bus: mhi: Load DDR training data using device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-sahara_protocol_new_v2-v8-5-e12939d229a1@oss.qualcomm.com>
References: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
In-Reply-To: <20261012-sahara_protocol_new_v2-v8-0-e12939d229a1@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791829086; l=2312;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=VkPrxkJqsqM3JMRUSMdLvFLYTODuntM5UO+1g8Zzfgc=;
 b=ZpCO9GOHQmxmSwwG63+gYndvPFgU1yjA7PkqDcVwq7tg7+t+/k2WztsK7jewmcQJx4SJnS0Cg
 8QZrLuBr5IDDxqp8aU5o8mPtE07eD02TC2jLh2utDGUFJH+LQE5DLDd
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-GUID: pQLFAkOsesFGtlk8RSp-hwS7Z7r5TaHv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX9TsSkYpfWwyH
 IqcDk4/bntQmZZx2vzM8l0pQFpynOgXrca5VUrVWbKKGvKbq9btaluzP5qovAmSYn1OQdrZ7p5C
 IjjDX8QE/5FySwrpvsRJgA593RJY+CxS3vXuJCwR85HU3HxBIgXfEb99wzLBzlOQQsY2jRMp06X
 v2B0d94N4f58xfEyTL6LqiN4GqYLGaqFcHcYpzSgZmF7MBpbt1OaM7AKVH6mUdK7QS5swkdnZ0a
 jEDuciB6hBe3I5hVBMO3FcWSlIUQE8IU+7QcjkjS2eEs4QSKkxxz58DTmkw6DHEN3ht0J7i10bP
 b7ntu5S63LUKYQcq+lgqR6HgfKrpxMgBJJuxmDQ656zswYQQDImk3B2h6yjkPuw7W1N+MSIDYoP
 YjQKn8qyvCyAnccmBvuhffq3ajwcjBdj/aIsKVorvJiTlsKaoFNlTr+346yYaHIivYuSvKaMIDK
 tv8KRKWQhPLhwoMz/Rw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA3MiBTYWx0ZWRfX/sxFFoye2E4Y
 timcF+lYqLN7EgfMkcoVKAYmHstaONIImf5yQR5/qSjFxkf15t0BOKipTDnvltD/O3sOPHxY+6e
 NAl1ouBYGhJuKYabv9Ha5ElHWm89+iQ=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acd247d cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ICgrKnnyuXbdZ-Zkjz4A:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-ORIG-GUID: pQLFAkOsesFGtlk8RSp-hwS7Z7r5TaHv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120072
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
index 4baa47d0b94e326b5bfcaa80c8ddf008881c85c9..afb72910fd67b225cd77c44d7e835cae138c2ffb 100644
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

-- 
2.34.1

