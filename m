Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F17CD8C89
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 17:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 865B510E30F;
	Sun,  7 Jun 2026 17:01:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="vo7kH9u0";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C20710E30F
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 17:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: Content-Type: In-Reply-To: From: References:
 Cc: To: Subject: MIME-Version: Date: Message-ID; q=dns/txt;
 s=fe-e1b5cab7be; t=1780851677;
 bh=/KOKsw71E6GZdJzTzoVwlKCoJhLgUSQVcRLLZNcFO5I=;
 b=vo7kH9u0uusLYJsqz4olHxbCsGUsiyxfyhehVZHGSza1upB1HiaiI92c78uB9wi0Q0AsIYX/o
 g49G6/+qg1+r0G7C2GBfHhtTFDnHPDWuvI3LbY9eA8lqsjcoFnSgubv3hrYWPP8Z8tKBOWSHPEd
 6nxEH2MobVNVGrm3r1E457DaaHv0ZtFOA38MjVR3x2QOwQkXyNSYT/5yqDnHDxy8DA893lx9faO
 a+cm1/Yd9YDOPBgf38ZCFP00Lo3Hs5ULlPCgFIZ3XRTcXnTG1R5iQ6AMcWDzsQm6Msl8s06CDGN
 62YVZA8ZZ0tlvrej/NvHT7n2QLGofkXyHAh776cDS8jw==
X-Forward-Email-ID: 6a25a3da9dabeed5113106ce
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.22
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
Message-ID: <c8f30973-450e-4995-b6f5-03e7b6afc75b@kwiboo.se>
Date: Sun, 7 Jun 2026 19:01:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/rockchip: dsi: Open-code drm_simple_encoder_init()
To: Diogo Silva <diogompaissilva@gmail.com>, heiko@sntech.de
Cc: airlied@gmail.com, andy.yan@rock-chips.com,
 dri-devel@lists.freedesktop.org, hjc@rock-chips.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, tzimmermann@suse.de
References: <5277524.h16uAIiOU7@phil>
 <20260607123739.393974-2-diogompaissilva@gmail.com>
Content-Language: en-US
From: Jonas Karlman <jonas@kwiboo.se>
In-Reply-To: <20260607123739.393974-2-diogompaissilva@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi Diogo,

On 6/7/2026 2:37 PM, Diogo Silva wrote:
> Simple KMS helper are deprecated since they only add an intermediate
> layer between drivers and the atomic modesetting.
> This patch removes the dependency on drm_simple_encoder_init from rockchip
> DRM drivers by inlining this helper.
> 
> Signed-off-by: Diogo Silva <diogompaissilva@gmail.com>
> ---
>  drivers/gpu/drm/rockchip/analogix_dp-rockchip.c  | 9 ++++++---
>  drivers/gpu/drm/rockchip/cdn-dp-core.c           | 9 ++++++---
>  drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c  | 9 +++++++--
>  drivers/gpu/drm/rockchip/dw-mipi-dsi2-rockchip.c | 8 ++++++--
>  drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c      | 8 ++++++--
>  drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c   | 8 ++++++--
>  drivers/gpu/drm/rockchip/rk3066_hdmi.c           | 8 ++++++--
>  drivers/gpu/drm/rockchip/rockchip_lvds.c         | 9 +++++++--
>  drivers/gpu/drm/rockchip/rockchip_rgb.c          | 8 ++++++--
>  9 files changed, 56 insertions(+), 20 deletions(-)

[snip]

> diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> index 0dc1eb5d2ae3..906264d65db3 100644
> --- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> +++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
> @@ -16,7 +16,6 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_of.h>
>  #include <drm/drm_probe_helper.h>
> -#include <drm/drm_simple_kms_helper.h>
>  
>  #include "rockchip_drm_drv.h"
>  
> @@ -322,6 +321,10 @@ dw_hdmi_rockchip_encoder_atomic_check(struct drm_encoder *encoder,
>  	return 0;
>  }
>  
> +static const struct drm_encoder_funcs dw_hdmi_rockchip_encoder_funcs = {
> +	.destroy    = drm_encoder_cleanup,
> +};
> +
>  static const struct drm_encoder_helper_funcs dw_hdmi_rockchip_encoder_helper_funcs = {
>  	.mode_fixup = dw_hdmi_rockchip_encoder_mode_fixup,
>  	.mode_set   = dw_hdmi_rockchip_encoder_mode_set,
> @@ -604,7 +607,8 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
>  	}
>  
>  	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
> -	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
> +	drm_encoder_init(drm, encoder, &dw_hdmi_rockchip_encoder_funcs,
> +			 DRM_MODE_ENCODER_TMDS, NULL);

Please base your work on latest drm-misc tree, this has already been
addressed in commit 3de723684be5 ("drm/rockchip: dw_hdmi: Use drmres
helpers for encoder resources") [1].

Also instead of open-code, maybe a change to use drmm_encoder_init() is
more appropriate for some of the other drivers?

[1] https://cgit.freedesktop.org/drm/drm-misc/commit/?id=3de723684be5c13517dea3dba287d06e12678c86

Regards,
Jonas

>  
>  	platform_set_drvdata(pdev, hdmi);
>  

[snip]
