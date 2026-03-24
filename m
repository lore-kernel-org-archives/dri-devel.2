Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0778FEC11B
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 22:05:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6265E10E66F;
	Tue, 24 Mar 2026 22:05:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BWQZXGVR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KCXc4718";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DD4E10E66F
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:30 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCxrM2340490
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hXs1ilEphqy
 uUJvSiSscnyD6ZgL5ByYr+YWWml4pGG8=; b=BWQZXGVRXF1yKOdkm3mktusTWAJ
 PKmrGhLoRX++t0nau4hYbyhyD1Cw1ntnl7VXuVqvhkQZLD3f2LRMA4ISFP0CTZUj
 xQPX1EIsOeu2uY8jUoTdOPrqOg+z0lWy/YtpW59g2Od09oFjADtMN/1MloOo8vK/
 UQDaWMw3PueUpAAiayMUfSw8dT1eAdz2JqW/T4+TZtmxAW3SjRMhQcz8i9zlBdO9
 cBtSSAZbq5yowX1d8o2dtYT4eKcE7p1BjmKs2Lily/vIJHUa57k3p+V5EDg3mzS+
 Q4Sot5oLNTkjZU12M/fVxM04bld8w47vgTQwnoGAY8SL07c33em7nDYu8AQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3sw42d71-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 22:05:29 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82c613194caso918100b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 15:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774389928; x=1774994728;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXs1ilEphqyuUJvSiSscnyD6ZgL5ByYr+YWWml4pGG8=;
 b=KCXc4718wlJTgoMYIlyHs9NETjOCYj7/VNlCPMXbzpSmvOj78FC6nglPrwyYK3x4j0
 It/5/YVSvQwyHmIq40cF23fPt8C0oIfMv0z6vVq0XKZtiL3a/UfSNCjqgY2M8HbrK7V6
 ba51Qd3FP9bkgVE3r7oqgz6AEuT+CQtQ1e0b+BTIJdh5D+dQIOCNY/478uHyFHk/sa30
 WHYzG9kYVzpxSgdPC0Ti8MS/b2IqgMa/hHeYIlx2xhTHnfD2B1J4DQJpCpnRZ3hQCdVd
 mJEFfY10wM6+RFEFH/rMET9qe6dTHj+92r4vNx7khL9e0IBLzGAbr2Z8lzTBxwlfieId
 CdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774389928; x=1774994728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXs1ilEphqyuUJvSiSscnyD6ZgL5ByYr+YWWml4pGG8=;
 b=BkqBb0IERctpqny1JlxyU0MnVTg53U8G3NK0Vz3Na03fxKIxVs1xxpoOndC2D4O1zd
 TI1rKxk9CO4k55dOmk4pIsULcYrtk2csQYq7uVGGj6EhAwC1f+7Ifc0xOnkdp4utk+ui
 7W9ueO3ADj+CjTcMgnKzC6WPPTk6ee9SoBbZylxtMgH9HX8A+fJA9G25V2BIt62odZoO
 bPU8XeP/QS4kqh7TXn9YBvsdqrWHlv1/WhyRq6CzZnytm6j/dOELJuxzuLUIq8AJZXM4
 Ssxg9/ikdEoRa/Bu+HmtjnchbVcbKAV06gIIJrQzhJf7ddVurCmouQW4drbIUxU21A4r
 msEg==
X-Gm-Message-State: AOJu0YzBffOGmGCFxO2HewACGu78JlR2V+alwgPxIoRECkOSfq0bsXEz
 HX9GzctUYgzgDceDbBluF85Sjjdl30XpAQMGxqxZKbzW+jCRCEpF/zsLpges3OnUn/6JLI+SGVZ
 gWQNDtZ6EdwaBudU7S2EsKUPidfyzgrVeFUekR5jFK8mfz7kTGpfT0XiSIOqM6GBGGBwf6DJzvh
 nPmNk=
X-Gm-Gg: ATEYQzyllg1zfjx769jP9xH36IQQQxMgaNL5eRKuMm2e5H6tF6v6cXTFEpm85C6KO0H
 yoAvE7m4pPmxk1JQUhmIECqxSrjdZ3UeOJcOLYT7ClXiPgCgadNKECVSi92nnO4YVMv+3VpJVRl
 9Z7LpQCZ6ml9WSXmd/nSyhqXwr8nXFYPK3WzmXecEZb2Z5or/pXnLfDelj2esCJJ5mYncMfaJqb
 XQ9jq5RTX7GMHuZ0rTzjwPFf5blY0WymHvzeD4b7q9nJH8O7+vjBxk2Kpj1YbU0tvJ3aJb3J9uD
 QO0TYqTSO3eSbrIhG+cXzkl72lFsbWvjc0kCyKqy8UVp7oiOCTYegYXhUUT+1Y6EpTowVpWV6Uj
 E+gtI2KYh/dAds3RtyjeP1n4643/2lc4E
X-Received: by 2002:a05:6a00:f05:b0:82a:6de8:fa4e with SMTP id
 d2e1a72fcca58-82c6de9f009mr1353467b3a.17.1774389928183; 
 Tue, 24 Mar 2026 15:05:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:f05:b0:82a:6de8:fa4e with SMTP id
 d2e1a72fcca58-82c6de9f009mr1353343b3a.17.1774389926197; 
 Tue, 24 Mar 2026 15:05:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b03bbf0c2sm15880581b3a.15.2026.03.24.15.05.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 15:05:25 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Victoria Brekenfeld <victoria@system76.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] drm/msm: Fix VM_BIND UNMAP locking
Date: Tue, 24 Mar 2026 15:05:18 -0700
Message-ID: <20260324220519.1221471-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
References: <20260324220519.1221471-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE3MCBTYWx0ZWRfX6YwY+GFJj6wF
 wOrfU7/mwfp0HsVkvORYpjM59IaL+WDgaLchSXvue9wXZqgdlQQ3nycRjAfikIWrG8Ql2kltqrr
 BDmTx0ftWIaTiwERra8m5TU7v4Z75Tw1JOM6A5k+Yf31vZ/MmxQ6OwG36nHk1AewnLbhKoDys/2
 Sp8vVl71qV1yptkNBNC6wo3V+SuRht+Hn1eyDKReydkR1Pv+z/WwZU6Z1T31jXOv564nn1I5iy8
 Fu16dJS3nxgo/2cz97ObYLOSkDuV1HNSfngcmW6FoPMYPciI9J8ORoYr105jWYzhY3FeNeh1ZQy
 qkOqRZKxDNFWHwtUrm7N5Ls8zcPy1q8cmYcPaKoIzq+kkHP0njYlq3LQZaawzlwjc/f9YAeRttc
 P7sNwOLRhbgmBeTTNsDzoxH6QjpzU+MgWEQfKq53JrJ6AQCrU1+c4aerQigljLwIwrwmb36Kset
 ik8bBpTmuTZnZxthy2g==
X-Proofpoint-GUID: KVPwiPGIlIt4xZ1SF0q9edXIKb56ZMmR
X-Authority-Analysis: v=2.4 cv=bpVBxUai c=1 sm=1 tr=0 ts=69c30aa9 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=e5mUnYsNAAAA:8 a=E-CVgwXbAAAA:8 a=EUspDBNiAAAA:8
 a=wHnczO1oL0llXtWWSCoA:9 a=zc0IvFSfCIW2DFIPzwfm:22 a=Vxmtnl_E_bksehYqCbjh:22
 a=7UGCclw-5oBoqXlMmAWZ:22
X-Proofpoint-ORIG-GUID: KVPwiPGIlIt4xZ1SF0q9edXIKb56ZMmR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240170
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

Wrong argument meant that the objs involved in UNMAP ops were not always
getting locked.

Since _NO_SHARE objs share a common resv with the VM (which is always
locked) this would only show up with non-_NO_SHARE BOs.

Reported-by: Victoria Brekenfeld <victoria@system76.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/94
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
v2: Add tags

 drivers/gpu/drm/msm/msm_gem_vma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 43d61e0919bd..953a2403f598 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1251,7 +1251,7 @@ vm_bind_job_lock_objects(struct msm_vm_bind_job *job, struct drm_exec *exec)
 			case MSM_VM_BIND_OP_UNMAP:
 				ret = drm_gpuvm_sm_unmap_exec_lock(job->vm, exec,
 							      op->iova,
-							      op->obj_offset);
+							      op->range);
 				break;
 			case MSM_VM_BIND_OP_MAP:
 			case MSM_VM_BIND_OP_MAP_NULL: {
-- 
2.53.0

