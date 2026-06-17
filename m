Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABB51CD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C064210EB5F;
	Wed, 17 Jun 2026 20:50:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lIfWuihB";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB4410EB36
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:50:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C441F6001D;
 Wed, 17 Jun 2026 20:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDD71F000E9;
 Wed, 17 Jun 2026 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781729419;
 bh=yMO3leQfxdBQVqim9Di9C5BD0VRUxY7jwGnMo2AXTJ8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lIfWuihBjUldDBZ2Cr9nRChizV+394rMNK+Ab12BkombYQOeeBzyAWS6eYK2gHyTR
 XURx0p7x+mu2nPCuf7Ve7KXM+jNyJWXQUTxuxk6v9cri534zMC/PYvvyjZAs5ErgWG
 zP/Pd2CidJgfEmaZb3VhvctxIj1H6oMadVF5RULql7piiz/u43gP0oAEjuxpkhRm/6
 nZW12Jh9QSh9bBny27QviTqi08YZeJVuE6x8bJJ0+H7rlSHZpJi6omxzYWn62SrcYw
 xsQGCxfCpRIW5C6Q6849GjMev71+A9IH2aJ57UgijgyD1KPcTMSFczhMqGhdV6xUIe
 IJ1eWT4KKos0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/amdgpu: initialize ret in UMC error record fill
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617183737.1101458-1-ruoyuw560@gmail.com>
References: <20260617183737.1101458-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:50:18 +0000
Message-Id: <20260617205019.5BDD71F000E9@smtp.kernel.org>
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
- [High] Initializing `ret` to 0 masks bad page lookup failures, causing ha=
rdware memory errors to be permanently discarded.
--

commit 70c0c3121204f18673da4770e06143179e0b0b6c
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/amdgpu: initialize ret in UMC error record fill

This commit initializes the ret variable to 0 in umc_v12_0_fill_error_recor=
d()
to avoid returning uninitialized stack data when the bad page lookup loop
is skipped.

> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/umc_v12_0.c
> index a6df6a778f50b..3d84223acfa20 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -681,7 +681,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_=
device *adev,
>  {
>  	struct ras_err_data *err_data =3D (struct ras_err_data *)ras_error_stat=
us;
>  	uint64_t page_pfn[UMC_V12_0_BAD_PAGE_NUM_PER_CHANNEL];
> -	int ret, i, count;
> +	int ret =3D 0, i, count;

[Severity: High]
Does initializing this to 0 introduce a regression that masks bad page
lookup failures?

If amdgpu_umc_lookup_bad_pages_in_a_row() returns 0 (e.g. kcalloc failure)
or a negative error code (e.g. address translation failure), count will be
<=3D 0. The for loop will be skipped, and this function will return 0 (succ=
ess).

If this returns success on a failure, won't the caller incorrectly clear
the error tag?

drivers/gpu/drm/amd/amdgpu/umc_v12_0.c:umc_v12_0_query_ras_ecc_err_addr() {
    ...
		ret =3D umc_v12_0_fill_error_record(adev, entries[i], ras_error_status);
		if (ret) {
			dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
			break;
		}
		radix_tree_tag_clear(ecc_tree,
				entries[i]->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);
    ...
}

This appears to permanently drop the hardware ECC error event since it clea=
rs
the UMC_ECC_NEW_DETECTED_TAG without actually recording the bad pages for
retirement.

> =20
>  	if (!err_data || !ecc_err)
>  		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617183737.1101=
458-1-ruoyuw560@gmail.com?part=3D1
