Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B46FDCA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2364310E039;
	Tue,  6 Oct 2026 13:10:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fvd4TQyI";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dMGwKOXx";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7940210E3AF
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:19 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPE1g680829
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=J3ubeOOHnY3
 FSH96zXZQAtmRz0b+NtvvnMh1Zyox5v0=; b=Fvd4TQyIOALjD/cxQI8hsCgbAd0
 n97DE+5MN+e36WfXVL9nnExmFyDuvhW8D7rg6EpbEwUHBHfPX1ZwHLLtn5iv3EYx
 xbsnSDaLGGUR5W0EV9C8DRb7ZN5mTW5i3fnC6NtYMudmJ2WyHqY60/zqql3muKDj
 K3NU5Kt9n7h2wTb5Pe2UHtus1zkhXQwJv0wzarQzsNe536BZ+GhzFlJh72FjNI8F
 0A/Hq8wSZn4133IIsRG8QAkcNFGVhTnchTCXPcOfsUjUTd8EFPw1rcvQExtVwtQR
 7lPjEGlo55aTGGyCr6/2ueSAMXCkfRPxl5V6U6OFYBJXBrpnydkJmPJz1Ug==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4xc9rpw7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:18 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2d001671a54so32762265ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292218; x=1791897018;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=J3ubeOOHnY3FSH96zXZQAtmRz0b+NtvvnMh1Zyox5v0=;
 b=dMGwKOXxcFqhS7z4jYVDM8BzCgxDfZljdIejzbTQL5sf6cyUXCkzc77vC77dtCnR+5
 008s0xL2h1Dnbv0H88m+MO9ihsb56sCrUCA4thzTRKLuHGcupixrVdR5U0SDkEUs3Z/f
 HkEFabcYhdj/y8eCpIZcfGQOwMsNV7dnH7x7LWOjwdCkGfUYYppB+yeQ4N1iNOUwv5To
 gQloQSaMDQEYwggQlmmDgAl+0DYqVHiFLu/+peprvCibgTAmiCH5AFmTSEtiwwVujUIT
 VW5PzLPp+30gFisbCWh+TqfTP0Ip8vBu1e3Zaje4DiAyMjTAJlR8W/bKXhd4iYc3z8oI
 LjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292218; x=1791897018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=J3ubeOOHnY3FSH96zXZQAtmRz0b+NtvvnMh1Zyox5v0=;
 b=1bDmgKbhBqcfQe5ZvXog04YEl59nCL+DdxWMk7bBSuZ9kqm/dtujlSwTjTP0LvuWlW
 WvYHrbZYRfoYNww+neV9o88WoBM3bhjuadwDFcewjpyUmkQ0NO0RFHbrdd/yxYRJsUst
 ocHWfvaJLFgw9VPrRMLNKAHC62UEXVS5Zei8sJnUG7cQSNqty9mvxfJWsj0tZDwxtnTJ
 p8hZYvmrRTRUGoW+DGmiOpy1CcSlhxV/WOwNujb0+VrxgK9zKVksGFOzL0c76mKTbX1i
 rRhMDYV5T0T+dDsgNw6x0fxZ2Jno9oTh8lCS0c56vT6IQFSqz0ovl30seSERjFn1t1fr
 oGTg==
X-Gm-Message-State: AFuF++kyZY0XHs5usRk4DtZqKlbWz7i92SeIKBZ5FLKBda7/r8OJdthP
 9PTpLYOmtj8t48KmvQxJmBL6NwLxKqWFuUEwgVkVuyZmod/3hgAd4Goh6E0Pe06ZqpeTybAO3Hw
 ycocSEP8R0ERBDBjfq9avbnYXJev8CrkiMg9RFs8uMzHecW6KrZp4mrzUhLc41WjxVGDFt2AcU4
 lFIcg=
X-Gm-Gg: AYBFou3iVbIax2ajuM+4IgPlJfAHtXYXC/7EHEnmc5dCYSQbXp8tkGqy2uwtz9xnyl1
 OpmYMKEABqQ8DvKGxulRZi/635Opx3mN7eUMcuYfRIX9315QPdWjywxeojGxs3QGTKVT583VOxl
 WKSWS+H6Phy1iqehQBcFAmPhgAfGrWNhiXOjXcllpObNn9o8zLDztlIew1Nxaj3wPDNWr2uY0aG
 N7nu8D1ogtDtenR+I2274c3p0qbamwzzlLtkKKxmTUzIjXWmd9QrmU20LJsgJ4drnv0u4Q3/guV
 /xSbgY5K2+5/ZFpFLN1GpfXefiSzPC04iSCvtYOfH+aWOWuadGxrG1HCPB/GSlua0YNX3dywYOx
 lYor4mXatHtD0cmOL/DG+FCMA85NhMLXptnh9mFUXTe7Ctw==
X-Received: by 2002:a17:903:17cb:b0:2df:5836:d1d0 with SMTP id
 d9443c01a7336-2e5dcda09dbmr11501015ad.30.1791292217421; 
 Tue, 06 Oct 2026 06:10:17 -0700 (PDT)
X-Received: by 2002:a17:903:17cb:b0:2df:5836:d1d0 with SMTP id
 d9443c01a7336-2e5dcda09dbmr11500705ad.30.1791292216891; 
 Tue, 06 Oct 2026 06:10:16 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e5a5edee06sm22115255ad.59.2026.10.06.06.10.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:16 -0700 (PDT)
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
Subject: [RFT 5/5] drm/msm: Convert map helper to use dma-address
Date: Tue,  6 Oct 2026 06:09:56 -0700
Message-ID: <20261006131000.81501-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ctMOAF4i c=1 sm=1 tr=0 ts=6ac4f33a cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=B-XXGUA0wr0Z4rGOYBEA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX9UUBI2b/crbk
 B9XQoBivjv6fxZVjrb9UWtX3n+Z0dferYF8jHBcgjxwwlvYlJOWmVDpcUzL/yz84vrBp/QJSgI+
 ckhQzNgml3oTppsgctTG6O1yVN/qyIg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXyEUFlHiR9ZqA
 +D2Po5i3qnexHzMDXDmZouy9x2a07xAAzWFw+LkurJCCuC7c/DOtOrTr8B1EkYYYg3xQZNvUq2A
 Oe9U/QflVce7BP29/3S0CHoykNcUu3IUNIAj4rJiYM65LxvydNLpg+yt49PD/R0/G4GSTuBpnJw
 vVLuFV6VKQ4DWq0+rfSrTx5UGsI5n+XEa6AiMgxL2pQUvoVncANYl5EwkhLz/wbvtPr2RffwQB5
 qSJNtOTZyYaYRlOMx3EWdBUDN8RgICuHKvcyF2PP1+8v9peJOhwi35Be1Wv52JqwKis0TBRVP2r
 s+bo3+WH4XKTNwAAupdPwgo5ZDx3CbGgoO2uPboTCExdMaz0SoaDbXRpuZg6MeO3wdYUAZzCNEf
 38puOfaGtncoS6u4EctboLOtX/2o7ZSIQkMO0pwZlR0ywG1bFxV7ZiOlqBDx2DLtZcXchUVOECg
 xMZa3Fxmey1zbFVWWkQ==
X-Proofpoint-ORIG-GUID: dM_Ewsprl0nxXF67JYvveKOH4T7PXlcY
X-Proofpoint-GUID: dM_Ewsprl0nxXF67JYvveKOH4T7PXlcY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052
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

Now that we have everything unified in one path, switch over to using
dma addresses for setting up the mapping.  This avoids issues with
CONFIG_DMABUF_DEBUG stripping the pages from the sgt.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 50038d00c3a8..27a74514e942 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -148,9 +148,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
 	u64 addr = iova;
 	unsigned int i;
 
-	for_each_sgtable_sg (sgt, sg, i) {
-		size_t size = sg->length;
-		phys_addr_t phys = sg_phys(sg);
+	for_each_sgtable_dma_sg (sgt, sg, i) {
+		size_t size = sg_dma_len(sg);
+		phys_addr_t phys = sg_dma_address(sg);
 
 		if (!len)
 			break;
-- 
2.55.0

