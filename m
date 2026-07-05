Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE702C44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42ECD10E14F;
	Sun,  5 Jul 2026 08:01:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="jYWEQSrA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LD9MVTIo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A15910E161
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:01:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6656h7O9935559
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:01:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=; b=jYWEQSrAUJv+G1cN
 bXwUmbtQ3c7ObjQG+ukJt9DZ40VEQ6PTa/xjw1+N2e3GCt812eSCQk+dPYd2jPfi
 rdTvb6I19xcC9R/SG8craVD0o+htkVCgDwPS6emwf2k6+vSmDtvS8BKtlB5TFCwR
 2Yvk/h9+K5xpEjlQR0+3/csSwc3swKpXMlA/fFjTxuekd8VW90Hx8V3lnn++WKs8
 uj+4EijZA6e929hOWVjRvdmmowQ8eOkNKLvKPDUsQPIEsuopeRVeIE98bduRFh/2
 dfKFu1+t9kKTb9ibDwtygmTqsxF/C+CdpJ9WnMrG8DllrNmWFT6WW5Xv5wzseDX1
 gULo/w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6qhnjmb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:01:57 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3810960140eso3053149a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238516; x=1783843316;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
 b=LD9MVTIoubuXD2uEjVtcoVbwpEZOR4CLEiTuG19Uv3eTPRr3uCOUXvna2nCeKvqjEQ
 ZhNm8zkUZStJY64vYBE7v4I9yyfzimg0nLGkSK/3lkzUukb1vTVbXsWEtGhtlKkvvQ9a
 R633SNt43aaoKn2WOFnD6TWFRi+vVu1eBugtSG1RmjVpoh+zC9vJlvqT1rLp3FTQLpeo
 YtrrYfpAdMu/9Pa5CKoZ6HSdup8gTR5dgc5wx4s+TVrAZlgvHihp3FezIxJzp/RFcZaD
 aLZGy0vqyUOSZh+qv3PRmUlOj9jbBMPPknGrHKhbjEwlZCrKM/rUKkM9hGW8FOOA6m3D
 Mh8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238516; x=1783843316;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kJCEGFaL2BWb7t2hrhNOF7E5Nh+JxpjT/H4VU+ffr1Y=;
 b=a+ML42/3QwOExMuGMGSgNxqFqnszSH9z/o0/yDTr3yzCqunJyhqIz3wsxO0GPbMrkt
 zLPk4olN0SPPMgBpx9xYoEgAOVPvHdZTEvwMKpynn1mqjOKT87h9NEzva0d+ZbF+jqtq
 lCq1cGtdIyi5pKjqS70nox+TOgdsHuQMxkEfwiyU0vQPDVJWsbkBAuweDH8SIMV1GEw0
 +XndxCZZhcT7YKfNF4R9tnpzKYSVjUzebQA/mTMq9nYQpyVk+BQYKlySu1JyDOWf+DeE
 YmhNEcpE+b21e+yDlDLzLJE6LxGixwOt/3pi2xLKQGHe1paPJoBVUPcvkD2StlupjOQh
 5KCQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqoO8bJzeKexFa72HTZToMG3rk6SMQRP21SYFPPC3QrF5ZM6EMBT/4iEOpl095ShAMOkPKr7ri0W/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0rqp0V+gaaxf63b+F19pygjEgeEvKq7Qn6Hq18f7JbZ8ogoyP
 XTC/kG5/hQ+AdhYZfjd/3hakhM2RVQEPHQ1qqiQPo6yhIvgCVKNiR7eE//HHiclqhHzR4QET4pm
 k5/CFRwy+0CcBGuDp4lGPotrJwEK/nWptrUTLU2nHYYITeOk5KbjXbzKZ0gdGhJElgZhtB+U=
X-Gm-Gg: AfdE7ckCMyo3FvKPNrQwyWrHr+PFSBsQCJshkLNsmIbpPbHSSnGe48oAOJbjpOr0wZc
 nqU6t2U9GKhgzmKowMKWtzFy5sRunTa4uVdcN6UCQv/0ETJX1g71QvHSCIUpgNS5Gwjfkt4gA7P
 +1kKxnbfrloSO2Y8I7ilLC7A/Gj5kQ3/WQWhkdctc9kVARTeNT//7hD8xVdPny7bXFH/OTtRWnh
 gQShnRID1YfaQsP6XaWjIxzeM48EfEGF9rxy9KE8M9PhQV3zHG8ZRv5dGkffEVgtkdfC2MNYk0R
 242crV4UDT4RhnlPkkxxYwiTi+KggURaUzhXIDtzGliTh9SLc6YiXz+vS6z/rO3ya9067HF4Ac4
 MaaNbqdtJKuDiNq97/uVp681w10jJqAX7554=
X-Received: by 2002:a17:90b:184e:b0:36a:fcf5:64d2 with SMTP id
 98e67ed59e1d1-3829f0074aamr5306067a91.16.1783238515812; 
 Sun, 05 Jul 2026 01:01:55 -0700 (PDT)
X-Received: by 2002:a17:90b:184e:b0:36a:fcf5:64d2 with SMTP id
 98e67ed59e1d1-3829f0074aamr5305915a91.16.1783238514228; 
 Sun, 05 Jul 2026 01:01:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.01.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:01:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:30:12 +0530
Subject: [PATCH v2 8/8] arm64: dts: qcom: kaanapali-qrd: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-kaana-gpu-dt-v2-8-6ac53de56314@oss.qualcomm.com>
References: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
In-Reply-To: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=851;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wcNtHiPt37tRcLONgZr/t6X+o8Dp6m14w6rdasOzENQ=;
 b=URv+TD6nyF6fnwSALrkof6UTYsZQKMpZN6Rz87h3njAQB0CgJ4EMV5S7W8k1U/tDgpRf3l9zN
 cRBp6AKKgf8CR9cghxKkqama10bv835Kb/xUKijDgF/ifhTGcqEIvaN
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX9McqkENdWjSf
 Y3ZMnPJSMXSmW/3Ue6Gg2dyiHTlieTWMUubhsk25bNehSr95/PXMycRlI6WPvX8adMN/vGsVmV0
 XdVYwTS2VMsVi6MiqSJbVnfqB1JA9sQ=
X-Proofpoint-ORIG-GUID: GmSbx2EhcOxCNuxBPY3MwI9BHlNlOah_
X-Authority-Analysis: v=2.4 cv=J+yaKgnS c=1 sm=1 tr=0 ts=6a4a0f75 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ckKq4DLX54o5ySWhiFgA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX8SOyp6PH4BoI
 njMuk8PCtMav6UcPdTRIgSso1kIuypuT+jySWhBjGr8XxQfPZkfiie3YInNoAUplH8JrTsdqbKZ
 ZLm9WlJOXmUeF6TCDTdh57hE5D4m7X/JMh3Dv6EDE1niRJ6lisJiEDizY//st/wq9vV71+yG9Ho
 i8+f/v4RNijseGlAlrBBnGsEVM/CKyu3hKnL0blHZ4/HMO9eeOOCHSwAqsuGSQ7wAnBij0sZSqG
 JrBA6tu2t9hQZbkAwVwx3z5LvMQsbfOD8rAhgokFaUI7YShA40lE8HHgrYHq++zJQsKUNlNKLDV
 L+wzKLlY1oYejZZN1cExRHZE4kT+GFr2sNPa6ReZaoaGF9FF9eF70leUCGggv7qIBO0ZX1X1vjl
 hrVmhjk14EeqG3/U34dSD3xvWnL27evUfdRdqP2KGrnzUsc4QrdZLFZxhMen1jprBEviYGJxxwZ
 LhW/C2VmRVdI0JCHFuQ==
X-Proofpoint-GUID: GmSbx2EhcOxCNuxBPY3MwI9BHlNlOah_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050081
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

Add the secure firmware name property and enable GPU support on
Kaanapali QRD device.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
index 55d02219ef4e..6bef8ec151f8 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
+++ b/arch/arm64/boot/dts/qcom/kaanapali-qrd.dts
@@ -693,6 +693,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/kaanapali/gen80200_zap.mbn";
+};
+
 &pmh0101_flash {
 	status = "okay";
 

-- 
2.54.0

