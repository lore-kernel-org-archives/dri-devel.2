Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49AA606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DJiTvZZs;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AzOklSCD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B6E510E2CC;
	Fri, 30 Oct 2026 21:33:42 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5FF61129F4
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:02 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULJqDP267039
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=3A6r6krJwA2
 +ooPkO/GTStseFtBhZbXE17EJlS5WROk=; b=DJiTvZZskbK/YCXyDDUksCMzFiU
 6SjB24Aq7E7atEApP4BgYf8ao0FbM3mPKZYesRRJlimHAlg0QuV7PjwjlUkqo/pQ
 gfsH7z6H8vkt93EnDkazLsPyruAtjSo/3b/VqZfg20vi7flRwdk7nSTfFImjDtzL
 DD8+BAElssF9xoOb8PL4iWXod1Sy7q5W0m5z+lTZIM2M16WpsDlVfY7eUQUfZeRt
 exIv2r/CkXZOVE0sNDiAHnmUsDxHWbsZf3KunQnUybarTcfOssq/ROvZU373BKmh
 bNsYHr9rJ4jB91ecBYpIRFPTo4c7/a3wl69ggN/bj+lPlhRi1hZ91vo3uzA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g52e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:01 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2eb362d1f5eso12191725ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395981; x=1794000781;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3A6r6krJwA2+ooPkO/GTStseFtBhZbXE17EJlS5WROk=;
 b=AzOklSCDuvfKj+fzbM6g68K7rvlsMT5lHnjo5RCCGXGA5febxF91KabB9gxYEyC1bL
 g/HpEYiRtoMTA4tH2U7SPewawgcQ3dv5nJQJb8kOgI481Dm2ghTvW16LI6Nayhd0SHd6
 HSOLd+79Akfv3FJJ6XJNhaqcgouEfsbp2GdP0QtBjdCMimXDpqlZJoabozln1LdIbNQE
 i8c2y9PehmL99A3KpM5eOIpKKQdsbep31/IupbvoTm5v5okasFdGq/xI5bqM7f9MPlPO
 +HYczzijtKA84pyZtTBwfRpyShIWc2mHgrFdfqyiqhFamIr62jqXTOvufh1HZySCNuEI
 oECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395981; x=1794000781;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=3A6r6krJwA2+ooPkO/GTStseFtBhZbXE17EJlS5WROk=;
 b=dz/NYkFUPhajW34GWnZvoTCY3C8Np2Whz0wI7b27MweV4zhgiYPYU027nX5mEQCbDO
 ZJuxnnhCXzTlRlTeJbQJSmFKzs7YB6WDy5lvE8aeq6Ybbep/8J20n8KySiS3YsM90bAy
 aPiP/3bCzIU0M+P20Dgu3WPWUZcU7HcQ5s7fRNzZ5fmYrliEsQ0ydEwnqyK5r5COHQPd
 63pRBfn5a8zh93Al4uGOq9QVHCKIQAbyTSm5nA0MG+WO8jvaKMLU7LIVldpSKJSLqMfE
 mMo3wqUr5u9jAWIiAJd+BthqaQYEeza130k6ySDJ4eHmJ0Qiv3wXzbTDmmqTVhdfg11s
 4XGA==
X-Gm-Message-State: AFq9FYK2TIJyoXs06ck6MeZCp1uasaf5Qc8kSA44mtYocZedmK8WIn0/
 +6pLrPhZJs9AKyaLeX6ZH/54elp/9r8h0d8YKVxnIH0BJJsaWNWSb8i78CEobgcNGhdTqPqxzsP
 X9ps7UJ4/ySSFeo0OY5XHwR5jMm7oMDehqxpbRzWui3K7MZgong/nKd3uUvC/37UfQ6LMx1KSu3
 5Tk1uj/Q==
X-Gm-Gg: AYBFou3enTHBBBfbkjP0Y8r+b4iMM5a1l7AFZTX0Z7nZGlGJ/IslM3G2Oj6wE9tJ552
 u/o2yc8ire8Hg8+eRRHvgyPDGEquDS7QQeP2QpyhfSgpViMkE8aYru6wakTlD6YOPHKQ2+LoVJ9
 9ygm6uqMexM4uWai2RthocIqXxrRHijWcw7xnt9EcNia/KVBpeBhWIHa/CxL8dACCZb45431GEe
 q/O0+eJbiDVHldKH0k+NrIgQz8TU9JpzON14QxAqt9u7aDV5wPqZBExgxh0FBTaKOzQoRIfMHpp
 y0NDNld/3EssOu+3GIAGlHQTN9Ivq79KVMnV8CbVOvVRXxtfkJkPfAargG5OxP7rYWbvXbWdG8V
 y0T0StrZ4rbion06BdR00AYVGHbTfXS2MJ80dbBFEajnpNCcqLuyDQ9UAE57tmx0G3NEO9G8f2Z
 du8NG6pUVSvIylGT8mIe9uQA==
X-Received: by 2002:a17:90b:5645:b0:3ad:6738:db14 with SMTP id
 98e67ed59e1d1-3ae897aa76bmr3031020a91.55.1793395980689; 
 Fri, 30 Oct 2026 14:33:00 -0700 (PDT)
X-Received: by 2002:a17:90b:5645:b0:3ad:6738:db14 with SMTP id
 98e67ed59e1d1-3ae897aa76bmr3030995a91.55.1793395980208; 
 Fri, 30 Oct 2026 14:33:00 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae841dd1b9sm5359367a91.0.2026.10.30.14.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:32:59 -0700 (PDT)
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
Subject: [PATCH v4 3/6] drm/msm: Extract out map/unmap helpers
Date: Fri, 30 Oct 2026 14:32:45 -0700
Message-ID: <20261030213251.55365-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mjQrO9dWyQvHlBJa8d4316_uAp0ca0PM
X-Authority-Analysis: v=2.4 cv=No9E4MdJ c=1 sm=1 tr=0 ts=6ae50d0d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=BsEuFZ40A6pGwezTnxoA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: mjQrO9dWyQvHlBJa8d4316_uAp0ca0PM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX4XKuOd6S2egj
 whbPkAiPWifs4y3gZMD7bd+ruBS3wGGRHhxNcZ9So7zMbsU8DCN5FqCaC7ixbZ2K9RFnXffh1we
 PaBwguhwEo9nx7YwjaZf5ba8c13i+3E5C7IYMXypu6xxAgQ39+2wmNdwRLrqjYmqfEOxKIQIfSU
 RsejU3OYRdlSzI/L/hQ5iaboBVcieT/x5HSMi9YdI7OJCFVDvsLARMHCY0diIYE6zLazDTd+dTt
 Ea46MGzoViXiQPrzyeRwk9EMq8jj/GNG8CxjdwsF9d9Zwk05dyGgO0+h8NWOCJrLRipmoG+Q+ap
 3td87oxyxsU2CyBOJVGSt8TjLv7g1FKR3PL98av6JjZc53epQKgd2KB2ug6GWrpjdS+U5kUONOA
 JDETgYMPnwVSk0wj0Mvx3j+5OkwaQ6+A2PnKVEh6OV5UXTcghgcOBZRjFzXE/0llJPK3ALgODqI
 FfTrXsfhnz6Seg+A+YA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX5LytqrxXIZEN
 T5AEGOBGlKJuRzPGxCuIGX3oyKRK77hLKafRLoifEr/15fKodZZ0SPc8ziBejPUzTn5jsJa0oC0
 tUMfI48y34ALdUzkhzq3ut0h+i6CHzI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 spamscore=0 suspectscore=0
 adultscore=0 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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

