Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41E6606A32D
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c1XdZ3yj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CFBA10E575;
	Sat, 14 Nov 2026 16:33:26 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E700810E575;
 Sat, 14 Nov 2026 16:33:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A13824150F;
 Sat, 14 Nov 2026 16:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5362D1F000C4;
 Sat, 14 Nov 2026 16:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794673999;
 bh=FyQe9jL1Zwv63S3BHn0HTk4v8HLzH6ONbMmKcl9iA20=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c1XdZ3yj5WDve0mfvHbyMK0db2s7PaiMiqbRaT4l/WahcgTvqu6hswoQ+/Y6NpIA2
 4khfO/l4FqBzCcuzJJKMetUy7cgwj3+DtIHv16YtRFaPL6v/sflidQ5iOlPhPbqlHf
 sbTpoFeOWh7Hh3+Lbo6y8mC35Xu8H1QXx3+ct6vL3mSrDNRGsgT1TBiqXm7iqCx9X+
 c1F91ErF9kdUxqyv42NNcm6wz5XUADqmAdDhtiqwZqBQdeBIVSvxSlUcoMDazkxA3r
 Q1OX5ZUi/gBC9Jxzn0whp7ZDpKutuWnsSWUpPfRaWr6wscRo45CmDYrPOdc4asX56P
 ibTCa/X+tfFsA==
Message-ID: <sashiko-outbox-214755@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/12] drm/amdgpu: Catch register access while GMUX
 keeps the GPU off
To: "Atharva Tiwari" <atharvatiwarilinuxdev@gmail.com>
Cc: =?utf-8?b?b3BlbiBsaXN0OlBDSSBTVUJTWVNURU0=?= <linux-pci@vger.kernel.org>, 
 =?utf-8?b?b3BlbiBsaXN0OlJBREVPTiBhbmQgQU1ER1BVIERSTSBEUklWRVJT?=
 <amd-gfx@lists.freedesktop.org>, 
 =?utf-8?b?b3BlbiBsaXN0OkRSTSBEUklWRVJT?= <dri-devel@lists.freedesktop.org>
In-Reply-To: <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
References: <20261114160731.3756-1-atharvatiwarilinuxdev@gmail.com>
 <20261114160731.3756-10-atharvatiwarilinuxdev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 16:33:18 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/amdgpu: adev->runpm_active initialized after
  amdgpu_virt_init()
- [Medium] drm/amdgpu: premature runpm_active set and missing unwind on
  resume
--

commit 720e36a43938e97cb3f99b288c561e7448e2fbc3
Author: Andre Eikmeyer <dev@deq.rocks>

drm/amdgpu: Catch register access while GMUX keeps the GPU off

This commit adds a runpm_active flag to struct amdgpu_device and checks it
in amdgpu_device_skip_hw_access() and the indirect register accessors to
skip and warn on register accesses while the GPU is runtime suspended via
GMUX.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index ac336594bf055..ed205352f0f0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -947,6 +947,10 @@ bool amdgpu_device_skip_hw_access(struct amdgpu_devi=
ce *adev)
>  	if (adev->no_hw_access)
>  		return true;
> =20
> +	if (unlikely(!READ_ONCE(adev->runpm_active))) {
> +		WARN_RATELIMIT(1, "%s: register access while powered off\n", dev_name(=
adev->dev));
> +		return true;
> +	}
>  #ifdef CONFIG_LOCKDEP
>  	/*
>  	 * This is a bit complicated to understand, so worth a comment. What we=
 assert
> @@ -2029,6 +2033,7 @@ static int amdgpu_device_ip_early_init(struct amdgp=
u_device *adev)
>  	int i, r;
> =20
>  	amdgpu_device_enable_virtual_display(adev);
> +	adev->runpm_active =3D true;
> =20
>  	if (amdgpu_sriov_vf(adev)) {
>  		/*

[Severity: High]
Is adev->runpm_active initialized too late during device probe?

In amdgpu_device_init(), amdgpu_virt_init() runs before
amdgpu_device_ip_early_init():

drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:amdgpu_device_init() {
	...
	/* detect hw virtualization here */
	amdgpu_virt_init(adev);
	...
	/* early init functions */
	r =3D amdgpu_device_ip_early_init(adev);
}

Inside amdgpu_virt_init() -> amdgpu_virt_init_detect_asic(), the driver
calls RREG32(mmRCC_IOV_FUNC_IDENTIFIER) (or mmBIF_IOV_FUNC_IDENTIFIER on
Tonga/Fiji).  Because adev is zero-allocated and adev->runpm_active is
still false at that point, amdgpu_device_skip_hw_access() fires a
WARN_RATELIMIT splat on every probe of those GPUs and makes RREG32()
return 0, which also prevents SR-IOV VF detection from setting
AMDGPU_SRIOV_CAPS_IS_VF.

Setting adev->runpm_active =3D true in amdgpu_device_init() before
amdgpu_virt_init() would avoid this regression.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 3978ed284048f..d1b0c6c7301ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2935,6 +2935,9 @@ static int amdgpu_pmops_runtime_suspend(struct devi=
ce *dev)
>  		amdgpu_device_baco_enter(adev);
>  	}
> =20
> +	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_GMUX)
> +		WRITE_ONCE(adev->runpm_active, false);
> +
>  	dev_dbg(&pdev->dev, "asic/device is runtime suspended\n");
> =20
>  	return 0;
> @@ -2963,6 +2966,8 @@ static int amdgpu_pmops_runtime_resume(struct devic=
e *dev)
>  	if (adev->pm.rpm_mode =3D=3D AMDGPU_RUNPM_NONE)
>  		return -EINVAL;
> =20
> +	WRITE_ONCE(adev->runpm_active, true);
> +
>  	/* Avoids registers access if device is physically gone */
>  	if (!pci_device_is_present(adev->pdev))
>  		adev->no_hw_access =3D true;

[Severity: Medium]
Should amdgpu_pmops_runtime_resume() set adev->runpm_active only after
restoring PCI power and config state, and clear it again if resume fails?

In the AMDGPU_RUNPM_GMUX branch right below, the device is still in
PCI_D3cold with PCI memory decoding disabled until pci_set_power_state(),
amdgpu_device_load_pci_state(), and pci_enable_device() complete.  If
pci_enable_device() fails, or if amdgpu_device_resume() fails and calls
pci_disable_device(pdev), amdgpu_pmops_runtime_resume() returns an error
with adev->runpm_active left set to true while the PCI device is disabled,
allowing subsequent register accesses to bypass
amdgpu_device_skip_hw_access().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114160731.3756=
-1-atharvatiwarilinuxdev@gmail.com?part=3D9
