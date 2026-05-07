Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C83BCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BB5710F022;
	Thu,  7 May 2026 10:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="TkUzYLVd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VlVC7/ax";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7D410F022
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 10:24:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6475LoEZ682765
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 10:24:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=JoRWGgOZZS3G91zVwdG4c9Lr
 n6Mvfm03iqOH0vlvM/U=; b=TkUzYLVdDiDMQQqwZkOHH0vOVJwRA6Fw9vGkCznr
 P8/7iK/sHrwHY8tJTuFv67LAHfocEBWPmPzwLzOiq0RdZmXlt2DBqAGBnW1eo35L
 cHbnbTy0xVf6ITKvwk5QV0pR/K2lsaCdRkZhMJKdTzaLWiHJeXN4Tek1xCn4MUBt
 zk5zvD7ZX9wKua1nA/kGk08oZxomwuJDb5mMxHicFnb6RA9vjBCqY1MVMT8Zq7/b
 HzkyYbDDUlWhcWz1MCIpGGh7Q3kkM800DjV9rV/CD2ipSvNG+UgAjabH/5dGtAU4
 cKiWwlr1JRVNBZ+M+oxzMKTHXjP+B6QwlIoA4VWWCZwjWw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhas4t7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 10:24:18 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50e575a50bcso8167281cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 03:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778149458; x=1778754258;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JoRWGgOZZS3G91zVwdG4c9Lrn6Mvfm03iqOH0vlvM/U=;
 b=VlVC7/axLLPNurE/9FNUzK7wkDrkyLNS5JvMMDwc1rmYnIipx0LN3WIMa3+peXqM2y
 Hsc6J/dUPP8h/FnyneDm0bH3YIl7qYj0tfb1ANMO88TGVvuOigPnQHbcEjqusH4CRFUF
 VmPw0atroBOvmlN2wKREcf0VahEvdENg6oAF6OKKOFZ909ZqFaFhShCP5gWIz4uWjA09
 L8whuMJQD7/vcQF29l7mqosis826WsEi9MGFSZv9R06anBiaU/wu3YYJT/MnSjGn7xn7
 f0GK4E9hw67iQswFsV/hmrXo39BuvtqvZbE5Bch/xiOiLayZT8HU9ajhFe/KjfzpQ5dY
 T02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778149458; x=1778754258;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JoRWGgOZZS3G91zVwdG4c9Lrn6Mvfm03iqOH0vlvM/U=;
 b=KEgmUIk8Tkon2Bl1+owMi46KKna+p14qkxQcTU8uzI3j9DqUa+SY8GJSz2PYHyzvN6
 kBqwbyrtfxxAv9B4jlEXCPDKtVZHYLczJQOgIwLcm2FFERbFmpQZd6GpY04L7MnIeeHL
 MrdA0DhbPpWDG0ddsWWohlui9dl3XWpAVzVG38hfKFYOjVFXSGpsLPjL9O9VPBo31Ypj
 KVJR7ZKwM4NAVLykm+ubmSmBxO0RlEnsLmNR9dQfWPWrX4aJFfiOBUFmkvHJFO4raAkI
 CftyK1Pm/vcbI9zZtGChHi/uattTIZLANNhtq3RM2etYzcue/FGBGoqTMV63lG8NPi0m
 3Dog==
X-Gm-Message-State: AOJu0YyhrF9aYiLd1OKTI4e8nPDi64mDiEruTznLRMr0sw5KFY+X3hP6
 1e0hSal/TYh3xowX1BB/ZddZARwYZ3dMlU4+QQN5NayIcZPiQLaQXGDVRxADR8974OsDrx8buSN
 W5z120mRT+TXZFHFqwiPhu2FL8dhqi0+j3nDtLwa4S0i8H5FqC8Hzz3tdD9MVcINFzui/EaU=
X-Gm-Gg: AeBDietsNo5ljMT4ccdzkY8c0YF7RkvzX/YSCc+AvMqpvKS8XY1tD2+eIMkUqefwQEQ
 JjXpx2OhFx/fS6wo4rd6RjNz3yPYpUdM+XiTGZYVZD6W0hx+8k3UO38sLMZegeShSk1xZBhNI1D
 1SLJGIWHn12QxaE8a46jQpBkXSlS35AMVqFBiuQ3DbVXj4jGmwdhpVT82vI8TKGV4GWBHGdAwhk
 H6XmovUAq+xHFcDBaN9wWZ1oDd8uwcYZO+/U/pjUS65wsqACZpvR7kq4W1tGIN1WEN8I8OSNPNt
 bkEecbx254YEXWWmUkmZ6OMClF5ITJmVPvU1a8tm/wiI0eEZjLFNnsGDSka9rMf3krryxlmcyBY
 X2rwc8b8Wy908MXD1KsiEdVMm2qPYx87U1BCas1SotKayWlVHOjvyB2KAu35DDcQDYTygL2g4mo
 hqVcw4HEoXaRS5ITsnN9WS2EqCZjj3pA9ObV0sq2Azf1EmpQ==
X-Received: by 2002:a05:622a:4a8e:b0:50f:ade2:2da with SMTP id
 d75a77b69052e-51461fcdddamr103694241cf.44.1778149456962; 
 Thu, 07 May 2026 03:24:16 -0700 (PDT)
X-Received: by 2002:a05:622a:4a8e:b0:50f:ade2:2da with SMTP id
 d75a77b69052e-51461fcdddamr103690731cf.44.1778149455632; 
 Thu, 07 May 2026 03:24:15 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3939a58fa47sm37503021fa.37.2026.05.07.03.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 03:24:13 -0700 (PDT)
Date: Thu, 7 May 2026 13:24:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: x@2005.tr
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/rockchip: Open-code drm_simple_encoder_init()
Message-ID: <g7p4goe3fhnfxgp2tsopvvgbqmvvkktji25h4rsrbkavxac2es@ghc5v7xjw64e>
References: <20260506165346.19819-1-x@2005.tr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506165346.19819-1-x@2005.tr>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEwMyBTYWx0ZWRfX6wCPjUDwmWhY
 aBO6kuIV8CF/mxybqu8/rfavqC//+q1rqgzr7d9qyyKChyoxO1lSHrpx1uxubAfRMcD2hNgC48E
 lE4aQmsUeXFtjWbHjlHpHa7sJ3ROOgToqGO6d+5EKlOL+ySOc64Lw6JQuS9ZZMd2j2eHGwhxHIy
 M15uY6HxOT5pUip0aO2ycrloLPqogWk8sh0polD7u+JkgBNVp9HRCXIXRPe0LesesY2nhPTCQR0
 3aIXQyF9doayJp3/SW+ff3FayopK0CYUO16dE6bAJbNl1qeXjfvZ1mKM2BzgdvHJtldro7vOxff
 ag64m3k9tM+y9Lko9a+eVewDDZ0avSIGeusQNpFenleD/vEtAhmb1T96b2ls0/Fr8lzKOGavIg4
 qz2IWxbatRKWjAEXzGUnExQrwy93oNkbuiU+WgXEzzy1DyVW/39MHNd126EofTvZCf13budLvKO
 N74DoJh3Rc22TBshr0A==
X-Proofpoint-ORIG-GUID: YTp7C-7F7rpiZny1ttULY3Q3gKgDo86f
X-Proofpoint-GUID: YTp7C-7F7rpiZny1ttULY3Q3gKgDo86f
X-Authority-Analysis: v=2.4 cv=ReWgzVtv c=1 sm=1 tr=0 ts=69fc6852 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=K37GZDC8KpGTtN--OQ8A:9 a=CjuIK1q_8ugA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070103
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

On Wed, May 06, 2026 at 07:53:45PM +0300, x@2005.tr wrote:
> From: Favilances Noir <favilances@proton.me>
> 
> drm_simple_encoder_init() wraps drm_encoder_init().
> 
> It uses drm_encoder_cleanup() as the encoder destroy callback.
> 
> Add driver-local drm_encoder_funcs and call drm_encoder_init() directly.
> 
> This is a TODO cleanup towards removing drm_simple_encoder_init().
> 
> No functional change intended.
> 
> Signed-off-by: Favilances Noir <favilances@proton.me>
> ---
>  drivers/gpu/drm/rockchip/rockchip_rgb.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
