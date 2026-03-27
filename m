Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6164610AB82D
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04FFF10E9C4;
	Fri, 27 Mar 2026 00:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mtynslot";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ixquUj/K";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F9A410E20C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:40 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QI5GPG1476263
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=86oPhv+gqLMAa0j+cJ2jUB
 7qTPKEeQ/+LJnNAbKDKb0=; b=mtynslotJpTOczkxLElMzs1iWs/b2oJTH/8PAa
 dQqglelng4O/8WaDqruaiqyDV8kLGKhEwZHoILM67aWsylYgSsrAG1Cjq3L573XJ
 gR3Mi9HupXLv4cp2uXb8LhFY6LDep2s5xgGP5XH/N2Y8XbcCFYanjjH6dTu6jGEx
 oqVtPBYuhQibJ+ttE7KAKItGoWwfAR/+9EArMkHKgQ4yl6TwNgKSeHe569JYP2AM
 phTWaaRVUt/UblVzuW/w5WSiGtQ6ICHh0BDCSePvSxS4wHQuo8TZsOFHeKrGa4Ia
 ePX9xRO7wrBMFV7/jk54AwLhX3wZrXCNWdGPxUVpF5m6O+UA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d59s410ps-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:33 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35c1874336aso4818250a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570473; x=1775175273;
 darn=lists.freedesktop.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=86oPhv+gqLMAa0j+cJ2jUB7qTPKEeQ/+LJnNAbKDKb0=;
 b=ixquUj/KNkXi8iCjdXOTz5x8VaMFUQ2j4JGhvpgiTwVzNk4ylfbA9ErTAzYJb3tA5i
 9ZmvF67+7fTkCnfYBeXF3ZdWd/4WPvlaZX/rmtKqYxejDMkzb+KWqS4+N7SEcND+Cs3y
 BdkovYj3fgYoOY0/82f7y6bdeHhVChgsW/yDww7eYP4jvYrjFlHTi/Qv93Ih4ykAPaQL
 l0yRaaQJuuDdYMu4Z1qS3JyhuskUR0GPA3kyZ7foJkBL4DN6n7nifz+7Mir070Crl1Zi
 qLqbrRbqNeW/Hdif82TFVNP2gN48vrROOPU/fWV3g6le7+nw4mu2rM7GSTdYTOkRsdR/
 N9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570473; x=1775175273;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=86oPhv+gqLMAa0j+cJ2jUB7qTPKEeQ/+LJnNAbKDKb0=;
 b=F+Fekt8k7QEv3A3MBNI4vG1HhpM9lVu5b51/jQ/VZEOTd8EWE1Smw+2ld6gDahqtoZ
 i5eUFBXDyHjkkRPWaNG/EC8cAKxXIKRwBXeL5GgM6e5ijFQO5ltYSRQzzN2SyVdp7+Dt
 rXoV/OZ61ylnmU75k0BeSC94VY+T95GNdu+VxMYscV5afBZuRWTXg0H1KgS+gjdjfBXH
 fZoNiK4okJEqxRtCMH5+Y9BFXDgDOOMWcFuIIK0Fj8BCf5USQMGZXNXRHT2LvZmeZfuQ
 t/BQXxlITniG7V3u0MvT1SB5qwhUVsKDYSYc87JSOYPGvejOWIFaN3f1eJz3JyClQPtr
 XBgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5y/lNUR16MediRkli3tHun75elQH36J/qkm92plqGS22TuUOM6L+Pg0G7lqHtWnAJUw00Vv905Lc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuFF/eFhCNkwLYvSdcpzlR1L7bCU1Iq1mD+5WYCzJsc+XE7lol
 CP3vyMTWWD2RTONXHNKTeSroJojZCPpsiBq63AWQ3Ch4PIJy7kBfVKbiyAutNCWMxlKzgB1A9E5
 vEoZRvaCzLGzTtjKAphcK/wswchMbKE1nhP/UM5IodXvwwAj7X69OpTHzgEIwJTasUQ/sRZE=
X-Gm-Gg: ATEYQzwwHA35pbmNvErmbvYyPMIUqPNVa3MfuXQFc7DIlPcM/W13fDkWfP7YcJbxVyl
 jTfDhVelHRWzRqVPLqzW1giX+/SsCJMFt+wQBkbwm1LEcSpPdGLvvVcSgGvN+WZ+F8T8Bd/WEUf
 xh5r23mgk/HyxBbIOVMOFe4dYQZZzhX86PBQFf+fezwA25ypQ7hyrK5vA9h3lqswuZD44l3YreD
 bIhVX6LTZWbWAVQ291tJjB/a9EWIIbx/Bw0S4VL1eFRVrP1T4NKlB/LNXtamNNt0++9nLVcNoV4
 SBjfjTH1ww2PPqwvQ8UHOkf8wcJt5pJJNxGo62TLuMmMAKXAd/ZHQROYB1F1InlWvbAbJ/65a83
 cfFLiy9A6NM0gVtjQmeH9tZHjy17m4Vad/hO8h9sZt6B7mA==
X-Received: by 2002:a17:90a:e70e:b0:359:3426:c60a with SMTP id
 98e67ed59e1d1-35c2ff07dddmr509857a91.4.1774570473023; 
 Thu, 26 Mar 2026 17:14:33 -0700 (PDT)
X-Received: by 2002:a17:90a:e70e:b0:359:3426:c60a with SMTP id
 98e67ed59e1d1-35c2ff07dddmr509832a91.4.1774570472483; 
 Thu, 26 Mar 2026 17:14:32 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:14:32 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Subject: [PATCH v2 00/17] drm/msm: A8xx Support - Batch 2
Date: Fri, 27 Mar 2026 05:43:49 +0530
Message-Id: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAL7LxWkC/2WOywqDMBBFf0Vm3ZEY3676H8VFEqMGGh+JikX89
 8bYXTcDd+Dcew6w0ihpoQoOMHJTVo2DC/QRgOjZ0ElUjctACc1ITCmyYt+xm1bkbBE9Rd7mbcr
 KhGRMgKMmI1u1+8ZXfWcj59UVL/cTOLMSxai1WqqgMRq11egZvFaQxEgyuNhe2WU0Hy+3RR7+e
 SR/HluEBFtRprxoSkGi/DlaG84re19ToTtQn+f5Bc+qZtbxAAAA
X-Change-ID: 20260322-a8xx-gpu-batch2-bf7f5a9406ac
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3550;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=obyboWBP3UrpDRtKN/55V2OMReShR93eEU0GfYkS7mo=;
 b=iwnQ4B1lqyh3HmXj4oNcEkiHP/fmein2NVgXXBA/6iLAdefGorMq2FZH40argtbnXmRD0/MsF
 2eK8NKOxU+JDhSEr66KU+fPKwdrvLj+YOddoxhpmeJvW9Ptba3JBQHY
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: zhW_g8mw6PjQpWd1IubNQqByzvBHgz_I
X-Proofpoint-GUID: zhW_g8mw6PjQpWd1IubNQqByzvBHgz_I
X-Authority-Analysis: v=2.4 cv=CoGys34D c=1 sm=1 tr=0 ts=69c5cbea cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=kWU0ogdI3319zGDV2rQA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX3E01aLRsG1g0
 26b/g3R1J/biz65Ycbf3IJdBDvO1PWWLeqcHQQsD39zO5nhETAPneC8i5ZZWueXu/ykuojXXyZC
 vLE5nzcci5UDsGNL7VnSVrwOwxom5NenGtSfwI04JJr+5em3yKrSanlwOlXBcjRX1L0QCUO8PLM
 I1m8A+hRbSsdKK/JpEw2iz2cqna7co+a1WxWWGnUlyzwvhnRu26yYyFWXc8UxcWIuuJofMRAfO4
 DOx9ZK/HyMeC94SB2DITOJ8TtPaObw8BWMXEVqQHxcC+QIZuXu6ze+4gi3TvjpmnYdPhAZz9DAX
 aLEaugXLqsqeSptW54gdM9O5p5AToqFZjLRIsSbTxWmet/wpigF5cLVe4qlfvMr+mB4HPQa0bPU
 vEkk6rC2ioiJrAcOjEoSiJJuixkqBXXmVQVlLEgBUEg3+FbvP2r0H4TWNe7xX5VYrBOY1Ca6Eaa
 lBrIPJBv7IK39xRGLFw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270000
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

This series brings a few additional features for A8xx GPUs which were
deferred in the initial series. First few patches are a few general fixes
and improvements. The next few patches adds support for SKU tables,
Preemption, IFPC and a UABI to query AQE support.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
Changes in v2:
- Split X2-85 SKU detection patch (Rob)
- Split out a7xx_gmu_gx_is_on() (Konrad)
- Avoid secure init on every gmu_resume (Konrad)
- Simplify code in adreno_load_gpu() using guard(mutex) (Konrad)
- Correct the payload size for CP_ME_INIT packet (Konrad)
- Remove unnecessary gmu_wrapper check in a8xx_preempt.c (Konrad)
- Few misc formatting fixes (Konrad/Claude bot)
- Add Fixes tag & reorder patches to move fixes to top (Rob/Dmitry)
- Captured R-b tags
- Link to v1: https://lore.kernel.org/r/20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com

---
Akhil P Oommen (17):
      drm/msm/a6xx: Use barriers while updating HFI Q headers
      drm/msm/a8xx: Fix the ticks used in submit traces
      drm/msm/a6xx: Switch to preemption safe AO counter
      drm/msm/a6xx: Correct OOB usage
      drm/msm/adreno: Implement gx_is_on() for A8x
      drm/msm/a6xx: Fix gpu init from secure world
      drm/msm/a6xx: Add support for Debug HFI Q
      drm/msm/adreno: Coredump on GPU/GMU init failures
      drm/msm/a6xx: Use packed structs for HFI
      drm/msm/a6xx: Update HFI definitions
      drm/msm/a8xx: Add SKU table for A840
      drm/msm/a6xx: Add soft fuse detection support
      drm/msm/a6xx: Add SKU detection support for X2-85
      drm/msm/a8xx: Implement IFPC support for A840
      drm/msm/a8xx: Preemption support for A840
      drm/msm/a6xx: Enable Preemption on X2-85
      drm/msm/adreno: Expose a PARAM to check AQE support

 drivers/gpu/drm/msm/Makefile                      |   1 +
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c             |   6 +-
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c             |  12 +-
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c         | 243 +++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c             | 141 ++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h             |   9 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 169 +++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |   7 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c       |   6 +-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             |  33 ++-
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h             | 155 +++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c         |  77 +------
 drivers/gpu/drm/msm/adreno/a6xx_preempt.h         |  82 +++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 162 ++++++++++++--
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c         | 259 ++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_device.c        |   5 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  20 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |   5 +-
 drivers/gpu/drm/msm/msm_gpu.c                     |   5 +-
 drivers/gpu/drm/msm/msm_gpu.h                     |   2 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml     |   4 +
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |   6 +-
 include/uapi/drm/msm_drm.h                        |   1 +
 23 files changed, 1137 insertions(+), 273 deletions(-)
---
base-commit: 38d568f154c66430920b01edc9c722ec14aa54d7
change-id: 20260322-a8xx-gpu-batch2-bf7f5a9406ac

Best regards,
-- 
Akhil P Oommen <akhilpo@oss.qualcomm.com>

