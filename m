Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF284606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nkGHl3RS;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MsfB60Ov
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26E4E10F886;
	Tue, 27 Oct 2026 23:05:33 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 401F110F88D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:18 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKt7UV3891384
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=CR0OA6ftLKP
 m+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=; b=nkGHl3RSf1ERpITUSE4a0xBUYBZ
 EsSdtU5bHmzKkqRBnB7FvZMlwK7p5HSYGjaHgFKD9DCxdadCuWrlZYlnoNYYW1io
 qWBOwHHtoM1NiPQfUaliJEFRiozw29KxMhdSNx8U+/x8nPebYDtWcabYChPdmfQW
 xBuXsVTAq6dbnxRCVfkF4lbgc++lR1ojCS1PR/9xcEXQd5JuBH8oYSPopohZdlvu
 kUaDUeMPkHlg1B5XaZWxTQNFcAsNL94pY9NClcnaXMi0KBOzKFDKt/npJyziVz3a
 5ySYWHgr/sRHpIqJ3E8SIN632/DC3ip5xtotaDu+yow4qdYU1NBDfDfk5Ng==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqw23k8c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:17 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3adc5b185bfso378544a91.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142316; x=1793747116;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CR0OA6ftLKPm+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=;
 b=MsfB60OvOVNMlFJ5x7Zkhbk049k1gPatoaCMB2xs0Qd/tmwozRBVZkY5MisXKiM5RR
 eaZxJHVqM8O8U/lP1CquE0gBDFqkJZ/vV5KhFqq9AW6HfrTGPpFNiUAUKv0S06TS85QA
 ofJbJWp5sk7hnvZ1i26KXz5W0Qp777pcHrmleJyzc94KhdG+Z/AGcyRkEMB5qWljwu2d
 40ZFfWqq791ejeIWDPnNksw+whjYYyP7fyOJInqya8s9j+XvrkAE7Wu8rlzVpsZtvISt
 Di5CxxmrIC97f0jxXM7iPMwQGIsyUGNkHx0CPiJ+CLfRV1sjr7xsSESs3h3WDi0A4rMl
 5ZLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142316; x=1793747116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CR0OA6ftLKPm+mGkPsiROgpxTN7mmkcVrmLFwZqhkUI=;
 b=j6aO0Z+JWfhjZcuPPrlqb5EK7cNh1TZQhqmIOL0f2fThTDevvSzk7AcGmmyd/kLp1c
 JydwoNSi7fW3qzo5TaHIarH0Gw/cKTrwefvhiPYF3zkVBRodfsRbOIZXreufBQenJLWC
 GccrrGT8IxqJAn5V0HBu1+4PGdeRK1NSX88E11X6chLF6vXIfGAhF0KYygK6DoTyXKks
 P/+UBniFigiKtcuSxDWd/BkXKwR0OEzEuxlLyNlMTAp2ziFZWLAxDGY3d8kqHDCRn/8D
 aH079Ihl93zTnIeBauFVUFFBm7lY9QNNkTd+O1RG02Rp0IXbaJ+kZaUwCDNqGfBIIx2M
 T8eQ==
X-Gm-Message-State: AFq9FYJ/WW8j9kEKajulquDnhLIHWrlOg0DAXKQKw8pUyIHkjyCaC2ko
 IQNAduRwyr3490I3phrCxF8JEuxZELy8HHfjtPcIK+OK4GpxS7iq8aC6wOn1fz4U39s+I8cbwoK
 4UpnSsD2ort7mZAVpTv0xA2w2e2omFC+ZY5S2bMfUKuosK9TqHs/NXSYElexYQ/ocVmYlEgJ253
 MShOo=
X-Gm-Gg: AYBFou0lL+9TEHp5ErZ7eTbuNreev+68JLQaeYV+vR0KPij6OPpdPVxY049v6rlclvc
 O2fhrg8HraFlMCS1pFNOdQ3DsObtYWRm1OmbEyK4sdkkX/rGbsVL79RtDVfdFmhjPqbrH2mRynt
 JEc0fmbVJdOyUIV7Enwfju7D+4xxny+XQXsB3GOPDCCj/gydrs0o1VxHyZzCW5kH1lzYcC+385y
 Wedq2C7g3ju6s3A7gDYae3oB+MV6FyR20ZEs21f/JesHkCWHEwfQa21XQwTpza+erkx3AcQyvc4
 dh4hBntRtDQKU7dLq/JVmiekb60A5vcOl1vUbmfPrIMlC+fMB3Xl1KQH0IU4sQVRMPUq04ifbfs
 ALnfzCdnB69dJ/MWJMv7WWNIYzgVLdUe3ExDg7gRpsQxNwxm/
X-Received: by 2002:a17:90b:3811:b0:3ad:ce34:f63c with SMTP id
 98e67ed59e1d1-3ae582279a3mr421114a91.30.1793142316002; 
 Tue, 27 Oct 2026 16:05:16 -0700 (PDT)
X-Received: by 2002:a17:90b:3811:b0:3ad:ce34:f63c with SMTP id
 98e67ed59e1d1-3ae582279a3mr421071a91.30.1793142315409; 
 Tue, 27 Oct 2026 16:05:15 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae57a2fae4sm334864a91.4.2026.10.27.16.05.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:15 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/6] drm/msm: Convert iommu map/unmap to helpers
Date: Tue, 27 Oct 2026 16:04:47 -0700
Message-ID: <20261027230452.130031-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX3IBWlu2uAtUW
 nxtby8ciECkYNliBMpZO43B4rC0yGrPcdwXpnYY9whE/KfI+aCVuV1JrqSPSu+G3BGAaNUccmBF
 IyxgKijCq8qgZj0RTX0I4VTSURb8f0Yj70nTxhY/j5yJc4k9uZQOssnI5rFh9U6hFonFZymLcv5
 6SKYKJ4vv/2sqvWWJWusmkd+yS+F6aIpqxvek4kpTYZclG/21f7oqYM+FKoTWkMyb7Gpi9GLa6d
 1xRIKUdzCOR3u4IlA0imz+xGSXSzIGUD6Fc2iGV9Q2lLSkbenRo9nKYlA1dtWp1iKn20X5Ls0MN
 WhwQplgNDHs10R+n23YqWSnDn2vuc4C7ts3MTotIWm+/Lp/0KaMRAE+m0rDQh5cpmSsE1Ehpyc2
 YBvHbBNvTl3s/e9MUBNAqj9YM2Kovnr40pL11npIv7Xx3K9qA6wJtPEBT7OuDkoqluM+TOSYVXp
 RvYi803/j6sEZv6a3XQ==
X-Proofpoint-GUID: osY9izmP4BOfFNq9_hpGcJdhy2XgkcQK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX60ypvkxtegyT
 L/62uMELW+rUSbVXjhCaiJQbjmcOno4oGp8Wj5nLjq0la/vBZwlgdZtf9EGkdjcSgewKtBPAuFm
 RGiOglv2aCWM+VfpXgazHkcA6GoiQaI=
X-Authority-Analysis: v=2.4 cv=PsYG/AM3 c=1 sm=1 tr=0 ts=6ae12e2d cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3T_YcleVrN8O_gWOTnoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: osY9izmP4BOfFNq9_hpGcJdhy2XgkcQK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Re-use the previously introduced map/unmap helpers in the iommu path
(TTBR1 for GPU, ie. kernel managed buffers, and display/etc).

The callbacks work in terms of iommu_domain/ops instead of io_pgtable.
It would be kinda nice to just deal with io_pgtable, but the tlb ops
that arm-smmu uses for it's own io_pgtable require doing runpm, which
we wouldn't otherwise be able to do.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 43 ++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 5c13ad6d5a36..479e5450a4dc 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -731,12 +731,38 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
 	iommu_detach_device(iommu->domain, mmu->dev);
 }
 
+static size_t
+__unmap_iommu(void *arg, u64 iova, size_t pgsize, size_t pgcount)
+{
+	struct iommu_domain *domain = arg;
+	return domain->ops->unmap_pages(domain, iova, pgsize, pgcount, NULL);
+}
+
+static int
+__map_iommu(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
+	    size_t pgcount, int prot, size_t *mapped)
+{
+	struct iommu_domain *domain = arg;
+	return domain->ops->map_pages(domain, iova, paddr, pgsize, pgcount,
+				      prot, GFP_KERNEL, mapped);
+}
+
+static void
+__flush_iommu(void *arg)
+{
+	struct iommu_domain *domain = arg;
+	iommu_flush_iotlb_all(domain);
+}
+
+static const struct map_ops iommu_ops = {
+	__unmap_iommu, __map_iommu, __flush_iommu
+};
+
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 			 struct sg_table *sgt, size_t off, size_t len,
 			 int prot)
 {
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	ssize_t ret;
+	struct iommu_domain *domain = to_msm_iommu(mmu)->domain;
 
 	WARN_ON(off != 0);
 
@@ -744,23 +770,18 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
-	if (ret < 0)
-		return ret;
-
-	return (ret == len) ? 0 : -EINVAL;
+	return __do_map(domain->pgsize_bitmap, iova, sgt, off, len, prot,
+			domain, &iommu_ops);
 }
 
 static int msm_iommu_unmap(struct msm_mmu *mmu, uint64_t iova, size_t len)
 {
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
+	struct iommu_domain *domain = to_msm_iommu(mmu)->domain;
 
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	iommu_unmap(iommu->domain, iova, len);
-
-	return 0;
+	return __do_unmap(domain->pgsize_bitmap, iova, len, domain, &iommu_ops);
 }
 
 static void msm_iommu_destroy(struct msm_mmu *mmu)
-- 
2.56.0

