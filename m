Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1245CFF885D
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 11:02:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3F010E15D;
	Sat, 25 Apr 2026 11:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="HQaWP/zU";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UTOLPRxl";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF8310E188
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:02:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63P3k2Yv1017004
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=LuIbxZ4UGkr2MNHoHHNNbGJq
 U9tVlBHwrX/08rcaVp8=; b=HQaWP/zUUv16lKqJeof414zvjCEHqwtLTwHORYrc
 uuNXKoXfW5xGdbfm7Ul2EKQS01bgJCvGTn7tFrXPUj4NBCTi90rDrtl3v8QyNe50
 DtQQN7s1AB4G21yOz+YImxfApS9x3qvQrARYn096MMbdRHlaPG/xoinPcHGIKf1E
 tmgDhWBQPAxLVP1SypmeoVoGibGc1VCqey3Loy4wTxCvMMvPDs/U99gKAHIOz7Gr
 nZCj7rWqTMAhcuLCqlUsZzsm3E9TEDKRIyEkHrEZ51znwV/lYgZDnpM02rejVviM
 8MXPjmeovoPfg7Q6u7PSJEljEZglSRT34jMwkCOUNjnZEA==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4drp07gqx4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 11:02:29 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-94ad0ada31bso16135172241.0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777114949; x=1777719749;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LuIbxZ4UGkr2MNHoHHNNbGJqU9tVlBHwrX/08rcaVp8=;
 b=UTOLPRxlHyRHNPIp3cPRVlVBYf2cwANu6vGr7n9RE27rg0o7W3pTEKsnluyyuKC47x
 agr5WEfU0Sc3YTPM2khoRK7xLPORRRCByOQLy17xWOpwwMKn/kN8Ow2xCO5zMhzCW4zV
 Q4Iaz/aYv+2YdACmwT+d8ti5cLHajWfrjGiSI84EjgC5qJvDpelaIRsOTThL0OHTYFaH
 LM10vO1l9zydXWRJg7oJcFjxlij7Q33sOyRvnV1wGNBsdQW8zvTretFLplCFr0YLQul5
 sdMWmUumA8fH7DUx6DgsRtPLHJ3w0PzKUg/4NPK2D5IxDRkyByQEqpnmB0+N9+ggRGHl
 i2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777114949; x=1777719749;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuIbxZ4UGkr2MNHoHHNNbGJqU9tVlBHwrX/08rcaVp8=;
 b=fNc6qsW2nfvYmDamGl7DLgT57iDCAjOF/H7dauTKWmNObBqb6yp11icTZJbVhiH7H1
 mJfhPDFOQHzkShhNeyBlmAeG7s5FILnIVCKzmXzJpWPPeWuJpoee9EqwM7dl9zcz2FBq
 6IM2BBsAFWDFXDSKmrV8V+kgk0Keqd1s8i5iBI/+zPyJ/zRwsvCbQr8zX6MXCRsWxJW9
 XHnsOlSsKWmvnzT4x6yGb1Ruq7qP2wN5AczkDrA6pQGrCtWrJesrggkqSPi76Qak0toC
 dTmHnGBb9/fahKQ1MELyyqNY9GWreeb8sYtb8TLak6no+RmsibtKsvRyg1qNzF+lY+th
 Bb+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SNpFLBCgh8i4Gc/GMrLgX4fWSEDtqQ8oXOEkgNEk7EKaZAqXK3ALIgT+COgHBI4xA1mLyeLWzMDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyf0jkzPQ6qRL/ycW0wwbgXYZqBLAjYekedRt3SuRG9zyLFwFqz
 bxX7NOIKReTgVFxwcP7O0UlniTZ11PLzpQy3SbliufKYSDX45Qyj1N0MghnK76kW3GtDuNBN1Hh
 SWBPnPm19yfXMC78dVDMufRkKVr8lsFcoe+G26R4S2ockBTOojU4/yXGgx0m16tSP6m13mCE=
X-Gm-Gg: AeBDieu+rP8+OUyZuk8HXQca6I7jQuT8Zp42z+9QF0y1pbgBuLCQKMqMpwPlpWcXxSr
 K2yHWT2Ndh8230NK/BHephvJeYsbSKoL++3Fl9dKoeSIO6gEGPp7myW+kAt7Hsv0CDIsgclds/r
 zYn/SSB/d9KvZl4P663a36pESxudEq+Xg8MnZ0tKc0fhnZusut8tPwJ+TO8Al97q+xyN5L49z/j
 87ldYexIQKA2Gyod8riqPxCCJITwLuGaARBfVdC3lDAgdg44SSdr1KhHo4XSVAnGPPrMbKIeES5
 dvT8XsSWrOHUaPhWgtsBuwxw7SzN8GGRBBZRT8Dlg5iSdx8hqdjlt6qo8F5mOcHWD4Ht8a6kYNO
 AZgrLNNwrFAEhofcRCir4ow82G8I3j+G6EmMeCBlUI5QKcBQIg5FUsFQlhA4SeA8ycbFN2w7x0U
 mGU5Z+gSTI+NSaE67PhLzALvFYpOVCqcvmeWy+51/nzYDXeQ==
X-Received: by 2002:a05:6102:6a85:b0:607:ccde:5c00 with SMTP id
 ada2fe7eead31-616feb7be9cmr12845683137.21.1777114949259; 
 Sat, 25 Apr 2026 04:02:29 -0700 (PDT)
X-Received: by 2002:a05:6102:6a85:b0:607:ccde:5c00 with SMTP id
 ada2fe7eead31-616feb7be9cmr12845654137.21.1777114948825; 
 Sat, 25 Apr 2026 04:02:28 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a4187ebfd6sm6609501e87.78.2026.04.25.04.02.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Apr 2026 04:02:26 -0700 (PDT)
Date: Sat, 25 Apr 2026 14:02:24 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, kernel@collabora.com,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org,
 wayland-devel@lists.freedesktop.org
Subject: Re: [PATCH v14 05/28] drm/display: bridge_connector: Use HDMI color
 format for HDMI conns
Message-ID: <uwmhvmgnhge2vez5yussn3swgkqb4scfir7ls7iy35v4ewifmp@br3ynryrptzb>
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-5-449a419ccbd4@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423-color-format-v14-5-449a419ccbd4@collabora.com>
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=69ec9f45 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=QX4gbG5DAAAA:8
 a=EUspDBNiAAAA:8 a=gN0RDaQLg4mAccs6Ca8A:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-ORIG-GUID: LvyTn9_sPlNd0roJhaH4rOBPMRo7RB4w
X-Proofpoint-GUID: LvyTn9_sPlNd0roJhaH4rOBPMRo7RB4w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI1MDExMCBTYWx0ZWRfXyQEmK23jyRPI
 pOfCaXYkTMpqV7JiossdwDK14I2rX7bWodPPicNd67EK3/RYzPx5mPxbGzZxNH3lKphIHzCzGXT
 C2sZ1MsxMOWKI1e7shcOQT/QRdranHKQy1pJkhpJ8clJ/r1mYtkv3cbllIt9/wpM4P6Qy1kaU9v
 mbgy0rJgSiSf+PFRID7D3zUd79gwBQ1LwnlEXBJQs4IHGYtx9n9WoqaBJ7E94RY4sUGM/F+4wxy
 Ut8+7sodQdXfx4dPbwgCeFfbDuAFLQIhm8jHM/6hzqYGFXDeKss4xcalgJ7g11/O46e5L1jW61m
 ZegB7onhI9eCiTtjXeKuYA+SRqbF6seKgPHtQ/5J5vgxuxJkBPKpXFu6As+dBhyDDmXiLwgxkIY
 K+upZvTEHiTKvRB3bEXE5qfr8jjviWUTZSCakZ1QMhCWsrgsmUFBhmEnvOD3BkOc85DwTC11FHy
 AA6Kogm+muCyVCjoQaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-25_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604250110
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

On Thu, Apr 23, 2026 at 09:03:28PM +0200, Nicolas Frattaroli wrote:
> For bridge connectors which contain an HDMI bridge at some stage, the
> HDMI state helpers' format selection logic should be involved.
> 
> Add an implementation for the drm_bridge_funcs color_format function,
> which translates from the HDMI state's output format to a connector
> format for bridge connectors involving an HDMI bridge, but return the
> connector state's color_format member unchanged otherwise.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)

Thanks! I like how it ended up looking.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
