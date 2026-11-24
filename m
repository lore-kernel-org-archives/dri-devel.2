Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4C4606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Gp6vh78B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D3B110EFF8;
	Tue, 24 Nov 2026 23:43:38 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5217410EFF8
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 23:43:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795563806; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bh3+LCx8qV+vW1dINdJofNic+MV/TnlPSuWsa6WehjHhKiNy6k+bjM7FXPemW8SpSilivyKJQ+f6Z2tKyI4HRvcD1NF2gHMcr3cPROpNLFKs1E00OpasBqUARwz7z6+oUarAzGXyVLswxbitY1JJlOUDwv72JaXYX7mAqpPDUhY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795563806;
 h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=AAu0m4r/j5PDw3y2hQMlPY2Gh8yBE327ApiPIDIWDfk=; 
 b=MDsnx3wrh6zSnR3jbk9fIaEoQljZn3IueLx3KwJ1ypON5DbAoE+4fdQQtTjFJFx/mlYP3+3+p+3gq35ih8FqLDcNfnCJcIR9BgPD7aPyDlgGNW4TGeQQ3dl2i2tkEaDih5SdtOLWZHV/dEAxZjrd+9WqqpI5/2mo1G0N6nhkeC4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Gp6vh78BSFlFlibUSIehlK0gmNbqYNirj69pT8dKhks6WpuhDy6z5w8IWZbsKm7jKcoOaeECbtsjuqk8c9wTPHghctp/gZRetVRXmXgipSrEVw5yv53hgCjaJIoJ135hYGOB6/C01og8a6rA4Re9GE5HvY4xhCkDvonMY8KjiPs=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=AAu0m4r/j5PDw3y2hQMlPY2Gh8yBE327ApiPIDIWDfk=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795563804992109.6167052303839;
 Tue, 24 Nov 2026 15:43:24 -0800 (PST)
Date: Tue, 24 Nov 2026 16:43:21 -0700
From: Deborah Brouwer <deborah.brouwer@collabora.com>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>,
 Sami Tolvanen <samitolvanen@google.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 driver-core@lists.linux.dev, Ke Sun <sunke@kylinos.cn>
Subject: Re: [PATCH v7 04/10] drm/tyr: add per-file VM pool
Message-ID: <awYhGbovN-Fg-Rsr@um790>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
 <20261122-tyr-ioctls-v7-4-3a2af624b992@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261122-tyr-ioctls-v7-4-3a2af624b992@linux.dev>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/295.549.79
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

On Sun, Nov 22, 2026 at 08:50:23PM +0800, Alvin Sun wrote:
> Userspace needs multiple independent GPU address spaces per file,
> addressed by ID through the VM ioctls as in panthor. Store them in an
> IdPool (capped at 32 for panthor parity) plus an XArray. On failure
> the caller receives the VM for teardown through the returned error,
> whether the un-stored clone or the original on an ID conflict, so an
> aborted creation never leaks a VM. The pool kills every VM still
> stored when the file closes.
> 
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  drivers/gpu/drm/tyr/vm.rs | 145 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 144 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
> index 1dd11b2b12532..e67a6efcf451b 100644
> --- a/drivers/gpu/drm/tyr/vm.rs
> +++ b/drivers/gpu/drm/tyr/vm.rs
> @@ -11,6 +11,7 @@
>  use core::ops::Range;
>  
>  use kernel::{
> +    alloc::AllocError,
>      device::{
>          Bound,
>          Device, //
> @@ -33,6 +34,7 @@
>          }, //
>      },
>      fmt,
> +    id_pool::IdPool,
>      impl_flags,
>      io::PhysAddr,
>      iommu::pgtable::{
> @@ -41,6 +43,7 @@
>          ARM64LPAES1, //
>      },
>      new_mutex,
> +    num::casts::FromSafeCast,
>      prelude::*,
>      sizes::{
>          SZ_1G,
> @@ -53,7 +56,11 @@
>          ArcBorrow,
>          Mutex, //
>      },
> -    uapi, //
> +    uapi,
> +    xarray::{
> +        AllocKind,
> +        XArray, //
> +    }, //
>  };
>  
>  use crate::{
> @@ -947,3 +954,139 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
>  
>      Ok(())
>  }
> +
> +/// Maximum number of VMs a single file may hold, matching panthor's
> +/// `PANTHOR_MAX_VMS_PER_FILE`.
> +const MAX_VMS_PER_FILE: usize = 32;
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
> +    /// The pool is sized for [`MAX_VMS_PER_FILE`] IDs on all architectures,
> +    /// including 32-bit builds where `IdPool::new()` would only hold 31 IDs
> +    /// because `find_unused_id(1)` skips bit 0 of an inline bitmap.
> +    #[expect(dead_code)]
> +    pub(crate) fn new(dev: &'drm Device<Bound>) -> Result<impl PinInit<Self>, AllocError> {
> +        let ids = IdPool::with_capacity(MAX_VMS_PER_FILE + 1, GFP_KERNEL)?;
> +        Ok(pin_init!(Self {
> +            dev,
> +            ids <- new_mutex!(ids),
> +            vms <- XArray::new(AllocKind::Alloc),
> +        }))
> +    }
> +
> +    /// Stores the VM and returns the allocated ID.
> +    ///
> +    /// On failure - ID space exhausted or a store failure - the VM is
> +    /// returned in an [`AddError`] so the caller owns the teardown.
> +    // TODO: allocate IDs with the XArray directly (once it grows range
> +    // allocation, the equivalent of C's `XA_LIMIT`) and drop the IdPool.
> +    #[expect(dead_code)]
> +    pub(crate) fn add(&self, vm: Arc<Vm<'drm>>) -> Result<u32, AddError<'drm>> {
> +        let id = (|| {
> +            let mut ids = self.ids.lock();
> +            let unused = ids.find_unused_id(1).ok_or(ENOSPC)?;

In v6, I suggeted we use EBUSY here so that we have parity with panthor.
Any concerns with this?

> +            if unused.as_usize() > MAX_VMS_PER_FILE {
> +                return Err(ENOSPC);

Same here.

> +            }


> +            Ok(unused.acquire())
> +        })();
> +        let id = match id {
> +            Ok(id) => id,
> +            Err(error) => return Err(AddError { error, vm }),
> +        };
> +
> +        let mut vms = self.vms.lock();
> +        match vms.store(id, vm.clone(), GFP_KERNEL) {
> +            Ok(prev_vm) => {
> +                if let Some(prev_vm) = prev_vm {
> +                    // An existing VM at the freshly allocated slot means the
> +                    // IdPool and the XArray are out of sync: the stored VM is
> +                    // a pool entry, so the pool kills it and the caller's VM
> +                    // is returned for teardown.
> +                    drop(vms.remove(id));
> +                    drop(vms);
> +                    prev_vm.kill();
> +                    self.ids.lock().release_id(id);
> +                    dev_err!(
> +                        self.dev,
> +                        "IdPool/XArray out of sync at VM pool id {id} (stored VM conflict)"
> +                    );
> +                    return Err(AddError { error: EBUSY, vm });
> +                }
> +                Ok(id as u32)
> +            }
> +            Err(err) => {
> +                // Drop the XArray spinlock before acquiring the `ids` mutex.
> +                drop(vms);
> +                // Release the pooled id; the VM never entered the pool, so it
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
> +        let mut vms = self.vms.lock();
> +        let vm = match vms.remove(usize::from_safe_cast(id)) {
> +            Some(vm) => vm,
> +            None => return Err(EINVAL),
> +        };
> +        // Drop the XArray spinlock before killing, since `kill()` may sleep.
> +        drop(vms);
> +        // Kill the VM before handing the id back to the pool, so a VM is
> +        // never reusable while still alive.
> +        vm.kill();
> +        self.ids.lock().release_id(usize::from_safe_cast(id));
> +        Ok(())
> +    }
> +
> +    /// Gets a shared reference to the VM with the given ID.
> +    #[expect(dead_code)]
> +    pub(crate) fn get(&self, id: u32) -> Option<Arc<Vm<'drm>>> {
> +        let vms = self.vms.lock();
> +        let borrow = vms.get(usize::from_safe_cast(id))?;
> +        Some(Arc::from(borrow))
> +    }
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for VmPool<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        // Kill every VM left in the pool. The ID range is bounded by
> +        // `MAX_VMS_PER_FILE`, so this loop is cheap and runs at file close.
> +        for id in 1..=MAX_VMS_PER_FILE {
> +            // Release the XArray lock guard before killing: `kill()` may sleep.
> +            let vm = self.vms.lock().remove(id);
> +            if let Some(vm) = vm {
> +                vm.kill();
> +            }
> +        }
> +    }
> +}
> 
> -- 
> 2.43.0
> 
> 
