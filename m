Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B933CC55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 07:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C10B10E1E1;
	Wed,  5 Aug 2026 07:30:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Hp/FBZ0W";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6129810E1E1
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 07:30:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53235600AE;
 Wed,  5 Aug 2026 07:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D44081F00A3A;
 Wed,  5 Aug 2026 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785915028;
 bh=5Cm3Ho3Tzf6+u6xDvCxsRQXpAqlaj3PYU4giGGFmJDQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Hp/FBZ0WMu8yaR1Q61lGm54eun+V8PLxYdsbRI393CDKR0cg08wQ+H9v1ihQjZP23
 5m2qYUER5VlOldgUHwTRekMjtAI/nxN8JWwfXuYgF12FzEj38l8PXgPzT2RVpota8R
 7CJKbJLpT1UToq26p3s6RS++A9xHhzG1S41efxa3kw7NwBg6YFJM/5ispxaOFu0X4e
 MlxuISAQw3Tldn763YMdzbh7KKSzmXSBrL0ySiCBDPIFeh/gBH+idCaPD12RLtcXr2
 QtyKUvpXKM22qM2DJ5AIK3dX1gCZ0bzt2bkHlzriSiw95wlIy7Chnm00dbvOXLj2Ty
 dxRuXCmFNWopQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 3/4] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260805071152.1225416-9-mallesh.koujalagi@intel.com>
References: <20260805071152.1225416-6-mallesh.koujalagi@intel.com>
 <20260805071152.1225416-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 07:30:26 +0000
Message-Id: <20260805073027.D44081F00A3A@smtp.kernel.org>
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
- [High] Unprotected concurrent access to `xe->wedged.method` can cause the=
 `COLD_RESET` recovery method to be overwritten by the `DEFAULT` fallback m=
ethod during simultaneous wedge declarations.
--

--- Patch [3]: [PATCH v13 3/4] drm/xe: Handle PUNIT errors by requesting co=
ld-reset recovery ---
commit 5edfcf29ea367e4df826b556199c8154b0704d81
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

This commit handles PUNIT errors by marking the device as wedged with
DRM_WEDGE_RECOVERY_COLD_RESET, indicating that a full device power cycle
is required to restore normal operation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 352f056fd9ef4..3033a377bace9 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -254,6 +254,12 @@ static u8 handle_core_compute_errors(struct xe_ras_e=
rror_array *arr)
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
> =20
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +	xe_device_declare_wedged(xe);
> +}
        ^^^^

[Severity: High]
This is a pre-existing issue, but can the COLD_RESET recovery method be lost
here due to unprotected concurrent access to xe->wedged.method?

If a GT hang occurs concurrently with a PUNIT error, a race condition can
overwrite the COLD_RESET escalation with the fallback method:

CPU1 (GT hang)
xe_device_declare_wedged()
// Evaluates as true (sees 0)
    if (!xe->wedged.method)

CPU2 (PUNIT error)
punit_error_handler()
    xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);

CPU1 (GT hang)
    // Overwrites COLD_RESET
    xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |=20
                                    DRM_WEDGE_RECOVERY_BUS_RESET);

Because xe->wedged.method is assigned directly and read in a check-then-act
pattern without locking, both threads might pass the incorrect fallback met=
hod
to drm_dev_wedged_event().=20

Could this cause userspace to perform a generic bus reset instead of the=20
required full power cycle?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805071152.1225=
416-6-mallesh.koujalagi@intel.com?part=3D3
