Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE0BC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:43:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D250410F5F0;
	Fri, 17 Jul 2026 20:43:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pjPVSzfU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Nt2ka5GL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A05C310F5F2
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtaHg2887056
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=; b=pjPVSzfULLlVIqYC
 KHI/PHlLgb+u7+xOpdqVecyBd6IinheCrfAlxjs8juOuAZhmn8PhDTF8i9ugZw+X
 BRPfy6/PSJhwhGZ+zfTBRWW8WlMQum9U0u5lYfcZ49UkRf+JvTSKs8Cna6kG6ZZC
 EMIW5Yd7nYCnutt2+odxbkgiJaWEsPGjv0IpbjGCIh0gtSFLPfpYRw8ieNAoGKhu
 +cCnT8Bv6cf0JiZ9k3GM6nFxD+WkMyJm+6ZTbZk/8Hb4q3Yovv/a8zeFbwM1M8go
 Os4bxaLk3C2xqaLBfHgjGtfTIlFSs/m4aarMT6+FyEpnNMrjJ3GFqmAHIfp03Voy
 s5xNRw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffhpfjmdc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:43:10 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c894c1c4aa9so11881463a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320989; x=1784925789;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=;
 b=Nt2ka5GL+K9efHEjwZ11CKuP0rZfb2oxexeGgyN5oUZN9E+Q3+y5Vcqelf4CTRkqzS
 PZt7QeFIFNt68jmsYl1oBs2ShGmu4TlB59+X1svPzFyZV0Iqi1OljKNchSN+jwxESOKq
 6oCC1j3x3xtJ9RQVWiO5OFFC0pPsYzd1YUtlA+UR5lwHSOb6HZknXNDz4YWpeqUh1uvi
 wFzHMB+arjZnee+0uyXryf2B8sYq6Vy0LKGt+mvKl8IMgFEsQro4qPO9b3ylnGiYEiuf
 cUlhG1cZeC5Y6gic+N52gBNW8mmxOi2ZdWZKnAuvaDWeNDSjvvMMqTJ5voIAi118W2JU
 ZAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320989; x=1784925789;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6+db1P5RhSgKDmUAmXoiZyavEFVSigUv3Np7w9qQeMU=;
 b=EWPsnHD+AMgIN/0n7LTCpv2hDVpqMxqr8nl833bf0H6o5Yghc66I1vyzLU9L3v9WwA
 FhHYuJFg2HYFwVKdfDlZzOO5OGHfVa7LYdhJpSPDOQ9bWgx30I5KU+/CQc/eVn9sD3za
 V1kkqizklFjqmou7mk0ErAzJyqd0b5aKIherRl/Umw8N7LABL+QkeqlAWRTVBjZw17wF
 GWLASXCUPixhZaYAa+XV3/vE2pn1LFGsn9hvkaasysgpKA5msh1e8mOt0IMr0RFT8MZU
 JZIIfH/sJXIFi3QX25jqpiq0FAb6c6K0+DxIWBb76nD6oBUlwpKl7BwnPcWkEpw89rsB
 qtRA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoCxDJPj89dzkdd3OezeagWuouvmePcttLmWxUlemgBPwweghemVs9r18BItLAiNJSNrBJn4/V7rZI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz6MqZv74cH5mpxoNIZ59VjJr0532cuU9PwHzE+sWE6GakCJUni
 Cgo1GprRuEt4Cm04S2ZQUAC8AL5ImV/Me5r/F9kn5J7dLhZjaVl1vUZKS6lrOvkJ+gZVUQYrhXg
 T+1bRh3988RHsHY3PTgqRhTPigWMaJoUGRdWLLrcG6fydfxJzZmLtdSQjE68oV3YNfYvi/kE=
X-Gm-Gg: AfdE7cnHHmI+Y/Qg3pHopEyIjUVkW9WZ4KAm+MSthKffy1PvTBywa1iESbA/aTz0XGp
 BIu7fR3i1ctB8c/EGHKOgXbTLix1RrTBZ+FrQgcC26PlKg0j6UvxqlwxXa8+ITv37qyNnf9zC0v
 8XB5CSRv5ox8N2hTebP+1bzBYYzawWO/02jRNOdcqNIm7hCe98U/K1XGwDB8XecTQK7qk3t5HX5
 vEJ+wG06HMoEjWJ+IsFiv6CKtre+XGe/EQsPyHkkv3mB7YWD/Qjec3vDEYn7zDAOnqfFas/zQFu
 1ZOLJbo1ATVW/Kn/czIlDZ/58MDzn3qbKEfSFUQPq5wmuE5GwgTqBAE24Th/qAzh2kzZFhj0YyQ
 +AOcXzfxk0Q4lTtIZwGutxPAU
X-Received: by 2002:a17:90b:4ccb:b0:387:e0bb:57f5 with SMTP id
 98e67ed59e1d1-38e4b57c2edmr4367640a91.38.1784320989055; 
 Fri, 17 Jul 2026 13:43:09 -0700 (PDT)
X-Received: by 2002:a17:90b:4ccb:b0:387:e0bb:57f5 with SMTP id
 98e67ed59e1d1-38e4b57c2edmr4367589a91.38.1784320988324; 
 Fri, 17 Jul 2026 13:43:08 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:43:07 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:34 +0530
Subject: [PATCH v2 9/9] arm64: dts: qcom: eliza-mtp: Enable Adreno A722 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-9-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=826;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=X8RDXfBHklja5EB34gmFlxaH7HzFaYeX4Z1IBHMoit8=;
 b=9Q8iDnAw0MhJOK5ZVzp6qxDBJ1QRxddOheLScWmDbidXJrIMQnonMmlM6v+PtlCEEzK/dtESK
 DatlP1RAZO2COPGL6D6h9BFfbWY7fTmJpoXiY4tftEFy1+oli76Z++j
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfX08tYxEa7gty1
 TrzlAvLN4tv6dO/CchKnovmfzy7JemzwDuN5pfHtC3l3jWK03yt8yzttVuYGrd9oNM4M8AUXUlx
 nu0hd9R+Mq10JthoBIiv+vc0ebc48E2a2ECcys1gtOuudoaCEPrJefAbC9WijGzPt+KXMow/+0r
 EYn6plaQ+99bBNKUJC5JXvUfMfI5aK8MMW5Y8VO1e+L6NJ+aKzar4Lzx9W0HOnCrUxOppBcGXmI
 hmqL6dCPrbLQRZ3aArMjafK6T7t4akkvusPxj2oBAZ4tC8rB87BqlAZiaOFjwfAl1qh+TFygLoj
 w12gBsFHSZjBBEJFyG0cFIkyjuAA/YZpoP7RnN5bzSXY4HCKHpn1UWtUzcLa0L0EA0zN9NaNvmp
 xmtgCMPAHMvrjmlfdC9y+RRFivfXo6p8m4vJCGzOf9BRa3hs5PyPvmBizgOp5XK1jHPQs83CMQR
 PzxftH8fK4BXENg6YTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMyBTYWx0ZWRfXwEwXQbMU8P6T
 SkQMQQ0x9HMOZZjDUNqz6Oir8a2bfhhotF/LXXgCr4OV7QKSJYvCmGM6WqkzLmd3oCTj3y8Ue8l
 7DXO99S4nY5eQoSzwiwxodt6R3Ab8WA=
X-Authority-Analysis: v=2.4 cv=YeWNIQRf c=1 sm=1 tr=0 ts=6a5a93de cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Xl3f10jGzgz6Ja07nhwA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: hO8X9qzrI7fnjaM-DbllI6islNEuCd_o
X-Proofpoint-ORIG-GUID: hO8X9qzrI7fnjaM-DbllI6islNEuCd_o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170213
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

From: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>

Enable the Adreno A722 GPU on the Eliza MTP board and provide the zap
shader firmware path.

Signed-off-by: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/eliza-mtp.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/eliza-mtp.dts b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
index 1374afd9d14e..a6e24d2e3b42 100644
--- a/arch/arm64/boot/dts/qcom/eliza-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/eliza-mtp.dts
@@ -417,6 +417,14 @@ vreg_l7k: ldo7 {
 	};
 };
 
+&gpu {
+	status = "okay";
+};
+
+&gpu_zap_shader {
+	firmware-name = "qcom/eliza/gen71700_zap.mbn";
+};
+
 &mdss {
 	status = "okay";
 };

-- 
2.54.0

