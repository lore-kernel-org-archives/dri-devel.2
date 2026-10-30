Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C612160A2630
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GjrjMV9q;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NBqfjZT0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F7C1129FA;
	Fri, 30 Oct 2026 21:19:50 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0397E10E1E2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:38 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAuIv824569
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=3P2WBnm8wuFlt2BEKGAThp63jkomyxPqM2P
 K9B1Nd/Y=; b=GjrjMV9qAaecSsP6giBR0QwdcSIOJLVzkWJshpR2xiEV07pFWX8
 BypflwGjx59R2PqoUDZ0HJkTQD+E8vY9kpANBM4aS50lhllZJbSJcfISPkCh+dqT
 G/0/F7wTK6koHeESNTp3tgiXKgBSAq2kuR3U7szte/WPqYlkcmmGCrjRcwvfzbW8
 ngejtRfwYdiQWNLtqZ8xxJSJ2GJ2IKQAyTzkXPN4b0TWfYUhDpVmgEh/ll8x32+i
 YNiNriMoL3sIzjXgo/RNeK8lEelyyyl/yzv2UpO9yFt4OgVBKZhDlsQFIXDHnAdW
 Pv4bGdSf9btyL64P1eJ7l75xNTzQIRaPe5w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x081eq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:37 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ae72da2f57so1719256a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395177; x=1793999977;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3P2WBnm8wuFlt2BEKGAThp63jkomyxPqM2PK9B1Nd/Y=;
 b=NBqfjZT0WAZnFOdVkgOzezzHYtkl2jcA+au05Fc7eaTwCIBRPDX2dNGV+luYjBPyuv
 hfi41GHH29bTe7kts4jyK3gwH2aibIpm+CsICu91r9qaKhomG33Cq57BPcfE8RBCvMay
 wq6anV4IZSipIODS0gqcLBhdG/V1S7FkaFACa3toNVUe2oQYbfIRLtJi3KcdKfnjgoUr
 E16N5coDmVPFx8u0HJtCSyG48iZkCu0u8gYgJ+sLlyrBOaYLXeO+Y9VhkfXHGgk7hEJO
 fFWyYtO7tPzlMbaCawfVDo+6Gvff/S1lvVUJBFPWxi2wpgRO9ojftTgPkgEzaezidO9+
 xrjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395177; x=1793999977;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3P2WBnm8wuFlt2BEKGAThp63jkomyxPqM2PK9B1Nd/Y=;
 b=nqsI8r3cT3PPcQcFxeYYh8rC5HsjPokHd+fNI9PalVPA809EwdJIJg6oCnw2r7XRMV
 YCpBhmY1u3vTuANan9aWIwVPzKIJvpatHJhtkFEMBrWRO8948/4a/pNHXraZFgaY1aCf
 dnmipvpRR7zdBOI7tL5N5L8rYDR1SyAzKOvBkh0j3pRiW7oKy1BSx0okN21mJeMPR8is
 RfkWdChCzmSVws3gpE9R6B9JtrdWOnlBS03bnGw5a3noaTNnPIxsBTw4CMcZoWhJ/yBU
 wTuLQYbCGHpzA/jq5qyCzDH6LRQS0+7jDrquhkI5pZa37MMYzS8dc4JlUbIG5ahYr+wu
 tB7g==
X-Gm-Message-State: AFq9FYKXyiUzx+sobK2v5/zsa1KqtszN9V0cA/sCVKpE5qjNoFi6E7au
 ABJiDJUcnHqcGO1f/WaHtUN4Pjpiu02gu8+aopnbZoe+cr6x9z4Wh5cGiwYSNuYIyi17GT+8DOo
 94ixuzUEcBVBQHMI7GS8qP68JG0rAtXZkxFYMZzwV+Pnn1ZVUHntZ67fF4/YLRIhQGT2O9Xi2xT
 SOiuw=
X-Gm-Gg: AYBFou1SKzW7EGGqL0S5ZvJCAJdewRXzCivJ3MaHFszxcFmp9rGvgGiScPWZN1+rBip
 UEnlnatuRu0wnFx/vWGdP11PwrVyNKDSogzBgo/483ZszjKXySaLhY7lkguEmno16+I71aSG4bF
 g8I12EMsEX+5OEt337X97FS7Dur6uP+orUS1AtgT95xr7/Fad0nfD1XMRbqwjTwfvE+IaBh7V1Q
 8/7BAxK1X7fyOLjFE7gIRTx9MKuLn35GZcpIMBzz56tmKOcqWy00fjO+trHxMo0T7QBjD2szHa1
 UkSXguibiBZcwlGE0iLQ7YS4frOc4Pne+ky1TJ1CmsFsTyZBaAsTQphb91bYXxkHaO2clR2eyvR
 YvTgYf2X0KMOceLN6ls2D/SSdhBTg/GDdBu2Lgl/4B3ESi5rtkzwojKDAwGDZttSQswcJ8vcPxz
 rzALVR7S8IPHW1PuGNcGrb0G0=
X-Received: by 2002:a17:90b:3807:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3ae897f3745mr2749769a91.26.1793395176519; 
 Fri, 30 Oct 2026 14:19:36 -0700 (PDT)
X-Received: by 2002:a17:90b:3807:b0:3a8:6a6b:596d with SMTP id
 98e67ed59e1d1-3ae897f3745mr2749739a91.26.1793395176039; 
 Fri, 30 Oct 2026 14:19:36 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae85d24261sm2661296a91.0.2026.10.30.14.19.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:35 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v4 00/19] drm/msm/a8xx: GPU state capture support
Date: Fri, 30 Oct 2026 14:18:02 -0700
Message-ID: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: VMFNEuiDPbu-XHdEc_qKlzMtTkYzoGg2
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae509e9 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=3qWqBt1DSER8stsMlmIA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfXzTHORAgEddio
 utf7PebyApZs1LGJDhy0RvJJTSBoK0Y/uILnuF259OhMyDhAlRqAwmuBc0xjjIcYDwplfLle9sH
 qwXi+R7ylUw51/5WNQXkBF1ck1wbkmS/QQm7Z7Nspi4gjaDGqW/sQ2Lf+jYw/agE59s6zFDFI0J
 VQEfsPrMz1c2hAgx6xC2XEnNCM0X6YZYEvQap5CPqrUoIK5NHCzxM/1z8Vf49zfQ8daf6Qb4pJP
 EvTQZBX0MJrx5ZYICgZADVzPwR2furpg5ZY1/NcwAorCvd0TSW1C/sWKYCxNF68Fte2SRabx3yJ
 apgTJ2rDxQa1iSqN1wma2mNswi8ipM1zz3T845vqmiZEN5pyrN4gIM8XFjnBOZ1U7p9BccVWvXZ
 x7DdrYNqWbQoaVgcpccNR8vcgOo4mn27gjk+UyhG7S6cOSqWWLFGKIjabdEii7CpeZMoMeCXrWi
 ENNbQOZbZ0ZQAEymqSw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX1hNJ/y/G1Mq4
 uY1WfQRUJ3rYeej25FK3MmdTu57bMDcIvECUjg5D0kq1Qi+GMBn1759N1BpzlTUhiHKqWlDMXj1
 +/wWrCUpm0xVhuvUAX6id97qvMdjcYY=
X-Proofpoint-ORIG-GUID: VMFNEuiDPbu-XHdEc_qKlzMtTkYzoGg2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series introduces gen8 devcoredump support.  Compared to previous
gens, it:

1. Switches to generated tables.  Compared to hand modifying headers from
   kgsl (which were originally generated, then adjusted a bit by hand before
   adding to kgsl tree.  And then copied to drm/msm and lightly modified
   some more in the process).

   In the process, we also switch to generated cp_protect tables.

2. Aligns to the "snapshot" format that kgsl/etc use for hw state capture.
   The non-generation specific bits (SMMU fault info, capturing relevant
   BOs, etc) still works as before.  Everything gen8 specific gets encoded
   as "snapshot" sections, ascii85 encoded in the resulting devcoredump
   file (similar to captured BOs).

3. Try to make it easier to at least compare kgsl snapshot code with
   upstream, for porting fixes/etc.  State capture is tedious and mind-
   numbing, and the last thing you want to do when debugging a GPU hang
   is going down the rabbit hole of having to first debug gpu state
   capture.

   However, I don't love kgsl_snapshot_add_section().  It does avoid
   duplicating snapshot header stuff everywhere.  But the ergonomics
   are not great.  So instead I went with "align with what I wish kgsl
   looked like..

The mesa/crashdec side of this is at:

   https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/45304

I'd appreciate tested-by's on Hawi, Maili, Milos, and Pakala, since I
don't have these devices at-hand to test myself.  To test devcoredump,
you can use the msm_recovery test in igt.. or just:

  cat /sys/kernel/debug/dri/*/gpu > /dev/null

NOTE: I'm still tracking down some descrepancies compared to kgsl.  I
      think at least we should be matching on the excluded access-
      protected regs, so hopefully collecting a devcoredump doesn't
      make things go boom.  Tested on glymur (windows fw) and on
      kaanapali MTP (android fw).

NOTE: Uses $codename for generated file/table names, rather than continue
      to perpetuate the equally meaningless gen8_x_y naming from kgsl into 
      upstream.  At least the codenames are familiar upstream and this
      removes an extra level of name translation.

v4:
- Drop RB_GC_GMEM_PROTECT from nonctx list, now that we are computing
  the value directly
- Add missing 'break' in switch
- Move RBBM_MISC_STATUS read to after we check GX is on
- Rename sysprof_setup
- Add cleanup.h support for disabling IFPC, and use it in debugfs
  snapshot path
- Collect tags
- Link to v3: https://lore.kernel.org/all/20261029201730.151754-1-robin.clark@oss.qualcomm.com/

v3:
- Drop generated nonctx list for now
- Exclude access protected registers
- Shuffle around some debugbus blocks to match kgsl
- Use CP_PROTECT_PIPE regs to pickup the extra spans if we exceed the
  64 CP_PROTECT_GLOBAL regs
- Inhibit IFPC for gpu debugfs dump
- Fix cx_dbgc capture
- Misc other small fixes
- Link to v2: https://lore.kernel.org/all/20261021204244.67160-1-robin.clark@oss.qualcomm.com/

v2:
- Fix incorrect protect list for Kaanapali
- Use __free() for snapshot_sect finalization
- Fix missing early return error path in gen8_snapshot_mempool()
- Fix aperture setting in gen8_legacy_snapshot_mvc()
- Fix first_slice in gen8_snapshot_mempool()
- Remove GBIF regs in generated nonctx list
- Link to v1: https://lore.kernel.org/all/20261020204728.28844-1-robin.clark@oss.qualcomm.com/

Rob Clark (19):
  drm/msm: Import adreno_snapshot.h
  drm/msm/a8xx: Export aperture helpers
  drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
  drm/msm/a8xx: Export slice helper
  drm/msm/a8xx: Add missing a850 ifpc reglist entries
  drm/msm/a8xx: Allow nonctx reglist to include GMU regs
  drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx list
  drm/msm/adreno: Fix PROTECT span length
  drm/msm: Rename sysprof_setup()
  drm/msm: Add cleanup help for disabling IFPC
  drm/msm/debugfs: Use cleanup.h for gpu state dump
  drm/msm: Inhibit IFPC for state snapshot
  drm/msm/adreno: add temporary __maybe_unused
  drm/msm/a8xx: Import generated headers
  drm/msm/a8xx: devcoredump state capture support
  drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup reglist
  drm/msm/a8xx: Use CP_PROTECT_PIPE regs
  drm/msm/a8xx: Switch to generated protect regs
  drm/msm/adreno: Remove temporary __maybe_unused

 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         |   17 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |   13 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   16 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  404 +--
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   65 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1401 ++++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  576 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  530 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2307 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2387 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2317 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1882 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1977 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2161 +++++++++++++++
 drivers/gpu/drm/msm/msm_debugfs.c             |   31 +-
 drivers/gpu/drm/msm/msm_gpu.h                 |    6 +-
 drivers/gpu/drm/msm/msm_perfcntr.c            |    7 +-
 drivers/gpu/drm/msm/msm_submitqueue.c         |    4 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
 21 files changed, 15754 insertions(+), 357 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c
 create mode 100644 drivers/gpu/drm/msm/adreno/adreno_gen8_snapshot.h
 create mode 100644 drivers/gpu/drm/msm/adreno/adreno_snapshot.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_glymur.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_hawi.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_kaanapali.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_maili.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_milos.h
 create mode 100644 drivers/gpu/drm/msm/adreno/catalog/adreno_pakala.h

-- 
2.56.0

