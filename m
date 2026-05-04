Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC81CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB08310E83C;
	Mon,  4 May 2026 19:08:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aiF48jSk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PSWqap+5";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C2D10E83C
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:48 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644DlKV9366547
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=V4uUYe1yUyG
 7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=; b=aiF48jSk2z03g5J0k6wGhitJjRW
 zZ5SzT322LLAPFpGhEccDuh5t9SlEZ7wUAHQWxejw+VO07LehrJpSvlKcYIMSYW6
 nGGNPG7UddirNLOIYHauEpJO7lk0hx3ZLOSd1fRHoD1nJip3gXLKHXncrYeH1zV6
 atpjM/MVSmkyLBoVoN4iTgK1j+EryclN5yjnDLPZ+hjj2ofveu3Kwk7gZ8SPcn97
 cr5OqA3LGzI1K+GMYvveRiGmF9/Y/ypUjpl/zs+gdOHRpdyPfu+mdBy9wzP1N9HI
 FbNI2rf/hd2LKqQujhEtHOq1KwGGvgkxbjsN5jhyCEb3PeEO0wY8DHAYEiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvn6s982-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:48 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b458add85aso42215685ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921727; x=1778526527;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=PSWqap+5yp+FuPxOBl8JA6/FVmPSQiQoJbWUMmk2NvI/6VW26XG5Xg5GuEDy8koWRX
 ns5/9QHELEgjpOCdk6cVG8LcSAc+P2tq7KWWwvX+oMMTrxaD11Lc8oP537nwls4A/ewN
 o3/NNBOvWVImcKJiOy+mX1rGYpDwMergvXLbTAqpYJAOTHf3oZB7xhfPUGrsjXhrGcK4
 7kGk4z6twoyo5iCz9yuRBlBgUuyX1/P9ZKwmqAu9E/AWOD/feewucP0k/VziHmD/hhzW
 1b4lSLJKCIpzPk5cLk1aG5UIRo47RouWfROtmKhXDa/CfArUCn33tq5EP47U5LNNq6vf
 4mcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921727; x=1778526527;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V4uUYe1yUyG7QRKd8WtYyuBLYfX08jPs1+jI/fe/6lw=;
 b=Kn1j9iFKWt6nzvHUx01lHLIS5G/aHkGXWwSPZNcsGR5/mgP8cD4c2UgYGmbxq1vFEy
 BNl4GLgYGDm3HHhwC6VNGzCw6Jse4MJu9Vqz/oyiVtWtpO6dr+WpQ6JdfQLy2PfFYz9Z
 jlPFspx5l/as2kUvtwPHKhoujQ9ooBSJHKixS0wegckITTHk++ou5SXUxwHCqevpfACj
 JgQ0B+izYqc/tZMxMxc2xWT0GN2b+eybBvUHGo/ov4+7KTxJLCrtOex6PfkLYTXd5fN/
 q2xBNuhsuBd9incPV3ueW1prDB9YCt8f8eNtlFseUqa/s3Nnn8LIFKbSyshnVPHO2EjZ
 q26Q==
X-Gm-Message-State: AOJu0YxuXMpqf1XbQKQwIk6qpvZf+tnjZ3ieNVS46UDCsQGsomtJerVF
 uLGWaqiMa7rag36NJbvivB+YpWqhS986FRPJs2fXnAMdDEYJhemB1JORok90ctOoDXf7d6MwNZE
 uuk9fRaHjU33QYLWa3Llo2Z0Z5dz79/FeknvP2WgexV15oTsVa4IMxiEOosPbhdM/HWLXOcYBtZ
 UY0jM=
X-Gm-Gg: AeBDieuK1OHMuAqJhyvkesNM/oReqzL/4hJ+giAllSu/T134s0/UHe84pEq5NZbDrol
 30K5CX2Oc0qrstQooigzajlspc+236y7MpiZVYjDTWUswwXLYsd7i0/Wj/+7aRaObnLOhHB7lFy
 5Snz8OSOIcfzPKI/ALz/HM8NHUwq6eMS1Yi5R+dYEn3f3eiZvNz+fwzXDLVujgndNa3tKhx5jwy
 K9niMCDMzzPTpMJGJgBK98WwKuLop3RnC1DGBkMDMr+3xQUqLlz+dI3cX77Q7bQm+G7MagEXWw1
 MdM9NbukpmpWRbrGWaL7agDtZKR6Bi5/Hix7novqUlX6Dl3u6K8AiXEl/VuoZ6tmNvBQjQA1B8/
 tNuz4JPCFCoMTIF4iiVK7V8MSS7KqglLSX0Iktt9ssYw=
X-Received: by 2002:a17:902:9889:b0:2b4:5309:2c14 with SMTP id
 d9443c01a7336-2b9f260b785mr76828145ad.31.1777921726789; 
 Mon, 04 May 2026 12:08:46 -0700 (PDT)
X-Received: by 2002:a17:902:9889:b0:2b4:5309:2c14 with SMTP id
 d9443c01a7336-2b9f260b785mr76827835ad.31.1777921726207; 
 Mon, 04 May 2026 12:08:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae0f67esm117642825ad.51.2026.05.04.12.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:45 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 14/16] drm/msm/a6xx: Increase pwrup_reglist size
Date: Mon,  4 May 2026 12:06:57 -0700
Message-ID: <20260504190751.61052-15-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IEHUUqwS08tVsShfWSkgdSVrFba0y8tl
X-Authority-Analysis: v=2.4 cv=Z+vc2nRA c=1 sm=1 tr=0 ts=69f8eec0 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=8lTVeMJbxB4f0FvlbnAA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: IEHUUqwS08tVsShfWSkgdSVrFba0y8tl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfXyygeE2PIXr8y
 vnxem8uOiBCq9sn6gvHmZ233yQtHP9WeZFXxP1F4rmIcw9KxAsoMU98uDVG65hEEJ4W6NmJq1gi
 l23p89gVo34+3vflixDk/KugstCAn9CBVfi7eP+CCgve/X2gQFGpiFgpHNYkMJwnMSEicMN37dm
 HydbYJhqIW2hLg5ci3JWYIsXGXrw5bzZonSM4JrXKal1xQYIBpkALApURQn/jiY4xWkKR1/8atf
 8biXDSLUVH6N7wE7xKWe5weTwph3mdTr3Ga4b6vZLzBljU1jphtmG0avjhWO24gxcbe4jUBZWLN
 45/Ow4RcHDYHhrcjTuwFz0FBjttPrkuhpNUFDQmqrPyUeK0sLz6fdE6SeCSsYiTbVx6O/W8hgWE
 dJ+4hnHDELCCFZMZ7kd4bIQSc0IL9LSnbCeiUf1sAjgWhW1sOAttZHbh1FjQ+JTNcO7grlNz0u5
 cQq0rvg2eMLqBTl44ZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

To make room for appending SEL reg programming.  Without increasing the
size, we would overflow the pwrup_reglist at ~190 counters on gen8.
Or possibly fewer, considering that some gen8 counter groups also have
separate slice vs unslice SELectors.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index a329d20033d7..61c6b0e781ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1183,7 +1183,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 		msm_gem_object_set_name(a6xx_gpu->shadow_bo, "shadow");
 	}
 
-	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, PAGE_SIZE,
+	a6xx_gpu->pwrup_reglist_ptr = msm_gem_kernel_new(gpu->dev, 2 * PAGE_SIZE,
 							 MSM_BO_WC  | MSM_BO_MAP_PRIV,
 							 gpu->vm, &a6xx_gpu->pwrup_reglist_bo,
 							 &a6xx_gpu->pwrup_reglist_iova);
-- 
2.54.0

