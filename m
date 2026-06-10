Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DCECD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 15:46:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3BFA10EA35;
	Wed, 10 Jun 2026 15:46:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="MA9TveqP";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD82110E1AC
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781106394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VhAoECBQXQqCtdG9eNW5XUoRrOiJaUrouLUGatPWJFQ=;
 b=MA9TveqPcX6sDzdt+aT/VzrckabmVQqTo88WC91vjAOqY+bURc1eUQ0NMPUpty90JOfMhn
 XAwUXAOpeKSoLWkppgCVhuOCLAugT0TGz3r3qZz7Grsmc1///rW5DWlExfgJDnMKxLLJbW
 RVbxlZMqVc/g50BK+W1w5+KKXuCxrZo=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-296-tC5pnGD0MlG_WXtyNSOiCw-1; Wed, 10 Jun 2026 11:46:33 -0400
X-MC-Unique: tC5pnGD0MlG_WXtyNSOiCw-1
X-Mimecast-MFC-AGG-ID: tC5pnGD0MlG_WXtyNSOiCw_1781106393
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8ccd83d58d9so112930966d6.0
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 08:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781106393; x=1781711193;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VhAoECBQXQqCtdG9eNW5XUoRrOiJaUrouLUGatPWJFQ=;
 b=ehtBWXVnpAAyajSJnZDh57DcgQpzQL9yEUBw2NGVmud+4s699wiS05WUpFo2dKDGGT
 HWSGJQZDzEP4lGtpt7ZZ/7TvE+Ov6v0L2k1EsQxddxxhLE1qzONANDnXqEZH6ZFbh467
 IsvN71rvL/+GRw3pDZZzpr37Qhbpm54SY4aHFBwqY9THymm4QfnT4c9OL61v+KE0ZwI6
 69kXQgRaFCfRNknJT/qkT/J3U/EJlI1Q/Cjh44VN46prFtXCg32+X7B5e/jy/bddTKlq
 1nIuWrDzMJvJS5gEEn10Gw30cWDHonKHKHfx2Qk+HmfwJPqSX7bFbKz3qsfBmVXMqQAy
 sWZg==
X-Gm-Message-State: AOJu0YwOXacD3nbA+C0Gkpb0n8VEIjACJePoLaYM7OZOQ0BYJ0YjvlZR
 8IQ1HXzf3yQkN8vTv9ZK/gXXbAWkLKLyYUa1eHL+vQGLysdTSxgexPAcu9c0b8n2ydM8KyFicK5
 l8cPObQosklUdjaNd1QRuaPDUDapsnOdtpaNjPH0fxaJi57ynl+6u1IYeLHeLT9iS6qhz5A==
X-Gm-Gg: Acq92OFIDZxWfmkDok9hexsU0qcaLd8+0efKerrnklXjMIvVrUjaZkQdfAhU1vWRxjO
 rtwxsBpVECHAeV+n1p9tEA5vqgCbmWAkCOP+Kwwkeqs5WYiauDgiA7Dl3KII9j6CbzM3QlBsRsY
 DRpcjrdxZip7jAgoqt5r7uNwGYbtxP8nP2TIkregNrwt6ybGjtW4GFSCkVtwL38QkqeFO+e1vcH
 molGBz72suArFDGRirX7edF2D1iqV9uApv0bcMaN1HoMM2gqh5ov5WErE5WGozp6v087F2VqOwf
 h05wc1jcAdJ3iLYcMw2ZI7W+0tmoSzXFFDGjtQ/16/f6GcYfpXd7ceIb8Gx4cYtL5hYy4sV1GVd
 jmTpkvLYQRhKEglQ1NQPld3BfnEHE
X-Received: by 2002:a05:6214:301e:b0:8ce:d77e:e5f with SMTP id
 6a1803df08f44-8cee6141b25mr462425166d6.36.1781106392485; 
 Wed, 10 Jun 2026 08:46:32 -0700 (PDT)
X-Received: by 2002:a05:6214:301e:b0:8ce:d77e:e5f with SMTP id
 6a1803df08f44-8cee6141b25mr462424686d6.36.1781106391913; 
 Wed, 10 Jun 2026 08:46:31 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd053210sm233596986d6.26.2026.06.10.08.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 08:46:31 -0700 (PDT)
Message-ID: <86cf30192e1cc11d411c4384eba1e61a663b919f.camel@redhat.com>
Subject: Re: [PATCH v19 4/4] rust: drm: gem: Introduce
 shmem::Object::sg_table()
From: lyude@redhat.com
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
Date: Wed, 10 Jun 2026 11:46:31 -0400
In-Reply-To: <20260608184829.B7E7B1F00893@smtp.kernel.org>
References: <20260608183057.2001376-5-lyude@redhat.com>
 <20260608184829.B7E7B1F00893@smtp.kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 78qJjy5E8QyH1r22b5O8ht3ZjY8ZPuAZ2uJtfiiOPUQ_1781106393
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

I think these are (almost) all false positives?

On Mon, 2026-06-08 at 18:48 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider:
> - [Critical] `SGTableMap::drop()` unconditionally frees the
> scatter/gather table, causing a double-free and memory corruption for
> imported GEM objects whose SGT is owned by the DMA-BUF exporter.
> - [Critical] Caching `Devres` in a `SetOnce` field on a reference-
> counted GEM object causes a Use-After-Free if the driver is unbound
> and rebound.
> - [Critical] Concurrent execution of device unbind
> (`devres_node_release`) and GEM object freeing (`free_callback`)
> causes a fatal Use-After-Free due to missing synchronization.
> - [High] SGTableMap fails to pin the GEM object, allowing the
> shrinker to purge the object and free the sg_table out from under the
> Rust driver, leading to a UAF and NULL pointer dereference.
> - [High] `SGTableMap::drop` destroys the SGT but fails to release the
> backing pages reference, permanently leaking the memory and
> triggering a kernel warning on rebinds.
> --
>=20
> commit ca164753ace4f901b6f5bd1ab132aa0d035c5a2b
> Author: Lyude Paul <lyude@redhat.com>
> rust: drm: gem: Introduce shmem::Object::sg_table()
>=20
> This patch introduces sg_table() to shmem::Object, utilizing Devres
> to ensure
> SGTable mappings are released on driver-unbind.
>=20
> > diff --git a/rust/kernel/drm/gem/shmem.rs
> > b/rust/kernel/drm/gem/shmem.rs
> > index e0bd0695ba1f8..ae97498500afa 100644
> > --- a/rust/kernel/drm/gem/shmem.rs
> > +++ b/rust/kernel/drm/gem/shmem.rs
>=20
> [ ... ]
>=20
> > @@ -183,18 +207,26 @@ extern "C" fn free_callback(obj: *mut
> > bindings::drm_gem_object) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - DRM always passes=
 a valid gem object here
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We used drm_gem_s=
hmem_create() in our
> > create_gem_object callback, so we know that
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `obj` i=
s contained within a drm_gem_shmem_object
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { conta=
iner_of!(obj,
> > bindings::drm_gem_shmem_object, base) };
> > -
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're in free_callback=
 - so this function is safe to
> > call.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We won't be using the =
gem resources on `this` after
> > this call.
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_gem_=
shmem_release(this) };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let base =3D unsafe { conta=
iner_of!(obj,
> > bindings::drm_gem_shmem_object, base) };
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We verified above=
 that `obj` is valid, which makes
> > `this` valid
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This function is =
set in AllocOps, so we know that
> > `this` is contained within a
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `Object=
<T, C>`
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { conta=
iner_of!(Opaque::cast_from(this),
> > Self, obj) }.cast_mut();
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { conta=
iner_of!(Opaque::cast_from(base),
> > Self, obj) }.cast_mut();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We need to drop `sgt_res=
` first, since doing so
> > requires that the GEM object is still
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // alive.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We verified above that=
 `this` is valid.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We are in free_callbac=
k, guaranteeing we have
> > exclusive access to `this` and that
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `sgt_res` wi=
ll not be used after dropping it here.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { ManuallyDrop::drop=
(&mut (*this).sgt_res) };
>=20
> [Severity: Critical]
> Could this cause a race condition with a concurrent device unbind? If
> the
> drop races with devres_node_release, Devres::drop's internal atomic
> revoke
> might return false, but free_callback proceeds to free the Rust
> Object memory
> without blocking.

This doesn't make sense - `sgt_res` doesn't get cleared on driver
unbind, the Devres simply just no longer can be used to access its
contents.

>=20
> When the concurrent unbind thread continues and invokes
> SGTableMap::drop, it
> dereferences self.obj to acquire the dma_resv lock, which would
> access
> already freed memory.

I don't think the drop order here matters?

>=20
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We're in free_callback=
 - so this function is safe to
> > call.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We won't be using the =
gem resources on `this` after
> > this call.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::drm_gem_=
shmem_release(base) };
> > =C2=A0
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We're recov=
ering the Kbox<> we created in
> > gem_create_object()
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _ =3D unsafe { KBo=
x::from_raw(this) };
>=20
> [ ... ]
>=20
> > @@ -270,6 +302,46 @@ pub fn vmap<const SIZE: usize>(&self) ->
> > Result<VMapRef<'_, T, C, SIZE>> {
> > =C2=A0=C2=A0=C2=A0=C2=A0 pub fn owned_vmap<const SIZE: usize>(&self) ->
> > Result<VMapOwned<T, C, SIZE>> {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.make_vmap()
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0 /// Creates (if necessary) and returns an immutable=
 reference
> > to a scatter-gather table of DMA
> > +=C2=A0=C2=A0=C2=A0 /// pages for this object.
> > +=C2=A0=C2=A0=C2=A0 ///
> > +=C2=A0=C2=A0=C2=A0 /// This will pin the object in memory. It is expec=
ted that
> > `dev` should be a pointer to the
> > +=C2=A0=C2=A0=C2=A0 /// same [`device::Device`] which `self` belongs to=
, otherwise
> > this function will return
> > +=C2=A0=C2=A0=C2=A0 /// `Err(EINVAL)`.
> > +=C2=A0=C2=A0=C2=A0 pub fn sg_table<'a>(
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &'a self,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dev: &'a device::Device<Bou=
nd>,
> > +=C2=A0=C2=A0=C2=A0 ) -> Result<&'a scatterlist::SGTable> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if dev.as_raw() !=3D self.d=
ev().as_ref().as_raw() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret=
urn Err(EINVAL);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let sgt_res =3D 'out: {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
Fast path: sgt_res is already initialized
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
let Some(sgt_res) =3D self.sgt_res.as_ref() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break 'out sgt_res;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
Slow path: Grab the lock and see if we need to
> > initialize sgt_res.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let=
 _guard =3D self.sgt_lock.lock();
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
If someone initialized it while we were waiting, we
> > can exit early.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if =
let Some(sgt_res) =3D self.sgt_res.as_ref() {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break 'out sgt_res;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
If not, finish initializing and return.
> > `populate()` cannot return false, as
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
`sgt_res` must be unpopulated, and we must hold
> > `sgt_lock` to reach this point.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sel=
f.sgt_res
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .populate(Devres::new(dev,
> > SGTableMap::new(self))?);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // =
SAFETY: We just populated sgt_res above.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uns=
afe { self.sgt_res.as_ref().unwrap_unchecked() }
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(sgt_res.access(dev)?)
> > +=C2=A0=C2=A0=C2=A0 }
>=20
> [Severity: Critical]
> Does caching Devres in a SetOnce field on a reference-counted GEM
> object
> cause a use-after-free on driver rebind?=20

Driver "rebind" is definitely not something I've ever heard before, is
that even possible for a driver to do?

>=20
> On device unbind, the Devres is revoked and its internal SGTableMap
> is dropped,
> clearing the SGT. Since the GEM object outlives the binding and
> SetOnce is
> never cleared, a subsequent rebind with the same device pointer would
> hit
> the fast path here. The call to access() bypasses revocation checks,
> returning
> a reference to the dropped SGTableMap and accessing a NULL shmem-
> >sgt.
>=20
> > =C2=A0}
> > =C2=A0
> > =C2=A0impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
>=20
> [ ... ]
>=20
> > @@ -468,6 +540,64 @@ unsafe fn io_write(&self, value: $ty, address:
> > usize) {
> > =C2=A0#[cfg(CONFIG_64BIT)]
> > =C2=A0impl_vmap_io_capable!(u64);
> > =C2=A0
> > +/// A reference to a GEM object that is known to have a mapped
> > [`SGTable`].
> > +///
> > +/// This is used by the Rust bindings with [`Devres`] in order to
> > ensure that mappings for SGTables
> > +/// on GEM shmem objects are revoked on driver-unbind.
> > +///
> > +/// # Invariants
> > +///
> > +/// - `self.obj` always points to a valid GEM object.
> > +/// - This object is proof that `self.obj.owner.sgt_res` has an
> > initialized and valid pointer to an
> > +///=C2=A0=C2=A0 [`SGTable`].
> > +///
> > +/// [`SGTable`]: scatterlist::SGTable
> > +pub struct SGTableMap<T: DriverObject, C: DeviceContext> {
> > +=C2=A0=C2=A0=C2=A0 obj: NonNull<Object<T, C>>,
> > +}
> > +
> > +impl<T: DriverObject, C: DeviceContext> Deref for SGTableMap<T, C>
> > {
> > +=C2=A0=C2=A0=C2=A0 type Target =3D scatterlist::SGTable;
> > +
> > +=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - The NonNull is guarant=
eed to be valid via our type
> > invariants.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - The sgt field is guara=
nteed to be initialized and
> > valid via our type invariants.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> > scatterlist::SGTable::from_raw((*self.obj.as_ref().as_raw_shmem()).
> > sgt) }
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
> > +
> > +impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C>
> > {
> > +=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `obj` is always =
valid via our type invariants
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D unsafe { self.o=
bj.as_ref() };
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let _lock =3D DmaResvGuard:=
:new(obj);
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We acquired the =
lock needed for calling this
> > function above
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe {
> > bindings::__drm_gem_shmem_free_sgt_locked(obj.as_raw_shmem()) };
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
> [Severity: Critical]
> Is it safe to unconditionally free the SGT here? For imported DMA-BUF
> objects, the SGT is owned by the exporter and must be freed via
> dma_buf_unmap_attachment. Calling __drm_gem_shmem_free_sgt_locked on
> an
> imported object frees the exporter's table, leading to memory
> corruption
> and a double-free when the DMA-BUF is eventually destroyed.

I don't think this is correct either, but I'm a bit stumped on this
one? Or if it is, it's not a bug in this patch. It looks like it's
pulling tokens from other functions that look like they have similar
purposes (drm_gem_shmem_prime_import_no_map(), or
drm_gem_shmem_prime_import_sg_table()) but I can't tell.

>=20
> [Severity: High]
> Does this leak the backing pages reference? SGTableMap::new calls
> drm_gem_shmem_get_pages_sgt, which increments pages_use_count. When
> this
> drop destroys the SGT, it omits the paired call to
> drm_gem_shmem_put_pages_locked. If a driver unbinds and rebinds, this
> will leak the extra reference and trigger a kernel warning.

I think this one may actually be correct, but it's not about this
patch.

>=20
> > +
> > +impl<T: DriverObject, C: DeviceContext> SGTableMap<T, C> {
> > +=C2=A0=C2=A0=C2=A0 fn new(obj: &Object<T, C>) -> impl Init<Self, Error=
> {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We call drm_gem_shmem_=
get_pages_sgt below and check
> > whether or not it succeeds,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 fulfilling t=
he invariant of SGTableMap that the
> > object's `sgt` field is initialized.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - `obj` is fully initial=
ized, making this function safe
> > to call.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_err_ptr(unsafe {
> > bindings::drm_gem_shmem_get_pages_sgt(obj.as_raw_shmem()) })?;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(Self { obj: obj.into() }=
)
> > +=C2=A0=C2=A0=C2=A0 }
> > +}
>=20
> [Severity: High]
> Should this pin the GEM object? The documentation for sg_table
> mentions it
> pins the object, but drm_gem_shmem_get_pages_sgt only increments
> pages_use_count, not pages_pin_count.=20
>=20
> If userspace calls madvise(DONTNEED), the shrinker could purge the
> object,
> freeing shmem->sgt. When SGTableMap is dropped, passing the object to
> __drm_gem_shmem_free_sgt_locked will dereference a NULL pointer.

Looks correct, but not our bug again.

