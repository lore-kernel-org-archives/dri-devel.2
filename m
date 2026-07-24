Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E70BC531C9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 10:20:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F710F330;
	Fri, 24 Jul 2026 10:20:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BNHbjjvo";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6487C10F330
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 10:20:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7761D600C3;
 Fri, 24 Jul 2026 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA071F000E9;
 Fri, 24 Jul 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784888421;
 bh=xPXvf4ZxoLPXzFz9D//qO76euT0NkJhn5InUS4T8hOM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BNHbjjvoKaQh8SSfRWT7lOqA0g6rFaCdwH/clNrpq5k/Ujdvb+2Qz8OF16W8YgJ9v
 TZJxkhPGxePjwlYCt3QVJLptwqmVdqnjAHi3JwLzBwUQPoy4tzTyvlo4HcXUnhMgmU
 9LpGbMoVrdOOB3b8eQAWMov5e8jBG5N1imTM5+/7FpY25A6WkN2DiVonsma+nyXGjE
 l1TvoH6SoMRiEYPLdWca1L02cKWqJOrplxEVoJR+pvDimh23VwluWYGVJSipP4PgxO
 q6K/v0u4JtgSpxPIogE/lxsvNdFPCwV0l9oWNQX4dtVGMlg39myviV1OeeH61y1Apx
 2XHE89La7V9rQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger punit
 error handler
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260724100302.706685-10-mallesh.koujalagi@intel.com>
References: <20260724100302.706685-6-mallesh.koujalagi@intel.com>
 <20260724100302.706685-10-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Jul 2026 10:20:20 +0000
Message-Id: <20260724102020.EFA071F000E9@smtp.kernel.org>
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
- [High] Real hardware errors (PUNIT/CSC) detected during probe trigger a b=
roken KOBJ_CHANGE uevent with an unresolvable DEVPATH, dropping the event s=
ilently and breaking cold-reset recovery. The patch works around this exclu=
sively for injected errors, leaving the real bug unhandled.
--

--- Patch [4]: [PATCH v12 4/4] drm/xe/ras: Use fault-inject to trigger puni=
t error handler ---
commit 7bec129b8ce98871b6643acdf5450a3fe7c276cd
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe/ras: Use fault-inject to trigger punit error handler

Use fault-inject framework to trigger punit_error_handler()
for testing.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 92b4181026cbe..da06c16cf7ed9 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c
> @@ -391,6 +392,22 @@ enum xe_ras_recovery_action xe_ras_process_errors(st=
ruct xe_device *xe)
>  	size_t rlen;
>  	int ret;
> =20
> +	/*
> +	 * Only allow the injected PUNIT error once the DRM device is registere=
d.
> +	 * xe_ras_process_errors() also runs during probe (via xe_ras_init()), =
before
> +	 * drm_dev_register() calls device_add() on the DRM minor's kdev. At th=
at
> +	 * point kdev->kobj.parent is not yet linked into the sysfs hierarchy, =
so
> +	 * kobject_get_path() returns "/card0" instead of the real sysfs path.
> +	 * drm_dev_wedged_event() would then emit a KOBJ_CHANGE uevent with a w=
rong
> +	 * DEVPATH that udev cannot resolve, silently dropping the event and le=
aving
> +	 * the cold-reset recovery broken.
> +	 */
> +	if (xe->drm.registered && xe_fault_punit_error()) {
> +		xe_err(xe, "[RAS]: PUNIT error injected\n");
> +		punit_error_handler(xe);
> +		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
> +	}

[Severity: High]
Does this same broken uevent issue also apply to real hardware errors detec=
ted
during probe?

The comment correctly identifies that calling punit_error_handler() before=
=20
the DRM device is registered emits a KOBJ_CHANGE uevent with a wrong DEVPAT=
H.
However, if a real PUNIT error is detected during probe, the code bypasses
this guard and proceeds to handle_soc_internal_errors():

drivers/gpu/drm/xe/xe_ras.c:xe_ras_process_errors() {
	...
	case XE_RAS_COMP_SOC_INTERNAL:
		action =3D handle_soc_internal_errors(xe, arr);
		break;
	...
}

Which unconditionally calls punit_error_handler() without the
xe->drm.registered check:

drivers/gpu/drm/xe/xe_ras.c:handle_soc_internal_errors() {
	...
	if (ieh_error->global_error_status & XE_RAS_SOC_IEH_PUNIT) {
		xe_err(xe, "[RAS]: PUNIT %s detected: 0x%x\n",
		       sev_to_str(counter->common.severity),
		       ieh_error->global_error_status);
		punit_error_handler(xe);
		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
	}
	...
}

Should the underlying uevent emission in punit_error_handler() be delayed
or guarded until after registration, rather than only working around it for
injected errors?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724100302.7066=
85-6-mallesh.koujalagi@intel.com?part=3D4
