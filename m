Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C27CD6E6B
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:31:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5CE1127DC;
	Thu,  4 Jun 2026 12:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H3NI3kj4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WQOZuP1V";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92CAB1127D9
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 12:31:14 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6548UXcf1132197
 for <dri-devel@lists.freedesktop.org>; Thu, 4 Jun 2026 12:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=oVCtfvOAMMbqkNqCa+q9Cb
 6hDsShNb4EGCU/ePnP6H0=; b=H3NI3kj4ZuurxfJZVm++bRwxL3cJBUp3YZlXUY
 MwZqAuxKRSoKNb7pTolPXWLrEWW/mewM5klj2kkr0E4YieQ7DnsM15srCgkkAVHl
 T/6sm/yKEJZmxZ9QfqkB+Fs1zLKE8yVOYPR+Hs9pvkW4D6xJ2kp0qHU0eSP5P2tQ
 T/WBDbfO71UaczluEjEdzQC30KtAKRwwrLv5FvS2XakzUKvTtB4uRzgX1SpjESqS
 mHXEmjxcXdZBkAPtMO3XKa/yHOT2xyE9L/2rP9HUdBT0/6jV5x0ztjhY16t1GkWs
 4peHABjNr9tIVkG9kF32L/BNUOk8/yqOkNIScjj0ZhqJMQrg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek5wsgw4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 12:31:13 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c8582b167f7so422445a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 04 Jun 2026 05:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780576272; x=1781181072;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oVCtfvOAMMbqkNqCa+q9Cb6hDsShNb4EGCU/ePnP6H0=;
 b=WQOZuP1VoQJVfn60WTp6h6dgLbUN0HblyywwoWej657UnyMd/A4sdwwJyT7GfCcscZ
 KGA69Pwn9HtsqboutSBCwx/ihWEmixIywo2T5V++luCMQwMHTrLN2h/MO/XF0EBD6opX
 /hpeW4gzQyRRkaimt55Mr4rDIs/33fgkN938palCo9XulrgCEUJYYa3st8ciNG/YW7lg
 E03I5LI5TxfJiM/tZ0LAyterm03lRLqLSo/bOGHubXm0JUSj34HOB3+Vo9wj5vp4/axu
 vDFSgRmjLHUYEmxGBXmBmKX0HU/XDJ/K1zb11x+GyGLI1IBX7JDwOH2cDpTol95Oompv
 dJpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780576272; x=1781181072;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVCtfvOAMMbqkNqCa+q9Cb6hDsShNb4EGCU/ePnP6H0=;
 b=V285adH4F13zKvrCsl7XsGUXJHE/Hg9RKaFeazzRzkB21rcxlizx+g0JkzZmm1Gkq8
 49M1mKQsN0TGP/1hQJKjZSxHQANwNTVXEZAT348KOM6GvyCV1cFZZUwdbXuGH5KFTgmG
 chg6YEyo2eGhWT771l3Ti76qzmtjsv/eXMufx7fnKxTi5fqVRp6IGFDWnlNM5X9lfuvc
 TvMwtnL2Ii3E8wNYa0zxB8DDX1kxVwps3bIFlebI9oDPIUXrLbfMvKboTBmLS807H2Dx
 3NtsRP2qKx74jUj6rrZhRyLhewNirZ9AbrpRzA9YYh8+BSwxjqem+7uz/cLNsFruRNxt
 00kA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8F6hy8Xe0nwaSXDJMgYZoTo68A1JRD1wCuvx96yuucYvBpSVhGZhcezPfBp0JV5YN+W9n2H2/u0Dk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVzK6V9xVPNC7rjmw5nXQAfDNmY2FVXHFOoajwFk5DQG+dtkbT
 C2nRtkHBEOJLppg+KEfGpOo/KpG3zRZs625/wJJ3Z8opu1e6TRYQ9xQoU3Z5UblE3zBzDszrl4N
 GPKGPH1T4AMXuvaKnIyuoYVz/2Jz+gECkNLtL0y1+tUhX+znNm6KUr+rD0k9Cay7jwbKVnXY=
X-Gm-Gg: Acq92OFiyqgH+GRqzt5AJDDK/H1i7amDEjz5rvYE2VolhTHraPcMUESmcfd/NGG2Jbp
 /AB+EbmktCQssDRbNnZDvt8Uq4s3ora23TnnHXwTX86WNKcTzy9GMqXiriW+iasQFyuPAAIWicE
 Z+OV9U5Q3hVbfCs0XnkFxs16W6xtyFKQqWsVeYIGbKaJgEXVoN81mjfAsPWHe7Rps8+4AgpiXwk
 F8HpwsySl7MZzTJjKIqAFOz5GNE8RhXJLiajdy0EOKJwT6aYH9nIyxK5Oh/5Qa3ufcWb+Mj23f9
 LcvJ7Nh1dKotHPjED3qfbryDx01Olt8sIPRXFSla9hT8u/nvc1ki5imMr84JSYVdF5t04DJi7NA
 ppEW+mNBx0RxSWy6fT9YaBcjmVsBRxpKJtVr5/SXJosc2/IIAr2/OnoOgc8I=
X-Received: by 2002:a05:6a00:368e:b0:841:dc85:1638 with SMTP id
 d2e1a72fcca58-84284f53d31mr7173795b3a.42.1780576272409; 
 Thu, 04 Jun 2026 05:31:12 -0700 (PDT)
X-Received: by 2002:a05:6a00:368e:b0:841:dc85:1638 with SMTP id
 d2e1a72fcca58-84284f53d31mr7173753b3a.42.1780576271868; 
 Thu, 04 Jun 2026 05:31:11 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428325d9a3sm6015917b3a.34.2026.06.04.05.31.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 05:31:11 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Subject: [PATCH 0/3] Add Shikra (QCM2390) display
 support
Date: Thu, 04 Jun 2026 18:00:46 +0530
Message-Id: <20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPZvIWoC/3WNwQ6CMBBEf4X0bMlSDRVP/IfhsJQiq0CxC0RC+
 HcLnr1M8pKZN6tg68myuEWr8HYmJtcHUKdImAb7h5VUBRYKVAopnCU39PIoK+KhxUWC1qlWcK0
 xAxFGg7c1fQ7hvfgxT+XTmnG37I2GeHR+OR7nZO/9lc+JBIkWTVJmlxpR5445fk/YGtd1cQhRb
 Nv2BfxvrkzFAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780576263; l=2713;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=BzGjWMm7NOWQTFGGfvZVv4acRcjMzGDbIyUMsF+f/Sc=;
 b=DMPp/3/P7p0mXsQD7I5mVa3XnUwoOu1FC9g/lOw0Oil7tXRLfw36d3FtC9Vm0lebimbzZc3mx
 2nZUxp3Ljv9ArLU9lP93ovjQqDjl059xpYQ4hTofSNFsZeINsNo4k+V
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: g4jQp3VAJRehfvYAqyFikt3GGE1Fu3vS
X-Proofpoint-ORIG-GUID: g4jQp3VAJRehfvYAqyFikt3GGE1Fu3vS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyMSBTYWx0ZWRfX9UCaAgu9AyuU
 CkBt6MrzL2V0qOpCY5PDoA2YAsetH4bigrGpo8wSIQ/hSY3zN64K6+m2Fp37KXZsO52D51ob3rI
 BWsYFSm99UD6EpHRfaza2Iez8oIBiCt954ZjRD93/xzy+pcQ0DXF9ykgYhWUxEDM2kGONj0v6XT
 BVEHwpJgN30iCAuEGKp5j+ybneVPuMxKhhWTmlrAAcPrknLOmApq9PZLALHpQy1qm0Au2Ql6m23
 uMeojfBWqspdbm2ZtOkk9LgJn/RjPRBMk9gVjc42+4ayMU8g9UZXSD7Oa0YkpIM6bE5K5d7vztT
 bH7iTWu6D9qjkRA2TF3N9xxKfnTY/Ryrk31Jbe8RCIERDnFddgQOKpkpnQ+JymGWNZJZpiT30Mh
 vw4Nc/H60EQyFv2BSOQNY0avyCv9p1Zn9JdVve/hHYdcAdZrTbp+PN61XniVvhqGkrwKdaozs6M
 PxWk6pXYulrK6kJuuVA==
X-Authority-Analysis: v=2.4 cv=POc/P/qC c=1 sm=1 tr=0 ts=6a217011 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=3zM2i4eYArf5VB82j9MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040121
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

Shikra (QCM2390) is a Qualcomm SoC based on the QCM2290 family that
reuses the same MDSS/DPU 6.5 hardware as QCM2290. This series enables
the display subsystem for Shikra by adding DT binding updates for MDSS,
DSI controller and DPU, arm64 defconfig enablement for the ILI7807S DSI
panel, and UBWC configuration mapping Shikra to qcm2290_data.

Driver and SMMU support are covered by the existing qcom,qcm2290-mdss
fallback compatible string — no separate drm/msm or IOMMU patches are
required.

Tested on Shikra CQM EVK board with ILI7807S DSI panel. Display
pipeline probes cleanly and panel renders correctly.

Signed-off-by: Nabige Aala <nabige.aala@oss.qualcomm.com>
---
Nabige Aala (3):
  dt-bindings: display: msm: qcm2290: Add Shikra MDSS
  arm64: defconfig: Enable ILI7807S DSI panel driver
  soc: qcom: ubwc: Add Shikra UBWC config 

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml		|  1 +
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  4 +++-
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 34 +++++++++++++++++++++++++++-------
 arch/arm64/configs/defconfig							|  1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c					|  1 +
 drivers/soc/qcom/ubwc_config.c							|  1 +
 5 files changed, 33 insertions(+), 8 deletions(-)
---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Changes in v2:
- Drop drm/msm/mdss: Shikra support patch; driver reuse is handled via
  the qcom,qcm2290-mdss fallback compatible string (per Dmitry's review)
- Drop iommu/arm-smmu: Shikra SMMU client table patch; not required with
  fallback compatible approach
- Fix UBWC config to map qcom,shikra to qcm2290_data instead of
  no_ubwc_data; Shikra shares UBWC support with QCM2290
- Refactor series from 5 patches to 3 patches
- Link to v1: https://patch.msgid.link/20260603-shikra-display-v1-0-aeac1b94faa7@oss.qualcomm.com

---
Nabige Aala (3):
      dt-bindings: display: msm: qcm2290: Add Shikra MDSS
      arm64: defconfig: Enable ILI7807S DSI panel driver
      soc: qcom: ubwc: Add Shikra UBWC config

 .../bindings/display/msm/dsi-controller-main.yaml  |  1 +
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 ++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 38 ++++++++++++++++++----
 arch/arm64/configs/defconfig                       |  1 +
 drivers/soc/qcom/ubwc_config.c                     |  1 +
 5 files changed, 39 insertions(+), 9 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

