Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843EECD343F
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 19:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E55E810EC07;
	Tue, 12 May 2026 19:21:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Z558tiJh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="c98IEb7t";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D02CA10EC06
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:52 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CIsBsn1059561
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=ZxTVwMydLH4t3EYrix2WM9
 RnBiXRbR3ac7t4t7+IWoM=; b=Z558tiJh8DHjrBro2KabN6a8GEGel+CCcFdSWE
 8sAz+VkKeE0f3lSW48wJ5s/oYj4cFSVoX2oc1MvyOv9l0UphYMIqRqy79GgsHwTk
 VdfT7bPV1v/7PP4ZXZF0Od+DUnUS3ec8V3TrpEakSpZsXsOWCs2nIcEXpRY+vTIy
 tl1mpCIq9JwHYdFQ5rqJGcKYfj6rKxgvwEPomry5uMlI2RuWIo8SCXakh0rKQqEZ
 qTMWabHPUQ+2dZpA6DLjbT8zsOCjXXd2oud7fgIUhCx7Tm8lMQ0kl2qbnNDHilA4
 KbFR30KTPUBTINKcDFCm9uk+uo4+6qdUxvfr5Hf0FwYPknAg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e49vx82yg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 19:21:51 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b9fe2d6793so107283585ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613709; x=1779218509;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZxTVwMydLH4t3EYrix2WM9RnBiXRbR3ac7t4t7+IWoM=;
 b=c98IEb7t0inQlQ9JkS1NDkMayo23EjbB02myhRxdq4C+vtUg/GRRWGVbSYtZmKlEtN
 RyjS+lQU8o+qBPB4pYF6IMaKI6ZB/Zk5hzL5RwxZVMJHn7x3ybaV64JAGIQwZjEXbNxu
 QQVLN4ypn4R4HdrJm69zv+Mh0lIM9IqDbTu+K+vkntPBhGtqXax0w346wi9YEDZ0uSYU
 j0FsLQUoH5g0rrSaZC3y1pM5iz4O3//Zj2+cqPph+RrrnavwZsislHpEgzdZTLpje9Mn
 jT/kqca4zfFoiLxViRUOeL4tALug9WixxLJW/4sr40o5uTZXt22CeDhXBwkXdNs9ggQA
 HzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613709; x=1779218509;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZxTVwMydLH4t3EYrix2WM9RnBiXRbR3ac7t4t7+IWoM=;
 b=EHymjY4T/7fZrMvkkK6EFQnMZXZxXok8IjrL5VbgM+Y0PzAiAC5CyoW3r4Oh9S0oBs
 PqYjMp+R60CyrS7jTcgL0+AFVlXPqT78XRCtAdLlJl7EzRuvH3u3nLom/yd+Vd/Rwi5B
 xZMCevMRmFRVBz7WgPSrRl+rIdo5ZnhDOgXJL2kDfL7R5bFjvJRRmmkHc6Um4jn4UawR
 HSyF9JkL4dPo6ddeawkZQR4ggOpWNG/76nie5uKTkiO5JjfZMxQKrUso83JZpVmZIzb2
 AsIX5MwuzLmnBd07wn0ApX5kRe78T03GIoFKX5ZxSSZi+0HFt9D4UPMrQhHvluNZNPuH
 DhyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/X5q7Lfi0PsbKpK+CqxdcY/weX9f+k9rNfLS0pP+6TzhhVud41SQw0W3Kc85d+rxzPXo0aF9b/Zj4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxkK0SBfoGEBF7FgYCIpH7g0vSBtjuCVrphiY/3ZsKPhjnqR7Mz
 O+mgWvP5RtfYchlwRCHkah/6uOPxL15aaJRwXu3/++mucXmJaxxLpBKzGecE/RcSLAIMSJl/5wz
 qZNdSm8RjJtzv8JD/ejcCPFPa2Mv07N0F1SwkWTkbw6gg22WkCjSy6uYhv83xASGVUxXhK/A=
X-Gm-Gg: Acq92OEDzaSyKVEY38MQe7nNJ8Gw/2ybSpTM0W4fgEA+22nUOQ1DvG37UmzemIWF+wM
 mYAqnVehDqKrr5JkDUsA+FdIOsff8SGJKACpi70wg/V1KtVy1DgF7a4Ec3wvDCBByD3KCaHFQy3
 T5vzsaCTQyYXuUBp0wC6N00KW0T9NuzeiefLaUkRgQu6oSzJ/qvgvbon1VtyEY42r05OXbYjzst
 jHMvSiLhfKbm1bsOBSrIxV1tY4dWzIc0hA6gbZNOfejDrpseoKOOQRmQBT1IRXKDdTBeGaw3bpb
 /3Jl2PVXE/3gb6eMfcIxcWDquevlwt9/d0kJSKLeXxq2E6LbVsZM7ZdZPCAT0T6fDRePZILTP7m
 UVAC4VQUElNc2DdzCGCqC97+/+CduhqSymld9nijmjLyMXQ==
X-Received: by 2002:a17:903:1aa4:b0:2b0:4f9a:b794 with SMTP id
 d9443c01a7336-2bd2773017fmr3307735ad.37.1778613709129; 
 Tue, 12 May 2026 12:21:49 -0700 (PDT)
X-Received: by 2002:a17:903:1aa4:b0:2b0:4f9a:b794 with SMTP id
 d9443c01a7336-2bd2773017fmr3307455ad.37.1778613708637; 
 Tue, 12 May 2026 12:21:48 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ead90asm141250585ad.72.2026.05.12.12.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:21:48 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v4 0/6] Devicetree support for Glymur GPU
Date: Wed, 13 May 2026 00:51:17 +0530
Message-Id: <20260513-glymur-gpu-dt-v4-0-f83832c3bc9a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAK59A2oC/3XP4WqDMBAH8FeRfF5KcjFZlTH2HmOIxtMGqrZJD
 C3Fd1+Mgw23fQn8c9zv7h7EoTXoSJk9iMVgnJnGGPKnjOhTPfZITRszAQaKASjan+/DbGl/mWn
 rqRAFSlbEmmpI7LlY7Mwtee8fW7Z4nSPrt0/S1A6pnobB+DIb8eZponPB1v4BnavT0DJ72Qqcf
 c2shkHrqvWVnsbO9FUAGgRltNYai5Yzhc/wNjl3uM71eZ1wiM8rWdc4Gecne09XBp722HAmdwc
 FHkXgQmLDuZbqt5jAAN+IZHyPwIp0HI6NlIVqmn8Q8QPhsEfW2445CGg1cM3EH8iyLJ9lWUVEw
 gEAAA==
X-Change-ID: 20260226-glymur-gpu-dt-339e5092606b
To: Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778613699; l=3384;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=wYO6+mkSHyBImgkmn59rKun7eq0HzQ+6WVDffYq0oGI=;
 b=0mHEywVyTDI6uhVjoy9a8e9lPrHbK3KNYy2NOM0D/zwcx2CpBzxNu5tkDdaJ76vnFRhQHqFdH
 fX7pME2bdIjDgPMt75UB2HagBHjYCZkqnp6VVAFn6Bl4jM7sINRqkd4
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: m6ENhOv6SAjD6M_0JzjWz-u-7_iFynnu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDIwMCBTYWx0ZWRfX80lMA/44eZeJ
 kp7BG9OTVVi0LuF59umrerEWJxjyiK4Xw2nFEDjMpLv0rma73+Mhe7DXD0P+uMGtMp6xZZgz3py
 yVHLEiYy4VjSMkZKIvj0pITLSjAOJRIWgM8rD796UnRLZy+jcjP7Zs3UmFXzzE6PnrQf/ADsJHh
 Ysf5o0BHdGLxL3ybpobd1oGhuPV97gS8ydUwx2W6ty2A5cBCj2Die+Mz7kJc5xcrRx1yHbGj9SU
 VuqbuTOP37lNCEULHHaNX1HwTZZCDmmocse+dFplGwZpqkKUZkv0q2bodtGsIAqu2huiHIsRamj
 S1NIX1nhmzIqDEtd77bLWtWgDLtssF4f2xTEa1COcVg47tZ1aQMeunv8x2hzoqoqWXRMKeOrQjo
 ovUj2qlUPPK1EP+IY3OMfy1su1J/9VmenxnlFW4PHLK2EAt36FXFy5C/L0eZpmOO86Bfq45LCSY
 473kDTdli91MQFCGkag==
X-Proofpoint-GUID: m6ENhOv6SAjD6M_0JzjWz-u-7_iFynnu
X-Authority-Analysis: v=2.4 cv=A8Fc+aWG c=1 sm=1 tr=0 ts=6a037dcf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=-08r9DDlpfC4vgu8VQ8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120200
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
on the Glymur-based CRD devices. The Adreno X2-85 GPU present in Glymur
chipsets is based on the new Adreno A8x family of GPUs. It features a new
slice architecture with 4 slices, significantly higher bandwidth
throughput compared to mobile counterparts, raytracing support, and the
highest GPU Fmax seen so far on an Adreno GPU (1850 Mhz), among other
improvements.

This series includes patches that updates DT schema, add GPU SMMU &
GPU/GMU support. Keen-eyed readers may notice that the zap shader node
is missing. This is intentional: The Glymur-based laptop platforms
generally allow booting Linux at EL2 (yay!), which means the zap firmware
is not required here.

There is an update to the gxclkctl/drm drivers to properly support the IFPC
feature across all A8x GPUs. That series [1] is necessary to properly
support Glymur GPU:
[1] https://lore.kernel.org/lkml/20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com/

Just FYI, on top of the linux-next, I had to pick below series [2] to boot
the device properly. But it is unrelated to GPU or this series:
[2] https://lore.kernel.org/all/20260331-qref_vote-v1-0-3fd7fbf87864@oss.qualcomm.com/

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v4:
- Add a new patch for passive cooling support
- Link to v3: https://lore.kernel.org/r/20260512-glymur-gpu-dt-v3-0-84232dc21c03@oss.qualcomm.com

Changes in v3:
- Add a new patch to fix RSCC base vaddr in drm-msm
- Remove interconnect property from adreno smmu dt and the binding doc
- Add a contrait in GPU binding doc to limit the reg entries for Glymur
  (Krzysztof)
- Link to v2: https://lore.kernel.org/r/20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com

Changes in v2:
- Keep GPU/GMU enabled by default and drop the enablement patch (Konrad)
- Drop zap shader node from DT
- A new patch to update GPU SMMU dt schema.
- Adjust reg range in dt nodes to avoid overlap. 
- Removed cx_dbgc range as it is already stable across chipsets. This
  region is now part of kgsl_3d0_reg_memory range.
- Link to v1: https://lore.kernel.org/r/20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com

---
Akhil P Oommen (4):
      drm/msm/a8xx: Fix RSCC offset
      dt-bindings: display/msm: gpu: Document Adreno X2-185
      dt-bindings: arm-smmu: Update the description for Glymur GPU SMMU
      arm64: dts: qcom: Add GPU support for Glymur

Manaf Meethalavalappu Pallikunhi (1):
      arm64: dts: qcom: glymur: Add GPU cooling

Rajendra Nayak (1):
      arm64: dts: qcom: glymur: Add GPU smmu node

 .../devicetree/bindings/display/msm/gpu.yaml       |  17 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   4 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 461 ++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c              |   7 +-
 4 files changed, 431 insertions(+), 58 deletions(-)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20260226-glymur-gpu-dt-339e5092606b
prerequisite-message-id: <20260410-glymur_mmcc_dt_config_v2-v3-0-acce9d106e72@oss.qualcomm.com>
prerequisite-patch-id: f7ab29f2f0241b6536d3b0c0593f0baa0e435221
prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

