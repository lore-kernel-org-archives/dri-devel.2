Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E09C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:28:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD2710EFA3;
	Wed, 23 Sep 2026 10:28:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSo2N114";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dugfdyQ8";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197C310EFA3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:28:04 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2j653087091
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tJOzJ9srOMosaldHRAHYeJVA1bT1kfaQQ3r/rKqtz88=; b=VSo2N114zfk0G/zm
 OKK8Kylhkp43W3IJph2g78Yt2TMOBvBBiIZAK+hwS7ewDDeLS6LwS5gEI6Kfu0X7
 d5td/98TptysDM1TEjzlYi+jfBDRBTETjzQgRQjp7Psbwjw4bcxtIPXR4RO+HFWU
 Wwf+2HBRGKJzR72Idpqv7GltaUNyAgkeVpKBpbCzu5CjZ6ELKl5D8gfn/x9Mu20t
 mr8DOmzUIQJVpn/3dckoIuKbjSZwrX0MLcdgkPOuU35PLqgD9VvqrC0AJccSsGRN
 dd72pJF8VBWy3+ajYVzqIWb17LDVqka7kZ6dPxltao308DQlxrWiuv0VenW5JJbu
 AWqFBA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwm8au5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:28:03 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-32ab0911226so877065eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159283; x=1790764083;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tJOzJ9srOMosaldHRAHYeJVA1bT1kfaQQ3r/rKqtz88=;
 b=dugfdyQ8D+2sr8mqgaF0n51QNFDJleFc7kOY5HDE2Bvlqld7gBPsJy/qHYxVPIPa5M
 wL49aErHLe85RSVBDrc7MdIKMiUxRD3FfyhMllVPup+ydqtsiWoWa2oXAYffyFR109E0
 HNAacUkRNV42QTRqSn7GVRuDLNlqaBMzbsKdi7PnjrdIrueYinvCz9H5ElTM/nNeV3Xm
 a20rEusfcPYOInVDaye221CCN0BvrKTScd2uFojg8/ka79+Z5JQfQ4z/B3Pd0rChEt/v
 V+s+5eNK1UCJNfvMqWPVgKnDpRZrGiCv+rHv8zxZDbkoXcQN2/wzL00ilidAA1DQQBVw
 GH9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159283; x=1790764083;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tJOzJ9srOMosaldHRAHYeJVA1bT1kfaQQ3r/rKqtz88=;
 b=HUtNfVIFWJ4a0nSz35Td0oif3E9MJXF9YOBn+880XNmBLu9q7aRbhinw9XAKdvaxAt
 xA/vcyJ8u+tkjMy4Hbu45K1UlicycqY0igiF2zxMC4WWLbXxtx7KxyIluK1Eox8w5fCY
 /PmTj/hO0lGOSrivuVGb3JIdyLz5rbU7yLl0o6jscxHdRYF/X89bdwrRxPh7vBNtuNIQ
 4g/suNBylct5uQxLeNUnifY97qJb5CWTcbYqp2A2+cS9XfI/zoio54LXVeTD9i90yYSv
 PjrgRKyO/8RxLoHfMq5w3fjbMuvlNDeKWQwtked9o3ZsLCG5jESJY/Pvec4vywwA2gfB
 Wbiw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUDmHByv576MH1Jt+dJ3eoCQlzbP30iR4PgUl2WSZz4J/DV/2MT7XdvjI8OVIUeMxpxbGrXUeRXrw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kIJgign2MupZoUM87Z4v74OvP+sy+mcDao2/0EDSlRMZq4xvM5
 JM8fLw19JFFJXk3Panqh0WpUsg8KhtD3fTDjD/rO2MuUoalrJPB/AItygvEC1Sb8C6o7mUTWkVP
 fqJo5ouFX9UPliQaclxyr2T/sd5y6xwYC5ujZe7EZ5v7VX+S8OSJ5ZvuifV83eE5x31vOGc4SaX
 2mgFQ=
X-Gm-Gg: AYBFou37a3OMLYTGK0r16xZsOHQhH/vIdRfWT6YUUu16NL/9/KmcVOI2J+RxOH6IbLb
 c9tmej9gT/AMrgMAWezNVX6Tm2RvQIQLQS/2rRAqsdWM+f24eFH1No9d/XibcFEhYGxnuLlVnb/
 0bBQePp+XbNOUtUpFIKi6CMwshcVmmwHddziNpZvA5iuJNy68Q3jyI5KIVoH/zh4FvFkfZ2fqF7
 8S6cmNnSx8cgYdE2ySuZxVoLBydjf+Hcvldf5CYOUnxnjS10Ng0Qx/4Ugenw1gD4mPazMYMYXgI
 GPZOlHYYcqDFpQ3jHQbgAZKtCHuQly+Ln/zPJoP2UKh1AH9gekJpkuNIkuvFjYF4Apqv9PRHNgC
 XRzTFSw6i1nEKzJo+91+eNXw=
X-Received: by 2002:a05:7022:b051:10b0:144:dc45:91a2 with SMTP id
 a92af1059eb24-144ef1fee35mr2380575c88.23.1790159282490; 
 Wed, 23 Sep 2026 03:28:02 -0700 (PDT)
X-Received: by 2002:a05:7022:b051:10b0:144:dc45:91a2 with SMTP id
 a92af1059eb24-144ef1fee35mr2380549c88.23.1790159281883; 
 Wed, 23 Sep 2026 03:28:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:28:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:55 +0530
Subject: [PATCH 15/15] arm64: dts: qcom: maili-mtp: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-15-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=777;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=eKiUsBNhuhpANIu3zPjDmXfBzq8uzmsYtvGThaw8i9g=;
 b=oTucU2pHz+0kJn0XJLB2P55JznrHw4kc2XiOpgWY9Y4niLKlf9mz/lMqhVAoHQaqpkO+RLoRC
 V7ojlwv33lUBSe1R5puE980u2yX89hfBmI9gLIGacE3GYVLxIQRfgtr
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX1OTwmzn+j9yE
 5D5xPmQ51mHaahuHqu2+r9np9ClyKy69Ve8eVkuWbFWWNHhMj0ovL1wA6ZmUcl62SZRXCwKI0P6
 FhPdj6DT6vImUDEnibSYg1XGiax5MtU=
X-Authority-Analysis: v=2.4 cv=R/6WitRX c=1 sm=1 tr=0 ts=6ab3a9b3 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=bOBbJXBpTyr2JeYZIkIA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: iiVq4qrWqajAkyAwlSGCoAphosI1LS8A
X-Proofpoint-ORIG-GUID: iiVq4qrWqajAkyAwlSGCoAphosI1LS8A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX0B9jmOJq7L1R
 frXnpw/dzCbL17xdvyHXZ880gfMx83LuNFrZoT1Dt1+2NUSFz3vcZBB2hHRooPOnSsmnkcUk9jl
 oiVxnZmAgkuGerMEo/oAuEO6crI5kponKfRuHWrWYsVO+Bs+q3F1y4Dlg7iso9U8xIpoOg4K7Ov
 +K5qJmOaTRqvQvynS67Vj8kkCgDnoejlhNmuXttPM2Eu0+DglO9659mgauoYBxGAH39wg4nEnPV
 kwSo+58aU9UMQD2RBfEmOjCT0Zcm3iusFFdoy4KNu04JdIZT1T0ljzlAKt7ODlAwa9cMWFd+RPi
 et2IhvXXooLJVeF61dbS2Fjtu0P+FcEPnuz62ZGwc/oFtbKnMtFOLXOFwjfoGXs2h9us7AL9tlP
 0ySNvD5H1IZxFj1+Z2I9WhKkWL8yBYnWiGhPOTs+v17XpKyUlozmqnjGm4x1hP4PcuAkibZ/AvJ
 L7AbNx/8IEUfLPwHaYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

From: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>

Add the secure firmware name property and enable GPU support on
Maili MTP device.

Signed-off-by: Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/maili-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/maili-mtp.dts b/arch/arm64/boot/dts/qcom/maili-mtp.dts
index 1fdc91e03271..27facd4b2a13 100644
--- a/arch/arm64/boot/dts/qcom/maili-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/maili-mtp.dts
@@ -908,6 +908,14 @@ &tlmm {
 			       <211 1>; /* NFC Secure IO */
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/maili/gen81100_zap.mbn";
+};
+
 &uart7 {
 	status = "okay";
 };

-- 
2.55.0

