Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BACC606A32E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QzAO+G4/;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EdX2y89j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2C0E10F17B;
	Mon,  2 Nov 2026 19:00:32 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49EB510F17B
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 19:00:22 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A2HOttu1332713
 for <dri-devel@lists.freedesktop.org>; Mon, 2 Nov 2026 19:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=F6H2yfL9HCI
 54AnjG5fFp4KvZiYwlVgCCRFJCHr/W4w=; b=QzAO+G4/5jBP6PJnzqPoOSD7AoG
 yxS2rHeSt4rH4pKRL7LHQ5uXBPObws+fmXeK8WEwCmKxDhDDjfhKBU3dGbm0FHh5
 ByK5DGthnJ7OWW+suhEh0u3ANYmEWkEdzE9PHASb+ceQW4DziUne2ywsb5DL18Oe
 shcGR0Y+I7iYMSo3de9BLCzWhtH0de3Kubb6QJDGrGVgiJF8A1CYcVCLutAhy8RE
 iwDz6wUufAawN096+P1fXie8kPA9gxHttWT4wqwalzFk94yzFuazSSkOcggYGZgt
 GpP7cCewfVrZ9nJiekv7RV8RFsB4jNQ2xEisdzHpsZB7mDHyAc7Ahw+2Oew==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpmf1ua1h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 19:00:21 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a073778890so2324472b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 11:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793646021; x=1794250821;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=F6H2yfL9HCI54AnjG5fFp4KvZiYwlVgCCRFJCHr/W4w=;
 b=EdX2y89jDDHNtqo5v8vgblIlH/DixLvi/2dk33Ij7u0+DqeyAtuAWjuqzj7/MbWdxF
 FUGtWLEHJ4dxMI0wd9HdViyXtQtmEcJOcUPgOsba9w4gBd7yMQom5GJfX9WpDmM51CEk
 KrjlGlulROJCCOvTeeQadZIXW3dhuaps7SbwUwrFsSiwhq12KAOGT6m2xqTOk7EqneKR
 VM6ZlmKMion3s+m3gz7I2/DVnIc//MnGFBlKs9tBO3h1qI/20LdzNjoSmVNycUqZCU+2
 wDhURmlqI4lHRa/4vTjgSFBH8pFP/a3SB/t0rO+hy4txnoLUlUKUdGroE7wuh7lL8jOa
 wGEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793646021; x=1794250821;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=F6H2yfL9HCI54AnjG5fFp4KvZiYwlVgCCRFJCHr/W4w=;
 b=RNVEAa/a/xMS6M5+gEywQ3l1yrv/az9UcjlIpTPXbhlEYbXPMFrkXNJMDNP+LjbxXB
 wX5dm9S3FqRZj9HWz71A74bahrKDdALsK/WyADDJjzk9+5MxllxKt165y16esDXSXpM5
 1dEilF69SX0fD+epX7H4hGFfiPwuLDNSnk6hz2kubuBwZgTiKJ7M3GsxpDvhDQF8TwH/
 w9KPDCnNjD/VNq3jYIZTiIjmHV9xtPeJlG5xJVwA53RzusHszJaedPmY1QwH6w105VM2
 1joGerCIagHmuJv83V5uz9a8HTnAaacO9sTzdsDo8s18vShYV7CoEf3+D/c2IQQlwU1H
 L4mA==
X-Gm-Message-State: APuU4Z9/P3HHc2VDeb2lXHAYvjT5BYXF94rQb3khA5pNZuZVS1hSlQSw
 QqgnvO4sTCF43Nf3lrG4aQhND4rif8B35HUNcUBCuzTplWVvXDeDhMFH8GdqjnuXm7ATC3+rHbW
 78hk5gpBsitS6AXaEHxghWbFkxwIzefEmwtY1BC6wjG9UeaDPFqsJTv4GOzLNQ/J27B4Y8yYCMc
 JWWZtTFQ==
X-Gm-Gg: AYBFou1tNqOsIxe5XCshowO3cCI1tWdflOWgWbZoAFuNUDjzIWl3/fZvcGKKP2c7OMi
 Mq1pc4XnNXM5wzqTmZS+3Qrt/Q2GkxPxXgR+VMT1EfUpryFPnWNW65OmpZZEpOJPtgy1kAQ3gOA
 3yPUvE7opAy78mGaj9qRJElcDcimMBskkO4+uox9mxY7MOFPCQj9KN8GNu7z+9RLju0YsqcCOw0
 qjYl5mOaORlhE7ouVXu7wRLzq/xLZUcvRVXnW/R1DMUxgxSQ+Ezs4wUHdxzB1f31F2Dtdlnjcbb
 ZIxoZx/625S0mSpMAzXI26sjos7d+PMXk9sl6lwjxC1IiaUy9r8yTsOrdKI+YXhSAFcCn/5w99w
 09Qw05aCaw1wGTN8fZM9jxfQOgapjKFnuVS8K0DW1qiElXoPhVbaVuM0L2ZcJeoZ3sCrnG9PaF5
 NjopnTZnnXwhMu4sAlb1RjkE8=
X-Received: by 2002:a05:6a00:4c1c:b0:89e:43ee:654d with SMTP id
 d2e1a72fcca58-8a9ba703936mr8590815b3a.5.1793646020863; 
 Mon, 02 Nov 2026 11:00:20 -0800 (PST)
X-Received: by 2002:a05:6a00:4c1c:b0:89e:43ee:654d with SMTP id
 d2e1a72fcca58-8a9ba703936mr8590770b3a.5.1793646020264; 
 Mon, 02 Nov 2026 11:00:20 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8aada9ae39esm2379711b3a.52.2026.11.02.11.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:00:19 -0800 (PST)
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
Subject: [PATCH v2 3/4] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Mon,  2 Nov 2026 11:00:06 -0800
Message-ID: <20261102190010.720443-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
References: <20261102190010.720443-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GkqDcIvWOZpaUE9nveZzfueI2dy43PqV
X-Authority-Analysis: v=2.4 cv=bNaDs/+Z c=1 sm=1 tr=0 ts=6ae8ddc5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=isCY8TonHXl0-fnU9HAA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfX7PlzimZgRZUZ
 UA0pIHpXtdpqdiWeMPGEnfLyiTk5zAVmWsipcZFIj7tJkvHUqZFahzIezAMObTqn5Uasp3p1SRs
 Xlf4oKfzW8P2Fd7gFs9aoOSQy7HFEm+i6Wyf71W7tSHUMaEuSgV7rwdCYEuPIfFrwS6+4W3pkX4
 BuH40hdkhxIDgzonPer+rujAzMOcRvIwxjONEka8HggJBlX31wNL7NSxY/f/Qvu0+UFXIY+98ZM
 DfhWbWS3qt1gtHN9RHcA/RXxGPifcZVWpZ8aDBkRn08+2zGrU7fS0EKl31mLtKsNz/lU7983e9G
 fU9hFEwgw1840VJxv39UdysB+5JsVeMhE/4eMcqVkBY3ejdb8MCH3g0QmWhIlehmWQRYzdu+pIK
 jhJBskB3dAlwlC3ByjRaHQYNM6aCFFf280FWBHWgOfPWg6V0rrkRBKU4agRyyq6ZKAN8qQFDDRF
 9mgGpcwYwCOb3y4IaRQ==
X-Proofpoint-GUID: GkqDcIvWOZpaUE9nveZzfueI2dy43PqV
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA3NSBTYWx0ZWRfX02ejy6Evlqwe
 N/kT2mhSrRMqqkY4MyndrkYP5uDS72q03Might2ox6/S/vSH1YarApRhYreO+6UtQ0iB/i3POZ8
 ZxXQghpZrWQl84t1OR8azFEQ/JjHHJk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_05,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020075
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

