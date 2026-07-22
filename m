Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA621C4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EEF010ECA2;
	Wed, 22 Jul 2026 07:38:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GuOcay4k";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DWh5r9Ca";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B4D210ECA2
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:38:25 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M6fkLD200282
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FcjqAeTgLsiht+7guJ7zeeOB
 F1xXICcGZUBcywGzczU=; b=GuOcay4k3SiU6XYW1TYKYeaOIB1q6iMvGt8XxwgE
 163liQqUGE2TrlEk1nkbZ6ioNv5JA5t3kPcOO9JfUwmLE4sEaLhjj7tVXQjcm7GW
 IJ1ZAcYdoD2IzEIQdjg/5dKsxjrkZpkASJfp511nIVGX/JDPxpn9aQr3sz6iWMuF
 hcqiKhFfWbruZPaVbhWij2HD1vIHZTD1PHgz5pHFzIHlgNztZ9iya0Ty/t1yMAVs
 2iP4Wa5DN67DBVUHMGeMQqL+bFV6A4FIns/X35qe8Mv9ZuQfzpiRFuR3tn4yOkWj
 yfs7oUzk0Ts+ZvG6DVp+bWQVf7Yq4qs9pJCqvxdtWaxu8g==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjrtt082k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:38:24 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c0199faafso188340941cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:38:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784705903; x=1785310703;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=FcjqAeTgLsiht+7guJ7zeeOBF1xXICcGZUBcywGzczU=;
 b=DWh5r9CaAo70kSwaE3apNdnb7nTLOr4agVSwfBhrdnwYqwxRGd2NrogRz33aMcnd8j
 bwiC+Go1QlSHzIL1sMawsUMwXizNIJIdEhEN9JTGXdGC/3yF/xpJwM/10+2ZSkvoj1Pg
 txyyfCQ6MRt056qmdDXljkgauWaYgKcCprjZhLA7bGGBGP5M+g4a8b4HK3CjcXhnG9WC
 6rng7I6dLit0E3CI4APztCXuJ+U+jF2YMEnRWC9HWnJiEOI9bGfDeWGNmY7CFLLOcetk
 KYDTwkvy23AHvG5sY7hIrSjS5B505MMpJGeLwiDhvMCo+ULrH/MiwAYExD99d8902Stc
 nl7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705903; x=1785310703;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FcjqAeTgLsiht+7guJ7zeeOBF1xXICcGZUBcywGzczU=;
 b=l+VYxqxoTDRnvzQAY8474ZzxI3IU/I+voMITmMRIHf1wkb6cIc5GP5WgOiS9p0ZtOE
 HhweKBkBBfxkaX8VdUntlvD3nlHF9dRkkjnPP9E8RQhgcCl/kfg8uFjYMmGWVqg9v8m8
 kTPsKVi54Nm1fjrLVj8yIzSCUj9Tq1cfKVLDX9zzMZzV9UFlLdcVQ/5/ci8ZZxmQIcHM
 ZnPeoHCqkJr9MRuKJbh8uOHHt4u+PQfPyeQLTB25GEhI8UYlzbRe5w5duIzsl+DwqiUh
 P8oRLQYFygquCbZD+2tPt+IB+KMfM4a/Fz47EUecvS3Cy3r1g39hImBXkHQ4LV+KvPCS
 RD1A==
X-Forwarded-Encrypted: i=1;
 AHgh+RotMHiZXIiVHjPwUcS0kP7BXM4PAcItvYZ0PXfh3r7qa2sF6ldLL9Lk/3FyCLzxGAvFbVaqZuVEnrc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx3qNNjcN+Z1zqcE/QapnSXMBwk7q8jL1RQut+/USP+8bLH+r3E
 Jn8AyO1qQQ/kUtkVQDlDimr+szjOh+IJ12+2uKIJfyOQwVIsEARVKyytDgIVgj8YFziaFOkcchV
 /Xw/nmgLt4wBzuHlZBGc1vybdPPgGdgoEzICtzNHvYtFbIWpr1XJqtmYXODUKmNObb3/Ujas=
X-Gm-Gg: AR+sD12Ckbpm/u1gUoy5AcnxlMcjrUZKVgPItfslSZc8pSe/N12U5qXwgo+zpBhpHWM
 EXCuNUtZpwwScineaLcthCQmuiMrdcwICNLN55lFBZXNtAKruHzfbWLQJxjk4wxvet1dL+CTRGM
 T5OM83mHJjo7cKGQ3RBVkmwBHOcPh884UJo76k3npPzWCkASc4xysFSwJtb1N3Lt8HBJNCWilDk
 uLxJbUVWKoClCz0JNtB8IQ6Fl9NrExQ35Opd6GcnjXg5nxFDDiGe9H++zV3iYR4KQ/4Tw1h27Zg
 vcT+Z9eLn06cc4/kyGXyhWkgI0WIRIqRfXoYQx5QKE4g2gUabNNSsLVHe49XiiPGWFE929vUoAN
 C7ZhdJWQtQXsUW6Zd2iuKGaW+6O26ClEjX1O6bw6mKt8KTvpkzjkgE7HAQVo2npkaSRZNjNZJ5y
 XfS6RK2Lurar64LQ==
X-Received: by 2002:a05:622a:1b9e:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-5213c5f1d1emr190722251cf.20.1784705903330; 
 Wed, 22 Jul 2026 00:38:23 -0700 (PDT)
X-Received: by 2002:a05:622a:1b9e:b0:517:7b6c:445b with SMTP id
 d75a77b69052e-5213c5f1d1emr190722051cf.20.1784705902886; 
 Wed, 22 Jul 2026 00:38:22 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9e44b97sm324394e87.61.2026.07.22.00.38.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:38:21 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:38:20 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, Daniel Stone <daniels@collabora.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v7 08/30] drm/bridge: Add HDMI 2.0 scrambler bridge
 operation and callbacks
Message-ID: <wvkcamiigekyjdmlsngeccjzkjtfetnmb6aavikvhqk6ave464@5fs2g6uc7axx>
References: <20260602-dw-hdmi-qp-scramb-v7-0-445eb54ee1ed@collabora.com>
 <20260602-dw-hdmi-qp-scramb-v7-8-445eb54ee1ed@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-dw-hdmi-qp-scramb-v7-8-445eb54ee1ed@collabora.com>
X-Proofpoint-ORIG-GUID: FCO1589nHGr338QIfj7MFWbKyig6ELB3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfXydP4kIVWt+vd
 Xx+zkNbl1OtI5DXI6LFJkJ6Xl0qsr9414W2hGZjoNoSFP8jFLsalXJSfpD3Xyby8XUoKki3/eEB
 Y4vM9du2kK98O8ledSMr0I+9G0o0IAhWVKHtWJHrIwP8l0lgKH4XMUF+A0MI9ea+BW56osnqtSg
 lhqqhIjGQl1Skw/rGTx/ynWFQ6K8bNRpmfcFhhB8BdGV7x0gsq1q6vcVGaVpbeenBY+Q8YvHmAg
 nnHQesp/Bda3/SxtjJHhSxgGaVd6hzLuiHFda5LpDeVWEbpFePLpUCA58ffRV+wSfdZzYVKVKC+
 wTWDNkNM0F9zjkUDUedXN+NwxCUi7DWpmhl6zz8rcGw/fL6fA0+s1YrbY21RcG3/iohG0vNjBJm
 r6GlteMt87r3tj8eIzoUbGAj8wK+7NXoqfII632dRyj7q3dNezxvPSx6gbQUDo7luKfBTAHBZNQ
 Zkj5FT9HfltvWOn1n6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MCBTYWx0ZWRfX1xdU2R2EOZ/M
 OrFm76f3upk3+IDVfOlhT4vaon51YP99E8EU9ydznQD+ipTHDk02EEke0hzNCgdJW3MiFihLliy
 Mo/O/uhKUFTBSzNBvn0yBU+hmq8wis0=
X-Proofpoint-GUID: FCO1589nHGr338QIfj7MFWbKyig6ELB3
X-Authority-Analysis: v=2.4 cv=V8lNF+ni c=1 sm=1 tr=0 ts=6a607370 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=PX8HVTZbq2s29_-t98EA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220070
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

On Tue, Jun 02, 2026 at 01:44:08AM +0300, Cristian Ciocaltea wrote:
> Add DRM_BRIDGE_OP_HDMI_SCRAMBLER bridge operation flag and the
> corresponding .hdmi_scrambler_{enable|disable}() bridge funcs callbacks.
> 
> Bridge drivers are expected to set DRM_BRIDGE_OP_HDMI_SCRAMBLER to
> advertise that they implement source-side scrambling control, which the
> bridge connector layer uses to wire up the connector's scrambler
> callbacks.
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  include/drm/drm_bridge.h | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
