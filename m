Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F35C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 10:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B94210E3E9;
	Thu, 27 Aug 2026 10:35:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RUMmw2N2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC06A10E3E9;
 Thu, 27 Aug 2026 10:35:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ECE00600D2;
 Thu, 27 Aug 2026 10:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77AF91F000E9;
 Thu, 27 Aug 2026 10:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787826906;
 bh=OSoeOCuHv6g9hVLAm2Hx1Kt4uvqKSUiUvxdNtfTzTtA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RUMmw2N2k4yWPt2BsO2DNrUiqGJRLF+ASqHimInduR9TWbFnTzZm8P4tP2Zuxl+W2
 3lszbKKuMcKinFacpM6JxfsdCyfNwtU2uiPj7IDpyyVMSWR/7AJIv+pDOOyUTFZH+l
 I7HmK7oMgTVB8sSvjhxTtnEd56vmKv4dTvqRANS+vMZvsUo2+L+b9O/x01J9hALArP
 heb4w+m8TJVsFCSxX77sHWa2ilSq9nLVNjDjSBy/mJWurM5d8GazLZ/EWSCdvOq75y
 xAX+hXdHj+HRa7V2OxpO0IUbah14xZY8lt153F1OOwqCMtSA8UR2G+FGyiCz2NP3G9
 OkHEvh+CUesfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] drm/xe: Isolate a wedged device before notifying
 userspace
To: "Arvind Yadav" <arvind.yadav@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20260827101801.1247654-10-arvind.yadav@intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-10-arvind.yadav@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 27 Aug 2026 10:35:05 +0000
Message-Id: <20260827103506.77AF91F000E9@smtp.kernel.org>
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
- [High] TOCTOU race in `xe_pci_suspend` allows concurrent execution of `xe=
_pm_suspend` and the asynchronous wedge worker, leading to unbalanced PCI e=
nable counts and unsafe MMIO accesses.
- [High] The xe_pci_resume function unconditionally toggles D3Cold, leading=
 to unbalanced power state changes when the device is wedged.
--

commit fc050bbcfed735c33773bd7fb0bbf0a5e4fe47a1
Author: Arvind Yadav <arvind.yadav@intel.com>

drm/xe: Isolate a wedged device before notifying userspace

This commit introduces a sleepable wedge worker to safely isolate a permane=
ntly
wedged device. It stops interrupt and DMA activity, invalidates VRAM mappin=
gs,
and updates the suspend and resume paths to wait for device isolation and s=
kip
normal PM transitions when the device is wedged.

> diff --git a/drivers/gpu/drm/xe/xe_pci.c b/drivers/gpu/drm/xe/xe_pci.c
> index 1e04e8ef2611f..beaa79d136198 100644
> --- a/drivers/gpu/drm/xe/xe_pci.c
> +++ b/drivers/gpu/drm/xe/xe_pci.c
> @@ -1331,6 +1331,16 @@ static int xe_pci_suspend(struct device *dev)
>  	if (xe_survivability_mode_is_boot_enabled(xe))
>  		return -EBUSY;
> =20
> +	/*
> +	 * Wait until wedge work is queued, then wait for isolation to
> +	 * finish before skipping normal suspend.
> +	 */
> +	if (xe_device_wedged(xe)) {
> +		wait_for_completion(&xe->wedged.prepared);
> +		flush_work(&xe->wedged.work);
> +		return 0;
> +	}
> +

[Severity: High]
Does this lockless check open a TOCTOU race window before proceeding to the
normal PM suspend flow and pci_disable_device()?

If the device is declared wedged immediately after the lockless
xe_device_wedged(xe) check evaluates to false, xe_pci_suspend() will
proceed with executing xe_pm_suspend() and eventually calling
pci_disable_device(pdev). Meanwhile, xe_device_wedged_work() executes
concurrently with xe_pm_suspend().

Later during system resume, xe_pci_resume() will see xe_device_wedged(xe)
as true and return early without calling pci_enable_device(pdev). This
results in an unbalanced pci_disable_device() leaving enable_cnt decremented
without a matching increment.

Could this happen if a hardware timeout occurs during the suspend process
itself (e.g., during GT suspend or eviction timeout)?

Also, if the device is already wedged and xe_pci_suspend() returns 0 here,
it skips the d3cold_toggle(pdev, D3COLD_ENABLE) call which occurs later in
this function.

[ ... ]

> @@ -1352,6 +1362,7 @@ static int xe_pci_resume(struct device *dev)
>  {
>  	struct pci_dev *pdev =3D to_pci_dev(dev);
> +	struct xe_device *xe =3D pdev_to_xe_device(pdev);
>  	int err;
> =20
>  	/* Give back the D3Cold decision to the runtime P M*/
>  	d3cold_toggle(pdev, D3COLD_DISABLE);
> =20
>  	err =3D pci_set_power_state(pdev, PCI_D0);
>  	if (err)
>  		return err;
> =20
>  	pci_restore_state(pdev);
> =20
> +	/*
> +	 * Suspend skipped PCI disable for an already isolated device. Avoid
> +	 * incrementing enable_cnt and clear bus mastering restored from the
> +	 * saved configuration.
> +	 */
> +	if (xe_device_wedged(xe)) {
> +		pci_clear_master(pdev);
> +		return 0;
> +	}

[Severity: High]
Does this unconditionally toggle D3Cold before checking if the device is
wedged?

If the device is wedged before xe_pci_suspend() is called, it returns early
and skips the balancing d3cold_toggle(pdev, D3COLD_ENABLE) call. However,
on system resume, xe_pci_resume() unconditionally calls
d3cold_toggle(pdev, D3COLD_DISABLE) before checking if the device is wedged.

Can this lead to an unbalanced call to pci_d3cold_disable(root_pdev) (which
increments no_d3cold) on every suspend/resume cycle once the device has been
permanently wedged, eventually breaking D3Cold power management for the
root port?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260827101801.1247=
654-1-arvind.yadav@intel.com?part=3D9
