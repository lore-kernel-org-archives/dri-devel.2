Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A4BCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94ED110E72C;
	Mon, 11 May 2026 13:00:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R2C6XVCV";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W/74uj3g";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D5D510E72C
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:00:58 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B7ALGc452800
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:00:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=TpHroqNFYrbHc+Hyc8A7RZr1LE9fkn+T3bp
 iGnJTfpQ=; b=R2C6XVCVvTqmEEametLLwmbGpiJulaV1Y+BOWVVqDjhIFFg8aRC
 xmB/XliURraDnSSLGnUaAgX88jgeiWFfgELdoa9ip4I+g8t14vtxamEBtxH8sxtL
 1UhCht5Gs5aMdRp9akAE8u9MIl9VZ85Kvo+b4iEwDL344+eS2Q6ehb0fOLICSJfY
 p/h2hQIFZlPwTCW4d/gXUZPq/JvAsiJEIC79vnapG9Xn/qScpFyXpQAkIrkPRan+
 rYGWZE8TNrX8eBGeV9wBUGbIT3hb+JgIJx8eld/IFG7sA9pNHXekE1kj1mi+Fphi
 CNWpm3xbDS05NoJqQB/A+iNSyYyho3S+Wfw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3ag6h6es-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:00:56 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9fe2d6793so79057885ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504455; x=1779109255;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TpHroqNFYrbHc+Hyc8A7RZr1LE9fkn+T3bpiGnJTfpQ=;
 b=W/74uj3ga62sdZo1CYhsghNqOJl9PCf2SQsl7k/8Nr+dYp+6xDp1ih6OrXRmNDH+zr
 miOLb14NZxCxhO4fpoFy+WiVsbQqiH+glN3RQx2iPLApCm8oDTQ6rnykPFBxcc/+f1z0
 Q/02pHedBzg1QKxhkj+X/if4IADoD3YYc/UBFooKS46vtQkwRGV6cHGL0QeR5np6e4uT
 lnwsDvxgG3DpeuD/cSuuwMcU4iQfjU8ahrI8ix9RPn3LmdFXnupl66LpZ20zMLyy4WmI
 bFxupH4hf5bMGEbjxCiy6Bugvql048tRR1JaVlXuqjsFzLNPYp+mnwGD+lxGy9/H71zJ
 Z/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504455; x=1779109255;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TpHroqNFYrbHc+Hyc8A7RZr1LE9fkn+T3bpiGnJTfpQ=;
 b=bT/CC0cyE5EfpeRqo5WiIgYWEN3VRAxEdabVSLn9IpgDFu2/F4KLBkXZI1DquCf+sK
 RgQqrBGCGKseyXhRrSK4BDpFkvFlSEyjIgjHVOsWiAwKsPHn8aZytADqfTN+LZo1OaMP
 SeUPKXubvqj1vV22Y9/e6in9TBdY3tXdezLGAgSCYsHKBYTzeuam9W1TFaJK9PfGpVGs
 ZGUOwLHL0tecYruUQoLpaZHVLy2DxTbxD8yDvQq+mXXZylmC35REV+NZdNO9BH7ALahu
 mbks+d7+GRlkAnA5RliPkP02RRLubaEM+u+GGv7luj1ocA4VvnotOyzlWI/uhcziIKez
 HSSQ==
X-Gm-Message-State: AOJu0YxOavAQ+nj2HXivW06RLEaaQLM2yHWxfCW3OzZMPjYCmE8SC5hS
 EVy1vvqEqWk7J3m01KzxPuadLcSjICyCb9ukTQFaAMLDTZwPA1+ghuk0lk7sfkXd/aIhjRH1PgD
 DbLmRpy2GmkZMKI7wL1YoEcXvZ40hishpCV0W3O2IF0HAWb7QweYAaal82OevRBaXBvW0+vGbuq
 CaLe8=
X-Gm-Gg: Acq92OEXQqv8w89nxLQfBc/4i/1NlDz/p7wdGR6tNqHp0vyCeiEyRNZasyAhNZ1Bh2V
 dQWEou9mvGEpYZV/zoUiDc0SrTqN5fVNMq2umX8z4N3VZSCNSsBzyz1fkxahGtl77lWOdnziYYC
 ujHDUFzLfZRtX1r1ZEhfymb5j4ozX2ko1MdaDH9NhoBhws8GPycf14LpNjCnsYc1VOKd/6hr9R0
 NMWMAYHuidtzn5KR29ki4xbtcPqp0Au2GzU5kZhbX2wszIeDCqXV8iMwb39ltMK9h7LVYG60DAZ
 XQ4GV6bl+5cyvVkPV83tPGz+oS7vIjwsTrI5wEsbpcM0lulkgu8pl/uI3rK55EXedCPrApkjW3n
 c2AnqsGb1vlf2rhrBMBA2ZScq6KlCdQjK
X-Received: by 2002:a17:902:7042:b0:2bc:e299:4c9c with SMTP id
 d9443c01a7336-2bce299504cmr15972015ad.3.1778504455159; 
 Mon, 11 May 2026 06:00:55 -0700 (PDT)
X-Received: by 2002:a17:902:7042:b0:2bc:e299:4c9c with SMTP id
 d9443c01a7336-2bce299504cmr15971115ad.3.1778504454330; 
 Mon, 11 May 2026 06:00:54 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e9723esm112028105ad.67.2026.05.11.06.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:00:53 -0700 (PDT)
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
Subject: [PATCH v5 00/16] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Mon, 11 May 2026 05:59:13 -0700
Message-ID: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fOsJG5ae c=1 sm=1 tr=0 ts=6a01d308 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=j6mXroKpKqDHY7BEWhIA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX/xIdQJJEMh8L
 devoIp+UYVwS5bCCZGpP+8nmI5MZmx/UaxyA0JSFXLFh+5BUV9flDSxDG7q1G+c2Iosj9D8zK9V
 C6uxajof3Xi9+VkPPOk5jzv3bKxDpUfvvao4LV7r+BIcWw+m7WwP0mL7PEJ7LkUKenLNBpRZtqv
 RqSTzXWUeZoLrVf+nQD5F0DSk3YKbqHQss2fPW6OsmzsueyWoHLDAcoZIib0NIfGGW/qRpan+Su
 EqUX5spVz4+GsAJGCELrsK4MLV3+QcDvfnPptmGPgWhUaRjfiPH6y4RXx9xZLKz7hhsYsWXzuy8
 TLqIMa27HOUO3btdAm1BqhEWkOGMRSjRSUyM/Cmw5yFo79j9MR/v1abaRiDntFebyGCd/VX68wu
 Ewa85bwiUC21wEykKQxqHXo+VBpT2kUOaztHTjWN2ryK23iSk9qRfWWGvcfgvtEUjxiz/4HnGRN
 909RXj+CR6JI2QGD/WA==
X-Proofpoint-GUID: BalGTk24eMjJn-Wd1LpMd_mNkbJMUCC-
X-Proofpoint-ORIG-GUID: BalGTk24eMjJn-Wd1LpMd_mNkbJMUCC-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110144
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

wiki page about the design:
https://gitlab.freedesktop.org/drm/msm/-/wikis/adreno:-perfcounter-UABI

Changes in v5:
- Drop unnecessary runpm in ioctl path
- Link to v4: https://lore.kernel.org/all/20260506171127.133572-1-robin.clark@oss.qualcomm.com

Changes in v4:
- Fix null ptr deref on older gens without perfcntr support [Claude]
- Add upper limit to userspace controlled FIFO size [Claude]
- Fix nr_regs calculation [Claude]
- Link to v3: https://lore.kernel.org/all/20260504190751.61052-1-robin.clark@oss.qualcomm.com/

Changes in v3:
- Fix loop counter issue spotted by Claude review
- Add MSM_PERFCNTR_UPDATE flag to ask kernel to return the actual # of
  available counters in case of -E2BIG
- Proper barriers for modifying pwrup_Link
- Link to v2: https://lore.kernel.org/all/20260424151140.104093-1-robin.clark@oss.qualcomm.com

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
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  217 +-
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
 drivers/gpu/drm/msm/msm_perfcntr.c            |  648 +++++
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
 include/uapi/drm/msm_drm.h                    |   48 +
 39 files changed, 6015 insertions(+), 2212 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a2xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a5xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.xml

-- 
2.54.0

