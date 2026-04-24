Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B293FED3DF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:11:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD29810E239;
	Fri, 24 Apr 2026 15:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Pvb9NuDA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T5RL8uQi";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECF6510E3E1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:48 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O988e0756616
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=TQKV5i7FQV7McTrmvPRkI8jVP94ZVtnhau3
 TwLw+RTI=; b=Pvb9NuDAjz3q4XgF6OPkb5+GfqXrFSlPilaYDxNlkSs7cgQ9UYB
 MmR1rj/dE4QOurE0Qfqh2C7npncirw285BHSHwU/35/lw1/Wf+OhFkSoyS7YvJLq
 Yr4fl89P6J5sXdC+fpNL7KmJI5rM0ep3g/ROYPGOBbLLlY5fKQPHMmfVKxXmKIkJ
 rqVLd8h0YO+coX8d+lr/fsWsoPJh43KHJ1un+7md4mJIQ7nfRLT9FS3B2ewd0MsV
 bxnU69jzy+RF/8oMm9QL0IZEDMOlaI+qZl35dpsFVVrfOLrZ/8e26K7ovWoa9SlI
 yahIpcGdNjs1f3oiFdhSPHZ1rHOJoeiDJdw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr4bmn08-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:11:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c76bfd7b9cdso3369513a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043507; x=1777648307;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TQKV5i7FQV7McTrmvPRkI8jVP94ZVtnhau3TwLw+RTI=;
 b=T5RL8uQiVnqulYmwSi30R+UHSUpg+Y5gHaJvnbrGliBGNUdNd1oceg4w4yJN3s6ZoW
 GUB9R4ZdCPbEs7rP4EfHNjrb06Sm+RRxr3WZMQFWrbqVNeFjW48wSsiG7hVdjdu+Lvrg
 PcVWablRwN+wRWDGgRBAYV0nQ9QZ3gRh320KlaC0LMs2i9ue6Mg/OLwEHB/pJWe5ZQ1D
 9APK98hnlmgJNuidLTYrZIOfHWTsqB1m0YuVHM3879vB6tcrSUvHHeHUZGmmylbXzKpF
 Ss2umVJGKStoCcdclzN7UNWx3FPYl/Lv0Ha8ypLwBYMHd81GZz8vuRFXrLZmJ9SHFB7U
 HHlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043507; x=1777648307;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TQKV5i7FQV7McTrmvPRkI8jVP94ZVtnhau3TwLw+RTI=;
 b=UIxPU2z8NW6tKogab0e6hy/u2nkObUOodS1pO3A7PE0Pn/T2wyW6m7rKThCYdneqNx
 3CGeCHmPvtr9FVQqqi45o5W8ap2Fy9cu+WT/GFMh3mgzUNdtAuIyxovc0xgDlvWMQLMn
 2/z1LCrTFYOSl0IDDmMUwon+V7V2p76BwVrUPxM2thaD4qi1l8veavhIr62oQJaeyUv+
 JDt37BHVbyxxojYJe48D3Z11WYXEBUaot/umuk3lKmvn2/k4OV42gRJ/uI+CxFNT7OKt
 eAWOv3Y48vuejicEM3CftTQC4IIBfmelDxFflmPVxv1nI4/n9IUKZo5igAtObyDeThPz
 ZOaA==
X-Gm-Message-State: AOJu0Yz5iHtsy6uJJv1mvRuG+TITJsLtJvnEqkleT+KyZdSJr3MuJ8dz
 7bQyWQl0WqW3F0CvFlI2BgfjHVfFnlEqLeRg0733TXX2IiSOhW/MUjfxQh7m3uDxeRVf9Q8w1Ha
 GAA6Yq2sg0CPXc/X/w2Rz8VE3dlEYr+uMtLVqrj5eH0nZNO6jee5o/x+XEcDAHFQkQrpkPP4LcQ
 3Bz14=
X-Gm-Gg: AeBDievIlS0A+uHpDD1HVsXzw787drwxapGqrfPX1x9kjPZ9CZqLP1lpOcbNcFKstEl
 cpVi/dIlFbodb4bjOsvQmdCceaFqqwzt/kdarQXWhDY0W3sngxv2eA5zXKuUyhHkfhtr+zDQWMr
 fXLaTVrpx22Vskk0lF7y1gBxSuQdUennFNwgHOrD+I1zF0cMmiRO35rNaMDFAR7XoKJcD3nvCuU
 5weBao6zAJ9W+uPC//NWV1lGXcOjjA08fHCPsLBR4A1Gmn3ChS3HuZ2GZKQ+lhkXntIaAXIpjww
 2dV0ESfzbcq2XNJkomQx4PRQyCLzTmknx7YuQNRllSPyoICdClgXk5xwcNCiclbpKOW9mjh4av5
 BS1kjGQno/Gpj286kvNwxiVsEv5ihjm3BOU109Zr8GPM=
X-Received: by 2002:a05:6a00:6c87:b0:82f:84c6:6510 with SMTP id
 d2e1a72fcca58-82f8c80e36bmr31088718b3a.11.1777043506338; 
 Fri, 24 Apr 2026 08:11:46 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c87:b0:82f:84c6:6510 with SMTP id
 d2e1a72fcca58-82f8c80e36bmr31088654b3a.11.1777043505645; 
 Fri, 24 Apr 2026 08:11:45 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ec0566dsm24084461b3a.57.2026.04.24.08.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:11:45 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Bill Wendling <morbo@google.com>, David Airlie <airlied@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Justin Stitt <justinstitt@google.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 llvm@lists.linux.dev (open list:CLANG/LLVM BUILD
 SUPPORT:Keyword:\b(?i:clang|llvm)\b), 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maxime Ripard <mripard@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 00/16] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Fri, 24 Apr 2026 08:10:35 -0700
Message-ID: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX4ZLfVBV3otE4
 pcJMoYLdBQym5q51JAQmpOd+TTxisVhVcKm5cVsDP/4BA6osH2QOi1QjHrTKlacBOKelnLkXLma
 1WKrtLaMxBBnLKoCiTIwG3A5SDTaRMeyVwlV6Y55wcNNl2a6T2Q401uJCXIWvSa7j6VTd+bgO1b
 Q+l5htmfcyko+M6tMSN6CXW3KgOpNyN4DgdeLBfISe2snGL8GL3eQv4fXKTxyKJd1lK3JsGAyS8
 B4EuPBMK/CxEM/2GRVaFBhraSq/KIhLRTMYspEvqQ4/NfMdQREKZdRr33g23c6/Z2WJrFhozhxK
 ziTzwN+iO/nWnELTOCioBSCPugUrjBB8QUgYnaU1MFSKbFN6O61aThuOUwkDr0louT8oibLP0JL
 nzIWmQF50+zl7t9rDoYhZBH+qiuXuXpD+zfBlbNJbDvkyEseolpp2QEjSr/Y3to49RX5kfGbFT/
 WDTvuzdebXS5zKUCEGQ==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=69eb8833 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=j6mXroKpKqDHY7BEWhIA:9 a=bFCP_H2QrGi7Okbo017w:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: -1b3sJvcntUVMwfqt__obxV9gD1ZBraU
X-Proofpoint-GUID: -1b3sJvcntUVMwfqt__obxV9gD1ZBraU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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

Add a new PERFCNTR_CONFIG ioctl, serving two functions:

1. Global counter collection (restricted to perfmon_capable()) using the
   MSM_PERFCNTR_STREAM flag.  Global counter sampling is, global, across
   contexts.  Only a single global counter stream is allowed at a time.
2. Reserve counters for local counter collection.  Local counter
   collection is local to a cmdstream (GEM_SUBMIT), and as such is
   allowed in all processes without additional privileges.

The kernel enforces that counters assigned for global counter collection
do not conflict with counters reserved for local counter collection, and
visa versa.  Since local counter collection is scoped to a single cmd-
stream, multiple UMD processes can overlap in their reserved counters.
But cannot conflict with global counter usage.

In the case of local counter collection, the UMD is still responsible
for programming the corresponding SELect registers, and sampling the
counter values, from it's cmdstream.  But by performing the reservation
step, the UMD protects itself from the kernel trying to use the same
SEL/counter regs for global counter collection.

For global counter collection, the kernel programs SEL regs, and sets up
a timer for counter sampling.  Userspace reads out the sampled values
from the returned perfcntr stream fd.  Releasing the global perfcntr
stream is simply a matter of close()ing the fd.

The final two patches wire up the needed support for global counter
stream collection while IFPC is active, and drops disabling of IFPC.

The mesa side of this is at:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/41158

igt test at:
https://gitlab.freedesktop.org/robclark/igt-gpu-tools/-/commits/perfcntrs

Changes in v2:
- Rework makefile magic based on Dmitry's suggestion, and add a2xx/a5xx
  perfcntr tables (although only a6xx+ is supported at this point)
- Fix compile error for compilers that are picky about a struct that
  only contains a flex array
- Drop a6xx_idle() under gpu->lock in a6xx_perfcntr_configure(), replace
  with perfcntr_fence that sel_worker can check
- Add a7xx+ pwrup_reglist support for restoring SELect regs on exit from
  IFPC.  (a6xx doesn't support IFPC, and the pwrup_reglist works a bit
  differently)
- Stop disabling IFPC when global counter stream is active.
- Link to v1: https://lore.kernel.org/all/20260420222621.417276-1-robin.clark@oss.qualcomm.com/

Rob Clark (16):
  drm/msm: Remove obsolete perf infrastructure
  drm/msm: Allow CAP_PERFMON for setting SYSPROF
  drm/msm/adreno: Sync registers from mesa
  drm/msm/registers: Sync gen_header.py from mesa
  drm/msm/registers: Add perfcntr json
  drm/msm: Add a6xx+ perfcntr tables
  drm/msm: Add sysprof accessors
  drm/msm/a6xx: Add yield & flush helper
  drm/msm: Add per-context perfcntr state
  drm/msm: Add basic perfcntr infrastructure
  drm/msm/a6xx+: Add support to configure perfcntrs
  drm/msm/a8xx: Add perfcntr flush sequence
  drm/msm: Add PERFCNTR_CONFIG ioctl
  drm/msm/a6xx: Increase pwrup_reglist size
  drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
  drm/msm/a6xx: Allow IFPC with perfcntr stream

 drivers/gpu/drm/msm/Makefile                  |   27 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |    7 -
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   16 -
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |    3 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   16 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  205 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   15 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |    2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   33 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c     |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |    8 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |    7 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |    6 -
 drivers/gpu/drm/msm/msm_drv.c                 |    2 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   13 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |  119 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |  104 +-
 drivers/gpu/drm/msm/msm_perf.c                |  235 --
 drivers/gpu/drm/msm/msm_perfcntr.c            |  620 +++++
 drivers/gpu/drm/msm/msm_perfcntr.h            |  155 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h          |    2 +
 drivers/gpu/drm/msm/msm_submitqueue.c         |    3 +-
 .../msm/registers/adreno/a2xx_perfcntrs.json  |  109 +
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml |    8 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml |  141 +-
 .../msm/registers/adreno/a5xx_perfcntrs.json  |  128 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 1300 ++++++-----
 .../msm/registers/adreno/a6xx_descriptors.xml |   71 +-
 .../drm/msm/registers/adreno/a6xx_enums.xml   |    3 +
 .../msm/registers/adreno/a6xx_perfcntrs.json  |  105 +
 .../msm/registers/adreno/a7xx_perfcntrs.json  |  228 ++
 .../msm/registers/adreno/a8xx_descriptors.xml |   96 +-
 .../msm/registers/adreno/a8xx_perfcntrs.json  |  240 ++
 .../msm/registers/adreno/a8xx_perfcntrs.xml   | 1929 +++++++++++++++
 .../msm/registers/adreno/adreno_common.xml    |   42 +
 .../drm/msm/registers/adreno/adreno_pm4.xml   |   50 +-
 drivers/gpu/drm/msm/registers/gen_header.py   | 2079 +++++++++--------
 include/uapi/drm/msm_drm.h                    |   41 +
 39 files changed, 5968 insertions(+), 2212 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.xml
---
dependency: https://lore.kernel.org/all/20260411150312.257937-1-robin.clark@oss.qualcomm.com

-- 
2.53.0

