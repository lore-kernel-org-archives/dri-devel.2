Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A52DCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A523510E533;
	Mon, 12 Oct 2026 12:40:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7473C10EA7D
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:40:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69CC06nl1933158
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:40:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sxiNADN34Bn3hCov2PhV3feq
 5avacxCrZr/2GuhWpv0=; b=ByZxy/6Js4fHnxneBjxYjCUubPTr79h1A+yP9Pzg
 x8aFZntUDX7xs7KWuK222xsvzmdMQfW+qUbHbQ7CWDCsD1VH4BqX5WJCwW4xbRa9
 tzn64/nsBHpz5T+kfovaDhZhfWmnb992bOu5BpFDyZbKnhFVj8IJdefp+0Kcgqbe
 ffMAraZ80Ib8x+iVMtSeUsM2A8yi5PBa+TzUgUCvCku8Tyx9LeNck9+lHyAooxgq
 2+xteOC7CZgqVi2OYDRFgDASD1WeMIIunxutO27PxlL0FkDEKnruNp3WohNT0D1b
 YCSARZkUwmRC1pugGI3OSCp1uh5waA3k+EK7fw/7ENANUw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8qtkj77b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:40:08 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93dd3c3badbso418942585a.2
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791808807; x=1792413607;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sxiNADN34Bn3hCov2PhV3feq5avacxCrZr/2GuhWpv0=;
 b=HxW+Og7vO86HEaA5Tt0jE9UClBH+HwoQYx4gmVJk8untIwX+/ut/oR7EsVA01B1xn/
 1mfNP9oo/q3yk4chtLXxmdE3bLXyyAV396YQxjgUsk+ZY9v9uDSpdnh3pc5WmJiQ93JN
 tPfj28aNOQsT5+/kztQdTUhFfkHp9pEySOe0+/33dYO3ipC6gExWO/fL/BRHkjk5b1Jx
 prlI8Hht2fOXq5gBFmHBgzaRUfNq1pe+BMThd227R/pH/x35PQv8eLdiur3Jw5O4ZVNr
 DllEgot0ccgZeMb6Rm3bAmQR6JexqDCnT+Bsep61oFVEziGiUznyWVduw+pVHYBFrLEK
 sbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808807; x=1792413607;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sxiNADN34Bn3hCov2PhV3feq5avacxCrZr/2GuhWpv0=;
 b=Pd4Hr0Uko5PHefrEuhgrzz2w4hW0IeDpydb9RXM1EEMT7IFTRhu8OpfPhfHaYsRasR
 o0yWkfm7wfReIoK0AJ/ImX9aZ1s+15G3J5v/n/uAJyW7DPWYwM6vhq0nS8GtjM+9houz
 0fUxNhnTmxK+5XqmJyRZ1V3mAoO1kXN1d4C9i8A6q/mu+j4CJumk0VT1WWcMTnxzI7eg
 WfjPZpTOnMppqdX0hwmGNB5BGLJGzXnzYg7PlHRsbxJtPPrWweq2P4+fYlX+zoBms5wP
 C7VadQxhBKxmr4mp0lovi66nfk7A0zVK/2/+NAtf0sZU1GhmfbnD6ZsAfUshcYeSiKji
 WF9A==
X-Forwarded-Encrypted: i=1;
 AKwUvBw21P7ynLQV2UuXSu+9y3KxDj55Rp2MJ1V4/NDfYeRNigBn5NCary7mxC6d4YFd5zhctuYylnCVvgQ=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKo8YuUaV0PbDxl9GSyvG/y0Rh6elKu1tmkIgKvkDupWwYGt+nU
 VFy1DKnQo/l6IxEl1+ELaaxslkQhd8miY41MxsFgleohYVgwJuqtBSj7UYGjBQO4/iAwDD+SyJ7
 +rmK+QkVFM0wXG7lFiefPEJAXZ/pUl1L8cC2v5lQQm24PsD/fTXkkmoH1jSrCoV/NesEE7Os=
X-Gm-Gg: AYBFou0equoRPWfNh+2+HjLsv36cn4KCPVyXb3r/3IniEE5766n1tumUx8VeX/2kHRe
 GUBRDqwAaamnerX//T7aDVeOuAhur9kZaACTajfAEnX3JZeZREANXHFoZrUEQ6ydw3iM/vrmPmP
 M5eEUJpGKJ8KcyyMkPfhLw8R0ryWoEEB67cANWrBZzZZyOsx5NM3b2jZhW8Wmv761HjF6VHEDqN
 SeGeAWYOQ93XAgZ3k3o87IcwLI5hGf8vqIwAuuJ0fHvqzqRzkiDdFkWZPXdLwzATc8qBYxLZLhg
 Avf0igh5d4pjLC9pHhSahT81hXudhvVOgWFxo7OT0Ldjc15d9XwHuL9cNpbuBg/aJc859WcXM5+
 XqW5jiMAWyeUoZe9pvcP71GNQejQiVJET22Fl+4H09TF7yz8WAsyTIlpdDBcoOucZYcV4M0Sre0
 rGyjkg66lBC4NQ
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:9b6c with SMTP id
 af79cd13be357-93ec12c9f75mr1287531885a.71.1791808807406; 
 Mon, 12 Oct 2026 05:40:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:9b6c with SMTP id
 af79cd13be357-93ec12c9f75mr1287525785a.71.1791808806759; 
 Mon, 12 Oct 2026 05:40:06 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bcddeb5136sm2762212e87.61.2026.10.12.05.40.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 05:40:04 -0700 (PDT)
Date: Mon, 12 Oct 2026 15:40:02 +0300
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
Subject: Re: [PATCH v2 03/20] drm/bridge-connector: Attach max bpc for
 non-HDMI bridges
Message-ID: <hh2nn5eazfxpulmtvrugkjujhsspf7wlr64a65smmzxtlb53ml@6wynyytdaued>
References: <20261009-msm-dp-hdr10-v2-0-1835d4966da3@radxa.com>
 <20261009-msm-dp-hdr10-v2-3-1835d4966da3@radxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-msm-dp-hdr10-v2-3-1835d4966da3@radxa.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX4HSCnIpOmUqV
 T5g7sNAdtUrRdwFPFyQLc6tUsAdgLUI4s2Uahg8DndiX7fZR3UpK3MQkvO+IfJDJazkloaGV1he
 I7lBYDJ8cYQfGbDvq1DOcwg+PseqN5mt5frdqyNlu22niJ/pphB/y6+bZU3oLdZr09GPLHhhCmq
 etVRf0K9ODtHc1tUsnPnoCyDnPbwCCxuetQZvlr5IaE97uCbvYg+7KXCamczukKhhtQruyvilWt
 TYZvw0Vfdc5RH91BQmRxZBtaQ2mrJQSPTttUe9vfa0+gF6Un0GDDUYbIsv9c+u8JRzZvwxMqEC+
 8x0mUYJHhaSSMdcNjc0mpvLlMlx5HOQq7uXm9MACRGoO0NMuu5r5aNn+C1ojvbRnqs8qN6BIpGp
 vB/yYJbopHKY2m/sg0kdgFljRoXovJtarZ/SsM/3vnnLj4+EM3Y+tze1XhoKAaTkJjKsft4H2s8
 1EPr9sbFOUTtfHRJ1hQ==
X-Authority-Analysis: v=2.4 cv=c8U+0h9l c=1 sm=1 tr=0 ts=6accd528 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=ksxQWNrZAAAA:8
 a=4AZdoXe02SclfKkZrKEA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1MCBTYWx0ZWRfX4iwzz8NboPtc
 3r/DDNJQkEhwPZa9oPd5ERMJp1480x42QMAElrVdZOkUDQiUDkZUO4HUtuOWhHmfsRYxrkX9OQz
 QooMVpTd1zXQN5tMC50Am6jsR3s6DA4=
X-Proofpoint-ORIG-GUID: igL1VzkD9vKjIjj0fxloIlvI0GNZLakq
X-Proofpoint-GUID: igL1VzkD9vKjIjj0fxloIlvI0GNZLakq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120050
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

On Fri, Oct 09, 2026 at 11:15:55AM +0800, Xilin Wu wrote:
> Allow non-HDMI bridges to advertise their output bit-depth limit through
> max_bpc. Attach the max bpc property when the lowest reported limit in the
> chain exceeds 8, ignoring bridges that do not report a limit. This lets
> DP drivers expose deep-color support without attaching the property in
> their connector initialization code.
> 
> Use a lower bound of 6 for DP and eDP, which support 6 bpc RGB output, and
> 8 for other connector types. Keep the existing HDMI registration path.
> The property can be attached before connector state allocation; the
> atomic state helper initializes its default when state is created.
> 
> Assisted-by: LLM
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---
>  drivers/gpu/drm/display/drm_bridge_connector.c | 18 ++++++++++++++++++
>  include/drm/drm_bridge.h                       | 11 ++++++++---
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
> index 8b54069fa53a..be2e08a3694a 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -825,6 +825,7 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  	struct drm_bridge *panel_bridge __free(drm_bridge_put) = NULL;
>  	unsigned int supported_formats = BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444);
>  	unsigned int max_bpc = 8;
> +	unsigned int chain_max_bpc = 0;

UINT_MAX?

>  	bool support_hdcp = false;
>  	int connector_type;
>  	int ret;
> @@ -985,6 +986,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  			panel_bridge = drm_bridge_get(bridge);
>  		}
>  
> +		if (bridge->max_bpc)
> +			chain_max_bpc = chain_max_bpc ?
> +				min(chain_max_bpc, bridge->max_bpc) : bridge->max_bpc;
> +
>  		if (bridge->support_hdcp)
>  			support_hdcp = true;
>  	}
> @@ -1026,6 +1031,19 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
>  					  connector_type, ddc);
>  		if (ret)
>  			return ERR_PTR(ret);
> +
> +		if (chain_max_bpc > 8) {
> +			unsigned int min_bpc = 8;
> +
> +			if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
> +			    connector_type == DRM_MODE_CONNECTOR_eDP)
> +				min_bpc = 6;

This opens a can of worms. Consider having host -> DP -> HDMI chain of
bridges. DP would support 6bpc. HDMI would not output 6bpc, but would
the chain be able to negotiate 6bpc, feed that to HDMI and let it output
8bpc? What is the resulting bpc?

> +
> +			ret = drm_connector_attach_max_bpc_property(connector, min_bpc,
> +								    chain_max_bpc);
> +			if (ret)
> +				return ERR_PTR(ret);
> +		}
>  	}
>  
>  	if (bridge_connector->bridge_hdmi_audio ||

-- 
With best wishes
Dmitry
