Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BD606A323
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 00:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dR90L945
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06FD310E1E3;
	Mon,  9 Nov 2026 00:37:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A39010E1C5
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 00:37:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5EF8B43E78;
 Mon,  9 Nov 2026 00:37:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794184624;
 b=gv4ZmkeJAcdJOnZwHDsXrbxCold8hJOtr6cRBYDGDg+ZzPhNvZXhaOVIGSoqFJPH/ogz
 N3SdPqI/mSB0gLMT1jIcpdsc+dqdgTUjqMomgUBT6sVxKW4psGToMbnO7ngJfGH0U7hXI
 jTNv8isbLyiCqltLrcIaDf2e6XJ8yRsyjci+aDKtIbhrzglAjQKPDbjkC0yoJNFMct/IZ
 KPBNGcJToPdO7kJKBAQoNidBm9+ucv9SfdEi4Oimb2sypPJMCpCPGWGgR9YNbzwQPW1+R
 6Gbv6MwlEcgMjy+G1fMkkQgrt+au4t3+W4/A0TdkdbJ3QNGzgqqoMn8QGEdBQQUmNKQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794184624;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=yNtRNkBdxpQt6jw/UfG6Xg0klekmqsGOVL0iY18jIkM=;
 b=RaD2hORmTQvjdWXLXqD/gVaS/1CCg+z63xGzREKdFIc68TejeSW0c96hLv4L0h2+CySI
 lUILgaRyTiy4zJo3tw7FPjdF2StPDfPQENnm9FHekB4rNJCJ7Mmm0hnCZOOkmnu2m6YFK
 O8ioyB2GsSu+3a+Aq9Hn5x3ZYzSsdr3KiY6f5M7hXB4B9IRPgoHBXkyYOu+4XORfRepgb
 aOYhtfKjvgHA29phs62eivp1yypgMGAwzIrq4PBJc16ugLTnOgM3i0CTnfy0v0VAwZwz5
 M7beyMBUP0gMaBIRN4In/pFs1pqcGLRAesxZcOtCwXSXB/JzCuR+eViOoXBRMfrwDxw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id BE0381F008A4;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794184624;
 bh=yNtRNkBdxpQt6jw/UfG6Xg0klekmqsGOVL0iY18jIkM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=dR90L945fJErJmlbhMUMKygnW0L6I432rC6ILoGRRmg0+rsK2RrFhUMZ8tYbXDuI3
 SjsureLoSBwnHQfOJYVFekss+ogNkbWCjmoem0ph/n3wSIjbq0gP204lCuGfUdIiUk
 vO2n6xrZ2AfmqA01cvJ5I2ARbAvG48dstJYoj2ezjfMqYr+n89yveZu5wR/CE55scr
 isA8+iArV+0go2FlG+zbELOhJZRRDBsey51EWNh/ak1+cHXE2mupAYvrUn5aLAvRpt
 +4QBA3w5Xg+jaWpC00+oMJjYTxoByD/CzQShJw1iTQYZ054C096eJUDi6vnWg+rnfC
 GZR/L2Kp3TS4w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 47723481B1;
 Mon,  9 Nov 2026 00:37:02 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Mon, 09 Nov 2026 08:36:47 +0800
Subject: [PATCH v6 04/10] drm/tyr: add per-file VM pool
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-tyr-ioctls-v6-4-b2896bf2b3c9@kylinos.cn>
References: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
In-Reply-To: <20261109-tyr-ioctls-v6-0-b2896bf2b3c9@kylinos.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184620; l=6351;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=CS+VEPFg10Riae4OhToklyNt8xVJMBpKZlDDyzmV+jU=;
 b=NB5Ah7syJQp/7ze5P8p4dFXCwfIro926fxVzetZO4VdTfAJe55G4F/+MZcpPiDQrDsg8d8Rnw
 Bntc2oLUsksA8zoXEFtH3v+OoJc/l7AyIexvOWk/di+4eDUF+y0CZTf
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Alvin Sun <alvin.sun@linux.dev>

Userspace needs multiple independent GPU address spaces per file,
addressed by ID through the VM ioctls as in panthor. Store them in an
IdPool (capped at 32 for panthor parity) plus an XArray. On failure
the caller receives the VM for teardown through the returned error,
whether the un-stored clone or the original on an ID conflict, so an
aborted creation never leaks a VM. The pool kills every VM still
stored when the file closes.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/vm.rs | 140 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 139 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tyr/vm.rs b/drivers/gpu/drm/tyr/vm.rs
index 1dd11b2b12532..6f5518652a03f 100644
--- a/drivers/gpu/drm/tyr/vm.rs
+++ b/drivers/gpu/drm/tyr/vm.rs
@@ -33,6 +33,7 @@
         }, //
     },
     fmt,
+    id_pool::IdPool,
     impl_flags,
     io::PhysAddr,
     iommu::pgtable::{
@@ -41,6 +42,7 @@
         ARM64LPAES1, //
     },
     new_mutex,
+    num::casts::FromSafeCast,
     prelude::*,
     sizes::{
         SZ_1G,
@@ -53,7 +55,11 @@
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
@@ -947,3 +953,135 @@ fn pt_unmap(dev: &Device, pt: &IoPageTable<'_, ARM64LPAES1>, range: Range<u64>)
 
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
+    #[expect(dead_code)]
+    pub(crate) fn new(dev: &'drm Device<Bound>) -> impl PinInit<Self> {
+        let ids = IdPool::new();
+        pin_init!(Self {
+            dev,
+            ids <- new_mutex!(ids),
+            vms <- XArray::new(AllocKind::Alloc),
+        })
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


