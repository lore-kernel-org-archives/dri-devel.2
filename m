Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C1BCD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FC410E5AD;
	Fri,  5 Jun 2026 10:19:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CoTPCZNX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h+1utDh4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1764C10E5A2
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:19:18 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6554he142667053
 for <dri-devel@lists.freedesktop.org>; Fri, 5 Jun 2026 10:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=YdRn4DRbFufW0fmv7Xxdna
 0Xs07PVl1QBs1/OWzN90w=; b=CoTPCZNXVLY22xU7IlGWff9+nkN8NSABuqQK7T
 yhjH5HRfRUAC2nU5amDTJOTJ8/X0cepcrQnVE6naN3qswU2gy/9MW/sYS6sFkSNb
 k+mEyavpP9eznk+hA/3jVTMMVFf4IBPR4rqLBxNSPDXMVNqPVwN8RCWZP6U2KrBQ
 DWzeRwu8FgdX+upf4gWBXo4U4zcUj3+6MlD+oA+ZYF4aODv3rf4HV1ljjnVPMLDf
 danFRBdDSE19VvaI3aKe/oX/+Dfr0AiFbR82LXwJVcC8N4X5AMj3I8m5Yrfwgjhz
 Ejehl2Yxz9mHIaMac+1UCzRDut8xVTBdP2BbEidMeb4R3x2A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ekemyueyv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 10:19:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2c0b35fa876so20541565ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 03:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780654756; x=1781259556;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YdRn4DRbFufW0fmv7Xxdna0Xs07PVl1QBs1/OWzN90w=;
 b=h+1utDh4UKPh7LwChqkori9TpIGSaS0E/DnZOaXjloBEakYt1D5yhPt8ZhXswl6Ztx
 fc28SHbjPk2QpIAEcjBZjD6UxwpFTgTesIJoU4ellxYJs2GXQ1H1hUB9xC3ue84BWqpE
 cNpiyXjFuPdtH/3BcyS4Jw0ZEBUZVt9mSffBPb+iRy1Is9I0GXxCINVFjQS84v0Tv3DY
 EhTmGAcvdQ1+ILfhccEn9ZxRNwYo3VkV5Qbw4Jz99q1Qv+XbXhsqyKds3t3J1EHRVu5X
 nFOdV+6wj4qkPY+0geL/zleTzDuuStLXAwWKEnlKfgnaFQBhy1j22HiWdZT9kQT6LRE8
 VLRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780654756; x=1781259556;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YdRn4DRbFufW0fmv7Xxdna0Xs07PVl1QBs1/OWzN90w=;
 b=i3mo3diGkFSYLWmsi2r5TvtQFA+I6jnEn0eof2zuRhg1dFFgl4pYwIY1KQk8ma0N9F
 Xo/lGoCcr0aJoIkCrGWvFuRjHInP4QdWlRFFDq77t2WcczjulIHJO/l8VK0Hgx2DdLiH
 /taVvpg/+lQQUpaMOYhN925SSxX7UfIFbBynNc2uzN3hCFFQ3Il9s0ZR46Cjd7RRZW+U
 8hera0ocJ5/g6gXo3HX2Cmk3H5I6qSFVikdi51E2a0Ib/CcjBtxaTnYbaZvSbsXMYsl6
 YQnxWbhXvr5Qy4LYS1EA5XMHl0WBt3Ohfy/lhpnCkrNcafl3ywG/OTX7B9oku6pcIkuU
 7rlA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8N9YJMHrYzVLJOzV6PBhxLUvtuUvx6UlkfOl8DWocUHj94yaGzmGTscrdKBkaEDWCfg2YiIj/v6I0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxtf8BVHerHskOvIXDOxNuJV4lIV/sw4ZFEYvPLIA+iACLqLa7/
 r1jKc7an7/J+FcNF5cDkpAjQI0gf2zDnaxfwmBQ5rqSqdOyEN6V2C+sLb8WPIdW06x83Mg6A+hr
 erd8IJWFaD4vMuLOQ5+FxBKydJp8YGe/hQPaH9cSRcXKdEFjheHgHPeOqe51G2Poxk5xj/LM=
X-Gm-Gg: Acq92OGs/R1ZzbGLHnisQ3/dJXfsLUw29duLrhwAl1WSmqOugbMLipbA1DWXDx29euq
 pUFDNULKhBW/xLhtXZsDxbVHHwWFpaqEx320mhTsIIdH+ny4Bg9KmGZnMOhp/KBGR+iRVR+0kMh
 EXxpysOl48Dy9UfUEHDI/jG3KgbVOsDFCSEJJtOlE0fnROcUfGtZqZ2A2emzkZHctHqjIPjolO6
 HqDFA58uYCErRTAvup0PMCXXSZqbsD/sY6wwuAmeIxpQnwsjWcBU4h5CUjqvDtxYcbmnT8Yp1vD
 5j8pfZGltDdximfBfXv1cA3rUuvUgu+c6D3wVL/mrzX+qf1JnRvj9ztROivg+RAJ//YkfKQFrub
 tqvfGeNy+SMkec4+wHkCye8laulve0LO8KJt3BMqdHduUTFBFZmgbcGjkOeA=
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id
 d9443c01a7336-2c1e7e44e91mr31358625ad.16.1780654755816; 
 Fri, 05 Jun 2026 03:19:15 -0700 (PDT)
X-Received: by 2002:a17:902:d58f:b0:2bf:195d:21d2 with SMTP id
 d9443c01a7336-2c1e7e44e91mr31358275ad.16.1780654755335; 
 Fri, 05 Jun 2026 03:19:15 -0700 (PDT)
Received: from hu-naala-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c164fa0236sm89741445ad.33.2026.06.05.03.19.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 03:19:14 -0700 (PDT)
From: Nabige Aala <nabige.aala@oss.qualcomm.com>
Subject: [PATCH v3 0/3] Add Shikra (QCM2390) display support
Date: Fri, 05 Jun 2026 15:48:50 +0530
Message-Id: <20260605-shikra-display-v3-0-9846ba5fe635@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAIqiImoC/3XNQQ6CMBAF0KuQri0phVBx5T2Mi2kpUkWKHWgkh
 Lvb4sZE3Uzykz/vLwS1MxrJIVmI096gsX0I+S4hqoX+oqmpQyac8ZKVLKfYmpsDWhscOpgpE6I
 UnO0bqBgJT4PTjXlu4On8zjjJq1ZjVGKjNThaN2+LPou9v7jPKKOgQWWyKhoAcbSI6WOCTtn7P
 Q2HxA3PP5XiS+FBkXlAuCyFrtUPZV3XF6jbTxkLAQAA
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
 Nabige Aala <nabige.aala@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780654747; l=3346;
 i=nabige.aala@oss.qualcomm.com; s=20260520; h=from:subject:message-id;
 bh=UjONg0NYj4XKMunIFJbINoDK3VSOgIFWYIBOvuNak5g=;
 b=NYZsTfhD6L1pZkrKqjY12HiGTIOPAad7elMOIEmgc5l650WfUBoPQwTaiYI4OYgsjDKjhuKBL
 jCLt2KM/JUJAy+tdw3EdLXgPUp6qTh8OMonqEGpoxLFIK4lrDHSxFSQ
X-Developer-Key: i=nabige.aala@oss.qualcomm.com; a=ed25519;
 pk=PYHJom8sPos1IGkrbCCsWiE7XTBQrQZd9jzAo051tgw=
X-Proofpoint-GUID: puTcrqGOYKMdXALWOCs1362FQek43OUL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA1MDA5OSBTYWx0ZWRfX6XI4NKdlYLMr
 gPPM3BQSP+wNU4opgPJSJ+y7ZNOqT7z3Q2NYX3Gm7H8T9rcn4WnKk++tJX1uITspu/PJ7xvC6YG
 l5OfGgVDAv/GwttRS9mcEQmh8j5di+o75BYDGE8Ym5T8WVawCpCocgHNPVunfO7CDvJBmJrGDVM
 I/ZKTBAjMno0myf6pT4z17mcq9QARbVQsjHlawgPYNZvmGCExioq57gbU0YKv2Ba4mniBRS+Skb
 CB91jc2oY/6PkdHY0ErhWfPMVdE/NpEm5TGPGnrC+4cEilW1+RRIFjJhRcmeFA7StjzhY0Zctoy
 h/G62PS1MebhSqvs3/rkY15dDm+GmZYQ9pGUqP3ya8Dj6dUWFobFNjkzIM83G7puiGJMwCLU+dx
 Hzi/HQ0UmT4vXzQpAHWPwkSyGCZkeuZWnh06hiISMqnY19QDihSNCLqwsMalGAxaAVpowIkQVfm
 SFLz9y25zvde56e1cHA==
X-Authority-Analysis: v=2.4 cv=K/wS2SWI c=1 sm=1 tr=0 ts=6a22a2a4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=_or6NCU1o4AAqT2-bvQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: puTcrqGOYKMdXALWOCs1362FQek43OUL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-05_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0 spamscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606050099
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

 Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml 	| 4 ++++
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-dpu.yaml		|  7 +++++--
 Documentation/devicetree/bindings/display/msm/qcom,qcm2290-mdss.yaml		| 22 +++++++++++++++-------
 arch/arm64/configs/defconfig							|  1 +
 drivers/soc/qcom/ubwc_config.c							|  1 +
 5 files changed, 26 insertions(+), 9 deletions(-)
 ---
Prerequisite-Message-Id: <20260518-ili7807s-panel-v1-0-d7b048163b1c@oss.qualcomm.com>

---
Changes in v3:
- Use a fallback compatible chain for qcom,shikra-dsi-ctrl
  in dsi-controller-main.yaml instead of a standalone enum entry, with
  qcom,qcm2290-dsi-ctrl and qcom,mdss-dsi-ctrl as fallbacks
- Replace oneOf in qcm2290-mdss patternProperties DSI compatible with
  contains: qcom,qcm2290-dsi-ctrl to avoid duplicating full chain
  validation already handled by dsi-controller-main.yaml
- Drop unnecessary select: block from qcom,qcm2290-mdss.yaml; default
  dt-validate compatible matching is sufficient
- Remove self from qcom,qcm2290-mdss.yaml maintainers list
- Link to v2: https://patch.msgid.link/20260604-shikra-display-v2-0-b3c1b2b67edc@oss.qualcomm.com

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

 .../bindings/display/msm/dsi-controller-main.yaml  |  4 ++++
 .../bindings/display/msm/qcom,qcm2290-dpu.yaml     |  7 +++++--
 .../bindings/display/msm/qcom,qcm2290-mdss.yaml    | 22 +++++++++++++++-------
 arch/arm64/configs/defconfig                       |  1 +
 drivers/soc/qcom/ubwc_config.c                     |  1 +
 5 files changed, 26 insertions(+), 9 deletions(-)
---
base-commit: 3a34f9c13cc0688f8db2a0db8506bf8c0d90737d
change-id: 20260603-shikra-display-07767208fa90

Best regards,
--  
Nabige Aala <nabige.aala@oss.qualcomm.com>

