Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A7D7C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4D910E1AA;
	Wed,  5 Aug 2026 07:19:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZBsHsC8a";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4A5810E1D9
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:19:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4830C60A69;
 Wed,  5 Aug 2026 07:19:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84E81F00A3A;
 Wed,  5 Aug 2026 07:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785914384;
 bh=XhuNj611viArkV+JmvtO+cfbFghFDB1In5vIQGQVvsc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZBsHsC8aa41QAyAAzctCpN78vTy1hD3U7/Hv/6BSqlG50UB5u5I/ppiOQCXGXUSRj
 gPiyt1BRlDQgEmj/GgzHk61lJ7Nhu+wyTuE4kueg5Jm+6i3qwlD6bsa07ekuSzbLcO
 eduQGEwZJcLy+KH/djqjueo+aPvYSq+1cZrK0FaRL6eThzFIrreUVbjWUIZHmSw3t7
 5jWnXr9m9jnTk3tic9b9AcL53Dy3tnfhvxiGoWu5n56UasXjxG04pdJgZkRKoJ9fRE
 TH4Dwy199Q0omvHtwwlZDnn/Y8nW1R2g2DBFNc8pyPibJPeMlKqRNRi7R2ChOY/GmP
 Ei6EMYfAZp5Iw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 1/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery
 method
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805071152.1225416-7-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-7-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:19:43 +0000
Message-Id: <20260805071943.C84E81F00A3A@smtp.kernel.org>
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
- [High] The `event_string` buffer used for wedged uevents is limited to 32=
 bytes (`WEDGE_STR_LEN`), which is insufficient to hold multiple combined r=
ecovery methods. This leads to silent string truncation and a malformed UAP=
I payload.
--

--- Patch [1]: [PATCH v13 1/4] drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recov=
ery method ---
commit 091feacf4c7aa58c5985f7e23f67de90d3d5760f
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm: Add DRM_WEDGE_RECOVERY_COLD_RESET recovery method

Introduce DRM_WEDGE_RECOVERY_COLD_RESET (BIT(4)) recovery method to handle
scenarios requiring device power cycle. This method addresses cases where
other recovery mechanisms are insufficient to restore device functionality.

> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index e51ed959da89f..8519e97ef5d31 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -545,6 +545,8 @@ static const char *drm_get_wedge_recovery(unsigned in=
t opt)
>  		return "bus-reset";
>  	case DRM_WEDGE_RECOVERY_VENDOR:
>  		return "vendor-specific";
> +	case DRM_WEDGE_RECOVERY_COLD_RESET:
> +		return "cold-reset";

[Severity: High]
This is a pre-existing issue, but will adding the "cold-reset" recovery
method cause the event_string buffer to overflow and silently truncate?

Looking at drm_dev_wedged_event() in drivers/gpu/drm/drm_drv.c, the
event_string buffer is limited to 32 bytes (WEDGE_STR_LEN). If multiple
recovery methods are combined, their appended strings can exceed this limit:

drivers/gpu/drm/drm_drv.c:drm_dev_wedged_event() {
	char event_string[WEDGE_STR_LEN]; ...
	...
	len =3D scnprintf(event_string, sizeof(event_string), "%s", "WEDGED=3D");

	for_each_set_bit(opt, &method, BITS_PER_TYPE(method)) {
		recovery =3D drm_get_wedge_recovery(opt);
		...
		len +=3D scnprintf(event_string + len,
				 sizeof(event_string) - len, "%s,", recovery);
	}

	if (recovery)
		/* Get rid of trailing comma */
		event_string[len - 1] =3D '\0';
...
}

When the string is truncated by scnprintf() to fit the 32-byte buffer, could
the trailing comma removal blindly overwrite the last character of the
truncated word (e.g. chopping "cold-reset" down to "cold-r")? It appears th=
is
might result in a malformed UAPI payload being sent to userspace when
multiple recovery methods are combined.

>  	default:
>  		return NULL;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805071152.1225=
416-6-mallesh.koujalagi@intel.com?part=3D1
