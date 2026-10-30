Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492260A380A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=N5pJfXVM;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dHB2iTQX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99A8B1129FC;
	Fri, 30 Oct 2026 21:20:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95F2A112A05
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:20:00 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAqZT247656
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=KTqlhnQMr2N
 CQesTIo4IGBobCa+G+VXCAaqS3tav790=; b=N5pJfXVM0HBJFm8p2G1mlZXXoO7
 Z8NRcrfRVVvd1os/tteLSOSeR5g3vpNeN9eBz5LNsBZBwvi9Ozn9xCt4fK4Rk2JP
 ZTT8o2qOdLLIHDj/j+33GTGyLOhQn0N5rXkfU8RWRmtipDDpqNtMu/tcEmbqBxWH
 oXkxNp4AvGFXDg/jyfolrVOyj9vl/rxQJfdnff79LNJQKJFHBJAFyKwO2U0nYQXm
 kicYBFbCdrenW5oTn6GRd+ITFoMPUaoPbfk3c3c860/TNsT+HTyn1mbZ7hBbaOf7
 OjMkcKCSvOVMUZkoQXB1S4+clhDyufwvm52yHRYgH16Gl/fGHzPJdIoELNQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g1df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:19:59 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2e942b1cc86so12983715ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395199; x=1793999999;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KTqlhnQMr2NCQesTIo4IGBobCa+G+VXCAaqS3tav790=;
 b=dHB2iTQXc35jNmNEX5o8RMWu/uzjSzJ6wUF3FFwpN/SpgYxMjIy4gjcgYtBIkCXTd5
 N3On+xR8+rp/U0x4NoSRQ87T5hiv63/VJC0joYVp6A2Vn+20WtUnLmETVd75bgbmTEyh
 K1mHRPqTliz9pb4COVsgO6Lh6Lfy6nPTsqVQBVpTmSucjQkpx/sHuxMPpCEl93hC6NvJ
 NoIjc/C4YFezAc9LYW5/QzXSRV5DGfqoJxJxEW4wENouh/U4EHMjBtsKV40h1hNRpeQI
 KIgv+FtIh1J0uxEkarf39GwQw0qL5YxP1UDxI2o+vHz858TM9/RVXjWq9x2rI16v/LMd
 Ae8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395199; x=1793999999;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KTqlhnQMr2NCQesTIo4IGBobCa+G+VXCAaqS3tav790=;
 b=XytSkG/L27givRCxDYxePcwZPmMK1n4rL1L+EtBF1p3+fjNxWlMkgPDkZ8J7AXeXx8
 S5ErqbYd2HD5BnJ0na3eaLJx5CVwc8DGNEnLsEtEKi92cBlH5YHFcAl+craXZ49mLjtD
 JUt1Wn1h1cwsXRpgD5cZ9D+RpqC2X+F65Zc4KWV7Ek3rXXp6sU/tkV26Yz4JZFoh75+F
 3uV2X9Iz14GpCRH7TXokgVe1vBxC56cp+8JqSCON7JqP1vgjvAq54/xjJkZM0n74x8pn
 13PPgl2AVEc41ALd3dE1RLm8P9BFxjYha1OOkhoC3vCLwejMf/YgpYf9UM76WZU5mtXg
 R7FA==
X-Gm-Message-State: AFq9FYLhq5gBwALUxFJdIhh9wFBIED/S12xWhSyMszcW/IuMUB/buAJQ
 ghCt+Q82z3YQzx/GCQVbW3Of962lOb7C9VZFkA3crp2pm3KvzXWGGv5rftjpSwSQ2u2oRJkcFtr
 R2Rzv+e2pLuNOhCIW7+y1J+6kVaITRWEPhtdTHFsnlT81DI1ijLbrcktGXop6L573dSOOlZ/ApV
 2Klmc=
X-Gm-Gg: AYBFou1imU50vIMU9nbRbTejKxJ0vBVz5adVdIOK11o2+AvykzLGklKEKQuA8YZuWml
 tDr1yuE0dpUi7E6YEyjrjJwdxMV1N3f5ZZV/mXxHvtl+7k3yM8x5ZF87sxXpGkQ3BBvishrXXCt
 DFR++Th4leb99lJE7aGGkYzLuqEKToXkTbtAQJbtpUtGWYrXZ0p2U0k5XTNo9bIQcRJrOwBd73C
 Uh/kbPNQd4rfWng2gXIuJG9ty8LVEUDwQ67ynIHJYb2WJL8pBwJpvYmRMW7ZbqTxL6MNB2dP8hS
 BwiNwW+slH9E6zwLcnFHgqw28kJA34SwLErOFZ09yKM1VBBImH3cdqR07k4mBMEH33qSvAlfdQ7
 ZbKjvrepkGod3ruQH0CncXpMzfxZG3DYPn/UK01dXoNTF/LPh8Wc4z5fEDTT8Zmp35Qd2w0V7bP
 4HKAbEEHJb+nUVkz5iY4RE+g==
X-Received: by 2002:a17:90b:5111:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3ae89772eaemr2722435a91.34.1793395198904; 
 Fri, 30 Oct 2026 14:19:58 -0700 (PDT)
X-Received: by 2002:a17:90b:5111:b0:3ab:f38:2b43 with SMTP id
 98e67ed59e1d1-3ae89772eaemr2722416a91.34.1793395198373; 
 Fri, 30 Oct 2026 14:19:58 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae8805ebc8sm2580145a91.3.2026.10.30.14.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:19:57 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 13/19] drm/msm/adreno: add temporary __maybe_unused
Date: Fri, 30 Oct 2026 14:18:15 -0700
Message-ID: <20261030211928.45761-14-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
References: <20261030211928.45761-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: XBq-RsQSaRriKc7vOjxJ_ibWXJ5u4dfT
X-Authority-Analysis: v=2.4 cv=No9E4MdJ c=1 sm=1 tr=0 ts=6ae509ff cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=SI4bJWXHUBEfUJKjJlYA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX0g3slkdcBlOo
 GCsiB6AyjI3cgATeJ2PFpYks/bOusLJH33PwkFlb55sVsLdtIUrizONe50Xsa+oxaz2UnWuLQ4i
 GbqqK9XEjLms2X7WPi96iYN8MbKLXyd3yo7iBDU4uAo1k2D4R6ykTZwyHuySufX3HsEj6FwJReB
 YWPhsiXncsOsVR5KLeMz8Fzl2w7HeFXZgwGB2hs+IqvcL+wvee0hnCzcP6RKK+zY//TJGYjn4sq
 gnVlrZWsWbYCOZ3OCRQOu6l/SJmt6mB4bKCK+tvH7R0Jw3zgHfMicdqTqNowr/WOy5WKDQXZFD4
 e9p8I85Pv/XXahzTAszfHZeOIR3yz8MlLa1ORzNx0X0kS6Zs0gEfYvj8sUeoTUGxgQYO0ieVmcS
 rHNmJXGndd8ootgN1eAfbjzStYl7PA==
X-Proofpoint-ORIG-GUID: XBq-RsQSaRriKc7vOjxJ_ibWXJ5u4dfT
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX/8Q33TX3QqQo
 QaT9jIOxlE+oppylpZCw8VPrZ4CmJqP1EzaM+k2rMEuE+aEhOHQwbMaY8SPsaVZNl08A/35a0z8
 glBvcO3KkUeJ3HHHHhhoQvgRUtYVPLM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2610300000 definitions=main-2610300085
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

To keep this series bisectable.  This will be removed once there maybe-
unused protect tables are gone.

Tested-by: Alexander Koskovich <akoskovich@pm.me> # Milos (Nothing Phone 3a)
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 6d6e4c7cf919..c43efb85fde7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -168,7 +168,7 @@ struct adreno_protect {
 };
 
 #define DECLARE_ADRENO_PROTECT(name, __count_max)	\
-static const struct adreno_protect name = {		\
+static const struct adreno_protect name __maybe_unused = {		\
 	.regs = name ## _regs,				\
 	.count = ARRAY_SIZE(name ## _regs),		\
 	.count_max = __count_max,			\
-- 
2.56.0

