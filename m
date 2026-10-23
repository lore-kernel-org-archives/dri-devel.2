Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D4160A2623
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=AGA4Rqmi;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CP38cfd8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0C4F112D35;
	Fri, 23 Oct 2026 23:20:36 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441A310E75F
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:21 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvBMB3116848
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=; b=AGA4RqmiTNsm1iS4
 bsxrJ+GgMuy6yLb8KIVQwB72T6w3B1VfSJwYcoQ/MWbK2QS61JJ9fj8MMHONSnyU
 AZJhZEHXKQ/Rpgx5g77z7degkURdy5thgW6BeXqnpeghltDlO8pMP9E2oUcrUhHW
 Rj/FuZ1m6exY9mJ6/j1nMXcAg9afdtRM3myTw3CY4hR0/Jrg2PzCoQGtZU3IRjpv
 YuBbXF/5PeDTkLgVzDm1F0eoWDcgTaBO8kZyi4jDeLe7X7Y6z7B1ZVY/r0KmYLHc
 3L29uht+TFJLng0cNcqWO05+njoK8nc71YmiQePEzma7XXyK4VOT3HqCCrr2CoPK
 GD3YZw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrt8uw6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:20:20 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb98809caso243002785a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797620; x=1793402420;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=;
 b=CP38cfd88G5C8xYLsptixEUCKfYqyGsQcWpF4kZLi515Woi5EE+pwbPNdobOcgTQj+
 KqRO2ttcMLAZAXVFzBAxP3ZSJJHWyFZXqxNWMlKGKuG6+BNkiMYuZFLMrcEH0CNctmUA
 ynKdbMpzl3KuBYnWQqcUP0FXZHH0wFFrIpND8kVISUVI3EBjB+75aU17ODsEy0D6DuQm
 Bd7fLQwWy0PbEyyNmK7RxckfwZ3cM3t6NipH0WRctiOF8T8Ew1ienYRBNemqlVvexgWa
 4HiwfNmbHVSpJVs53R5ruQZoBU8iLHIsLntcLDjgL/FXIRkz948RszIyh0bW/6YTr1Y9
 S2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797620; x=1793402420;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Bouo2TwdZYWtrlod8zFDy+axmmNowG1vvoPhame7Qco=;
 b=ftcsgyuAJcK9pyWboQJFxgji4m5xzm7qAgNgLBp9ADZJVhjktcCnFXrNRt3/KjuPNs
 cyqr5iqhY8xAe6wkL1hd9qgK5JKbFM9IKY2hphQPHUbrcG/7hHFbQnxHun1ej7g/dBR1
 FnlOrUrbed0HZFF/jmLl6Rso9lfcxCDPZfr45nhzuTfAjxyWMru20ktz7F3qgDRTqwDr
 ZI0ZsV1rPeJm3bCuK5ARYbf7HkS3az6I1DDrGPQNQwWZ/X0wOtN5HrFDGl0la8Vi2ThP
 Vj3fTSyf9s0rkyUa5PHzVDS20yn759w/DlYaLeGdH40T8+lhy97LlLqPhNu0dzTiYt0f
 9HMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxChuT9t5eqT1RszPO+oKs4ro/3SC//aawF2MI/44+xUPAwpHntYK0HJkTL4Vq1VmKjrVRkz0XSXYE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLteIA2WF74qZFSLBGcduaKBXFJGLrCWBQpf6xhOCrzygKEPi2v
 uyCyK+IxfoohbkfLg1coWhx+otClYlTa+29iDtAuJy/eiyoPII0JqawGmcQUAy7My+yzjNEnnDl
 uV63NhyRA9YLNVitrzMr6xnp7+Grc3A3cLSo34psgJHA2CYeoDMARR3dN8XbGBwgUK6F4HHw=
X-Gm-Gg: AYBFou39Bj7OxNplHmkoEW3zVzc71YLq+h4QAYPCqlUTK1iVVCZTNtor00dCjDZNqS/
 pu9og5Vz5o7J+5N3l41/yKQiXjEMeuEpefS21J6mkaOOVGw5KEP02M8ntbXgtTATTXNApNPEMj9
 //KiYp7q3G+iDf49w+Y5Hl5hJsxoN8P8cKZN/W7xWx1s3+aXdwYkkb2pbClaVzU+4zmw2wO4JhN
 kdCkp5WDLSANhT29OwvRPVvV2swuVoiOzRseH6i54u0qBRojLrbFWOUEYPPfsPSvbh1T1MynARq
 Y7Q3aeyaT7e2rt4OF2i8gBV9J3z7vHHeOacTyOIFdCKL9qsQaEvgCxSGZWPxug30NUMlsfSS9jp
 74hri4t4PGelozZycegatFIzUpLgkSFQ2cD2aMUHH5mVfZiK9fmkGM+GVwPacf6iMBhFaPmnN+v
 xL0PAmFRtug5ZI
X-Received: by 2002:a05:620a:4628:b0:93f:2ec5:7e1e with SMTP id
 af79cd13be357-940ef9322d4mr94121685a.65.1792797619593; 
 Fri, 23 Oct 2026 16:20:19 -0700 (PDT)
X-Received: by 2002:a05:620a:4628:b0:93f:2ec5:7e1e with SMTP id
 af79cd13be357-940ef9322d4mr94117785a.65.1792797619096; 
 Fri, 23 Oct 2026 16:20:19 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ac709f3a58sm863811fa.24.2026.10.23.16.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:20:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:19:40 +0300
Subject: [PATCH v3 07/14] drm/msm/mdp5: unwind a failed mdp5_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-msm-kms-destroy-fixes-v3-7-66a30120a5ea@oss.qualcomm.com>
References: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
In-Reply-To: <20261024-msm-kms-destroy-fixes-v3-0-66a30120a5ea@oss.qualcomm.com>
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
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+uTAxaJ9ToYBaS3tBcK/CiOnSJBkEzedlgXm
 N29faEu1XuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvrkwAKCRCLPIo+Aiko
 1VmSB/sH0k/jc18bOj8XnRvDZZ0ai/kVj6c9174VdVZi5yuymIMM5HCmTC8/DTNTMRLpGUwDuuu
 mcyoz/fwICXQzneuwi+CGuImyhBg5o4GHzZfKwlrjSR+TUytDZIS8z4NdJ40C/AbWfkelOy/B87
 kQ/Cw1q0FpV6IyrltqyQWZszCwdB4CKV/dvBMVYmKX+pvUdo4Ss56B4kks7LDpQ0czTxhsc+iko
 zERHcFMVntKR/2WEaQiHYpiQjZk2GYYasjmX5Pqq5He0GEL+/sIgr+/CliW7wwMMODn4hmYT0QO
 lG3x2eHBXrmi4/w4PryG873n904ivV9zxT0fiLLga+/fuki3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX+XUsklOpecrb
 6/C3DNVoqYFFjsmt/WPzTrkQaxHYqMOv78hbZLPfetlWgWsv46j8k1Wi8ql+h6nVGymwbxLuLE5
 r7AjI2WYE0ul4b4S1Eb6ZI9k6dMRaiA=
X-Proofpoint-ORIG-GUID: vo9kMfNtmVboVpdX8cXY0lswCq3wMKan
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX69pDkZ5U1Z3W
 K1j7GVVku1mALDEJnfbo6n9wTh2dKyze5ZfZurllOsbAXlWDFVY1Kb0dSHAl++MCHHPGcd+YPFD
 ogv50o1NAfiJ0vhOmMVMnUqUirkPBNn5WIKLpUKPupGOqYhtEfNKLkLj7ZqC9KXad2ryj2KQ5na
 SNm5v9+WGIPNGGG5jHiCotNMdhZyL39g7OJ6fYnUQberYioFbYUWCRA5JGyRJf2fFKrMvoGSb76
 z+SVQUWEaA/C5v68CkhpiV44mk/QSgJ3ru4rA0wkOX706L7tcAyqiKkakCBaPcegJ+uyXFdSzfG
 YziD3gtDa3tLLZF1tXnQHQ8Fe3DniMbc7z3Y8heHMaS29dZDVrotKzUp3Bc+CEzZaaXTOoF32Z2
 4oTgKCORLouPxI4jLwnfn6HkzzEL3XyLHGeKz6ggmT3ZtxjiKJkMX/GJ3qIPLCEyoZxRrR+lce1
 ayFj8JEsMFI/W2Yx1Tw==
X-Authority-Analysis: v=2.4 cv=E7lYNqdl c=1 sm=1 tr=0 ts=6adbebb4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=MU5U8ZpPrSxGNErEH5sA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: vo9kMfNtmVboVpdX8cXY0lswCq3wMKan
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

