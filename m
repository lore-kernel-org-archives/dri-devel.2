Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB804EDB7DC
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 09:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F3CC10E397;
	Tue,  7 Apr 2026 09:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="nSnbsysl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hMtaL00R";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8043510E397
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Apr 2026 09:31:58 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376lJAg3536830
 for <dri-devel@lists.freedesktop.org>; Tue, 7 Apr 2026 09:31:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2tjvfWn90X2gwQ0oPND/UL5ENlIlf0ru6kXbNjLjd5c=; b=nSnbsyslSbWkgVmV
 E9qgjM+KFyawR11GzKroT5/BaFql7b5DjuINjxJ8TsnHomtr4nd2QV2oqD2Q8hLC
 U5fbJHd/98jEttC5+vZmWaGGpfXnRQlHpV/V5Ay4gwYHP8O6PmlYDB+zCdrqAEjW
 IDI20LtLWB3xWKYGOHJS9vMgWfNvGePch7E/4Yk/XMrtdkSh2bSeGOmd50/KVdUY
 p8WIOfj4JnctrgaegbY7OmRGttWtnQIvGpKlZ6dtSPMb7QywtjTfBRbu42LVyBK7
 MRdwkiGhH5dlr32VWCEiANP8hDImHALYOhhbfGsqAW4/tLhkmb3L50/2yWIwINdk
 8dyP3Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmra22qm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 09:31:58 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b242b9359aso46716045ad.0
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Apr 2026 02:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554317; x=1776159117;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2tjvfWn90X2gwQ0oPND/UL5ENlIlf0ru6kXbNjLjd5c=;
 b=hMtaL00Rfr1wq8WPg/8evvEiPlkdomOnc5THWp9it4iQJiIuKjCs+pcrgrZwFx/ZWh
 q1K2C6xb2o/MJEylMDUtbtNIM5oyLLxkQvBb07zg9h+fQR3dN1XlVvfGXrsczmelZehM
 582cxArDI/mJg1MaDwJl2CRTR18fs+hPmk5a2zhPjdBw66GTtl+P6ayh68gPmJNr2/FF
 wpb5am3yZcvZFroWQcPXL1jwLDCBG5BAMgB7Y18xvqUK8n5KCKLN46Lwx+GAHyks7Gmm
 rsM/ivSMYzDayw3NFP5omzYonkuncIBx47iJYy/EZNClZy41QP5pzHiWnBazm+gXEVk7
 gQLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554317; x=1776159117;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2tjvfWn90X2gwQ0oPND/UL5ENlIlf0ru6kXbNjLjd5c=;
 b=Db0KhZ2plIFtS8Ri+9t1AcKHu6hIBL/uTwNuun+y88/IyMWtCFHpObuTU7wD8sepU3
 D9lOqvv80WW1fgDZ9dPvOxje43LbqqttUC2mvQ8XynDgE4Lc2hShoDp/FDV7E6lXALVK
 XlT1VLmGmszKZDsNIB9QYZj8ycdp0eQPLa3G8cS16mbgfsD07ntAL/5ACMTTt1ZB/OUw
 v8ek+g5gGjjk7SVOGllxZqNhrAVAlI6KFjWOu7TuoxIME0MxTnQGpwZtULGDLaHE8z91
 1D2oD6HKj0HpBlRrI9wrGBq4Ma+PV6xx4LSDDde70/EkDqeACgLz6fJTCl1LgeYpQJV0
 p27g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXAPCJjbfhRuuu6vXTHh+vxseQ2y4DOp8eTZ69Cmizc1FyBvn5QmKaqsj3uD0+qS+/R4evOnqvO9qc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEbmrcwLshI0eQhLxpptxWpGt3kLEuyw7zr+5FeywVjD61ChdA
 j9MLUoAhtb7bW7r7Bhr/L9fTrAufM30Rjt5ox9crvw7ZhHaB6azNGzyyyhIuC6ywV7RvoKzN6Po
 u9hcyuSYPEw8NYcSvFxKjZyAuEi9wgmQgKmHziQf1LxLn5QPoLa5Qj7eXsuyBFJ3JhjbxTNk=
X-Gm-Gg: AeBDietqJElKVE1afVqImftHnQA7gaPrTR5Bfb7Vu7bnZy450ezwONU3EEdOK9r00Hq
 upvfgD1Q+1HZbphIwJRds1BDKa2lQ6HB9Rk7DNgNObPxDC2UTfilIiyvlbLT50SP451pxxzoNqI
 zxp4qoR0uwp/nIvNl0Qn+Db+1OHqmUIfPf0vGcZPc4xCH5U8ylC6HCWrizL+NL4pHU0pPEohZmf
 SKPGsg+PjtJue5ZTb62O4J0ULuvRXlBRGGqGSbT2fnWHiWRrq/jDXMoBQh4SLEC8kw8npOtdNdh
 F3db0S13+WCHk7/mA2cM94mi3RP/xtLd+vXFCCE29s6nsQYWSLFg4dxyDQG2C91KR5R21d3Dayp
 1g7ljKwbh9a/md3X00ix8FXon7pXwGlAn0+wK7nQKVvaTwQ==
X-Received: by 2002:a17:903:b8c:b0:2b0:6885:f1d4 with SMTP id
 d9443c01a7336-2b2817b5e43mr172137905ad.39.1775554317317; 
 Tue, 07 Apr 2026 02:31:57 -0700 (PDT)
X-Received: by 2002:a17:903:b8c:b0:2b0:6885:f1d4 with SMTP id
 d9443c01a7336-2b2817b5e43mr172137655ad.39.1775554316829; 
 Tue, 07 Apr 2026 02:31:56 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27478bc96sm172888365ad.33.2026.04.07.02.31.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 02:31:56 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Tue, 07 Apr 2026 15:00:55 +0530
Subject: [PATCH 5/6] drm/msm/a8xx: Make a8xx_recover IFPC safe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-gfx-clk-fixes-v1-5-4bb5583a5054@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: SiXnWBSXwro2OygIG0ZpD7DJWe8S3d1-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4NyBTYWx0ZWRfXyY2bMTo/pqJr
 oXjN/TABcj6aWSv0whElAeSE1hHx5+Qdayq9Oed5m0HYeaeVIIJCIY7rtLK0ZHsolpy2ySlm8di
 iM0bUEZycPZXVkZeahZ3jA6YRYUlSPAidAelggs4U40kZGtcxoOyox4YYnOELeug8mOE3nPT/8Q
 kZZYZz0DUYdMYbk2+b23XCdLkBuDcOtzAab5G+U5Jlf1rBLo5EZnajQPd4Fx8uaOK9H+orzBNt6
 dcsIeKqkAAhgAB2dgtgYy6Y/EWlBSS6xHDLuCbwfWCU6MeBUUFuJIcNbLF5IGAuhzGXTQweTVed
 lhpuh/JJZTJ9OO1aZcQuOM4vPVsZqe7LXI3a2ih3E0zA4OMYOlvMK860YNgJ5+tpe5gg5Qlx11L
 2Y7aYpqv7mFvx1B9vs06Mb+99z5/oaM7f0rSS6MIWWbYaTXQsPBYlSstuuL/Ow2HSkBSO9z+i7G
 A+hAZW7Huhaxg+7v9SQ==
X-Authority-Analysis: v=2.4 cv=BKGDalQG c=1 sm=1 tr=0 ts=69d4cf0e cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=6racf7IOMx3K1H64_JMA:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: SiXnWBSXwro2OygIG0ZpD7DJWe8S3d1-
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

Similar to a6xx_recover(), check the GX power domain status before
accessing mmio in GX domain a8xx_recover().

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index ccfccc45133fda53168d3475ebd3d543f10268af..9b99ec5ceeb5826fbd5cd1059febf5bc5ba468b5 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -886,17 +886,22 @@ void a8xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
-	if (hang_debug)
-		a8xx_dump(gpu);
-
 	/*
 	 * To handle recovery specific sequences during the rpm suspend we are
 	 * about to trigger
 	 */
 	a6xx_gpu->hung = true;
 
-	/* Halt SQE first */
-	gpu_write(gpu, REG_A8XX_CP_SQE_CNTL, 3);
+	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
+		/*
+		 * Sometimes crashstate capture is skipped, so SQE should be
+		 * halted here again
+		 */
+		gpu_write(gpu, REG_A8XX_CP_SQE_CNTL, 3);
+
+		if (hang_debug)
+			a8xx_dump(gpu);
+	}
 
 	pm_runtime_dont_use_autosuspend(&gpu->pdev->dev);
 

-- 
2.34.1

