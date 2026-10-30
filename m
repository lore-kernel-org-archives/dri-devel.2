Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C2760A2611
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YI3GF1n0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=A6O+SXxi
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B7A112A14;
	Fri, 30 Oct 2026 21:33:09 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C723E10E5BA
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:32:58 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULDOph4091874
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:32:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=paS89U6ae6+JjAm7XDJVwYgoty+ZJJfzu7s
 x98FlssY=; b=YI3GF1n079bAY2C8ujlc8Po/Y3jsVu6gXtBMHCDwaYJgbTCKOwq
 vP31L01GlI+GjcvFCTWgzxfn324og+cD+s20RI4K0S1HAN8SX4e9EIj7VjkFoEff
 rAZrCZcRWxRa9OH2MobRaGCKphCp/JgPChiZmMLTUW4Upc8rXzzbueTw9nUnI9/3
 BDDR9ohj/DKvo32alfb4KPvpqL2FQhf4SA4UFawF/Wmg5VXg5ZLUyeOoPMs9HwjB
 VX+rhcNs6LK0fwuKpdCDb8DWTvRq8m93yMPcJap7wkdfRZMO++GFH0wnBigZ0gsh
 BtltwK4OZmZ/SM2sa6iPcx5me/tOtlfNTDA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x10493-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:32:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ada8bc8575so2573180a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395977; x=1794000777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=paS89U6ae6+JjAm7XDJVwYgoty+ZJJfzu7sx98FlssY=;
 b=A6O+SXxiEN+15+7mr0g4zD+EMNeq6B7YyDHhEzO94ZRabyTsgpC7lwRvasx1kxEJWm
 O8ZysxRO1jspi6Hf5RfWulYJcS2Sn+QwlGGo3u2K+wjLInJ2x91zHK62fsx6LpNgP7DD
 0ElrIDfCzxQBr+6z+kK+A6cwcSngMb44FD/rFehUNc7/CYmt9XvlF0Xey2rlYFR9axPk
 HwxZ7Z+pG8eZI+QMcibqFYRllfNNs3hRYmJ95mD6RKcygmrtvN38KqpZD3iQwcp75xU3
 iq2Pow+lj8jLbt5PhQYcEE6HjSpWTqolKrGcEpAwDvxN+Fy6bONUmovDtZu8b+huFPtL
 WdRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395977; x=1794000777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=paS89U6ae6+JjAm7XDJVwYgoty+ZJJfzu7sx98FlssY=;
 b=qA7KnF7NvbwAqj2/vmHDfVy3umdvIAhBIxByn/KpkRoRI1QOqiRWaNVxpqcIPqbXKE
 5sZ5XrT+pgeBEr1P6C8eXLPEH8g0IgUOcHAxHy+NlKF7+3qGDw8hUI72DGWboJ+9egeI
 dc/gfwOxzwMArpxeuvNEmpZx0K6whrmcUj2tad8Ns53BbZpkfFEeCwjrs/K2ieRb+WK1
 TjuS5FJK7AXYercyRiYgiHbIDgi1UE5LoMvFbraCveJOjtvDMMYLAEj2lwKLdIakevvZ
 HFuS+z93sRVrkhJV2lXbbl7+NOG80RWiIkSAWDuvAp6/FhUydLC5qA3ZdnbvxuCrXbRC
 PJIQ==
X-Gm-Message-State: AFq9FYJQaELOsQvqJnyerX0y9HdgS2uPTJ4pddM4obdkb39b9RXs+vTo
 r/GDdgdJbPlWxHogTPA0qXZJn/5AfiBvAxMlWG7H3whjNAHysxA9t421EIoUmpdOXlDDjRpO7fa
 9CRx7wfAIo/N0Toe6xbAUQJdaYOyj1Wk2M/jhX4qzTmYwsQOYf/mNcdoorBeUIZ3pasK/AyeuTO
 darsYXXA==
X-Gm-Gg: AYBFou1I9u10MmDfGJvQgmtlBmm0ct8Wx8Ep5E4qmly3nzYYM/17SARC1zJ/gko2GXV
 3v44K3PKZxuXslsgAPjXjmVNJ6eOJCUiuHKh1AnmVKMhsUwJ9b0UKIyfDTFl6SRNVcn9vh2W/pD
 fculwts79LH8Xbwl09DQsBObNwH8zUbn/JpttPWW7qFDzYOqD7NSSl7WbRXuz45Duu7GHMIH/WD
 U+zmJLgXcNdyDeIiC4yjHH32gkxMKZYaFsFbojRYGa0zNG4FfpDplRtiQwPhsukvdgU+3hAv5MJ
 thX13P8xgM6dKkRZ/mhrtQlVEAr+WX1SigKbXS/AjVHpjgEk+2xQz6qv9Km9yWP2YyoMroaZ8ww
 ViZR6dYIRkhTMfUUpn4/RUGalAEFZL/SQkabzC3LeYHCfAEQZUcw8fJ1a4QNfdMh2o0jdMaT0rM
 erWXdVfZ1D5az7Pxngnt4luw==
X-Received: by 2002:a17:90b:28c5:b0:3ad:ce24:acfa with SMTP id
 98e67ed59e1d1-3ae897c652dmr2778873a91.20.1793395976785; 
 Fri, 30 Oct 2026 14:32:56 -0700 (PDT)
X-Received: by 2002:a17:90b:28c5:b0:3ad:ce24:acfa with SMTP id
 98e67ed59e1d1-3ae897c652dmr2778859a91.20.1793395976351; 
 Fri, 30 Oct 2026 14:32:56 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8454327esm5313128a91.4.2026.10.30.14.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:32:55 -0700 (PDT)
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
Subject: [PATCH v4 0/6] drm/msm: DMABUF_DEBUG fixes
Date: Fri, 30 Oct 2026 14:32:42 -0700
Message-ID: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: l18Kl52eltp4bo0IvzcH--OxsuPkk77W
X-Proofpoint-ORIG-GUID: l18Kl52eltp4bo0IvzcH--OxsuPkk77W
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX8ddjmjh6+kn4
 brepkGH1nNwkgUmEgezyN2StM9dxcQu/kS+Wpq0meyZkjGrGnucHvmNyjhJBOjIzuZXi86Z3RlD
 7GeE2zvB4pTskIA9fl52vjJ5anfztek=
X-Authority-Analysis: v=2.4 cv=abD0Dhot c=1 sm=1 tr=0 ts=6ae50d09 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=oIYrXKFyhTD9TMpG1_EA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX2MOXBwuYel9t
 BetnrutPDdKZ3g0XdqVU3vzTmp4LmH8IWM6h/p8J4R5VYZwgKtZ73y1WIP2B4fTCgCU57Whg8c6
 zH0tCvA8rLHB79iv/6ltAvWrNFxInZ6v2ZNtre05oynX1mMPVjpsuC1Z2h9azm5+fyMG2xSmDvh
 9N2FqFURERtytTvKf+Yo00DyRTI/NN2ZbuRV+/vROY5FW5ZsYZRVgnlZq9dLQePuy5i3K/ozoOD
 1bTNxmYJOsA6GSazyrJLQtyi4ACgPhA2SUrYbAKMLDnDGSEB/Lm1mH1o8sfu95/fN1qN1Q9h4uy
 jqJSHvNnpYoXEH6KIFhgAFuABP4WzdIulICL1LS8r50dhKgvwwidYqlbiDsIQptMl5+mtkjJPJp
 WXv5P7CnBRvHzsILV45dWuE5TwnuTsmOcZFypI2WMME5MWxz4GzpJvYSsSXSS22ThtYlxL79aB2
 zwg1nKliOkZtqsFNeTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610300085
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

Note, for older pre-arm-smmu devices, this iommu series is a dependency:
https://lore.kernel.org/all/20261029212344.346069-1-robin.clark@oss.qualcomm.com/

v4:
- Fix get_pages() error path
- Link to v3: https://lore.kernel.org/all/20261027230452.130031-1-robin.clark@oss.qualcomm.com/

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

 drivers/gpu/drm/msm/msm_gem.c   |  96 +++++++--------
 drivers/gpu/drm/msm/msm_iommu.c | 210 +++++++++++++++++++++-----------
 2 files changed, 187 insertions(+), 119 deletions(-)

-- 
2.56.0

