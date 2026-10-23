Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC69606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 15:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=X1sDswPR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hS3MkQxu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1450E10E676;
	Fri, 23 Oct 2026 15:32:34 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E661910E691
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:05 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NE6IC73557697
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=; b=X1sDswPRvWoxklsQ
 sMbFRQXSzQ626ji/o6HmiEmTpXl31Wv2H0UxWZlZd2BpCvFeu0obZ0vzngr+A8MH
 su9ZdjfTsF8uUA/gQAUUTn15Z3s60NoEU0xu3mwRSiLXS1prtknqiaIy7HLGbZKx
 GlWQ3aDJytx5lxX+EQ2EZjJ2aTz2E3ur23d0Iv90crnXLMcDlL4zScGCuvTJ3baR
 6eLQM+1QLkEwYRqkqk4dGQLboHa/FyHWBsAUFYM/U18DRxbVmA6uRnJJcORKFOi9
 wdQwy+ohc/s7YddsGkpGCvzSxqNiMHymZycyW5RCEPTMF4IalpY8AT/OMwsY0HPg
 lobn6g==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmjcbme-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 15:32:04 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-99077a0be0bso236162241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792769524; x=1793374324;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=;
 b=hS3MkQxuyf8KPjlOYXPCjGM3Sgu4ww6wVXcKXcIM5L6fd1wZJrJPNkSi7YP94FR/Nq
 czHDwUZ2rmBSQTsnCwZp++qBFxlSQlJYjG7xZEqNuUINCYifJb053ifIcosaUN8ROZgY
 JAYJ0vNrC38tiNIlAY/gJCIAzbEwQJG3tA9MVX6OVfMq7xgcREGYOzQP+ExFhtXkunl/
 mu+0oW36dq/jNRCq14LtDPkxa2fzDGj+AOGzowdkd+WaVEAtFxHKKhlQkjC7L744U1us
 BcBJTwR6yzT9hc5uc2c0CP9Es9F6CrEyvaDhsjSB59pOFmJutNlrKr8eURwlaOHRW0qK
 iz1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792769524; x=1793374324;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BHN0xNuoeyIHKTV1AFeaVEsWSbzhZXzn9ubdzSnUtM8=;
 b=oMlF/81MdZcpZbVs+I1S3HI3FvJ7YY0j4l1mLoAsdFiECFGOhX+J7wHWxEg4EA7IZ6
 TiuuyxzAMco3sP8bK8Ueo2Mum5ArUIpewcY5leeCKUSTzO7fZ+XFelWSVIsAEkrQ2Ym+
 QIBS5J6OWWBvCm5sINI0UNsEm8PtFAuPBzolhj/nkqvn2G7dlQjFjMGaIKBd+S+3oqOm
 9a7X3rqv3kVSuRJUjahbCbuqUtUPrNIficSip1WFXFwAAuedDCHSXUKcagbzcfyA+6VK
 YL3JM6zaGW1rdjkk8jZugtJtamEhhqRu8Ww2s5zDIZkMJnBLgkD+eq4A/f9Sa57nUCXz
 HOHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxzJ3GViII/rC8fQGx/Zp/nIx7BK6ufdnj1Xf3yKdorgVujStLiy2fgHdTPlvWZw3lsakGMpiQY4J4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7hB6qw6WbzAwsTiPQYqYaQAK5ZydbLtqmAD0gmdxGzea2rInJ
 2BUPxyyJMv+9aG2V+BVmx1SoF3zhUNWPxcxwRzKDNVhpP4wPkP4LhuPdaXdMCt+oirbjrGauXZ4
 ghV/TpEywS5gtJ5E108DaqQFSIqu+dlz1NLz0atTYgUbCzERLON9sp/faPoy1dptSiTaK4pw=
X-Gm-Gg: AYBFou2cjw4HJx0bWqcNw928eFoUYTqSZH6+/s0IuM8t1Vs06gwYw4ZwuMSfIUOEz0k
 a+MwWd5XzOo34RpPMBP0N4PF96j28i8VD/P+0SaQ0ny7hYJzugRnW+pUEPJtdW5dNaZEXdNh4SY
 slYbBIzOAJ8iw57aXq2BV32I+T2Bwwcg3e8nap7OhRkrGrPQCqGc1WuG+t+q/S7vus8HH3ch3Wg
 GXsX7KoyeXgtEe23b6Dx0VwqqK/458EMjThFsopVJ+VyRblUI587OPJf3pap5YDpKZ4grPpsWCB
 2EvClopY5x8J/9ZdFbhA5xdEsUGzimfQ2+hB7pWQPfAgoP7bAYv+JV9EFYf88Ikheh6Xf2ZOXyk
 zn6YaCw92puIvJW4jVRZNZ4DTmnpBoqr2Fe+meqKFbuo7EKYqhZNu+3bw94RdwpxDAnYyd5Ri31
 oG0eEjjumLj4FI
X-Received: by 2002:a05:6102:3f8f:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7ccc331edcdmr1088009137.30.1792769523998; 
 Fri, 23 Oct 2026 08:32:03 -0700 (PDT)
X-Received: by 2002:a05:6102:3f8f:b0:7cc:2cd0:e74f with SMTP id
 ada2fe7eead31-7ccc331edcdmr1087972137.30.1792769523376; 
 Fri, 23 Oct 2026 08:32:03 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb0288806sm478062e87.55.2026.10.23.08.32.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 08:32:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 18:31:26 +0300
Subject: [PATCH v2 11/14] drm/msm/dpu: clean up the self-refresh helpers on
 teardown
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-msm-kms-destroy-fixes-v2-11-83727c122de7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2139;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=x7Um4Zh4cOtsynGFkbo/mRPO0qZY+PJocyHznMzNkZY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq233ZHl4pBqK6GM2pkabWqcafnfptjGyjUp5nt
 wQ7oVrPkn2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatt92QAKCRCLPIo+Aiko
 1T9uCACEyuDjbPE5Sh7CmbTxW9KCKHATXRdnYKFmXrAh13+g/Sr2SZghghJN/nbNrXcrhOFudX0
 Q5Pg3v7iYALaUcqQMbFdc3pACqHZx3y9F8hl2dzqbSFCncnn3+4p5FeSDmfNzeFhfBUoBceIbA/
 JhDCiTUyQ7i5721hb4tu6RWQrwfloqy4S9dcDuYvHORzqelHWXIojdFWh3mW0lxLXnEaDCs9PAO
 dtaewrdH50LZDPnyNlC0kDbMDijjt57etpNNp9XYbhf1T0CgrkrZcLtX1UMsVIFX0+sNlJjdgZS
 dSL2X4xeSL7nJxW5oQsS2F/t1wH6WLJnFdQhgVUnxQTS20B6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: lIB1Q9Jl9QFRt5hY2VeN2MHobVHtKcuW
X-Authority-Analysis: v=2.4 cv=cPR1IVeN c=1 sm=1 tr=0 ts=6adb7df4 cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=r-hXt3OJkovplFG2WMgA:9 a=QEXdDO2ut3YA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfX5LmW92ClDzjI
 IEG2D8o5lGk0NA8PYTkGUlwPQWpdKtRiMDKIpys59pVCBbSWAbdNln/vdGaLuKa75vKjRWNOKum
 oxIT08yjSOUq89yVnRpSD/LWnkdKneU=
X-Proofpoint-ORIG-GUID: lIB1Q9Jl9QFRt5hY2VeN2MHobVHtKcuW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA2MCBTYWx0ZWRfXygGv5bijKgKW
 YQul0jiQlffnbGijyJvSaRBH62ErhkbJk3zmrjHI5HHupAGgcZeB0d+kWjHfUHOFNqNfN/uh5qF
 xm+ixIJjd6jLVN3U8/8WSErTX5sb/EkTUdxvna8anVkKRLTd9k3Xio19A7t3jKuDshI99lTGbIj
 N0DHP2Nyp4/fweq2gSVKIJWT1XunX6SMq/Eq1ZYABAd7t8f2oz5KwHwm34eyK/1C+ndZnGYOPQP
 KwtMqu3La2whg4m7tvNNtb6SSum3sPqudzTdIiwOdVLmcwOKeaGV/igr1wjigB1pYo9YbBqNNF2
 OksOTWV5Ujw1LX9uLexHeqML78Kdyj2VATOdB9mRf9KWk3jAc26sfMnRf0EV4/NeUX8rwiQcIuf
 L9rAimHox8biQLMf9cNag6aiJdfrqG7kYfCtpb8F3il6RjHJaBxXxm5QSrpEBTEXHvcATDAZ2z0
 JvAkyqdJQ9/g8VL2QtQ==
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

Unbinding the display driver on MSM8996 with DPU oopses about a second
later:

  Unable to handle kernel NULL pointer dereference at virtual address 0000000000000870
  pc : drm_atomic_commit_alloc+0x10/0x9c
  lr : drm_self_refresh_helper_entry_work+0x5c/0x1dc

dpu_crtc_init() sets up the self-refresh helper for each CRTC, but
nothing ever calls drm_self_refresh_helper_cleanup(). Every modeset
commit, including the one which shuts the display down on unbind, queues
the delayed entry work of the helper, which then runs after the CRTC
and the DRM device have been freed, and its data is leaked.

Clean the helpers up when tearing down the DPU hardware, which cancels
the pending work while the KMS is still intact. Doing it from a managed
action instead would not be enough: the DRM device, and its managed
resources with it, outlives the unbind as long as userspace holds it
open.

Fixes: 1122697810e5 ("drm/msm/disp/dpu: add PSR support for eDP interface in dpu driver")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index 65ba8fa697e9..934ba47b2dae 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -17,6 +17,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_file.h>
 #include <drm/drm_framebuffer.h>
+#include <drm/drm_self_refresh_helper.h>
 #include <drm/drm_vblank.h>
 #include <drm/drm_writeback.h>
 
@@ -885,8 +886,18 @@ static int _dpu_kms_drm_obj_init(struct dpu_kms *dpu_kms)
 	return 0;
 }
 
+static void dpu_kms_self_refresh_cleanup(struct dpu_kms *dpu_kms)
+{
+	struct drm_crtc *crtc;
+
+	drm_for_each_crtc(crtc, dpu_kms->dev)
+		drm_self_refresh_helper_cleanup(crtc);
+}
+
 static void _dpu_kms_hw_destroy(struct dpu_kms *dpu_kms)
 {
+	dpu_kms_self_refresh_cleanup(dpu_kms);
+
 	dpu_kms->hw_intr = NULL;
 
 	/* safe to call these more than once during shutdown */

-- 
2.47.3

