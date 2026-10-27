Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D695F606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Qge6OcY8;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JglSwJ0b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2173810F669;
	Tue, 27 Oct 2026 15:28:59 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F6C10F67D
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:35 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFL0AR2549092
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=rWJwiQL2/XF
 Lm3h5+bxetGJ+ZPFcBnTK0gADMZ2ejbs=; b=Qge6OcY8n9kSqehNikiFwmdi56Z
 BWEWL4C6y+D9bNAmQiufjrIZs+IxdGHISmUjApkeOKONT6UEJusp8TaiidQ711aG
 A5Gpqf7YerUThimUk8VVtNHrPpBKWw6z7x7SBgaCLG9zL0FoZVsBj+SoX4Bsi1rX
 n+lmxLznfKlrXYDXW2sxBO2yssxwjO6KqR2zSQz0ovJ/2VrVEVRK4+m2O9CzTLqM
 U4ym0v8iUi/mjOtqgDoN1MVV01Sd+aGRLlDwYwQvaQmb33iHUl5XA2qVs2jdDrRk
 rlaLe8/I6rzkI7vEnXzUEFaV7ZMEL3O/gSFWe5+HRBgrButVrtWi+4t4KnA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjrq69mme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:34 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cd60e4e8bc3so37706a12.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114913; x=1793719713;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rWJwiQL2/XFLm3h5+bxetGJ+ZPFcBnTK0gADMZ2ejbs=;
 b=JglSwJ0br7YiFd3dKSJGOtO1QcBbh/CxAN2EQXxXh3SRPTRN2yUV+LTjwpnT6B1C28
 w29WsqDIcyLJHX0sUN0lV3Xw2NetBbVhzPLN9ApKRT2EEI4UVcoLgf3ocLyXKKnP4Guo
 AQf/r4yX2BIpeQ7R7PnW1vgIg8k/JLUnMjGm1IR/bLla3Bl7wQ/Zaf/HaBpyVhQTVU1+
 kR+sUZJp9ti9NgYE7eTOzsP7LYTt9tQ+AsMAbcEo7qR8kN945eyyp1XVx5shvWyhoHkE
 IJKreyaIncB6Jm47eYpb90hUlAUkB3VH6Zef+KBqQ/w1YpC1cFo4B4+SNYu43KXcAEcs
 xyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114913; x=1793719713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rWJwiQL2/XFLm3h5+bxetGJ+ZPFcBnTK0gADMZ2ejbs=;
 b=OgKz89+BlaBqt0m/b+Q8awL4boB3GqDX8vNgz/dIiAGrlN1UYXJ45N2kG64Jktziuc
 2z+G1MaBEfELPQqNGYAfD7C3r0N0sUFVqdbwDdEj0wgfOuCKCi2L4IilslZvhaiIpYNm
 C7HwKzb1XglE8keWlfzvl77YK32nb4D3YRQ66Qyq6HydEkyAyUJOJMt8tX7kIs0SCVo8
 0WBKoBCC3XzC9TMbveaMq2Tt0LkVoYsU0A+hH8x/GUd+GzjYoB4Xo93HeaFSarAkIe08
 mG7fCpEU5EmOz40EO+b+JjlSBiOel07uSvsHk5DHtYiYHotJjoSTmwavS6Mq5UTd2s2q
 5pUw==
X-Gm-Message-State: AFq9FYIhYmD0tiw6uSoCBYOvOhlGSLVrcvoyVUhIcFbFaqv9zC9kE+N/
 0ZRsLLznsruwb20Rk8uhkOWf0Jn1my2XcgDs+OIkQmETWZxmfz+RC/iHGPY92vGB4WsyQ2YbmuT
 +3mu5gYC4/wxuLSAKaysDxI88JsLAoi2J92XKXDsIMGCMXkcair7lN4yUJnzbQWxCxX2mX7VHPB
 D975s=
X-Gm-Gg: AYBFou1o6Ic1JRjfiUz3fYsuhjcoVkhkIhfGzAJyyxBGuXbvucTZUnpHfeO1BN1uSl/
 kXrxprC/JiMApqW28LduMiX25w9gh1JZgfDxSvATd2lfRkbexBiPuQJpraCIim+gt+DxV5xftWj
 QxA0Y1yCVcbOZPIu+RyAVx+s0ADqCqmFCc+o/2ee+4FMSZgLBnkAe06oxH7/7SkRIjGo0IrJYe3
 yPJXF4zZVIP4z+6F4NoKKAm8gkqz9ATB8lloYpsfgJhsuaDMORBVK09WFGMH8BsXP/zRqzcrVBj
 h0ZgpuaQKvK36/B+/mdCqVOjtwLHdSIETguAh5LR8fYzt46rk6WIeINarRImNNT50ReFi6PACTt
 3pF8wBv8vaPseF+ZjDN4Ds1cc2/Eii05gKwn+gzzCNCMwVLSVZM9jjgMQFPxufZqSwh0NCKnlue
 qQ3IYz/i5n4fvTzTHo4byhThw=
X-Received: by 2002:a17:90b:224d:b0:3ac:a1c7:20fd with SMTP id
 98e67ed59e1d1-3ade9b30a3emr8433513a91.4.1793114913266; 
 Tue, 27 Oct 2026 08:28:33 -0700 (PDT)
X-Received: by 2002:a17:90b:224d:b0:3ac:a1c7:20fd with SMTP id
 98e67ed59e1d1-3ade9b30a3emr8433490a91.4.1793114912711; 
 Tue, 27 Oct 2026 08:28:32 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae4064f4bdsm4256128a91.11.2026.10.27.08.28.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:32 -0700 (PDT)
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
Subject: [PATCH v2 5/5] drm/msm: Convert map helper to use dma-address
Date: Tue, 27 Oct 2026 08:28:19 -0700
Message-ID: <20261027152821.51144-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RYwFmFtv c=1 sm=1 tr=0 ts=6ae0c322 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=I_bc3XnsTyL_mMZFCHAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: t678lnm237RCgWokaGQGtEKc1w6CB8ft
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX0WVH9hx61XFj
 iUbgffPtXek1/bMni8ZCG4v1L9uPj+R1LxZxwZQxQp8EupkqA7/bchACugL/0j73zff5TjkxZ+b
 eOXloreXKlbuYisVAEZGIUAgrKNGDyQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX/jq4a2m8pZtw
 nXig160ffgVywjJU9Bp+Ee47mEDmYoyuiy+wIN8ddl+riD0LL1Hk0QMOw8F4DDnFEe4HKLnppE0
 BNzA/nOMvUR7MWaZeQ8UdBFZ75/C+uEUDQWRxTT7BU7/GnUjVbdEUOdzh6xVtznw/ODtFwdWjKd
 ABTZLoalWZdIOtwL0BHSW00Vmp7EgXTVzIYuoQEq4nbmdi7f5uZgzCkm+4I4curU3q5+5KdJOTA
 nx3RuV5kNSmcWDMNMOqMRbdNDrqlvabWyMIEt8wGwvHy2M335V9sskSMVoJ1AqyvJO02pdhQhRV
 zYRgZ5pc2LDtZRDd0FzmBZR1SSpNLUxfcy6TSS750PfRTNqEqWyELnO2dscyQ72Xg0aJfiv0AFT
 0LjTWJUVLAJj9QnkxJ9L1PF9Zgwx9nuin/9IzZxqqhcHEqxJ0l71PyLbRk2rtNNLcJCRzsjxb0J
 jTvS0BGfiicODxt/lPg==
X-Proofpoint-ORIG-GUID: t678lnm237RCgWokaGQGtEKc1w6CB8ft
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270061
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
index 435736c8d715..6258c942e66a 100644
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
2.56.0

