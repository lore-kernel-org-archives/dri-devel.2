Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E16E606A33A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VeCPMOgh;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=T32IKgQn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C981121F7;
	Wed, 21 Oct 2026 20:52:46 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AACC10E2B5
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:35 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69LKe5KL2748308
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=DvWm9Nv7PxkmSAxRTYuuUpcfA5dz0Ks8L+z
 cIVXOSyI=; b=VeCPMOghPhJQ8i4U7k+LoChfc40+Ghio5YzQUJ6oDUSZBFdrgp3
 hREUOvLZeYTVzniOYEUqCvzros6bPxrv3Ixca8umIEtEAC56AKDBhSJHMYtr756G
 BGw6+19rjIl4srj8Oj9pvBcah3nCuJCdxgF6X1MVewqCG8pQ0+Fx+5kIEN6wx2wt
 kg5me+iKPAi5Wmh7mkctQej8vw4/dN0+lADwaRvvsW9uVKGrRQG6xSRsSZBqQdz7
 WzHFCiBEJafa+Tm/HxLQyR+tHih2hog0kcTNAoIgNfEswRxSRW7lQt6KQcrXl/Qt
 k+cCOymJCo27Nf+BoB1jOx+T46IyLaTT0vA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf0ke144w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 20:52:34 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ab868fe362so1654221a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 13:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792615954; x=1793220754;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DvWm9Nv7PxkmSAxRTYuuUpcfA5dz0Ks8L+zcIVXOSyI=;
 b=T32IKgQn0sHfjhhC5m73BNUZ8wEqOTrnbwrhr5EJKMpAzqOUQTd6u5Oelv4C46u0sC
 D4o/reDp0mk8/ttfNdb5YmTbhWBTUyEqKgIoUppaiqXm0f1OM2y8DSorGGX2wJckeg+I
 cqZdmBcCXbCBjWVuxGjBZui0RWgjhfADkzOGl5rmJYT0R1LUJ10NXOMUAuyoG2oBQ9Hu
 YSXnjXYmVNCBZiyXNWqhFdqgxD68c+0wrGUGsz2Fjmdw+VKry+DniLfmj+jGUdB5PyE5
 U4D6mDROmbnJMnRh0N8o2X7p3BjiFUKalxzsM6DFCJJyvm7xW7uzj5s6KOShZTd2G8fa
 Iz2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615954; x=1793220754;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DvWm9Nv7PxkmSAxRTYuuUpcfA5dz0Ks8L+zcIVXOSyI=;
 b=HNOA7TXkGQlqOeDavH0QHjjAEr+BOyXwV/N6PLaoaZe2IQTz/tuO0AEZBF6aZY79MJ
 SbUSNLfmiUqBHWIkOkoFa6ziqe0Ywo5m1VCs30bKLSqIpaVBN2hPjl79f8vxOYVq48Ph
 ZTshDlZNtJZ+AppfI3JHaL2YzpwvP25bLoAq3BdrUyjc0XMjFEw/gs8DWZ8GuaR8zFDZ
 8RzFy1e7vRNJUwNpm5LQIqscWMeTfVXWHVxwYKTSE5TWv2RHkJnT/YyC2ROhMJ4mpfsj
 Fn2wOJA56d97XcFiWcyvsWLSX2ggo+0Xl0VpudRvpWHzLOy7dOY2HS2nnXK80gQ7UTS6
 cMVw==
X-Gm-Message-State: AFq9FYIjGXwv0/vZqI/swcwh61JjipuSHgoYzFMoBUMtQj2ThstKaSzj
 8NeiDG6c/J2wOoTzSzhv6NBbZX6eq+HM9xTKCExNUaQMl8t/ZYy0sbQOhP/FJ5edtPtHqHmRnQk
 evCMjaTiGR9bcYuaP5FYvUASfr59kaot3pecVHUKD57gwO/Fa8Nu2Zp2vndw8TJqBj6GlDKtxcX
 EZ/Yk=
X-Gm-Gg: AYBFou2cUQZabyM+BiAMw0mmhD/dO/z7F8VmfiXuFzPD9abpc2VbF9FihHr4eHL7WAP
 PEGR+LERijoMueFBn8/4vkFtYnnbcH0Csh7YBrN31BfW6/tLoWCw4PDrtrUJj2FoogYhoLMGSwh
 2lzLweNm3/rkVklGat7hS67xrWcxXcg25meGMoHWF2ETApmcM90VVAIuB2KXSHHn6LugpvvJQdk
 CQheNGege6vBcC9Ixp5ze15xN+XazZXHaptPPjKtpUwXIJGlqyPovM3a/tENcMUoID3otcENpKY
 p/scXbY1ZCGSz6/LYWdi9jCYN+BOnz0TAR16Aay6fRFQ4AfdCxG5fVmsyPYxOVJy8Vu/bCm1pCx
 MTmp5miXxuG89wDb+t+kGBVnpAFk8ZNGSx0p/4rU7Qq8d+7Mk
X-Received: by 2002:a17:90a:e7c8:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3ad86e97f59mr2458365a91.13.1792615953596; 
 Wed, 21 Oct 2026 13:52:33 -0700 (PDT)
X-Received: by 2002:a17:90a:e7c8:b0:3a4:b0a1:c7ed with SMTP id
 98e67ed59e1d1-3ad86e97f59mr2458334a91.13.1792615952851; 
 Wed, 21 Oct 2026 13:52:32 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada48a55d5sm981845a91.9.2026.10.21.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 13:52:32 -0700 (PDT)
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
Subject: [PATCH v2 00/14] drm/msm/a8xx: GPU state capture support
Date: Wed, 21 Oct 2026 13:41:25 -0700
Message-ID: <20261021204244.67160-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: QbS6IDxgOg8SZeHWDLdzUNh-G7YFe8G-
X-Proofpoint-ORIG-GUID: QbS6IDxgOg8SZeHWDLdzUNh-G7YFe8G-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfX1AD953sGHFcC
 IhN8YDWv2Ay/Z1GEKqvh/N/vbJpklSvU2ncR2xoMPp0CV5L6LIbHVthsmcByv5ZR4M8/TW2ua/H
 ys/jzwGfxxAsdbxFirR3t2jTrYe3qps=
X-Authority-Analysis: v=2.4 cv=KOzPn1Fo c=1 sm=1 tr=0 ts=6ad92612 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=5uKouOo8jYOmxnCoqBwA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA4MyBTYWx0ZWRfXynt+9rW/n8s4
 kISqqXmcZg+6X2Rd1wFcaV+oDbpgx5L2fSI0HwNlpjuo5U5OyTlW4PIntManalC0D6XAMmw4y9L
 OBreS6XFQBiU7aup6QEI1lYShk4mItmavKVIysS5Ah8f/Wfg075wxE3xY9FHcJQCqKbVlMtE3NQ
 /qSQgT4FRQ2AOE4Hnj2GoY9bc3xlC1CRQR3l860tZRpL97anES4NOyAHQr958bb1TpwPMLlNEJe
 5g1DH6KG2jHmH06m1vcVwLSw3PoGaQmObuT9k1wBNsqO2qSchCRonMLxNjNRvDvyrU7BMbaubFf
 7PSkZMB1X8F5Vueor7z/OrKQMHidC9S3e3nPiLwcBbw6LWb1Aivqp/suQb9N8YIoNyf32JLKc9t
 fdeSpvamh4M+djkqEwGiPokmr8c6DbpyYLy7eJ3T0gpG3emjVElqnFu2L1pPkYxV1vouW7yUoYY
 /zfFaapWHoHlNr4+ucA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210083
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

   In the process, we also switch to generated nonctx reg tables and
   cp_protect tables.

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
don't have these devices at-hand to test myself.  In particular, do
things look fine after the switch to generated nonctx regs.  To test
devcoredump, you can use the msm_recovery test in igt.. or just:

  cat /sys/kernel/debug/dri/*/gpu > /dev/null


NOTE: Uses $codename for generated file/table names, rather than continue
      to perpetuate the equally meaningless gen8_x_y naming from kgsl into 
      upstream.  At least the codenames are familiar upstream and this
      removes an extra level of name translation.

v2:
- Fix incorrect protect list for Kaanapali
- Use __free() for snapshot_sect finalization
- Fix missing early return error path in gen8_snapshot_mempool()
- Fix aperture setting in gen8_legacy_snapshot_mvc()
- Fix first_slice in gen8_snapshot_mempool()
- Remove GBIF regs in generated nonctx list
- Link to v1: https://lore.kernel.org/all/20261020204728.28844-1-robin.clark@oss.qualcomm.com/

Rob Clark (14):
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
  drm/msm/a8xx: Switch to generated nonctx regs
  drm/msm/a8xx: Switch to generated protect regs
  drm/msm/adreno: Remove temporary __maybe_unused

 drivers/gpu/drm/msm/Makefile                  |    4 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |    7 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   14 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  675 +----
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   46 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1278 +++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  582 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  527 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2308 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2403 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2332 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1893 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1987 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2171 +++++++++++++++
 15 files changed, 15572 insertions(+), 657 deletions(-)
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

