Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2AA606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XTEWEyXz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NNuiIJli
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADDF10E5BA;
	Fri, 30 Oct 2026 21:33:30 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93F98112A0D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:04 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAV381222876
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=vX8c2uJChbI
 30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=; b=XTEWEyXzn7z0NWjfkjmNM5imB1P
 YgItPuSTcDuZvj0+k4zuMo6UyHmwLZoTdMW7xyUCI8ZJy/1WJeS7/fgiwj7TLIzM
 /A1dpi79Uq5PtjlketpkF6c9tJYc1cmQT3aZ8HMXk8Pjjktn+YKujcP8Hhj7zX6/
 QoTO0ntHnyDuLhmuzN6R38sOP4mUwjxfn28U/EVJwDpywRbMrY6OIqeUmCt6ZJGn
 vNuRwQU+O+xXqw+Uv3mib/IHzgIUxY8asxYu6kXW0BVS4/myj0KhvKtdP/oqY2n2
 kB6m/pgvd4c3VJsL8uyDlWK8foXbntids+d5bDcbnJSbi1um4/+yli84mnQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x08260-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:03 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3abb4c24125so991545a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395983; x=1794000783;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vX8c2uJChbI30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=;
 b=NNuiIJlivBTlTYLteQerq6AMGWCTtLFKBcwoEmRT0F9hQPmaPYvxan61jmXYBdtrtt
 lbFtlKbbaeSq00yuzUtPiIxWl2qe8B9pTTAa97duRSe3+cr2UpAVzUzD1fpl3HJuIlDw
 wTp5Ody/0wzigFZHcBl39jAL9NhUNWjYZqwxifnn1urkUEVyxYYHPfFlprXx18KroVUo
 +eJboCbcpj4BK+b6jQxilbKLskWVwRrPap2Txy7xNjORmXEYmGLMGidwpSNvjWjqFOH7
 LLPPqweQkjd4EpgTaQeA6Ppoli+On1yBFx+OoCy7tpKrpji5eAjjnHsgUc/mtUEzf4uJ
 vlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395983; x=1794000783;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vX8c2uJChbI30GlGQJ9D3SlnpZahwcNedt7ptpVKARc=;
 b=tqqnAPVzhQ/z0+kUY2RzXnhA3wgXYu9OoY2JTWtGD/89nwwnI1+ioD0BXh9H7p2nEJ
 oVs46WANRCVBvSFubpcsRJnWmt9QSZVXz7ZeT95MP76Kda2xiyL3Lq/8FRnM07i/qoKD
 VIy5fbAQD2v/ocClu1UO0qWM3Kl6bsk3KPMTkw+dYJlx+E4ekVFzDGdbGdhjUCoNAGsc
 bRD39zx0qVzTSj4UILBaChoYqnCkP46bJ6vxc5Cj06lth10pelbStT1fJZQ0KEzvV8qX
 /pLRs+RyTBD2/4GKtA6t3T4l9b1Jh/jgh/HjvigDrhEKTHWh+DVwg7WAzb+Wq7GOvZOp
 CAWg==
X-Gm-Message-State: AFq9FYJS2ubZ6Wyb1YFNUOMojfnsTXnRYFz5A/arYIx6ThdGaqz2S3QJ
 RCRi55TZcNP/Oxz1I6/FSM84LqITOJxRKT3qVJCl+78tOxX27d7lQljDoVQKvdNSJTYcvV9nIrE
 QjOJJOIhExyCXkjI1WFjz0loMeKd644PGEI1Foj8arHYJOCPqZQs1O7c3cGPDT43gYyiTnejhHO
 AuFrs70Q==
X-Gm-Gg: AYBFou3QJFugXeF6+XoP7vt4jU8Ob/qECKW6miCtNpyaxasjWorbFeOsORWDMCHo1Ru
 6sYEbf2sKrUFeHzCEBgqb2RcM1EcBh7pAzp+svb0mDUlRxEEf1/8MGWiNweJIbIybWuRy0WnYNL
 guFp6AU17UovLzgJyNOwR0mUSi41t165nb6BVhcuT/ZaSUbjuUROvX/Xe/EOrc0DoW3gyrDhKCj
 A/8gNWBdvU0gr1Ch18bnNeqByI1WNVnpG6ZOCG9dKNzyh7CS6FWVVPBC1FeBfMFF5qnul41zyGv
 HFuyXoSXKVwObiHvhM5I3twh5aKLcZ3G6qN4R0qeU5JY/n4UTqGrIEQ3k7ApbJtut7+hwk7dRqE
 kuxBKFAlWn9XTX1tLqg7VbUmiktriYqBQezoaZti6eXe7AynYzUxrXqvZCRHnMCidhR6QyM5aR5
 5et+eQk8UCbwzBMR/OUHwIpg==
X-Received: by 2002:a17:90b:1f8f:b0:3a4:ba6b:cc24 with SMTP id
 98e67ed59e1d1-3ae89820cc1mr2657939a91.58.1793395983366; 
 Fri, 30 Oct 2026 14:33:03 -0700 (PDT)
X-Received: by 2002:a17:90b:1f8f:b0:3a4:ba6b:cc24 with SMTP id
 98e67ed59e1d1-3ae89820cc1mr2657914a91.58.1793395982953; 
 Fri, 30 Oct 2026 14:33:02 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9583c1sm10544978a91.10.2026.10.30.14.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:33:02 -0700 (PDT)
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
Subject: [PATCH v4 5/6] drm/msm: Convert map helper to use dma-address
Date: Fri, 30 Oct 2026 14:32:47 -0700
Message-ID: <20261030213251.55365-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX5gtEwd9aTYeg
 0j+OTZa6BkE4QHmIh7+iOcgjbGC4oEGcK2/k+C5/fPJGZ2qxQzaSPz9kezrbhy4xNPT+MHtqOR6
 WZZNDhfTQlA7/UDVT2KyXNtNAAWtNVc=
X-Authority-Analysis: v=2.4 cv=d4xgWhjE c=1 sm=1 tr=0 ts=6ae50d10 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=I_bc3XnsTyL_mMZFCHAA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX/NZ4M3NDiiiz
 SJhTlwPHLiYplvfpMmUCLXenZkMRtb6VeLRwpuE4uA0U5R494VOr5pU1iuyDMK2svM9Jly21xJt
 y4nRPQfoQyz/GfyLxv10j0liqlv6CzgIGOr7SBXX1bBlnNOaHfYd2LFvpq4+aZ826ZhPMZdnOxN
 u0nzGg2W7OrlK3Q8XQ9RypmWubfqblkwIbraXQO3LWzFi3FEIhsCn3FOrlupCZx+SccigpbPzW/
 Pwu2I4uKZeZvAtFPYvB2PTtuXK1hCZvP9X6XdF+ktIePe44AycNJohzj5+hF5k/apTH12Uia12t
 R2p3GD9nr8JzQQDeqxhahXBtfmJ7fmRZhCZ6dBHFv0++0BzJzXIrz9gWT5a2Kad+TiNFEoBhdiY
 Y8wijTsxD6l5McB4ptF7KTc8PCbR5HFLa7GnlduYHgj8trlrfioAo+CBBskP8D8Tx1FEAZlDpzJ
 kH3EcZpU4OJuehE/ISA==
X-Proofpoint-ORIG-GUID: h4SfCoKIljH_os_v29ljUUMn3Sz1MO84
X-Proofpoint-GUID: h4SfCoKIljH_os_v29ljUUMn3Sz1MO84
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
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

Now that we have everything unified in one path, switch over to using
dma addresses for setting up the mapping.  This avoids issues with
CONFIG_DMABUF_DEBUG stripping the pages from the sgt.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_iommu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 479e5450a4dc..c2950d32c507 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -153,9 +153,9 @@ __do_map(unsigned long pgsize_bitmap, u64 iova, struct sg_table *sgt, size_t off
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
2.56.0

