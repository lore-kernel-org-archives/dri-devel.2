Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76903F5A8C8
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA7E310E066;
	Mon, 20 Apr 2026 22:27:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X8RgU5bH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kDPn/oUu";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D28410E066
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:01 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFJjIO084674
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=q2Dqpg4OdB+GYal1kt4hriA4lBdfXQhJrL4
 /ifmzV4A=; b=X8RgU5bHAHBYX8xmpRu/AVpa3AGhOPNttldsL0KaxFs2yZxz6gC
 3GmCNXCaJ/KVb6R7hCHZrZ2r0O88FkRXs4G+c3C6Vz8AQfdUohXqvlEKRVzH/FJP
 wuUzBllWTp0a30SoPfjxOrvKAub9ccUAvL/TfRLhz4xMve0w9zd5usg5AxhOlYGz
 wuS8ZOYdEMPKttfbAhuGJ0mNyNuSG9Fspx/NQJti7u5IE97dt/FK3Gpr4dH2eiE0
 JA6UN76AmtSg/ts42jLZnQS+F8taO3heyjXMz8rWYp+oxMf+IhSaK+RrMftpqBDg
 MsL1J+CarGiDFCyiVlWWWJCISOYz6PuZAjw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81jsdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:00 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa6c3a77cso1447411b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724019; x=1777328819;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q2Dqpg4OdB+GYal1kt4hriA4lBdfXQhJrL4/ifmzV4A=;
 b=kDPn/oUuDeoxxDgzmc2VkYcPGmjpJ1dpplZpANHrmwkt1kbjtvA4GyiH/o3nCI2nH7
 67zlKfEBWKyQiijBmT+0J/6N7cAdEp+zckmx1GGRkGk9F8rxgK/fiGMxJw7tgVMAe8x5
 pXcYYf5DmXAzpBlZquu0UogBlnb1vsvoBmzsTZW10FobBYi0sZqnpZWJFn/Hli+dyowS
 +FUxdKJNQCHmm+XLePbzEc/Du29lK5+1qMEoRYqPXvuv1ZdAS6sNA7VpM7HTBOKivcBp
 QPMq56J5SZ9FovJdBkRx8mAktgAAKugSow+zMFtZ94gBvECtWadNjKNROJOOPVsLyMe3
 e7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724019; x=1777328819;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q2Dqpg4OdB+GYal1kt4hriA4lBdfXQhJrL4/ifmzV4A=;
 b=fImIgGX84zmGTT8VZ7qrMBFHJP17fDUi6BYTUSJmPzIn13Txhndzck2LkRFgqpF1QG
 usYjBHiNsLVj6ChqYfWWkTeN9uTIZBAtjlpkoJP4vm6Tk6qxwMvI/RVsgUIjcxVKDOJz
 GG8WJZmTUmbzdn0snjNir6UY3c37/ZlqMmBDr23aLv8AXnzbKvgnYTDzzBWXIMoc+thR
 Qhlv9jNAMI09tuq4e74LLruqMn3gFmTTynDsw5YzD5AJjpmBlyoZzpHHKJK5BU6p80O/
 SZt+ld6T4jVCeZ93HsZqOg+tnhHthARR08MuhgEF4/WW1ESLLb5xpr529DJ3J6itdve8
 sNcQ==
X-Gm-Message-State: AOJu0Yymd1DcJlqaxxQz6obgwiA4adowj+dvsKM4l2yNjUg2cUh2XOQt
 xgkdpQD7LWEq04Mnikf5NwRGsU5ExaXx7MmJ2xO7G12rS6U5U6ObvKoeSa+Skn/qQE2Y69ipx5m
 E8usmIQQwRmvtbNId8Wm7iHZ01REvAyt7SrFOwZMmEMGCyMZfQFnI4ylosb7rNnNYsUY8ehNxns
 2kldM=
X-Gm-Gg: AeBDies3fgQAkPuuNgcKP5RqoqnfPmHv54BCwRTzN1D+bWi7AF7tD3nDBzpFld8g4o4
 Jxequwdgmh/Da6J/0qYsd/qqeC5s/J3gNuhreq05Q53A+gcAkmzc4jQ9qJJZTQjdq1YF+z5x2J8
 RQO7TNAjzMGnthSg2PPhvks4ILC+QA0m35uCtUd6MjsMlYr9jOACNl7njZ+LCot1nWQGROw0fcV
 4SeA8HCAJHCXgNcoXT8N0kjPCQKsG5ub1owgRaa0h0hOQEBuBVHjGxtXRlIw7SnVtlekV26SOEE
 BRBGrsMbXho3vGZCDefR3k8BTdpE67NfjW4x25s+Vpd+NpZfQybGz52VH1jwD3Hubi4V7Cj5GJG
 JnKm/lbHIX/RYiqwOpdWODcxkELnPEBkGQe3Ao7jSRV8=
X-Received: by 2002:a05:6a00:4186:b0:82c:212a:8023 with SMTP id
 d2e1a72fcca58-82f8c89e97fmr16027056b3a.11.1776724018965; 
 Mon, 20 Apr 2026 15:26:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:4186:b0:82c:212a:8023 with SMTP id
 d2e1a72fcca58-82f8c89e97fmr16027034b3a.11.1776724018495; 
 Mon, 20 Apr 2026 15:26:58 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8ebbf0e5sm11610522b3a.28.2026.04.20.15.26.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:26:58 -0700 (PDT)
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
Subject: [PATCH 00/13] drm/msm: Add PERFCNTR_CONFIG ioctl
Date: Mon, 20 Apr 2026 15:25:22 -0700
Message-ID: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfXwnb+nnJXFujO
 phMuPR+r0qrDg27uKoIPuNUpoU/0HsloGLv/pmCwmCgxU76MrD/VqYh6jBF3yqze3hwy4NhMSv5
 6paHcC0YFoTW+5hdBuswZU4qFzSJTnc8U4P5PqscJaQ9RJb/rQm20bvoZXoaLSBBtDsNU1DLo39
 K76YBJfPMIoEKA6JWR+oBjcJECV0wdcmbivRSWHTWK9TN3uNlll6eFv81MSAxnXfM1Mtjpt+JfR
 aO28pdH2qfm0654M1CSlVR0xLoK+XA99zMisFFJpZv4HYNUrHGudWvNGP5ZHoUCn6FkshRGQ+9z
 kUafAYZMuuv0ACowxG/q1lCVY/lPZMlGxOugP4ch6rqg0kErAN85DDjXdjcf4Zwyflg0LOYl0hk
 kxT/TMNQhNCWLk5WRwG03+mqdjGMF0icqLsUeY7nA2au6Ez1ggBkpz8Wo+NYYRRsXe5V2z6YuTV
 jAkIIcD9GvM1Q6QY72Q==
X-Proofpoint-GUID: 6lDNacuWlx1C-t3yI6h_WU-KqqeIaG92
X-Proofpoint-ORIG-GUID: 6lDNacuWlx1C-t3yI6h_WU-KqqeIaG92
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e6a834 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=e5mUnYsNAAAA:8 a=hBlBM7czq62D-dRUyHYA:9
 a=IoOABgeZipijB_acs4fv:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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

Since the counter sampling is done in the kernel, this prepares us for
not having to disable IFPC while global counter sampling is active.  But
wiring this up will come in a later patch.

The mesa side of this is at:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/40522

Rob Clark (13):
  drm/msm: Remove obsolete perf infrastructure
  drm/msm/adreno: Sync registers from mesa
  drm/msm/registers: Sync gen_header.py from mesa
  drm/msm/registers: Add perfcntr json
  drm/msm: Allow CAP_PERFMON for setting SYSPROF
  drm/msm: Add a6xx+ perfcntr tables
  drm/msm: Add sysprof accessors
  drm/msm/a6xx: Add yield & flush helper
  drm/msm: Add per-context perfcntr state
  drm/msm: Add basic perfcntr infrastructure
  drm/msm/a6xx+: Add support to configure perfcntrs
  drm/msm/a8xx: Add perfcntr flush sequence
  drm/msm: Add PERFCNTR_CONFIG ioctl

 drivers/gpu/drm/msm/Makefile                  |   19 +-
 drivers/gpu/drm/msm/adreno/a2xx_gpu.c         |    7 -
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c         |   16 -
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c         |    3 -
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |   16 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |    8 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  142 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |    2 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |    2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   32 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c     |    2 +-
 drivers/gpu/drm/msm/adreno/adreno_device.c    |    8 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |    7 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |    6 -
 drivers/gpu/drm/msm/msm_drv.c                 |    2 +-
 drivers/gpu/drm/msm/msm_drv.h                 |   13 +-
 drivers/gpu/drm/msm/msm_gpu.c                 |  119 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |  105 +-
 drivers/gpu/drm/msm/msm_perf.c                |  235 --
 drivers/gpu/drm/msm/msm_perfcntr.c            |  609 +++++
 drivers/gpu/drm/msm/msm_perfcntr.h            |  152 ++
 drivers/gpu/drm/msm/msm_submitqueue.c         |    1 +
 drivers/gpu/drm/msm/registers/adreno/a3xx.xml |    8 +-
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml |  141 +-
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
 36 files changed, 5634 insertions(+), 2205 deletions(-)
 delete mode 100644 drivers/gpu/drm/msm/msm_perf.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.h
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a6xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a7xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.json
 create mode 100644 drivers/gpu/drm/msm/registers/adreno/a8xx_perfcntrs.xml

-- 
2.53.0

