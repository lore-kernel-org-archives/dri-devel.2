Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B592FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C61710E27B;
	Mon, 27 Apr 2026 06:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Nvom64kR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iVUgbRKA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E616110E27C
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:50 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R3MnmD2526400
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=; b=Nvom64kRl3CVEg9v
 VxzjqyKzMgv4wplcqD02BaPhFVqe2fyTtYCnOb+UYSakQJMGOZC6MwSyhr57OaVX
 7NHeQRYVmTve4d1AGhHmwQ0RkVqbaOXVPChTKYjIKWum4DU708aMBbIwRxxhmGRc
 i5rd9Az7NSlAPLXx8EqNzebqLRuM43iA/dJnBYQHyY6Im+qeyAZUOYgYivKf78Mn
 n7GhnrsAH+s1q8do/quUagvVdwMj5CYboMCY1eo8sdcSI7qYkYcSwWLTQ38pqaAm
 Jx1Fh/jCkRTRpBOekU6TU9Xhno0ZwVSgp82/RknRP4f4dRFWQJ9FgCABGiRE+ft6
 hxlxJA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrmput-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:49 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35e59791605so10496790a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271989; x=1777876789;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=;
 b=iVUgbRKAqMRutT/WLd+Y44Dlp2rUJGxSGpeDivvZDmz+87Eo2TRZ8rIy3B2gq5TUoJ
 OmFlTlP32YrAs2cBHeMdACvKY/tFDSUUGvNTJFOi/SG/9yQUtH4l6eRy9Djs5eInJk8Q
 p+bolrPn2u9vTMhGk9ULl9D/OS8K3x/fVpeb/Rd+HhH/fs5eoE2x4Od++1hqjUuTSDen
 hlAZok9UgpulTJtXQYEny+8xePlfrcexwLEb3+QPOYlBqPFA0NkA/Avffbqu+f/EDv5u
 +/MiHh4GwE12b/kpnMFocXHfpXd7Fsx2KObXXCJ+UDnoG1dR3lWG59KytER/QjSCI/YD
 uywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271989; x=1777876789;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qzC8dA/21UMvhLjLYCfzr/+6i+/FSPhWX2hchnV7imk=;
 b=R214OBWPDiJEZ8OzVzd5OJetMSVWREUDRzbT9ValNKa+rhqcofdb9zPPbySFHxHTHg
 SjgS17RhIpntRJMSm3zYptPtlq9lSTAuqJ4LMfGRWGSOS+pVTdoX+rUhks4U9IdX5sq0
 D8gKkFrHH8zMW+D2rImfkkBA9axMGYayrrQcUeFf8PYspcRNHmF+X+lQXdQZwGt6vr8L
 CmxrnL4d79QrocUDMEUCRolHSvTGZfAPGahgbmStcYTO819o3Dlb0TD3j+t/DogUkTWD
 Ne9dELoX1RPMWe+YTpEwLOPybDOTyaWNgnapajBL1PIKnM6iEFaemc8SEJFX8f+ttBIb
 45Bg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E51gspLNiElvmN6F8tH/+hd0lCDh+XAEsLaTPd+G92oIiZu3w+fPkUiwgmbFwJXKSwc+tXZlTfH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ+ybr+dCmvH32EHNqDn1Az1qVkPrKXfa1iPlfi93ZA/r153ew
 KF/2U8KGf2tMaeNZB6soLY4qCyfJIMvSwowswyEn+nyqQzAMViixRddqvCeGTqjSPGj1Ugo+XOH
 208xt8cx30jjcQBv31CFYhhJXGRc4NRQkeEznBiTfTrtSOQxQukwHj8NjOQbk5T+sRjcrv2c=
X-Gm-Gg: AeBDietxGfHJm3lMZ79DrQN+ksRM7UQW9QTL7sHwvfB+ettBxZc2pslf6OHp/pquz+2
 kIcjKYZNJ0a4HNfmyfwIXY/DDBHMoA1wfmMWl/yWwgOGUne1MGmERBSG6ifBLpnnZhr4RYnHZ6s
 31ZQ0nZglHOsS5ltK0wP76egEBoCW8wNl09Z1mvzLUEnFQnRumtyAFzippmI6ZYr6cUACq/RG4v
 YJd7Bji+lVgxaGCSfmW7ZHrllBbq9Bl1ora+RZF5uOcYYRZE9UCXY6wYjM2PAmstt8DIaZznh8J
 nMVq8p3Fx3C9EGKu69zfPHOTtRfT67GIe0R0W+Sl6h5jmA27kgM+SUovkRHhR6pqu9gGfuRBnTU
 EBQUMBQEd7cnXF00Rn+uIPNOx6YUp3Z3uqvrgjKqssudnJXqULPX0lyg7
X-Received: by 2002:a17:90b:164a:b0:35b:96bb:47ba with SMTP id
 98e67ed59e1d1-361404c0ca8mr41138502a91.26.1777271988883; 
 Sun, 26 Apr 2026 23:39:48 -0700 (PDT)
X-Received: by 2002:a17:90b:164a:b0:35b:96bb:47ba with SMTP id
 98e67ed59e1d1-361404c0ca8mr41138449a91.26.1777271988319; 
 Sun, 26 Apr 2026 23:39:48 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:47 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:09:00 +0530
Subject: [PATCH v2 6/6] drm/msm/a6xx: Limit GXPD votes to recovery in A8x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gfx-clk-fixes-v2-6-797e54b3d464@oss.qualcomm.com>
References: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
In-Reply-To: <20260427-gfx-clk-fixes-v2-0-797e54b3d464@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX/bNJPMo4vYo+
 pakyQVZcH7raHr2yqX/olC2wF2lWy/ZDLrnpzobhIR8lHegkgtvc0pwCrpAwg9BVxTFSxVkYT/w
 TiaZ+GUDdhJEoE1//ofceADXtjZy0s28BgnON/znpuNHaPAcwQS80OUyHE0GiUEXdt/b/8uplgd
 MzPYsOxwki6+Dr6A4+iXDVMqItRPR4uYEPdfQIsrJEuTWmQ1orgfXGi/7Ee5kX8yxscHvOISzqB
 OzX9eRRBFQYQNryXlXbPpZFy3q+f4UGwC9a9ATLxcVer0VY/aMXgHqvHtcv8VI77b8waNXcin5n
 odmXXzFvS7QOVPws/y2P6OyhT6a0tiJ9OrVO03KjaZH+Jke9A72WbtpV28FXVPGIzENoBhlAFvo
 SA6t68WH7//9JB5HEAQYDB5iRShhPt32xqteEJ5f5Fk15gbsdJhY6r+CjUSo0jFj+cW2W1pe6FP
 36n5ojAy0NjeflQJChw==
X-Proofpoint-ORIG-GUID: w9TkDDFR4RWT52Tiu4hzNj2jn_oXRBEo
X-Proofpoint-GUID: w9TkDDFR4RWT52Tiu4hzNj2jn_oXRBEo
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ef04b5 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wUjT8lVc3dO_4AMqBZcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270068
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

