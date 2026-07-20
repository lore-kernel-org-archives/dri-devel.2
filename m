Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56308C44520
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 10:48:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 930D710E885;
	Mon, 20 Jul 2026 10:48:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="b4zUMSNC";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B9EF10E885
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 10:48:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB20860A8E;
 Mon, 20 Jul 2026 10:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51BD11F00A3A;
 Mon, 20 Jul 2026 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784544496;
 bh=cEIhehe1o2I/ETS88uejqY+0p9/hRes8BbOj9yeJNQ0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b4zUMSNC+PiEhvbEYbGRX4M3tt8lCkWouI/Ys3QJwJfm6F7qYqYBTO8x2LF8ZoBc9
 FRGHz69h0gBJEq50yXCsoq0D3/fO2BLCK1t81KrGIobQ0j1uJvx69zkJCtPzv5GXwM
 I8jm0TCzQXKtNZlTOCKrf6yAHZBSsZbXlsCKQTdu6Mk5Pi/EvXEDMzw1mhFpqlu3p9
 66pj8RbXtu5fIwAU5EDN55c57a+oDyBZv7nDa9OyGpeWupMmJKhybUQqtm0X7TYLxe
 LxVzrx1da6Yk/05+DMbJlaun7njk02EQnNJxGxbLPOxcNXd6hCXKNt4x3gcYcIwhSg
 oj4gTdH7U2Jtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720101815.526813-8-mallesh.koujalagi@intel.com>
References: <20260720101815.526813-5-mallesh.koujalagi@intel.com>
 <20260720101815.526813-8-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:48:15 +0000
Message-Id: <20260720104816.51BD11F00A3A@smtp.kernel.org>
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
- [High] Calling `xe_device_declare_wedged()` during early driver probe fai=
ls to notify userspace because the DRM device is not yet registered in sysf=
s.
--

--- Patch [3]: [PATCH v11 3/3] drm/xe: Handle PUNIT errors by requesting co=
ld-reset recovery ---
commit e4801339581daca0be0db10f90d94f25e72cfa52
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

When PUNIT (power management unit) errors are detected that persist across
warm resets, mark the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notify userspace that a complete device power cycle is required to
restore normal operation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index a31e06b8aa67a..92b4181026cbe 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
[ ... ]
> @@ -236,6 +236,12 @@ static u8 handle_core_compute_errors(struct xe_ras_e=
rror_array *arr)
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
> =20
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
> +	xe_device_declare_wedged(xe);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does calling xe_device_declare_wedged() here fail to notify userspace when
triggered during early driver probe?

If a PUNIT error is present at driver load, the call chain is:

xe_device_probe()
  xe_ras_init()
    xe_ras_process_errors()
      handle_soc_internal_errors()
        punit_error_handler()
          xe_device_declare_wedged()
            drm_dev_wedged_event()

Since drm_dev_register() has not yet been called at this stage of the probe
path, the sysfs directory for the DRM device does not exist, and the KOBJ_A=
DD
event has not been emitted.

Consequently, userspace (e.g., udev) will likely drop or ignore the KOBJ_CH=
ANGE
uevent emitted by drm_dev_wedged_event().

Will this cause the device to finish probe successfully but leave userspace
unaware of the wedged state, breaking the automated cold reset recovery
mechanism?

> +}
> +
>  static u8 handle_soc_internal_errors(struct xe_device *xe, struct xe_ras=
_error_array *arr)
>  {
>  	struct xe_ras_soc_error *info =3D (void *)arr->details;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720101815.5268=
13-5-mallesh.koujalagi@intel.com?part=3D3
