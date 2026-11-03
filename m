Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A337606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TE48tcIA;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WduxqNbA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151B610F937;
	Tue,  3 Nov 2026 23:19:11 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 463F310F937
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKgYl3993606
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:18:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4Yu+UuFD/Wj
 iOEoLie6jGRMxfHMmEcnLeHN5yHd+Id0=; b=TE48tcIAvHvRqRR9E2KJ4z8RqGQ
 SgqFO3i1MlTELD4gNTbHzsYKIFI1mP2BW7xfhwkNLndSpEkaGR5CfmITdE0xPk71
 e4DBeQgFCfXuJJwCdV6t/z5qP760WNSMxJRIUyByDd33HDFpk0LIw5n0VxCUI+m+
 BIs0a1+gsi4IkMuoT2w7lk6CbnuakYNwrDFjbqIG0Rw8IBBH+/wcn/5P68QVawKp
 7AUutbsxFMSOlZ0SWmPKsuHfqMjWkmFXqw4yDNCKxNqcBxMx6cPYIk2tQixKV1FX
 h6U7bdem9vyt77rHhIXrXTwKftlCEPO7qwjYN1i9k1TBkmUDJV2cjU6ToYg==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqn8ngvtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:18:59 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a06da65d92so100281b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747939; x=1794352739;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Yu+UuFD/WjiOEoLie6jGRMxfHMmEcnLeHN5yHd+Id0=;
 b=WduxqNbAaAArGmWKqFSaS3823inwQVNWYEOpD+SR0ycWE3z9A1kotHabHLy6y7I9BV
 fy25KzSO0ZaMLP6VGKKOUFyIcGUrQJPAOxrcpqngxyQBtE8hclIslz1frpnXfNU1W8op
 xQd3toi6IJ+WPpfSocS+cc0kwUrkyXAJYZz3Z8yI5v/tgg05MaMArVF0MqJurtZ2vQwZ
 YYkFhBpUZQ4WP1QsZe7KTxbv8axOaI8GBT/Cq/sV3PKyWhGRMKPaWPA+FOodNqtbqvYn
 MU6FIJvYS0HPV+niDcM07jNQiD/FTdp+RzJHgPR/aRnXsJr8gLcoLudqi+RJ0azsVnJp
 CMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747939; x=1794352739;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Yu+UuFD/WjiOEoLie6jGRMxfHMmEcnLeHN5yHd+Id0=;
 b=t+ZhfHYX9q69ZktcQKoYowjdUh9QnET36xgIcsQYDzNZ66YntOQzQPh2MRFuyCLji/
 haMh8RKOLR0WpNPC5tu9QHOYSiSHVca5PwX1HUaY0Sg82f/Fv/2ch1J7pQFEloM8zYgo
 GXd+N5GV5+RiRiykQ4gOkA3ulCvMYfirteEf98LlB5WI4lcz/UDVWe0EmMQI8rEsfDOh
 /aogASgFFgE9F0dXisSb1vZwDqODxKZ+UYyM+IdQNJ3+6lR4paaECkUtmL1c7WdbrsNJ
 SWxkBdD/jcVCF7dpyKnzHi+RRPjqpZlBajoUnYyIxRY3M10cIe/ImzzT89LlMZIOA56m
 Wt0A==
X-Gm-Message-State: APuU4Z+5Lhvzeaq1kqVqXSZhfB9Q0AW3gWxDaYIBF1ppNZR1ODIeFy6h
 II8vtxl7xl2N+npttThRXYWngnMJU6Shey9YsLWWyM+UhM1NCF8iEXk6v7+0h35rtxDmU6X/aft
 E+7C1KJpPLD0ewxuxmtgsU49Omrqjuo0cTlBWYCXx3nvBlhMq/EUVF7+vvVqE4cOAP/vtMvzZFn
 voxAGExg==
X-Gm-Gg: AYBFou1/XW5zaQZjYQbHDuFYO3kSllQKa9YINgt3YBUROIGRV0o7MQuAOHRgvdJ0vyt
 JcekqXbK+Ry56AAlLkJnGGc7ODWaAt7Wgdj74SRG54u5n7JiniDBmwPQoOE8T0HRhP1P9njl/8t
 nysEKRGTDN43Z70V/aYp5bF1X23mqbDYjhVOncXHxw+h9fgrme6l3fS62rwpuo8sSnMM3xWNHIM
 eXG3b55PdK3wQzVS4B2/4yGeSzkukDFvzK5BcAfNe7SqLQ33NrSQPDm4q3aU5AzXojqMMhnfDsr
 tkbQgFvDtBQQkT33R4D8mxV/3esdTdKBbSz9b7/5wmyXq6XORmSav6EKcYL6CrV7wd0IMm/1oCz
 BRxsbgu6uq2D4E3E9ZE0XJjj3PINakDnAg4J1bMaduVtz67D94YvkahgdGBMwVzhcrnHdYMwkZe
 dzUbN0YileqnV/J/SLKqLprUczVPlwCwofc1MydG3QQ6gMNTXGCJUgYSKr1Lg=
X-Received: by 2002:a05:6a00:10c3:b0:878:3538:8f7d with SMTP id
 d2e1a72fcca58-8a9bffd0f9emr12878354b3a.43.1793747939023; 
 Tue, 03 Nov 2026 15:18:59 -0800 (PST)
X-Received: by 2002:a05:6a00:10c3:b0:878:3538:8f7d with SMTP id
 d2e1a72fcca58-8a9bffd0f9emr12878328b3a.43.1793747938577; 
 Tue, 03 Nov 2026 15:18:58 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09af918f2sm144319b3a.23.2026.11.03.15.18.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:18:57 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 2/6] drm/msm: Resume perfcntrs after hw_init
Date: Tue,  3 Nov 2026 15:18:41 -0800
Message-ID: <20261103231850.17493-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX4nSN7zOUhDhf
 aFA+B6oaWEho6WxroSYukIn36hWB/F4z7WhfScisK5mv3iR5/8T7Mj2ejkFtYwupSVwBbBjd6eG
 7o3X0mOpdbi2xx9ADsTWzvhAoFdA9HK6NA0cq5YEabQQgYOTe31oTVp9/Owczjc9EYVdoIniKES
 ZpLBFtGgZpYU168Mu3aMQNijVlYdZ4a/AefaC5YHL0UV+93lr8OCwRRoHGCDmLrLxQ+sSDwwbRc
 WF03TCtHpuMLWJP7gGU++8yeFc+w5gV1HUxEddZDAMMqkGH96HSpPWTUbx1AAvkXUzS769p9gRE
 WsHdc64Y+V/F27zXMKkDFVo8B+DrCDumTNF1OLohn99KwHBwapdxQ2ZJutqC9LUIuMIPgWgICQG
 kqnv/9BPQehUBmjDTL4WRSw9A5CSdQ1af/ONfSABjy4KaqRSfWrHrbIv583gvSphFAExV59+doZ
 blpLEOJ8lk9PY7k1gTw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX6Ytm6wt8qNFt
 X15pU5OJDCYbuhs5PYE+XmARuNQaA6odKnPxKa0T4TesemsGUErhGU0wSepJB88BiIE8KhtMK1q
 wXU2Yerbkd/wIm2ypjsNeCjuXS2SfTI=
X-Proofpoint-GUID: x3t8RLpLuYWxq69pM9AhT06mKAdQkchQ
X-Proofpoint-ORIG-GUID: x3t8RLpLuYWxq69pM9AhT06mKAdQkchQ
X-Authority-Analysis: v=2.4 cv=As17T+9P c=1 sm=1 tr=0 ts=6aea6be3 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=ZcLbcdItcj5UGiXMI0wA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030092
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

It isn't really useful to start sampling counters before hw_init().  And
the next commit will require IFPC OOB request to come after hw_init().

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 5 +----
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 1 -
 drivers/gpu/drm/msm/msm_gpu.c              | 4 +++-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7108d4aa59b5..749269843e42 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -309,10 +309,7 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static int adreno_runtime_resume(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
-	int ret = gpu->funcs->pm_resume(gpu);
-	if (!ret)
-		ret = msm_perfcntr_resume(gpu);
-	return ret;
+	return gpu->funcs->pm_resume(gpu);
 }
 
 static int adreno_runtime_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 6db6cb7eb287..d074f4df78f6 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -720,7 +720,6 @@ void adreno_recover(struct msm_gpu *gpu)
 	msm_perfcntr_suspend(gpu);
 	gpu->funcs->pm_suspend(gpu);
 	gpu->funcs->pm_resume(gpu);
-	msm_perfcntr_resume(gpu);
 
 	ret = msm_gpu_hw_init(gpu);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fb07803f5aba..ca21b3bf20df 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -168,8 +168,10 @@ int msm_gpu_hw_init(struct msm_gpu *gpu)
 
 	disable_irq(gpu->irq);
 	ret = gpu->funcs->hw_init(gpu);
-	if (!ret)
+	if (!ret) {
+		msm_perfcntr_resume(gpu);
 		gpu->needs_hw_init = false;
+	}
 	enable_irq(gpu->irq);
 
 	return ret;
-- 
2.56.0

