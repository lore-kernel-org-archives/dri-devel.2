Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17359E99062
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 09:36:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7427410E92D;
	Fri, 10 Apr 2026 09:36:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JQtOA5HC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MmgFD0II";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6471C10E92D
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:49 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63A56AQ32698366
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 xkuNQEV8XZqCGyzJul8RBDnuBqWH9JDDufCPPjSulj4=; b=JQtOA5HCSuYzAxzD
 BJlgTc2EI6T6368G+ZC/jT+3z8fhl6xtRKN66FU52cv0iVIZ8vhD0yNoTTld/G60
 8wZJrARXAz1sVqgfUJ249LHPhzVtl8bF18wCKS1DIWtAUkL7G+XDRrDxPHxjSWJc
 9vEw7qZIoHzzIu8RGc2vHJ57nvCtgTqN1L9oJYxejqyrlF6XTk6SmXTpgfJ+Sil2
 FPbWpHJOEERZ//gsCxTa+D0q96Q/MGBrn6xGn6ppDQqTmgIP4LR9VaS1nM0gRbMl
 aPW0Ep3us66vgHybjYYXSBGYhVBETfSuzCDvoc1xuzhbw+6hkEGKozWByjYH8XT4
 daKaSw==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9tjrs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 09:36:48 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8a1f96bf221so62777716d6.3
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Apr 2026 02:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775813808; x=1776418608;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xkuNQEV8XZqCGyzJul8RBDnuBqWH9JDDufCPPjSulj4=;
 b=MmgFD0IIcxbqdtgQXMiwkf0B3m0PdWZ38Rx6uAFDusXwxnSCQKPB3I/KaRTqupkH9E
 5YFi5MaNNX2uoqL+g/QCIirtxY0Fu6PjIlcC8uzD/dTMQ8H7r+MM6nWnf4//qxQ1NUaF
 VPhpy+Ph6uacKupB9DmJMQYizv1QAR87uxq29Ub6AgpG/dQnGPBWEjczvX/Fa+A2hwZI
 u+A3+xv8ctM1U07bpo1fX3FbUJL23KJRQzCRqHRpR7r243TDTBpGL1PJviWW7KrnelX0
 4IM8emC42s0qOEgevTlZAtDWXn2waSXvuELBMfIi6w94MTf0v20CzpBtAaCkGdLyFhib
 +26A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775813808; x=1776418608;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xkuNQEV8XZqCGyzJul8RBDnuBqWH9JDDufCPPjSulj4=;
 b=fMaoI2rbFLiRGsruslJo8D2wAu8g8ZioWKMriM17M+nZ33ozxQcIv50qB5CKO5v/iQ
 RNZdZoepqVLwp/LnhU2PSpzLnEYOk4ZMnlHazaiBLXlSDQ7FrbgYd7CwUnQ50hSXn5AE
 KWZg0zGNaJcAIHrnIlykJ8xNcMD4bmR5pzAswyo7tjQj2VFblMi1Gjqyvg9bhZj0gOIU
 9dt7IP4WexRYfdrWwJAnK7giKSyGxIMdUHxTNiLf9G4W9mXFeEp4biAbNo2iCs4lpBIZ
 E+Y/IxJDd82fTBMOqa2fgNW9Q/EBGfUqXXur9MSngL3YHiKR3aLjY8u0xZIqLnI6r7d9
 d1zA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFsm6QWvLhHEGk4+dbpZeTsesAH/YKavvnJteOh/fRqRO0tdeILwJpI0kuETAKhormo+OtgTtaV/c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7mm1JXQWjOz1qTFvex8zwDwKjdBbnXvhVeUgoinIh9a/fjJ/U
 13CXy9Jh99MBeUCvsc+Swtp0SuYzp4uvulyoqar3Uyv9sTrekoTtHJMWOnIG4sYLyGGZdBQyX7K
 /bcz7elFLRGxDNU0/lJAJbzTRppUXjN0vY1JHZwKX7zD+Ihs2yaxLgBjBrxuvRKHx2JIRhyQ=
X-Gm-Gg: AeBDiet2adb65+lx22s7kwdeDHy3aCXnPJZsIYUDAikEvYcjnWHX3vm4Lf0CMShVC2H
 8qEJP17cq2Rmvsklxq2J6HbzwJieKBWQ5lRWTG7bshhGj1Ee4zu2eNk9DvXm+sFBd20ILu/E2CQ
 fSgvv046ZpHfMU+KXxTS2EHROcfkrCK0BI9lk+wZyasegYCWQcXvLI3MMCWGvOA5+/30Xq8hv4y
 o0lVXS1AtCZNevggw5f6plP8cFqbXfdmvk9Xzj3SeHq7VGUJxmLipuzYjz5JmrBFfA1eo4k3dBW
 ocQt2Kssq1tWXThpEL1KCwwX/OYPgVSnQt1A6FzL0I2OIYVqMyaRgKgZUZ6sGtITBI0+kuSDM59
 wLvvhvlhuTbY+95nMnHuiO6ckY00X1XFOvzv0ymUWByMf4S0WT6BSsiYpY2iC8c1GYLQQRNJ8Nn
 VsuieNUkU=
X-Received: by 2002:a05:6214:4018:b0:8a2:3f80:2a22 with SMTP id
 6a1803df08f44-8ac862d6535mr30241126d6.46.1775813807794; 
 Fri, 10 Apr 2026 02:36:47 -0700 (PDT)
X-Received: by 2002:a05:6214:4018:b0:8a2:3f80:2a22 with SMTP id
 6a1803df08f44-8ac862d6535mr30240856d6.46.1775813807410; 
 Fri, 10 Apr 2026 02:36:47 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ac84cb135fsm19223386d6.38.2026.04.10.02.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 02:36:47 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Fri, 10 Apr 2026 17:34:10 +0800
Subject: [PATCH v4 35/39] drm/msm/dp: wire MST helpers into atomic check
 and commit paths
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260410-msm-dp-mst-v4-35-b20518dea8de@oss.qualcomm.com>
References: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
In-Reply-To: <20260410-msm-dp-mst-v4-0-b20518dea8de@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775813628; l=2569;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=Zev8vjo6Ne+mGVU8pUaXaUCRweFkFvpilX34drpva4I=;
 b=oLVHjWdNRLabsfryin9mu2VygyEHy0KlEZWGjsfAvWgGqw0Wu2XMJSnTxRBbak8JM3wfZvw02
 aqKHwYSOV/cB9Sy9m//i7f15vjCw1pzFgImBYhkgNwQglUOSW/UkaAa
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEwMDA4OSBTYWx0ZWRfX2sbccGyH2qQf
 8xhq50Z9JAWhM4pjfco0chVBRJeSIDAkBANDsTwHUqSMbm0yleG5foqqYCzBSZ7qq7XJumEmec2
 zlCmzJrFQ2a0Y2aAfAK1CaH545afj7OaKVdtDjxfLqCu6cuMH0mJhi5ZiCTDx9W0IjnFBb51zEj
 1QPU+lfsyXxA4Bgz8UnWPIjxC1S2YJ9Vx72s/SpGwCIrcAkoNS0OwQcKL5ay8Dnj2xOfgdfZe1g
 x+2g3SvqCAmcp0Bz7VOHH4qhzzcJDslJRG+msie4wTjrhxXIKx/rbF16ADVlT4xqXxYhzzbP8PX
 +0zbG4gTfjPlMk1r3FX9O3rqnGvMUiFpss0C4gWIihVlahgnQYzKFjm40FehCaCdLXKMVk09fo3
 hIMsuN+7Kp8xjEK14ujTWgv3OxlIhJuo+G2xivQsqJWx/+KfKsHeCqMp/HbtSReJOzunvIj+UTI
 fzNjdbtiikvE3noT55Q==
X-Proofpoint-ORIG-GUID: pwtYKiuzirsK7x1ePhZ-kSFeo1PWrGqO
X-Proofpoint-GUID: pwtYKiuzirsK7x1ePhZ-kSFeo1PWrGqO
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d8c4b0 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=WDpXsREKN9l9u-HpV_IA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-10_03,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604100089
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
 drivers/gpu/drm/msm/msm_atomic.c | 9 ++++++++-
 drivers/gpu/drm/msm/msm_kms.c    | 2 ++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_atomic.c b/drivers/gpu/drm/msm/msm_atomic.c
index 87a91148a731..ea064aa6d8fc 100644
--- a/drivers/gpu/drm/msm/msm_atomic.c
+++ b/drivers/gpu/drm/msm/msm_atomic.c
@@ -4,6 +4,7 @@
  * Author: Rob Clark <robdclark@gmail.com>
  */
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_atomic_uapi.h>
 #include <drm/drm_vblank.h>
 
@@ -207,7 +208,11 @@ int msm_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 	if (ret)
 		return ret;
 
-	return drm_atomic_helper_check(dev, state);
+	ret = drm_atomic_helper_check(dev, state);
+	if (ret)
+		return ret;
+
+	return drm_dp_mst_atomic_check(state);
 }
 
 void msm_atomic_commit_tail(struct drm_atomic_state *state)
@@ -221,6 +226,8 @@ void msm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	trace_msm_atomic_commit_tail_start(async, crtc_mask);
 
+	drm_dp_mst_atomic_wait_for_dependencies(state);
+
 	kms->funcs->enable_commit(kms);
 
 	/*
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index e5d0ea629448..a8f5fbb3239d 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -10,6 +10,7 @@
 #include <linux/sched/mm.h>
 #include <uapi/linux/sched/types.h>
 
+#include <drm/display/drm_dp_mst_helper.h>
 #include <drm/drm_drv.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
@@ -29,6 +30,7 @@ static const struct drm_mode_config_funcs mode_config_funcs = {
 
 static const struct drm_mode_config_helper_funcs mode_config_helper_funcs = {
 	.atomic_commit_tail = msm_atomic_commit_tail,
+	.atomic_commit_setup = drm_dp_mst_atomic_setup_commit,
 };
 
 static irqreturn_t msm_irq(int irq, void *arg)

-- 
2.43.0

