Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F700CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 08:50:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C131A10E89B;
	Mon, 19 Oct 2026 08:50:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 736D610E89B
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 08:50:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F7B7601DB;
 Mon, 19 Oct 2026 08:50:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D8A1F000C4;
 Mon, 19 Oct 2026 08:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792399812;
 bh=OT5HXO1+U/X+6ak8FHJaNmU/vsbKU9AmC0Ik69emAeM=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=cgIDPNZ+dG3nH/gq2anumx+hQZtdCUtyTIi+8yXFEtVtF33JbAkJKrVBCBtlJ7Ofx
 vJJgCuLx3I6CxyehrS+XFynTujxjf200RBkrk8yYQ2ceoUrSwcmK4JadL/uiWKeWil
 OTPFvoYFNv7098jT72PvD/dmsMZ7SVDakPxil8qou4ZeQbwjpFLe/9nWJU56/shOXe
 04paIU73WuCmtyIlQdCOB6UmcvUF10hOiZByDQDUXbKHqYk8/KxsoeKXc5SPz7b/pN
 c4CsCknUijmsEk7oXZgrIGgwaUc37cpgqBBFQuA+aDtssRZwCZh3MLz/i2c6Pzyra3
 eaFjosnAT5Y/A==
Message-ID: <sashiko-outbox-176842@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/6] drm/radeon: reject empty VRAM ranges
To: "Jiale Yao" <yaojiale02@163.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261019084138.1821477-5-yaojiale02@163.com>
References: <20261019084138.1821477-1-yaojiale02@163.com>
 <20261019084138.1821477-5-yaojiale02@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 08:50:11 +0000
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
- [High] drm/radeon: NULL pointer dereference in radeon_ttm_set_active_vram=
_size()
--

commit 5b48ce714a8da9ec1142b39b688fe2ea60f7c240
Author: Jiale Yao <yaojiale02@163.com>

drm/radeon: reject empty VRAM ranges

This commit rejects VRAM sizes smaller than a page in radeon_ttm_init_vram()
before calling ttm_range_man_init() to avoid hitting a zero-range BUG check
in drm_mm_init().

> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon=
/radeon_ttm.c
> index e7ab8162ac694..925593af1688b 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -69,6 +69,9 @@ struct radeon_device *radeon_get_rdev(struct ttm_device=
 *bdev)
> =20
>  static int radeon_ttm_init_vram(struct radeon_device *rdev)
>  {
> +	if (rdev->mc.real_vram_size < PAGE_SIZE)
> +		return -EINVAL;
> +
>  	return ttm_range_man_init(&rdev->mman.bdev, TTM_PL_VRAM,
>  				  false, rdev->mc.real_vram_size >> PAGE_SHIFT);
>  }

[Severity: High]
Can returning -EINVAL here lead to a NULL pointer dereference in
radeon_ttm_set_active_vram_size() during error teardown?

In drivers/gpu/drm/radeon/radeon_ttm.c, radeon_ttm_init() sets
rdev->mman.initialized =3D true before calling radeon_ttm_init_vram():

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_init() {
	...
	rdev->mman.initialized =3D true;

	r =3D radeon_ttm_init_vram(rdev);
	if (r) {
		DRM_ERROR("Failed initializing VRAM heap.\n");
		return r;
	}
	...
}

When rdev->mc.real_vram_size < PAGE_SIZE, radeon_ttm_init_vram() now
returns -EINVAL before ttm_range_man_init() registers the TTM_PL_VRAM
manager, leaving rdev->mman.initialized set to true while the TTM_PL_VRAM
manager slot remains NULL.

As the error propagates up through radeon_bo_init() -> rdev->asic->init() ->
radeon_device_init() to radeon_driver_load_kms(), error cleanup calls
radeon_driver_unload_kms() -> radeon_device_fini() -> radeon_fini().

The ASIC .fini callbacks (such as r100_fini(), r600_fini(), and cik_fini())
stop the CP/DMA engines before calling radeon_bo_fini(), which invokes
radeon_ttm_set_active_vram_size() (for example via r100_cp_fini() ->
r100_cp_disable()):

drivers/gpu/drm/radeon/radeon_ttm.c:radeon_ttm_set_active_vram_size() {
	struct ttm_resource_manager *man;

	if (!rdev->mman.initialized)
		return;

	man =3D ttm_manager_type(&rdev->mman.bdev, TTM_PL_VRAM);
	/* this just adjusts TTM size idea, which sets lpfn to the correct value */
	man->size =3D size >> PAGE_SHIFT;
}

Because rdev->mman.initialized is true, wouldn't this bypass the early
return and dereference a NULL man pointer (and also abort teardown before
radeon_bo_fini() and radeon_ttm_fini() can clean up the initialized
ttm_device)?

Should radeon_ttm_init() only set rdev->mman.initialized =3D true after
initialization succeeds (or clean up ttm_device_fini() on failure), or
should radeon_ttm_set_active_vram_size() also check if man is NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019084138.1821=
477-1-yaojiale02@163.com?part=3D4
