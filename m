Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6ED58CD0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 04:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 038E610E3AC;
	Mon, 23 Mar 2026 04:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Zw5SVhqk";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BBeWqa/C";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B95310E39E
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:32 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62N3sEYC2488737
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=W5rwiOXF2FFDG/kdjyCGCZaP
 JLF8PoP6ImoKwsa95hs=; b=Zw5SVhqkPq2/cw3ADnBJ5wgBRbhd6YTXpPGmORtK
 L+Tm1dVCL2518ekIBX8K7LtOeS4wZS9pEig/W4AJFNe3Imk0sxFuh6st7w+CKMK9
 AWI7rERcfwXLEQMjLCzdN9cNk5WWl8SvuE4pgOyb5YQ0AjsxQlWyZQaFFoEKfHSa
 YSt6n+fVlQsmvAisWict0zJSnVNwpn5puup+flKkn7Y0GoOKdLjxqwv1lb0o5TV9
 YNyCil28mxaA798c2WvD6qRBObe8+XRZgFlKBNFRS4Y1QDhxC4+0Ps9QhnrdihZU
 m1tnxlVkDv5GVI+IyRuavtp5B2C8JIubTyevpXEnYAIf/A==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1gpk3uet-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 04:07:31 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-509219f94b0so40913521cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 21:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774238851; x=1774843651;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=W5rwiOXF2FFDG/kdjyCGCZaPJLF8PoP6ImoKwsa95hs=;
 b=BBeWqa/Cn4j/eQe/quN5KwOsgJ/RWiXaQL68h8NhfRBeWcKow9sl4L/q5v8RiWPw/3
 rRnDhPlkQwTjeN3CZ4/NGfGCNp3js6Uo9AV+cQIcSsAQ0eLJw7c/XlKuobHsiGyx6vMg
 zW2/kbp/PypcQMGNb3VXzE849//tvtLfmar7nA2xY/+bz5qXwLXfOnEdYjEzadyTCcAd
 SoYSKt9oDV/vsvkoLoGzefzCpoLzs2rISVd9JuHiolNL2oiStN2+6Hr/TpqqGsKXdEE5
 RGmeqXYUBAAkpE55V8pW2Gfi6E9bFyIm1QyucSVhP/JFaMRre1JPYat0FspoehxWnB3b
 C6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774238851; x=1774843651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W5rwiOXF2FFDG/kdjyCGCZaPJLF8PoP6ImoKwsa95hs=;
 b=RYQTqhb1ZCn9WkRazXHcFU3Z9+mPgoY55B7zrm1Uisx1DLWPicCfI4jfI849jmfbos
 kpr9IdAGQGQA3m1FoHEaWp1zbfPRE7SDxSttA0rsiAjfsYbZA7sFjdnBJsOMEIgeO3Nd
 8iS8r8jTY1AbO2YGM+UjndYotyUSyUAqaKFEDsrA3Sz4M8w6kgDd/V+v/DGIHLafQA/F
 mniTYMRDnmUpE0eM2vUuHgWPlhKijmu6vUgkuOdmEqYB5bmSNNhItqnhGBumLRiFWPbw
 RcpQG9euskNg4WczNAY3ybxvRD3fD2BfwyTiGDtmcDhxP8jq0zl9ZxNWWfy0ou4RV8kI
 +wUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX0LB8QN2lyjqau15e1Y2dME6B9ODSfUoqkn4H2NlPgcgll9NKzWZI8AcmyTyLVGRHrsgxsj4cXvWE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyhAxpwzJ9tqJbjCS19RVNWfeMjuwN54WCwKV1812h4U8x8iZG2
 Sb4QONcxXtucA+0qDag9ihnvHcCkLJe9/arjrDZ+gLSGPVc41oL5L+Mh3BGVJDrEakxrsM5KdA6
 M8BDXEASiN3C+6wW30+wwrithHfkamfbphPo+atIj8u7sBG2S4oEBAoPPzpCm+MOSV0hRvRQ=
X-Gm-Gg: ATEYQzy5y424uF1w4jlJwvDWIAsN6I3/T7suNHW/uFOu+mKIuW4v/RHw6GmF/2jaxS1
 6m5vEDJcn72vQTdL21FJFa2ehmx05uCFIaKAVudww0QmxSpNKX1qpjV89soeF6p3UW86pvUC3uL
 N8373+xTeNYazK3OjznB9rxDiipnfQ7QNI0lxtndWLfOs+mo6TwQoUbYRv1JyTdBfmyBpksKCET
 gOCEuUALEKGHixnn1RBl7qF9dEKUX88IbNAvyLoH8VGegO+l6XFsVpesYAxivMmZyVQLG64bQHx
 fr7NskM28FHn5z2UBcr+BNLJ/VSahIz/TKbww34Mb2/2XA4eOUI6KPpD/4BbyaNBdyu7IYY/T5G
 kVTEkezTcUCx6MjNfcA8FbyKVXghTMZMCJfuws9RXkitldcR6gDDdAY17jIb9NTZuStPHF1RjHZ
 03GpI4MOBMEonBhFkNSKE6USOvljsPxEcs3yY=
X-Received: by 2002:ac8:59cf:0:b0:50b:2f1f:ffd3 with SMTP id
 d75a77b69052e-50b375682d1mr166637651cf.59.1774238850828; 
 Sun, 22 Mar 2026 21:07:30 -0700 (PDT)
X-Received: by 2002:ac8:59cf:0:b0:50b:2f1f:ffd3 with SMTP id
 d75a77b69052e-50b375682d1mr166637111cf.59.1774238850280; 
 Sun, 22 Mar 2026 21:07:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38bf9981ecasm24919121fa.24.2026.03.22.21.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 21:07:29 -0700 (PDT)
Date: Mon, 23 Mar 2026 06:07:26 +0200
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
Subject: Re: [PATCH v3 02/14] drm/edid: Convert to drm_output_color_format enum
Message-ID: <xip6aoymudbdakietc6qrt43irdajp46jrsdi27m36dfqfzqnz@y4stxqdxdjix>
References: <20260305-drm-rework-color-formats-v3-0-f3935f6db579@kernel.org>
 <20260305-drm-rework-color-formats-v3-2-f3935f6db579@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-drm-rework-color-formats-v3-2-f3935f6db579@kernel.org>
X-Proofpoint-ORIG-GUID: a-Cv1iXj4UNkzPcxWkF0cvvPR9yW3eTB
X-Proofpoint-GUID: a-Cv1iXj4UNkzPcxWkF0cvvPR9yW3eTB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyOCBTYWx0ZWRfXwecBY0vZ4u+V
 v9ObdFEqqKBuURgxcj3krN9XWa9masBsQ8gRSb+jFTyffzSBPv9QUTtsfmiOo+ebLhAuAfj/Z7I
 D8TWMk0bwwLB2c4wrHDSG8FxMocDq1AYa1G59+RufzMDzNOrJzRIkEhouD760iAotlR3FBP1ftz
 UuBJNdUPBjCzbjnPL/rK9+yGi/CSQdQMgoi3KGIEARQW4SgAZ8X+KrTJRrsbJEwTbngxopN5fhY
 UZZPgOlyLyl8a4efIFwMHpoogKxkMjXz5bu85e3m5f5wa5A6Q6Z6nBecHEjgAsjt0WP74SikeZT
 80wbhBAUW1DYeonfwCEbkRsCCvPHqkcoPWdqDTuCrgE3nGqsAEHkVULjFmETdTNZ5D1mjwwiyGm
 iq8/mA6WXAc0hfGdKujEyTQ9tj4tiU7zBqzxvNb0Q8iQ/umv7X7zL+64gHw+/F3i2AhqncoQ/Db
 L7OLT5Fefjg3Aduv/mw==
X-Authority-Analysis: v=2.4 cv=QKhlhwLL c=1 sm=1 tr=0 ts=69c0bc83 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=QyXUC8HyAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_wym5JX8MKgHMASIHSEA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
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

On Thu, Mar 05, 2026 at 10:04:54AM +0100, Maxime Ripard wrote:
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
>  drivers/gpu/drm/drm_edid.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
