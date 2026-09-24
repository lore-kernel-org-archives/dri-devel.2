Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90EE6C98318
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 21:15:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE23710F7B2;
	Thu, 24 Sep 2026 21:15:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BTvV6QV7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iMqYlJTn";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644CF10F7B2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:42 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OIdjHt4001904
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L8XTk5v0tefQ530CES22MYlLHvNcAW6UsMK5DSixRlE=; b=BTvV6QV7YdPA2Wlw
 QqIRO6/PYju5u37Vhc3XZ9HOTn06vi8hPuhveajHU6xI0lVYu0SEKbgiSFtBjUkX
 uutwbQK8ZASpYCANq4pCBRSzMLyKa015/uk0X/8QcHyAq5r72dga6uzsIgkj/x0i
 pOd+zhWBFw2BzODwALED3hf3G+C52BkW1Xu3sDOwBm3EcFKomIqlT7JLzEPdZhOe
 JtLvxrx5K/RO0PWeV7JnX77FNwUAoZ71NEan4Y81IejN19HHKW+NFoDRvyplkn6e
 XNAJJaa0lmKr5meQ2WAE9vf73PeAbIvo4KalRueqR3/mYoEt1qVOPoSanmhQYqWk
 QfkRuQ==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gw1rajtwy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 21:15:41 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1383723dfddso481054c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790284541; x=1790889341;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L8XTk5v0tefQ530CES22MYlLHvNcAW6UsMK5DSixRlE=;
 b=iMqYlJTncKo6o73/9q/L7uEKfvxZTfrefh9fw1VsL4gn+ha72ww3YbyyBBkxGxxlua
 Q3aEjAJnONP1cn8v5PPFu0r8OHNUe1J0z9nSTlbrLjdQAmb1Qi19uxBRGnT+ufzGn7xP
 avTG0E9K8L7pLcD8tU3HOxqkah/k+TSbzNYi1tDqA77+ecaIJQwNk279bCmt0OObB3+Z
 3aw50aoOOkxSQbg8Eieycm+ess8IJK7e+oFiP9b/O1PxFGwA4sTPfqAPBTw0HOimvi8t
 XArOR3jQDCmjoyz3HtiXuV55v9KePTUnaYC4671SFt7BOB1JeYMhDCcMhMn/do3qAWYK
 ZsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790284541; x=1790889341;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=L8XTk5v0tefQ530CES22MYlLHvNcAW6UsMK5DSixRlE=;
 b=qga+ps1dVzLFKlH+isyVKTZ0/9rs/uM92kH9IB0NI0pDa5sepLFFUx1GX27CC+WEn4
 D0dgEcl2Ijo4o8rM+2j+YpyoLeAZti9Nf1jw/z85jgXMG4/95337ri1SnpQTptHbUEnG
 2O+44YCnyi/tM5jzaZ4A2nnKwRAjkszjdQxCJJEPodekoRGzL3gUjSyL1AunT6Rtl9jo
 LIro8suDyr1it1UDtW6nq9wzI0YqoQ/B6bF9gBPqJ3OQB8kmEJIWY+1QhC+Ero2NGnsm
 ljfuiKqxwKlQnfxhI4LtZcZJARExBs+8UFQ9ZgrAKgSPsW1i8R5lfxBOYKbLuPWQQxbD
 6CJQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXPJF9gvyD13sPqy/C/KKjYw/RvxBq3gXBLY+v7lCQULd5N2bsPY6E8YAx1gZOrxLeS7XhRDP02Cs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mpzdaUlkUME41Btrfi7XmOPeOF5Bn4RE2QmwtQWF3etTSmPDDg
 PP7eVB3JwxB+nruaZsiHLK4iI8hM6s5caOUcwpwV1i0dlZXCR+jdhmM7daje0f/9kPD5a9rJCEP
 +858hl3dCTCIaq1n6dsK7wJCbH16Mvsz09yi5r+Yjonpslc8T2Ev4E7tc/QqDGxiYdUeOyDQ=
X-Gm-Gg: AYBFou07X2O+QaEeQ/gGo6J6VLeiYvkVZQuvYslLkgOPC0ZkAWIJu0BjCiBQjZnqJSv
 DjQxoxVc8n7TdqUqZlUo8KxwfpQKmekHm3GhmHW0P+++FEHKRmvbANGGgJQ98/Q46WU8REHJa9D
 Cp7voV/RmbGaBTR28L0nIyMPMcOU1ncnxYSD17sERB9RuzUogiP3Q4EEUEznBOdjoLGU6Y88lEz
 4/2L+Tue9/GySn+It0U2H6U4nojDWwDWWBXZBafrA67HWY8j4mZ57HYSwtzrezs1VZIqw06Va0V
 RjA9uMOk4cYVAfvubmfA19g/uOVC3owIgPHqU2jxmA0Zn2pPBuZRAEkgw8QfnCLRJ8WzhrJpNzT
 D9lhdiTLcj9BOe4O/IXdJeEw=
X-Received: by 2002:a05:701b:4306:10b0:143:5d6f:5532 with SMTP id
 a92af1059eb24-145040cfd94mr2743787c88.40.1790284540717; 
 Thu, 24 Sep 2026 14:15:40 -0700 (PDT)
X-Received: by 2002:a05:701b:4306:10b0:143:5d6f:5532 with SMTP id
 a92af1059eb24-145040cfd94mr2743773c88.40.1790284540113; 
 Thu, 24 Sep 2026 14:15:40 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-145acc47ab8sm1323776c88.6.2026.09.24.14.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 14:15:39 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 02:44:36 +0530
Subject: [PATCH 5/5] arm64: dts: qcom: mahua: Support GPU and GMU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-mahua-gpu-v1-5-0fa0bfd8d315@oss.qualcomm.com>
References: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
In-Reply-To: <20260925-mahua-gpu-v1-0-0fa0bfd8d315@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790284491; l=896;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=zcZQ01STOX/BFxpjfteZ5GbDA/SstCruTcWAzRWOPQw=;
 b=qf5WmuA+flC64cCXlsBjTmkpfQFtpR3zTefYrtkTx4i+d6SPJXuF5PLCJyCt1DKDYV3vIsh2z
 h7RJ86eK1yNCynUS7ywf8obGGXSmuuceWuZ65Z7lQC/seu9JrUHBztx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX8NJdfgPLjvjy
 uuKT4gMPyM2YKoqbg3nhtpYeLEfaXs5xXy20KdeyIaSQ5Hrkg7XeC6AItyFjaD0Ql+oXQCJyr2N
 YFf6Z0bo3d0l+6ERrrZSpkLNaQ9+MevLQAGLAuN5o/LaNHYsBQYvGXMgnO9DeygdW/DYwBDq3Vr
 8svcWQlDPm5HTvIIGnsOOJvsuU2nqSwpYCuqJQxZ+0O4NPRDs4/2n7lVMjGfyt5HQMR0HLchEbS
 Xn9bmd5VdEldV/E4hZPKYyUfjJ90YOlKAb0UteJVesKAOjYHKwv+zDHMATfgZvbyNEtXFC2mS9d
 J31xLyo1uEk2+loDbjrvNRhqhMD+8OwgwNjf8tdfM4vW1Q5AhC2keetaMYsgIGnm71YSbB0yR4b
 Ae9/dL7k2kIN5yL1GuzkZEcWTzvwLNjHTTNmA9iLZwjzFCny/pIrqAx/Sn7fP1+ID5jzkgbXcKt
 0CZuC5stIYL1Dpr+GaA==
X-Proofpoint-ORIG-GUID: L498xFAi-c-QZnBB81WBXzbkek9b4Zep
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA4NiBTYWx0ZWRfX1Tc+vtfGDfQ0
 N2LbdQyq8v+yzTAsMHf78cxLRyFs4ocuwzL0TIrooc743WeSFaRtUVaifL11577AF0dNl+MwDZG
 7kQkOZTWFwT2pQxSKOLZ0XpiFZM1DZM=
X-Authority-Analysis: v=2.4 cv=fvpJ914f c=1 sm=1 tr=0 ts=6ab592fd cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: L498xFAi-c-QZnBB81WBXzbkek9b4Zep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240086
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Mahua SoC has a new GPU called Adreno X2-85, a slightly smaller variant
of the Adreno X2-90 found on glymur. Override the compatible strings to
correctly support it's GPU and GMU.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/mahua.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/mahua.dtsi b/arch/arm64/boot/dts/qcom/mahua.dtsi
index a59c5ed7b48e..25b40c33521c 100644
--- a/arch/arm64/boot/dts/qcom/mahua.dtsi
+++ b/arch/arm64/boot/dts/qcom/mahua.dtsi
@@ -127,6 +127,14 @@ &gcc {
 		 <0>;				/* USB4 PHY 2 Max */
 };
 
+&gmu {
+	compatible = "qcom,adreno-gmu-x285.0", "qcom,adreno-gmu";
+};
+
+&gpu {
+	compatible = "qcom,adreno-44060000", "qcom,adreno";
+};
+
 &hsc_noc {
 	compatible = "qcom,mahua-hscnoc";
 };

-- 
2.55.0

