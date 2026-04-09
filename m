Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78132F364B6
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:02:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C68C110E0B4;
	Thu,  9 Apr 2026 21:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iwt83TLd";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zwh7mUrI";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29B4F10E0B4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:02:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639KORfI729232
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:02:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fy24ThaE7zxCmOTOVBB95xQI
 Swb2qBaf1w/hIxxQ6/A=; b=iwt83TLdksEzI97LSyWc2oo6OTCnetVF+TBZtYiw
 jVvR93rQ0vMOjI9AGB43I1+Z3MGaVKHQYJUcZtCZqTVo/msgQFETyPAZX7TmH5lP
 Er7k8jHnbsNkbtFBIu0Bgw9oaNxRBDsuYIdIpXeBbsrwTQVqSDNe4wmGkL8Osx90
 32VlGgSVpKG0UmeHh5TgbJx0etVjXLB0VhbY7KIvrSqkcHv7uR9Nuvpuxgvc+/6x
 qIpPaf8zT4TNVfSO7dpdO+FYiF3Pa89SwQWrkYQaWb+0/dujQoFTymbuiXbHzp26
 jgNmLP0WYZRPyl6YuD5rT2Ob8d92OA/BnC1ECwM/vs9AYQ==
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com
 [209.85.161.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dek4c83ag-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:02:42 +0000 (GMT)
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-68a2fa3375eso1550473eaf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775768562; x=1776373362;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fy24ThaE7zxCmOTOVBB95xQISwb2qBaf1w/hIxxQ6/A=;
 b=Zwh7mUrI510ZOe5SJYPgchLnhgWo7CKll27HHoj9FFsyzGjPjvT8cQ4nrVSXnHCaQx
 ktEGpamRXGIJj20dXpybXByX6SiDRnrNS5D+MFCoEGWWmPQqJqzd+WaMwbXS1L+kPkM+
 2NUAOxi+/SWg0UNKs+/b0WuLqjEkd4zbLFgPZ2fJmJpr/LXKecz5pr9t/55OsBTj6b5Q
 EuzPalyrWzuTJnrQp5/QvEaYt/3223xbfQmOht4ee6Au/3LwS4DMZCWMECBoxfx6DDyF
 fTfKOfBsX6V/4fEygAmbUL2VO/+hcjd1yx7NaxNeDjid4w92xpbAPcg2DmK4+fkpVcYH
 f3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775768562; x=1776373362;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fy24ThaE7zxCmOTOVBB95xQISwb2qBaf1w/hIxxQ6/A=;
 b=X/KHfJEeBfhBCbwve3Yuako7L8oSSXmjiDDy9+nLa9saUuVdby8sauFCWKpSALcqLI
 4zY3uURB99mn8M5CHBu5NXPVLNmqU/2FiiOK2KJ0rN9bG3TWFytJLiUI3/8aFjFvhrGq
 sFTe6N7uzNIrnL7Q8+DENAPEFgY2upX8TGyHH91/P5eqWuSBCWQAujq+G5LqBuKuhJbt
 bYZ+rtGs9TeVejDJw8tfumM+38mIreGFDzr4S2IQUVz+jn3eODvixgj6zdAXAflRr2Q0
 UNsSwTtLMlm/mN9fCjLDQY+fdUnk5U5gv1tAKEcNgUl53O+RUs49grP/GHtmmMiD5Xp3
 gqVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBnKkdwH1bywQ3Nh2HLuKbkXc2teRvYCImIIc7R93cetBDOvi5psb4SzgOkjAL5ExTFcaciL07uzY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwP8WkjiM03Ktb9qWEn1IA4PcPOgo1Fz4hJxiEDasE3XAiKcp5N
 Z6n45bq+c3EV/oPD6TGX41Ry0bZr2nPKQmkjpry8vd7HLFnpHgNww4vpI8VzxWmy+Tvi+C7T6K4
 kod9C/okV3gqVhrRfP8vaLGmDoYTS33Oedp8eLR8Tq1XvYx0dfxOoT1fU0xY449bmf1ctSGY=
X-Gm-Gg: AeBDietYex6cy82/+Pvv72K9nRNLfsZ4pnoWUn6DHsZmtwpV1Sdw6C83gF3uEZJV97B
 qqlxkOY40ZfHFSdzVYxSWa+zaKwa4+ctthgbHDfYD/P5WvL4OORFhVGfsmc7x7VwgYTjNKn4xfa
 uAr5DNP7wdeS52o3bw/Er8mnovvwvl3Ll+bt5ej6v3jFRBYPFD7J5k18kYPrXSI3kq8SGa7Vbju
 Ln5hhwJEeD/6METrSTs7Y673a2t97bul0mOCAGMZNrvGMfTBinTIR/8uCNVTcNSRPeJdX/aWldo
 sUlEbcT1xrKa9Ma2ImsnCEdiiIZYaONrgW85qz2yiXxlPSu01HEoLsb8HYpMenACb2503fsXO5A
 awQ9vmWK1s1zpfDrjV7M2XFHE4cItxrNBjObnjUJLYxvvm9zHyObGEEPP5XsOCBEX8QIkEm0WEH
 qIgNKmUQebsD9Ne2/vUOjZqRqAO3hwA9xDuLw=
X-Received: by 2002:a05:6820:678d:b0:68a:3b31:1bfa with SMTP id
 006d021491bc7-68a68d5fb3bmr2094613eaf.13.1775768561809; 
 Thu, 09 Apr 2026 14:02:41 -0700 (PDT)
X-Received: by 2002:a05:6820:678d:b0:68a:3b31:1bfa with SMTP id
 006d021491bc7-68a68d5fb3bmr2094597eaf.13.1775768561356; 
 Thu, 09 Apr 2026 14:02:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a3eee93264sm160532e87.29.2026.04.09.14.02.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 14:02:40 -0700 (PDT)
Date: Fri, 10 Apr 2026 00:02:38 +0300
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
Subject: Re: [PATCH v13 10/17] drm/bridge: analogix_dp: Pass struct
 drm_atomic_state* for analogix_dp_bridge_mode_set()
Message-ID: <cvm3mvyh5ggs2fsjmikzn6z4kf7vsgxcxl3qusyxnv6jmtt3sa@fof7vydwsvff>
References: <20260409065301.446670-1-damon.ding@rock-chips.com>
 <20260409065301.446670-11-damon.ding@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409065301.446670-11-damon.ding@rock-chips.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE5NCBTYWx0ZWRfX7tDt+MKCrnGt
 kZktANqUENU+tsu+fka7VGsIU1ugsUQrwEprDQsFONLUmXb4tqgpKy2NJgxh63eSm5m1o9gxSav
 pqbz1MZdnMSR0GIDHwwz+A54WWxctaa48LOVA8Hb5EiSKNxk3dZV88pS83AL6nai8wrS7yA74Bl
 MzGF+xy9PGr7MHAs5lUw4K9Ih+uvbyqgjk2PEz1tLmrFfZDlV95IFO02sXLWAYMDIWv1vnaQhJS
 1gnS4DnfmmL7Vx9Hdxxt6YGy+ry3nNgLQHYAATEtbOcaW+2XARkCHu+/R34C5VfHbx5mIwCU2It
 l31MYHRodGH/B8ECmpNKRT2J95ohAk0eg7JSZAG2TOJ1ufttIgLK7dCtG1pzf+LhYp5rVgCiILb
 aIIDvcJVcCg170pevTD7ih4tZAn824GfxUC7FqXy54khzow2uCnPzoSOP5j5i6w8BeLt3GX3t3D
 sTRvwUTHw7SWTrYwuxA==
X-Proofpoint-ORIG-GUID: 4GTg1a31mNgVWWRqOktXLiAdMALR0Bu4
X-Authority-Analysis: v=2.4 cv=fZmdDUQF c=1 sm=1 tr=0 ts=69d813f2 cx=c_pps
 a=V4L7fE8DliODT/OoDI2WOg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=s8YR1HE3AAAA:8
 a=EUspDBNiAAAA:8 a=pclm5J9ib1Ufy00r_ZoA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=WZGXeFmKUf7gPmL3hEjn:22 a=jGH_LyMDp9YhSvY-UuyI:22
X-Proofpoint-GUID: 4GTg1a31mNgVWWRqOktXLiAdMALR0Bu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0
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

On Thu, Apr 09, 2026 at 02:52:54PM +0800, Damon Ding wrote:
> To avoid using &analogix_dp_device.connector for compatibility
> with the bridge connector framework, get &drm_connector from
> &drm_atomic_state instead.
> 
> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
