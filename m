Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A38C1CD6E75
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 19:54:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CE511A2AA;
	Thu,  4 Jun 2026 19:54:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fxrgdhi+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA8A611A2AA
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 19:54:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16E1C6001A;
 Thu,  4 Jun 2026 19:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EEA1F00893;
 Thu,  4 Jun 2026 19:54:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780602857;
 bh=VlNCEx7fSXTvxEos14U11YA6V7bI6hyrbU6QtXchtsI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fxrgdhi+2p3vS6hQdItpxa9NGAEaPheM/rSuxOVOVuna7NoQFoVhwv3Ln5CxXzfM8
 mFBe5KqHDT3zNmkNJZa+px6SyKNP7UShF1L9V6ud5m0r1DrtIlXimYbRFZvTNuEAfb
 ZboxQBaTMZtnulrHfRDadGApwSPHUEs5TG0rF1fnVP+POATrYvaFAIMy2+gRxeq+Uc
 dmq5atuDNRGs1w8OhwTkzpsY1uthCTQwEYUkC4fnTqIN+jJ573MQA3XtNsByacf+Ej
 p9PeV0Ub0QQQc2PWpwHaLqF4tWVUj2pFediWbL7Z5COjq9QX0jWcVQjaXmCKGMcpFv
 DwdvbSkF6g/Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v18 4/4] rust: drm: gem: Introduce
 shmem::Object::sg_table()
To: "Lyude Paul" <lyude@redhat.com>
Cc: linux-media@vger.kernel.org, ojeda@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260604192740.659240-5-lyude@redhat.com>
References: <20260604192740.659240-5-lyude@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 19:54:17 +0000
Message-Id: <20260604195417.88EEA1F00893@smtp.kernel.org>
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
- [Medium] SGTableMap::drop frees the scatter-gather table without decremen=
ting the backing pages reference count, causing a permanent memory leak if =
Devres initialization fails.
--

commit 28826d4b9c036cf868c70bbd1c12d628314a0735
Author: Lyude Paul <lyude@redhat.com>

rust: drm: gem: Introduce shmem::Object::sg_table()

This commit introduces sg_table() to shmem::Object and utilizes a Devres
resource to ensure SGTable mappings are released on driver-unbind.

> diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
> index a20b0c0dac6bd..f3c893c7fbf4f 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs

[ ... ]

> @@ -270,6 +302,45 @@ pub fn vmap<const SIZE: usize>(&self) -> Result<VMap=
Ref<'_, T, C, SIZE>> {
>      pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, C=
, SIZE>> {
>          self.make_vmap()
>      }
> +
> +    /// Creates (if necessary) and returns an immutable reference to a s=
catter-gather table of DMA
> +    /// pages for this object.
> +    ///
> +    /// This will pin the object in memory. It is expected that `dev` sh=
ould be a pointer to the
> +    /// same [`device::Device`] which `self` belongs to, otherwise this =
function will return
> +    /// `Err(EINVAL)`.
> +    pub fn sg_table<'a>(
> +        &'a self,
> +        dev: &'a device::Device<Bound>,
> +    ) -> Result<&'a scatterlist::SGTable> {
> +        if dev.as_raw() !=3D self.dev().as_ref().as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        let sgt_res =3D 'out: {

[ ... ]

> +            // If not, finish initializing and return.
> +            self.sgt_res
> +                .populate(Devres::new(dev, SGTableMap::new(self))?);

[Severity: Medium]
If Devres::new() returns an error here, will the newly created SGTableMap
be immediately dropped?

When SGTableMap::new() calls drm_gem_shmem_get_pages_sgt(), it pins the
backing pages by incrementing pages_use_count and caches the new sgt. If the
SGTableMap is dropped during this error path, it frees the SGT without
decrementing pages_use_count, leading to a permanent memory leak of the
backing pages.

> +
> +            // SAFETY: We just populated sgt_res above.
> +            unsafe { self.sgt_res.as_ref().unwrap_unchecked() }
> +        };

[ ... ]

> +impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C> {
> +    fn drop(&mut self) {
> +        // SAFETY: `obj` is always valid via our type invariants
> +        let obj =3D unsafe { self.obj.as_ref() };
> +        let _lock =3D DmaResvGuard::new(obj);
> +
> +        // SAFETY: We acquired the lock needed for calling this function=
 above
> +        unsafe { bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_sh=
mem()) };

[Severity: Medium]
Does this code leak the backing pages?

This function frees the SGT and sets shmem->sgt =3D NULL, but it omits a pa=
ired
call to drm_gem_shmem_put_pages_locked(). If this drop is triggered early
(such as when Devres::new() fails in Object::sg_table()), pages_use_count is
permanently incremented.

If the caller retries sg_table() after the failure, it will see
shmem->sgt =3D=3D NULL and increment pages_use_count a second time. When th=
e GEM
object is eventually released, drm_gem_shmem_release() will only decrement =
it
once, failing to reach 0 and triggering a drm_WARN_ON.

> +    }
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604192740.6592=
40-1-lyude@redhat.com?part=3D4
