Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19973C5AC67
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 12:24:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17FF810E1E8;
	Sat,  8 Aug 2026 12:24:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mBjJQqJS";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E8110E1E8
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 12:24:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53641600B1;
 Sat,  8 Aug 2026 12:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58891F000E9;
 Sat,  8 Aug 2026 12:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786191886;
 bh=F/VSYoUOlIj2maxKjzqkhTHJHc9PzCkk2TuDnQfJbV0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mBjJQqJS1CQBG5U+S+/8z+nurtf4gNvWFFwZpHe92hkct5k9D5PPgrPKy0V/ctgiV
 cvEjjL+w5kgM84ZRgJQLbUYfYY/N/Y1Xdc28Oj6mTr6I4Q2A9PE7nS0/8MEPJwzgnG
 WvADx4U6JLjYdmRjQ7xCkI1H7o7k8nypKhQ3qC502dwarNqmmXf1YMKJCqovUYQn5P
 SuzhqzEb499oacxWfS3k/COi/8VkSG9wCPFHLmCH7SOMCi8rAqTi0OKbf2AA53SffU
 sgs6iMimpPGiAG071/nOnzsq/qJGvlP56TzbGdxBRmQ6m0oyyysqhzRFS5TwFZt1xs
 G1eGMIdySrcmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal
To: "Guangshuo Li" <lgs201920130244@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260808120934.2813010-1-lgs201920130244@gmail.com>
References: <20260808120934.2813010-1-lgs201920130244@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 08 Aug 2026 12:24:45 +0000
Message-Id: <20260808122445.D58891F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] If late initialization steps in `amdgpu_pci_probe()` fail, the err=
or path skips hardware teardown and fails to unwind earlier registrations, =
leading to resource leaks, zombie devices, and potential use-after-free.
--

--- Patch [1]: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal -=
--
commit c007137d62506190886d6bf0f4180137897883b4
Author: Guangshuo Li <lgs201920130244@gmail.com>

drm/amdgpu: fix autosuspend cleanup during removal

This commit adds a missing pm_runtime_dont_use_autosuspend() call to the
remove path. This ensures that the usage count is properly balanced and
dropped, preventing issues where the runtime PM core keeps the device from
suspending when the autosuspend delay is set to a negative value.

> amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
> amdgpu_pci_remove() does not call the matching
> pm_runtime_dont_use_autosuspend().

[Severity: High]
This is a pre-existing issue, but while looking at amdgpu_pci_probe(), if l=
ate
initialization steps fail, the error path skips hardware teardown:

drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:amdgpu_pci_probe() {
    ...
	} else if (ret) {
		goto err_pci;
	}

	ret =3D amdgpu_xcp_dev_register(adev, ent);
	if (ret)
		goto err_pci;

	ret =3D amdgpu_amdkfd_drm_client_create(adev);
	if (ret)
		goto err_pci;
    ...
err_pci:
	pci_disable_device(pdev);
	return ret;
}

Can this leave a zombie DRM device exposed to userspace?

Because adev is allocated via devm_drm_dev_alloc(), devres handles cleanup =
on
probe failure by calling drm_dev_put(). The release callback
(amdgpu_driver_release_kms) only calls amdgpu_device_fini_sw(), which frees
memory and software state.

Since the error path does not call amdgpu_driver_unload_kms(),
amdgpu_device_fini_hw() is never executed. Hardware clocks, interrupts, and
internal engines remain active while the backing memory is freed, which cou=
ld
lead to memory corruption.

Furthermore, if drm_dev_register() succeeds but a subsequent step (like
amdgpu_xcp_dev_register()) fails, the error path fails to call
drm_dev_unregister(). Could this leave dangling sysfs nodes and device files
that might trigger a use-after-free when userspace attempts to open them?

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 0ab380ca7e645..5c33c19fd9bc5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2557,6 +2557,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
>  	if (adev->pm.rpm_mode !=3D AMDGPU_RUNPM_NONE) {
>  		pm_runtime_get_sync(dev->dev);
>  		pm_runtime_forbid(dev->dev);
> +		pm_runtime_dont_use_autosuspend(dev->dev);
>  	}
> =20
>  	amdgpu_driver_unload_kms(dev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260808120934.2813=
010-1-lgs201920130244@gmail.com?part=3D1
