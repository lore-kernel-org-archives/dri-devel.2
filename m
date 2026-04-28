Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7D1FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 12:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B64B010EB63;
	Tue, 28 Apr 2026 12:42:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QIvMrmKJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O5WnVlJR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D545210EB6A
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:42:16 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S94cgV662991
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:42:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=TMl0fceSXKB31QqIGUfwYqRH
 eczNPrV43yKASyx3Yc8=; b=QIvMrmKJEm4qlgUHtl2HEaD+sQ9Ll0L4s+3yaYIZ
 ZvU2SLCvPE/hfHnycy6rtGcPEFINGVF2ZkFaIJQmFDH0ftvCLDfD6ziq8HulS9Kn
 4o9jao/OpJ05+HdV+nUF7OuYPdeVjLUOWya18JvFfn1gfOTYhPZOw2bTOyow30SE
 y92KnZBMxd+3i1CGiQ+Xo5Yt/nTGQEZRW5YkIFmAJGWezTDElGCsRkIsa+69cWi3
 Orz/3eoVbhHqoguUJG2M8mPN4vOiKQ77cmDtjaVRApAXJAAxA4NNnVv7BKI5G/5D
 o5wY6V0OVwKNHRSnKYF+ZDwj5/TnYCgQnBjFQacBwx/62w==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dtc5n3wup-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 12:42:15 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-56a8c0b9ef9so9464555e0c.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 05:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777380135; x=1777984935;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TMl0fceSXKB31QqIGUfwYqRHeczNPrV43yKASyx3Yc8=;
 b=O5WnVlJR+zTvp85J3rgvWGRZsg4tHE/YMQq/09XVxoyuRu7Wya54nJlwYz3S1OO3Kb
 qbqa8QnK5UKkZ9IBQbYiRg/KB09Yk/Myd40PWvg9XuHsu4tEZsU65hpTNWxVXxLVYDwY
 MT1AIkY6UZeWdVXQusr9s0adDf8bbYCW9ilAqDzrI/vCuxHHtvPVqjTn+D9k2GNlziYD
 LZsISw6cwuNYD2ZtYu8Bfo3J05Sk+uyMUm3aVGhiMPeKtvknsFJz1FruuO/i+DTx1iqq
 OXOUNZXCgqasdup+fdC5J5nOJMAKOY8cYrpJ9mRnHhLIsWy4TYWJ2ExFp2eor4Zx4QI4
 aPkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777380135; x=1777984935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TMl0fceSXKB31QqIGUfwYqRHeczNPrV43yKASyx3Yc8=;
 b=R0w0xTr1BDWU1uGDkGL3fL6hWNGasHXAk/z5NkIXxuelmt0qdgcjGeu8vaitxkpRLB
 kTiRUcA/mfn/nf0cblVJx4B8OlLMnkxixUVSEdhJN3W7FTwXZT3mpLeRUvat/CC2WLW9
 A7g7BF6nb7ckafGpCiwHEAvBwjO/oPI3thD5vsIVf7/AmnktQo6tQIv5yOMlGIqgV5+R
 DDZ65DrbFNJWfvoh4eZiNYI6K1+57iPynoxpMQ/VXIFBx/DuBSXoOU/bkCqZQvRVsSBE
 6iSJj5uoX92pxEu/dFKWfcVo0qBwJgH4Xs/XIw003Jl1Wn290BXkOA78uFGR+gVYWwxS
 dTPw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/EdJOg++V8i/R388eyKjUJQJTJd4J4RasCPnaSoxQhfdA8bGF8GhdQrvHs4QKrKqX2iQdZ6cBIM0M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+nqU9hol9ZUquD/CtPBfhp9RJqMPoygO5GAKMJg5Q62J63GRS
 rm14v1HYvdcqH3oYxXUJkSx63oMyVumxRVWxszvKVelv/WU+vDm/iRCJFNtAubxz0X2oY7R8rE3
 FNcPwFa0S+qXAUtNNLGCZ1A+rks79qCZoJit0fua+1/E0TLn0JuDkjJs5/hPZOFDoRviTPOM=
X-Gm-Gg: AeBDiesDyWnEsV8d102/05xosIbXhwKJ0+NZ5bC1116GvIbtpjFnpzToluyjGILF7zf
 PwGXK2mnWJ13lvmC3psGA8SZox/cLECzpiupt/Wbo2k1dBjYLjZ3WYnlMWPiIw7qf2WeOsvawW3
 sWM2Y2eFlVgvOvTD0YzsDN7siB67+BElBar0Yq/zVdDK9tMl61nh7U9aWMgPs8SktJpSvkH7DNx
 uY9NF17NwKV74ZPeNTsTnwDy9bKxNKRDvUzKORQkBzsa/bpc0p52deoAPKuLoqCmggzP5T4YOyA
 a/XnvLHoH87CzR7oNGMkMfHzFz9r/jJjIPnkIX4FOJl41i5FQpvxDO1kAr7Vwq7zSLiegR1n4a3
 iwAElpKMCRqIRWxliNTEyHXCVzs0t5t2OT8v9jqy/trhOW1YLFg1v10JJTEQB/HmbwR6rC3smPB
 11nKNu8tIlGYl0Yr1zJ265LzAoYEdRSbJDBtLi0kUKS6YaLQ==
X-Received: by 2002:a05:6122:20a6:b0:56f:7300:37c9 with SMTP id
 71dfb90a1353d-573a5674d9emr960552e0c.10.1777380135283; 
 Tue, 28 Apr 2026 05:42:15 -0700 (PDT)
X-Received: by 2002:a05:6122:20a6:b0:56f:7300:37c9 with SMTP id
 71dfb90a1353d-573a5674d9emr960538e0c.10.1777380134745; 
 Tue, 28 Apr 2026 05:42:14 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f55f0e5sm6587151fa.34.2026.04.28.05.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 05:42:13 -0700 (PDT)
Date: Tue, 28 Apr 2026 15:42:12 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Christian Hewitt <christianshewitt@gmail.com>,
 Diederik de Haas <diederik@cknow-tech.com>,
 dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 12/13] drm: bridge: dw_hdmi: Use
 dw_hdmi_connector_status_update()
Message-ID: <nsgxyv5sflscs66kxcgbyapivu3yjskfqzeqkt4yhnjfomyfav@rkxft2e6lqbd>
References: <20260403185303.80748-1-jonas@kwiboo.se>
 <20260403185303.80748-13-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403185303.80748-13-jonas@kwiboo.se>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDExNyBTYWx0ZWRfX8OoLxJKVnOaf
 yuS5Zp9GPKre3esOdjxGtDiMBTXWKbvj+eUBVF3IURIwEgNH1zzvFKlWIVsp/y1KlCpENTN1brZ
 5pECC1FndbUCtEkQkQ9wKMHeJVvfhEB+GYAfMX7vqqTR2nJJHSRU0kbtq0wfu5kdDkqAYqyhr+5
 tG3SOzv75hhHY0EleI9AkJXPFiZdKUei7/Nfce06BvBHTVVUkQOWcwUKJrh4fD2KICL9gWTbUrc
 zUA1lHBgCJ/NVimDjLh5Mw5jE22v+8NonavGtwviyzw7TzUWLnmbt/hw2SED8rO4xkSJbIPVgLQ
 rMgSmcim4AhH7UDyP4IV9RGrgDwUdr6nnZk7WjSipRqGLUidRNmg+jKGFrVvgW+HZMJeEV4XDYd
 BksFpQWWf1lkLRf+zgldItT8vLUVMaa6c3DXa9AkbrbfvmeTxmOAVLY58g2cHtC4PRiJcbHoZ3J
 cgofLpO1UeTewGsnCxA==
X-Proofpoint-GUID: Jtu5RjjYrQhi8XITXr0zgubKB4XahHwy
X-Proofpoint-ORIG-GUID: Jtu5RjjYrQhi8XITXr0zgubKB4XahHwy
X-Authority-Analysis: v=2.4 cv=ZMfnX37b c=1 sm=1 tr=0 ts=69f0ab27 cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=6So5M6-r7czCO2SscSEA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-28_03,2026-04-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280117
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

On Fri, Apr 03, 2026 at 06:52:58PM +0000, Jonas Karlman wrote:
> Update connector EDID and CEC phys addr from detect and force funcs to
> ensure that userspace always have access to latest read EDID after a
> sink use a HPD low voltage pulse to indicate that EDID has changed.
> 
> With EDID being updated in detect and force funcs, there should no
> longer be a need to re-read EDID in get_modes funcs, so drop it.
> 
> This change make the dw-hdmi connector work more closely like the bridge
> connector does with a hdmi bridge.

Please consider using drm_atomic_helper_connector_hdmi_update()
directly.


> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v3: Reworked 'Update EDID during hotplug processing' patch
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 24 +++++++++++++----------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
