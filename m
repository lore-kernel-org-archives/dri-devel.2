Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1593CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB9310E8AC;
	Mon, 19 Oct 2026 08:51:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECB1A10E8AE
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:50:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D591F40E16;
 Mon, 19 Oct 2026 08:50:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB791F000C5;
 Mon, 19 Oct 2026 08:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792399858;
 bh=SVIqQFkLCM2mSdJmxuUI/VPm/m7LswMBAkoRjv9gfHI=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=oZ1xANh0mhw2dyEsXWHEGSOD248UH23fTpeVSW0UzH8KVrx4AGNiSizKWXh/aEoZF
 ++q9ZBEYv12UUzYRiD4+K74yCg8+vrMlTS05bIYPMlV8v1NaVbZtKfq5tAUUadGApz
 4jFrS0vkBIKRuThlBqBGejZwSmx6bY88iKmCPJ1rI3mTiXE974x8W/SuTISvq422JW
 /jx/1+lbaNM4RDaAmk9VUyEz3CguZLmS1GTnHoLrGk2H1E+HeVGbNVtAbSvLqqlkwo
 fkW8zPkLUfYKSdEvVylNnt5zNLSLzHAnC0pqijt36XohX50Le/Gv0h8dV6tk66+9RX
 f4cmX7H1frI2A==
Message-ID: <sashiko-outbox-176847@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/6] drm/nouveau: reject empty VRAM ranges
To: "Jiale Yao" <yaojiale02@163.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019084138.1821477-3-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
 <20261019084138.1821477-3-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:50:58 +0000
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
- [Critical] drm/nouveau: UAF and leaks in nouveau_ttm_init() on vram init =
failure
- [High] drm/nouveau: broken probe on VRAM-less SoCs in nouveau_ttm_init_vr=
am()
--

commit 51b3731f82a143b12828ab1838f6ea352d2d1ef2
Author: Jiale Yao <yaojiale02@163.com>

drm/nouveau: reject empty VRAM ranges

This commit rejects VRAM sizes smaller than PAGE_SIZE in
nouveau_ttm_init_vram() to avoid passing a zero-page range to drm_mm_init().

> diff --git a/drivers/gpu/drm/nouveau/nouveau_ttm.c b/drivers/gpu/drm/nouv=
eau/nouveau_ttm.c
> index ad01f922aa86a..6f8728f433645 100644
> --- a/drivers/gpu/drm/nouveau/nouveau_ttm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_ttm.c
> @@ -180,6 +180,9 @@ nouveau_ttm_init_host(struct nouveau_drm *drm, u8 kin=
d)
>  static int
>  nouveau_ttm_init_vram(struct nouveau_drm *drm)
>  {
> +	if (drm->gem.vram_available < PAGE_SIZE)
> +		return -EINVAL;
> +
>  	if (drm->client.device.info.family >=3D NV_DEVICE_INFO_V0_TESLA) {
>  		struct ttm_resource_manager *man =3D kzalloc_obj(*man);
> =20

[Severity: High]
Does placing this check before the family >=3D NV_DEVICE_INFO_V0_TESLA bran=
ch
break probe on VRAM-less Tegra SoC GPUs (such as GK20A, GM20B, GP10B, and
GV11B)?

On those platforms, fb->ram is NULL, so nvkm_udevice_info() sets ram_size a=
nd
ram_user to 0:

drivers/gpu/drm/nouveau/nvkm/engine/device/user.c:nvkm_udevice_info() {
	...
	if (fb && fb->ram)
		args->v0.ram_size =3D args->v0.ram_user =3D fb->ram->size;
	else
		args->v0.ram_size =3D args->v0.ram_user =3D 0;
	...
}

In nouveau_ttm_init(), drm->gem.vram_available is set to ram_user (0). For
family >=3D NV_DEVICE_INFO_V0_TESLA, nouveau_ttm_init_vram() does not call
ttm_range_man_init() or drm_mm_init(); instead it initializes
nouveau_vram_manager, which handles zero-VRAM devices in
nouveau_vram_manager_new():

drivers/gpu/drm/nouveau/nouveau_ttm.c:nouveau_vram_manager_new() {
	...
	if (drm->client.device.info.ram_size =3D=3D 0)
		return -ENOMEM;
	...
}

Only the else branch (family < NV_DEVICE_INFO_V0_TESLA) calls
ttm_range_man_init(). Should this check only apply to that branch?

[Severity: Critical]
Also, when nouveau_ttm_init_vram() returns an error here, can this cause a
use-after-free of drm->ttm.bdev.device_list as well as leak bdev->wq,
bdev->pool, the ttm_glob reference, and the arch_io_reserve_memtype_wc()
reservation?

In nouveau_ttm_init(), ttm_device_init() and arch_io_reserve_memtype_wc() a=
re
called before nouveau_ttm_init_vram():

drivers/gpu/drm/nouveau/nouveau_ttm.c:nouveau_ttm_init() {
	...
	ret =3D ttm_device_init(&drm->ttm.bdev, ...);
	if (ret) {
		NV_ERROR(drm, "error initialising bo driver, %d\n", ret);
		return ret;
	}

	/* VRAM init */
	drm->gem.vram_available =3D drm->client.device.info.ram_user;

	arch_io_reserve_memtype_wc(device->func->resource_addr(device, NVKM_BAR1_F=
B),
				   device->func->resource_size(device, NVKM_BAR1_FB));

	ret =3D nouveau_ttm_init_vram(drm);
	if (ret) {
		NV_ERROR(drm, "VRAM mm init failed, %d\n", ret);
		return ret;
	}
	...
}

ttm_device_init() links &bdev->device_list into the global
ttm_glob.device_list. When nouveau_ttm_init() fails,
nouveau_drm_device_init() jumps to fail_ttm (skipping nouveau_ttm_fini()),
and nouveau_drm_device_del() frees drm without calling ttm_device_fini() or
arch_io_free_memtype_wc().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019084138.1821=
477-1-yaojiale02@163.com?part=3D2
