Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35DBFFF8850
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 06:39:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E1CA10E577;
	Mon, 27 Apr 2026 06:39:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SfzCHpGM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GO1zjChI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E686C10E27A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63QINpaD3909591
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Spu2aZ7sZlC2v6vcrcvt66Eq5ch+u67lu57CxDRsDh4=; b=SfzCHpGM18QafocW
 NPb1KXvoKnxgHgJdKWoyUsKg4zsfSgvO6I5f2HH89DpFL5sQEc+ZcccvLXjCbFps
 VqH8xscCrWKjP9KZRAYSjFusMKws3LOJA4K8p+jjCbfWryXOOZqou0HCS2rRxijh
 2WkRC1xw5Xy5Vqzvx7dBvWVJmDyEWgeXkIYpB0ZhKkNBoqrxQWJx3RSBzHwbn9cN
 AE31ci29FE4nBT3uyRxvv194sKXXUPwZrL/vc7ilvsxRrwlBYDWPoyHRtePR2BPi
 j6pjXkOzkoNBeoYVpLMYq4gqy/OqefYWfZf4ZhJpcIvu+i1ff3QmHRqodsj+lSSE
 DBtAjA==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drnqrmpub-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 06:39:42 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-35daf3d3030so10339765a91.1
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 23:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777271982; x=1777876782;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Spu2aZ7sZlC2v6vcrcvt66Eq5ch+u67lu57CxDRsDh4=;
 b=GO1zjChI4OW1GG53EbYOSaojzjAbX3AWE6+XHTjYnhcTJU7AwCmPJSNZn2EN79xXeo
 6lj9PB4UolHoQJs5F/2FmN2E37CKSepp8xuOdxFT4sJa7VTgC6l/Lxli0lFHy6BOIrlg
 gg/Y7Mzzq5zFy+2BbkRFVfarQLtc2X+mfRzdXbfRmyKv19jk+b4AsQ8HHc6MPKioGOc7
 Cpfc3OyK+2FzT+fGCHe4llUHDYFeX+uu50aFOUpmD5gTBtQaOPWINami5m9p9AbtVRT8
 +L7cmqF9xlaFQuvaGRB5eEJt0+YJaCyzqXmxN6m1TarW98n0FXAH8xZmGAqJh8vHRQIE
 4yaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777271982; x=1777876782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Spu2aZ7sZlC2v6vcrcvt66Eq5ch+u67lu57CxDRsDh4=;
 b=rDFQPjsBZNbPD3NgTP/R1dnjctm0ekRBWYDXrd+IGNdOvorw1fROqYvmVzr3ZO89/E
 NmP8RK2eKdAvI/AiGrU7Gz3uhkd6fkgGq9wMB1L75vyo2AOhucrCh2QUCU3hNNS5F4mj
 E76LHTKRP9b74yf7gqLp1yl0+t5P/lWblY8V0KztYM7eDckJ3xXmNd6/u2k0aXC/DLsr
 Q9xoXHhtX3WaC9OsuBG9zmcU1uwVBZeRJEwC2Daann31DYcDSjl454CXz1ILZrSslkPp
 S5ZMTcpKsL3HqO7tHBNW9tCXVIGSNec0NcJmXkKyUGtoYDPFTr2p2/YirLNa8V4FqNcB
 cHVg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/Dg0P7XTUC8AWKQCRBsGW9Oj7yuU/UXpNOc3fFFpqlGNNkMxaubh33sNkI7gwvATblIUZvz6AHbV0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo2xcYJO/b+BzZLmKMxmokKvC8iYNSDNIwULBLaKX3vStSBDPC
 0Y1RkwrvBg5sQZlQLkUNaGOQ1JUi7AZH/PETkUK2l/B6lZzhzr6wriH03jXBABBhv4rFjL2Yajs
 gHF4F0Hv6Ler/FD9A2euGYDfeDtP97q8p6zVrGXkDAlPPK9WUMojXZ57KwqlutxqQ3tqnYGs=
X-Gm-Gg: AeBDieuyedi75IThkGhQNaYz/WZKtUPF0VCf3p5Gp6jtuk3gRqH4QuXRY/Nc8uAqs6X
 /mDr+L1BqtYLDP6q6dd/G7Q9oLMbCFY7RDE1ie90Belj0OhzbHcGHv1QU7Pab1kv26qWBf/LSHo
 dy6QZq4ueYIL5KleU+CwlVayZsn6cOo04Ft0cuFM6eRSTwoD5rBdgiDRiN2Dnxun71JTlj6/9lv
 60cDnOwAF62M7q26GZASOpRJlHt4Ue5QsRK+fAPQtYn+TbzmrR6WxCDTLB7ODLWAMgeNXqQgqzj
 tP1FdYGDrq19UH9vJomggQTF50t3L5pDv7fxeIXKGUuBOFqQr+w1Gsi2X51vZozQlVJjT4KFatT
 0lS5kX2WISihKa0pn3q0Xp8j4Wa6/22W6TRtUive7+WMrD9lqhRMNV8Ol
X-Received: by 2002:a17:90b:3f4b:b0:362:e7e5:a20a with SMTP id
 98e67ed59e1d1-362e7e5ac9amr12823663a91.4.1777271981948; 
 Sun, 26 Apr 2026 23:39:41 -0700 (PDT)
X-Received: by 2002:a17:90b:3f4b:b0:362:e7e5:a20a with SMTP id
 98e67ed59e1d1-362e7e5ac9amr12823621a91.4.1777271981496; 
 Sun, 26 Apr 2026 23:39:41 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-361410a7ab7sm38628234a91.10.2026.04.26.23.39.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 23:39:41 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Mon, 27 Apr 2026 12:08:59 +0530
Subject: [PATCH v2 5/6] drm/msm/a8xx: Make a8xx_recover IFPC safe
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-gfx-clk-fixes-v2-5-797e54b3d464@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA2OCBTYWx0ZWRfX2qXJW2iHrgyD
 QWYfGr59XGTA6haNG5cKNvi0hVJkHtKD94QJu4Rualkc5tnt13ou/8zuFnzpFeICWLzRytZhq2h
 vFSZfKCQlNGlQbyZA2WYYHVa6Rk0lh8Afe4loVnwjrq9issCSA8s/gGN2zIft5552pI/dFdy+eX
 oC9gP+G+jQZ4rse+GRX9Hr4ykm9jKJCPeYC8BdP0eenVA/LR/C/q/DWLNNm5CkrQGE6GJ2Aqm+r
 vSHyeQMLI3W5io43LRnerj742jStSTjPBdw3QKW9VnuA7iyrCdDE674wkCyfDZ3Zm1/uOqE5Y/H
 N31hExd9C6MBfc7Y2lOkAgKcevHP21jTyDJSCdsp9aqjT9FYa0LGwjdayvECYioKVEPko2eaNjx
 PqmRSa/EAjfnJJ6pTvmvQZ5i8woC0Y7Ow5MGnXKRiKF5mAYBxWmU+hNglDSnVhH0mkGRI6cxU6w
 i6K5keP7n/CVq4Sfu4Q==
X-Proofpoint-ORIG-GUID: JgEBpdi6H-qGkEIP8xIqFF7SIGOvROz_
X-Proofpoint-GUID: JgEBpdi6H-qGkEIP8xIqFF7SIGOvROz_
X-Authority-Analysis: v=2.4 cv=UcthjqSN c=1 sm=1 tr=0 ts=69ef04af cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6racf7IOMx3K1H64_JMA:9 a=QEXdDO2ut3YA:10
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

Similar to a6xx_recover(), check the GX power domain status before
accessing mmio in GX domain a8xx_recover().

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

