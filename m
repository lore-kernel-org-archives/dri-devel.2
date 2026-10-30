Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4B96606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hwPoeJUM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=TfLdhJzj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03FEF112A04;
	Fri, 30 Oct 2026 21:33:17 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC03F112A06
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:00 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAYVq2832274
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lKfSr9ShDgz
 6eFnCZ0r6QMxMYlKS96GB2Cpk0qX7FGs=; b=hwPoeJUMib669wrGmDMfFDP3il2
 TJNBWSmJoBvUDsSADtQ7IQBCgoP/FrBpWbLgj4cWqNwGRS7yn+H+AGdp28T+2qGb
 ZYFogluIZ0h/bxcbXXj1e+dXSc766HwOncLQVAX2aXi2wrcKJs36VC5A4zrqEzat
 Si+m6Oh+zXg74xb/2rs+sw5Ul0nuvA0dhfhyKpXGmooy6lEi8GNOG14/iAKXLGAE
 rTKmd8Ss6HYx5eKY8ncqtFYNl3yabGhvw2qIN79LgNSxUFZ5oO3BHtaqJeu55MNo
 4AmUVzz1R+vEMl90Fr6oeUINJEnOvp2LWfN9GOrtsuO9zGTwzfRpuZFzdYw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x181xm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:00 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdac99e77d0so498061a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395979; x=1794000779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lKfSr9ShDgz6eFnCZ0r6QMxMYlKS96GB2Cpk0qX7FGs=;
 b=TfLdhJzjscE+70FvbopW6ewZsEnrujAd1WqnPgt1Wm7BbP+Z7PLlZ8l0hasvYHMJBe
 HPux8GHHh4PY3+i0UwrlsKJY6pKsn9Yba3iEXt93aXVMmRqZYWx2UTCKY9e8Doh/+G4N
 M1m/Xe64kQgOl3USSCA8mylpN0wWf4M8hO7ndeE83r0Y9mkAhWBTQDjzWlc57csC9qx7
 cvyXmkHPnkLfxn2Mi6xd8d3f5L2lud+LyLD6GSnTJUVgYEEYQG/mf/qexaX+x90BuvNJ
 EbHGIl7Oji5F+DWOvS8LSeastXL0dF2dcUXM0NE1N+v4ViTBlQoYuQ74fCAvJ7xh7SbR
 btEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395979; x=1794000779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lKfSr9ShDgz6eFnCZ0r6QMxMYlKS96GB2Cpk0qX7FGs=;
 b=ZzhVDNAb/O0wx9fRRQz16CxRbD5e74hug6YPOnHJ3scGSf8B57AHjQ6asuMyBbBagd
 YAmEA1f7L/jgngIlcPkU/ip/FgvG4bACSgf1b3msKtjRbBfTs8Nc8ovZCd+SLD5hlZAa
 VsJ+iIzwBs/E4UroFUw5BurWMi6PQxa70h3pBmWya9xxjds0pbqMHrypcwQRW56NedpG
 afV0Eaz+wm1I/5/W9Gn+VjHEksvY8SppJ0WwB1rfecB008bYfgRXzGD0sdEwcGUvpz5p
 gbN5ms0DqPU0Px9eMATh2Sz+ak5L7QyaHahyZUIieZK03TmWk2p3ofkWgsByxehikCQC
 yHVw==
X-Gm-Message-State: AFq9FYIjEqAgOmnffz38y9vBaj6xfWadB1oylm9R34kM4v7vHmxxhP+J
 UCMOHh6bJJGRN0xo2EEY5bFrTLRTiSgCuNbJUQjGiIA9TRv/9Wwkx43Whctkacob6YqdhaBVSJS
 SFusYLoWyPesK2DHOj/8OGhHkntS+pXzTLJtxWl6Jjh7G//Qni0ZTnNquxAiOf1Pg1FmysS4ENw
 iCxyUyzA==
X-Gm-Gg: AYBFou30dyFxoEz3IS472qkb2jK1Lov0bS3p+xokJEo3C8vveCjYgI+49dcKewHiiZ2
 tvCbcouP7kMm8+Xy9VdkiHYwbZ/NMLwxknX5zkxiO4V/Y/d9Ih3OeaL633C9w/f2am7LtVf4k6K
 hnoXFxWClYjDkQ5u5nZ4kjgRe3+osVXD/pra9ZmSSbhchx7KdD15/fswTY4ydXwYAOepY7RjxdJ
 HhoinKxOma1EF2w1py+ELGh1LcAgYIhAJt7hsnSj98yR6fX3DH0F4nUHLfkDlbS6eX/k1Cn2xNf
 gxldFQ84Lcv51CsctMRW9Q53OORjq4P3kGfXZUtt+aqfIxjBduSB1icqujtm2FGLAaE/TLWuMLp
 W0kWp8qdz4lz6mLAbrNOfA7/c0qKByxnrRqrO3gWz6EtUgQEW9SF+EenUCmomeGlJ2e/pHPQRfd
 3iwoDkpmuvviiF/5z3drbP0w==
X-Received: by 2002:a17:90b:3c08:b0:3ab:17b6:9a93 with SMTP id
 98e67ed59e1d1-3ae897a64b7mr3002395a91.52.1793395979314; 
 Fri, 30 Oct 2026 14:32:59 -0700 (PDT)
X-Received: by 2002:a17:90b:3c08:b0:3ab:17b6:9a93 with SMTP id
 98e67ed59e1d1-3ae897a64b7mr3002384a91.52.1793395978870; 
 Fri, 30 Oct 2026 14:32:58 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8454327esm5313204a91.4.2026.10.30.14.32.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:32:58 -0700 (PDT)
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
Subject: [PATCH v4 2/6] drm/msm/gem: dma_map/unmap_sgtable()
Date: Fri, 30 Oct 2026 14:32:44 -0700
Message-ID: <20261030213251.55365-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XsgUMOy638XKJ2_yHTXx7h7helXRMx2g
X-Proofpoint-ORIG-GUID: XsgUMOy638XKJ2_yHTXx7h7helXRMx2g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX+xZG6bmhlysg
 ieI6OnNkB7TPtEU2t6DiCEuhi+mn2SX6ZaCaSVo7yMgjwJlEZ73P8xvaWRFIMKVSrTVW1DcA2NW
 d5jOMWhh/cWvfBHO5aua84YHfXU2GsJPrfSwuuKT1unaozRPyeuHMNekVnSjkhnRrfmgJgFsXPY
 hWikaXw6xAW6Omgkp3iwaTY/mIGmWp8X+trVMdt5mcb14cee90QTI2XvGSiyQ0TtaiKrbfZSAVP
 wtE2ui+V0A6wu7ubhbO15d+8HxZ0TZmmMqVaMTwz0zurKqlzJpKd82T8G+J/fKeTneWV1ubMRw7
 o8GHbK4q2EsFB3CUKr2dQvCW0ad3yBma9k0t6xH1Vf+X4Ya9ZnAuZOf+SKXQG3p4ccSOgBRoId/
 cAODqmeA+A/F8d0CFOGSlFJVe8tHi6qc3Ihcd9quc6b9x2kepnB0dsCVE5dmRJRVpoFY2JTm/K8
 gbyPLYu38JiE0yvWQGw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfXwuTHxGFCea/9
 nUj1dd7XKafnaHrIfoAOc9Rzb6ezcZK9xbMB8515KM3DpZSUnofsN+kBUDFHWhcUMgfmIeLO9TS
 1kZheLEMRAu+X2WA5zysdeQRpGAHs0M=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae50d0c cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=urFl2zf4nAXEHr-h338A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
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

This should functionally be a no-op for us, since we are managing our
SMMU directly (dma_map_ops is NULL), but it populates the dma_len/
dma_address's so that we can use them for setting up pgtable mappings.

This inlines sync_for_device() and sync_for_cpu() into their only
callers to avoid doubling up on the dma-mapping calls.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 65 +++++++++++++++--------------------
 1 file changed, 28 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 181b9ad32672..bcdb57866cf6 100644
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
@@ -233,6 +213,11 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	return msm_obj->pages;
 
 error:
+	if (!IS_ERR(msm_obj->sgt)) {
+		sg_free_table(msm_obj->sgt);
+		kfree(msm_obj->sgt);
+		msm_obj->sgt = NULL;
+	}
 	msm_obj->sgt = NULL;
 
 	drm_gem_put_pages(obj, msm_obj->pages, false, false);
@@ -253,12 +238,18 @@ static void put_pages(struct drm_gem_object *obj)
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

