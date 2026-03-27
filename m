Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D9710AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77C5710EBAB;
	Fri, 27 Mar 2026 00:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BkQKI2eP";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EYwY7zik";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE9410EB6F
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:20 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QKYb0c519428
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4kDtSY8iHEY7m3Ukm8JBULMqvnEiIsXdddnR6CXPwVU=; b=BkQKI2ePX9jkrdJq
 cS2DPjvKBTTHTet6Viw3M8o04tvFXXrZDFubkakug5j9N7HLvIfnVIttXR0gHh/y
 l3ZhGVcazY2khpjVvwGR4uoiAEreWW+VwlgwHg9+xZi77615yn2fiDKRm9n+z4cp
 HpMwmbLTS1T4dV8hAwCwR8fe7C/xSEmodwgmwuZz4TivAbPWGMEBrA4bO4PjpjGo
 1uIi2pJeyixZRhdaqZQIAY/H6VptI4RfnoUroKLyS3izkuNKjD2qvFZe6lOcuCJL
 P9Rkg1iOxWFa7SHQxGFMZLMBbHamYrzNwLKsPmINvK3jli2sSlfmyPZ2ACYJqK8k
 Afq4+A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5bxv0h5c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:20 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-359fe456655so1590831a91.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570519; x=1775175319;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4kDtSY8iHEY7m3Ukm8JBULMqvnEiIsXdddnR6CXPwVU=;
 b=EYwY7zikcS+p8nq+JnGbAyzkeFqyOl/cbFPLuNN9rtXySmV1bd+vIMAbuNwpKW1kK6
 z9BHA77/URIWVkEqSm29Mj3w6Sq2bMwtiL94TTB0GbBTJPVWc8PDKwf2EAarQr2+63Qr
 3eYxLM1ftXWEN8HUwthgrjy1+d7yjnyra4OaIOI8+WlX9L5B/I+tygeVCaQNPvN6Kf1u
 7C1zz9rI0FcwieoWOleLTOhfgo7Sg56Ba6B8Evl6AK67WiUNpAUPrmnkFLQhWyd158Bl
 1qMlVxEk5VCiZTtoNA5CtaQqjp5P9JPaiIjy4pOEOCKRUirKy1HoTF/e+Jc2AouYX+sv
 Idbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570520; x=1775175320;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=4kDtSY8iHEY7m3Ukm8JBULMqvnEiIsXdddnR6CXPwVU=;
 b=ifQaj83NLnuZOZ/Nwd6ZH2nvAzrF+lGKeqS1eK6R7ffkN6VtPwBhZw3KtrFuJWm7ab
 V6XzEmsT2GRPD9zalOVIxPlwO+AvEsMCyn3e0eKAUJjJjBoaU+NqtTXjNNVrWyAfK4Dc
 amOIhEa5BDmnezo6iLv83Ud2JbfX0AjKDk8ctWflgWS/iA2HOW57O0jNbk1XOKtyP6/b
 nwxdg0xuYMz8TWkJfTOvErg4nwzloo5QXWfmUwBAln3XDXJptEnPzzDH0odISfN14Pxz
 EjWLQtLtKno1RO5JKbrfrlz6+HCUEiQ/Mbv8UBkqa3bsx0OD3s7vEYxQqtAIAPRGjB/l
 bWPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVj1rcs0ekq00kMPMtCeN7r1VHnr0nF8aAa3JakLKNeIknxFN8vZdiLA5iGSjubdCCwCdNRH2YSYRI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/56Z6terLf2J0QbxwnKg+/O8gjLMhwmQbLEA8vLrmfcNiQOQh
 tVwhR0ueOzGRfISo4ONRuW+mAWCxvUQzUGMw2YnngM+9uQ3QR4viR7ur1HehzxynUv6AR8G8RjG
 8aHI87xqBz1GVI55WtRWbl7tCkrUNoYwtM7jc1yHdqZu68f5qZam6KTf63MSKoa4c1KF9hBg=
X-Gm-Gg: ATEYQzyLS3eRSJPZVHb11YSg4mZhkiCo8kAWXJPkPD2M3wbaKZdLCrKQFfiswCteB5t
 35HnBiJVF5UCTYUngBTb60Y0aLV7ZocpDnfcqRjVqNInyWYo4Em+7ogbJrBRcgVFvMKZRtYQTMO
 37bJ1B+Ug6INEBziVzSzEoe344egQM1TcM01yoZiKG0UB5fvsO/zVOoaYJDjgSbggGje85Qw4yo
 B27IDnXVo41VKaa2RT8Jw93R/oOE2GDDGPauGYMx1xyQj6z6JeYPG/afkId4EjhkfpyvyOpWc8E
 DeySBvWExg+3L4bWhrEZNXfYa+i7jAdLmPHE5RIicWDV9QWy/rCCct/zMNr9zyDzsKAcHAkRwe7
 CmbyO/2yV/Nnva+8HE9kAfj7wn9RF+ZmrqUqDjqA6uofwOA==
X-Received: by 2002:a17:90b:4c8b:b0:354:c593:b1a8 with SMTP id
 98e67ed59e1d1-35c2ffa93e7mr556479a91.13.1774570519496; 
 Thu, 26 Mar 2026 17:15:19 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8b:b0:354:c593:b1a8 with SMTP id
 98e67ed59e1d1-35c2ffa93e7mr556422a91.13.1774570518865; 
 Thu, 26 Mar 2026 17:15:18 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.15.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:18 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:57 +0530
Subject: [PATCH v2 08/17] drm/msm/adreno: Coredump on GPU/GMU init failures
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-8-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=4176;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=cDGl0uZ6i5pv8Z8hV4IeFJXQL2XOvg9/tRM5E6JrofE=;
 b=KuwoFLu8wFJBzBvS5WU+a3ua508Y1HlGEvylT+oTxL8oSjs2seOL0RsQs2vvZVmZCs8OMEuwH
 c5qpp9fSiY6DYgovCfhkpMyIYU7YedArZTHe6XQYMlniAHtntGpDC3P
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=A99h/qWG c=1 sm=1 tr=0 ts=69c5cc18 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=yqx-ntKogz8YgV0l4v8A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: iA3D_s0uG7sPFFgxL8xhdCDVxdC4Y2Yg
X-Proofpoint-GUID: iA3D_s0uG7sPFFgxL8xhdCDVxdC4Y2Yg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX1IyaesmJELnW
 PjdK56nA9wzmUWm1ZyQbAL1QFQVFYmk4QSuGaDn18K0UGEKctBcpWQSgaSMZgvwavGqXOfMvg7o
 B1c9/DsS3Wp81MFHR/7ORtGs2qdunXQd4Mhv+21NjRuOcNbuogPBma9n2Qlz8Pfyk/ByFCft/+o
 /789cnbxvUD9SjOF5rkaMAwDc5LReR0LTdGCS3uemYsrtsUdeios3TBf43twaNh1Pfjz5UoSwbQ
 LhQssgdKjka1MrfZ8YFhYhwFkamy/s+zYPEkojK70YfjRcU1v/nIBlDRLYwT6TiNkcYKFPVsRVb
 Kg1A0xNF+cvlVO/9d1HFhpn5RJyDdvsv2T6TququGlihZHi9Sn10GJ2Z7JPBHKa18s2G1Mfrr6k
 ceHLBHpXs8uJRiCjVYMTn7eG0iWTYx91F9W4aIGl9pAvuNQL1i8yofSalaWqymJ8YH1a2YXQ34s
 etFoPpjgM1cSGHSYF5A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 malwarescore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

Capture coredump on GPU or GMU errors during initialization to help in
debugging the issues. To be consistent with the locks while calling
msm_gpu_crashstate_capture(), call pm_runtime_get(gpu) always with
msm_gpu->lock.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c      | 1 +
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 5 ++++-
 drivers/gpu/drm/msm/msm_gpu.c              | 5 +++--
 drivers/gpu/drm/msm/msm_gpu.h              | 2 ++
 5 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..916c5d99c4d1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1335,6 +1335,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 
 disable_irq:
 	disable_irq(gmu->gmu_irq);
+	msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 	a6xx_rpmh_stop(gmu);
 disable_clk:
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 4edfe80c5be7..ca5f96e16870 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -105,6 +105,8 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 	 */
 	pm_runtime_enable(&pdev->dev);
 
+	guard(mutex)(&gpu->lock);
+
 	ret = pm_runtime_get_sync(&pdev->dev);
 	if (ret < 0) {
 		pm_runtime_put_noidle(&pdev->dev);
@@ -112,10 +114,9 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
 		goto err_disable_rpm;
 	}
 
-	mutex_lock(&gpu->lock);
 	ret = msm_gpu_hw_init(gpu);
-	mutex_unlock(&gpu->lock);
 	if (ret) {
+		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 		DRM_DEV_ERROR(dev->dev, "gpu hw init failed: %d\n", ret);
 		goto err_put_rpm;
 	}
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 785e99fb5bd5..8475802fdde2 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -391,10 +391,13 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	case MSM_PARAM_TIMESTAMP:
 		if (adreno_gpu->funcs->get_timestamp) {
+			mutex_lock(&gpu->lock);
 			pm_runtime_get_sync(&gpu->pdev->dev);
+
 			*value = adreno_gpu->funcs->get_timestamp(gpu);
-			pm_runtime_put_autosuspend(&gpu->pdev->dev);
 
+			pm_runtime_put_autosuspend(&gpu->pdev->dev);
+			mutex_unlock(&gpu->lock);
 			return 0;
 		}
 		return -EINVAL;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 995549d0bbbc..472db2c916f9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -361,7 +361,7 @@ static void crashstate_get_vm_logs(struct msm_gpu_state *state, struct msm_gem_v
 	mutex_unlock(&vm->mmu_lock);
 }
 
-static void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
+void msm_gpu_crashstate_capture(struct msm_gpu *gpu,
 		struct msm_gem_submit *submit, struct msm_gpu_fault_info *fault_info,
 		char *comm, char *cmd)
 {
@@ -886,7 +886,8 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 
 	pm_runtime_get_sync(&gpu->pdev->dev);
 
-	msm_gpu_hw_init(gpu);
+	if (msm_gpu_hw_init(gpu))
+		msm_gpu_crashstate_capture(gpu, NULL, NULL, NULL, NULL);
 
 	submit->seqno = submit->hw_fence->seqno;
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 666cf499b7ec..eb5b3a7b81f9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -747,6 +747,8 @@ static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 }
 
 void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info);
+void msm_gpu_crashstate_capture(struct msm_gpu *gpu, struct msm_gem_submit *submit,
+		struct msm_gpu_fault_info *fault_info, char *comm, char *cmd);
 
 /*
  * Simple macro to semi-cleanly add the MAP_PRIV flag for targets that can

-- 
2.51.0

