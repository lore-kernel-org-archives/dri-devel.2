Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD41FCA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D4810FF82;
	Fri,  9 Oct 2026 08:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZwbGWNR6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XaTad+CH";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B21BC10FF82
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 08:29:17 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KNPw1223225
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 08:29:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=lXGhk/a8780ZR6oMz9Rsju0v
 1tiLizXrFKOLc8mUmHM=; b=ZwbGWNR6D867cmEY0fujoxLXXXMdO9GZAdrDv8/+
 e0SNERucHwLT383fDLSthPXNF1KAzFyvNhpQJhUBAHsaS1eGMckECBE7r894XQQk
 Hf8rFodpCNW3gHgJDjdoNX1LSzr3ij1M30w0HEd85UsXcuScuTVqri5o+TBEZumM
 9PtTghEn+2LgCbzKbix7XtgLs3CLFmBWNbsGZfOHxaRcTJghYulP70xg88KJRKQg
 riZl51lXyfJoHW12Jk9lZkgES4oFXNX2aq5hxnlCE/3hCvN7N15IEZlNVSAWJNH4
 Xci8lMxRItpQyQ+eog1RXbPullYLbdbfnT93pQ2GRngLww==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxkake5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 08:29:16 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93caf7856ffso1150362985a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 01:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791534555; x=1792139355;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lXGhk/a8780ZR6oMz9Rsju0v1tiLizXrFKOLc8mUmHM=;
 b=XaTad+CHGPbrehgwxrXbZemgQhlD4Aokf+A6w37TZhFob7wt4/hOnzw7N08YoL27Hz
 fab9g1ozWzd5lDsEI6aJ+nph401RqRZMzYxwEiLDFjYgvZcCrrwgQ8/GOKNlIuLq/3gc
 abZJr2p43qOjd9RopLWJOqWSVhGU8ii54zEJCz9okvVIxegDdKWGAY0wEqOzYxfyR1e8
 /V5kl3E/QQ3TBT7fILzi4P0+c8Bk4wGG7JnI2MIIx+dizOiMEbqRRUSzk6Pr/65EFsfF
 1Cg1F0ydriTQrSwZBiajy44krwdF6ap9m13eTLkOYoYShKr9/ycVb/Zxz9bRgMq7DTus
 JwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791534555; x=1792139355;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lXGhk/a8780ZR6oMz9Rsju0v1tiLizXrFKOLc8mUmHM=;
 b=r64XmxR9MS8TAur/nCsRqvfLHJU0bVE3gwHVD/lq5sxgww0Uk4zKGurmiwOwrWw+Ny
 9SYnMbl7NaK8fvifBeJSf5zSD2H78tD1rugXBuUNic8HKlQ89cHXCGYrPoe10SXBSdd5
 gqWgwz1S3JBKAD/tWmQwYg792iDyFfV4T1QdsbZ05jMw7dBI/7eGhEF6C55HN97H32L/
 LlUUs0bA5zbjSCjAq4g4AgNnUBfO+FlSWekhRxcb/rryOTstLh+NgCSynrhH2DqUZ/zm
 vLoqKHUr5ZOp/1RgcaIAR3tUBPYmnXNa0CSSa8b6EiTgJlkYoKK79J4jH1YYYw2x0Ft8
 C0iQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzf+GgDiEjVo36O1JuUHLoQvnnXz36dG3UEziITi0ZqtQJe8Y13J70ai4Z/V0/8qiLEbvDi7EczPlg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kMS1+DuLQsHQ6gZrDVs8bOIxBVA19AHXQUhE7itRtDNiXC17UG
 bwNCaZT6kTaR+4sXqBqgD+lrfVf6NCeQiu+sZjTCIbv4ZJmMjDFjCK8RNKqVTxXMvGsh98X95hM
 zzpmGeR9L7FU88JUbZxwEk6z0I80oRjHOBWkNJ1O6NZkGlVK98LcUmAVT2xHSX+JotbxA+WM=
X-Gm-Gg: AYBFou0VVwIaAG7xkxQkKmTi2RI8vvYMK/2r3pOEoNQ1tYTj9EmwQW6s2bCBSrELPnb
 cCt1tfruKLQlDq90Sl1Rim8Gu4frFyumhEKTWWnefLfxzGHflAWGtcvlyrdUD0xo+onUb7THXOt
 muiMmKkpz2cehOattqz2UHFW5rK/DognGe2jZ7kjdqf9Tr4PnUYj7nGcKY4OPGBzzGbWhzCqOCY
 E3EiSp354MdnpTvx633W2u9nASjEggctpmvPeVwY8BOs+5GHds9HNLWb67kwVlx7jk/E2QH3U9U
 Rbhgo9oKkC+0Tgpu1hFVjHm/tCDtXVsOz+dv5N4veufFOOFs3VgEi6TOmy0lVOM5XiHgUTSsio1
 BI5TC0GIwJ/HSA80X3x7sX3WLFbY6fuIxNzuu2J39CdEjMS5nVZeQoq1wZNqClRD1DLPwFt9LVF
 lScj0Ys7LyK7jr
X-Received: by 2002:a05:620a:2985:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-93ebd228f3dmr162551485a.19.1791534554740; 
 Fri, 09 Oct 2026 01:29:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2985:b0:93c:9d56:a860 with SMTP id
 af79cd13be357-93ebd228f3dmr162546085a.19.1791534554149; 
 Fri, 09 Oct 2026 01:29:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde9bde3sm435232e87.42.2026.10.09.01.29.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:29:12 -0700 (PDT)
Date: Fri, 9 Oct 2026 11:29:11 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Kuogee Hsieh <quic_khsieh@quicinc.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
 Mahadevan P <mahadevan.p@oss.qualcomm.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] drm/msm/dp: Add DisplayPort controller for Kaanapali
Message-ID: <ayqjh5syjbnayfu7wp647tclaer6vd3jbtfuoj32tlpqjyhfal@2uh543ydchm3>
References: <20261005-kaanapali_dp-v1-0-6faeac3a6d59@oss.qualcomm.com>
 <20261005-kaanapali_dp-v1-2-6faeac3a6d59@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-kaanapali_dp-v1-2-6faeac3a6d59@oss.qualcomm.com>
X-Proofpoint-GUID: CVTal6wnCLbrbwK77sASaRl5PPwUo922
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfX0/niA+dvEU3c
 +YU4BCR0pL0XIQLxFsDstHbTKJwJTKZDZAHRmmTR5X4dj89tWcF/RpB8OLkY8hB9u/2rY9ybTya
 WiKAZzHTWLGVnkDPTSj4WP5OD8JaOT4=
X-Authority-Analysis: v=2.4 cv=Cs0q4X4D c=1 sm=1 tr=0 ts=6ac8a5dc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=OHVtJ8ySOF6wsxM0GN0A:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAzMiBTYWx0ZWRfXwBPnT0QAndGj
 sjLTQC8TYQ1ZnVbBujaO6qKSHqFrWM7DaETRdZPUEVdiRjOcLT3deiSZHpY3zczqZKUiRIygtLV
 n6MInxQL6equ46kLxKrbYS/aZhHCqNzEVTYgjGemQMsvXnMDLh7yJmYXPekmfTzmjRwvYX0Q73G
 SMS7T/Xq1G0nOdaV7rU4cx57e5D7/DEj+Aq/V9b94lTesXYM/3lX9pEETq/wd7xvhs5wxJkOQMu
 WD0gQywtXQS+nfiztDwLkIJiD7ZwsoFs3HnTzCi7byUkjYK2CcWDCZarV8kswRjRGAl6Rq4H5Nr
 Dc3qt90fBhzVBKfcfUwFhklQ4+ec5l09ayvDTAbouYnvLSdzj4cAp3A2PdfWkrnSKAFQ8LPL+F/
 MTo6ph6YHTZdjfSE726yKTidCmhb43iYmCWUPG+TGBnHmxkRbrRh5p8EVAB+0HBFtW5rGImH6Mb
 qEu2MDfiIaeggMxX9tQ==
X-Proofpoint-ORIG-GUID: CVTal6wnCLbrbwK77sASaRl5PPwUo922
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090032
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

On Mon, Oct 05, 2026 at 12:54:27PM +0530, Balaji Kalkonda wrote:
> The Qualcomm Kaanapali platform comes with a DisplayPort controller
> with a different base offset than the previous SM8650 SoC, add support
> for this in the DisplayPort driver.
> 
> Signed-off-by: Balaji Kalkonda <balaji.kalkonda@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
