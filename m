Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D075CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6410C10E4E0;
	Fri, 22 May 2026 17:34:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oU4/ioBB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GdsWsR/6";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FCC610E4E0
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MGMCBs3005817
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pqGG+UjGql253bxtTVKZZbAD/GfaNDndOan
 MEIC/0d4=; b=oU4/ioBBU8q2kkfCoBDSLPqj7jwdVuc4KsFxbtKg/OhmHE6o7zL
 q3wuJcQe8Gwwh0gCjXPbXG/PAGBvcC+UCYWy3hIsNz1nsHQjUUxdO0A+BRsrBmxb
 QWg+IP5r42fbGzlv6Wp6HnnE0WIMPjJuEeaC+p1WsIejCq/7n+AztR1JXwmJI38k
 IEmhKmB0UBSmumUuy70p5kus7LlW8AnI5v/cf2cFgHrd2HggELybr25KjrEp6TmF
 x/uG0k0aaXecY0LC3ahXJhlGEnvPBYD+xUktmBTjr3HitHNH9y+T0wKvJgbdXVcB
 Sa6YnoF+MuqNP8F3kPXhH2vboozQJVMgNyg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eafrtb88c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:30 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2bd1dbcccf6so127142535ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471270; x=1780076070;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pqGG+UjGql253bxtTVKZZbAD/GfaNDndOanMEIC/0d4=;
 b=GdsWsR/68Ar8k3p9GsjCCEBkvNKmrr7WcsdVk6coHhgEapy7wOSEce4Jp/5T4tb5JD
 l6RZ78hq0LNgTUrUbQaehB6gKvz/RolceM7gEcYPF4be4MFqnJivsTljZfS87erB3jL2
 KYX3WdvUHu1iNf9UdUdvFSOxiBiqk5jszoM+xbXUb2McE/MVDKRVkZ77o11sqvojXdMk
 qbwizHCSv54qc2b8E53byxDmbeDh/2hAPlQYPQD+K8JCpHyAnOokIjvYvIdTYidU01r/
 3u56Ob9CNS9PchdkSNAORrDYj08CVHNjkplRA6uCt/qwjJcfG4eU4Ob+bGWqYcOIYK+L
 OdhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471270; x=1780076070;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pqGG+UjGql253bxtTVKZZbAD/GfaNDndOanMEIC/0d4=;
 b=UjOeT8r74PJZKkHQb9ZPzU6+swKW+zGIDcz5NYMYx//eJA4tUCZh0MRn/5ECjSd93U
 I8WB+IFoBswq/trBjuPwWwkzZ9txSgcAWmQBQ9grmYsf/TCxiRXPZh8dtoNTkV8DXvce
 EtOYRi84Ak9xfZAGFn6Lre3zvLvN5V0OVm+ejquLq5INKgoJrTOo3to6lBg1W3McYnBn
 m4bb1y4AtD75Op3hkDZpkxFtmUsGmPLjRhKbDGD4Lj6CJb3zxMBEEGvDwHUY/rqs6teS
 WgJs6YZeakuHKaNDt57GJZqFi767w7ocCjC8Bo0IurONpoFzypg6yCB3CiwoNO7Rwpfz
 scYQ==
X-Gm-Message-State: AOJu0Yw44+JJiBdUGsKbd6afu/FA4Vc9+J4a6hGoFFo9cZJCxU7aj+qa
 Po20SpequL2/iNzYZaFkXysD5GVRxViEcU5R7VxqyFNVsy1k08/A5MgddMAY9LVLHzWX+hLdtrN
 roSq4BGgbZ4zgpRwlYcR+44HSiFqLob2v3TTEBrKnDg0R+jfZpVCc/UHJhPDCproA3nTLr47MPB
 30CTs=
X-Gm-Gg: Acq92OHDy+1Dd0ZpwtdehqSGy/h1qY0IrvjR+2r/BqoJreHUw/W3KE7XznmCnY+ePwz
 uEtPBZ+PT3NQ/l7oRV30FiI6qOUe9OfYfw51xwmjKucel5w9fwP+903ZxRNlECR8+iw0h1a4Wvg
 lwMXZvUFxTdpTElZmY917/Q5VclEl4js4Xji1NmbNMg3ft4X7bMuCW+7Mu26O99K+j44xw/tv+k
 H9Z3Ns/1fagmMvBGg+qlU5zclJa0PTuNDTSdQOHEd8Y0aX0CMzxktiHdTd9gWxzQ9Mrj2vdCl2z
 JZAgNeg0uDWBFVgPpS/kv+sqyHPmbiFtldPTuJ15EGIterYLgBOUOouP0lxRt3CfUlGPYeIu5et
 9XxtwOLO0wgkK51hjY8xOeuH9UeUJFNtp
X-Received: by 2002:a17:902:e84c:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2beb06aa272mr54403085ad.31.1779471269587; 
 Fri, 22 May 2026 10:34:29 -0700 (PDT)
X-Received: by 2002:a17:902:e84c:b0:2ba:4ad9:70f6 with SMTP id
 d9443c01a7336-2beb06aa272mr54402575ad.31.1779471269000; 
 Fri, 22 May 2026 10:34:29 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb58d9fe9sm21341175ad.65.2026.05.22.10.34.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:28 -0700 (PDT)
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
Subject: [PATCH v9 00/16] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Fri, 22 May 2026 10:32:46 -0700
Message-ID: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JN0LdcKb c=1 sm=1 tr=0 ts=6a1093a6 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=y2SdjSjt7DsdxN5ViJQA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfXwk1e63ZLksly
 /EFgkQeBO70FZr0R+lz9FLpxOEKNtjMcxO4PVGDQe2mCyE2gwKpIudeYD5acSPR6+28bEvW9aqc
 24AsPRJvtlrDlKS0/1EmdwBid0JbtzMosPDJ0CC8FsOWydGI0awgbMiJNKjtfq6Xac9ToTtIE3t
 VoGllSyGpF/JyfebMd9HYKoHIvT6Hm3mW+mPTdu03BBWgkgYKPtQ6gKq9bjl0fRKpyy32Y8DCAG
 HIrL35buwMSn3waVJToBRHhSMYzqnqriX1bjBYbUjwV07MoQRX/Z7MSEn8MpYm8o3ulcPo8d54I
 B9uj/kaLGzhnz83vdTO5erd+z5upaSnoDB2XnC6tl92DUDF7HQ1HZLtXSBcMIFIULQJn4TZueSL
 rx9L1fkghsqohp0ODfqbxviJPAaihtSdwEMl0Jym1B1Zd7OTNlVILjy1XlJVP37WEsQxW9S3ZWa
 ikD3QRgrABhWXNHcxSw==
X-Proofpoint-GUID: XVGwoVkLFrfX6SRr33EOH35AbSwFTEFn
X-Proofpoint-ORIG-GUID: XVGwoVkLFrfX6SRr33EOH35AbSwFTEFn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220175
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

Changes in v9:
- Fix msm_perfcntr_init() error path [Claude]
- Fix off-by-one WARN in msm_perfcntr_group_idx [Claude]
- Fix error path leak of allocated_counters [Claude]
- Fix copy_from_user()/copy_to_user() stack corruption/leak [Claude]
- Fix fifo_size overflow [Claude]
- Use kzalloc_objs() where possible
- Disallow duplicate groups in PERFCNTR_CONFIG ioctl
- Add WARN_ON_ONCE() for pwrup_reglist overflow [Claude]
- Link to v8: https://lore.kernel.org/all/20260520162454.18391-1-robin.clark@oss.qualcomm.com/

Changes in v8:
- json fixes [Akhil]
- Use dma_wmb() [Akhil]
- Use kzalloc_obj() where possible
- Link to v7: https://lore.kernel.org/all/20260518190735.16236-1-robin.clark@oss.qualcomm.com

Changes in v7:
- Use smp_load_acquire() for fifo_count_to_end() [Akhil]
- Defer installing stream_fd until end [Akhil]
- Link to v6: https://lore.kernel.org/all/20260514134052.361771-1-robin.clark@oss.qualcomm.com/

Changes in v6:
- Reword comment [Anna]
- Link to v5: https://lore.kernel.org/all/20260511130017.96867-1-robin.clark@oss.qualcomm.com/

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
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  219 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   16 +-
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
 drivers/gpu/drm/msm/msm_perfcntr.c            |  667 ++++++
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
 .../msm/registers/adreno/a6xx_perfcntrs.json  |  112 +
 .../msm/registers/adreno/a7xx_perfcntrs.json  |  228 ++
 .../msm/registers/adreno/a8xx_descriptors.xml |   96 +-
 .../msm/registers/adreno/a8xx_perfcntrs.json  |  240 ++
 .../msm/registers/adreno/a8xx_perfcntrs.xml   | 1929 +++++++++++++++
 .../msm/registers/adreno/adreno_common.xml    |   42 +
 .../drm/msm/registers/adreno/adreno_pm4.xml   |   50 +-
 drivers/gpu/drm/msm/registers/gen_header.py   | 2079 +++++++++--------
 include/uapi/drm/msm_drm.h                    |   48 +
 39 files changed, 6044 insertions(+), 2212 deletions(-)
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

