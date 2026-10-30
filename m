Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF2C606A339
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=m6ZHmLGN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YNai05wy
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9179E10E638;
	Fri, 30 Oct 2026 17:09:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38D2310E217
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UERDli3552366
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 +pKgN+iyHM+dHZqnvSBYkvdG14OZA8VI6MFzP84UyBw=; b=m6ZHmLGNyJ2nn+bg
 VkIEbxDtWdCFX6ztB5uVioliUHo8SAtnClaeB2ibGq7wRxB2d3jXgL+rSP5L55rx
 elj12CqNDZc7gyXU+XVw8tM5ABEYXNBgHcp7cgC9WIVZTZjMpSI7K9bD3M6hcBjJ
 xtpgcX7DOq4siAz8cF2KIU1b928saqkRAH3fS21c6Zf01gr4Y9GAVH6Ztig7Vly/
 0ZD2cz5n5+T8k+d2kUZedYtUKRYh6vQ9HnFj2nXS9f4kh6FuCm6ErGfi/xWzuxe/
 v9brjGt7KSACuO6pZleB40og2HSIMpyixdMsvwLPu1k/80FC8ANWZd/SgxGVgqrn
 bdRLCw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qm2x1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:09:44 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1a2af4c8cbaso438029c88.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793380183; x=1793984983;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+pKgN+iyHM+dHZqnvSBYkvdG14OZA8VI6MFzP84UyBw=;
 b=YNai05wyCWbLG3ZNoAAs6lvI62/zjAphgOpkhamJSLW1vMx8mk13ZD2Rg9HWYk8n1t
 CmAY868+4ULoloDR8gNZ6ypSKcuLw7p5Xz5SliUqMQh3Y5NGVTLDYm2/k7Vc4iBhDQAN
 Ws3MOOSLrbeD2y1IZkysPnM6GtMA+q/QHKgwb8ZLfEsRBjEEL0IFm70E7pZHPeqbyy00
 Vg3JRBXbJNyms514s+CEdvohKgN9uR5PQjHdZcyB/11asbToaZlzWEVTXj1MIq+Wld5I
 C9MG0Ftqzd817MvXnheaOOGk7mFfO0hF7q0NjIekHp4o1NH2U4VOtvIcZQlIi54Lcwrm
 VzUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793380183; x=1793984983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+pKgN+iyHM+dHZqnvSBYkvdG14OZA8VI6MFzP84UyBw=;
 b=I5ufy3/UXa9fIRqvN5dACBXOU7xw8IW6+p/nXX+SSiIOglSNpYq+5po+ZLcYKccmHV
 LwWIATHluyGCVq9cHJzrIvLsIdOiZq3gVHxGh9A02cG15Jsw96OqN/i77htyLyalXSJn
 anZsIIiU6YqUOR9F5YS/wjgQF1mEPPkwU5p44KwDvj18p779anEF0QDTwbMJWKXG//xv
 oW+D8UrXp6QfECpN7PMijNCBYlzq3QXU8CMLF2ZTiyiBtf9Z3FFnCHV8NQQJNPWLlJqS
 16D+hOqivdh0HAjCZ93FoOysqImFq+ic+45JILyDsa5i4fCOb7JQJSfrL9Uw/qzCvisu
 7jvQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxYipLkEmPs3fESAfjtiCHhLp9Sj7bbT8/pk/wfqeAG03UAZQxYzY9fldbmYfXs6BrqCToBPZjFhI0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKvFL++Nv1MsdFUuHPKGgR5+V2Nwvwhn5P2EQjNLGlBOVzLoJ46
 srP2WR5Vv9HHrDNnYrv+JPYxm/jjzJDekw+WD/OiGMDpPEOSoIQdXwx4Cld8bLndYDlXi96KXZy
 QTIk5jrJc6gCYUFVHyXc8GGWGEqtb3eS1isb9XHgzbR8xV7BMfgFX8XOvUbnuCokR7vdKiO8=
X-Gm-Gg: AYBFou3Y4jbaX/Olo7FtI89OJXF5llDSdkdNvny+01dTuw9ccMIBm2om5M/kj+n6sm5
 J/S+ilXMQ4gclx3L9RUERjfP9XC6LU6m0HMzyQs3iQmX1jyDGW22F9IjLnzyNSSgNAFy4Lkt9VN
 cycyBpGZYgKAHuPa+3TJXB6wP2wCisepN4GTS3rO6rujbghqGYpO6RttI5uLTMhe70msi/rXUGz
 TZtum2ktlwuHSXA/LNQGp/tNqarvrJu5Cf7Oi3XH+eQtCSY6Ho8F241zRHiQp3QPQmKGBdQy6Hf
 kXD+aU4m6eIdG2cvzkEjW/uatpJK2rVp0Vsa6aykW94CPUDa9HEvg4Bep4cSG9cyD4YxPlkfsFd
 jpaiIpvJ9tAAzupn/oF8210a7sbzK7PDy3WE/uRy1cTl16KCh2nWlRHREVqfcw9oKTTPyMXY47g
 ==
X-Received: by 2002:a05:701b:4586:10b0:147:a685:912d with SMTP id
 a92af1059eb24-1ac5bda418dmr3749240c88.29.1793380182933; 
 Fri, 30 Oct 2026 10:09:42 -0700 (PDT)
X-Received: by 2002:a05:701b:4586:10b0:147:a685:912d with SMTP id
 a92af1059eb24-1ac5bda418dmr3749206c88.29.1793380182465; 
 Fri, 30 Oct 2026 10:09:42 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1ac194b5437sm9481168c88.13.2026.10.30.10.09.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 10:09:42 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 22:39:22 +0530
Subject: [PATCH v2 1/8] drm/msm/adreno: Fix invalid drvdata typecast in
 adreno_remove()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-gmu-sync-state-fix-v2-1-89d3082d97af@oss.qualcomm.com>
References: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
In-Reply-To: <20261030-gmu-sync-state-fix-v2-0-89d3082d97af@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Neil Armstrong <neil.armstrong@linaro.org>, Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akisaira <akisaira@outlook.com>, Vladyslav Tymoshchuk <tvlad744@gmail.com>,
 Val Packett <val@packett.cool>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793380168; l=1507;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=cUPrmtdLtvyA8qWNZ70NP04TMjj4fezEiP2SX4BUv2M=;
 b=SbxIO+Tep6mZX6zixBFP60UBj2aAFuVRJTvvFmYsQYCr1b6bBt1cRMncdsoIVf2mN4XV3DRSU
 2Opr0S+GriNC3mU0WnPNGK7zjNo5vrlVCOLvV3dyux89GC9O1NQJQB6
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: koi-pwjFqsr4mNtPZ7kZp7Rr7v1_cmqK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfXy4nb/5A8MZli
 weKt/y2bwufGoKP6BzhMX+ZwmgfRH54+9xivpApZTD8msmfrds6dVlLpb5+41AzlgkjCrKeMDvE
 +znpc0LZK+y8K40Fryf6rLy1EXumd24=
X-Authority-Analysis: v=2.4 cv=DfSCOftW c=1 sm=1 tr=0 ts=6ae4cf58 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=K84Zv5WaSeujtAAFOroA:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-GUID: koi-pwjFqsr4mNtPZ7kZp7Rr7v1_cmqK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2OCBTYWx0ZWRfX39PHNz34J9Hk
 1Rmjpi6IhWn07I+oaVdk295ELOS6DLFp/gLgei/R0ZXQb0LsKl3tAP6JL/vIIHODsi+HU13biig
 PXsvuvfici4tg27UsMmX1PIea/SjF8NsOZ5xGfTwsR40o5G4w53QtYaIlC1FxczcnmNenol3k9z
 uDvwbq/YCIf9lH2BwRHWlpPG6XWaV3qyJ7dKkLgx4v7YSb+ixK45AHoQewL3hzPiWyECArXHQyH
 cgKK/8fkwNLpx9xXHMdSrhZIbEEgYYRL+BhhyBD8wWg9PEhTnjvhD50BugstI3tpbHgyGysc5Is
 c2ug1si8wvEdCX+tjSbaPgTxPQQiQhFjvk4sBWasmAF7emUtMeYEu3mMt/TaGfHKnt8ZmypMpfY
 5PxqM7e/CW11Br5AgOy+H0wFYQUcsE6dUi3znmsEVQdzdHDX77Z4yLZ1zc7lo4tXX6vF9Vl3Zak
 f+Dk73r5t6M68PkVoyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 phishscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300068
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

adreno_remove() decides between component_del() and msm_gpu_remove()
based on platform_get_drvdata(pdev), interpreted as a struct
msm_drm_private *. That dereference is wrong because msm_gpu_init()
overwrites the GPU pdev's drvdata with adreno_smmu_priv pointer.
Use an alternate check similar to adreno_probe() that avoids this.

Fixes: 643515a9cd09 ("drm/msm: rework binding of Imageon GPUs")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7108d4aa59b5..1798bb12805a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -282,12 +282,13 @@ static int adreno_probe(struct platform_device *pdev)
 
 static void adreno_remove(struct platform_device *pdev)
 {
-	struct msm_drm_private *priv = platform_get_drvdata(pdev);
+	struct device_node *node = pdev->dev.of_node;
 
-	if (priv->kms_init)
-		component_del(&pdev->dev, &a3xx_ops);
-	else
+	if (of_device_is_compatible(node, "amd,imageon") ||
+	    (msm_separate_gpu_kms_components() && adreno_has_gpu(node)))
 		msm_gpu_remove(pdev, &a3xx_ops);
+	else
+		component_del(&pdev->dev, &a3xx_ops);
 }
 
 static void adreno_shutdown(struct platform_device *pdev)

-- 
2.55.0

