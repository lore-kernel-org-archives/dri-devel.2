Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F7C606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 14:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DdNw9PS1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C6471122FF;
	Thu, 29 Oct 2026 14:03:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA5ED1122FF
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:03:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7281C42B35
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 14:03:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC5B1F031E2;
 Thu, 29 Oct 2026 14:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793282580;
 bh=Lur+5cahGXOyFePp5WavHZfq8uojtVIKDfCK4AL4xqk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DdNw9PS13Npu3ErsvfR9klvm/8aXt8DtI8szj/LLvvjo0dFrBQdutEl22VD+Qd4/C
 rsZ39WnQQP0TYewY7QlzYBB6DMpcqLabMMWA5FlaNtIovoprq5HyVIz+E75VUeoF6Y
 sCo85posYP/nf7V4anpUkQSaE2oQ4/i1kgS2tEvusGhAtVcXTHwkkPF8cDQcHOD+Fn
 Tb7Noap0vIXRxaX3O9aurZZPL9hjb841M8TOI1hoHzTvN+A2NImiG3WsqwGuGaPOoX
 5r2KNFnRDjgQHNYbBANsyd6bHnZvqKSWd5is6h3CabjqgmAppO4tplRpRRzWZhPTBx
 j2iQDAiXyPzoQ==
Message-ID: <sashiko-outbox-189463@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 02/31] accel: ethosu: Ensure suspended on removal
To: =?utf-8?b?Um9iIEhlcnJpbmcgKEFybSk=?= <robh@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261029-ethosu-fixes-v4-2-4aa25e22578e@kernel.org>
References: <20261029-ethosu-fixes-v4-0-4aa25e22578e@kernel.org>
 <20261029-ethosu-fixes-v4-2-4aa25e22578e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 14:02:59 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] accel: ethosu: double ethosu_device_suspend() call in ethosu_remov=
e()
--

commit 8f693e6f09e933d0b127a2a725128f9cb43526dc
Author: Rob Herring (Arm) <robh@kernel.org>

accel: ethosu: Ensure suspended on removal

This commit adds a runtime PM barrier and a direct call to
ethosu_device_suspend() in ethosu_remove() when the device is not runtime
suspended, aiming to ensure clocks are disabled on device removal.

> diff --git a/drivers/accel/ethosu/ethosu_drv.c b/drivers/accel/ethosu/eth=
osu_drv.c
> index 38af57807cee7..ae7ebf29cb2f6 100644
> --- a/drivers/accel/ethosu/ethosu_drv.c
> +++ b/drivers/accel/ethosu/ethosu_drv.c
> @@ -387,6 +387,11 @@ static void ethosu_remove(struct platform_device *pd=
ev)
> =20
>  	drm_dev_unregister(&ethosudev->base);
>  	ethosu_job_fini(ethosudev);
> +
> +	pm_runtime_barrier(&pdev->dev);
> +	if (!pm_runtime_status_suspended(&pdev->dev))
> +		ethosu_device_suspend(&pdev->dev);

[Severity: High]
Can calling ethosu_device_suspend() directly here while runtime PM is still
enabled and runtime_status is RPM_ACTIVE cause ethosu_device_suspend() to be
invoked a second time during devres teardown, underflowing the clock enable
and prepare counts?

In ethosu_init() in drivers/accel/ethosu/ethosu_drv.c, runtime PM is
configured with autosuspend and devres:

	pm_runtime_set_autosuspend_delay(ethosudev->base.dev, 50);
	pm_runtime_use_autosuspend(ethosudev->base.dev);
	ret =3D devm_pm_runtime_set_active_enabled(ethosudev->base.dev);

During driver unbind or device removal under CONFIG_PM=3Dy with
power/control=3Dauto, __device_release_driver() calls pm_runtime_get_sync()=
 and
pm_runtime_put_sync() before invoking ethosu_remove(), which leaves the
device in RPM_ACTIVE with usage_count =3D=3D 0 and the autosuspend timer ar=
med.

In ethosu_remove(), pm_runtime_barrier() cancels the autosuspend timer, and
ethosu_device_suspend() then runs:

	clk_bulk_disable_unprepare(ethosudev->num_clks, ethosudev->clks);

However, runtime PM remains enabled (disable_depth =3D=3D 0) and runtime_st=
atus
remains RPM_ACTIVE. Immediately after ethosu_remove() returns,
__device_release_driver() -> device_unbind_cleanup() -> devres_release_all()
runs pm_runtime_disable_action() in drivers/base/power/runtime.c:

static void pm_runtime_disable_action(void *data)
{
	pm_runtime_dont_use_autosuspend(data);
	pm_runtime_disable(data);
}

Because pm_runtime_dont_use_autosuspend() runs before pm_runtime_disable(),
it calls __pm_runtime_use_autosuspend(dev, false) -> update_autosuspend() ->
rpm_idle(dev, RPM_AUTO) -> rpm_suspend(dev, RPM_AUTO). Since disable_depth =
is
0, usage_count is 0, use_autosuspend is now false, and runtime_status is
still RPM_ACTIVE, rpm_suspend() synchronously invokes ethosu_device_suspend=
()
a second time, calling clk_bulk_disable_unprepare() on clocks that were
already disabled and unprepared.

Also, while runtime_status remains RPM_ACTIVE after ethosu_device_suspend()
has disabled the clocks, could an open DRM file descriptor closing or issui=
ng
an ioctl concurrently (such as ethosu_postclose() ->
ethosu_perfmon_close_file() -> ethosu_perfmon_stop_locked() checking
pm_runtime_get_if_active(), or ethosu_ioctl_perfmon_get_values() calling
pm_runtime_resume_and_get()) see RPM_ACTIVE and access ethosu->pmu_regs with
the NPU clocks disabled?

Would calling pm_runtime_dont_use_autosuspend(&pdev->dev) and
pm_runtime_disable(&pdev->dev) before checking pm_runtime_status_suspended()
(and calling pm_runtime_set_suspended(&pdev->dev) after
ethosu_device_suspend()) avoid both issues?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029-ethosu-fix=
es-v4-0-4aa25e22578e@kernel.org?part=3D2
