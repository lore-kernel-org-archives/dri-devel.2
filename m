Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6830606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=korg header.b=unTUh1lP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F28CB10E58B;
	Sun, 22 Nov 2026 13:02:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D93510E7B6
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 13:02:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D19361B64;
 Sun, 22 Nov 2026 13:02:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795352566;
 b=xpoRgd+FsCO42hOH58DYni1rgUeD9KMw+baAlbj0GnogpbHJAMbxJmbw406mI6E5h2on
 k1kCXVj4Ti06T2eCu+HTnyCEclUgMMBzLSXiu1NwNw7ha8SVG+OpLlOc5pSkenl5W51lE
 awePhdvhBw+CUVRug7r8+fN3Zu4ax3WFZm1Xt4hoTDmpj0AgjPRfdiYSpv1Y7i/kzdOB6
 p0cM3t2iB+MZlgAtu9GfAGa/Hp4doOLQstcnu8FdHiRvv4uVNl3ptL+WXlwd5TgJdNQyz
 /te+Zp2moe4hmOQTLtnG3Q0FKUKJ0PcvgI77vBh0Gvufsl4IWSAgMVwUf23Gv46XhQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795352566;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received;
 bh=NuDDhu8xgfA5CdVkRU1+v7HZ41fjvkOsmke9TYmml8M=;
 b=RWlLran08nIepq6eJ2k+KvB14Q+ulUXs11xHM/6cFd0obRADjZUh1T1zQtPomDdT2Q0U
 UCEg/EoK9+gFeeHOesg9JIFkPEcwzMTjwdM6gY0uA2SUnZu/aVEqs0VpyVlmbAR+vXWTd
 ggZUw87tBGuJS2naLiWf9rvx1sBeAX0tZitEhFNrRat0HhJKcAaoBs9uMmiVgxrJ9eju0
 viqwZq4QublEBqldHdHpqtlSFNUAuN1HYQXkX57YYhLeQEnueWTYcyyOy6Rc0uUyqFrPc
 GBMKf5g3dNx2mGH5bP/bA4OkvXI6GTP9/EJk8SmevCJ0c2oh6MtA7rfTQysfvt1B7OQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 921301F000D2;
 Sun, 22 Nov 2026 13:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=korg;
 t=1795352566; bh=NuDDhu8xgfA5CdVkRU1+v7HZ41fjvkOsmke9TYmml8M=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=unTUh1lPsGCWX+fwLe8e6qomdyxssb2nTVsEa0F+Yj8xJeTHV6blHOonihBZcDpov
 xo0cmq6oGLGbTnSwYJW38YbYaiBIVkkc1a4yx3Yyu7ZNhcCAyE2U1VrCRsiTL2p+S6
 lHt7HM3clN/K3MmeB4GInfSfat/jZ6CpktGQqGi4=
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 1BFF24C05B;
 Sun, 22 Nov 2026 13:02:34 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Sun, 22 Nov 2026 20:50:23 +0800
Subject: [PATCH v7 04/10] drm/tyr: add per-file VM pool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261122-tyr-ioctls-v7-4-3a2af624b992@linux.dev>
References: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
In-Reply-To: <20261122-tyr-ioctls-v7-0-3a2af624b992@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795352551; l=6798;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=dGwY3rvD8GP4IJdrvQ0ngWSMuyfYMu3DKF9uIkJKZMU=;
 b=yB/vGJC0+m456OGwBdkfc8jJ+0lhK2hVWTnbluhpW0fHTgglRUMyIbsP7M1WEGyJTpYVbDsLD
 2NzsgQBaHTGDK8uy+uuJeywvpqfgRmL+K3oM1iHiTqpzubXnOPrAoAm
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Userspace needs multiple independent GPU address spaces per file,
addressed by ID through the VM ioctls as in panthor. Store them in an
IdPool (capped at 32 for panthor parity) plus an XArray. On failure
the caller receives the VM for teardown through the returned error,
whether the un-stored clone or the original on an ID conflict, so an
aborted creation never leaks a VM. The pool kills every VM still
stored when the file closes.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/vm.rs | 145 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b12532..e67a6efcf451b 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -11,6 +11,7 @@
 use core::ops::Range;
 
 use kernel::{
+    alloc::AllocError,
     device::{
         Bound,
         Device, //
@@ -33,6 +34,7 @@
         }, //
     },
     fmt,
+    id_pool::IdPool,
     impl_flags,
     io::PhysAddr,
     iommu::pgtable::{
@@ -41,6 +43,7 @@
         ARM64LPAES1, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     sizes::{
         SZ_1G,
@@ -53,7 +56,11 @@
         ArcBorrow,
         Mutex, //
     },
-    uapi, //
+    uapi,
+    xarray::{
+        AllocKind,
+        XArray, //
+    }, //
 };
 
 use crate::{
@@ -947,3 +954,139 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
 
     Ok(())
 }
+
+/// Maximum number of VMs a single file may hold, matching panthor's
+/// `PANTHOR_MAX_VMS_PER_FILE`.
+const MAX_VMS_PER_FILE: usize = 32;
+
+/// Per-open-file pool of VMs.
+#[pin_data(PinnedDrop)]
+pub(crate) struct VmPool<'drm> {
+    /// Parent device, for error reporting.
+    dev: &'drm Device<Bound>,
+    #[pin]
+    ids: Mutex<IdPool>,
+    #[pin]
+    vms: XArray<Arc<Vm<'drm>>>,
+}
+
+/// Error returned when a VM cannot be added to the pool. The caller
+/// owns the teardown of the VM in [`AddError::vm`].
+pub(crate) struct AddError<'drm> {
+    #[expect(dead_code)]
+    pub(crate) error: Error,
+    #[expect(dead_code)]
+    pub(crate) vm: Arc<Vm<'drm>>,
+}
+
+impl<'drm> VmPool<'drm> {
+    /// Creates a new [`VmPool`].
+    ///
+    /// The pool is sized for [`MAX_VMS_PER_FILE`] IDs on all architectures,
+    /// including 32-bit builds where `IdPool::new()` would only hold 31 IDs
+    /// because `find_unused_id(1)` skips bit 0 of an inline bitmap.
+    #[expect(dead_code)]
+    pub(crate) fn new(dev: &'drm Device<Bound>) -> Result<impl PinInit<Self>, AllocError> {
+        let ids = IdPool::with_capacity(MAX_VMS_PER_FILE + 1, GFP_KERNEL)?;
+        Ok(pin_init!(Self {
+            dev,
+            ids <- new_mutex!(ids),
+            vms <- XArray::new(AllocKind::Alloc),
+        }))
+    }
+
+    /// Stores the VM and returns the allocated ID.
+    ///
+    /// On failure - ID space exhausted or a store failure - the VM is
+    /// returned in an [`AddError`] so the caller owns the teardown.
+    // TODO: allocate IDs with the XArray directly (once it grows range
+    // allocation, the equivalent of C's `XA_LIMIT`) and drop the IdPool.
+    #[expect(dead_code)]
+    pub(crate) fn add(&self, vm: Arc<Vm<'drm>>) -> Result<u32, AddError<'drm>> {
+        let id = (|| {
+            let mut ids = self.ids.lock();
+            let unused = ids.find_unused_id(1).ok_or(ENOSPC)?;
+            if unused.as_usize() > MAX_VMS_PER_FILE {
+                return Err(ENOSPC);
+            }
+            Ok(unused.acquire())
+        })();
+        let id = match id {
+            Ok(id) => id,
+            Err(error) => return Err(AddError { error, vm }),
+        };
+
+        let mut vms = self.vms.lock();
+        match vms.store(id, vm.clone(), GFP_KERNEL) {
+            Ok(prev_vm) => {
+                if let Some(prev_vm) = prev_vm {
+                    // An existing VM at the freshly allocated slot means the
+                    // IdPool and the XArray are out of sync: the stored VM is
+                    // a pool entry, so the pool kills it and the caller's VM
+                    // is returned for teardown.
+                    drop(vms.remove(id));
+                    drop(vms);
+                    prev_vm.kill();
+                    self.ids.lock().release_id(id);
+                    dev_err!(
+                        self.dev,
+                        "IdPool/XArray out of sync at VM pool id {id} (stored VM conflict)"
+                    );
+                    return Err(AddError { error: EBUSY, vm });
+                }
+                Ok(id as u32)
+            }
+            Err(err) => {
+                // Drop the XArray spinlock before acquiring the `ids` mutex.
+                drop(vms);
+                // Release the pooled id; the VM never entered the pool, so it
+                // is returned to the caller for teardown.
+                self.ids.lock().release_id(id);
+                Err(AddError {
+                    error: err.error,
+                    vm: err.value,
+                })
+            }
+        }
+    }
+
+    /// Removes and kills the VM with the given ID.
+    #[expect(dead_code)]
+    pub(crate) fn remove(&self, id: u32) -> Result<()> {
+        let mut vms = self.vms.lock();
+        let vm = match vms.remove(usize::from_safe_cast(id)) {
+            Some(vm) => vm,
+            None => return Err(EINVAL),
+        };
+        // Drop the XArray spinlock before killing, since `kill()` may sleep.
+        drop(vms);
+        // Kill the VM before handing the id back to the pool, so a VM is
+        // never reusable while still alive.
+        vm.kill();
+        self.ids.lock().release_id(usize::from_safe_cast(id));
+        Ok(())
+    }
+
+    /// Gets a shared reference to the VM with the given ID.
+    #[expect(dead_code)]
+    pub(crate) fn get(&self, id: u32) -> Option<Arc<Vm<'drm>>> {
+        let vms = self.vms.lock();
+        let borrow = vms.get(usize::from_safe_cast(id))?;
+        Some(Arc::from(borrow))
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for VmPool<'_> {
+    fn drop(self: Pin<&mut Self>) {
+        // Kill every VM left in the pool. The ID range is bounded by
+        // `MAX_VMS_PER_FILE`, so this loop is cheap and runs at file close.
+        for id in 1..=MAX_VMS_PER_FILE {
+            // Release the XArray lock guard before killing: `kill()` may sleep.
+            let vm = self.vms.lock().remove(id);
+            if let Some(vm) = vm {
+                vm.kill();
+            }
+        }
+    }
+}

-- 
2.43.0


