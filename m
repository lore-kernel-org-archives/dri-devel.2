Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41B1DCA9ED0
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 21:53:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5B210F38B;
	Mon, 12 Oct 2026 21:53:02 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7A4710F2E5
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:52:50 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CJN7PE2911813
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=K+fv5z59h3BrsGh9ocdCXpDS
 hfQmJTPHUsOE2PlPFqM=; b=DdAOuTmjL52rL3XRAhWdcUSgGBfsa18vzPxlcXk9
 WxjTb2S5wwvYud+MgOIP5Gp5Tsa1RoaEahGC7erKxQftuVmFbRCwVNSqN3aEcyxb
 fRRLD9jLK55vY/4V8b9ocux97ItVdebIUuusF15Qi+sBp9wR/o+BH9KVWHXN3gVI
 NzZPx7ZESfGuKVBHvf7pschn6nTgI4cw5DnREAXLytJ7XyB1UH8YoC3XjWKE0rqI
 QUd4TafUL2BJRXDaf8OlFm33A3jO2x/xtNOv9ZNgRr/vhWajOii6fdUfjgw0xLgq
 sOHAZesQsNY9iXsm3U0Xl31B7ta1IYB3i+WqsTtMhmRXQQ==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h940w0yva-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 21:52:49 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-91b69ef6514so38133256d6.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 14:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791841969; x=1792446769;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K+fv5z59h3BrsGh9ocdCXpDShfQmJTPHUsOE2PlPFqM=;
 b=JU7cUfrKv1urMfMp7zV91DrxUnmtW/7H+E3RwBLDk8j16iwcjefo8+im5E20ax+HRS
 ETDsdWU+wjgOpzQGtjie8uXmYP2EQZ1jzGqmA09NqHRVwdIz8UxbYpqAvWQsYUdNhmEd
 GceqjJfZArNCI23Uv4StaK8qBSIWhoRi+vweW7GYtGPlLesz8XJkVChE89w5zKv6/LwH
 2PjZSQUUQRCzdInd4kq5JJr9VFQGexHEIWWMkuIJlaG0xAAd0y9DLJK0FqTkAlhcUStY
 nQpSgZRDFTrUuE01sgIT5VlWcj2fxCaL6vtSkAeVCHsAvlnSr6NQiY9tS6rRpj/xhoaV
 Iswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791841969; x=1792446769;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K+fv5z59h3BrsGh9ocdCXpDShfQmJTPHUsOE2PlPFqM=;
 b=0+2T+E02sLipC/2dyumbe8yLciyhEOx/bKHj+0XucIbAjvkPXBX12kgmqTLlTXdude
 RWlsqhJnp9VQiDCrwlhl3fSsTIwZZcGVlVPr6f+KQus3BO74Zojn/Nu/jKQ2l/LLQ83N
 X1iM/XUQiEg4NtGZD3FH54e7O0+sMUyJxMAtE0AkkV+jNfusuf5bhU72LjJrvWAfE1Jt
 +kSfyfIIse9nSHgnh5BFDVpYRzFKBDgTX3pyQm/5nD7+Ki+Qrny9mNztXgDn+oRbtGLn
 Gub7TidPvARo6TU25be44FB6ZxcfavEvLVeHFTANR28NNW+9WHFIVMU2D/7tyx7AzgPi
 59Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwx1MWB3AzNUl3KWMWreUxNvcjhVB2ZgpIcKVTz7/4xBHoLjqvNk+sQex18jWgMeFZwskcoeXfTo/Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKcBqN0mQmg1b8Dr/JMuSmHp/0XPZZ2BGn1PLWqW1ecm7OxLLaZ
 YanvN9CHtYjiFLOU8iZXOGeTjud/AolXrsc6gLmha4ZM4gKkUwUjDSq/UM4h11udVSOddZqj1bG
 TDwyDSHRu/xuenot1rA9lSo3g7aEiYtxtTdojoKrv8NQACP4lnU2If8ejxLMrN+lB+1+nvdU=
X-Gm-Gg: AYBFou0XSjPFP0Fuaf/sSjpv9GIcopiYsFmyD9hKHDK2Q0vmTAbZMU9X9dSgplaBnmg
 u3RpIJ3/ft3/izzlhjbp378BCsyib+ATuRSod9lBRoKjAnn4tl2foVrzKlHa24UATwoZ8cxlijq
 K46JE0jiMenRfo9DazsrAZ30O+uHLi/12DE1fVUOfuw8o2EbQA+N86qdbOjkR2KDuW0gdIfpNeI
 muDOMf1cZmh/IvGUnpxWK9uZjMgp0HwST1Gnx6zZsuAnwDOrxwtTmnmTjSajaYS901ynkqmfDDJ
 N3C6qLzhx0bI6WZMSLNe/lHERfYraCZPu/KwJYGMFhPEjhTulJIrJHBJMboVT0VWJBvJ0jyQ1WG
 HQf5Kl7sxJIbW9MaGhKzkZwlRaPdtTDHo78cVwcfkve+85fDhHYvm5TYwSqCbgWnFRr4xfRFxJc
 kUGBXiWi54RCs1
X-Received: by 2002:a05:620a:25d2:b0:93e:d5c1:da49 with SMTP id
 af79cd13be357-93ed5c1dd35mr1101463485a.82.1791841968892; 
 Mon, 12 Oct 2026 14:52:48 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:93e:d5c1:da49 with SMTP id
 af79cd13be357-93ed5c1dd35mr1101460285a.82.1791841968289; 
 Mon, 12 Oct 2026 14:52:48 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcdde91537sm3083268e87.16.2026.10.12.14.52.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 14:52:47 -0700 (PDT)
Date: Tue, 13 Oct 2026 00:52:43 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Xilin Wu <sophon@radxa.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 dragon@radxa.com, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 19/20] drm/msm/dp: Serialize video test state changes
Message-ID: <gcvermba6qq7jw7svx644fncfglqvwt3fpj72ew4habdq6gsn7@arxwbb4bdubb>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-19-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-19-1835d4966da3@radxa.com>
X-Proofpoint-GUID: 854iOR5-yo0LWHoYrAjgNv1PMludj7_P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfX8bPWXcd2CO+w
 bjeLbfNmBhCBrbsWmMu2vIUHdQ9CbDsYlhIlcuC2fuNYN96HLknNxF4lWsrR2V+I0/hQCedQXJm
 TMoaGg/66OixeeYWXZGfxn8RgYJL0JAuJfWf0wIroxp3EzoXVZKMZ5WnojX1x3J/oFzhNhxtmkG
 LlERXlJXZ0DQANmxzZgEcfwTu+WtgTRGZL1uAjAoMYWX1Dv3ntIjB+MeD4D4FmGaQAEmrLP3jyi
 zICzC/GatiuqwZVsjdcEh/ciuqkSwV4QLejcIYE69nGzxaCgIU3nuBooV6tPUapqONa9EZMkFw+
 kBMcLbLOYoGN2y8pLq6HrHGRUgkkih4iIhas0awx3OZVWOuvJsvCzMPvG2XXuINdtGiIYjPc8iS
 91vFRiNDAMx339xLqc/QrFREiB1a58e7JzEcnh9wADVl1I4SCNMdHfSAkkVOo5CT0s1JW3XgRBJ
 tbgutMOeDRf2WlsqdIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA4NyBTYWx0ZWRfX/08ddzJRaes7
 kjEiHzQy3glsg5YLSL+jF83jw+pLqL3He8CpQ1LRT/eQTPSpZF2OeMBtQHvP3bL+nQH3o5/hvT0
 43gKDewc3+cNNs94FJ9EVaSL2i9unJQ=
X-Authority-Analysis: v=2.4 cv=ftZJ914f c=1 sm=1 tr=0 ts=6acd56b1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ksxQWNrZAAAA:8
 a=kznJ5srmxMGE6xClfzsA:9 a=CjuIK1q_8ugA:10 a=OIgjcC2v60KrkQgK7BGD:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: 854iOR5-yo0LWHoYrAjgNv1PMludj7_P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_06,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120087
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

On Fri, Oct 09, 2026 at 11:16:11AM +0800, Xilin Wu wrote:
> The debugfs test control writes video_test directly, racing HPD handling
> and mode programming. Reading the test flag and its requested depth in
> separate calls also allows those values to change between the reads.
> 

Fixes?

> Route test state access through the display and use plugged_lock for both
> HPD and debugfs updates. Hold the same lock while selecting the test depth
> and installing the mode. Pass the display instance to debugfs for access
> to its connector and the serialized test controls.
> 
> Preserve the existing SDR test behavior. The shared setter provides the
> entry point for rejecting incompatible tests when HDR is added.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/msm/dp/dp_debug.c   | 27 ++++++++++++++-------------
>  drivers/gpu/drm/msm/dp/dp_debug.h   |  8 +++++---
>  drivers/gpu/drm/msm/dp/dp_display.c | 34 ++++++++++++++++++++++------------
>  drivers/gpu/drm/msm/dp/dp_display.h |  2 +-
>  4 files changed, 42 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_debug.c b/drivers/gpu/drm/msm/dp/dp_debug.c
> index 00fb1a7ba40e..c26b356f998a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_debug.c
> +++ b/drivers/gpu/drm/msm/dp/dp_debug.c
> @@ -21,7 +21,7 @@
>  struct msm_dp_debug_private {
>  	struct msm_dp_link *link;
>  	struct msm_dp_panel *panel;
> -	struct drm_connector *connector;
> +	struct msm_dp *dp;
>  };
>  
>  static int msm_dp_debug_show(struct seq_file *seq, void *p)
> @@ -89,7 +89,7 @@ DEFINE_SHOW_ATTRIBUTE(msm_dp_debug);
>  static int msm_dp_test_data_show(struct seq_file *m, void *data)
>  {
>  	const struct msm_dp_debug_private *debug = m->private;
> -	const struct drm_connector *connector = debug->connector;
> +	const struct drm_connector *connector = debug->dp->connector;

I really don't like this approach. My (eventual) goal is to remove the
stored connector.

>  	u32 bpc;
>  
>  	if (connector->status == connector_status_connected) {

-- 
With best wishes
Dmitry
