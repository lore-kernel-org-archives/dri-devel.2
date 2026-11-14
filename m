Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F130C606A338
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9EVZtaJ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 108AB10E88E;
	Sat, 14 Nov 2026 16:35:02 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5471310E88E;
 Sat, 14 Nov 2026 16:34:56 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E28642DE7;
 Sat, 14 Nov 2026 16:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72A41F000CA;
 Sat, 14 Nov 2026 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794674096;
 bh=Qw6W2fzj7Oc8qqfynrlow0LYI/cQx3l8U5lKNmVGtFk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=b9EVZtaJ2hI1SjEIO9fJFEV97m4LnJk8giBgwgEnlbqyPQCvp/5N0W+WQauEwjBkm
 FLhZrCyCLTeRVg1iWGB1bmsLsIwObo1l3YJp2JpX1yc8FB1Z536KhDC9vgXdMTBy0c
 tJ+X1Q5Zfjwnu0owvdk8IzSIrrZNpoWOlorEv3fyOCn0LHwaGwKuGsLvliwpheeBLN
 OxxTitPE2Nve2WSdv3n4khpzqrsqAqq30rnfiKMmCyo/2F6itSXWQ9pO+jT+YnWfaF
 RV/DBBp3+wcazcgAZjH9211EXRymwI1HoliA5qSKT9ynGDGS6KoRcKqVbD1xiAwPRb
 HkBf9qm867WSA==
Message-ID: <sashiko-outbox-214757@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/12] drm/amd/display: Refuse DP AUX while GMUX
 keeps the GPU off
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-11-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-11-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:34:55 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/amd/display: unsynchronized runtime PM check in
  dm_dp_aux_transfer()
--

commit 7acdd21f6d25e531ba11673cecccfbbda8f8f481
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amd/display: Refuse DP AUX while GMUX keeps the GPU off

This commit adds a runtime PM check around dc_link_aux_transfer_raw() in
dm_dp_aux_transfer() using pm_runtime_get_noresume() and adev->runpm_active.

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 7261317d4c0f4..0d11a9443ca01 100644
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
> +	 * check if the gpu is active or not.
> +	 */
> +	if (adev->dev) {
> +		pm_runtime_get_noresume(adev->dev);
> +		if (!READ_ONCE(adev->runpm_active)) {
> +			pm_runtime_put_noidle(adev->dev);
> +			return -EBUSY;
> +		}
> +	}
>  	payload.address =3D msg->address;
>  	payload.data =3D msg->buffer;
>  	payload.length =3D msg->size;
> @@ -126,13 +141,13 @@ STATIC_IFN_KUNIT ssize_t dm_dp_aux_transfer(struct =
drm_dp_aux *aux,
>  	result =3D dc_link_aux_transfer_raw(TO_DM_AUX(aux)->ddc_service, &paylo=
ad,
>  				      &operation_result);
> =20
> +	if (adev->dev)
> +		pm_runtime_put_autosuspend(adev->dev);

[Severity: High]
As reported by Alex Deucher on v1 [1], why gate this on GMUX-specific
adev->runpm_active and pm_runtime_get_noresume() instead of waking or
synchronizing with runtime PM across all runtime PM modes?

pm_runtime_get_noresume() only increments dev->power.usage_count without
checking runtime_status or waiting on in-progress suspend or resume
transitions, and adev->runpm_active is only cleared at the very end of
amdgpu_pmops_runtime_suspend() when rpm_mode =3D=3D AMDGPU_RUNPM_GMUX:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pmops_runtime_suspend() {
	...
	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_PX ||
	    adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX) {
		amdgpu_device_cache_pci_state(pdev);
		pci_disable_device(pdev);
		pci_ignore_hotplug(pdev);
		pci_set_power_state(pdev, PCI_D3cold);
		drm_dev->switch_power_state =3D DRM_SWITCH_POWER_DYNAMIC_OFF;
	...
	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
		WRITE_ONCE(adev->runpm_active, false);
}

Once rpm_suspend() sets runtime_status to RPM_SUSPENDING, a concurrent
/dev/drm_dp_aux* transfer still races with PCI disable and GMUX power-off:

CPU0                                  CPU1
rpm_suspend()
  runtime_status =3D RPM_SUSPENDING
  vga_switcheroo_runtime_suspend()
    amdgpu_pmops_runtime_suspend()
      amdgpu_device_suspend()
      pci_disable_device(pdev)
      pci_set_power_state(..., PCI_D3cold)
                                      aux_dev_read_iter()
                                        ...
                                          dm_dp_aux_transfer()
                                            pm_runtime_get_noresume()
                                            READ_ONCE(adev->runpm_active)
                                              /* still true */
      WRITE_ONCE(adev->runpm_active, false)
    vga_switcheroo_power_switch(..., OFF)
                                            dc_link_aux_transfer_raw()
                                              /* MMIO on powered-off GPU */

The same race occurs during amdgpu_pmops_runtime_resume(), which sets
adev->runpm_active =3D true at the start of the callback before PCI power
state, BAR state, and DMUB are restored.

On non-GMUX systems (PX, BOCO, BACO, BAMACO), adev->runpm_active is never
cleared on runtime suspend, so pm_runtime_get_noresume() leaves the GPU
suspended while allowing dc_link_aux_transfer_raw() to touch powered-down
registers.

In addition, dm_dp_aux_transfer() is called by internal display paths during
dm_suspend() and dm_resume(), where unconditional pm_runtime_get_noresume()
and pm_runtime_put_autosuspend() manipulate usage_count and last_busy in the
middle of a runtime PM transition.

[1] https://lore.kernel.org/r/CADnq5_PRG_O7jy9P+mf7AQLerpfz6up=3DBejRSPMgYD=
h9xigm=3DA@mail.gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D10
