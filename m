Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CED2F34C78
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 17:57:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0270510E4EA;
	Mon, 13 Apr 2026 17:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="AYJ29elX";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JiaGpMwh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ED2010E4EA
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:57:50 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63DDmXCU1497846
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:57:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=PF56oFFcY8rN+D6lGHMuLLpm
 LnPKi9sPdMQpQo/0PDo=; b=AYJ29elX0COrAWmTaSA254ZqAugCQ02TUvSX6j9e
 ssKVfQ/ZKRvjBAzIJDC5cWaKwIS9ppem1QmqpoEWaItL/4uVXHDn0waVbxJ7c0y7
 1mw3q0Qp4peLxQWVyALDwhLVQLnnRa/4c8YDBGNfdqpXTcf+STwKNlk5QcgM/CRN
 sNkUUe6MJNAiPTMDR4sSE68TT9lwq61YWWBjXyh4EXe0Qjxe8GeI4FE1JgQw5Uas
 Q0M7K3L9uEv+fUxXLek9I3wgvCOHXzjihMU+jwCTjVYPhHMrbjx6Jsd5pwWColgm
 4pgTSV/WiA0hKsWpvaRNzpmDJn9lwIbUE+zMOb6PP2mQZA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dh1pk8xxd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 17:57:48 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-50b4b81c632so48002661cf.1
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 10:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776103068; x=1776707868;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PF56oFFcY8rN+D6lGHMuLLpmLnPKi9sPdMQpQo/0PDo=;
 b=JiaGpMwhFM4BFulUbC5bxIz9lnipoYd/3JP5V94p7bdXKxvU4B6qXkmlHuePrd1zYP
 eanAtUE611Wy+FJZwMVYp0LXhwQBiB8L9dUG8b/onpXrXXI0rxhezXqjNlw1DKzd/omQ
 ExYnHAQLPT2Q7va7TxFI97U/ufxw339Mr5dVV0s0A/PqYtSBzAyWRjZr9/M9CGeyhXZm
 Y8Ip9/KxsOKBpGgpN4wog/dfn84pZxUGGIvKQ/Nk1vlKDezPzALKSl3fLpfzXvLn3F8F
 jUc40T9fD8LkcrgP4jqPgLhsYfkpBoEDmto/fqns6HpF2u3eDMkX7ZcB60mfC7zE7rCS
 jqRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776103068; x=1776707868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PF56oFFcY8rN+D6lGHMuLLpmLnPKi9sPdMQpQo/0PDo=;
 b=qEsySvTrqc8cUxj1CF0ZKqh3vvciZmUxI/3qBBivqikPf8cGnw4KVJTTAIjBeSeAaA
 Z3q7xZnaE3EoIfIv4wT/fMlotMvLh1lnC3yg1Fgk63jBzaNSGVhfF5mw3kOUlTuSfOih
 u1j3OYHgUaRRORBrGRK//dzwGQTiiie88zTYeQHlQlHlfcdeAG4JXvzGgpScFo70nfB9
 QNduSPzlF1x+R0bY+36tDkPxSVwcO5OWdPTehXsWzQWSi8Eo/dhft8/AULJO/tFrm+Hf
 CPtoAB91SBSvp/fQlMb9CLvcUDP9sUJKMuTcTXaox7vUmsQDMn99qOFZppnlLng4o0WH
 cYng==
X-Forwarded-Encrypted: i=1;
 AFNElJ9RhVrb/tOHAl/hsksAbdRIAuoMm9YgazoBsJxBjRnn2oAADRDpscha7KLes/HcQSu1AIxFd0DbSAw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTjLC3rrf/s7WyH7tZol7VvFlqXzdufbr+1/7OojXXB30YV2tl
 kw0DZvrgDNuyDsQVmdLxgtfi5CLksO+3HmACnMmCsLXfFCamOuhiitFbCkPqAi/r+RjSoQk7Mii
 iuCjzAPBS7XfiKn2vXnLUyxCxzqDVQUzVKvcQ7iGWUeJ3CrnxPUAkZiRH13hk1s7OkK28iLI=
X-Gm-Gg: AeBDieui/T6PeHvWf2sdPuQ8RnlODY8htpDkgWRXFyUsoMHRuM1yqbqPjFSmkR8xqLP
 RMfS0NdktUV91V1me5GgOr58WFP4rLKZqlmqHQy8RpPpWqbdMqgw1MiNm8sTpoiJIVO21l5h+kH
 fwvp2ouBwGM8VDwua9gTFzwwoBVtpZCPKUaU5ZQdd5B5BW6fNeXoBmUwkVkbCBYTUkf/ps9IXhw
 vAnA+YhDyiZxPMOnHTTMnFNWNh5zeIKgvB7Kmedz+vNFaCRZCsrcj11RI1WvfZ3Bu+sXeiKYrUS
 ufp7SPsOpwR+Qk3BEn2gLJPrgTBIBb2msZyK4P7RU3zNfUa+U+kCEToubGw0ayA4TEvJPSdIxU9
 3l5VpiFz07dhsobBznJnKb2T3q8wdIk3pZlNSMzjA72bKp59jnuDcSMQBK0LRRxHPA7bQ79Ip0R
 dRbZ6sekgFqV6eBTC2OYLgGsUfmrf/04a6nQ2rNFChzKWpqg==
X-Received: by 2002:a05:622a:a40c:b0:50d:6b77:4c06 with SMTP id
 d75a77b69052e-50dd5baafadmr176516801cf.29.1776103068199; 
 Mon, 13 Apr 2026 10:57:48 -0700 (PDT)
X-Received: by 2002:a05:622a:a40c:b0:50d:6b77:4c06 with SMTP id
 d75a77b69052e-50dd5baafadmr176516371cf.29.1776103067734; 
 Mon, 13 Apr 2026 10:57:47 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-38e8cd635e3sm221471fa.8.2026.04.13.10.57.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 10:57:45 -0700 (PDT)
Date: Mon, 13 Apr 2026 20:57:42 +0300
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
Subject: Re: [PATCH 02/10] drm/msm/hdmi: switch to
 of_drm_get_bridge_by_endpoint()
Message-ID: <t45cmunr6lhxrvqgwa2mrh765zmjjderfpd32islrbg7jey4fq@d5635guivyla>
References: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com>
 <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-2-acd01cd79a1f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-2-acd01cd79a1f@bootlin.com>
X-Proofpoint-ORIG-GUID: BMeI5yCX7h6e8KE1gvLALHJ0T-VPobVI
X-Proofpoint-GUID: BMeI5yCX7h6e8KE1gvLALHJ0T-VPobVI
X-Authority-Analysis: v=2.4 cv=BoitB4X5 c=1 sm=1 tr=0 ts=69dd2e9d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=P-IC7800AAAA:8
 a=EUspDBNiAAAA:8 a=hXVsb92WUBna0ZnZifYA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDE3NiBTYWx0ZWRfX7MNPc9h1I4Wt
 f0fv5195oTmMJOYVGkll5WV2VFmoS7q1vQSGbXL2L8e+Yw2R+SNY76c3EdaR7u/VHW/WRIYUJWK
 ElpGzQXNSB8OR45K6nI4DfzaeTg0sw2/GCv6oIIy9gCfggI1DdT4DaUdR0nDlgUEFcT7G+lk3Wi
 NnXCrOzGy+d5KT98IXA7LtFqbOhUDi5OsFv/56leUxEz5bwTyNeykSBj0wuIijFmMj6KrxtRGN8
 28Y3DbwGJ0NnkRp1TwhAb6DlxWD3xunHckp586zWqj4NFTVFHQcFzlpjwRbBzinGno4QUCyTUSb
 wOtOhHT8S5z/OkAFD3lI0JMM+Uc+O7GQkZ7bSOFw31R9bDRabkPBhZwfZFXa88nPAA6KO4qEv/w
 tNkdD70r5tAWkl/nPMQBBjA77X5AExXXExd4o5RY2LI99B+gdgQkJBCNuImC9b7nON8MaPhL+OG
 1fYqCqdMeOrp5LESwAQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130176
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

On Mon, Apr 13, 2026 at 03:58:34PM +0200, Luca Ceresoli wrote:
> This driver calls drm_of_find_panel_or_bridge() with a NULL pointer in the
> @panel parameter, thus using a reduced feature set of that function.
> Replace this call with the simpler of_drm_get_bridge_by_endpoint().
> 
> Since of_drm_get_bridge_by_endpoint() increases the refcount of the
> returned bridge, ensure it is put on removal.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
>  drivers/gpu/drm/msm/hdmi/hdmi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

How common is the probe / remove path? Would it make sense to have a
devm_ version of the function?


-- 
With best wishes
Dmitry
