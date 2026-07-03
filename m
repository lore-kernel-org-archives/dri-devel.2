Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37574C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 12:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8421310E5EE;
	Fri,  3 Jul 2026 12:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gmMy8GZr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a/pnh+9g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D728710E5EE
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 12:34:01 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 663BOJfE3136094
 for <dri-devel@lists.freedesktop.org>; Fri, 3 Jul 2026 12:34:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6HClnpnLgJbZHiHBgKqUqSMf
 hI5+WcDhllChwXjvU14=; b=gmMy8GZrxbIduqOKBeFagsh2XOQrDhN2bhEGB4lx
 Pe/Owu0Aj5dt9x/pH8X1YS/Yu2+GabrPT3UH7gfqxZ9xgWyuua2YNFuKtxJyWwFL
 J5GykYorOChso0ca1moVo4Lw8DBVjf5tXmRaSbKkb/cijlF7NRS7SrLBjTTC+LKl
 Nlqs3nAR3kU0XMFmJ/EvRchk16z0gNqiM0qjxzlWqaEok5N9VxvPkATD8zTl1msK
 XH1aG3r6JFlVTpGM3qbaLkIx8oM0Pkj1hyD2bjJJUbqpglN/talkG6I8OKgpkRZm
 yet7S2Mp8QvuBBUwNz8TY2vJECy4Rhvaj1bP/5J9RPhcnQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f64b5abgx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 12:34:01 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3810e5c5871so893054a91.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Jul 2026 05:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783082041; x=1783686841;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6HClnpnLgJbZHiHBgKqUqSMfhI5+WcDhllChwXjvU14=;
 b=a/pnh+9gCPKcjhb02VqN2LeZIjSFoAKewHwEskfJwAdr2045+AwNmCAGI5+j+PGRDx
 emZnDC6W0JYJ+qpzbeimWpYWwm3d3HDOGiLTbn8D2khkxWxpQlBYnGwVIvUgJKK9zM8V
 0I+AqS6rj8SNB7+ju153m0MTgI+hvW8YZ3ErTefDRyM4c10bFv9+LS8DOv0wGeIvuQQP
 w8SVPGx/i8tdZ5SHrjBqVr1TwQH4f2MivPrP0s9uTzQPwHV6YJO9bTsaa4e4bybY2zDC
 1/OjTmoB8AvcA45/mbPWecLJwLYl1ipmg4CRs9FtWtGA/uOoilLlLmDJ8F+VieNyiP6H
 8v4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783082041; x=1783686841;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6HClnpnLgJbZHiHBgKqUqSMfhI5+WcDhllChwXjvU14=;
 b=WhqowrTPrxzH74TMB9wLuzyuchpcLFGMILW6rtkeecSg1LFDOx3SGRfWpqvR1qghjo
 asTAjUCNi+XqkhLFcUf4vpTLcMs4lA+QqT+WjpOmPbmpWWKhOQYjINHkIdKWacCre1ru
 cxJvsp0alpjmulBkulKL9Le+Mr6DwO3P8yTdrmk8v33IQSmn7/nMf+KBjXh6dF36ELXD
 zmlCT92bSGTqaix2gXG40iwt8TYL6psqXd4WEuLfJgxxjLP5gPf+exaa+39kL/Zuuuxe
 Vl4ulc1c1hK5F70xaTw7wlcupHEelsUV0JQQfI2S2pxwh1z10WLOaf6NAloX0SDWHPGS
 Mcfg==
X-Forwarded-Encrypted: i=1;
 AHgh+RryCizwUn6vUaKM8CIwVY3GTdbr6U34xKZnef1vbQmQwLVtyPG0naVGWkJw1miOWAQwzjZJoPgQ4Ao=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBeU+hJTB0BTNN2y85+D3ECn6Rwjs0qhPNLPzgrjpfxJ8BHTj7
 aZxd20OAWATYZ917RYw76ej4cb7R5xwgmUO+52kZffNzOtdkgc40ZN393LLBu/lGHdaAV5reSON
 GP0CnSqjKKc+P5qKjoqMxmRZPGHRKGF+YY1YyLhZQhUpGdVSeTFJjSdIZrNpd+gwJDvea9Gc=
X-Gm-Gg: AfdE7clY8r3Rgz+EBSUNfYcLYYn3G798aj/Qr1XmRxd7sX3zXty/k1D93iAtHlpRcfO
 ZgOkYuIzmVlydklNDCGwsyQkkoYhJMVxZg26sqYEdiOjMsXELTNzx9Qg/yJNfxjnx81K5DLv+HY
 Z1HbplSfuxzETZbMmQVxVqttYrf1xIAiDMki2i9zXSbFukYklS30vHR+5q8oRj3zCTPJHWcorJ/
 kiRszXPYehGNcCN+pRV4n6waZ/6nYZPicJnKWnpNWiVlAHMnfDoFMhT43Jvtd4mmLjGeZgzr5G7
 t4WPca8PIOPuaKwuqNhyZvOFf7TdmHkMDNny/Lh88NvDQaDxpRgkhJZxKNJn0dnwlCaK2gOa+eZ
 yqY0cDgt8Z2AviUggOqRiua3exg3FgbHi1nbn
X-Received: by 2002:a17:90b:1806:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-380aa1cad60mr11111801a91.22.1783082040562; 
 Fri, 03 Jul 2026 05:34:00 -0700 (PDT)
X-Received: by 2002:a17:90b:1806:b0:37f:db06:229c with SMTP id
 98e67ed59e1d1-380aa1cad60mr11111740a91.22.1783082039974; 
 Fri, 03 Jul 2026 05:33:59 -0700 (PDT)
Received: from hu-mdsor-hyd.qualcomm.com ([202.46.22.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f31e7a2a8sm4556282eec.25.2026.07.03.05.33.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2026 05:33:59 -0700 (PDT)
Date: Fri, 3 Jul 2026 18:03:50 +0530
From: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, boss@oss.qualcomm.com,
 qc-display-maintainer@oss.qualcomm.com
Subject: Re: [PATCH 2/4] drm/bridge: lontium-lt9611c: Increase MCU poll
 timeout to 200ms
Message-ID: <akesLiXidOELLya5@hu-mdsor-hyd.qualcomm.com>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-2-42abbcd3bb1e@oss.qualcomm.com>
 <jtzitxsoqhuohc7ztpo4rzirpt6gxo3dcarztw3smn6pnr2vet@vmli6nyrhucm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jtzitxsoqhuohc7ztpo4rzirpt6gxo3dcarztw3smn6pnr2vet@vmli6nyrhucm>
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDEyMyBTYWx0ZWRfX3InOM/PN6TeX
 7R6AUWw79O4k59iPTiuHoJZ5CfLECubAWPNo9s9uAHwoe4cTO/lhlxoNLtilS5nCNuWclyzCIT+
 CnMVqJoBbZ0GOKKVQr/XI/m2RnJMlE8=
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a47ac39 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=wn4IccVi28QXfKnItucA:9 a=CjuIK1q_8ugA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: TzbJ8XMiho0S2jL-_BSpY3x1VEuIsh8M
X-Proofpoint-GUID: TzbJ8XMiho0S2jL-_BSpY3x1VEuIsh8M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDEyMyBTYWx0ZWRfX9v1YLflEyTQ5
 rrFD/IufMAzd0eUE4df1bmW+oBvPeudL1h9XHQz4nmFzFoVrgcHrD0Lz5hqB21iUkBZ+awx3nqQ
 yHxavu4lel3XoUETZOeCpqBnLdh44MSsGDjMWH/OiCAstYIzsoyMb1GYpDeBTd8UV4xl8JRQCdp
 Zmz0+HOSHbkJcd3o3sGr/jYBLFDrQ9R23oGbOyEuwNb+QZ7msr0kpebM1aQjp/fVJX92hbFC9fI
 lzkR6DMPMhDzRBgvIw+pPEUHmYhrsIjlA+OxZF4XVZAnRUJ4Xkjkojtmnk/t9HMaJtWYHG3M4jV
 g0dpGKR4UGHzQyrwZ5YB09BJGl50nSEVV8UTUX21CfSLbPNa0uPT1tH6NiMXMHF+UF09v4CN0iA
 WYU20sViEdI7bDPK5Ux+0dRhdh5I+IPqEMNDwO9V5mkzlFBizeIXFUJVB+QhxtwUenMTkvy8U9+
 DUkqrfwwrCXPS0P2r3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030123
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

On Fri, Jun 26, 2026 at 11:25:03PM +0300, Dmitry Baryshkov wrote:
> On Thu, Jun 11, 2026 at 02:44:57AM +0530, Mohit Dsor wrote:
> > The on-chip MCU may take longer than 100ms to respond on some hardware
> > variants or slower I2C buses, causing spurious -ETIMEDOUT errors during
> > normal operation. Double the poll timeout from 100ms to 200ms to improve
> > reliability without changing the poll interval.
> > 
> > Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> 
> Fixes, cc:stable.
>
We will add this fix as a part of base patch.
> > ---
> >  drivers/gpu/drm/bridge/lontium-lt9611c.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> 
> -- 
> With best wishes
> Dmitry
