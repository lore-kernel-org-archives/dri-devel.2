Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC3B4FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 00:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B7EC10E40A;
	Tue,  5 May 2026 00:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aDPRA2Wy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NThVLe0B";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8A1710E05C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 00:48:27 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644FOqbU1346361
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 00:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=ZoqdR0XZGmUXKsPgvfPhc9Gc
 8oHeFYnuRnafn7F91g4=; b=aDPRA2WyRiQ2rfgD2tgLPZxXkjUmxioa59YymOB4
 NZL41rXZOyfIi57OANQ4K0g7YnUkG1UIn5agaNUCCfYrDi5JGWUTUvSnpho/Yie4
 QSL/2DkJeFpbbVA8gwn0I1W7nwh0c82aEPdZabeaSP0DNHBYB/ymqWnNpCcUFH2H
 TVHoucXJXImgiRuC+CYOyR0wz3MpXSqLncMijhzMYd3y4RR73eb6a8uaOr9GW2Gc
 3OvBnrenu2CjOP/cOidJbrZN0lK6YinyjW2BYdUx2VUpkEfkQ0fJ8cNOC4hCaQHJ
 vTPsBtQxwpS4c+cs2eupG9UkWw6lHKYXZFvMLXdf80OwDQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxx2x9srd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:48:27 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50e2592ea3bso47563651cf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 17:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777942106; x=1778546906;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZoqdR0XZGmUXKsPgvfPhc9Gc8oHeFYnuRnafn7F91g4=;
 b=NThVLe0BPIjAjx3uM30sJcfY52DIsEwatu7EAa4ujfZdaKO3x7EIT+Ro2p/xHLKlFV
 hIq2QFWztyBOoR/h+fiTeBEMbCxKoIxFvxRe7CxvdEOMD+NFzEDUq2IIQD5zDD17qyZE
 hzYrDaOeRWxKT5neOkt8pEkywJ8b1FOtLc1KEav/hh6ZZLi4/HRCHP81VL4FVnJrThlV
 epnFtvKe6sMU585LGdFtou5qUDInjHizkpQbRQdF4I+ZMYit5WVKvjSZSD/ecIYxYuGK
 jxMNbu5ebDSiU1njEyfCV0C7rLNMnKZuZbD40dbVbl6B2xYv0px3o9X+rmO23W0r0EjR
 k1yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777942106; x=1778546906;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZoqdR0XZGmUXKsPgvfPhc9Gc8oHeFYnuRnafn7F91g4=;
 b=HLJIqr1E7meadcuSvdlg6NEeqVWRBivdY8Lewq7sF08aRqEiXIXJcZHvt5sO1cBvG7
 S6hfou+SlkRXZzt8ZSS2oG9CrwlwCkm8xn454UoR14gQKtsxBPkd/Q+xHMAPnD/3hbC4
 LE1UmxhJd9SFD6fE7qFjWIxti4iVTMb5A6zoGqNrh0T3GIi1KHbErENBw+jWX4btbsz8
 pnAA9ePzb+jyHr0Zuesbqm2t46AbA05XmAfa1Bb32p0sYFRJSUiiFHBDWldG9tyZ2YCF
 /ttG1DXYfE3YBbUeZoLmNRhSF96/FW7RRKREPDCJoMtEbq4KFRJwoDpB8N+9VaGW/fZd
 tgLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gIHu3vR6VlIi7Z2pn/RKIaUAOhW4iSUdzEuckzQ/IiAm9mZbR9sm8/c4/wI/0A8lmU1C78tDDQI0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJy4rnElQ76kiTDJLKaJoZ6TqgO6frrZLldtlsdvWT+O6jLnfP
 4BBPVAaw0S2E52s3vxZHZeTj2Ga2CgrEzNXkD4Kv0ZJTQFfNqCzkPbBQZl2HrWTJ5Zi8CNfyvff
 ML4hL2Hz/TIG6N/CObQ8DxU9aK/nRIwM2lcVsE2l0+YXFP5UtGvArX3OOUFPNqJsx+satkZ96ai
 cRZsU=
X-Gm-Gg: AeBDiesr9+MJut/Em0xefCxHaW5KoDcXsKhyYTzPypyxB0OFfTHiVPLRcgwDTE5Wsiz
 w7Z/13uouRtnKg+QyOr0Yld+EVq+JkWBDPtYAU31YoyQ5NNtS39RFjcSBSvdLV3Vsp/msPGLsB+
 COvtCiDB7iTJKgq1ymkSIlvoOR1Iuy+8Y1ibh8shKaQo/7uA7igAc/kQFsCygctmRWq5iCpb3t7
 9XV+mtpjH+3JXJOf+gV/by+Y01uNJU/AWP9RseP3MNohOoU8kGHTX2suUFVYQbDxZIk1l9jlsmr
 OC6mUXPEOeDhv8NdKBSEEE0ScnOMzSnL/ayXC2xLvRVCZcCgcB7kj4Joa59/fN0tk2HgQGxNwSg
 1nL9tY9ZED1DldbCo5LfoFZq5O6AtiOM0c7N6QqURSsmRzBZ8WfxALdWEUCNmM8FdwF7k5aYSnS
 5/1UnOYMA3OnZrfa+kCZWxrAywCvf75c6rqwF0u9alAJI6rg==
X-Received: by 2002:a05:622a:4d99:b0:50d:83d7:686c with SMTP id
 d75a77b69052e-5104bf98d55mr183328591cf.31.1777942105786; 
 Mon, 04 May 2026 17:48:25 -0700 (PDT)
X-Received: by 2002:a05:622a:4d99:b0:50d:83d7:686c with SMTP id
 d75a77b69052e-5104bf98d55mr183328291cf.31.1777942105309; 
 Mon, 04 May 2026 17:48:25 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8670a37absm2603992e87.55.2026.05.04.17.48.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 17:48:23 -0700 (PDT)
Date: Tue, 5 May 2026 03:48:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: syyang@lontium.com
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 maarten.lankhorst@linux.intel.com, rfoss@kernel.org,
 mripard@kernel.org, Laurent.pinchart@ideasonboard.com,
 tzimmermann@suse.de, jonas@kwiboo.se, jernej.skrabec@gmail.com,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, yangsunyun1993@gmail.com,
 xmzhu@lontium.corp-partner.google.com, xmzhu@lontium.com,
 rlyu@lontium.com, xbpeng@lontium.com
Subject: Re: [PATCH v4 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI
 bridge
Message-ID: <nqcq5h3io7o4jkvyywh2pzfuorj2grk3r5ogifs36obw7vawap@xv4ohryelqc7>
References: <20260430094612.3408174-1-syyang@lontium.com>
 <20260430094612.3408174-3-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430094612.3408174-3-syyang@lontium.com>
X-Authority-Analysis: v=2.4 cv=U9eiy+ru c=1 sm=1 tr=0 ts=69f93e5b cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Kz8-B0t5AAAA:8
 a=EUspDBNiAAAA:8 a=Th18vmrz9VDaD5OkdogA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-ORIG-GUID: aSPseVAoMJPSpXj-yMjieQ34K133J48H
X-Proofpoint-GUID: aSPseVAoMJPSpXj-yMjieQ34K133J48H
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDAwNCBTYWx0ZWRfX53SzB99Jxi8Q
 U+nRyt1x+2XRol8n7HwK/aX6GWXR6PZA6k+BXJvKzp37GEv9jmdX6WXXm1uQd74G/kfytOPsn+a
 3B37fkdwkRIzvlzKiozpAfv0L1884T6onBY5pOdpiO/W0b9u7NAo5rOlk1ajf9sk1BTg1kjT7FG
 4GlxA8kmWZJM3cwDWei1t4B625S+SALBAOnp4X9WSb3IJoMas+0WuNnFmLxIFkGB7nGtzO8H3NB
 ML4sL37TiKCHNGghMmTOQ7MFl1jH+/wxHbyuSCoaZ0+xUMHnssE1vQjqcDvM1dsF0MX/isOw5Pg
 Zp7XxXRUUPIZLQpDeMpquh1VS/hY0/FPmJptRH89atL6OUJaFkzoauegWBZzuVcZr8NLWLaTj/L
 PpN+76qpeQ6iuy8EwKXY/mSOGiRnrG00ZZNEfkOrgnRQNQs8gufPfM0ZJgcxolCR5FNT1Wzn0Ia
 RLdSBuM9XirjE2if9Sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_06,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050004
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

On Thu, Apr 30, 2026 at 05:46:12PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi.

MIPI what? DPI? CSI?

> 
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> ---
>  drivers/gpu/drm/bridge/Kconfig             |  13 +
>  drivers/gpu/drm/bridge/Makefile            |   1 +
>  drivers/gpu/drm/bridge/lontium-lt7911exc.c | 493 +++++++++++++++++++++
>  3 files changed, 507 insertions(+)
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> 
> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
> index c3209b0f4678..8cff2bf15b09 100644
> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -132,6 +132,19 @@ config DRM_ITE_IT6505
>  	help
>  	  ITE IT6505 DisplayPort bridge chip driver.
>  
> +config DRM_LONTIUM_LT7911EXC
> +	tristate "Lontium eDP/MIPI bridge"

MIPI DSI

> +	depends on OF
> +	select CRC32
> +	select FW_LOADER
> +	select DRM_PANEL
> +	select DRM_KMS_HELPER
> +	help
> +	  DRM driver for the Lontium LT7911EXC bridge chip.
> +	  The LT7911EXC converts eDP input to single/dual port
> +	  MIPI DSI output.
> +	  Please say Y if you have such hardware.
> +
>  config DRM_LONTIUM_LT8912B
>  	tristate "Lontium LT8912B DSI/HDMI bridge"
>  	depends on OF


With those two fixed:


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>



-- 
With best wishes
Dmitry
