Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C4FCD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F6710E6A5;
	Tue, 26 May 2026 14:54:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lEwh4jRO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VJt89PrW";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2774B10E6CF
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:55 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsUv22385433
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=cwRQp5DMbK857hmccvlsN6Xv6Zd9SmSWZCT
 NBea45cE=; b=lEwh4jROiy7b5bOqBdx5Dj7n+fUnyiimN8+wZZ/kSOh8n29q510
 OyBYZlx/6v/jkOWWpSAApUqShNC6CX7CH1E6qo4S/pWFMU7vT/LWBvlmMjrAXhJr
 s1Qjqj5tBwzIfPOLpkd7H4cybHv7V/STNmLvGpS9iraKxc1n9MuO1xt/AKWCIlUq
 zq3PnwRVC2l/+pZqqpgNCChe96x7XCje8ZZ6Y72rx3cdiCjvGPhBU4nAZQ5CIoO5
 jogMNNjuRczOuMONQ0VlUhO/WzwAeSlfq22ofYiyAR1gjulNKz2TgH3mQcRAHb4c
 ROTX+9OTiLboSLPnHoXFcYPkD0FzUNktYiw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecnhs5b3m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:53:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-365faf6006dso10381279a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807233; x=1780412033;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cwRQp5DMbK857hmccvlsN6Xv6Zd9SmSWZCTNBea45cE=;
 b=VJt89PrWjalTxw2TiDvCAvwSLqQiU3UX1xpKQ1P6DyGMbJnzljI8pCO4Tt07pRkapF
 5U0qV22XCZNdOCWaeYkcOptRCxBxKtxFxSG++l9dtk2URWao8LkGBzdaItc3q3s/yYfq
 iBMZUNN4A0qyOQRJWhbgcghKZBiMNoqlHUc9VXkD3unZwRdNnu3gv/GtNho6g4BNECO2
 n9fymLauQ4aGRR6rZQ/6zzntqSUt7j0yww6UZ1+CxSr1YTOX8fQnrmdaEEKcnHk4VDWL
 kAjERXOzkq2ukoi0q7pUdXaDgsTIwW7D4zc7M/4lXFR2ucXojGRnTTX3mhYrJIbu1x4Q
 SN0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807233; x=1780412033;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cwRQp5DMbK857hmccvlsN6Xv6Zd9SmSWZCTNBea45cE=;
 b=Qq2KPcvt9HCazT1jwu50J7j2Y+NHKJlEHXGTjgX9Zm+HPTuDlbISAmIKcJWQ2lPAml
 VU+tKC1obGsgsJ8860vYFVR2QcqXJS/zSsund/dagb5QIH6aOaub8PcI5cRAxnVcAt2b
 NJ6cDeVtkDmS+JuJvDeURl0vUwPFlAFA9ELXPYUdNnz4NiMjQZp2JAvoLmKssHpvjb4p
 2pZnDJNAjOFUIgSFZJQHH+SjBcZlwzCZbwxoD3avtoyT/iCiO2+JE2YNkOskAE9744Qj
 66Y2EN4jXpt7XRWXIhK23sYe68yWFgWscFjzM4f6KrIsLVDxC5lfwvNzGEBqFLctbRkE
 KpSg==
X-Gm-Message-State: AOJu0YwGS7Xl4xTXtVptqlpk1o7OKE08JDZnAmEB1d3dABFHvNMJjJiu
 y8mtKz68pYHgkw1xGJs8pKLJsnVYsDhDeboRl/nklHI9IUB+yXygCeZFV+T93N9Qp77jY0qg5Tn
 GrHNHi+cZ5WkZ3ziXk2Hd0V0+JR1bMJhr82/2JsJBjbFtcHtEiHIepsiJjB5QtHOB43LnSJfuMt
 fiA1g=
X-Gm-Gg: Acq92OGZUF3aPhFStn1UdC85kR/1l5YSQELD4cGz0eaovAvHyMEVKzWb324HiK+l3o7
 F3gBwzLviz8rvgyxZdYmJS7tWquoIf9YfFJJy9zFzcRHoWpYrWM0wMwgXFDYS46iXld0c3BUq/S
 3pJHW3y1QAxMQEnUkrkvWERSzyAczQcDUnN77rI0vBey7jZHtOGYiqQISZV178yCoLcnec8SrPm
 wHYXTXVsBbhi6exIefJFYrXWcm1yO7rRJ8v+Rfspm3orGEzql8M2EOEobRoPFNKvm7Umg25GvLI
 1lEbW9n3ANMtueVXw99caTDd0lIM3Twa70NWgVSmGEathNrBdQc7JKdoKPD1UG6el0KlBCUmE+I
 wO11MCKPliopNN3Oy6SSio3w61ti9NsiU
X-Received: by 2002:a05:6a21:618e:b0:3b2:864a:ed74 with SMTP id
 adf61e73a8af0-3b3293bb68amr20294619637.43.1779807232872; 
 Tue, 26 May 2026 07:53:52 -0700 (PDT)
X-Received: by 2002:a05:6a21:618e:b0:3b2:864a:ed74 with SMTP id
 adf61e73a8af0-3b3293bb68amr20294576637.43.1779807232379; 
 Tue, 26 May 2026 07:53:52 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c852056db34sm10757809a12.27.2026.05.26.07.53.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:53:51 -0700 (PDT)
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
Subject: [PATCH v10 00/16] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Tue, 26 May 2026 07:50:34 -0700
Message-ID: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Vd3H+lp9 c=1 sm=1 tr=0 ts=6a15b402 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Y_GqGrSV0k1v4m2USCEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: kRNKJIYSVTt49EMrrwBabF_PNFg5Gosb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX95D7yTNJkbPV
 ycld+uCJ3uNUKddiewXt1a9TLvYuUwVwcSiq1lqrJNRD66PAWeZc42YtqT4f8Lc4SUe3GmvXlm9
 umDCG3atBV1YniS8g0eGEkv9FOAOCSnKOPgtekcpicYZEZytLmstMvMJaUk7nZTRNaXN2d+Dq/8
 D5/LfetjiiF8dXgOUm+ePVEMPfucz+HFpWp8GQ59jigbxSNXtuit/4t2STqLay6x8GIsBumY/yT
 dgOet43qI+CEZyDxjC0ZmYeF62bvfUH3sLQOUAni1tIMKOfxZ/8ikzr40LZyEKYZO9Pu6cvr8hO
 07BW8mkJTNyHjGqMYDfzs276jgjdNr2ODFuaDP983jCs/YaabTqgj0lcwGsuBr4GUDTqExhsc3/
 chlA+22UHTat0tQiL42gR93+lZ8bvqx57/hIEN4zr5SqYYTYhmy+DL7iOfq8ZH+c//k/gJWJLYm
 GH046XL2cBOycRRwWHw==
X-Proofpoint-ORIG-GUID: kRNKJIYSVTt49EMrrwBabF_PNFg5Gosb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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

Changes in v10:
- Fix some "mesa style" 3sp indenting that snuck in [Claude]
- Fix msm_perfcntrs_stream_read() to return -EAGAIN if no data available [Claude]
- Fix duplicate counter group detection when nr_countables=0 in the earlier
  group [Claude]
- Link to v9: https://lore.kernel.org/all/20260522173349.55491-1-robin.clark@oss.qualcomm.com

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
 drivers/gpu/drm/msm/msm_perfcntr.c            |  670 ++++++
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
 39 files changed, 6047 insertions(+), 2212 deletions(-)
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

