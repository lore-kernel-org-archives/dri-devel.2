Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A22EC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 11:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDF410E33B;
	Mon,  6 Jul 2026 11:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ihqh6tOf";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D63310E33B
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 11:31:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9AE1D60018;
 Mon,  6 Jul 2026 11:31:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F851F000E9;
 Mon,  6 Jul 2026 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783337504;
 bh=A07Wrucks9vFNfR7L7+WPExqCl8uYIbfexLDCj7Ld/s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ihqh6tOfLAh4MNwp+EB4MapMFmwJ2ki+CJAOlvncpya16RMuwynzAeaHgKbmeTGf+
 zkRmXejkrthG9c2SCGM0O9phdC+VsDJbiqhSNjEhcvsS80iUr67EX08WBtUJYEvA12
 qKYam4FuUdNITrS2foM6x/feBKVi1physMWbTbUM1OfPeB80Ezav2mGgC8jML1rQFY
 cjKi1f6TTrAjAi2nQ5RmG/RxcQ7MAhoGxv+cjVh2g1Fmxzjy4u/69hufRCYZGnLEU8
 qnNTvhVVBL8+A7fbiK44hLB/oyoB1xOhKaO1Jhh1UhwPo+dvk2njoyy11qIlpgjyAG
 RfpkwD9CxUHKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND] drm/i915/guc: Return NULL for missing multi-lrc
 parent
To: "Linmao Li" <lilinmao@kylinos.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260706111954.619602-1-lilinmao@kylinos.cn>
References: <20260706111954.619602-1-lilinmao@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 11:31:43 +0000
Message-Id: <20260706113144.25F851F000E9@smtp.kernel.org>
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
- [High] Uninitialized stack memory dereference in `logical_sort()` leading=
 to kernel panic.
- [High] Memory corruption in `logical_sort()` due to incorrect pointer der=
eference in `memcpy()`.
--

commit c072d35be05423277bc1711d69cd5ba9043c2466
Author: Linmao Li <lilinmao@kylinos.cn>

drm/i915/guc: Return NULL for missing multi-lrc parent

multi_lrc_create_parent() returns ERR_PTR(0) when there are not enough engi=
nes.
This commit changes it to explicitly return NULL to make the non-error path
clear, as the caller already handles NULL.

> diff --git a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c b/driver=
s/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> index 28e8a092f4e7d..18077801b2e60 100644
> --- a/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> +++ b/drivers/gpu/drm/i915/gt/uc/selftest_guc_multi_lrc.c
> @@ -44,7 +44,7 @@ multi_lrc_create_parent(struct intel_gt *gt, u8 class,
>  	}
> =20
>  	if (i <=3D 1)
> -		return ERR_PTR(0);
> +		return NULL;
> =20
>  	logical_sort(siblings, i);

[Severity: High]
This is a pre-existing issue, but does logical_sort() dereference
uninitialized stack memory here?

In multi_lrc_create_parent(), the siblings array is allocated on the stack
and partially populated before being passed in:

    struct intel_engine_cs *siblings[MAX_ENGINE_INSTANCE + 1];
    // ... populated with i elements ...
    logical_sort(siblings, i);

However, the inner loop in logical_sort() unconditionally iterates past the
initialized num_engines:

selftest_guc_multi_lrc.c:logical_sort() {
    ...
    for (i =3D 0; i < num_engines; ++i)
        for (j =3D 0; j < MAX_ENGINE_INSTANCE + 1; ++j) {
            if (engines[j]->logical_mask & BIT(i)) {
    ...
}

If the mask condition is not met by the initialized elements, won't this
loop continue reading beyond num_engines, dereferencing uninitialized stack
memory as a struct intel_engine_cs pointer?

[Severity: High]
This is also a pre-existing issue, but can this call corrupt memory when
copying the sorted array?

At the end of logical_sort(), memcpy() is called with dereferenced array
pointers:

selftest_guc_multi_lrc.c:logical_sort() {
    ...
    memcpy(*engines, *sorted,
           sizeof(struct intel_engine_cs *) * num_engines);
}

Since engines is a double pointer (struct intel_engine_cs **), *engines
evaluates to the first engine object pointer rather than the array itself.

Will this cause memcpy() to overwrite the struct intel_engine_cs hardware
configuration memory directly, instead of updating the array of pointers?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706111954.6196=
02-1-lilinmao@kylinos.cn?part=3D1
