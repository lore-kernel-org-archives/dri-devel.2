Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF66FF8855
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 13:51:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDF2C10E2D8;
	Wed,  6 May 2026 13:51:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="mrAziuRy";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013014.outbound.protection.outlook.com
 [40.93.201.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF6C810E2D8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:51:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=icsmY13as4CoKY8Rdhs3hOaLWzMgyPuWp7Lj0sVoYhvCOhApuS2AGSGDKov28T5QfomZtjDIqn5sC8FJ7HL9yIMTQpfAmnT6vRcyXKc7l0b6ivSldrn0QIFyxjcKY64x66uhLdtOV/RrYgmGDWkah+h8GKxoWa4SvXqaJKq7x+P+aJ1UbSLExzLol/sR5DMFFdmU/UL4wdFySpdCQGBnLgkGBJ9Ehsipe9/s36LAwlCoS36CEJH7O3JUiUsBS7Ej3O2FG6bn0T5bFSe9eZyH0kAuny+tSsyEKEQgvLasNXcb/88MAnVXVaYHL/XlMnSxE39g9w0dw1Ey2RHbP9OIEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PW2rGiAwxUIaD5Mt4anare4h5nw4+bdhoXz+xDBsK78=;
 b=iUxy/5pMVOzkrhIXvp/FKUGcRtgRA0zmQbKmZQr1B+ORIUSkUbYOAcES+fMdcBvuyuGCvoEw14fza+vcBlk+I2YTvPXWl7RPpC5ASUbbTlpBINRpzbz/uV65VPV4A+Kk8yT4El/LQg0Kb7JHhAqDycb0P1BwOp1+YI+qXweTgI4qBpbJ5TYTtvlPnJOLhxK2PBHjn3dYQUHslYkUgu26Ob/AwXUL8XX5LjJJDIeUYzeCBA0CXrHzGkDGOPBVBFeLBECgaLk738Z2IufsqR8IAAIHFRU9Np4e4UcnzD5el1Vr5fhVdVDRs0QNGJ/U+vKpvGUBtz67VVWnaJ4W7eEqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PW2rGiAwxUIaD5Mt4anare4h5nw4+bdhoXz+xDBsK78=;
 b=mrAziuRyZJ+RZoTWsjC8VschKG1nwQdDnpOn+cDHMKVQvuRqU91/lyKGVhY1JJ0HvlTYqSLaHn4vJk6zL/HM9uDiyL9YKQvu1T6IaxW7rc5Bm8LydEhXRC1GNkAG53NCwstJ9kyNCWQ3BQxBtiQqs0uontJD2YnbZq/n4UNyUjOaPZ040/KkqE1Ok0WwxvsrDIPCSPymAsoGzxgGn17h6jP/S1qgmQB4fNkXL5o+FWeDNTQl0f9CA37/4e7o98J56BqveNjXTNsGTRnR1YNHUpnKhBUdJXurjvaSAnkwri4pE885vFHQi+7zYc/n1m3Xb0lei1dNAbrlwcOC9tfmTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 IA1PR12MB6305.namprd12.prod.outlook.com (2603:10b6:208:3e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 13:51:24 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 13:51:23 +0000
Date: Wed, 6 May 2026 09:51:22 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: linux-kernel@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev, Nikola Djukic <ndjukic@nvidia.com>,
 David Airlie <airlied@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 John Hubbard <jhubbard@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Philipp Stanner <phasta@kernel.org>, alexeyi@nvidia.com,
 Eliot Courtney <ecourtney@nvidia.com>, joel@joelfernandes.org,
 linux-doc@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v2] rust: maple_tree: implement Send and Sync for MapleTree
Message-ID: <20260506135122.GA1432412@joelbox2>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: CY5PR13CA0042.namprd13.prod.outlook.com
 (2603:10b6:930:11::10) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|IA1PR12MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa6d29d-bda4-48d5-bff2-08deab768f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: kB8U5C1rf+gKEScvxM/EN83stdPUd+uWpBZ4dvXmJY88uhzHVKiUafGxhObnnBA1QSY76xxP+kP1fp0wBhdnXCmbe2ElInmBmErAkqq/eAHZsPcCNliHeyWnjCTbg47FkIRO3ulbNcxMDCInWXbdMPYPdZpg54ys47AGcIbkVOV9B+NCLDmTyiCwIbFalaFsjgTyGFjjTwcwyCZ3t4wE+fBp+Dbb5fxVmIbbJUoa5x5xExK5KmQqFVevQDIbmV0avm1I5Y3IDtcI7Lrj2Hh732iQF+DLp8cV7+fTcuEtX6bQFWrngHvCYlx4g0BGvXZoO2ITayID2bL4yk5hRPE7R/DcakC9+c+4W33CFEq0H+0IlNd/9s23mcU6hN44xf4PvW9Ob2aWxXtFueiTQTz6lTlWLfNXqVwjbGQYPZOYy/8XLq8uO/YJFtuCMKJ3GJDooNODOQVGE/v3aP38cqGDI3iwhG10WSdWzEHMbatvJsDP0+eTBcCpxg0JgqGxJQdDyDzmwI8/qgq45dvNCWuZkOtlcg7OxF49q7cz9w2fIIb3Za77hMu5OIZekKrqAdPvhRum3z84uDZy4EOk2wpaN8QY0QWU3YPtBl0BvxjrMNsZzLa6bCUtiCXD6KLIpTka9GTBz0fzPb9XpTKm4gimflW3rUbr6IbpmZZnbi4PJkxmt6tIRKxPsVhlMyaPgzzKgt8prPEzgShzbX5XJlPtHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?az8hlSf3RxIPnhIuPEvmKimSWm5D5KM6vbfZQwgumKO89I/hzpbMhRSktPdO?=
 =?us-ascii?Q?et1orRqW4qUXwrfomSM1NbM9smVn2wPhcPJ1zpfZCpYqctIjzjHqQwLSAAH7?=
 =?us-ascii?Q?XR24qJVOUbK1+ik2lvkFp4uL3wxxoXO9HXtfhnHgJtuTqLuYHvxF4FMFS356?=
 =?us-ascii?Q?8/JtTjUMX4DhQVSPZL2VFuZJaLNyhLDvMTuhfaWsSZs/LPmDbKK9vPi5ou7r?=
 =?us-ascii?Q?8Uz8xVqKPj9q6e08kx4A9PaVz2T2civjLHeA14Dbf0uKwb5M19j1BMGyRj0w?=
 =?us-ascii?Q?ZURANCze53NwoW9FJcvM/oya+MmHDc0yjJRQIjy5Zd2ZPWxd9NJFO1NSjQNG?=
 =?us-ascii?Q?s68/4Arr9X7elTyhOYISF88eCrL+aYq/5rdUMF6E20cLi5ieLT2tVMGTm044?=
 =?us-ascii?Q?RsD8FZkbxYdffGXnWWtijAVSrTSdycFwMyRxwMwv2x/EdP1EcouZaYz1r+i7?=
 =?us-ascii?Q?DwcQmWfP3bKnK9vpBlNzTGZ8pAYTAVzO45ENwB1mPzZM9QJc64wMwa6oCeNU?=
 =?us-ascii?Q?fOcKCvEZAMZmBnbymQ3ssGMgubDgjeSFUsOzvkbqKJRhe8+hu2AwaR6wfOQw?=
 =?us-ascii?Q?7DI6nVFd2iFNKf+HPNfd2UHGaiVH74goxWz38DXZqghutKo8paxt9110m0PA?=
 =?us-ascii?Q?gkEfZDE+eSOK1JfAUhBWtpsM1XNpX48NSkEyIqwOeW9s/6Y+7Er+pIehORyh?=
 =?us-ascii?Q?3i0UmEhIuq3FzV0GFYcfu9pi02wp7mMj//tYkBGEbCIrlJcGsiNK34vpa0jj?=
 =?us-ascii?Q?IS4gdy5yVIip1RvjGCB3qZBvg/3K/aky7KAFtr5RLGHvRJ0KtH6GGbwNXsrV?=
 =?us-ascii?Q?OflX5mqtpl/M9H835Zsh07G/RdULh5pxJLLJ1EMxhsaiZp4Pk1o+hyxJcuhJ?=
 =?us-ascii?Q?mZXtRPRFN/wNGoa0poWyNUt+FZVb2DkPz4YCGloj/CBCdNIu57JttgF1fQwE?=
 =?us-ascii?Q?BrILB6+Zzv0AdlKN+vWYWsVFYqfZAxYOB0O7FGNzuox6uc0XOt+GmFRUDvu4?=
 =?us-ascii?Q?v9+l4aP0MHleIA6gJJgxLD2gh3bgj9cGFQQD6s47A2WhK+WjZRfUSOkFRC8n?=
 =?us-ascii?Q?uYzQz3ZXPRsYaGD41yD1qvLX79efipMyPEqcbJrbvjk967DgkSXgCC8hMKmg?=
 =?us-ascii?Q?k8vPQbB3IYY6hrqtyLMLT/AuIcromtCTbRAdB91R7DzTnzpyTqax7mMhRYN3?=
 =?us-ascii?Q?WFBDd9IDnhM1wfQ+VeBRTO8nns1VdVkSqHeSR//M2JF2VKOmcB2ZQ05ELYw1?=
 =?us-ascii?Q?PgdmWHmgTkXE2X3qHXX0ycQzPVYt/n2PWp4qx07PPAowMidLzINx2H+kaWwx?=
 =?us-ascii?Q?Q0KeGWCifhX7pPWcBQ+mQ/6pQxVerYioATgB9OCjSaZ3E9Xfrc51BQ2Mqf4R?=
 =?us-ascii?Q?XBwiHDx3tzEq1hxoVAF3HTp2Pdtaxad+RiHq6Pd3bG1Fz+Bt6NvYs40p+2hN?=
 =?us-ascii?Q?oM+c49jlt+R1xzxieijXXgZiOkREGtEfhO78eR3b7I52ZaRfbBB0MltTFi1W?=
 =?us-ascii?Q?Jb1raX+Egn+eka/VCper/B+iDUicO8T5sXubobIS/Hd+8FbN7lcxz+Qx41KG?=
 =?us-ascii?Q?obrECffmdPc41I7rSlOe5i+H/BWi59xqY8vqakIx3JdNSDPOFaP4I7Ou5Ion?=
 =?us-ascii?Q?o7oSmJvl6rRU3IBvnocIt8NVd7IKNQA1SAVX2SMilLochNputER/jCsIG6ah?=
 =?us-ascii?Q?hWWxanj2RoJVJDSX51R3Gn0l7JFKHwlJsYKq3m6d6Fo9u2AH5UElv9Pzi++O?=
 =?us-ascii?Q?rYzWKKoGgg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa6d29d-bda4-48d5-bff2-08deab768f8e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2026 13:51:23.8013 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Y1uQv8LGpYfitFsCH3eV6w1aaphpQjxutWzDt3fHMj3eMGw5ieGpl+ZOr+HRF80NqnrBxp7qUlrizGbsC9Pcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6305
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

The C maple_tree struct contains a *mut c_void, which prevents Rust from
auto-deriving Send/Sync. Following is an example error message when using
MapleTree in nova-core's Vmm.

This propagates up through MapleTreeAlloc to Vmm, BarUser, Gpu, and NovaCore,
causing NovaCore to fail the Send bound required by pci::Driver:

  error[E0277]: `*mut c_void` cannot be sent between threads safely
      --> drivers/gpu/nova-core/driver.rs:77:22
       |
  77   | impl pci::Driver for NovaCore {
       |                      ^^^^^^^^ `*mut c_void` cannot be sent between threads safely
       |
       = help: within `MapleTreeAlloc<()>`, the trait `Send` is not implemented for `*mut c_void`
  note: required because it appears within the type `kernel::bindings::maple_tree`
  note: required because it appears within the type `Opaque<kernel::bindings::maple_tree>`
  note: required because it appears within the type `MapleTree<()>`
  note: required because it appears within the type `MapleTreeAlloc<()>`
       = note: required for `Box<MapleTreeAlloc<()>, Kmalloc>` to implement `Send`
  note: required because it appears within the type `core::pin::Pin<Box<MapleTreeAlloc<()>, Kmalloc>>`
  note: required because it appears within the type `Vmm`
  note: required because it appears within the type `BarUser`
  note: required because it appears within the type `Gpu`
  note: required because it appears within the type `NovaCore`
  note: required by a bound in `kernel::pci::Driver`
      --> rust/kernel/pci.rs:294:19

Implement Send and Sync for MapleTree. The tree contains no thread-local
state, and all shared access goes through the internal ma_lock spinlock.

Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
---
RFC->v2: Just adjusted a few comments as suggested by Gary.

Sending this separately as discussed in the nova mm patch series that needs it:
https://lore.kernel.org/all/252a4eef-f4f4-4edf-8154-06cae4ad8518@nvidia.com/

 rust/kernel/maple_tree.rs | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/rust/kernel/maple_tree.rs b/rust/kernel/maple_tree.rs
index 265d6396a78a..2400c905270d 100644
--- a/rust/kernel/maple_tree.rs
+++ b/rust/kernel/maple_tree.rs
@@ -16,7 +16,11 @@
     alloc::Flags,
     error::to_result,
     prelude::*,
-    types::{ForeignOwnable, Opaque},
+    types::{
+        ForeignOwnable,
+        NotThreadSafe,
+        Opaque, //
+    },
 };
 
 /// A maple tree optimized for storing non-overlapping ranges.
@@ -240,7 +244,10 @@ pub fn lock(&self) -> MapleGuard<'_, T> {
         unsafe { bindings::spin_lock(self.ma_lock()) };
 
         // INVARIANT: We just took the spinlock.
-        MapleGuard(self)
+        MapleGuard {
+            tree: self,
+            _not_send: NotThreadSafe,
+        }
     }
 
     #[inline]
@@ -302,19 +309,29 @@ fn drop(mut self: Pin<&mut Self>) {
     }
 }
 
+// SAFETY: `MapleTree<T>` is `Send` if `T` is `Send` because `MapleTree` owns its elements.
+unsafe impl<T: ForeignOwnable + Send> Send for MapleTree<T> {}
+// SAFETY: `&MapleTree<T>` never hands out `&T`; all entry access is serialized
+// by `ma_lock` or `&mut Guard`, so `T: Send` suffices (`T: Sync` not required).
+unsafe impl<T: ForeignOwnable + Send> Sync for MapleTree<T> {}
+
 /// A reference to a [`MapleTree`] that owns the inner lock.
 ///
 /// # Invariants
 ///
 /// This guard owns the inner spinlock.
 #[must_use = "if unused, the lock will be immediately unlocked"]
-pub struct MapleGuard<'tree, T: ForeignOwnable>(&'tree MapleTree<T>);
+pub struct MapleGuard<'tree, T: ForeignOwnable> {
+    tree: &'tree MapleTree<T>,
+    // A held spinlock must be released on the same CPU that acquired it.
+    _not_send: NotThreadSafe,
+}
 
 impl<'tree, T: ForeignOwnable> Drop for MapleGuard<'tree, T> {
     #[inline]
     fn drop(&mut self) {
         // SAFETY: By the type invariants, we hold this spinlock.
-        unsafe { bindings::spin_unlock(self.0.ma_lock()) };
+        unsafe { bindings::spin_unlock(self.tree.ma_lock()) };
     }
 }
 
@@ -323,7 +340,7 @@ impl<'tree, T: ForeignOwnable> MapleGuard<'tree, T> {
     pub fn ma_state(&mut self, first: usize, end: usize) -> MaState<'_, T> {
         // SAFETY: The `MaState` borrows this `MapleGuard`, so it can also borrow the `MapleGuard`s
         // read/write permissions to the maple tree.
-        unsafe { MaState::new_raw(self.0, first, end) }
+        unsafe { MaState::new_raw(self.tree, first, end) }
     }
 
     /// Load the value at the given index.
@@ -375,7 +392,7 @@ pub fn ma_state(&mut self, first: usize, end: usize) -> MaState<'_, T> {
     #[inline]
     pub fn load(&mut self, index: usize) -> Option<T::BorrowedMut<'_>> {
         // SAFETY: `self.tree` contains a valid maple tree.
-        let ret = unsafe { bindings::mtree_load(self.0.tree.get(), index) };
+        let ret = unsafe { bindings::mtree_load(self.tree.tree.get(), index) };
         if ret.is_null() {
             return None;
         }
-- 
2.34.1

