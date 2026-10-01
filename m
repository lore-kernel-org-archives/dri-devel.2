Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8030ACA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 01:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA6EA10E223;
	Thu,  1 Oct 2026 01:23:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d8qg/VWa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B52DA10E223
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 01:23:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B2A3760142;
 Thu,  1 Oct 2026 01:23:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C82B1F000FF;
 Thu,  1 Oct 2026 01:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790817793;
 bh=vTvZeF/Nhnq3jiQ437lHxmC8RA2jQksT3rwH45GKqd4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d8qg/VWaOcKEaQTC+roW0LKXNO7GVASAE3A9D8lrq6DqVo9tt3T+MqfJo/y/b4JTC
 WrQt07Yjl1rx3Js0dzjVxeUjfRFCQ4mJkVgkNlWbSesoEpk2z0RELKM5nKuMNToAck
 B8y7tcuV5UBHvp+v2/7WhKE5N+6BWiIHquCque/Kap0S3d5g8YryP9wABiEs1oUXf4
 8uvQD+JrAmIF1fiSjP/v61SMPqyz94M82X/GguZoVI3ShDeYqt8lm7jABMHOo1M7Nu
 KPkglDhbQWkkq7qIyHKlZugyziJMBAn7KZs1tTNV5xY7goIxdXXGAJ3dxlRC7e880s
 RnwfefH4B8b6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/8] drm/bridge: ite-it6263: Advertise HDMI 1.3
 capabilities
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20261001-bridge-advert-hdmi-caps-v1-4-f8806570e243@collabora.com>
References: <20261001-bridge-advert-hdmi-caps-v1-0-f8806570e243@collabora.com>
 <20261001-bridge-advert-hdmi-caps-v1-4-f8806570e243@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 01:23:12 +0000
Message-Id: <20261001012313.3C82B1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Unused macro MAX_HDMI_TMDS_CHAR_RATE_HZ left as dead code
--

commit 4c0965b876d8cee6ad2805996d389a95afff88cf
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/bridge: ite-it6263: Advertise HDMI 1.3 capabilities

This commit advertises HDMI 1.3 support for the IT6263 bridge and sets the
maximum TMDS character rate. It also removes the now-redundant
it6263_hdmi_tmds_char_rate_valid() hook, as the core DRM helper handles
these checks before invoking the driver's hook.

> diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge=
/ite-it6263.c
> index 550999491086e..e8e0197171e10 100644
> --- a/drivers/gpu/drm/bridge/ite-it6263.c
> +++ b/drivers/gpu/drm/bridge/ite-it6263.c
> @@ -738,20 +738,6 @@ it6263_bridge_atomic_get_input_bus_fmts(struct drm_b=
ridge *bridge,
>  	return input_fmts;
>  }
> =20
> -static enum drm_mode_status
> -it6263_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> -				 const struct drm_display_mode *mode,
> -				 unsigned long long tmds_rate)
> -{
> -	if (mode->clock > MAX_PIXEL_CLOCK_KHZ)
> -		return MODE_CLOCK_HIGH;
> -
> -	if (tmds_rate > MAX_HDMI_TMDS_CHAR_RATE_HZ)

[Severity: Low]
With the removal of the it6263_hdmi_tmds_char_rate_valid() hook, the macro
MAX_HDMI_TMDS_CHAR_RATE_HZ in drivers/gpu/drm/bridge/ite-it6263.c is no
longer referenced anywhere. Should this unused macro also be removed to
prevent leaving dead code behind?

> -		return MODE_CLOCK_HIGH;
> -
> -	return MODE_OK;
> -}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-bridge-adv=
ert-hdmi-caps-v1-0-f8806570e243@collabora.com?part=3D4
