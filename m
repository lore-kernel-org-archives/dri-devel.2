Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A784FF885A
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F79F10E80A;
	Mon,  4 May 2026 19:08:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nu/yXbXE";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fofdRfYl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 693FC10E808
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:15 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644E2uht1187279
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=QzGN39/k9vpS2EcWVM+qBeoV72MYzkEJR6Q
 UrJ9Mhpw=; b=nu/yXbXEAggVijSGVSH2hkK5whhv+yzflbOZRmeJM9IfWao+Q2c
 Xoz1ddKSClBPYDIH1YAbNMXyLjxgBWYb7iTM8XeSbEyZoabZIMS/pR6l+An/Z1O+
 nKs7DydhtrP7sL8aH7UM0TM8JSyYgtAx87oZqnTTR4/ROPSsDIQ4nCF6C9C7bkEo
 riljkVYbYs49/0CW/pINQQnC/UvgDsftCrOZrAX35nr3XOAAzBO8wpddj/8P3rpS
 EwaD5CHwx4rg2rPykIipZdkfqT4xL9GZICQTywKIb+H75na0Dacxb2dxo+tyJ3vh
 zF1wJCJzvw59gA/e9kyeFrb2C0Zu/+HATkQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvg97cj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:14 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b9f5ac4e36so19684205ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921693; x=1778526493;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QzGN39/k9vpS2EcWVM+qBeoV72MYzkEJR6QUrJ9Mhpw=;
 b=fofdRfYlQWOYtPa0vCr8uLFxpAxIkKHnPxhJ2SngbbN7+rS8Efm5QQc+fjKyji4dpq
 lk8g74CY9ubu3pnpJSBFuC2jqUS/eYtiw4f3j6luzH/B13Ctmd7sHV4HDYeICL0O/drq
 rTzzh0DrJqelRoKMymczK8k5ShmIzaEs3y1dCbw3BPPVPb7p/QJ/I9X5ctfKRY6/HNYZ
 IsZACb8ljJz+JdCaE4D8rK9Cl9hwLQvVIgTkCAA5p3koMkvJl3lV6JoEaXCvoDlmcnWx
 aYTdDUygv5ZPg3YGk/+7vOoA5WvACTJ/unP+krxjX4NqIsSAOcAKx+C+LVWB82YdVhF4
 isuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921693; x=1778526493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QzGN39/k9vpS2EcWVM+qBeoV72MYzkEJR6QUrJ9Mhpw=;
 b=Rh9Y9mDKQAjfFkbHR7IzW6EjCibNHS6MW1clYq+Mveib9a4sfc4dHSkjvMLg87Xm+0
 0MWc7Dlbq2YT0jmVnObGESRZmxvYf6ZJNVlKuDP/oEpKJg1Mcz5ivqm+JyxRiLdSxK/u
 MUSwHGnod2iX5/W5lIQSvNvZX8NygvNsysfJ5oaumKDL12M+3fzs7+v+jyznRcU7Tqe5
 AAaI8/Bkh/9mKzmmBSEILvb+Kng7ZwsRRsvPJwPx08vg2b0krBQVXAHVfELYkjt/kYew
 IrWkX97PAMVY/XU4KUMiHygptwoWNG4L/s1WHWGvvxghm4/ERAB76ktZOngwheHCDqlv
 hOaQ==
X-Gm-Message-State: AOJu0YzdZ+9hslTReEgsYZDgacUBjET2IFknyv/ps/ZGEqjLFC7NEa87
 Z/p28F/Y9lA/cnOziq6Uv1MODdHHLNBWjqkJOQ+TpFKutT57aRe1lh1FaPxxRB3+U/gKOdu3Twr
 cSeIV+ABp84QgZguQzmm7u1ork1vup3ni2shzNpaUOQyY8zEgUldo+WzKaxSwZ8vT1N09fpFOT+
 r5m2A=
X-Gm-Gg: AeBDiet4WrUT1jTavoJqccCCiZ+vu3R0IG3PZ/G9A3eMZx6M5LC21InnoJIXJMin7fR
 jjX9wpfGJS7m6jC6+qm6t7lIsRU6lDIAXbWxbGhM6V6Vmp75xVUVxUPj/En/9LLELdvMJdeCuP6
 KctWO3ssgMxZ9ZwTNpz012LYQDi5D4knumK4j2E8QXEStQe1mHsOgUWOhFN1hRnykvnotgoLlrs
 kgQYn1ngw+sIx0U9EhcqcnUWWs7rHutZ7Cq6DhkrPrczsnp6bbXI8LCbVkpBNiq21xIgjSsDo8j
 auSxZM2Xw1FMPYCWESbaR1lyfkIhTkNi0R1XivyULCcPsMP+M+8YvtBRblRQGL8HBtJ6cccgejE
 Nt3sYTU6mfS3xAwfJ4QOOFPYcEIHEvYL3OLuS/ekJ0xM=
X-Received: by 2002:a17:903:3c2e:b0:2b9:ff02:a15a with SMTP id
 d9443c01a7336-2b9ff02aa03mr94424855ad.9.1777921692867; 
 Mon, 04 May 2026 12:08:12 -0700 (PDT)
X-Received: by 2002:a17:903:3c2e:b0:2b9:ff02:a15a with SMTP id
 d9443c01a7336-2b9ff02aa03mr94424425ad.9.1777921692207; 
 Mon, 04 May 2026 12:08:12 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae1e293sm119619435ad.45.2026.05.04.12.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:11 -0700 (PDT)
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
Subject: [PATCH v3 00/16] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Mon,  4 May 2026 12:06:43 -0700
Message-ID: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cSR2QwMLPUfQxxtwMHdukgoocNTZxvDF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX2YJXChS7zP2y
 lb1nQtT46/z4yX4Eoou2fJ8sL2gGH8Ga5i3DXTJBZi8IgDhoB5hNeM8wkjapBU9lGOWXKgxLn1d
 36kTZKsNwc1kYR3xE8fUNfvEKd28TkXFUY/B4iayRBbyDtRwjoskh+PBj9JOJjDkznboYiT21Wb
 qfM4L3zzmImZK2sN2sI0ec+KkXZk8ewEmhdUPaxXGjYxao87H39Kd4SOyNi4K9DlMiwUMwwNZpN
 m+QIlAAweTVmw9Px32ygicVdHfMLwRZ3IvF7ivUeZSU4NeosvqJVJkrj5hKHSrNjAAPsnIV+632
 9L49B7srLJuyuFwo3SJrvRwq7ENO5ijLPE00rjOP/TXbhW3sNvWpxsY8Hi8XVnLxZ05iQbaI6Ze
 1jj1Fen9nmhAIu+TjatytD4DsVqGOSOhth1Y0VmViaEhhvcyX5ika+cUCdReCDhsoF635OtTJec
 9zxrpikmp88zTDE54QA==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f8ee9e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=j6mXroKpKqDHY7BEWhIA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: cSR2QwMLPUfQxxtwMHdukgoocNTZxvDF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
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

Changes in v3:
- Fix loop counter issue spotted by Claude review
- Add MSM_PERFCNTR_UPDATE flag to ask kernel to return the actual # of
  available counters in case of -E2BIG
- Proper barriers for modifying pwrup_reglist
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
 drivers/gpu/drm/msm/msm_perfcntr.c            |  638 +++++
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
 39 files changed, 6005 insertions(+), 2212 deletions(-)
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

