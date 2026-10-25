Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EC1606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 25 Oct 2026 04:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=caAYW7co
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 743C810E7FB;
	Sun, 25 Oct 2026 04:41:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B1F810E7FB
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 04:41:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CAD9E4135F;
 Sun, 25 Oct 2026 04:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4551F01825;
 Sun, 25 Oct 2026 04:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792903294;
 bh=43XuBRT7vWYIcEU8xeazB2ZFlyxbxXrjVdUfYdAB17c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=caAYW7com5t0A8hy4VJM5WzdJSmWFkdYOFga96S2q+blFu7BWZ3goQMVHpvUww0bR
 9ZzPA56X5WKxRj1SlocOKe4OWymDVKg1ITgnkmmX+krPC32l34zg0AN1Rs1ebttq8p
 CHG1om1f1dlXfNqu04lrjFwkuU4GHu8rovVtJaqKVPGtid3G520vcBpaU9ZbU+UUO7
 e3kvpvLzGJQ75vbNLVO3N8jo5fTc+tDHLgrclUeEhjURFz6qHrv9QWKIClE7hAukIx
 jVYzR8phJYYdcwoxlq3V8Xt44gbQLNd+zS4kOOVJ5aqYp78FO0eaDaNxKb5lr2bkie
 FiVggfaARezQQ==
Message-ID: <sashiko-outbox-184075@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 11/13] drm/amd/display: Refuse DP AUX while GMUX keeps
 the GPU off
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
References: <20261025040046.1602-1-atharvatiwarilinuxdev@gmail.com>
 <20261025040046.1602-12-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 25 Oct 2026 04:41:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/amd/display: unsynchronized runtime PM check in dm_dp_aux_tran=
sfer()
- [Medium] drm/amd/display: NULL adev->dev dereference in dm_dp_aux_transfe=
r() KUnit
--

commit 06da2e04484d301378e2740f320dbda5681bdad8
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off

This commit adds a runtime PM reference and checks adev->gmux_off in
dm_dp_aux_transfer() to refuse DP AUX transfers while GMUX keeps the GPU
powered off.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7261317d4c0f4..b099bf5206734 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c

[ ... ]

> @@ -111,6 +112,20 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct d=
rm_dp_aux *aux,
>  	if (WARN_ON(msg->size > 16))
>  		return -E2BIG;
> =20
> +	ddc =3D TO_DM_AUX(aux)->ddc_service;
> +	adev =3D ddc->ctx->driver_context;
> +
> +	/*
> +	 * User space reaches this through the drm_dp_aux_dev character device
> +	 * without a runtime PM reference. Refuse the transfer while GMUX keeps
> +	 * the GPU powered off, a register access then hangs the PEG link.
> +	 */
> +	pm_runtime_get_noresume(adev->dev);

[Severity: Medium]
Can this dereference a NULL adev->dev pointer when running the
amdgpu_dm_mst_types_test KUnit suite with CONFIG_PM enabled?

In drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c,
the KUnit test cases (such as dm_mst_test_aux_transfer_native_read() and
dm_mst_test_aux_transfer_native_write()) allocate a mock struct
amdgpu_device via kunit_kzalloc() and wire it through
dm_mst_test_setup_dm_aux() without initializing adev->dev:

drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c:
dm_mst_test_aux_transfer_native_read() {
	...
	dm_aux =3D kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
	adev =3D kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
	...
	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);

	ret =3D drm_dp_dpcd_read(&dm_aux->aux, 4, buffer, sizeof(buffer));
	...
}

When drm_dp_dpcd_read() invokes dm_dp_aux_transfer(), passing adev->dev
(which is NULL) to pm_runtime_get_noresume(), pm_runtime_put_noidle(), or
pm_runtime_put_autosuspend() will dereference a NULL pointer.

> +	if (READ_ONCE(adev->gmux_off)) {
> +		pm_runtime_put_noidle(adev->dev);
> +		return -EBUSY;
> +	}
> +
>  	payload.address =3D msg->address;
>  	payload.data =3D msg->buffer;
>  	payload.length =3D msg->size;
> @@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct =
drm_dp_aux *aux,
>  	result =3D dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &paylo=
ad,
>  				      &operation_result);
> =20
> +	pm_runtime_put_autosuspend(adev->dev);

[Severity: High]
Does pm_runtime_get_noresume() combined with checking adev->gmux_off prevent
dm_dp_aux_transfer() from accessing hardware registers while the GPU is
suspending, resuming, or runtime-suspended under other runtime PM modes?

In dm_dp_aux_transfer(), pm_runtime_get_noresume(adev->dev) only increments
dev->power.usage_count without acquiring dev->power.lock, checking
dev->power.runtime_status, or waiting on an in-flight RPM_SUSPENDING or
RPM_RESUMING transition.

In rpm_suspend(), the PM core checks usage_count before setting
runtime_status to RPM_SUSPENDING and invoking the driver callback. In
drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c, amdgpu_pmops_runtime_suspend() only
sets adev->gmux_off at the very end of the function, after
amdgpu_device_suspend(), pci_disable_device(), and
pci_set_power_state(pdev, PCI_D3cold) have already run:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pmops_runtime_suspend() {
	...
		amdgpu_device_cache_pci_state(pdev);
		pci_disable_device(pdev);
		pci_ignore_hotplug(pdev);
		pci_set_power_state(pdev, PCI_D3cold);
		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
	} else if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BOCO) {
		/* nothing to do */
	} else if ((adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BACO) ||
			(adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_BAMACO)) {
		amdgpu_device_baco_enter(adev);
	}

	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
		WRITE_ONCE(adev->gmux_off, true);
	...
}

And in amdgpu_pmops_runtime_resume(), adev->gmux_off is cleared at the very
beginning of the callback before PCI state is restored to PCI_D0,
pci_enable_device() is called, and amdgpu_device_resume() reinitializes the
device:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pmops_runtime_resume() {
	...
	WRITE_ONCE(adev->gmux_off, false);

	/* Avoids registers access if device is physically gone */
	if (!pci_device_is_present(adev->pdev))
		adev->no_hw_access =3D true;

	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
	    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) {
		if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX)
			drm_dev->switch_power_state =3D DRM_SWITCH_POWER_CHANGING;

		/* Only need to handle PCI state in the driver for ATPX and GMUX.
		 * PCI core handles it for _PR3.
		 */
		pci_set_power_state(pdev, PCI_D0);
		amdgpu_device_load_pci_state(pdev);
		ret =3D pci_enable_device(pdev);
	...
}

If userspace reads /dev/drm_dp_aux* concurrently with
amdgpu_pmops_runtime_suspend() or amdgpu_pmops_runtime_resume(),
dm_dp_aux_transfer() can observe adev->gmux_off =3D=3D false and call
dc_link_aux_transfer_raw() while the PCI device is disabled or in
PCI_D3cold, or while vga_switcheroo_runtime_suspend() is cutting GMUX power.

In addition, on non-GMUX runtime PM configurations (such as
AMDGPU_RUNPM_PX, AMDGPU_RUNPM_BOCO, AMDGPU_RUNPM_BACO, or
AMDGPU_RUNPM_BAMACO), adev->gmux_off remains false while the GPU is runtime
suspended, and pm_runtime_get_noresume() will not wake the device before
dc_link_aux_transfer_raw() accesses AUX registers.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261025040046.1602=
-1-atharvatiwarilinuxdev@gmail.com?part=3D11
