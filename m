Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DBDC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:40:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E6B410EADD;
	Mon,  6 Jul 2026 21:40:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HJ/ojeK+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cd7Gs25d";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 880CC10E908
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 21:40:43 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE6Ia1650827
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 21:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Sl1a701shpBJWVBwhh6ZP9
 Kq23RhfGUWyGD/s/IZgbw=; b=HJ/ojeK+rNwO5/4jDzx12MhnRCZul1oJFph8di
 W8Yl3e0LfnHow40KFW26JFj3+W3qYKDV0ThdvEkqL9uRdIcNbMlTnSrTI418lKoT
 HcS+0WsOkarsXHksd1jH1K+4H58sfNwi9+PMddDszR+cbSV5IgeQyDJ+ntG6W7Iz
 zeZrGa5oMyDGOs2y7JVLfXrwhK2cozLNPX66JchWQXlZv4Majx43CqdEbnpXmcCK
 cbRQzCkqDVWxSd4aW+JHVFDzexafSnUjkxgEIqVfvwlrRRVwzJxNQB9o/DOW744U
 0UHJJCZw8g3nXyosAH+SDzix1hWlNzdUwB8TOcyBa8nOt9Jg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89kgu5rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 21:40:42 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2c9ed5caa3bso92925ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 14:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783374042; x=1783978842;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Sl1a701shpBJWVBwhh6ZP9Kq23RhfGUWyGD/s/IZgbw=;
 b=cd7Gs25dcYgTs2cO5k27Ri3zi14fdTpzDR05erqw+p+HqkFA4PbrOM8XZV+P7kLQqW
 l+2i5SuS6wYQLEGXua7fSpUkuAUvW2xI65HpDYnehrForcaV9XGA3GdxaUheo9KWYRdZ
 P0aGwMpIvI1FOrTI5UpFD/TjxpFwMWRs1LKxuJRw+FGaNuYck+co8rG9CIMWB6D3Z6qr
 C8t1en9H3Hhs1PHfnOureTbbNS9uJtcIA8oAPP+kJ33J7qrMzzYyNOY7hMfc+G9uOMfc
 lNnJTBklNo5yFv35spphg177CRiXdyNSsF4eV1rGDQFCQrJ0IxJ9BLnkH5pX0CLar3dZ
 Eg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783374042; x=1783978842;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sl1a701shpBJWVBwhh6ZP9Kq23RhfGUWyGD/s/IZgbw=;
 b=d1w3o6TZLbrjcwz+ALqZWp/ltXugpo0vvZyc7wHPvBGLnh3nwsRmHbijX5pxJ4Dy3P
 6+bYBsvGtZILfn7QeQhumsJwsyPQx336kst+h+3Cuzs/o/ebieF5bfA6yl5l0snlf/XO
 poYsc6p1TtezLxbhTyrYDj6pSxH7xSGlcw39EuTu3Gavbcpm7kzxDTmcb8Gox6uMz6IP
 8S790KsZddZXOOOiApYBX819T1uZ9K1UcC99IxUhC2aSE5O5hzYXTvwxFEctKxeBIlcx
 ANy2v7sF2b6sEmL81whcfTustHmDFThPetNiZenT0utXPjthgDg5hEazzW4VACtDWC2P
 whWw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrhtct/9kY8ZYab/6tp0yPsnfbtaXv+mhsANiS1YmwI7VAJUxKSYM6x/AQTgffZBVvCryuZnkphNUg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwXrg4FN+tMGVRAcQh7xd7AfY+l/PQgEnj4ToH4/MRaqSa1lllz
 +qV7BFx7658J2MH9p3UrhA7kGVHE/50T30AfEXzqFEmCE/D6XJZa/Xfu+BOlECi8UwLsByrme2w
 SW3Qj5rY7SpLx1bnqJ+i8Lz2qTwhUtMsncnZ/M2/Hl4XHE6zcrIQF8eZv0gJqnACd0auiT6I=
X-Gm-Gg: AfdE7ck+I1deL/wGVqRGe2fjPZv1P8262+eEM0OeDp0j9e2aQ+c0+mrDZnf8xmTCZ3B
 29nrpCSu3QGqvMAo2c6uXahRyU2ZvQ2l9VO6HVLzgKHsgipp9nqpIvdgBOhujGqy1pch0OkLUn/
 gMICAu9CvWOxDvrN9PxWuTQI/30e3QSS4wHNyOSfH4Q2/+4QrhbPILCyLYe+r2VZH+XbaUoeQyZ
 Cp5jjMu9iUkj7OKjA7L+60prI9dA/SzoeA8ysS7GueX70V7MSsRxoZ3mnoInfuhnctVS7ubskAk
 ZLDrMwvpuJBj+ZVscgvLNRC8jXB+IrewJaKK6vwZblwnwwo/CJSV1RwdlvQcNyiH5iSoQOWyoAU
 QFJ2OijeqjWsyNi3LQoVQameoELlm/Jfvgzs=
X-Received: by 2002:a17:902:fda5:b0:2c9:994c:9a5 with SMTP id
 d9443c01a7336-2cccaf33717mr555585ad.30.1783374042024; 
 Mon, 06 Jul 2026 14:40:42 -0700 (PDT)
X-Received: by 2002:a17:902:fda5:b0:2c9:994c:9a5 with SMTP id
 d9443c01a7336-2cccaf33717mr555215ad.30.1783374041497; 
 Mon, 06 Jul 2026 14:40:41 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm901810c88.14.2026.07.06.14.40.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 14:40:41 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v3 0/7] arm64: dts: qcom: Devicetree support for Kaanapali GPU
Date: Tue, 07 Jul 2026 03:10:18 +0530
Message-Id: <20260707-kaana-gpu-dt-v3-0-8dac9a60dd5c@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMIgTGoC/23OQQ6CMBAF0KuQrh0zbSmoK+9hXNQyQqOAtoVoC
 He31IUJcdPkd/LfzMQ8OUueHbKJORqtt30Xg9xkzDS6qwlsFTMTKArMuYCb1p2G+jFAFWBf7HS
 JXOZGCBYrD0dX+0rc6fzNjp5DVMP3k120JzB929pwyDp6BUhyiZIthcb60Lt3OmfkqZHmar155
 IDAJXGDpRGo8Nh7v30O+r7g2/gkbxQ/o0S1MkQ0Cm2UrEgVkud/jHmeP/+t434kAQAA
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
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Qingqing Zhou <quic_qqzhou@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
 Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783374032; l=2226;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=bs+iDFNnM8Jvg3DP8d38QXtbWpKTJaOmfgrbI8NBa80=;
 b=aOWgjsH3Quqy/Ba4njoZ6uizggyqsh282W4b6iHuOyw2JsdoW3L0lnBNH6TZEF9o3L50kD17o
 ubko8wpOpbwD/Y9jUT9CfcTBibDg0S/mj6CTh3/lk6huCzK9uduPgpM
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: deCjjBzY9KShXO_zcn0JL2qVQS6HWSmF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfXxdyhoQCGzjJ5
 8x9PLHMb+j9ldyICiB6FWS5JvL2lMUD0oYeExmqVWL17/YkClKMMhGGE6ptNbn0FPP6bCcfVTb3
 6YdqUNRFJNpq9VxIFqnZNQdKHFhNWZsuFWCbRiZEwWQKWN0FTHtoMeuFUPh+N9K5e32SnJuzO2l
 3nNFxvByGh2KciSEAcGP3qJX4GiDqX1i0CAt+uqJ1kMmG9hhdGaIq3sZ7L19GIJnvLYsQ02pMAH
 N9g3Nt6k+Jskbra0RHNclYmo7H6VOAlFdqVuH3tRa0GwgAVOTMjpSjtGtx5o3plRP0N8gyEIbzp
 Da/t4+5MkAzDLFBZgMRNDnrYzgf0gRb/3M7PRu5PDEBqyLAd7hKKsxK1BwVm16X0rVvCByZqBBR
 iVQPa1QXQBZG4LMraJWkfTDsLUQ28/MYvsU6HFkMDTfDU2YKE/lRu/jXIvba2CWXsk4AY0lWOgO
 2ZMFB++DTX1/pi7GFPQ==
X-Proofpoint-ORIG-GUID: deCjjBzY9KShXO_zcn0JL2qVQS6HWSmF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxOCBTYWx0ZWRfXyTgq5/am694c
 h1Wy/9qO0pIjYk5VgWQEKWa/cMAbVqZikqH9G2yeyoRgT1FDs5HksLb/olZ4gdiqKK8W3x7hsbG
 mM/1QGmPzB45en8oUkuKw8t6U+6xhkc=
X-Authority-Analysis: v=2.4 cv=c6Sbhx9l c=1 sm=1 tr=0 ts=6a4c20da cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=RSuC8zd2ZDaJPqFJxW4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060218
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
Changes in v3:
- Reorder properties of adreno_smmu dt node (Konrad)
- Drop updates to the HFI interface as it breaks legacy GPUs (Sashiko)
- Capture trailers
- Link to v2: https://lore.kernel.org/r/20260705-kaana-gpu-dt-v2-0-6ac53de56314@oss.qualcomm.com

Changes in v2:
- Fix formatting in DT patches (Dmitry/Konrad)
- Update cooling patch to lower the polling delay (Dmitry)
- Keep both passive and hot thermal trip points (Dmitry)
- Update GPU OPP table to match latest downstream version (Konrad)
- Add a new patch to allow HFI related structs to accomodate >16 GX levels
- Drop the smmu binding doc patch as it is already addressed in linux-next
- Link to v1: https://lore.kernel.org/r/20260512-kaana-gpu-dt-v1-0-13e1c07c2050@oss.qualcomm.com

---
Akhil P Oommen (4):
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
 arch/arm64/boot/dts/qcom/kaanapali.dtsi            | 458 +++++++++++++++++++++
 4 files changed, 476 insertions(+)
---
base-commit: b96de4afaea292f70aec05d40def1d993c04d71c
change-id: 20260412-kaana-gpu-dt-968a70134c22

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

