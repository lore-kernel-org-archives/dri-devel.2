Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7175D58CD1
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449DA10E39E;
	Mon, 23 Mar 2026 04:07:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YwKTM3sZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X2RAcwbr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF3BE10E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MKenPD194123
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BxISgP/fl36GplI+JqnlrwsE
 hA6Bu39iBYyi3QEp08k=; b=YwKTM3sZOJdgT3TAFMPt9LNyf5/D4M6suM8CSNMz
 BYaBOWI6dfGkap/oTUuKXyHdTV76LQO+9/j0vAZQ0jswoAyN+MEvvvLrMyl0BQ34
 rnzQUQ8L9DpbxmTPRdcUV/2nWH5zyvxSxuM9D/36mwIzddifH1wH3axnG8ak2HiZ
 1hagwh+eOOrVVoWluYEbH9ssQiyUwKI2Y4YQ7gjbNiieW1uFcgjBv2EKwnC8zZIC
 NWDuxi4fdO4w/70RMll+U0fRHhJrl3n+AwdViEiCZjbssrUd2kLXTXBxf//VrTXY
 1Nlif3WY1gBVNQgZnuiCrQznq6IuNnSYjdYCxjR8ySPuCw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kj1kjc8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:45 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b34223670so74045101cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238864; x=1774843664;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BxISgP/fl36GplI+JqnlrwsEhA6Bu39iBYyi3QEp08k=;
 b=X2RAcwbrDdjyar+LGObakTMDAaPl+XEn7KdQxasPnaN8GPNnjhyQHpwXkumHdlwZfs
 H0o72qNGC0OyUeragYoTvwf2gVwSRwQXgP1mqtBoBEzoW6t3zINcbE/BD27q9VF769+w
 dQ74yYMFipq8fZ7ZcBj2/VrCnfYyYkPoPouJ+qxLGbma6PfHoxkGgJCp3XUMX5DzHO+n
 TGrcf6py7oVldp7//NODLtoMC8L71Qm6GdeWkucfBQQaVpv5FcbHxgLG5zRLAxcfWZCm
 t/snkErZu86x5K2iAWdi1q40ENPZiFJmHN6BLDNGfxErof+/PFyoXANrh5wsEEUhkc6f
 A4+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238864; x=1774843664;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BxISgP/fl36GplI+JqnlrwsEhA6Bu39iBYyi3QEp08k=;
 b=DyCgcFPxUlh+tMImiLEjgppeLYo4sL5arNxMe0i3iQ1w+9sTMgl7/i4rcHt1pIOlPj
 NiSmmAxtiSmhynCE2XrNIzsqK4dmYVVdmbk7yFWySng6HX29pHjuVC5/xm2fzwxtzTov
 +/w57aY4FjaHHyqUW5mf0d0qMkPwLeGtD5ITMEPYcCzCKQPb0yH65/V51+/2ZXpv7Tkh
 zNSjSR3I50PzNVuBGon/R3uHsX7BHWNznP1t8hbiKnTUc8Am+VISlufgBgz1gdb8CsJp
 ZUdh/3k7bfloWx1b4wrCy0IhbXBEsKegWHc7GYEA/jOf27Gju/ovToe5fMAQxH91MTEL
 kAig==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMrQC++Vo6YvQGFD5eVCtwCBrfU0spbd6FLR+JrZYnWcZM+zAxdJyaKLZz74k4f8w9Kt64G2YwV7M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPni663fGtUxawjUMaAW1SbPKwb7ilj2sHYBAhcbcE0T3PJdW7
 gxdPFsJO/AD0ESvI9eFvf01zmcBJTwQJYq2cLR/sHuxDOrR9XA2mh94lhgRbiUcJkKUq57SsqCQ
 oUjaB5hk8u8KM/Htu9aexE9NAFxcs1NZNMR7CAQyxuHef8j1/YisKtZA9XYKZ37wEIXBcfTc=
X-Gm-Gg: ATEYQzz0YU5aFxete8uvxRNPrFbs12KtO40BW/HzOYqoqvKfu/od2nLDEIdh/WPsivX
 rsbocMKgUBC22rLoL0+lViIV4I2vhtXAPJ9/H7FtfahIFrPrNPUL7GhbxoC2fi1kDBg6Bv0uPnk
 t6RSY/0FuIFie9HM2xRVP//tmKHcDJUD/TD74ezoz0pxcvKk0rH7pBdSATb6XPMK1L/qQ50vRT5
 T46gxEiYzqCAnrwrNR+FP1BV4/4VRND/c6YNIa4aJzSriisJFCf3xsJQqP7DKWXN5/zrMQti5tW
 MOGuZ/txOOd7U3li1U4vORq/LyajsttPdjqpHSH4LSfadbKPb0m3WBuOq9MSfg7n9xR9/ZaEvMP
 O8BqwkUnwzSBqkDNEZ4Rm8dJ1FTONhiVlcH/S+M/pvgrwPTq+x43m0HM5hBK+Mvj1zrGiu81XvD
 NZK49bXlQ6RA5cRy1b7olJJcyoDQORF6Fkjp4=
X-Received: by 2002:ac8:7f0c:0:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-50b48e34b2amr101887011cf.18.1774238864364; 
 Sun, 22 Mar 2026 21:07:44 -0700 (PDT)
X-Received: by 2002:ac8:7f0c:0:b0:50b:48e3:47a7 with SMTP id
 d75a77b69052e-50b48e34b2amr101886631cf.18.1774238863896; 
 Sun, 22 Mar 2026 21:07:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a285206f73sm2204203e87.54.2026.03.22.21.07.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:42 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:39 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Andy Yan <andy.yan@rock-chips.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Liu Ying <victor.liu@nxp.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v3 03/14] drm/display: hdmi: Convert to
 drm_output_color_format
Message-ID: <7duzhocpjyhpvoiw4xy2wlxmrld3sj74rqhozbnlpv2magmbta@c4rlwitio7p6>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-3-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-3-f3935f6db579@kernel.org>
X-Proofpoint-GUID: vrVCbCB5SvD9Q_4V_NVarZlWc4wKsghF
X-Proofpoint-ORIG-GUID: vrVCbCB5SvD9Q_4V_NVarZlWc4wKsghF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX2Um3fCcCgja/
 ybuVOogIP4SMshza5kkf/kC4CcVfXxKVjfp8rW5BDp5VeUTs3JGLY7ull7DaC2hxa0qst103sD0
 UELyJDsXMoe6NkDVBNgK0B4ceTPExgz4sfpz87j/JF7WBCGOxyIa4drLDIb/8+jQWxIc+2m7SCS
 H7x4lWytu414k3s5n+ETTFArQ5vbYAtkR+pTp2PHIMlSrImY+RI/NZsrAQj+VxA//VLiiNbFI5M
 rHTJHiMG1EDTc32vY85h9w/mQoABDV3vzfaY8WTLcGAj2O1EFTPyseg+ZFB80rnp/8132HJ7Gjn
 13yDsa1LL4eZ2BQVTYNoPvwv8nlwW0o7sLYYj2AEnXjEv1AYvUQcsN1V7gbmMw3wNu3u2J133w6
 ZmRXJ3aoZ/zYxxGR4umKz8Mrt9oCn6C/S4A88TCbqXMD8jpHkuPGOXJzSFtlS3QZ4usPzQwSHXh
 KL6GbXTQimFy15z909Q==
X-Authority-Analysis: v=2.4 cv=dYiNHHXe c=1 sm=1 tr=0 ts=69c0bc91 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=f-rPyQLBH6VTMeScU9cA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:55AM +0100, Maxime Ripard wrote:
> Now that we introduced a new drm_output_color_format enum to represent
> what DRM_COLOR_FORMAT_* bits were representing, we can switch to the new
> enum.
> 
> The main difference is that while DRM_COLOR_FORMAT_ was a bitmask,
> drm_output_color_format is a proper enum. However, the enum was done is
> such a way than DRM_COLOR_FORMAT_X = BIT(DRM_OUTPUT_COLOR_FORMAT_X) so
> the transitition is easier.
> 
> The only thing we need to consider is if the original code meant to use
> that value as a bitmask, in which case we do need to keep the bit shift,
> or as a discriminant in which case we don't.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  drivers/gpu/drm/display/drm_hdmi_state_helper.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
