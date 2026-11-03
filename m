Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DAC606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 23:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=T9TAGBP6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=B0cd1Tun
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 267A810F943;
	Tue,  3 Nov 2026 23:19:19 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF5710F939
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 23:19:06 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3LKl5d2395515
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 23:19:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9R7AOWcFK2O
 6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=; b=T9TAGBP6FqUzBkYa2zuGXHBxadu
 1kuEq+X98ZVvrnGIbtfcoszOzUZPFMbmeOJaGBf8wWP3v0JC1qP9UqBglfqN2OVF
 diqLSGAIYxECWQ73tjgcevAnbsSdy/8/aiViGCbjq1B7redz+lOWK8b+EZmh2i7C
 ATHFeImO5Ty+SaX+NjltOPRzETNZqAU2lqCP3RGZiuh1dRmm+jKkD6rAtYeUVjD2
 TqDbMVKEtXeiPMY9P0DwBzrqM9eTthfikjHtPCfboUm617akvDeBpqwXWomAWGlZ
 v9x2C+Uehzzk9F/q17wWL0TkSaEgl16k03xCd3ZLjfPjeh3psvTMDMPkEhg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyd1vn9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 23:19:05 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a06bc723b1so202224b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 15:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793747945; x=1794352745;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9R7AOWcFK2O6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=;
 b=B0cd1TunGs4eJ4ERFAP1gnZiVLwKJEoOUZVr8Iy4uBo8fMfJkC9kOecgmAWmzFtKcf
 7NP9fbjpbVN4pZrXCNslZs0zujcJnLuPApRrCmPyM6QAZdtIrOAp5pnGPJeqv5RkgFoL
 Jaa/XeGrwK0ojumRKgKq3aNoE7N3xyL0EqWDnaFIYA6eLYFKDlEFlt6SLCmTapoyRnB+
 PvqTYhF3kP9Nx3xAD/YhnEZV9Zu0Nt8HPiFJlt4x18JMWCVocwxUnJtLPS1TW2tMAasi
 LFD+LKllSpzS7008ur+aR2ghms328iWHtUq/nx+9z95e25AYrFW/bvCiYqruNyIKJaoO
 SBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793747945; x=1794352745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9R7AOWcFK2O6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=;
 b=qLmWoZ2ZHfbLBuNsLxf72A+aslQiylAx7ofuFEGtBy71Ke3SZN2ag9cyhMPHKcXOtd
 GnFd8rxfqaaEWI+PzPv0PkSjMVm7eNTZxmFnMskH9d9Ya4Kyw+2CCEo2PfrczLegYB9z
 4MEsA4uVH2vFpqJDv2OvOULwAT8ZH0rLBjYogZbkvDCbgtfGeLPiyEJKPeg90ba+OQlb
 uLRQTlld1NbspTMvXgYRxp3UNC1k5OzIEbtc7tDux0xmJRXdinzSPD8CDp1yzXGyqBaX
 4vZ1iU94lNVMaaGxiAC7rYuPUqR6FrttTwxpN6IwucFAshCO/wnof90CfCMZ9my55ymv
 KWIw==
X-Gm-Message-State: APuU4Z8AtntCiCnm4X+FV1lCYmx2MFLXnzowJUc1GAUrCQ0+8qmrgq4+
 bURow1J29vfR5rztyAPZ3wlvnEpD0jn1BwOnByWLFqnGJH36hF0wso9PbZUjpW8jGI+Yln7qe2X
 ZmMNl0e2ys6Vd54Z+xuTGUUw4aa+vJQ/DwcpLCyJZSbfSjFzial5mQ23Bcojf9r02vMIKp1rXWR
 RKkDxWmg==
X-Gm-Gg: AYBFou3iN0eh8HebS2F7Jgwa0EbaLHHd8+5u6JHr6k6EOu1cfB+n5YhnpbooN2vdAfF
 hTsznC46nZ8Xi97ZEn/7fY+99fBNXoLRCvYjIz/u68Mdu36kF+tvY1OML7Ik1Ge1uY457uRnNxT
 IoSEgikoR+pJW1iwX662pGAKwM7Ojwb2CPdn0tz4l0LRb1Cgu/yFHRamx8jDu42lhFO76KDo51A
 aVXgTcvD03bF44yu1yHQ3hpwZ45TNLmMcNcvpGNXDk4g1l/n5od2PUpyfzGfeqpBIBhqACbJcgY
 lHmHLPe44qSG2LxtcP6EVKkH/4pc90ouo4OEJRS73/z7Rg6M3W9em2219JY1d6H7XQ/nYNdDavG
 BwMrLqE4lR/Sw0Z8oVQAO+X3flFHjzyCov5yD1OdWUqzMXFGGeI4iyrODwYGqGr5FG0VONF/tYs
 F/kK2GPsFdp7tXrkJ4KkHpFAanWkQoT8+nMEhWUtz8cKR4POLs5BFFiWyNlw==
X-Received: by 2002:a05:6a00:2d96:b0:89a:19ae:10ed with SMTP id
 d2e1a72fcca58-8a9bc8321d9mr11305829b3a.31.1793747944881; 
 Tue, 03 Nov 2026 15:19:04 -0800 (PST)
X-Received: by 2002:a05:6a00:2d96:b0:89a:19ae:10ed with SMTP id
 d2e1a72fcca58-8a9bc8321d9mr11305804b3a.31.1793747944436; 
 Tue, 03 Nov 2026 15:19:04 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8b09bd3ad6fsm146353b3a.55.2026.11.03.15.19.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 15:19:03 -0800 (PST)
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
Subject: [PATCH v4 5/6] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Tue,  3 Nov 2026 15:18:44 -0800
Message-ID: <20261103231850.17493-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
References: <20261103231850.17493-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bp/Zl0ai c=1 sm=1 tr=0 ts=6aea6be9 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=isCY8TonHXl0-fnU9HAA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: DJMIbHgP-Wkg7TDQyQnyNnZL1qg5VaGC
X-Proofpoint-ORIG-GUID: DJMIbHgP-Wkg7TDQyQnyNnZL1qg5VaGC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX9rQLHLkyqb1M
 yD4fb45azI5O2uLIi3C29YmGINyP9rgyELVc2nFBPL48bQtd23jUTueGpsV6tyG9IbhnOGLU+Hp
 k+jc5y0YG7NKRf2aWk7EEKKlKbq4Iy8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA5MiBTYWx0ZWRfX4MvevAkE28Xb
 NVkcl93rZlQVR+UAqhgvZlZJJRkbapfT79iWXvuB9+8WwRJkZLdlsUehkM8BgC7Dz90afyhqfub
 RDLuweVZkhCblaZh0juSLHZqXN8lUAPKjdD43qaMcgsJ/Go5DUxJc9tnhiQeqqWey9D6kRjpUCX
 jf8n5D14/iw+cFSE0wxrPFu+IWta/FQp5X5vvUpaTLRHpMuVDp5XKS7GKfGokpOMLDJOYBdsUrm
 etNey+6o64aVywhVhEvTZfUUs4EXhtyvzW4qPrP70PPmphWoUIeX35D/hM58feLxmZg48sC2T1q
 zOGbhLWdyHPw1RKFKDuPIKQtp6S1CEuLzTXJdLiHf+a3njVeGKOqkzVLhRnQO9hpqOUCKXoIwTf
 6DrEBdvhf7PWT/3ItduTnBsVE2qdAK/jMWOm4dNc+8iljxQ3tRAexrrePwFHIFwT1FQpXTdDPsr
 x8jN3hDIu5+sHXy1hOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_05,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030092
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

We need to move the gpu lock around a bit for the next patch.  Use
scoped_guard/etc so we don't have to make the error path handling more
complicated.

Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f12701e286ec..aa59b28a3392 100644
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
+	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
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

