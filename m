Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6C8CCD5BC0
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 08:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22BBE10E5DB;
	Mon, 25 May 2026 08:16:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Xtg+FrXK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB3C010E5D9
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 08:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779696995; x=1811232995;
 h=message-id:subject:from:to:cc:date:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=DyPT94IvA5RWAL7kwusd0DRglI/hTJhQpNfWY0Xs9MY=;
 b=Xtg+FrXKHjlgeisltckucETr+P1PFZ1NUxC18SX6fCS3ZeXCeWDtiW4i
 VuqLX135VFVCrB7DJW1AxfA4u0IgNg5c7nP24hPlab5gjqKmqaSYg/yVN
 z5yKFesH5wEa2zmoGK9OM8SEjMPZwk6nK5kCkiVESx6dwnTLPreogPmPd
 rXmJnq4r/pp0anyVEj7CW7a30AWtl5BNCP0H2q7cNalp4lQiVFmFlMUk0
 TbjsOEtZQFLevw5pF1WSNcpIrH3dPxvwhPmh4YVr59Kkr1lFxtoPQdbLY
 C1tBW0slmngPKMcbnMKL1532s8H0LHmPngJdD3qNlbovFy4d/3OifvSGt Q==;
X-CSE-ConnectionGUID: WPn1yrQkTX29thJVJSsPqQ==
X-CSE-MsgGUID: /yYzoCRYTX+6x7uR+2734A==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="80485750"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="80485750"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:16:35 -0700
X-CSE-ConnectionGUID: ZiJEeHatTJChLImepo9tlg==
X-CSE-MsgGUID: HM/OZXEsTVW3aN3IuEsQ/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; d="scan'208";a="238506293"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO
 smoticic-mobl1.ger.corp.intel.com) ([10.245.245.215])
 by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 May 2026 01:16:33 -0700
Message-ID: <c55da1fa43e00d755191520e8c03a7659c6e892f.camel@linux.intel.com>
Subject: Re: [PATCH] drm: Set dev->registered back to false in case of
 register failure
From: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
To: Krzysztof Niemiec <krzysztof.niemiec@intel.com>, 
 dri-devel@lists.freedesktop.org
Cc: Andi Shyti <andi.shyti@linux.intel.com>, Krzysztof Karas	
 <krzysztof.karas@intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>
Date: Mon, 25 May 2026 10:16:32 +0200
In-Reply-To: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
References: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
MIME-Version: 1.0
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

Hi Krzysztof,

On Fri, 2026-05-22 at 17:40 +0200, Krzysztof Niemiec wrote:
> The dev->registered variable was initially added in such a way that it
> is only set after all functions that could have failed have been called
> and haven't returned an error. However, since then, the function
> drm_modeset_register_all() is being checked for its return value, which
> opens a possibility of failing the register after setting the registered
> variable anyway. drm_dev_register() cleans up after itself in case of
> failure, mimicking the functions called in drm_dev_unregister(), with
> the exception of drm_client_sysrq_unregister() and
> drm_panic_unregister() (_register() counterparts of which are not
> checked for their return values), and the dev->registered flag.
>=20
> This creates a situation in which after calling drm_dev_register()
> nothing is registered (as the function entered an error path and cleaned
> up), but the device is reported as being registered according to the
> dev->registered variable.
>=20
> This, for example, confuses the WARN_ON() in drm_mode_object_register(), =
which
> is raised if a non-dynamic mode object is attempted to be unregistered
> in between the drm_dev_register() and drm_dev_unregister() calls. If
> drm_dev_register() fails - meaning the device *isn't* registered -
> currently it still reports dev->registered =3D true, which triggers the
> WARN_ON(), even though the usage is correct in that instance.
>=20
> Set dev->registered back to false in the error path to prevent this.

While you've also submitted a patch ("drm/i915: Remove drm_dev_unregister()
from the error path during i915_driver_register()") that adjusts i915
handling of register / unregister steps after this fix, have you checked if
other drivers are prepared for that and won't be affected?

Thanks,
Janusz


>=20
> Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 985c283cf59f..92403d79bb64 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev, unsign=
ed long flags)
>  	if (dev->driver->unload)
>  		dev->driver->unload(dev);
>  err_minors:
> +	dev->registered =3D false;
>  	remove_compat_control_link(dev);
>  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
>  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
