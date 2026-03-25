Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90E19103A997
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 02:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C459110E5BE;
	Wed, 25 Mar 2026 02:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KzmZLPn1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jTKg/YZt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B02710E5BE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:20:24 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJDkv03984539
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:20:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=HENptg37gJJryl+XcIdc1POO
 isu4rdjd0shfQjM2yC8=; b=KzmZLPn1E5Pof+nWOeyN59Hg1alQ+okqCL+jxgQE
 SxHopyNX/9O9x4mF4puW3IbGNFgkkzCWVKycCspNyux7vbGdZG7c8sHwinTqBpxN
 3X4qPmQ8bpbINt7kuOiOguF4ALVirPNUhZoG2A9p/bcTTUZbs/v16ZPQy8LPUFni
 6cFiy3v+3fWChpaTYvphdVIRh+BLUaRxzmcivtEP4C4yuFBOEx0ejHoyQlE5fzzF
 Wh6bYRxiY2+Z9WLae8C4DRAxzNa/HIt9QhZiv9PLGMNHms8Rq3CPbrbAIEtyPCRH
 Xp4FEfNhwWuOJk4uUgJXDrtwenUhJBWFoQjs/0D+C6NKUQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3p833v11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Mar 2026 02:20:23 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b31cff27fso24024081cf.3
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774405222; x=1775010022;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=HENptg37gJJryl+XcIdc1POOisu4rdjd0shfQjM2yC8=;
 b=jTKg/YZtb/W7lBqDLg0bOq88y90VxHZmoIAaXSMWoK0ZzYniPLK3Wtus9RoCGZ1+at
 uilw6MVNDQdoODNB6QvDx7EnMQt7ElWFkDUVB1FwsN1XherSyK8PAjlL3iKTI6xg/NQ1
 +4XnWIRkOCWEBW2PGZuYlkJAE0xrGlbJVXMepJNDIhc79f3yjokYA5kXygohPo4a0tAC
 fIHGr5UFvHEMb3vNZW3H7MgcQ3m+/ONJ5kijn9VUbEJx2Ki/VYYrGtK7mqoXO+3mYwu9
 J9XbBQdDMc7VUw1UbHBN7B6pgb3/np29YLIJ/PvhZTWyP5J4eeo2DmO//DImD4ivmcoO
 xZeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774405222; x=1775010022;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HENptg37gJJryl+XcIdc1POOisu4rdjd0shfQjM2yC8=;
 b=QBAVA9IdAMenphP16f6ud6BH5Adh4Z7xR32KQY87Dq7JGVfH8p9eDWcyY97iCuV6bR
 9S9vzDbX/1wbVC1maJPrJfs0TzPOPhyg8XQbp6AB7LM5Xc4+IxS8z7RUU1y80fqQKxJY
 rN2Oi1eA6K0TvSHf098OaaamQ7dR1AmuQcgwIFf9dVkHUx0QIGHKQWggeemblIYBJzvd
 IMdafHygNJ2+4JzatdoRO3d3KLrDIMYb9k9qxf5VJFto/unGet1mLRw5udbmNUYHSQfv
 H0yeuegDY5ppueLfFHJa6sNgNDoOmAIx+tCzPaM+If7s2+X35RwSonwSuBSR2F2LsS+O
 L4Ug==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4BfTRCT7Vbpx5/OVXgChJlSLFUsZhea7YxrfTUu/IRqu8sDoZMAJl+u103YQQhmCewSEbfDxLxYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYvyxq8j6dMISKdFUT5VMulecd/6eZW/IQCjuDpxI4FXB72Smu
 HK4DgTTf1Jpvgg4EDlT5VmhXoGUaP7sXHrGZHIK+0ycf6b3zCo3mN16qO5niwkv4RqTAuzd2NKT
 d5B0C+hP2xBjv6oDSB/Juvy3dQN7ZTiuCwAXJBASYb0FuUQyYLkwW0MjBrDKEewTSGLAtVOg=
X-Gm-Gg: ATEYQzxBwn4FHrjyA+qmxeGJDNpLf8GSUSW1pWKAAVWmgoqxVHmRPhE0ZpSlDxkHMEn
 v7EUohvjbYqB235e3MeQy5cxPSQsuYRtBmja8iizwmNvM2IRJlq/eLCzHoTWcuMl78bDFpM73Kh
 UMJXxjjCXvyWLJVY/KIyyHlERzUAlWALlUkE25SgN/rNm+XRenzeiC1oc0lRsULVrfsuOA49eCZ
 6Krm2VDG8KItdvdL8MUM1B/W3Qd866+49yEFmI1Qfi3tE7JZCHTt3sOkXF5xl21bvvCWwmoEwBY
 UtxrF4gx08Hr3fzrhq9yqaoD7GzbU3BC/xXa2zZ/HUJkNH4SaT8i76hfy5p+Op76UahDaAkxgLE
 aeCWKr264fj0j7bLeY9OGxA+wjDR+VKlABV9eHDYkrtRISFlk2VEYe2b6jcp10fZ48nM0aqi5aX
 NF++LvB6rqEGwvoQPA100WqLYSAlkJ8X+DniA=
X-Received: by 2002:a05:622a:17ca:b0:50b:1e5d:992b with SMTP id
 d75a77b69052e-50b80e902f5mr28178051cf.54.1774405222259; 
 Tue, 24 Mar 2026 19:20:22 -0700 (PDT)
X-Received: by 2002:a05:622a:17ca:b0:50b:1e5d:992b with SMTP id
 d75a77b69052e-50b80e902f5mr28177651cf.54.1774405221766; 
 Tue, 24 Mar 2026 19:20:21 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm3480437e87.54.2026.03.24.19.20.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:20:20 -0700 (PDT)
Date: Wed, 25 Mar 2026 04:20:18 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 Prahlad Valluru <vvalluru@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chen-Yu Tsai <wenst@chromium.org>, Eric Biggers <ebiggers@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: lt8713sx select CONFIG_CRC8
Message-ID: <ysej2ms26llphwtolaojtirbrslth3uqodk7o742elouicddfn@dokcxrkqprtr>
References: <20260318105130.1969966-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318105130.1969966-1-arnd@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDAxNSBTYWx0ZWRfX59vGjOcIZ6m9
 cSZuCIJuOGx/cBkbPpEDugGvuB+piI4gsOqnvQ82VVeYWA4eKuiHBXBUKVETdL6gVG6zSB4rX+j
 sUTiZyNB/2BCAUVqghNYvxk2aCrl8izEUVwpMbF3JX9vxo1tpU9evzgc+2aFjh4klrw4ydX4BgY
 /tuyj0KtuEiq5P461L5Ot2zDO/JS95so0Pekvhh8WWDPE/yYzOEp4yQLzzuC5ePD7k/czGPZvaJ
 q4t4uS2CJ1zXCy3xdePVOIVj2AgGT7AcszFiIbqBlwTISdmFcZJjv1GhnZCJSgZPwhD+/rweAuf
 rs+2Sk8E/vtobZlM2WPBayfHjedBjHnRe6TZT8jBJkdrFmewUwg8r7ddx2G/uHd4XmlzX0xEnqz
 qxwQAWG1ddz6XEiYlIDKnojekWRYsB+9bsn8dHSOruhY11jgTYvpN+Pe41xPs5IOetww4uEFSK+
 2Igyj52XmvjcaMnzwgA==
X-Proofpoint-ORIG-GUID: K_rUcXA9_cZTD3NDEwNnEVIdH--DqBy9
X-Authority-Analysis: v=2.4 cv=F6hat6hN c=1 sm=1 tr=0 ts=69c34667 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=4GOrQvsgZWK2qBYQFb0A:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: K_rUcXA9_cZTD3NDEwNnEVIdH--DqBy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_01,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250015
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

On Wed, Mar 18, 2026 at 11:51:15AM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> CRC8 needs to be enabled for lt8713sx to build:
> 
> ld.lld-22: error: undefined symbol: crc8_populate_msb
> >>> referenced by lontium-lt8713sx.c
> >>>               drivers/gpu/drm/bridge/lontium-lt8713sx.o:(lt8713sx_probe) in archive vmlinux.a
> 
> Fixes: 4037c6adc1f9 ("drm/bridge: add support for lontium lt8713sx bridge driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/gpu/drm/bridge/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
