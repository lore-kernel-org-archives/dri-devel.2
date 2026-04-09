Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09755F364BD
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:06:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7F110E0A8;
	Thu,  9 Apr 2026 21:06:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BIWL5Rqq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QQqFa0kM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3569610E0A8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:06:34 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639HkUFs2698383
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:06:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BkT2BXpxWHehgHaz7HpCxZpY
 hADGt5iQQLiK/P6Xocs=; b=BIWL5Rqqsj0jnC+EeLvbLFI4/kra1Oj3NiTjbMPp
 /XQeyVBxb1yj1Xik4FOtTE05S4A4Y8Ie772HGVqYNd61VIRj2+D0qMLWU16xVOr6
 SM2jzt68Gq35kUw0JSA5klvDL3s06inD5cmehemAhJy+NTeCO4+x9w/k9DFM7GVO
 2sRadJT/Ay75272QJ8YVCFvUNQnZjK3Mo0EuFRALKPE2QdZetCMfBW3rLcVM6eDl
 9MYmcQAnR4te0uifG3MWVMAHfVb4kTUUdEuDcVYlQ4cZNNOkheYns+TXTwxVubvu
 gCj0kpjPZ6D3EUQfYXRaSw3MpMLftlHDyqgbxpS4EoM0iQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4degt9rk6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:06:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b34223670so60898171cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775768793; x=1776373593;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BkT2BXpxWHehgHaz7HpCxZpYhADGt5iQQLiK/P6Xocs=;
 b=QQqFa0kM7/7FDM+/yKLRM9+2/r1ITPInWblBmd33C+e+co5HsSrLfW5xf+ab/hi0z8
 XLMf070AmVl6lDfcTXG73xBfRJbbkzbZ2O8mJhiOV5L91eqKTFzePYyIvCdeJy1rneMw
 7wdeX73g0ezGfLfrX+GVeDTI2XapSDJHb2vAlOfcXvASHerUlna6jr+qyZz16MvC9AN7
 n9CE8FZc5ti0oHNjMZ/Tk9sh/XsrH+jLvrM+WNJfuGFQwaUhMb3Sy1bUBDtVAEwDqpwr
 sfn6jjHI5+lTXwRqkUp8bTNa2/ivLTk61dbFT1YP9XxXNGiU1IAkUxtGgriwoRPNrL8Y
 eamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775768793; x=1776373593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BkT2BXpxWHehgHaz7HpCxZpYhADGt5iQQLiK/P6Xocs=;
 b=dsLOXGT7qNFRPzHOWTwoiNM70E/tnescjRXtp9s4XA+4jhzdVyS0evG7Z5sw+VdVLF
 g8Xjb+mD3W2FlRKxQM5rHSfQVCMjqxfzyYlkYWlPDitk154QVe8ahAgIafsekBo0K+8Y
 GAws26UYuCW2/TPdg78PC5QmGPTMpvNrXykQSRj9HoqKab7FkHgMWRO/Q0O/eGFdWAT5
 /KC1yz2WceClv1aMe1GsoAD7+yW6QXcKABkBS8IkYfCh+2BBd4wAM6EcCp9mevKeE+kg
 AfD6ZI1IwjtnxobseITkQxOdMJbteUsq00U4uE3Rthkwy6DBs70ghJEHUiJABySh4XiP
 5VLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2eM2hsi3vfTHzqlgCESsxXooVYtDvk1GPKOwJRhY4r49suXqblyc/HYLqti4xIjjXGkR9KvFTLmE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxn0h4U90qCG+ptjToDOG+VKlr8KUoponuf5ZqsAH8H0+X7a1ho
 NvxQ7zB5sPhpPkm4ElLJD6r3ab+wv5i8HMSaXF5br9lSaISiTqFGG81X7UQ8LHP7bV2e1mc9/0o
 frgnKajcfR3ClWYe9c9xI3hE759pSje5qZr4yGV6fuRIS75HeehDQF3SLC7G0CeXE4w1JLgk=
X-Gm-Gg: AeBDieujjFACk8K2AYzsxvG8EE4dAythtr1g3sTMRl7pMsQZ85eKQW5mOXyec1FzlAT
 Wv/YreqpI2DEbMmcURKNPKMV2reVrznoiVXfE9a7lIVAQGiABAUSLQk9laVsS9eOPzoy6Vm/A8c
 Z+/rxZpGHb/9eBvqUNonheh5pzgI48E8Mp1Yq6FJWOYejWSKweWfOYTJCr2vH9F/aBs/44kMfnX
 Y702Ks4p9inNtg1vRWp+H1OYubKfJ6IcfXGfAkGPG2ArrcGpERnll4/LpEgz1BHoDQaqDqx5nct
 9aQeTjPJwl0cVk25Z4lXKfLzSS98Mtw7vJ+32Yy9da1szD/nL0y47JCUpUkVUSapPqX+LFRZAOq
 /wwSfiQiOibYbA6OBRBSSqMwK/ONWFb4R8aqgXlfG6awVZxSuKwVDDhLyFoj3u7yOyulHFFAJ1o
 UpEKkWM+ZddUfLXRZSU/xPyQS9ll9jGhqHax4=
X-Received: by 2002:ac8:5a02:0:b0:50d:8734:ba65 with SMTP id
 d75a77b69052e-50dd5b95bc8mr14103821cf.11.1775768792650; 
 Thu, 09 Apr 2026 14:06:32 -0700 (PDT)
X-Received: by 2002:ac8:5a02:0:b0:50d:8734:ba65 with SMTP id
 d75a77b69052e-50dd5b95bc8mr14102751cf.11.1775768791806; 
 Thu, 09 Apr 2026 14:06:31 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee86641sm161191e87.3.2026.04.09.14.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 14:06:30 -0700 (PDT)
Date: Fri, 10 Apr 2026 00:06:28 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 victor.liu@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org,
 s.hauer@pengutronix.de, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, jingoohan1@gmail.com,
 p.zabel@pengutronix.de, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com, Laurent.pinchart@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, kernel@pengutronix.de,
 festevam@gmail.com, alim.akhtar@samsung.com, luca.ceresoli@bootlin.com,
 nicolas.frattaroli@collabora.com, dianders@chromium.org,
 m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v13 11/17] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
Message-ID: <wmt75edxyrmhyyfxx7xrrhfdjvdu6u24zwwwsd4ryy52ctwm6f@th73j4phtvmm>
References: <20260409065301.446670-1-damon.ding@rock-chips.com>
 <20260409065301.446670-12-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409065301.446670-12-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5NCBTYWx0ZWRfX/k5Z1cKBIVAL
 AgtigqjOHwzeldjX6t9PrX7FxoRgTLBvU5mxSb59wPPv2bA4h2oA5ICj3q44de1ZKdpVZzn1RHb
 rf9GC2CpSwsuxG9JL64X+fZuc6LlNS8sMzGta+IamdLeJj7/CbogFqcBmC27+fMW56/CxkvcfwE
 a2a6Gnsn8ilWmhUfp7iGlO/TCbfwClJsG/kvERG3Y5uwCpJi0GoLrKIfHdmWP9PmwtzTYtmqwr1
 IHMbdZNmsdAaVF/0r3KKnoOJ3dFsgg6LRu3Wubwve/87kQkRen1p8hyIhZCKbQwtBuNftpTtUwd
 jZbKzE7zpSS491PUAZ6w7lLlbITFOB3I239De7oc4Fx9j6HaNTPHjFnWYSlU09ivDNSNRE/JzfT
 DJHol0jahSquxzfraAuZn010TYQhlxni3i7z9stnaloWbnicioHGWoYsxVszkBv0iAcxDIwrHZ3
 P7CwemuhuYQBk9lGyXA==
X-Proofpoint-ORIG-GUID: IYXwj_RhC9dLnhaeUVlw39MrhKsg5-yY
X-Proofpoint-GUID: IYXwj_RhC9dLnhaeUVlw39MrhKsg5-yY
X-Authority-Analysis: v=2.4 cv=BJyDalQG c=1 sm=1 tr=0 ts=69d814d9 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=s8YR1HE3AAAA:8
 a=hD80L64hAAAA:8 a=EUspDBNiAAAA:8 a=yovIxdhcBUqVpsxpVugA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090194
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

On Thu, Apr 09, 2026 at 02:52:55PM +0800, Damon Ding wrote:
> Initialize bridge_connector for both Rockchip and Exynos encoder sides.
> Then, make DRM_BRIDGE_ATTACH_NO_CONNECTOR mandatory for Analogix bridge
> side, as the private &drm_connector is no longer created.
> 
> The previous &drm_connector_funcs and &drm_connector_helper_funcs APIs
> are replaced by the corresponding &drm_bridge_funcs APIs:
> 
> analogix_dp_atomic_check() -> analogix_dp_bridge_atomic_check()
> analogix_dp_detect()       -> analogix_dp_bridge_detect()
> analogix_dp_get_modes()    -> analogix_dp_bridge_get_modes()
>                               analogix_dp_bridge_edid_read()
> 
> Additionally, the compatibilities of Analogix DP bridge based on whether
> the next bridge is a 'panel'. If it is, OP_MODES and OP_DETECT are
> supported; If not (the next bridge is a 'monitor' or a bridge chip),
> OP_EDID and OP_DETECT are supported.
> 
> The devm_drm_bridge_add() is placed in analogix_dp_bind() instead of
> analogix_dp_probe(), because the type of next bridge (the panel, monitor
> or bridge chip) can only be determined after the probe process has fully
> completed.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Heiko Stuebner <heiko@sntech.de> # rk3588
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
