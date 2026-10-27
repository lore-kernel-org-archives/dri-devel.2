Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5AD7606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AnRznZxN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hCv3Vqne
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4C410F887;
	Tue, 27 Oct 2026 23:05:29 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E1B10F887
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:15 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtUOW2976524
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gKkjkgB2Aru
 FPzmA+c9ZwhBgEoivlZ/rVWs+sgjcVJs=; b=AnRznZxNycvJ4dxw8dFlVWa8Y1/
 wppsIPRcRt38SUH92I1ZMuNlzFga75v37N94iFKuewD4YHqr66fafeHtIp/XSDoj
 sSNmZkpSOK52WL13C8riAfNQhMv0PHg/LqL2uXg80ZY7lexfL7nmzuV1S36htNVL
 wOSxpk7ym3XHdJQ3N1D1yFDGTEq5FQmieBvy7/+qRKi4Jv6Y9ghht86zRrR4BqYl
 DcfrUNUiwBjuhv1gKRujDXqI7vXlPFc96PFhMurrV1PPav2/HYnQtG9QsoUQbHHe
 NjH5GavirKe55+KhdKOuBKDmkdTzEdo6ENJBbrJ5Gj/8+jlSKWVBfJ5dZlw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5upua-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:14 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3aaf955db5fso516368a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142313; x=1793747113;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gKkjkgB2AruFPzmA+c9ZwhBgEoivlZ/rVWs+sgjcVJs=;
 b=hCv3VqneR3fQcYgS9cKZlzntJIPDxYva398woGLgpKuV/nnaognJ3vG5MJxFL49pq3
 ILGttzgxL3friSkQXuTF7aLNBCKymGL2Klinv0JrE+F+roUzC8fTYRa3Ol5RKdwp5662
 GwgdN0bcf9h0ULOuQURPpUppzcEsMZJUG4sxKq7CI+UBBiP/Ny1cLm3Bcm/9w7K2nDsh
 rxNsOy6mjQoLqLsvhobQLXzEpDV1W6JXxRhBaj9lnqPLXPDP/UXWqQAPZ2YSZZhFpoeO
 t0FrtQTnfTlcNzkVGpxF1wISKYY5wSrlzp78kH5tSh2D8DnPbKBOro3a2n+UuQudfTdj
 pdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142313; x=1793747113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gKkjkgB2AruFPzmA+c9ZwhBgEoivlZ/rVWs+sgjcVJs=;
 b=MpL7KNc0W6kh/MvL7ytDtro8P0OgCSEl7Bvk0hEMpTnLJAkXqIa+h8vvg4LgqNBMri
 zb1cK0p01KqgtJoEDBxktzsGNn5jEimpfsMfEx23E36RU4/sdY6CjK+kgPunDgT6mI2c
 vbiinpUXlgLLl81Chrl879x5XBRg+2CDq+Y7HAjL8k1TlIM1opgeUvITyP1BGeAPyuF/
 vWGmuiLvYalZx/6qsVCWGJ5vPY1vJHaVUmUbDRUiuAt2jHqRpqqKqdBANpS8iqpD62rL
 V1wvg0n+Tlo2TKCnqy2VNCpd9otqfEzGq+ZZUh/R8SdFToLmjqYb2qEb1Qo/g51ANFw3
 /7Wg==
X-Gm-Message-State: AFq9FYIXpCVoNR5h83GM7FQoCvu0tV2FykqaoRq4HU2EdSl2/+cqHhoq
 iitHaLdT7CHxFlq+W5lGS49T/Nl/Nc7lmuTXEROE6IjWSNXK2UyIbwex1yRErvc373Di60fq79i
 MPOu1SwCY4SP7cyToh3rSAWnBkKb5qQcoXptWx/gVBNMWZw/9rVlU7ehHGp4lui5wZz0Sq2+8qO
 wigSU=
X-Gm-Gg: AYBFou1DHeIrbIaLn/7wNMpyawO6+jKXZ+sIQwK4qnvvVk2gYfOthMNsuImJoWFZI+V
 tPoxz3KDOVRlLR7mQWqJDQwFLIjUrCu26t+0YAVtvKlPI/zRLZxJFrdsFaR5nAheqIOwFg5mm1U
 qHPFK+mCRJWLw4qLwr/dVjaiNfqrNtEh2rgwYXz8dZG7B/nzV3LB6akE3TVCNv5s9IS6W2LJV5A
 RBVWPZtpYL2K6t9pYL2wX+XzORJIHkzpaHqXNTj8NUjxID+OfPa4Uk9PJZfFt4l6W56IYaCAfuQ
 zVCKJK2L3+cc/BPa7Vv3oimzW33XSC/j5qD4l5E67a3ohucGEW94RFz8ka4qJdXbX0wLWh52fbg
 ChKqhO3yrexF/37wt3IKn8OWWGAH6dicK30hJHK2KDZIxeq3mWw==
X-Received: by 2002:a17:90a:ec84:b0:39e:6a80:b799 with SMTP id
 98e67ed59e1d1-3ae5829a339mr404934a91.41.1793142313050; 
 Tue, 27 Oct 2026 16:05:13 -0700 (PDT)
X-Received: by 2002:a17:90a:ec84:b0:39e:6a80:b799 with SMTP id
 98e67ed59e1d1-3ae5829a339mr404892a91.41.1793142312536; 
 Tue, 27 Oct 2026 16:05:12 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae5a9a5e81sm220719a91.12.2026.10.27.16.05.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:12 -0700 (PDT)
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
Subject: [PATCH v3 2/6] drm/msm/gem: dma_map/unmap_sgtable()
Date: Tue, 27 Oct 2026 16:04:45 -0700
Message-ID: <20261027230452.130031-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfXyFTr2TKgFpdb
 0sMdMFJBeM3GVyMZP3nCED9T6E1dZw0bYrUsuhghxoi4/K9Xyw+pyVQHGxRp3/maObBobEB8vIo
 hYYSax5nHufjQoL5lKJ8QDEbOjwtJtk=
X-Proofpoint-ORIG-GUID: gozO2DZ8HonKGDTWcgLcuZlr6MyX9I4Y
X-Proofpoint-GUID: gozO2DZ8HonKGDTWcgLcuZlr6MyX9I4Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX9pbZybtJkw33
 U0v5FqxQ7VoiV5kmBgXlsFQ6rJeQBvXItOY5+qsKD8Q1j33CJFuqtl19/hUlHhrkm+kt1I7/Y8D
 O7u2UmFlwKFltOfzxEmpbT33rN61KjPAnJffJRMaJEYq4tiA57CA3bg6SJItX0Gm/HKCLlu9Dw2
 7rsdjPcxrviYFWBDSOYB/tqFAVWxsHzCPmfO8Isrwy+dZDEw5qJrPp1hBxN/LzSK1yzgGAphS9Y
 hWYV6wIbPumdHKNcAlyVbPwib2+kgJOzhLk/TSmlU9sk1fhI//ZcmiHW/PiAwidZ7+ud3Tqbfra
 ZkF0ZpT73UeAy3rlTS8PnFD2V4qW3I37GuHAPzCQkawUV7pAKY62R6nM/gTR92b+Ge/JrznxMKt
 rwHe9+ivv1vMklXoT5NSTJ5kDzlfS3YGDTd5Gd0NGzkCmgV9wE3c4bnCkeUHapSEjNlIxhyKaYb
 f+WjVLlXWZhS+WxdQIw==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae12e2a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=urFl2zf4nAXEHr-h338A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
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

This should functionally be a no-op for us, since we are managing our
SMMU directly (dma_map_ops is NULL), but it populates the dma_len/
dma_address's so that we can use them for setting up pgtable mappings.

This inlines sync_for_device() and sync_for_cpu() into their only
callers to avoid doubling up on the dma-mapping calls.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 62 ++++++++++++++---------------------
 1 file changed, 25 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 181b9ad32672..c97395e4ea2b 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -116,34 +116,6 @@ void msm_gem_vma_put(struct drm_gem_object *obj)
 #endif
 }
 
-/*
- * Cache sync.. this is a bit over-complicated, to fit dma-mapping
- * API.  Really GPU cache is out of scope here (handled on cmdstream)
- * and all we need to do is invalidate newly allocated pages before
- * mapping to CPU as uncached/writecombine.
- *
- * On top of this, we have the added headache, that depending on
- * display generation, the display's iommu may be wired up to either
- * the toplevel drm device (mdss), or to the mdp sub-node, meaning
- * that here we either have dma-direct or iommu ops.
- *
- * Let this be a cautionary tail of abstraction gone wrong.
- */
-
-static void sync_for_device(struct msm_gem_object *msm_obj)
-{
-	struct device *dev = msm_obj->base.dev->dev;
-
-	dma_map_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
-}
-
-static void sync_for_cpu(struct msm_gem_object *msm_obj)
-{
-	struct device *dev = msm_obj->base.dev->dev;
-
-	dma_unmap_sgtable(dev, msm_obj->sgt, DMA_BIDIRECTIONAL, 0);
-}
-
 static void update_lru_active(struct drm_gem_object *obj)
 {
 	struct msm_drm_private *priv = obj->dev->dev_private;
@@ -201,6 +173,7 @@ static struct page **get_pages(struct drm_gem_object *obj)
 		struct drm_device *dev = obj->dev;
 		struct page **p;
 		size_t npages = obj->size >> PAGE_SHIFT;
+		unsigned map_attrs = DMA_ATTR_SKIP_CPU_SYNC;
 
 		p = drm_gem_get_pages(obj);
 
@@ -219,13 +192,20 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			goto error;
 		}
 
-		update_device_mem(dev->dev_private, obj->size);
-
-		/* For non-cached buffers, ensure the new pages are clean
-		 * because display controller, GPU, etc. are not coherent:
-		 */
+		/* For non-cached buffers, ensure the new pages are clean. */
 		if (msm_obj->flags & MSM_BO_WC)
-			sync_for_device(msm_obj);
+			map_attrs = 0;
+
+		ret = dma_map_sgtable(drm_dev_dma_dev(obj->dev),
+				      msm_obj->sgt,
+				      DMA_BIDIRECTIONAL,
+				      map_attrs);
+		if (ret) {
+			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
+			goto error;
+		}
+
+		update_device_mem(dev->dev_private, obj->size);
 
 		update_lru(obj);
 	}
@@ -233,6 +213,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	return msm_obj->pages;
 
 error:
+	if (!IS_ERR(msm_obj->sgt))
+		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	msm_obj->sgt = NULL;
 
 	drm_gem_put_pages(obj, msm_obj->pages, false, false);
@@ -253,12 +235,18 @@ static void put_pages(struct drm_gem_object *obj)
 		drm_gpuvm_bo_gem_evict(obj, true);
 
 	if (msm_obj->pages) {
+		unsigned unmap_attrs = DMA_ATTR_SKIP_CPU_SYNC;
+
 		/* For non-cached buffers, ensure the new
-		 * pages are clean because display controller,
-		 * GPU, etc. are not coherent:
+		 * pages are clean:
 		 */
 		if (msm_obj->flags & MSM_BO_WC)
-			sync_for_cpu(msm_obj);
+			unmap_attrs = 0;
+
+		dma_unmap_sgtable(drm_dev_dma_dev(obj->dev),
+				  msm_obj->sgt,
+				  DMA_BIDIRECTIONAL,
+				  unmap_attrs);
 
 		sg_free_table(msm_obj->sgt);
 		kfree(msm_obj->sgt);
-- 
2.56.0

