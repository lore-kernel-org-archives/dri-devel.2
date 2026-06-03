Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BFFFCD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 14:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E53D112725;
	Wed,  3 Jun 2026 14:59:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGP0dkdD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XmbrJwm1";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37B87112024
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 14:59:40 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 653CqTPk873803
 for <dri-devel@lists.freedesktop.org>; Wed, 3 Jun 2026 14:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=OHsKV+ltiKXXlmj8cUFWo9
 IbTkRATlv2GK6UqkbO9h4=; b=LGP0dkdDB/zIX1VP4TSAhzZdDunN+X8a21fjfc
 kWdA25gpjcSUH4hBGFoMDe15TSA5J62MDzzfPpR33WVdWY5QlZ++2ocwmD8DT0im
 /CSnTGyUec9kqbVoNIzXvCLbZ8wHhm/fdT8tjf8lY5rs/G3h0wUxJWQGUg7JqnT9
 tbuLiIZTgtxwggkRGdUQshxJsIEP8se1b4FYjiD4OHnlhAKYXP3p4k4qBszLFiS+
 89EVsCwGN9DfKnutMcAfcVKnQrhO3cxak98I09t18A514ss5hzrWZIPhKJD8GTdA
 JrkY9YAEbCBdbioM3v58dOE13HczH2Ce4JRf5CnK/KXN9Hbw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ej6a9m1yd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 14:59:39 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8596e4272aso4751646a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 03 Jun 2026 07:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780498779; x=1781103579;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=OHsKV+ltiKXXlmj8cUFWo9IbTkRATlv2GK6UqkbO9h4=;
 b=XmbrJwm1TXSYQtL4dvT1yK1VRS3ANZfM7hoZLF8n8GNz8AmaqATFYgKYkJRZZRcJNV
 2UiqVnWkfr9qsb/+FwDueBj1QTnlUL9EPHG7pjW3v+Mayh5dj3Fj/mjTJwBzmFe4ecdW
 RFO0KCLeeamMOwavdiCdVJx0gJnXaYkc9ina5ZzSIfjTt3svDRk1OPoNu1ZLq1WJjcY2
 8PSsWfugXCG4C1e8AnayjdkyhT0l21NsoN//qgZZOXtGgqwMzhPll6Nwqqo92ZtYSwjj
 q5MikeTjJ0K8D3lyzLUkSx2sHxMTQXjZG6kJxKSu1ob2iR1my9/xREO0QMDBT2dvPu98
 bGUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780498779; x=1781103579;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OHsKV+ltiKXXlmj8cUFWo9IbTkRATlv2GK6UqkbO9h4=;
 b=BQ5MMf4s6CXWJd5dAfokVLzs1LrjL6GUiqlWE3WC4LAOFbBWdekGs35fe+bLC4NgRL
 bzVi1zNDPvl7xURO618qF89GJTAvHaacsLmx0ungdl/+sIyVEWNIojC50g9mpC+8YZz0
 zxzSJk3CwPHu6SoRb1JRTCivwz+YbP/OXGHjFx3Jktn7jKUpjOXrBdI7napSIV67g171
 F/LvTobI8qHEESXyNMAd66FNc4+7NJXFDIc24g4WdQQQTkDDZq5mxr/l6XV3udUUk/60
 7WG3MTq+w4TF+ySfeRLCmWzUYo9Naz7Q9X+nqj7fnFadexGj1zhrlw0+ZLjV2R9w6JAK
 8kNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8dQjlzy/tCefgVmvp06MHTm+iHamIe0lAbepxHvLsQLNTRnQZXkoheKNVdchw38K8HL7uBoeJXPmc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRPbvmGMHEXRKPpzwhd1BbHHXj+yAK5Gf6hQrRukDFBRGanuV8
 aa3gcgleQSPA8vtqrHyStfS5BxhuvmZDAQckoVXnfbjbu4UFXqMiNUzWBKQLP8m0i4faVRCNrXz
 9aP87QgaprXJYkH/BETJjQLOP6sV5NaWZ6mtK9fm0lnTabOlfQ/qSeaPGjX2FlqOmsi32Csg=
X-Gm-Gg: Acq92OFswnSrKEOHBwZ05ynEiF72dz1siP62y25ZFl+qQEgiwi+2rHPMmtvGxePMpBX
 1ZtCBAWtve4aNoBAGDOd58QZuan1WkDVEW7Kk4ylPKG//Yy2Zp+DTB2xv7qBRTde/UeeMhmP1he
 sA0qcxzggglKliTWvf6DXJiaTsP+PJQsUJ85xjJLfSAhJlMGz1pMt/1qmVB+0jGzf3EtDCu5L3z
 TeopwVzO+zpm3bR/qvVqr7cHTrGzze6A+k6xyxnXgl60Agwjna6c5Le7dokYqE1UpqZQVIO1ga8
 w6DS9m4Rg/H6CJMpONdedHPxYgaPyp1QA8LOw4c0lSawU1L6iv7GXEpxJGLmoZZCcrcdK7yB3uU
 2px+vUmcSBXasHaB+4ha6Dry3znhJLxzqBe694vNoeMY78Ww7r5wZvC0iY54=
X-Received: by 2002:a05:6a00:4085:b0:82f:6e9:d1c3 with SMTP id
 d2e1a72fcca58-84284ef2c4cmr4096585b3a.29.1780498779046; 
 Wed, 03 Jun 2026 07:59:39 -0700 (PDT)
X-Received: by 2002:a05:6a00:4085:b0:82f:6e9:d1c3 with SMTP id
 d2e1a72fcca58-84284ef2c4cmr4096526b3a.29.1780498778597; 
 Wed, 03 Jun 2026 07:59:38 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282882170sm3747409b3a.30.2026.06.03.07.59.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Jun 2026 07:59:38 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH 0/5] Subject: [PATCH 0/5] Add Shikra (QCM2290) display support
Date: Wed, 03 Jun 2026 20:29:25 +0530
Message-Id: <20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE1BIGoC/yXMQQ6CMBBA0auQWTvJUJMWuQpxUdsBRg2QDhAN4
 e4UXb7F/xsoJ2GFutgg8Soq45BRXgoIvR86RonZYMhYsnRF7eWVPEbR6e2/SM5ZZ6hq/Y0gR1P
 iVj6/YXP/W5fHk8N8XmDfD+zSrYlyAAAA
X-Change-ID: 20260603-shikra-display-07767208fa90
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
 Conor Dooley <conor+dt@kernel.org>,
 Krishna Manikandan <quic_mkrishn@quicinc.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780498770; l=2627;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=tlczd3hbO7jRStxmbXwY/7Pvez+jwqK8qrOvD2gZiqc=;
 b=NuBmKboJ2e9mtFWMrrsLSiNUZwFZCNOuWYAD9ECbT/obdMO75IR3X0zKzn8SsFhx1YCJYfXpd
 t5w8rKtPPLWAIxXudncUKr9Kq4VWoutNylTrUaf1UuMDOP8r2sgYGcu
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: ip6mVSVn-mnrMuls-1Nefb-TcoJsE3Zg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE0NCBTYWx0ZWRfX/1WVm3PUqChi
 XFlXzMGBO4bd5TDT6GTveiVxAlmrvpoyfJ+toaXAgtAGU7xZtP5/i3RQZyUNCX/Or2QzJZOcNZW
 DbHjNR0lY+ZD5M8AVESHH/xZK1aD8pDg3BbABRnvd158iHSY3WIwJBOTAURj7VtiZpsMpMSxIJk
 rq3dlQR//6plrlgQSQsfTpejUmuUDYzzbYD3lIR8frAXxDWdG10xiCcrLafW8DqKaFZmdeb01c6
 NiR3/zJeaByBbRgMbiZPQNPV8HyPmwgAzP3M83ZvVNEXJQ24QTlpwUcsdpvgPYQdwNS0c1ZAiAZ
 xk2gl+ohmhWerI5uQY1idZVX0ueZSrcx5b/WxqOAS0ajB57z2FAuO08ge9UYEJBSyLcSQjrB77L
 PSXr+5fc0seCPxbNjTcKQUKcoAdHmsKNkUkO/CPWdhGMJv5mEKoBOHf1Ve1wQptAhrfyoMnNWP0
 CjZKbFebIHhpvnXt4aQ==
X-Authority-Analysis: v=2.4 cv=I/9Vgtgg c=1 sm=1 tr=0 ts=6a20415b cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=sFAlhcv5WihPgsyf0pgA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: ip6mVSVn-mnrMuls-1Nefb-TcoJsE3Zg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030144
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

Shikra (QCM2290) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU, drm/msm driver entries reusing the QCM2290
AHB clock and DPU catalog, UBWC configuration (no_ubwc_data), arm64
defconfig enablement for the ILI7807S DSI panel, and explicit SMMU
client table entries for qcom,shikra-mdss.

Tested on Shikra EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (5):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  drm/msm/mdss: Add Shikra support
  arm64: defconfig: Enable ILI7807S DSI panel driver
  soc: qcom: ubwc: Add Shikra UBWC config
  iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU client tables

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml		|  1 +
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  4 +++-
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 34 +++++++++++++++++++++++++++-------
 arch/arm64/configs/defconfig							|  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c					|  1 +
 drivers/gpu/drm/msm/msm_mdss.c							|  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c					|  3 +++
 drivers/soc/qcom/ubwc_config.c							|  1 +
 8 files changed, 38 insertions(+), 8 deletions(-)
---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Nabige Aala (5):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      drm/msm/mdss: Add Shikra support
      arm64: defconfig: Enable ILI7807S DSI panel driver
      soc: qcom: ubwc: Add Shikra UBWC config
      iommu/arm-smmu: Add qcom,shikra-mdss to Qualcomm SMMU client tables

 .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  4 ++-
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 34 +++++++++++++++++-----
 arch/arm64/configs/defconfig                       |  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  1 +
 drivers/gpu/drm/msm/msm_mdss.c                     |  1 +
 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c         |  3 ++
 drivers/soc/qcom/ubwc_config.c                     |  1 +
 8 files changed, 38 insertions(+), 8 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

