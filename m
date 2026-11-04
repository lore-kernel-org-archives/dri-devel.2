Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B89B606B209
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L3hvFHTV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=AORBWvOl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D75310FDCB;
	Wed,  4 Nov 2026 18:00:05 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBC8F10FDCF
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 17:59:44 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A4Fivbg2210784
 for <dri-devel@lists.freedesktop.org>; Wed, 4 Nov 2026 17:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Da7a6+qQq19
 Xl3Y3nz2zVJieAU0gyascrZ86Q+lA+L0=; b=L3hvFHTV7Tp7RMiSHKqliC3kzxy
 Z1WbFvYJhax5wxBWUWzUe2AKIopJxDC3MvtAmcYUXppFp7RsBr44KaYZ8Z18n3f5
 DPih+qVQQnxWZjm3zgORWreA0cpWykmlYSt9kziczI/Osn5XJ39GSj4qAtGvbsvx
 KWgZwg7cgb9sjeXIgoCzhv7HFmkErn1gW5ZXbLIWpC4pPYDGoPXxTKpqA5f6lcsU
 pIvwZ0mrRKft8tevilf6LKeZhPK3a/RbhMJMVKm+4IC1cEQA6IhA2x3a5j/3YypG
 YGG2rcoyU6/wVWknLy/AWEGFaMUEFSS6HSAJk7c26kED2XZvGdABg61k/HA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hr6bdrxmt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 17:59:44 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cdac8b7169eso619008a12.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793815184; x=1794419984;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Da7a6+qQq19Xl3Y3nz2zVJieAU0gyascrZ86Q+lA+L0=;
 b=AORBWvOliax57z196xfjpp07jW85R0yP5vnJN+vwTCFMO8QRluqHm5tXYoN+CaGIWZ
 Hy0QHLzHKXQbQ94A5cfdGegt4UjETBRR+czNqwh9SNcykP/qUCX2trfZqACgJCvfh0+h
 XkwGs/zbJLILraRc8j1+wmlo5R0Zj65a8Vgth6zSFdNN0+oTbAaPyx0e1UdEHkJQ2nTV
 CQaWz6zIFa7ue5uN496WFwd53zq87qCZi3rL5RiIFDx7vBXhs13iqdD8Ma2uXkcw8TWx
 S9toNxGLoSiyaBZ7Jl8tcVFb1i6V4EQ6KtMaK54P56bSMm2Mll3iFk7d5+ipXL64a8Ii
 CzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793815184; x=1794419984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Da7a6+qQq19Xl3Y3nz2zVJieAU0gyascrZ86Q+lA+L0=;
 b=NbKHNe5pOPekmJTywOI6DZ/wLC38nKlT3zNIMWNx3BuKxAjaSb+f8JVzPSEYAIZdjv
 8rnh3lxEakH6Z+YifB6ivW7T4IWnc6eUpt2aSeZZUKuKJsx+Gzm1unZ1i2ypJCv4ryOJ
 03YeyXLWZR1gB544syiS1eJYmvC2gP2rB+Dl6QLRF7mATW1h+QqV17SXFBtg0SoLNOnZ
 Tq+0EwygOMyMBPj7TwF8c7m2u7+nR4+h75pUglKulMYdQx1hMXIR2bhURR0ooCMRPhqP
 BkKI2xZrmz2dabgcBxxNSOxxwiW6g6b5aqHe9dQmJe/wneF0iGUZSwpIqcdNCIywnRt/
 OsXQ==
X-Gm-Message-State: APuU4Z9favi1JJyvbEFy3ZENsNW/RbY+mJNaclooMNJ9Xko7/BOgpidK
 ZLY0g8TBHAtF4sKi1UfawpEtCoO77Ov9QQGlMzysru/VQwqwCkUu5b7cxNODD410ZoBxH4MHJ9h
 GNk60PoM3GTlvz87TRXIpqAIHt5r4knDNdQYrWWuXeGDWd2ITli0bUmrbPy4e0VdBynERv04P7Q
 K8rQBoGw==
X-Gm-Gg: AYBFou3k1vOjhdQ1ELHVoYOm7sSyaMX+pht9bUREn9NGhpcO4EG3hgpX5SiWcqoQA4h
 QCHdtqnnidT1Qm1r6QSLojWlI17r8FNn6CR9FtNhi9yvhaAwwLIUmKKbU9QpUuLtU34hyeBu9hB
 YXrI80pE3CdVvtw9LRhgcHg4ytRApX0eFdxIyAPrbFUaTsXrjKlacZMkcEgpd44rchgbY2MDS5z
 C0Pw6RPmtpUamTc3yz5GTRHv9Zzl//iZ/SnbziDy/fs80nk7ago8qxy3rJuOLgpl7Ask727SZ5r
 ReMD2AyMYzc+NBX8RKAECqlCqJ+7OzJpl++RFUg7WxuyH4MVoKAGmC4m/JLXd7kg1Uxl8AhXeM2
 s16ovLkgoZvUc5l0i4eNevnLXoyyDFg1vlLbhvhF8BP7SI8FJdy9+ny4COpFvjMFkN7SUpK4XcR
 FFsCL6O0h1ZWYkxvWkzk/pJjx3TnKmH8Jf1hkoqb75itAgHVFiMuyP/bWGqw==
X-Received: by 2002:a17:90b:570c:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ae897ccb52mr14991770a91.11.1793815183538; 
 Wed, 04 Nov 2026 09:59:43 -0800 (PST)
X-Received: by 2002:a17:90b:570c:b0:3ab:e588:c288 with SMTP id
 98e67ed59e1d1-3ae897ccb52mr14991749a91.11.1793815183032; 
 Wed, 04 Nov 2026 09:59:43 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b0b3163383sm48912a91.7.2026.11.04.09.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 09:59:42 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 5/6] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Wed,  4 Nov 2026 09:59:25 -0800
Message-ID: <20261104175931.28475-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
References: <20261104175931.28475-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX1Yf/fhRUicu9
 trZUJsvH/kxW9Nlns6dJ7rE6/EM7rgHHrO3StxJivISHasgugDFvMRe5pTT00G7qsYWFm1jFpP4
 UNRG9tTggUoO2Izwc3Zt9qYTC+CqUfU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA0MDA3MSBTYWx0ZWRfX6LAKn0n/IV+s
 XZbz68FsMesDzhuvFmU9dMAXFIbjkUd1ftrltS/MrCVxCzRN6NvJgnpPWAlnvG3zHj1S89DLU81
 nB2n5daiIhKx/pm2q2SkWQdyJv8R0oMm0rFd/w9jKXZN0Piktrl8tU5+WjYhkR8vx0HqWbruC89
 37bGR89GRi4SE2MpvPJIr2sc0BEAVOSiLrvwQcm0KDD2znqd7j00SxFtfCpHXLqSpzDh2kC2/Lh
 sJEqGOayEy/3moagg/1hQC9UvnZVdI446pCACtRPGbvXOohyYVTXRKgLltPaHVsGLoxMZHIynvU
 hJD9VNwtjuE+p/DeL1pgFkkFexvVfV45KuVyUu8460sXvG7q6AKmWYog55ByEXxALdgy33pRnQK
 Pi2350JudpWdGaL/GtuB70m8sNsuoDolaO06uRcC3ur7ENACz88AWf+6v7/yHs52V1l+y6zhy+9
 kp5PHd5EKvvstsDpr5g==
X-Proofpoint-ORIG-GUID: pLIaaHsjd_-UU3tQb3bd0OFchma8kDTn
X-Authority-Analysis: v=2.4 cv=D4XSufRj c=1 sm=1 tr=0 ts=6aeb7290 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=IYGNqqR_R4_3MQmAMmMA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: pLIaaHsjd_-UU3tQb3bd0OFchma8kDTn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-04_05,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
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

Use scoped_guard/etc to simplify the error paths.

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>

Reword, we are no longer reordering locking/runpm
---
 drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f12701e286ec..136029025b80 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -70,43 +70,36 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 	struct drm_device *dev = inode->i_private;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gpu *gpu = priv->gpu;
-	struct msm_gpu_show_priv *show_priv;
 	int ret;
 
 	if (!gpu || !gpu->funcs->gpu_state_get)
 		return -ENODEV;
 
-	show_priv = kmalloc_obj(*show_priv);
+	struct msm_gpu_show_priv *show_priv __free(kfree)
+		= kmalloc_obj(*show_priv);
 	if (!show_priv)
 		return -ENOMEM;
 
-	ret = mutex_lock_interruptible(&gpu->lock);
-	if (ret)
-		goto free_priv;
-
-	pm_runtime_get_sync(&gpu->pdev->dev);
-	msm_gpu_hw_init(gpu);
-	show_priv->state = gpu->funcs->gpu_state_get(gpu);
-	pm_runtime_put_sync(&gpu->pdev->dev);
-
-	mutex_unlock(&gpu->lock);
+	scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
+		scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+			msm_gpu_hw_init(gpu);
+			show_priv->state = gpu->funcs->gpu_state_get(gpu);
+		}
+	}
 
 	if (IS_ERR(show_priv->state)) {
-		ret = PTR_ERR(show_priv->state);
-		goto free_priv;
+		return PTR_ERR(show_priv->state);
 	}
 
 	show_priv->dev = dev;
 
 	ret = single_open(file, msm_gpu_show, show_priv);
 	if (ret)
-		goto free_priv;
+		return ret;
 
-	return 0;
+	retain_and_null_ptr(show_priv);
 
-free_priv:
-	kfree(show_priv);
-	return ret;
+	return 0;
 }
 
 static const struct file_operations msm_gpu_fops = {
-- 
2.56.0

