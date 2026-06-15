Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48C9CD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:48:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36BEE10E52D;
	Mon, 15 Jun 2026 16:48:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wru4OnAk";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0550B10E566
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 16:48:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 58179601E1;
 Mon, 15 Jun 2026 16:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE401F000E9;
 Mon, 15 Jun 2026 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781542132;
 bh=rgAK34AoO/YNV6ur2YhBuivVJRCBBRUUpYRgZ9dzBks=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Wru4OnAk/9dpN7n0cAJMyVXsAmkWcFPZG/Bjnr15Jb2+fw+q2SjMQm0JucaKmibeO
 T9UUOfzwlHTyHEfQ4fiO/JpPrNnbsyyDZQfK3hKHxt0WlWNiBc2EPYDUSLu2p5IreE
 GKD8WYZMDD8E/gai6ma+uWJAZrrY5DhcGhWLiGkAfbtP61ECtVJP54DLY6w4/8/FpZ
 mY4+0PLTk1r0EJASWSniHWmbCkPPWLW8OmEBXSWSobuXZdfPkW5qqv4gc4dkbPyUIm
 NBG7clW+cKdRiLdEa6BpOqtLskEDD0q9lyEocEFOfpb4roid8N/Q1tM9BmAPh7Kccw
 iemSZuOpTDawQ==
Date: Mon, 15 Jun 2026 17:48:48 +0100
From: Conor Dooley <conor@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: MidG971 <midgy971@gmail.com>, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH v4 6/9] dt-bindings: npu: rockchip,rk3588-rknn-core:
 Add RK3568
Message-ID: <20260615-platter-washroom-043ea869adb1@spud>
References: <20260613070116.438906-7-midgy971@gmail.com>
 <20260613071113.C60751F00A3D@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="KcjmGw9GtIMy6xex"
Content-Disposition: inline
In-Reply-To: <20260613071113.C60751F00A3D@smtp.kernel.org>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>


--KcjmGw9GtIMy6xex
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 07:11:13AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
>=20
> Pre-existing issues:
> - [Critical] Double free of `rjob->tasks` leading to memory corruption tr=
iggerable from userspace.
> - [Critical] Unconditional dereference of a NULL `job->domain` triggering=
 a kernel panic on early job submission failure.
> - [High] Permanent PM runtime reference count leak when `iommu_attach_gro=
up()` fails.
> - [High] Zero-initialized clock IDs cause the framework to fetch the same=
 clock repeatedly, violating hardware constraints.
> - [Medium] Premature DRM device registration exposes an incomplete state =
to userspace.

Why is the bot complaining about drivers here?

> --
>=20
> commit d0d76b931ac773e3e176353cdb3ac9c590c43dc3
> Author: Midgy BALON <midgy971@gmail.com>
>=20
> dt-bindings: npu: rockchip, rk3588-rknn-core: Add RK3568
>    =20
> The RK3568 carries a single core of the same NVDLA-derived NPU IP as the
> RK3588.  Add its compatible.
>=20
> > diff --git a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn=
-core.yaml b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-cor=
e.yaml
> > index caca2a4903cd1..e0b948ac47d45 100644
> > --- a/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.y=
aml
> > +++ b/Documentation/devicetree/bindings/npu/rockchip,rk3588-rknn-core.y=
aml
> [ ... ]
>=20
> drivers/accel/rocket/rocket_device.c:rocket_device_init() {
>     ...
>     err =3D drm_dev_register(ddev, 0);
>     ...
> }
>=20
> drivers/accel/rocket/rocket_drv.c:rocket_probe() {
>     ...
>     rdev->cores[core].dev =3D &pdev->dev;
>     ...
> }
>=20
> [Severity: Medium]
> This is a pre-existing issue, but does this premature registration expose=
 an
> incomplete state to userspace?
>=20
> drm_dev_register() is called in rocket_device_init() before rocket_probe()
> assigns rdev->cores[0].dev.
>=20
> As a result, the device node is briefly visible to userspace while its co=
re
> structures remain partially uninitialized.
>=20
> If userspace attempts to open the DRM device during this window, rocket_o=
pen()
> passes the NULL rdev->cores[0].dev to rocket_iommu_domain_create().
>=20
> While the IOMMU framework safely catches the NULL device and returns -ENO=
DEV,
> this still causes a spurious open() failure for userspace applications re=
lying
> on udev events.
>=20
>=20
> drivers/accel/rocket/rocket_job.c:rocket_job_run() {
>     ...
> 	ret =3D pm_runtime_get_sync(core->dev);
> 	if (ret < 0)
> 		return fence;
>     ...
> 		ret =3D iommu_attach_group(job->domain->domain, core->iommu_group);
> 		if (ret < 0)
> 			return fence;
>     ...
> }
>=20
> [Severity: High]
> This is a pre-existing issue, but does this cause a permanent PM runtime
> reference count leak when iommu_attach_group() fails?
>=20
> In rocket_job_run(), pm_runtime_get_sync() increments the PM usage count =
to wake
> up the NPU.
>=20
> If the subsequent iommu_attach_group() fails, the driver returns the allo=
cated
> fence and exits early without calling pm_runtime_put().
>=20
> Because the driver exits before assigning core->in_flight_job, the subseq=
uent
> timeout handler rocket_reset() will also skip the manual
> pm_runtime_put_noidle().
>=20
> This causes a permanent PM runtime reference count leak, preventing the N=
PU
> hardware from ever entering runtime suspend.
>=20
>=20
> drivers/accel/rocket/rocket_core.c:rocket_core_init() {
>     ...
>     err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>     ...
> }
>=20
> [Severity: High]
> This is a pre-existing issue, but do these zero-initialized clock IDs cau=
se the
> framework to fetch the same clock repeatedly?
>=20
> In rocket_core_init(), the driver declares an array of clk_bulk_data but =
never
> initializes the .id fields, leaving them implicitly NULL.
>=20
> When devm_clk_bulk_get() is called, the clock framework handles the NULL =
IDs by
> returning the first clock defined in the device tree for the device on al=
l four
> iterations.
>=20
> Consequently, rocket_device_runtime_resume() enables the exact same clock=
 four
> times, while the remaining required clocks are left disabled.
>=20
> This violates physical hardware state requirements and causes unclocked N=
PU
> register accesses.
>=20
>=20
> drivers/accel/rocket/rocket_job.c:rocket_copy_tasks() {
>     ...
> fail:
> 	kvfree(rjob->tasks);
> 	return ret;
> }
>=20
> drivers/accel/rocket/rocket_job.c:rocket_job_cleanup() {
>     ...
> 	kvfree(job->tasks);
>     ...
> }
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does this lead to a double free of rjob=
->tasks
> that can be triggered from userspace?
>=20
> In rocket_copy_tasks(), if copy_from_user() fails, kvfree(rjob->tasks) is
> called, but the pointer rjob->tasks is not cleared.
>=20
> The function returns an error to rocket_ioctl_submit_job(), which jumps to
> out_cleanup_job and invokes rocket_job_put().
>=20
> When the reference count drops, rocket_job_cleanup() is executed,
> unconditionally calling kvfree(job->tasks) again on the already freed mem=
ory
> block.
>=20
> Since the IOCTL input is fully controlled by userspace, an unprivileged a=
ttacker
> can trigger a double free by submitting an invalid task pointer.
>=20
>=20
> drivers/accel/rocket/rocket_job.c:rocket_ioctl_submit_job() {
>     ...
> 	rjob =3D kzalloc_obj(*rjob);
>     ...
> 	ret =3D rocket_copy_tasks(dev, file, job, rjob);
> 	if (ret)
> 		goto out_cleanup_job;
>     ...
> }
>=20
> drivers/accel/rocket/rocket_drv.c:rocket_iommu_domain_put() {
>     ...
>     kref_put(&domain->kref, rocket_iommu_domain_destroy);
>     ...
> }
>=20
> [Severity: Critical]
> This is a pre-existing issue, but does this unconditionally dereference a=
 NULL
> job->domain, triggering a kernel panic on early job submission failure?
>=20
> In rocket_ioctl_submit_job(), rjob is allocated via kzalloc_obj(), leaving
> rjob->domain initialized to NULL.
>=20
> If a failure occurs before the domain is assigned, such as an invalid task
> pointer in rocket_copy_tasks() or a bad BO handle in drm_gem_objects_look=
up(),
> the driver jumps to the cleanup path.
>=20
> The cleanup handler, rocket_job_cleanup(), unconditionally passes the NULL
> domain to rocket_iommu_domain_put(), which invokes kref_put(&domain->kref=
, ...).
>=20
> Computing &domain->kref yields an offset address, and refcount_dec_and_te=
st()
> immediately dereferences this invalid address, resulting in a kernel pani=
c that
> can be triggered by unprivileged userspace.
>=20
> --=20
> Sashiko AI review =B7 https://sashiko.dev/#/patchset/20260613070116.43890=
6-1-midgy971@gmail.com?part=3D6

--KcjmGw9GtIMy6xex
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCajAs8AAKCRB4tDGHoIJi
0ofRAP97TD5uDsOpTTpPt+os3+gnPlFQSvVwHARNEl0ytyivmQD8DStsr3uQM9Me
xBayd1rg1P6TJhzNDiXajM0OU5hPnQw=
=KBbc
-----END PGP SIGNATURE-----

--KcjmGw9GtIMy6xex--
