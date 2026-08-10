Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30072C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:06:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF5E10E1B6;
	Mon, 10 Aug 2026 16:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i1NhVVUe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UNBPT+xV";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E259110E0F8
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:05:59 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67AFW6c21694280
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:05:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=mPujkJTOGc0TWj04uUMCHTdn
 NQgumaeuC61sBKnEmUw=; b=i1NhVVUeZGJGLT8al0W51NbX1Ojh2Qui6aK1blgY
 nf5Hemwv+rLSF9HlTgPlTtzK17bJBtvOcfZZ0YPauxCuPGO/jMG4NuAY9ZoLs/mM
 zIkZqDbeYAdlR9w6vN75ApPo9EXklL9N5vmqwz6aPd0JGo9m6rzQ/rj3q0/+3cf5
 RQU+WXKePt8GryifKZjNFwxXOlAJY+M0vEx6HUq1EFiv//d4uBmNLKbjnBwQuL98
 zE0lxPhVZNKaLiCEOoJy4ewYYTX/ebf+d9c4mCKHzeJQBhWd3mGKVDEG7omg8vck
 U1C7RLiN8fMswq5+ZS+gMtEh1NbzTIEtAitvXNjzAeaAMw==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com
 [209.85.221.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyccqshq9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 16:05:59 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id
 71dfb90a1353d-5bf90475eb9so312757e0c.2
 for <dri-devel@lists.freedesktop.org>; Mon, 10 Aug 2026 09:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786377958; x=1786982758;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mPujkJTOGc0TWj04uUMCHTdnNQgumaeuC61sBKnEmUw=;
 b=UNBPT+xVkQ6A7t0IwUV5bhuHQqJ54wfaR4z9reJnmOqERzX6XDo+gi+tNMdD5V+egB
 2/GdvzsZq4oy2ud9q4gG1MgkUBUyjuOjvFRt3LsEBUWNXjd3yg+MeJUkn9lvjbQtLRxg
 BenDDxiaIIxHLtjiwHPCXY4qm48VX7TmUxEhqt/jxLJZ7JdP7EAvL/ZLWe3LERxjrv2O
 QugKZaUJGfhkoSScFMVDx/rUgeozyKtRP2El0CT72lYCyzm+B7I3BEsS5+bQEepNxIgo
 R+LvgGNVXiaUCk44PEtZuEvkQ1/Q9oAlkuQS5uD557QTkj8pdKI5YJedHKwKu9HCcWIZ
 5FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786377958; x=1786982758;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mPujkJTOGc0TWj04uUMCHTdnNQgumaeuC61sBKnEmUw=;
 b=NzQx/gKn+MxmhDFZPFETTvl3ElFDOsfP4ru2iQKyMp1ewKgqGK3bydrtRo46SOUazg
 hoFcxncyZxlG2ZKiPqG5kCc76gpY8cr0IoSUv+SvEUx0ZINys0Ag4MR86OOBuXt7kpcE
 plbbFc4MaOCOgclJQn8jKM9u2YSwKWQhIB4QZnaqQb4dzqzOViTPSs54b0ZHXHMAO7LG
 qvWsR/I8u+cytPNseZPtFl0kkAlg6M8QcGyKmaSn4uGmbcrleheRJ4LLvncTBOVSM7AQ
 Tlm3sxi5uwfnm5/9vL3jPJqCAqXgAm3NJRUN/OWszJ/J1EiA+GU8R4o1KSjuswlW4zZF
 BD4g==
X-Gm-Message-State: AOJu0Yx7Z66y6+QtwBHk3+hXFwTWUbEu2CPF10Kb7CwYYAoxaZCcPE2L
 tDmzF3TRpfRWmNICzdXFvbL9y77qK+jNzAcbQzxuXBOHXIMAJlXOsr91fW+SE3laoP2tpxyVTjM
 TBHD9NXD7g2CfNBm8j9YajUMhiCfJ04ynt+86o5wpozYJ3FJaX3DSkPZlhRyPUG4jrmUZGlY=
X-Gm-Gg: AR+sD108BXbaVxstunamx62lPYUoMa7dSy1txekRi0YhfqcosnTaP/BZ5VCWlHhTjez
 q6w7qcAGfhYSgHDfn3r9CfVUrOSKDFMUEsQJEtlREQ6D9vigZeFTa4nihQxeelIJ72eYNFI4JLY
 APHA3TaaQ7YPDrku/br/7mbJQbnF+lvJc1M3q8EYgGBrwGAyN6/In+W9hq+yRWSEbfT85DMSCdL
 +SY1q7OyIWX5QVZjS83KKm4Gto5DtPZ3JV1wLOV3EQwa/VdgQKJGdB6U8dvqnqJmPnXo2GAWpJN
 hKqf+caT6d/hIV6VewvbEWzEVF5KUBfdS3VnIMP4o2X+UFyHVX6e99t7Iqcb3MTx27iWNG4LEAs
 1uy+4sWDj/leagzDvTUjjuQetn3MP7WI7n3p1QkTusN4icmvDlOSBu2Y3N+qiM1glPB2oo1N8uK
 dolHVOjjvxMInl7Q==
X-Received: by 2002:a05:6102:4b07:b0:760:418c:8a9f with SMTP id
 ada2fe7eead31-768e8c52790mr739672137.13.1786377958231; 
 Mon, 10 Aug 2026 09:05:58 -0700 (PDT)
X-Received: by 2002:a05:6102:4b07:b0:760:418c:8a9f with SMTP id
 ada2fe7eead31-768e8c52790mr739648137.13.1786377957798; 
 Mon, 10 Aug 2026 09:05:57 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b304fd1c38sm2066473e87.12.2026.08.10.09.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 09:05:56 -0700 (PDT)
Date: Mon, 10 Aug 2026 19:05:54 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Inki Dae <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Subject: Re: [PATCH v9 1/2] drm: add <linux/pm_runtime.h> where missing
Message-ID: <gfhkrmgrdmqf2zmfdoqnmc3a7ifcwxdyoiqptg65nigdwvmwvv@4pt57y73ucrb>
References: <20260810131314.452865-1-vladimir.oltean@nxp.com>
 <20260810131314.452865-2-vladimir.oltean@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810131314.452865-2-vladimir.oltean@nxp.com>
X-Proofpoint-GUID: 9BZTUd8xVTP1vEi7Zyb3QODX6jAkShY_
X-Proofpoint-ORIG-GUID: 9BZTUd8xVTP1vEi7Zyb3QODX6jAkShY_
X-Authority-Analysis: v=2.4 cv=WNVPmHsR c=1 sm=1 tr=0 ts=6a79f6e7 cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=8AirrxEcAAAA:8
 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8 a=P1BnusSwAAAA:8
 a=pGLkceISAAAA:8 a=hD80L64hAAAA:8 a=iP-xVBlJAAAA:8 a=EUspDBNiAAAA:8
 a=xt7DZbCNmi909WKh4bIA:9 a=CjuIK1q_8ugA:10 a=XD7yVLdPMpWraOa8Un9W:22
 a=ST-jHhOKWsTCqRlWije3:22 a=cvBusfyB2V15izCimMoJ:22 a=D0XLA9XvdZm18NrgonBM:22
 a=lHLH-nfn2y1bM_0xSXwp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzOCBTYWx0ZWRfXxaCn49SAjkHO
 Y8QX1YdjXGdPc2mel9lGmtCYdEzISXOrzX5HqS9chifsDa5m03tS1GphGCDBzni1WKdhChDTBBh
 r6QNM0mVdphLVVeZbEKAPnKgqgLAIQJ2glGSEUbdffTlgJGxlP3zoeTA+ncQeKWO7mPhvipJxcf
 ur1KTpy50bAGjw7uZJiRYGe6hFF3ZHiSP7npYJ4L45I05NxBK9F/K9VT2dqTsakSjTcfldrGkwI
 RKqGm1AB9XqcMX40IIWrEJBdp075f3kcePm3NxvqMVU3n+n6TagrZF/iTge9hjjyPUJg7dSWTbF
 gHnAhlgtPMZGUB6Vik3POJBfz6a94D3vF6VOPc5yEhB2NR0qcI3XlwDguAdTNQj00fOR6vfWCED
 YMPxf4OgaFxi8ihBJrHYXvF6Fdi0/DNLgKxUs8Z+IzU1Y37EqoZKsK4Vm8hQc9Wiay+ulSqVJjd
 OfqXgdLH0kuZPcEaAbQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzOCBTYWx0ZWRfXys5vnANXffiT
 +RucRkbyA2uvGQvqLe/SIgHMNN+BkLCYPbAz18KYuUHGJrRIGf+9q1osdjzGF9zVq9VyColcp+O
 rr0LmBYqyWieEjtoWgXuYRB/DLTAWzI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100138
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

On Mon, Aug 10, 2026 at 04:13:13PM +0300, Vladimir Oltean wrote:
> Multiple DRM bridge drivers use runtime PM operations without
> including the proper header, instead relying on transitive inclusion
> by <linux/phy/phy.h>.
> 
> The PHY subsystem wants to get rid of headers it provides for no reason,
> so modify these drivers to include what they need directly.
> 
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> Cc: Andrzej Hajda <andrzej.hajda@intel.com>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Rob Clark <robin.clark@oss.qualcomm.com>
> Cc: Dmitry Baryshkov <lumag@kernel.org>
> 
> v1->v9: none
> ---
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c  | 1 +
>  drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c | 1 +
>  drivers/gpu/drm/bridge/nwl-dsi.c                    | 1 +
>  drivers/gpu/drm/bridge/samsung-dsim.c               | 1 +
>  drivers/gpu/drm/msm/dp/dp_aux.c                     | 1 +
>  drivers/gpu/drm/rockchip/cdn-dp-core.c              | 1 +
>  6 files changed, 6 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
