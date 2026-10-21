Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7639F606A337
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 08:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IBP1AgCN;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JP6EoukA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB12410EC5F;
	Wed, 21 Oct 2026 08:39:07 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC0910FC97
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:38:56 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69L7EAPC365904
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 10q99WjpupYyXoAqEGbsDSnGwWdgp3LWUj2x80wFg9g=; b=IBP1AgCNXnfxKQWs
 U/gF6I4kttmVJBgP+n+m+w1mQh1SNWfkVPYDMewQm13NgtuORAjhg0dJtMxpqUXE
 TuKwpKXCL1WE7G0F8Oeb+JZMNvrfs6zex1hf8PtQKWdBJmth2HzTbu2AqD2E8WNg
 79MaS4yUU1GPhHx5gQBZA1tj5tzs40i2f6ps8KE/R4rbPgvGkggDy4n4nM3bOf6u
 D2BdEpDYiuail7KwS2VxG0yIIT8WsEn5NVRTDyWnZfvJ6oNheQcfRhxxqkgSO7yC
 n258RB16rRgVP6BZ0+Uzwrn4b7QOYu0g9HPXbgaELdP2kyD7PW66/58dcuwG7rIV
 abvBcA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hegs02532-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 08:38:55 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-536540909e5so1525571cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 01:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792571934; x=1793176734;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=10q99WjpupYyXoAqEGbsDSnGwWdgp3LWUj2x80wFg9g=;
 b=JP6EoukAX/XdrnDMT4KfZhNXLZUgQfruvU2zKJDJuGFHrSFaoA6NELww7q/LNXpkwy
 4jUY/8T6Czp+iBHjbyp2BjdTOIjZb6eO5oxAhbhO5rF/bzMl1UxRzkeyiuXTdbL75Xav
 UMhr3bUlLByCavNAxCCHWLVSEE+pd2faFozzHbNuJPBlyhlntLtIQ4cYKb4HMURItMjJ
 rUC05maqv3WzkCmr4t/pVGGAqdP1fctYOK8+Yv0+nk3xhbGBbCTcLv8TnkVeUORgjEOn
 J4MXAkUIJiGJnUXVj8fjTA1jQU1cUyAwpdegfwsGC6tR5hTcq21Vse24kAesD7Dq+uzu
 X4mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792571934; x=1793176734;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=10q99WjpupYyXoAqEGbsDSnGwWdgp3LWUj2x80wFg9g=;
 b=ubBl/r/jC6f7c10WiT5GxdWQgilKeGYf120iYKUjk0Ikt5MEt/Q8ac+OCrcJjp7Ncm
 9Id0gwKYOag7y/7Fp2uzLYOmyLWHVjL9I2REuAszAyMxRHyoRAazQoY+3qHnPrFbvC7X
 cRDrgbjJhDBVMTMfJyj8uTwq68FlucLgpQyA2FpX1i2Xra7zmTd1EdO6+l8pWP1Db3hv
 zZke57xfWfp3ko/fb936ZWwsU+KTQq7jrt2A+p2LZp+Zmy34vfhveDqzvT/KhBJuH+uW
 DFDi78exjrC8LvM9y4lEbeE9h+xJ5HVxd7Ce2Q8vFeBaZZ5QIOea/4o5DrZGEhX3qJAK
 P/EA==
X-Forwarded-Encrypted: i=1;
 AKwUvByWhWGg2Vy92CekD5yJ8PLhg80ABoynwgwsbURFitQSwlTxfoZRqjr0JxgzCbGHt1Lx4FDX3tegL0Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIfkZs9vKVJO7qm68XGOKc8eGstIHZyKBLq/MhZlDMf655YjquD
 z92onbfOxHksbDUGk8pAR5rysJ4XnKInvgqWdzupvc5M/cVn0odpY6yUg/ygRfvp/zeUvNl83hy
 88kfIzX5bmrPgkrQcF+5BTZFvSDVIYVRqi+4vHYMcyEmUtouTFyOz6Ol0d0mgLLXGauzNy5U=
X-Gm-Gg: AYBFou3261hFKBAfZn7Q5iI6FoPgu9sTfTrDmUECtFKXxdcjDB+TrQf3xUrpOiKhs2X
 OwHeKIzgbcYQDf6TIwj/YV2SAXPUEkcDidBSX5S34M5PdMzBz+3c30PRQIbTujsZ4tnVKVFwSK/
 NPvR7BX5e7P/TYLWUt5Kj3ySfJoahSkIbR9sEdYLVoWJ1EmAPRwJPOBNmOpeeL6IuQFtKMMn6v6
 7Nm/FU5eJfixvOhLNRv47wku/bDIgkwJ/SfBZ4nwt3S1f5wddcGCgfrdnMIz9VRPO94+qTdRrDr
 YSc7xaK6RgMkdx5ZV3vu3BO9FySglQ2wDVZEKHwOix/IZ0/RQld2AD1IiYSJG18N3fY3g2KfhL9
 e7qKrO/fxWg12DrQB87PXUw==
X-Received: by 2002:a05:620a:172b:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93f57e897a9mr338660585a.2.1792571934496; 
 Wed, 21 Oct 2026 01:38:54 -0700 (PDT)
X-Received: by 2002:a05:620a:172b:b0:939:8bc:8826 with SMTP id
 af79cd13be357-93f57e897a9mr338657585a.2.1792571934003; 
 Wed, 21 Oct 2026 01:38:54 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4678f77729sm54778566b.25.2026.10.21.01.38.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Oct 2026 01:38:53 -0700 (PDT)
Message-ID: <c90eb47d-0eac-46af-9806-8404f5053e38@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 10:38:50 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] drm/msm/a8xx: Allow nonctx reglist to include GMU
 regs
To: Rob Clark <robin.clark@oss.qualcomm.com>, dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 open list <linux-kernel@vger.kernel.org>
References: <20261020204728.28844-1-robin.clark@oss.qualcomm.com>
 <20261020204728.28844-5-robin.clark@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261020204728.28844-5-robin.clark@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=S/NMU4sP c=1 sm=1 tr=0 ts=6ad87a1f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=FxG1VXWaU6FXrht2Wa8A:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX4b3JXZ3Os1On
 cROsaMf01mS6+7Sv/esGsEgtLZlMx226OiizFUgMcJ45OKo93tXI8zsQWrb4sms9QNvwejr0d/E
 KMyQFR0pbSWRBj+MjZ3uDyCTNnGUghcdFpH2kzWwiqDseiFLt+zU2RM/U6zIXpV5Jxlb8MySGGq
 dCId3YSzOqIyQNxvwuEhR35IebXLbaJGJWWIMUl/u7/3Ad2x13hgxCm5haBDQP0lqyyw9pXGhII
 iNKHBURecZiIx+JYCX/pWZlrC5rryLaPrw43lfH5mypkSg8kO9yAPuqpSGTQ1sQOZyhKQoKr1y4
 85UuM/xLOu9GYW6ZNccDETC1G1HsN0ruEpnh47J8DKyX5nkD4GDVDtk291qT61At23rQGgELOi4
 f3edgDJVCpomkyNZKMgDiomZr9VxD657xKUBIayKL8f6KZpU7HPAvizqeSSAYS4OXQax64wU95z
 x4fd8fSK/t623/EC+cw==
X-Proofpoint-ORIG-GUID: pRG75k6XjJ4Sr7VjqcQAFHdofhtwEeD0
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfXxIxGs7WUgain
 0hxmOCVEi5ZU7aHNOz4YFg5lzo1OVk8ymbw10qAHdf3hCZU3M3YUdzcXrLU80UFCRtV6Kw5QuoW
 5itGRXrAyxDfHJBRiTWidJwlZAzzZ6A=
X-Proofpoint-GUID: pRG75k6XjJ4Sr7VjqcQAFHdofhtwEeD0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210034
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
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/20/26 10:46 PM, Rob Clark wrote:
> From hw PoV, it's all part of the GPU.  But from dt perspective it is
> it's own device with a separate io space.  So we need to detect this and
> direct writes to the correct place.
> 
> Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
> ---

Acked-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
