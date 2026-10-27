Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1370C60A260B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HK5iSCnj;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YwbTXi1J
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94F4E10E107;
	Tue, 27 Oct 2026 15:28:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 254C010F67B
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFL8dr2242307
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F8E1dlDc2+y
 oHmfS+23ajE4p5M5n5nd5e4IqvEnIe4M=; b=HK5iSCnjYs/osJBiit3eLBgQGCb
 bSYgEbMdb1ZcDoT7bMe3liYkksC/4MHRM9vuu0I4GizBulrQP1mb+MZeDz41AUPp
 1K2czSIHmcMf1slA5EHwZoywDBZI0QorMWH+QRy9/JIUrKXYvPyxSSlCuG4C+/s7
 l9YJ2Qx0AO0c4B1bKWdkbnozBofe6SNH1QdkCMscyUDumv8oRxQsH4V8zKzeNDxQ
 k9vF6cYeAb22u/KIOUhRTSE6K+d04qeO34OuR/C8Ot41acwEuzXyY4iPqlgIJDpw
 9UNsHsmlOCOe7YfzGoolIE8wwWqb8VKlaVbkoMx0WRsNn0nD+la2VRrrtbg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5sy9v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:33 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ab67ff8ec3so18020a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114912; x=1793719712;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F8E1dlDc2+yoHmfS+23ajE4p5M5n5nd5e4IqvEnIe4M=;
 b=YwbTXi1JuP7Lrl0hxFjtNYslGHua5VHjDr7LdpRSaj7NOqUTJadGP2cmNDEkknHgGY
 yRakFrwd43iIVjwbgQHNF5nZeWiMo8MNod5ICnwSS6rp6tYaB5LiQxrgMNmuRPIFijrt
 xN40BZe0G6R57BvkIsEbL3MY68MBHxZIGuELvcJNK480oI5UwgUtHWORoWs4ADBbcd7U
 fRqCRkXcxRnP8n+B9VAATk7OAlld38gSjOc2lQLcvt5uyH2Zx49Bg0F9DCWMPPCZoV6I
 DEpmkIzcnT8aGDYVC/W5qvpHDlxIIMbONLo7f39AC/Qm4lowVyd55iNjku9bz/yMLp10
 iCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114912; x=1793719712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F8E1dlDc2+yoHmfS+23ajE4p5M5n5nd5e4IqvEnIe4M=;
 b=AkulNp498HFX05Y+1mduwyzj8SL0ByUflC69zYCYITEo9xWAuJbSjWezKHmLanShWY
 TsJixS469OsvuJsd6Sf7NCeg8Xij+tJYVPuEvg4yMXlNUAvDvbIhjexKSZj+k3pqrCsD
 ws0bf4+eyYEVtV6H5hwIWlEkLZpRVa54zc4/qjrL8ezDYyVKOeHIcm8PN+SZUlBPcxWd
 voU1R1HAmDaYrphtZukd2teDIXEb1wiguCSwK0r7WKuNjcasxKofRebUc/DUZu8uJxoA
 arvHKn4K7si7zhxV21hd069g+/8+woNu72XkR7X/oM7Rbp83CO6j8AGk+glI2lhf832j
 dQ5w==
X-Gm-Message-State: AFq9FYIK3yP3F4lKNFiV+CyXMBcMbgDOdDwxqPbYS63G10FpiwfCjmX1
 5+Yh0lbWt5jjuG7QbVYauo5CBaKntH2uPTHujMUTw//JcD2Xqn5BsRKKQ7eyuvSm+VwREAU94C+
 LHM+spokIuw1z+XbLWb8TyNdZYXFyBCUjHSApTeapPUGPO++TvXGBZOsef5m5pOLtOx0G6YZ3ii
 BfrAU=
X-Gm-Gg: AYBFou3ZxAARtD2cIE0W45M/TFUEVMKFVlgnWgZrQGjiNecsTd1Sv3zG6eZZ27rrkIV
 HPBvelLvkRCJuXoCKeAzBy+5chc4J2sBzxycNIgSyt3TkcwEcl5L49/qNdfUjDJcjl2LIfKIEDx
 Cko02YnHXl0D8mn63FCPJjldnOlelKa7Fl0IqBKkaR4QFbyrRfdNvah/RBuGbToggUw6wrpDMGp
 gma9Qex126wK2e/3CQ/ovjBFg452vqpkg2+gb4LGerlBlgE1EWJIZ0qc5UDN2F7YN0nQdydOzC5
 Uyp0qe6rMBeJG8H5M5k09frVsqyuYVaz06+/nwdg2DPxLTJ04DRK9W6OdfcP2+51WdqYUT0cTnL
 6g1SSFfgcTPi/j1cK9sSby7oZ48wZgTnaJ4NjMWuaxiMrK8eMu3y3KUiOZ3GCS4wrp2w0WJcPBH
 eHtHFhQtyQ6r09yQVBRtju1RM=
X-Received: by 2002:a17:90b:58ef:b0:3ad:93b4:718f with SMTP id
 98e67ed59e1d1-3adeafcf07dmr9059551a91.65.1793114911937; 
 Tue, 27 Oct 2026 08:28:31 -0700 (PDT)
X-Received: by 2002:a17:90b:58ef:b0:3ad:93b4:718f with SMTP id
 98e67ed59e1d1-3adeafcf07dmr9059526a91.65.1793114911429; 
 Tue, 27 Oct 2026 08:28:31 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae4061578fsm4263987a91.6.2026.10.27.08.28.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:30 -0700 (PDT)
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
Subject: [PATCH v2 4/5] drm/msm: Convert iommu map/unmap to helpers
Date: Tue, 27 Oct 2026 08:28:18 -0700
Message-ID: <20261027152821.51144-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX/Bb9GtS2uO0b
 531X3+DMrW8nbQMmL7mMVBYO1fDFAIcmKvb/i0Jer6jzLePMUmLonCtwbAa4BM92uHkU+FP4Mvn
 BGuhMejRX1mdaWcCUxsF503wmyTevDo=
X-Proofpoint-ORIG-GUID: UE0F1Q-nt_XnIqUykNMrFd4ZCSY-GCZK
X-Proofpoint-GUID: UE0F1Q-nt_XnIqUykNMrFd4ZCSY-GCZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX2ynApIWetlvi
 ButBut0S2wCdJi2q+ixwy4qq1SXDIQ/EgcdYo7WXIN9foQIih2WGHhAFGqK2kZsDV6UHg9sAt7Z
 7DpxjXYdVOqo9Nbt7zC5qSGEEx+K4FCVrhu0NcgVZAll1lDGbGZnU3OFWxPSZAoacVzztl5iwsN
 9XPXsmTa5WB7XxU0nX/KSkQmN+TvEN19XV5JNEBIFkyQp01LLEcwLCMBy/8psJW3jPB1Z47Rm3N
 36L6QsiqPhIXKpm7dc1etxaFoQEuZT7gbD9rWzotoQEFLHcjEbXYqb75pBYhl3WoEvGU/a8qWtq
 c4GgODpclKHaS0HloNAh5ywapa4T4Reb0tqLdYyagJfmoGG0+VACIxjqDy6LkdaFhJOhKpV0UCj
 Obrlgu7y6dYSkfHtD9IlDGkNWGiplnf1MjoAb8KvNVezxeiob+ae6N5GnxY9l2QsiE1yL80/PnY
 BEtyBL0m3fKpFHb/CcQ==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0c321 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=3T_YcleVrN8O_gWOTnoA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
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

Re-use the previously introduced map/unmap helpers in the iommu path
(TTBR1 for GPU, ie. kernel managed buffers, and display/etc).

The callbacks work in terms of iommu_domain/ops instead of io_pgtable.
It would be kinda nice to just deal with io_pgtable, but the tlb ops
that arm-smmu uses for it's own io_pgtable require doing runpm, which
we wouldn't otherwise be able to do.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 35 +++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 78c82f4a01b9..435736c8d715 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -731,12 +731,27 @@ static void msm_iommu_detach(struct msm_mmu *mmu)
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
 
@@ -744,23 +759,23 @@ static int msm_iommu_map(struct msm_mmu *mmu, uint64_t iova,
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
+	int ret;
 
 	if (iova & BIT_ULL(48))
 		iova |= GENMASK_ULL(63, 49);
 
-	iommu_unmap(iommu->domain, iova, len);
+	ret = __do_unmap(domain->pgsize_bitmap, iova, len, domain, __unmap_iommu);
 
-	return 0;
+	iommu_flush_iotlb_all(domain);
+
+	return ret;
 }
 
 static void msm_iommu_destroy(struct msm_mmu *mmu)
-- 
2.56.0

