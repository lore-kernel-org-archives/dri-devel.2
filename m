Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FE33C44533
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C43210EC9B;
	Wed, 22 Jul 2026 07:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="kyiAT1D8";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUqhyK4m";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABE610EC9B
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:48:28 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53bD63882935
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=vleywJjGQkVO0x510PGIAoh5
 WqM/nmE+oyHx2voXORI=; b=kyiAT1D8s6vwKDeBtT+U+vIjL16dCKJ1WUr8HNGy
 S13OLvv/kphwJgtrfaBooHWRW67+M13EudLaKKn1yKG25JTPjBmI3U9u6OSARjcp
 Knt5FuBXlkKa4M+1RLrS8KsnrCYtfwjaAjgQ9cS3RFl27Nwiz9z6gpVhrPF5fTTx
 wW8SNi47Ojw2Dv+Zi1q5ehlUCOW5uldWy4smVL/AHxOuOxbEgh30aJuRJU+OwUB6
 BJmEaaJYvTyhbSdo40mMsT/8s8OilhJlRWamSKnZqWxwH6BkoAQc/XBkqAySx3s6
 3dDm532rp59N6bcvVnuUDQ0P1Q8TNxh4WaULc3V1p5QBAg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjntn0ydr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:48:27 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso240273451cf.0
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 00:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784706507; x=1785311307;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vleywJjGQkVO0x510PGIAoh5WqM/nmE+oyHx2voXORI=;
 b=fUqhyK4mMHHC1SW+y+YqAMcFwuwfJQ0CYiRXvpqGUoDOCooSVPPffK+b54vCKA1sbP
 b49cYM27HhF+eGkB01Wxqs7+G6ndZyqP4CchAqbXOUOVx8wTgtDBaw8G6K7VI7LWUzes
 2NR9H2vB7lCXQKVJpZByiuVHkm47XMa94T4R/U/EiPCobRjsCjQ1I3tFBcADkxX2SWR1
 j6bltOAM5dIQqtE8dutyYbo3cs80E1Vyl95rgU9J13Mq0jAwqcmebLy18iZHWC7TPiZW
 yOFyVvf2jfq8QpLRxRUO5u0evQpQk1hrQmi9hj0KIk99rtSuri1AnLPuLbWsLWpkSOx3
 E07A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784706507; x=1785311307;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vleywJjGQkVO0x510PGIAoh5WqM/nmE+oyHx2voXORI=;
 b=jA5ZGlrqGd9LDlRXbQA5D4/MaansTQUa/QQWAnmDCwOGZYu+nOs/QFSB637UtzW2o3
 bJKfHyY8jM9kP0J7ZVFWNIbGkRu/8OKrAeNPRLlFbVVFUuipO1ZbPoDIF7t35vwi46VA
 9GivsUmQGSBltFmFd1/pOitl7Vr9b1IatYb9Xo+xyOc/pbruZFM+B3nwkK9AgSx8qMlH
 F8CIhvdB589GaicGph/dk+Ir4cotCge+sHTAnUgZBLFNI+3Ws+D+oiAFq/ahU1x1TCn3
 HMXTgjdGERCkAmXbc0lvTIWJG3Ll8fMVPOb7q7KYJs4i73dwDFbo1COoIsqJYyErTdw4
 KUYg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoBBD2TiqMZG+hPOKvRYhT8zUqSA8Iqikxb/AKksy9M5NVkO0vjVNDpBFVsy8S2ee6rQl09wIujOw0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6B5VeAC6G7K3+jPePYZFVL65t7DA7WGFNlbrs79Ku0MlrS8MM
 Zrfrw0bTe+JcuOiUW5H99tE9Dz+8DMDcdM88PX1kytQN3acet6V5dJmvM6b4qSS6prQeiNfe9Ru
 gL/K6SRQk0ouHOM5hUZF92PzvTMcgHnmmXmi2nHvmJnJUFYcjhZOdlnvoojo3u9ZSF4MNSps=
X-Gm-Gg: AR+sD13rbwEMk6NXJc4sMYjkINqE7Jm5Zb+ip4rv2soJmV5Hi4Tj122UF1Y5qEJhXsn
 J70qssdyCPdDJZE9wtbANjCam6PmaPhG32t7sdCDZ/1Je+sZ4V4vfUsjzG6S+X70Ew/Y6QTo7py
 yWI/jlzhiI5GBS5TFx7xmyd+8Sn9kbhkVWZjvtKYCqBRhJwotxMkZ3GU92KdlsO53H8oJX1iaI3
 v594Yc+lVCT5TRPLWxfWunNR4xS8vrniQhsqxx7QV4zhvr2qDjb6KdxUjpq33yyUpAVYfF5DaZg
 orEvEvCZDYwNmVGmrjeSORBAmSEcb7JYWmAPefazmciOyAsfFb5QwqswNWjkKUmnp+A57Q2Rn1i
 hxwwImkzYt39E6df1b875RuSJgnnhqw6CKSzKrCmE5nx2kidZYmqf/iXRPg4QhwKfLpBiGT//ws
 4So2oQ7J7zl0GUSA==
X-Received: by 2002:a05:622a:2309:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-5213c5f3e3cmr196654381cf.19.1784706506958; 
 Wed, 22 Jul 2026 00:48:26 -0700 (PDT)
X-Received: by 2002:a05:622a:2309:b0:517:580c:bcd3 with SMTP id
 d75a77b69052e-5213c5f3e3cmr196653991cf.19.1784706506484; 
 Wed, 22 Jul 2026 00:48:26 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39ef6886b50sm3142311fa.6.2026.07.22.00.48.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:48:25 -0700 (PDT)
Date: Wed, 22 Jul 2026 10:48:23 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Daniel Stone <daniel@fooishbar.org>,
 Hans Verkuil <hverkuil+cisco@kernel.org>,
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 4/5] drm/debugfs: Move HDMI debugfs registration to
 state helper
Message-ID: <6mdvpbcozxkm6m4psgz63lja4i5l2cgz6six3aas4rurgiqh2v@r247m6paaaiq>
References: <20260721-scdc-link-health-v7-0-92df1b6ad5fc@collabora.com>
 <20260721-scdc-link-health-v7-4-92df1b6ad5fc@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-scdc-link-health-v7-4-92df1b6ad5fc@collabora.com>
X-Authority-Analysis: v=2.4 cv=AJsSZ1gA c=1 sm=1 tr=0 ts=6a6075cb cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=QX4gbG5DAAAA:8 a=EUspDBNiAAAA:8 a=VQDRRO-cRQiftV9tIq4A:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: jQvjCZmKeVAs1PHuTwlv-Bmt4ALLhKIL
X-Proofpoint-ORIG-GUID: jQvjCZmKeVAs1PHuTwlv-Bmt4ALLhKIL
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA3MSBTYWx0ZWRfX5LDAmk2e0SPX
 8C26/HbZjrQXm2j8UPKLkRgW5B/7o4wXl7vRYK5y8rfcCXXk2MeV6Ui0KJ3ObktMEOQ64KzlKiw
 G0gqW6U095QECZUq8y/WbHrJfTQWDzw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA3MSBTYWx0ZWRfX2sIQH9xnDVsh
 tI4ozAEmhLwDg5qx3WbELKIGZXCGDgMtwU46zf9VlcEoJz7X3bm77tIpXQEqwcBvXtd0KfBIMZl
 pAuTISpqn8fnpHU/73Mp5zHOLIEjJY6K7Wb5zP8v1uwBmDImV5xN+otRIK2PRP3vtM0bTCrjS1P
 6NOM9th/45nVAitdn6lUDjJP466W4877kx0lxyqttOx+v2j12Tk2VQb3lm2uL15paERP87n999f
 LeIze/moPyPdMI6LaNfGGvsEUl+/WuiJ//HL2RsJMzs8er1Ns41bJBLvFLBD49iKbZRM2zvP7hB
 j4gzNPb7+65JSzUkjiLQmIF53QuwX6+ltAU+2uETKuhoyrH60BanXOotFbuyNpOWziQHe18zUYt
 txhf6S8MO++XccKCQSxeC4r3A7xPaA4qZJkeW7xliTzCS6AL4Q5HuYs1PWy9paceCP+Djmcg/LD
 11hqOqRAAHFsR9zGctw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220071
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

On Tue, Jul 21, 2026 at 10:59:00AM +0200, Nicolas Frattaroli wrote:
> The HDMI debugfs files are only useful for connectors that already make
> use of the HDMI state helpers. In addition, relying on HDMI-specific
> functions in drm_debugfs.c can lead to circular linking problems later
> down the line.
> 
> Move hdmi_debugfs_add() and friends to a new helper in
> drm_hdmi_state_helper.c, and make all current users (vc4, sun4i, bridge)
> either use it as a debugfs_init func, or call it directly in its
> debugfs_init func.
> 
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c  |   3 +
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 154 +++++++++++++++++++++++
>  drivers/gpu/drm/drm_debugfs.c                   | 157 ------------------------
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          |   1 +
>  drivers/gpu/drm/vc4/vc4_hdmi.c                  |   1 +
>  include/drm/display/drm_hdmi_state_helper.h     |   3 +
>  6 files changed, 162 insertions(+), 157 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
