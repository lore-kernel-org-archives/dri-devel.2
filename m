Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A45F60A2605
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=COSfLb3J;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LcMpCL7J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 962A010F674;
	Tue, 27 Oct 2026 15:28:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2A8C10F676
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:32 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFKtnI1521233
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y11jEpRTQq1
 C4+GXBtkJEfxP2mZ+Qxz7cGDzmFaJGPI=; b=COSfLb3JVphph+skhdIQP71lFsL
 RyXpX52qfgDkm6eHHlfi+tlNM1p1yn7+jtl7Hc/9rEaerYEgRjuvI5rX+gnnGmAi
 MSVBlB3uKeLkYwiOORmraX2lzQOooSkfSH05V+uwmlrpgzKWTsXPGhQ2LPGXN8Aj
 akDWSeTHL6KVBJrNJlD2gTxzn4VLetSyRyPWzmQL4x6mQOvbLcIrAwpUGq8+r2wk
 fJ79k4vjYfVtIpTXR+AAtULvRQb7UbLSropy/4g4R2Fz5STRFydxK5i2V5PsMpZX
 D5xr3L7ptzgwW2PgYMI3t6avJxRfQ9aCch5+Ny54UM5zV+lgEBycs+HU51A==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98swk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:31 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2e818ca61bfso44647925ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114911; x=1793719711;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y11jEpRTQq1C4+GXBtkJEfxP2mZ+Qxz7cGDzmFaJGPI=;
 b=LcMpCL7Jw47i0I+tahFHYyeG4azlm6L/Azqg9mIw/ZQ1cPrfZuAX0VUSZYrkJDiV+w
 aIJXRdoWKTjnWvPEoGowm5izufcp1TpXXuzlulu0N9xxuJ85PgZaAt/kWaX57qbxfhyb
 T2290O4IuGiMc9toE6ztPOxKOMwzi9y4tFmXY3GUDJWO5yLKW1oseM6ToeLUl/tR52or
 KWvilRxQZomqgeQPHM/kn1G73B9MCWFFmYdHa/OCXdj8JTfu4UpL1FIjv8qucK8TMEcJ
 tt3kgfahR5+cLGIvCL/6wtZEy9kk7Qte5Kmy4WRWaQDk7onDnTrSIhl//1jLZUPDVDEy
 eBNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114911; x=1793719711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y11jEpRTQq1C4+GXBtkJEfxP2mZ+Qxz7cGDzmFaJGPI=;
 b=eOMvxegZ+jmZe1ufqhCM/QkepOgm7ss1i4kPhjRqqkEM1bxfeJFcC/ea0jZGVNXVnk
 SBKBGmPIaNZaWlz19FQnLU/rYnobLhwsQlvKhaOK47Sqc5ll71YrBDopI0l1Mpc85jNI
 R5JugPLiyql+eQptLQNE+dQVt7c6Tu9Gsb96k9C12Wul0Eye9CtbjZ8wQes9LeAr+Hvm
 1RIutJCyr6jx3o1Mdleo6RUWoC8pnjOTz5woZlzBwy5QQ2eyeIHJoNiK8cir2qppZm2w
 dy4QV8TNazH4wXFh2cpuwuubC7GDrmX5zHNYVmqUcUttfDb6T20dJE6VE8cUzYf7t8Al
 Pqjg==
X-Gm-Message-State: AFq9FYJ8chMgy08dt5QiQtQ2nOKfb4mliq61q/C9hMYYCe3NoXPhWP2A
 qJflUvAMbfSdHvv0a8izCVlDHaJDNk4j8FynaQ1OxmaMaBVhKqyPwlkI7fUL+0IjM4hmppqUYkG
 aq7z/LnEk6xONaP74G1K7wvVPoKxYbCNue6C1LdVgt5ZM/VXy0R5tPTECETaoNfMosiqOVCSSXK
 fGtWY=
X-Gm-Gg: AYBFou2BgtIyFdk/gZ0vxY/yzvEUud274FL16kracpiIDctHoXX/zcUob6uUd9DmFxl
 U7OT91/PJaH8VNKG53CjOKRfbw7+HR13DKW8hp0SBp7wgsbS3U00VEBXCsyNHF6P8PB+XSh4xMI
 zIoSxeWRcbWIIDlUx5i3XcgL2ZhVDG6xJdX+0E808aixzrJG09NDZCmHvFvXDlP6ONYFEjsGwH4
 FiutDVPBIDOPiuEIS2I2TyuaMIDVMaGNtEdRDW3rv3iE8fM+Mbn5OIgkeLWmd38BI1ccQ3mqBJ+
 owOXmTs/G4jXV5paH+PRWIy/pV6+tMFb3OS4s4/WfhVwyYmSRLb2Ve9Fa/O6qsk4YT2Ho75jpdf
 RDS8Rc3mEWNhxhOzv9FMhHbPBDeikGpqdx2Jn+VXUixbJ81w8brlM+J4rVt6TpFtr+qH9Tx+Oe0
 I2mIJn+qfcofDsR9KXS4MkHXw=
X-Received: by 2002:a17:903:26c3:b0:2e9:8510:6acf with SMTP id
 d9443c01a7336-2ea9c8194a1mr83268035ad.25.1793114910462; 
 Tue, 27 Oct 2026 08:28:30 -0700 (PDT)
X-Received: by 2002:a17:903:26c3:b0:2e9:8510:6acf with SMTP id
 d9443c01a7336-2ea9c8194a1mr83267805ad.25.1793114909957; 
 Tue, 27 Oct 2026 08:28:29 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6b768ffsm11619545ad.24.2026.10.27.08.28.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:29 -0700 (PDT)
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
Subject: [PATCH v2 3/5] drm/msm: Extract out map/unmap helpers
Date: Tue, 27 Oct 2026 08:28:17 -0700
Message-ID: <20261027152821.51144-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0c31f cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=R8jjkeD1lhB8w9RMBGIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: bzR0WDGrDeAjv3tKRHTudZozYfX0Q91F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX9o1myx8fFQ/h
 94MYtbKr/mhL7QWlrIUcmNCWkBKXB+6XikR0wB9/FuEDon4rw27kTazea6/hyssRXd3ixYO0kXy
 S93Xyk95P5dc9u8TnpV0KqpYbN90hTCXjAV04oUgNMN9v5+hdrPZOWMil+DPShWGhxtQTxpNW3u
 lUjbD5EdLa4RvYFq9EYfay0xRCm1xy2UnBpMyw5B+hRG0+HRxjcg8BCtHUC1ox9TyzvvSAzmlYX
 oe/qbTgOz2BWt0PlOj6InXwXZ4hjXxrnWqt0+eNXkP/MAIkA70lLhtrdKTcCSfwQkZDsz5govWR
 LGuFElmgJ+egquCDKVGDmEq0iHY0UOmiBV+LyP0fa3pwHPf/87wvhcMUha93PrCHWkvmEX3qOjZ
 CfHfWCDqf3OVFqFgl1xWtL8y9Ak5mUxbxAKotj0kM39Cq/dPRSLNjSDz4Y5CE03/Gp+LXFBVJv6
 BNY7w482ioKTv+pPjaQ==
X-Proofpoint-GUID: bzR0WDGrDeAjv3tKRHTudZozYfX0Q91F
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfXxQHDy0dRKks0
 iolalJjxKZussRi5FDoUXZrsNGTFFbMlx2cdPXLqgbYsqxv3EdhnDFXo3V6cqM1EfMiwA9tIiR3
 y7Rni/i/dR7XRcFU1gxT1nJs1TF2ek0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270061
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
 drivers/gpu/drm/msm/msm_iommu.c | 155 +++++++++++++++++++++-----------
 1 file changed, 101 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index da6782fca6bd..78c82f4a01b9 100644
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
@@ -135,6 +137,83 @@ static int msm_iommu_pagetable_unmap(struct msm_mmu *mmu, u64 iova,
 		size -= unmapped;
 	}
 
+	return ret;
+}
+
+static inline int
+__do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off,
+	 size_t len, int prot, void *arg, map_fn map, unmap_fn unmap)
+{
+	struct scatterlist *sg;
+	u64 addr = iova;
+	unsigned int i;
+
+	for_each_sgtable_sg (sgt, sg, i) {
+		size_t size = sg->length;
+		phys_addr_t phys = sg_phys(sg);
+
+		if (!len)
+			break;
+
+		if (size <= off) {
+			off -= size;
+			continue;
+		}
+
+		phys += off;
+		size -= off;
+		size = min_t(size_t, size, len);
+		off = 0;
+
+		while (size) {
+			size_t pgsize, count, mapped = 0;
+			int ret;
+
+			pgsize = calc_pgsize(pgsize_bitmap, addr, phys, size, &count);
+
+			ret = map(arg, phys, addr, pgsize, count, prot, &mapped);
+
+			/* map_pages could fail after mapping some of the pages,
+			 * so update the counters before error handling.
+			 */
+			phys += mapped;
+			addr += mapped;
+			size -= mapped;
+			len  -= mapped;
+
+			if (ret) {
+				__do_unmap(pgsize_bitmap, iova, addr - iova, arg, unmap);
+				return -EINVAL;
+			}
+		}
+	}
+
+	return 0;
+}
+
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
 	iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
 
 	return ret;
@@ -176,55 +255,23 @@ static int msm_iommu_pagetable_map(struct msm_mmu *mmu, u64 iova,
 {
 	struct msm_iommu_pagetable *pagetable = to_pagetable(mmu);
 	struct io_pgtable_ops *ops = pagetable->pgtbl_ops;
-	struct scatterlist *sg;
-	u64 addr = iova;
-	unsigned int i;
+	int ret;
 
 	if (!sgt)
 		return msm_iommu_pagetable_map_prr(mmu, iova, len, prot);
 
-	for_each_sgtable_sg(sgt, sg, i) {
-		size_t size = sg->length;
-		phys_addr_t phys = sg_phys(sg);
-
-		if (!len)
-			break;
-
-		if (size <= off) {
-			off -= size;
-			continue;
-		}
-
-		phys += off;
-		size -= off;
-		size = min_t(size_t, size, len);
-		off = 0;
-
-		while (size) {
-			size_t pgsize, count, mapped = 0;
-			int ret;
-
-			pgsize = calc_pgsize(pagetable, addr, phys, size, &count);
-
-			ret = ops->map_pages(ops, addr, phys, pgsize, count,
-					     prot, GFP_KERNEL, &mapped);
-
-			/* map_pages could fail after mapping some of the pages,
-			 * so update the counters before error handling.
-			 */
-			phys += mapped;
-			addr += mapped;
-			size -= mapped;
-			len  -= mapped;
+	ret = __do_map(pagetable->pgsize_bitmap, iova, sgt, off, len, prot,
+		       ops, __map_pgtable, __unmap_pgtable);
 
-			if (ret) {
-				msm_iommu_pagetable_unmap(mmu, iova, addr - iova);
-				return -EINVAL;
-			}
-		}
+	if (ret) {
+		/*
+		 * If the map failed mid-way, it will have triggered an
+		 * unmap, so we need to flush the TLB:
+		 */
+		iommu_flush_iotlb_all(to_msm_iommu(pagetable->parent)->domain);
 	}
 
-	return 0;
+	return ret;
 }
 
 static void msm_iommu_pagetable_destroy(struct msm_mmu *mmu)
-- 
2.56.0

