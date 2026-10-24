Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558A1606A323
	for <dri-devel@archiver.kernel.org>; Sat, 24 Oct 2026 10:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=hbFw69Za;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Tf8sF75i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC7510E7EE;
	Sat, 24 Oct 2026 10:31:02 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1E7C10E7EE
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:51 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69O8o39T1166345
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=; b=hbFw69Za6+9aZVUA
 HqU6MRuyyTjYdXcuuPU8rrD8BRNE77vyWRfOoZcFb4RCcAPUd062hYBXO/QqDobO
 eYoR1KxBuc7pv32sv7QWw2jkpBsjnxF4BLvOkY0slRguf7UdN2kIWihywZ9AYOD0
 kHT/EGg8ATp50XwlJU+YX4FAtp6RLA/eioveQaC799vQn0EWFRd+Mrgxn8wqtdwH
 nBrMnHZde3C/QYDkfV5O11mf2M4oVY6Fn8KbeTbTVY7IaVM2j/tjKcfX6TTEAppL
 LOiCWUUr+23O2o441ldrvC/Ek68wNMdtAdX95yS0yPipsPM2L0Rr457a5DE/5L68
 1mR4jA==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgmw3gqd8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 10:30:51 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-186c1aae818so5408307c88.0
 for <dri-devel@lists.freedesktop.org>; Sat, 24 Oct 2026 03:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792837851; x=1793442651;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=;
 b=Tf8sF75ivF5QLim3yPY2Vshg/Qwu3FVqLL12irCTDPXjbXy3VQxkt7KpMHu0zf1SoP
 9zPlfSBosVRZEl4glZGzlKZSAatHgVQD9J+HZXK4xLhrjzKagzc8G4QfDzRVkm8Zm5/t
 ekrdICsZLDwCGfTpXeIa8BgC8hWahJCojuG7/gNe/V4jRBc5YXYWSK7k3e7jgidm3q6E
 gr5g3BsB8lM/4kfrV/yryy5eErt6Xo6DTiQPR2yAIQq6iaY0X2h9fxn0tE2xBtHwHaE5
 nendAB1yqnAJ7S/jKVUcojb2NT80oV2WbhMUOx2UQrN4wFoZMTZwH9QT1qjkbWjpLo3A
 rTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792837851; x=1793442651;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=A2cReWsSiTJKbfzFTEgcvWxEdzaCiferPXrh60qGdmw=;
 b=h8wIsAEPUGusIVosJhld+kpqdPU0kBSa6XoT82qml0fnc2IMowaXjLcu/V7E5T/jES
 sRCxSv58IE+Gp9mwwBKMVtmk+UOQ8Govr+GnMFmk8FhvE+qaMmAunY3FD6RJudOuhInV
 Ga1JoulBIp5b+6GtmBXsQF75aMmfURPW+9rc1MU/OgU4Ao05UigWy0+nFJY09szUKGHa
 LuWVV853I54QX5xzmvJ9+bT6RMQVwfSszpYEgpS5pMBiKwn+OL8cbOE4DGCKBUlTC4Op
 qBy2Q9HhZldC5IoaLgtgX2xncXPfbi7qfTaYeTeK5kropQkUYktiHzO29BRrc+qW98t0
 yThg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwnPOOmaP5rvhfUZ7ok9MQ3Q7bVPUdQ8MsryDh1gJapReYWLv/4VpZS4dY2q4hiKcnyn1mVQbHlcLY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJWZMUAWxnOGpXKn1VPg5EzHA4C+DFjYTearXSOo8q7tc2hp7Ke
 chCSaukTW89LrnexdjJff4Sx9hE2bWZFQMHpjjiEDPykHcWdhI5gp01wboHnQ0QKWhrSEOd43bY
 bN1J8e/jZ9RIKHzBRwqTrfO3aIt1V2pWvaQAknEojQmIsTyck6fToygoJsh21YiaAHQkDrPs=
X-Gm-Gg: AYBFou1rHOZeleVOE+7KEcpbfJ3gSRc1vgHb7sreHU97TxMMzmi2Wcjlp8XY8hZRhGr
 g7PDRdvct9PNgKSYJq3gQ9nROF3/+mniT7B9mKsT0q8XQVGwE1FSGf0cMYwPdaqG9A1qUx5Q5aj
 8oTTyFdam7I1aRzdXq6jJqsj3coCHn8kwoHr7My5EG1pHrsGx6UraBE4KM8O/9IeaMVi9DjSKj9
 oOYlQxYq+g3PF0c9n0IBs0R95zEL3BZ/AwfGOSdYFY1El3LHF8nAfD6YVJgRtSn4hQPZARtujvk
 YhqkBgLt8cwbGTOL4uVmTe/FywMo/bP9KLwPfrko7vumaxAsqllxAxm2X+LBNPZRizMbtCr+N4B
 AOPg/Nnn8FWj5Mc6irPWh9bI=
X-Received: by 2002:a05:7022:4198:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-199363a06f2mr3358619c88.21.1792837850598; 
 Sat, 24 Oct 2026 03:30:50 -0700 (PDT)
X-Received: by 2002:a05:7022:4198:b0:14c:be8e:69f2 with SMTP id
 a92af1059eb24-199363a06f2mr3358566c88.21.1792837850081; 
 Sat, 24 Oct 2026 03:30:50 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-19894d5a10csm6009441c88.1.2026.10.24.03.30.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Oct 2026 03:30:49 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 16:00:10 +0530
Subject: [PATCH 4/8] drm/msm/devfreq: Record idle_time at GPU idle onset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-assorted-fixes-oct-v1-4-2977f974ddb7@oss.qualcomm.com>
References: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
In-Reply-To: <20261024-assorted-fixes-oct-v1-0-2977f974ddb7@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Luben Tuikov <ltuikov89@gmail.com>,
 Antonino Maniscalco <antomani103@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792837816; l=1385;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=B/7JK0auHlH1E5rs71vnCUiEOGLiVg3K7pfC0lEPdGQ=;
 b=OHcBZxDZNTeCg15sZVgW9W325yRHdMZt7Y5EKtm8SHncpfDafjAKZCIaSdMq/XWwJEHRJ3iWF
 s8jSVSyR42UDmFDV0cQIE4lrEBBUQUKAG7jkIMW2a0xZrPPBZ0xCjcb
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 8H6tKvlew-4L2h_OO_jsFOFh3c6akKcc
X-Proofpoint-ORIG-GUID: 8H6tKvlew-4L2h_OO_jsFOFh3c6akKcc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX9YkZEhJDecJF
 XeOJfQg8VCQwtAjN7M7BMtcgeeyR2UCxl1rTpQDlIS4Od26XnUb1rDo+KO5Ptee2YjABHyLp1/A
 o77YHY3WilGs/EshjpugA4HrpKWWn2s=
X-Authority-Analysis: v=2.4 cv=HqHjiETS c=1 sm=1 tr=0 ts=6adc88db cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=8Gjds2nr7p1U5lpkA6QA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI0MDA0MSBTYWx0ZWRfX0HSZHaH5N7Mr
 qjMWbPvynuDJWKqpbOwRSDdFL3nQ8pRaMqOMQwR5DseRuqO7PFQq4zABBlujQdald5KelOeIDM2
 KlXBSiwgeMn1JhIwU1JFtrUQWEDt77UIMFsd6p3zPV1ZcCn+CWjBkU8L/2VOBBWGLbOiCAKuosr
 oR8UfgsSODuSQhGd4Yz7h7No5XMVymOojxF2K7pLOP3ji+4QeYqxwR3rA9VwVGHO63L5o+yPTyr
 zdiWJ0cg/9rRovMBJ5gCP04FFusYbYny+0DuyMLGRLg9OIu0OU06lAVXY5KDkeBxKskOeaTtTiP
 NWNsPRZJWqXlJh6Oaq41UJME0rc1GZTBLL9holEJv9ksj10fmf4t0mpwqTq/4PufSh+hVBe+jVX
 LpYq3ZDHVNL0EyrsO6g82+FuJ6HMuElMb+oQvMeFLoRgD81p3d49eLat2TMF0YEzkGDTBq+P+fg
 eokovREGSXpKPircnew==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-24_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610240041
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Setting df->idle_time in msm_devfreq_idle_work() means a cancelled
idle_work leaves a stale timestamp, causing idle_time to accumulate
across idle cycles and potentially trigger a spurious devfreq boost.

Move the assignment to msm_devfreq_idle() so the timestamp always
reflects the actual GPU idle onset.

Fixes: 658f4c829688 ("drm/msm/devfreq: Add 1ms delay before clamping freq")
Cc: stable@vger.kernel.org
Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gpu_devfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/msm_gpu_devfreq.c b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
index 2e1d5c343272..f3c664b20a1b 100644
--- a/drivers/gpu/drm/msm/msm_gpu_devfreq.c
+++ b/drivers/gpu/drm/msm/msm_gpu_devfreq.c
@@ -357,7 +357,6 @@ static void msm_devfreq_idle_work(struct kthread_work *work)
 	if (priv->gpu_clamp_to_idle)
 		msm_devfreq_target(&gpu->pdev->dev, &target_freq, 0);
 
-	df->idle_time = ktime_get();
 	df->idle_freq = idle_freq;
 
 	mutex_unlock(&df->devfreq->lock);
@@ -370,6 +369,8 @@ void msm_devfreq_idle(struct msm_gpu *gpu)
 	if (!has_devfreq(gpu))
 		return;
 
+	df->idle_time = ktime_get();
+
 	msm_hrtimer_queue_work(&df->idle_work, ms_to_ktime(1),
 			       HRTIMER_MODE_REL);
 }

-- 
2.55.0

