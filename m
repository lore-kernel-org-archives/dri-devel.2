Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48D36FF8850
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 23:39:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC29110F6F5;
	Fri, 24 Apr 2026 23:39:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Ak8+duY6";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E9AF10F6F8
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 23:39:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1777073967; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=X34Vb4Up52DHVDPS1pxWhqtskd4KgZ7Uz7Mvo91LKP1j+c89Fjt1a7jdZKEA0Yms4UZ9o+oGSsvqyssiKi/8ucaGZ1qNEZkY9TZbqceN5EmMghS0Ks9tGce0Uy5ocvPOU9pSTTh2XDB/bDp+e592iOg91fWF5shf80FhOLZlF5I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1777073967;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=NVSzguzV5E8I0aAecr1bh6aE0xgm/faWDGEzrzojJ54=; 
 b=dKnvTDTYVMuDJVfn2PaIvUzI2RDfEaRuhltEw7mI2VbRq6DbsShxNZUU9BNFwYkxPtDwBRwhXmfNLqNB8yhH4lpXXvfZx9UhLRFh9gABh6gvRTU/e1BE6kizwOot8EUAUrYrV/q+plWtTLNanKUkJG5An3tzUkV0UUN+zcC/tkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1777073967; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=NVSzguzV5E8I0aAecr1bh6aE0xgm/faWDGEzrzojJ54=;
 b=Ak8+duY6qxU5zGC9T+t8wlo0uSv/VTGxEQhpaTQTTKyxs9ZUS8+AtFrGhNOnSNDU
 SbPP/SsAZWx/075ARVHZMKUVshKfILw0QxtD8lmo9Wgto+UP4f/itNjBybScNkTk37o
 L3BnGxkuSnYdjToB/aMsTmUUDRPyqmh5QvRHmgzc=
Received: by mx.zohomail.com with SMTPS id 1777073965007235.40588310344913;
 Fri, 24 Apr 2026 16:39:25 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Fri, 24 Apr 2026 16:39:02 -0700
Subject: [PATCH v4 08/20] drm/tyr: Add generic slot manager
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260424-b4-fw-boot-v4-v4-8-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
In-Reply-To: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Frederic Weisbecker <frederic@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, 
 Anna-Maria Behnsen <anna-maria@linutronix.de>, 
 John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com, 
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com, 
 work@onurozkan.dev, alvin.sun@linux.dev, 
 Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=18083;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=2lsx5cWpz1kepWGxKnmDJilNXZeOAHnAUs6sa7ze99k=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDJmv/yt0GFsv/a+2pOtzZzRn6J9cy5r4X6madYukzS/UW
 bXeWb+to5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgIlMtWdkuGznxCC73k/+UXfA
 +vS5j0+ufRDeLvakbZnXGou3+TntkowMuyQSHP35haZVXJhwO6j8VOOOSdkri+t/Wz5JW8Z2gHU
 LBwA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

From: Boris Brezillon <boris.brezillon@collabora.com>

Introduce a generic slot manager to dynamically allocate limited hardware
slots to software "seats". It can be used for both address space (AS) and
command stream group (CSG) slots.

The slot manager initially assigns seats to its free slots. It then
continues to reuse the same slot for a seat, as long as another seat
did not start to use the slot in the interim.

When contention arises because all of the slots are allocated, the slot
manager will lazily evict and reuse slots that have become idle (if any).

The seat state is protected using the LockedBy pattern with the same lock
that guards the SlotManager. This ensures the seat state stays consistent
across slot operations.

Hardware specific behaviour can be customized using the slot manager's
`SlotOperations` trait.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/slot.rs | 437 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs  |   1 +
 2 files changed, 438 insertions(+)

diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
new file mode 100644
index 000000000000..debba75f6204
--- /dev/null
+++ b/drivers/gpu/drm/tyr/slot.rs
@@ -0,0 +1,437 @@
+// SPDX-License-Identifier: GPL-2.0 or MIT
+
+//! Slot management abstraction for limited hardware resources.
+//!
+//! This module provides a generic [`SlotManager`] that assigns limited hardware
+//! slots to logical "seats". A seat represents an entity (such as a virtual memory
+//! (VM) address space) that needs access to a hardware slot.
+//!
+//! The [`SlotManager`] tracks slot allocation using sequence numbers (seqno) to detect
+//! when a seat's binding has been invalidated. When a seat requests activation,
+//! the manager will either reuse the seat's existing slot (if still valid),
+//! allocate a free slot (if any are available), or evict the oldest idle slot if any
+//! slots are idle.
+//!
+//! Hardware-specific behavior is customized by implementing the [`SlotOperations`]
+//! trait, which allows callbacks when slots are activated or evicted.
+//!
+//! This is currently used for managing address space slots in the GPU, and it will
+//! also be used to manage Command Stream Group (CSG) interface slots in the future.
+//!
+//! [SlotOperations]: crate::slot::SlotOperations
+//! [SlotManager]: crate::slot::SlotManager
+#![allow(dead_code)]
+
+use core::{
+    mem::take,
+    ops::{
+        Deref,
+        DerefMut, //
+    }, //
+};
+
+use kernel::{
+    prelude::*,
+    sync::LockedBy, //
+};
+
+/// Seat information.
+///
+/// This can't be accessed directly by the element embedding a `Seat`,
+/// but is used by the generic slot manager logic to control residency
+/// of a certain object on a hardware slot.
+pub(crate) struct SeatInfo {
+    /// Slot used by this seat.
+    ///
+    /// This index is only valid if the slot pointed to by this index
+    /// has its `SlotInfo::seqno` match `SeatInfo::seqno`. Otherwise,
+    /// it means the object has been evicted from the hardware slot,
+    /// and a new slot needs to be acquired to make this object
+    /// resident again.
+    slot: u8,
+
+    /// Sequence number encoding the last time this seat was active.
+    /// We also use it to check if a slot is still bound to a seat.
+    seqno: u64,
+}
+
+/// Seat state.
+///
+/// This is meant to be embedded in the object that wants to acquire
+/// hardware slots. It also starts in the `Seat::NoSeat` state, and
+/// the slot manager will change the object value when an active/evict
+/// request is issued.
+#[derive(Default)]
+pub(crate) enum Seat {
+    #[expect(clippy::enum_variant_names)]
+    /// Resource is not resident.
+    ///
+    /// All objects start with a seat in the `Seat::NoSeat` state. The seat also
+    /// gets back to that state if the user requests eviction. It
+    /// can also end up in that state next time an operation is done
+    /// on a `Seat::Idle` seat and the slot manager finds out this
+    /// object has been evicted from the slot.
+    #[default]
+    NoSeat,
+
+    /// Resource is actively used and resident.
+    ///
+    /// When a seat is in the `Seat::Active` state, it can't be evicted, and the
+    /// slot pointed to by `SeatInfo::slot` is guaranteed to be reserved
+    /// for this object as long as the seat stays active.
+    Active(SeatInfo),
+
+    /// Resource is idle and might or might not be resident.
+    ///
+    /// When a seat is in the`Seat::Idle` state, we can't know for sure if the
+    /// object is resident or evicted until the next request we issue
+    /// to the slot manager. This tells the slot manager it can
+    /// reclaim the underlying slot if needed.
+    /// In order for the hardware to use this object again, the seat
+    /// needs to be turned into an `Seat::Active` state again
+    /// with a `SlotManager::activate()` call.
+    Idle(SeatInfo),
+}
+
+impl Seat {
+    /// Get the slot index this seat is pointing to.
+    ///
+    /// If the seat is not `Seat::Active` we can't trust the
+    /// `SeatInfo`. In that case `None` is returned, otherwise
+    /// `Some(SeatInfo::slot)` is returned.
+    pub(super) fn slot(&self) -> Option<u8> {
+        match self {
+            Self::Active(info) => Some(info.slot),
+            _ => None,
+        }
+    }
+}
+
+/// Trait describing the slot-related operations.
+pub(crate) trait SlotOperations {
+    /// Implementation-specific data associated with each slot.
+    type SlotData;
+
+    /// Called when a slot is being activated for a seat.
+    ///
+    /// This callback allows hardware-specific actions to be performed when a slot
+    /// becomes active, such as updating hardware registers or invalidating caches.
+    fn activate(&mut self, _slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
+        Ok(())
+    }
+
+    /// Called when a slot is being evicted and freed.
+    ///
+    /// This callback allows hardware-specific cleanup when a slot is being
+    /// completely freed, either explicitly or when an idle slot is being
+    /// reused for a different seat. Any hardware state should be invalidated.
+    fn evict(&mut self, _slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
+        Ok(())
+    }
+}
+
+/// Data attached to a slot.
+///
+/// Contains data and the sequence number used to check
+/// whether a seat's binding to this slot is still valid.
+struct SlotInfo<T> {
+    /// Type specific data attached to a slot
+    slot_data: T,
+
+    /// Sequence number from when this slot was last activated
+    seqno: u64,
+}
+
+/// Slot state.
+///
+/// Tracks whether a hardware slot is free, actively in use, or idle and available
+/// for eviction.
+#[derive(Default)]
+enum Slot<T> {
+    /// Slot is free.
+    ///
+    /// All slots start in the `Slot::Free` state when the slot manager is created.
+    #[default]
+    Free,
+
+    /// Slot is active.
+    ///
+    /// When in the `Slot::Active` state, the slot is guaranteed to stay active
+    /// for as long as the resource bound to it has its seat in the
+    /// `Seat::Active` state. No new resource can be bound to it.
+    Active(SlotInfo<T>),
+
+    /// Slot is idle.
+    ///
+    /// Happens when the underlying resource has been flagged
+    /// `Seat::Idle`. When in the `Slot::Idle` state, the slot manager is allowed
+    /// to evict the resource and re-assign the slot to someone else.
+    /// This process involves updating the `SlotInfo::seqno` which
+    /// will be checked against the `SeatInfo::seqno` in case the idle
+    /// resource wants to become active again.
+    Idle(SlotInfo<T>),
+}
+
+/// Generic slot manager object.
+///
+/// It abstracts away all the churn around activeness/idleness tracking
+/// and lets the implementer of the SlotOperations trait focus on how to
+/// make a resource active or evict it.
+///
+/// This structure must be protected by a lock.
+/// Seats that want to use this manager must be wrapped with
+/// `LockedBy<Seat, SlotManager<T, MAX_SLOTS>>` to ensure they are protected by the same lock.
+/// All operations on seats and slots are synchronized through this shared lock.
+pub(crate) struct SlotManager<T: SlotOperations, const MAX_SLOTS: usize> {
+    /// Manager specific data
+    manager: T,
+
+    /// Number of slots actually available
+    slot_count: usize,
+
+    /// Slots
+    slots: [Slot<T::SlotData>; MAX_SLOTS],
+
+    /// Sequence number incremented each time a Seat is successfully activated
+    use_seqno: u64,
+}
+
+/// A `Seat` protected by the same lock that is used to wrap the `SlotManager`.
+type LockedSeat<T, const MAX_SLOTS: usize> = LockedBy<Seat, SlotManager<T, MAX_SLOTS>>;
+
+impl<T: SlotOperations, const MAX_SLOTS: usize> SlotManager<T, MAX_SLOTS> {
+    /// Creates a new slot manager.
+    ///
+    /// Returns [`EINVAL`] if the slot count is zero or exceeds the maximum number of slots.
+    pub(crate) fn new(manager: T, slot_count: usize) -> Result<Self> {
+        if slot_count == 0 {
+            return Err(EINVAL);
+        }
+        if slot_count > MAX_SLOTS {
+            return Err(EINVAL);
+        }
+        Ok(Self {
+            manager,
+            slot_count,
+            slots: [const { Slot::Free }; MAX_SLOTS],
+            use_seqno: 1,
+        })
+    }
+
+    /// Records a slot as active for the given seat.
+    ///
+    /// Updates both the seat state and the slot state to reflect the active binding,
+    /// using the current sequence number. Increments the sequence number for the next
+    /// activation.
+    fn record_active_slot(
+        &mut self,
+        slot_idx: usize,
+        locked_seat: &LockedSeat<T, MAX_SLOTS>,
+        slot_data: T::SlotData,
+    ) -> Result {
+        let cur_seqno = self.use_seqno;
+
+        *locked_seat.access_mut(self) = Seat::Active(SeatInfo {
+            slot: slot_idx as u8,
+            seqno: cur_seqno,
+        });
+
+        self.slots[slot_idx] = Slot::Active(SlotInfo {
+            slot_data,
+            seqno: cur_seqno,
+        });
+
+        self.use_seqno += 1;
+        Ok(())
+    }
+
+    /// Activates a slot for the given seat.
+    ///
+    /// Calls the activation callback and then records the slot as active.
+    fn activate_slot(
+        &mut self,
+        slot_idx: usize,
+        locked_seat: &LockedSeat<T, MAX_SLOTS>,
+        slot_data: T::SlotData,
+    ) -> Result {
+        self.manager.activate(slot_idx, &slot_data)?;
+        self.record_active_slot(slot_idx, locked_seat, slot_data)
+    }
+
+    /// Allocates a slot for the given seat.
+    ///
+    /// Searches for a free slot first. If none are available, finds the oldest idle
+    /// slot (by sequence number) and evicts it. Returns [`EBUSY`] if all slots are
+    /// active and none can be evicted.
+    fn allocate_slot(
+        &mut self,
+        locked_seat: &LockedSeat<T, MAX_SLOTS>,
+        slot_data: T::SlotData,
+    ) -> Result {
+        let slots = &self.slots[..self.slot_count];
+
+        let mut idle_slot_idx = None;
+        let mut idle_slot_seqno: u64 = 0;
+
+        for (slot_idx, slot) in slots.iter().enumerate() {
+            match slot {
+                Slot::Free => {
+                    return self.activate_slot(slot_idx, locked_seat, slot_data);
+                }
+                Slot::Idle(slot_info) => {
+                    if idle_slot_idx.is_none() || slot_info.seqno < idle_slot_seqno {
+                        idle_slot_idx = Some(slot_idx);
+                        idle_slot_seqno = slot_info.seqno;
+                    }
+                }
+                Slot::Active(_) => (),
+            }
+        }
+
+        match idle_slot_idx {
+            Some(slot_idx) => {
+                // Lazily evict idle slot just before it is reused
+                if let Slot::Idle(slot_info) = &self.slots[slot_idx] {
+                    self.manager.evict(slot_idx, &slot_info.slot_data)?;
+                }
+                self.activate_slot(slot_idx, locked_seat, slot_data)
+            }
+            None => {
+                pr_err!(
+                    "Slot allocation failed: all {} slots in use\n",
+                    self.slot_count
+                );
+                Err(EBUSY)
+            }
+        }
+    }
+
+    /// Transitions a slot from active to idle state.
+    ///
+    /// Updates both the slot and seat to idle state, making the slot eligible for
+    /// eviction if needed by another seat.
+    fn idle_slot(&mut self, slot_idx: usize, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        let slot = take(&mut self.slots[slot_idx]);
+
+        if let Slot::Active(slot_info) = slot {
+            self.slots[slot_idx] = Slot::Idle(SlotInfo {
+                slot_data: slot_info.slot_data,
+                seqno: slot_info.seqno,
+            })
+        };
+
+        *locked_seat.access_mut(self) = match locked_seat.access(self) {
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => Seat::Idle(SeatInfo {
+                slot: seat_info.slot,
+                seqno: seat_info.seqno,
+            }),
+            Seat::NoSeat => Seat::NoSeat,
+        };
+        Ok(())
+    }
+
+    /// Evicts a seat from its slot and marks the slot as free.
+    ///
+    /// Calls the eviction callback then frees the slot and resets the seat to `NoSeat`.
+    fn evict_slot(&mut self, slot_idx: usize, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        match &self.slots[slot_idx] {
+            Slot::Active(slot_info) | Slot::Idle(slot_info) => {
+                self.manager.evict(slot_idx, &slot_info.slot_data)?;
+                take(&mut self.slots[slot_idx]);
+            }
+            _ => (),
+        }
+
+        *locked_seat.access_mut(self) = Seat::NoSeat;
+        Ok(())
+    }
+
+    /// Checks and updates the seat state based on the slot it points to.
+    ///
+    /// Validates that the seat's sequence number matches the slot's sequence number.
+    /// If they don't match, the seat has been evicted and is reset to `NoSeat`.
+    fn check_seat(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) {
+        let (slot_idx, seqno, is_active) = match locked_seat.access(self) {
+            Seat::Active(info) => (info.slot as usize, info.seqno, true),
+            Seat::Idle(info) => (info.slot as usize, info.seqno, false),
+            _ => return,
+        };
+
+        let valid = if is_active {
+            !kernel::warn_on!(!matches!(&self.slots[slot_idx], Slot::Active(s) if s.seqno == seqno))
+        } else {
+            matches!(&self.slots[slot_idx], Slot::Idle(s) if s.seqno == seqno)
+        };
+
+        if !valid {
+            *locked_seat.access_mut(self) = Seat::NoSeat;
+        }
+    }
+
+    /// Make a resource active on any available/reclaimable slot.
+    ///
+    /// Returns [`EBUSY`] if all slots are in use and none can be reclaimed
+    /// or the reclaim failed. May also return errors from the callbacks.
+    pub(crate) fn activate(
+        &mut self,
+        locked_seat: &LockedSeat<T, MAX_SLOTS>,
+        slot_data: T::SlotData,
+    ) -> Result {
+        self.check_seat(locked_seat);
+        match locked_seat.access(self) {
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => {
+                // With lazy eviction, if seqno matches, the hardware state is still
+                // valid for both Active and Idle slots, so just update our records
+                self.record_active_slot(seat_info.slot as usize, locked_seat, slot_data)
+            }
+            _ => self.allocate_slot(locked_seat, slot_data),
+        }
+    }
+
+    /// Flag a resource idle.
+    ///
+    /// The slot manager can decide to reclaim the slot this resource
+    /// was bound to at any point after function returns.
+    // The idle() method will be used when we start adding support for user VMs.
+    #[expect(dead_code)]
+    pub(crate) fn idle(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        self.check_seat(locked_seat);
+        if let Seat::Active(seat_info) = locked_seat.access(self) {
+            self.idle_slot(seat_info.slot as usize, locked_seat)?;
+        }
+        Ok(())
+    }
+
+    /// Evict a resource from its slot, and make this slot free again
+    /// for other users.
+    ///
+    /// May return errors from the eviction callback.
+    pub(crate) fn evict(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        self.check_seat(locked_seat);
+
+        match locked_seat.access(self) {
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => {
+                let slot_idx = seat_info.slot as usize;
+
+                self.evict_slot(slot_idx, locked_seat)?;
+            }
+            _ => (),
+        }
+
+        Ok(())
+    }
+}
+
+impl<T: SlotOperations, const MAX_SLOTS: usize> Deref for SlotManager<T, MAX_SLOTS> {
+    type Target = T;
+
+    fn deref(&self) -> &Self::Target {
+        &self.manager
+    }
+}
+
+impl<T: SlotOperations, const MAX_SLOTS: usize> DerefMut for SlotManager<T, MAX_SLOTS> {
+    fn deref_mut(&mut self) -> &mut Self::Target {
+        &mut self.manager
+    }
+}
diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
index 9432ddd6b5b8..20b38120e20e 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -12,6 +12,7 @@
 mod gem;
 mod gpu;
 mod regs;
+mod slot;
 
 kernel::module_platform_driver! {
     type: TyrPlatformDriverData,

-- 
2.53.0

