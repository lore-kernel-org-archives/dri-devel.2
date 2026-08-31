Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6ACC624A5
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2DC10E73A;
	Mon, 31 Aug 2026 08:19:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hrnB54V9";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AR2mpmSo";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8EFB10E73C
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:52 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67V7xjxY2419583
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 6fG6edY2B80yevoZeN3MhpTgETb0AMUhGfbVvl1yPtY=; b=hrnB54V9AY/EhE1a
 9XqOguZrtqVatrWgxs2i5TZ4VeVTY5yTs2zd/ujJ2RG1PktUbFGFxnlvXRyoHSsf
 nN+XSmkW5rc8S48GcoS8mxYZM0PiuLE2ZnOrWz+NuM/GBRfAjLpI3mHrnFxQW0oH
 t63p8VjsxG0C+y3yj8fa6R7H7P1AUzv4BtjaBHYJWma3bGC9Z3UtEnHy2zoSY9jB
 C2YBCgktlcGA7YPz1cv69x9w/8N34IXzp0T2lqQ+CoPYFonpklTDsTxgoSs5ZT0+
 UjbyiAz/R/qtSvKli/4VH53v56aOte2EKn9fZSBQnMDz9QHaUKzPxDpjsKmz7e8p
 EIzqoQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gbqt6nc81-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:19:51 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9390a2c895bso705506985a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 01:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788164391; x=1788769191;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6fG6edY2B80yevoZeN3MhpTgETb0AMUhGfbVvl1yPtY=;
 b=AR2mpmSo6JBW5Rw+pF+AVVPY72HXVyOqfrHcw6kfF5WgvfmtEnxN8nXtEFOrhC/8TQ
 cCxdiPSPJkK4h9DDCy5cEVV8wJ8WSUBs/EKqQiy0r+0FVMfb9tVZEI8DMoXCCDPIos7X
 7FBsH243ZkZ8qfzMTVsCC1unY2BnSOcqrzuVyLl/w2iPvkoiWMOX5xdVT/gpTP6wzpmd
 4TlcQAcPyVndtxxJ9Izr9ku7rSExx8Tevvp10meObadC+PdjSgZQTOfoq1AvUKwdIBI6
 Sl/8KfTk+iLxkRRjiE+Ci3tzFSmG0JfFVnYhRxwfCsBeZZBxAPY3Hfer7iyJzkvNuUMk
 4Gbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788164391; x=1788769191;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6fG6edY2B80yevoZeN3MhpTgETb0AMUhGfbVvl1yPtY=;
 b=UIIasQVPDyVoScnD0c8FGfiBsq9qtcpv7sKrK0liQusFXInmBcLtzfBh4ZEJSMD3h8
 VqvXoKlixQ8UWqjTenjx+plGymX8fn9PYzeBV+xy4yc9sUXeFa4dLfLnu24ZqSWaGKig
 qAryHXNDhWktJoEuUxJDt5/7H4J7gxAReafkf5BbfUW6CDv/F19OWl+SDIDeYX8RMAsW
 ItsK89jkjBIqZfB2HwvTl5mm3sDk+m7Jb7Zd30u3vFito6WCM6I7gISI04Bg7Uu8C5g+
 nXwO1G1/l9CKkqWK502NQ10y4QYECh8fYhRP2os1AgUBh6fRc2D4AHHv2YobWF2cBSvn
 pt0Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RqK1hv0BiIPFDbe6+j40Rrq+294N0wtxrVkJM2VRhBBSpFDnL+SjJE26wrUlK56cqQAzA0IcBJOqzM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3gv0gb/vXQ9en64KAUdH0hZdm40Dyr9vmfWAtAfACT/b5ZnyF
 ktyMJdwubCU37Hm0nE7ZnlJ6MRamDORN2xN8Xu9PTzbJ3doXMTV+mM7rcaqaGcQ+wRkVE8YdDRQ
 BU2ykhBFueLdN/vQ6Dy44piK5pw6SD/eAmxQbFuaejICsYoUfAT+YRk4kMPxXrnCV5Q+szg1vI3
 5IQS5Dqw==
X-Gm-Gg: AR+sD10NP+QKn7z4cBTYPfvvYZt5loIQFq+6M3Q3W2B1LmkYx+3b0XSqUs3scjJ4Pwa
 jYtmqSjK8qYlS/mG043Ki1TJrE+ga2hkyfCKrtPAKh4eTfxeeJe5S7IiBgcHbhJg+n5cUEGn2TG
 sLMFyhfRNaFzxJimWaISTt1gRhBbg4HnCcp/ehP60Bis+WDuM+RXUPDxfxuKfQMRCtnZLf9RVIx
 YjzrE+VP2NzfUf9ApkbZU56ch+Ti2iUzBTIYeO2vy7ow9ZiFMzmuXQl0mRs/mrk+QO/pVJ7GUIN
 Kf1My+dgsJC3cRa0pnVYIKS9Ikf3DL9Gqq+O0Aws8ejwB2wZjrVkj0TNDH3eYZTPt1ocMgswt0P
 Rv8a1GNJ5GQECl3K3xwWpQUfqa5vC2FaFN1X3K49atXdfYtQs4T1hjBr1Gh35V5I=
X-Received: by 2002:a05:620a:2b8f:b0:930:f35d:41ba with SMTP id
 af79cd13be357-939139565fbmr2873411185a.36.1788164391204; 
 Mon, 31 Aug 2026 01:19:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8f:b0:930:f35d:41ba with SMTP id
 af79cd13be357-939139565fbmr2873408885a.36.1788164390771; 
 Mon, 31 Aug 2026 01:19:50 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93917236b86sm735974285a.13.2026.08.31.01.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 01:19:50 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 31 Aug 2026 16:17:42 +0800
Subject: [PATCH v6 25/29] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-msm-dp-mst-v6-25-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
In-Reply-To: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788164246; l=3337;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=wMC2YihO4QtFdymka/2UJ8jIACbnk36l94X1rDU6A9s=;
 b=Oivxgd6UPuqqiiOJ5YCme7iDXl+Yq1ae+wyNRNEeQeAkfWKGqSox8YyOSvZ8b1mKENdqI0t3x
 1Y4jFquGX60CqrGrf+aYe0r0PFKFBqlwuFNtki/GczqoMvTZ9WzsdIq
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: VnIN26Bj4p965AyL5HTIgNdhordL63_n
X-Proofpoint-GUID: VnIN26Bj4p965AyL5HTIgNdhordL63_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfXyS4ZuBklgSr9
 DW87uWd67AQQxqvL/xm2o1AXVrv877Fx2KKCfXPTQbYBBaQrnE44wxy4YtAXvnvgVadY4BSdRUf
 DKOWHWC3vwLoFyF6c+x9yCXuUySD4yEot+RFtGlhMYnVPMEhCC85Vgw+2hJ5gdR097olCBM2AVK
 1XGwAcsMHU+1Uc16x77joKaNemxukDoG9fWg9t143hHBx1LFnOW/b9Sf4Q2nRlEh9YD4ijmv8UB
 8Ae5TDFxZ2f+jMNKPtm9SpknuRYW2bktzSZQcDXw98hdoKq3z+NOEZ+bFxBeWf+zK8iMotC3UYe
 YtIK0jkhmxvfLG17lHMEYl4AhMXvhAZ3pp/S9GtEol+O2vHK7b1aOXmlDsgnubHT4DHmK8vEcXH
 +pa4NrbdHs5d8Y1PEXKMbfLWvCd95nzISje/zhE83Tcz1EQVD4gPsOU/BQm5WgQYhpkWTbn1J2P
 oeBHCNuA/2CaiPF3NLg==
X-Authority-Analysis: v=2.4 cv=S8/pBosP c=1 sm=1 tr=0 ts=6a953927 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA3MCBTYWx0ZWRfX31819I7I2hFa
 IUrMMkcQ6g3xFWokEaSsoMNMR/Tam71yecwFyejisA6SkD0EIV5/oe+DFbbIb88EmrwBWPPBzjm
 xVQWeDYFsuZJd8yliNfdup/zqPZ5nzQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_03,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310070
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
index e9a7c9332707..fd0675797fd1 100644
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

