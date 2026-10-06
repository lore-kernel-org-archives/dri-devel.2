Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1220CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F5CE10E404;
	Tue,  6 Oct 2026 13:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kxwPwu2m";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jXsHQJXG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC3AC10E3AD
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:16 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPOh61172358
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7qz+kphyBcY
 gVTQEMuJdZWHB+095CEstCSz1VAkJ91s=; b=kxwPwu2mUM0ysSQUtdvpW4sEsDD
 vqUj4yKc7bTrBe1MFSjT7/kI/AkLi2KSZfnyNxZ5/M/MOBqxezXraCQRB82Aq3zc
 7RLzNKxXL7iJuv6N5JZERriJD9QBf1SuCcHNgYILbyPoGh5LWu4B5+SzeqQowsth
 59K/qE7a02hTXyK66dqDGjNZMIYLUanE904VrukV9xP2nz8BlSheDVuUmnaajttj
 0BPK25tUVO1A8bDXVlK49oOOK8rBVOF4wthLI3O+FMa1YUJKFHbenwfKn82COLop
 8mdSARUVMsXySH2ELkR8VIFZzp0p0z+jeaGEdBiNxGrLDdztj7vK8a89eoQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwrjb2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3a7fa5e0442so2982595a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292215; x=1791897015;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7qz+kphyBcYgVTQEMuJdZWHB+095CEstCSz1VAkJ91s=;
 b=jXsHQJXGJGYQ+afZSullHyZurkuyePfhuQ3i2kBvVuQN79HYuFkQsZwAiTSzA5IjDJ
 icrJCd/nkHAmzFPlzf3lwHqBFnkvcc4l7+VmLbpiejMvEQf1ja8sIYc34ryXrrFZN/LH
 /TZ2Qpm+/becwKSEignxCfG/McOdh09555kdHLm+SdKxXbGZfZ4pWoWWPiDqAsexLH0t
 sHiyT0yV1Q6PAA2RqlWuZrio1xQR+mFZ/7hLWVdtyQVvLQJhE3iKdXkwL+ZYfvyoHjMv
 Gv4md7Yxp5C3kdlmQxQicDJCGfZ8tkfQL3QKInp6fNDhvmEP88rQNp8JlC3GgshxPZvj
 GPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292215; x=1791897015;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=7qz+kphyBcYgVTQEMuJdZWHB+095CEstCSz1VAkJ91s=;
 b=znhgLPKLT90jibNx4vyfhz1GRavA8zE5shNYeKTnAF30abx5toKy0GxIaMJ62W1Sni
 0KF6UWkjyNWB9BmVIO+VUp5B1K8C04VLNpD6i7Ux29V9biStwibbVNJj8yeapdiYAVan
 pFZ/EZAYhSg4YT9+2TOaE6bontYdInJ2wPsNQC/koftEQVO3BW343jzZXouRDdtmX1EE
 gVSDPulzQAjgDwEOslJSnGK6M13zUMDq2AfhSeXqfiUX0KJ+Wf8ywUDeZFdLzV+ODpJy
 3dLztSKVZ16nqFP6ajJhwZqpMp7ezKj253PqFX9Rq5aB0fOJeqUIjV+pLOduLX7LmQtI
 aSdg==
X-Gm-Message-State: AFq9FYL4BHHAdycTfO4mVsSPwvcuCZcTUV4aUmxggHk+VryUCW2fdVml
 9jkFv1MavwBwWTMu1Gq4372vWwjgdQZASEY4bl7iI1vvM6tRCBIBPVBMuZy+RMTq6j8tHxQMJZI
 KtABVIP0NhCiNNV3i6xmOgqGqaIL/pDy8mA4gIn+aA0UM5BcZeClH1+t9u5gemn/MoI7xp/cZZ1
 IUoy4=
X-Gm-Gg: AYBFou17uYwh7aPezyNt91dZsgDTQ9uNRYbNTKC0FzRlOP7w+PZA4Fes3G1F24E8O6R
 FtrIC7wT20CjlPE2fWQm8xBxQ7baf3ZPkPC4tBYlohI+Ae35hLIDQYOWwDVPvf2YNqt3v3FsChY
 qiCn/2jq4b3pWWNbRJP998JqSk4m+qvvxlSU1aMkdyUH9C320IDbWuipwT1oRoOOKKO/pqjLpvT
 hA/AlB4cjqHVytLab71/Snw6jT8XqHkrleqWzT9MPC93oi3LYt5fheJPLRufEzKKuXzF/ue0SHM
 3ZoIZzscvkp4+20XqgBzFzNnAXVz/tqGq1x/4jG+Od3prdvFOxQ6T4iVCDlL4KpW+OGU3t3GldC
 fF5ymDz/Ry7Q6reXIINZHC1pZoiJ+vkWxUYWLOpbM+DnQ3w==
X-Received: by 2002:a17:90a:d88b:b0:3a4:bc68:42b8 with SMTP id
 98e67ed59e1d1-3a87353c17cmr967034a91.13.1791292214511; 
 Tue, 06 Oct 2026 06:10:14 -0700 (PDT)
X-Received: by 2002:a17:90a:d88b:b0:3a4:bc68:42b8 with SMTP id
 98e67ed59e1d1-3a87353c17cmr966993a91.13.1791292213804; 
 Tue, 06 Oct 2026 06:10:13 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5cb457c87sm10596705ad.68.2026.10.06.06.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:13 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [RFT 3/5] drm/msm: Extract out map/unmap helpers
Date: Tue,  6 Oct 2026 06:09:54 -0700
Message-ID: <20261006131000.81501-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX/ncuJds3M//C
 h/vuEB9tijWnsWJ22f3a/xjzOyALQZTse1blze/H/Zc6FD8eEQtYTsxh9zDtRYYh1kMx0U2LwAo
 KPRGrxbQdyRMByCPAjU3B2ynwfH66agyoZ3vtB+A42HGUr/5j7ohlSMt+Qs5RlW9+Fgk8DeH9oi
 Ko7NXigKr2WIGi826VDgIit/pucrGnrwEZTensBvj4F7ocz0RqP8HGn/7zbpeSNnIN8J9kauchR
 7N9YiJcvHYKCEnIoByMq+B90uyRC6hLkcNKFwv2ybusrKX8Zch6VuFhuM3sbvxdYi+6WN+zZoNv
 4SPhw9yNsQXfnmn5L+/102au4CKrAzLyvbcJxfrmcaWvpZ0KgIBi97p9Mi/9lS6sw5pPKdUHieY
 0+wedyVRzQCVgEsQY4IrtbNN1WPAnXtRyanwDtx9A26gIvOrWteW3PIdnPrjMYDkuGBcpd6dbem
 9+POnkq+64/IBKQ4FZQ==
X-Proofpoint-ORIG-GUID: 06CPCfE4veoBE0Lmg9jMAYai4WMIGdBm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX9o+AGYtmMjRW
 OXtHJ6L/Qd6K46wiJbpKw9q6KNEAPmuxbZYAL/TsJsUAza4Ix3PVGh52upcrqL64+16f18gvrq8
 q5Ix7k5Z2ONs688s19TGv0gAyJs4rac=
X-Proofpoint-GUID: 06CPCfE4veoBE0Lmg9jMAYai4WMIGdBm
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac4f337 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=TlyCNyREkyh6uJHYreoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 spamscore=0 phishscore=0 adultscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060052
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

We're going to re-use these in the next commit.  No functional changes,
just some ugly callbacks.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 150 ++++++++++++++++++++------------
 1 file changed, 93 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index da6782fca6bd..a658493f8007 100644
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
 
@@ -107,24 +106,27 @@ static size_t calc_pgsize(struct msm_iommu_pagetable *pagetable,
 	return pgsize;
 }
 
-static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
-		size_t size)
+typedef size_t (*unmap_fn)(void *arg, u64 iova, size_t pgsize, size_t count);
+typedef int (*map_fn)(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
+		      size_t pgcount, int prot, size_t *mapped);
+
+static inline int
+__do_unmap(unsigned long pgsize_bitmap, u64 iova, size_t size,
+	   void *arg, unmap_fn unmap)
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
+		unmapped = unmap(arg, iova, pgsize, count);
 		if (unmapped <= 0) {
 			ret = -EINVAL;
 			/*
-			 * Continue attempting to unamp the remained of the
+			 * Continue attempting to unmap the remained of the
 			 * range, so we don't end up with some dangling
 			 * mapped pages
 			 */
@@ -135,55 +137,18 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size -= unmapped;
 	}
 
-	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
-
 	return ret;
 }
 
-static int msm_iommu_pagetable_map_prr(struct msm_mmu *mmu, u64 iova, size_t len, int prot)
-{
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
+static inline int
+__do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off,
+	 size_t len, int prot, void *arg, map_fn map, unmap_fn unmap)
 {
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
 
@@ -204,10 +169,9 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 			size_t pgsize, count, mapped = 0;
 			int ret;
 
-			pgsize = calc_pgsize(pagetable, addr, phys, size, &count);
+			pgsize = calc_pgsize(pgsize_bitmap, addr, phys, size, &count);
 
-			ret = ops->map_pages(ops, addr, phys, pgsize, count,
-					     prot, GFP_KERNEL, &mapped);
+			ret = map(arg, phys, addr, pgsize, count, prot, &mapped);
 
 			/* map_pages could fail after mapping some of the pages,
 			 * so update the counters before error handling.
@@ -218,7 +182,7 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 			len  -= mapped;
 
 			if (ret) {
-				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
+				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, unmap);
 				return -EINVAL;
 			}
 		}
@@ -227,6 +191,78 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 	return 0;
 }
 
+static size_t
+__unmap_pgtable(void *arg, u64 iova, size_t pgsize, size_t pgcount)
+{
+	struct io_pgtable_ops *ops = arg;
+	return ops->unmap_pages(ops, iova, pgsize, pgcount, NULL);
+}
+
+static int
+__map_pgtable(void *arg, phys_addr_t paddr, u64 iova, size_t pgsize,
+	      size_t pgcount, int prot, size_t *mapped)
+{
+	struct io_pgtable_ops *ops = arg;
+	return ops->map_pages(ops, iova, paddr, pgsize, pgcount, prot, GFP_KERNEL, mapped);
+}
+
+static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova, size_t size)
+{
+	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+	int ret = 0;
+
+	ret = __do_unmap(pagetable->pgsize_bitmap, iova, size, ops, __unmap_pgtable);
+
+	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
+
+	return ret;
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
+	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
+
+	if (!sgt)
+		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
+
+	return __do_map(pagetable->pgsize_bitmap, iova, sgt, off, len, prot,
+			ops, __map_pgtable, __unmap_pgtable);
+}
+
 static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
-- 
2.55.0

