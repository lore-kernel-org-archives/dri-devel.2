Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B74606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PVWQkSSZ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RiMUA25M
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25A5210E6C3;
	Tue,  3 Nov 2026 18:47:57 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F44E10E6C3
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:47:45 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IYxAJ3318603
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 18:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=9R7AOWcFK2O
 6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=; b=PVWQkSSZJC/z/n6VAMha+F5P5v2
 erT/O5hJQqURWiLGhRQk8VDBQv0dt8HHZ+RYzBYDmYqSAx2IRX0SHBUEnJCXalal
 ufJp5Rsy8yV23iLQGE/yrjSe1BcFm26MyPazDhrduGi1EmGBR7SCCBMmKLijVsgs
 tFRuUnXBZTtPQf8JqWhu6wDducHPrm+9QZ1GGiw2YMMaWFBEmAB9oct3aVs30qjr
 xtBnXYwsx5Xcu0rOK58p7Dft16GRojHfj7dtI4IuuZOk5McR178zEFitaW1NhH9M
 tKVUzezFSKRQPvFSXeKuslkCtR1NyfNgatOsI/alDbQyn1LNfY7mh7KHpRg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqh2bhapu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:47:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2eaf8ea208bso40059335ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793731663; x=1794336463;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9R7AOWcFK2O6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=;
 b=RiMUA25MDszTKNDPs7upOevl2YMaT4xlIcU6HzUQMQx9k7lAgg7gROfa8LXA68gMHa
 990XaaaYkeoq6YE4xN83F8FeEzuXIga0LP4yczUuKgDJEh5QwR/yD7kSQJBR06ZobiDC
 obFLCn+fm3Aq3sRZdiRWCPkj3B7CJM8vEAIXN5Gbp7uoVTwwvQtWZ0xnb9lNksRPysfi
 2VxoNEk4l9D9oGsyhFy3Fj2EhoXJGWbbUKWZOVBrWoSydinTylNs+60ok+OawkmfLZzz
 IW788bOwRa1X1SEw17P6LpUzRADTd2F+8gG3xnPVxaYW9mqy2885lJAwkS2u6hXbPlkV
 VNGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731663; x=1794336463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9R7AOWcFK2O6YBonVJ+x/oCpM5TEf6hYWJwCy2Nvgdg=;
 b=QWId8bN7nIeyIV9KCw7QPmIb6Q9lGUY2n9GOTUtqiar0wnaF9MtrkSGEwf4vnZ3Npp
 N11EFOpv9wH71xuT3jjAebJ4BCpMbNq1Iu3AM39p6HUDoXvjc3O904Pg/kMv+Lob9QJe
 wA6kaCWvhC6wq4WpciBzi6mV+h+XaJ7IFF9pCZfPERKqiuXLZ72iWbpu8Sv2UV8S446j
 ILL6c2CYvenQWwKXHcbIidKaxPv99z9Zp5NNbnA5b/bevev2igGQcamcQR+jQY335xdN
 Mbh2wXikq9etc2j88r0Lz3cSDPHhaONiPHJH95i/3mg5iGEx52F2TqoKQjaI/oXXLAF3
 0tJg==
X-Gm-Message-State: APuU4Z9kJRnYQujuI2egoULsSBo1w+8HYBKknJcDFmUQhK0qBzL3OKRe
 CLHuw6rqkPPIbUr1VzTnFMKo6C/PSw95HTvRwBnVS+KZ0N694QjxXAV5Vly2zh63CI5GfyuFY22
 MwVGy4bqKGqNIEyZxhDgzyg24yvGVRnXp5TJ/E2anpgmwX42wn4462uu1qA5QsSIzNfZfmK6ThQ
 L09WK28Q==
X-Gm-Gg: AYBFou1u5vfjMG0z+aFTaVwOG5fivGErw7LDcXafYuDInsU5rO7ZGNdNtQofQ93+LjK
 r8y43uTUvJsrZcEkAcn+khq+QqFyLcSToIxLmvknYsGvWmS8UieLzyeXk4+jKzjyLzB4r0t3S7V
 WbKqO0sqCvBEtiygKn/h2+3kY/QflJ48GXMJKcX+lGUGnC4VhGleX3n3PMtl5toMInRB2sac/3S
 8z0pLrPlEydWOphcR+zOCNrGXJXjXmqdBvm8SzcVSt1sM0eqh+Nqh0GmCkboaPhfNU9tj6obZAf
 eFEOxPMAeQcKY1RnaZObW5Mqcv8yACWRnKJKex/Dyq2yQWs4VZuvYCJzUkWVSN1Dn7oT2OvmXM6
 25gPWSK1zWmCCdjYr4QydMBnuwYnLzzuEYfDS3VLhyPyxSB/Cs5hGWlSECEMK2Z6SX3enSJR5g2
 rzf5Su6dZzoMrKjCUXe0AentaBJAP3rftW2LJ6fllGNw4o5furk6ANvZ2b6g==
X-Received: by 2002:a17:903:1b47:b0:2e9:6788:9381 with SMTP id
 d9443c01a7336-2eb36396895mr125207765ad.7.1793731663499; 
 Tue, 03 Nov 2026 10:47:43 -0800 (PST)
X-Received: by 2002:a17:903:1b47:b0:2e9:6788:9381 with SMTP id
 d9443c01a7336-2eb36396895mr125207415ad.7.1793731662914; 
 Tue, 03 Nov 2026 10:47:42 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb3922f5fesm44626145ad.21.2026.11.03.10.47.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:47:42 -0800 (PST)
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
Subject: [PATCH v3 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Tue,  3 Nov 2026 10:47:09 -0800
Message-ID: <20261103184713.29664-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX2/bhqursLIq7
 kHDKR4oztiXtfoeo4GlL4G0OMHUzatrShbWnLHEwdz4Hs2wjwYVmFgrFRraNiixVlVg5h0vQaGL
 zwbojAogvWx/fQHIIDF7EME42McBYGQ=
X-Authority-Analysis: v=2.4 cv=Xs1vqlF9 c=1 sm=1 tr=0 ts=6aea2c50 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=isCY8TonHXl0-fnU9HAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: K_sAfvtFKnJBivXiWtOAwvkJ6FTi_5_5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX7ZRGUFDWWxew
 b4BntSa83IPEEdEfBe6R+sjzIMafbd46gevVVS33KWOeT29Oo4VrxKrRFXzPf6wsG3TfBPmX8wn
 xN3q8YFAYujW0J6ddd0K+1mEaAwzoWpSVGhuey+C9TNRvVi0wf64RiOlppW8KlyAnk01MVWnjlI
 WqTl/FUayWd34Q2cqC6dk/2ZcrPBdVvhux36Bek4+PmQm2UdvQ1bLmMVM/pnsrAJPiLA4+wpD3h
 HB0nRQLJ0XwrJAkTlqcOIIiVrH78ytm84e7/cz9+8uo/OUQEZfEFn0g/jDYVtVkl6DMIHQ+6gM8
 86FDZbRZRiLrnumcYLj2aQdiuOuf0PiHFNLt7i6a07gSLDR1nZp3K2qs9A89p0bUXsBbmd8+De1
 soIiwYDfivMe4Oj4WqRK3Jo/l4LGFfbId1qTjjHVBbPTkw0Vv9FrKnQGb2aD0O66fw/qrQtJg7x
 j5fmdhj20UKlgXNRSLw==
X-Proofpoint-GUID: K_sAfvtFKnJBivXiWtOAwvkJ6FTi_5_5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030074
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

