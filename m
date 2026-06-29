Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCFBBC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:35:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 204D010EA64;
	Mon, 29 Jun 2026 21:35:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="FLNBWIhj";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6980E10E12F
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 21:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782768932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ami3OEVVmPIPc65ivwuYHu9E/kmgmz19rUk+xS/sEd8=;
 b=FLNBWIhjnbt3N/NU0Wqgv15iDomELkoOxTqHhpmdp1aDAD0CCTRvV13qkMb5ItYlD2ROp1
 n/lkhQGIR9rSZA1hPctkGRoJV3flSdHYqzn8va3CoGpzS3W/2JY3lsJ+yOskpSPlfVNEHG
 MfGOtNS4OQeqg1Tcf8uj/o6JtzuGVSo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-JOAA69eYNNmnmQlV-Pgzvg-1; Mon, 29 Jun 2026 17:35:30 -0400
X-MC-Unique: JOAA69eYNNmnmQlV-Pgzvg-1
X-Mimecast-MFC-AGG-ID: JOAA69eYNNmnmQlV-Pgzvg_1782768930
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e62e3459fso78189185a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:35:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782768930; x=1783373730;
 h=mime-version:user-agent:content-transfer-encoding:references
 :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ami3OEVVmPIPc65ivwuYHu9E/kmgmz19rUk+xS/sEd8=;
 b=QH+ohJ3uVvGBQjWtJCtOquqll4Pjya5rsyM65DBDut6y6iVy5bEvr6Gn2/02vjDOM5
 DxWMtS9K7qKjZ2CBSVB0HvMh9dIt5wZcNIVxOL+Jup/6DpznQ6kt5XGaTjuF1qIfB2Pa
 X6RrX/xIr0BCRoVpeDdmol7Ua7JHHkbzwqpzWe2Lbx8Qk8R4gnxPjb2gUeRx1kkcYeX+
 qvJLyuJoC1KAg/gd89TLCQEszqcvTMZ0TI4QCglIzzZIq698WXnM+ZiCGBS8A4OWQ3IA
 3icHAMKW/vhQt2IG0t29P4YaS6rTN6vl5MC9mrxCj0uYoyVXNT5LaBbbxxlw7HzO/bZX
 ZPnA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LykJf9wAB+YuuKg/h5XXgIqS3330c6OX5vy9YlgF7chqxvYk8WsmTOw4N3d3qbxUQmEC/vCL+ZbU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyzJ89Z4LHf2whixC7xEhcAEhJ8pnNW/jMlsRqWtpflkDS/r8Gg
 vtP4c9iMPsDDii/inagSW3ptYdsJLSQnjNWLeghHhXB7ecwna7iVopU1cbAyPFUX1LT3aQLIz0m
 yvxxUZgMaU+7u0OZlU/2o4kRa4iZeeP8ZEN1DqLIxgskT6wd4aroSdWSmMQpJ7/mEPA4Zyw==
X-Gm-Gg: AfdE7cmXMCLsbAj8ZbRlzAJUeCQG8NkmSyeFHLrXQmCPnX99phdrvtkkzVkQTgesfMU
 ahuxoW70/sNDDHMtT6fKD9hJHHWGhZAjNh0XgJKF0/AouAkycjvIjm/4N2Zt249TDmscyMdcZBs
 PVvSQ9HoQLIlH3BsCsxvHfwYmZcWQEUrzmaizSkAe/cGY/WFn3kc1YfduXrp2ALkxmpedq9tske
 svW5NZu9GxHxN8XpZE90TQG5mpgvcEflNPdyhMt6CzMIRvZurFJsv6STb81R+FCVFL0gLtW13C1
 BpOkbouMJGtpk2dLsUAoIN4rMpzCWGP4n7J+GIMz1E0rqf68T1NsPKeu79azuBogIv5opmACGjW
 DO3l33F8=
X-Received: by 2002:a05:620a:489b:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-92e624d84f8mr226754585a.22.1782768929684; 
 Mon, 29 Jun 2026 14:35:29 -0700 (PDT)
X-Received: by 2002:a05:620a:489b:b0:92e:5f90:c0de with SMTP id
 af79cd13be357-92e624d84f8mr226747885a.22.1782768928846; 
 Mon, 29 Jun 2026 14:35:28 -0700 (PDT)
Received: from [192.168.8.4] ([100.0.180.93]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a27e8629sm8490976d6.8.2026.06.29.14.35.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 14:35:28 -0700 (PDT)
Message-ID: <56328f70c39b9d7db57ab28f66240f003f29aeb0.camel@redhat.com>
Subject: Re: [PATCH v5 08/19] rust: drm/gem: remove DeviceContext from
 shmem::Object
From: lyude@redhat.com
To: Danilo Krummrich <dakr@kernel.org>, aliceryhl@google.com, 
 daniel.almeida@collabora.com, acourbot@nvidia.com, ecourtney@nvidia.com, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, 	lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, 	deborah.brouwer@collabora.com,
 boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
Date: Mon, 29 Jun 2026 17:35:27 -0400
In-Reply-To: <20260628145406.2107056-9-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
 <20260628145406.2107056-9-dakr@kernel.org>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: d72xxaKg5EsTEKq0KJ9fjOifNMHhP9TvKWE9gB6xGdw_1782768930
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

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Sun, 2026-06-28 at 16:53 +0200, Danilo Krummrich wrote:
> Now that AlwaysRefCounted is restricted to the Normal GEM Object
> context, there is no use for instantiating Object<T, C> with a
> non-Normal context. Remove the DeviceContext generic parameter from
> shmem::Object and all associated types (VMap, VMapRef, VMapOwned,
> DmaResvGuard, SGTableMap), simplifying the API.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> =C2=A0rust/kernel/drm/gem/shmem.rs | 121 +++++++++++++++-----------------=
-
> --
> =C2=A01 file changed, 51 insertions(+), 70 deletions(-)
>=20
> diff --git a/rust/kernel/drm/gem/shmem.rs
> b/rust/kernel/drm/gem/shmem.rs
> index cf8410e0f228..e0ef47352e88 100644
> --- a/rust/kernel/drm/gem/shmem.rs
> +++ b/rust/kernel/drm/gem/shmem.rs
> @@ -20,9 +20,7 @@
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 driver,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gem,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 private::Sealed,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DeviceContext,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Normal, //
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Device, //
> =C2=A0=C2=A0=C2=A0=C2=A0 },
> =C2=A0=C2=A0=C2=A0=C2=A0 error::{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 from_err_ptr,
> @@ -48,7 +46,6 @@
> =C2=A0};
> =C2=A0use core::{
> =C2=A0=C2=A0=C2=A0=C2=A0 ffi::c_void,
> -=C2=A0=C2=A0=C2=A0 marker::PhantomData,
> =C2=A0=C2=A0=C2=A0=C2=A0 mem::{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ManuallyDrop,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MaybeUninit, //
> @@ -99,22 +96,20 @@ fn default() -> Self {
> =C2=A0///
> =C2=A0/// - `obj` contains a valid initialized `struct
> drm_gem_shmem_object` for the lifetime of this
> =C2=A0///=C2=A0=C2=A0 object.
> -/// - Any type invariants of `C` apply to the parent DRM device for
> this GEM object.
> =C2=A0#[repr(C)]
> =C2=A0#[pin_data]
> -pub struct Object<T: DriverObject, C: DeviceContext =3D Normal> {
> +pub struct Object<T: DriverObject> {
> =C2=A0=C2=A0=C2=A0=C2=A0 #[pin]
> =C2=A0=C2=A0=C2=A0=C2=A0 obj: Opaque<bindings::drm_gem_shmem_object>,
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Parent object that owns this object's DMA re=
servation
> object.
> =C2=A0=C2=A0=C2=A0=C2=A0 parent_resv_obj: Option<ARef<Object<T>>>,
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Devres object for unmapping any SGTable on d=
river-unbind.
> -=C2=A0=C2=A0=C2=A0 sgt_res: ManuallyDrop<SetOnce<Devres<SGTableMap<T, C>=
>>>,
> +=C2=A0=C2=A0=C2=A0 sgt_res: ManuallyDrop<SetOnce<Devres<SGTableMap<T>>>>=
,
> =C2=A0=C2=A0=C2=A0=C2=A0 #[pin]
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Lock for protecting initialization of `sgt_r=
es`.
> =C2=A0=C2=A0=C2=A0=C2=A0 sgt_lock: Mutex<()>,
> =C2=A0=C2=A0=C2=A0=C2=A0 #[pin]
> =C2=A0=C2=A0=C2=A0=C2=A0 inner: T,
> -=C2=A0=C2=A0=C2=A0 _ctx: PhantomData<C>,
> =C2=A0}
> =C2=A0
> =C2=A0super::impl_aref_for_gem_obj! {
> @@ -124,12 +119,12 @@ impl<T> for Object<T>
> =C2=A0}
> =C2=A0
> =C2=A0// SAFETY: All GEM objects are thread-safe.
> -unsafe impl<T: DriverObject, C: DeviceContext> Send for Object<T, C>
> {}
> +unsafe impl<T: DriverObject> Send for Object<T> {}
> =C2=A0
> =C2=A0// SAFETY: All GEM objects are thread-safe.
> -unsafe impl<T: DriverObject, C: DeviceContext> Sync for Object<T, C>
> {}
> +unsafe impl<T: DriverObject> Sync for Object<T> {}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> Object<T, C> {
> +impl<T: DriverObject> Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// `drm_gem_object_funcs` vtable suitable for G=
EM shmem
> objects.
> =C2=A0=C2=A0=C2=A0=C2=A0 const VTABLE: bindings::drm_gem_object_funcs =3D
> bindings::drm_gem_object_funcs {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 free: Some(Self::free_ca=
llback),
> @@ -157,7 +152,7 @@ fn as_raw_shmem(&self) -> *mut
> bindings::drm_gem_shmem_object {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Returns the `Device` that owns this GEM obje=
ct.
> -=C2=A0=C2=A0=C2=A0 pub fn dev(&self) -> &Device<T::Driver, C> {
> +=C2=A0=C2=A0=C2=A0 pub fn dev(&self) -> &Device<T::Driver> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `dev` will ha=
ve been initialized in `Self::new()`
> by `drm_gem_shmem_init()`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { Device::from_ra=
w((*self.as_raw()).dev) }
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> @@ -171,8 +166,8 @@ extern "C" fn free_callback(obj: *mut
> bindings::drm_gem_object) {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We verified above t=
hat `obj` is valid, which makes
> `this` valid
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This function is set in =
AllocOps, so we know that
> `this` is contained within a
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `Object<T, C>`
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - This function is set in =
AllocOps, so we know that
> `this` is contained within an
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 `Object<T>`
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let this =3D unsafe { co=
ntainer_of!(Opaque::cast_from(base),
> Self, obj) }.cast_mut();
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // We need to drop `sgt_=
res` first, since doing so requires
> that the GEM object is still
> @@ -193,7 +188,7 @@ extern "C" fn free_callback(obj: *mut
> bindings::drm_gem_object) {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Attempt to create a vmap from the gem object=
, and confirm
> the size of said vmap.
> -=C2=A0=C2=A0=C2=A0 fn make_vmap<'a, R, const SIZE: usize>(&'a self) ->
> Result<VMap<T, R, C, SIZE>>
> +=C2=A0=C2=A0=C2=A0 fn make_vmap<'a, R, const SIZE: usize>(&'a self) ->
> Result<VMap<T, R, SIZE>>
> =C2=A0=C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Self=
> + From<&'a Self>,
> =C2=A0=C2=A0=C2=A0=C2=A0 {
> @@ -255,7 +250,7 @@ unsafe fn raw_vunmap(&self, mut map:
> bindings::iosys_map) {
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Creates and returns a virtual kernel memory =
mapping for this
> object.
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> -=C2=A0=C2=A0=C2=A0 pub fn vmap<const SIZE: usize>(&self) -> Result<VMapR=
ef<'_, T,
> C, SIZE>> {
> +=C2=A0=C2=A0=C2=A0 pub fn vmap<const SIZE: usize>(&self) -> Result<VMapR=
ef<'_, T,
> SIZE>> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.make_vmap()
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0
> @@ -298,9 +293,7 @@ pub fn sg_table<'a>(
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Ok(sgt_res.access(dev)?)
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> -}
> =C2=A0
> -impl<T: DriverObject> Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Create a new shmem-backed DRM object of the =
given size.
> =C2=A0=C2=A0=C2=A0=C2=A0 ///
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Additional config options can be specified u=
sing `config`.
> @@ -317,7 +310,6 @@ pub fn new(
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sgt_res: ManuallyDrop::new(SetOnce::new()),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 sgt_lock <- new_mutex!(()),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 inner <- T::new(dev, size, args),
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 _ctx: PhantomData,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
}),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
GFP_KERNEL,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 )?;
> @@ -351,12 +343,12 @@ pub fn new(
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Creates and returns an owned reference to a =
virtual kernel
> memory mapping for this object.
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> -=C2=A0=C2=A0=C2=A0 pub fn owned_vmap<const SIZE: usize>(&self) ->
> Result<VMapOwned<T, Normal, SIZE>> {
> +=C2=A0=C2=A0=C2=A0 pub fn owned_vmap<const SIZE: usize>(&self) ->
> Result<VMapOwned<T, SIZE>> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.make_vmap()
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> Deref for Object<T, C> {
> +impl<T: DriverObject> Deref for Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D T;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> @@ -364,15 +356,15 @@ fn deref(&self) -> &Self::Target {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> DerefMut for Object<T, C> {
> +impl<T: DriverObject> DerefMut for Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn deref_mut(&mut self) -> &mut Self::Target {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &mut self.inner
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> Sealed for Object<T, C> {}
> +impl<T: DriverObject> Sealed for Object<T> {}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> gem::IntoGEMObject for
> Object<T, C> {
> +impl<T: DriverObject> gem::IntoGEMObject for Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn as_raw(&self) -> *mut bindings::drm_gem_objec=
t {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - Our immutable refer=
ence is proof that this is safe to
> dereference.
> @@ -391,7 +383,7 @@ unsafe fn from_raw<'a>(obj: *mut
> bindings::drm_gem_object) -> &'a Self {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> driver::AllocImpl for
> Object<T, C> {
> +impl<T: DriverObject> driver::AllocImpl for Object<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Driver =3D T::Driver;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 const ALLOC_OPS: driver::AllocOps =3D driver::Al=
locOps {
> @@ -410,14 +402,11 @@ impl<T: DriverObject, C: DeviceContext>
> driver::AllocImpl for Object<T, C> {
> =C2=A0/// When this is dropped, the `dma_resv` lock is dropped as well.
> =C2=A0///
> =C2=A0// TODO: This should be replace with a WwMutex equivalent once we
> have such bindings in the kernel.
> -struct DmaResvGuard<'a, T: DriverObject, C: DeviceContext =3D Normal>(
> -=C2=A0=C2=A0=C2=A0 &'a Object<T, C>,
> -=C2=A0=C2=A0=C2=A0 NotThreadSafe,
> -);
> +struct DmaResvGuard<'a, T: DriverObject>(&'a Object<T>,
> NotThreadSafe);
> =C2=A0
> -impl<'a, T: DriverObject, C: DeviceContext> DmaResvGuard<'a, T, C> {
> +impl<'a, T: DriverObject> DmaResvGuard<'a, T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> -=C2=A0=C2=A0=C2=A0 fn new(obj: &'a Object<T, C>) -> Self {
> +=C2=A0=C2=A0=C2=A0 fn new(obj: &'a Object<T>) -> Self {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: This lock is =
initialized throughout the lifetime
> of `object`.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unsafe { bindings::dma_r=
esv_lock(obj.raw_dma_resv(),
> ptr::null_mut()) };
> =C2=A0
> @@ -425,7 +414,7 @@ fn new(obj: &'a Object<T, C>) -> Self {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<'a, T: DriverObject, C: DeviceContext> Drop for
> DmaResvGuard<'a, T, C> {
> +impl<'a, T: DriverObject> Drop for DmaResvGuard<'a, T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: We are releas=
ing the lock grabbed during the
> creation of this object.
> @@ -439,40 +428,37 @@ fn drop(&mut self) {
> =C2=A0///
> =C2=A0/// - The size of `owner` is >=3D SIZE.
> =C2=A0/// - The memory pointed to by `addr` remains valid at least until
> this object is dropped.
> -pub struct VMap<D, R, C =3D Normal, const SIZE: usize =3D 0>
> +pub struct VMap<D, R, const SIZE: usize =3D 0>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>>,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 addr: *mut c_void,
> =C2=A0=C2=A0=C2=A0=C2=A0 owner: R,
> =C2=A0}
> =C2=A0
> =C2=A0/// An alias type for a reference to a shmem-based GEM object's
> VMap.
> -pub type VMapRef<'a, D, C, const SIZE: usize =3D 0> =3D VMap<D, &'a
> Object<D, C>, C, SIZE>;
> +pub type VMapRef<'a, D, const SIZE: usize =3D 0> =3D VMap<D, &'a
> Object<D>, SIZE>;
> =C2=A0
> =C2=A0/// An alias type for an owned reference to a shmem-based GEM
> object's VMap.
> -pub type VMapOwned<D, C, const SIZE: usize =3D 0> =3D VMap<D,
> ARef<Object<D, C>>, C, SIZE>;
> +pub type VMapOwned<D, const SIZE: usize =3D 0> =3D VMap<D,
> ARef<Object<D>>, SIZE>;
> =C2=A0
> -impl<D, R, C, const SIZE: usize> VMap<D, R, C, SIZE>
> +impl<D, R, const SIZE: usize> VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>>,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 /// Borrows a reference to the object that owns =
this virtual
> mapping.
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> -=C2=A0=C2=A0=C2=A0 pub fn owner(&self) -> &Object<D, C> {
> +=C2=A0=C2=A0=C2=A0 pub fn owner(&self) -> &Object<D> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &self.owner
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<D, R, C, const SIZE: usize> Drop for VMap<D, R, C, SIZE>
> +impl<D, R, const SIZE: usize> Drop for VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>>,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> @@ -491,29 +477,26 @@ fn drop(&mut self) {
> =C2=A0
> =C2=A0// SAFETY: `addr` points to a valid memory address for as long as
> `owner` exists, meaning that so
> =C2=A0// long as `owner` is `Send` so is `VMap`.
> -unsafe impl<D, R, C, const SIZE: usize> Send for VMap<D, R, C, SIZE>
> +unsafe impl<D, R, const SIZE: usize> Send for VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>> + Send,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>> + Send,
> =C2=A0{
> =C2=A0}
> =C2=A0
> =C2=A0// SAFETY: `addr` points to a valid memory address for as long as
> `owner` exists, meaning that so
> =C2=A0// long as `owner` is `Sync` so is `VMap`.
> -unsafe impl<D, R, C, const SIZE: usize> Sync for VMap<D, R, C, SIZE>
> +unsafe impl<D, R, const SIZE: usize> Sync for VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>> + Sync,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>> + Sync,
> =C2=A0{
> =C2=A0}
> =C2=A0
> -impl<D, R, C, const SIZE: usize> Io for VMap<D, R, C, SIZE>
> +impl<D, R, const SIZE: usize> Io for VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>>,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 #[inline]
> =C2=A0=C2=A0=C2=A0=C2=A0 fn addr(&self) -> usize {
> @@ -526,22 +509,20 @@ fn maxsize(&self) -> usize {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<D, R, C, const SIZE: usize> IoKnownSize for VMap<D, R, C, SIZE>
> +impl<D, R, const SIZE: usize> IoKnownSize for VMap<D, R, SIZE>
> =C2=A0where
> =C2=A0=C2=A0=C2=A0=C2=A0 D: DriverObject,
> -=C2=A0=C2=A0=C2=A0 C: DeviceContext,
> -=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0 R: Deref<Target =3D Object<D>>,
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0 const MIN_SIZE: usize =3D SIZE;
> =C2=A0}
> =C2=A0
> =C2=A0macro_rules! impl_vmap_io_capable {
> =C2=A0=C2=A0=C2=A0=C2=A0 ($ty:ty) =3D> {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impl<D, R, C, const SIZE: usi=
ze> IoCapable<$ty> for VMap<D,
> R, C, SIZE>
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 impl<D, R, const SIZE: usize>=
 IoCapable<$ty> for VMap<D, R,
> SIZE>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 where
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
D: DriverObject,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 C: De=
viceContext,
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R: De=
ref<Target =3D Object<D, C>>,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 R: De=
ref<Target =3D Object<D>>,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
#[inline]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
unsafe fn io_read(&self, address: usize) -> $ty {
> @@ -584,11 +565,11 @@ unsafe fn io_write(&self, value: $ty, address:
> usize) {
> =C2=A0///=C2=A0=C2=A0 [`SGTable`].
> =C2=A0///
> =C2=A0/// [`SGTable`]: scatterlist::SGTable
> -pub struct SGTableMap<T: DriverObject, C: DeviceContext> {
> -=C2=A0=C2=A0=C2=A0 obj: NonNull<Object<T, C>>,
> +pub struct SGTableMap<T: DriverObject> {
> +=C2=A0=C2=A0=C2=A0 obj: NonNull<Object<T>>,
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> Deref for SGTableMap<T, C> {
> +impl<T: DriverObject> Deref for SGTableMap<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 type Target =3D scatterlist::SGTable;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 fn deref(&self) -> &Self::Target {
> @@ -599,7 +580,7 @@ fn deref(&self) -> &Self::Target {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> Drop for SGTableMap<T, C> {
> +impl<T: DriverObject> Drop for SGTableMap<T> {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // SAFETY: `obj` is alwa=
ys valid via our type invariants
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D unsafe { sel=
f.obj.as_ref() };
> @@ -610,8 +591,8 @@ fn drop(&mut self) {
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0}
> =C2=A0
> -impl<T: DriverObject, C: DeviceContext> SGTableMap<T, C> {
> -=C2=A0=C2=A0=C2=A0 fn new(obj: &Object<T, C>) -> impl Init<Self, Error> =
{
> +impl<T: DriverObject> SGTableMap<T> {
> +=C2=A0=C2=A0=C2=A0 fn new(obj: &Object<T>) -> impl Init<Self, Error> {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // INVARIANT:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // - We call drm_gem_shm=
em_get_pages_sgt below and check
> whether or not it succeeds,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 //=C2=A0=C2=A0 fulfillin=
g the invariant of SGTableMap that the
> object's `sgt` field is initialized.
> @@ -625,10 +606,10 @@ fn new(obj: &Object<T, C>) -> impl Init<Self,
> Error> {
> =C2=A0
> =C2=A0// SAFETY: The NonNull in SGTableMap is guaranteed valid by our typ=
e
> invariants, and the GEM object
> =C2=A0// it points to is guaranteed to be thread-safe.
> -unsafe impl<T: DriverObject, C: DeviceContext> Send for
> SGTableMap<T, C> {}
> +unsafe impl<T: DriverObject> Send for SGTableMap<T> {}
> =C2=A0// SAFETY: The NonNull in SGTableMap is guaranteed valid by our typ=
e
> invariants, and the GEM object
> =C2=A0// it points to is guaranteed to be thread-safe.
> -unsafe impl<T: DriverObject, C: DeviceContext> Sync for
> SGTableMap<T, C> {}
> +unsafe impl<T: DriverObject> Sync for SGTableMap<T> {}
> =C2=A0
> =C2=A0#[kunit_tests(rust_drm_gem_shmem)]
> =C2=A0mod tests {
> @@ -705,7 +686,7 @@ fn create_drm_dev() ->
> Result<(faux::Registration, UnregisteredDevice<KunitDrive
> =C2=A0=C2=A0=C2=A0=C2=A0 fn compile_time_vmap_sizes() -> Result {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let (_dev, drm) =3D crea=
te_drm_dev()?;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect, _>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // Try creating a normal=
 vmap
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 obj.vmap::<PAGE_SIZE>()?=
;
> @@ -729,7 +710,7 @@ fn compile_time_vmap_sizes() -> Result {
> =C2=A0=C2=A0=C2=A0=C2=A0 fn vmap_io() -> Result {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let (_dev, drm) =3D crea=
te_drm_dev()?;
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect, _>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let vmap =3D obj.vmap::<=
PAGE_SIZE>()?;
> =C2=A0
> @@ -761,7 +742,7 @@ fn fail_sg_table_on_wrong_dev() -> Result {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let reg =3D faux::Regist=
ration::new(c"EvilKunit", None)?;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let wrong_dev =3D reg.as=
_ref();
> =C2=A0
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect, _>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 let obj =3D Object::<KunitObj=
ect>::new(&drm, PAGE_SIZE,
> ObjectConfig::default(), ())?;
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert_eq!(obj.sg_table(=
wrong_dev.as_ref()).err().unwrap(),
> EINVAL);
> =C2=A0

