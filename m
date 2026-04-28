Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D24FF8867
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 01:53:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE2B10E9E9;
	Tue, 28 Apr 2026 01:53:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YHbhxU7d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kG1l9G9g";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F038D10E9E9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:53:32 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63S1iV2A3123629
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:53:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=qsYf6auyPCvYiUhWs9qEQr3E
 nNJRMJfao1u7g46ap5c=; b=YHbhxU7dPRkCfypPX1k6IzmiUAXi/D0aFgIvztv6
 uWLPPelcDF7ODdPrh3x/UOhzSjuGoBFWLpcAlIPn7qb7H9wKDNtagMwuqQKhxqgO
 f9V8R7wtj2mL/51uY0Ys/J7WOh/W68TPRUEyD7dsHMHMz0Eo1Whoj4zB346YfMsm
 MOCRxxzIcwqCQq4PjqOh2+6SfjZyCAedlKcHedI++RySLsTnWjMWLQewwe1vWbz9
 l5NBfavcgT6p3iV/zzMR3lOR5k/fjZ0fjMLEawYYsfifPQJDyzFFgpdrPRzbyW85
 DarZXcATaQPn7pGqCqbZ7vgHb+4g8uKerkgjmFhtuAcI4w==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com
 [209.85.221.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dt5qgk8bv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 01:53:32 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id
 71dfb90a1353d-5675cb317e3so8328375e0c.0
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 18:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777341211; x=1777946011;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qsYf6auyPCvYiUhWs9qEQr3EnNJRMJfao1u7g46ap5c=;
 b=kG1l9G9gyrzXt+wB6rnKMetA6t8gKol1rYSm7G5TEVOKRSt2q7Ohrsr/k/8yNehSh9
 T/cnlxZ3WehGzXst8aXGWEgyF1ErRRe+6gP6D8EbbK1v/eFkVLO87sn/vhqNOjaIy5Kc
 v36wldvZbI1UZ6yDS2ikPQbbRFtNulj3R9fC1JO5q7uRRolqsOfUg/7MiN4Sg50YFfNx
 icP8ndpkPFM2o9UPWb5/UbzOiA7P9kFzKcs7yHVJljXd4YUFQGLdJKrtfJKOj1W8620o
 c+OtKkvYO+wX1/NtEJh8Y2apoFXmhN4d7/k1NjiG0vBkCEBHpysQ+ZpJYUP7xhUBI1rZ
 kxzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777341211; x=1777946011;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qsYf6auyPCvYiUhWs9qEQr3EnNJRMJfao1u7g46ap5c=;
 b=P4lxeqJq7fZ7xFVEPr3+uJDum7CnUcXMBN40EDBTE+sIlSzZBCAAU9ra0l3oTSrZ4F
 VE47XQkHOHCd1yIexA+o5UZdAdbMdx5Zwr0MehSwWfHRumAzwyvABk60MfH83dNGB326
 2WBrk4313/MISQ/45zAqHNFq41SyUQ94DF4xRSUO1Ua1/iKswTq9900yh5kS4eElpxaK
 VlMEt/SoB+I7AA70RI0VWBF3hmUEyo5PnZspZo11E5VU8x8Iuq/pFnY5dPoad9fQQw0b
 UN/6uv4XcQ7MEpNEg2Ww3UOVdQm3lj0PcaAv0KeQR/0g52CBgdTPQSwXUJm5jyMtuxGs
 v8Sw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WHGMg8+Hc2dxB0jUnaXD+1nqvCnbrVh9+5QG7Qpvw1O5DH7z2TVOI345d4DaD7GqeMHBOJVVt5Ek=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywiyisg8D8PVrKWnmkFgDv1kW0kH50Z0HJhS/zyd9DySlzyyC1k
 hJS9lraDsbjWcJAribyaOKG9Yj1e4sWmUdnh/D105GIU9ohG4QT+apuruiTfjnSMlI8+pCqaml5
 abAiYV0Ia12E+L8g2hsrxADa1SIxLwCbzFMSRfYMScMEwkVGZRK514SH7RjJxEqJbTJ8ZHDI=
X-Gm-Gg: AeBDietTYMBo7AA1ztsGqRcvGr3MjLmydcRQEEKsKLvs9OapCrtbfzSTB5ugtWlCOHw
 ScKLkZZujmpX4ZGRl/fN80Vr2RobPTw04E8s63lCx2UupIvzvalotoFLILWaBRc0lH9PLZDsXPQ
 MMLlxlUIQ6vo1rUlaFTp2IZd9fr+Hl0ULYU10XCEf+nDhNXz2xeq97LPAiDoYeAtCu1zF0EyETA
 tShejpSndiwfPlTME6tgbxbjrvCuGdE12No2lyB3OYG8mOmh7Y0ZVeP56Nl7eronHvQula4Ahvp
 EVh6zMj7WK0zrg3pGZOsyELbZ6J5N+10uyElYMze7u6AwRJ73UAUofa0MbTc8JTdRpQgaqgLsVc
 OTXJL3WM5UQwYU6b8DHbmgAlfiPB0mXmNq8unL471Gb6ZkxOyKMY0qGUJ3c1z6BTECKd8o0szOY
 mMLDl35DzGcQxugnoFt9rLpUYYF7ZgH4+X3n32AFy+QsTtFw==
X-Received: by 2002:a05:6122:e20a:b0:56d:8493:d455 with SMTP id
 71dfb90a1353d-573a53222d2mr525627e0c.0.1777341211520; 
 Mon, 27 Apr 2026 18:53:31 -0700 (PDT)
X-Received: by 2002:a05:6122:e20a:b0:56d:8493:d455 with SMTP id
 71dfb90a1353d-573a53222d2mr525613e0c.0.1777341210914; 
 Mon, 27 Apr 2026 18:53:30 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3923f5b1b3asm2780951fa.40.2026.04.27.18.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 18:53:28 -0700 (PDT)
Date: Tue, 28 Apr 2026 04:53:26 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>,
 Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, kernel@collabora.com,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
Subject: Re: [PATCH v5 10/10] drm/rockchip: dw_hdmi_qp: Restrict HPD event to
 the affected connector
Message-ID: <xwsnwqk2bqixswue7ajy5tfzxn6u7sfuqlpquywsrdj3bs6nmb@pv6szzdjjuzu>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-10-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426-dw-hdmi-qp-scramb-v5-10-d778e70c317b@collabora.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI4MDAxNSBTYWx0ZWRfX9mCepRA3mK1g
 Fs/U1wL4eBWcPcnS30RjIB16ED17dULURreoXjXPLeM9kyMPQ/s0RXBE2UaZAH7+pyOOhh7LncG
 hqR38L+m1FTdUQ/CKbidEFSG5h0auknYLeUw9lx3liNfJbg7XmIxqsr1IrCvG1E6s7Gul+yRF/c
 RuOxjzAyWaJbEcb7AiYsupoto4oGkaoVWvm8mO82BXgDUGIUSjHCmVC6dNwOwiCaFsguuaGZeHU
 tqXX5ZUTW+NXLV5DY+/oHTV39eK6rT4v5owuLpjCwID5TJ3lvUBtqYdP8h7qBjOpo0+D8hD9/Tr
 4GiUbFBB/p08irN6ebxvPu+YthkzcbHI06WEPxACgp0UMnwEHdmMcS6UnR/SGYxhsWWAf19pQ7l
 6jLQ2MJIagHcc0Vrs9HYhh+J0hKZbepfW88wV1dLZN5gX9f1AkdnOD8+XD0uwsqS+AQj0UMftin
 UXqQdZ0FWyvx4UI2PEw==
X-Authority-Analysis: v=2.4 cv=V69NF+ni c=1 sm=1 tr=0 ts=69f0131c cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=MTERcTr8AAAA:8
 a=69EAbJreAAAA:8 a=QX4gbG5DAAAA:8 a=PsTfIz2H8riIsuG6cnkA:9 a=CjuIK1q_8ugA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=1w2Y23rLpnaGpkO2nlKf:22 a=AbAUZ8qAyYyZVLSsDulk:22
X-Proofpoint-GUID: YgLfXEkt0oIgFwnDXf1HISf4dV9nj7Ep
X-Proofpoint-ORIG-GUID: YgLfXEkt0oIgFwnDXf1HISf4dV9nj7Ep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604280015
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

On Sun, Apr 26, 2026 at 03:20:22AM +0300, Cristian Ciocaltea wrote:
> Switch from drm_helper_hpd_irq_event(), which polls all connectors, to
> drm_connector_helper_hpd_irq_event(), which runs the detect cycle only
> on the affected connector.
> 
> This avoids unnecessary work and redundant detect calls on unrelated
> connectors.

This also doesn't feel correct. The dw_hdmi_qp is a bridge. As such it
should be using drm_bridge_hpd_notify() rather than any of the mentioned
functions. Would it be better to add the a corresponding wrapper to the
dw_hdmi_qp API and call one there? Also consider implementing the
.hpd_enable() and .hpd_disable() callbacks for the bridge, which would
remove the necessity to call enable the IRQ in the bind function.

> 
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 

-- 
With best wishes
Dmitry
