Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B44606A320
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=RNrOcGbA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hnflBWmN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB48510F88F;
	Tue, 27 Oct 2026 23:05:39 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FE1210F88A
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtQZk2254146
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3A6r6krJwA2
 +ooPkO/GTStseFtBhZbXE17EJlS5WROk=; b=RNrOcGbAtg8CSmQX7FShR0ZUyap
 25h1mNsJzerNfhVGtd/tXv4As9oD4PzSR0D+jLVfhSwZNG+gwptIRJilRzMEsSc5
 rL74S/tsAN3pXgXEOgq7GWvHOJKq14NTRFWvj/NASuamgyvCJh7ISI/t2EdbjFGL
 3W0K/aNz9lSJznGCgWIWAUOlbyrI6TT3MMpxsaH2oYSD4pesYtKQbeVJ3xNC3VIV
 VyMOrpVj6sllCkXp2ocZtZiWpm2xvAm51Pj0Tn7c3A5i3HzqEQSywfiqFu2Rtf6z
 v3aav1C22iERqtde7AySFD2csbPfgca4fXk6hnlYUAH3r0iUlinr7xNDxHQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux9ah25-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:15 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ae19907a31so317361a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142315; x=1793747115;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3A6r6krJwA2+ooPkO/GTStseFtBhZbXE17EJlS5WROk=;
 b=hnflBWmNatduHRqUezRlssAvxL7NcC/8OUv9uWrXL0v0UTcMxLQSi9gn3cD62A+30X
 7UXv/kC+u098Bfi6E/AZ3bYF9STuhq6/DjvTPw+jnwzBoJzK0Pu3zbPLEywmmzXbeyqG
 FbVRldsGctg/+bHjKm5+cCT/GxG0Te16ltMmsynFv8tcbelxLYO6bIhcpO78/efh1+du
 ZzG8QKXKuKfSDpOOVb3qdhiZNRdkkkkQZXrsWflcIulaw8NsWBNNiz08vKOsvUit3btl
 Js1pIAsqsyXpD9th9tUf91GqY1U1TsZwovl+6TxLCVWvG0fD6bHNgmTRpeAWHZtXf4em
 zN4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142315; x=1793747115;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3A6r6krJwA2+ooPkO/GTStseFtBhZbXE17EJlS5WROk=;
 b=bO1arqoWpwEP0+W3upDXWAYTAGhSqymhYwdxc4sGRicvkLhnhCXdOlnb1WEGdeczI6
 qk8o+SEUQwbQrf/2wD3F10S2CWSqjaHs+fqdjrY/5KcLJcbk8XJcAaJH4exGyWyVH8ev
 Dcf4iCrEr5dwO5RIQCR20bGqcWW2hjFwFxcMEgKWsC4VlcE+DPflxUd8KtrVcR/GOsG/
 l/xBzVpDUARU4oFmlLNxQYI+5IFrfYPAjjRt7/fEUvi+A6sVAeR7Nw8p4D519E8LQvOY
 TuRc3vIymZBnzMs/tM0Ml6TNBrgkLlL2QRINKzfbGeOvpZF5tOW7+m9lhC4lgMcQxY7d
 c7DQ==
X-Gm-Message-State: AFq9FYK12pKNZhfzxKds9jX665cZPnsS2bhlDHGVK9IOi82fn1pyQr2v
 7LSzcJcsPCcvrsnrjRSwid53OfyafZ0sTN+++6W/kgmQTeriKWG1ybgoYf4oFsan6qYNfaZJTcK
 X0X6x1T66LphfysjZpaSUhwhsA/D6y/T5vY3N4rJrd5Ne9NBDLrc6fe2MyfhOu1ThQEJs6TDaUa
 Y7Kw0=
X-Gm-Gg: AYBFou3cqGeyZi5Os+tbsjP0EPeu17h6big63qIXFg9mF54ivvdDdcDkDM3c5Obfl9J
 trOzxfVNeMLSYOf1o7j7RxiQGIYk2WWiHBr5+2wsilioHV8B3GrXc6Eyh1NvOoT2Xa0BLmsJ9oX
 /EZxJD7vv/nDz8PCXsNmwSm+wZM1qlpXpUhJ572vud4FNBy30Q9bXc+jln2Mwch6DgITs2jNEDV
 3cNO1zEvOiNC+puaf+IfHBw3pL6tXHsM87MlQs5mXWFbJpsAYB5MJB+2mWugCG1DINstIXUYYMz
 R00RkIhLr3s3RiTZ+Hz4QxDyZ/jTOWvlw7eX/lmlz9Nn/A2OgdM8xY/BScGPejKVvcQPYHBIXR4
 imMhVAu+GaK0XWlfsvTnCHOfWXjg2a1SyO0iJh7zUwrRaujubPQ==
X-Received: by 2002:a17:90a:d00c:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ae58182be0mr247632a91.33.1793142314580; 
 Tue, 27 Oct 2026 16:05:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d00c:b0:3ac:928a:68ce with SMTP id
 98e67ed59e1d1-3ae58182be0mr247620a91.33.1793142314089; 
 Tue, 27 Oct 2026 16:05:14 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a9f287fsm215748a91.16.2026.10.27.16.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:13 -0700 (PDT)
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
Subject: [PATCH v3 3/6] drm/msm: Extract out map/unmap helpers
Date: Tue, 27 Oct 2026 16:04:46 -0700
Message-ID: <20261027230452.130031-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae12e2b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=BsEuFZ40A6pGwezTnxoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: cCFteEcOHsHbRq2QMJKlGV90uXjsWskc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX94Rir8Z2LP4Q
 v0J+XpQ0EQkXMe6l08n4BWgl0xEMVdciB3N3yfyS/ij+z/yespEBemEygC8/G9mb5PglIDBqvkS
 SLkHY4s6/FZvqZiVHvH6uYbRgYx4cd3Mto7F14pDTVO0dqFDgUXQwhfuu6gmzwTHGnAmzeYs9Df
 cYk4SFXhL/GchTTrOUwOXbhnQdQzO5b6XFSMxwxbS2elMzI8wtHwjUC4l8b/htHPZqujGMRMqDF
 P/xpNrEK3JmVPqUy7p/lQ4eRertzyAHBldbJfyyy3TElji3/9XtBMtKiCUfcY396cVJRsMfI8Cz
 +R81PTbFscKbZG9pjb4aHklAgT/8NekgKbG9QmRsU724ru/s4dKpTk3Y1QI0fi6BbOZC4o53VCw
 eBJ9EcKFGwj9jdO9makXOgfnBLcGrkwDxHfQsRpqWOzw4iCkyr05+JRzhCY7F4KswrbnJySuCRp
 3k/sm1CarUhvU9A/wLA==
X-Proofpoint-GUID: cCFteEcOHsHbRq2QMJKlGV90uXjsWskc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX608w5Xlig1ig
 q3KjEtg1IhZ1p3DBjYcnjkZHvHzCie7O/+6U4R7RDLFy/q/9DsVFG5zjGe/0llNCktBaRTdxj3z
 mOf1oWNQSJOx/DLcOrO7mwdAVbrIJts=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
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

We're going to re-use these in the next commit.  No functional changes,
just some ugly callbacks.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 159 +++++++++++++++++++++-----------
 1 file changed, 103 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index da6782fca6bd..5c13ad6d5a36 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -52,9 +52,8 @@ static struct msm_iommu_pagetable *to_pagetable(struct msm_mmu *mmu)
 }
 
 /* based on iommu_pgsize() in iommu.c: */
-static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
-			   unsigned long iova, phys_addr_t paddr,
-			   size_t size, size_t *count)
+static size_t calc_pgsize(unsigned long pgsize_bitmap, unsigned long iova,
+			  phys_addr_t paddr, size_t size, size_t *count)
 {
 	unsigned int pgsize_idx, pgsize_idx_next;
 	unsigned long pgsizes;
@@ -62,7 +61,7 @@ static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
 	unsigned long addr_merge = paddr | iova;
 
 	/* Page sizes supported by the hardware and small enough for @size */
-	pgsizes = pagetable->pgsize_bitmap & GENMASK(__fls(size), 0);
+	pgsizes = pgsize_bitmap & GENMASK(__fls(size), 0);
 
 	/* Constrain the page sizes further based on the maximum alignment */
 	if (likely(addr_merge))
@@ -78,7 +77,7 @@ static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
 		return pgsize;
 
 	/* Find the next biggest support page size, if it exists */
-	pgsizes = pagetable->pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
+	pgsizes = pgsize_bitmap & ~GENMASK(pgsize_idx, 0);
 	if (!pgsizes)
 		goto out_set_count;
 
@@ -107,24 +106,30 @@ static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
 	return pgsize;
 }
 
-static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
-		size_t size)
+struct map_ops {
+	size_t (*unmap)(void *arg, u64 iova, size_t pgsize, size_t count);
+	int (*map)(void *arg, phys_addr_t padder, u64 iova, size_t pgsize,
+		   size_t pkcount, int prot, size_t *mapped);
+	void (*flush)(void *arg);
+};
+
+static inline int
+__do_unmap(unsigned long pgsize_bitmap, u64 iova, size_t size, void *arg,
+	   const struct map_ops *ops)
 {
-	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
-	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
 	int ret = 0;
 
 	while (size) {
 		size_t pgsize, count;
 		ssize_t unmapped;
 
-		pgsize = calc_pgsize(pagetable, iova, iova, size, &count);
+		pgsize = calc_pgsize(pgsize_bitmap, iova, iova, size, &count);
 
-		unmapped = ops->unmap_pages(ops, iova, pgsize, count, NULL);
+		unmapped = ops->unmap(arg, iova, pgsize, count);
 		if (unmapped <= 0) {
 			ret = -EINVAL;
 			/*
-			 * Continue attempting to unamp the remained of the
+			 * Continue attempting to unmap the remained of the
 			 * range, so we don't end up with some dangling
 			 * mapped pages
 			 */
@@ -135,55 +140,20 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size -= unmapped;
 	}
 
-	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
+	ops->flush(arg);
 
 	return ret;
 }
 
-static int msm_iommu_pagetable_map_prr(struct msm_mmu *mmu, u64 iova, size_t len, int prot)
+static inline int
+__do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off,
+	 size_t len, int prot, void *arg, const struct map_ops *ops)
 {
-	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
-	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
-	struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
-	phys_addr_t phys = page_to_phys(iommu->prr_page);
-	u64 addr = iova;
-
-	while (len) {
-		size_t mapped = 0;
-		size_t size = PAGE_SIZE;
-		int ret;
-
-		ret = ops->map_pages(ops, addr, phys, size, 1, prot, GFP_KERNEL, &mapped);
-
-		/* map_pages could fail after mapping some of the pages,
-		 * so update the counters before error handling.
-		 */
-		addr += mapped;
-		len  -= mapped;
-
-		if (ret) {
-			msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
-			return -EINVAL;
-		}
-	}
-
-	return 0;
-}
-
-static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
-				   struct sg_table *sgt, size_t off, size_t len,
-				   int prot)
-{
-	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
-	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
 	struct scatterlist *sg;
 	u64 addr = iova;
 	unsigned int i;
 
-	if (!sgt)
-		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
-
-	for_each_sgtable_sg(sgt, sg, i) {
+	for_each_sgtable_sg (sgt, sg, i) {
 		size_t size = sg->length;
 		phys_addr_t phys = sg_phys(sg);
 
@@ -204,10 +174,9 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 			size_t pgsize, count, mapped = 0;
 			int ret;
 
-			pgsize = calc_pgsize(pagetable, addr, phys, size, &count);
+			pgsize = calc_pgsize(pgsize_bitmap, addr, phys, size, &count);
 
-			ret = ops->map_pages(ops, addr, phys, pgsize, count,
-					     prot, GFP_KERNEL, &mapped);
+			ret = ops->map(arg, phys, addr, pgsize, count, prot, &mapped);
 
 			/* map_pages could fail after mapping some of the pages,
 			 * so update the counters before error handling.
@@ -218,7 +187,7 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 			len  -= mapped;
 
 			if (ret) {
-				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
+				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, ops);
 				return -EINVAL;
 			}
 		}
@@ -227,6 +196,84 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 	return 0;
 }
 
+static size_t
+__unmap_pgtable(void *arg, u64 iova, size_t pgsize, size_t pgcount)
+{
+	struct msm_iommu_pagetable *pagetable = arg;
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	return ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
+}
+
+static int
+__map_pgtable(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
+	      size_t pgcount, int prot, size_t *mapped)
+{
+	struct msm_iommu_pagetable *pagetable = arg;
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, GFP_KERNEL, mapped);
+}
+
+static void
+__flush_pgtable(void *arg)
+{
+	struct msm_iommu_pagetable *pagetable = arg;
+	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
+}
+
+static const struct map_ops pgtable_ops = {
+	__unmap_pgtable, __map_pgtable, __flush_pgtable
+};
+
+static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova, size_t size)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+
+	return __do_unmap(pagetable->pgsize_bitmap, iova, size, pagetable, &pgtable_ops);
+}
+
+static int msm_iommu_pagetable_map_prr(struct msm_mmu *mmu, u64 iova, size_t len, int prot)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	struct msm_iommu *iommu = to_msm_iommu(pagetable->parent);
+	phys_addr_t phys = page_to_phys(iommu->prr_page);
+	u64 addr = iova;
+
+	while (len) {
+		size_t mapped = 0;
+		size_t size = PAGE_SIZE;
+		int ret;
+
+		ret = ops->map_pages(ops, addr, phys, size, 1, prot, GFP_KERNEL, &mapped);
+
+		/* map_pages could fail after mapping some of the pages,
+		 * so update the counters before error handling.
+		 */
+		addr += mapped;
+		len  -= mapped;
+
+		if (ret) {
+			msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
+				   struct sg_table *sgt, size_t off, size_t len,
+				   int prot)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+
+	if (!sgt)
+		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
+
+	return __do_map(pagetable->pgsize_bitmap, iova, sgt, off, len, prot,
+			pagetable, &pgtable_ops);
+}
+
 static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
-- 
2.56.0

