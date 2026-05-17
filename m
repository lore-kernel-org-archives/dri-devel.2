Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF92CD4F4B
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 15:40:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A9CC10E241;
	Sun, 17 May 2026 15:40:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="I+V9eap6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KF6MST51";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F56810E241
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 15:40:10 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64GNRYw03188415
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 15:40:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:reply-to:subject:to; s=qcppdkim1; bh=va65SuP/Ts7eb
 FnyIBmXToIeGwDGd6hztFKbfgaGro8=; b=I+V9eap6BamJ73VRDteMQzQmpcLp1
 SqIJgLbXn7PQfd2cWOkwkRZJ8bhC7QAANAIAKgKHR9evj1uz+HCa5kFJn1ZOfLbH
 oZKylctdFD+oulHNDiXFaih8pcog5J7iaP3vCi4eLhNZ15WFtq6QZblh/MijsBc2
 khkrrz12QukN0k30HJtYeZjTpFFDs01XFNMb75JiIN3zzt/vqtb52LVKA/mGVUri
 idOs9cMZ+flF/LezZ099kULMYtFXxlKloPHF2kW9unurrJM22Nd1cvuM4QPpfKFV
 ocAQux5/FW/UyHqVCNySkGoTqMcQcxHiOIGBioLLhezEQPkd1q3A/wAbA==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e6gvyu46w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 15:40:09 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7dcdeac07b1so3936491a34.3
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 08:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779032409; cv=none;
 d=google.com; s=arc-20240605;
 b=JrUkw2M8UujkK6SlhADYBoqsJj+jgVJtm25/MjxjjX8L6AiNio1bG5xlc895hF93F5
 40125yXfNuBWT9hNDvSc/RVTo3+m6odYd2RZgnGpYz/vcl4Ux9yj4CP/4I4jya/jpQtj
 UGap9DnN8MPv6ZBzFKNG6ZlK2HETe/hSD4i5W7ChpX1FuOS5teRpqoYw7IkVN/Vjpt+v
 P73aOdKhBDSk9eiXhIbmMI2Jl52g9UxNXhdQizbpcookpwh8OroOdfzCH6CN/WC9uTQY
 qlZwgQB0fdUOcEqkKChLsNcMWQQNLRl2JycEkPq6FYjEU6KyrznotrmOqfJQ/YeyH06p
 lHsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:dkim-signature;
 bh=va65SuP/Ts7ebFnyIBmXToIeGwDGd6hztFKbfgaGro8=;
 fh=lUa31pXghKJJA2PenM0whbt+5Zk//abQDn787iXH3eQ=;
 b=YrESly7WrtoSYVi4Qv5BevQnDTXxRLDp1drJpjL50EVZghpSUdxeMkFzSK6CohEN1S
 dUcZHeJWi4DOOZKJ+rypXTDDrnHCRwKQq4yI+v4gqomVePr/WdzQ6bPQUoanWSn1p7D/
 /Wd1Bph5I5eKICLllrZ/+0RkaOnbZZ6DVlfvcz6//6pGuWnCYlv3Zz95nayuZ39ikNLe
 jNVoI35672CTluK4zL10ELo/1ao2eAnXhcQacpS4DxRVocvy821jWJI9R1OTCNckkvKn
 jASwDUznsHVqMVKINQ0sl2vHWjanTnwqpPnbC78yz6AfbabpFJXX/v3hin24g+FkS0PH
 0Buw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779032409; x=1779637209;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=va65SuP/Ts7ebFnyIBmXToIeGwDGd6hztFKbfgaGro8=;
 b=KF6MST51eQBzzWRq2OHq2+MwNJh0AhsdqomaIDXtqwJzaICR+ZPlTXreUWIjSBYZQa
 T/lQ8MjEQYckg2MT7pEi3mKKtwHYlJyBhLiESlekczDC9AXm6O06i+6eDWTV3xcIkwBp
 DkQdv30su2WazIMVPhXGIv0EmxJidFBFGgP6w/gBThcyXvxGtffpDbuGIOdc2e5bD5Jw
 y8YxKQ2AadYxGMoTXAIwEfrEoRV/pwRd1NapAlxF6uJiWBeslifOGKoUM316hFeNHtZ2
 k1UA+ykj15DBRwhHRL3RoUs4KAiWGvT39frIWRxwNSjzJeNCtqa0rX2sSzUHCKyUHcal
 G2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779032409; x=1779637209;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=va65SuP/Ts7ebFnyIBmXToIeGwDGd6hztFKbfgaGro8=;
 b=eGc4rkwN5spHMCUnR1PGO7mf91KvR5wVU9SgLDmMyQvKEK9c77lA+h4rAgO+eySMlL
 lsS8ntPplq2Q+O8c4xsjvxxnNb0IRj9OkN/9Pm1TTY8l1h6aGFbO4/RcAZRofTSHSBUx
 894a0A+Hzbqdw4l88BYhzAFaGpjZRT+qHqIxGeAWnop4pOw+G2WDprX1oDPXTLYEQI63
 +MLZduG6SRyMp5kBix0UwGOsaJsW0+28K0U6BsBFJHdS4tAx/lfzdROx4yjEDek22OgH
 1YDJS/bF6HlAhOXJs186vA+HIl4R6bT6NmsIx6lJU3Ls+sbAoOxw8ZcO9oiHe7vA7x7s
 kDfQ==
X-Gm-Message-State: AOJu0Yw7/40WGfZxt3cPRjGmebrMourRSNeEZxwa1okItgCV7mMwfr8l
 80iWYUI9QD7qPV3GPcAeXVrkEwX1h4ZUOqO1MwbX7h5c9StLmmuVGjm88FS2FYKjRM8pQMpmN7v
 ko5TsGKJ23uHu3vmty2P0Hwr6cKyurkeaXTskCOWYeI7n9s05U3tRVDOSudbNxb3NN0yTGh164F
 uAHkJ+MP+X9VQ1ruvq5T8oNdPxXlbHyK84N19wXx0S9pl63w==
X-Gm-Gg: Acq92OEni1JCx1VnXmcFldm5Lnqw+vgTLMT7b6uiJbL8I5fNzVmVd/QW/VJQgixDDkm
 /yxcEJ6PxL1T3OvnYFsqcqF4ZPXs2Fa+M/0HeKCOoQnvugBwRQ+JWXp2GSVnFEXxNMjwxOaKHD5
 FUn9Mk+atRtB1OqvFEzXqJZ+wipw6YlWPwdtC4oK0tDsmlZVYs4ZMiwr3pVDEdbci6V88VO6qZ7
 QxsxbRk9doSYbT/MCW8DSlfrIFVkKM451OGvA==
X-Received: by 2002:a05:6820:290a:b0:686:d107:2856 with SMTP id
 006d021491bc7-69c9bfb3b85mr7715042eaf.51.1779032408847; 
 Sun, 17 May 2026 08:40:08 -0700 (PDT)
X-Received: by 2002:a05:6820:290a:b0:686:d107:2856 with SMTP id
 006d021491bc7-69c9bfb3b85mr7715028eaf.51.1779032408425; Sun, 17 May 2026
 08:40:08 -0700 (PDT)
MIME-Version: 1.0
From: Rob Clark <rob.clark@oss.qualcomm.com>
Date: Sun, 17 May 2026 08:39:57 -0700
X-Gm-Features: AVHnY4IGMrZqSU_DFTpi4UJULi-CaOTmv8vCqzs3Y-3ZjuVuAOmqPDpr2_BSarA
Message-ID: <CACSVV02cTK7h=d0uqanRE-cj35THDqFjqsTB_2zQV1Mcw77aNw@mail.gmail.com>
Subject: [pull] drm/msm: drm-msm-fixes-2026-05-17 for v7.1-rc5
To: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <dri-devel@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <freedreno@lists.freedesktop.org>, 
 "open list:DRM DRIVER for Qualcomm Adreno GPUs"
 <linux-arm-msm@vger.kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE3MDE2OCBTYWx0ZWRfX5tGz0oyNmxkX
 I/j4F6w52ZrqpJRwJFAUBRn2mp4pAOoXTWUUgfk79OaRohDqeozfL8zUoHTcIB/FsqHE1G2+V7W
 f7AwNCEIrV7HwWq3S58ycIPFbrX3g2RQfvj25OG+9FwStZ2ACKHnT3wwQxXSQw7b0/Tfkq3oDvo
 RFhJ4eV9r+769UEKY7usyT75mbzDAtQuB6oyd/eP9eyV6IilZPMq9VWcfL2hf61Y3mQo+0Xm/W9
 3ozellLLf8ANRmEsTasQDBpEoex9nom9zirxzyQ4xazvW0di3yxJcrIbm6R+dkkHaRDuJK+vNma
 PE7bRgZbgVGicBGFlZD9Rx61HjRuTOe++NOV6BlfHqgrgGQUvMEmg/dk4P08aWrwEcEUX8dTmN8
 jDO7aQW/n9adCwyN4iiHdE6/bP22EVnOqqdhmcrwG/0yaRzKnpwFOYHypWGE6/bc0Q+RihG26js
 9aOTiTCfZijW6H3dbLA==
X-Proofpoint-ORIG-GUID: 5fxPdDr5MP74PheRZNHyXCk6M9OQgSXh
X-Proofpoint-GUID: 5fxPdDr5MP74PheRZNHyXCk6M9OQgSXh
X-Authority-Analysis: v=2.4 cv=X5Ni7mTe c=1 sm=1 tr=0 ts=6a09e159 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8 a=W0Bhe94nciMH-WOqbJAA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-17_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605170168
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
Reply-To: rob.clark@oss.qualcomm.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Dave, Simona,

Fixes for v7.1 as described below.

The following changes since commit a972d1b864e8efcfda0b387debac8ea2875a182c=
:

  drm/msm: Use of_get_available_child_by_name() (2026-04-01 18:05:05 +0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/msm.git tags/drm-msm-fixes-2026-05-17

for you to fetch changes up to db339b6bc9f234b4883eb02946ea01d8d9faa11c:

  dt-bindings: display/msm: Fix typo in clock-names property
(2026-05-17 06:33:28 -0700)

----------------------------------------------------------------
Fixes for v7.1:

Core:
- Fixed bindings for SM8650, SM8750 and Eliza
- Don't use UTS_RELEASE directly
- Fix typo in clock-names property

DPU:
- Fixed CWB description on Kaanapali
- Fixed scanline strides for YUV UBWC formats
- Stopped DSI register dumping to access past the end of region

DSI:
- Fix dumping unaligned regions

GPU:
- Fix GMEM_BASE for a6xx gen3
- Fix userspace reachable crash on a2xx-a4xx
- Fix sysprof_active for counter collection with IFPC enabled GPUs
- Fix shrinker lockdep

----------------------------------------------------------------
Alexander Koskovich (1):
      drm/msm: Fix GMEM_BASE for A650

Chen Ni (1):
      drm/msm/a6xx: Check kzalloc return in a8xx_hfi_send_perf_table

Daniel J Blueman (1):
      drm/msm: Fix shrinker deadlock

Dmitry Baryshkov (4):
      drm/msm/dsi: don't dump registers past the mapped region
      drm/msm/dpu: don't mix devm and drmm functions
      drm/msm/adreno: fix userspace-triggered crash on a2xx-a4xx
      drm/msm/snapshot: fix dumping of the unaligned regions

Felix Gu (1):
      drm/msm/adreno: Fix a reference leak in a6xx_gpu_init()

Krzysztof Kozlowski (5):
      dt-bindings: display/msm: dp-controller: Correct SM8650 IO range
      dt-bindings: display/msm: dp-controller: Allow DAI on SM8650 and othe=
rs
      dt-bindings: display/msm: sm8650: Correct VBIF range in example
      dt-bindings: display/msm: sm8750-mdss: Correct DPU and DP ranges
in example
      dt-bindings: display/msm: qcom,eliza-mdss: Correct DPU and DP
ranges in example

Lad Prabhakar (1):
      dt-bindings: display/msm: Fix typo in clock-names property

Mahadevan P (1):
      drm/msm/dpu: Fix Kaanapali CWB register configuration

Mikko Perttunen (1):
      drm/msm: Fix iommu_map_sgtable() return value check and avoid WARN

Neil Armstrong (1):
      drm/msm/dpu: fix UV scanlines calculation for YUV UBWC formats

Rob Clark (2):
      drm/msm/a6xx: Restore sysprof_active
      drm/msm: Correct modparam description

Uwe Kleine-K=C3=B6nig (The Capable Hub) (1):
      drm/msm: Don't use UTS_RELEASE directly

 .../bindings/display/msm/dp-controller.yaml        | 28 ++++++++++++---
 .../bindings/display/msm/qcom,eliza-mdss.yaml      | 20 ++++++-----
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |  2 +-
 .../bindings/display/msm/qcom,sm8650-mdss.yaml     |  2 +-
 .../bindings/display/msm/qcom,sm8750-mdss.yaml     | 16 +++++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c              |  7 ++--
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c              |  2 ++
 drivers/gpu/drm/msm/adreno/adreno_device.c         |  2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c            |  8 ++++-
 .../drm/msm/disp/dpu1/catalog/dpu_13_0_kaanapali.h |  2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c        | 12 ++++---
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      |  3 +-
 drivers/gpu/drm/msm/disp/msm_disp_snapshot_util.c  | 28 ++++++++++-----
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  1 +
 drivers/gpu/drm/msm/msm_gem_shrinker.c             | 40 +++++++++---------=
----
 drivers/gpu/drm/msm/msm_gpu.c                      |  4 +--
 drivers/gpu/drm/msm/msm_iommu.c                    |  5 +--
 17 files changed, 113 insertions(+), 69 deletions(-)
