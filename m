Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2189FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BF1A10E078;
	Tue, 28 Apr 2026 07:31:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="THcP+Nbs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OibY2fav";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 585F810E078
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:31:13 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S6OD7Z241134
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:31:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=bwq72CVADBTaOQqPqrMijBTa
 KsgmE9bGcYbY85sgZTA=; b=THcP+Nbs94aKZHmAcQkGVC6CCnBaXlEYcymTlG8l
 mk2lZK/9g7YQ1nkclsowUt2GLif1bteybOYS6KfEWLoQ9WMTG0QZybAPUVVIkqkW
 3QJtnOQ89f8CSOjfH2fjgH97KzpvhZme6ekSDnRs7eI5MMsy4NYWpO9AVvs7o5as
 Mw8kPQTsXgbypRo1zHowDkVCru6lDY3eNZXZKtOjujV1DyOxbWyek0t6IOqj76cd
 SvD+RHqOtx9h+gltq/CM0FIjnDffa2kPvufkVv5ZtyF4Nwrt36mwEBmPtUKB+4Ls
 eXyfjMd3JX1ZOyPLm052dPGE+ZT8UBfgY7n83ecmt7bA9Q==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946ujnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:31:12 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50eb8bad331so75125551cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777361471; x=1777966271;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=bwq72CVADBTaOQqPqrMijBTaKsgmE9bGcYbY85sgZTA=;
 b=OibY2fav7EBwPk+fstzPA/itZWvr3ckjFmQuhE9O0E+bjpHnxa1/tUrYWmEIb8pk8T
 W+ybkE4s7cUnOtghmUjU2jEIYTJL5IBaYeeNcgBxMKepSc8tX4X+MauYUf6FHPeCMq+k
 wZ/m3AXanY6UM1TJ9Vz8cXxWwK2o7BdRNUAav+PhBbLxyC3y+3uhACRO7FZQg+dmZY3X
 gZrAsTXdmqwp4uIvTDEZe6PGC0tSKcJTuslebok5V+R2oQ230AteECqjM4RZYUv1QS9F
 9h3VnUUflz/qlYvlg9+GRaY1tHLmhzGmXg5TP3UyOOGv5+Zc90UTJepdrHcuYdeMqJnI
 fsAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777361471; x=1777966271;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bwq72CVADBTaOQqPqrMijBTaKsgmE9bGcYbY85sgZTA=;
 b=JV5HEh0W/aNzAGby5nPBSSNNaZRulO8f/elHK/OGQtSPja2upUlbTHgLtRuvTkh81S
 KrxK18fZYxV3IRfO9AepKKzTfD8wGvtjdo/F4XXvWQtWKSSXH3RTgzc/tiJk3kpSQUpJ
 jiuXzJ4rYXE2ZOfxw7uMN7RG661tywVUCwyf/L5gopDuk+VlUsbeA/FA4F6q10H9R6Wc
 2i4fzjOR9gavUimlo1BvruLhAI8bqVAZFVF7gFZ/5FVvWKmCFxHzymtv+h7Cpgj1sbVi
 SLMe/lIicaQY3iDrYYVjiou5LeWtJatpdhoFma7PQwvAF08odHWyv8zNkzxrWdxASSej
 aX8A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ygKrsJsrLUBPacGCsxfEiVihLlFfnS3IJZIlPgNyyHuETXRdPNbWkTMpeRinWM8NpvJib3J36Lvk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJeaCXzGlTGtitKTj0+lq/edfcTS0tWYg8VnkOIbOc1dqJh79e
 WaO2Jk7/JHpelMI5kgJO7IRzd1NaxOT6F16lvfDs5lxivEtbJb7uJCrBWatY9KdwvCsx8eX8xvW
 6g9d8jatuq4UbueCH4IZdV1ivVawqncvuHLWVCMskq8ZeVymn7tPCbbWHtxR2jwZIW+a1O4Q=
X-Gm-Gg: AeBDiesI2sK8MaPFPE7UcGZGxvGlfqONrr1s2WldFKVC6geKH0H2tLvrH9K0Lkh+CBk
 pZ+8OWKlPCa8jGcY514HjXeKzyd6kaM4/YVtNIpoDt1qmU6p79DrWrP5LC7ZJezIW2IEgEteRkz
 fBe4VUsBBIgHzTPCatWGXJ3+hw5pN1mhApui3ntx6Opk389osQtw1PMqqH3RjWqRK3amaI1FqmA
 P9tVYvMaTSxOHmYuWgE3hx3aqJ+qYh2KYVn1p7EGz3mnC4UukUDQ6OJPb28OgXHTLLAIGghPJ7a
 kktdrhb0HulzbCB2VRVJvtF54QpWyXytOte09YjW/9UsHY2aVUIYih8nzb9J+07LzMdiZGfA/lP
 bI9p/dFSpqF1VIpB3YGdhTsqlFkyzeG9dtv4BE+qtd1ofrKDpn2C/rrEPYzUZHeF6OFoLZwQxAT
 whzOZQBsl0qGnF2YDAS965Mi+X0opVejrMPxSmRZsUrODSgQ==
X-Received: by 2002:a05:622a:153:b0:50b:3788:ab59 with SMTP id
 d75a77b69052e-5100e136844mr24305791cf.22.1777361471167; 
 Tue, 28 Apr 2026 00:31:11 -0700 (PDT)
X-Received: by 2002:a05:622a:153:b0:50b:3788:ab59 with SMTP id
 d75a77b69052e-5100e136844mr24305501cf.22.1777361470719; 
 Tue, 28 Apr 2026 00:31:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a7462ca9c5sm408872e87.14.2026.04.28.00.31.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 00:31:09 -0700 (PDT)
Date: Tue, 28 Apr 2026 10:31:07 +0300
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
Subject: Re: [PATCH v1 0/2] Add Lontiun LT7911EXC eDP to MIPI DSI bridge
Message-ID: <ilkpth74qyjxmd7fol76kztjvsdmktjmj74qu4f35gevfjgy4v@nscmwgworotm>
References: <20260428063224.3316655-1-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428063224.3316655-1-syyang@lontium.com>
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69f06240 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=Kz8-B0t5AAAA:8
 a=Th18vmrz9VDaD5OkdogA:9 a=CjuIK1q_8ugA:10 a=a_PwQJl-kcHnX1M80qC6:22
 a=RuZk68QooNbwfxovefhk:22
X-Proofpoint-GUID: BD4cH2WBt2LjEuAkim4_ZdT1oJDX3dFn
X-Proofpoint-ORIG-GUID: BD4cH2WBt2LjEuAkim4_ZdT1oJDX3dFn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDA2OSBTYWx0ZWRfXwz1nc9zYhkfA
 UPKZli8tA3xuih3TPR5iqD7VRGK1Vra25Cga4tdcqsiym5vlEE+kdpkK5+mYTKJrB/kSK7ECa++
 OxyODe9SQJ3tCTRj0XvHQeWAI/mTKJOZCkTJ5dHVqNOaA+f0rTbgd5zCl+Q6WcfN1M4a7tRy+mE
 PtXw65u3Xy2r9phR04PyxCeS7Au/q185zutFHKUMO0apWVeuh4xi794CIAGOmMnj9FH/o/HOoM2
 DjPQ9E7oJ31zhQmW+fRJu85Y6o5erhuIXzbn1FCll3wkrmws6GdThbhqGkKY7DGPLFB3EmLDTDT
 Q1QFyvQ2meiGiwLh6TNdUn4NvgldnVt3LmbdPSgWh1mIknRgGY0rbT3WhmPgoIpcNUiXDX8uDP6
 bcXTdN7OCmMbtu5TmnDBVs6OlWBd01CnCQkh7a+xeOELnGOtenrSCaujrtMrniz2AKl1a1TA6H6
 JExbDhAjj0GBrvKpLiQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280069
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

On Tue, Apr 28, 2026 at 02:32:22PM +0800, syyang@lontium.com wrote:
> From: Sunyun Yang <syyang@lontium.com>
> 
> The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
> and output signal/dual port mipi. This series introduces:
> 
> - A device tree binding YAML file describing the hardware
> - A new DRM bridge driver implementing the basic functionality
> 
> Signed-off-by: Sunyun Yang<syyang@lontium.com>
> ---
> Change in v1:

How can this be v1, if you already have sent the first iteration?

> - dt-binding:
>  1. reset pins use active low.                        [Dmitry]
> - drm/bridge:
>  1. use atomic_* callbacks.                           [Quentin]
>  2. fix the incorrect formatting and spaces.
>  3. add the required header files.                    [Dmitry]
>  4. remove "enabled" flag.
>  5. remove *fw from the lt7911exc struct.
>  6. .max_register and .range_max use actual range.
>  7. regulator use bulk interface.
>  8. use dev_err_probe, devm_mutex_init and devm_drm_bridge_add.
>  9. Replace GPL with GPL v2.
> ---
> Sunyun Yang (2):
>   dt-bindings:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
>   drm:bridge: Add Lontiun LT7911EXC eDP to MIPI DSI bridge
> 
>  .../display/bridge/lontium,lt7911exc.yaml     |  89 ++++
>  drivers/gpu/drm/bridge/Kconfig                |  13 +
>  drivers/gpu/drm/bridge/Makefile               |   1 +
>  drivers/gpu/drm/bridge/lontium-lt7911exc.c    | 497 ++++++++++++++++++
>  4 files changed, 600 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/lontium,lt7911exc.yaml
>  create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c
> 
> -- 
> 2.34.1
> 

-- 
With best wishes
Dmitry
