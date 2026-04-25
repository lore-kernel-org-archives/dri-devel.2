Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8A2FF8863
	for <dri-devel@archiver.kernel.org>; Sat, 25 Apr 2026 21:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD16010E498;
	Sat, 25 Apr 2026 21:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DfL1dTuk";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E2DE10E48C
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 21:16:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVoqxPAQN6j1PDd7GvRYKJQaicHkxyk6J+h4uEMUq9Q/Y7lmXyCkNw8UhjXxhgAaiG0+nInI8DDsOTmUcltUprTriI7u+wqf/L7RpuUE7qtWeirdAaFqPSmYrkNP5WQM4v65eHK5G9a114SVcMsYU1lLLzyiWV+jKNVR7C7SQPSx6iUHk8J50qr4/Ntv9auOUNvs8+Zz4Ks0tKBtMd+6kFdk1dABy+VX9J9U15sIspgfOxW/ZDKMp/VCVFC77b/lXeRTkX7Be0PUO5gmzXtlf8MvNgo4PDtNK9Rd4cS2UEwmmNB21dvrzgI3W3APeNcrI5OtvdMfWF4Gk3t0uj7Y7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgB+8CVQb1tcL3+Yv52GQLOqWFAEjP6h+ej6wl7Ydvg=;
 b=gMx4HvIZuchZ7RwchMZgEsBrEYjx/k8v2YoPCZ5yc+i2/YtWMNto/L1JdJpsMbWqL6sLKiZBuiKDi2AxFdi07Wv060kQtktrRH1kp7TY7D7tH62Zgdy0Z21u42ZH3HJdLyZqv/DsE2kz4Y249RjScflnAQ1JvTtd2SVVC+6hXvKklnZJGPQVFScSeWd6+4Kob3z7K87VyMPkrMw9p1f4MzP8RBfsDtnyF6JqGKF3p0qfKL2104SejTJIiC9CnHU2+gq+y80wm/LKnZylP1lhzLdjOWpQFgje4YCSJskTd8nOd4+zzOLOod8HRy8AW0B6eFxPQ4YTyUtC3EJrGIJ/HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgB+8CVQb1tcL3+Yv52GQLOqWFAEjP6h+ej6wl7Ydvg=;
 b=DfL1dTukzDsaOS1cEQxyAlQpIsT1gTMYK6iZpoCZT+9+kTBvL2jarFrnqBr5QzPhS2kUjLB4ywh+5Sh7o8fVIyAYeEQMnuABOcsqbyaL8mT3e51cJnWBR5JIuFUaFkVVdjmWotOvXKRk7DQftptTXHrPL43bEt9jYt97Zlz8Zn3gUaFcHc37KGZOwEyA6WRXPCfKudmWeR4cDZgWon/zxwLoBbbziuv9DaC/+RYq5YzmBP5SpleiFHYrcB+u+ErN1UyD8sJAs0Y+TtO7YmEnk3pocVwzQzJRwfLLfV+H4ykIlQ17d1yg8e1OUpcQrA8wETMLdJWgsP8G3GscqwIZgg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB6486.namprd12.prod.outlook.com (2603:10b6:8:c5::21) by
 CH8PR12MB9765.namprd12.prod.outlook.com (2603:10b6:610:264::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.13; Sat, 25 Apr 2026 21:15:56 +0000
Received: from DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33]) by DS0PR12MB6486.namprd12.prod.outlook.com
 ([fe80::88a9:f314:c95f:8b33%4]) with mapi id 15.20.9870.012; Sat, 25 Apr 2026
 21:15:56 +0000
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
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, Edwin Peer <epeer@nvidia.com>,
 Alexandre Courbot <acourbot@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Philipp Stanner <phasta@kernel.org>,
 alexeyi@nvidia.com, Eliot Courtney <ecourtney@nvidia.com>,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 Joel Fernandes <joelagnelf@nvidia.com>
Subject: [PATCH v12 22/22] rust: maple_tree: implement Send and Sync for
 MapleTree
Date: Sat, 25 Apr 2026 17:14:54 -0400
Message-Id: <20260425211454.174696-23-joelagnelf@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260425211454.174696-1-joelagnelf@nvidia.com>
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR14CA0027.namprd14.prod.outlook.com
 (2603:10b6:930:a0::17) To DS0PR12MB6486.namprd12.prod.outlook.com
 (2603:10b6:8:c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6486:EE_|CH8PR12MB9765:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f712bc9-3c7d-4bbd-c7a8-08dea30fd6eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ov2gvhUpmV1e4JMPvIUjwcYz5SCAkfSYoOpylH61P79v0sKQxxd6RElDlTHwMNQ/tayPzsBd+Y0SVFdKoMtIJ67zUv8PXBiYGteH4lQ2VBsCcaUeaqS7+1POomCAYrCJw++3dwkpaSs/mw9csGwNQbbXKj0N6vrFfwfBHSaoizhNWowlxvtAUapiiihPDMZdYJ09tq3K5JTymJUBxM8qOxdYn/TPIdT6zAHmnEfEOm2Su+dHOuxStsXedP1smn8Hhl2w/PXq/GcZO18uElPRq88KFTJu3gJJZ0QKAMntXIlf5HGFFvkmyAOl0RVQGNryXDm7CqTPrDauH23q3NZMd9AjV07n/nhkzCb01eMT7ughsOAN583yW8/caxWFFPU6T6ziH97juFKScfPHmk6WwY3XJVRiiqFk25ncOv2/6B5NDcW0qvCiv9ULHvvza2ht3KTP4QhGKdQHE/xghvPMUPMNv31ITgeQ9iIk1n1mShX47DY/vPW1g/WnYK8sMhd8Z17hEe/FEvzzS6KBoo6osOFXUwi1HTIXrtl/4YkIXbGyYIKoOK/Ucrrlz1mbivEpBDVzEbVqqLfi8rYddFVSd+dMJ9Ns/B0lene8dtmLkHQjpGyIqp60HQ924OQHaAzT/j7SA8C32rCj7hLatTtog9qgCQ9Uo8PH6EtfeXBvxrCZRbcvyoHeeA3xD9CDJQkou810d1ZZckzGcovqaF8eGYag83sN0Y4lZioCfus4c0k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6486.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v3oQGT8xLFZc5WK8OjMz2fFZpRY7hejmid7qouzmUTRdb/Ev9BwEPeTtISbC?=
 =?us-ascii?Q?svpMUbmLRj5iJ9mGQ2iI8XxJryVNeCwGSsbOePnaLmTCoSLg8x5KQc1n6xuf?=
 =?us-ascii?Q?BJPrz3I90DCfzeE0qSg8mZRwHw6QOQOttXMLvylmNA1Ghl9cBZL/W4qlFJsl?=
 =?us-ascii?Q?ZbAJW875XFMv4oXUFG8mUOjfLhhVD4b8UrdKxRtrW5Zz9mr0lSZDfTsNRGDG?=
 =?us-ascii?Q?tnniQ48bRFnUZuzRrgzI7nDe4EzXR9+TUQneQKDcvO4QxXwvvGxKFIy5Ne/X?=
 =?us-ascii?Q?pvg2CXxx6pmsJKAB1fRf9h/kcw6GTvPD9l4tHKlA+T1E8BbkZHvYzSHNPEmK?=
 =?us-ascii?Q?P/DIJbo+w/HmnZSomq+XJ0in9NuqQ0RydcBZdyLBZ4FCbMVN7RNKwfB3RqN0?=
 =?us-ascii?Q?37QKMrP2KKz/9w1TXTd3g/tKdNh261q2A6Teh3LtniVCAWJ/PLWrxgGp+OZU?=
 =?us-ascii?Q?ufQhX8yY7vf2POPWlJijV25ys83F5MoQ5rPTYcnRUYWigH3kwGu6Glo7+l5O?=
 =?us-ascii?Q?omhpvzglBL8ycCgKT+GByxZmPCiA7w8L7E0CT8QxRc8qyIEpfeTyeAoGdOqG?=
 =?us-ascii?Q?z+Dq9zcGGgvGCiySmlCRL8oPGx8OajWtb1H+l3u7CIcNDducCAkgG0+794m2?=
 =?us-ascii?Q?iWOm85Hd7O7sdwe4qVurl0RZ+gvukOVrtg3mqQHxLHEu8EE1ntB1x4UPNFzL?=
 =?us-ascii?Q?kxDUWNTcyhF3MX943h7DAESspevPGAIUkjExVPp+EPo/HT2xqQmq/OOEsQjl?=
 =?us-ascii?Q?/uHwE3x676ABIVDHJUKVS5MtA3Tda5TZIrtJX+87EV3ZXxGsj639qSJMZ6i3?=
 =?us-ascii?Q?Ju+sKKKAuC9wQTCXZagYCyw02XNc4VTYGQ6aoyETD9ryS+Vyv9+G20JTMS+0?=
 =?us-ascii?Q?AYngObMa30g6QWU/X6bfLV4T4X2fkTAG48YJVjMX/D/SrWmHv2yZ28N0Kgqu?=
 =?us-ascii?Q?CJ/nxk87D/KZ0RgyVw0YFUfVbyiXGjURm6GWrfqkMy83qh7T6moZOw6zSjKx?=
 =?us-ascii?Q?nTLID+sG6ve2Ak50r2qShvJY2Fpoaxo2U4bhqv01Ckoff/S3KrWX7NMdja9x?=
 =?us-ascii?Q?Q/2S2GkxnF6u+NE8K6SW861B7+toHq9tmB/lzmJ+pVTr9UeexyqDKlM7r4x7?=
 =?us-ascii?Q?8DmlPd+PaaWUF/JSjD9mWMVWgq1BsJqOqbk9HLoJk5ksV2frrmtzfT15jxYN?=
 =?us-ascii?Q?IQdc4XPuISNB6k204JP77ZUgFMiML81xJOKkT5uRXBfw0/IT36gPbf0eeHNL?=
 =?us-ascii?Q?E90+eb98oq2sCmj1ly5Si7wuodUfttjrMYSB/Cp0zvnvt7bPNKsmOKmS/FeH?=
 =?us-ascii?Q?IcwVCZqauukvlIazYJ+CxyCrKPjtyg9R69lI/hXZPWAVCDXwm9pltaTWphUR?=
 =?us-ascii?Q?CXGNTpqwCHcdmZOw8zCyrH1TRDGDcFB5tJ01Dat79bNhM0ymeJ4lmHA3/Sq5?=
 =?us-ascii?Q?FXyRHXImCMT1sUz8EhRtpU426JxHdwpuGQgkY/ICGGCYyit92S6IW+gY92mo?=
 =?us-ascii?Q?KMUO2DhJeY4xwuYspq0WLZTMvFdrBmEmwtLkDrWn/iVLFJPcz2RiswJfrWMl?=
 =?us-ascii?Q?I0NRaIs5mSk0ItyFlBa3eegjLGyEnf/nAnp3rTg0A1aAscoqaEte6yF6PpaA?=
 =?us-ascii?Q?AqVmY6HpN0FuSqQKZM+ZPzBCdUnNKa4xGx9c+79TmOSLD7zK/lYjMZz+QxVP?=
 =?us-ascii?Q?EF6fidY0M8qEYEcMT5ZVXraNuKJ8zMER+3iHWeVUIr9q2yso81/U1UDXRkMt?=
 =?us-ascii?Q?LgWxJL/y3Q=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f712bc9-3c7d-4bbd-c7a8-08dea30fd6eb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6486.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2026 21:15:56.0316 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k19X8WcCH/7u2pLBex96XDBzlLLiBu+Io7LO/bAMrSC+kp22INJn4/eLqxtz6zCJbK9Si3VRSKlGYWMdX0m/HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9765
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

