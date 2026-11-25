Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41261606A334
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 15:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=XawzcFH9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C5F10E8F7;
	Wed, 25 Nov 2026 15:15:27 +0000 (UTC)
Received: from sender5-op-o11.zoho.com (sender5-op-o11.zoho.com
 [165.173.182.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAB4110E8F7
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 15:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795619717; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dmHhvP8wb97y9f62jf0DPLoyvfiAnOnZFwXN5jnlnLGlCujIivZX7DyauLLuXidx0hO+GCcZL6qOb8HMwsLU+bN5jGPYYiOLVnny5j9qLcnq3d8blBo4lJ07xFe/20Rb5lRjlX9fEJ401b0zg5hWfp1ljtVwkBnTzJzJkkm7bS8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795619717;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=KsKOL1LBuE5DwahQvnWhjgMjkWGirzDL40wWzqc9Jsg=; 
 b=M+MGlnaHjtNdkUnvZPzHWcMYhWt61AGBuGr4aMVCDkVvm1ojyDoYZPDKZQMfjkxtAfYldoh1E5J8GViV6PnhwFb+xmtwpSgltjzVgQuQjzetDZTdkXDBMA90fhDw5kbgTIQjXIr+7R4Of5uQi7dLWKfBn3Fv/fgllCrFlxmDT0o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=XawzcFH99NAGaEH4Fv59nI+nfcNk0o+a54DiHyLysYi1R0WU7e+NRpifdM1OtXtiT80i/ajYPBeXSDhP5h60uKYqIvLJmw15F3FQUhHSCK8pNqf1fsDRjFKQxhxtIF0tUi5t3GUBEb4jJQ3yj8qfWX89JzpYb95MnFnOXye0FjA=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=KsKOL1LBuE5DwahQvnWhjgMjkWGirzDL40wWzqc9Jsg=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795619715408617.2203218784065;
 Wed, 25 Nov 2026 07:15:15 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH v7 04/10] drm/tyr: add per-file VM pool
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20261122-tyr-ioctls-v7-4-3a2af624b992@linux.dev>
Date: Wed, 25 Nov 2026 12:14:54 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 Ke Sun <sunke@kylinos.cn>
Content-Transfer-Encoding: quoted-printable
Message-Id: <27D1AE72-927B-4F2E-B2E3-E5226626ABB8@collabora.com>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-4-3a2af624b992@linux.dev>
To: Alvin Sun <alvin.sun@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-ZohoMailClient: External
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 22 Nov 2026, at 09:50, Alvin Sun <alvin.sun@linux.dev> wrote:
>=20
> Userspace needs multiple independent GPU address spaces per file,
> addressed by ID through the VM ioctls as in panthor. Store them in an

Can you please capitalize Panthor?

> IdPool (capped at 32 for panthor parity) plus an XArray. On failure
> the caller receives the VM for teardown through the returned error,
> whether the un-stored clone or the original on an ID conflict, so an

Perhaps =E2=80=9Cnot yet stored=E2=80=9D? Although a native English =
speaker is
probably in a better position to judge this.

> aborted creation never leaks a VM. The pool kills every VM still
> stored when the file closes.
>=20
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
> drivers/gpu/drm/tyr/vm.rs | 145 =
+++++++++++++++++++++++++++++++++++++++++++++-
> 1 file changed, 144 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 1dd11b2b12532..e67a6efcf451b 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -11,6 +11,7 @@
> use core::ops::Range;
>=20
> use kernel::{
> +    alloc::AllocError,
>     device::{
>         Bound,
>         Device, //
> @@ -33,6 +34,7 @@
>         }, //
>     },
>     fmt,
> +    id_pool::IdPool,
>     impl_flags,
>     io::PhysAddr,
>     iommu::pgtable::{
> @@ -41,6 +43,7 @@
>         ARM64LPAES1, //
>     },
>     new_mutex,
> +    num::casts::FromSafeCast,
>     prelude::*,
>     sizes::{
>         SZ_1G,
> @@ -53,7 +56,11 @@
>         ArcBorrow,
>         Mutex, //
>     },
> -    uapi, //
> +    uapi,
> +    xarray::{
> +        AllocKind,
> +        XArray, //
> +    }, //
> };
>=20
> use crate::{
> @@ -947,3 +954,139 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, =
ARM64LPAES1>, range: Range<u64>)
>=20
>     Ok(())
> }
> +
> +/// Maximum number of VMs a single file may hold, matching panthor's
> +/// `PANTHOR_MAX_VMS_PER_FILE`.
> +const MAX_VMS_PER_FILE: usize =3D 32;
> +
> +/// Per-open-file pool of VMs.
> +#[pin_data(PinnedDrop)]
> +pub(crate) struct VmPool<'drm> {
> +    /// Parent device, for error reporting.
> +    dev: &'drm Device<Bound>,
> +    #[pin]
> +    ids: Mutex<IdPool>,
> +    #[pin]
> +    vms: XArray<Arc<Vm<'drm>>>,
> +}
> +
> +/// Error returned when a VM cannot be added to the pool. The caller
> +/// owns the teardown of the VM in [`AddError::vm`].
> +pub(crate) struct AddError<'drm> {
> +    #[expect(dead_code)]
> +    pub(crate) error: Error,
> +    #[expect(dead_code)]
> +    pub(crate) vm: Arc<Vm<'drm>>,
> +}
> +
> +impl<'drm> VmPool<'drm> {
> +    /// Creates a new [`VmPool`].
> +    ///
> +    /// The pool is sized for [`MAX_VMS_PER_FILE`] IDs on all =
architectures,
> +    /// including 32-bit builds where `IdPool::new()` would only hold =
31 IDs
> +    /// because `find_unused_id(1)` skips bit 0 of an inline bitmap.
> +    #[expect(dead_code)]
> +    pub(crate) fn new(dev: &'drm Device<Bound>) -> Result<impl =
PinInit<Self>, AllocError> {
> +        let ids =3D IdPool::with_capacity(MAX_VMS_PER_FILE + 1, =
GFP_KERNEL)?;
> +        Ok(pin_init!(Self {
> +            dev,
> +            ids <- new_mutex!(ids),
> +            vms <- XArray::new(AllocKind::Alloc),
> +        }))
> +    }
> +
> +    /// Stores the VM and returns the allocated ID.
> +    ///
> +    /// On failure - ID space exhausted or a store failure - the VM =
is
> +    /// returned in an [`AddError`] so the caller owns the teardown.
> +    // TODO: allocate IDs with the XArray directly (once it grows =
range
> +    // allocation, the equivalent of C's `XA_LIMIT`) and drop the =
IdPool.
> +    #[expect(dead_code)]
> +    pub(crate) fn add(&self, vm: Arc<Vm<'drm>>) -> Result<u32, =
AddError<'drm>> {
> +        let id =3D (|| {
> +            let mut ids =3D self.ids.lock();
> +            let unused =3D ids.find_unused_id(1).ok_or(ENOSPC)?;
> +            if unused.as_usize() > MAX_VMS_PER_FILE {
> +                return Err(ENOSPC);
> +            }
> +            Ok(unused.acquire())
> +        })();
> +        let id =3D match id {
> +            Ok(id) =3D> id,
> +            Err(error) =3D> return Err(AddError { error, vm }),
> +        };
> +
> +        let mut vms =3D self.vms.lock();
> +        match vms.store(id, vm.clone(), GFP_KERNEL) {
> +            Ok(prev_vm) =3D> {
> +                if let Some(prev_vm) =3D prev_vm {
> +                    // An existing VM at the freshly allocated slot =
means the
> +                    // IdPool and the XArray are out of sync: the =
stored VM is
> +                    // a pool entry, so the pool kills it and the =
caller's VM
> +                    // is returned for teardown.
> +                    drop(vms.remove(id));
> +                    drop(vms);
> +                    prev_vm.kill();
> +                    self.ids.lock().release_id(id);
> +                    dev_err!(
> +                        self.dev,

VMs already have a dev() accessor. For the time being
I don=E2=80=99t think we need to store dev here too.

> +                        "IdPool/XArray out of sync at VM pool id {id} =
(stored VM conflict)"

Missing newline here. Also, could you please improve this message? =
Someone
seeing this on dmesg has no idea what is going on. How about:

"VM id {id} marked free but still in use\n"

?


> +                    );
> +                    return Err(AddError { error: EBUSY, vm });
> +                }
> +                Ok(id as u32)

Please remove this cast. Use as_u32() instead.

> +            }
> +            Err(err) =3D> {
> +                // Drop the XArray spinlock before acquiring the =
`ids` mutex.
> +                drop(vms);
> +                // Release the pooled id; the VM never entered the =
pool, so it
> +                // is returned to the caller for teardown.
> +                self.ids.lock().release_id(id);
> +                Err(AddError {
> +                    error: err.error,
> +                    vm: err.value,
> +                })
> +            }
> +        }
> +    }
> +
> +    /// Removes and kills the VM with the given ID.
> +    #[expect(dead_code)]
> +    pub(crate) fn remove(&self, id: u32) -> Result<()> {

Result<()> -> Result=20

> +        let mut vms =3D self.vms.lock();
> +        let vm =3D match vms.remove(usize::from_safe_cast(id)) {
> +            Some(vm) =3D> vm,
> +            None =3D> return Err(EINVAL),
> +        };
> +        // Drop the XArray spinlock before killing, since `kill()` =
may sleep.
> +        drop(vms);
> +        // Kill the VM before handing the id back to the pool, so a =
VM is
> +        // never reusable while still alive.
> +        vm.kill();
> +        self.ids.lock().release_id(usize::from_safe_cast(id));
> +        Ok(())
> +    }
> +
> +    /// Gets a shared reference to the VM with the given ID.
> +    #[expect(dead_code)]
> +    pub(crate) fn get(&self, id: u32) -> Option<Arc<Vm<'drm>>> {
> +        let vms =3D self.vms.lock();
> +        let borrow =3D vms.get(usize::from_safe_cast(id))?;
> +        Some(Arc::from(borrow))
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for VmPool<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Kill every VM left in the pool. The ID range is bounded by
> +        // `MAX_VMS_PER_FILE`, so this loop is cheap and runs at file =
close.
> +        for id in 1..=3DMAX_VMS_PER_FILE {
> +            // Release the XArray lock guard before killing: `kill()` =
may sleep.
> +            let vm =3D self.vms.lock().remove(id);
> +            if let Some(vm) =3D vm {
> +                vm.kill();
> +            }
> +        }
> +    }
> +}
>=20
> --=20
> 2.43.0
>=20
>=20


With the fixes above + the fixes Deborah asked for:

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=
