Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74CFECA5FDD
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 00:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D132410F9BE;
	Sat,  3 Oct 2026 00:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="U3Er2bYQ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kqwBJC07";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9DD0710FA6B
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 00:30:33 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeNcu2309815
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 00:30:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=; b=U3Er2bYQbYYenOG3
 yz//5n/vcuk8BFff79e3s5ptrjkIEUUoCjw67ERR2aXKSg91vMMrGwKMK23T1tCo
 hPtTYFm3ZLDKv9LW08Bfb7aJgcqbZlpmfaL123hV1k7TlhXbu4dp6esJwJK9AVKf
 xNQC1Oj51tGhjy+3V1uXU7yzTT7C4/KIeQ2VCB85mI2PFF2JjFxm1ErY3ApXZrms
 K2FU+wMgQ9K82siMho0PJ185+q6D9j89U/CYEIaGZL3c6JxTVoFul0JqUZjPbFjv
 lRnNAuRuO7L6w2I9wmGvk9g1HrGEE8HJKLtkykk5BNbO7J1n1RvV44k3yYfwwHzg
 aZKDgw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2f3da2m3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 00:30:32 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso29443285a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 17:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790987432; x=1791592232;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=;
 b=kqwBJC07fBq5FQpsMIiawV32ngKBrEWzGcmrZWWyff34nveF/jPZrgQb8ximVd6TPF
 EQOZGyzvvRCm//s6UEk0av5WVo7g6BZdKv5168m4ALGep5+4UAD2zmBFFjk8oWZ+irRX
 42lQcz0L9ABmFdgmnEFE7zymduor8uehwMaXyjbm/jeabGzAEQsVw05s6uYttKkQBNjQ
 H6uEjbhV2pAaDRQUOO930aBowYccV9WFTBh2PWxzY8kJdBaF5yK2RuvpXzfYgH0lpTv+
 mNaiFnZsoDsfZ4ekFLK4EPAjvTV0nqqWmW6Kq8LwZF6jGEOfQlHtraOAbCKsoS59Hl2I
 +SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790987432; x=1791592232;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=;
 b=IHstRBIHdVz398DJGhZ1viKZNfA48PIXeu5RJiAV5FgkJr6w/4Ucc6Bzp+f+/saJ1s
 RwDvItdYJqbF/566Q6xjnoFfuTnX9GZ+x9PjflNxwm66/v4l4run3zEwetAyyqKPG1wL
 msvwkd75LtXSP2lcjqn7ppoh3tMiioZPygchHQUy2J9piRftuWxioCSUfSvO98Yxlc/N
 gwQMz10KAkwixb9I5ALuF2f4+OddHHLPPxwrBNAQp3MmH6uDN1XbXTfeRIFovq2TEdX6
 CHSoNfCnDqD5ykoEV2AXxQXEUy/beOcnmnuw1HmC92egktrMTwZJwIKTe27SAhdbaxHZ
 79vw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJ9FeNdzBjQR9m21WdwuQ03Aelatbq9L/fh4yJ7VE1ay95gmKFLVxfXU2xSS6V9KNxBy0BOBvTOYo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lD1bOfEcKPqC9ekB+UTXWtOUG5xifiQRww7N8Wz+cULUgynBAo
 txE5Zkt5W4E5McW6IdkQ8yDUVPdTj/42AkE95jlmSBum5aC9Zd0ZXvExm9vovLTuTheYymgksaE
 8o7NN/las4YXNTw5hd1gWhLLER+mcHgtU7bgOcOrPtRwvJUsI+BGfg6004jiGeIlDKO7axuI=
X-Gm-Gg: AYBFou1z/rgRLclezSY8o38UB54VAaSoX3cs3Df9vs6bD4AUKvM1uXlimG5C4FMJ2mk
 Xf6JZ/HmvXSOhib5j5Cl8VshhNTHwabL2PzrPZTs8pVisYCYL74hS9HSWMC5ds7RUphNBcjwi9a
 LfSw5c55ieFCMtpq4zNo8DdbFy0evkyZmYTf/ersXayCMHF006/yXicSCBtK+8ADbDQJrBfHGE3
 0k7E/jWQGj0ZyN2FpBbXteQ8UeRN/46CwlLU2PoIVENdgUN9szQGGFnAlRyiGpm9G5sRzWgQ0SD
 dCOr/s36zch8gDHcM1+QGs7eAJfqqQW4lgz6NFgKyqj14Gu1A8eAw4XvmKtjvIQ3Ujqrpep3yBS
 m79nILptclsQ7/cAkkIjRh1bHYeFcVadH/FLK/yx/JY/+85y4eXlEFwGk5vw0zIb866Zt8KrcE8
 VeFWAFQZGgHq32
X-Received: by 2002:a05:620a:1b9a:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93cf178a668mr803419285a.49.1790987431969; 
 Fri, 02 Oct 2026 17:30:31 -0700 (PDT)
X-Received: by 2002:a05:620a:1b9a:b0:93c:b47b:26f with SMTP id
 af79cd13be357-93cf178a668mr803413685a.49.1790987431402; 
 Fri, 02 Oct 2026 17:30:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bb7c7957d0sm1133979e87.31.2026.10.02.17.30.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 17:30:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 03 Oct 2026 03:30:17 +0300
Subject: [PATCH v4 02/10] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261003-fd-kms-fix-smmu-v4-2-2a44d4d8ac77@oss.qualcomm.com>
References: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
In-Reply-To: <20261003-fd-kms-fix-smmu-v4-0-2a44d4d8ac77@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/Y4+Ew8bQbr3xd07TJNsXmM99kEeC3E5cOSJ3Rcs2qc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqwEydtwrPat7qXUt66f+1g4fJ8zOYW9Zis+PZp
 +p7/sDvxfCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCasBMnQAKCRCLPIo+Aiko
 1cxRB/4iUUgl17KXsRCJ+FOWP4ku1AInAHA6A0VhVqHEZMS52SlqTXHj+gh55MXrQynLwF2a/Vx
 YewljfPpngqmOQx2GAagDIm6k2tegkQrh4xmCE5GEhrwUkfCr2+0VkLjGbvCEXHVvhGEQ+JDj9U
 FrS8TYarjb96cwT9jkOnohW627OHttXoLAJ2zF9bc7/7uG1bUQytDJIGOLc0UMdjSm0nwBvI1jt
 zg7iU+r+8jCIsjgsbJFvppl3M3DkHWkwWPgvPasDZx0eWRdMuPOJiN+6T89/qkO1oEVVT62q8Pi
 0N3tRWo9/eoBAkF1zl4grO/n19xAfWTdQznHCEZ1YmE8Fz09
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: e0tTdHkoU7wo8VA2AjYZE5JvlXDrOUmf
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX4GSRlVgqqfHQ
 lH+bK4oONt7HPnp7QS0raumi5jFDORSmGUfp7ZC+D70zXAq2rkg6HZ6b7Q4jHp3gaXFl8qiYH5K
 lh1r1Sll37qsc8YgmhjNrD2aeHFXcnU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAwMSBTYWx0ZWRfX3hfGxKF5J2KT
 EK3MkwCnD8Ik7QeFu1gleTdgK2H+LldY8SlmXK4C7yTreEJc5evRT2K/71WI9ki9RtP4c6gyjCO
 XtXLGcIYTTzgV4q9IBDXhvuGiCzbfHyqocxOv1TNJdTxMDtSY2+FH7esjmdtFhebMVykjySp94l
 +vcb67zXGxgbmRGTOsY9K78BAyI0u+C2BiV2sjBrnLgx45TBdokClco0zhE34wPU+RXsmCylWku
 e/KL5b812j9QnWDMH7xjj0uJBf/sSEZCcw3BRxlxX/qd546AYO08yvJnU0vsmHxLkhvO385NwXp
 nkXcZAe08BJOJDRBn40jA2xUk0Q87f/iERMn8rUn1ulL/HhYmOHfQt2jf4wUWlmJTt7zSKBmo2M
 7IFA+nxs0CErx5ehZa5yHLM8Y2kjF5QybQNFx8h1gCHNAmbOL5clr75YmUbCbjJyMy3y7JBdty1
 d8GWanPaAgiM4Brm3Vg==
X-Authority-Analysis: v=2.4 cv=L9SI0OT8 c=1 sm=1 tr=0 ts=6ac04ca9 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=oM4tAuVuu9RyGq0-O0gA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: e0tTdHkoU7wo8VA2AjYZE5JvlXDrOUmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030001
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
 drivers/gpu/drm/msm/msm_fb.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index a38e5b3a1d1e..792d47b4acc4 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -80,6 +80,18 @@ void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 }
 #endif
 
+static void msm_framebuffer_unpin_planes(struct drm_framebuffer *fb, int n)
+{
+	struct msm_drm_private *priv = fb->dev->dev_private;
+	struct drm_gpuvm *vm = priv->kms->vm;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		msm_gem_unpin_iova(fb->obj[i], vm);
+		msm_gem_vma_put(fb->obj[i]);
+	}
+}
+
 /* prepare/pin all the fb's bo's for scanout.
  */
 int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
@@ -102,8 +114,17 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
-		if (ret)
+		if (ret) {
+			msm_gem_vma_put(fb->obj[i]);
+			msm_framebuffer_unpin_planes(fb, i);
+			memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
+			msm_fb->prepare_count--;
+
+			if (needs_dirtyfb)
+				refcount_dec(&msm_fb->dirtyfb);
+
 			return ret;
+		}
 	}
 
 	return 0;
@@ -111,10 +132,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 
 void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 {
-	struct msm_drm_private *priv = fb->dev->dev_private;
-	struct drm_gpuvm *vm = priv->kms->vm;
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
-	int i, n = fb->format->num_planes;
 
 	if (needed_dirtyfb)
 		refcount_dec(&msm_fb->dirtyfb);
@@ -125,11 +143,7 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 		return;
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
-
-	for (i = 0; i < n; i++) {
-		msm_gem_unpin_iova(fb->obj[i], vm);
-		msm_gem_vma_put(fb->obj[i]);
-	}
+	msm_framebuffer_unpin_planes(fb, fb->format->num_planes);
 }
 
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)

-- 
2.47.3

