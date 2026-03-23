Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F428D58CD0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3C610E3A7;
	Mon, 23 Mar 2026 04:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mkB7ye1A";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LJ+CdmxD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74D5A10E368
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:19 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MMQJOu2574486
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=FkOlnsc0EKvOIhkAtLnyw5lm
 SHO8rtw4V09fAITZLBs=; b=mkB7ye1ABcjRkiyURKA6wmiG8gu2qAXGJgZYQfvJ
 ys04tLxs4TicdQbJAnSx1QrGvOI/bS2qSouJw9b59PiEeMYFbBx6awIaPGFioOKH
 D9Fm4SNw7zNoaoz8bw5lDksOz0792gDPV4/hn/T+vmnCG0D+bdzNAv6vuNTo3Gfy
 yXK5x0dNxWoEOd+3l/QpN5OURspZ4R4/RJ7PIwIANXfMBzg8WXBs2kgWI5kPb8Cu
 Vgfxb9to87kSFRUIRwSqEE0/abOf7aYutz0S3EmGAEXZcKD/vhcAdUqinQ6hvxZP
 vzfZgAMXEsfq/dl1rJPcbYykgUoGgjt7H6UH3mx6Aq2Trw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1jb5krmn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:18 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50b4031b86dso231123091cf.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238838; x=1774843638;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FkOlnsc0EKvOIhkAtLnyw5lmSHO8rtw4V09fAITZLBs=;
 b=LJ+CdmxDHk6JfdgDQbKAEHbwXAuWKzgtk5kMju2dWGHFObuQAYHHG/8vh+47edHS34
 DQ74eqaLThre+euqrDc4QdK5kayZTToKuQk+O/iZxfBiPIvKlR+k0A7JBBtawlTBLQmZ
 Fprz78VbIp4WkAS6rS1AyiTZptplrKo+/PVhiA/uLaRL9wJAC/fsgrGbOZFJXfp76Cgu
 BogB7jN+OkYVQgDqafswCIuK5JmTML8/Uflg2Yh2vKUXNgQE0YSkaQ4k22kBuKrmrgVi
 Pu/0N+IrWzrmaG+oo5Zsjtf9ts0PDIXh5v8dVN4uNjoGMX00JnRhAB29y6J9W61Jnle7
 gAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238838; x=1774843638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FkOlnsc0EKvOIhkAtLnyw5lmSHO8rtw4V09fAITZLBs=;
 b=Y/fz24BSpjjh2+DU+O6vSZ3ptKBxxUlSk+dO9TwyOo4SFiIWIKCfSrjgg27XWm96ep
 9KhojQM3DKq9PX3Bpc5Ph/CU+ewYhOQywXt+8SAndWDqe9kRWlsvcEq6LEjRhk5HZUFy
 tAsvUndzXzBHDorwIKGrloP5lnpTi+WQsWC5Xn7cexmap3VcYYSC2qE1Pp6xyXb1vIjk
 5zvj+AgbQBayjtxokbAt6kuInvEmyLdVbY/i/4yBuk27YdPJVIEg18OdPAUF0emmwc8p
 Snxc4wPW1sMtBwFKDllgqzsPaangOJqmJyj/BC91hCtgoqT+YOjqKDz92Qf5La1HMEJ/
 smSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHNlZ4yepK1P6+dMC3c4KW1YB4RSLaeD+aKkp60imalS1+yCX9XTsvV5DfUcfyfeuVtHWViEjg4Q0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy220AZbQJsWMXUfBgSnGQ1Q3cc0G1dIk4l9thkveJl0Y2asT9V
 ZcO9gjOYovEqYyPEKlCg/VezxJU45e41KoxXcCjsE3s5vyxq2jvm+mkTBO7Jqp0JysR6w/p9Mb4
 vj1LOpLMOms5lSC9bGvGIfZohIP7H5eKHXQwfRYe/QNrQgyeo2Q0acOVRecV3gePiRyU0f1U=
X-Gm-Gg: ATEYQzwuIQw78q4+ELmRtgKEEO7Pl7RpTQUOBVA9EaPIPQdC853sqgnPal5YUc3izKE
 /VZdpukgebaN5Y9cSatspRaHAH3GPo+pLKJEfWR9aE4/n73slVh22a/iDVL1l1N5OikN2DzDq0I
 sLBwxrDIsfkWc7gQd2iYyWtVPT9aU8+uwOjGOOciBrCEF/cfrdahFyljy4LILrODeWYmpRJuyJb
 3KK8dwnmhto14M9sYwJyKM39WPeRidAH6EmG69Jp1Tsj0BE8GYp9WN0QAwYbdimXxTJYhq/zl0H
 yr5hc+CCgGD89CV0+xDUaJC7KZcfE0iccAVOYieTMo3oapbsqAwwWkKcJ+KtAwCGDFN6bRGD30R
 Hvevhu9AInvlv+f63waIRyx5z0lwjdCyI/Qn0S0rEgnISubzMRbw8/XBa0scPTE9jexQX42kR5T
 WXpD0S6inSb05PVR4K1Xcmnta0xO30sRgeeCM=
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr84026391cf.62.1774238838043; 
 Sun, 22 Mar 2026 21:07:18 -0700 (PDT)
X-Received: by 2002:a05:622a:2611:b0:50b:4e65:95dd with SMTP id
 d75a77b69052e-50b4e6598dcmr84026151cf.62.1774238837540; 
 Sun, 22 Mar 2026 21:07:17 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9ac2661sm22658351fa.39.2026.03.22.21.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:16 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:13 +0200
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
Subject: Re: [PATCH v3 01/14] drm/connector: Introduce
 drm_output_color_format enum
Message-ID: <mvur5pb6jjbvssdhvbzoekfy7hq4h5vketlzembwb2l6fgt63i@a5f43tecwecr>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-1-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-1-f3935f6db579@kernel.org>
X-Authority-Analysis: v=2.4 cv=aJv9aL9m c=1 sm=1 tr=0 ts=69c0bc76 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=QyXUC8HyAAAA:8
 a=7CQSdrXTAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Myhj0e63kkGcRKXW9oMA:9
 a=CjuIK1q_8ugA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: Hxr3-gLMxXjTz2Wl1VUEvhQ7f0s8iBxz
X-Proofpoint-ORIG-GUID: Hxr3-gLMxXjTz2Wl1VUEvhQ7f0s8iBxz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfX9jOFbjtjblDU
 wnehsga9SzLaqQltuEvhSiffImcTyXNEBJ7BNBP9/vb+HMh20OP7beRjFYQEfy+AET3tvMTPiaG
 omNEW0fqKKSmQ/w/LBvgK9axY/ULNWpxGy1L0oIX5WM/W349aFrhwIgGlnZcyqtj32WGznew44v
 YTTRSiQtEMnjfubQ9raFFXlyMky4UuCcJA9aSb7qPvY81B4YaP7tNIh6m19GncV0aU+zpNh3YoC
 ru6nIPXStx4EAUPuZpqNEjhDvrFXn+9wi9GLNOmWhjKgJw80oN1C33+GYFdkTbMmFDnzlueB6Vz
 I4xKQAu/aSHVdzqCbjBGJJKPMYtDu/gQRpUtb9oQDW2YUFr2QdLy2MtW9kMuJtq6QGURYihzQgh
 eeOTcFSBUMkDmSeDUdlzWQVawZ5Zz0Y0H5IkW3B8kJnoUBUBJFhSQSusDgOh71OYIIKMwFkERIN
 6w5DHQqrGNf40HNe1PQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0 suspectscore=0
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

On Thu, Mar 05, 2026 at 10:04:53AM +0100, Maxime Ripard wrote:
> The EDID parsing code initially introduced the DRM_COLOR_FORMAT_*
> defines to represent the sink capabilities. Since a given sink could
> support multiple formats, it was first defined as a bitmask.
> 
> However, the core and drivers have since leveraged those defines to
> represent both the supported formats but also the current format being
> used.
> 
> Considering the latter case, the more natural, and consistent, thing to
> do would be to create an enum of all the possible formats, and then list
> the supported formats using a bitmask of the individual enum values.
> 
> Let's create a new enum following that pattern, drm_output_color_format,
> while maintaining the DRM_COLOR_FORMAT_* compatibility to make the
> transition easier.
> 
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
>  include/drm/drm_connector.h | 42 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 34 insertions(+), 8 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
