Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33FD606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=GhxpIZ8c;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MO4V5rJJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E59410F7C8;
	Tue, 20 Oct 2026 20:47:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1143610E27D
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:47 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KI7kvB3499167
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=IB/ZjUSIH8oWz+WZKTgO5NAmSxJZU52lsWr
 TkciQxko=; b=GhxpIZ8c+53Da+Ez2FcUSLrvAD6ESxQFYDLUJSZOyhCFczICK5G
 +aemkGIdNTrl65uvbrSLeoWwPky5A6wZzP7HnLx7oC6Leca9I954Oq6m/LyXrNH7
 gV0Wh9iKTCfAVboO3PBEWEdtTUte/20UV+pjXE57+kkk1r0dSokJttyCUGNV4cpJ
 1YZwWi71qtZBkX/VvLSW8QGklUKlGY4VjAf/NrK+hhE4FgrRWvv+hW9gcr6kiXX9
 jBW3ZhgzwpIMKf8xqEGMF/Pz5b97YNsfb8BMYiwZ9otjA9OQp6RajgcvU1zaeSSv
 F5eeZHLwCOILOdxXQgv95eABRfjFXVTapdg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hedabghh4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:47:46 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so87106a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792529266; x=1793134066;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IB/ZjUSIH8oWz+WZKTgO5NAmSxJZU52lsWrTkciQxko=;
 b=MO4V5rJJrcSAMXOBahndBgSYrkiiXsSmwugkpCIUmcCBVQaOcBF7m94HFAHYZma1ZA
 z9NcbSUoKJ6+f6edWdIPdQBICrBKzOgZl7Se+HivAQuJBeBKQCcufDWXKl83/UTRPyDB
 UlRoU42iZikHKdOmUN+DGidE2EJ8B/NWqAF77LC8rCpxACSFrdtT8gahg1zb1Jxlh4/6
 p4sI8i04GcDsJHl4qVe0Gq5/ZuEqMVhnpk1aH5137Vr7r4x1Uc7GM0cjClumqcb4l3RF
 2GttNHydFtxwkZpmRPLT5T/H5rHJx9uzlYZ1Cqnv5IzeTFfWj7KpdmyLVFKr5DIGppYn
 QN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792529266; x=1793134066;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IB/ZjUSIH8oWz+WZKTgO5NAmSxJZU52lsWrTkciQxko=;
 b=a3g80EHEeRT4Gytlay1AaDHKYHvw48foQgBw4jgEy1lUQ+YbQEF8K/57Qn0he9RJDd
 hLQZZ0ohyzhfkbIfOoEY7gSWVdedhh95q1hZgqdJgaIe8p3eBLUS/FpQCifG0bkniyu8
 Mb3ItYdcTinIOZzMRLKeyRQKrTRlNRCVkVvd2yTfrQ5UKQljXDKByrnLTr2FxntyGRCj
 wxl5ZaNsrOPVSmjgjLO7wasnv0bcM/DGuW4pqklAuJvcgvOvJJgeGLoHMWGfrohVWRLf
 lfUmtrZ76R0zlkxmH+e/dTBR1G+rYtdwAqqiSHo068MUpv3Xs7oeoT7mK7O5jn0tg6hq
 k3ew==
X-Gm-Message-State: AFq9FYIcwUWG5UbbSvJQDDoIpIHOGnsoGlAMYrIr6tcAulY4emAObjNd
 PmGMWJx70rFcjKHB6+Y1mRasdzlkAUj+7VmPQ6xRYLfsZ0ia2/YQQqumYK3zM6Pq/M2Qy7QA5W4
 lPW/lYCHcCU9hNm8WqqYOarMyILudSqfcLuTCdmQJ80JjUisfbHqRF6nVQMXDoKaIFqb0xBv468
 qIB7A=
X-Gm-Gg: AYBFou1DmutQTdRJ5X5Bd3JK51E9OytIdPVV3OOKOnV2UAhH+GFDzlILCRRbpWJOyXf
 kZyscektZ9BQLhXSPz1PoCInXIpmYtCTQN+yrFLv2FWjA/hIwMtM+4fWj/1C9l6FNx05cLJ8X8w
 DNQ31LaSRgU79wumdRUo/VeLl1+N0jfskx5u4YtwETg6v+WtD3DhGt7Rs2OWZekHit43u389lBT
 7TAFm/1iGEwTxWKYTtuKFcbDbxMIpmZqrNtq1rOPuCsHE3+TSNf0WWvq8mxTYUCrzXpG2D6XOF4
 zCn2yb72/8UdWOdkznOrgfQjkGmrm7nWqlDrpNn1h3HEPwMUVXi+w2KE44I2PBsA4kmDABMTSiw
 xrqGlQ+m579yioLmsFBBzxPL3gm9W42s5NqsCNsTsQU6hZXV3
X-Received: by 2002:a17:90b:5546:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3ad86f5951amr34856a91.36.1792529265673; 
 Tue, 20 Oct 2026 13:47:45 -0700 (PDT)
X-Received: by 2002:a17:90b:5546:b0:3a6:f6b0:30ce with SMTP id
 98e67ed59e1d1-3ad86f5951amr34840a91.36.1792529265169; 
 Tue, 20 Oct 2026 13:47:45 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ad83607790sm326982a91.1.2026.10.20.13.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2026 13:47:44 -0700 (PDT)
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
Subject: [PATCH 00/12] drm/msm/a8xx: GPU state capture support
Date: Tue, 20 Oct 2026 13:46:14 -0700
Message-ID: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX7fAkXdqRIj9a
 7wng5YQRT5uPlL7Nmbd2cAljWhrE5Ty4pF8uqMnd7beu0TF+VzRxJDackB3IRjF2M2TeuV00tvC
 UUa4OQWGqACaO8vo0416MRYjiPcZ9UI=
X-Proofpoint-ORIG-GUID: XWl74_bv7PkNSZCEPL6euydpYfVjRbHE
X-Proofpoint-GUID: XWl74_bv7PkNSZCEPL6euydpYfVjRbHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA4MiBTYWx0ZWRfX3OvLh0/qW3oo
 1LlhffDrGhv0SCRxe8dAVOHTel156StrH/1EZs3Sx+mgXJPNKI6hNwg9dLPtJI8q3w9bKVc2RbX
 q8leAZgLDlUidFdEIUw4uJvs9/UK2iRKuCLlWqD1vGHg3IUbDy/09eUqoGGKFiS+vUuj6EolyHn
 iFGlQHH2T33S32MM5dhQBNUJ7d9PVzSxwKwb5fEvzw9DrViVbugJDwx1k3uDbHqMdgJTTQWw504
 TbvP1+5lhq0/1q55KYZrp2w6Xy72fVZx9+e+9rzKAKY9wsIbkP2XBnYsAXJ/6WLkaJNa0itwRNa
 XvKs5RqvgwgGg2szFvPxzbIvEF7lvFYwreLz2K1ofGfId2T77hDNV4cQl0+KD4OIbWjlTaWrGgv
 /0CGhh7xkdPDsQ1nW3/8egmwASaUW2tH+qtiILOXjNqj002E6nowaulihv707PYjUEIPcoYtZeZ
 4Kv6Q/sR7W95nfg/7qQ==
X-Authority-Analysis: v=2.4 cv=NLpAaE6g c=1 sm=1 tr=0 ts=6ad7d372 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=e5mUnYsNAAAA:8
 a=aXZFJKk2W_MRhlCQtksA:9 a=rl5im9kqc5Lf4LNbBjHf:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610200082
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

Rob Clark (12):
  drm/msm: Import adreno_snapshot.h
  drm/msm/a8xx: Export aperture helpers
  drm/msm/a8xx: Add a8xx_aperture_acquire_slice()
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
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h         |   15 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c     |  668 +----
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         |   42 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu_state.c   | 1253 +++++++++
 .../gpu/drm/msm/adreno/adreno_gen8_snapshot.h |  582 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |    2 +
 drivers/gpu/drm/msm/adreno/adreno_snapshot.h  |  526 ++++
 .../drm/msm/adreno/catalog/adreno_glymur.h    | 2315 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_hawi.h  | 2410 +++++++++++++++++
 .../drm/msm/adreno/catalog/adreno_kaanapali.h | 2339 ++++++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_maili.h | 1900 +++++++++++++
 .../gpu/drm/msm/adreno/catalog/adreno_milos.h | 1994 ++++++++++++++
 .../drm/msm/adreno/catalog/adreno_pakala.h    | 2178 +++++++++++++++
 15 files changed, 15583 insertions(+), 652 deletions(-)
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

