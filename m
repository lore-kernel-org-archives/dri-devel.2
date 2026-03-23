Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B44A2D58CCE
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:08:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A1A510E3B2;
	Mon, 23 Mar 2026 04:08:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="d1R5o6Sc";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="el1bs6zC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBAA10E3B3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MLnev8199272
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=AqeC/roitS7lz4atrPMGBHkG
 fv3MPIQwtd12I+kF8Sw=; b=d1R5o6ScrRpvUSm5twz1BpFPnyTr0nJI+3j9WZjW
 hauYc6RhhGiqd+eNOVlzr7CAZVGa7x8+3pn0dZP+a22f64h1IVM2t7WminprqPl7
 RHOpEQS3XEmmJiZ4Z2+lqufwyhESST5agXuk8EfBE00yytBbnZnQ6k0u09eo/Ic9
 3qVS96LHmLZFbHfSXr5GM6ssgvlgL8Ayw17+6O2sg2GqQN7jVjhYjs8S3NwJYO8h
 BvmS48hH80OR5xzCb7XjLCdOEZUQQgCGVIYKKrTpOREmP2onis8Dz3+/TUkzNarq
 szGpXPPh1RkCsb+Y0Z9k+UKIRga00lpmIy9X+lEYgm0crQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1h1e3stj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:08:10 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-89a17ec1eecso21470636d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238890; x=1774843690;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AqeC/roitS7lz4atrPMGBHkGfv3MPIQwtd12I+kF8Sw=;
 b=el1bs6zCqqJtMw/3/wskGilK+afpXnkGDAUB98x7YJWqXY8M4/57bz+A1Z0+tOWvJb
 V165WROktds3nsxAX+IhqR9dXXQS/V6sT7gS/yf9/3n66vkH3paAngkdYtxzryoQkjj4
 MHJcXt4cBWniNcdHSr6o/yxPibk9wbh7pkBcs/16fz7L/yXozH/kGrjoN9mmU9hTF0le
 0ekFaETDHDM21FOiZhMnjkn5gKYfXBkIkA9q23f99meTZGa8mD32CrDR54ItSZ/YA8Zy
 VW6jV4HatVcUdvsPQi7HPPlp2mpS2fSYXDuFgX9yaBrGSEtBjHcfkIm2ItP/Y2/S/PyN
 vRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238890; x=1774843690;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AqeC/roitS7lz4atrPMGBHkGfv3MPIQwtd12I+kF8Sw=;
 b=An/0qa3Zs10Nbcq1V1cE8cYQb4ujtyFc+QhIvM8O1m6EfHOm1in6imHufKqPAdizGo
 tdBZKq5Xfcz5I9UaEXp5CPstTGGApab9bJLAHXGabf7jpp+otIj7708Uj5k5dzQrxXUh
 pSEop1/i1y1TMwRUqpJmh9a3HSAYficiYWhv8GrmeKkGQYunSaxCyJ/Iod8kdxDDSov0
 IkGGjO1bqPdVnDTfoI9M+XUrxA/GfVlAlvSFFEC8L06+Fir5le8TzKY3IodQF/ZTaZG2
 TrHlrnJi7CaC7NThKddpaUQ3gkcaIrjoEpmibOfLtj0r90Mn+iVbw/J+cvCK1Mpqw6FZ
 Uzqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoJSsFEMEw8rdb8Dz7uYYmQy6EEXqZq+bmt0smbw8Yjwyfkz3lKjUIbbZsPpsM1wzTnFvF4EeHHZ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzOtKCxE3j5aLOxseJS1NLtUW4YX54Fo+nJ8BKJ2kk6nl4djVCJ
 OYYAd3pTKIp3eMq7RqCXWlUfsHiMhrgjkZUFKu8k7K/VUi7pCqQeGQn3bTXM+S9qBNJZVTMgF40
 3LnUIynBZtkMPwIsiW/YZmRl25SGxF9eVfqD8nulJxcw2YPQ79fiXNHFPlAI3vrUUq2CaN94=
X-Gm-Gg: ATEYQzw9iVBZHt9xNdQThdlfhxXkVNKpVafFNvtfjCtZJiV9Wg2CPXd/JHD44Ekc0j/
 L5RSuUlV1AvZZb0MNiY/UXHUO6/sBY/CzNalX4G0EozVjVB1TdVrQdy3erCvdmKXwbx+fhQbFae
 /yuIoyvQ4Ui5YCK1tCCGp9bKdFMfhcWfDcNdXAXarbEWEmLl8lpX0hBn+/uxvKlOJoKgMOv2TAn
 BUmLFnayIGDrgEqYsDfVS/dwBtj9rOBFJrn1JQjwZIc6ZrPmETcgl3iOSDisij2GhRRgFcz+Z70
 7ENepxCyUcJIKRPCJ7bgcrKVouXwWVJwcWnzmoxng9kEEBnowtwxuf7YuLyP848rRDTq6SzQu3a
 jPCJzMIZbvQD4lMXDz1mpIFb7ukXrGfvO7h2wmrl77bIMdeJdK4tE/ktp4nABQWsqzU+QAPgTKC
 zIH+DhkWPr/Yp1ExoA4zMzrBMz4BMTtuCtVcI=
X-Received: by 2002:ac8:7fc4:0:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50b37538e75mr168613781cf.50.1774238889753; 
 Sun, 22 Mar 2026 21:08:09 -0700 (PDT)
X-Received: by 2002:ac8:7fc4:0:b0:509:2ef7:7034 with SMTP id
 d75a77b69052e-50b37538e75mr168613281cf.50.1774238889243; 
 Sun, 22 Mar 2026 21:08:09 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf99820ebsm21316001fa.20.2026.03.22.21.08.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:08:07 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:08:04 +0200
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
Subject: Re: [PATCH v3 06/14] drm/bridge: analogix: Convert to
 drm_output_color_format
Message-ID: <rf7nfbpyc7ce2t4c23melurn226egzqfhk35wt7q7yaurkgeeg@yu4qhmtblpit>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-6-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-6-f3935f6db579@kernel.org>
X-Proofpoint-ORIG-GUID: KMdCKQ5dsRrBpeNze1XN42QOxU0ZxWdi
X-Authority-Analysis: v=2.4 cv=epXSD4pX c=1 sm=1 tr=0 ts=69c0bcaa cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=O2P03feSXV0Fh_yUmGcA:9 a=CjuIK1q_8ugA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX/46Xgk9ypdxB
 pbu/PPVrmkzDSjlSPnsTTc410w4DHY7bK1AVi0WgSZniKAM9WE8mhDlGMwGU74vwTznvW4/ro70
 5HDP2BMM2tMncnUdMJYfSZCX+tDR2PcailsDcfIvPDsofOfTbtR45MbJx5FxyoyCJirT/qfBji0
 1qhWIBdX/RE8R299IOKn5hLjMSRk9fSNc9SJotqomqs7brwpNxm8K8x0KzhhRnjGUXYSMwXyV9B
 7ad5yFQsJH7JWiEQ8Q1KbxuaBi4kHzNRdka1d9byOLsTdQaB08KhnNeJ5R+zxflvBy0xWNGhFE0
 jCUQpOYXcdiJjgjYHqeN57uVmhZwJfK9heHqchtI8AqWAP6njTZeNV4aAVjSIn6pXsY9KuBF99y
 EFWjb6qWbA6tLAfQMT1OOI/zuSY3vu5e9XvxKUD0B5IfuVf0W1o6yI5abwijay27xJW0DjPDMNY
 ub0XEAIED1t5lPgBIfQ==
X-Proofpoint-GUID: KMdCKQ5dsRrBpeNze1XN42QOxU0ZxWdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230028
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

On Thu, Mar 05, 2026 at 10:04:58AM +0100, Maxime Ripard wrote:
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
>  drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
