Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A5CDB47F
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 22:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DA910ED36;
	Tue, 23 Jun 2026 22:47:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oCkTC4oz";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80F110ED31
 for <dri-devel@lists.freedesktop.org>; Tue, 23 Jun 2026 22:47:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5CFC1601DC;
 Tue, 23 Jun 2026 22:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBE521F000E9;
 Tue, 23 Jun 2026 22:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782254866;
 bh=EHZm42tlnEKTc+MsjAZhb1pwjrmI+U5ivYtvO/o1A7s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oCkTC4ozNWY0oh8g1GdEAqN2s3bxRbw2wReVco9QNCPzVwuOjXgEjkGeTMJfNIZRW
 B3qNbU3Uuc4bg8sobE/SIJx82HME6XRfXlKVk96BG+LCxERMSI3erUlTiUwtViohqJ
 7S7xUxu/0VK6q51AV4uY4qIej1Nt1P+j2ZzuFEULCsU3vExanZ+HAHs76CBfZRDPwz
 hQ4/z8MpGaWWIcTyovUntUQD2s88yu1QFWpVJEniSpUkZfNHyVH5gBpi+8FZXSOEyS
 59GDmMXockrWzM5MaK/180ligTUY5r7dXznZ1ZhSJ6HEEUb7s0CPvLk/Omjj8PzR+O
 Kj2FdsfctXEhg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 6/6] drm/xe/ras: Use fault-inject to trigger punit
 error handler
To: "Mallesh Koujalagi" <mallesh.koujalagi@intel.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260622131458.144873-14-mallesh.koujalagi@intel.com>
References: <20260622131458.144873-8-mallesh.koujalagi@intel.com>
 <20260622131458.144873-14-mallesh.koujalagi@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:47:45 +0000
Message-Id: <20260623224745.EBE521F000E9@smtp.kernel.org>
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
- [Medium] Global struct fault_attr causes dentry reference leak and cross-=
device state contamination
- [Medium] Potential NULL pointer dereference during early probe if wedged =
event is sent before DRM device registration
--

commit f49d10330bc9238666f6e80cf2c7887368a6612b
Author: Mallesh Koujalagi <mallesh.koujalagi@intel.com>

drm/xe/ras: Use fault-inject to trigger punit error handler

Use fault-inject framework to trigger punit_error_handler()
for testing.

> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debu=
gfs.c
> index 22b471303984a..3a90deb5596ce 100644
> --- a/drivers/gpu/drm/xe/xe_debugfs.c
> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> @@ -40,6 +40,7 @@
> =20
>  DECLARE_FAULT_ATTR(gt_reset_failure);
>  DECLARE_FAULT_ATTR(inject_csc_hw_error);
> +DECLARE_FAULT_ATTR(inject_punit_error);
> =20
>  static void read_residency_counter(struct xe_device *xe, struct xe_mmio =
*mmio,
>  				   u32 offset, const char *name, struct drm_printer *p)

[ ... ]

> @@ -612,6 +613,8 @@ void xe_debugfs_register(struct xe_device *xe)
> =20
>  	fault_create_debugfs_attr("fail_gt_reset", root, &gt_reset_failure);
> =20
> +	fault_create_debugfs_attr("inject_punit_error", root, &inject_punit_err=
or);

[Severity: Medium]
Since inject_punit_error is declared as a global attribute, will calling
fault_create_debugfs_attr() for each device overwrite attr->dname?

Looking at fault_create_debugfs_attr(), it unconditionally assigns
attr->dname =3D dget(dir). If the system has multiple XE GPUs, each
subsequent device's debugfs registration would overwrite attr->dname without
calling dput() on the previous reference, leaking the dentry.

Would this also expose a single global fault injection state across all
devices, meaning a write to one device's debugfs file unintentionally alters
the behavior for all other XE devices?

> +
>  	if (IS_SRIOV_PF(xe))
>  		xe_sriov_pf_debugfs_register(xe, root);
>  	else if (IS_SRIOV_VF(xe))
> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
> index 5a2fee5a13083..bb8502472f738 100644
> --- a/drivers/gpu/drm/xe/xe_ras.c
> +++ b/drivers/gpu/drm/xe/xe_ras.c

[ ... ]

> @@ -708,6 +717,11 @@ enum xe_ras_recovery_action xe_ras_process_errors(st=
ruct xe_device *xe)
>  	size_t rlen;
>  	int ret;
> =20
> +	if (fault_inject_punit_error()) {
> +		punit_error_handler(xe);
> +		return XE_RAS_RECOVERY_ACTION_DISCONNECT;
> +	}

[Severity: Medium]
Could this trigger a NULL pointer dereference during early probe?

xe_ras_init() is called during driver probe and executes
xe_ras_process_errors(). If the injected fault triggers here, it executes
punit_error_handler() which in turn calls xe_device_declare_wedged().

If xe_device_declare_wedged() invokes drm_dev_wedged_event() to notify
userspace before the DRM device interface is fully registered (before
drm_dev_register() initializes the minor's kdev), it might evaluate
&dev->primary->kdev->kobj and dereference NULL.

Because the inject_punit_error fault attribute is global, if a user sets
the probability to 100% on the first probed device, could it inadvertently
trigger during the probe of a subsequently attached device and crash the
system?

> +
>  	if (!xe->info.has_sysctrl)
>  		return XE_RAS_RECOVERY_ACTION_RESET;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260622131458.1448=
73-8-mallesh.koujalagi@intel.com?part=3D6
