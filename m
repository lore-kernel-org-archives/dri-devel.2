Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530E606D827
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kmqbxN2P;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=jpP2Y6Zy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FC6710EAD4;
	Fri,  6 Nov 2026 23:22:48 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB84010EABF
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 23:22:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6MoRIx1105104
 for <dri-devel@lists.freedesktop.org>; Fri, 6 Nov 2026 23:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=S055k6TyhPCYhS1fDxaEVyy6bLh6abktDuU
 jiQGLWqM=; b=kmqbxN2PDDtM9OnkPRNx2xaaUbxZAjNlVuJHuWWygwKyHJVx+CI
 poFHbBx89HZ2TPEcDfcry+4SncHRqIiUi0t3zIJll3rCb4Pdz6HPQMxOKAa5oFBZ
 JQRWe1PY/GVALfFwVC0STKdF2w0l3E5qx8WJWAPYs6L+4hMOdn/UjbcWdEmzPmjs
 JVie1mgZkfjiah2Y43DMW8JVJcnKBf6eddlM731SYC5b9X0xUZexFt4GXwv9Vpg7
 l+bJKFITzFYdpcHNKuVU2q661V6Bq+XAN28SZDQhGKxBKRQq7nJFif0Q+JeT0oEZ
 X1JBPyV2Ay+SWzRkLNfdFzu+oQw9Jdx5ROw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsk3wh7fj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 23:22:35 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cd5fd34fee0so713772a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 15:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007354; x=1794612154;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=S055k6TyhPCYhS1fDxaEVyy6bLh6abktDuUjiQGLWqM=;
 b=jpP2Y6ZyfkKwHYTvYgxLpkvvBzRU3OYzXHNkvbZGu12qGg1eOMvOxe9hcvQQU0fMOE
 N2hh+KclDDHrhubKWXwRQXrbHuJR9gIWNqxaBqyF0bge2UGJ7GvL3/aMIzsTg4yKZZkb
 18osbYFjrWXRVA8y7wqaBNc6UfN5vXqXLVBtMvrTuKB1HfZSxyZICY/aA1osEgps/l/N
 WN7VE1NWgUNZkQjlnAaRZiI3JS6iykdj9iaBzBQP2X49m6QPevZ80A5HIHBJBURnilL5
 96MPKpVtoUERWgiBTAYYPZbccN6Cvi5SBX3ZU0ufPtn5eXYHP5hWrd1HDjLdUL6ErNCk
 0vww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007354; x=1794612154;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S055k6TyhPCYhS1fDxaEVyy6bLh6abktDuUjiQGLWqM=;
 b=ilOkl3R+yJuSr8wHm+o1UAheKqmKOyTmXQ0ySToXC0ssK9H8UIBLh6Ne1ECMwEc29P
 uFwKV3kdlxxvNwse+bOYG2k5W8NMPYGZcLLqC0is6onHO/WuqBQh5r9kll2u6avF8gJ7
 aR9hR7hRF3AMr0ttMs3gQH6ORmqjWiaj/tNJxj0f6VjHfwD8uWDT300UHwTbqB/qYRX1
 YnmaQfbDTfKjbGiN+P2bQaKHhvp124qZ7niA1PdXsBvDdB1w9rmVh4wXYkBW9Ml2dHPG
 3fShTL0rlT+oJJFc3aJ87kFX66CMCCT/B1cmDm9GDrnQ/EtF5VcnSirgv7KOs2N8hrDI
 +Z+g==
X-Gm-Message-State: APuU4Z8YOWSx4ziIvL/KvQTrtt7av/f1wbNDEfUPgaAnBvE7vGffQPkc
 yaz/Lsskh3FiHct+bluwHIb4TFoDdadyZakFJTqz0gVW0g7e9epLmR9kzw3fD/GRF7b4w4fNP4Z
 AO9pC5IgtDovmvGBl0wH+SNvRuz26IOuBYZO9dQUNm6nsvQm9ShBb3OntkQSrDAdUFMW2J6iOvK
 0k88a/gQ==
X-Gm-Gg: AYBFou2H3cq02xFSmbVs2zXdPvyU6ef4sMSDBhzLsUyq4/chal/QZy4fQvf712vhN6v
 1b6i5GuxNUlY+J2pKeOPirp56L/NjFFcozDkLqXdnRgGJIeC3jgktXtCCNRSUMt8Nrq7DiBENiP
 0tJdZdeRPBqRHzJl94VWZYcq7utHWB6ceuPfQUH/eK7Qz2gmGfJbCSU/VytNc55T9cz+eKM4GvM
 WNMQcSV7EM8cmV5HPVN/R6drNWe/KUidFkEKDAvMYSHNN0Nef+r0DOOyl7+1QFrg8WfUIQb7d6k
 JTtOkX8wCTYiI/zI3B6XwQhb3v0RskX//FOFOsBFRM7bYXDm2+BFuVfIxWYM3KanBO4S90ajTkP
 5mtD2P34wt2PmQej/Bkb230T9asrjQgjU9+ge1lv3B+69ii+Ft1+LCTQq6OTLQnB3LFjFlESunM
 phdYc5B4yXxiRSUiXR/7dGWW9fKnV07FrJIo33TX2dSvlRud47bTsziuckpR/Y
X-Received: by 2002:a17:90b:2748:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3b0db6f507amr4043236a91.36.1794007354352; 
 Fri, 06 Nov 2026 15:22:34 -0800 (PST)
X-Received: by 2002:a17:90b:2748:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3b0db6f507amr4043193a91.36.1794007353794; 
 Fri, 06 Nov 2026 15:22:33 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b105831cf6sm653732a91.11.2026.11.06.15.22.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 15:22:33 -0800 (PST)
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
Subject: [PATCH v7 00/15] drm/msm/a8xx: GPU state capture support
Date: Fri,  6 Nov 2026 15:20:52 -0800
Message-ID: <20261106232220.47602-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: m7JGRCq64Dvrljut3A4UfyKUFtSZOSF4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX5WsHeadSj8fg
 JB/29+omumaruKHouXkO3xvXVsDnFh0R8fGuXJK1qiJXhIOpcOdJ8HUeEz3VAXW/ZxuXKCl+a5E
 tg2w+3N+5yTsIYA6X8xjopLrbXSNaaA4weePsvVqwj/OU18wrdVH5b5XB0H3NjjGzAqj5L4NIWA
 mzT4eeY/YuOeP8SXdfPBivzpXidMpdn80DP2abFxKnWSisvTxLH8cWNgWXknovA+8GW5E948dzb
 YzxpbiZ/6b4tY/vLR2ZnEPbadLOTW9KqwdWIn8tvbP9gDvtFOMxB2TbX2ZKxxEZekdQtN9M28Vd
 OaYHxKvua0Q9RnGKXLkvTOhGb+0sphwvs5afEHwEGSUxLY6NNQnmYeMEbFhwY7D4Jlz+S/X6RWJ
 AZIoCNTsId7eSLEBCgzz5IUYM0FVahelw3zSKNMalnRQdSKd1b8YE3TtFCp2rl+X4e5prFGhzDn
 TZQvCswdXizNESPJ1tQ==
X-Authority-Analysis: v=2.4 cv=a6OlZkSF c=1 sm=1 tr=0 ts=6aee613b cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=JpdGgOSwG_CvbEWjDSIA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MyBTYWx0ZWRfX6iRe3WW13Ryz
 6toi6Kcy3M9hMnQnkupEcFP0wA+mEOB3W4dAqfBrbr5zNNeOdOCymP3M//SjMw/T/FKZqtJHxLy
 ybIY+ulJSiPN/QqUnE6YaQOaVDvYl38=
X-Proofpoint-GUID: m7JGRCq64Dvrljut3A4UfyKUFtSZOSF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060093
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

v7:
- Fix PING_BLK_SEL size.. this bitfield got larger on gen8 to accommodate
  a larger # of debugbus blocks
- Make debugbus snapshot conditional on modparam, as with earlier gens
- Clear aperture at end of state snapshot, for good measure
- Add missing bitfield.h #include
- Link to v6: https://lore.kernel.org/all/20261105203057.66520-1-robin.clark@oss.qualcomm.com/

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
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1407 ++++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  576 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  531 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2307 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2387 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2317 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1882 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1977 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2161 +++++++++++++++
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |   20 +-
 16 files changed, 15737 insertions(+), 324 deletions(-)
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

