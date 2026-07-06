Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 222EFC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 15:00:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75D9410E4D2;
	Mon,  6 Jul 2026 15:00:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IF/ut3ah";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GPp7MkSv";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C490E10E38F
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 15:00:40 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666EEEvH688476
 for <dri-devel@lists.freedesktop.org>; Mon, 6 Jul 2026 15:00:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bn9/G/DyutefUg00Snqy1zzU
 39NkJvMT4AS5q8icaWo=; b=IF/ut3ahI8X40Wfyw7vMydD/20TuCbIZ19Z/0afh
 KTEahq8IFTkDK9tb76zcwC0Q9wNWvlKTH43UBxpNFSa/Q4XjVBXMEK7dcrVQhle3
 4FHEE50mrQk5Vo3uszoyFv9/vb0qHu75pm+FycOu6SSkqLMmDq2PGd4AyrBxHklE
 GVS30PqdnWrDeuyMbWZ7a9c8/QrIa6G8QZRy7CMcZ1jeG5X/3LTGoIcwZhlrbFB0
 7kEjJ3pdpmlUl/sXrkEQ4XshqJ3P0iBcJCnGnNRJr0d/qAnLzJatdHXrNBgoo3J2
 pt8CzE8jBlwn08YYTIQWXp9vHfE+KP7tp9sgX5A4gAX8ow==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a98h7vc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 15:00:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-73843d3623dso566312137.1
 for <dri-devel@lists.freedesktop.org>; Mon, 06 Jul 2026 08:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783350039; x=1783954839;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bn9/G/DyutefUg00Snqy1zzU39NkJvMT4AS5q8icaWo=;
 b=GPp7MkSvprTW9ENiJxGzAOmcdGp6nv2PtwdmIf5xHv000BZvyC1xV1gP9L+GM99SAW
 COxk9WY1F249q9VEYbu6ngTlPuVgBO+dDD0n+hqS7RIHXVonSNgoiReIqzRa0UViNk5E
 ecBGpN18nI4FMkhnuM/W7APS/6DmVgATsMJLNuPi21Sl+iCW2jb43tdsULpKn4ynjQoK
 bfwYY9KRewKlVbB/2bi9IdpedslIlfOu80lr3+ycsa/YajH1m8IO1lL4mLl8KUpU5N6J
 dLJkKmxsvFGLXYIg2loh3MW1sEGw8+HdjBhy2U/zWbrbbtDBaodjIKzOplN5IFgO6cph
 c9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350039; x=1783954839;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bn9/G/DyutefUg00Snqy1zzU39NkJvMT4AS5q8icaWo=;
 b=VCSrYU3JC8zHz35nG4/FkNJYU5Vy+lSn3z3Sy7uD433Nv1I0tIJXG+mbHCjUHozmjs
 hX1IZ4jyE/PFqzfpZKOpSHUShQisvzrt7zKEVzIo+JNegLzyH9RHZ/er+ec6G1Lrh+fq
 Ihn6BwdnJgOaVo/TBsJ+7qaUHWFfwF4QUnBF3VJqSzTDJuz3ccHblHVPUEY3MtKX6rBm
 7O4dRgiTtsTrYrp+hcg2E6nVpeWCNm1sZCMD3MPdOy4pDul+fQjVRfcM2RdcAuuiirjT
 sLawZTQdQv7ZIZs9oFpDB+yJA4iqHWR58l7F1cX3cdDhJc+DXPJG71ykvyk3HYjYKAFm
 UP8g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrNxitSY8nvPBB2sLtO4PoIBKvBWW8KcKEMmL0ss+U2SAZzcSlwjxlf8TK7rub2ec4mXmYVNYIRYp4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrlZu0Co+7vna/l0/s0nro9PlJ6l/xlMw+tczBytAqjZ1HXIHw
 jLnpzD4DrohNIBdAIq14ylasMskW9iaVXsqjqbQI+gsur6h1rYysgCpauFv8CZTPqU6CxxBAZm0
 GDinSbnj2hpcYmlFA/Ey55EW5jY81gt1QyD6BucHm8Ki80mGOH8OIK171cj/l9TjeR32+6g4=
X-Gm-Gg: AfdE7cnwShkbNNhTMLJwOpJc4GaWvosgj7DFRHG0/YGP2Po2VyLt5jqosEpTay5HZeE
 XLYHYOMN7TS1bIwiBrCa1rcPoOU4MdS6K2kZ69mUJAcQPSbg4nSJge7vHznk7efA4S6YEqaQcCe
 RKvtTilXC1IT+O909iqSxIFQPpg4v2Er3JEk7yaLmpjwIs6eCNmC8RBLkXUXoveu09GNUcLhXcl
 6h6b6JIJWJzBpUraiA/96egYsKBlz4DEk9l0iJav8hQHaUCoKnMvPfsn7dNMMvadqp9dEetbwKE
 nf3bT9xw+MAa9ziF9l6DGhBm8VKfLxLDhz+RA7fxvHy7JuWWJ7h9iB7Tej4wcOzHvkoFtreRu5e
 FytmCxMlPGoHyLX1KuZtqEqyIYEwIXORmhUWcgvq7KZ+GH8+zkCRwdQMf5pRU0kmT8TEo6vU7wA
 JeFgn7b31m5FZ65qSRPZ944NPe
X-Received: by 2002:a05:6102:5ccc:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-744b7bb690amr470661137.13.1783350039040; 
 Mon, 06 Jul 2026 08:00:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5ccc:b0:631:4cd8:b6aa with SMTP id
 ada2fe7eead31-744b7bb690amr470598137.13.1783350038304; 
 Mon, 06 Jul 2026 08:00:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aed13c5c11sm2964033e87.77.2026.07.06.08.00.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jul 2026 08:00:36 -0700 (PDT)
Date: Mon, 6 Jul 2026 18:00:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, iommu@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 01/13] iommu: arm-smmu-qcom: Configure lpac device
 with split address space
Message-ID: <5vfdbrk4bu77e7wgutp4h3ilbpjhcxxnwemqiufmtiwoffp4sl@oaonwwouw4qm>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
 <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-1-01d50c3e0c99@gmail.com>
X-Authority-Analysis: v=2.4 cv=SpigLvO0 c=1 sm=1 tr=0 ts=6a4bc318 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=pGLkceISAAAA:8
 a=lhguFYgXd42DN747EnMA:9 a=CjuIK1q_8ugA:10 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX9qcAi0+eSGb0
 QQlcktbw3Hk4kchpBCapmfcu0+hglNMfSuWyvii6/qF6temJ8qJ/PzFfliXZ9FfLDD8LNfWqfPN
 rSaob8QG7fJwvgcGAjTkhAwsSdJxXUjfsd10vhCci3zv8a0/CE8fsBtFDJTtzAqFSKR8nGMQtS4
 b8JfXN9WxHquVzy6igSAL6DcVJEUMKa0Wu8OGWlBUQkBN/tfwF8g7LsFMKm+AOA334AcbPQtTAb
 qNZuGoi1cw6UjStmrZvZgV0fUzGUXt3zlH5Av6XnIk/fxmp32pLgQB/zptcX8zy3wHz4bFIyGxd
 /1M1wZEPlE4bcNFnxODehX2ByKuo5gajHEUoRz5LTQtFY6dD/nDjOpmJRndBKPCLP8um1YcT7kt
 VwGS1e1VR0X/PV9cVRkm6GN9ORG3fDnhKcg4iiJF4bW3AVMdOTPlMxFThaqUskE1GjURzPQKhYO
 IuVO01tkwbbeP28i0Pg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE1MiBTYWx0ZWRfX/o+wzJ9YT8Yn
 hTQnTptiZC4lXuC1LkFEp3Y1B2GPvIFRXCYkM/OxeL4HqDcj7XUqH66gwW0cmAJT7f1F33NLYGZ
 sIpiQ8xAizwEIyFmQq9j53DakjFvQQw=
X-Proofpoint-GUID: AoJwrc7TzQZKSAlw2dOr-6DGkYoZQIwR
X-Proofpoint-ORIG-GUID: AoJwrc7TzQZKSAlw2dOr-6DGkYoZQIwR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060152
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

On Sun, Jul 05, 2026 at 09:13:35PM +0200, Anna Maniscalco wrote:
> We want the context bank used by LPAC to use split address space just
> like GFX.

Why?

> 
> Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 

-- 
With best wishes
Dmitry
