Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4750660A3812
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kHePRQzT;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=d/G/6tV9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 753AF112A00;
	Fri, 30 Oct 2026 21:20:19 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D1751129ED
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:57 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAUkJ823205
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/GyDAzpwZI
 mWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=; b=kHePRQzTFqk8wzeqqTO5gwSq388
 17kiUznM/dIB9i6P2K/lKZxWNNyvdlc+wY3NfoVgSZVBHAO1XII2KBGGSqbhNzWj
 UVsSpB06hUhzPpO8Se4h7uC9dc+y/wBAV7mt2bd5SCtLTwRBEU93iWtqWX7hsjCV
 b/M5C1dt0/U6YF7kfnoVsx/z0XYDB73ZCH+g+GY0KMGeh8Fb6nj0ZlXyxkMBJvAv
 c5xzEDWBMAn3kbL7y5B7ZKcqjLxAhDGYzoywkeISgmeQl/idblnJV/9pQOc5C7vp
 epWGu9YVOgXa75KOovCLaKgK7QzU6o9DKjhRLpKaJPsGGNKxpzJ5vxUogqw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x081je-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:56 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e869e00005so18666565ad.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395195; x=1793999995;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/GyDAzpwZImWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=;
 b=d/G/6tV9WjoChaAe+vxKzpg1ms1XxPIVS1BEQNBU4JV1Gh6au7MuZfaT3FQJwcGmhG
 dIhBzD8zSjWPdFJxJgvTgqk1BsU8A2zbMslauNUVkqvxGJV36IMW735QtZwx6cyixm8+
 ZMOHI+RiRcY247Hl4MR6U2Ra5yfj6FKtVCsfOx0+CLOqDVtj0g1OILgXPnQbCi1Fn3Pi
 N2AznxUAJuKJ5rye83gHS2tnAdn9CPHepu99cvlukih5KLRjXMX94I2c+txFM7CXG+zD
 kDqPLa+4DD6j2wDD3pMFlN+I7rmQ5awE0+Cz/gAll5FrkmWdkajHqwUSKNAsL1eyYw93
 2niQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395195; x=1793999995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/GyDAzpwZImWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=;
 b=mWSDvIhBVNi9RtLWvTv+Cj3Pga5zcOUXAtDxNrLQdXYAaqSoO+NyNOwdgY2fpzPtdh
 ruj2dyxfYVn6lJQa3DOtlRcKK/cLuWOVE/nCH4XsjTGjVXuFSllm541VBg/RZggt04kM
 tkPDPdexgn2Cpunc8MkipRh8gm+SZL3S48D45e9zm17SKurrm/pVQHY4IDf0nQGt6usD
 CcKmmG0KQDeb7dfzLIqaAhzecsP6wSA2DHgVn8d6X+3xkSd38noK2nIi/e3S33ODOdy0
 LmiySvZ9wPkpGg/01uOzY/p5VQC/6U2+dAx2zbaNua6mV+10Kczo85X7Z/77kwn4xTvb
 4a9w==
X-Gm-Message-State: AFq9FYJ1yY8YuijgxykjQ4j/H3ry6nb1n/a5WhElM8MRa+eW99Y3pAMt
 Aj3Hy1KvX+M4lWE4hT8YWtvvMGAnyEeaIWM5XPkrmqO4sXV0/M2ebjIe0mUhTfFc4Cv7i4yQkme
 Y7k/FRAWKiRbmu16MUM8n150lku8t89lD4+LIx0WCEFinyanlo5LIqibWv6V9VnfZKUJSncZiVC
 B+52w=
X-Gm-Gg: AYBFou3LGkMVtCP9HM7qIuE2Qr27kNXWReJ6I35fFYjJLtzOEV2DXEbap6qF4bdRRSe
 7HBybbpZgdNzMkWyl60JZdU9XP6JJIxx6qAS/xm7XLBtyCPK4iXmJtmASv0++JG+9T2Rk/MKfY0
 vOGvmQpVIrHrk64lv7aKr0/dDlA0pH/sovTNxKWfqCnUmdxOFADZ1wT1m5xOCtFxYlulJlrrZqx
 xnA8/KbV7sl2Qs4SFClV8/82qgRzlgpmjhH4ZtdsNBDaCqlv8ll9FZ4w7afbC7h9kob/o9KfIUw
 yxvY9HaizHN8k0KxsW6yG+gQ5cfklHUBXCKqwqDliTolqVWxjbfpuHZo5e0SojBNaeDrhzqPRxR
 ygXFIK5Ty/JQtdQ7ng5lJiui0tiAscUfhcK4seFPlzAvKpJxh4FEWBzxADjk6MClOgWje2sPWj+
 orcONWteNckK8HbG5OLeYfiRY=
X-Received: by 2002:a17:90a:ec8e:b0:3ac:a203:e0a1 with SMTP id
 98e67ed59e1d1-3ae8980ede9mr2465114a91.37.1793395195206; 
 Fri, 30 Oct 2026 14:19:55 -0700 (PDT)
X-Received: by 2002:a17:90a:ec8e:b0:3ac:a203:e0a1 with SMTP id
 98e67ed59e1d1-3ae8980ede9mr2465097a91.37.1793395194778; 
 Fri, 30 Oct 2026 14:19:54 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845d5e62sm5619069a91.13.2026.10.30.14.19.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 11/19] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Fri, 30 Oct 2026 14:18:13 -0700
Message-ID: <20261030211928.45761-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 72-hDG8vFJEoTChrmR529VRo9IRCrLC3
X-Authority-Analysis: v=2.4 cv=Z6N5j3RA c=1 sm=1 tr=0 ts=6ae509fc cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX5Di3BTsexCgt
 CH1E5eWzMqCo0QwW6IIkjU/3VadODPO56WC42oPlwlb5FykCLtBGiUtkhf9FRRghTeYT2CAuNxp
 lHBaw/A1xi2Ky6M/+p+0QPLtrZekohvys0LWXjOpmSdpeAGEb+3ix3dvZ2NZo02vaM6BjZPsdK1
 FrML7BFc/rN1qBLvIvXyUwGQLl5ncOen0XlSg7DATJhoR3E7m5DijKhnYJjf1JbZbHui7hBSjo4
 tOdtI/Cp8gj1nnqkJIFrHIF79zlNPhKgFkdC9KDsOVW6wQcyiYL3Xs6mYQZn7RlYG2J5GWn9Z4j
 n2VvnAoh6G4Brm8aKmn7GmW8WmrBCqcw9f2ZNnsoNBgUKFoV2TnqMNbnAzZW4F0MUJ/kheuuks7
 IPoW9dq0dcS6+IkBiWEzHpl/0qXQ5Attki2gUYTKvrmN14vkqzKh07z3vIXCFwRUmDu6MvEypFM
 nba47MFR2CXTZAxnBJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX/f8iRJbWgOBT
 Nmgr+96EDjySQPVAW1V7UJ5UlGiNfTT4iTdpbJnmPppQvKD2YAa8uUTu+5iVLXSAQdu1/am2bNg
 Z1HO/wCCYfTbgFnb/2HWv3lGn1DG0lo=
X-Proofpoint-ORIG-GUID: 72-hDG8vFJEoTChrmR529VRo9IRCrLC3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index f12701e286ec..b0ddc02f67b5 100644
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
+		scoped_cond_guard (mutex_intr, return PTR_ERR(scope.lock), &gpu->lock) {
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

