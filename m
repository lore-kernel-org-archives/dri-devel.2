Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA45EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20AEA10E39B;
	Tue,  7 Apr 2026 09:32:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n9lNxdUU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bQKl6aiP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CDCF10E39B
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:32:05 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376UwfX3536859
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:32:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=; b=n9lNxdUUZhqiN7Wr
 dqJnk/9BBJRZ/D4SR6SDMY76gA1GgHx17IOWRnyhUpy/by4fKdTGN61eloGcmcFK
 jT9ldeFQq0K4KZpiaE1vWx5qSudZaQBizulgBgcXsjo5PGtkf+Ta4vQBlJ5wRpbO
 Hwg5DGztVYrboGJcarsf8gmfWWgihn43kCum76FS/plwGxZNguPQfcpCkWiSU77f
 P1MbnwjZACZnPbG50DLP7dtsgBzhmEAmlO2ou7G42bAIkh+cIMz3gBucE5htDBTx
 ljeMmOaY61H/UjSIkrCtXZfGSUMGpAzsrPISRFIj+gccEN27IgNzrvaWyN1fYpAh
 Z2eF4w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra22r5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:32:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2b241be0126so132698155ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:32:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554324; x=1776159124;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=;
 b=bQKl6aiP7n6Wybq6a5DDGBMWnJ5wgHARUs6oxv0NQpO5bA7tBdWZqayHjvACN4ciZL
 CawXX4jTwH3XQIX1pk/iWQKx17JxhVXLaJemswbfa/Hg0Ze9w6LSDUe+kQHmgnBEbLwY
 gbqyGDtJ6dt7zjX+r6+gP+pv7w8nBu4LxBx+NMxy9wL9czZKUtZ0wKI3GR/eAMY+l/xg
 pEOBX3bgp409OjZajaFUNdsfnkYr+WqGQQQrHipP611VKFrePPnVBPNoqCMkbhjRjboO
 d6HKGc9dKpq7TITj+WFPjEW6KM7XtV8Wjnj4e7hTsJ90Bm7DLNKuqNXUwiuqr0tn4ZJ4
 2ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554324; x=1776159124;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=;
 b=QQhozNxKyYa9ehV9T5MegwDtG+rM7JEdydM+OBYw2teHf1S3nESRVNq31ffa58Ed1r
 8e9teVmPw0OkfyOr4UmcNZCVpUuHFFS3mRxFvIEcBREKPyd6UC939MTwXU0Vjw04UqVw
 bTgZ3K6BeaXPmVEiez1aatUH+yv/C8KQ/rcoIrFfaUGUsm+eezfEAMQ5rqdS14nSDfO0
 Z0GyuHM4pzgxOyexH858pX0L5F5PSBZnRVppgelaxDP1md8Fo97I8OHetALTqWnSNuVX
 wcJA43C6cSPts93RnrGlsmpEj2XqOx+IIrlgUwzBaCMLiGxKpAgRUgLu/2I3AIVgtNH6
 Gy6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhyNoEWKGOH2riNDCFDqa0tFy7FGseDTx4KVANiOkKT6NCmkDpAtKgI4TU8iGMBD+RBNMEwpV2XJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIHMPSmsCHz7pPN59xm1Y8eTYoLiBsldrUHe/UxHjmRFzPEYUR
 R0X1rD9V8hYAerUaFRYRieNigXjb/OKsXnpv88nk+Iy7PR8crKfRhhNLWhNfel0c8n13FpOCQYL
 bqwNo5oR9nFSNkdXyKGKYyEdje0tfrvw9i7Cxpa9OWLJ43N4VZVUan6HMoSiueJ4u9grqP0Y=
X-Gm-Gg: AeBDietp3FET8O5R95CL01+kabLfM/YtE7xSHT9rROlmqXxgfMZR6YuN8/Zay73bpyT
 QQq6QYP/42OD5H7ZUT+7YCjA6S8DR927wBBrchfPLEkzzm1gavZPjpW+EyCx3bywbUMaq3D/Rd8
 ByTrD/qL9JFhZ52Y/XOTiRbqQbDTQ7fGZ4Old8Iab0fA/7vWUZuYDF+N2q/hJWJ+kW+HQ9u4fM6
 8nc+IysayU+eBFRVKQEPUX1qXWq4zrY+tUOiXh6P2Dv6wAFOP97zrfq1hQgO4Yx6vwTvVyRZevN
 3WBB0uckVPlhViY+owUc5PFPRDIEn8e2BidhprJcysMNQyYPAqCs4kLcVJSUuY7iubCSc/QkyqQ
 TiuKYFIFYAiIwyaejXHMQOm5E1AOpZlVP9KlcY+qZmbwaEA==
X-Received: by 2002:a17:903:3586:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b281705e9fmr171104695ad.22.1775554324127; 
 Tue, 07 Apr 2026 02:32:04 -0700 (PDT)
X-Received: by 2002:a17:903:3586:b0:2b0:b325:748a with SMTP id
 d9443c01a7336-2b281705e9fmr171104335ad.22.1775554323620; 
 Tue, 07 Apr 2026 02:32:03 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:32:03 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:56 +0530
Subject: [PATCH 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-gfx-clk-fixes-v1-6-4bb5583a5054@oss.qualcomm.com>
References: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
In-Reply-To: <20260407-gfx-clk-fixes-v1-0-4bb5583a5054@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
 Imran Shaik <imran.shaik@oss.qualcomm.com>,
 Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-ORIG-GUID: IlaIMpdNCvuTHVbO1rwDn4m5YjyAaCJ1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfX9BQABYIvnNgZ
 BoFBopMC3XGC7eenveJ8DqZupE+hXwlfRFD0sQU9/vG2PJW94cHr2G0jItNBrGGcrCcFZ2ppvgK
 wLuEzyB01m81ECaAW/HxnzawkCbCUxNozv2ru98jZr3LE+XdIpSoxTLNeCA3YGy5h1Jo2Ch1gp4
 arFOO5j38ZqteNJt3G8BT8p8lFOq8SRl2y22mSbNcd05pc7PFT1H9VrXjh7tVF+CShCFskdSVHY
 wGxnqnr1evPM6sjtmqxiZkXBR40/4gwACNjoMLeJtwLCY5+p5rfpd/GxV7VWUI/W1ziBDOzmJ9n
 F3bF/tphq4oUw6OgpJnrOt4PRryQW5Mq9m4e/zqSzG/o6g8oO9c8jOv0RRhE0QzpiifpNfLAlkz
 JWBdvGq6gOAGTjSwUMCjkCfd2ahKBncp3eddO9eZWMyjWZjZnqREf+GyThzyxpOFNWrkQhwN7YF
 AeEfAjD8KhAQpcPiZ9A==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4cf14 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wUjT8lVc3dO_4AMqBZcA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: IlaIMpdNCvuTHVbO1rwDn4m5YjyAaCJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0 suspectscore=0
 spamscore=0 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070087
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

From: Akhil P Oommen <akhilpo@oss.qualcomm.com>

In A8x GPUs, the GX GDSC is moved to a separate block called GXCLKCTL
which is under the GX power domain. Due to the way the support for this
block is implemented in its driver, pm_runtime votes result in a vote on
GX/GMxC/MxC rails from the APPS RSC. This is against the Adreno
architecture which require GMU to be the sole voter of these collapsible
rails on behalf of GPU, except during the GPU/GMU recovery.

To align with this architectural requirement and to realize the power
benefits of the IFPC feature, remove the GXPD votes during gmu resume
and suspend. And during the recovery sequence, enable/disable the GXPD
along with the 'synced_poweroff' genpd hint to force collapse this GDSC.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 64 +++++++++++++++++++++++++++++------
 1 file changed, 54 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad868e6454b9140284cc7ebedc4f59a..b7166a883b018f459caae742e9a589f32167f8d2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1250,6 +1250,56 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
 	return 0;
 }
 
+static int a6xx_gmu_gxpd_get(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+
+	if (IS_ERR_OR_NULL(gmu->gxpd))
+		return 0;
+
+	/*
+	 * On A8xx HW, GX GDSC is moved to a new clk controller block under GX
+	 * power domain. The clock driver for this new block keeps the GX rail
+	 * voted when gxpd is voted. So, use the gxpd only during gpu recovery.
+	 */
+	if (adreno_gpu->info->family >= ADRENO_8XX_GEN1)
+		return 0;
+
+	/*
+	 * On A6x/A7x, "enable" the GX power domain which won't actually do
+	 * anything but it will make sure that the refcounting is correct in
+	 * case we need to bring down the GX after a GMU failure
+	 */
+	return pm_runtime_get_sync(gmu->gxpd);
+}
+
+static int a6xx_gmu_gxpd_put(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+
+	if (IS_ERR_OR_NULL(gmu->gxpd))
+		return 0;
+
+	if (adreno_gpu->info->family < ADRENO_8XX_GEN1)
+		return pm_runtime_put_sync(gmu->gxpd);
+
+	/*
+	 * On A8x, GX GDSC collapse should be triggered only when it is stuck ON
+	 */
+	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
+		pm_runtime_get_sync(gmu->gxpd);
+		/*
+		 * Hint to gfxclkctl driver to do a hw collapse during the next
+		 * RPM PUT. This is a special behavior in the gfxclkctl driver
+		 */
+		dev_pm_genpd_synced_poweroff(gmu->gxpd);
+		pm_runtime_put_sync(gmu->gxpd);
+	}
+
+	return 0;
+}
 
 int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 {
@@ -1266,13 +1316,7 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 	/* Turn on the resources */
 	pm_runtime_get_sync(gmu->dev);
 
-	/*
-	 * "enable" the GX power domain which won't actually do anything but it
-	 * will make sure that the refcounting is correct in case we need to
-	 * bring down the GX after a GMU failure
-	 */
-	if (!IS_ERR_OR_NULL(gmu->gxpd))
-		pm_runtime_get_sync(gmu->gxpd);
+	a6xx_gmu_gxpd_get(gmu);
 
 	/* Use a known rate to bring up the GMU */
 	clk_set_rate(gmu->core_clk, 200000000);
@@ -1339,7 +1383,8 @@ int a6xx_gmu_resume(struct a6xx_gpu *a6xx_gpu)
 disable_clk:
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 rpm_put:
-	pm_runtime_put(gmu->gxpd);
+	a6xx_gmu_gxpd_put(gmu);
+
 	pm_runtime_put(gmu->dev);
 
 	return ret;
@@ -1455,8 +1500,7 @@ int a6xx_gmu_stop(struct a6xx_gpu *a6xx_gpu)
 	 * domain. Usually the GMU does this but only if the shutdown sequence
 	 * was successful
 	 */
-	if (!IS_ERR_OR_NULL(gmu->gxpd))
-		pm_runtime_put_sync(gmu->gxpd);
+	a6xx_gmu_gxpd_put(gmu);
 
 	clk_bulk_disable_unprepare(gmu->nr_clocks, gmu->clocks);
 

-- 
2.34.1

