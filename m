Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFDDCA6007
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 04:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA73710E729;
	Thu,  8 Oct 2026 04:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I4ZkhoDe";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A376310E729
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 04:22:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EF136025A;
 Thu,  8 Oct 2026 04:22:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234A11F000FF;
 Thu,  8 Oct 2026 04:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791433364;
 bh=D1a4sVuiu85xG4/+b+PuUHywZHP1YJ07DtRXoZjBPnY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I4ZkhoDeUutr9jR2AG3XGP1bCHX8waHDbWRkilGGXaOOp0oBVGmdPM0kG60Va7jM5
 Blsdoq7seT3PuV8Ttm64/w5uDhwX+YiF5V+e2ZQRNjhVYntjPMoEcZzbGqbne+8Gfh
 S2glzcdOs8UB4FwYfdWFLvLYuDoS6DOIDGmQaDMPO4dkIJ0IsMtdVn04jkXFYOUlRj
 VVf8aOoRfAOkR5xbY68T3eQ+qjDe/6vsZzqqMZN6C411BBc5WTSWd28B2QHQf2AlhC
 c9yWlLEpc5jiotcGebJkyiGmsf1DQ/+vweNqXOxpy+g0ppQRL20gijmV1re88KwnrK
 qS3MUCWqlawmQ==
Message-ID: <sashiko-outbox-163609@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 19/19] accel/amdxdna: Implement runtime suspend and
 resume support
To: "David Zhang" <yidong.zhang@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261008032348.2044667-20-yidong.zhang@amd.com>
References: <yidong.zhang@amd.com>
 <20261008032348.2044667-1-yidong.zhang@amd.com>
 <20261008032348.2044667-20-yidong.zhang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 04:22:43 +0000
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
- [High] amdxdna: PM deadlock in probe error path via pm_runtime_forbid()
- [High] amdxdna: missing PM reference in AIE4 hwctx_init causes hardware a=
ccess while suspended
- [Low] pm: Unconditional external PM callbacks defeat dead code elimination
--

commit cc7f853ee4ac4c49242812a5366af4f77504c2a6
Author: David Zhang <yidong.zhang@amd.com>
Subject: accel/amdxdna: Implement runtime suspend and resume support

This commit adds runtime suspend and resume handlers for the AIE4 classic
device by wrapping its system PM handlers. It also attempts to discard
dev_pm_ops and associated callbacks by using the pm_ptr() wrapper when
CONFIG_PM is disabled.

> diff --git a/drivers/accel/amdxdna/aie4_pci.c b/drivers/accel/amdxdna/aie=
4_pci.c
> index a368bd3c257f5..ee64a5f3405dd 100644
> --- a/drivers/accel/amdxdna/aie4_pci.c
> +++ b/drivers/accel/amdxdna/aie4_pci.c
> @@ -1040,6 +1040,7 @@ static int aie4_classic_init(struct amdxdna_dev *xd=
na)
>  	if (ret)
>  		goto free_work_buf;
> =20
> +	amdxdna_pm_init(xdna);

[Severity: High]
Does enabling runtime PM autosuspend here expose a missing wake-up in the
context creation path?

If the device autosuspends, and a user application calls the context creati=
on
ioctl, aie4_hwctx_init() invokes aie4_hwctx_create(), which calls
aie_send_mgmt_msg_wait() to send a message via the hardware doorbell ring.

Unlike aie2_hwctx_init() which takes a PM reference, aie4_hwctx_init() does
not, which could lead to a synchronous external abort or system hang when
accessing the powered-down PCI device.

>  	return 0;
> =20
>  free_work_buf:

[ ... ]

> @@ -1403,4 +1405,6 @@ const struct amdxdna_dev_ops aie4_classic_ops =3D {
>  	.set_aie_state		=3D aie4_set_state,
>  	.resume			=3D aie4_classic_resume,
>  	.suspend		=3D aie4_classic_suspend,
> +	.runtime_resume		=3D aie4_classic_resume,
> +	.runtime_suspend	=3D aie4_classic_suspend,

[Severity: Low]
Will these callbacks actually be discarded as dead code when CONFIG_PM is
disabled?

Since aie4_classic_suspend and aie4_classic_resume are unconditionally
assigned to the globally visible aie4_classic_ops structure, they will rema=
in
referenced and cannot be eliminated by the compiler.

>  };

> diff --git a/drivers/accel/amdxdna/amdxdna_pci_drv.c b/drivers/accel/amdx=
dna/amdxdna_pci_drv.c
> index f5f7831c4e802..cb78f145ffa1f 100644
> --- a/drivers/accel/amdxdna/amdxdna_pci_drv.c
> +++ b/drivers/accel/amdxdna/amdxdna_pci_drv.c
> @@ -484,7 +484,7 @@ static struct pci_driver amdxdna_pci_driver =3D {
>  	.id_table =3D pci_ids,
>  	.probe =3D amdxdna_probe,
>  	.remove =3D amdxdna_remove,
> -	.driver.pm =3D &amdxdna_pm_ops,
> +	.driver.pm =3D pm_ptr(&amdxdna_pm_ops),

[Severity: Low]
Does this pm_ptr() actually prevent the PM callbacks from being compiled in=
to
the kernel when CONFIG_PM is disabled?

Because amdxdna_pm_runtime_suspend and amdxdna_pm_runtime_resume are defined
unconditionally with external linkage in amdxdna_pm.c, the compiler cannot
eliminate them across translation units even when amdxdna_pm_ops is dropped.

>  	.sriov_configure =3D amdxdna_sriov_configure,
>  };

> diff --git a/drivers/accel/amdxdna/amdxdna_pm.c b/drivers/accel/amdxdna/a=
mdxdna_pm.c
> index b1fafddd7ad59..7d7bc965342dc 100644
> --- a/drivers/accel/amdxdna/amdxdna_pm.c
> +++ b/drivers/accel/amdxdna/amdxdna_pm.c
> @@ -37,11 +37,40 @@ int amdxdna_pm_resume(struct device *dev)
>  	return ret;
>  }
> =20

[ ... ]

> +int amdxdna_pm_runtime_resume(struct device *dev)
> +{
> +	struct amdxdna_dev *xdna =3D to_xdna_dev(dev_get_drvdata(dev));
> +	int ret =3D -EOPNOTSUPP;
> +
> +	guard(mutex)(&xdna->dev_lock);

[Severity: High]
Can this dev_lock acquisition cause a deadlock during the probe error path?

If amdxdna_probe() encounters an error after initialization (like a sysfs
or DRM registration failure), the error path calls xdna->dev_info->ops->fin=
i()
with dev_lock held:

amdxdna_pci_drv.c:amdxdna_probe() {
    ...
failed_dev_fini:
	mutex_lock(&xdna->dev_lock);
	xdna->dev_info->ops->fini(xdna);
	mutex_unlock(&xdna->dev_lock);
    ...
}

This fini handler maps to aie4_classic_fini(), which now calls
amdxdna_pm_fini().

amdxdna_pm_fini() calls pm_runtime_forbid(). If the device has autosuspended
in the background, pm_runtime_forbid() synchronously resumes it, calling
amdxdna_pm_runtime_resume().

This leads to a second attempt to acquire dev_lock, deadlocking the probe
thread.

> +	if (xdna->dev_info->ops->runtime_resume)
> +		ret =3D xdna->dev_info->ops->runtime_resume(xdna);
> +
> +	XDNA_DBG(xdna, "Runtime resume done ret %d", ret);
> +	return ret;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008032348.2044=
667-1-yidong.zhang@amd.com?part=3D19
