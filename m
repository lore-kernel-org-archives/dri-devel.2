Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C61A2C982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1507F10EFB9;
	Wed, 23 Sep 2026 10:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZReutKyw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BL7JMTAJ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A375510EFA3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:49 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA2eLx2821202
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RfrblhWfxf8VQ4VzE4Aa8JWdUn1BoSPKxiuXBWBY+60=; b=ZReutKyw0lRObdNO
 Mze2c9GJtqxQzOBe2R/l4aA/EYI4Kyqv6oTBQ5eRHwX9ibTeDbQGIZM+T13NiqBO
 hN44wtkFLdByky2siUYWSjFGMrFWGdzh1kFThelFe6Xp2SpRiIA7K1PQVpq2tek5
 5wLmBDib2htNu5u8WzkHQMJlZlCqcf84dmUuistLTW2cbpPJ8C7asYxAzcY8GMZ7
 FGjhVdHAUQcH2Km3Cut3sJhKy72/ozetajp1gIHNpH3OmXLNWNMJD7CNkUUnguMw
 Sh+93MHhTipFnscy+Act6UAfgXZHt0DORG7erx/kT0yPTmd3+BGKR/sEidhGAasV
 EU3Ogw==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvbwarapn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-14388794dcfso813818c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159268; x=1790764068;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RfrblhWfxf8VQ4VzE4Aa8JWdUn1BoSPKxiuXBWBY+60=;
 b=BL7JMTAJH9BY7WQlsOLAOGKXKwqRVu+AdHt9ovqjI/9/kiLdrdgw2OScwOPvD29tRu
 HBaL4SIwm+EoSJ2QHA7zDf3avZNZ2fg8EqfBo2DC/RjPXNQd1Zwu1nYqhPJLySVyKUsW
 7YzpklkGD0p54wfbyM7UFoffDBz7NASpKM8+vQjbIaFd1CevVaUTRV37ogn1PEcIJyHY
 3U5etYXspGjpGq/eN5OBqzVgAsKNOMxfbvIYnHddISPDtCZ1X/8EP23FczLMpz7guaKz
 vROO/8syHtsB7D/VOXLH9trkx44eNb/w5Nd6HR6ounVMF6WK7tINJKJND2JkE4G+fxXA
 Af/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159268; x=1790764068;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RfrblhWfxf8VQ4VzE4Aa8JWdUn1BoSPKxiuXBWBY+60=;
 b=Te5zdxRnbGYSt7/ai42/3pvbXtJqHwuAo+hxuaFtu3wV9Of979ZhuehvEcPj3HKS+A
 djGEDJIRGUpNvAdM86iCLbiQfwIFFkh5r7c1vaQLsyfOUl3X5rVSfj0+DaN2y5E4bzvI
 Q8bL1N9oVM3Eu4T681xexTOhLxYFQ4qkmQABDGQ0PZLJpX85S0JfyIYb2DCdl5F2UxRn
 ESIFsu54tCSZtp/DRIA533S87XQCcybDI9CckqTT3JKHTBiGrUuSJyjVqw3psPFDhH/7
 C77e3eATEwcb62l2ap7/vDOBtXgwxIFxpxWprGTwuk9K0gxbF6g9n7gRc8xSyNonRxQZ
 CUhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxOvmdsK24fw6v4fqzTXupq7pYlhQ6chA+toGNjWSorqxUq1LIvPZ4F4EfWcyiHFLP8f3IpZ44TIjI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lvgqCr927XeJx9aIw9JV0mAiqPUE3BzNrTT93DoS1am61vWRH8
 obPHptHtX6VMIoZ91FjzhS2Lhu/K6DLaLVIAsy+yyfeSM8h3qYmBEYd6iuBC3xpRB4MWSNvB+Ym
 np6AQ/2ZM2ME+FIP3Iid7dXRaRfjvNQQBPStRohFDDkRRScXdIGPE5fbYZfUuPW/1AvwnJBk=
X-Gm-Gg: AYBFou2S38K0GMmJoySARoi+pW1qyOtBmu0OdHwzItRrXanOuijLkMk3hsLkmunpRV3
 JD4cSb7snX/ZhQeQjjLlGz6LB0SqNRgE+qYjDBMOdZR1efz17YMB4aMQbVs+GvnHmXj5GbKFfN0
 j4kdMFxk/PE2X6HSsN9pnJHvII+F4fAR6k0QccSGMPN2sJWCuCK2NZuqlHCFP+I08m+QtO2k7/u
 fMl2iQ00JE6gPNV888ZW3M4hzgpEXczWCFmiscrsLofT8QwhZcWjnDqttj6FPvce6S/EPPVPG2k
 6W+OmgdnfI5cI6CJ1q6tdZCl8ZwS5xnBUOCc9kPCogbGdmpbun1h5SwfnGQFP4NYMy04OOv76DP
 ZyHecdqxhacrli1Ame0jhe7Q=
X-Received: by 2002:a05:7022:294:20b0:143:74ca:e825 with SMTP id
 a92af1059eb24-144f917e79cmr2282743c88.41.1790159267633; 
 Wed, 23 Sep 2026 03:27:47 -0700 (PDT)
X-Received: by 2002:a05:7022:294:20b0:143:74ca:e825 with SMTP id
 a92af1059eb24-144f917e79cmr2282721c88.41.1790159267103; 
 Wed, 23 Sep 2026 03:27:47 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:27:46 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:53 +0530
Subject: [PATCH 13/15] arm64: dts: qcom: hawi-mtp: Enable GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-13-0c3c79a1a470@oss.qualcomm.com>
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
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=743;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=3yrd9iaxk6WVgzH/+KegTwiSgLsdXLNTrYaYCjHpfy0=;
 b=z4IzWM19ZUzLaZsn01beUUV5IsAfP11dYgwYL6oOn1vBBwSz35w4MLJQ/iB/mjHrPSK/jyyCJ
 G2prA8e0ZtkBodOLVAY7mww720d3ehtoNhURELlFqkd/C7FKsGeqVNq
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfXwSK+Ybuwf13x
 YHIiyBNrX340onkGV1wudwtudz/nSAyaIhtFxShFZFZ6f3+HetYF7li/BSwrgFYsbJwfs+kDM/n
 GgVJBjMCL5u20xOT7erFhcpWWKog0lnia3McSAkJmgeNk7m3VcLNsGY0DcrzRINCG4PAtdabMFN
 or1UCCM4RHIFrsjZUkyetAfplR9JIDfv87+X318Vq31xLdfb/UbKgNEAA9MqvK1jb279V9AOAVy
 fft1x6SL2MBkv+KWyXef8xHUC7R/jQnNhoeguPaeBcKs4CfBjuMbrxccq4Ah9p8hw+Dr6zl633f
 pr2V+QcGEiwg5LaObYLlSCmM3dvRcJ3iowPWDjhyFnoouSqSCWG/kEXTyvQbKFyRHw2bSb993eE
 ikqnDXBC9rUg351IFwY+apWj6UzE6+9jZ45Doa+UY18Wh7zgyTArwfd7ZuSpcaqOIjOH5YHYlEd
 7I8M764b+R63LjzS14w==
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6ab3a9a4 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=fF9zt-HNKniO5dK11HgA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: NTvnXg80dWHlUzE-Z5rRVuUcJ8-skT_q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX0igCJ8ag5J7N
 Pqaa6w1TWAuMRj/k6ZvquzFfpJVNBtQm2UH77OsrIo8ekLMSTE1VhHXsApo/0RxYYKvdJBJsm46
 fEJqT0kyz6uswAzloI/i6rimkR6p/zQ=
X-Proofpoint-ORIG-GUID: NTvnXg80dWHlUzE-Z5rRVuUcJ8-skT_q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 phishscore=0
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

Add the secure firmware name property and enable GPU support on
Hawi MTP device.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hawi-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/hawi-mtp.dts b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
index 7709582491f9..ee4b36f2bbad 100644
--- a/arch/arm64/boot/dts/qcom/hawi-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/hawi-mtp.dts
@@ -781,6 +781,14 @@ vreg_l7n_3p3: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/hawi/gen81100_zap.mbn";
+};
+
 &pcie0 {
 	status = "okay";
 };

-- 
2.55.0

