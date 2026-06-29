Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08398C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F3AE10E8D1;
	Mon, 29 Jun 2026 13:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EfDN4d4p";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e05gtBE6";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E7A310E8D2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:25 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATSij2592843
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=; b=EfDN4d4pjXGiApYi
 nFnUPTb4WtSWyLwOOWqUq79kRJSR3cwtC4646d6UjN2folbe3f5qAL74/WfoDZ+r
 96CCYcv8pYWwPsV7L3RkiDa7a8+nnau8q3euZ6EKW8sRsrcfQWG5xuJYRUFXs1ic
 p3NwW+4+Gx7QFFdqkWEn9NNzmP7mxsS8PKiKgYdXl6JHFOYIAmO04DI+VGqGh3br
 0tsNPbLOjCeLZSXuXfRIiJpYebzzJSOnTpBa53c3C7RQyxOUjB+VjKDfbDPP/PYi
 QB68rQWBOfxrEFobyclM7wTCrEp0zxM6jaTwPWZKWS8FwAq0v70FrDOP4SmSBIes
 AY1ypQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vhtdn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:18:24 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f05dd0dda9so36427796d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782739104; x=1783343904;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=;
 b=e05gtBE6iis7hDLG+aQlduMtNVrlUNkRHM/YEkuPTYixzr5Ey4VZVCmtQddJqQXeOx
 C1TqjVTknTtuHxgvpOb8SaGUjKvrei0yOO6yvCUgxq9qzzc2TUIfV1l43ozKj9RJnl8b
 SAfCuHbektyrcQk5J4fYSKgIf3O73PAv8UaVw/vzlHiZDiVRgYaeu51+SlUJubncSe9w
 zJi0clB/oC7WVphXul2qHBftGNCGTi8r5x8KCwN3Dhond+VU0p1mB02DIjMwBrFgZOej
 YJBvP+QuN8SOFQPjXmQ90by/iOAVCAe0St7ByTJcSD7jDbMkMQp1z5gJuzfXQRfjR4XN
 Quwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782739104; x=1783343904;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=;
 b=iJFA8DHC9walCyxtHEuh18GMcDrPnoIs7z2v1jNX1Gj7KurKh7IZNUp8zE4rbK143R
 1kRKvRBchjDtE/emdnT+GOR70VpUqJXgo5baV6I9Iih9vVizstZbwSOQWHtzm1QQQU9X
 aeU+e1z76g743YVfx0hl2d9mIM1J1V4yYDXkCAWDnf8MmuJQU8TZvYOHEkdbfOiIgbz1
 1xzl3NMt2DoiKi/tyr+dEkVgqmjAKnEP2L2NdH+5d48m1MQi+hoivJZifK+UVZRWwtyv
 lwVg66yN1d+nadCybbEgu/zgBL/OalM8t5jPzph0vNCtiXGCYcgIOuVkGD7GwF5YQ0OP
 VYlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrZfoqnkkpUIBTyIv5I3Bar/ST59g2+UFJe2y10BaS+Ogxf6neEezUmEzUc1aq5WzHwZg8OxXjklDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys8990g6UWuGtDbo5cCsaAU8WZxWXTvUwreS3y6vorjpHNnACB
 V0MUNaaVbA2Sl+gXfTqRSSfVutOcfAN1eCuxtIjOoh+VWihgKOLGs9K6EXShAL+gZ31fiOkcklu
 8VGij7ilR11TF5B8XkwktP3KP7M+6uB/utBvlYqUxMhizwcgBTne6OCder+Dwl+Lbg0MLaYg=
X-Gm-Gg: AfdE7cl9X0ZqYiyZjkCPNJ2RJbj2lW2NCJlx1uWK3b5QxqvJXGvsNp+XJ7jwqrWU8Ds
 0BFTuFLOZMUafZD+s5qmPv5425fErEyLnM075/DeS3rbChTvn0wEcLsW+6K0lugNu3654YYx8/v
 F62xG3h88tca3RoyS+7S+4T4Xp4tkmnrtTfkebDZLm1HQbbjsFhuwLlzbms7ueexbD3W+DljOpG
 Dgz2F4HKyj9o/YlI4wNbUMtRRAU7OnRS9lr8Wp6Jn5WFBmy2FrGKmszSHaiF7vWccoTxpa9mRb2
 xTGS88MPs+hpbW7mPdbKq8qGzKBbRbc17DGQqRCdBKqKwwPjzxIGbg+gYsDFIZzxFMzI0uag5xu
 iMwcptucRpc3pQ56dqXGHEBbfGB1lHkM9U3VE42YVORPmgIN+nko8UIYReSYS2FBP62UL5/6KFQ
 ==
X-Received: by 2002:a05:6214:2a8b:b0:8ef:e7db:1a91 with SMTP id
 6a1803df08f44-8efe7db1c83mr58422656d6.4.1782739102364; 
 Mon, 29 Jun 2026 06:18:22 -0700 (PDT)
X-Received: by 2002:a05:6214:2a8b:b0:8ef:e7db:1a91 with SMTP id
 6a1803df08f44-8efe7db1c83mr58420756d6.4.1782739100211; 
 Mon, 29 Jun 2026 06:18:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ef0f2b9df0sm56744616d6.13.2026.06.29.06.18.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 06:18:19 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 21:16:40 +0800
Subject: [PATCH v5 22/25] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-mst-v5-22-1d882d9012f4@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-mst-v5-0-1d882d9012f4@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782738985; l=3337;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=b2i238VUI/AdKzoSuCKAbFa1dbTjNQRwjyN6xCNz0mo=;
 b=9cT3aQekbGmcWb8Knq3maYHywYSVMhy9Dvz2ZE/x0ybyzlMp6YTz3bw9ad4bbocaX+Qq+ZnPR
 W2dD0oUOgJ7Amc4a8Tgn5zU5WBCoNWwC3VL8+Q1/hVZxobHPiEza9m/
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-GUID: SMGSrsYO7OYU65yi-VRogtoNuXB9nZ5H
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a4270a0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6H612DHON8qE
 4REqNXB//o4aZku5QQMle8As3QFR1yZF1nmYYt1u3+1B17Hk+3fppU+P6Gg4xu8j4BrjLVSkM71
 Hzgy2wZlsnnBgJ0Xhvxjgv6w3gMjamQ=
X-Proofpoint-ORIG-GUID: SMGSrsYO7OYU65yi-VRogtoNuXB9nZ5H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEwOSBTYWx0ZWRfX6yJDqmmJaJS4
 +x/E80I1ea32cS7kgaygK48lBeF9EDUYysviqZWityG+2Sj2Zm7S+xj92siSkFV8fmlS+o1hmP8
 VgH6ZKfrDsl10GbS24EclrddRX0oMclD9HNb/YqxuikUMHCvRDmNVl8mDq9wWopcAytYrEUaQ9v
 yKElYKbJaAD2WxPbILi2j8RiI6pK4JP+EFW0U+fFr3zj/WpWXJFIv7qKBcKcZGzxMmk9JgiqYNO
 LlSqVAxD86UEfh0D62QHxpQL8RuIM/xAL4Xp12bdmCqmtJnPV2g7iUWLx9gkohFFpO+W4XosjxZ
 wKO+/Q9sGsu/5Hb0ydFMvHNA/OwomKLaU+sA5qMiq8ArF0P+rDrFDvvOg3prw4Ho8I8fGdmMlMQ
 E0WD9p/id0JxUU7t/dGXiNToUByHQfGyM2IxxpfU1mn+xh3tscA6RaSuUmeJtnqK5adpn8NmZY6
 REUswqo5/nSyGjg44Ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290109
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
index a8babf1dbe0d..e70e5088cfe5 100644
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
index 963303079220..f71200a790f3 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -213,6 +213,7 @@ int msm_atomic_init_pending_timer(struct msm_pending_timer *timer,
 		struct msm_kms *kms, int crtc_idx);
 void msm_atomic_destroy_pending_timer(struct msm_pending_timer *timer);
 void msm_atomic_commit_tail(struct drm_atomic_commit *state);
+int msm_atomic_commit_setup(struct drm_atomic_commit *state);
 int msm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state);
 struct drm_atomic_commit *msm_atomic_state_alloc(struct drm_device *dev);
 
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..33ab30300e16 100644
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

