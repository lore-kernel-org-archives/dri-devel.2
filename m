Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AC1F364C3
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 21:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 451BB10E02F;
	Thu,  9 Apr 2026 21:53:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmT673w0";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ko835XX1";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1DAA10E08B
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Apr 2026 21:53:15 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 639K2iVg1432467
 for <dri-devel@lists.freedesktop.org>; Thu, 9 Apr 2026 21:53:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=hu81u8EXPjFrB34GvSJW9iQw
 sEy8qvlO31eh+EE0xPg=; b=GmT673w0E/j1Q74yC99wb3ajRMSsRLbCbIHUvSVP
 uamrDGeWDu5NNk7G6tKX8jeB37nxu/H/C06C/S4yCJruDmrKx+ZLLLzPg3mclIP6
 mSJmy3eZbHxVhMTwbP7fc/ATus+LU4btxJZkNij0IJGfTBasR8eTPtdAYkhavNPk
 uRKgkE5/rQgpoYqNzOSkZrgr4DDhAZjoJYhMnELo5gQPSmcJA20p5gYGBIOs/rjO
 DxahXh/NChmF8HdNyZIHzJDRHWzU05YKF8KSlIsWptwTNibxjz92qddG+8mnXzev
 ypT8gPTdbW/WfZSg6miimVwvQCD63qVuSXz0MZsGx0OBcg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4deckf9tbw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 21:53:14 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4ca7e7c2so28931661cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Apr 2026 14:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775771594; x=1776376394;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=hu81u8EXPjFrB34GvSJW9iQwsEy8qvlO31eh+EE0xPg=;
 b=Ko835XX1S2JI6/dCKWM225Wvj2Tep44IGJMgUkBS3FJqhzLS5YKOwWMbSyhWpvoJCv
 hddWrB4PUrTThCzK6chEQ2bf2evOZVq1hJpwbiTVMgHIKToNz46sLrQnkhKjqPjZT4LL
 7WGN1ZORuSTH3DfkpX1RKjfoDPVUOFuwZlo8yRQ/pTwI0eTTOC9bmGx0ab4hUNk7xL1I
 PlrcSphHGWkBDeSXQmIssQRO0myYg6lb+tfq3rJnVKS5xSaOExs5Nbec6U8F23Oe9V8O
 878aFGXK8n3Hy+48EKHTTgcNBh0wSi6CU9SX0juRSA9LLnyfWDC0jFD0OBjechQHZeOM
 Yaiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775771594; x=1776376394;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hu81u8EXPjFrB34GvSJW9iQwsEy8qvlO31eh+EE0xPg=;
 b=jiYu/85NdlCbE0AB/coK5fYtQp41LQPZRXixNhQnjCEh+iA06FV0y7dkCzw9pMY+4o
 HXySDhrQ8krjD6ORgxAroZ9SoZBy5+bnWBgbGgMivUdncY7KWoEr5aurOgF0GvMog2rw
 eGefw0AyMLgvvQYHhKK/wkCX7DZqoGXLcP1jx/EfS0oMx9tXT7uYC7haNqjSdztOKskI
 ZwqAof3ETdWBch26VfYMX/4wmBu8M2lyrUOo0w2FpHEJkx4GMyEhsXHgbnKrcF3TdDoG
 nU9NupqzDh4Dfb9xl/gEE4OJ+0DoPOFksT7gZmTwgBHZXEkI448nhCSx5xry6ooyFp2F
 s7TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdC85eAgMBXJ2u92AfUtR4kJ2m/cnH6qAJC5terSmWi67s5DkVaX8hNK4dPGnbOrhx6pP3mxyjZnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxTnoCLX+n6Bha0ZL+voRWvrDYuespySdqEQZnp4WDp5bX2fnW7
 v0mtFxLHudC1kGdgn3M53VoLhrV4JrsCrJOv2GvwsaMwuQpGOzRuQwCyJ12Mky+ERvRopRwc21B
 jPcauGVCK420D2ZZ0DxbyAYybUsZgdmtQDlOvAIAABfWy+Izuci0QJjEr7cNSxXRZpvrtDas=
X-Gm-Gg: AeBDiet80/Qn2gn0Klm+upEwY+JsdcDT+f9VEOYT+ioECJqC7q0C2BI156e2ytwmlMN
 vnCEjvHmEcGqYfu6Xn5Lbnu6W+B7W1Zad71v12c0mz869px42ED5qqfhC/c5FcpkMT4VyAIEKOL
 hKmGdtoO0hEM0XRabxMvudjpQIxGx4doAXX/KhLc6PkSthwSVWVRoa6sdyXD6tAv4GzHM6tZGQj
 RlgOk4T5t+EG7J+9+Mc8fYO6h+pcSDDzNeAqn/gkgHsjFq8i5IK2x6flHmyzUHSAqlf2NN3kiWc
 4iClA/66c+U1UreMMMVwV0kALhsPO5px1BTfPqT5oW0Z86mQzqolp8s5aSl6TrTg91TAVpH/uzc
 tK3YlWWdNToKXzO+YoJgj/hL0sGqCxO6I+jkOVOFtDshol1FSXV2QrWp8xNVGn6+FGg4LX27YWt
 Ch/I8y5BpoPuG4QTksiyt9aV8Yh28J9Kz396Q=
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id
 d75a77b69052e-50dd5c74756mr15755561cf.44.1775771593987; 
 Thu, 09 Apr 2026 14:53:13 -0700 (PDT)
X-Received: by 2002:a05:622a:9:b0:50d:7b0c:35de with SMTP id
 d75a77b69052e-50dd5c74756mr15755051cf.44.1775771593478; 
 Thu, 09 Apr 2026 14:53:13 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e49298f1csm1971861fa.12.2026.04.09.14.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2026 14:53:11 -0700 (PDT)
Date: Fri, 10 Apr 2026 00:53:08 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dave Airlie <airlied@redhat.com>,
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Simona Vetter <simona.vetter@ffwll.ch>
Subject: Re: [PATCH RFC 09/12] drm: Introduce drmm_connector_dp_init() with
 link training state properties
Message-ID: <gmaxonri7y3k43pxsnxfnd23mydgrwsw2322v6m4yjoksqm7aj@4ehgvhzg2ubb>
References: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
 <20260409-feat_link_cap-v1-9-7069e8199ce2@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409-feat_link_cap-v1-9-7069e8199ce2@bootlin.com>
X-Authority-Analysis: v=2.4 cv=S/fpBosP c=1 sm=1 tr=0 ts=69d81fca cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=E-m9dlAQy1ysB7IIWEIA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIwMiBTYWx0ZWRfXwlwvXp0nE+wv
 6saOKKs75TKDFaZ9LiQK6401v04oYWyyHd8WwsgcCyTBMMX/x1trYJpmVuOPs7Ep0OvjrbtVvz7
 dYlCr9MaXZoaJszoycwr60JntsEB8IzQ6L213tanIdv73/9lu83VQaeAK4kyG+V0xz2asuv1aBt
 3/q29YLYYSOtNxREVbfZPCptyObMkiZjw5I0bOzVXQJpo3MVeum3I8cfpdeblFlqwtuNEPRoN/v
 0cGjbx5VBTJ3AuoFWCUIR2sm+5EM9TcY25MDzQQQS6V5glDnTc/Olsp95eqUnbngKgbOwnvPIbZ
 Zjs7t/hLRdNFL9WHe/NoDiKlc3S0UDxPXbBQzN0lu+6yTVsRSGLlpAhz73YQ4fHLhCu4c/HL465
 O3apXEoDPofaFLnOt9egS44cQYM2ctbgXR95lAys6OjMwxSeigByFFH7056i7rF25C1y0T2hRpu
 oBmD+3gMku1MZjKM3jg==
X-Proofpoint-ORIG-GUID: VGKSBbMOppJ-T5ZugJzLezU-nMUMQ2L3
X-Proofpoint-GUID: VGKSBbMOppJ-T5ZugJzLezU-nMUMQ2L3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604090202
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

On Thu, Apr 09, 2026 at 07:08:25PM +0200, Kory Maincent wrote:
> Add a managed DisplayPort connector initialization helper,
> drmm_connector_dp_init(), modeled after the existing HDMI counterpart
> drmm_connector_hdmi_init(). Cleanup is handled automatically via a
> DRM-managed action.
> 
> The helper creates the following immutable connector properties to expose
> DP link training capabilities and state to userspace:
> 
>   - num_lanes: bitmask of supported lane counts (1, 2, 4)
>   - link_rate: Array of supported link rates.
>   - dsc_en: Display Stream Compression supported
>   - voltage_swingN: per-lane voltage swing level bitmask
>   - pre-emphasisN: per-lane pre-emphasis level bitmask
> 
> Link rates are passed by the driver in deca-kbps, following the DRM
> convention, but exposed to userspace in kbps for clarity.
> 
> Two additional helpers are provided to update and reset those properties
> at runtime:
>   - drm_connector_dp_set_link_train_properties()
>   - drm_connector_dp_reset_link_train_properties()
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> ---
>  drivers/gpu/drm/Makefile           |   1 +
>  drivers/gpu/drm/drm_dp_connector.c | 344 +++++++++++++++++++++++++++++++++++++
>  include/drm/drm_connector.h        |  38 ++++
>  include/drm/drm_dp_connector.h     | 109 ++++++++++++
>  4 files changed, 492 insertions(+)
> 
> diff --git a/include/drm/drm_dp_connector.h b/include/drm/drm_dp_connector.h
> new file mode 100644
> index 0000000000000..77d2f4bb6df68
> --- /dev/null
> +++ b/include/drm/drm_dp_connector.h
> @@ -0,0 +1,109 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef DRM_DP_CONNECTOR_H_
> +#define DRM_DP_CONNECTOR_H_
> +
> +#include <drm/drm_connector.h>
> +
> +#define DRM_DP_1LANE	BIT(0)
> +#define DRM_DP_2LANE	BIT(1)
> +#define DRM_DP_4LANE	BIT(2)
> +#define DRM_NLANES_MASK (DRM_DP_1LANE | DRM_DP_2LANE | DRM_DP_4LANE)
> +#define DRM_DP_VOLTAGE_SWING_LEVEL_0 BIT(0)
> +#define DRM_DP_VOLTAGE_SWING_LEVEL_1 BIT(1)
> +#define DRM_DP_VOLTAGE_SWING_LEVEL_2 BIT(2)
> +#define DRM_DP_VOLTAGE_SWING_LEVEL_3 BIT(3)
> +#define DRM_DP_VOLTAGE_SWING_LEVEL_MASK (DRM_DP_VOLTAGE_SWING_LEVEL_0 | \
> +					 DRM_DP_VOLTAGE_SWING_LEVEL_1 | \
> +					 DRM_DP_VOLTAGE_SWING_LEVEL_2 | \
> +					 DRM_DP_VOLTAGE_SWING_LEVEL_3)
> +#define DRM_DP_PRE_EMPH_LEVEL_0 BIT(0)
> +#define DRM_DP_PRE_EMPH_LEVEL_1 BIT(1)
> +#define DRM_DP_PRE_EMPH_LEVEL_2 BIT(2)
> +#define DRM_DP_PRE_EMPH_LEVEL_3 BIT(3)
> +#define DRM_DP_PRE_EMPH_LEVEL_MASK (DRM_DP_PRE_EMPH_LEVEL_0 | \
> +				    DRM_DP_PRE_EMPH_LEVEL_1 | \
> +				    DRM_DP_PRE_EMPH_LEVEL_2 | \
> +				    DRM_DP_PRE_EMPH_LEVEL_3)
> +
> +/**
> + * struct drm_connector_dp_link_train_caps - DRM DisplayPort link training
> + * capabilities

Those are not just link training caps. It is more like DP link caps.
They make sense to be a part of the DP-related drm_connector part.

> + */
> +struct drm_connector_dp_link_train_caps {
> +	/**
> +	 * @nlanes: Bitmask of lanes number supported
> +	 */
> +	u8 nlanes;
> +
> +	/**
> +	 * @nrates: Number of link rates supported
> +	 */
> +	u32 nrates;
> +
> +	/**
> +	 * @rates: Array listing the supported link rates in deca-kbps
> +	 */
> +	const u32 *rates;
> +
> +	/**
> +	 * @dsc: Display Stream Compression supported
> +	 */
> +	bool dsc;
> +
> +	/**
> +	 * @v_swings: Bitmask of voltage swing level supported
> +	 */
> +	u8 v_swings;
> +
> +	/**
> +	 * @pre_emphs: Bitmask of pre-emphasis level supported
> +	 */
> +	u8 pre_emphs;
> +};
> +
> +/**
> + * struct drm_connector_dp_link_train - DRM DisplayPort link training
> + * information report
> + */
> +struct drm_connector_dp_link_train {

THese define the current DP state. As such, they definitely make sense
to be a part of the drm_connector.
> +	/**
> +	 * @nlanes: The number of lanes used
> +	 */
> +	u8 nlanes;
> +
> +	/**
> +	 * @rates: Link rate value selected in deca-kbps
> +	 */
> +	u32 rate;
> +
> +	/**
> +	 * @dsc: Display Stream Compression enabled
> +	 */
> +	bool dsc_en;
> +
> +	/**
> +	 * @v_swings: Array listing the bitmask voltage swing level per lanes
> +	 */
> +	u8 v_swing[4];
> +
> +	/**
> +	 * @pre_emph: Array listing the bitmask pre-emphasis level per lanes
> +	 */
> +	u8 pre_emph[4];

Please consider following struct phy_configure_opts_dp (or using it as
is). Overall, please refer the talk and (more important) the lightning
resumee at this XDC. I have some bits and pieces ready in spite of that
proposal, but I didn't have time to finish it.

> +};
> +

-- 
With best wishes
Dmitry
