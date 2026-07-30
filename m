Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E12AC55165
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:20:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A10710EF3C;
	Thu, 30 Jul 2026 14:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hKdDpD6x";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IAiyaD4+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A21810EF3C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:20:01 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UEHJkN1061117
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=6zNtlF6EBgMK54ivwKze52av
 mGMNXevbSu+B7Qp9w/Q=; b=hKdDpD6xOn8RXByoH/ONerRf5R+Jo27skbtrQrx/
 ss0wVqgwcl5ckE1d84Ql7bRz6BmWViAJZK3nv9m17ZeZ7Xebh+3tcGRbXYN4Eq0k
 +7XkjZs/zVIlzeoi4tiAxCQGXnaLA8SGAtvhW2mh2tWS5lkMgq02Ck9cCuCiTDjG
 fOqrzIK3IALpgKVpZjCeCL/TDiBzH+bQS6aKn9SMPjhabvys0NWyeqrr4KDrCNqB
 McOpVlxw6MVkaDEnj5amYRoYtllfnp9mAwAwg0jtS3LmqI+zLL1wSOxM70Bhcuae
 xbyDj9wTnO3em5nLep4STve3Fsez81Z2VW4OJUVajB936Q==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr88980bp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 14:19:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52827090cc5so10561391cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 07:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785421199; x=1786025999;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6zNtlF6EBgMK54ivwKze52avmGMNXevbSu+B7Qp9w/Q=;
 b=IAiyaD4+HXZFcjfhJSeXixstqvM0O2qY/z+tHwQn72FEjLjDkOyyxuQVojM1D/ROz7
 SSGThtYUdFFUZs9PCUccB/onGD8mxKoz+BSayT1JBI4yPskkC4zdVLXZevJMsqrQSI6i
 jUHCADSFscNPwDHe83nOEOJb8nXl9IKl4g3lmxmQyDqdIsM2YP8QUiho7ECasgwFa5Uq
 GkdlmU6l870yjGE8Fnr1A09qID+F52C0Vl4Cy+K0ktaqmtqL3SIxETPoed3gdt6w83lZ
 yrVMjdR1WEJK7Bh4QScHfUwQGN4o8v4Qqh23PL1DrlRURdvN3qHaWW9THcmHSGxB+fD8
 FyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785421199; x=1786025999;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6zNtlF6EBgMK54ivwKze52avmGMNXevbSu+B7Qp9w/Q=;
 b=gnv4MFkwn25S6JszW8bmJhyOu+pCSr92NNZgB0SKHN8VTTpf60qSdlk1Sgvz6arqKW
 gPQbnpslJbYfWK8HvudW5cCGCt2guBcMI4+OGzoO/Pe/lIKwLd72xwqq/oVUbu+sBsPj
 qQI/3XGQRf8nxZTDV/C2wB5A+x0EcvSTZx482mYLbsrFj6P5ITUvfwOsFybbq5r8g8+T
 LY3cBcwyJIXPLypoZCmYosF2qtMGGCYaXN8Jzp11JEEQHTuj8kK+cyLDnOyY6jnSXK2M
 Tf+mGwdhBoVyZNNJDyTSxuc4+ZArteG0u/wFYKlyRuk4oBcUk6jW6cMpZMxBfZpc2ys3
 YRig==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr04VGwELbPVjFr5kE7gt/JP7lMkbk64Aw1CsPjyiFzFHq9nw6Dirkj2eYRfpfNyZ0kbkP2SmGn+q4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxrSK0vmkw0DD54TepdU9o72WZz4Ebf8oNpe3bxSWFAIcoPgH6V
 eeHW8nCwZQwCv5WeG8QSioO6jpX5p1QUojLBT+2EPbEJr7NboAQk7ACMn8br4mifpwIqvD5k42y
 hk3LdjrLfx7Uxm+4X2x8ns/pOkMHX7IjP257RZh4dP5dd8Y3WlInsYUKZNrvLnajgzz/K1ZI=
X-Gm-Gg: AR+sD12sEDLMtUV4xbi8Y6IkHw34kllwnRT1+sNhUrt/8piO68iyAHAf2AMZjiYoCSN
 SxtBB51DxYEwRh0ICT+9USTq1rR8NGBfDEIZFLXGz+wtcv4NOZFymaiboGg2PPfXVeOzWj/p320
 BObQK9loxk/7bf4AuQ+SUwcr/g1OO4YdkE3+drOUwBnn/wh0SSieo4IEdCJsMQvcjwtOafFwMe/
 1PccOVPqxaBWKmgWd8M3b/S1QSa2fMQ9sUj1IpCGw7vxCEXjC0NOwzkZcCrl4cv9C9a87Y33+GQ
 IRzhXTLEc8gymqeRrjBaHPYk6pYICpkcfnJ4VLN7ilkdJbLfpkZVmGT2AmBMtORG13adSaP7n6Z
 EbAUxwqeEJ93htJ4rgrZhXxGe0SdVkmoWT44miXFMyGphN3zX6DUmjn84DPnlBAC9YUxBNM1WYs
 3iYZNmWGafI+6ykw==
X-Received: by 2002:a05:622a:4c0f:b0:51b:feb2:3827 with SMTP id
 d75a77b69052e-52b42618677mr6293431cf.32.1785421198998; 
 Thu, 30 Jul 2026 07:19:58 -0700 (PDT)
X-Received: by 2002:a05:622a:4c0f:b0:51b:feb2:3827 with SMTP id
 d75a77b69052e-52b42618677mr6292761cf.32.1785421198521; 
 Thu, 30 Jul 2026 07:19:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6ac5ed84sm3374311fa.25.2026.07.30.07.19.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 07:19:57 -0700 (PDT)
Date: Thu, 30 Jul 2026 17:19:55 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>,
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>,
 Phong LE <ple@baylibre.com>, kernel@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v9 02/61] drm/display: hdmi: Rename
 drmm_connector_hdmi_init() to *_ini2()
Message-ID: <e4miagjzyvyxxbhbznze3ht4vvnqx5whe24dl3w5sdgasafdmw@gblajrkqr3mc>
References: <20260723-dw-hdmi-qp-scramb-v9-0-4fb12ea22ac9@collabora.com>
 <20260723-dw-hdmi-qp-scramb-v9-2-4fb12ea22ac9@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-dw-hdmi-qp-scramb-v9-2-4fb12ea22ac9@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfXzdtWDx2MzWMT
 yek4CCIWlHT+zgKWM09g39kWgIBBDt2u49gKd4HcIl7YjBWwZEgLIoj9qfaK6f2f7ZyvDeTWs/k
 88JEVK0Xzly6AU3iTSEKHl1QEoDTiDbeyslZE6QJCH4o6amMB/nJsxk2nSytjR/k5GaA3dGdJ7S
 pXLzdya2mW4FypBtxd7AyzxsiSKqgUY84mkQFPmQcVaeKs2vaIxX10jJhTupqVQ5QdjL+AV/Aed
 SmcWX0ti4zUYic+XXlkvMQjx5rLXu+iXUU34pcjNC8wlVJXxXonKsVeqMH4RzjWwscRMoh55Vj/
 Fy/xhabxwm+Bzz6UeJM1q1iM9Se74Uqm+RjV/NaB0cXsBEf/I9vSqP9HQSuge9aDwwQkvrCsfC1
 3/9xJDN1OxeF0Pah1IlIiWvQECMVje9JUcaU8t7LwqmGBMGvIT8KbEqQzHxFOuOu5/kmqimfVV4
 EGOri7szJnVQE24yHFQ==
X-Proofpoint-GUID: 6s8Gc3oJ1-704FxuWLfK4uq8XEGiFR8Y
X-Proofpoint-ORIG-GUID: 6s8Gc3oJ1-704FxuWLfK4uq8XEGiFR8Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwOSBTYWx0ZWRfX/XxN3SzqK36f
 BmU5F3fXJkMSLLVlu/xtePRgWlug/G7QCrp7hlDc1OS8kBRcRCf0YezmrKT8fcBIa221l3+xLvF
 DJ9MgmdHo1lwgvT8zXZABmt9QheRAR4=
X-Authority-Analysis: v=2.4 cv=S5HpBosP c=1 sm=1 tr=0 ts=6a6b5d8f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=uf52Jz-x5RUOtouhqywA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300109
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

On Thu, Jul 23, 2026 at 04:34:51AM +0300, Cristian Ciocaltea wrote:
> In preparation for changing the signature of drmm_connector_hdmi_init(),
> i.e. dropping the vendor, product, supported_formats and max_bpc
> arguments, which are being moved into struct drm_connector_hdmi_funcs,
> temporarily rename the helper to drmm_connector_hdmi_ini2().
> 
> This lets the new signature be introduced under the original name while
> callers are converted incrementally.  The final patch removes *_ini2()
> once no callers remain.
> 
> This is a mechanical, same-length rename performed with sed:
> 
>   $ git grep -l 'drmm_connector_hdmi_init' -- '*.[ch]' \
>     | xargs sed -i 's/drmm_connector_hdmi_init/drmm_connector_hdmi_ini2/g'
> 
> The transitional name matches the original's length so continuation-line
> arguments stay aligned to the opening parenthesis, keeping the diff to
> the identifier itself and avoiding re-alignment churn here and in the
> later conversions.
> 
> No functional change intended.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c     |  2 +-
>  drivers/gpu/drm/drm_connector.c                    |  6 ++--
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |  2 +-
>  drivers/gpu/drm/tests/drm_connector_test.c         | 42 +++++++++++-----------
>  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  2 +-
>  drivers/gpu/drm/vc4/vc4_hdmi.c                     |  2 +-
>  include/drm/drm_connector.h                        |  2 +-
>  7 files changed, 29 insertions(+), 29 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
