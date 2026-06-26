Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D95AC43458
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 20:24:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E554610E261;
	Fri, 26 Jun 2026 20:24:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XUAesGcF";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUkqURM2";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A158410E261
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:24:43 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65QJ8q0g2309947
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qRLn7zE1/l07EVzKf2DixLcz
 lAPgdebamMdISm5Dlbw=; b=XUAesGcF/cqu0QYAtr3EiZWvbdSC5E2/kHCJgyHV
 +FIvLcU+mE/BJd8blUxitJjVUsNk3vQYZMva0nMuPQtbCjcSJ9udOkXgimv9e3vq
 gqfelvzc9Dqxam6c7DaD+ug5FEOXq2R2XZS3HoL3ThtHaP8K1Yt0bcSYLpx1dq3B
 rgUTNzWust+YTbgpYgmrS/NhQU2/ZBhZN0QL7iH37FyIbV4fqauJs4ZEUMwj1Y/H
 8xc3T+OS69qEgwJtEBebLsoofSdyyMmrR8J40T90Ash9nbablRAOjHTI3C1Lk218
 961HitVXEMRS2qnRe+iQ9IVb70yVyfkygGpVZSZINnYPtg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f1tc3hf9t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 20:24:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-91598ab3a1aso182423785a.3
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782505482; x=1783110282;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qRLn7zE1/l07EVzKf2DixLczlAPgdebamMdISm5Dlbw=;
 b=fUkqURM2AxPJSpQZv8FQzVpzotrVHdKJTo/kV1/bT8QLFPUzIYccYsALEsPCY3IqT6
 MPeFa0ReURmgzXTi//glXQIlvIFpMrFxWBsrMwPprtBZAZBLskuGAfLftgp/080sch2G
 7nm91MwnnQEL86pdHVa33l3yz934vrhFpoj9mw/3YfqvbU1vXtBCPB9mGXhmqXTu5Ru8
 LKTNz4Ou2l16fl+gIukyCxXUWDejYyhXRF3XfqEkPdsz9ch2bsQZ9HmzEehdWQIOWCwc
 3oYUbaBJPI/TrUz74avLWkwDkS9THgaYxa9xYvwi0Ii1dCOJ5x84GTL5kZ6CJwwEaT2K
 6VgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782505482; x=1783110282;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRLn7zE1/l07EVzKf2DixLczlAPgdebamMdISm5Dlbw=;
 b=W1DFTc4iaojThxIfOyEZLac62OhKOD8JmJocElxNwjFAVMkaGprb9+Hs6BM/W96dgo
 A3XNtuf9sJI9fFcqkhpuoA61JLiih3SfnzusIqJ0sGK5m2sbCL/AIbvdYPqhoYI7ad1p
 x4gcfivqkbr0Q7N8aZQcyG8QylrbPY3WKm2Z1fCrVFfxkH8Z5WxXGZat/hB4SD3LH55T
 La7J89Tb3hhTdu+w1uRH48QWHoheVrVx2Q/JWlarshZQWYsFAbYb1wZxI/BvcVscuCui
 E2wWinoNr6BouP1r7uMP5uTP9J0M/+F0WsNveXKcXrv2RqBMp0mf2EQ5xyOQVZvLYp8k
 Rj0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CsfFdCVZMKXgZheRlEEaTMy3ElYeDbldDhIiGQK+I28/QxDXMIMEj/VfJuCqnwxqKL4+3/pvw/dY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzQgc7crO1kktLhSD2IQ/dmTsc1xDjyCKaIQbHzA2LK6YPHkJfe
 YE1gPdCeUiEMWu/WweDPpfnKJMUoXz0XH25LcQX0Eer47CbBgFJzGXT3M4HLlDkFll2QzAbqA5e
 tQD2SARYZtER9+fQ3JXcyQ5aKifzDeH5C6pR5fE14063iVaX3z90F2XCaiD9D4Ot2V3EWFIw=
X-Gm-Gg: AfdE7cmeJuam/+7SYHYiExj6wxOzho1dKm0W/w8HGxpsYCpEM7pktidSjHjq+5QkJ//
 m/86xi91SXUtVYm2no8hCGqY9M53Kv03vjr7F3Q1PHUaBDMVDVXhciBS44Z7iDXBNwzJyMFcIrt
 os5Z0uL6so5FEJH8BKJqEabd1LyWmP/zRc22cv17+6B4lZ0uj5mnIBZ+MNEgMpZwFTBeW03y8Bj
 HVS2U8OMy8V5G7s3d/WNoVuDJMSg3pUoX6mFutd2H4341WbFccp12ANV/F4MB6+B7fXMM5F+Dj3
 Owg1bcgXfwXLCyDnkHfEbsYGAmKvN6uMzZxrnjqQ4TtvW20hyrs4jQBh0NEJa/9LsSTjaEY/MO4
 jsGCz6aF/B6N0nRi0MSj/vFdqFv1sH+346VcWZzfy34+FRUfyvAXRQ0Nm1i1MD5z+MCKDfhvpW0
 +5luk+LEzxcGuDAqNEt6nv+CbU
X-Received: by 2002:a05:620a:25c6:b0:915:92bf:560f with SMTP id
 af79cd13be357-9293c5fcd5emr1352924885a.36.1782505481711; 
 Fri, 26 Jun 2026 13:24:41 -0700 (PDT)
X-Received: by 2002:a05:620a:25c6:b0:915:92bf:560f with SMTP id
 af79cd13be357-9293c5fcd5emr1352917285a.36.1782505481133; 
 Fri, 26 Jun 2026 13:24:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5ae9d8fb537sm2601790e87.21.2026.06.26.13.24.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 13:24:40 -0700 (PDT)
Date: Fri, 26 Jun 2026 23:24:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
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
Subject: Re: [PATCH 4/4] drm/bridge: lontium-lt9611c: Add DSI port selection
 via DT property
Message-ID: <yphfxybiao4ls4gnjzjzkjg3fjgn6q3rr2hzxl2ved54ettmml@sdpdoxfh2p46>
References: <20260611-lt9611-b4-send-v1-0-42abbcd3bb1e@oss.qualcomm.com>
 <20260611-lt9611-b4-send-v1-4-42abbcd3bb1e@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611-lt9611-b4-send-v1-4-42abbcd3bb1e@oss.qualcomm.com>
X-Proofpoint-GUID: iKuiuku8Qhv0gcgS5lZ3WOCmp-GC9J0A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX++a1gQk7bIVJ
 podhZM7TITqiiyuhb9eGluaajBKbZPHB6fax24fMM2Evts7HONQARy/ahDLw0MQMURqrjLWAqRP
 Anui/r8eS4LYbVM/E46yKF7CIqc2BsY=
X-Proofpoint-ORIG-GUID: iKuiuku8Qhv0gcgS5lZ3WOCmp-GC9J0A
X-Authority-Analysis: v=2.4 cv=T4m8ifKQ c=1 sm=1 tr=0 ts=6a3ee00a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=W3wm3ICrMjM9hY8d95IA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI2MDE2OSBTYWx0ZWRfX7NjSl00JgnCk
 9zaGjBW10/FPHnODMuKbyX/fU/3emWMudVlxXSIZAu9YCB5vIyMOy2qApE2eocXmm+JsOdp1zGt
 rfsHqDpSw9t5gbpPXkvFwiQN+ztIm8n5I/EIEG8Gg//ZmmbM0V/gnym41nwuba9Frnwm9YlOGC2
 vXmn5wUZFWxo7dpvND9Uh12Mf/D7ESMDt46SsjKt9/NCpPfWRDM+E4/wSP8zwlQc7udNLIqMHPM
 x3FvgEY8n8TBbCZqusBiFpeeBZLnS64D/uq7J+xEJyaxqn9UUpFv5WZbYqVYAO24BQptFwtd8v4
 ikUulaXGE3Srme6NJDypkFFYIzXiXb8BwwNBwHZZxQejrGYsnOWB7uZQY5qGdRDirc+K+lY7Lki
 PyNaGBfOsZ0XVtgLRde1K4qDKGMhAbl9PHNx8wDbzLYEapIleV0zK1TzuUV+qp+dbJ0CH4oLGPG
 CVmQ6CSRok9AuN7/1Lw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-26_05,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606260169
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

On Thu, Jun 11, 2026 at 02:44:59AM +0530, Mohit Dsor wrote:
> Some board designs connect only DSI port B, or both DSI ports A and B,
> to the LT9611C. Add support for a 'lontium,port-select' DT property that
> allows the board DTS to specify which DSI port(s) the chip should use:
> 
>   0 = PORT_SELECT_A  (default, single DSI port A)
>   1 = PORT_SELECT_B  (single DSI port B)
>   2 = PORT_SELECT_AB (dual DSI ports A+B)
> 
> When the property is absent the driver defaults to PORT_SELECT_A (0),
> preserving backward compatibility with existing DTS files.
> 
> The selected port is programmed into the chip via lt9611c_select_port()
> during probe, after the chip ID has been verified.
> 
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9611c.c | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 

No, existing LT9611 driver doesn't need extra properties to determine
which ports are being used. So, I gues, your driver doesn't need them
too. Follow the OF graph description and drop the property.

-- 
With best wishes
Dmitry
