Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476EBFF8864
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 21:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EDAD10E95E;
	Mon, 27 Apr 2026 21:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZ6Ss6XT";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="O2GyTDop";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4823F10E95E
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:52:41 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63RLhSfw241446
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:52:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=CNhntZyoOnGHOA0x4ScHYcHW
 xSRqZTMx43yC0kuuWsU=; b=CZ6Ss6XTBvh0n7I8Jn5kTc+Ex/cTe/aMwy9GsBd0
 TvHeNCdSr6eogQr6g7f61TOvBQGG9oFOyZ1VH2Qkz5+vF+oJWjooKB0pBITckyLo
 /n2O4fJRkSdmkzTnJ3wBaBJJ/62iVJrB23HgXalmxefV0+Bs7mxpyOW1VEHGhme8
 AzH1OsfTMcabuFf0EiE2t5oDa0nwOSDO/0BmhDVxi2zZR0rQ3tNCXcYzFoJCSzKD
 lOXc5glwNc8dubirwbeeyDvewdqc2B0pQFaMvfqsWe1hQH2J6kn6ifpaIWcHhcW/
 q82QEhVjHBW++2FAsXl1FNFIOOlT5x4+TKnZQxYzTOrXcQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com
 [209.85.217.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt946sqn8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 21:52:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id
 ada2fe7eead31-60fdbcd749fso12783082137.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 14:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777326759; x=1777931559;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CNhntZyoOnGHOA0x4ScHYcHWxSRqZTMx43yC0kuuWsU=;
 b=O2GyTDop0Dmu7VjvU71oKu01mpL+iJQ/BUvJpXmazSP9o48mkkH1qHF44comDhDD65
 5HfXUHDzyYU+SOoNzNP+iRaISNBPIZiAwL6K1/yyLFKi52Tb+Qc1gYkdSFgL5piNsp01
 dGpNaVqwJeVT53yX2V/7+nrR3ZBIrLJqaokLgip1FYlVof/fjuCkg+nETd8va+bujPRT
 q34SD4/MRiU0XMF3ulDZT9kx0uzq7ezz6bQHONZrGHDcLQELYNWx0s7YKlko68sc57V1
 sd3UY9pm5lD6yHNZ6Sz1YTaZMN3UN3HzvyU8IDe2AB6JTpRe34w1dUbg0IUP2nvRjL4y
 w7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777326759; x=1777931559;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CNhntZyoOnGHOA0x4ScHYcHWxSRqZTMx43yC0kuuWsU=;
 b=Yp7KpCDW9ggxKm1t5Ggh5h+2hzXErOn+27gjdvcrNe+zr+R3F645LnIT7zYQeEY57n
 bY+rgZRY3wXT2G0ZljRmmDbMT6aAY2CLEvih3rVerrgA/tbb/ChLHyWHkZn1t1zqUFEn
 V4LzoJW2whnKX6ZhBlc49Fk8E7QawSfESNjRJLGptnIvVzZKVzAxmY127J7K2c+pxPdN
 DSq3PbbnZrUIveY97o5yFY9rvXJ39gYUGbPD70BEm51bbaAkZkhW9IB6hPIabMy4X7XU
 WNzHV/d3bgEx1fXgGYWuS+05WlRxADTNdE2Zb0vzvebFcH9mZIQobcjHhBP+LAPDCQ0p
 8/2A==
X-Forwarded-Encrypted: i=1;
 AFNElJ86nqr1YF9Lazcb7Ze3jQ230IPHPZYk/ZA5XoNbsL/1rG0uyxTIVMIpr3n/OhnNJ77ukSDUvCRStaE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyRwVH6ct3eC+9xYoU7QU0+AFmqPG7FIjC06bEl6PoLI0bXhn4n
 9wRIpka+kz2EBfRyb3JkxuD7il2JiVndIgVcbjxrNRzg8JYjxHbCZwiWDksFbljWZa+AEtwTfY4
 mv0Zg6iuhwTShoTpjtEGJzseWiP9fJYNaCEbahD6nBCbyRF05Cvesxy9VBmgJZPmTxA0/kpg=
X-Gm-Gg: AeBDies0Y5JVyHbvex3J1uJc63Yhcbyz+nXPCoP3zNrSCUgBRg2dd3j3SYyT8/IuAXA
 aSZqQXX5917g5Zk/2JdKhhKxRYth90HNhYkByMArTvPUgNRlCDnHnNYOHae9rRW+QskgGmNGMJX
 Xoee/PbLpHfI7dN+c2GWlE6xLMPEvj0VcmgHxngoezJCkoqM+b+i7OlvMV7E/FIPToXjkdUjzKs
 2HQxSgqRKTWiFTOTtnlC+Mv+OccddYmJZKjXj4XshOLO5tH9Hupaw39SkCpSEX6S+exGAyKJw4x
 2akaxsE8v524CX8lDoyVe7s2E9ZbQ2rbwzn6MyEZv+NUfExmi9yuhmBOXrdOXecViWpQ0RhTxC1
 J+MLCzY6kOPiL2o/zulom/012tftLoRr6O6bwWP97d84M10CKVziwnFzpmAO4dwXGuswxItSM8V
 0qK39yuKvSVHIwqYlmr64ep4ddux6NLZSmaiTtKtHYnJC6FQ==
X-Received: by 2002:a05:6102:46e8:b0:613:6b44:3fad with SMTP id
 ada2fe7eead31-6280b3dcee1mr126952137.25.1777326759327; 
 Mon, 27 Apr 2026 14:52:39 -0700 (PDT)
X-Received: by 2002:a05:6102:46e8:b0:613:6b44:3fad with SMTP id
 ada2fe7eead31-6280b3dcee1mr126934137.25.1777326758789; 
 Mon, 27 Apr 2026 14:52:38 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f2e3237sm1638651fa.3.2026.04.27.14.52.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 14:52:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 00:52:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v5 03/10] drm/bridge-connector: Use cached connector
 status in .get_modes()
Message-ID: <4zvprx4mytr22ylibmoj2rsrjzkrnnuumucohodrl75cwntxcj@5wixqw74n6cs>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-3-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-3-d778e70c317b@collabora.com>
X-Authority-Analysis: v=2.4 cv=YcWNIQRf c=1 sm=1 tr=0 ts=69efdaa8 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=ANRcj1VhA4TbxNHgoT0A:9 a=CjuIK1q_8ugA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: VzRE5beGND-N0caZ7ALGMvV2JHJBIEGz
X-Proofpoint-ORIG-GUID: VzRE5beGND-N0caZ7ALGMvV2JHJBIEGz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIzMSBTYWx0ZWRfXxEv3wQbdBa+c
 DzM0ekOfZ/Jddre0+ydkd7sersB0D+IcTDEsOVsJL7T/h0cnQIgPD4Wjp6BzARbueLhx6ZWU5G3
 QCixCfM3tndxjnOAAzN9kUYXrXsyTbeLAUUpLF/kdTb6s7zcxpKJ3nNyifF/DEC4ue3fIBhG6pX
 O+0Xm4CtBjZoUzXKcKQvGFCnDrjP/TjE9GPzCNWXFEmou32qglpZWsTyXnOhU9DESw2dZ6/0wak
 rUdrLBxrQkuWevCxE/xsu15E9WReKc8HpRsqX28TU2Ve+pOCAodpkB6cXtWoKwnF5B+PHnDNwLf
 0HG9t1eHtuaz8SDSWPP09vwvzhv45BpXu0H6A5ZeAnDhe2BkpKdHwAkWRkoVqlG3trDPodfXXnw
 2dRtB9w6UMk13F/Fw4AZnbvrqTJUuJocyHkhx1V01MlswBCEpmNyOS6ByGBzMAfhgAhVZ8jerEu
 wyFfU3+F7H07jgLJyWA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270231
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

On Sun, Apr 26, 2026 at 03:20:15AM +0300, Cristian Ciocaltea wrote:
> Replace the active drm_bridge_connector_detect() call in get_modes()
> with a read of the already-cached connector->status.
> 
> The .get_modes() callback is only invoked from
> drm_helper_probe_single_connector_modes(), which has already retrieved
> the connector status.  Calling detect again is redundant and triggers a
> duplicate hotplug event.  This is also a prerequisite for switching to
> the .detect_ctx() hook, which requires a drm_modeset_acquire_ctx not
> available in the .get_modes() path.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
