Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B71606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YympX1Jt;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GcOLvR2O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 548D810E0F1;
	Tue,  3 Nov 2026 18:48:14 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 563AB10E0F1
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:48:02 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZ8rE2586432
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 18:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ETmQNPch7+V
 QUvY9eYBohTQWDTkaLoeqazZ+zWLafZY=; b=YympX1JtIHjTisLKAIaPwt3NtsD
 GZkWySP6Wo8WdY9HBznBmtgThLM8nlXh2JOtGyqvs00xHe43WXj6W63h/i++BRU7
 G0emyhDbQBI4nGcEHlUa+8LPa99MkKxDJWCgZCkNywbmx8MJTDIZUbNjj5KeaI73
 rWdwy/2e5gar1ph3t87b9E4qhlffyklB6YGJFIzcEP1PafGEk9MDQ607W7NnUieV
 xmjFH5xbe2uVKdpY/FJZuCtDFvaKacs4e3WMaOOvBQB7kOt8hTY73x5coOEnDGED
 VB9B1NQnnKipgswVjjHLqnfRJ2dVvXcIJ0rmQyLeztn2uGGiV6d/hs63MIA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqmjbr5sx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:48:00 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2eb361b86dcso25353575ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:47:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793731665; x=1794336465;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ETmQNPch7+VQUvY9eYBohTQWDTkaLoeqazZ+zWLafZY=;
 b=GcOLvR2OU2JdiXBv79h56r4swq8VkeePns84273T0eieVWklp6G21hMtxJDrsz2gP8
 RCchDt4dO94ti24fxM/Xqp00zvf/TmVVmpf/79LClgpKyktSRfYZ2F0Fa1Vd7gEz5veu
 OXnuN9g/aHnolSnOMmoFq6/iIVIbcYJk3bduS0fCjdKyKQG2tLgjqXfWqOBYlOsJzG7R
 rJCZ2RYfIrdFpLZlQQAqT7UxxWv9EawCiAHiVPWHFAewWAFAQvINMfrIeMAkipUOH+cA
 QhGhrHPXBFPP0q4+/qkRaYSpU0P+riOrmWi9Kamz8DChsgSEkalp06ls6TPrMIc49zth
 qN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731665; x=1794336465;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ETmQNPch7+VQUvY9eYBohTQWDTkaLoeqazZ+zWLafZY=;
 b=W30YDEko9lGOBiACfiySLUfMlEAYyH5nevUwV0jaDPbQ2fjSmcp6CvkdDkn1mv4MQo
 0jWQtzq7YBMOLAvCOy+qGxauMoRLUBKm7YS3qyNE3Q3LkAZrAsAS32k3IvivGuwDJnJm
 A7es+5v8iaZSzNMropoEOtJomF0Ilx+Ivq0SXlDIHHyv7FBybPsjoUcjuY3XJknvg+/2
 bCEAIKWrYg7VL4rSvjTzckV7gBkIhKAurk6FAzQLTKMWFs3i76GLu3bS8Z5nZVPk4ymT
 fjMVpjHVedJTrOGD8szKSU59rafBJkg4mexfBvyO1UPjdm4ri5zyVLG5NbqFcvuxC9Pi
 mTrw==
X-Gm-Message-State: APuU4Z8GHSHcwubR1LbT16o/KtcnvdhuY7+dyxdaI6ylUYNHczAkLEx/
 Gv7rogpUIqVGWo+/+nnDS5xsuAU8jH/E0rnbI5bshmRcTXlCozlQ2e4sWngPPPnsCPGG6c3o/UT
 3ShzbyuTEKZ3Zkp+N01jiZOtQENbK4umC+IfBA2qUd1txPcdfmr4+Fd4Mtjzj5CwVvbmBkgIUns
 KvOgHZRw==
X-Gm-Gg: AYBFou29r9rADMufirkB6bXPKztdfNFrmQqlbdGqP0m9d0+TdRtH3/appw9WQ49EctE
 xrbAe3UnWU6MIq9RvPJYdwVHrZx+PQjJ7bmpCbJxbKD7V2K7QDgBU35GzSXsBJAkAf0I4dPaLQu
 9pD+Q2DbNlJklHMYR1mBhHkwCoXJHG1NmNjEqcdoIG2ILIJAWHH/rQyUjgVG3aaaQcYjtAgmrMc
 /b0ObUArwgtLAMUU51fRejkCQMs5DjBHQIK941nwOUAcGXLVwJkN1zgW3TY+AXiWnocy8B/sDuX
 vV8OYOWP09kWHxIS2/8FlHRSaYcaVymeA/J8YivtrYtxtslXrb/1xUeLObTIeNSBfYlAI4a8/dk
 HtRx2QAlF9oRsWpcxVSLgCLnwm3iv5h4Tj0cVOr6gd1hNewZKbhIRQynGjV6a3GMEOyP0FiDop6
 1+kG/YS4Ccyde4jF1xWlJOTYkCykOhe+PMdv9sHV/e0ZPJGbz/6lK08u0s/LI=
X-Received: by 2002:a17:902:ce8f:b0:2e9:3a86:b987 with SMTP id
 d9443c01a7336-2eb364e7ad5mr118513395ad.51.1793731664939; 
 Tue, 03 Nov 2026 10:47:44 -0800 (PST)
X-Received: by 2002:a17:902:ce8f:b0:2e9:3a86:b987 with SMTP id
 d9443c01a7336-2eb364e7ad5mr118513285ad.51.1793731664539; 
 Tue, 03 Nov 2026 10:47:44 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392aa7bcsm44746595ad.67.2026.11.03.10.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:47:44 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Alexander Koskovich <akoskovich@pm.me>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] drm/msm: Inhibit IFPC for state snapshot
Date: Tue,  3 Nov 2026 10:47:10 -0800
Message-ID: <20261103184713.29664-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TOmx-iAc8a-P6j1fdlJe9uXF13F7O_RN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX4786vBxwxTRI
 PdEqOZAYV+Bmd9civ+PJyG/DE8HrHXSELNixyFpxdcxPzpEqO8VQOY7n3AQPWRabBFSToFYne51
 9tp0vo8F6LgW0IqtUB40oDbs8k/WelFWRPIrrkFuNgo+pVmk9fxR/rHyHpi0/Y5sQugRA7MHJl6
 DfHW/xLZ+qUuOVtO+kYOExTXsanxFkhmPjTSS1sw392PrWJicoHIZFiiviIkeVBsf42HRUKDeo6
 nRxRZPJc7lNey2UAteyXlI9mjnWpQFu2qpzqC7yz1bwVI9qyHDqYo/+qxXbqAudwiv1mnn45ptT
 2z8N4NDNNFPGeHqkTAp19ihnhaxoRNmStvooeSMdBMUtaIYbHh6OdhQbUfnwrGAuxaM8oIH4ulX
 u7VDOlbokbUzfOjM+/W4XgDbc0nMvoSC4BGvGhO0E82mypiIPqpS5ZyQe5O6LAs5e4d3WWORqdA
 q/utE7/AuIV0QsX0wpg==
X-Proofpoint-ORIG-GUID: TOmx-iAc8a-P6j1fdlJe9uXF13F7O_RN
X-Authority-Analysis: v=2.4 cv=NMhAaE6g c=1 sm=1 tr=0 ts=6aea2c60 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=jgQnFmZX3A3noQDnNKkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX8X7MJHUoldBw
 n/ADhVqMbTQhDdKoafRgqXcGPvJUoFY8MJtLk6XRcgrJv3ZEdVa+AM0yUFi0UAuy0gX5f9L6ufN
 h6HDH5uVX9smcFtjSNuCeFmizdv3Fr8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030074
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

We need the GPU to stay awake for this.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_debugfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_debugfs.c b/drivers/gpu/drm/msm/msm_debugfs.c
index aa59b28a3392..29209c23fcfa 100644
--- a/drivers/gpu/drm/msm/msm_debugfs.c
+++ b/drivers/gpu/drm/msm/msm_debugfs.c
@@ -81,6 +81,8 @@ static int msm_gpu_open(struct inode *inode, struct file *file)
 		return -ENOMEM;
 
 	scoped_guard (pm_runtime_active, &gpu->pdev->dev) {
+		guard(ifpc_disable)(gpu);
+
 		scoped_cond_guard (mutex_intr, return -EINTR, &gpu->lock) {
 			msm_gpu_hw_init(gpu);
 			show_priv->state = gpu->funcs->gpu_state_get(gpu);
-- 
2.56.0

