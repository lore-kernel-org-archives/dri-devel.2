Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AFC5C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:30:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E4C10E177;
	Mon, 20 Jul 2026 10:30:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HL8vKntl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CFD910E177
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 10:30:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 143B160A83;
 Mon, 20 Jul 2026 10:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960D81F00A3D;
 Mon, 20 Jul 2026 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784543437;
 bh=ILGgSP9ErvUfPwbnkOm9mXUX384Vs+lQlLEZ/F/8n1Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HL8vKntlkAYTFeK73jClU/8Wp487d5Iuj24txytRF9jPUwa1mRBLGujwHNNpAxqGP
 FpBW/dgMq9dEPcFWxapMf6rT8cgYdXlt3Mb2VlkYCiS7WGhMmQ+kkwkD0PG6ocWhT5
 zqJmrE1TUII9Bl+c0DcC33KGPkVWoBmLbAyDEPe4yx94EColRAiSLbBlUAqAnoQILj
 LoB/dfa9cc2OkBGAxupT15UcgbYZCIta8HWxBpGEj8hAauIQiqZ+k5W/3jN0fHiueQ
 1xVJP941Xpvj5jSEJu2U+1nUUVkpOoWYNxrw2zk12kFDvyXFCMwCmOy3C5EGSSBxZo
 ylO8yDirf3nsg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 1/3] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720101815.526813-6-mallesh.koujalagi@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
 <20260720101815.526813-6-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:30:37 +0000
Message-Id: <20260720103037.960D81F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Low] The newly introduced `cold-reset` uAPI string is missing from the o=
fficial device wedging documentation.

Pre-existing issues:
- [High] The `event_string` buffer used for the uevent is too small to hold=
 multiple wedge recovery methods, leading to silent truncation and malforme=
d uevent strings being sent to userspace.
--

--- Patch [1]: [PATCH v11 1/3] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recov=
ery method ---
commit 187c2c07431486fea095780d51c31e9abe6dc614
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
scenarios requiring device power cycle.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index 1ff0bf7cba6aa..94abe7a811a52 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -537,6 +537,8 @@ static const char *drm_get_wedge_recovery(unsigned in=
t opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";

[Severity: High]
This is a pre-existing issue, but is the WEDGE_STR_LEN buffer large enough
to hold all combinations now that a new recovery method is added?

In drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event():

#define WEDGE_STR_LEN 32
...
	len =3D scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=3D");
...
		len +=3D scnprintf(event_string + len, sizeof(event_string) - len,
				 "%s,", recovery);
...
	if (recovery)
		/* Get rid of trailing comma */
		event_string[len - 1] =3D '\0';

If a device enters an unrecoverable state with multiple flags set
(like DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET |
DRM_WEDGE_RECOVERY_COLD_RESET), the string representation exceeds the 32 by=
te
limit of event_string.

Because scnprintf caps the write, the trailing comma removal logic will
inadvertently overwrite the last valid character, leading to a malformed
uevent string being sent to userspace (e.g., WEDGED=3Drebind,bus-reset,cold=
-r).
Could this prevent userspace parsers from recognizing the method?

>  	default:
>  		return NULL;
>  	}
> diff --git a/include/drm/drm_device.h b/include/drm/drm_device.h
> index 768a8dae83c52..75f030d027ee4 100644
> --- a/include/drm/drm_device.h
> +++ b/include/drm/drm_device.h
> @@ -37,6 +37,7 @@ struct pci_controller;
>  #define DRM_WEDGE_RECOVERY_REBIND	BIT(1)	/* unbind + bind driver */
>  #define DRM_WEDGE_RECOVERY_BUS_RESET	BIT(2)	/* unbind + reset bus device=
 + bind */
>  #define DRM_WEDGE_RECOVERY_VENDOR	BIT(3)	/* vendor specific recovery met=
hod */
> +#define DRM_WEDGE_RECOVERY_COLD_RESET	BIT(4)	/* remove device + slot pow=
er cycle + rescan */

[Severity: Low]
Should this newly introduced cold-reset method also be added to the uAPI
documentation?

The device wedging documentation in Documentation/gpu/drm-uapi.rst lists
consumer expectations for other methods (none, rebind, bus-reset,
vendor-specific, unknown), but cold-reset is currently missing.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101815.5268=
13-5-mallesh.koujalagi@intel.com?part=3D1
