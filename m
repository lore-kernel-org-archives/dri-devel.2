Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A96AD58CC5
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 03:45:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A837C10E341;
	Mon, 23 Mar 2026 03:45:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NPMmsh0S";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QFfG3Tnr";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E22510E341
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:45:42 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62MLwrlm347545
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=771hqY1mCDIAg/yx+uEf6Ttz
 Hkh8ia+W+7ypVEyNNiY=; b=NPMmsh0S+owYHSkMHe7FKTXso9ov8bkoJHssgfpI
 QUuIAvmzADFOygabkrTB53bIqHT7UYxLCoyOabZX7cXwnG5NIMo5IjKHhN5+1ve5
 Gk0yEsmWFG1dmGm+D9V0JmGSnt/U0TB3fRMxoV5bGOCLGpS5vEj5u7dubAKcvD2u
 x8g47IItRdSFL6r2RQHhJ92nxH0hzFTz+LlBiHvj6+FJFp4vpUhcNP3MeSEsT5D7
 XZRuA93iE0BlQYVreYiHd0ngaT4owpVG6NcrqfMHfyIDPIxDgbbHBajQDCsetLWz
 cvJju/Fa5yuKzfqct2CrOkLebbtY84iKRau6c6WNfGhQvA==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d1kj1kgur-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 03:45:41 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-50b52a2d70cso29294441cf.3
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 20:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774237541; x=1774842341;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=771hqY1mCDIAg/yx+uEf6TtzHkh8ia+W+7ypVEyNNiY=;
 b=QFfG3Tnr0EE9Mvopto4ujb2mI2qoQpZ4K4qJ4L+WwPF6nX/Id3tu4Vd9aHZL+WJ98Y
 KjkZT1fu5uw6b+KN25GubnTLwjm9eAIS0OcVvBO02fyiQ10QQTuJmNa+pWF1C1hcD46n
 dJszL7JEbz715S/uUn2W6Z+xXocdvJ0OXjAf+6z68FpiGjyZGqJnnlxe0p2QzClC/Xw4
 1fz16MFnVa12SDmJQeRX64cAf6kctygD6MW7joAwuvCyOpYl7p58veQagIxL1Z6xWLAr
 01PFnf6x1HQqyJz241FlWbdTj7xzFi32zuU7DxsdJVvT+Cc4ZCBtHIlfQaaGwhvr9IGQ
 ibnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774237541; x=1774842341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=771hqY1mCDIAg/yx+uEf6TtzHkh8ia+W+7ypVEyNNiY=;
 b=roMlgUIn85xbeDTqFaWxdKEQqCVLAuPGI1mSNQuu9uNRYz5Q2A1i8dJg5rpR7Nh3hX
 jycpvmy+pGCRpWsaxXiNpvSABk5vHxE97rTdRiBP0EkYRricprzs5/WWNYmenmNq+DkO
 +u9dbXSceQRMobFT3ah/jRBDRLQRikEQE3G6+WFgAee0cFC2E/okJmhwaRX96tkm3D++
 sOMpLh8fngdLjeBxJPRcs74akDzHnyl8fCmUO2HjBR8/ETX4gwNTlWxyL10IR5P2tmjB
 Ct7omDjUjS0WqVRe7y8bVA5bNVQF7SAZF3gQO08wOygM1Qfrp5mOmvR2y65kTSKdhzmA
 R+Og==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1C3cZIAbmEMJvZhAc8UNUqVhfODuQzYAFDXjBeKvhma5qK7rXdM37Oqfs6x1rz53tmaOoV/+JDjY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwKAZWnmsMV5YhA/51/WNUrP7cOlVZojJX+PUyB1PFCn/q21WNS
 PPIdFdQUGJv5+2LI20Kzy7JkfHCnKJfGpLtKlSVX8RsPNPunvB5h5B0jUPphXjeHMQijbJlpLrV
 rAYm+njc+B3u3rBBaYunCxOGqmGKZ8lETvi8pNaAwGIXi7nnIQw9sZ1GDfBCsHgK5MS0ufjw=
X-Gm-Gg: ATEYQzx6vWhEwr+swFWxCakw2RYW+56G2IHF9PwPHygnr67z3ZWsaxp8YtEQ1DJ83nO
 wG7pqI+aYsfF8vYbUSCb0yfNRsaHgOjw5Jg1OO05EchCyE5U05BedwUmKqxIBnS4tRmHPodXveB
 FmGjIPFuSezPvAhFP2xCbl4/gZitphAM+m0qdz1MIJfI5aKEOImUKuQ/ll3VrJlAXf8Ae7OfbZ7
 Z1JVr5kRPSjFgMe7S/KH5BSCSo/iG0qMkQvFv2oeXiilZduHOuUyRwtloVMd5gqf89gttjuhNNW
 pmOmQQBE/z+83ot61WA21iI9JghdiiLzjCq8J2vgI6R/+O0y0voh+uEjtFqQZZB+Q0tvwskzYNQ
 AUejTM+yI4wYPFbk458mgryuJWyOAZXwtOCGdqDQs1YWvv2X29TJLejrcar5k6CtdNAjsxKYO8F
 eRRsgAvJySNS+9HjLhvaTw5ugtPXFA0ZCEVEQ=
X-Received: by 2002:a05:622a:5c9:b0:509:1766:2f45 with SMTP id
 d75a77b69052e-50b37511914mr162680511cf.51.1774237540979; 
 Sun, 22 Mar 2026 20:45:40 -0700 (PDT)
X-Received: by 2002:a05:622a:5c9:b0:509:1766:2f45 with SMTP id
 d75a77b69052e-50b37511914mr162680301cf.51.1774237540560; 
 Sun, 22 Mar 2026 20:45:40 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a28530bd3dsm2247739e87.73.2026.03.22.20.45.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Mar 2026 20:45:39 -0700 (PDT)
Date: Mon, 23 Mar 2026 05:45:37 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Hermes.wu@ite.com.tw
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Pet.Weng@ite.com.tw,
 Kenneth.Hung@ite.com.tw, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] drm/bridge: Add ITE IT6162 MIPI DSI to HDMI
 bridge driver
Message-ID: <hylxawutrdmwxem52lyhhprkdm4oc6bnj2w6z5p2e2czvwmhgq@apcxe3lg6kgd>
References: <20260319-upstream-6162-v4-0-7268483ef03d@ite.com.tw>
 <20260319-upstream-6162-v4-2-7268483ef03d@ite.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319-upstream-6162-v4-2-7268483ef03d@ite.com.tw>
X-Proofpoint-GUID: lHvG4Ffv5xEkPsHiNCYuYxFUE7gm_8pt
X-Proofpoint-ORIG-GUID: lHvG4Ffv5xEkPsHiNCYuYxFUE7gm_8pt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDAyNSBTYWx0ZWRfX9jM9h/kvStvL
 AbzsOTpHwF2NsFZSG+IvqODcDGCeYLHESeE2YsKD9sl66cKccAzpZ5X2MKZj1kjhjDlS+KyV4c8
 XCAut+Dl3HerRNoh5XouS//7oDcJVTDvRrZMNLIkCMen5P5yksoDMaBqhh1+wta5smDJXcuIBf9
 R6yV/szuqc/kW8GnKKOPaeG7cIdLkAImz30WBOdAZ76yFo6fDzetO+sxsl5Dnj8o59LPLkgWVTy
 ArFGzNgh8iQ4UH9MDMDlJBn9+P9Xmsj5XKgYMbK57WZ/Udn/HCmqSBstzBBd6Nn7UJ3iNhH+7H4
 qsiJc8yiI7/KPLyFUguA82XV7VdoKvWRSzM9h7odJ6dvYo8e1NpzZ+/dYpJmKj2xt1UrkEH0mCG
 v5Osn6HDe3wccufTKHfe0TNbKh1nTGxDRlc7nBBOy5pbyrNZDYD8lhKDAp4JS8V8B4uh6pXL/Er
 VJyPe7QREr2r3oHC5+w==
X-Authority-Analysis: v=2.4 cv=dYiNHHXe c=1 sm=1 tr=0 ts=69c0b766 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=Ns9eNvu6AAAA:8
 a=EUspDBNiAAAA:8 a=QVOp_v3Uv6RRArEZA8kA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22 a=LZLx1i01EnjtqRv10NxV:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_01,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 adultscore=0 clxscore=1015 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230025
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

On Thu, Mar 19, 2026 at 02:37:12PM +0800, Hermes Wu via B4 Relay wrote:
> From: Hermes Wu <Hermes.wu@ite.com.tw>
> 
> Add support for the ITE IT6162 MIPI DSI to HDMI 2.0 bridge chip.
> The IT6162 is an I2C-controlled bridge that supports the following
> configurations:
> 
>   - Single MIPI DSI input: up to 4K @ 30Hz
>   - Dual MIPI DSI input (combined): up to 4K @ 60Hz
> 
> The driver implements the DRM bridge and connector frameworks,
> including mode setting, EDID retrieval, and HPD support.
> 
> Also add a MAINTAINERS entry for the newly introduced ITE IT6162 MIPI DSI
> to HDMI bridge driver, covering the driver source file and the
> device tree binding document.
> 
> Signed-off-by: Hermes Wu <Hermes.wu@ite.com.tw>
> ---
> Changes in v4
>   * Drop struc it6162_audio
>   * Add HDCP_AUTO in enum hdcp_ver{}, FW enable HDCP by sink capability.
>   * Call drm_atomic_helper_connector_hdmi_clear_audio_infoframe()
>     in it6162_bridge_hdmi_audio_shutdown()
>   * Drop  it6162_bridge_hdmi_audio_startup()
>   * Add hdmi_clear_hdmi_infoframe and hdmi_write_hdmi_infoframe
>   * Drop it6162_parse_dt() due to "ite,support-hdcp" is removed from DT.
>   * Add DRM_BRIDGE_OP_HDMI to it6162->bridge.ops
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
