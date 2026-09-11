Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F9C88E50
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 15:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 206D010E3DE;
	Fri, 11 Sep 2026 15:37:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="es1DConp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FwkxEHcx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3575510E3DE
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:04 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68BElxGX3748689
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=NoklEjEHefOp4rYdjJllOB
 /b4jWlzIWDGBqgFGK4+ls=; b=es1DConpLm07rfbb5R8DWZa0t7NaoJSlylMZOn
 SkS4sG7SJ2vz+Wam55KL+G+rgxIbnJc6Ep1blSkhhR3CiFF4Hy7BglscniJ3GgMP
 zN+OG53cUjaZOknP10+Q0apmJKe8mNwHvj4KvorISy/D42OgKwudg5YKhjlQPKTj
 D2faayLi5hDSFzhpq9SSdbpJx86EVAo2LJ0iQg1oJk3nBmbvu6p2aFSaWwR4BlK0
 JTXKort3qx2hVZ7NIAE4X8DojI7YmQ6vG7pbuRU6RhTFVJIQFVdUMJkAi53C5M3G
 6/oDNfKL28EwPi7Egap/M92LcVWtal9Nw0uJaZBGwsTJizDQ==
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm729kfec-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 15:37:03 +0000 (GMT)
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-4519ef1babeso787540fac.2
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 08:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789141023; x=1789745823;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NoklEjEHefOp4rYdjJllOB/b4jWlzIWDGBqgFGK4+ls=;
 b=FwkxEHcxVKsfiaeeG14o/+P2f1BACa5XdoMU6n5FgTUFZspzHGGRgtUMTiyvmpPgxZ
 1k5n9/5+5nd1vI7byMsfnpvB3TQiuep5u1qDsxuX0HTiiDBzs7ndn+tzoXZZoXJJvWVb
 31Bdu9J1Tt3u+TWb2Qp+7pMTTE4l9K4PBiQNLejPW/Ta3cgWiObsnuOUY516sipHZUZE
 RjbjiJuQ5Ua95p2QjwXxYM0GRJGnycF2TjOovcsMVMAs/Wm85Icu+8dRXKhL/uE0p0rB
 p4NfF30bL9B/PSX72cumA9ZV9OWEgH+whJt6LxsmYfhbs/ecCLIQ91FIyR4enlcIbS7B
 L/nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789141023; x=1789745823;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=NoklEjEHefOp4rYdjJllOB/b4jWlzIWDGBqgFGK4+ls=;
 b=FuMtkUNiHHpZmqrXNsK/2HG3htRrnz9dCEB+wqbTVUbAwKuZJiGK+zU8xjjPM3CQE/
 3RxbGn64GguCPRWvu8ZGFvdo29o96J6ykiUxIdGZlToFENEDt6VZpHpalkOOQpJ3s4Hk
 nx7sKXtFYHEwIdc5OPUW6fA/0II0YLaqr63O8WYUSrzbimAuJ99XPjTqI/AMhgDF1qCg
 prwg2WVVOFpGOQ/hlLAprF1K1MsHHN3NvEsY7YfAKVLk1uG+xfED5Eiw+SVJQ7cIIK4N
 kIE8auchpDuJ2uGV/0iEOPbsSrn3KbTPHt8Zb6H7BTTXher2wo2/vT8iP8MlqRNVbozV
 vxqQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3pU1kBkWh+qbqg0tGoBLrmiFOr9vSZh2m+06TE7V1z/p3473/LyEbitobtFSMw9WBkiwA6M2Fbr0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKLjw99gyD/WloWlfjFLbMdM6yRW2hsMEEuYnQC0+lQC/DY/S5
 u/lY9Rb74TFvv6wwCDmx+yIdchycCvjluLFLeKQARjsTsy5jHrYLGeRJXNYJ/FnsrgXkOjrTt2J
 h8NQ89bPh9O8Ltzj3F0hO/G4i637IPS/ygpO6DDM8MNiSQG/mOg/lcsPzLB4JK/8Yn2Xab58=
X-Gm-Gg: AYBFou185RpmN/MWaUiW8ma0sSTYh7wODKwB7fYmzMiAeJaQI29Cpna1uIeRzSK8cUj
 xUqUCtZVPs7Qwv/8pssV6mzIDcn1qBf6JaosDQsGIu5lvuSJ/Ae7PNclG01fwYujqTCtfJF0sY3
 wTT+3d6CIDXkHNSTaDih9dFGo9eEz5iLi2kWbN+J3uJ17Rh94XFyIGPjG1HmqVCF6pSe0dwiJEM
 11za8rR2YBRzo5I/tgiC6NeiQLj4IU+jQDDC8E2fmFNqNMSJmoGSRQCJaE6c+DbM1QA/VmrxfKf
 x4ZbYWlRIKeP52cONQvQXiREACvEiN71ULePKmHKJOHUy16IOJnaW3HztPBK0yXnnCmAy2Et9CM
 yqHtY+dSUwiamcGSrcIrqa+OCt9s=
X-Received: by 2002:a05:6871:828a:b0:475:e0a7:9f2c with SMTP id
 586e51a60fabf-47de95f77bemr3653790fac.26.1789141022816; 
 Fri, 11 Sep 2026 08:37:02 -0700 (PDT)
X-Received: by 2002:a05:6871:828a:b0:475:e0a7:9f2c with SMTP id
 586e51a60fabf-47de95f77bemr3653743fac.26.1789141022347; 
 Fri, 11 Sep 2026 08:37:02 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df90ff148sm1882160fac.14.2026.09.11.08.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 08:37:01 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH 00/17] Add Qualcomm Nord display and eDP PHY support
Date: Fri, 11 Sep 2026 21:06:31 +0530
Message-Id: <20260911-nord-drv-dt-v1-0-e25c073cf1b6@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8fpGoC/yXMQQqEMAxA0auUrCfQVlA6VxlmoSZqXNQh7Ygg3
 t2qy7f4f4fEKpzgbXZQXiXJEgvcy0A/tXFkFCoGb31tg3MYFyUkXZEykg2dd0PVtBygFD/lQbb
 79vk+Tv9u5j5fCziOE7EmhCBvAAAA
X-Change-ID: 20260911-nord-drv-dt-d09b21f37ae9
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 Nabige Aala <nabige.aala@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789141012; l=2969;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=uZtos5GcxW16bUgCP04imDNSXk4Y2sw1hsgfG8ryyeU=;
 b=fvlgQemdYfvMPG2C2gg7mIz0dTtNx1itQVQos4yxGflmCrffKnuOPCQ1TeWCAjmupxkjNdcad
 MglmLqvQIJMBgE50me0cbTbNltdvQKecJlrQVeJODZH2ZN/I8/pxFlv
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX/48SWET+ustg
 k+xpQ24EOWogH2n8pHaiDc+Be3tmwTFUQlbAeRkiSLksld9ogSZf02VfB7WQ2gRxborqDnF6vt8
 plZln8kVFDJBol4TDoAoe/xPJ/pBaK4=
X-Proofpoint-GUID: kHf4ezycl2rqmZBgkEkvtGdtDJv_aVJ6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIxOCBTYWx0ZWRfX954CHgZe7c41
 6BgkWN6bmcERZ9UzarDvvtWa7/j4OCBgnQ1G65tMQL2rNLcQMnFSVkhu3UG53ykbtTPaj7J4zVv
 STRhdNuhY9ll5MLIKYzN/MZGLiKKa6NyrUPutOZKIEc8N9nRkIlIj7q4fHYAZPqiSRXe8f8JkmP
 dW7NNL/ak7NpWsPyWQgg3UIpx4LBA1JMfJbSGmmGICVllBUODIMQLTm3n9Rcs2jzQck8BdMEosV
 ZDu3XW5G2sF7MkAuCmyIa0e9tamkRYOzn7m/G1naakyZgYhPMjMgZFpi/OZ3a72oTXTlRg9o7eV
 qKR67WQXXTKwV0GX1I/6sMv2rcOXAFO2GAQOvCPxrg8pNKyxxhoXwY2kfPjt+swZue3WGYxCfMD
 fbwemUuH2X5J6jYnZ4Fsidt9RFhFh5kG+3iySVkbTD8WV6KbJ4NDyFV4UkUVWu0pWvQF+0873IA
 f7fjjf/VYN57n14BM9A==
X-Proofpoint-ORIG-GUID: kHf4ezycl2rqmZBgkEkvtGdtDJv_aVJ6
X-Authority-Analysis: v=2.4 cv=AfwkjHXG c=1 sm=1 tr=0 ts=6aa4201f cx=c_pps
 a=CWtnpBpaoqyeOyNyJ5EW7Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=PFInfxxGytTXtyWs1EMA:9 a=QEXdDO2ut3YA:10
 a=vh23qwtRXIYOdz9xvnmn:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110218
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

Nord is a Qualcomm SoC with a DP-only display subsystem
(MDSS 12.1 / DPU 1499A) and two independent DP controllers
backed by eDP PHY.  The PHY uses a different register layout,
PLL/SSC coefficients and TX signal parameters compared to
all existing SoCs supported by the qcom-edp driver.

This series enables the display pipeline on Nord by adding
DT bindings for the MDSS, DP controller and eDP PHY, DPU
catalog and driver entries for MDSS and DP, and full eDP
PHY support.

Tested on Nord Ride SX board with one DPU. Both MDSS and
DP controllers probe cleanly and panels render correctly.

Signed-off-by: Ritesh Kumar <ritesh.kumar@oss.qualcomm.com>
Signed-off-by: Mahadevan P <mahadevan.p@oss.qualcomm.com>
Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Mahadevan P (6):
      dt-bindings: phy: qcom,edp-phy: Document Nord eDP PHY
      dt-bindings: display/msm: dp-controller: Document Nord DP
      dt-bindings: display/msm: Document Nord MDSS
      drm/msm/dpu: Add support for DPU 12.1 on Nord
      drm/msm: mdss: Add support for MDSS on Nord
      drm/msm/dp: Add support for DP controllers on Nord

Ritesh Kumar (11):
      phy: qcom: edp: Add Nord-specific register offsets
      phy: qcom: edp: Generalize power-on path to support per-SoC overrides
      phy: qcom: edp: Add Nord AUX channel and VCO divider configuration tables
      phy: qcom: edp: Add Nord voltage-swing and pre-emphasis tables
      phy: qcom: edp: Add Nord PHY power-on and reset state-machine callbacks
      phy: qcom: edp: Add Nord bias and clock buffer enable callback
      phy: qcom: edp: Add Nord spread-spectrum clocking configuration callback
      phy: qcom: edp: Add Nord PLL configuration callback
      phy: qcom: edp: Add Nord LDO, TX lane and TX resistor calibration callbacks
      phy: qcom: edp: Introduce Nord phy_ver_ops and phy_cfg descriptor
      phy: qcom: edp: Register qcom,nord-dp-phy OF compatible string

 .../bindings/display/msm/dp-controller.yaml        |   1 +
 .../bindings/display/msm/qcom,nord-mdss.yaml       |  98 ++++
 .../devicetree/bindings/phy/qcom,edp-phy.yaml      |   1 +
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_12_1_nord.h  | 588 +++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_mdss.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dp/dp_display.c                |   7 +
 drivers/gpu/drm/msm/msm_mdss.c                     |   1 +
 drivers/phy/qualcomm/phy-qcom-edp.c                | 416 ++++++++++++++-
 .../phy/qualcomm/phy-qcom-qmp-qserdes-dp-com-v8.h  |   3 +
 12 files changed, 1107 insertions(+), 13 deletions(-)
---
base-commit: 693de981a44b0e7e3b6a73f0b0bcbae9c8d068e6
change-id: 20260911-nord-drv-dt-d09b21f37ae9

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

