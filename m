Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C38606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=FwKsuVyb;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XRvpkbG8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE21B10F659;
	Tue, 27 Oct 2026 15:28:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E2C810F673
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFL3QV1522032
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PeGMG0GUYQ6
 9EwVs+BG01KfQYxsrLdk8FD6P+7s8JTY=; b=FwKsuVybaVThb9tZF1gRV74vs4p
 XCQUWrT02CBRVDYhUzZCTnA1t561OHEr7pLzZ96unT1mqDbz3r2OYCLgXdIW2dbO
 CCp4Z5wZzfUBXT3R87ZCr0Qu9npQafLCbbioXjh6FU8uJsodL7Df+Wv9pOYimJHv
 ZQ3VSyoA8ApkQgQ3/hetVg+pAjCx+VJFbjuqSIxYkd/B0wdizLTT2n0yVGT10CRM
 jpU17IevJRwg/S4HFFOYHbIYZY6ebU+x6oPDKXrNLUT9ZwGceiyPRWcP1T0W2WqD
 Mh5JKET9YqPcNcH7GI1BBDW4/6hrQ0iUa7520TTat7a6mJU/mqXdU+HM4Kg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux98swe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:30 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a05c820ecbso34256b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114909; x=1793719709;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PeGMG0GUYQ69EwVs+BG01KfQYxsrLdk8FD6P+7s8JTY=;
 b=XRvpkbG8juvFU4oHGsP3L4s4PRAi+tmaEL5Edzb7b8FG3itCOP6JbQoq8eSZmoy861
 gk1SrCFZxeAojMyoGCXVvfVpDrlAZ6FnrLKnHya1c/jm65lLZV9d8PbrUNFKIgur6a+m
 vc/ZInfaGibKsO6Gq56OiNKIf+YdlrsBRVTLEDDocygkTLe3hptpA6aDLXigpmD+G23s
 F+k8sfi9TEy5D0mKsVJ4pVSa2l37/XLdYmVvtzUSI+SePMy8hnHH62nBuiglLKrwzg7H
 YXCLd9K/DtnUVVBDoGoZIynmVKY2Uba58bXxsu2xNRlTtsZfiHb0mW9wSaDbS2iCiQMe
 hhaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114909; x=1793719709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PeGMG0GUYQ69EwVs+BG01KfQYxsrLdk8FD6P+7s8JTY=;
 b=2ZW+PEZ81E3tOvna7c+8GeWbcfrLDivHlcbrBnSvF8CaudOrZu14Thdazed4ti6pv+
 DGtDUfVclgNrHyFf/7VwBrnsZBjvWjY+wO+4wIB8pUGR7OVACPmeI/+tdNepO8dwXWwH
 XOeauqSf1CabGkKqKbc5Ai+YdGtOq2yaIwuLUzvu9bpiwTQu2XQMANZkJQLzoIFryBMu
 Mw4q6T+2XNVP6JTRo7y8mxJTIsyT7LXyblZIYm+AMdEeX0MoKstfXktLWci2oQoopIoA
 7Wdtsq44TVBxZDgtvxE0vGvAjrB4La7DPbKbl09AdlESRaqxbx6c112To0xSUC6FoRWh
 8B4Q==
X-Gm-Message-State: AFq9FYKXI33QuHHjnmMGtg03ny6E2F3eu0e5O3pzUTb4tKWdtdN29p/x
 4gXDa/jxlKZOquCwGM/wtRLHkLmrl7hlZ8xA+0Gj7SOrhTk535rnKVxGPH0S2MiLG54AHvrzVwk
 AQNAgjkcHWa+vycJSm4mG0NAIflbrCUR4DbtH3xhlHCvCI+8x+TL7/sHLVzYFObumLnV6l+qBWF
 F9YdI=
X-Gm-Gg: AYBFou3CT4xGB+HzmlW2bNGfaGzs08VmIHztZPcdjLpji/SAfChyxmCOZPGr3TK+n0b
 /Y731gPPsrahxMXBwNqia2+oBZ3BI0nrOjAME+by96VG6L+zQLpcPgHsfwGULc9jdtlQ+C5JHg5
 qZSZ/OX7U6iHBCFe7Ocg9UdwhaKUAFk9HtoXSDOwZEhPY5lQ6UB/tLtJeunIshllY+vkD63th17
 Su7PpUA6HiiEVu2IXeAVCOOPeP7PTXzwZ0SkPCDWiVsnGHQKdb/BBkV9Y29JveL/QIsG1WFiwt/
 BM/aflJmLI3P6S1mT6pKJA2aUQNL+AdvqFguZaPFrsfThq/t6b8Fr3da7pD4yOWCbxXPUOImIQr
 6fzCF0uMlLTI248hfwuuOsubYnr0Vtw6ABbrv3lxLKa7Dvpc1
X-Received: by 2002:a05:6a00:1da5:b0:89e:2a91:4fd1 with SMTP id
 d2e1a72fcca58-8a364e33a57mr7763313b3a.6.1793114909451; 
 Tue, 27 Oct 2026 08:28:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:1da5:b0:89e:2a91:4fd1 with SMTP id
 d2e1a72fcca58-8a364e33a57mr7763284b3a.6.1793114908690; 
 Tue, 27 Oct 2026 08:28:28 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a5f652aasm196096b3a.17.2026.10.27.08.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:28 -0700 (PDT)
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
Subject: [PATCH v2 2/5] drm/msm/gem: dma_map/unmap_sgtable()
Date: Tue, 27 Oct 2026 08:28:16 -0700
Message-ID: <20261027152821.51144-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae0c31e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=isCY8TonHXl0-fnU9HAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: PrHDjmM1lCGaY7o0XGuZMSoHyKp-fW4X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX0jLjGZj/BlEc
 dqNiSdpjKGNPKheJ0jZhUSDfV/e+0AI3cJGGUtVOG4NkthuI9gIjFrqXnXP5SvdfgHUdCVT7GeB
 8siKGpYX6bTANIBPleOs5cLAqhn+Ig6qb7+IXbYdNmO2cHG4JtVt+LyCsEV1uAJdMLI8i08CNLk
 TyW4Pdpe+kgxdC0jXjyKl4h6EJDPUd9T/o1zH700MTIR42TUmQrRGLOP4iZmF5zrm6ZhsC50Jxo
 OdOT/GQYCS0y9AGZFe677utpj2mlAVa2BQuTSoo2OMI6mB5x9XASu1D8oAGQWwQ4Jt5dt7VM0f5
 /eAofjTc2ML6mu5xk9dqyN2A1rdf1Yoas0WvHw6AAclP+fd0868W75U/SMd6omTbeqKOt8QT1rT
 GlrfNtAVJWN563Xe+3MW3kA1OOkSW8fa3p9BoubdezxtarcsKQho3ma0+7dqZjhm0TkfkhfnCGL
 emz23AgckE5K0nQsymA==
X-Proofpoint-GUID: PrHDjmM1lCGaY7o0XGuZMSoHyKp-fW4X
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX/pPKQKcePqeh
 jvhmJnObiNNtCytZNEfIQfc7O5MMIeq1eX0/NVlG5yeBZ3P+AtDKLe1KOJxcTWM4u5HsYEMSoui
 r5SXP2ZaSODXyVB25rRxgvWY/m5upYM=
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

This should functionally be a no-op for us, since we are managing our
SMMU directly (dma_map_ops is NULL), but it populates the dma_len/
dma_address's so that we can use them for setting up pgtable mappings.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 181b9ad32672..72e3cd8bb1e7 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -219,6 +219,15 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			goto error;
 		}
 
+		ret = dma_map_sgtable(drm_dev_dma_dev(obj->dev),
+				      msm_obj->sgt,
+				      DMA_BIDIRECTIONAL,
+				      DMA_ATTR_SKIP_CPU_SYNC);
+		if (ret) {
+			DRM_DEV_ERROR(dev->dev, "could not map sgtable: %d\n", ret);
+			goto error;
+		}
+
 		update_device_mem(dev->dev_private, obj->size);
 
 		/* For non-cached buffers, ensure the new pages are clean
@@ -233,6 +242,8 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	return msm_obj->pages;
 
 error:
+	if (!IS_ERR(msm_obj->sgt))
+		drm_prime_gem_destroy(obj, msm_obj->sgt);
 	msm_obj->sgt = NULL;
 
 	drm_gem_put_pages(obj, msm_obj->pages, false, false);
@@ -260,6 +271,11 @@ static void put_pages(struct drm_gem_object *obj)
 		if (msm_obj->flags & MSM_BO_WC)
 			sync_for_cpu(msm_obj);
 
+		dma_unmap_sgtable(drm_dev_dma_dev(obj->dev),
+				  msm_obj->sgt,
+				  DMA_BIDIRECTIONAL,
+				  DMA_ATTR_SKIP_CPU_SYNC);
+
 		sg_free_table(msm_obj->sgt);
 		kfree(msm_obj->sgt);
 		msm_obj->sgt = NULL;
-- 
2.56.0

