Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7852CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 20:58:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16C0F10EB36;
	Wed, 17 Jun 2026 20:58:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dxmxVo6O";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DABE10EB36
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 20:58:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3FF742148;
 Wed, 17 Jun 2026 20:58:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDBC1F000E9;
 Wed, 17 Jun 2026 20:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781729880;
 bh=odBXX6TVikl1f/WZrXLeWxO8Pzjve3XxgvUyW0He1YY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dxmxVo6OiuMkXcYAw5AOcMsy9eae9pvdp5ruZ3DZe5DP13RtbBP0I5EZ5emGbG16W
 2V8NApLHtUF6Ed8Y6pGLf859AiZdOKxR2a9H1wiyDQkj+9cD/zxXTkdw/hC/svYt4l
 aWbV8i7fmc33Ypmk0Q27nTQlOuCWr00K5IFxK7WltJV4Wx1O92uTIi+gFEBAkUHzHV
 t1O68hn+ZkTsZwUTvybOgokD/AjfbpgHf4HsXHODstC7Xs3BBuItubLXUBXs/OUhPy
 oGWPFrH7hHbq08j94J6IF0Hf5DRrUnv1MRwgTJMqd6j9NiY7C1xt3yokl2WrofATN2
 XTFcfMF4DCRIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/amdgpu: initialize ret before UMC error record loop
To: "Ruoyu Wang" <ruoyuw560@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260617193335.1662613-1-ruoyuw560@gmail.com>
References: <20260617193335.1662613-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Jun 2026 20:58:00 +0000
Message-Id: <20260617205800.8FDBC1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] `amdgpu_umc_lookup_bad_pages_in_a_row()` incorrectly returns 0 and=
 drops error pages if `retire_unit` exceeds the array length.
- [High] Infinite overcounting of `de_count` and duplicate bad pages if `am=
dgpu_umc_fill_error_record()` fails.
--

commit dbc37c594d1c3e76008f0f9e176701a44797cd01
Author: Ruoyu Wang <ruoyuw560@gmail.com>

drm/amdgpu: initialize ret before UMC error record loop

The commit initializes ret to 0 before iterating over the bad pages returned
by amdgpu_umc_lookup_bad_pages_in_a_row() to prevent returning uninitialized
data when no pages are found.

> diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/umc_v12_0.c
> index a6df6a778f50b..6d3c0f495e0f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
> @@ -690,6 +690,7 @@ static int umc_v12_0_fill_error_record(struct amdgpu_=
device *adev,
>  	count =3D amdgpu_umc_lookup_bad_pages_in_a_row(adev,
>  				ecc_err->pa_pfn << AMDGPU_GPU_PAGE_SHIFT,
>  				page_pfn, ARRAY_SIZE(page_pfn));

[Severity: High]
This is a pre-existing issue, but does
amdgpu_umc_lookup_bad_pages_in_a_row() incorrectly return 0 and drop error
pages if the retire_unit exceeds the array length?

Looking at amdgpu_umc_lookup_bad_pages_in_a_row() in
drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c, if adev->umc.retire_unit is greater
than len, the loop terminates early via goto out:

    for (i =3D 0; i < adev->umc.retire_unit; i++) {
        if (i >=3D len)
            goto out;

        pfns[i] =3D err_data.err_addr[i].retired_page;
    }
    ret =3D i;
    adev->umc.err_addr_cnt =3D err_data.err_addr_cnt;

out:
    kfree(err_data.err_addr);
    return ret;

Since ret is 0 from the previously successful call to
amdgpu_umc_pages_in_a_row(), this bypasses the updates to ret and
adev->umc.err_addr_cnt. Does this cause the function to incorrectly return 0
instead of len, dropping the successfully retrieved bad pages?

> +	ret =3D 0;
> =20
>  	for (i =3D 0; i < count; i++) {
>  		ret =3D amdgpu_umc_fill_error_record(err_data,

[Severity: High]
This is a pre-existing issue, but can this create an infinite loop of
overcounting if amdgpu_umc_fill_error_record() fails?

If amdgpu_umc_fill_error_record() returns an error, the loop in
umc_v12_0_fill_error_record() breaks, err_data->de_count is unconditionally
incremented, and the error code is returned.

The caller umc_v12_0_query_ras_ecc_err_addr() detects this failure:

    ret =3D umc_v12_0_fill_error_record(adev, entries[i], ras_error_status);
    if (ret) {
        dev_err(adev->dev, "Fail to fill umc error record, ret:%d\n", ret);
        break;
    }
    radix_tree_tag_clear(ecc_tree,
            entries[i]->pa_pfn, UMC_ECC_NEW_DETECTED_TAG);

Because it breaks out of its iteration without clearing
UMC_ECC_NEW_DETECTED_TAG, won't any subsequent query (like a periodic
retirement worker) find the exact same entry, leading to the exact same
failure sequence and infinitely incrementing the counters?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617193335.1662=
613-1-ruoyuw560@gmail.com?part=3D1
