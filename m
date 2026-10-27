Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D297606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=e6cgj6DY;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WLtOwc1v
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AF1A10F894;
	Tue, 27 Oct 2026 23:05:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F382110F881
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:12 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtEuB3297873
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=nwXaotoqXsySYhmtZoW8iErlGXBt4yCAJIz
 c7fNEC78=; b=e6cgj6DYA10IAmENer0b2vhHva3a1v9yqSmL971iqALvaC9WOTW
 imSeV+Dpy9yHzLozwDfE2cqc/5w3Nv/5m3yWNIcyamfjdEjOhFYTFGyEngn8rSEh
 /AMd7xNUOikq9ogBjQtO67gecdj67bjcDeI4BEAtdc0pTTVFIQ9EhfzBrhd4B/dx
 pfHkSZXrSPKwEO4FvbelRw+Y//ZVa7Uka8Ag+4GkSyfP4Pjq4d5i/9QHaFm0+877
 shUs0fKqsbhn9dWGKj31u9O2s0+yMd6UNCgaHntUFgR8wQacRIdzPk1vamF2WupM
 qcCneKTUat3PFMIHTHhLwIzks91j6/Yo2dw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjy671hf8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:11 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so1166783a91.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142311; x=1793747111;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=nwXaotoqXsySYhmtZoW8iErlGXBt4yCAJIzc7fNEC78=;
 b=WLtOwc1vPHZL2iiCx3hehnw8xHET3tOEpcebBQs6HrJPP8C0Qt70wgUR87oby6uEwz
 0jB8dqdt2HJyFMDdz+RTDPHyVHuzQppW5pbeV2VT9gkhc/Lh0BSqPRwd6+kmx30eoKl7
 N5TSJa5OS4j8Si6VLm4kbXDjSbbImF3vd9EyLq0miQaLVC4euKGyBIGHQUXSny9hW5CK
 wybjSuG9ykxQOaV48ZCF+sr9URFUWpjlN39Q4wW44xlDnsBxOgWFO+Nygc/Vwf65ZkR3
 M/8NT2CKAjZcKB6hrAc4tqAu+/3fOdriE0MTDc+ZNb4afQo86CostypFLNton0WkZ4iU
 grtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142311; x=1793747111;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nwXaotoqXsySYhmtZoW8iErlGXBt4yCAJIzc7fNEC78=;
 b=DqzRqEtN2sVBrQTTxwkk4wzGJCePy6JxQ5HVRr8HVHDMqOTHUfnYPjLxiUydRfhfsU
 O2brNCRxRaaywgxboGVg1BuhyHItI7aZzz43NMFBGQLyEU9O6jTecqoLCgsup9WC8t7S
 3aqezXAEKVsTYf/hqUUPJ5cmTGoGYyzMcV8nn6dhN2aYjJdmaokE4CTGsXaXsCQ85aM7
 Aso7hJtK2B509V6l9L4ghUzOFJWq6B5c4MImiAxPAc4cGnU0p2GMLxxyr05tJKCSEcq+
 HUv6wkD/Zg7sCkUGnkn53lYLOHyZ2+oOv3Y70tXuShLg9vqqpTr+NxhYzo6ofy0avb+2
 EpWg==
X-Gm-Message-State: AFq9FYJv1fBWCasyDFhLlukaFxZ/A+dBgjyjgGpG3vNuz1AxQTs3vTEz
 9Op4l6rxN0oijp7hNHFxYecPSz4PvaWEPSussPBHD6bJ8pgf0zwi2V+0TwrS9OtIVGbkinFIb9C
 Ib6cxC/eVh5gZKs7db+HbSHWLFjX8alnkDdBOXFZuF3aStIIatoPm/G4nzkfknxr/73gbmfZ5LD
 Qd2wA=
X-Gm-Gg: AYBFou35N8v4M+2HeKZ7UTipTyDfApNd9+swrt/II5eaIkLBUFKjLjJLOfuFz771fBW
 Xmnk/hVDpSZblqRGfCeG0VMItLKR03zXNG368P9YzxCnB4DOF5sGjNwAmG0UfxIm76DSQsHKixj
 BwAWnlAD84UKqFZIi8lDX2Rljago6I8duTLLodD3qWCvTXBjRKLhjR7+7Q1aE9LafNrpoOH7THf
 OJY3d6GPIx4AGPWB26KYKpoy3V9GLNQ/arOmFlP22bEqsJqmWfA7WE7Q+CmObCpRM7uxLVEuDCY
 7OGngLBvORrYPHxnb/2oiT9SYImrhLYyjCrB7nnFlAjgH2mqGw23DZCMKAsDku8Vaz6/2e5Ms+E
 7TgA1AvCTc+8n6IgLCS2vAcKHUCPRy37RWzrZ44VqM5i82KWu
X-Received: by 2002:a17:90b:4a11:b0:3ab:be66:ddd3 with SMTP id
 98e67ed59e1d1-3ae5816379cmr248213a91.32.1793142310463; 
 Tue, 27 Oct 2026 16:05:10 -0700 (PDT)
X-Received: by 2002:a17:90b:4a11:b0:3ab:be66:ddd3 with SMTP id
 98e67ed59e1d1-3ae5816379cmr248185a91.32.1793142309880; 
 Tue, 27 Oct 2026 16:05:09 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a5839besm248297a91.11.2026.10.27.16.05.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:08 -0700 (PDT)
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
Subject: [PATCH v3 0/6] drm/msm: DMABUF_DEBUG fixes
Date: Tue, 27 Oct 2026 16:04:43 -0700
Message-ID: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KXaQTRD66hJXm_gALdfB8rJm41QV7zaP
X-Authority-Analysis: v=2.4 cv=QvfLTlyd c=1 sm=1 tr=0 ts=6ae12e27 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=puu_XB033Gd1UDA3wS8A:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX64boYS5R0wKv
 PtbvtJmj23lESLTsPH8ujHpppU5B565fkTUJZZdFJflEQOLWVYAOFsfO4hc/9LuTR6ZZubezIBM
 wbYGiEAr2F0xDwJRDeqVEOYuv5nLCwU=
X-Proofpoint-GUID: KXaQTRD66hJXm_gALdfB8rJm41QV7zaP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX/d8dwJtA/Tm7
 YI5EM3MEZax07RP9ajUp4ANtIezogMAzN7z8d9DXne0YwTv+v3aCwsaq2RmzuoShLxaJE3ddWzZ
 gYKBNDfACGQm9xWTpVenTETh2y6qJRmSj33aNGViimmauUMdWTpkwRrtW5QU9PL3wUziKcpqZrd
 wL2ZeiwZHoHZC2V3qbu1UUlUrO10Potf/WOB9yvplHsVo+9ZD9hdu3lQmekT2uvInYzapYPqD8u
 VcRQt4BoTyZlFicxqR+aeUz/aWmO7CWhNoVmrlVQrBdayCWwPFg3tNde20tE5C1XMCtukXKAo0s
 am6sh4U1m/L27ttavQGVxZVNvq/DfUHwHM8EmMLHaO4TQ5vyMrln32ykyEcUNHJzhA9P4m/Zvdp
 haAahC1VnUOU+I8YQpE0E8xuvfUHK6WxRGwreNMxZ9yqt38vOTL77PlGHvOdKTT7eqRaUdI0w3C
 fF/GFafgPAEfPRrQOVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270093
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

v3:
- Fixing missing tlb flushes in error paths harder
- Do a single dma_map/unmap_sgtable()
- More paranoid error checking on map path
- Link to v2: https://lore.kernel.org/all/20261027152821.51144-1-robin.clark@oss.qualcomm.com/

v2:
- Fix missing tlb flushes in error paths
- Link to v1: https://lore.kernel.org/all/20261006131000.81501-1-robin.clark@oss.qualcomm.com/

Rob Clark (6):
  drm/msm: Cleanup if pages_to_sg() fails
  drm/msm/gem: dma_map/unmap_sgtable()
  drm/msm: Extract out map/unmap helpers
  drm/msm: Convert iommu map/unmap to helpers
  drm/msm: Convert map helper to use dma-address
  drm/msm: Treat !mapped as an error

 drivers/gpu/drm/msm/msm_gem.c   |  93 +++++++-------
 drivers/gpu/drm/msm/msm_iommu.c | 210 +++++++++++++++++++++-----------
 2 files changed, 184 insertions(+), 119 deletions(-)

-- 
2.56.0

