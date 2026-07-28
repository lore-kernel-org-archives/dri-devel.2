Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D86C9C54F54
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4EF10E5D6;
	Tue, 28 Jul 2026 19:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L/arhS0F";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1A810E5D6
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 19:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E95E843751;
 Tue, 28 Jul 2026 19:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEC81F000E9;
 Tue, 28 Jul 2026 19:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785266383;
 bh=kKh5bHlgSxr7yaa1N0d+muFlHAGPSUDCGWeLaNimWvI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=L/arhS0FXTnm4/xbiMGC2YtE5fbJOf0b571JsorERD5zMeFFf0+o5WNLLjplZP8ZJ
 BQrIeb67ESeUKdsYSs9vlGUEctNvEZ/R7BqAGiTJxUsjz2GINCsxHgVlf1XIJkUly6
 5iyir720vYU2lu7J9RCLUros+Eu1X69Gzgm6Dkh9XrhRNji37HU8Q4Shbq6hkQoBrQ
 AK/ybwwpLC/RcD99143CR8ZJz/M3LBqzkc3cdgk5njR7gnKfNP6/yskrYk/Qj7mql6
 2mNSWoouHgqtsW6s9jcIEOqQo2qze6gE/dQunSMr9Qxh1rX8ROY7hmMi572iLutArs
 AjssZ1SlbmMkg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/18] drm/bridge: Add out-of-band HPD notify handler
To: "Sebastian Reichel" <sebastian.reichel@collabora.com>
Cc: robh@kernel.org, devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-synopsys-dw-dp-improvements-v7-9-b7640fa8cf48@collabora.com>
References: <20260728-synopsys-dw-dp-improvements-v7-0-b7640fa8cf48@collabora.com>
 <20260728-synopsys-dw-dp-improvements-v7-9-b7640fa8cf48@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 19:19:43 +0000
Message-Id: <20260728191943.7EEC81F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Potential Use-After-Free of the connector and encoder due to missi=
ng DRM device reference in OOB hotplug event handling.
--

--- Patch [9]: [PATCH v7 09/18] drm/bridge: Add out-of-band HPD notify hand=
ler ---
commit 60a32b50437d6f06ebb30ed7d8a1cc757f684526
Author: Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: drm/bridge: Add out-of-band HPD notify handler

This commit adds an out-of-band hotplug detection notify handler to the DRM
bridge structure. It allows notifying all bridges in a pipeline of hotplug
events, which is useful for forcing DP controllers HPD signals for USB-C DP
AltMode.

> diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu=
/drm/display/drm_bridge_connector.c
> index 8b54069fa53a4..632cc3ae3b544 100644
> --- a/drivers/gpu/drm/display/drm_bridge_connector.c
> +++ b/drivers/gpu/drm/display/drm_bridge_connector.c
> @@ -180,6 +180,12 @@ static void drm_bridge_connector_oob_hotplug_event(s=
truct drm_connector *connect
>  	struct drm_bridge_connector *bridge_connector =3D
>  		to_drm_bridge_connector(connector);
> =20
> +	/* Notify all bridges in the pipeline of hotplug events. */
> +	drm_for_each_bridge_in_chain(bridge_connector->encoder, bridge) {

[Severity: High]
This is a pre-existing issue, but I have a question about the use of
bridge_connector->encoder and connector here.

The Type-C subsystem calls drm_connector_oob_hotplug_event() in
drivers/gpu/drm/drm_connector.c, which acquires a reference to the
connector via drm_connector_find_by_fwnode().

However, drm_connector_get() only increments the connector's internal
kref, not the refcount of the parent drm_device.

If the DRM driver is concurrently unbound (e.g., via sysfs) during a
hotplug event, the drm_device refcount can drop to 0.

This triggers drmm_ cleanup handlers that free the drmm_kzalloc'ed
connector memory while the Type-C subsystem is still executing
connector->funcs->oob_hotplug_event().

Could this lead to accessing a freed bridge_connector->encoder and
passing the freed connector object down the stack to the newly added
oob_notify callbacks?

> +		if (bridge->funcs->oob_notify)
> +			bridge->funcs->oob_notify(bridge, connector, status);
> +	}
> +
>  	drm_bridge_connector_handle_hpd(bridge_connector, status);
>  }
> =20

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-synopsys-d=
w-dp-improvements-v7-0-b7640fa8cf48@collabora.com?part=3D9
