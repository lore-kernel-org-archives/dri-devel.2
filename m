Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC28CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 18:16:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 384F610E167;
	Tue,  6 Oct 2026 18:16:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SxDTbkdD";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E1910E167;
 Tue,  6 Oct 2026 18:16:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 082606053A;
 Tue,  6 Oct 2026 18:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C46B1F0089C;
 Tue,  6 Oct 2026 18:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791310603;
 bh=LUkFej9CircDzB8pJwgWGZENuQU7pBYRmcOHIJvMojo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SxDTbkdD/eqbDiF9Lk5XkaNF7zke2lzXKygudK60fjs8TvATLR5MjJa0qbO4uHzMB
 I5schnFmx4D0V0sSgLGo+xkUUbevqybQcDbtPYuUrJj7F1+qR0gdVexXohDU62uGs+
 4l5jBpK8dibH4E4FJ8hCkgJUQ3U+TJ14uMXyECaXoZ7UvV9gzhXbQkjsJ8yRDh59Dn
 GrcadvSGcUOPg+5q4/HGHX4YGyQbXyPFJnTRcxwT8ir4Vq3JNQBtABGerGTGRldtnZ
 cwP//H1ddQgiXomBSp6HZeV1r6nWaEt7I0yOUo9HCXOXglbuqwB+IZO0u1VKxTNK8J
 lCEE93YKJ/2FQ==
Message-ID: <sashiko-outbox-162325@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] RFC: drm/xe: Prevent pinned_link double add
To: "FNU VISHWANATHA" <fnu.vishwanatha@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org
In-Reply-To: <20261006175741.3582911-2-fnu.vishwanatha@intel.com>
References: <20261006175741.3582911-1-fnu.vishwanatha@intel.com>
 <20261006175741.3582911-2-fnu.vishwanatha@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 18:16:43 +0000
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
- [High] drm/xe: Masked list corruption causes system suspend failure
--

commit 2ec4b5f1ac44438a30593cce5cd58f19ac02f193
Author: Kornel Dul=C4=99ba <korneld@google.com>

RFC: drm/xe: Prevent pinned_link double add

The commit attempts to fix a list double-add by checking if the pinned link
is empty and adding a warning. It resolves kernel crashes on memory
constrained devices running CtsCameraTestCases.

> diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> index 98c7c17cc46cc..a5af53b36a5f2 100644
> --- a/drivers/gpu/drm/xe/xe_bo.c
> +++ b/drivers/gpu/drm/xe/xe_bo.c
> @@ -3166,7 +3166,14 @@ int xe_bo_pin_external(struct xe_bo *bo, bool in_p=
lace, struct drm_exec *exec)
>  		}
> =20
>  		spin_lock(&xe->pinned.lock);
> -		list_add_tail(&bo->pinned_link, &xe->pinned.late.external);
> +		if (list_empty(&bo->pinned_link)) {
> +			list_add_tail(&bo->pinned_link,
> +				      &xe->pinned.late.external);
> +		} else {
> +			WARN_ONCE(true,
> +				  "pinned_link already added to a list, bo->ttm.pin_count: %d\n",
> +				  bo->ttm.pin_count);
> +		}

[Severity: High]
Does this list_empty() check mask the root cause of a desynchronized
lifecycle when a buffer object is pinned by multiple subsystems, such as
external and display?

If xe_bo_unpin_external() is called while the buffer object is still pinned
elsewhere, the pin_count is greater than 1, and it skips removing the
buffer object from xe->pinned.late.external:

drivers/gpu/drm/xe/xe_bo.c:xe_bo_unpin_external() {
    ...
	if (bo->ttm.pin_count =3D=3D 1 && !list_empty(&bo->pinned_link))
		list_del_init(&bo->pinned_link);
    ...
}

If a subsequent display unpin happens, it calls ttm_bo_unpin() directly and
drops the pin_count to 0, completely bypassing the external pinned list
removal:

drivers/gpu/drm/xe/display/xe_fb_pin.c:__xe_unpin_fb_vma() {
    ...
	ttm_bo_unpin(&vma->bo->ttm);
    ...
}

This leaves the unpinned buffer object stranded on the pinned list. During
system suspend, power management eviction encounters this stranded unpinned
buffer object, triggering a warning and returning -EINVAL:

drivers/gpu/drm/xe/xe_bo.c:xe_bo_evict_pinned() {
    ...
		if (WARN_ON(!xe_bo_is_pinned(bo))) {
			ret =3D -EINVAL;
			break;
		}
    ...
}

Will this cause power management eviction to abort and break system suspend?

>  		spin_unlock(&xe->pinned.lock);
>  	}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006175741.3582=
911-1-fnu.vishwanatha@intel.com?part=3D2
