Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC65606D82E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nWdki1D+;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=h/6C2pXR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8841610F24E;
	Mon,  2 Nov 2026 22:04:28 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCF3A10E415
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 22:04:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2K61FE720190
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 22:04:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=SvXcR8+6AOMRF6azzS7zhFa6baaJR1YMpk1
 sV0Vz94U=; b=nWdki1D+sgOdlxjmk+wsea4EpAq/Ax1+WrlP/Gf5VcFAo22BeEi
 U7w+VP6Q1qLX4+rKcVUKnW/b5/wpnkCydrr/L7d9seJ+cdVdrxcNZQtDNIssY5J+
 t+UDqbXCaGgihZbwZQcXeuME8/yCrZP/bAXhqEvJLYTq3houNgUzRBtKtlXuXksQ
 CnXXxYjZbpcBRDNoeM8sm8VKBp9Eod9u0Iw9p954NkR3CSVoT75ySEvJtHTaFBrr
 x/lx+5uC7Ugxi4EVbM1VAN5TI9onhfsas4M74IMMOMzucYgJw1FQLOHs18wZjf/z
 r2qU7HKYtgS7bF6ru0pH+Ls915FYPLurKhw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq0870nsn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 22:04:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2e8ba4757baso32211705ad.0
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 14:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793657055; x=1794261855;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=SvXcR8+6AOMRF6azzS7zhFa6baaJR1YMpk1sV0Vz94U=;
 b=h/6C2pXRXCrMD9gDFvz17jPSFhYZOrMJGMNW96g7hzOp+4CrVt9TZuvaIgNp7XBYiZ
 3m1l3CkuwXHrw5zvb2+YF/kSWxd/sl39zH18ORiOCHwIs5ngIpzi73R2eZNYiJWgNfBG
 GKNEyZ8tXtPfHd+EaFdGJs9ZeXASN+x2J6nXMME1oc5UuUoThvPUBRFUtXukLKYZMT3h
 2Dgz26LAyOwF7brFc857xBhrksafvPhqpApWAEKV7iTcC91gr2pJsLM/fLf9xvH3LEva
 vcBQetzirPycM3gN8vw5TR+DVXhCimWKsUdvrTDpUUyo20hLz0Lr6HuByAKWggwC6Id+
 S7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793657055; x=1794261855;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SvXcR8+6AOMRF6azzS7zhFa6baaJR1YMpk1sV0Vz94U=;
 b=biulLXlfrgLhi7InFvH+h7A7P97H1+SR6Fw3y0kZ3bXaJAvy6UbNz4Miu0beu40jvd
 ZNC3LQE5KfgIQEpYqSzq5Ji23LNYwMXp6qbRx17uWqAkcmfTrR/7yNoMl3ow0x89il1V
 bIj6182ahF8V0sN8bXVwtj6MvJzQ3KqvlmYFBnbei9KKQYJtKC6d+HEzo8yfhe1kZNGw
 irRR99PpXB255pGBwmsrBpKazYI+9bEpUrJEgxCVuaE45Z3GQ6IQ0TaGa5se3gcAIwoc
 u+veNZmc4Xwt5WSoMR+k6otoJPpqn6kmwlsFXKWfaEgqcBHp+fyuWEQkJMlJqBiOhCWW
 JSIQ==
X-Gm-Message-State: APuU4Z/OXv/fjIjill01UCmSX2IDU7hX6wMDr4zxAQLNYV0Ql3s2kigs
 Byq3o9X3aMSJ086/lfqJjUHzG0kx/U0xk0PF7+UX0E/8g94cjWp+ezUDDPmrvexAQW+/1EFEfOc
 mzMbGXt2zOMR3oMQGHEFbVO3h/oycimDxiNhNCRWz3DQxxylO6cUcihlLiFma11wvl1GlySPeq5
 fOYsgL8w==
X-Gm-Gg: AYBFou3cnGiXB9k/x6LaMEOsmCVSct+mlaqOUsuqS6BzQZ4SqOm37n+QYXpPdFdeguE
 dicPJtEoYAFh9EyMgly18F7Wu1MpNHHbFTohrjidDrh8J1z8VGViX7/rZGYzmdyvnHT4ZXH78BW
 v7nG3SYBjyg/aheyegwIYDRg6hQA/EwpoKRleCzySTgaWF5Y/hRrrNrI5rk7Vb/A+gaIuWrKB6p
 KT21TbcCtc5uJHE0AIgFcwGMScv/EquvZK28IoBJxqnSHcGrnHvw9Awx6BLXFLWsxUCjbvSseLe
 NMVoyB6oEznw5kurVdN0MHmJkmH5VqnbIqd14xB+B4uE+8O3rtCVA1PNmBUEXeWU7vl28HUoJXZ
 irNZHiSQRFWfvxId1iMQfVNAbsicAVo1By3Nwm66uRufOgXngI+yF9cmrob6U8Nsr1/Hg6E2Kd8
 k0M8SuFFZHilRI2G8rt9GsTw==
X-Received: by 2002:a17:90b:1a85:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3ae898194acmr9615681a91.36.1793657055377; 
 Mon, 02 Nov 2026 14:04:15 -0800 (PST)
X-Received: by 2002:a17:90b:1a85:b0:39e:6a80:dd9d with SMTP id
 98e67ed59e1d1-3ae898194acmr9615648a91.36.1793657054882; 
 Mon, 02 Nov 2026 14:04:14 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c9928c4sm974146a91.15.2026.11.02.14.04.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 14:04:13 -0800 (PST)
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
Subject: [PATCH v5 00/15] drm/msm/a8xx: GPU state capture support
Date: Mon,  2 Nov 2026 14:02:44 -0800
Message-ID: <20261102220405.30730-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfXwGuI1EK3VUDe
 3yjn3PeoZe6HFH5dOiC7RMDKQKXEGEERUitgYkildFRd4nWmHZP541hLwQKolF61Mf6l6AhBDHC
 sk96NbJwVqKo0hXtS/hQ5fEYLQI9LtY=
X-Authority-Analysis: v=2.4 cv=K9m3jCWI c=1 sm=1 tr=0 ts=6ae908e0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=e5mUnYsNAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ATBJMNQxfpEraPvdLzsA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA4NyBTYWx0ZWRfX/9n6OADyg/Kc
 nwZ+p2JB8T2RlJc6rDPsWr2Xi26i+cYjT6k7WJd1xpEeeVRjJqFxOF2svyRFPiluQB97oahtBWE
 +IfWfAeP+v7vEEHs+sCX44gf8H68G1hHf+d4cIgceUd6eb/9FlDIXqPP+/ZHZidKtnDVumtxutj
 j0msWqaBg2fnIMbIpccjtbLM9lHVEfgLY+mwmm+2XG3fsjbcJowJRWIgNwsREeaYBfWn4k9nUYr
 UtXz6aVJuI6JMZjM8xmZfreunzeHq7rRIak1M/gX07ll2PFhwbuQCpz8eVHON06B4XCGGcRmDqd
 ETIc9K7wlJnW5k/05yH29PzuNhGrfX5Er+5UL4pHr/7SwaMej+p8nUM935HnqKMVY3O8s2bKCLi
 z2DO3kn5bW13d3zNI2oUFBw+ZBWc4L2bq7BW6mpHYFDdmyEar2I6GpzXEZ8nlOdG2JzGb8/Siby
 5g+bR6sVAuP83C+KtRA==
X-Proofpoint-ORIG-GUID: ph9A72cn13N2Awmfh8DcFvJQ4SS4QyhA
X-Proofpoint-GUID: ph9A72cn13N2Awmfh8DcFvJQ4SS4QyhA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_06,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020087
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
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |    4 +
 16 files changed, 15716 insertions(+), 322 deletions(-)
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

