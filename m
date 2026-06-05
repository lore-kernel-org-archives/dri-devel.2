Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698EECD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 12:48:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD289112B0E;
	Fri,  5 Jun 2026 12:48:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DnvhNc6o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04652112B0E
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 12:48:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BD15D40735;
 Fri,  5 Jun 2026 12:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81BEE1F00893;
 Fri,  5 Jun 2026 12:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780663702;
 bh=ygbVMbIOEi7SA3cbzLPCnqZHhzljDDucEAyQ+RyDinw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DnvhNc6ozCdJ5tFBmZfV39ihrnGVnWIBRKg8ErMdMa+OT8Pl9T25FWdkdDSl03rBX
 xr+gLXolG3Zmj4WgZb0vBKyo3kd275J2UBCD6WWlGYF8je4ZTaj87f9PDbKOzcaKWJ
 jSKwrQ0Ob1+/PU9NoECKJnopYeYYcNANc+tegrHceXcj35P3L5nZFZ3UjGj35wD8om
 DB79Eca/wd7hVQvylVYPxz+KPxkENH/46b/+zm2lMbzMXfse3PB2nEgjTjAqM8ffdf
 IxV0L7lyEF2mSepvnKm0tahgG6M+Up2GJXSN6+SgSrLdT+YXV/EHglw4EVi8eTaTWk
 6GOIyQgts4gIQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/6] drm/xe: Handle PUNIT errors by requesting
 cold-reset recovery
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260605122544.1021695-12-mallesh.koujalagi@intel.com>
References: <20260605122544.1021695-12-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 12:48:22 +0000
Message-Id: <20260605124822.81BEE1F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] Emitting a DRM wedged uevent before the device is registered in sy=
sfs causes the uevent to be silently dropped, losing the cold-reset notific=
ation.
- [High] Concurrent modification of unprotected `xe->wedged.method` can cau=
se the `COLD_RESET` recovery method to be overwritten.
--

commit d8f11e3cba2116967c1b1af489f30a2fd996f664
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe: Handle PUNIT errors by requesting cold-reset recovery

When PUNIT errors are detected that persist across warm resets, this
commit marks the device as wedged with DRM_WEDGE_RECOVERY_COLD_RESET
and notifies userspace that a complete device power cycle is required.

> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c

[ ... ]

> @@ -207,6 +209,12 @@ static enum xe_ras_recovery_action handle_core_compu=
te_errors(struct xe_ras_erro
>  	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>  }
> =20
> +static void punit_error_handler(struct xe_device *xe)
> +{
> +	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);

[Severity: High]
This is a pre-existing issue, but does concurrent modification of the
unprotected xe->wedged.method here cause the COLD_RESET recovery method to
be overwritten?

If a concurrent event (such as a GT hang timeout) triggers
xe_device_declare_wedged() concurrently, there appears to be a race
condition. The concurrent thread may evaluate if (!xe->wedged.method) as
true just before punit_error_handler() executes xe_device_set_wedged_method=
()
with DRM_WEDGE_RECOVERY_COLD_RESET.

The concurrent thread would then execute:

xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_REBIND |
                                DRM_WEDGE_RECOVERY_BUS_RESET);

Will this overwrite the COLD_RESET method and result in an incorrect
recovery uevent being broadcast to userspace?

> +	xe_device_declare_wedged(xe);

[Severity: High]
This isn't a bug introduced by this patch, but does emitting a DRM wedged
uevent before the device is registered in sysfs cause the uevent to be
silently dropped?

During driver initialization, xe_device_probe() calls xe_ras_init(), which
processes preexisting hardware errors. If a PUNIT error is detected at this
stage, punit_error_handler() marks the device as wedged and calls
xe_device_declare_wedged(), which in turn calls drm_dev_wedged_event().

Since drm_dev_register() has not yet been called at this stage of the probe,
device_add() has not executed, leaving state_in_sysfs =3D 0 for the kobject.
The core kobject_uevent_env() explicitly drops events for unlinked kobjects.

Does this cause the WEDGED=3Dcold-reset uevent notification intended for
userspace to be permanently lost, leaving the device unusable without
userspace automation knowing it needs to power-cycle the slot?

> +}
> +
>  static enum xe_ras_recovery_action handle_soc_internal_errors(struct xe_=
device *xe,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605122544.1021=
695-8-mallesh.koujalagi@intel.com?part=3D4
