Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862036082BFA
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 20:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=BXosqJ35;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cF/xd9Jh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCD3210FBD8;
	Thu,  5 Nov 2026 20:40:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF1FC10FBD8
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 20:40:20 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5HeNrN2091130
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 20:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=ejJX0zIY3UTvwm+Dr1cQT9BYGv3Db+um3b5
 u1jzCIvQ=; b=BXosqJ35GFC3hAFSGBBAdFfrLr3DMAfTWfcGKOwgu8igZlAYn24
 1zFHy53sTDUoShIqYFEzCa8GGZQlo7lNDXA+eDDCUhquiBlaEUjFK8eqV+jpZkEp
 4G9nLxANAbMHduvgIsdfr2CRlk6fkDGgChA8AHVf/oZR4fkD8qXxHeeblChKjJHq
 hIET/694Y1YuqM9HdUNv0oDNEDUS07DF8qNtwzKehKTkoLtkRUWuTsJw6e3edqVh
 8w9Dm08a9HdXgZE/yJseGUpUA7kLtMA09FmYxj9XX0yymI8RfHafiAP+XYpJU4i8
 Jaazqps2rpzPaMeF9dSxnY0y+17HPbYtSrg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrq9faupq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 20:40:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ed1fbae872so23527305ad.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 12:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793911219; x=1794516019;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ejJX0zIY3UTvwm+Dr1cQT9BYGv3Db+um3b5u1jzCIvQ=;
 b=cF/xd9JhpyL7qUPUQOMdSsqpLkixioGVIWBD/ml5CQRqJltnCkKy0Mxt9lPjIuYved
 P8Hz/RvsSi0hD/l1csdc9x9K4i1kSR447MGY1v8TvwZONz9Qu2c+Vn2DCTmQcfVkP1j2
 wXLSjdn8nYOnmkt/3+LytrEL1lBDxfJoFloZMM7O384EOYqQoGTzu8I8HaS1I+TFWWON
 o+KLLiDmJEipG8djwy/0Ry0nL+5/XS/DLVhbqEhmkqS5tmP/KDHjiWJ+6gnhtLhWJ0gK
 YWpEJR20JH0BJbHN4ACznW8ioK7hgN6Gn0bQWH1AOktQxvI/KVPkULGDP2d7JAmzDPOG
 mVKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793911219; x=1794516019;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ejJX0zIY3UTvwm+Dr1cQT9BYGv3Db+um3b5u1jzCIvQ=;
 b=kQXeGJi+CHCCavF/uHI2djRMeg/h18WSZ9P13u00V7eGTcZ4Lnx8ewgZx9ifJB8Vl1
 1VZQJFlsiab6TyVNYpQDFgvKNVBrsqLanUxVZ8keEW7fyyV1+VjSWOL2UrntRvOM8voo
 FhuksGGLZUJuSSl+D85mTDciPAK3TgL7IzSSta+p4TEj/sm9JwwfDZsDptPhtIcCNll1
 xcwSrpm10WyBQFOEWNygdKR6RO9vYLmzmHhhRSwuZJ/7QxTAtnJEgxfAMzFQdo1Xz2r8
 lVyT/EmOcL8L4VWaw2PN2ab5esWW+aqttEOhKE9GaZB4WZGOqq7iCvBbvhb87B8qSQNH
 pIjQ==
X-Gm-Message-State: APuU4Z/lH4W/KgDgwF6ThvBotLt+9u2ugRu95lY0cpl0IS35xy/sD0j9
 imRSPVsJLA67oYAA4NkCVWJ/Iumlcw8obSJgrx9pqu4z3gmTd+kmVxlXISekjZtp4LZT85AwX8c
 CmvFRZk36Jxrl7kLIsDbhCaFa2TV2NjnFaKGcPXTvMl/+0jcsUsdKOW5yw1EOZkBb08AgEjjyvT
 UIqEqIjw==
X-Gm-Gg: AYBFou0Lo0cfN1TCgEdpUNPPGtIzUplGa96XzYV5EJsi9OKqrNlj827HLkEI77rcelY
 MHBPpvXEK379GedDFNdEWqk5h+4RoRoDIfiwf7RjLNvF9uohKPc3wRcf/xp1aqqWs65gV7nKb4/
 YLRZEGgo5LwOxzhThx2NcqTmDtdqRwLODwZQGQdKcpH658bMvI1gyNq/OvTYapr+kUHb5mlSB68
 U+nVurMlUNJi5dUp36e7c3V8tCGYKlQbRirXV7K0ZjzLPRT3YU+++nsXjK1EALLQ9pv5f9D1XEK
 zGYm/SXuzZB7ezMNLu+8t9YLeKv3j2ZZM/DcnMTTYGn/hTAeL6eCmVoWITLIohzd8Kp2Rx7TiHL
 KFuAnkmZKEb3coJa2xI7jNiRaZNHw1/kmjD3OKM9Vhr+a3dJUjwKJ2wXvGLGeLviSFFtCZBlvwo
 T2MFmVix14eYOnGl8bzoUj8TUAR080QF5wjb2UJpRDPFByoyObd25J64rFiyBfOw==
X-Received: by 2002:a17:90b:1e48:b0:3b0:97b8:d6b7 with SMTP id
 98e67ed59e1d1-3b0db6f8c29mr187965a91.42.1793911218451; 
 Thu, 05 Nov 2026 12:40:18 -0800 (PST)
X-Received: by 2002:a17:90b:1e48:b0:3b0:97b8:d6b7 with SMTP id
 98e67ed59e1d1-3b0db6f8c29mr187931a91.42.1793911217867; 
 Thu, 05 Nov 2026 12:40:17 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b323a1fdsm5075510a91.5.2026.11.05.12.40.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 12:40:12 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v6 00/15] drm/msm/a8xx: GPU state capture support
Date: Thu,  5 Nov 2026 12:29:26 -0800
Message-ID: <20261105203057.66520-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX7KEWsOAaFVim
 IxAlr0uqSYHXt2JLe4mpBjBKLJQd5ZeM1z2xCNn20q9trXoWOXauo+GcGWHEaR6W2zMHNFF52x/
 MJ7VZcs6Nm4v0ZDPxWNT25S/KZpl6mqn4egYrByLmhL7yDDntLQQ17fE3J67TqVCldcfEOdqiGw
 Wg2AgL6oLWCGQk3HA3hlIDlMGHLL1BDPviGhoyguNaW2jJWl4Q01v/7Thqc5c6WkGbj9lKaf+KJ
 3jWAj0cI45xTD+rfXcg3qhX9jKCJoYXvWUNvruLW2tdgclezH/3qCWvpR3wcIkIVCWe83AE4ddZ
 cv/t8grkFha3vLnvfVan2eUM16sDjddWJI05m4P7AmN54iv5p/vOG/9AFVsP2gzCQQq8eN/8dlz
 QeDio5hgXEQKdny5c+bM8tTXkqpd2dT2B7NzjhREV0X0HsYznLe+pjDkHLugLTaoubkkYJCASMF
 YeLh3+qlbZz0iOXflhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA4MiBTYWx0ZWRfX+OTyhr3nUp9L
 L0tEaPAyGxouGZkTj+u5rzzfSt1E2oB4msyV46Fd+TcZh6wUY+eF0P68GzxO1dIf3GUT4IAixUz
 pz2OFOZf+JpkPphKkoK9UIpW2elmaKY=
X-Authority-Analysis: v=2.4 cv=Vdhir1p9 c=1 sm=1 tr=0 ts=6aece9b3 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=K31SCvzAQ5oPMqjnjVEA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: mgoVX1XWGyucrwYMfhG03Ihkh5jty6IV
X-Proofpoint-GUID: mgoVX1XWGyucrwYMfhG03Ihkh5jty6IV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050082
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

v6:
- Fix gx_is_on() check
- Only capture preemption records if preemption is enabled
- Link to v5: https://lore.kernel.org/all/20261102220405.30730-1-robin.clark@oss.qualcomm.com/

v5:
- Fix inverted IS_ERR_OR_NULL() check
- Drop IFPC fixes (moved to their own series)
- Link to v4: https://lore.kernel.org/all/20261030211928.45761-1-robin.clark@oss.qualcomm.com/

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

Rob Clark (15):
  drm/msm: Import adreno_snapshot.h
  drm/msm/a8xx: Export aperture helpers
  drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
  drm/msm/a8xx: Export slice helper
  drm/msm/a8xx: Add missing a850 ifpc reglist entries
  drm/msm/a8xx: Allow nonctx reglist to include GMU regs
  drm/msm/a8xx: Stop getting GMEM_PROTECT from nonctx list
  drm/msm/adreno: Fix PROTECT span length
  drm/msm/adreno: add temporary __maybe_unused
  drm/msm/a8xx: Import generated headers
  drm/msm/a8xx: devcoredump state capture support
  drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup reglist
  drm/msm/a8xx: Use CP_PROTECT_PIPE regs
  drm/msm/a8xx: Switch to generated protect regs
  drm/msm/adreno: Remove temporary __maybe_unused

 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    7 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   14 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  404 +--
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   65 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1403 ++++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  576 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  530 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2307 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2387 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2317 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1882 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1977 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2161 +++++++++++++++
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
 16 files changed, 15718 insertions(+), 322 deletions(-)
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

