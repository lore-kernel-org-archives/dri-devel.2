Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5E8606A32D
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 22:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=Gt2P0ZVz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 829DA10FFD9;
	Wed, 25 Nov 2026 22:47:38 +0000 (UTC)
Received: from sender6-op-o11.zoho.com (sender6-op-o11.zoho.com
 [165.173.180.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 389FD10E525
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 22:47:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795646835; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nQFoYGV41ffDsF1IRkYk+kKZxQr+eNNvxssOZlhsDku4O0oXeAJfIkI765/ijMbRn5S4vg1tEV9+4+EN9UIsEsQi7i4YNrLZLk7DtPYnMcHiACpH2Ezmg9EEnrinTQwiLmOaYDp6gnjyrl+tvYGDvXSOK98uB9b2mZ1dbKKaP1g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795646835;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZdWRi8zA1ua11I581iM4xwj+4Pga6MDcixxXt5D4L/o=; 
 b=bclh7U3Rt2WfpM/srLLvX6yORbAw5w091jVAmMQxCyk2FkONAVwUDNe+hUM9KxZqHDEMZuJAi6D65f7oC6Lf/urh70gWDflGe04VYRoZP4ZxvfkQ5mdjCdofT0T3rvk4erkEACcx9Orcu8Tu+6divGIEwfFEm56KXJukj4VZMzU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: a=rsa-sha256;
 b=Gt2P0ZVzekEySP2CNLLGPfWHKqaLglWKrA8842B689/03OFib3MivfMOn/PP2JQUiKcbkI3QRyfBph+4C81cuvJZBPpJcQE9iY6jVCC7KCWxoKaM4ssiasMM8PH5uhAXYdIt4lgyjUZOtuUs2ZKhPBnBSXrz5/kAQAD3XAz/fAI=;
 c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1;
 bh=ZdWRi8zA1ua11I581iM4xwj+4Pga6MDcixxXt5D4L/o=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795646832404642.2890147683337;
 Wed, 25 Nov 2026 14:47:12 -0800 (PST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Date: Wed, 25 Nov 2026 19:46:52 -0300
Subject: [PATCH 01/13] drm/tyr: convert SeatInfo::slot from u8 to usize
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-b4-tyr-as-casts-v1-1-2b2f53164d86@collabora.com>
References: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
In-Reply-To: <20261125-b4-tyr-as-casts-v1-0-2b2f53164d86@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

An `as` cast silently drops the bits that do not fit the target type,
and nothing at the cast shows whether that can happen. As part of a
larger effort to reduce the number of `as` casts in Tyr, convert
`SeatInfo::slot` from `u8` to `usize`.

The slot index is stored as a `u8`, while the code that uses it takes a
`usize`. The casts follow from that choice. The index is cast with `as`
on the way into a `SeatInfo` and on the way out, and
`SlotManager::new()` rejects more than 256 slots so that the cast to
`u8` cannot truncate.

Store the index as `usize`, which removes the casts and the limit.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
 drivers/gpu/drm/tyr/mmu/address_space.rs | 15 +++------------
 drivers/gpu/drm/tyr/slot.rs              | 23 +++++++++--------------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/tyr/mmu/address_space.rs b/drivers/gpu/drm/tyr/mmu/address_space.rs
index 76e3d2df6afd..dd6377bee989 100644
--- a/drivers/gpu/drm/tyr/mmu/address_space.rs
+++ b/drivers/gpu/drm/tyr/mmu/address_space.rs
@@ -467,10 +467,7 @@ pub(super) fn start_vm_update(
     ) -> Result {
         let seat = vm_as_data.as_seat.access(self);
         match seat.slot() {
-            Some(slot) => {
-                let as_nr = slot as usize;
-                self.as_start_update(as_nr, region)
-            }
+            Some(slot) => self.as_start_update(slot, region),
             _ => Ok(()),
         }
     }
@@ -479,10 +476,7 @@ pub(super) fn start_vm_update(
     pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
         let seat = vm_as_data.as_seat.access(self);
         match seat.slot() {
-            Some(slot) => {
-                let as_nr = slot as usize;
-                self.as_end_update(as_nr)
-            }
+            Some(slot) => self.as_end_update(slot),
             _ => Ok(()),
         }
     }
@@ -491,10 +485,7 @@ pub(super) fn end_vm_update(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
     pub(super) fn flush_vm(&mut self, vm_as_data: &VmAsData<'drm>) -> Result {
         let seat = vm_as_data.as_seat.access(self);
         match seat.slot() {
-            Some(slot) => {
-                let as_nr = slot as usize;
-                self.as_flush(as_nr)
-            }
+            Some(slot) => self.as_flush(slot),
             _ => Ok(()),
         }
     }
diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
index d194ead53f71..0e153dc025c5 100644
--- a/drivers/gpu/drm/tyr/slot.rs
+++ b/drivers/gpu/drm/tyr/slot.rs
@@ -47,7 +47,7 @@ pub(crate) struct SeatInfo {
     /// it means the object has been evicted from the hardware slot,
     /// and a new slot needs to be acquired to make this object
     /// resident again.
-    slot: u8,
+    slot: usize,
 
     /// Sequence number encoding the last time this seat was active.
     /// We also use it to check if a slot is still bound to a seat.
@@ -98,7 +98,7 @@ impl Seat {
     /// If the seat is not `Seat::Active` we can't trust the
     /// `SeatInfo`. In that case `None` is returned, otherwise
     /// `Some(SeatInfo::slot)` is returned.
-    pub(crate) fn slot(&self) -> Option<u8> {
+    pub(crate) fn slot(&self) -> Option<usize> {
         match self {
             Self::Active(info) => Some(info.slot),
             _ => None,
@@ -174,10 +174,6 @@ pub(crate) fn new(manager: T, slot_count: usize) -> Result<Self> {
         if slot_count > MAX_SLOTS {
             return Err(EINVAL);
         }
-        // Since the slot index is stored in SeatInfo as a u8, the maximum number of slots is 256.
-        if slot_count > u8::MAX as usize + 1 {
-            return Err(EINVAL);
-        }
 
         Ok(Self {
             manager,
@@ -193,7 +189,7 @@ fn record_active_slot(&mut self, slot_idx: usize, slot_data: T::SlotData) {
         let cur_seqno = self.use_seqno;
 
         *T::seat(&slot_data).access_mut(self) = Seat::Active(SeatInfo {
-            slot: slot_idx as u8,
+            slot: slot_idx,
             seqno: cur_seqno,
         });
 
@@ -221,7 +217,7 @@ fn reactivate_slot(&mut self, slot_idx: usize, slot_data: &T::SlotData) -> Resul
         };
 
         *T::seat(slot_data).access_mut(self) = Seat::Active(SeatInfo {
-            slot: slot_idx as u8,
+            slot: slot_idx,
             seqno: cur_seqno,
         });
 
@@ -325,8 +321,8 @@ fn evict_slot(&mut self, slot_idx: usize, locked_seat: &LockedSeat<T, MAX_SLOTS>
     /// If they don't match, the seat is stale and is reset to `NoSeat`.
     fn check_seat(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) {
         let (slot_idx, seat_seqno, is_active) = match locked_seat.access(self) {
-            Seat::Active(seat_info) => (seat_info.slot as usize, seat_info.seqno, true),
-            Seat::Idle(seat_info) => (seat_info.slot as usize, seat_info.seqno, false),
+            Seat::Active(seat_info) => (seat_info.slot, seat_info.seqno, true),
+            Seat::Idle(seat_info) => (seat_info.slot, seat_info.seqno, false),
             _ => return,
         };
 
@@ -353,7 +349,7 @@ pub(crate) fn activate(&mut self, slot_data: T::SlotData) -> Result {
 
         // Copy out only the slot index so the borrow of slot_data ends here.
         let slot_idx = match T::seat(&slot_data).access(self) {
-            Seat::Active(seat_info) | Seat::Idle(seat_info) => Some(seat_info.slot as usize),
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => Some(seat_info.slot),
             Seat::NoSeat => None,
         };
 
@@ -368,7 +364,7 @@ pub(crate) fn activate(&mut self, slot_data: T::SlotData) -> Result {
     pub(crate) fn idle(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
         self.check_seat(locked_seat);
         if let Seat::Active(seat_info) = locked_seat.access(self) {
-            self.idle_slot(seat_info.slot as usize, locked_seat)?;
+            self.idle_slot(seat_info.slot, locked_seat)?;
         }
         Ok(())
     }
@@ -379,8 +375,7 @@ pub(crate) fn evict(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result
 
         match locked_seat.access(self) {
             Seat::Active(seat_info) | Seat::Idle(seat_info) => {
-                let slot_idx = seat_info.slot as usize;
-                self.evict_slot(slot_idx, locked_seat)?;
+                self.evict_slot(seat_info.slot, locked_seat)?;
             }
             _ => (),
         }

-- 
2.56.0

