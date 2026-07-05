Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C2ABC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:00:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B1BE10E13F;
	Sun,  5 Jul 2026 08:00:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="g785812M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ekSypFEl";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 412A010E13F
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:00:51 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 664NtOX7033370
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:00:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=64k8OwOX7AWdYCpKVex+ex
 yN30K4FzzL3yTqY9H2RBA=; b=g785812MkR0jeIIjz63it8ak8hMvZM23hCqxHL
 gAHw3y0GSU5IGzSsY9Lpyq5hDQM1iUrR3VIVHkI5EMkRn1WCYAOjN9DqbHyXNOnw
 b30ETVxc0qcs+HvO79XUz2kfOSqW5FmG2K2pCfdCRf2+qPoMoN1ocrj4DpNH5HuP
 +ckdGGd+ebrMBZz6AQ0SPXxi7KtfJCe6U/vEfPRVbB8ue4zM5vqJS5uuzPQIpT09
 I6kK4oO5obWjDAceULaMtaTmiUNjvrO9zw0XS+dYxXBCMgxukVlRPdiSWJJAaBhD
 FmpaGiSw2DWjUnQvlM0ljmJvXB5T72eCVAVgFDNayaM2ctEA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf825rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:00:50 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c890bac374eso3035362a12.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783238450; x=1783843250;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=64k8OwOX7AWdYCpKVex+exyN30K4FzzL3yTqY9H2RBA=;
 b=ekSypFElYOCvifq0m+GTdx+qlfcJR0sZgQg6TajjwzGwxdkvNkdOknntsWKuYlxL8e
 2fBDY1heubBBs8ynYTWfCVZHcjLjvA2qtHdNJZDYG4ub5BoN9HF+zq1RfgMB5XAnDz08
 n8w2lHFW/pIeALLzvFburtaXQ1j7AeRP20ltf6OmhN/sWIPrXp93Dn3/PTpzU+CJoe5I
 SWD8Hln/ue2zFzX57g+UThqJSOBJYNNPYTMeiX50b3/bJg/DxshHsHEycCTV2RRlCnFG
 Ct7c0rHuWkj7akzAoQWh5Pc5wk6z9XxEBuflCjcw2AIuPv2SswrNvqbF85ZOQ+2cpjkr
 BCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783238450; x=1783843250;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=64k8OwOX7AWdYCpKVex+exyN30K4FzzL3yTqY9H2RBA=;
 b=BV34VpIfl9G5Zb1Kdh6752ACSmKkreRseWgj6HXoQ+/vjxtV/yYH3tzHw9hR4Pdjlk
 jUN8T2SUF0k9YZ8vJ6WvmJA0mdpBhcpssXj7DN1y5D955YE+TNwLVznjmbB4neH1ki5r
 W7IKPbPajDMJjbw5z0RowcWMJyWgjliw7aNTRx7Hioi0sfx4oDdzrDwNGwWmZkWb+eDd
 e5MS7VFteIchosrCy6aPGZdJrEcKJak8X/z8eoT3aJs4bSjpY3GKuJZyDELO4NAhDSyV
 dmd1E+3tseYm6uA4g2n2EdhyykJEiRe5IyeNrtH44uFmWnzCkcy2lwDR/JuxFc7OIEfp
 nMmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wzuYJc8p2Xsc+d1KUE+xkICrlTttUkbcnFIiqATzObDpcDi6gBW/k9+QNYTSFU80F4EOfyyWqH/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/jTHU7GBzD69zy/OTEMgtLPAYjf96Jw2KyaPTNKWZ+ac1Bjt2
 WViy3bDvZLAoCP6IO2cZrAQGn09SjLgPdPjuny1vYXcbcMHUZcpEJJ/R3EEDfQuRP0NUu/w4LZ0
 jnGYYr3/RyinJOoCsLpa85ciAnFlApxp54bkRJiYmviLixR5bYVcZMJjSBgY6756Fc3qWkGI=
X-Gm-Gg: AfdE7cnEvB9QEE0Vm0NbTdPuZYvjMm05M4je4hYv7pESqTxNa5G42JIJoihAQ2ClqMD
 jUT9ofODtkLAIhfD1YPVxtisJs74jxfTqoGNktOkMrKaVrfOfnwhgz/03VBR7oiGKiQiy2HrJKk
 QX3okhBVMP0co1i7WoEEDp0r7Zl/eW8xbbyLtoNhbL3qKubXmoyqbtFzD2cdBuoKhFVlkZUQ2V/
 1JNn0paV1ijlsXymhwMN51DPEUtcijtFlie+RXuGtqpKSPZSD2/Ai3b3Hn53fyN+8JwGJgEPwD0
 WS07iiSGiw0zYwJcB+2+CsLIpAf2rd+BwXZ3/OnXkVUxmLWbGdKp1LYQsdYt041fDiQf7EQnzYG
 runFCm7xotw9fExJs2uGq77nPz/arlaHaxxQ=
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c03e5916e2mr5800955637.48.1783238449522; 
 Sun, 05 Jul 2026 01:00:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:6e8f:b0:3bf:6c08:fb8e with SMTP id
 adf61e73a8af0-3c03e5916e2mr5800919637.48.1783238448966; 
 Sun, 05 Jul 2026 01:00:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3113c88041fsm7759179eec.15.2026.07.05.01.00.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:00:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/8] arm64: dts: qcom: Devicetree support for Kaanapali GPU
Date: Sun, 05 Jul 2026 13:30:04 +0530
Message-Id: <20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAQPSmoC/12OSQ6DMAxFr4K8rlESppZV71GxSIMLUcuUBESFu
 HtD2HVj6dn6z38DS0aThTLawNCirR56D+ISgWpl3xDq2jMIJnKWcoFvKXuJzThj7fCWX2XBeJI
 qIcBHRkMvvQbdozrZ0DR7qzuX8JSWUA1dp10Z9bQ6DOaCJXAEWm3dYL6hzsJDItyz/88LR4Y8I
 a5YoQTL2H2wNp5m+TnksR9Q7fv+A5p/DTXgAAAA
X-Change-ID: 20260412-kaana-gpu-dt-968a70134c22
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
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783238440; l=2164;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=URQVb9Hu2fuzstaA7s+Dd/pLK/dbkCOd1kpmgoOBjng=;
 b=A5ueMO6pkv7W0jq9M8lYGlP/UQ+N8qJKQmdwVe3f2yDx/gBZObWVIlTiApffHVD2KMvafWnGI
 Wc6rXJ0SU5iDxoEkZ987rQGNfssS9UD+04+9JBd5Mg3XhOBdesECS7a
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: -q1ZdSUd4Hsu-hCkznP3LG-hvpU9JqqR
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX5zrUpE2LzuZs
 5amMRXb+3H+OsEN438I0KPhF48b7Js74YGFvjX4Iu+lEC2HNB00PFTDw5d7pjLRfCqpPdnleCsJ
 8bouDxS0DDiqhj5RXzCbsZcoWNSy6tE=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4a0f32 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RSuC8zd2ZDaJPqFJxW4A:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: -q1ZdSUd4Hsu-hCkznP3LG-hvpU9JqqR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MSBTYWx0ZWRfX8h9w/cJBh6SV
 Vz1XhhFHrWj799paFxySc8/BwKtDX9er+XjoH1ArTglpzqPGFWxh/OZJ2mf0NPZn2q02oojsQf2
 6WcV8mzXngbt3LDtL/+NkmqkRjFjWw1YlDooCOkcejP0d0OPK+Y/bduc9lEjCt0SBQRQL1fYcqO
 3yNHIZMQ57gnfBr4k+sCk623CW2r+hBWQRsYoQ7P17hJUEw2nJsI04s0dTc/QF3Tu4JhsT6E+vc
 vJpckD+YgiAO84ByZN+VzLPipD1iziboAMaS9hWFS/3C+yCRsdGaTkLKXUlTK22RRADneO1yGcM
 aFW+rf5Yu+zj17731KwYBnV8Y7GGsqg/3eozWD0dvZQOPrZEb8DhkN+fHtgs62vIYzdORnrz9r1
 nKZ32Sxutk+26qStag/pbbptdy0GQ/kS9VUMbji5rCKJCS7+1KNRiGP/ApLibhSgdFAGgSQTpxS
 L9OZs3zfeKd9Ts0jSjw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1015 bulkscore=0
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

This series adds the necessary Device Tree bits to enable GPU support
on the Kaanapali-based devices. The Adreno 840 GPU present in Kaanapali
chipsets is based on the new Adreno A8x family of GPUs. It features a
new slice architecture with 3 slices, raytracing support and other
improvements.

This series includes patches that updates DT schema, add GPU SMMU,
GPU/GMU support, GPU cooling, and enables the GPU on Kaanapali MTP and
QRD platforms.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Fix formatting in DT patches (Dmitry/Konrad)
- Update cooling patch to lower the polling delay (Dmitry)
- Keep both passive and hot thermal trip points (Dmitry)
- Update GPU OPP table to match latest downstream version (Konrad)
- Add a new patch to allow HFI related structs to accomodate >16 GX levels
- Drop the smmu binding doc patch as it is already addressed in linux-next
- Link to v1: https://lore.kernel.org/r/20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com

---
Akhil P Oommen (5):
      drm/msm/a6xx: Increase HFI GX perf level limit to 24
      dt-bindings: display/msm: gpu: Document Adreno 840
      arm64: dts: qcom: Add GPU support for Kaanapali
      arm64: dts: qcom: kaanapali-mtp: Enable GPU
      arm64: dts: qcom: kaanapali-qrd: Enable GPU

Gaurav Kohli (1):
      arm64: dts: qcom: kaanapali: Add GPU cooling

Jingyi Wang (1):
      arm64: dts: qcom: kaanapali: Add QFPROM node

Qingqing Zhou (1):
      arm64: dts: qcom: kaanapali: add the GPU SMMU node

 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +
 arch/arm64/boot/dts/qcom/kaanapali-mtp.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali-qrd.dts         |   8 +
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 461 +++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h              |   2 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h              |   7 +-
 6 files changed, 484 insertions(+), 4 deletions(-)
---
base-commit: b96de4afaea292f70aec05d40def1d993c04d71c
change-id: 20260412-kaana-gpu-dt-968a70134c22

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

