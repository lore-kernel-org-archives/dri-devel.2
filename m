Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1E5606A329
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 22:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kRLN+rD0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 747C310E67E;
	Mon,  2 Nov 2026 22:33:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA7610E599;
 Mon,  2 Nov 2026 22:33:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D3F30600D1;
 Mon,  2 Nov 2026 22:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639BC1F00A16;
 Mon,  2 Nov 2026 22:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793658820;
 bh=uZS2HiIL4c9FSQYqnmXre+q40hhQZlrSFKgeKy0/YEk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kRLN+rD0AaS4RRXDNkISl2xjvnrARfv8oSt1ZLq/pncFcZ8EFrJZVtwIdraJmaNdD
 DnCHpE3GCqvFSHfiFO7ghST3gdOdO0eyG387KayyoIF9AvcbwQvLLUh0z0ALcOQRxv
 zicQO0QBDSId/hmmZ3fwBERLGW0GpZ1rfzfrDqDxQEdlLGHB5GkYupe+0sCQXh6p+d
 IR+tJKqLjPC7CINlpCf1M1PhRAYTSC0xE065n+ZklefYAytb+Kw35Wj2mlvOogGTWm
 Ul4Lj+4xXfLppSR5zdadGXquRucRpYn+Q14PMuoGB3W+JUq2taPLqAUbu2WuqghpS0
 +wgTrysNzH10w==
Message-ID: <sashiko-outbox-194291@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/1] drm/xe/survivability: broadcast dmesg when engaging
 survivability
To: "Alan Previn" <alan.previn.teres.alexis@intel.com>,
 intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261102222643.1758080-2-alan.previn.teres.alexis@intel.com>
References: <20261102222643.1758080-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 22:33:39 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/xe: short-circuit in xe_device_probe_early() suppresses surv=
ivability log
--

commit 61c74e2642fe230ed9329d7da9f94eb01df2fc3a
Author: Alan Previn <alan.previn.teres.alexis@intel.com>

drm/xe/survivability: broadcast dmesg when engaging survivability

This commit renames xe_survivability_mode_is_requested() to
xe_survivability_mode_is_required() and moves the survivability dmesg
logging from enable_boot_survivability_mode() into a shared helper
survivability_mode_required().

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
> index 45d44ebe288b4..f8619c0db3d95 100644
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
> +static bool survivability_mode_required(struct xe_device *xe, bool log_o=
n_action)
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
>  		return 0;

[Severity: Medium]
As reported by Sashiko on v1 [1], moving the survivability messages out of
enable_boot_survivability_mode() and gating them on log_on_action in
survivability_mode_required() causes a few issues depending on whether
xe_pcode_probe_early() succeeds or fails.

In drivers/gpu/drm/xe/xe_device.c:xe_device_probe_early():

	err =3D xe_pcode_probe_early(xe);
	if (err || xe_survivability_mode_is_required(xe)) {
		int save_err =3D err;

		err =3D xe_survivability_mode_boot_enable(xe);

When xe_pcode_probe_early() returns a non-zero error code (which is the
normal hardware boot-survivability path when PCODE initialization fails),
the logical OR short-circuits and xe_survivability_mode_is_required() is
never called.

Execution then proceeds to xe_survivability_mode_boot_enable(), which calls
survivability_mode_required(xe, false) with log_on_action set to false, and
then enable_boot_survivability_mode(), where the "Boot Mode enabled!" logs
were removed. Does this cause boot survivability mode to be enabled without
emitting any survivability dmesg or XE_SIGID_SURVIVABILITY message at all
whenever xe_pcode_probe_early() fails?

Conversely, when xe_pcode_probe_early() returns 0 and check_boot_failure()
is true, xe_survivability_mode_is_required() calls
survivability_mode_required(xe, true) and emits the fatal
XE_SIGID_SURVIVABILITY log before xe_survivability_mode_boot_enable()
populates the survivability info and checks the breadcrumb version:

	populate_survivability_info(xe);

	/*
	 * v2 supports survivability mode for critical errors
	 */
	if (survivability->version < 2  && survivability->boot_status =3D=3D CRITI=
CAL_FAILURE) {
		log_survivability_info(xe);
		return -ENXIO;
	}

In that case, the fatal survivability log is emitted even when
xe_survivability_mode_boot_enable() aborts with -ENXIO, and when it does
succeed, there is no longer a message confirming that boot survivability
mode was enabled.

Would it work better to log inside xe_survivability_mode_boot_enable() or
enable_boot_survivability_mode() so both the err !=3D 0 and err =3D=3D 0 pa=
ths
are covered without duplicate checks?

[1] https://lore.kernel.org/r/20261030171738.674775-2-alan.previn.teres.ale=
xis@intel.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102222643.1758=
080-2-alan.previn.teres.alexis@intel.com?part=3D1
