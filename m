Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6924EC79F82
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A57910E0AB;
	Tue,  8 Sep 2026 07:59:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YAEiCbO/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Sq4coWKb";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A241710E096
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 07:59:42 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6886LfMu1477267
 for <dri-devel@lists.freedesktop.org>; Tue, 8 Sep 2026 07:59:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fpbmmZ1QtShdu/q4PKZ8L0K0xegJNYhOag8VQBO3HSs=; b=YAEiCbO/LI82E+lK
 E/tu8cfQeQ9BJxIYXpSbj9jULhhrfia3qZgIP5fiMdBVp46T4LGvafyY0mcDOD2b
 v/WPrlZTK5cUZ7oRe38qd3cEVrzHF6K9kEOyPmmhgbkEuNKYzt3foruRHyGXLw06
 jFyEfIylRBKVqaaOkcJx+3REByTExfN7moPPuvJsJ3+oom1oPhHzgyoLhrJRvy19
 KOI7Qc+dkA9pi+/KXK1j8JKkyQVNV9Xwdes7LDkJ+Vl4bioPh2yoQnqHmOF840K0
 ooky8E14O1rbhyltuAUUSTtIjEnkPLkI6mpxNGQEYYN7oN+4cfpxdvWsIwScvxFH
 V6m8sg==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjatjgvbd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 07:59:42 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97cbaa9bef2so40833241.0
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 00:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788854381; x=1789459181;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fpbmmZ1QtShdu/q4PKZ8L0K0xegJNYhOag8VQBO3HSs=;
 b=Sq4coWKbuRFfshdBnrdSDKiGB5pch45c/jifkFwGGpBo8m+WObCz5Qc+j3YxHfqnd1
 mu5gbESiBqlNvsVDG47JWpFG6rX9TNHOFiG9R3uc1TL7f+z1rJfR0BrrzYDxAZ6DbmZ4
 SrcxMuYLip7YY5yjaQIxpb08hb+N6AcckW8BcaS5D1vYWTZpNtISxG0Z5bAddtflWdRg
 E6Z9wIPE5ZMObL6yLWskptIY3rJ4WvtXkRa8aJflUCGQkzm2/wfB2mKbSW7GZFEQ3sQq
 LHJUReROBZIg4nDeDa/VPiDWb4xCveCud43vy+ZGggyAwD48JJJcqM5hAo0SB0h0RwLh
 yYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788854381; x=1789459181;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fpbmmZ1QtShdu/q4PKZ8L0K0xegJNYhOag8VQBO3HSs=;
 b=jZ2/JCJ7YDvsd00dzXVJwFDqbRDZ1sA0IrJNDDDPSkhQjxp4RpJ9bKi2VchGnEQj3o
 8ZjH0pSgR426N9zDpC5JjncyzzyZtVX4VTJTSr9Q3nHZP4k0BmG93JPmpq76/iedlXGF
 ZTuusgmWduRgkzzk/PqkwB93LnpGIgEKZHHk2IYupQew0nWWiJeHIpZx0pAKZRyB2H3N
 f2uQ5fa3T9MZc+dtD4q79+PxqaKqyCl32FLCNH7CYnJ2so6EtvZ6Zna7aXMrHEfjVpE4
 F5asCkqlj72D/rCRHF+zlDrKeB3pQ0QLoqBbh8IVqeS6ACUIjr8S3+ORsYgTnhv0P7rX
 Z/XA==
X-Forwarded-Encrypted: i=1;
 AKwUvByUJEX+AqPeFIc7UDNr1446mms+2cc/5JomDrpbyHZP67HqERL/MBOraDZgM/wIJ8Rkqe93FUxXTDk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lgYf/asD5nn14zwFBZ68/zdTG7tJA55S0TwOjWSOTXjhWvRKec
 o2TH2QjrMHloVCKpbaBKI9E9/9gbM5uc81cHjgfyRZTccZa266km39n9lKigsBzwVb7cmKalMPn
 pOQKzORbbCWfdhr2zH4Oh6zyfO8cLWR122BJwpz/v+aXyMkxd0KKoCkgYmExMtjqxtkBiokY8N7
 PhCz4=
X-Gm-Gg: AYBFou14Tgxu456VaOaVJ9M5MLznzs6aQFrAAtgxW1wmSyFavBa1YUB9ZjnFZ07NMDz
 xo34w/w6sUlkfkhWD8O1Q8r0sgoy2H6Y7QkdsS8fppcKfKzPFyHkjdGANh3KagGij8j0lEjMkZY
 Pmm3ydj4XSlLPJKRhbWNECYox5J8hWsCUhQJC27wYuLFr/Y8bZkVLXGPCMAWrdWT1RjG8Tu5uKA
 ORFiM4LZT4jjzgQp5mN4Y5bBMC9+jqb2H46LFufG+t9ZNwBALeywzqrZIFaxNKKORolmcioGrVQ
 Jwf/7AfDbxeVgePhN0PNzuJNiSjSZxVaFgHQ9aJ1ZUQmb8mHnS3l9Oe4GIwyU5sLw1mtb2lKfJC
 lUJ1kVFKOYYvrX4QR40vNgQ==
X-Received: by 2002:a05:6122:c2d6:10b0:5c6:2128:7cf8 with SMTP id
 71dfb90a1353d-5c7fbb2e565mr2177823e0c.3.1788854380977; 
 Tue, 08 Sep 2026 00:59:40 -0700 (PDT)
X-Received: by 2002:a05:6122:c2d6:10b0:5c6:2128:7cf8 with SMTP id
 71dfb90a1353d-5c7fbb2e565mr2177812e0c.3.1788854380521; 
 Tue, 08 Sep 2026 00:59:40 -0700 (PDT)
Received: from [192.168.202.12] ([178.235.128.140])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a37054a1b0sm32636061fa.14.2026.09.08.00.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 00:59:39 -0700 (PDT)
Message-ID: <51fceedb-2dbb-483c-8eee-9409ca61b1cc@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 09:59:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] drm/msm: Properly handle msm_ioremap() without name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
References: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-0-dcf8956878ca@oss.qualcomm.com>
 <20260908-drm-msm-hdmi-fixes-before-eliza-v3-5-dcf8956878ca@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260908-drm-msm-hdmi-fixes-before-eliza-v3-5-dcf8956878ca@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfX+t9vU4+OsVOc
 JcKUCafzKuWQns6smmqfbW5VuvMMOjsc19uhpD5NfODdA/Fe4kespeNX39B7uaDDs8PbpmfnCmp
 ew2IuXSXElomuctqsPYLK/92CTJX8UQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4MiBTYWx0ZWRfX+cFWqscztx8o
 swHw8TFXnWaWJCO6G90QZXCOllve/u8lErcVpD6oLh/57tM2u5yPSgDvTQD250i1LwyfpxnKf5M
 rj+y5od4IOt88FTp5y9sK+3eDmNJunkSpB0RupqERvaICs6UJyPwWlggh24vubrGNaM9k8/9NbX
 goAHiDEe+gciBhsxxEPJcd4RbY69DCB7Y3laUArfI/DV12UMCNQ9JECZecd17zXRmkK5o4WQYzG
 7XdKk1DVnvjQODC+X/c4gtqIsJp7Iprb8ejs50vAcOfBxrvMyIqZxDMkHprVKKMHQNvpTEpEd3L
 6aefvTJiF9sOfAGE6wCOGWMimBXsA2GBw68J99FmB0C6BxtZrxRSUrWfc+f43C6IdBTpF3/dlmW
 +yacVs6MV6JBW/FOWjVs8QsX6amA8Yb2MUJ4YRKp8HCKqBNsryrr7J8/X2bchDnB07ZUlhJR15w
 TyA+ykD4ReMhkB8i3dQ==
X-Proofpoint-ORIG-GUID: QBEm5fib36yi__OTB8EqETz-wq3r5XcB
X-Authority-Analysis: v=2.4 cv=QrduG1yd c=1 sm=1 tr=0 ts=6a9fc06e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=cvAdRwzt0-5P8qaLRNMA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: QBEm5fib36yi__OTB8EqETz-wq3r5XcB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080082
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

On 9/8/26 9:10 AM, Krzysztof Kozlowski wrote:
> msm_ioremap() accepts being called without name of the region to map and
> in such case maps by index 0.  However error paths still use the name in
> error message.
> 
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/msm_io_utils.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_io_utils.c b/drivers/gpu/drm/msm/msm_io_utils.c
> index a6efe1eac271..0a4ac0fc5fb5 100644
> --- a/drivers/gpu/drm/msm/msm_io_utils.c
> +++ b/drivers/gpu/drm/msm/msm_io_utils.c
> @@ -77,7 +77,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
>  
>  	if (!res) {
>  		if (!quiet)
> -			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n", name);
> +			DRM_DEV_ERROR(&pdev->dev, "failed to get memory resource: %s\n",
> +				      (name ? name : "#0"));
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> @@ -86,7 +87,8 @@ static void __iomem *_msm_ioremap(struct platform_device *pdev, const char *name
>  	ptr = devm_ioremap(&pdev->dev, res->start, size);
>  	if (!ptr) {
>  		if (!quiet)
> -			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n", name);
> +			DRM_DEV_ERROR(&pdev->dev, "failed to ioremap: %s\n",
> +				      (name ?: "#0"));
>  		return ERR_PTR(-ENOMEM);

It's odd to see one being ?: and one being open-coded..

Konrad
