Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A87606A923
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 16:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Fa4ezJoo;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OY5Rfhel
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2434810E941;
	Thu,  5 Nov 2026 16:42:30 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C1D10E6B7
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 16:42:13 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A5EQDIJ1049751
 for <dri-devel@lists.freedesktop.org>; Thu, 5 Nov 2026 16:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=h1E34adikNa
 Ie65XlAHTCNCokzVVPjH+sMqHX//xLDE=; b=Fa4ezJoofXYv4uwrpbYcnxjMvVU
 TUmebyWvk6cx+TREqzIKnFIMyhSZJ5tq8xf0CHoMus/ND4DG+EJB/qV/kuo2ncXa
 vAPcTQLtXXfKViNrmJklKJKacPStrxmqBvos81TSKuw7OMjEqQNaPwRoQKzTuGOb
 PKRYLlYBkPIPsTUo6zpeYKQjxP6/I2h38QANjgoSzEYWJGOcdapRZ3d0dd9gLL/X
 Mmk7uCPxh3tP0XaQuoMmIf8dd7J8XrP911CEYxRTd7SvrEcLUqQKc1Ar81I7VDSg
 +IP7YMAuaSvEOKoIz6Z1Evu6Ydru+tohtFhOouLTQYlJqLe8v1mubbA510g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrpaaj3ne-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 16:42:12 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ac7a4ba546so717326a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 08:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793896932; x=1794501732;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h1E34adikNaIe65XlAHTCNCokzVVPjH+sMqHX//xLDE=;
 b=OY5RfhelYiF+JUXy/DC4L1hszdUJ6xTbw3ACPZluGSFCFQAZcLytjAf9aVoyVcFqJ8
 ouEztdlQIPsgz6Tj0TuExZTCV8bKQe9Sb0THitx5kALUN81cnN/xnQfnjaUsuadYvHfo
 ZzqsUHIGg1vsvTn23pwtVrJVEZZ0xukPkRdBPVJRpSDxj0FPgXYbemTZQLB6yUqLBG2s
 PAE+zSWfjbInbWqstc7LLKKGku2Te7oy2retHyZKrOvC/PaY5KzayXusYnReOFKeUtCu
 ilg39+5M4T5XjB9h2sWd3j1YUSS6LPKhL+5F24iyDCMHIU3cimsIWVB+tet5N3VaitSR
 GwVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793896932; x=1794501732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h1E34adikNaIe65XlAHTCNCokzVVPjH+sMqHX//xLDE=;
 b=R+8fwIsiIqT0Hi4Xpg4sOags4yv34P2pxlFPGiy7uqvZvOZWMtwfB2TWTsYyRLjHVJ
 bXMaHhAMgBbuN8qjCJmGHOUtRKeuGVviXW4k7geAkoO1QZUq5Nwvz240fQy5aRdOVoC0
 k0lro9xaKzUeYP66sVkWqaYAosmPQIg2PBMKGNcuzs0rI4pHvFoGWFusJzfi2C/pPYt9
 ksrqqoIkaglco3VzXqi0bRfJQ0tQEQklV4beASSgiOk6QhBvZ9HM/hMTAn6XxqZ7qCi4
 /U6BfVTTRlDXXFRTbz6Knq0nZn8dos1rJdT1z8z2H57BI81M4GFubhqmwTiQhTTm1/f0
 umWg==
X-Gm-Message-State: APuU4Z+BqbUPpNOAWEFewhdiXW7uVtZoVbto41E33GCE+FfJhbxZL70F
 NAdggMjOmXMTfzI4DGb2+5yvijGglTpUPuN81fBvamtHByadPQSSlmHIGTi6cbqJZCo0QxvYi9j
 /MTCWtvFsK5eCnkm1Z590QrkIEfMpYCwCHEq2TcyaaTSDCc5CFq0V4h04LUpDGzNG6Jwc8NgQNn
 qwxrQ=
X-Gm-Gg: AYBFou2NP143gqW3ns6evbG7E6eH6X5+oAosJhWAjgsqU4Gdr/JKK/gN1+jAoODApzX
 a5Cs6yWW+1MI0igdSnbMRJJ3VnGUIwfMD10z5OPaT9TUiUcFEjfPQKMPSpaBLXxPEJBAt5VUWEm
 s3ol9/9K6F5ZrzZQQ9lgrXKQPY3EfZBQXWKb6//lmIwFKqCpwX94jK0rnvmVX9b+P8JSz6mpIH/
 phhJqtDF6OeQuFES10TurVr6yWNByQLicMhuKAIcUiZXsRIWiME2RxUjfGk67BRzc+hvRec0E14
 UL0UaW+jxatIBZ0VmzfzntuvDjeiz6ZF/mdrvCp25LZXfi+MJg8KFBqYEGPsCIGazTiidCjR4BM
 Iujp2Dj8fuWuLv2qx3UlZSZmGrbR2s7ldgG96Ehr4ApMwD0/qK6gNSfWkC6q23uWkpiuGE0xAsL
 R9OQeQlIEJvSYKk6dIb7oHhyyVaUT9qKA/yThnSgDQF66FnhUz/TzuZXpC6M4Q
X-Received: by 2002:a17:90b:388a:b0:3b0:a413:dd8e with SMTP id
 98e67ed59e1d1-3b0afd9a13cmr1869234a91.43.1793896931404; 
 Thu, 05 Nov 2026 08:42:11 -0800 (PST)
X-Received: by 2002:a17:90b:388a:b0:3b0:a413:dd8e with SMTP id
 98e67ed59e1d1-3b0afd9a13cmr1869182a91.43.1793896930563; 
 Thu, 05 Nov 2026 08:42:10 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b094ce9f65sm5088572a91.1.2026.11.05.08.42.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 08:42:10 -0800 (PST)
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
Subject: [PATCH v6 5/6] drm/msm/debugfs: Use cleanup.h for gpu state dump
Date: Thu,  5 Nov 2026 08:41:52 -0800
Message-ID: <20261105164158.23263-6-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
References: <20261105164158.23263-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfX77QsWw6YJBuU
 nWgdxVPy9B27JxU86HvBSTm68t+ZnJ4vnVAwNAq6CTab9j52tM6wJBRf0A3xJ3py6xw7iSd9ayI
 sKGiXc/fL+Q6niRerwkfL7sEIvzy/xmBeRyX7J8fqxgp4i+bXfVU6GGDTqyNPlNxBYYctxxkfJx
 k/NkhU3zMnbPnDWxUNXMdzu7mLu21WpuRj9gApzxcg/SkZZRZLZlU4bMRUfxSZoF6dvLUPa1kKn
 EhUTZG927IXP7xVjd5cvniRk+1LZ4+eBPmf6BelkYr1hTwanpPuunifVQ0IhjO4GIZ/Y3ipgOjl
 L6cZ7eyG4k8iI+07MbTdUCbtYwmM1B6/UXZ5cVdoQzcUh/9hup+FhyS9eMrxPxjIFL13KEpPl5o
 127mNeaVWZSTg5b6FSdfndzTIw9uYHwEUBZ/hJ+1qEG0FfXxwISxvgOyhCTfKQ/I1xGvXm0qva/
 b8SvYkA4dYHNjNkr3Yw==
X-Proofpoint-GUID: FaAq4N3W0x9KqVDP4v349YS8zw5bjBeG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NiBTYWx0ZWRfXxwblsrL2zkUE
 DMtHPRQ4GatnRjHMJszgGKhKX+yw257vX/xAn94kqQbfdox9SuRqaSsx+PV06BLNSyu/isr1d82
 lnY9M6EDIqgqVdDI1oQBuF+n52wSOlM=
X-Proofpoint-ORIG-GUID: FaAq4N3W0x9KqVDP4v349YS8zw5bjBeG
X-Authority-Analysis: v=2.4 cv=WOXqzXsR c=1 sm=1 tr=0 ts=6aecb1e4 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=isCY8TonHXl0-fnU9HAA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050066
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
---
 drivers/gpu/drm/msm/msm_debugfs.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index d05307bfa123..98f67b7aab66 100644
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

