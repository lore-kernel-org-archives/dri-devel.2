Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02E34C43211
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 16:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53BAC10F5CC;
	Fri, 26 Jun 2026 16:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="w21TOswO";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81FD910F5CC
 for <dri-devel@lists.freedesktop.org>; Fri, 26 Jun 2026 16:29:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id 68D5EC5CD6C;
 Fri, 26 Jun 2026 16:29:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 814D060232;
 Fri, 26 Jun 2026 16:29:45 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 914E3104C9AEC; 
 Fri, 26 Jun 2026 18:29:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1782491384; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=t+BRi142KmPuEUcsmuXZ0IikgeFHZzmKjoeyvOaxuEQ=;
 b=w21TOswOVZP9cm07O68mTEA9LTM/duqidm1F8aWEzC7PVhcUBQDBk0zM6eUh3qjO4yLZYU
 uKlmPHpoaFimW/HZ6ulF35YQxLVfxiny9tAcGq5sZNzsLLTkZcZ8pafDtF9b2dl32ZycN7
 Q/PmGPX5B9sJAIHdZoV7PRXYLH+ckEmizv21lWyeMqDib6cz3Kcl2dFEa6OMzePnde6Arm
 6MkgcF+7T6YZHcDrp/6GFo9TyR2Zfyc4nyQghYQ1JX5fvEnSItexw2F0Uu5QgVqQRajiSb
 fz2eYG+dbdo6Xriq/0C1p80MzKD7JFKf2liwI8ZAHdoNxU3wZzesxPQDgMTbCA==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v5 3/4] drm/bridge: analogix_dp: Add validation for
 samsung,lane-count property
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Damon Ding <damon.ding@rock-chips.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com, 
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, 
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org, 
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se, 
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com, 
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com, 
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com, 
 dianders@chromium.org, m.szyprowski@samsung.com, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260604085220.2862986-4-damon.ding@rock-chips.com>
References: <20260604085220.2862986-1-damon.ding@rock-chips.com>
 <20260604085220.2862986-4-damon.ding@rock-chips.com>
Date: Fri, 26 Jun 2026 18:29:25 +0200
Message-Id: <178249136513.1374898.11400378046460567437.b4-review@b4>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

On Thu, 04 Jun 2026 16:52:19 +0800, Damon Ding <damon.ding@rock-chips.com> wrote:

Hello Damon,

>
> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> index 7a85774aaac1..e120ef3320c1 100644
> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
> @@ -1261,8 +1262,11 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>  		 */
>  		of_property_read_u32(dp_node, "samsung,link-rate",
>  				     &video_info->max_link_rate);
> -		of_property_read_u32(dp_node, "samsung,lane-count",
> -				     &video_info->max_lane_count);
> +		ret = of_property_read_u32(dp_node, "samsung,lane-count",
> +					   &video_info->max_lane_count);
> +		if (ret || !drm_dp_lane_count_is_valid(video_info->max_lane_count))
> +			return dev_err_probe(dp->dev, ret ? ret : -EINVAL,
> +					     "failed to parse samsung,lane-count\n");

I think this report by sashiko makes sense:

  >  sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
  >
  >  [Severity: High]
  >  Does this make the optional and deprecated samsung,lane-count property a
  >  strict requirement?
  >
  >  If samsung,lane-count is absent from the device tree, of_property_read_u32()
  >  returns -EINVAL. This causes the condition to evaluate to true, aborting the
  >  probe with an error.
  >
  >  According to the device tree bindings
  >  (Documentation/devicetree/bindings/display/samsung/samsung,exynos5-dp.yaml),
  >  this property is marked as deprecated and explicitly optional because the
  >  lane count can be read from the monitor. Does this patch break compatibility
  >  with device trees that rightfully omit this deprecated property?

 (via: https://patch.msgid.link/20260604090935.7FC051F00898@smtp.kernel.org)

Can you comment on this?

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

