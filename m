Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5801606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ChwukNLo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RtcVI973
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35917112514;
	Thu, 29 Oct 2026 20:18:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F29112504
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:50 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJk2qV1708436
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=4/SZ45DNk5ZF2RjfLf1m3kZqYrfwnIVOQiV
 IA5lFy5A=; b=ChwukNLoLCTLlXDyzf6shcNKytw98YN8RStYniIAH6u12rAdKpf
 wHigsSlkU1UDCDo3DhHJIp2mDyjC3iNj1i4q+uIKRdUBFNlW/CvbrB1XoU/SNrCL
 Cg/M6Z7doIGklIDowi1Hgl29RkLtg9cNB/aDlZ/PInqJOJS+g8YdS1m//OczWOFW
 sAYzFWfpe7IBl5Z79iPAXmEbYAWKvS/XNP306w2TD8oPepOZZKJe6WJ1nOIeQ+EA
 mVePCdZdxe1bSlImx7ksmgWVzPpiO90MQvIdOIWpieVhHzhNhKgTNB3JOA5TCuRN
 sx8Bunax6bGlnCNQvqZGLnYec+uCy2yHMcg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hm76ck4y5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac77c3ff6aso20684a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305068; x=1793909868;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4/SZ45DNk5ZF2RjfLf1m3kZqYrfwnIVOQiVIA5lFy5A=;
 b=RtcVI973eyGiTqQcGU7ZVE2b1IyClmF4e3byh1Aekx+bVNNh2w+oXgvB5/NamZic56
 6fnTWEvJqeA2CUd48f/MHxrWj4u0c6qPvuVzC52S/J52OBK0JKhPnDwlp8TS5JEYAn81
 /d48SaQOkQcfFlQxMlnB7a3OSKkoH0Xx/p1PomPipZgnWgMFrLw2Up82NbMcIA49J7lc
 XfdL8iSyZKlucX22lyvHfs1GrEXn7N1NQ6XC51jlDehHzq+crN4lmyNYb72/lAKSwMgK
 GxesNCCw5IjYNsStWTM5wFaZF+iVjQ+Q6k+WROVkKO49AuuMk/K7BNbpVpOxnFW8Qihx
 x7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305068; x=1793909868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4/SZ45DNk5ZF2RjfLf1m3kZqYrfwnIVOQiVIA5lFy5A=;
 b=xgGTM2Vw6VFnKIOTUYYcBKk1BpiDyk8e24dyUUKQ+FITLIsnSgbnrWHiUw6FPWbWZI
 z/DWXYVSRjkpVS/2BzlUWE4xjXdArRXqXOPSRyfPq9EtqLmyKE5iIYNZzT0EDVRN0iGA
 RVAF87UZqzN9+usfVvovdZW8ikQhdBnPkbuGzWhN6JB55CQDSqrxXcvUxK9uZWZfGSxL
 A+YrImnE1FWroYiuIlxlWiUQzlj5X2s6bAccPHxWBB4trsFsRAD59z52w69rDJaYoOfp
 eWroyzmVIii0wPVvayHeu6/WYOn0OxxVG1T53ZEPGNY5r1Rn2fCEfOJXI+Jbw1Rvn9nU
 ZkQg==
X-Gm-Message-State: AFq9FYLnGIDfTEzxlTBBf3CHj//DG2+WSpFb82naI62Nr8FLPff02WYd
 R3YXlja/3XAO96Hlk6Kc6OvQYNbxVzjKcKWQTE0UolZOPwizxI/1m6TkD129p5FwzhLNfwpi9Ac
 Klct78yyuF2hJ9u3LfKmkt98hIAmISeRpLXMlFVgykSkQUwyrlnwX1W584sSe/GXaeF3ae6B1UT
 YPXQU=
X-Gm-Gg: AYBFou29NqjGyLTN3YR+hb05mgt7ZBRcjn8F/aKHf76CQoiOgPavnMWKqXE/m8Xwk+6
 VtWQ2/ILSte/MvUYd42fOdWC6fz1/BXWuLRrF7T/a3GI0geF4ubwSu5IHTSyXgX007u3Z8y8cFC
 yTa0iIe7RSC+53EWQYlpof3HFqW8RnUcCw6XgAqiv9J4E+rvhzpwHOhH96Od16b5qTIA8VOUPDc
 X6T2FjJ70y87Q6PJygupY5SIOlRIhS2wFqTRRvryXLOzOobOlpU9UfBiz5jcH+yzJoR81kIsijv
 nD++S9u9XHUI5Fsr+drQbdDQqeML1tlMCCh+eLpXvHuz/MNPAjHH89TnvbOoDQmG1ESyExutdNq
 BAHn9Yo5tSvse1NrbWhYmZQqGHrxsI7T8VDJQRUpJfZ1jmZU4+mlB5CxFBQQ5O1YD2I7rf8gGrC
 Y0MEz4mZ5BB3YgriHS6YuoXw==
X-Received: by 2002:a17:90b:1188:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3ae897eb75bmr46555a91.17.1793305068377; 
 Thu, 29 Oct 2026 13:17:48 -0700 (PDT)
X-Received: by 2002:a17:90b:1188:b0:3ad:b7d1:8631 with SMTP id
 98e67ed59e1d1-3ae897eb75bmr46536a91.17.1793305067875; 
 Thu, 29 Oct 2026 13:17:47 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8803a80asm96244a91.3.2026.10.29.13.17.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:47 -0700 (PDT)
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
Subject: [PATCH v3 00/16] drm/msm/a8xx: GPU state capture support
Date: Thu, 29 Oct 2026 13:16:10 -0700
Message-ID: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ZBFcoH93zrM8kJCaaHBcK27hmv0neSVQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX74iELWt7J1pP
 GPZEs/2a6gPROntoOMflV2NGLhmPWGQ0YRIlDQ/y+eZAwwporWxYer3yExd9we2NDPOOzNeg+22
 sQCjm+0qzF3VQu/GZ68nBkuQaj3Ol9DRmYVGFAXaIWy6XNYNduRQcj/QhiGF29kPC3cCngSTkcz
 /HskvzaOfLbHgEcdfjYgV/Ju3c/fNxkYw6IZx/S9LicR1zrW1cI1MDQ/xcfxWzhLWyLCdE9Dzkf
 r45GOGfBRZYg23P6+zd2zV+jDgjjoRPsVwA1g8+L/G4DuaCI16c9Pv81Ksc7erFNaGpK6UOvLsk
 bt5cKxlWAvOfLCM1Yc+riZlkLzSuvxe16r30kHuKxw8GIBjNhxWjdw8Jp3aQNASHW5uHa5bOQOX
 euUFyIJo8UeS0X3lit3y4k/rk5p9tW4PGuJq27kQKALUwnsrd8Hy70HWY5EUkO0og62dfFDbjXb
 Y1/TLIZYcxQz30wuFLw==
X-Proofpoint-GUID: ZBFcoH93zrM8kJCaaHBcK27hmv0neSVQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX7si2FMc9gDEN
 kk1lmljqN2fvScSpca9Q8SoHhiQODhhhQ0mfcqGFhL0WwFoyY5hlR63bWa34L1Sj0krMG9+SlsV
 7GtvkScXx2Rh+PD6uCp1RMrQ8y1U+l0=
X-Authority-Analysis: v=2.4 cv=NPtAaE6g c=1 sm=1 tr=0 ts=6ae3a9ed cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Xe6-QGUCc6mO8dw4QqkA:9
 a=iS9zxrgQBfv6-_F4QbHw:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290079
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

Rob Clark (16):
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
  drm/msm: Inhibit IFPC for state snapshot
  drm/msm/a8xx: devcoredump state capture support
  drm/msm/a8xx: Add all CP_PROTECT_PIPE to pwrup reglist
  drm/msm/a8xx: Use CP_PROTECT_PIPE regs
  drm/msm/a8xx: Switch to generated protect regs
  drm/msm/adreno: Remove temporary __maybe_unused

 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    7 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   14 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  398 +--
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   65 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1402 ++++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  576 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  529 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2307 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2387 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2317 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1882 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1977 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2161 +++++++++++++++
 drivers/gpu/drm/msm/msm_debugfs.c             |   10 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
 17 files changed, 15726 insertions(+), 316 deletions(-)
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

