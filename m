Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC34CC88E64
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 00:43:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FD8410EA9A;
	Mon, 14 Sep 2026 00:43:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bgQfIVCC";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jftz9pRp";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF48410E19C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:43:26 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68E06dXH3348995
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Lj9pFcVapk0XSSP7vk2Ibgx2
 B2uTAyJseO6HX7OHZTQ=; b=bgQfIVCCMV3iD6UZqTIHicnGFEy/PC9xmmStr4hW
 iyC32DhH9LgnCniqdkSEuCp+18iX2NujkqzB1cYtn95L8LVUk38FeprgNUjoEObo
 F1txYgUXb12oxATaUNxoV7SsKqhQbgyAqLs1qnT1eg2kzJEIYOFCvXccLkNm/YRd
 aC3vPCNpJiZbmz1REOfDqdv6wJ42UIKuVkkfm7QFOBiWNYEJThgAh3RD3xHMQdzC
 6Bbuf/rwqlQTj5DOZn+sS4Bt1FFCprFi7kiLdLEx0DvAjUEGldr9FSevg0hvgOpa
 ceQrTpifSKXCoMijz+EzO9JZOtJZtsFbE/l5hG2JPdZYmw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gp3hsr9jr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 00:43:25 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97cb32961e3so2001820241.2
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789346605; x=1789951405;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Lj9pFcVapk0XSSP7vk2Ibgx2B2uTAyJseO6HX7OHZTQ=;
 b=jftz9pRpUFzquejEoR+yqpZQuUBHHNdBkUGpwf7RMEVR0RCJW33QF7BT+vfgusJyI5
 Ubw7arM9a1nDOWWSHbMxQJNfhRexfUBd6A7fAj4pFTUEswZu9CcDlpdrb0Pv4PciOf0/
 Coza2rEUEXR/CpLaJZOXzsej6b+apaV8bMg7AmplLnl/yt0X/PToSFwTL2QxapMA42tJ
 pi1WO5UwJvF38pEn745tm+dit/Gut8pQUWygDS8a16hQKMpzty7GFHwHDhzImRwFEL+L
 vg8KyUjM2GKmYHUust2NiHL55yUNFCpsWlK5NJxTXuAM67uTbpJVIlL+UDkeh9/QtZkZ
 pIJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789346605; x=1789951405;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Lj9pFcVapk0XSSP7vk2Ibgx2B2uTAyJseO6HX7OHZTQ=;
 b=rFAp17CsKWYuxIxkFo9YqwDj75+wvH6STV8Gvb5aH33PJB4IxGOx9uxsMSiRmpWL3v
 DR+p9mqjJ9W9OumguOkajXMaNuGVYS4zk5sXqeC99IRRg5edxSom0E9Mgwr6BmDuaejZ
 aNdd+eV22IAYt6oX/GZBNjE3GHa5/ZURRZc8PEzyZVj2j3y8uNyLXT46t4H7kE2+WMoL
 PTKQFh1n4FZ31/t0o3Hx+trUZB+KdrNO+R8gYrYyhA0Z4k18l5AVmdGGSqZzZxGivZnu
 Z8MkyGCdL9Be1aBJWrYlIKJEhsxO5X2gvnDMyga4ySeFJDoBDT0cV/4MpPf3qhcDgVN7
 eKWA==
X-Forwarded-Encrypted: i=1;
 AKwUvBycGhiszo6W9hNJnz3ZTb5p8g874zf7aH0sswSLIVFR3ZiLjEY3RoC08hbue+NTVWlGdQzbrBkJZxE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mlqlqfM83ySzX5jmrmqk6s6OgXhRKyHrmqKEvAVkinBtycPrND
 ai0ogYty2l3GiaWXUDrUbK82ItCCsQvwWYJ6Q4Ycf8d6l7aqCOkoBnJYLGuwBeHaVncRn5Rex+v
 Kr9fOZm45j+FJ9EzHtPnw7KmzEyiDsXRPjHED6dyNlwFhwuDVftPTQelG8RZ/0MUo1vgqPak=
X-Gm-Gg: AYBFou3k8NRzCxTZBDD2b22vYX2GpO4xNnV0Jg/IjaAut6WYwYnl52a2xHLr9PFGm2A
 mYik7z0URaPo3yFtDqWmwgtm3NHau/3VcxH9OmuaLAuxUV5VPYjKixAgmnetC+JpXgLNPEkMDxN
 KGcyYoEefOH4EfmPQe5Qx96hK7HMR5LRJeuweml4j950XKWdmjDAdYN0UDqfLBCqhD7LJ0D6mhY
 7TVfRk6DcxlPsldPUdy0/hB0YneWIR1POVkiZEs0NyazNyZWnKNSYKoCLbtvPFbClAmv4zv1TBI
 VQMVNEzCq1YVt5flqADUYzhZ2yqREHQFYdF6gFJUmshSzQ+TsAVOIMwW3h9MCiVY1QF/jf87Bse
 shhw7OWeGkBhEHt8/sQUEEWPikjtSEs9/k+TTbVOoO4g4vvLIaqCpJxFdUgevTZt4FZUIaJqEQx
 g/AqA2gn181Jbs
X-Received: by 2002:a05:6102:a48:b0:79a:1d27:a8ac with SMTP id
 ada2fe7eead31-79b5878ad50mr144552137.5.1789346604721; 
 Sun, 13 Sep 2026 17:43:24 -0700 (PDT)
X-Received: by 2002:a05:6102:a48:b0:79a:1d27:a8ac with SMTP id
 ada2fe7eead31-79b5878ad50mr144521137.5.1789346604268; 
 Sun, 13 Sep 2026 17:43:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a5a3303fc9sm23868501fa.6.2026.09.13.17.43.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 17:43:23 -0700 (PDT)
Date: Mon, 14 Sep 2026 03:43:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Archit Taneja <architt@codeaurora.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 2/7] drm/msm/hdmi: Handle msm_hdmi_power_on() errors
 during .atomic_pre_enable()
Message-ID: <udst66v6mxlbugyqehsrluvf3nvuw34plt7fzj75wwzrwgev6m@wzyiuexzeu4o>
References: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-0-87bdb9f1987f@oss.qualcomm.com>
 <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911-drm-msm-hdmi-fixes-before-eliza-v4-2-87bdb9f1987f@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDAwNiBTYWx0ZWRfXx0SaCU/2V3qk
 PP60Bmzht5QgTmww0rRxAC1ml7BG2vit8k0W5bOFWmxNKvueXik/LNOzmgbEoAnpRktGeZzKKod
 PsJysX0IJeRlr6jd9659KJkSO7gGj6IlBoTpc2FxFWKGK/LHpWyNqZGYed5ZZFWRFii96+5jbub
 n1aQuu3ZxiwVaAoauOK8HSvSccFPTO8zlpMTIeDXWInF478wZ8k3+2u2HEU9hSFqvIHlRsRPSbB
 ClZVet5EF5cuE/jxtBgY8AbWKDukWrB9KxTouzmZmfHgTteAAzZK6jvbkXlsbFU+nLX8PO3ERO4
 hJ91oqEedQnwDvpYxdz5yeqcRS+SImYxzrEnG2JQN0n++r1XQua5boRx73q4sdxwaJQJSBb7KVd
 WXbwO+6ApcvOIMEGaO6cuE5Q0pYYZlq7cT0WHhjIX07qkmWRUDSNksD6iD51VEYIKoOQzFQth3E
 6KOCM0reKL4GA1fBc2A==
X-Authority-Analysis: v=2.4 cv=IZwSymqa c=1 sm=1 tr=0 ts=6aa7432d cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=yaZh0le1K7A__2Wy8xAA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: bNDRXv16Op-fpBJVL3jrpUIpjRhg7HmW
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDAwNiBTYWx0ZWRfX2fccBZh7k4N7
 FG+piGDB2LSbGhNfqC6vyLbblhrJNUagx9cFOM6I4OEJ8B0ZSm2ZxuFvPytrtFK6utNmPrYXBrl
 YxW8nw2Cjhe8aYphIOS5QOsJgxXWW8I=
X-Proofpoint-ORIG-GUID: bNDRXv16Op-fpBJVL3jrpUIpjRhg7HmW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-13_08,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140006
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

On Fri, Sep 11, 2026 at 12:29:35PM +0200, Krzysztof Kozlowski wrote:
> Properly handle power up failures during .atomic_pre_enable() by
> aborting the .atomic_pre_enable() to avoid accessing registers why
> blocks did not bring up.  Otherwise this could lead to imprecise aborts
> when accessing MMIO while entire power domain is off.
> 
> Cc: <stable@vger.kernel.org>
> Fixes: ba3d7bf3a7ab ("drm/msm/hdmi: Convert PHY files according to new design")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi_bridge.c | 30 +++++++++++++++++++++---------
>  1 file changed, 21 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
