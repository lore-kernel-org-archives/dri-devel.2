Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD032606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UeE4XOKZ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=R+Qvh/YG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 367A911216C;
	Thu, 19 Nov 2026 08:26:44 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 126C3112164
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:24 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6v3g31962316
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=; b=UeE4XOKZ0qGuqGbB
 P3n+1cscfKUln7ktneDNruBq/4RT6WQdCBa+AjoNIyUW3cvJyEf3cOaYddGcVJcb
 Cuk07cGZ3wSO1WWpGmHamMcazNSQYYFiBAfJCk+YYA9wYk5ZBCZzpr0/Tc7RU1ue
 cbs6H9gJSgPKKsXu8GWZSYnbw+mharxk54P7hi8jdKfzkDSTYGg3rr+9MACT0fZx
 haB4uRNrm9mMxkL2pSFb+mII7I8NdjdjIGKdpkYNUHIhP6n/ou8dDHmq5KuQDV4l
 DQwQ2XNtaWKqRuJd5NQ6T/iys2DevnN28YDFydwPoG/Rm/GheXXQPXjpg4Qn6oWS
 VqMx2w==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1gxcu90g-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:26:23 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-949b0d322fcso48529385a.2
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076782; x=1795681582;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=;
 b=R+Qvh/YGs+x3KSczfx+pMVdT7mi1yM6uKABiUVWKCj0QOn9Luy5pcRhS5KgFhATj0u
 wx6BKEmB0ScMzSjQF3Nq9H8B5hAoFMtiYFppAdoqEcPltxT79SfbGa/AUHsuM9DahdD6
 9HuqkGABY3qDz4mmVyKVFNhX2oAYOTNikbs7ABPQ+DKwqYtKew6/eIAtxYNHDgSpwymx
 5NFUuO9D+h11mE9+xHCVXzKDscSDforDMkVoMMjBr52m64/JfTDQ90qwe+Z/WrGvPk2r
 2t37vjFrLKo90aXXepHLS612zASanbixQe3Wd/EBFftBpJuktHryyiXuov9fC7yHvbUs
 DBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076782; x=1795681582;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gNMAZ74nOlHBL+Q6uH6uEldYPzcE1yDEmKde5l1Npwk=;
 b=SPMpKwdLhRx6BZDQXO/+SF1gLRqXoxe3HcRBHxMO1hFWZ8/xdm/tuG5dBvNOpn78ei
 yCROGM46WAEccUZv6104W51OiAiNVTCpwxetEK3RyiBc9UBaoc3hWiPAUTjddpcLyVim
 WHDqutjdP1+1vs0WIXpQrsKSIniHX3gUdef0hsPn5UaP61Iz020GU9XWze9IDZF5UzSV
 bDVC63rTxx5CfPeQbdF3kjZ88+tsQyoCT9Q/P9ifrTufiqR4SO5ApY4BqQo5gX51cx1B
 1wuRSv0xywr/TcDInG4BNMC5oadmEpzvKlb8AcY2AI8QB00GyL9Kgnj2LduDZbSzrPco
 /Mvg==
X-Forwarded-Encrypted: i=1;
 AL+hErHcjqE5j7lF3qkW7fMdZXlAyomagKPTbcCRQbonEDybHb84nu3XHxJur0GDeSoJvdCwMsW32frKbmI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/IKBUFg+NLF+i2rvZAVqoKJhG8NqDQVRxdYtgMxSCcJymmy+cs
 vYMutHNltwRzwWN6i3hBnhZLo3y18WhLd8H/iwz0/8ErVNrfgV/P22sPjGBxxMb+nb6muN526Xa
 bSo12vC/3wTWTb8r7KUCy6z8JzHIJF33mm57E1JxXZRk5Z8NkgnhBoFaEi3bo2XmMouP5+I1csd
 o92Jdbog==
X-Gm-Gg: AYBFou0NdFrs2PqG3Ur+/rNax/D+NMfngKRPEWiSz26DsOtVscYfNFRg+pooaqGS3B6
 IRaRvpHwKXJEMrzJJUhOpVtHeM9fQv/Nr/4++33CYCvRfLpelivy/Zza9St67y+EU+6TMT+aJeU
 N3mhbupXbMMdTL+KE6CUBz7RIHpyIvBNezzDA5pUJ69mfmF+X36pqRg+wLnpq6wDlsN3mCYX7ZO
 jfNVd0SbkpRhdDYRgxQaTz+QtNJQE+SfQ7GyrhpCmfBM0kArXCg/7BMZrOknwlbrZO6Bb3vjznX
 xDwXzXhDzI+0f9Ek+aPe4CIgDKxdUqrcfK9aVNUfmJxQu6ppy/cwnxkzDhFhgyhyz7Ai8Ggrbjb
 STQtmrPuBs6w2R5lRDQ9ECxEoQzT//glmIcpT1Baihj7pNPqc/LDDaeaBv1ghgmU8QZkOByguuv
 OF0OIPirQOfyQRzlQ7p6TA+JXH0bK+mGKIVINU
X-Received: by 2002:a05:620a:2685:b0:949:3ec9:9d6 with SMTP id
 af79cd13be357-949995b3c78mr1017347485a.43.1795076782483; 
 Thu, 19 Nov 2026 00:26:22 -0800 (PST)
X-Received: by 2002:a05:620a:2685:b0:949:3ec9:9d6 with SMTP id
 af79cd13be357-949995b3c78mr1017344185a.43.1795076781955; 
 Thu, 19 Nov 2026 00:26:21 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.26.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:26:21 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:24 +0800
Subject: [PATCH v9 22/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-22-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=3343;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=AdBLBWWEc6vpplMBiBDW6FZCSILo6YakvdgN8c22ZTs=;
 b=+cOROUkoNEA4cqsakkFCRfX2TKkrdR6dgMiWA0GRDTHUGDl85/u79RVBHRNfcxXdqsnnpL7wD
 pjbanPSylqGDo606VHITWT3mqohyUnW6SUndZHOlpjDzt4fW5zjsReR
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=LZapeTfi c=1 sm=1 tr=0 ts=6afeb2af cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: kWh1VUctx6o8ZDTtM2UXla3804Y0uRMJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0gGI418SxaGi
 nfPUL7+KTMOrDU31Wae2Kd9XCRwkl+dM0y86wB1inCV4MCWChablrIzT3lVN3Qg6wuo+lbLW0nz
 qZ9lQNrHMhhmyIgF1djWPfeE3ckFW+OMzQGMfO7Fm07Zvo67l19NTQoWZqDpjqXSV5McGpuTiGs
 x8VNl/Vke0p8KGfBx9Fn1m8Q39vOMwrc3S4ACzoHZ8KFzlKUzALpwEZG/EawmyTRDhBZv2IMGQZ
 h+9eZ43kIruGReDFgVPW9lLLsmCcE5nnsfrgmov/TEz7vSgRufAC+Km9QA0ovl+oOLkKdvkAzcI
 CdjyVtR/eWoSMQh5+nwQwtpBqLWanPaK3W8SSKQh9iYtLFffOtz9ziqJbEpR6JxKoyiXGay/KqY
 ySJlMyVEjSkfdj8BMie6ZfKaw6xaZEmaxICgfUAtM4/Flu9+VyVfkqOajv9XK4GBATx67du1qkR
 yf1E4QQtAkdP5jweU+g==
X-Proofpoint-GUID: kWh1VUctx6o8ZDTtM2UXla3804Y0uRMJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXxclWsl9qNe00
 8tmMr42oE/7zTudB68jkvwK5aXDyHL4SxqthUXrLQvPW/UFY60HGfvpqKpYwinJHFkQXnf72/Kq
 KV2FNhmDu7Oe47SRNUae8rwEWz5MTIw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611190033
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

Call drm_dp_mst_atomic_check() from msm_atomic_check() so MST-specific
state, such as connector and topology changes, is validated as part of
the atomic check.

Hook the MST helpers into atomic_commit_setup() and
atomic_commit_tail() to support non-blocking atomic commits for
DisplayPort MST, and ensure MST commits properly wait for dependencies.

For SST, non-blocking commits are already handled via commit_tail(),
which waits for dependencies in the DRM core.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_atomic.c | 14 +++++++++++++-
 drivers/gpu/drm/msm/msm_drv.h    |  1 +
 drivers/gpu/drm/msm/msm_kms.c    |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index a8babf1dbe0d3..e70e5088cfe53 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_vblank.h>
 
@@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
 	if (ret)
 		return ret;
 
-	return drm_atomic_helper_check(dev, state);
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	return drm_dp_mst_atomic_check(state);
 }
 
 void msm_atomic_commit_tail(struct drm_atomic_commit *state)
@@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 	trace_msm_atomic_commit_tail_start(async, crtc_mask);
 
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
 	kms->funcs->enable_commit(kms);
 
 	/*
@@ -322,3 +329,8 @@ void msm_atomic_commit_tail(struct drm_atomic_commit *state)
 
 	trace_msm_atomic_commit_tail_finish(async, crtc_mask);
 }
+
+int msm_atomic_commit_setup(struct drm_atomic_commit *state)
+{
+	return drm_dp_mst_atomic_setup_commit(state);
+}
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 597728ec6f3b5..ebbc138935c43 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -211,6 +211,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
 		struct msm_kms *kms, int crtc_idx);
 void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer);
 void msm_atomic_commit_tail(struct drm_atomic_commit *state);
+int msm_atomic_commit_setup(struct drm_atomic_commit *state);
 int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state);
 struct drm_atomic_commit *msm_atomic_state_alloc(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea6294484..33ab30300e16d 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -29,6 +29,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
 	.atomic_commit_tail = msm_atomic_commit_tail,
+	.atomic_commit_setup = msm_atomic_commit_setup,
 };
 
 static irqreturn_t msm_irq(int irq, void *arg)

-- 
2.43.0

