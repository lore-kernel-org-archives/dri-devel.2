Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE97606A327
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HWjjGqhU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D1i+fcgD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0916D10E32D;
	Sun,  1 Nov 2026 17:47:10 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A97510E32D
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 17:46:59 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A1HRhMK2468072
 for <dri-devel@lists.freedesktop.org>; Sun, 1 Nov 2026 17:46:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Y/GyDAzpwZI
 mWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=; b=HWjjGqhU/tdTaoFLQJoSOgX7VfN
 eOPHX2/z5V2QOy+Hoye0D+/QRqBhxKc0+/tsKNlP2yrnhDt+7jzvxMCNdGYDwq14
 1lRXL93op2SBIOBnkJf+mqR7YC9ovWPThnvgap+JoZ3IbMEaRJtfhWtNeYYFaehe
 ewsYSiCLNUZbtuM6iQRwi55ZcEKWvjN1lFrDTM9DW+Y3+gT6A87waOslZDN31qvK
 zY3jS7AZL+5WBhJyfKzAkl9zPWJmaOfzG/ToUoRDOP63n8wyQ+dSHvDQyhMAWlhv
 t0PYs9aAtjiv5GCwGGJQtgnT68uoJN14ivbLTwSDGasBQi2QEt9zLXGjdlg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn79rv022-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 17:46:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ae6fda7a00so2276908a91.2
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 09:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793555218; x=1794160018;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y/GyDAzpwZImWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=;
 b=D1i+fcgD5kUxR8e2YPcJoSEr+d/2W4pX4oVVCq8I/hfhLSNuQQG1ZMUvuNmyRfnSs8
 nYq1TOEybHWxOYMq+ikSyalI/67ZKd79J91S3YyomQ+fpj7TNLlRjNa7b3fUGQpx2db3
 +qqCpxTlAUwkAfkJcVpLi+g8M4JTJ44BFq6WjopeQLlJVIiYweIXt57U89Yhx3UNt6pZ
 SvO1y2SIma+6uehVMku2E7fXviWx+UE50f7hSADIjuTGS0AeXaeoUtpsqGOL98fhDDCs
 xVUau9/JFoMcbd8HGvkZPkab8zi1ooVg+ywkL7rMQoVHnNDI9O/FnLuAlcKLbkTVuOiD
 XVqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793555218; x=1794160018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y/GyDAzpwZImWFuqQSsjq6uv+RPz8GtxfDN21Tjamqw=;
 b=BFEmCklGVE8PLgRhDvYjdB/6p4Oh2cOkkDUy5sZIptcu/PGyljBLEeHoBOpB+pV5pu
 qZciqhQZXO7GZ/DiE1VQaOR9h1jGWzaueVymvS4CkTV03P1iqe0zNBk4XPKOHNKenbXM
 28VkvukEbdzkwwfuvpYIg5N7CW3gCy2r/2fi+YDbRxTZn0stJpyMnwCuFSuX3WEe80kj
 JOv/qhb5HknBVifgH6CSIXGEYoPBw4U7hZKopEpmZ2zk28agnijTarURYNjiu+Lt5Cus
 ZgafmGTgxw9+KNpjb8WdXfnY9pndHAVVNMLlMjBM4aQXHAx9a4sckwXE2pF+A1u30/H0
 eLUA==
X-Gm-Message-State: APuU4Z9o2LGeOt8uGh0inPe9vAH/tJs+ZP0rpL1bv3m724Xlf/MqD8Tj
 mP9ysaFveLLlvkrSj/olndo0T0Bt/s7z0LzRNiE9AELKi7AgOD2pKfK9wBstM1pcM1bTVNGRGkV
 OcfcmOy0JNnE0XZixz8MPQo2tn6lK2un8Thpwese4B97DBWh5Q3OOAEXyIlpEw06PlHCbGdk/bQ
 F8wigh9g==
X-Gm-Gg: AYBFou1A+4+1w+gKtMyXosgmxKwWKPC3Y2I36wZq3GjSRoDp1V3lf8QriZg/btjZ2e1
 Qj69SY6PjWOGgPzn8h3VadchBiTPrZe4Hb3P1ddamYmAN1in5lzf3fWU7WJMQ9+EF1cUPzA+P9Z
 FM6YpsCPCOgdZ4kMyXoYJeouT5FonakdXDdBTlEfB8CktduZ7BMRiiOuyuJ7TLUUrZkVjjNn1kU
 C4SZM/Nf7ox8offAAlrEGOeEKb6sZk4HB9uY18L2IeSmnw+D72SBiv9rnO3grWnk0xKNggFATE1
 OjxoKuLiFaPcOTJsN03sWnqM+478LTqaIshNOR2ynYLOB5by9IRhZzlr6xmVfEcVLv2+wmeGa82
 3pU/o7Eysi/pvY1u3qJAhxp1yOl9JK2V5o0JT3JO/sN/4eHIlmJ9gsXYQmaebQb/zpiXyyUfj5C
 8B0BAy1u6K1FAcFJU9MHXGhw==
X-Received: by 2002:a17:90b:3882:b0:3ad:6090:a17b with SMTP id
 98e67ed59e1d1-3ae89776869mr5880113a91.17.1793555217979; 
 Sun, 01 Nov 2026 09:46:57 -0800 (PST)
X-Received: by 2002:a17:90b:3882:b0:3ad:6090:a17b with SMTP id
 98e67ed59e1d1-3ae89776869mr5880092a91.17.1793555217545; 
 Sun, 01 Nov 2026 09:46:57 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae6e9db612sm15164277a91.17.2026.11.01.09.46.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 09:46:56 -0800 (PST)
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
Subject: [PATCH 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Sun,  1 Nov 2026 09:46:27 -0800
Message-ID: <20261101174631.23637-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
References: <20261101174631.23637-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5tkzivT767WP4mI3GygLgYtyfjwt_ld-
X-Authority-Analysis: v=2.4 cv=Wtq+otfv c=1 sm=1 tr=0 ts=6ae77b12 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfXwxYTNeGGYzbt
 bZDVBKSgE5IoAG0HsGcj8910Wz2TAA8ad/wwfYZDMM90RPfpMbqTS3w1lDKgJ14f2wNVZcoQUQC
 HaXh+3I+RBrrRBnfBkhA93G6zGSkQQI=
X-Proofpoint-GUID: 5tkzivT767WP4mI3GygLgYtyfjwt_ld-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAxMDA3MCBTYWx0ZWRfX3bA57mt5/yvK
 +gZ4WrGNEMCC/yBBkkNOqDjWwZczVyLT09o3bzreOll44bL70iaSFARG9CeJyTbB70ZJBDmazrc
 XYcTLdjIIxtmmI6TtgB5Id2QQUScbmgq0GVqSGKki7J7XyBw1KSNZt72eKSd5CTQfprbntpgDWh
 m+d93waj6CrEg611uoRXu7RbU2Vfn56hXwrM+sXvxTu4/dEecxGnDApW6JQx/obJHmjtNJgc5uW
 +ncxbRUaM1+HfpIkaP27P5v64YtVG+mqeS7WtRIvmnJ0qLfad7COr1yBi87RxaDyhtQOU1kxiDt
 WK3SE4IbspLFPV7pxa4xc37k2ABOiDuwd3BnX1FULPCVHc2E73UYrFCkB1+Vu2NiW16U+zAlczK
 cROQrBx/DSU+OCjyPw+wGue8KA6YqK+dMnCnP+5snNMQWHN3DYwD4csond4pocwv+an/u0d0KHW
 RH0o5bsYC3mn0ed9UZw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-01_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611010070
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

