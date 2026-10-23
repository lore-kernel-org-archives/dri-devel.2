Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3970C606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XWiNU7XQ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ixg3Wnju
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A72710E69D;
	Fri, 23 Oct 2026 15:33:22 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFCE010E66F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:59 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6K4x3557728
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=; b=XWiNU7XQDnB7y/wO
 KLSMw33O9DccCqhyTp1l1enBJDx6Pdj1ty9cFhX2Pklo76XCPN2TIT/WxPydz5bN
 bIXa9HkzDy+uob9QMVv1yZdYhLNS5eyt2Kc0gS5WDyFneqPLQsiQAyGO9ZTKV4nS
 Z6jFmGGWXveI6JRwX9WGjByA9jbzo19ljsxysztw1E9zHh5h0dvgDgAbmGpNF1oH
 93sWA8uvO/NvqDXlyXfUYkbP/yF8BOdXGeoDzJiCiIpIpGh2h17IvlhWLB62onA1
 Dz1TCnVnrUTnvPmaUPi3oHW92ILcIHMc3uR2KStzV/jG9TIh7esjF+vdt5D2HPn3
 M0C/Tg==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjcbky-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:31:58 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-99062be02ddso189437241.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769518; x=1793374318;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=;
 b=ixg3WnjuhaX5tjGCVVTTZy+iZMr/ywRoiyFICqdtBLRte+7u/x4iXhgUE101eJIFxo
 iMlXWtLBU5xCFRJ/Eu9DcC+20ezVvOzOg0lcPb/uPgGBwfNMHl7Xco+i9+4f9Xdwit5I
 tIy7dksEyvY0Ohy3VXfALVDu+ZHWWrBfx87HN3V4uN1370f+k5I1TqJbD7zQXweFQMMb
 QGXas40462R7x7EfS3pSLYfAHdSFF4BQa1fa7+pV8nnI1ZXzv8k9Af3njUFXNKtbE9mY
 Mq00lsz4a+UzPbSKAHvXVG6g3y7V7T0DeR+pkCpEA1Lt/cIIid+totVB4XfmlKUHTZ2l
 uOew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769518; x=1793374318;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=;
 b=PVKoOhsmW+367Zg/n1aWghgUurejVtQqyS2xN+gh85K0XjZ/TYmb/WH9SLABVxCVkT
 diQMuFRz8BeGLv/iVrN4DNZdV33mcuwDX268z/wq4at3ayEScIhzFUceQMeXVFzPw3Q9
 tNOL2187ujLiIqgiQh76/p3CZjm9zn9fkEeRArtAPbQA0fROlL5thGJ0ygC6wexawwcc
 mcHRDnjDfTVbxw9Xa5I5pIrbckVXk0W0jzulO1+Gp8LiHI/SkUfZ78SjIg+G/62Kw6DE
 w3Tpe3ylClUQv3eRgJbtWKKR0PGqUY1SOPp020WmoEjxP7HceAttP2QTnJIiBatIxq/5
 Ivqg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRmPSsgqLYKnbCOU48+MEHITy9R3DWjvn0kotZ9kArO+blJGAU0sMude0RRbQIpTc++UFVLTuoL3I=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJucRKRWVFZoRKY0uDkk4OjdaeEbL6O1fJKbQiP30Dv5QQhj9/B
 QyFuo48CYFGkmyqzCySIDaBnnodDCVT1+8054gAjcvioi0EdqOnkhJnCbpxdOHBDUyP8Xl6RKbs
 agcRFC7GbrCZlg/RGv2ASp5sM3n6E0cidEk4H0nyxlLF1RTCW9ztLJK1aEnxe3D9EOUmetZA=
X-Gm-Gg: AYBFou0DL/1bcaLyWQgu8t06t1A4gA/c8vqxO7pv56Gk7sUy1dYSr4IsXpb0MjcjOx2
 nzAOyZZes4t1VJaUseQOCQts3XWdwkhx6kKonF4kGJHHeZY1WJquIuuKbiqRLVOUh6BgrY0N6XE
 pJqq96JaoHTPVNV7NZaz0IswQVi/a4BiSmD09hdsM7QrxDJHyvV6bfHt44Baga28GTEFr+QkSCP
 PRUqL7aXR5jHtSw0WI5YmSPLTDnyUtqhE5qbctH9wOlWLNkQ7CLyiVcchjk6dsMJLDbK1aHXZin
 NPJs76FTNtb4gguqDRQ1Wi8NnJg6hWjz+GYs9IS2TxxPxz1WwdDq8V4R+AcjmZzP2CIvdSuAVwM
 GIxSynO3BZkaFlT2hzBCnJGjoIFJQIN9j4M2nOcq4oiX4qpiXZy1HhVIuOBawdhMazPx5bBd3WW
 DRMzY8aslG9OKI
X-Received: by 2002:a05:6102:2b9c:b0:7a7:366c:92b1 with SMTP id
 ada2fe7eead31-7ccc334af2amr900588137.23.1792769517896; 
 Fri, 23 Oct 2026 08:31:57 -0700 (PDT)
X-Received: by 2002:a05:6102:2b9c:b0:7a7:366c:92b1 with SMTP id
 ada2fe7eead31-7ccc334af2amr900547137.23.1792769517232; 
 Fri, 23 Oct 2026 08:31:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:56 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:22 +0300
Subject: [PATCH v2 07/14] drm/msm/mdp5: unwind a failed mdp5_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-7-83727c122de7@oss.qualcomm.com>
References: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
In-Reply-To: <20261023-msm-kms-destroy-fixes-v2-0-83727c122de7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4313;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=opQ+Hay17WlVMklcY1kZq3cMOOsRo3ASKSUfJonVxsQ=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233VQDsPdiHby8Y8BcS3wc3WMLWc/zB4nE4D7
 TG3L/oCIUaJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt91QAKCRCLPIo+Aiko
 1RsUB/kBw944ZdwyYPTkROO0CRtxWx+DAfMoWeRVvb+lZUAovbL3gKVO7f9Fe86GgFlC0UXLTyj
 MvZ5uUAYQb4zk0JLcAfrHDTOpSajg/WBaE2bYiuS0c7fRp/B7d41n0VQ80ygNB6ZLcHvgQToXdB
 kFTwZXvkRJn5z7JUzetbLpTZqE1GymwVj/HbBrcz+6cE1zncMOHNm2+EB+fviHBWWCu+nImD5k3
 ObSXK7iiAiXJM11OIONbf5eRaWMgPnW0uYNdqMT3H71AFXQPfkTDcOy8iiPd3Kx0DVJzs6b4wCJ
 Ec9jRKMVQBXYU7k1NUk+cfYZacl6cP59CrqitvNDeHLh2/N2
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 5FvPdBtmuppJBO5DCphfu0A4WawoJIUe
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7dee cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=MU5U8ZpPrSxGNErEH5sA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX06UZV/cfoTgA
 7AbesgeSdbQYw7c8uUqPI1gVNaCnPJ+vLTn3eYdKy166KWaeyQ1Nbjq4PYJfggJN+0IWmZK3aR0
 OrlNIyt256ODTKOBa9FdLIkFJSpXmmM=
X-Proofpoint-ORIG-GUID: 5FvPdBtmuppJBO5DCphfu0A4WawoJIUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX03giTEMKtIHY
 O4R+TNgrWDOb5xWrjLrF0LNFosqmmZzP+jhKtRL5wmzN5Ck9SA529GZS0XRAYFC66PJyzBWbgAr
 gB3Jbb34jEa8tKqYFy5c0xtTvEMuEofhYGA/sxZm6iUTEn7MToF1oa6FhghLqgM+7ZY1sb69+TP
 brdnKrbQ5G/9zJMwbnGeyG7HViYIybfvtuE1CVT6r1WAeQiu1CADPtWX8yKGFoRjW+cKY+EwiYt
 8mhBjgRFQVZk5+7wxEg5paoPjM5IMZ2goKFnFUUrj+3u5JtHBXWUhN0q29fQbAczlA3/7qPJ7qd
 Yc/DPrwXEsstS+/qBBOYZO87/USBD7riFqzcR58VyzpGzg3e+OH5EdE7rw+kW1oBHyJOSGOcvpD
 l/HKQE2ygy3EDXvbN2cvhY4/VOAQlD/rRKo5spUTMNKeSzWFlKq/m/Dg9g/FlF5R5T4gWtuvweJ
 SEzsQUDumk3LvSxRBvQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230060
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

mdp5_kms_init() returns straight away when one of its later steps fails,
leaving behind the kms, the runtime PM reference taken around the address
space setup and the address space itself, and lets the ->destroy()
callback, which the caller runs afterwards, clean up. When mdp5_init()
fails, however, it has already run mdp5_destroy() itself, and ->destroy()
runs it a second time: the global state object is finalised twice.

Undo the steps which have completed, in the reverse order, drop the
runtime PM reference on the error path as well, and tell the caller not
to run ->destroy() after a failed init. Fold the hardware setup, which
can't fail, into mdp5_kms_init().

Fixes: 8d58ef346f30 ("drm/msm/mdp5: Add global state as a private atomic object")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 45 ++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
index 085c23820f46..30af8ef51e4c 100644
--- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
@@ -19,9 +19,8 @@
 #include "msm_mmu.h"
 #include "mdp5_kms.h"
 
-static int mdp5_hw_init(struct msm_kms *kms)
+static void mdp5_hw_init(struct mdp5_kms *mdp5_kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 	struct device *dev = &mdp5_kms->pdev->dev;
 	unsigned long flags;
 
@@ -58,8 +57,6 @@ static int mdp5_hw_init(struct msm_kms *kms)
 	mdp5_ctlm_hw_reset(mdp5_kms->ctlm);
 
 	pm_runtime_put_sync(dev);
-
-	return 0;
 }
 
 /* Global/shared object state funcs */
@@ -198,24 +195,26 @@ static void mdp5_complete_commit(struct msm_kms *kms, unsigned crtc_mask)
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms);
 
-static void mdp5_kms_destroy(struct msm_kms *kms)
+static void mdp5_kms_destroy_vm(struct msm_kms *kms)
 {
-	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
 
-	if (kms->vm) {
-		struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+	kms->vm = NULL;
+}
 
-		mmu->funcs->detach(mmu);
-		drm_gpuvm_put(kms->vm);
-	}
+static void mdp5_kms_destroy(struct msm_kms *kms)
+{
+	struct mdp5_kms *mdp5_kms = to_mdp5_kms(to_mdp_kms(kms));
 
+	mdp5_kms_destroy_vm(kms);
 	mdp_kms_destroy(&mdp5_kms->base);
 	mdp5_destroy(mdp5_kms);
 }
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp5_hw_init,
 		.irq_preinstall  = mdp5_irq_preinstall,
 		.irq_postinstall = mdp5_irq_postinstall,
 		.irq_uninstall   = mdp5_irq_uninstall,
@@ -506,6 +505,8 @@ static int mdp5_kms_init(struct drm_device *dev)
 	struct drm_gpuvm *vm;
 	int i, ret;
 
+	kms->init_unwinds = true;
+
 	ret = mdp5_init(to_platform_device(dev->dev), dev);
 	if (ret)
 		return ret;
@@ -517,7 +518,7 @@ static int mdp5_kms_init(struct drm_device *dev)
 	ret = mdp_kms_init(&mdp5_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "failed to init kms\n");
-		return ret;
+		goto err_mdp5_destroy;
 	}
 
 	config = mdp5_cfg_get_config(mdp5_kms->cfg);
@@ -538,19 +539,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	mdelay(16);
 
 	vm = msm_kms_init_vm(mdp5_kms->dev, pdev->dev.parent);
+	pm_runtime_put_sync(&pdev->dev);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_kms_destroy;
 	}
 
 	kms->vm = vm;
 
-	pm_runtime_put_sync(&pdev->dev);
-
 	ret = modeset_init(mdp5_kms);
 	if (ret) {
 		DRM_DEV_ERROR(&pdev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -561,7 +561,18 @@ static int mdp5_kms_init(struct drm_device *dev)
 	dev->max_vblank_count = 0; /* max_vblank_count is set on each CRTC */
 	dev->vblank_disable_immediate = true;
 
+	mdp5_hw_init(mdp5_kms);
+
 	return 0;
+
+err_destroy_vm:
+	mdp5_kms_destroy_vm(kms);
+err_kms_destroy:
+	mdp_kms_destroy(&mdp5_kms->base);
+err_mdp5_destroy:
+	mdp5_destroy(mdp5_kms);
+
+	return ret;
 }
 
 static void mdp5_destroy(struct mdp5_kms *mdp5_kms)

-- 
2.47.3

