Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F0DF34C5E
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 14:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE7E10E4B5;
	Mon, 13 Apr 2026 14:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgwDecpG";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Eqa0SgY+";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA9C610E4B1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:45 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDT1SW1481380
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=00DJSzTx4OYnNszTMCzO4Ng7
 MXEjLPxiBpeE0uNJD6k=; b=mgwDecpGYk1IEbv5RhvjNBijJN3DKbCFeO9mk0mR
 6xzlx0jWn9lAgIXzn0rwYWUTi1IvjJZxN6AfFsSzLvgXonH1dAclmOsyoUHZG1jT
 KFHWpPF7aGkxofgz9GpLSxtQqmZkGWXfLzIPsaAnuOu+LS0TCR8w6juXFTdQRMIP
 r93NkAOrzu9m9PolKDcdIKcA+/qWJCPSQuGpztJw0woes1OdZL0dQLH0K3BXz2/6
 2bJXcHlF2XWia9JsPoYk+MQOW9XKwW/EXuPxmjnMP2Pa0vKje/IJuSoQmtE9Aggz
 wLJzBC6+bCcgp988cc4NJN9oCe38Wxa0bLaMqAByNOa8VQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dfexfwvda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 14:58:44 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4987c698so118612201cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776092324; x=1776697124;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=00DJSzTx4OYnNszTMCzO4Ng7MXEjLPxiBpeE0uNJD6k=;
 b=Eqa0SgY+grPzpAU4J5m73172vUxru1F4rMxT25GwNNs757n7iMJUE0sU9i6FN7Q89y
 B8p17pgccV0cRsYWP0hFGqgI9fT23dtypvHq+9fnGZ91jWe7MyjbWvfQ0/wr3MCOKSuW
 LmOvBaEFM8RlfJdRpfZoXN/GCtaii1vVdNEsLRioQ7uFyZhcRK9GxYjLi56j9IZ/c6X5
 Cn5LSMhNC7ACAZSprOeQ6K0YjBVFLVz+tAHTTgPHjuAMMlL6WMOSnyP7AJMLvdpCVFnq
 q4c9xxSKqLTV0k2jDS7NfZFVCOM8fsz3a8WrBN1ccBMa/6X3gAsey5lHB5jMOhy/OxbX
 oX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776092324; x=1776697124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=00DJSzTx4OYnNszTMCzO4Ng7MXEjLPxiBpeE0uNJD6k=;
 b=LHh3NT/txbdaIGWPqsXB8Z+YpdcQyLjdPZocJuW7fCN/YB3MDTLRyz96w67nYIG4Lf
 sZyZMlnvK1FqDzQSMlF8aB24/WbOcnlEhtVVcEjUS2sMeWE/0A8d2ECcrF4sKwlfbZrP
 d1T4uPJuxGysz8Atggm8gDQukp+dDdEVWlFHVeVHfxD03x2xCkZTOjy47QTmCJgzOK4x
 Z0HLKcbFPhxd8iH7ZG5UHhYDNPE6ta605jAu0uUf+Yo+9NKwW0UR9W6VONOUEFzzoJ4Y
 I7PktoygONOLy/maCZjP6lZKLbvvb5khpUgrGRgrb4XoyAb/Nwg0vsoC0+tesSTymHpP
 uJ7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+RU7o5SkgT6RlfSPvtaisN8e3FDWdQtnsUTsirFuI1G8MsqJ+mkSIAep3uYm222s3la+/3wdW7hk4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwK+cUgtFksc0IP51mSCOq95ZxwFDz13akneCl5F6KmMfLJar9A
 3yVApcE2fO/0CMAN2vOrrkRvpxrmkIZxKBf0NUXxMmM/n7x67/5QhIWjERn80D85QUYv8KW8WMI
 vTfhWbCgiqWWhNtX4Z+EjNs9ah973ElWjCde5HQ4ly3jGOx8McufhFhHse4NSgNsCwANhaUM=
X-Gm-Gg: AeBDievSqJeYXdDR5BO9jcqvPMpHMFlV1d9XV3//I7eUYQj+UsYv+kdt0IMkO+JW6U/
 PzINMaMDYjgO7MSptUbTdW3MikZD+sp0kZl6AQPVufEfpd9xkDSjgcMS8bk50ktQI82FJ7Ks0SJ
 GneoyEmlvouvkdQuA9+xNt4a0K6Lc+fzeMAdJPw6u6gs4fhBPPVwwF0XzLt+akr3ymCvZYHxpeJ
 rGxqKypMvOB+ies3LGxxIRNkp6hOyPMklIBleegCyQcEQaUWP6i1gBj490us3J5v/Q99f6nV/zi
 f0fjnEvsZei8jwiFyvUTsuT5ekNWMyUUI8jo54Z05yA8UkwT1uj54XHfcclLw8L/6kCggwb47+j
 lNk9kio0QGgdawgzV9c8EYnKbiDJah3/9kfNf428l3vbKuVDVyCocJR7XwkwDTvOSQbI7IJJK6e
 CyboZSedqG6A/CCA57sNZRwlnj4Cd4G3AMZI4=
X-Received: by 2002:ac8:5955:0:b0:50d:84ce:e339 with SMTP id
 d75a77b69052e-50dc1acd899mr255338841cf.19.1776092324118; 
 Mon, 13 Apr 2026 07:58:44 -0700 (PDT)
X-Received: by 2002:ac8:5955:0:b0:50d:84ce:e339 with SMTP id
 d75a77b69052e-50dc1acd899mr255338201cf.19.1776092323512; 
 Mon, 13 Apr 2026 07:58:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e4956a839sm24467831fa.32.2026.04.13.07.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 07:58:42 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:58:40 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Xinliang Liu <xinliang.liu@linaro.org>, Tian Tao <tiantao6@hisilicon.com>,
 Xinwei Kong <kong.kongxinwei@hisilicon.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Yongqin Liu <yongqin.liu@linaro.org>, John Stultz <jstultz@google.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Michal Simek <michal.simek@amd.com>, Hui Pu <Hui.Pu@gehealthcare.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 01/10] drm/bridge: add of_drm_get_bridge_by_endpoint()
Message-ID: <u2awvqh2uoc2acuuvyavwwtuvtiaidhbkkj5a2d2wwph2s7j7g@b4j73kwzblgk>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-1-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-1-acd01cd79a1f@bootlin.com>
X-Proofpoint-GUID: kyubQI1uwHgCJ1H8mPdMNYb5m-poM737
X-Authority-Analysis: v=2.4 cv=OpZ/DS/t c=1 sm=1 tr=0 ts=69dd04a4 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=P-IC7800AAAA:8
 a=rZHl3HjT5p_iJrZpzTIA:9 a=CjuIK1q_8ugA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-ORIG-GUID: kyubQI1uwHgCJ1H8mPdMNYb5m-poM737
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE0NyBTYWx0ZWRfX9FBcijc20z9f
 7TA0lDtNXrkFsX2HLFDHeYOLn86MzXEDI8O5hoe3pqUeXQ7lR8jepM6oguAxgryvJ2hyQ1CoRYL
 D0vqLMU48VjetgYYSaVZTnsX5k2VFwPcwrHbHOHMspIdEeCKRAzhy5aNMmA8a0tHmIlHsBu1y4J
 6ZtfP0NuDhg2xtxBVTlMzP5e4BcYdg2s+DKBelCmyBsuscrW9AOBuipj3X8DZkTfzp8zDW07u0m
 yb3Xk1YsX16RHABLzgL3UUiJVunEcuGXgAqRdBVEG3E3lKNWwOox3JnZxPkxfBk7HCuCEEIz9Ed
 3aQudM/8LxlJHXjgaLBHnQJiVbnzeuoIF0OHch46qwB/zmooQ3aVZi4hx/7DW4oVq2xWbhHeIlY
 v72AyWYSmRWAJZos/mE0hB6tbGfHoZXe3xO0vKwoefEYY3MPldqO4ySG0e9fntxal8WnjPO1h3R
 9KGV82VK2uKb4J4dUOg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130147
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

On Mon, Apr 13, 2026 at 03:58:33PM +0200, Luca Ceresoli wrote:
> drm_of_find_panel_or_bridge() is widely used, but many callers pass NULL
> into the @panel or the @bridge arguments, thus making a very partial usage
> of this rather complex function.
> 
> Besides, the bridge returned in @bridge is not refcounted, thus making this
> API unsafe when DRM bridge hotplug will be introduced.
> 
> Solve both issues for the cases of calls to drm_of_find_panel_or_bridge()
> with a NULL @panel pointer by adding a new function that only looks for
> bridges (and is thus much simpler) and increments the refcount of the
> returned bridge.
> 
> The new function is identical to drm_of_find_panel_or_bridge() except it:
> 
>  - handles bridge refcounting: uses of_drm_find_and_get_bridge() instead of
>    of_drm_find_bridge() internally to return a refcounted bridge
>  - is slightly simpler to use: just takes no @panel parameter
>  - has a simpler implementation: it is equal to
>    drm_of_find_panel_or_bridge() after removing the code that becomes dead
>    when @panel == NULL
> 
> Also add this function to drm_bridge.c and not drm_of.c because it returns
> bridges only.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 46 ++++++++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_bridge.h     |  9 +++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index ba80bebb5685..e51990b74417 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -1581,6 +1581,52 @@ struct drm_bridge *of_drm_find_bridge(struct device_node *np)
>  	return bridge;
>  }
>  EXPORT_SYMBOL(of_drm_find_bridge);
> +
> +/**
> + * of_drm_get_bridge_by_endpoint - return DRM bridge connected to a port/endpoint
> + * @np: device tree node containing output ports
> + * @port: port in the device tree node, or -1 for the first port found
> + * @endpoint: endpoint in the device tree node, or -1 for the first endpoint found
> + * @bridge: pointer to hold returned drm_bridge, must not be NULL
> + *
> + * Given a DT node's port and endpoint number, find the connected node and
> + * return the associated drm_bridge device.
> + *
> + * The refcount of the returned bridge is incremented. Use drm_bridge_put()
> + * when done with it.
> + *
> + * Returns zero (and sets *bridge to a valid bridge pointer) if successful,
> + * or one of the standard error codes (and the value in *bridge is
> + * unspecified) if it fails.

Can we return drm_bridge or error cookie instead?

> + */
> +int of_drm_get_bridge_by_endpoint(const struct device_node *np,
> +				  int port, int endpoint,
> +				  struct drm_bridge **bridge)

Nit: can it be drm_of_get_bridge_by_endpoint?

> +{
> +	if (!bridge)
> +		return -EINVAL;
> +
> +	/*
> +	 * of_graph_get_remote_node() produces a noisy error message if port
> +	 * node isn't found and the absence of the port is a legit case here,
> +	 * so at first we silently check whether graph presents in the
> +	 * device-tree node.
> +	 */
> +	if (!of_graph_is_present(np))
> +		return -ENODEV;
> +
> +	struct device_node *remote __free(device_node) =
> +		of_graph_get_remote_node(np, port, endpoint);
> +	if (!remote)
> +		return -ENODEV;
> +
> +	*bridge = of_drm_find_and_get_bridge(remote);
> +	if (*bridge)
> +		return 0;
> +
> +	return -EPROBE_DEFER;
> +}
> +EXPORT_SYMBOL_GPL(of_drm_get_bridge_by_endpoint);
>  #endif
>  

-- 
With best wishes
Dmitry
