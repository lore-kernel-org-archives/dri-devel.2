Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A18BC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEDD610E93B;
	Mon, 29 Jun 2026 14:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfxVIzRF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OYr1QBS8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FC4510E939
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:04 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATTau2592877
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=; b=HfxVIzRFx73FAPkn
 ditk1xCO1diJU0vRJtCrnydiQExGXu5MQlI9hQFi2CakmktSyvJy/TPI4FajvrGl
 +XOe215R8NOlXFBMp/t6k4KNTpoigFdqeR21HTvNlxsYVm3zXtT1EFWKb1ky/0vw
 t/HfnWRilQ+mi3R9JSkdliH1yOprBCeSxyR8VYu8sdjX2FHMq5HVYY6N9hU8IMTQ
 Gic15XD5PQXPimrBMFfs7XoMvdRzb1W0btaqUaYBUeET0HbPW2KDW/iBZeis3Bql
 njcVXqyhMkz/ShPPXuuea+KdPMt5jsEW5eAiIffJ6zpCsvrzhHDDkPuqFbpDe3sf
 i7g/ww==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3k7vj1s6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:17:03 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8eac2620cb0so55760036d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782742623; x=1783347423;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=;
 b=OYr1QBS8mQLZg2Qn0kIMAcHLMxyR02r0Cf1BcpIkqRxIWTpocJfW/F9JevhEgr1IAM
 D63g4UfllETVw2xRPoKvw3vxGLUD6htefWy20nAMZsT7DgYqtzbuOfvPmLkxk57MRC2x
 yRtl95ytdGece43ai2QGWWhI7XpFuAcQtWGLqWcKR9KryfT3YnzNI0uy8XhPVvXEkURB
 KJ6750uY84zg/HM4O9xjsL1pF6GIqGM7mMzOxGBvLfWICfDZJQXZRl62yKImbYYYNk0f
 IlwFaj393nwGviI4nkLhbmPfk8jpNt0xXsf2DwSbw5jr4kqqAMGIGs58g5pLINx+TjiU
 iWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742623; x=1783347423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s3VwBumwCqEjd1GYUzP46GInRqb8UClCfWsUQZYOShE=;
 b=hivM+WVdxSYXxsBedf8D6SARZJXNuJvu2oc5KgDEyOI9REbhNH+/e3q2azzwOTE5jm
 I+KDOsuyjnEPI4XGx/W+Cld98TAPzHCfjnrobCORcFTdZk8tz7FFzn2LFY9sq7DgQBvV
 7bGcJz+KIEuF/WbtmuGrcMGYVPFpvdW5l7FOetgudRi59x5M7CnADKZSQDiH9DZbLjml
 v2RAYQwkWCULUDmpdDxN4khOJ4W/A61gRyF5NFoL8HEuBRBLY2oerURHF/pVH7qctX5i
 nk4CR7k48er/ZJRHFVaLk7nZ3HQyX5PztGpTYtSTsQcUeAk3DF5eD6eo8LHCQWPJF0RN
 YwYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9iqRcEHXBXjMpW4j+mC+Ay3Hra7lkZ1IkeGkArjy6DLDiwbcfmjCIVj7YRSvBqHmUzn0HTh2mtkkk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyNOS938/xrv9Gk4sOc62/gLqjF0mLwgNYHUjh8DfM1Z7jawYHQ
 U/gAKD48yWgQJkHXyOZ5hMM/WncMlasX5QhBZnXYep3iUaKolAesZddyJdmoKVj8bQf67U0Dhtj
 L3G+Ns0XuY9USNcd63GsEuozxtvCW/dDBR6TUVd/7dPTfblts4Jo51Nkpje5gziZFsdXXkdo=
X-Gm-Gg: AfdE7cnEz3KWv2fwD+HzUQqr5gQSs8ZjFo4+Ys65C4L1rISEtH2e1g93AKzGsnx9PDS
 JnOKrqOFYoGmQhKJJvWM9goJ/7R6DcXiQEX09O/GxXYmDDmWGpsTUV9CESTHy5SFVMmYnER8epF
 JTipoYBMe5LTzGfnQzZ9E+OHjeGXf0dMRR+sPP6N3kM6jp187d7m9+sh+E9QwpGtCCNjz0QHlYL
 kx1e2fn/hX98GQDNLstdXg9JnxBw6K0dn+aKqWeUX32bkzUmf7SSg7T/XmsjVzfDlpi1o8eBtYS
 19cNPWvNgB+msM6qP8tTOj0DzEv/8VSLRInzYF8ua8Tx4Nvcyp20ImUy5jLs+sSqsgnkqzWUmPL
 KBgN9NVeO/p0Y+0RJNolBP2AxV4G4b+M0SmNBMW9d9A9p/3xFus55VFrslXLYP8y6CJUreA==
X-Received: by 2002:a05:620a:2301:10b0:92b:32d4:4ae6 with SMTP id
 af79cd13be357-92b32d46453mr1194425385a.42.1782742622569; 
 Mon, 29 Jun 2026 07:17:02 -0700 (PDT)
X-Received: by 2002:a05:620a:2301:10b0:92b:32d4:4ae6 with SMTP id
 af79cd13be357-92b32d46453mr1194420985a.42.1782742621870; 
 Mon, 29 Jun 2026 07:17:01 -0700 (PDT)
Received: from yongmou2.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9260079070bsm2143165885a.40.2026.06.29.07.16.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:17:01 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH RESEND v5 22/25] drm/msm/dp: wire MST helpers into atomic
 check and commit paths
Date: Mon, 29 Jun 2026 22:14:43 +0800
Message-ID: <20260629-msm-dp-mst-v5-22-2ed6aee1867a@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
References: <20260629-msm-dp-mst-v5-0-2ed6aee1867a@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782742144; l=3337;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=b2i238VUI/AdKzoSuCKAbFa1dbTjNQRwjyN6xCNz0mo=;
 b=igEgrzozdyLMzTrm2/ynfm9SDhtgOWmyL75SDtVtIh+KRvPdQR3TaKoFjqQI6DDHzD+QSGfVV
 xZh9vwij2jWCA9H1pOpUd8wGitlgUN+Tfo9+KwkSx3idfi+sI9CUtLA
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: u_-uzQ4m4W8DLx_PcmDT8pRa8iqNulQS
X-Authority-Analysis: v=2.4 cv=CqCPtH4D c=1 sm=1 tr=0 ts=6a427e5f cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=rXwVWE6-aGP_zC5-gXEA:9
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX6fvIiPaauTW7
 5TIfdO+anp60cLhVzKIV/r4RSEkQSAvfZYfSEp8swcrS/hQAkOVPXrYIXngX4wSHLv7sPNXzbb2
 Fy1Oaq8MP8wp+e5QIJly2BaiWeoJoFE=
X-Proofpoint-ORIG-GUID: u_-uzQ4m4W8DLx_PcmDT8pRa8iqNulQS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOCBTYWx0ZWRfX61jCuJejtrDE
 i9j0rKSZ1vWghviHukhavXYsklGH7IaIpxeKeHqDT+QsVem1Cg32xGik7CLBSs4BPGgXUGo5uz5
 AiAZ24Wwj5i2p6Uh6Cy+s9V5LPnbteYpLl4zGGLRXLaMUg0eXXvzNi/O8NVcvyM+JJ6pZ2qhPw/
 w+fT8WuVY4qmA2j7EUPg/sS+wUpvTVBm2NrxIuBJCiAEsGmrsJHUTJxk4z5VT9Be/IxFjSMxTKc
 p2VqENJCe4XiPEu8vURhX0bkYFkEYBxqa9iqVAPsSxA8yWg9NcbN7z7MxUJRqvpsBZ/FuVQlQms
 a2zO9VyQY5OWpQhp10gGn0rgCBJAojfaH8ezyjCeyqv0ORK9XAL/CMoXW68/xF8eZ9u1Sp56XEl
 YlYArOPWqsi65I+yHvsKi5hZpRMdThDoyyDaYn7mlP23ZYqQszhKZJmGa0wIztZ7PldReeepdEQ
 qipiDi1zjn/k9vKpQRA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290118
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

