Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646FACD484E
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 22:24:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F8F10E8F7;
	Mon, 11 May 2026 22:24:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="b3DMw+w+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="g4PM1QrM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009B310E8DB
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:59 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BK6j812573994
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=; b=b3DMw+w+N/9GxBUS
 1NB5SWDv4tBz7QN0HA/VcqtKp0QGd1l9LFbuooFJCjvq9aMt98zzNa5Abs68fRA+
 cLQZTb+XaFkeRQxPHcl4NdKM210kU8S0xUZ4iJEssut9MJQ628Gew+i4YvfoDjeM
 Y8EJdSoIkd30D5tJWHr183dw8Wvr6CqUWrvfcMHiK/E9uMHeiONFwi3QWlDh+Is7
 Eymm1a3jPTpHYJOJA29abjOuEOcrMjFA6lXrYeacIi7oDfzfsLnyNKItau6eynO5
 QtFHv8YxboWx1SDVOQCM3rhHqieAqBbbmf5sX+ooEkBXBvzprMos1nFXtRGcA+ig
 vL1a4g==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3nv28fbb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 22:23:59 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba7662827fso42567685ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778538239; x=1779143039;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=;
 b=g4PM1QrMWZrpyyinFINe6sHnPthR4cAa3XzdpZefHgbQQlrUtzMcDxTT/u0hXr1g/L
 Hs7ExRZ4znN1dOmU0Gr65uM66oMi5D1PuL3oXulaK/zMbF0ZFXbIi2BtD/UAzP6P5F/C
 vCDBoFSQH5yX8/cAmq8KGWSOThxb4sOfyVbpcQ3aPAqox8Cmiwt1zrV1VacPaeBKKUag
 m6u6++4WGgtX0vnqQljI55jMiG6MxvFsY4RK/pv5+oi+fm+EuhUQSYMNAcL8w604mTLb
 ZjfxuOeKaAS2HPSYmh0AoNo5V0DB5VuyxVriDCE0PY+OTLhwQbcqLcDY41n0SrrOTVT7
 Qc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778538239; x=1779143039;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=R7Frk5q2FbrccyAZoFFWXLc+MXICjLS7DMiAdsGdoHA=;
 b=PgliEKwbaywzDvMB3+IjlxQGsgzYA81Likis/dnyVw5ApD/p92SJmromRHnt+ewarx
 ryBgnawppTOol7sGYec2efU6xA0Fczzrf7bK3kzyutkObtWcRp2TM5DcNJcAnPeiIhyy
 49fdZj8K+3PuqfZzRludreSNeWyjUYuEMN7+WKLM30qdLgNt5A9Wl5cIghbeswnfxI3M
 mhonhIEidFFK6AlgpR0sLZ49A1IQGDU2ytuJgPsnPXSy/+F3AjLlVoMGz1xhXNJHzA0K
 GI0y2MAki0CY9KWwXYKjot473F7HJ1EwltQFQHmN0nNSQdnG9D/H+dFN2ceVDksQIYkp
 84Rg==
X-Forwarded-Encrypted: i=1;
 AFNElJ//iDan7mvapGVyjDKiFl8prB1xHYfYzYkY43/D7pKjUQPSjGSDVrqxDsn2OT+T/a56Hj9PvLUqUjc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo81gR7IjiRr7C6wCmYSNwXMcaeTFbjJcf0J6ebZ8UB6mvjj2v
 YTU8mlGk1lLdtoBr1N8C7IRFwa98DeDkeLScZ6M/HIA/nm4On5fLFcnXFJ2ZE6Z2u/QTSx93jTK
 dujWQSECt3gPsCEaLlLR6JQ/mO4tFs90RYGDTnF5frYw3WPSIeVH3MRAkc9QcsJlqoDo3AHs=
X-Gm-Gg: Acq92OGxa6ZSpP6PyJtdg0iu27HN8e4O8u1jSANygDyDs6mgv/IJh6ukGWmVhNubWun
 CaZUJazUilfpOqcpWnuCAqSVf242Rxnp4IfphXm7mq5Bh4y4dqzEpNOcPjzNPmdFKyseFpv+5RO
 Z/znPUAoHFhHJsaOt68dWYizxDsw2R2eHeP9/T2Kz59RRJ1w8l8PjcKgJg2ZYGulqUxkz/c0IG5
 Vt9PDX8TX0JYTWabsel81DdL7a9jn7AvJZ4ZK+agJlHyA+dvCGpf2+wImcOdF6jjLOwml908/IO
 CqOmDhulZEYh9Mnc9Jfw3RKMC/g9lB0pot6mnB+jSKIGlGE82912G6n43J4xuKqUJcrzdon3HET
 4O93PzF8hhxUqS/VInQC1mGr1KKh9QNXvG1GA1sDDYWsGvA==
X-Received: by 2002:a05:6a20:9144:b0:39f:c93e:c7f7 with SMTP id
 adf61e73a8af0-3acc3538b93mr1274540637.0.1778538238642; 
 Mon, 11 May 2026 15:23:58 -0700 (PDT)
X-Received: by 2002:a05:6a20:9144:b0:39f:c93e:c7f7 with SMTP id
 adf61e73a8af0-3acc3538b93mr1274515637.0.1778538238163; 
 Mon, 11 May 2026 15:23:58 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965946543sm27028110b3a.16.2026.05.11.15.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 15:23:57 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 12 May 2026 03:53:17 +0530
Subject: [PATCH 3/8] arm64: dts: qcom: kaanapali: add the GPU SMMU node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260512-kaana-gpu-dt-v1-3-13e1c07c2050@oss.qualcomm.com>
References: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
In-Reply-To: <20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com>
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
 Qingqing Zhou <quic_qqzhou@quicinc.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778538205; l=2262;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=rscpl8C0bBlWpsGZRfQr8cfwna3yHTFswaa+FyKvunw=;
 b=coHh6zS2m9SCj16Gzyz7t9BkZ8HEBuHE4W4uPRbQpDal5KptphD8Sputqj9jokSZ2d48QX9E4
 JAbZtSW1QrVCU4M5AZnST+pgHSljyAF0noTa/1EOUAF/8SwP5RojBAi
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=IsAutr/g c=1 sm=1 tr=0 ts=6a0256ff cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=XZrIUYhEBg08vmH-lqUA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Nf2Dkh-E6lUlozwpRXq7n_avopjFM1_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDIzNiBTYWx0ZWRfXzdZDDxiNA3g9
 A03RdZQUJ1b6/EBKt9gAIF6NGIiNybmCFRKUQOgQjUJ17vIJYxpmyaZjnV9iHZIl0tzwanEyefc
 yMD3xHmuhHxTqdw2UJW06fJLMhi0nNsqJX8GubGgJ6yWuEsvXwzhZfAISX2wBEMLkZ4kmCyhQrg
 hPE6D0Vx9v3u01+bfeSXid+SehTMxabT0d3dWyn8PXxkYN5UTlkeki53yPOocNZiRm10TyZQ/et
 znzAdUhVYzUcdxgj+ckxqt3iQ9k+fmgzb2EKSCrEFWZVTdWCbyhqnKkEcpbNaB6j6cKvHUXMtNv
 yvgbFbed0e8k3Dz56U3ReTRiiVCbahFhx187ZPkpVL4+xtDJOBNP7H90/6YEYLm1iNDyewOJp9d
 YxpzV4VugH575THjdmaega5eQ47Mwh8ZDoAfmzmQk3oIXFJET6Qcerod2aXVRttH5iUXR7kIoVh
 i+GYWXnrTuAbYJNDv6A==
X-Proofpoint-ORIG-GUID: Nf2Dkh-E6lUlozwpRXq7n_avopjFM1_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605110236
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

From: Qingqing Zhou <quic_qqzhou@quicinc.com>

Add the Adreno GPU SMMU node for kaanapali platform.

Signed-off-by: Qingqing Zhou <quic_qqzhou@quicinc.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/kaanapali.dtsi | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/kaanapali.dtsi b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
index bab654bbd6d0..26a4de9c8d45 100644
--- a/arch/arm64/boot/dts/qcom/kaanapali.dtsi
+++ b/arch/arm64/boot/dts/qcom/kaanapali.dtsi
@@ -2597,6 +2597,47 @@ gpucc: clock-controller@3d90000 {
 			#power-domain-cells = <1>;
 		};
 
+		adreno_smmu: iommu@3da0000 {
+			compatible = "qcom,kaanapali-smmu-500", "qcom,adreno-smmu",
+					"qcom,smmu-500", "arm,mmu-500";
+			reg = <0x0 0x3da0000 0x0 0x40000>;
+			#iommu-cells = <2>;
+			#global-interrupts = <1>;
+			dma-coherent;
+
+			power-domains = <&gpucc GPU_CC_CX_GDSC>;
+
+			clocks = <&gpucc GPU_CC_GPU_SMMU_VOTE_CLK>;
+			clock-names = "hlos";
+
+			interrupts = <GIC_SPI 674 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 678 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 679 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 680 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 681 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 682 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 683 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 684 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 685 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 686 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 687 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 688 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 422 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 476 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 574 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 575 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 576 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 577 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 660 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 662 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 665 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 666 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 667 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 669 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 670 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 700 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		remoteproc_adsp: remoteproc@6800000 {
 			compatible = "qcom,kaanapali-adsp-pas", "qcom,sm8550-adsp-pas";
 			reg = <0x0 0x06800000 0x0 0x10000>;

-- 
2.51.0

