Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C88C61DD3
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:08:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D66DC10E3EC;
	Thu,  3 Sep 2026 15:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GwobO+Us";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD45110E3EC
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:08:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B9CC060546;
 Thu,  3 Sep 2026 15:08:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953AA1F00A3A;
 Thu,  3 Sep 2026 15:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788448080;
 bh=4qmYNKLvmK56Y3vExZhL5LncOr+j7eNZrKKmYJsXYNE=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=GwobO+UsGz08X5+CX/F/wgchM6dWjckrK7hRPiukogUSoSOraKrwEQ023cSteyd15
 uGLnrA8WETQlR+nrq6PD2oVwUadiUfNb1gdmgpvNAtTKjweXNhKEtAiLN1etIMGsBa
 0iiPjXXslAV0gGRb0xXiau9pCUVVHDUpLKl8XRmjNHHtowSwcxrURwoehCWUj3035y
 vp643ZLZZcIVJcGSOZNHSa9hrzP4PQQ7piqzHSyzNkSwUPMxKu241C6JiX/Ec0vZMX
 QDmVkZFbWhmFjahUmSfPEb7UzStGl+jBELTX6MbbymVdVPhtHh74Jz+i70IiIqIFiz
 NGcrgShWLLf5A==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 17:07:55 +0200
Message-Id: <DL5RXJCC43FY.CACM7A2UNBCI@kernel.org>
Subject: Re: [PATCH 1/4] rust: debugfs: drop 'static bound from ScopedDir
 file creation methods
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <mmaurer@google.com>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-2-dakr@kernel.org>
 <DL5PH2S8AP7E.25CW1PZIQ8BM3@garyguo.net>
In-Reply-To: <DL5PH2S8AP7E.25CW1PZIQ8BM3@garyguo.net>
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

On Thu Sep 3, 2026 at 3:12 PM CEST, Gary Guo wrote:
> This can be better done by storing `&'static bindings::file_operations` i=
n
> `FileOps<T>` instead of just by value. That is actually better than the c=
urrent
> impl, IMO, because `mode` for example doesn't have to be in static storag=
e. (You
> can also then make `FileOps<T>` `Copy`).

That's a great suggestion, thanks. It simplifies the patch to:

Author: Danilo Krummrich <dakr@kernel.org>
Date:   Sat Aug 29 14:42:54 2026 +0200

    rust: debugfs: drop 'static bound from ScopedDir file creation methods

    Drop the T: 'static bound from ScopedDir's file creation methods
    (read_binary_file(), read_only_file(), etc.) to support registering
    debugfs files backed by types that contain non-'static references, such
    as dma::Coherent<'a, T>.

    The previous 'static bound existed because ScopedDir::create_file() too=
k
    &'static FileOps<T>, and &'static requires T: 'static for well-
    formedness. However, this was overly conservative: the file_operations
    pointer passed to the C debugfs API just needs to be 'static, not the
    entire FileOps<T>.

    Store &'static bindings::file_operations in FileOps<T> instead of the
    file_operations by value. In each trait impl, take a reference to the
    file_operations struct within the const block; since
    bindings::file_operations does not mention T, the reference is promoted
    to 'static regardless of T's lifetime parameters.

    Replace the Deref impl with an explicit fops() method that returns the
    stored &'static reference.

    Signed-off-by: Danilo Krummrich <dakr@kernel.org>

diff --git a/rust/kernel/debugfs.rs b/rust/kernel/debugfs.rs
index d7b8014a6474..2beb55d444ca 100644
--- a/rust/kernel/debugfs.rs
+++ b/rust/kernel/debugfs.rs
@@ -538,7 +538,7 @@ pub fn dir<'dir2>(&'dir2 self, name: &CStr) -> ScopedDi=
r<'data, 'dir2> {
         }
     }

-    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: &'=
static FileOps<T>) {
+    fn create_file<T: Sync>(&self, name: &CStr, data: &'data T, vtable: &F=
ileOps<T>) {
         #[cfg(CONFIG_DEBUG_FS)]
         core::mem::forget(Entry::file(name, &self.entry, data, vtable));
     }
@@ -550,7 +550,7 @@ fn create_file<T: Sync>(&self, name: &CStr, data: &'dat=
a T, vtable: &'static Fil
     /// This function does not produce an owning handle to the file. The c=
reated
     /// file is removed when the [`Scope`] that this directory belongs
     /// to is dropped.
-    pub fn read_only_file<T: Writer + Send + Sync + 'static>(&self, name: =
&CStr, data: &'data T) {
+    pub fn read_only_file<T: Writer + Send + Sync>(&self, name: &CStr, dat=
a: &'data T) {
         self.create_file(name, data, &T::FILE_OPS)
     }

@@ -560,11 +560,7 @@ pub fn read_only_file<T: Writer + Send + Sync + 'stati=
c>(&self, name: &CStr, dat
     ///
     /// This function does not produce an owning handle to the file. The c=
reated file is removed
     /// when the [`Scope`] that this directory belongs to is dropped.
-    pub fn read_binary_file<T: BinaryWriter + Send + Sync + 'static>(
-        &self,
-        name: &CStr,
-        data: &'data T,
-    ) {
+    pub fn read_binary_file<T: BinaryWriter + Send + Sync>(&self, name: &C=
Str, data: &'data T) {
         self.create_file(name, data, &T::FILE_OPS)
     }

@@ -596,11 +592,7 @@ pub fn read_callback_file<T, F>(&self, name: &CStr, da=
ta: &'data T, _f: &'static
     /// This function does not produce an owning handle to the file. The c=
reated
     /// file is removed when the [`Scope`] that this directory belongs
     /// to is dropped.
-    pub fn read_write_file<T: Writer + Reader + Send + Sync + 'static>(
-        &self,
-        name: &CStr,
-        data: &'data T,
-    ) {
+    pub fn read_write_file<T: Writer + Reader + Send + Sync>(&self, name: =
&CStr, data: &'data T) {
         let vtable =3D &<T as ReadWriteFile<_>>::FILE_OPS;
         self.create_file(name, data, vtable)
     }
@@ -612,7 +604,7 @@ pub fn read_write_file<T: Writer + Reader + Send + Sync=
 + 'static>(
     ///
     /// This function does not produce an owning handle to the file. The c=
reated file is removed
     /// when the [`Scope`] that this directory belongs to is dropped.
-    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + =
Sync + 'static>(
+    pub fn read_write_binary_file<T: BinaryWriter + BinaryReader + Send + =
Sync>(
         &self,
         name: &CStr,
         data: &'data T,
@@ -655,7 +647,7 @@ pub fn read_write_callback_file<T, F, W>(
     /// This function does not produce an owning handle to the file. The c=
reated
     /// file is removed when the [`Scope`] that this directory belongs
     /// to is dropped.
-    pub fn write_only_file<T: Reader + Send + Sync + 'static>(&self, name:=
 &CStr, data: &'data T) {
+    pub fn write_only_file<T: Reader + Send + Sync>(&self, name: &CStr, da=
ta: &'data T) {
         let vtable =3D &<T as WriteFile<_>>::FILE_OPS;
         self.create_file(name, data, vtable)
     }
@@ -666,11 +658,7 @@ pub fn write_only_file<T: Reader + Send + Sync + 'stat=
ic>(&self, name: &CStr, da
     ///
     /// This function does not produce an owning handle to the file. The c=
reated file is removed
     /// when the [`Scope`] that this directory belongs to is dropped.
-    pub fn write_binary_file<T: BinaryReader + Send + Sync + 'static>(
-        &self,
-        name: &CStr,
-        data: &'data T,
-    ) {
+    pub fn write_binary_file<T: BinaryReader + Send + Sync>(&self, name: &=
CStr, data: &'data T) {
         self.create_file(name, data, &T::FILE_OPS)
     }

diff --git a/rust/kernel/debugfs/entry.rs b/rust/kernel/debugfs/entry.rs
index 46aad64896ec..88a870d8c295 100644
--- a/rust/kernel/debugfs/entry.rs
+++ b/rust/kernel/debugfs/entry.rs
@@ -74,7 +74,7 @@ pub(crate) unsafe fn dynamic_file<T>(
                 parent.as_ptr(),
                 core::ptr::from_ref(data) as *mut c_void,
                 core::ptr::null(),
-                &**file_ops,
+                file_ops.fops(),
             )
         };

@@ -127,7 +127,7 @@ pub(crate) fn file<T>(
                 parent.as_ptr(),
                 core::ptr::from_ref(data) as *mut c_void,
                 core::ptr::null(),
-                &**file_ops,
+                file_ops.fops(),
             )
         };

diff --git a/rust/kernel/debugfs/file_ops.rs b/rust/kernel/debugfs/file_ops=
.rs
index f15908f71c4a..5c16a3196ca2 100644
--- a/rust/kernel/debugfs/file_ops.rs
+++ b/rust/kernel/debugfs/file_ops.rs
@@ -20,9 +20,6 @@

 use core::marker::PhantomData;

-#[cfg(CONFIG_DEBUG_FS)]
-use core::ops::Deref;
-
 /// # Invariant
 ///
 /// `FileOps<T>` will always contain an `operations` which is safe to use =
for a file backed
@@ -30,7 +27,7 @@
 /// into a reference.
 pub(super) struct FileOps<T> {
     #[cfg(CONFIG_DEBUG_FS)]
-    operations: bindings::file_operations,
+    operations: &'static bindings::file_operations,
     #[cfg(CONFIG_DEBUG_FS)]
     mode: u16,
     _phantom: PhantomData<T>,
@@ -41,7 +38,7 @@ impl<T> FileOps<T> {
     ///
     /// The caller asserts that the provided `operations` is safe to use f=
or a file whose
     /// inode has a pointer to `T` in its private data that is safe to con=
vert into a reference.
-    const unsafe fn new(operations: bindings::file_operations, mode: u16) =
-> Self {
+    const unsafe fn new(operations: &'static bindings::file_operations, mo=
de: u16) -> Self {
         Self {
             #[cfg(CONFIG_DEBUG_FS)]
             operations,
@@ -65,11 +62,11 @@ pub(super) const fn adapt(&self) -> &FileOps<T::Inner> =
{
 }

 #[cfg(CONFIG_DEBUG_FS)]
-impl<T> Deref for FileOps<T> {
-    type Target =3D bindings::file_operations;
-
-    fn deref(&self) -> &Self::Target {
-        &self.operations
+impl<T> FileOps<T> {
+    /// Returns a `'static` reference to the inner `file_operations`.
+    #[inline]
+    pub(crate) fn fops(&self) -> &'static bindings::file_operations {
+        self.operations
     }
 }

@@ -130,11 +127,11 @@ pub(crate) trait ReadFile<T> {

 impl<T: Writer + Sync> ReadFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             read: Some(bindings::seq_read),
             llseek: Some(bindings::seq_lseek),
             release: Some(bindings::single_release),
-            open: Some(writer_open::<Self>),
+            open: Some(writer_open::<T>),
             ..pin_init::zeroed()
         };
         // SAFETY: `operations` is all stock `seq_file` implementations ex=
cept for `writer_open`.
@@ -181,7 +178,7 @@ pub(crate) trait ReadWriteFile<T> {

 impl<T: Writer + Reader + Sync> ReadWriteFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             open: Some(writer_open::<T>),
             read: Some(bindings::seq_read),
             write: Some(write::<T>),
@@ -238,7 +235,7 @@ pub(crate) trait WriteFile<T> {

 impl<T: Reader + Sync> WriteFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             open: Some(write_only_open),
             write: Some(write_only_write::<T>),
             llseek: Some(bindings::noop_llseek),
@@ -290,7 +287,7 @@ pub(crate) trait BinaryReadFile<T> {

 impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             read: Some(blob_read::<T>),
             llseek: Some(bindings::default_llseek),
             open: Some(bindings::simple_open),
@@ -344,7 +341,7 @@ pub(crate) trait BinaryWriteFile<T> {

 impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             write: Some(blob_write::<T>),
             llseek: Some(bindings::default_llseek),
             open: Some(bindings::simple_open),
@@ -368,7 +365,7 @@ pub(crate) trait BinaryReadWriteFile<T> {

 impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for T {
     const FILE_OPS: FileOps<T> =3D {
-        let operations =3D bindings::file_operations {
+        let operations =3D &bindings::file_operations {
             read: Some(blob_read::<T>),
             write: Some(blob_write::<T>),
             llseek: Some(bindings::default_llseek),
