Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E841606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 20:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VLU/0Kny;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FP9LomSH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC795112D70;
	Fri, 27 Nov 2026 20:16:08 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A967E112D79
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:52 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ARJAnsm3346864
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 98qDoH92azSwLouRMH+8XP3dKSJaHgdwXUq+g/TmSHg=; b=VLU/0KnyuUJMZQdO
 rBEocEKSzuWWiP5IfVwqLXMCIiwHJVHuegFQp+Y/29wQB89z+281D+srlm0HHAl4
 6XJ94xeoKQL7N0CW1DfrSfwuu4z3n8wPgYHRyS/bjRZ51w9lQEOP65ZIR4EVkQ8n
 CaHg58cL0ia0ZNgYCZlcf4/0Dq3RhPllklUib/8mUqqeSk4d2S7/bQs4k4TkDxMg
 s+bVtGrdARWnX8bnmLRM7bkidX9iS3M/dKlCHgJknOTV5q5aHCR4ryIFZA+wfm8d
 ZUWezr9vkzsOuXazLvleMPTo9ovj/vgn08nzh0LbSSVGXplBzj2U6MqCKmeHpRbS
 +vmRtQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j73uhk1dy-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 20:15:52 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-5eac2cf3905so1944305e0c.1
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795810551; x=1796415351;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98qDoH92azSwLouRMH+8XP3dKSJaHgdwXUq+g/TmSHg=;
 b=FP9LomSH2kGdPMLvL034QqWc0S2akCy6h1qVT4J/V6jmCEQq58o6xIXhbFK48UhQ1C
 vPCQkx6FhuiXNqemA5kvQAEXYTsxCq24f7WEeK3VWV43Mb+x3/l6i0JqpRHbGJ7P41w5
 CuEwb3rxv6Y9gJbsbVgFSIiIZdsIpkHebTAfbp1w9ZSefRcIAnh/nbyzmhVCXiw0It1P
 no9TFAFtroZpZejlyDBji3bWlq225Vg4Vq543CkuyVOdLZhOUHgo7txt/b0QSOmCsQJY
 csmJVa4dMceJiO6Sg+uZsjdwDvMEQ1KowWuJEnkLPDGYzp3rgWRPo9QpubOZDq5wvLE2
 VLIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795810551; x=1796415351;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=98qDoH92azSwLouRMH+8XP3dKSJaHgdwXUq+g/TmSHg=;
 b=W525xSyVTXFsyBbP+Ma3wyD3CKa4fdhTwDhxtvyBuZANY5g+UHYd3ZmbrFB7ysmqVF
 T/d3CP+Bk2VaBo3x5xf/veOS1SpomCM7B8goX6knpiQKbJmXhApbEe48HiY2R1DJN/xa
 ZZZa3tDoj5gcupc1uIcS4abuCc2cPZNY9lopXxi24QwTRAsqindE57vngNG71+N4A9Va
 p3+BV3URIXhff2PF8sYvKW8pUD4FRa5ukzwaDnmuOIcMxb9qGhSepoXXnA3CSyYuQHsA
 PbnOWRcMotngi3tygrkwwxK0Yv/U5h6wTJUkmIj3+iooshRLFU9xwG2sFVqE3wFdYnUN
 rU6w==
X-Forwarded-Encrypted: i=1;
 AL+hErEskxLmxKfpqQn2uQHtBSz6ar5pYGrrgHZwOZTr0SwHix/rVkPBSiyoTobPoe8WN7UG8XnlyVMcovE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9dhCOwKbMV2aHjNuQgJVDP/yM3NzIU4o1XHBcNxPg8LVwpwgYp
 B2SpwQ3vXJ31SgI4Rdjf1RPlnFGDHAf4U8amjLyatwY/JioZ6bI0NGcnOyytcj189M080QEJMb0
 Nr7vIzCnrFzCbMTK5A1aokWLaRaxsICybJZo7XJ6WoeITk10McsjasAR6sU8rWbikCZ4plRo=
X-Gm-Gg: AZFdTZczA/3tCo/HsACVP9IMWqd1jWpD7kRLHzi4gLHe7TcX37ds7h9t5NDTqd/k0aP
 /HCUuJZwnECenS2vZniyTtR9tv/vLKE4l6IbnMEgeNA7C00J+Y2WOdqla22JFstXnCbE9VuYzF2
 w+DlsuqFKWkj7PP9QWlyu+/AwF8IRZ3/9hrwfz6Vju7Vyg5llG5hXC7gqN7LsaiKkpDENrF3I1W
 XtKYAMB/5RIg62I0bn6CKYBScAyPROcQ8yRKe51Rw5Q6ewif2jDVkJouVos0QwsaZ2qs1/xC0ty
 CkcpK1fyxMjLSijE6EvrXSM8wkk0rssfT5S7k35yLoq5bd1b/Rzs7ZKvycAyWoTIRvMWuiQEizh
 QE/bXo0gUaBDHbL8yOoT/+2O9mNlFZ3Qc3NlPWWpn0e0Qd682WB0wlqa3a7jdnJ7+3MMP6jycge
 XDwn5KQYpJNmBHLdJzKEZLDuqL1W/EOCsOxbJxPYc4plAVPCHxcDg1Z7NoKddnng==
X-Received: by 2002:a05:6123:a8:b0:5ec:3e18:a912 with SMTP id
 71dfb90a1353d-5ee8af230a5mr14375566e0c.14.1795810550835; 
 Fri, 27 Nov 2026 12:15:50 -0800 (PST)
X-Received: by 2002:a05:6123:a8:b0:5ec:3e18:a912 with SMTP id
 71dfb90a1353d-5ee8af230a5mr14375526e0c.14.1795810550153; 
 Fri, 27 Nov 2026 12:15:50 -0800 (PST)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae8050fddfsm64591511fa.16.2026.11.27.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 12:15:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 22:15:27 +0200
Subject: [PATCH v2 3/3] drm/msm/a3xx: update the CP_ME_INIT data to
 msm-3.10
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-a3xx-fix-me-v2-3-839408d293ed@oss.qualcomm.com>
References: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
In-Reply-To: <20261127-a3xx-fix-me-v2-0-839408d293ed@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=894;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=lso6GGjxnW0xHLP2ZKgFEvmFfqpbP27jCKyKzBg+AJw=;
 b=kA0DAAoBizyKPgIpKNUByyZiAGsJ5O2heZmgfdQPfBuaJhQqnhwbxZMb5CFc2yvFrdQ8zioZU
 YkBMwQAAQoAHRYhBExwhJVcsmNW8LiVf4s8ij4CKSjVBQJrCeTtAAoJEIs8ij4CKSjVmosIAJPL
 Q8lzjYTDLtfWLAR1zrvO/YFv4g2WYPDaBT/f81v8IG7R7cgVDeEjvOcj9tq2TDJjnqL59TJxq5j
 wtM0f4ufpkis94gCU+iLEgJh7L+AiDpvzR2pXNIpaqU5PbmWUdaO0a1qz7D0DJXqiFNd+B0LT6M
 L0TqrUS1sk9YNyylDbcwdLtXFz1LbJho3Kzif5oI7BYyH7hjr1jzsOOaSes6fKdMWY5fE+r/y+Q
 L2L+bR/nYrkfBkjECWzIFcKOtJ6UnOunIkPx4dMFST2g0fqkDS/EZfnPsyqRGfkI4YeUVO6bAFn
 EHNdZVo1hmxS9SotV2tq1sCqdGB8gqyO7nJ0jTI=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX793O2cqgv+y4
 5DNhwmWNza+IrYSqCI6hUwnvMhqTti8Tp6r5I9Qr4y/KMQ5h3Nyd7gb9ujYtU/omi1uvtoyJSiT
 3f/Pang+6BtLxfGXJMbOhRubcwEYjXc=
X-Proofpoint-ORIG-GUID: hFXkeOaiz0aR5opBUzTRcD8Joi-nHS5V
X-Proofpoint-GUID: hFXkeOaiz0aR5opBUzTRcD8Joi-nHS5V
X-Authority-Analysis: v=2.4 cv=BbBNQbt2 c=1 sm=1 tr=0 ts=6b09e4f8 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=ypG0q2TZ0WS5u_ylJzIA:9 a=QEXdDO2ut3YA:10 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA4MCBTYWx0ZWRfX+sEGs/Q3jwxq
 17wiMhDiXocEqMl5N2JPV0O+KBT1nyfzdwWxTWshW1jdQOtRuPj0K5otHE4gW/HXnmbWC1TcOTn
 88o14/RthUzGF7rlyAAzNO7y2/gDpu9ogyoJrFimZaXyFlcRNZVsRrSE7FplfgP7ZyZNcsQo4Rq
 I4mHlb1UXTE0Nlp3AvwGQbqb3K07qGDXjknAtRpiBUPxY7j67a7sB0vAGO3nO6v78OTfW+S8s7m
 WvibD2y41e42vVKf9sVVfgTPSj66Cun1u8wvU5wsz+D53QgxXB7T3CT8/GR//Il5q8hCMSUcQ8h
 tOwR4/FJ0EI+VLK8192hLTaL2tqyBtdoSQ/woTqxSeBvsdi3Rg/2PwqVrBVT3bqNN0Uk13Hf0F2
 h8UjXXt0afn/8ATYaIF3T8CZMjFG2VqWfUPSWnSVU3e8Kwvpp4I6neMBTOrmW4lVdc6wP3ER9mm
 tIbXf1I7m531eJUbjgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_04,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270080
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

Update the CP_ME_INIT payload to the values used by the msm-3.10 kgsl
driver.

Fixes: 7198e6b03155 ("drm/msm: add a3xx gpu support")
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a3xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
index 6a9e0e87a8d9..8bcd65f52496 100644
--- a/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a3xx_gpu.c
@@ -103,7 +103,7 @@ static bool a3xx_me_init(struct msm_gpu *gpu)
 	OUT_RING(ring, 0x00000001);
 	OUT_RING(ring, 0x00000000);
 	OUT_RING(ring, 0x00000000);
-	OUT_RING(ring, 0x00000000);
+	OUT_RING(ring, 0x20000000);
 	OUT_RING(ring, 0x00000000);
 	OUT_RING(ring, 0x00000000);
 

-- 
2.47.3

