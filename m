Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 251BACA600B
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 06:24:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B45210FC40;
	Thu,  8 Oct 2026 06:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TFmNdFpO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ArK7I6xw";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C2F10FC67
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 06:24:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6984Bncc1433931
 for <dri-devel@lists.freedesktop.org>; Thu, 8 Oct 2026 06:24:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 P+Y4gRYTod15OBoxNgHw8ukLV+tqTnNT/YxqpsSxaXE=; b=TFmNdFpOlG6NHlIp
 ysObBgGGLPPajn+bvzRVehKaxBQR+MqGbnXHIwO80l9sznaCsHTTxnr67Um5cruq
 6Ak60HUHN2YY8cPW4VydPR5c8Y+elQTNoklcIReDUvjI1YvdvrW3OMvTPtUfRij3
 0hN9WZrezjRdiGQuqO/Djk37SFsmiiU1oAE28/O5GwmNbUshM92gp1hmYDA9QWXw
 kxzHyNOX/TnywHGk4RfPjYYkncHlCKOlyvrX+9Rd3LYs3M0d5qc3lUHOS4A60D/c
 tR4uoBtujR1aRD/3K2X8Q6rY6XKzhh6WeB5b+lSJLyPOYbrAPfr6IbPCpnjMFWAA
 59VVRA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe3hhqp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 08 Oct 2026 06:24:19 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a8ae5154e7so1373616a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 07 Oct 2026 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791440658; x=1792045458;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=P+Y4gRYTod15OBoxNgHw8ukLV+tqTnNT/YxqpsSxaXE=;
 b=ArK7I6xwvA8+o9WkWXrb+6e5euw6Za08gwTT7/g3djkDwYTBdD3qC2ujeCqA0RD0/U
 wjU02dHHa7hbc+Zd5WYXErhCENkzagll+vLNXpm6NeqXHyvnm2MmGkO0nL4erY1SQ+Uk
 2b6y9vGuGf3gQ1/bSo3yaosMMH5Pp+YqZcMReImCuk/jXaBGlW0Pkp4AKiJUxno3SCJw
 r921xUPcqoRoOm9ypVOqn6Tq/5z0gPk5wGuvd0RsfYaIalFWW0DMzUlbP73B6VQhfgpK
 T3QgNQNF6NxT6plGa9G2v4oXbg91mzrw0UaHN3yLqGu4UdJ5UmFZDhb/Tdik/LJiT1R3
 QffA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791440658; x=1792045458;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=P+Y4gRYTod15OBoxNgHw8ukLV+tqTnNT/YxqpsSxaXE=;
 b=VYkn3YleNYT+axbnsgr6+EYLPoMDHLWUrM9+YdSAVF138V4nREmidnHzsNBFrzEwJM
 NwdH6wyHAzrksIEGzbWzW6ksAnv9e1mNUqBscQ7uJqsnjnWaFVZjWWTDGX9sAMTfU2qr
 X70cm44X0hkY5N3DJ9K+yyuI6JV1m0J4Lm+a36B5TTD3txRNs/9QN8R19+gEAlhGyWcy
 eR8WuSFoK8cSjeObftyWad2T3ssua3xo9cY38sBMI+o/e1VsPwO+noLoQST3veNqfIFN
 De6nHICRG/MAZvbTkMM3tiue7+J/9ZwnpdfZGxCU/Jp/7q6pG4u6n4SPEn1gZ0qQHjA8
 XwfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7h4cpc7/I0/ZiThXm9GiHFRxnc7vtFij1QNNl6BxPxzwao/9pOWktEV0jq5EaTDy/FOzY1AT5q2M=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI5fH0jGiPRusw/G0raXU1jnOYQqlmL821//CN6NxfFOrjqnPd3
 ae3FYwzE79AH1qqCdQX6f3Tr1F2WJJB/K5cRu1l1jMJhgUrj15eLZVrv6QchkaHCLNZWspuqEt8
 HJ1tDvaeRXuXM8UqR6ulBKrv7wqZ2ajdTbTphIBvZnzG+2GmkL4SfqHxKevseCa60//3Evz4=
X-Gm-Gg: AYBFou1fzua5WMOFjQ+aNt6nrxloxbxOWhD38b737Fu1sZvvmUzyyV8aiObJvz07St4
 JqzehqBjWva/rIjmykmakcFXFX2SRZcxPWp5he6WriWXkyGPXAY3anjBttXZxs/JJMakUHD0THb
 WLCEXwboAiatXZbco8Ww/jIb1FtEo4fPt3d9lXjaa/qQUGpEGyG/pM5RLW81sslZlRneHoLGCdA
 B68gSwMp1ixJ6jYtSZ4ZvglJElaURI1xw6u7E0s7B5li5TcIjFJJ8r7j49xZbFuigIc9AkHKwxF
 3hOxEJaSmdkmksbk1d/LJNYRetro5w8UWVLzxcqzh0ifpIb2BhD2308hft6p99RX/U1qFoWlhqu
 GcV0JPrEwmMnyyVf9yZZ0Cy/WU1bE
X-Received: by 2002:a17:90b:4ac8:b0:3a6:fc30:ce16 with SMTP id
 98e67ed59e1d1-3a8a10789bamr3477732a91.51.1791440658138; 
 Wed, 07 Oct 2026 23:24:18 -0700 (PDT)
X-Received: by 2002:a17:90b:4ac8:b0:3a6:fc30:ce16 with SMTP id
 98e67ed59e1d1-3a8a10789bamr3477720a91.51.1791440657697; 
 Wed, 07 Oct 2026 23:24:17 -0700 (PDT)
Received: from hu-batta-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a9ff7ab034sm2767618a91.4.2026.10.07.23.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2026 23:24:17 -0700 (PDT)
From: Kishore Batta <kishore.batta@oss.qualcomm.com>
Date: Thu, 08 Oct 2026 11:53:49 +0530
Subject: [PATCH v7 5/7] bus: mhi: Load DDR training data using device
 serial number
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-sahara_protocol_new_v2-v7-5-90d278bd7414@oss.qualcomm.com>
References: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
In-Reply-To: <20261008-sahara_protocol_new_v2-v7-0-90d278bd7414@oss.qualcomm.com>
To: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>,
 Oded Gabbay <ogabbay@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 mhi@lists.linux.dev, Kishore Batta <kishore.batta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791440631; l=2312;
 i=kishore.batta@oss.qualcomm.com; s=20260206; h=from:subject:message-id;
 bh=ZkA86Go2WmwsxeA79B2BPHvYldgOMas+7hnEDf9OKdg=;
 b=bOPbALLTjtghyIg6XWPv+m4uZabc/9k/qXf2m7FLi9ATry5ElCUPscnHwYbhJuhKdksUdejlf
 zmj75EumEjGBqTI4IiSli48DtA/009ODsG5zbLLblm0hBjfRMLBzdnL
X-Developer-Key: i=kishore.batta@oss.qualcomm.com; a=ed25519;
 pk=vJo8RvTf+HZpRLK2oOIljmbn9l3zFkibCGh+blaqZCw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfX6uc1hyrcg6sE
 ZddnPg/yb69DFS8l3rYzMdK2wsZUFDy290BBsG7qecFxfoSF4IzwTYetcDWELQtYtwyenJfFwrR
 JKzm0jTR0xmNGsJudiqNqMiyGjP1ayQ=
X-Proofpoint-ORIG-GUID: M2B-ewPGgO021SflvrRTFuVL4ES9Uv73
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAyNSBTYWx0ZWRfXyJiX45cW3bNS
 mx3yXe6vKnAQkgYFA9LJ/ieXU5QPn15HOXGomBMh7WmXWdbkHv2xohjl96O82N76Uyd5FpZlYGj
 l9vDCeSklTi1B69u26kd95feC+ZNi7g6S4R7ooukJiLI43ZoVB26FRePhfz0u+NXlp1+dtEbCw5
 o3vVuIvCWilQ3439GBZ6Pqwjw6IH2hVsaddizMU09I0/Ntott4NyquQNiChVs4wasDBEYtAaFaC
 1OZK+FeT1SZBLHIDM6uyrJTovfrmTDIKoeWvZkSm3AvTHLk8hkscTD9LZi/rurJqlryXcTPpkzI
 ecV9KU1l3FIGNbxiAhVL+YYen3/iD4sxdmXqiZMnrRbsKLl7ymYrT0T5dfksa45u3fAy8VzVXMW
 WKgqba4IqFeRPKHXblmMHV4lZ6DwyVvihcPaiN6wXTAPdmX79s99/cpoS4y36FtVFhpeS+xnPIB
 La0AwkUtd1TJQ085nqQ==
X-Authority-Analysis: v=2.4 cv=IIuXmQvG c=1 sm=1 tr=0 ts=6ac73713 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=ICgrKnnyuXbdZ-Zkjz4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: M2B-ewPGgO021SflvrRTFuVL4ES9Uv73
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080025
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
index 7fe5158c17e9814f50b2065202a629eb10a742a8..460695055572151003110f4aec1d682b92753770 100644
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

