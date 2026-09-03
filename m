Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C058C624D6
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 24DB910F5B2;
	Thu,  3 Sep 2026 13:23:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KOrC4MfC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="i8XEmypa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9E610F5AF
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:23:47 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683DAMVv1314570
 for <dri-devel@lists.freedesktop.org>; Thu, 3 Sep 2026 13:23:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 k+mI3GEI2CDfK3ssOBCMKAt4S/5fYocofrXGK1kFQNw=; b=KOrC4MfCUaYdZFPC
 Y9tDwRDQARL4Aiw24OjmAR+qlMYqhehogHwbkp6F+MlAhll0I9J7GtBSkajUVirq
 EvnJAbUV8wJny7+KTX5wJXr9xPQ2C1ZHy1zczyaZeUQyM1vC0dH3Yug8gWgqrNsk
 oypxpgX0BMp10ZcyeLJenIFm2cDX+5ojNp4rTNPH1bYV+yuwtv/CAey6QYU6sMol
 9UIKPC/kbU4TMhHcdR3t0vKhK6q4fWAOESOOXU1GMx2LzcsBxu4NcCujc5P+XvGc
 RfcGHj1f28vKKQgYq800WKMGxUCF6y4cWOF2PWm1t9F0wkIGlEWsKyUJJowyiTFQ
 z9NUGA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gerdncg0f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 13:23:46 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e8be2221eso161688241.2
 for <dri-devel@lists.freedesktop.org>; Thu, 03 Sep 2026 06:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788441826; x=1789046626;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=k+mI3GEI2CDfK3ssOBCMKAt4S/5fYocofrXGK1kFQNw=;
 b=i8XEmypaHQReYIdpxMt1c5DiKtfIZJXS7Ys1smtsIbseCPTYavzVReYlHG5+pJqxmO
 3WivBdYRTbcALx97RdKE9Jgunq7f5L360vZFqHMIdipq/Cn7pVKaZSNfi7mRz3g+iAVw
 mST2Szq1nGsD+uJTpHc8fPY3BYYwNL3huUmxuuY7p3uYIrp5U2bsN5j2DL2MBMy7mUsk
 mdY1KexmWZUQUNnFboYtdjS5/dOVFc/ViyA0FWKrSxCQrH1+MqLP5auGtqFplkEP6tLh
 s7m8QqQYRDfkOHZp5eKYJvDU9HqjJrV+UF3/loiYbKizTTLDdSYrXCWxV9i4DfNHu2jf
 h6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788441826; x=1789046626;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=k+mI3GEI2CDfK3ssOBCMKAt4S/5fYocofrXGK1kFQNw=;
 b=Jtg2Z90sbpVBgyzv75QIbtlyUX4yGTwUVQVIe+Da+gzFCR6C85tuqg3W0hIKTW6i2E
 nFwMylxx3HjsAN6iB9RlZ3cVSbj0GbjkAHudMueg6/fEHfKcOf7uSguJ/a6KhlD4JnFr
 +Rg9I1NTl5EAL9acMjh0tTmkhPXrVfvyP12E0pk3sdcdGVWYqjIfbRiZYjAtc/Tb29kw
 Lo7rFRLjw8J29ahgifAq0Vjt/z7nfs09TPbcXIfxkKlOzsOKflHoKHa26hhHyNpPeEVJ
 s+ZyC8L7ZBByApdqB8MPk9SffTIHI7CjPD9jj/1mV/3sYwBJM3Py86BVx95bHZL9Iz11
 ScSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK7Pq5U7TgsF5WQMV4ef5E3JMAgL40Sgn+klIQR4U78O+mg/8vlA+ICJs6HhvyJaN3kZRK0AVCcKk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m13jj9kxAlWyzQJim4qbN1gMYN3B2GHzyEm3uw34nznzYGWhky
 tDp83A3g1JvbgtWH65MltZ2gylL9N6U1Vm4gIekVzpAhN03hk5IPK44FeDXW5VhWDohBmDCvx/M
 x2mtVTBLKsEvgU/It43q6bnxdH2Ppc5MmlauoMUg2/xH0h4ABeUhJ3uX90sISliklNG444JU=
X-Gm-Gg: AYBFou2uHooFDJH9mZWpCIMkdxfAUjxBzsG4YtBpLWfmchSdzJRIMVOXgnyPz9HcGAY
 2fJm93pr8oaKm3c3jImPCaSUc2B/uStF6mwp73uzzt6u5Ce6r9+xz1eC1ODmkAwzzMpySvKfVHW
 DL1Vprtg6ljBQS3Whq+j7E2ualjUKoo+ZujfUBQ9Wv9/n6dcD1skrF4R6U7H9AhYYIMgnY4ntAG
 VcTLKQBkcDEfX7HqeBZeA9B9wJ4xQzbfEaq6B2NAzgvaPsWGFtTTlSbzf8tZiYoZIjHRT/noAHL
 xJdPNvkiE6S1dcObeCU0du33xOUA06B5EqVig88Mqix80JzyvNANB3Z5/bKGtF6wwznYkhIJYEH
 1HLUdnYvkXaNm8aPG0ENzMDmX6SVUFe+WMJXwCphwRFjojzaaeKdrJM4DwbF64jPBjfBBhXcRig
 ZfwZgkHlzHMAU/
X-Received: by 2002:a05:6102:32cd:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-78a1eed1c93mr3585905137.0.1788441825660; 
 Thu, 03 Sep 2026 06:23:45 -0700 (PDT)
X-Received: by 2002:a05:6102:32cd:b0:779:5049:87b2 with SMTP id
 ada2fe7eead31-78a1eed1c93mr3585885137.0.1788441825273; 
 Thu, 03 Sep 2026 06:23:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b606da57e9sm1296480e87.83.2026.09.03.06.23.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 06:23:44 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 03 Sep 2026 16:23:40 +0300
Subject: [PATCH 1/2] drm/msm: fix framebuffer pin refcount leak on prepare
 failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-fd-kms-fix-smmu-v1-1-608d02491666@oss.qualcomm.com>
References: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
In-Reply-To: <20260903-fd-kms-fix-smmu-v1-0-608d02491666@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=NrFw7BXZVFZ9tRlXdJwvxA4tQOn9tdfDrYwT+OYyZR0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqmXTebiKydvKEhAHkK7W6WCJ5/HHQYgcyZIGg/
 LynZnPECGuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCapl03gAKCRCLPIo+Aiko
 1cgDB/9xO0XIZbbgdMWUPUY7xeo5AOfwIYi9GYgdd5Y/bmqF2smB915SaGJONfU9yvFHkpi0BHA
 /nSHNJF/3RWzF1LoPj5L0w/dvmxDkGYkTgIGdcJUF3/VMmFfmDQ9JNUU8h4/mFN+J4roGhHu6bA
 rf8eiv0liGzuBoxvgQK4yo9ddA0GtzctLM4C9FEJsIJryBx7r8/J3tcKsgFz7fobE3jg0C7VRvI
 ThPxJj5UPlSZljaLGPAYzmw9aLxf62lK+uy54CMohjqVdxYpZa1b9vxR0H29LTbwLIbxKK9J0WV
 My9HNDsc/AdAeXv5xvXYzX2QoPn5zUqST4CtENNEHHnvG0ov
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=YcmNIQRf c=1 sm=1 tr=0 ts=6a9974e2 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=bAolQom50hykzV7YMrMA:9 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfXyAfLYtvGFAoJ
 zVeGY23YzTCW8kdMcClFZfwxDhRgZ9n/XHAUsO25g6klH9EKLBSJOgHF/ZQlejsZfiHf0nOAkkY
 /LO6qUpPDTFfOBBolBER9Rntj0n5Ee0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExNiBTYWx0ZWRfX/zJxPVmN2FGT
 VkxX9HH8dAuUiWzJpEn7cjLr7UgbTOwh0uqZs+hB1gd0oiUOYAdPkQhgPDy+JxkGDvlGJd7R4T+
 rvIaQtNTuXhkVkqGBkCk2V875+6UyRnQYwbWYI/9eF9eiq68Hb8br9K85AzBBLg1hhMXnRlg/A9
 H7gEYkrkwCocr0Yrs47Ni21xn6eLLu1xasDqqWXlUSS0n/2uZOxxj6AK2/EP9Tv15gJTMqKS5dD
 vTdDQgWkOyuvS30x1JgR7tQB+cFCfH5pLjWmj6SBZsLr+xIudz8uy/OO12TDxHduUndyUj32QuG
 VKwgWHyr8vTpoRVrIpH4JhE8vkQAk+ZMyKSE9ei/RDIHfwBnCFlB1xopblPQpymQ16ShS0gimek
 aExuSnyPgMB/Cyd0FzCf0yO9WCp/Xj3obRk8kRu0SZlrCURia21SRldg5xRv334AbyVDCJgERBl
 iATxKHsQWMljJwBiVRA==
X-Proofpoint-GUID: h52R7pkvKbW__OeWzZbEPHd9SL-JInJd
X-Proofpoint-ORIG-GUID: h52R7pkvKbW__OeWzZbEPHd9SL-JInJd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 phishscore=0 impostorscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609030116
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

msm_framebuffer_prepare() bumps prepare_count before pinning, but returns
straight out of the pin loop on error, leaking the count, the
msm_gem_vma_get() reference and any planes already pinned.
drm_atomic_helper_prepare_planes() does not call cleanup_fb() for the
plane whose prepare_fb() failed, so nothing ever drops it.

Since commit 8ac37c88f991 ("drm/msm: Refcount framebuffer pins") a
prepare which finds the count already non-zero returns early, assuming
iova[] is populated.  With the count stuck, every later prepare of that
framebuffer reports success while iova[] is still zero, and DPU scans out
from a NULL base address:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11

Unwind properly on failure instead.

Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 60c108d35d2a..934337202afd 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -89,11 +89,27 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
-		if (ret)
-			return ret;
+		if (ret) {
+			msm_gem_vma_put(fb->obj[i]);
+			goto unwind;
+		}
 	}
 
 	return 0;
+
+unwind:
+	while (i--) {
+		msm_gem_unpin_iova(fb->obj[i], vm);
+		msm_gem_vma_put(fb->obj[i]);
+	}
+
+	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
+
+	atomic_dec(&msm_fb->prepare_count);
+	if (needs_dirtyfb)
+		refcount_dec(&msm_fb->dirtyfb);
+
+	return ret;
 }
 
 void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)

-- 
2.47.3

