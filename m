Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01591C531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5531010F35C;
	Fri, 24 Jul 2026 10:29:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T16xpMK2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE8B10F35C
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:29:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EBB32600AB;
 Fri, 24 Jul 2026 10:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEBE1F000E9;
 Fri, 24 Jul 2026 10:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784888952;
 bh=05kUCSXIcLexNamdryQwBCWU7PraAAH79lgUwlTPYww=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T16xpMK2Ho1YpZTV+bj5YQVfCp8U54AGodEmjYwRLHNCPIjRBxTXntwi3X1Ibv8Vu
 hIAVvuY+jq2Em3AFgoNy4J5r7KVzgzrYH3yr4hSCC8qxjOgASIWaciVeLWH/uLY7GC
 lujkcmiRpwDILv4RJ8mpd+nsXh4Ek5GhykMZGiRLDZ9xrC8gpdOwlf6to7hBhBss0G
 k9gKStUo2eg+B39akZ9Y7eKgvsRSFAAkS+IAqQ6KaPtFWYcbG82xfUR0BYuQtv08EN
 tlKTlWEPB14VYw0Z5CcDM+pX/+ulII1rI8dlaAiEf+k/TH+s/ZToJ02yKu3prbU0Jl
 agdCAxFCy29QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 3/4] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724100302.706685-9-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-9-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:29:11 +0000
Message-Id: <20260724102912.6FEBE1F000E9@smtp.kernel.org>
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
- [High] Calling `xe_device_declare_wedged()` during driver probe silently =
drops the `WEDGED` uevent because the DRM device is not yet registered in s=
ysfs, and `xe_ras_init()` ignores the disconnect return value, leaving user=
space unaware of a permanently wedged device.
- [High] Unprotected writes to `xe->wedged.method` cause a data race with c=
oncurrent wedge events, which can overwrite the critical `DRM_WEDGE_RECOVER=
Y_COLD_RESET` recovery method, and lack of state checking leads to redundan=
t uevent flooding.
--

--- Patch [3]: [PATCH v12 3/4] drm/xe: Handle PUNIT errors by requesting co=
ld-reset recovery ---
commit 340a6fc7bdb22fd2c21615ec29270c2b330f42ea
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

This commit handles PUNIT errors by setting the wedge recovery method to
cold reset and declaring the device wedged. This ensures that userspace is
notified that a complete device power cycle is required to restore normal
operation.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index a31e06b8aa67a..92b4181026cbe 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -236,6 +236,12 @@ static u8 handle_core_compute_errors(struct xe_ras_e=
rror_array *arr)
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
> =20
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);

[Severity: High]
Does this unprotected write to xe->wedged.method create a data race?

If another thread (e.g., PCI AER or GT reset) concurrently calls
xe_device_declare_wedged(), it could evaluate if (!xe->wedged.method) before
this assignment, and overwrite DRM_WEDGE_RECOVERY_COLD_RESET with the defau=
lt
DRM_WEDGE_RECOVERY_REBIND | DRM_WEDGE_RECOVERY_BUS_RESET.

Also, since xe_ras_process_errors() processes multiple errors in a loop:

drivers/gpu/drm/xe/xe_ras.c:xe_ras_process_errors() {
    ...
    for (int i =3D 0; i < response.num_errors && i < XE_RAS_NUM_ERROR_ARR; =
i++) {
        // error handler called
    ...
}

Will this cause a flood of redundant uevents and wedge method assignments if
multiple PUNIT errors are returned in a single response?

> +	xe_device_declare_wedged(xe);

[Severity: High]
Can this call silently drop the WEDGED uevent if it occurs during driver pr=
obe?

If a PUNIT error is detected during early probe via:
xe_device_probe() -> xe_ras_init() -> xe_ras_process_errors() ->=20
handle_soc_internal_errors() -> punit_error_handler()

The uevent sent by drm_dev_wedged_event() (called from
xe_device_declare_wedged()) will fail with -EINVAL because the DRM device is
not yet registered in sysfs (kobj->state_in_sysfs is false).

Furthermore, since xe_ras_init() ignores the XE_RAS_RECOVERY_ACTION_DISCONN=
ECT
return value, will the system boot with a wedged GPU while userspace is
completely unaware?

> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724100302.7066=
85-6-mallesh.koujalagi@intel.com?part=3D3
