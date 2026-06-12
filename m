Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AF0CD98CF
	for <dri-devel@archiver.kernel.org>; Fri, 12 Jun 2026 18:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41A3E10F650;
	Fri, 12 Jun 2026 18:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="atSJl+Ug";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0341610F650
 for <dri-devel@lists.freedesktop.org>; Fri, 12 Jun 2026 18:41:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6567C601E2;
 Fri, 12 Jun 2026 18:41:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02531F000E9;
 Fri, 12 Jun 2026 18:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781289687;
 bh=iss34MxHkbubR9+3HHrhgeMoStbDhK8oVZRXN7ryvJo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=atSJl+UghGA0bB5bJ9p3ACTxdsE8uXvB6CkSYxiBTWORGbnvOUEuJxytnBxlz8ak6
 01oAwNAsUMlqrPQBd/6kEEb+hAIFItIVs3uDZ25ahcL1MVd5SB1xwCEkz4gCKf/Xje
 cUv9s7/BNwJdRH0YeLzV3saJpCRuv9RoV5+KTCrPQWiTKsZcGRrlA1cdtCBsC3NaXU
 0aVZiklNekHaru64917HSuQLnq4zeRDkc/k/PftcGULDmIzAVNeJe96TeWQ53xBFoD
 S8bFSlE+b22bTym2yR0JQZWvXBOMx8ZVWoOw0udLGhtDLNChEpThoJwuPxytUDp3+W
 hiaOlM39byKog==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/9] drm/managed: implement managed versions of
 kzalloc_obj/objs()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: wsa+renesas@sang-engineering.com, dri-devel@lists.freedesktop.org
In-Reply-To: <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
References: <20260612-wb-drop-encoder-v6-1-9f3a54f81310@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 18:41:25 +0000
Message-Id: <20260612184126.A02531F000E9@smtp.kernel.org>
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
- [High] Missing explicit return type cast in drmm_kzalloc_objs / drmm_kzal=
loc_obj permits silent heap buffer overflows.
- [Low] Kernel-doc parameter name mismatch in drmm_kzalloc_obj triggers doc=
umentation warnings.
--

commit 852017e1ea6892532ead5eeb34b599432f852a80
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/managed: implement managed versions of kzalloc_obj/objs()

This commit implements drm_device-managed versions of the kzalloc_obj() and
kzalloc_objs() macros. They provide a convenient interface for allocating
objects with automatic freeing via the DRM managed API, defaulting to
GFP_KERNEL.

> diff --git a/include/drm/drm_managed.h b/include/drm/drm_managed.h
> index 72bfac002c062..d196387506c97 100644
> --- a/include/drm/drm_managed.h
> +++ b/include/drm/drm_managed.h
> @@ -105,6 +105,28 @@ static inline void *drmm_kcalloc(struct drm_device *=
dev,
>  	return drmm_kmalloc_array(dev, n, size, flags | __GFP_ZERO);
>  }
> =20
> +/**
> + * drmm_kzalloc_objs - &drm_device-managed kzalloc_objs()
> + * @dev: DRM device
> + * @p: Variable or type to allocate an array of
> + * @count: How many elements in the array
> + *
> + * Returns: newly allocated pointer to the zeroed array of @P on success=
, or
> + * NULL on failure.
> + */
> +#define drmm_kzalloc_objs(dev, p, count) \
> +	drmm_kcalloc(dev, count, sizeof(typeof(p)), GFP_KERNEL)

[Severity: High]
Does this macro need an explicit return type cast like the standard
kzalloc_objs() macro has?

The standard kzalloc_obj(P) and kzalloc_objs(P, count) macros explicitly ca=
st
their return values to (typeof(P) *). This cast provides a compile-time saf=
ety
guard: if a developer mistakenly passes a pointer variable ptr instead of t=
he
dereferenced pointer *ptr (e.g., ptr =3D kzalloc_obj(ptr)), the macro evalu=
ates
sizeof(typeof(ptr)) (allocating 8 bytes) and returns a double pointer
(typeof(ptr) *). Assigning this back to ptr triggers an "assignment from
incompatible pointer type" compiler warning, catching the error immediately.

Since drmm_kzalloc_objs directly returns void * from drmm_kcalloc, the exact
same mistake (ptr =3D drmm_kzalloc_obj(dev, ptr)) compiles silently without
warnings because C implicitly casts void * to any pointer type. This alloca=
tes
only the 8-byte pointer size instead of the full structure size, which could
lead to a silent out-of-bounds heap overwrite.

Should this macro wrap the drmm_kcalloc call in an explicit ((typeof(p) *) =
...)
cast to maintain the API safety guarantees of the standard macros it mimics?

> +
> +/**
> + * drmm_kzalloc_obj - &drm_device-managed kzalloc_obj()
> + * @dev: DRM device
> + * @p: Variable or type to allocate
> + *
> + * Returns: newly allocated pointer to a @p on success, or NULL on failu=
re.
> + */
> +#define drmm_kzalloc_obj(dev, P) \
> +	drmm_kzalloc_objs(dev, P, 1)

[Severity: Low]
This isn't a bug, but does the macro parameter case mismatch the kernel-doc?

In the kernel-doc comment for drmm_kzalloc_obj, the parameter is documented
as @p (lowercase). However, the actual macro definition uses P (uppercase)
as the parameter name.

Since kernel-doc is case-sensitive, this mismatch will trigger warnings for
an "Excess function parameter p" and "Function parameter P not described"
during document generation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260612-wb-drop-en=
coder-v6-0-9f3a54f81310@oss.qualcomm.com?part=3D1
