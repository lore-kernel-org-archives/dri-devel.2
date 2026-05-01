Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9391BCD3423
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 17:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D518910E547;
	Fri,  1 May 2026 17:10:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eZ6GRazp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a0l1oyMg";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D122910E547
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 17:10:58 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 641GLSxB2660950
 for <dri-devel@lists.freedesktop.org>; Fri, 1 May 2026 17:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=Xmgf9SSOqwqEz1frKQANVZ
 eXXRXnvjk87BN/wRkyWus=; b=eZ6GRazpna0LN1A3kFSSnlvhvSwgfR4ME8vZz8
 5dfwo1oXkEDrD/ClIyuRpaFrxTlJ0EywMvltO175mHzUPUfTd9Akjd+VRi/yOLS1
 9gOjc3oWETy1F1V0lu3ACeuQMWyPPT2ev4SWe1pLuNZOYNg2LKoSECLe+UULUnFV
 AaSrulkOebl48zq4EHXS17yzRhtug9i5F04McyXDoWZpZk898IZclTV4IQqljftY
 mYwCA8VlVnR7PEFSw8AT7RYbD020aKqCyuIObpkIC1KXwwxfNyGcpDEk5iEn25A0
 CHGiq29m46Fxc339hjI47IPJdKVkDQ7GzEbdLHBxUH3J1XZw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dvhbtj9sq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 17:10:57 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f756ebd0dso1303249b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 10:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777655455; x=1778260255;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Xmgf9SSOqwqEz1frKQANVZeXXRXnvjk87BN/wRkyWus=;
 b=a0l1oyMgZRxbBzqsmd+RadvBOC1QUCFh0cR6zP+Ep2clw1r+ui0+XuUvPVq3N4sVIs
 r04uLUT10uEQS0rqL+cvn/WTRj+Hw6ufae87mTxtuRRp052TDqVxmS49sdzKDl3eojmC
 2N9nWoZY67ReTMz6tBYfpjaDIZRpXhc7m6ImxbHzXMFUGiwrk60uxrNQzXP+s1Fk9rR6
 STFXikCh0DCcrpcz3oIkkJDB7TUmJmG02PKFW6mDRQdWXrwBAvLc3Zj/9Rl/qNGoIGYt
 02nEbTL2sFiJZHM1UWhZEV/2d6ydBVF9mVGnPp36dee7x7RRLThLIXsuoy7UyxHhwFIT
 WwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777655455; x=1778260255;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Xmgf9SSOqwqEz1frKQANVZeXXRXnvjk87BN/wRkyWus=;
 b=GcTPxxGByL9KJu+sKPGRb27+ifRdqpwAaWvKqzmZtRncjEFqmyzDhjZBrJGFED6lAi
 AzYGC/yY1GTl1V4IGOfhF9c3lKDadBXf8KNvQoPgLYeBM+ANIpmQL0YXaziLFI4I5wFM
 jSQInoQ4URyS8DnOPo38MggQT/Q5c0uGUC36oYl4/dlLU0S6VS6g1hvdc6kapx9aPtSC
 Dg6X49k5f5o0dhhg5YtsHlesxCt9ZkrmrH3IYMOMU9ZjX0+EZxvzNWwXjoOua3GAH1Oj
 LpJaZQBtiGQJT6tpel5ntARpENlGXrboDKYIphl9dRiLlqxBQtdA9eFRBztJt1Uj/yVa
 WPug==
X-Forwarded-Encrypted: i=1;
 AFNElJ95GEAdVo2y51WGXJz0WLehLb9Y0wk67/0oIi8o/5hUjjXqHSUR0SuVSGXiJC99IAicFz7cYtq1gCE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YygIJ1WGxvflZL5w8K5TCOj8WmeTZTA3JYy1m7Q9Du96LAgzlfW
 kr7am6Tus5RsJO4EhQjGlWAu66WvCoruRW+q8rPOzGqfR60iazHaKGHjfsgTrNAcUUk6JJlbkxB
 r+HcHUWq0/5YTuM4HRV48X7NETG/7CR1JI+wwGyTMAhdsI5qqF1C1YHIcC3eN/uZp94A6Jk4=
X-Gm-Gg: AeBDietA2WEzNACsv6gYgc+ejmO+1dfKiuD/Vyv/8w7iSZGD53FRKXQflL7wjeVdAmz
 tTAp/6j4zj3LdNhWTWGjaFUie0+Le6JW1s3brbGM8hAbiYrWLo++oVJtlXjTSimcHktuarnLGSO
 FtryacC5OxkEqASBEy9JcI+XnHBCxBPatt1siiTBQblKgzd1a2jXykgwOqrJR3YXuKLT3aiXm+0
 G8HNrApndDcTm5RZvtwROhl+80w9sKmbiV3SQTg0BHGJvQWGKKEaHxNHUIVZtYJ7fKm3Io3a7CG
 7cqmynUFEBWWaWnaV+T96Oc303SW8T+6FJQfzzyU3zeNpo1+Gr1i8eJbCZoZiYTKbsEn3pewICa
 Id03nQtPTuoPECQB16BB3RBQsMZpGwdN5j1PXMnAberSrpM+2KuYmeYdJ
X-Received: by 2002:a05:6a00:1ca8:b0:82c:212a:8023 with SMTP id
 d2e1a72fcca58-8352d1495d3mr96915b3a.11.1777655455363; 
 Fri, 01 May 2026 10:10:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:1ca8:b0:82c:212a:8023 with SMTP id
 d2e1a72fcca58-8352d1495d3mr96874b3a.11.1777655454844; 
 Fri, 01 May 2026 10:10:54 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8351587db67sm3099323b3a.13.2026.05.01.10.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 10:10:54 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 0/4] Devicetree support for Glymur GPU
Date: Fri, 01 May 2026 22:40:36 +0530
Message-Id: <20260501-glymur-gpu-dt-v2-0-2f128b5596bb@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIze9GkC/2WP3YrCMBCFX6Xk2pH8bCMtIr7HIiVNxxowjSZpU
 KTvvmm6V7s3A2eG+c45HxLQGwykrT7EYzLBuCkLvquIvqlpRDBD1oRTLinnEsb7284exscMQwQ
 hGqxpk2+yJ/nn4fFqXoX3fdm0x+ecsXFbkl4FBO2sNbGtJnxFKOgvQdd/iyGoYtpWx+3A6K9nZ
 63W3RA77aarGbvEIQmgoLTGZmBU4oGfXQj756zuq8M+jxNZY9xMiM6/S8vESo4NTus/hRLLRM5
 EjT1jupb/ieSyLMsPWkrKKDgBAAA=
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
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rajendra Nayak <rajendra.nayak@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777655447; l=2699;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=AOjeov0yUTMFQ1Ma3m1LBG72eiFPSxq8IrvyTOV5Jik=;
 b=GQvofMkE8YRm1WWEZcaDkd5inbdSBP4TBVUF5vcztYq43pzVVAe9dOkuCO1qbiumFbzerGX5u
 cB0A3XTLGGvBD9kEnQYkJySG33kK5x0FGLH/kdcNLIzIK2yC8bpbBCz
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=cP7QdFeN c=1 sm=1 tr=0 ts=69f4dea1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Q5AOMzfNme0c0ULdHeUA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: _n6ovf9s6Ykv02LEjZaW4EGkvoN738JG
X-Proofpoint-GUID: _n6ovf9s6Ykv02LEjZaW4EGkvoN738JG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDE2OSBTYWx0ZWRfX3FEojX+NuacW
 VY/txAA6R5ZSrUFbUcjuJqXO+u9HKWuVnq3QsI8curIR75N3zsoMl8a306XEv5zq5L0VufmIgC8
 fCDrQVJKQ1fvAenvy8h0viT6Dn+WdCPDa5/xcMd9A+vFbLaXmWkj+9NAiJennGMYH+3fEVNClBl
 NxouKChYIqUPIETCYmt00ahDiS/Bjiov9qc7wBReggbCzGQi8tJlzsYseEe/IpDl6lcD9FAruGJ
 QGa7JI+zvbTnHq4zg4pbvntk6P73IlOKxJBJksEpGVR+QsQQvwgc0lRoL1F8vXhVfSsHM7atBGA
 jqG7C/4wxxtY1sdt3caJCiCnyGQ3sZ8Ef8xidCAJzNSTIwp0Q1VotfaQ34KFJkC2fI1aNMwkKt2
 2LILBKFGLUU4Ay6lGEEJHbmTWg+MtQSct1baMNpXDFnVhj9d4gxFBTibIDSWODzbM6wl+IPQfoB
 p0A7vU2zGlrWxWCSpCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605010169
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
Changes in v2:
- Keep GPU/GMU enabled by default and drop the enablement patch (Konrad)
- Drop zap shader node from DT
- A new patch to update GPU SMMU dt schema.
- Adjust reg range in dt nodes to avoid overlap. 
- Removed cx_dbgc range as it is already stable across chipsets. This
  region is now part of kgsl_3d0_reg_memory range.
- Link to v1: https://lore.kernel.org/r/20260405-glymur-gpu-dt-v1-0-2135eb11c562@oss.qualcomm.com

---
Akhil P Oommen (3):
      dt-bindings: display/msm: gpu: Document Adreno X2-185
      dt-bindings: arm-smmu: Update the description for Glymur GPU SMMU
      arm64: dts: qcom: Add GPU support for Glymur

Rajendra Nayak (1):
      arm64: dts: qcom: glymur: Add GPU smmu node

 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../devicetree/bindings/iommu/arm,smmu.yaml        |   7 +-
 arch/arm64/boot/dts/qcom/glymur.dtsi               | 223 +++++++++++++++++++++
 3 files changed, 230 insertions(+), 1 deletion(-)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20260226-glymur-gpu-dt-339e5092606b
prerequisite-message-id: <20260410-glymur_mmcc_dt_config_v2-v3-0-acce9d106e72@oss.qualcomm.com>
prerequisite-patch-id: f7ab29f2f0241b6536d3b0c0593f0baa0e435221
prerequisite-patch-id: 56c830b7718129323b006e492aed9822d7c30079

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

