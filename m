Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A39E2CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 15:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF92D10F8E4;
	Fri,  2 Oct 2026 15:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DOdNgT16";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kdEADmtx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FF710F8E0
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 15:29:57 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692FHCE21246872
 for <dri-devel@lists.freedesktop.org>; Fri, 2 Oct 2026 15:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FSpAX2ci4IyuylsIuoBJyMoBurc4WTIiQmLhuNQA+dk=; b=DOdNgT16KAspGaPK
 i6EStB1B272SWArCMwjFVYkSnj8Qt8eFpxPtYEDPsCG2oeiDR+8ozC0IL+rRSYL2
 FK2q9KVhK7Vou++t/TTiXeSG4POSX0vwrz3uIdSpseXlZ8HIs3Nm5oyReg3LR0E/
 xOO5XLcs0KVgPsl/7/0As2rFBmssR5P5pcVkyhEOl8DU9chCf6WlDgrwH1qvAC0h
 Wx7eu6m7CvxnAKuZEUq+SZjQpL1Jy62L6MnlMBV5XM0RUT4UObQONkrnIp1Qyojp
 0D+NymiLYK7cAQmxgNMTVECsNZZKzXSU4behxLp7Xs2ClYNiK9IFUf37REzauLah
 iQxqPQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3d81s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 15:29:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-398dc3d8f0fso47310a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 08:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790954996; x=1791559796;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FSpAX2ci4IyuylsIuoBJyMoBurc4WTIiQmLhuNQA+dk=;
 b=kdEADmtxRz0AQjEaQTGauPuh9QrOUWYg6ytN79hReKcB8nEQQmVG5GHPQexsHzWJs1
 wRRKa2oCbzyXvFaZGNytoqEQlf5eehpHIjSOFbHpYgwXW4+NNYnHl1TcrtIqeGPSchF6
 vULgFJo2ieaaBoTBGeIqv7EDV8FrliFw0GCRUwEFK4Dd8TMQXA0eyRP7F4NVWjxkAR+k
 EieHzZL217L6beCYbKCSRKxS69R0sQviDUCPEOYCtFr/DpESiP4D32MIAPJBY2lezTOr
 GVRJEHSEwvJYWm9g8rcg+NchPZhJ3AiOQEYAN6r0ElASQFdchAy0QvYhU90RHx65KHXc
 Kdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790954996; x=1791559796;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FSpAX2ci4IyuylsIuoBJyMoBurc4WTIiQmLhuNQA+dk=;
 b=CE8wgo2P1T0OY5g2QmE/JaWNyR3JhByJ4yMIPDRYZblvXKfh1LnFFkTAG+ZwS7yBwy
 4s4mMpyZhaduvqmLdrwjIkJXP6QjBHmDogGgN3PXR8r5skFYYStSki2zFSwet3SfaN4z
 9I544+8opHSzHJvWWJE0UBpkGJ+FKZWsD4kcnUUKf+Jla2uCTTu/vEsZS33aXQhmni9a
 2cgGb1runiAL1BXcEwv39CbJJN/jYmO6+gkLXQynpIRDSXL+yi0LFAIKcBKyuhdIcLlA
 0wThjsJcsKwrupMNMALVxjSbPXi2bFrIZlJ38lMZ6jns3H7aatnxUfzLR1bM/zoWFIpD
 KXkQ==
X-Gm-Message-State: AFq9FYLrkLODCCqK9dstfJMKmvkBwMBcAbLFH2JPm5FSMm6XXlmqFRk1
 6B7Jm2E2pwgmxUwJBrKpshCdUnrwYocqpbM+jIY1fA+gMLj1Tj2vGciM4THp99KFKxivMsmFpPk
 Y5Ao3g6KjACnux2tmrTI0dHmqchdv5eZleerE8FsWx4Ay7EsCdVh6dKPWOI86BL01WJeSgWzb5I
 cMgg4=
X-Gm-Gg: AYBFou3e+9kujcABhdHPSww7pZGDAOU0+4eqO7CDQMl5rDU2SJ9CYRuHbVDRM0pbsLV
 Y0tnE0ibqQc2zc4LqMCsVUkEfbSBuP5HIEG4i1NSXgNyNt0+YMRXpkHLx9PzXav7unwY9ZJEj8N
 O4U4FEwG0H890l7lawaEbgL8MQXaXPw0Uf4/duvpiF9ZfXpUXol5jDrysVmWbdObL0LOPX+oTW7
 KEVVp57gmzll4DrsbYLL228pqfef7LmKJyhi2/tBvPC3X+RYqvLk9IsPUXRRW8Vy1UyCAANW6Qj
 RmhzuEOtVfFCnbgOmHiJrBlqYC5qVcXgZ0Vk1Gls5pMn1SQYBtufHlDdb4++5GuC9Ga3FQWfz7S
 VCU84DAMUk+Lvpx4NOtX1e7o3gxliJR8wFipLm24fwFJ7DQs=
X-Received: by 2002:a17:90b:5706:b0:3a0:f4ee:d2b2 with SMTP id
 98e67ed59e1d1-3a6cec2ff75mr2095707a91.32.1790954996064; 
 Fri, 02 Oct 2026 08:29:56 -0700 (PDT)
X-Received: by 2002:a17:90b:5706:b0:3a0:f4ee:d2b2 with SMTP id
 98e67ed59e1d1-3a6cec2ff75mr2095696a91.32.1790954995609; 
 Fri, 02 Oct 2026 08:29:55 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a6cd5ddb51sm4390972a91.14.2026.10.02.08.29.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 08:29:54 -0700 (PDT)
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
 Sumit Semwal <sumit.semwal@linaro.org>,
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH v2 2/6] drm/msm/gem: Mmap imported dma-bufs via the exporter
Date: Fri,  2 Oct 2026 08:29:39 -0700
Message-ID: <20261002152948.85308-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
References: <20261002152948.85308-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fjVnMRXqHalGEugMjAgz6-h2qNGq999a
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXze8vQ1qKRI4d
 kVFphY0Bh2zt9P6760aykP3x973H5l+frHoEU4338vL2kZU4CSt0byMpIGW5BrLQZNsvUx6IwcM
 4tk37ONlfkBSCei9sb/WsjJq//r7Fw8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA2MSBTYWx0ZWRfXz6BjEH4gvGlF
 iO9epW6Wrmb6qYJRXrZa0F389SeVom5nUEzxa8TZ07yAMV6RKl56KXgZrawugwhayg1jgfcO6HN
 yp36HVy+Qapf58hvB33KYS4frFfBH4FMl5ondLWep9r3K3sgnBoZ+Qby/Kx7bkEsSzQMi9jGTYV
 S8RT0jYGVQtAFA8SnUq+pYtGumrhN+koDCOpW7vU78xb/K4Ql7RyExR8bKYpaqfyh9GkGXHJQck
 nsgGYd1xRmnuvqstA8GlSrNnPRPJZ3k9xr9VPwnbHZJwZ10ufDz1TB6JRGoxVqPClUCrtMyDky9
 +TtE2Cukhpu5UyVanuRLNEnayetBWxei/a00PWKn3DckbbaOByUtcZYnuS6/Kd22vldVaqa48zj
 3/4cNrssBRL1ghEfkGu1MxcgBEPbTJbSALzxcGG2cLESfPRLrZ0JmukH8t9g9V8vmwKCQGJ1SDJ
 9ezRWJIkSErVKp5zSbg==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6abfcdf4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=zd2uoN0lAAAA:8 a=plbGacqYsnyxf3yiAH4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: fjVnMRXqHalGEugMjAgz6-h2qNGq999a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020061
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

This was always the way it was supposed to work, and when we drop the
page array for imported dma-bufs our fault handling path will no longer
work.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index e8390ebd5dd5..c90336b3b231 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -23,6 +23,8 @@
 #include "msm_gpu.h"
 #include "msm_kms.h"
 
+MODULE_IMPORT_NS("DMA_BUF");
+
 static void update_device_mem(struct msm_drm_private *priv, ssize_t size)
 {
 	uint64_t total_mem = atomic64_add_return(size, &priv->total_mem);
@@ -338,6 +340,9 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	int err;
 	vm_fault_t ret;
 
+	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
+		return VM_FAULT_SIGBUS;
+
 	/*
 	 * vm_ops.open/drm_gem_mmap_obj and close get and put
 	 * a reference on obj. So, we dont need to hold one here.
@@ -1126,6 +1131,25 @@ static int msm_gem_object_mmap(struct drm_gem_object *obj, struct vm_area_struct
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
+	if (drm_gem_is_imported(obj)) {
+		int ret;
+
+		/* Reset both vm_ops and vm_private_data, so we don't end up with
+		 * vm_ops pointing to our implementation if the dma-buf backend
+		 * doesn't set those fields.
+		 */
+		vma->vm_private_data = NULL;
+		vma->vm_ops = NULL;
+
+		ret = dma_buf_mmap(obj->dma_buf, vma, 0);
+
+		/* Drop the reference drm_gem_mmap_obj() acquired.*/
+		if (!ret)
+			drm_gem_object_put(obj);
+
+		return ret;
+	}
+
 	vm_flags_set(vma, VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
 	vma->vm_page_prot = msm_gem_pgprot(msm_obj, vma_get_page_prot(vma));
 
-- 
2.55.0

