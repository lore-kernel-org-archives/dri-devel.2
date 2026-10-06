Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E837FCA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 04:43:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B1B510F08F;
	Tue,  6 Oct 2026 04:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RPRGNuZp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C84710F08F
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 04:43:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3DE4741B04;
 Tue,  6 Oct 2026 04:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015DB1F000FF;
 Tue,  6 Oct 2026 04:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791261820;
 bh=a4djcaj1z3So799Wrs6651ME3Nx95KfGyqUVZ5P/WXk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RPRGNuZp/V+vSGN9kqWRebgvH3d+URFevnjkEfA2KDI7YkvFURaOhTs+AkDCRHsoI
 deQzpClyNo84YmYOKiCunNoVjz3S20pV52T64JUyqzwxdUnpwnYSV4A486Z7kGrgSG
 LalTekHFXZw2lhyWWChKrW3MOLqjUuyBZcatZq4ML2yljxbGSehbMRDKV8PfZZi8wz
 4Gl6MSZXbCcIruGUmQte6S+pxt/mJSk5DEXXqmgWC/Uf1OUEKp4cYNJFp3rqDt73wN
 eTFFQgS2j5YFPaRrLahxxCy7MJTiJy/D8gH+1BPV0V0PVr/kZOgCMNo+HTRolTf2c+
 TFrtpUs0UuyLA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 19/20] accel/amdxdna: Implement runtime suspend and
 resume support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261006042230.547807-20-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261006042230.547807-1-yidong.zhang@amd.com>
 <20261006042230.547807-20-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 04:43:39 +0000
Message-Id: <20261006044340.015DB1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] accel/amdxdna: VF device link removed on unbind causes PF to suspe=
nd
- [Medium] pm: returning -EOPNOTSUPP from runtime_suspend bricks PM state m=
achine
- [Low] accel/amdxdna: runtime suspend deferral spams kernel log for passth=
rough VFs
--

commit 9c2d41f547122e82068d6c644e6875d8381ac627
Author: David Zhang <yidong.zhang@amd.com>
Subject: accel/amdxdna: Implement runtime suspend and resume support

This commit adds runtime PM support to the AIE4 driver. It wraps the
device PM operations and implements runtime suspend/resume callbacks
for the PF and VF. It also detects passthrough VFs to prevent the PF
from suspending when VFs are in use.

> diff --git a/drivers/accel/amdxdna/aie4_sriov.c b/drivers/accel/amdxdna/a=
ie4_sriov.c
> index 3cad0526087db..c89bb033bb167 100644
> --- a/drivers/accel/amdxdna/aie4_sriov.c
> +++ b/drivers/accel/amdxdna/aie4_sriov.c
[ ... ]
> +/* Check if a VF is actively running workloads or in passthrough. */
> +static int aie4_check_vf_alive(struct amdxdna_dev *xdna, struct pci_dev =
*pdev_vf)
> +{
> +	struct device *pf_dev =3D xdna->ddev.dev;
> +	struct device_driver *drv;
> +	bool busy =3D false;
> +
> +	if (!device_trylock(&pdev_vf->dev)) {
> +		XDNA_WARN(xdna, "VF:%s is busy (locked)", pci_name(pdev_vf));
> +		return -EBUSY;
> +	}
> +
> +	drv =3D pdev_vf->dev.driver;
> +	if (!drv) {
> +		device_unlock(&pdev_vf->dev);
> +		return 0;
> +	}

[Severity: High]
Does returning 0 here allow the PF to suspend prematurely when a VF is
unbound?

In aie4_link_vf(), the device link between the PF and VF is created with
DL_FLAG_AUTOREMOVE_CONSUMER. When the user unbinds the host driver to
prepare for passthrough (e.g., to vfio-pci), this device link drops.

Since the VF temporarily has no driver during this transition, returning 0
here allows the PM core to successfully runtime-suspend the PF.

When vfio-pci later binds to the VF, it wakes the VF, but because the PM
link to the PF no longer exists, the PF remains suspended. The guest VM will
then attempt to use the VF with the underlying hardware powered off.

Could this lead to PCIe AER, host freezes, or MMIO faults?

> +
> +	/* VF bound to a driver other than the PF's (amdxdna) is passthrough. */
> +	if (drv !=3D pf_dev->driver) {
> +		XDNA_WARN(xdna, "VF:%s is in passthrough", pci_name(pdev_vf));
> +		busy =3D true;
> +	} else if (!pm_runtime_suspended(&pdev_vf->dev)) {
> +		XDNA_WARN(xdna, "VF:%s is busy", pci_name(pdev_vf));
> +		busy =3D true;
> +	}
> +
> +	device_unlock(&pdev_vf->dev);
> +	return busy ? -EBUSY : 0;
> +}
> +
> +int aie4_vfs_alive(struct amdxdna_dev *xdna)
> +{
> +	if (pci_vfs_assigned(to_pci_dev(xdna->ddev.dev))) {
> +		XDNA_WARN(xdna, "VF devices are being used in VMs, cannot suspend");
> +		return -EBUSY;
> +	}

[Severity: Low]
Will using XDNA_WARN here flood the kernel log during normal passthrough
operation?

Returning -EBUSY to defer suspend is correct, but the PM core re-evaluates
auto-suspend upon every pm_runtime_get/put cycle (e.g., from sysfs reads or
background tasks).

Because passthrough or VM assignment is a normal, expected state, returning
-EBUSY repeatedly will spam the log with these warnings.

Should these expected state deferrals use XDNA_DBG instead?

> diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/a=
mdxdna_pm.c
> index 9c030b7836fbb..2b4ce301bb96f 100644
> --- a/drivers/accel/amdxdna/amdxdna_pm.c
> +++ b/drivers/accel/amdxdna/amdxdna_pm.c
[ ... ]
> +int amdxdna_pm_runtime_suspend(struct device *dev)
> +{
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(dev_get_drvdata(dev));
> +	int ret =3D -EOPNOTSUPP;
> +
> +	guard(mutex)(&xdna->dev_lock);
> +	if (xdna->dev_info->ops->runtime_suspend)
> +		ret =3D xdna->dev_info->ops->runtime_suspend(xdna);

[Severity: Medium]
Can returning -EOPNOTSUPP here permanently break the PM state machine for
devices without a runtime_suspend callback?

The Linux PM core (specifically rpm_suspend() in drivers/base/power/runtime=
.c)
treats any return value from the runtime_suspend callback other than 0,
-EAGAIN, or -EBUSY as a fatal error.

This triggers the PM core to set dev->power.runtime_error =3D 1, which bloc=
ks
all future runtime PM operations (get, put, suspend, resume) for that
device until manually cleared.

If a device variant does not implement the callback, shouldn't this wrapper
return 0 so the PM core can safely transition?

> +
> +	XDNA_DBG(xdna, "Runtime suspend done ret %d", ret);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006042230.5478=
07-1-yidong.zhang@amd.com?part=3D19
