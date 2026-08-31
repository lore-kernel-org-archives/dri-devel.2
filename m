Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CA17C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 08:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F68010E267;
	Mon, 31 Aug 2026 08:36:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ROIVb2TM";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A2510E267
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 08:36:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D0C06601DB;
 Mon, 31 Aug 2026 08:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5201F000E9;
 Mon, 31 Aug 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788165371;
 bh=Nanm5Kl/1gdYtqG57ufN+8po6zLupNy0m7XNPH4j5Jg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ROIVb2TMWyUcqq1dgyrs8qHHkSBC2wX7nC8qJRJHaCLCcpoRqhkyd990Ew1PrPfzc
 LM5zC4LnRtfKSlItyJOuIxlL3Fo1gH6rnRiRtJa0FeZDruN+Kc1VsQf+2CH5V0aYaY
 UNtTMESu7uIDCFnCEaYVL4tHoFRSlOl/nk+cRyjAlY4LGMqjYC6i8I0j9R75sxnFNB
 D6VM0BfhJzZabtsEH2vJAdzJwt/x4+L1cs9jKyZnhuN4uoaxK3nj+x+PmBtaxt6OSi
 qJSGYzYdt8tAtmqNa2XlpijifWoRM8YeID0WeomAfauhMd5vRCJUAx4SkKo+ZchVvO
 Jox4Q5GB3TnBw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 01/14] accel/rocket: request the core clocks by name
To: "Jiaxing Hu" <gahing@gahingwoo.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260831081956.84871-2-gahing@gahingwoo.com>
References: <20260831081956.84871-1-gahing@gahingwoo.com>
 <20260831081956.84871-2-gahing@gahingwoo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:36:10 +0000
Message-Id: <20260831083611.4A5201F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [High] rocket_remove() decrements rdev->num_cores without shifting array =
elements, making subsequent cores inaccessible.
- [High] IOMMU group reference count leak on every job completion in rocket=
_job_handle_irq().
- [High] Double free / invalid cleanup when drm_sched_init() fails.
- [High] Unbounded memory leak of rdev and rdev->cores arrays on probe defe=
rral.
- [High] Shared IRQ handler unconditionally accesses hardware registers whe=
n clocks and power domains might be disabled.
- [High] Global rdev static variable is left containing an error pointer if=
 rocket_device_init() fails, causing a kernel panic on subsequent probes.
- [High] Registers are accessed while the device might still be held in res=
et, leading to bus hangs.
--

commit 31505652560107069dc219815082a4ea6f173762
Author: Igor Paunovic <royalnet026@gmail.com>

accel/rocket: request the core clocks by name

This commit fixes a clock handling bug where devm_clk_bulk_get() was
called with uninitialized clock IDs, resulting in the driver repeatedly
requesting the first clock from the device tree and ignoring the others.
The clock IDs are now explicitly set to "aclk", "hclk", "npu", and
"pclk" before requesting them, ensuring the correct clocks are prepared
and enabled.

> diff --git a/drivers/accel/rocket/rocket_core.c b/drivers/accel/rocket/ro=
cket_core.c
> index b3b2fa9ba645a..5dd260bacbff6 100644
> --- a/drivers/accel/rocket/rocket_core.c
> +++ b/drivers/accel/rocket/rocket_core.c
> @@ -28,6 +28,10 @@ int rocket_core_init(struct rocket_core *core)
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get resets for core %d\n", c=
ore->index);
> =20
> +	core->clks[0].id =3D "aclk";
> +	core->clks[1].id =3D "hclk";
> +	core->clks[2].id =3D "npu";
> +	core->clks[3].id =3D "pclk";
>  	err =3D devm_clk_bulk_get(dev, ARRAY_SIZE(core->clks), core->clks);
>  	if (err)
>  		return dev_err_probe(dev, err, "failed to get clocks for core %d\n", c=
ore->index);

[Severity: High]
This is a pre-existing issue, but later in this same function:

drivers/accel/rocket/rocket_core.c:rocket_core_init() {
    ...
	version =3D rocket_pc_readl(core, VERSION);
    ...
}

Are these registers accessed while the device might still be held in reset?
Since devm_reset_control_bulk_get_exclusive() is called earlier, shouldn't
the resets be explicitly deasserted before this first memory-mapped read to
prevent bus hangs?


[Severity: High]
This is a pre-existing issue, but in rocket_drv.c:rocket_remove():

drivers/accel/rocket/rocket_drv.c:rocket_remove() {
    ...
	rocket_core_fini(&rdev->cores[core]);
	rdev->num_cores--;
    ...
}

Does decrementing rdev->num_cores without shifting array elements make
subsequent cores inaccessible? Since find_core_for_dev() loops up to
rdev->num_cores, if an earlier core is removed, wouldn't the highest
index core fall outside the loop bounds?


[Severity: High]
This is a pre-existing issue, but in rocket_job.c:rocket_job_handle_irq():

drivers/accel/rocket/rocket_job.c:rocket_job_handle_irq() {
    ...
			iommu_detach_group(NULL, iommu_group_get(core->dev));
    ...
}

Does this code leak the IOMMU group reference count? iommu_group_get()
increments the reference count, but iommu_detach_group() consumes the
pointer without decrementing it, which could prevent the group from ever
being freed on driver unbind.


[Severity: High]
This is a pre-existing issue, but in rocket_job.c:rocket_job_init():

drivers/accel/rocket/rocket_job.c:rocket_job_init() {
    ...
	ret =3D drm_sched_init(&core->sched, &args);
	if (ret) {
		dev_err(core->dev, "Failed to create scheduler: %d.", ret);
		goto err_sched;
	}

	return 0;

err_sched:
	drm_sched_fini(&core->sched);
    ...
}

Can this lead to a double free or NULL pointer dereference? If
drm_sched_init() fails, it internally frees its resources and returns an
error. Calling drm_sched_fini() in the error path could attempt to stop
uninitialized workqueues and free resources again.


[Severity: High]
This is a pre-existing issue, but in rocket_drv.c:rocket_probe():

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
    ...
}

Does this cause an unbounded memory leak on probe deferral?
rocket_device_init() allocates devres tied to the global drm_dev,
which outlives the probe failure. Since rdev is then reset to NULL
during probe teardown, would a subsequent probe retry allocate an
entirely new set of structures without freeing the old ones?


[Severity: High]
This is a pre-existing issue, but in rocket_job.c:rocket_job_init():

drivers/accel/rocket/rocket_job.c:rocket_job_init() {
    ...
	ret =3D devm_request_threaded_irq(core->dev, core->irq,
					rocket_job_irq_handler,
					rocket_job_irq_handler_thread,
					IRQF_SHARED, dev_name(core->dev),
					core);
    ...
}

Does this shared IRQ handler unconditionally access hardware registers
when clocks and power domains might be disabled? If another device
sharing the IRQ line fires before pm_runtime_resume_and_get() is
called, could rocket_job_irq_handler() immediately execute a
memory-mapped read and cause a kernel panic?


[Severity: High]
This is a pre-existing issue, but in rocket_drv.c:rocket_probe():

drivers/accel/rocket/rocket_drv.c:rocket_probe() {
    ...
	if (rdev =3D=3D NULL) {
		/* First core probing, initialize DRM device. */
		rdev =3D rocket_device_init(drm_dev, &rocket_drm_driver);
		if (IS_ERR(rdev)) {
			dev_err(&pdev->dev, "failed to initialize rocket device\n");
			return PTR_ERR(rdev);
		}
	}

	unsigned int core =3D rdev->num_cores;
    ...
}

Is the global rdev static variable left containing an error pointer
if rocket_device_init() fails? On a subsequent probe retry, rdev
would no longer evaluate to NULL, leading directly to a dereference of
the error pointer when accessing rdev->num_cores.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831081956.8487=
1-1-gahing@gahingwoo.com?part=3D1
