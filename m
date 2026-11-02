Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07020606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vj1FPBfj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7143610E724;
	Mon,  2 Nov 2026 22:27:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B443410E724;
 Mon,  2 Nov 2026 22:27:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CA7B1600D1;
 Mon,  2 Nov 2026 22:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 509121F00A16;
 Mon,  2 Nov 2026 22:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793658430;
 bh=i3FX9/+gCC5EiULYFoAqy+2e0e5NJ8aDeIJ/xZy2iAY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Vj1FPBfjFuAT61+wujrJz4mge0mnKjoJ1yh+ptSZlBwymO7TFkPdtMWRt2PPRaGao
 H5Qs89GjYUaXC86UU3VV/9yx6cMPrGj9yDWVBiDIp7DPKOLPDZwd7nOLOvNXyo0GWt
 QBrH/SKG59gr/yb4odWiBojyqyzHO9SWyZg3jyYZ+sgh8hOOAQ6gUdmg0FmbcNz8tq
 CuD3myaXG+C2EndgQPEd66F+TLoAM9st94IE2An5Fyyp/haN5nB2ek+U2MdTOwH8oX
 /zUMcMl6pTKxI2L+q3KO6q0X+uAlAxi0laGfZzwZfGi323C0gGQMksLbiji6TqQF8U
 GLB8Hfpqu5F1g==
Message-ID: <sashiko-outbox-194284@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102221913.1746196-2-alan.previn.teres.alexis@intel.com>
References: <20261102221913.1746196-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:27:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] drm/xe/survivability: missing boot survivability log when pcode =
probe fails
- [Low] drm/xe/survivability: missing static on survivability_mode_required=
()
--

commit 76e10b908f7904219e63d606ae1f0f79dc234cdb
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/survivability: broadcast dmesg when engaging survivability

This commit renames xe_survivability_mode_is_requested() to
xe_survivability_mode_is_required() and moves boot survivability logging fr=
om
enable_boot_survivability_mode() into survivability_mode_required() when
log_on_action is true.

> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_devic=
e.c
> index 7e6027f49a4ca..bb0ccae7f13a8 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -727,7 +727,7 @@ int xe_device_probe_early(struct xe_device *xe)
>  	 * the driver will be blocked
>  	 */
>  	err =3D xe_pcode_probe_early(xe);
> -	if (err || xe_survivability_mode_is_requested(xe)) {
> +	if (err || xe_survivability_mode_is_required(xe)) {
>  		int save_err =3D err;
> =20
>  		/*
> diff --git a/drivers/gpu/drm/xe/xe_survivability_mode.c b/drivers/gpu/drm=
/xe/xe_survivability_mode.c
> index 45d44ebe288b4..50af47ac58cc7 100644
> --- a/drivers/gpu/drm/xe/xe_survivability_mode.c
> +++ b/drivers/gpu/drm/xe/xe_survivability_mode.c
> @@ -363,11 +363,6 @@ static int enable_boot_survivability_mode(struct pci=
_dev *pdev)
>  	if (ret)
>  		goto failed;
> =20
> -	if (check_boot_failure(xe))
> -		xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode enabled!\n");
> -	else
> -		xe_log_info(pdev, SURVIVABILITY, "Boot Mode enabled!\n");
> -
>  	return 0;
> =20
>  failed:
> @@ -389,17 +384,7 @@ bool xe_survivability_mode_is_boot_enabled(struct xe=
_device *xe)
>  	return survivability->mode && survivability->type =3D=3D XE_SURVIVABILI=
TY_TYPE_BOOT;
>  }
> =20
> -/**
> - * xe_survivability_mode_is_requested - check if it's possible to enable=
 survivability
> - *					mode that was requested by firmware or userspace
> - * @xe: xe device instance
> - *
> - * This function reads configfs and  boot status from Pcode.
> - *
> - * Return: true if platform support is available and boot status indicat=
es
> - * failure or if survivability mode is requested, false otherwise.
> - */
> -bool xe_survivability_mode_is_requested(struct xe_device *xe)
> +bool survivability_mode_required(struct xe_device *xe, bool log_on_actio=
n)

[Severity: Low]
Should survivability_mode_required() be marked static? It is only called
within drivers/gpu/drm/xe/xe_survivability_mode.c and has no prototype in
drivers/gpu/drm/xe/xe_survivability_mode.h, which will trigger a
-Wmissing-prototypes compiler warning (and fail the build when
CONFIG_DRM_XE_WERROR or CONFIG_WERROR is enabled).

>  {
>  	struct xe_survivability *survivability =3D &xe->survivability;
>  	struct xe_mmio *mmio =3D xe_root_tile_mmio(xe);
> @@ -412,13 +397,36 @@ bool xe_survivability_mode_is_requested(struct xe_d=
evice *xe)
> =20
>  	survivability_mode =3D xe_configfs_get_survivability_mode(pdev);
>  	/* Enable survivability mode if set via configfs */
> -	if (survivability_mode)
> +	if (survivability_mode) {
> +		if (log_on_action)
> +			xe_log_info(xe, SURVIVABILITY, "Boot mode requested.\n");
>  		return true;
> +	}
> =20
>  	data =3D xe_mmio_read32(mmio, PCODE_SCRATCH(0));
>  	survivability->boot_status =3D REG_FIELD_GET(BOOT_STATUS, data);
> =20
> -	return check_boot_failure(xe);
> +	if (check_boot_failure(xe)) {
> +		if (log_on_action)
> +			xe_log_err_fatal(pdev, SURVIVABILITY, 0, "Boot Mode required!\n");
> +		return true;
> +	}
> +	return false;
> +}
> +
> +/**
> + * xe_survivability_mode_is_required - check if survivability mode is re=
quired based on
> + *                                     state of firmware or userspace re=
quest.
> + * @xe: xe device instance
> + *
> + * This function reads configfs and boot status from Pcode.
> + *
> + * Return: true if platform support is available and boot status indicat=
es
> + * failure or if survivability mode is requested, false otherwise.
> + */
> +bool xe_survivability_mode_is_required(struct xe_device *xe)
> +{
> +	return survivability_mode_required(xe, true);
>  }
> =20
>  /**
> @@ -468,7 +476,7 @@ int xe_survivability_mode_boot_enable(struct xe_devic=
e *xe)
>  	struct xe_survivability *survivability =3D &xe->survivability;
>  	struct pci_dev *pdev =3D to_pci_dev(xe->drm.dev);
> =20
> -	if (!xe_survivability_mode_is_requested(xe))
> +	if (!survivability_mode_required(xe, false))

[Severity: Medium]
Does this suppress all boot survivability dmesg messages when
xe_pcode_probe_early() returns an error?

In drivers/gpu/drm/xe/xe_device.c, xe_device_probe_early() checks:

	err =3D xe_pcode_probe_early(xe);
	if (err || xe_survivability_mode_is_required(xe)) {
		int save_err =3D err;

		err =3D xe_survivability_mode_boot_enable(xe);

When pcode initialization fails (err !=3D 0), the || operator short-circuits
and skips calling xe_survivability_mode_is_required(xe). Execution then
enters xe_survivability_mode_boot_enable(xe), which calls
survivability_mode_required(xe, false) with log_on_action set to false.

Because the "Boot Mode enabled!" messages were also removed from
enable_boot_survivability_mode(), won't entering boot survivability mode on
a pcode probe failure result in no survivability message being logged at
all?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102221913.1746=
196-2-alan.previn.teres.alexis@intel.com?part=3D1
