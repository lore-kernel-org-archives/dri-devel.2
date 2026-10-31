Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825B2606A31E
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Q5R8AdHG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z0SsEHm0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8B410E383;
	Sat, 31 Oct 2026 16:12:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0266E10E316
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:20 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD00Mv1125257
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SwaZZ5qP/5Os7PUYA8dShd++x67vFNONHodttqsuw7M=; b=Q5R8AdHGzCNqDgdj
 BsZL8sDDAEd2BOHK6QqYqyaXHwO4vp7cwXq9VSjosRQpivDUDf5YR9YDwpwOuTvZ
 OtfgXuyKF44q5L5xYRE+sGPS5I/Hc87b/qBcuI/S/TzFhbfHdRvJDzN0xv4matAc
 sf+mHePfCw7iEtC0buA2IOqhtUKeeIBhf2oQ5SVR4rTAB5OSUDxwAGG65EaeUzky
 e9/Tvhzial8ghYk9EdIh2ZYJJImp/J8bFm27k46/iBuTTJFVgrU2Ahr62dV+XkUE
 orTtpf3AY4+G0snMHM1N+X9MCcFcJhfzujDN4ssUJWbSXH4cKlcu4rqegT1UpjKY
 s6i5rA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn8q7sek7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-944138ed63fso274647285a.3
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463139; x=1794067939;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SwaZZ5qP/5Os7PUYA8dShd++x67vFNONHodttqsuw7M=;
 b=Z0SsEHm06fW/m2T27RBBiUh7EUfK3fuNER7RVi+On6Ea2o1+Bty5qZ0MbROeMyl73x
 lTx4OznZ22DM3j0IaBPaR6wIJqoCzb1tZdP3byMv8TUrLs5tMAV+mNu55Ce8VJK6Kawa
 57ThqIvsYJA0mxc0gbeY9ReRsvJm8s94O58gkSQ84I7Cca5WBiLAX9AC/mpuYMZa3i7X
 5Mka9x3dlWQ8ssCEZdcsX4NPVbFsuATdJUCBvqRen9BZXaaK1zoJV9Acsz2+kgIejBbl
 AR1LnoPapi6KfwtYMHh72CEAWR0cGz9W1P/2xG9vQ3Vu//dGKpgCcIw76gw1od1hcO0y
 e5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463139; x=1794067939;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SwaZZ5qP/5Os7PUYA8dShd++x67vFNONHodttqsuw7M=;
 b=AIFHF+i6eahdkXCG3cVkribIoUn+xCKTCkHyS2z0ISTMke7pwm4x3axZkwwa4qnguL
 DHW48MsJdqwj6pnYQU65IbqGsBUcN3k8aHyWAwTsflyg+WVQpOauYlP5n6PnCIxmrAKT
 53wnY8WlR/mQEyvHKcPeceSxzDFpfNLnuUkOd7jRxZc94hq6PBvMfx3aPArl1MtmZGIc
 ZUPovPY9Lh1XTz3abLW0McM7UN1oaJkAB3qvguk+cg28rOza7NxDigRInkuZZzvfQPj5
 F61zXZtRv7J1CS2D4Hkm5i9xLq6Dp6IfCApiwbNomGM4rJDc4gs99T6lEFpFmpU5Tzpl
 ScGg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2s88zPbcXSTuPFs86OIsm8v+RJ/sNwewsBM0K+G6yZWqcrlCU29xZXm9Q7DLe3z3HOSiHILmtYdQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJc3LRKwvrybl6fhdk6vrBROe0aothCkByKOeJauF/T2lR/yDuZ
 jGx7FV2qIr1DDRvH2EshX+GuYyuNceKSf50/5UGm0VRG5U6P12N68UJVqB7pEnkwPBqNCV2xa4m
 Xj2aTxHyd9/EMGBjW4GFGcMEKUuqcg2+mutZMDl2fKWNMQv5+kpRvdZq4VotCDqNzLHYV56M=
X-Gm-Gg: AYBFou3NG9wYnAQdMcLj9ZWpEE2aw2qk4LD1L9TSiFxYHUXpi5B6jbX29DTt3CULGvb
 SOf1Vh6qyTP8yrj81ilZ9JgDs+vgcmMtf8yjnWpoVy6TUztiZPzCHDTgLt2zb6IFZ7AH4AJ+NHt
 M9EHw4FSNUo7Xe++c0zX62zMKP9mz3MwXemzCDM/V0J8HmyO0ehTeH6U3pLfr49RXsz1N/UiPkJ
 MjLgE6iC6gMygipz6I7UXOMyhijVY2yqMhVunu8Zm1stpb93WeGIm++JPkGWT9BK+tSMpS/jaix
 1iqj0p2SUSnJkPpEkveuJuMaS5dkDfVViT/dubpIEHl2npFqJjZxe0ekgFBk2xHqbO182nr58tf
 TvITf/kJEWh6T8BiUr5yBDFJ0IVibulIpAS+dfggyv/sigeM6lOyUm46kOKy1TiN4sW4ECa8fDu
 U3bp1NExYgUTm+3K7SKUBvlrYZFtEdnFKIqxWSip07mZg4Xo4UVu9GLI3q3sHQ2w==
X-Received: by 2002:a05:620a:460b:b0:937:6de8:b40 with SMTP id
 af79cd13be357-944217194b4mr956941885a.15.1793463139086; 
 Sat, 31 Oct 2026 09:12:19 -0700 (PDT)
X-Received: by 2002:a05:620a:460b:b0:937:6de8:b40 with SMTP id
 af79cd13be357-944217194b4mr956935185a.15.1793463138546; 
 Sat, 31 Oct 2026 09:12:18 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0720e3csm666666e87.28.2026.10.31.09.12.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:12:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:11:54 +0200
Subject: [PATCH v2 4/4] drm/msm/a6xx: keep the timestamp offset before a750
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-b4-adreno-timestamp-v2-4-0836856b228f@oss.qualcomm.com>
References: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
In-Reply-To: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3230;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5NRQ6jOCKhck+miqkwc99g4du2TkN6u82C541AjyHzo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5hNU4Au8tDJx937/aiTxBx0ICIWfYE/1W12+R
 dI3QwcvZh+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauYTVAAKCRCLPIo+Aiko
 1R+tB/9GaEodWm7sZNHcGP1kB8G45SuCqsEUtL1TkSjHdRmV6YMdW8iYO3/AfnX5OVu9Mulsx+A
 Fv2GyYdA9GdVQj+RrlPwYvdc0I+M7pZ9BJ4CTpgslaJabUHVnfUfmey7efixhjBYFEt1N5++eZI
 AnJ88eOrdK2HTmQXw5CaE9mgeAX+x/vZ4BrkpW9chb2PxmHCZA65Zn8sIay149xKEuUYPwGnkBO
 UgPEZeqoP0otv2vMraZHKed08d6aX658t3EpFs9wZeF19NQ2Cc72QoNBzlUzWwIzN1rsSFtLs81
 sBWFbISlDof5d8sFF80nej8Gkg2mn+hk/sdP6bOk8RTC58Qj
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: XlNTPx0fFELAs3NhTUzWBhLgVFAkNcRJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX3IJyWSyr0wPr
 QQTYReBH9cE5uutdEp6PoyrjaQHISiG2HWuhixGS24ChOuE0AJbZBC3Jw2aegz8vb8wOSFFZDjz
 GBxUzv7XMwwMmUtLEp1VAZGN+g0RrOo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX78OtCahhpc5o
 Wu/fvDUCZVfWjrA3ClRcN9+V5I7x4qhEGj+dA7kwhEnzxP7+VKsmfDiibFCYCj20Cgtet5AAmUt
 eiD/H1JrpkFtoqrlsTDP18eRewXaroVGSpK22YxtZV5T5WrZoSuEMJ3qrIw7G9dSQ8itcqfavSQ
 2IQbpADLRXlh7kCDdIBAqGLxgM9DarZeV26EE9ynEggXrmCR29+LJs1Q5qjPzsgTT18KDTnfmIp
 0EjVdoNyuiUACHJuXBi928lb5u0lQ4jnKxF5+bzMObksir0D7rLkx/Y4Wbf36yNV/70GmBLOvJU
 GffnidPG9Q7QEIB2Bv1rEvQWbPwrotCdSKsVXCIWZI9Hj9UVnGfh3JzadaFFHmjyB+qY0lOqWRO
 WZelAu9tfJNJVsGgg3WEkKPM5aDaXz6YR52LLCm14Vw3E+jzW1UTTB23pi0VAG6/EO/kEzVnt+A
 bp15QIcYNJZRzwuy4Tg==
X-Proofpoint-GUID: XlNTPx0fFELAs3NhTUzWBhLgVFAkNcRJ
X-Authority-Analysis: v=2.4 cv=PucG/AM3 c=1 sm=1 tr=0 ts=6ae61363 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=pMFaczZYBad8gVHhDZ0A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310064
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

Before a750 the always-on counter does not survive a power collapse
either: on the GMU-less parts it is in the GPU power domain, and on a650
the GMU counter behind MSM_PARAM_TIMESTAMP restarts with every runtime
suspend, reading 65229 and 68216 ticks two seconds apart. From a750 on
the counter is loaded from one in the CX domain that keeps running, and
userspace already relies on that.

Save and restore the counter around power collapse and recovery on the
earlier parts, as on a5xx.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 92e8c8abb86d..7cbeeccca000 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1575,6 +1575,8 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
+	adreno_timestamp_save(gpu);
+
 	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
 		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
 		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
@@ -1638,6 +1640,9 @@ static void a6xx_recover(struct msm_gpu *gpu)
 	gpu->active_submits = active_submits;
 	mutex_unlock(&gpu->active_lock);
 
+	/* the GPU may not have suspended, so resume did not restore */
+	adreno_timestamp_restore(gpu);
+
 	msm_gpu_hw_init(gpu);
 	a6xx_gpu->hung = false;
 }
@@ -2151,6 +2156,8 @@ static int a6xx_gmu_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	adreno_timestamp_restore(gpu);
+
 	msm_devfreq_resume(gpu);
 
 	if (adreno_is_a8xx(adreno_gpu))
@@ -2212,6 +2219,8 @@ static int a6xx_pm_resume(struct msm_gpu *gpu)
 	msm_devfreq_resume(gpu);
 	a6xx_llc_activate(a6xx_gpu);
 
+	adreno_timestamp_restore(gpu);
+
 	return 0;
 
 	/* If anything goes south, tear the GPU down piece by piece.. */
@@ -2234,6 +2243,8 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
 
 	trace_msm_gpu_suspend(0);
 
+	adreno_timestamp_save(gpu);
+
 	a6xx_llc_deactivate(a6xx_gpu);
 
 	msm_devfreq_suspend(gpu);
@@ -2241,8 +2252,10 @@ static int a6xx_gmu_pm_suspend(struct msm_gpu *gpu)
 	mutex_lock(&a6xx_gpu->gmu.lock);
 	ret = a6xx_gmu_stop(a6xx_gpu);
 	mutex_unlock(&a6xx_gpu->gmu.lock);
-	if (ret)
+	if (ret) {
+		adreno_timestamp_restore(gpu);
 		return ret;
+	}
 
 	if (a6xx_gpu->shadow_bo)
 		for (i = 0; i < gpu->nr_rings; i++)
@@ -2262,6 +2275,8 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 
 	trace_msm_gpu_suspend(0);
 
+	adreno_timestamp_save(gpu);
+
 	a6xx_llc_deactivate(a6xx_gpu);
 
 	msm_devfreq_suspend(gpu);
@@ -2757,6 +2772,10 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
+	/* From a750 on, the always-on counter survives a power collapse */
+	if (!adreno_is_a750_family(adreno_gpu) && !adreno_is_a8xx(adreno_gpu))
+		adreno_timestamp_init(gpu);
+
 	/* Set the speedbin value that is passed to userspace */
 	if (a6xx_read_speedbin(&pdev->dev, a6xx_gpu, info, &speedbin) || !speedbin)
 		speedbin = 0xffff;

-- 
2.47.3

