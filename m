Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DE7606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzF1Lre1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AF1C10E357;
	Wed, 18 Nov 2026 23:47:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F11B10E357
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 23:47:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 78302407D3;
 Wed, 18 Nov 2026 23:47:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2561C1F000C5;
 Wed, 18 Nov 2026 23:47:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795045625;
 bh=SncGqdynGtv9vWZbIXjgekA2bUNOxLIGXegG0c6muRs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bzF1Lre1yCK1+oeuYqILjMw4m1T0HhQZxpKJlj0/s0MkFeOdhH+jrofyRz3nvMWlq
 Jrs8UUAQ4XSgRB+dz9Z0uZZ7691+n6/UEdL4h+wiFVy9a8AbQ+kAdyTR71Awae6hfj
 pRkxlagY1D/9q5mHfAVN5M/xK9Ks1HOdqXE1zMASdjnvL9COgeMpuyklmybPKlqsFR
 BVgLxEUlxu83pdKBqQ8l6DYRjqFaJEEQ59sNU/Uq//qqqWhHyiAkCBTw9UlJLMLp1r
 xJkIi0L8upAlUwM66XNbm9WVtVN1ZG8RrdXA49cn8eaZ49h2IlsgHZyXiUEgHAjSnV
 QTtEAuZmYKujg==
Message-ID: <sashiko-outbox-222213@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] drm/tyr: use pin-init self-referential support
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org, gary@garyguo.net
In-Reply-To: <20261118233727.3147222-4-dakr@kernel.org>
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-4-dakr@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 23:47:04 +0000
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

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [High] drm/tyr: unaligned BO size in new_dummy_object() and
  KernelBo::new() [1]
--

commit c6eb3c50c479a4d12cbfccb1e7746b3f539a34fd
Author: Danilo Krummrich <dakr@kernel.org>

drm/tyr: use pin-init self-referential support

This commit replaces Arc-based sharing of the MMIO mapping, MMU, and
firmware VM in the Tyr driver with borrows using pin-init's
self-referential struct support.

> diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
> index 0439bf96467f3..05965a9135b77 100644
> --- a/drivers/gpu/drm/tyr/gem.rs
> +++ b/drivers/gpu/drm/tyr/gem.rs
[ ... ]
> @@ -99,7 +96,7 @@ impl<'bo> KernelBo<'bo> {
>      /// cleaned up when the [`KernelBo`] is dropped.
>      pub(crate) fn new(
>          ddev: &TyrDrmDevice,
> -        vm: Arc<Vm<'bo>>,
> +        vm: &'bo Vm<'bo, 'res>,
>          size: u64,
>          va_alloc: KernelBoVaAlloc,
>          flags: VmMapFlags,

[Severity: High]
This problem wasn't introduced by this patch, but can KernelBo::new() and
new_dummy_object() panic in drm_gem_private_object_init() on 16 KiB or
64 KiB page kernels [1]?

new_dummy_object() passes a hardcoded size of 4096 bytes to Bo::new(), and
KernelBo::new() passes firmware section sizes that are only aligned to
4 KiB:

drivers/gpu/drm/tyr/gem.rs:new_dummy_object() {
    let bo =3D Bo::new(
        ddev,
        4096,
    ...
}

drivers/gpu/drm/tyr/gem.rs:KernelBo::new() {
    ...
        let bo_size =3D usize::try_from(size).map_err(|_| EOVERFLOW)?;
        let va_end =3D va.checked_add(size).ok_or(EINVAL)?;

        let bo =3D Bo::new(
            ddev,
            bo_size,
    ...
}

Bo::new() forwards the size to drm_gem_private_object_init(), which
triggers BUG_ON((size & (PAGE_SIZE - 1)) !=3D 0) during probe when
PAGE_SIZE exceeds 4 KiB.

[1] https://sashiko.dev/#/bug/linux-c7c6866e-fcae-455a-98bc-11dd06209188

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118233727.3147=
222-1-dakr@kernel.org?part=3D3
