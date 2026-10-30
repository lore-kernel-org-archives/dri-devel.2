Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABE6606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VvUkgvx9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Z1XjZK0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FB04112A03;
	Fri, 30 Oct 2026 21:20:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4021B1129FB
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:51 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAVNb3367750
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=uy4egUIXFTy
 N8sajHl9qE8lhYFgJx267Ytfjd1RvPh0=; b=VvUkgvx93RWms59lZ+U3D82kzMU
 +YTUBiwDFAg94CWA9zOVFCdQHFEqIqeNtIELdGxtTvUQCwWqO/VxBRoUUHpaJe7K
 pZmvCAUflCVqzmRipQq4o+BLfuiJeOb9OCll7eEUq5ygexG6APCHs5N0gggLX77O
 2XQGHaUoDgaT/tMJ8WBCJ0XOhQxl24L04Bz3dvUJNCcE58vsrAIJ9ykqaVa0E75K
 BCQyl7YNG9aVqdwF9X/KODUeLg/QiEf4nRWEN7BlI7Q3Y6tK3JFUu8PseUjEs5NY
 fXctSE+V+VCzfA/qCQSyJmomTQ5yllsgsoM76ytZBu465cMGoYlcmDnlIvg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x080rm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:50 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3aca98f01c1so1082033a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395189; x=1793999989;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uy4egUIXFTyN8sajHl9qE8lhYFgJx267Ytfjd1RvPh0=;
 b=Z1XjZK0uEXVSa4dM1A8b60pqTp4EAK28l/qLoxiByynVH+d5R6lL7U3bQEGrJUmR5i
 xn0YgEC6EZMR9j5RCnr4ge2osXbZKSj1OcagBewGQ83KOR7VLQDPFVCsLAy4GyiCVCE+
 iI8hHCJ5nS6HaWtUTCOFNqOA3DdbqhTFZh1vK7bPdS13ppAsLUqDkXJ9W+pVhDUfHDk2
 3AExK+Dp7n78wHWwgVkWzBb3Xjdr3tOVLR/mcCQSXpnHQ2KVggT8xL0rMn82E98zgN6L
 Lby16ixr1ilLylyKR0NIumKEcAMG2PRuktkWVyMUECua+1YrVEvXbyeSZ/pkXFbmI0Vl
 9RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395189; x=1793999989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=uy4egUIXFTyN8sajHl9qE8lhYFgJx267Ytfjd1RvPh0=;
 b=Llg3IB8FD0wJ6h0mZe1kpaEes+u0g37W1EM0vEa+eFaF+HfH9VQN599DsNvVnndHmW
 8jDIdFcYCRwh1u4vLdQeSX+6YYE23g8z3/Y/VNn6oaHAa87QbfioeKoZAxTRy8wdtKD8
 382cgp/0WXc3nThN4gCmQJ4fzZRpolDwumi2AHGQER4J91u6zcshkVulpAES3REgveuN
 7Agga5ZxxlJxeTy3T9WtB7n353L4vBRSLaxG/NnB/1MltPd6NF4FDQvWaZk1Jv10Y0IF
 5GTiDrumBr0LEzOIqXo7Zk6rXK12vmk73cfuIU2mvReXWkJBJ5LAJEyxsU5xBHe4Q59i
 qDzw==
X-Gm-Message-State: AFq9FYLrUozY2G/1QZXgOKlG+gf12WyBZNfVQXhWzWPtnFy+OfznuQFJ
 X7gxyNCT48hxMb7pTmH797yEHxojQ6K7jmPxSV72i62z04MKHi4pDMev5YM5so5ZXsbJiu3QuEO
 hcoJh17UVNkpRP8xriP48PKSFpnE8EcXwq8+k9XkqCmmTH468FIiTnmH36F8h0p6mk0TncV6gBr
 S2fpM=
X-Gm-Gg: AYBFou2QVHyqdE5R7oeFb4eW5LpwgjC1dOkuAIm0lshjA+I4d8n1sl1C9rzxLpkmc6B
 BwNYjLc6qUSw9kjDjlQcVoG+v8IwpD0a+JxCUjENuj3qxy9vhXmC/SvuACRZnD0/Oe6LHF/SsEe
 JKUon4GLT4MVW5z9aecfM/olyqj71KLePNYC275a5yxpCbM3RzUxcY8xQwt1KeTtt2Xoo3mza9i
 uevXfMjIj3UNBagIcD5q5O/f5CqGpnKxEUAP9FsjeZ5nbS+rAXbSjodgtzj72+IVH35ZOZgi3I6
 AG3J3IMoBxp/id7JQTw92TnAgnECk3ES6kbyMjNSx2wk699/RbXBBLtUmc9v+7hwO7M4i5hpPc0
 I+VIq91ixRmtckfB6Hc4ZdOl2mR/cPAZpjaqdTEeRfXIN7eXfYBgmPsNojBjEW9mkq6dwo1DhS+
 cJIt+Rz/nxJ+yOvmUYtgLvNx4=
X-Received: by 2002:a17:90a:f6c7:b0:3ac:a521:960 with SMTP id
 98e67ed59e1d1-3ae89536bc3mr1943617a91.1.1793395189415; 
 Fri, 30 Oct 2026 14:19:49 -0700 (PDT)
X-Received: by 2002:a17:90a:f6c7:b0:3ac:a521:960 with SMTP id
 98e67ed59e1d1-3ae89536bc3mr1943605a91.1.1793395188916; 
 Fri, 30 Oct 2026 14:19:48 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae84577911sm5376432a91.7.2026.10.30.14.19.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:48 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 08/19] drm/msm/adreno: Fix PROTECT span length
Date: Fri, 30 Oct 2026 14:18:10 -0700
Message-ID: <20261030211928.45761-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v8jpcS1SmfCrW6oMzp4H9jkjOnvnEHc-
X-Proofpoint-GUID: v8jpcS1SmfCrW6oMzp4H9jkjOnvnEHc-
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfXzo3jb854d2vI
 prbOybM+76WjdDNcV/1BBU6hRy8cdXOCZxmVu2or1cXj+DiKURASgNn0dEdWcl398oDsPas5noD
 5deYwNWa4yJ7uwPYc7anQkKoY4gUjWs=
X-Authority-Analysis: v=2.4 cv=WfKZ+EhX c=1 sm=1 tr=0 ts=6ae509f6 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=MJDCpJTP__1aPQla-tsA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NCBTYWx0ZWRfX2kHd+YIm9aQy
 EkfVTPLQWk09O6w3fAV1RfSgjKiiHwvxnu1OUKTlph5Q9eytgEYCGZ3QLilEMJHuBa3HOO8ELEf
 aJPERtp2gVUeh2r0Jb2xRTwJJC60hlq/c67Tei0nRSvvuTt3Y7fee1pR38+9CB8Y8yyOQlfaKxZ
 DhOnm7Xn4SELP8PK19QkIXpnF8NbhanLnpJm2BqU7jzRxsaormPAvG13HYqV6H42Pe5bxiFjT0+
 EcrkT8MBeHLNm3ulQZNMbeLk4es9A9VyZ1BQueMixQezpM2TQeDBPp5HRuNGdfNqSXK8zBBFIow
 0rSU1HuDxplUBrKAdhoJPBNGj27HI5qS/0ZyTPtAuOxUDqfUs6ttLdGhkQ8CrWjvnqowoCrzYN3
 EYSmpQL6fDAg2RIsYv9Rr8hUsYpnfqL2PDIsp27cdeJ2piGBj0WKX29zTVZLhllT/87TC6wgXSu
 0zeRKTIpFhtA35BHGTg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300084
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

Don't let the length bleed into b31.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 6b23d301c144..c49301be504b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -244,7 +244,7 @@ struct a7xx_cp_smmu_info {
  */
 #define A6XX_PROTECT_NORDWR(_reg, _len) \
 	((1 << 31) | \
-	(((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	(((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 /*
  * Same as above, but allow reads over the range. For areas of mixed use (such
@@ -252,7 +252,7 @@ struct a7xx_cp_smmu_info {
  * single register
  */
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
-	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
+	((((_len) & 0x1FFF) << 18) | ((_reg) & 0x3FFFF))
 
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
-- 
2.56.0

