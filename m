Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72377606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Vi7sK0WN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Y2sI1B3+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 004A510E66E;
	Fri, 23 Oct 2026 15:32:24 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3ABE210E676
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:01 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6ArG2974547
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qZunG5yy6pTO2DbkEtv1VKnSC8oT+62cq2lapmplUqo=; b=Vi7sK0WNtWQdHzsy
 Gets4YpsMR84/FWJuUEyRU/MYOZJxghldPvauQ+WmZIWC5q85FlIJSD3a3iPewcV
 qVY1gahd0vS4HkQXPXyOYLyT+kanyWz4AU5nyfzlKD49HwPaMH8WTSreHBxes85v
 bvMRMv/4k1rwvdsZViZcIDOHq5QJnfiNJltnbMPtkMPQEYwVLdjAIuZWTomcGSJV
 5luLdqVUsQHoYb/zpC7yz6cJ+5i1+C5Jxe33SGvdpeckf+hiJ4/nusDx2fUBWQby
 QH9YcpWagByyQkeViOvvliOoC75ehXZtbju/KfvS4FwZvcUXsa9SSjgy/pfINOPu
 U8d03g==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw4t9x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:00 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-7cc3a482af7so969860137.3
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769519; x=1793374319;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qZunG5yy6pTO2DbkEtv1VKnSC8oT+62cq2lapmplUqo=;
 b=Y2sI1B3+zNjdl9/edLO0GWqh4v5zMmrF8u3BI1rYOCJGMdo2vZ5zgM3ekTqJwIoIrq
 f6TiaOVXBt52Ix3ujHtEu2BhqslT8oHc5sXq5BQKk6dyvTyWJd6ykQexz8BBeEK5epBN
 AAAI6StSJpv7kwLToCEMqH66C0eoOtXjkcmn8Lnkjdnnl3DMibde4RMAuFJ0lFI8UarV
 KFdyWZRlUkjvo8EXNPomclsp6+8AaiCcuoJGp1FEMTmrwdNXgaDtQcVmopTUa2wq/vq0
 cwSpyo+p1X9/fxivrnCLWWWi2eVgsjLcx0u51oTvVuqGgF9+zXA8zhpg3c0T+zHekk93
 fZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769519; x=1793374319;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qZunG5yy6pTO2DbkEtv1VKnSC8oT+62cq2lapmplUqo=;
 b=m0exYF13WuuoCS/t9UVLTVY7IqHLNUa6ljLboOtXNwXGdUbzHCheGNJPy7KO5XLmZ3
 trUXlQpotfXWRdRX+jFSFfMhsnyGfhUjrdvNgxp6o/PfubIzT2VDPl2/XwM7rl2UaGYV
 HOQPk+zC7wuayIB2sKUCPlio41AzUDuu1yeUG+NOH0DbP25ioNigmUSsq3FZ8MZoojqB
 RCevq0vhtNi5gyp1WluZ2ET39MEKBw8BpZWZGwDt7C3lCszSviRfIO/HkRoissk582EF
 N3TVhByGbGMVtq3Pbv3Em6p+eE4yXo1f2WCTySyv+r92d5fNRh3yZ4enaY3s4z+FinqS
 9M+Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBx8n4RUp2h3EdlWn77c6VwI73Os5iljSoHO03dVEOwes+Nvzj95V5V30/xsg1VapS5HLzEah4TzjX4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJqNKuan9eGi+OUgSQSwH5PPePGfh3KzydF7WkkU4uLyEEFMuKk
 0FisP/SxC62AE/7C5JTj0UlmDk55pSCz2CYr1xO+TYXJ+s/RzDktHnMxGzvnzOVvXx8XyjNVfRW
 lEKVwVq5OfezFEynraAVfbcZmVs8qgkH3EfLXMh1YyYqtymSQ+d0fYHF8hn2q7BIZ5eFdqNI=
X-Gm-Gg: AYBFou28INYhqk0WmyeYxYIfQLrhbrFY03MTa+r5Pj3YaBWaXgbT+gsfA/+yToAjcf+
 dZEeyKUlQUZs8P8VIhQe1FQCA0G9XIhX9EAFpI164cxya/lpzoy1Q9p97n5GPtNem33cOWzAmTV
 sx6kfstPgokrKUXdo7WxwqQRjMnDxgwYlqsMRcUKpTVjXZ8zcp9vx3QWeW36iYy+A3siRi/hfNY
 DBVmFnwE0AEdyV4laEq5G4bxw328ylAFhjG/I3mzItr1FyNLvU+zUNWSS5KjCGqI1OJrl5bhhK7
 T4vcdSa4ZXvjIkLY6iHWPJAyC2H9QytBMUuWfOGpZ5rHobVQCBKgCezGK5mdNCUz0fsRZeeKbch
 HFUvRt+x4CeyPXr3lk80Ua16v3zZA+nYPUZI9lJTqXucS7FM11Ru501mOD6ujMMKJ4aYUF41lNx
 fRiupv3cSUuOAw
X-Received: by 2002:a05:6102:570d:b0:7cc:3eb0:6ef5 with SMTP id
 ada2fe7eead31-7ccc31aac14mr1052321137.11.1792769519413; 
 Fri, 23 Oct 2026 08:31:59 -0700 (PDT)
X-Received: by 2002:a05:6102:570d:b0:7cc:3eb0:6ef5 with SMTP id
 ada2fe7eead31-7ccc31aac14mr1052302137.11.1792769518924; 
 Fri, 23 Oct 2026 08:31:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:31:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:23 +0300
Subject: [PATCH v2 08/14] drm/msm/mdp4: unwind a failed mdp4_kms_init()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-8-83727c122de7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5971;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=pQFgWanoVOPU1SD9eoh1kwmHhNTamyaQG3R5/Cs4y3w=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233WRwV1Nx7UujDseXGQBGM8nNMWB3vz2nTgE
 4ZCtfQXErWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt91gAKCRCLPIo+Aiko
 1QFAB/9iOnE5dtT4rUrAk5VrFsyu38++IvedCVNLH08Ap8cOOOrtfOaz71QP1J32M6kZa8tBl+m
 2YclTWgKFCVTMP4WfliUamp99N+eSBwqvIucwakg5XS7gitbR5z4ESK6NwYTMafdp57JShh90/J
 42iVIjf12UiKK+m2dz+ivg8qYu9JRcrATXu6adxZSw3p3KWyowJ1eQS1ZY2yyreT+6dL5G0mcFg
 gjirvdVOO1/CrOs3T2F3cPLkK3zz4kyCnjJ3b4FJ8uFWUixDJ9crwcI5ATh7d3O1vVLRqcxflJC
 0Pw+DHa/Hmm9AP48J48TS52+i9oMZkp1y3uOkWmLBTHqT+Y3
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 3-osdW0t5CVv6ZfGr4fZP0OVHxkVT7NK
X-Proofpoint-ORIG-GUID: 3-osdW0t5CVv6ZfGr4fZP0OVHxkVT7NK
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6adb7df0 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=j6QtfvlM2Oj41uVX788A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX4G0QWvcXayRI
 Ajb6aRTV4NObqewl3kpvSi19vHj0Hpqqdl4POcg8t7qEEH75xH6WtSmpuMwDp6+8adymUEmG9+x
 PuvKIRwSkZt49oRKHU31AkKotO0lm+k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX1R2MEfsr9MnF
 sAh4rDe3cMnhp7mHfoF79rl6wcyTzj85+fpvKxk8UfvCZLEN/NLvbJ04+wq++YhAvkSmsC3sZRf
 6dDtV3aXS1xP4BddBIirpxB4q5GcMwVpltWpWiP75uMJyXHqDA35BCf+EVa1vV0cpY9xbj4WKVG
 nPrPzbOkTubBV8bD2c/j7iiVijx7BgVew3bW4xHAU94gIcnMd9arBshUC4qhG3tvthUtBdhNIn8
 +9Ku4oEMJT6xDoCN9Hp/jAuUDF1qxN6voI6NgvRwR4R7QBAL7D6eNrHkTxB95pN66YqEM5bkgtU
 hTbd4wr+UrBT9X7jq8mWvigcrvbd6+dR3gxMsfjxPn5GXCepSqduDnav4qz9hQo+UiYZ6JOuzdr
 Vz5RHpcYd18l2L+PPDcNS3SfBvFAl3YVmuWnqo5hsQ/+V4e8wjULXD7X8w9QlZMS7RGNp/hE5Qe
 r8tv/kwrbUY1DBLaMow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
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

mdp4_kms_init() returns straight away when one of its steps fails and
lets the ->destroy() callback, which the caller runs afterwards, clean
up. mdp4_destroy() however dereferences mdp4_kms->dev, which is only set
after mdp_kms_init() has succeeded, so a failure there turns into a NULL
pointer dereference. It also leaves the vdd regulator enabled.

Set mdp4_kms->dev before anything can fail, undo the steps which have
completed, in the reverse order, and tell the caller not to run
->destroy() after a failed init. Fold the hardware setup, which can't
fail, into mdp4_kms_init().

Fixes: 93c125e4ea98 ("drm/msm: don't tear down KMS twice when KMS init fails")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c | 61 ++++++++++++++++++++------------
 1 file changed, 38 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 9b1d1982e683..cc6f202aa011 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -15,9 +15,8 @@
 #include "msm_mmu.h"
 #include "mdp4_kms.h"
 
-static int mdp4_hw_init(struct msm_kms *kms)
+static void mdp4_hw_init(struct mdp4_kms *mdp4_kms)
 {
-	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
 	struct drm_device *dev = mdp4_kms->dev;
 	u32 dmap_cfg, vg_cfg;
 	unsigned long clk;
@@ -70,8 +69,6 @@ static int mdp4_hw_init(struct msm_kms *kms)
 		mdp4_write(mdp4_kms, REG_MDP4_RESET_STATUS, 1);
 
 	pm_runtime_put_sync(dev->dev);
-
-	return 0;
 }
 
 static void mdp4_enable_commit(struct msm_kms *kms)
@@ -118,6 +115,15 @@ static long mdp4_round_pixclk(struct msm_kms *kms, unsigned long rate,
 	}
 }
 
+static void mdp4_destroy_vm(struct msm_kms *kms)
+{
+	struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
+
+	mmu->funcs->detach(mmu);
+	drm_gpuvm_put(kms->vm);
+	kms->vm = NULL;
+}
+
 static void mdp4_destroy(struct msm_kms *kms)
 {
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(kms));
@@ -127,12 +133,7 @@ static void mdp4_destroy(struct msm_kms *kms)
 		msm_gem_unpin_iova(mdp4_kms->blank_cursor_bo, kms->vm);
 	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
 
-	if (kms->vm) {
-		struct msm_mmu *mmu = to_msm_vm(kms->vm)->mmu;
-
-		mmu->funcs->detach(mmu);
-		drm_gpuvm_put(kms->vm);
-	}
+	mdp4_destroy_vm(kms);
 
 	if (mdp4_kms->rpm_enabled)
 		pm_runtime_disable(dev);
@@ -142,7 +143,6 @@ static void mdp4_destroy(struct msm_kms *kms)
 
 static const struct mdp_kms_funcs kms_funcs = {
 	.base = {
-		.hw_init         = mdp4_hw_init,
 		.irq_preinstall  = mdp4_irq_preinstall,
 		.irq_postinstall = mdp4_irq_postinstall,
 		.irq_uninstall   = mdp4_irq_uninstall,
@@ -386,7 +386,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct mdp4_kms *mdp4_kms = to_mdp4_kms(to_mdp_kms(priv->kms));
-	struct msm_kms *kms = NULL;
+	struct msm_kms *kms = priv->kms;
 	struct drm_gpuvm *vm;
 	int ret;
 	u32 major, minor;
@@ -395,21 +395,20 @@ static int mdp4_kms_init(struct drm_device *dev)
 	/* TODO: Chips that aren't apq8064 have a 200 Mhz max_clk */
 	max_clk = 266667000;
 
+	kms->init_unwinds = true;
+	mdp4_kms->dev = dev;
+
 	ret = mdp_kms_init(&mdp4_kms->base, &kms_funcs);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to init kms\n");
 		return ret;
 	}
 
-	kms = priv->kms;
-
-	mdp4_kms->dev = dev;
-
 	if (mdp4_kms->vdd) {
 		ret = regulator_enable(mdp4_kms->vdd);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to enable regulator vdd: %d\n", ret);
-			return ret;
+			goto err_kms_destroy;
 		}
 	}
 
@@ -421,7 +420,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		DRM_DEV_ERROR(dev->dev, "unexpected MDP version: v%d.%d\n",
 			      major, minor);
 		ret = -ENXIO;
-		return ret;
+		goto err_disable_vdd;
 	}
 
 	mdp4_kms->rev = minor;
@@ -430,7 +429,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		if (!mdp4_kms->lut_clk) {
 			DRM_DEV_ERROR(dev->dev, "failed to get lut_clk\n");
 			ret = -ENODEV;
-			return ret;
+			goto err_disable_vdd;
 		}
 		clk_set_rate(mdp4_kms->lut_clk, max_clk);
 	}
@@ -452,7 +451,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	vm = msm_kms_init_vm(mdp4_kms->dev, NULL);
 	if (IS_ERR(vm)) {
 		ret = PTR_ERR(vm);
-		return ret;
+		goto err_disable_rpm;
 	}
 
 	kms->vm = vm;
@@ -460,7 +459,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 	ret = modeset_init(mdp4_kms);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "modeset_init failed: %d\n", ret);
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT, NULL);
@@ -468,14 +467,14 @@ static int mdp4_kms_init(struct drm_device *dev)
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		DRM_DEV_ERROR(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
 		mdp4_kms->blank_cursor_bo = NULL;
-		return ret;
+		goto err_destroy_vm;
 	}
 
 	ret = msm_gem_get_and_pin_iova(mdp4_kms->blank_cursor_bo, kms->vm,
 			&mdp4_kms->blank_cursor_iova);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "could not pin blank-cursor bo: %d\n", ret);
-		return ret;
+		goto err_put_cursor;
 	}
 
 	dev->mode_config.min_width = 0;
@@ -483,7 +482,23 @@ static int mdp4_kms_init(struct drm_device *dev)
 	dev->mode_config.max_width = 2048;
 	dev->mode_config.max_height = 2048;
 
+	mdp4_hw_init(mdp4_kms);
+
 	return 0;
+
+err_put_cursor:
+	drm_gem_object_put(mdp4_kms->blank_cursor_bo);
+err_destroy_vm:
+	mdp4_destroy_vm(kms);
+err_disable_rpm:
+	pm_runtime_disable(dev->dev);
+err_disable_vdd:
+	if (mdp4_kms->vdd)
+		regulator_disable(mdp4_kms->vdd);
+err_kms_destroy:
+	mdp_kms_destroy(&mdp4_kms->base);
+
+	return ret;
 }
 
 static const struct dev_pm_ops mdp4_pm_ops = {

-- 
2.47.3

