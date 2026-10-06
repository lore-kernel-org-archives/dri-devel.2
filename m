Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D879BCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFE310E3AF;
	Tue,  6 Oct 2026 13:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJ6a455X";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UJSZMjWh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0154A10E3AF
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:17 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPN8p1172355
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NAuRL1B4w1q
 m6KEmQegsBYRQT9k+E9aeDav0hS/9suQ=; b=RJ6a455XcELItSvCqerXR1ehVHQ
 Ne52IfkwYPnPQAj6tn/MA9pDWxEbGcvYgjDnXhBTcj3x8A7MkMjnsEx9N9moqDsr
 J0y1axYkQyUQPYDvjdqg/QK4b/X2boIMGXeLgNPRYf+xqDwmjGxOotl3is+HR0vO
 YtrwSSEtGgryOmNHUGBokaGwscM5WfcbAE9ngbm7WwW562c3pmqACpYn9jW9gwr4
 E8aD4bXbV7oGqEA9aD3/BWMhcVhZxaE1YNrghVOcDIs7D+pZkCGTPkyhfATYB7u2
 XOWU3ShLkvB6g/ZfQdpiDtKYnACuKRzB7ihgsG/fzD+wLY7HD2qQ4YQbyhg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xwwrjbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:16 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc11b5dd54dso4425052a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292216; x=1791897016;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NAuRL1B4w1qm6KEmQegsBYRQT9k+E9aeDav0hS/9suQ=;
 b=UJSZMjWhVhY0mxQcsK3NsOat+rbspGb2/RT7YrhhPmtiRAegWTUStCO2TlW+JRTplG
 YeShOhdq9qUFJ9vUegoEQn9mU1jIH7KzthhxipFFjLY76oThqdkwk3ypiHD5aNuESVvV
 FxbJdareg3gBDXGyBum7eJVK7pPTppD7BpH/BzfFwRyQNsQcwb5nueghs4OHojZvo/Lp
 K+Z3RDklS5JUr8VlxO4fvHzqN4jQsBStD7asiKO40PB1N3nJ8DgDf/KX1xkhP0obRx5k
 0N34WubpeaUgLJ/s0JEvcrkpcpwy5Ganoi2aPvtFXtoJg9n1d+2RB5nH3ApW5XVYGzxk
 lWVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292216; x=1791897016;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NAuRL1B4w1qm6KEmQegsBYRQT9k+E9aeDav0hS/9suQ=;
 b=0rx1UZPZ0IarfGishJ41MeOVwThkJSk/Dpo1sJhuI/OfZ4l7WjPbE/GCGq6aMytas2
 xJEVZPBzhLU2n+TihLaCnZvi5061tLBdH2vfaEmvB1ysGHWPBxTXj3tTmjpOsDqChDoz
 mpzpzNE6GnyRs9pvXsn5MGHgZfXDVVN16mME5azO36jaxXk1FFCHLGlvNixW2goUWanX
 ZC0WpyDtq2ZRbImvjSRzwaWwuq0Noo1dkXnIrqUvvZzgkV1v+sW9TfUY+7Hn2IGVyvEF
 yPQGEW+NzPPz+wRdUfLTOzUaqFCqXvz6IEbqwWEBCb3x3yDO7lHMMSa0H22U5FxhhsUK
 3VPA==
X-Gm-Message-State: AFq9FYIRs/vkJ9+xD2PVnFrMjsaBRzFRLE49eSq5/X0AANGERPGTRPnb
 fBEIBqcHvzwsieZTujWknJmlbMvpCz9C1PrSofWlFchzcBIYToL9aT7QxCg9hL0EYk5EN+NBdtU
 uxN48HVdp8l8qY3U+NvaIXzqadjjPppbOaDGdv2LYeSb7aj+eLp/ZH0AOnJWEF4GkmOB1f7Gs4m
 nu4eY=
X-Gm-Gg: AYBFou26/8TYlVxM95fTsFHlMhWmGJZeB6jvRu+Ql+lSq+N1st4BFnmumBBqELyOaSC
 GmW1vf5UObMXiO4Shcla8he+CCJG60Z2ve/z9W1YwpgJge9V4BoPZfWpyTPfXU3EYky7cCQMdn+
 gqICy73xOXxZZV+RsDyA2BPuUH2JUpqEfwSytlZwaC8tPkwJH/CVv46vKGHKKNpIrPfZ4PqDcFE
 i0B4gLJnyLCsCwAbdNLhXdaf/8g/ylInZgbVD2IbiCyvBrw8DgXhgaQuDDYWRiFAUrtyEVRH1nB
 DcAsytP7zj2uU+qnng6bQcpqcBsyMn53VOQAQ5SIkeqfnKJOi5PtgonDbTbGuzc6bo/L3EkW3cl
 kKsA0rnaJ7bT+OLPQSO2pxoo3UKGECUKuNwY5RzjPpSVL4g==
X-Received: by 2002:a17:903:40cf:b0:2e1:35f0:6822 with SMTP id
 d9443c01a7336-2e4ea0e96f0mr97170725ad.2.1791292215911; 
 Tue, 06 Oct 2026 06:10:15 -0700 (PDT)
X-Received: by 2002:a17:903:40cf:b0:2e1:35f0:6822 with SMTP id
 d9443c01a7336-2e4ea0e96f0mr97170455ad.2.1791292215429; 
 Tue, 06 Oct 2026 06:10:15 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5ed0223sm22035515ad.54.2026.10.06.06.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:15 -0700 (PDT)
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
Subject: [RFT 4/5] drm/msm: Convert iommu map/unmap to helpers
Date: Tue,  6 Oct 2026 06:09:55 -0700
Message-ID: <20261006131000.81501-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX5PLCwcxXqXE3
 c0NEp2k5QfiLy0I4FMoHhR/aS6t5YolIpMT4qYez7Gy6DKhGfcm39SM0UtrSEyKBfgDsiQXAoxg
 YeaK6k7NumnKYdn5D4kVqlEwZ3nt4rsM7N0kd8QiZtnawwtP79L1fCIwqikY7ZgeR9ldQhP/ihh
 MLgVgvbO0M4J+h9ZFhzelMudExloBwpPGa2QMeFylkYdgP6ig0C9XUrULDr3SI9AaUU8GJxb69m
 hspU+HBx9I+ezM9A3xwFg7DQYEKfrr+3+RHjZ0JS7T57iz6X2NrcXfE78LrInO67CZzFNtVmMCq
 +9VlZEYHGiZKgGPinvBs+ckSCI2GxKTOKQU5Gg3fT9K/2ACQWraBKzAICBfBZvKPuoUQQUwOQs6
 FDOiSVJudE5FNmyV3kuj6BuF9rHHm88zafiJvkBHEAMhIaR+dN+GRgDoQj4rsarg6LrvYhBrvGt
 8RliuoLNx4l9ym2j1Hg==
X-Proofpoint-ORIG-GUID: ihjcZtY0tr6383H7wYyiZhCzQKxc1ydX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXz3EjMn8CV9qI
 nb34q/9E20guLAw8hbBYzzKhS1TisHTrufREiLwxbs7DcH+WPnWMUd9kkndJ2Heah2KgrPKlfJ/
 A+s7J3vGaAF8DLeU27VTJRZyozbm1ws=
X-Proofpoint-GUID: ihjcZtY0tr6383H7wYyiZhCzQKxc1ydX
X-Authority-Analysis: v=2.4 cv=SJXXx+vH c=1 sm=1 tr=0 ts=6ac4f339 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=3T_YcleVrN8O_gWOTnoA:9 a=x9snwWr2DeNwDh03kgHS:22
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

Re-use the previously introduced map/unmap helpers in the iommu path
(TTBR1 for GPU, ie. kernel managed buffers, and display/etc).

The callbacks work in terms of iommu_domain/ops instead of io_pgtable.
It would be kinda nice to just deal with io_pgtable, but the tlb ops
that arm-smmu uses for it's own io_pgtable require doing runpm, which
we wouldn't otherwise be able to do.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index a658493f8007..50038d00c3a8 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -720,12 +720,27 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
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
 static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 			 struct sg_table *sgt, size_t off, size_t len,
 			 int prot)
 {
-	struct msm_iommu *iommu = to_msm_iommu(mmu);
-	ssize_t ret;
+	struct iommu_domain *domain = to_msm_iommu(mmu)->domain;
 
 	WARN_ON(off != 0);
 
@@ -733,23 +748,18 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	ret = iommu_map_sgtable(iommu->domain, iova, sgt, prot);
-	if (ret < 0)
-		return ret;
-
-	return (ret == len) ? 0 : -EINVAL;
+	return __do_map(domain->pgsize_bitmap, iova, sgt, off, len, prot,
+			domain, __map_iommu, __unmap_iommu);
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
+	return __do_unmap(domain->pgsize_bitmap, iova, len, domain, __unmap_iommu);
 }
 
 static void msm_iommu_destroy(struct msm_mmu *mmu)
-- 
2.55.0

