Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC23606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lBy+oZfl;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BB2Oshde
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F96E10F65D;
	Tue, 27 Oct 2026 15:28:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C149010F65D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:28 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFLHk33086670
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=j11pQ2O0YT41mdxr21xy8gY+VUqxGKTMnbt
 rD9kSBmE=; b=lBy+oZflsvqtslCvzxtqG0c4xqH7dnJJhmMPkws2GM54rtmXjgc
 rTmyT0qxzT1t5EYzEkX6wjtNSg/Mhm4C/6WkBi55R4hnUhbqGE7+F3XGvfKXtaRo
 02phNg0ttJLlDC3fMAgYq7TXj6eMBnpBOfY6Au+gJBv94F2gbP0Yjn02q8rG9Kkb
 D0x0aLsL14PzGcI0mrhVOyxNhqEWOQ0Eo0bnA+kt5W7LRX/mFND5t3JbHCz/OaZy
 eOPGkQpU71kCwarIs4Mfpt5+Uh130y6mOl6iLn67RloI6bap3dq5uRTe5KfEzR53
 TkLwLc06N0IrPcw1ZY8y/lHFlFy/0i1meHg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjjbtb17g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:27 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a59717b0c0so5385b3a.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114906; x=1793719706;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=j11pQ2O0YT41mdxr21xy8gY+VUqxGKTMnbtrD9kSBmE=;
 b=BB2Oshde24B0yyg+9bW5EAFJI5jbMszmCFX2X4AkokTNVXp60qGdH92EovtiYJFxPA
 ou+KFDS3vhXdpXYGA5rLo9fE3Xf7o59n6i6cCYPpiXr5WmdrAV2YMcFK1+4IlNj5LAez
 s3KIMVd8D1XSD7TsVJA7hprre7KHMuCDFbKjZhTeQgRTrAeAo0S/niY4LkHl48yXpdYC
 yCYOCR60OyHNWhVklvEsN9HzjQc9DxHptWLB0mu8eWF4eYY01DAm4tI5Qn4EbUka6UD6
 08HojqBlevF11SRg/xcLerv61qMkQgYjoO1HMc6cQGHjmHRletR8f2k+KGcFDLz/vt+7
 yrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114906; x=1793719706;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=j11pQ2O0YT41mdxr21xy8gY+VUqxGKTMnbtrD9kSBmE=;
 b=OefXFJT4zd9JWbAalOiuJ4Ekq97W7M/SLY1vD5dT25o6gdqFzJPLY8ptFyRj3wMsn+
 f91popy5DBFHT6vDUjzKkuMM22khfDgEylFTpUrf1FDWSFj/yeCk/lzHOLxzQTYiojfL
 cz1r8LuDXACwRiAACMEBgPVz294Wvgap63LiDIu0xuID9ReMF2vDUforRwBRBpo+jOk0
 r8+Fw+D3Ox7/RJxGkNIUVxm3eXEpvqcpt3st7otIpDUGj+nvK0t5AGjwhiXXF5ehoMrQ
 F9p8mXUVSFhBmLYmo/3QsN7wtERCXNApyIV6cQBAnPt12K3bTcRxa0Kx06FE0WRlXaTR
 aHhA==
X-Gm-Message-State: AFq9FYKLe4NMD6Cu6j4f+ZSgwax8GbWjBJGWz/udaNGoQAbUFp1PUAeN
 sOkigowcatIGP+E+cItCHP425pvBQlAL6IuUKuuJrzG7gAVdcCrSoCpv0eWEI8Eu3jDSKICIFxi
 XgKj7WtMQ/eIEeRD/S4GZCZ3WYhpzzJrSUH9OwOj5+VyipBfJ5hj8Op0jkBlG01Yd9DJ8ANFSwM
 9greY=
X-Gm-Gg: AYBFou1SZp0wkHGdiAUQ2KbaqRaJJpzwoN+YfgAVe8L2S7wFXAvPJHyQJMfcD94abrg
 umaAS5DBWLabW0W+eENNPR/DhjyF0AcMshbPwK7HQNGgDEPwsUacyBDx5ZNmaMumzU2HsBYTJ5r
 zU3RH1xDSm7X9kSZWNRlKUjQo/eQ2N8ULrgnfluyQ+lS5cC7+epwetDepRH63xEwj9qN3k1Ab5y
 xoLOnNdDyKkXrWIJopRSNtyN/76vdm31RnLhn6ECKD5wfmPDqG7DE7qplZH8yM9ZjUGHDmXU412
 Xe6WQoImcYnEXaDh1uNXCE8denptpjD0scdS+cyHIHL0tr+AfRTXSUjlI4MlAYMNlk91KghLh18
 NdW3AXoETOjXSdngJtqJMuKblJPsSZhgI++JoRZn41Y9qZlxgEQ==
X-Received: by 2002:a05:6a20:9c17:b0:3e2:26fc:2e1c with SMTP id
 adf61e73a8af0-3e7bfa9cea9mr7731255637.39.1793114906393; 
 Tue, 27 Oct 2026 08:28:26 -0700 (PDT)
X-Received: by 2002:a05:6a20:9c17:b0:3e2:26fc:2e1c with SMTP id
 adf61e73a8af0-3e7bfa9cea9mr7731232637.39.1793114905906; 
 Tue, 27 Oct 2026 08:28:25 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdad33b99b2sm985434a12.26.2026.10.27.08.28.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 linux-kernel@vger.kernel.org (open list),
 Marijn Suijten <marijn.suijten@somainline.org>,
 Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH v2 0/5] drm/msm: DMABUF_DEBUG fixes
Date: Tue, 27 Oct 2026 08:28:14 -0700
Message-ID: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX4f3/dKqHKhZZ
 dLs/JtVOv1bN8DDbHO3SRC0gYXZzklKSBbBeT3eZPUhJl30rOPMb1VeTby0Z4ufhqm2uFRi8ppC
 wXZAH8c2ei16UN+NPiIpho61Xl0vwr4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX79Z7oPe/rGQN
 ky3GIsAftuhVMkpY5GT9r3rdKoZPpOxMfRWePsrcPPLNwqukImIB62Oq3XiJgY5CrSRH6/tPiTB
 9FJbGqe2vnnLkMA4lKtsglmQbl4mKxoe+BzZd3qo0fjXF5yeabF6YmuVHydRRlBjFG6BLaiFCrC
 u9qy7aoGLjaYGVrNroNN5pVsCnGIV5t5om++gTQGY1CvvgJhC5fS8YofX/58aXXLnuplGP79rEF
 Js/6EFrMC9biKwnxjE8g5DLsiKtNpLUW8bGdQrILiZAkhUK7w0LZ/EHn5RMNIg5spqlZfxwcriD
 2nXGPblCpZENt19jS7karaP4zMzPG6NEABt0elV5elxWRvMAKBGsVTcA5WOTtz1hX6iQFMwQWXP
 o0l0IRV2J9YtGzqiShs1K0XKGTJCKjACwiQpgPUt7qQsEAnsmNztA2LYOskrbXScV2LIxsR91Rg
 f5L78/cgKpH9yuhyDUQ==
X-Proofpoint-ORIG-GUID: wmU7pXtVeQMYxCim8I8kzVR9Zj4Bl0fJ
X-Proofpoint-GUID: wmU7pXtVeQMYxCim8I8kzVR9Zj4Bl0fJ
X-Authority-Analysis: v=2.4 cv=XaIcX455 c=1 sm=1 tr=0 ts=6ae0c31b cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=puu_XB033Gd1UDA3wS8A:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 suspectscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270061
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

With DMABUF_DEBUG=y, the page information is stripped from the sgt that
we get for an externally allocated buffer that is dma-buf imported (as
opposed to an exported GEM buffer that is re-imported).  This is a bit
unfortunate, since we need that information for mapping the buffer in
both paths:

1. Userspace GPU pgtables (TTBR0), where we use io_pgtable directly.
   Fortunately this we can fix ourselves easily.

2. Iommu managed pgtables (scanout, kernel GPU buffers (TTBR1)).  In
   normal usage that iommu subsystem envisions the dma-mapping and
   iommu-mapping are combined.  We can't really work around this but
   we can stop trying to pretend to be a normal iommu user and just
   go directly to the iommu_domain_ops.

This all depends on being dma_map_direct() for the dma_map_sgtable()
to work.  This should be the case on modern things that use arm-smmu.
It's less clear when it comes to older pre-arm-smmu hw.  It's possible
that this series causes those things to catch fire.  If so, look to
commit 0e764a01015d ("iommu/arm-smmu: Allow client devices to select
direct mapping") for inspiration.

v2:
- Fix missing tlb flushes in error paths
- Link to v1: https://lore.kernel.org/all/20261006131000.81501-1-robin.clark@oss.qualcomm.com/

Rob Clark (5):
  drm/msm: Cleanup if pages_to_sg() fails
  drm/msm/gem: dma_map/unmap_sgtable()
  drm/msm: Extract out map/unmap helpers
  drm/msm: Convert iommu map/unmap to helpers
  drm/msm: Convert map helper to use dma-address

 drivers/gpu/drm/msm/msm_gem.c   |  57 +++++++---
 drivers/gpu/drm/msm/msm_iommu.c | 190 +++++++++++++++++++++-----------
 2 files changed, 165 insertions(+), 82 deletions(-)

-- 
2.56.0

