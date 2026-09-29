Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4943FC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:29:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A97110ECC5;
	Tue, 29 Sep 2026 04:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QldwBsbK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EvPJsnBa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A278D10ECBB
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:40 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68T47fhp4052905
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0ucAewFEOicvP/KWQ2feDjZcwzUKPmoTcok5VDj8TTs=; b=QldwBsbKXBs2hZlC
 SxtxMDzP67Vm5+9P730PvE2bIQhDjqbYe1kwVSAyg0qK2XoUnC58uHi0p3v6vN8Q
 7h+yF3GTgXLT5DYXgKv/pXXKytbjRXrMivp6+/FwD5aOtcyv7BaG9PVIlx5P7rO2
 6Z0M0tSiNHE0Kb0mmDoNiHYjbA5KJOPfnK0xZJ8wK2OF6ZW0ACUM0/HN+ZaYdn6k
 Z6tRFj2ctz55L+qEnV7NQ4Cjv9HzbVThvlmMZw780lce6VUiDBI0uk95P/Z4WZL7
 RWmSTjfIFdspKQ/IsK4okk6nY5DMJKFIxZZVqsGqHpjpmWcbyYe/FwXWXBjX3x+2
 d3v7jg==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxg2h1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:28:39 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91786abb5abso6347026d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 21:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790656119; x=1791260919;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0ucAewFEOicvP/KWQ2feDjZcwzUKPmoTcok5VDj8TTs=;
 b=EvPJsnBaXULEkPOWLccMKVAB4pFWuELfBrdIPo1cBMrqWz2IzvBJGcAnc7a/c+GD4V
 WiKBvTqaDJ7jQbxfCP2Df/aSM4TIXfYDovXZKxMY4oAnaxrXIGSkojf4tuqHKyP/zqRk
 tTACJUlvF1h42DOzrkemuoj0E6UhDLlo06lkev/v/EdIS96hK01lWMkB+j1akjuflG5k
 5rLaMwq5C1uxS88UKQvcdak66vuw2RdcNA5+37z6/Zm+iQCAGljVz2IKOr/+GUvEgFOb
 gx6UUkdwCI1ikPnYaEyJ5S/lIRbEv+p6jkJmIMLvTrnANzz3LIbt0WdpveIM4CJ5rdMB
 lL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790656119; x=1791260919;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0ucAewFEOicvP/KWQ2feDjZcwzUKPmoTcok5VDj8TTs=;
 b=oUSdP0uee5Cjgl5K7Xe8hzN0mxwKRh8WvTi4yi7ikwdojKKVrCytogMrFbS7rucCAQ
 hxffq1P5Qnlmcl7iJPjHquchHzUY6oI5gxEyDFyKS+QCNDvNZLg+a3S0DBIVlbVjw2zT
 c9op0DWGjpHnaJnVVKRNc2eRYIgR0DnlMSedrclnS0e23wMZYPL5hUefvYRN9u+Q2tQe
 zTYUFXD7TWjrtsdJzx1+C4FJR3f7pMUmg3xWX/BAcvZfNCB6LbGm+LbcndjH8FrNx0/d
 M5SBHxWktv2bfBCeJunbLqRWOnWsN6n8TGCLGLumAEht3aYh77lXWi5toIIxAx6RZIb3
 60PQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByqXfq8mHbeQ5bd9m6Il0P9BsiTiIuL5gKfi23okjExz9yGi+SGrkrHkC4Biyt0QNBCKawO5RXvMWA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbqAFce/cMCMNLNvNyaCDEjNqne4wTXI8UTMpeXEjRkoi1+4Kv
 wizbxgeHO0UI4hVUZG5U8tUxK65SZW51zTOybUJpFuY0sJXJc8fMm+VOIkf/WiIhr4610m/TLvy
 o2Italm+T2Jbj9OcatGIt4cfyuDLrt20qQNvk3g/koVLhRH6xx2VFVaNsdjJ2KWMK3z4jY+g=
X-Gm-Gg: AYBFou23KTeRPhCQ0IAFqMh7an6JXGxkdoPLD9S9raJ6m4Cc6cJYEhoxT2SRmxa7Pkp
 CWAtBof9u/++xQSCemSZrkXcvaatsho8vnKkC6dcKHLhshVvb5rRiuOTU9lTFmWXH3xwm36+0eN
 Ac95Z+qX2iYJUQ19jCcryWdqmYPI3JG3sl9wEioshNrEbcyth+34nO+HgCR0HwFlk4VDLzuxLbC
 hFZiWj9OrcEh8tNJ8rtNAdiVueBFPVvqi1rrQOuOZ37OWXyIin8jA+rM3dQmJgkY9EOO5GDEji2
 swYZ8DMCWYbTPq8zwwGISNKryz9uOklOxuvW1N51N3R39VNnX7nNg50gMjaC2LCiV9QqCVfrubE
 H8ULIUUsHfQCIjwc5JLlsEt/udBmYhvHnBdUkvcy4x52NRi0VV6dPpWFEDQEiTbM=
X-Received: by 2002:a05:6214:459b:b0:917:8d49:6c7c with SMTP id
 6a1803df08f44-9178d496ddamr2990816d6.46.1790656119157; 
 Mon, 28 Sep 2026 21:28:39 -0700 (PDT)
X-Received: by 2002:a05:6214:459b:b0:917:8d49:6c7c with SMTP id
 6a1803df08f44-9178d496ddamr2990576d6.46.1790656118695; 
 Mon, 28 Sep 2026 21:28:38 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d34d4ccsm1717206d6.30.2026.09.28.21.28.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 21:28:38 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 12:25:52 +0800
Subject: [PATCH v7 28/35] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260929-msm-dp-mst-v7-28-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
In-Reply-To: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790655983; l=3337;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=2WHp6E6UvESdA7e8Ig6s/rlLlhgWELEP8B79xKxaQpA=;
 b=9kqodMK9gej/xEASxTZeg8YusSLAl+3+lV+PTCAXF6M+K7dTYM/3ZsFb9VLUgeqoNr7eITh/X
 hi6sFSkx/fmAWRJ8AgO62FkJ+gy1rEEvvqCAo6OcEI0ndspLFQYGYjp
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfX0oslqqxoGRZ7
 5itM3taln4JPrSGyXQhw6HgraeTcr//W1AubfTbuwEIUKptdc2wA6sj4m2xkWdqdwA/mEkn4Tmp
 uFe80mfITca+mUr8Bmy5rF5gN7T8DqE=
X-Proofpoint-GUID: WvGXbL7U2geYXOYpLguZdg-fvz7Wywkw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDAxNyBTYWx0ZWRfXwfcMX5N7j3Uv
 jIV4vZW64m55hfvvDPsrSdmXVIg/PQeZZqUho0RWhgn42XcWFLOjwpnTNwnzs++ZEw3hRflpEbQ
 P0nq7ojRuPcBC1qgH5h4+d0u32blLtiMC4eDUcVwDheg+3JrdKlaQeHzJQd6ECqDmNA0cHa0qIh
 2LQ7zfAMBcj46yFzz3yeB9sJPcPCeu6cfXO5sToaQBy1XxZFPGEC+v7UYFoe04omYCGrj0TH4/q
 E9qtIZ1O19GrUgTjSLiWqf1g+0dfrE3o5X9ZpbGyPfZI0Aer/CZwofLsibabduuGlwx/qRNJ1kN
 5aeTE5J6nSUbShbHW8oHuvFq+1yh7GzgrbbCUY8ux5HrIQRjijWMgvX7zrf53w1KnwXKfOzwCDA
 vntV609IOH3K+IaYnutZCGA55KCm9cdfYqetuSnLUXblqLgmUJGYYaHhrv9mfaeee43sAK7chQc
 Yd/34XDcFj4iSmm8ERw==
X-Proofpoint-ORIG-GUID: WvGXbL7U2geYXOYpLguZdg-fvz7Wywkw
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abb3e77 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290017
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
index 9d67425fecee..6d8a6779b4b3 100644
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

