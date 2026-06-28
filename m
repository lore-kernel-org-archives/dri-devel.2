Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6A7C43327
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 18:25:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC8A10E66F;
	Sun, 28 Jun 2026 18:25:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zg8G6Q8u";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QtSLkmYx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D332710E667
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:59 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65SHisf5425328
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=; b=Zg8G6Q8uUhjfLb0o
 vSZ9rn1P2sClR3oBYHSJinWJLHh2+8T/RztbOSNnC2SP9lPyxeLZ4MNt4qxvvEjL
 EP7+gwI5auQ8Pb9RIebe5+pxKFrIfaN7s1PR62XM4DW5MPuBQy/MGkCvRtHEHbpv
 4WBY0SXRDlgDMzdIHUctpX2Cophcr/VSKzTihjpfb7/OFZ/RtXTEK6/0BKnEPWGb
 FKi4xsVDVy0pVXtlgrgMHKhh1EQ12Gp7XH3In3b+6X51t5k5pIxpCRd3TvUK4U0B
 p2qeg+y6Frqsevq7Voxl2i6UQVUsHU5+jjbbTxSItKbCJdN8g/yOr7R4pZPRzQOT
 BZbSjg==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f27333e7v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 18:24:58 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-139b62317d0so10802384c88.0
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 11:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782671097; x=1783275897;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=;
 b=QtSLkmYxN7brXpj1sOaK6W0brO6WHh20sqzOirQ8uecmyaMyeel1P7EVRvE3NHfq5u
 1Cvvc103KdhTdI8EhbrAIrdK7uSdMP6t9N1CA/dgo+tpYAuZsrbFbSZTAQ7mbEvPfFQa
 mneot2ZJAjwbCZIzpXWfb2sgKq+8ZHfIGuBUnxyvVK6f/G7PuKHnm5HiVVXg1OeyIP72
 Fv4xzZAmJaabY9ePG1p6XveHftzql2cxTXoyPZTzDCvFmP+v7s5WlCDzL1bJJKO5fRya
 Yl70WeHa91ziKQ2mQwNKFLyaUGoN5Lb/qtuJJK5JR/3bX3lkxmpQ5Qe0Qyf/d0yni3dm
 qxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782671097; x=1783275897;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=IbMc4RrsOe+03o+lMwLAkg8XuHYRC2BTwKASC1wJIhk=;
 b=Msz6vyAAg/0EkmYSVrBQG6tMv+4hTkh+sdyq9yBVQ8WrLQrj19FzLuSJJ2nqC57oIB
 YUX3vcl77UHeJDPxhVm3O4jL2n+qtAiaUqKJe61HNZa7TcZc8uXkGVlV3s6zGTVAhSAy
 4zoKnYkkf2QNNcJGxIvix+5SOBdXvPc74UXWD4K1byQYIXoMn73F1soYw1SUixJVvFm1
 QY3tZzCeuha5mzy0tGCtrD4ghrEPogBb/aPLxYB2Idzyvttq6uYGUpB5V6SwtQNiFyYp
 oovWUaWS1aZxN20uMTzaIjutVw7BC/XRV0J41dk7ohY1XgMSTZaQC5+crv4XCjSbNp2p
 X+7w==
X-Forwarded-Encrypted: i=1;
 AHgh+RoujlfKD6TxuCbwPIqJKuJrfr29JBJ5kcfouPHVjYUaj+HtvllpP0ZLiFgNNF1EZvd03Uxr3UuKVv4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxl7PF3grPxNI/wkcvz49DAyE/pWnn+O1rrm2A3ZL9lm6VOaQHJ
 +gCOHEobTsLj8MY8lNmOSv+ApACX5RcybdjK3qeQyCegiQCKqKo/2fIdcrdcxxIUEhRtlIEAIiR
 Bh7wEbCKDHUCwiAJI2fi9t3P6KWJJZ5AcXdAOOOd9UdBqd1MDsbYXQtpojGO95FZoOu6TirPOhi
 ceOSA=
X-Gm-Gg: AfdE7cl3DeXw1RqsyUGO4fg+USOA11iRL8bU2HF2hvXyfPnpoOj9dJHIwQCvb9XGxGh
 hqKuuaJZ7gY++F8I41J1x6N2yaNz7aBT2LCO6d0mCxhOrWYNUn0i/0Jh0LT+cx9Go2Xg6yauKHE
 2zKdYL1hjfqQBtOhUbpHFB3FFBI0Up6Px3e/hBWVhhpDkiQ6RbgOaXIKZfZrvx15LaX8rG5lmSR
 aEI0h+yZhrC4Qus/U7qi3fu2+qdh/obI8WpCA1ImQ32VvKHSCkkFSF8dvbASgeOfBiH2Jjfj+3Y
 cjDRxarw/m/8/Zk23/iqr2G05B6mBVxMXHQsoxArS9ejdVr8gfdW23Klr0eV/stvSUxVz0fUk9v
 XkU8ReGkm52PxLBGgmvnsrw8CAP+OXeySo78=
X-Received: by 2002:a05:7300:5bac:b0:30c:1b22:646b with SMTP id
 5a478bee46e88-30c84dad33fmr14207342eec.19.1782671097428; 
 Sun, 28 Jun 2026 11:24:57 -0700 (PDT)
X-Received: by 2002:a05:7300:5bac:b0:30c:1b22:646b with SMTP id
 5a478bee46e88-30c84dad33fmr14207304eec.19.1782671096877; 
 Sun, 28 Jun 2026 11:24:56 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c8b1a75sm37508218eec.19.2026.06.28.11.24.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Jun 2026 11:24:56 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 28 Jun 2026 23:53:57 +0530
Subject: [PATCH v3 4/8] arm64: dts: qcom: shikra: Add Adreno SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260628-shikra-gpu-v3-4-9b28a3b167e1@oss.qualcomm.com>
References: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
In-Reply-To: <20260628-shikra-gpu-v3-0-9b28a3b167e1@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Bjorn Andersson <andersson@kernel.org>
Cc: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Komal Bajaj <komal.bajaj@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782671052; l=1886;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=G5KnzOKbF9FC9XZVD3H/X6wimGnOXvf0oUqbBl4LZbE=;
 b=tUNf9WGYMJjAdYic1WiMT87XqmIviOCldRCxeamUi7NGV4ape07i3r+B/0zrufi/pAMBdRgfw
 9nDbsKCIYIfCh5m3IYARovqRiiL0W/Bm4G8HRkLexLCQvUv65gCf+n/
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=F+FnsKhN c=1 sm=1 tr=0 ts=6a4166fa cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zTWU315qYGxAnKAOPQ0A:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: huUW7rEV0vR8xRqdieQSC8S3bcqxifVq
X-Proofpoint-ORIG-GUID: huUW7rEV0vR8xRqdieQSC8S3bcqxifVq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX7YM8geoUtfRl
 dQBTUOmma6sYN1Ny498LTXGfrOGqzsVRjQnXwsnJFRoWq8kSRXTOPrQaoPNjWUjq0/ikdY2Zm3i
 V+D3AFzuS1DvguSYzM06a0mObHePhAmF+lWvHP48ocY36+NZMepPjUeCkFwZ3kBgMtMKKNjBGSn
 l7tUho9gS9XgFqCor3QdEOih+V2gfLDpTD5Xs+eRR7HtBAXevATmE2U+v/C5Nhbt6zMD3447c3h
 fOoP9O+5IUzQIB6By6fVbjurBHYso8jIrzrsMHCn8kWBg15Y9ytufJ8OVeIiH3haLGi1Kqhhs/P
 ZLQeSFmW29Cw2FsFVziU7D8B8Ff8cgcBJkwOghfJjxmRcqdpY3srv3hcd5kxT1UFAKT/RwJjqaA
 YkaELP0RbHn+Kaict9J2LjuWMYFIPK3XiN12ppjCmalzq2QLhee5075b5sV4e0z8qX2M/A/285c
 dV+IwiJbG/RaSL08w7w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI4MDE2NSBTYWx0ZWRfX2sY/n3nVNSF3
 KDVxLafs+cXKwVdm1ItsT3f0RUNs435LmgMeZT7vA7KwslzCouEFiOht+h4ju4xCa/CLdV9DVmu
 1pEIAvgGPaCa7uK9oCRLp9TNB4bkCcg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-28_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606280165
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

From: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>

Add the Adreno GPU IOMMU (adreno_smmu) node for the Shikra SoC.

Signed-off-by: Bibek Kumar Patro <bibek.patro@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/shikra.dtsi | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/shikra.dtsi b/arch/arm64/boot/dts/qcom/shikra.dtsi
index 1ccb0f1419aa..398cb1a4dc86 100644
--- a/arch/arm64/boot/dts/qcom/shikra.dtsi
+++ b/arch/arm64/boot/dts/qcom/shikra.dtsi
@@ -655,6 +655,35 @@ gpucc: clock-controller@5990000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@59a0000 {
+			compatible = "qcom,shikra-smmu-500", "qcom,adreno-smmu",
+				     "qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x059a0000 0x0 0x10000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+
+			interrupts = <GIC_SPI 163 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 168 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 171 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 172 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 173 IRQ_TYPE_LEVEL_HIGH 0>,
+				     <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH 0>;
+
+			clocks = <&gpucc GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK>,
+				 <&gcc GCC_GPU_MEMNOC_GFX_CLK>,
+				 <&gcc GCC_GPU_SNOC_DVM_GFX_CLK>,
+				 <&gpucc GPU_CC_AHB_CLK>;
+			clock-names = "hlos",
+				      "bus",
+				      "iface",
+				      "ahb";
+
+			power-domains = <&gpucc GPU_CX_GDSC>;
+		};
+
 		dispcc: clock-controller@5f00000 {
 			compatible = "qcom,shikra-dispcc", "qcom,qcm2290-dispcc";
 			reg = <0x0 0x05f00000 0x0 0x20000>;

-- 
2.51.0

