Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAC6DC9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 12:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B11EA10EDE1;
	Wed, 23 Sep 2026 12:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="fkikkWFk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N4x2E7LY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D7B810EB46
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:12:45 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NBbTEn2466545
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=IWCAXdbt9MLQNW2dNVZ65g2U
 h0XJcuHhkEaIaIxj6KQ=; b=fkikkWFkCfrIuMPYgFh2PBG0gzBE2HOtEcoC+PGJ
 Xz45tVKP/N79jRR1xwzXlaTVy+NjjBRoi6zcCwBya66nbyDkVMwv5SN8+45qUZJN
 1Q+XNHr7fp4qZW1SkUrkLH//xHydwBGioJUfZvfMWi5z+ORSJy8l2o25GfD8rxHJ
 nRFkTwG5NtgqtBEaPiZAleicFL4PcZ6ApOMYnalbs16cQJSTamBJ4pge5iUiSvMd
 ls+Iubb5WH8MjbqIXKLP/XJZSWW2Y7SyhxxDpqYDsFHjQSrDVnr7BVaIaMtUmCW7
 mGNz+gNavws8fXLmW6d68KXgAmsiPT8Ixnzt670lOuU8uw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4guy2c3wtr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 12:12:44 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5c93c294214so367979e0c.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790165563; x=1790770363;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IWCAXdbt9MLQNW2dNVZ65g2Uh0XJcuHhkEaIaIxj6KQ=;
 b=N4x2E7LYCFDOo7tXdjDK/mpcN6YuYffLM2YeDXiABzS9UoQRc9dLic0kHm/nUS0rfs
 PVVFe+x2g4Ou+qYHjs0sTzaC6CNh05OeEOy7dePLrTjPDqTX3f+A/3fbQDtNrvpirwCp
 EcvlA9WYp8SVYh2k+5NS5Qp854LpiIt7Ln0zVxE+osAKhNGBY8tUBpMGPChJlxJMgvDA
 fKQCYnFGJEGVCt1e4s+Kk87qMn/NduKZAt+fADUaJVS+2JC7WEpTVu1ekTjjV26XTtba
 rSUlqvpVg92UNjLxZfOQpYSeMvlMad5bgcc3L1ZdSbYfcI3XRY7OLBMce4c6ltHO7btj
 VFtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790165563; x=1790770363;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IWCAXdbt9MLQNW2dNVZ65g2Uh0XJcuHhkEaIaIxj6KQ=;
 b=GXJLlE7bGzoGRBtr6zA3AoYYtN6J2A0dj5OKXBvZKH4tJOW9Ytz7Jk2nSfZaerrC1z
 lMJpHENb3uCJSLljk6Jw2mrFXDWv/R0sMXCYT1mIQw0e2VkYASywsf3DU0yx6DAjN6pv
 rlP3yDTzyspegCbDsTD4+D7JeVvf6DHXs1ABtazDxZ3WlIn3PHWh1LpNkGw3Cyxybex+
 dH8AEVy9mILpstDZzt4OOxso4Xw0pxSWD0pt3uutxGFVOoqY5J3Jy7/uie/1qCT/VfKQ
 Dk/0mX/+1WiYlHzDh1SSnLWLv6nZAAT4aQCLj/Gi53IhUDvwB3mnUJfA2yx/NXKYlSfD
 4QkA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz1FVOPr4nTajlWGniSdgMBP7TNaZ+0UIpsjUEEM4kiN9fd5ZkgAq27pAxFgPM1BE0WnhahVnb5XFs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m8TxDI9tiKWmo26kruIa7aCLBTOv5JtJDEnU3+6TlmZcIqAUe/
 EHi56qwkM2CKsEp5DEaoq+pimFdyvBaZ4CFhUDXKy5DFOD+TUpnzxXD4FG2Y3zI0ewBLn4CKQ31
 UBLqXPu30Y5Htu4qQzPDvpLCBcZil5YxFjjCVPUKll5HaDY2OPuRihL8o4BOuUpcWKNN8EE4=
X-Gm-Gg: AYBFou0LMchhYPp/418bM6UyUD+u7C/CQLByVYo1W3PaaKY1P3DF1Y2LiWs197zqF2m
 sy6s7ZKgEpqhW5ufQAK5Jy3GIghczpgd9NanSASHgG+lgSbw/rMcYxtPGUsEBbtr6KsHMnwF+z4
 UzvOmxP7kjKjyVUF0fVkgofQG5ysczUOum2sMiJa6Z/rkdisJD9V9hdrVjC+MQXdp5qI/R/5hJs
 oXXXICVqc8wq6QNst6/+G/InY+xZnyZAZTd7ueTk3a2G0BUaWtL5hCqFcZu5YSx+rrrspk7rB8r
 csiM+5dlLAlET69mhcIQJTZXjPjy/v69qOEFYvczoeYskQw428TlvQlootEzfKF74m+8aJRJ6YK
 TD0fdR5e3Uwz/t906xxOuVKgsElm2OmY4uqi4C4+HNWmHm6Fk0HY18NFcQIrOfzcBT6FgdqJw0u
 G9NHcyjPhu+L/A
X-Received: by 2002:a05:6102:3711:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-7ac1bb45468mr2060907137.12.1790165563572; 
 Wed, 23 Sep 2026 05:12:43 -0700 (PDT)
X-Received: by 2002:a05:6102:3711:b0:785:c643:a415 with SMTP id
 ada2fe7eead31-7ac1bb45468mr2060883137.12.1790165563151; 
 Wed, 23 Sep 2026 05:12:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b8d857877fsm547327e87.28.2026.09.23.05.12.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 05:12:40 -0700 (PDT)
Date: Wed, 23 Sep 2026 15:12:38 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 03/15] drm/msm/a6xx: Fix RPMH dependency votes
Message-ID: <tdjlbzqqpjmpdpkwylsxz5z62zaxceaqnmmi5rqishdnefcfed@qqxd4b5e7ift>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
 <20260923-hawi-gpu-v1-3-0c3c79a1a470@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-hawi-gpu-v1-3-0c3c79a1a470@oss.qualcomm.com>
X-Proofpoint-GUID: EpV5V_JRdN4AuyHJA7LjgMFoIYRbJaWT
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfX/txt1VUGJyxF
 E1l41TSoMBTiABkhirT35RoiKZZash0VMn59miAHumhB3spKtQL+KSqXofbXcd72uOjOISOjGXi
 mtTilrndg4JRN48mRe9gCnDTS6KCsS4=
X-Authority-Analysis: v=2.4 cv=Zsh4uN7G c=1 sm=1 tr=0 ts=6ab3c23c cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=6T55iVGf85rzv7ZivO8A:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-ORIG-GUID: EpV5V_JRdN4AuyHJA7LjgMFoIYRbJaWT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0OCBTYWx0ZWRfXynMEdb9ykNrb
 xT2Vx8ibMvUI0P9vGTMbyiThFcpZ6iNW1NcLKqWLTu2e+Sa5ciGGf+mx2vQa4jkYnJcChhe2AuZ
 NCtsHeh0OoQC0oBgOX2pvvgRpzcVZnSK83Jmf73MvVYUsGwI8a0ySoNBC6CaRXOO2th+Skc7Thb
 hqWDKi6FIS+up5DTEk4IYFdaBRE16pPIuGSEiVWt7Iqy9wdDv/Hxgnq8pPXpFuiJIg5X4Jeege9
 JqaUhV0TsXE4REYv6DnLoecohE5XH/H5hS30jPFudEzdL4Tez5VxHKGs4LPlCybcLFTh3qF9OZl
 cTb6h1q9StURvRodhGW337B3C6EvLzI5+ArmTg3uv3F5kUZqvZZHXx86+h+GyH0RB0YToRTbwOl
 sETX1+ibjl/RDDNNymN/36zAcCYKbSNIsrlcczgb1y0D7X2qdgv0fclba3qhKNefoTQ/w3RUVO2
 OMN/3y4KNe0MYkDde6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230048
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

On Wed, Sep 23, 2026 at 03:55:43PM +0530, Akhil P Oommen wrote:
> a6xx_gmu_rpmh_dep_votes_init() iterates the GPU frequency list
> (gmu->gpu_freqs) but was passed gmu->dev to resolve each frequency to an
> arc level. This results in generation of incorrect dependency votes
> table. To fix this, pass gpu->pdev->dev, which owns the GPU OPP table.
> 
> Also, reorder the dependency vote init to improve clarity.
> 
> Fixes: 06cfbca0e1c6 ("drm/msm/a6xx: Share dependency vote table with GMU")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
