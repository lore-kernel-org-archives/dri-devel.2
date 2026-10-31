Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D48606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Lr35K+LE;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Av/YYY0M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BFAE10E34C;
	Sat, 31 Oct 2026 16:12:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DEC4610E314
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:16 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD0C1w2203096
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 oWsw72PImj46weT9Ua70XV9rOd6NJxdtlKsXv4Qx7Ck=; b=Lr35K+LER+4iVlQo
 9PNjD//6jwTlV4c8LtjGdhf4fvJU1LGsq1qBBgR+Ro4LHsgmGVJ3xcp2PkbRKlvl
 bolSG/CSTCs8e/26iHcwjFJRwCXLsSStJKTQ942sJfetv4cZMQHf0iUH0rhULHz+
 N4IjKJy7Y/gp9xVVc0zy+UqYXoKQEAQGIyEHtJIdfarX3dMARgcoJj5FY8/1p+GX
 XvH9xJeX9zS3Cf7XidRiW64Lk0V7JfULZZO9rnSRJ+gu9xmQCSEBJxW7VExBTuT9
 XWXeNlntpRRh1QzHBV15S36Tc+5gcFfWgDV2qAZyuoM/i7SQqj1qMdsd4esGX25R
 jGXANQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn5pkhunu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:15 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-943e8ff02d0so155249385a.2
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463135; x=1794067935;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oWsw72PImj46weT9Ua70XV9rOd6NJxdtlKsXv4Qx7Ck=;
 b=Av/YYY0MF1QtSJKSlQIctWSBqAmQzXk/bQHIwWyKfVb2qet9+umF6GjFMWj18ejNoA
 mR//xNljHLWcIvFfE0bturxtKmZ1vROfpwb0pC1iYKORywpC9ufG3y3j65foRADLE78T
 jBE0LUMk6FbiMuOqLWm1rcI8MrV5yYdsh4qealJJ4fFQQ1vX2sDpDBu0Fl3RQ9sqMI4V
 mcs1+EEWDo9Il53PMKiAtRVmfaSsmDwIDJnrcuCVSH49L6gp/ZPhrpMGVhRd9/44htVw
 aV6iUnPIkmErUFdio/Ydmoa3143pDj0LdBHdiQZPUph4vPabZYlmJzikQRb+5aXYkFgw
 cStg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463135; x=1794067935;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oWsw72PImj46weT9Ua70XV9rOd6NJxdtlKsXv4Qx7Ck=;
 b=dWsHJeCLZxn1NuBl3CcZK2uPtZ/zlcEjdWmm6h9bMXFj9ZRhR+bmakqRzt5Ly/gur9
 uyTuy2M/gbc6m0uE1czd27AAcXStNZVU5/fWVQOJY2zyJXxNcub0g1N9a80ySO732X/T
 gvNMiNAPODO/1vLiA5n+CaAuS9Nk75Tt9GAdieBmYo+eutP9qTcoyPY1m4ciYz6O4oEc
 BLcd6ECBwVOcLYLYWVTWX/nmVgDPm+mOmCq4u95dIwhtJNDNemNr/8Enx8uT1T+Z/Qit
 Xike+5h7KdYlsG/7FsmFNW+1U4rlD5gKJ2FdL5byiQxM6AvlLUOPgXeeU5xUtvYskcEP
 34iw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzHsvUtsJMpkchaRzyx6ZvJnwmcV4sUuzSeO2oTsdlWBrHfXu4KbewKB0KBEnIMv1Vp8EBSCJTrjk0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLtgWu9blsXM5MBLJe/BB2/TolO0oaySQ+iNHiwn2y70KZ7wThF
 Z3sJbnNkkXCuhhmolhzx241Mu8rWkZC3I4V5zlmzY72Ghwwb7g6K1MDaeKX0D1z4Jl4XEwWmiKs
 Aac7r7+z1BE4fWrVdFCGgYbi8S8G600IKBtinq3aVsgEp3b36h1aaqt3EDxmN9dha+dNYoow=
X-Gm-Gg: AYBFou1UBR5O71rbLJmsSYGoL3z6IgfFu3gvTmSDqbB7rH6tv0ZXI4OHFZbj3NnTdYV
 We5cdAOP2KHkHOtToX0Mj2vaHR/HNxA3NplWm4y3pkkksuTuhmE9w2PbaboUQf39pHR2KsQkY38
 L3Mo2rIXn2i4TxMX19CdicmBmiCFYfQE2PQW4eDPd4O+mAVPLwS0uDrZaCNH0y9w6gGu7TZYZkn
 A+Dxn9rgBgtbD5JFMpUXggZcrjf930MdGdUKoO4xTTjzEi9+1A4D1UDJ8wizBi286nuYgc6+UGm
 d3jeF5/7OHlltFWS3gdLSBEu8SGy4GGdeDiA5MfwDT1mE0oseIekX9E7nh1roEEvONv3+6U/w1n
 QyQle6NE3Jcasxmcpt9Oa786iazllVggKwkffAXzS0PizKV8tXgkJpLORfxItZ6mqQ+ytpQn3TH
 zikQiLa22CKLLvlioER3jZDmA/N2rMEx03rkBc/RAZyLfQVswjEVf+ZX1o9AfdBg==
X-Received: by 2002:a05:620a:44d5:b0:93b:d7a2:dd2b with SMTP id
 af79cd13be357-9442175e4bamr928062585a.59.1793463135080; 
 Sat, 31 Oct 2026 09:12:15 -0700 (PDT)
X-Received: by 2002:a05:620a:44d5:b0:93b:d7a2:dd2b with SMTP id
 af79cd13be357-9442175e4bamr928055985a.59.1793463134377; 
 Sat, 31 Oct 2026 09:12:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0720e3csm666666e87.28.2026.10.31.09.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:12:13 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:11:53 +0200
Subject: [PATCH v2 3/4] drm/msm/a5xx: keep the timestamp offset
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-b4-adreno-timestamp-v2-3-0836856b228f@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2357;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lYY/hrbAKLPfEA/li7VCmu5NLk90bGLkzx4vpVBQR7w=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ9Yz4aAClUs9BUlbdRZzb0vMYk65UTjd1mrmXbNd8dkzt
 F6GvFHpZDRmYWDkYpAVU2TxKWiZGrMpOezDjqn1MINYmUCmMHBxCsBEBK+y/+FhNkhtZvOz+H4y
 NUaVo/pXC9OaCp/kS3amD6ts5zsx1Ksp3Ps93+3LOsGp1+fZFlww5vZrnyPy38zO+FNozpaPxm1
 RZ4pMjD9vWDrPR7tL40dkcHRFaFZrwdGdsxwnMsY/yDjVcFRta/FyCWX9umQGoaWSD5vPfJKPbu
 E6LCG4sFchU2a2XpuleYPwYutJzXx9q+8+iGlqtV946l5GfaK2bsn0YiPrMuk5H544HVJqMuNzC
 FaXl8g7WV0s8Hy5jmGzxz1JMcUdT9sCGfmP8fwoPCmfKXuZ3dhutkx8t8bixGT+XeG7lrRnMJ9e
 92hlv26os1zS2wXrT3tf5xL0tFbrPvjbZ52dvtH1VQA=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: gwzAI4KmA5TRjrh4ORyKn-RYexG5GvET
X-Authority-Analysis: v=2.4 cv=Z4F5j3RA c=1 sm=1 tr=0 ts=6ae6135f cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=G0ktpma277rnjfAblZIA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2MyBTYWx0ZWRfX9XtsuiZBpp+Z
 +PLkq8xWawR7Vr6xeiR3xcY8mh6DdMa1nAN0BK94p3H3ugdViL3MiKGwE+Rd8EPjbPhhTpjjYxQ
 FEf9r56el8b7NL6sH8I/nYtHI5yrINY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2MyBTYWx0ZWRfX5JgXxfjmPjtg
 17PpxEvEHCt3R/UpmVFVpBWJ4ih69v71HalmudincbnRsrMMf8kVG1X0kUtYCYDw+swRIyMklrG
 FcWpROJzj1jDVes4nG5owWHPxn47lDaBhXW7Yl9Q3CctMylWTVftbb7ouUMmwLI6aQoJs6Xa4Zw
 UIJ3a3VIifD/lRassUx828qZioHX/Eu3gzjxskIecBs75lwvcPnistdu5Gjrc8bK4SoIOLCLz8q
 Aodk4BXw06qIpNTtB6187eWkc6KouApN0ozzTUsmIakZDbTApSLF8lmlx1GyCi5wslE9VhBXMUl
 rkINIzglxsCGOeTOnD60WhVxn2A5/32FQOWowzGhZ/SAQxHdUIlcv6upCy5Ao/LcOKdtN+JGSFK
 KDW+PO7XCTFo0qwwbWRN23ydXmw+6k7FzccrYBgN4EOe5bTE+XGZ3CkPGuPTdGSTlE+7nqHVqr1
 8oQazW2VdRr4EOj+tpg==
X-Proofpoint-ORIG-GUID: gwzAI4KmA5TRjrh4ORyKn-RYexG5GvET
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2610310063
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

The always-on counter of a5xx is in the GPU power domain and restarts on
every runtime resume and on recovery.

Save the counter before the GPU powers down or is reset, and restore the
offset once it is back up, before it runs anything.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 16c7335c4b1f..fbb92cadf94f 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1025,6 +1025,8 @@ static void a5xx_recover(struct msm_gpu *gpu)
 	if (hang_debug)
 		a5xx_dump(gpu);
 
+	adreno_timestamp_save(gpu);
+
 	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 1);
 	gpu_read(gpu, REG_A5XX_RBBM_SW_RESET_CMD);
 	gpu_write(gpu, REG_A5XX_RBBM_SW_RESET_CMD, 0);
@@ -1374,6 +1376,7 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 		a5xx_set_hwcg(gpu, true);
 		/* Turn on sp_input_clk at HM level */
 		gpu_rmw(gpu, REG_A5XX_RBBM_CLOCK_CNTL, 0xff, 0);
+		adreno_timestamp_restore(gpu);
 		return 0;
 	}
 
@@ -1399,6 +1402,8 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		DRM_ERROR("%s: timeout waiting for SP GDSC enable\n",
 			gpu->name);
+	else
+		adreno_timestamp_restore(gpu);
 
 	return ret;
 }
@@ -1415,6 +1420,8 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 	    adreno_is_a508(adreno_gpu) || adreno_is_a510(adreno_gpu))
 		mask = 0x7;
 
+	adreno_timestamp_save(gpu);
+
 	/* Clear the VBIF pipe before shutting down */
 	gpu_write(gpu, REG_A5XX_VBIF_XIN_HALT_CTRL0, mask);
 	spin_until((gpu_read(gpu, REG_A5XX_VBIF_XIN_HALT_CTRL1) &
@@ -1432,8 +1439,10 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 	}
 
 	ret = msm_gpu_pm_suspend(gpu);
-	if (ret)
+	if (ret) {
+		adreno_timestamp_restore(gpu);
 		return ret;
+	}
 
 	if (a5xx_gpu->has_whereami)
 		for (i = 0; i < gpu->nr_rings; i++)
@@ -1824,6 +1833,8 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
+	adreno_timestamp_init(gpu);
+
 	/* Set the speedbin value that is passed to userspace */
 	if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
 		speedbin = 0xffff;

-- 
2.47.3

