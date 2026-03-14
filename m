Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA637107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 02:00:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0732B10E094;
	Sat, 14 Mar 2026 02:00:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC9vsEXr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YgM/8fRB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BB6610E094
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:00:00 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62E0gc3C2411577
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 02:00:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=viMdNHU0FK1bHiOmDZw1E7hd
 c6HErcMpfYJKUTkWOLo=; b=SC9vsEXrO5h+9m0PBWUzApPVHFQsyxyiNayq+B36
 uzNIwpKYuMa7N/Ra/aGWimpd6aKMGGk/CHcRcBlm6GPpOSCOb4f93ggw44Zb0mog
 WPoHlMNEunRqQXe4u5XA2MpQKSCFgHQNvZMIf7COIxuH2wj1qu3XBy6d+hBYU0tm
 urgOX0RljSc5WBa4QL3FMsnbcyrSSKjHQlOEf4buXqKQRP4GlqNvYarn7CMXHDeE
 FYe+0HiIjSUmVCjIlboChgGdD/X5OWleyph0n7oFigxverPEW+f1M4bohClWfUn2
 7PiovgYf8OSGkhhiA12uEfIZbuL3yiPuEc42y/11N9ulZw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvwcer41b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 01:59:59 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-94deb62ae32so30037518241.2
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 18:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773453599; x=1774058399;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=viMdNHU0FK1bHiOmDZw1E7hdc6HErcMpfYJKUTkWOLo=;
 b=YgM/8fRBtV1rGo+UsJGSWrqYPHBYLDcmnb0ld76Q+wsvJgkGhaf6lWiuPeYCAwImfk
 wU/XQR8jrGLLWZJuWwVjSX95pfthKe6toXo3JsnApLXt57JlIC2R8+xCjCjJZ5mfKvgk
 BRjh+LeF5DIzIRRmXfnEdvHiK9sq0BfaRVAppDY9kqLxgyQWm79nod+SGndOtLLpWdtn
 K96OKLktytes7qMC5s7bPevRv2iDB1fpXn/I6TVMfFVbWboljGswRBg+MFX+XLQEJ3tR
 Ifx2J9+DpDF/V6blMfEDqztce1UgEHBdzlz2CEQZp9jLVJeGW+wQbkzC9AO8rdHhc+Bp
 gxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773453599; x=1774058399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=viMdNHU0FK1bHiOmDZw1E7hdc6HErcMpfYJKUTkWOLo=;
 b=QweVu4P76VyvsNhN2DB01ram4yE/pUyfm6LtqAtnolFQBsk0yC+FaDmUqoBN6QZJFY
 SEokV3XvC/kRpSnCY0rv7aDhXV3LDr8Vn9lbtXM7QaYMpTX/N7rNiarxZG0HcHeAm4a9
 hQfJoDLKXJokTGihM3gZkYHpPzAEL5Vy5y4AnDKq1zO/dWP4VNMDak+0Qu/cTDDVHgTZ
 TLhu/y48O2JhUutYEN93GnE8FAC9RIz970fKDEL3WkZoY4q2bR5/IPULav7mpSMw5DdJ
 MsZzg+pABVIw8HbXGPK7DvEHi0LM0OtbrSFijPsfu+FhmdTy08v9/tEnhuPiqyYtfkQO
 3kPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3EO0gMm7Asq2hC6tDzAfYE2Aj9K+oudI+ENZJuuRFi+ImXVx7ItMtVvM/HORkzAOQ/MBy5hd8h44=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGflJxQ9217CK6zXMp9tVqWfhHOsJ09tmQ4zXYf2+ELWmjfYbZ
 EnPoD3gD/Rent0NhyIzRmWQ9Cmf+wkth6GQUWZleL/tg4oX6shswTM4w4hi/vOY5bIUwXKk7ra6
 q8R8RpvZpnC/Y7piLjraqdSrDK0o70kk1wB2ajR2SxXoWQtcOrXlx1mbrvHJJU8FGcUa0XIM=
X-Gm-Gg: ATEYQzxhHvt5rcgOiGAp1Ecx22jBTo0daqeWhC3gqql0OIqZHGsxt8VjFHTWXkiI9KL
 JrPuQhSjIdbmZjuxJO/PdiaQ0P0t2jTU7kOaUBO7MZ9VhXyDbmZ4yWFx3wbPNLZr7Vz/ZFxIVSM
 ldvMMX86P7Uu8j9tUZ9z7dJ82BX7LfR31hypWvKe66ouzBI9GZZ8ZQO8a/clyz30tDHN2yl5sFf
 BNB9pRUFoSnYyQOvPZ0chKE5MZjKK51Ji6cHMIIitm27Cbu3vE5n1Bl8O5aavcTQ0z0dSX95Doc
 hRUHOjNOqTvejTySqP20pDTUJp8IJ4SIMJvbbPd5YJIljQUpQgDHjdYm6SH/zR8mImT8qd3dilB
 DG0wEZ8qw7QlnwUF3909uyIQYbG2+mw8mM1O6K/c96s/15kzP7Vfw3PgV3Uwh3GiI+jT8leXVci
 GWdpeD6baYZRL5IBnD0SR9ppvQOcRYLgeVK+s=
X-Received: by 2002:a05:6102:c4a:b0:5ff:ba2d:17ab with SMTP id
 ada2fe7eead31-6020e16767fmr2542572137.8.1773453598917; 
 Fri, 13 Mar 2026 18:59:58 -0700 (PDT)
X-Received: by 2002:a05:6102:c4a:b0:5ff:ba2d:17ab with SMTP id
 ada2fe7eead31-6020e16767fmr2542562137.8.1773453598511; 
 Fri, 13 Mar 2026 18:59:58 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38a67d61851sm17696201fa.4.2026.03.13.18.59.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 18:59:56 -0700 (PDT)
Date: Sat, 14 Mar 2026 03:59:53 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Sen Wang <sen@ti.com>
Cc: ple@baylibre.com, neil.armstrong@linaro.org, andrzej.hajda@intel.com,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devarsht@ti.com, s-jain1@ti.com,
 j-sahu@ti.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: ite-it66121: Disable HDMI audio capture stream
Message-ID: <unsq4jrmlmwmkh4l6yz3vpmzifqpfxcafluawnxwxixuxg2mcf@gpou5yjbyc62>
References: <20260312193355.1348842-1-sen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312193355.1348842-1-sen@ti.com>
X-Proofpoint-ORIG-GUID: KlwDF_AM6wi_uh5SE0dni_w1IDMiNNnc
X-Proofpoint-GUID: KlwDF_AM6wi_uh5SE0dni_w1IDMiNNnc
X-Authority-Analysis: v=2.4 cv=EIcLElZC c=1 sm=1 tr=0 ts=69b4c11f cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=sozttTNsAAAA:8
 a=k5mv7VFq1dZqGJ_QhxkA:9 a=CjuIK1q_8ugA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAxMyBTYWx0ZWRfX6KiISKsM/QHe
 E6hpDvr/nAhupeqWa0jHYV0D77iJrmo8+ciYrq2vnk/VzkdTu/W1zOIKjQ+fFZs51A8femqsNrU
 7okfclWoY3T5zThWOmbWPorc8mjtuszk9bSWEYEiUilwxIr1h0DFNa3TYD5mZMM2kpTtxVh3Z8T
 e+Cmk2Tk4YKS+Xt1q4IJyAXJcjkUzr40nz1vtn+Cf2ImxMyK4v8d9oL9+08XfK6KAU6N+dtZxBE
 S9BIIckETOF0gIcinjFPR+NZ2ILRbtiWcLVRCNqKDFJ9AQ4iRAksLVWitT/wmBWsXNQt2iGjuJR
 cbqHeHyc+otoIQui5UyFpjE4Z4fQ27cV0eExxBz1jZlnwIJASmvKigkiZrrpsvlayjtS9JharPx
 BQrf9riQLBxNvH5kv2M6mhsnduWa4tmChJK0cznEoaJxY73EupaPFY3arWilWfba8N5omM8rC8C
 gKXws52pBEmFfrgvu4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603140013
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

On Thu, Mar 12, 2026 at 02:33:55PM -0500, Sen Wang wrote:
> The IT66121 is an HDMI transmitter and does not support audio capture.
> However, the driver registers hdmi-codec without setting no_i2s_capture,
> causing the codec to advertise a non-functional capture stream. Userspace
> audio servers such as PulseAudio then attempt to open this capture
> device, resulting in errors.
> 
> Set no_i2s_capture and no_spdif_capture in hdmi_codec_pdata so that the
> hdmi-codec driver only registers playback, matching the actual hardware
> capability.

As you hopefully have the hardware, can I suggest instead porting the
driver to HDMI helpers and HDMI audio helpers? The
drm_connector_hdmi_audio_init() already sets thesse flags for you.

> 
> Signed-off-by: Sen Wang <sen@ti.com>
> ---
>  drivers/gpu/drm/bridge/ite-it66121.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/bridge/ite-it66121.c b/drivers/gpu/drm/bridge/ite-it66121.c
> index 329fa47a5701..a1b2c3d4e5f6 100644
> --- a/drivers/gpu/drm/bridge/ite-it66121.c
> +++ b/drivers/gpu/drm/bridge/ite-it66121.c
> @@ -1476,6 +1476,8 @@ static int it66121_audio_codec_init(struct it66121_ctx *ctx, struct device *dev)
>  		.i2s = 1, /* Only i2s support for now */
>  		.spdif = 0,
>  		.max_i2s_channels = 8,
> +		.no_i2s_capture = 1,
> +		.no_spdif_capture = 1,
>  		.no_capture_mute = 1,
>  	};
> 
> --
> 2.34.1

-- 
With best wishes
Dmitry
