Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23946606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=mJlb9g6l;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Oh2pKaSN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4208E10F38C;
	Mon,  9 Nov 2026 14:21:32 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4414410E8B0
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 14:21:21 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9DF2Qc022633
 for <dri-devel@lists.freedesktop.org>; Mon, 9 Nov 2026 14:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=GFz+vbFNjp98yDL7aPn7CvXpdfBv6TkNC36
 /BTBNT/4=; b=mJlb9g6l06guGTQ3Yvl/qryLcSUrNANRKHw4Lhngf2KjFbmEzFK
 AgC2dR2yyEMpearddtaMNALGle97Scw1/dyf4AfwFUG53CIKMJUSWZh5gkzvjKDd
 h6UzSvqxtVreCpDhh5o/BSj8nVDlvc9Dg/R9CQtoa/Jbnu5aQzf5gCeHvg+LTdFU
 Id3UZtMIBKUgODjSBlPKkH/nPWcObihmzx0W9H85q/iA98lTMyMV2OhLAuyxmzoa
 r/ZHYXzSAWKEQH2EAkme0EYT4/oekpucJJjnaF+31Wj4Rt09D8TSXGMJ2Ih+YaAP
 bWUf9jVpxgxhYAerhfbx0O/Unn724sRK3WQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hucydgprd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 14:21:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ed283cb5b9so5116715ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 09 Nov 2026 06:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794234079; x=1794838879;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GFz+vbFNjp98yDL7aPn7CvXpdfBv6TkNC36/BTBNT/4=;
 b=Oh2pKaSNdkTzg3klipE1vefULZEErMRJJK+8UtSC5bq5oQTkBMsNVO6AU3nfpY9VGD
 exKR8mPz4Kr/wxBoSxd9ak605+cZ3uN1XjUUm63dOCoY5pAB0NtQ9xEdf+eKwZ2hjl9Q
 4niZwfKoBuXEYKKd8M7Ci17l+9cIiz0flrwtrk5urUEQTyDj5JDkw7i4LqGKqWWTjzE4
 F7YZKGggmQ3D1WmqSBsd9qMjLVHa7PoZD/VvcA92ooZ8lNMDEfw9RotT4ehZYI0Xz9SG
 xo5f/SMURrsHvjm0Vn6n3GlxNwAqGdJXQFrHYnM0Gl/aOwrXLFu0K6COfH/eo5wtm4uT
 0W0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794234079; x=1794838879;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GFz+vbFNjp98yDL7aPn7CvXpdfBv6TkNC36/BTBNT/4=;
 b=B7Bze6/FpiKbPq3hqrr0HQlFzREFEP2s0ybCzuhC9MrWatjUo7JXF5PvEmDdVFoLTq
 HuqDCUctFMDt4p+HSHluIqPU3k4mwrZvtIOYAnn3w0Idq8f6R/CC6otwK8D3kxgpf1tI
 64jk3XBsdE52JhQcEXEchLvQiVCqjmi88kL9KNBx+A1C13ijSSf4PTTJxXR3U/zItBO9
 h/TY6xCKBiALQhU4hDVc15tvCJ9FwJOn0nyjl6Xa/xIG3h/WtP3+B84k8LSU8xo15vX3
 azMuKQh2rdAEvyIo96lZ9xkc/vNbzmsSpjAaoMwxUYIMNDPbs0A1MTOrjZ+wwIHxAUyd
 xbow==
X-Gm-Message-State: APuU4Z8Yo3vYfm1G41ekyO3F9xpHBoG9sQzIRqAk+scbrgUlRm2mcwHx
 PYpk7HyiXsdlUazj8agXVzKC9vjdE7+4Y5+tm0WfiEyROuAoUSXXB3O67oe9VmBBvOv3plorBYK
 taElYWqE2nEZY1nKcLg3rLNtWEtUBOOBKsHak3wLMqeAl965dgVmSTJwelSYDcfG5WbTbGrZDMz
 Xq49zzZA==
X-Gm-Gg: AYBFou0YTbYveYo8FRVGVCT8sKvjdm7RG0CGx2+CIpsIYaAkxRhgqaVqO9zDK18Kham
 0bA4hU/pcyuXxr+9uT4lhWNx6waEnU7Y2EAOXGQR8mEtED1EwDYWkxCy+7gzizydcTBac4/ZEwr
 jLnFG0SZA6qGmCwTpnoxljGkplgkm/y8fgBLF92/p2e968OhWkNrECnf1oZ7BWcXYdM93puCiND
 d9vZIt0rWltybpW3/aKb5FsDsvSFizxj15NZF8LJq+jxlsuCIJaQikL01X9fNaNlazvct8Gt/s/
 5lyin93SKELewjG0QaRFd4AS7myJaNjkaFZXGk3JQuCfMbCuWB5/qYSZ1VDhJ5iktnxcabYl2pA
 rg3XSWRC40ZXHxMUcD0GXeGQymNTPGGwcv3Jx/c014l49T44xpngBgY77JdNEPY/hEcPcMqMFur
 AGsgUcaGRRqD3V1yITuCtjf+rjJy6YGd4Yn1cWwC1c7EPQuW0ZXKlXx6Haa5Iqdw==
X-Received: by 2002:a17:90b:4acf:b0:3ac:b3c7:de04 with SMTP id
 98e67ed59e1d1-3b12d590f5bmr3148877a91.34.1794234078873; 
 Mon, 09 Nov 2026 06:21:18 -0800 (PST)
X-Received: by 2002:a17:90b:4acf:b0:3ac:b3c7:de04 with SMTP id
 98e67ed59e1d1-3b12d590f5bmr3148830a91.34.1794234078169; 
 Mon, 09 Nov 2026 06:21:18 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b127891fa4sm7142836a91.4.2026.11.09.06.21.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 06:21:17 -0800 (PST)
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
Subject: [PATCH v8 00/15] drm/msm/a8xx: GPU state capture support
Date: Mon,  9 Nov 2026 06:19:46 -0800
Message-ID: <20261109142111.256630-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfXzg8vZedht5g3
 kI9Xaq7wVBKWhU/dFpcRyM9Gn2sar1fQG9VeW5uwXK7A2Td7Z/FSQbY1soRP9RPS/a4EyyqUaiX
 Xt1GC1TRXXUvPJQR72bQIhOcRW0JON8=
X-Proofpoint-GUID: XTSmFfJdvQWlc7wy0Y3Z-jMYvxOLiWVZ
X-Proofpoint-ORIG-GUID: XTSmFfJdvQWlc7wy0Y3Z-jMYvxOLiWVZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA1NyBTYWx0ZWRfX7xswzOhUhTtP
 xdI4j1yLdGmg1z21DvlepoIDiRfqAttD9pG5jCHjdtvuIlBCwlqVSzeIDqGbxd609xcm3zKEzDt
 i6jXIZmcBuEzK3KzmfhXFrTpi747dX7jraghYVULEkxSsCgqYYp1MlRh3IB9yeiaN1cYt45d0Oq
 IzG1BFJgblWIDX0ajP+uWReVxYlGfWFVPgATlxpvLMCGWTjdquCSZmbSLqtY8jP1C5rdpEvag9U
 gG/VaoXDvJ9fI6Wvlat30DOndTzCRlaYJpNyMi7vdAtfcqJoASVYU6kwHJqcKDpQzKLGMfp4dKA
 a06QIqWZa75YD/bNstUnXkJC1U0iv+HNrgHnJaVR87LVApCK47XOpN3LyVa9Ih81XSHVnUDBwND
 qiPszB7heGi5XCmvcBKVc6rB3CJtFeO3MoDjZNNFPDBIlBecfMivqN9gUazGRLc42MbImU07gzX
 azCdtEwh/ups/h1e90Q==
X-Authority-Analysis: v=2.4 cv=XuRvqlF9 c=1 sm=1 tr=0 ts=6af1d6df cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CMqLmQoervsXYc5HfjoA:9
 a=GvdueXVYPmCkWapjIL-Q:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090057
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

v8:
- Also fix PING_BLK_SEL size in cx_dbgc path
- Also make cx_dbgc capture conditional on modparam
- Link to v7: https://lore.kernel.org/all/20261106232220.47602-1-robin.clark@oss.qualcomm.com/

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
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1409 ++++++++++
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
 16 files changed, 15739 insertions(+), 324 deletions(-)
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

