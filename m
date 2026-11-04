Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275DF606B0A1
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bH/Dfs8d;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OEnleH7D
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E18C10FDBD;
	Wed,  4 Nov 2026 17:59:58 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CE4A10FDC6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:39 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4FiqYi3272836
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=gzjrY8YLclt
 +Cdw4cM+IfVHKe+qb0Pzmu/tMZyi31YA=; b=bH/Dfs8dg9auMVKpYtfJGa7/9Qk
 TbzTsxOfygrtvPZoeOj81PD/MAPgSe5o1bMfOCb0it3ifjfKDjdYPlDckirzd1Qy
 3lUcszvK3Z4Hyntuz69QXvjHGa9uLgBvon4frPuYk5UchP1f5L5YFC1gnxSPfwVs
 cYF5HjMam7UYJynwbYk0/ERqzB4PSdo28RpeVmslrAh4S+7DRo7l6WiXasUu7ucR
 Joks2Y9bJF8OHYAGe3sOv0WqrbgoRf+RzKGkRXkExWkyNV2hKtkKs1PJJeH3mC03
 yPk/emucw5jO67CXryCSgx7HBMqVBpwH2QA8POMuB7oGujdsnEoQgfGdMpA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bngxmg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3ac8f449d1bso763662a91.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815178; x=1794419978;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gzjrY8YLclt+Cdw4cM+IfVHKe+qb0Pzmu/tMZyi31YA=;
 b=OEnleH7DVxT2+2jSPur2B//GL4wLUMrQRiRDagdWZEY3Bx5r+FMMQcopYO8BFP8rZf
 X+P1IY4CzpflXzWA1cyOENAAlo5ea1ql8yllsiJlYCtpNqv+5brbf9+yhR5bKQbXySGK
 DsvDoGnWJQfmfcqlUpEzziJvBI6iJnriGgHGEEpPCRZs44KU7isXe+UFKS3SfaxVb3VR
 E6MzJQ592WzkUlYOWyKznryxrgQtfQAsCzZcn/RgRbXWqGAHj+5VlO3cDCAwj6Q0/QfJ
 7uV/9z49H7uNkH8/RVofdyCJqyLlN0M+4DvcmbZQDRgXQ7pb1BHDVEKrOnplVujnOhNo
 dXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815178; x=1794419978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gzjrY8YLclt+Cdw4cM+IfVHKe+qb0Pzmu/tMZyi31YA=;
 b=CdMyzhJD3bMCwh+8LsR5WS+HK0DYVN1PT9u1MWdwSA7wm/mtxVwsUAPWzpKVKptKbq
 rP/HhDspkU5xo3qOk9T9A8bjb/WIS/do3UJ684vT6zWYMATOUd+xsFtTqTEBDGpkR8up
 e89BXGVFKKomtJPH9WxCl42t0V8WJtUXSod8LS5yQrJwXaPrcV6S3qWDDptPlBhoBBdD
 q9Y2dLURm1hffMmGBENS2rf8f6aiZ3Q5glc1oXg9ihQNHgD9+is+owvI51/LpP26j/QK
 6ydHcj1vWAlIPiAzJrmoPCzP33+ejP1MLCiwBb7WBTkETb+EEW2Y7y3HxajVnU873/RG
 5+UQ==
X-Gm-Message-State: APuU4Z+qoUKPKMK7CKEp0wttnaFg3OVCvtcqsCaXtonJkXSds5OCsYY8
 lhDEsPAW11EeRmeV3r+79/9iwPERzm8NRgtVafTmdCgWCGmbzojWX9G8t8y808nFaVavwpBx+Dx
 MSyPmXX/d+W2wLk22urjVJyRza6cIQiDWzV3LFI9ATBFSQ1CFpI3A9x1T8/lz9qP6vDUggxyK03
 TAJDAT6g==
X-Gm-Gg: AYBFou2oJkoSWlRhYbCenOZL3BIUuy6Qlb4r4zbYcAjhpqjSoIySGOrSXV/3/SgX+0G
 f9OWOkYFaJeyXFzuCt3yRWTnnW0UrdZoF0fuMrHAFZGO/+fwArnxbSwvcXv8RelvwrOYVYy/j0r
 QCLP0TxX90BcKhPiGix593FJky5WCeyuVAFOrVa+RVtmlBL0f6Lkqs11YsJJ8Xsb8aKNjd/eBlw
 L4hyTBLkmcQaCuiEs46ZiDVE9fXLMQYmfjfV+2u69+Oni7PJwJCplX5BaX6n9NTLGEjTIkQuMLM
 kMi6BpmnGwFr6BA+1JiGWBYU1nZIxECAONez7qhj/0DedZOxtGkcEa/c009VL0SJ/SywbeFkuU2
 ov5aekC4k+BzQ2OIBRyrFI38cOD87BRqvzj69KBW2lfsgVShhDJzqj8DENJLKIgjqFjIMKB2rvW
 7xt2l6vN7TPljTZ3Vy9BXFtsSYlixZjvPADE/tNFTtX0Ww3y7HCouMvMTOsF8=
X-Received: by 2002:a17:90a:c241:b0:3b0:96b4:ceb7 with SMTP id
 98e67ed59e1d1-3b096b4d4e3mr1971702a91.8.1793815178205; 
 Wed, 04 Nov 2026 09:59:38 -0800 (PST)
X-Received: by 2002:a17:90a:c241:b0:3b0:96b4:ceb7 with SMTP id
 98e67ed59e1d1-3b096b4d4e3mr1971678a91.8.1793815177708; 
 Wed, 04 Nov 2026 09:59:37 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3160634sm50146a91.6.2026.11.04.09.59.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:37 -0800 (PST)
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
Subject: [PATCH v5 2/6] drm/msm: Resume perfcntrs after hw_init
Date: Wed,  4 Nov 2026 09:59:22 -0800
Message-ID: <20261104175931.28475-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX1lDsU7Rq0OY+
 IoSurk5CEm16+xbYSbNuwzRMsadnGNf3A5fzkxOSpTJIFnne33ewe3twqREqcmpIl9gAhvK9EBI
 SGop2KwtvyPBZ1X1IY+rF/kpoP4Fk8OvT2DWgmZhGQd0rAxWbYu8n2O2XvAKQymdn2k+R05wM+d
 k3FvwkjDyDH1JuCcccoGQnnTLfsq9PEo+o/okEmwTfEeDNZMz93Vq4zT2nB+tsml74k5LZzdF1A
 YuLUyvBWtAQI0MDywcKZvweOcaEHsY03PsJIs70OFuERKywajBZa7d+XrZmjG+RcDAIogJV8xeN
 qXm41f007yqc0545FqWXgxqypSbrtLCA8c/J+ZrNonaa7Vv6Auz2li6o4LRYlW0jFk0+WzvF9ZB
 sR/G8wnhXsRTd3Xg4XLNL9u3P/aanxlELllwy25DYtzanQWeAE0yDjTZIRSW2QEumTDg94O8xmg
 CS/0OhZOpVSKx94Gllw==
X-Authority-Analysis: v=2.4 cv=KLLPn1Fo c=1 sm=1 tr=0 ts=6aeb728a cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=QD1EvTAd08FZB_lsx5gA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: XwT1vl57rVP9ZTpbXUMnU_d7zhtFliIY
X-Proofpoint-GUID: XwT1vl57rVP9ZTpbXUMnU_d7zhtFliIY
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfXy8JNNHip5if6
 YynTF/mujQPYEWYCClDmDobjT3ZGQ7r6SUtT10N8WSzoNS6aKEw/vrmYt/oOiIxfSjOM0boUHVi
 3IM7q5ggrclx1L8FE71u2zZRKaIlI4s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 clxscore=1015 phishscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611040071
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
 drivers/gpu/drm/msm/msm_perfcntr.c         | 9 ++++++++-
 4 files changed, 12 insertions(+), 7 deletions(-)

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
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index ce65b1160955..36ce9a102c5e 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -199,10 +199,17 @@ sel_worker(struct work_struct *w)
 		return;
 
 	scoped_guard (mutex, &gpu->lock) {
+		/*
+		 * If gpu still needs hw_init, bail.  We'll be rescheduled
+		 * after hw_init, and there is no point to collect counters
+		 * beforehand
+		 */
+		if (gpu->needs_hw_init)
+			return;
+
 		guard(mutex)(&gpu->perfcntr_lock);
 
 		if (stream == gpu->perfcntrs->stream) {
-			msm_gpu_hw_init(gpu);
 			gpu->funcs->perfcntr_configure(gpu, ring, stream);
 		}
 	}
-- 
2.56.0

