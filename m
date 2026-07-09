Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9E2FC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7702E10F331;
	Thu,  9 Jul 2026 00:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="G8mwudmP";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA5B10F31C
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:47:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783558051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=bhwY3MWAyCnvAr30m6fA2kaNoK4wbVgos2hNTDObMunQsZJOClsu+lIn2rRVAaBlaWJCe6ZxaGwQBMDH0xk7qmIesnUV400vGoYAlU8+G2i4hnLebsJ9LyygcH+/csPljkJgEYIQCXAu/RmUi9U4oWR1Em2yJ8N9FQJLZInuaZQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783558051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=435U5sarZ29IKDaQsyTZlsgFBn68QCRbPa9Sff2H3WY=; 
 b=asa+6wvsHOu5wjdt/nSnYpAtapfkkdxSbU+0Y1K3dzKTlXce0psx5YHJs5g0Bd3p2rl0ClBIvEn44sjtZy0vl2nEX+16ipFwqhoA5F1j03Grh9ISDgKyfw4wngTEGk73T2Gl3yNvavsxx7Xpsg14Og3yrdqHLdtheyXTSJ3un8Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783558051; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=435U5sarZ29IKDaQsyTZlsgFBn68QCRbPa9Sff2H3WY=;
 b=G8mwudmPfumoJLw5UxUdzt9fvhQVwiCmorNWxMi68ypla4Y/f7Cp50su23S33IUK
 X+tH6Y49m4KAJRtorVQrbbCJuuPm8Y/dEaDbTJRzJKHmZDaMJoAuBNRHClpk648+v31
 OM1rSUqCeK55kf6/Uc2eTiajALKWA3OE+SIg0yWs=
Received: by mx.zohomail.com with SMTPS id 1783558050526312.95148594404;
 Wed, 8 Jul 2026 17:47:30 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 08 Jul 2026 17:47:08 -0700
Subject: [PATCH v5 2/7] drm/tyr: add a generic slot manager
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fw-boot-b4-v5-2-7792ab68e359@collabora.com>
References: <20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com>
In-Reply-To: <20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
 steven.price@arm.com, laura.nao@collabora.com, alvin.sun@linux.dev, 
 beata.michalska@arm.com, acourbot@nvidia.com, lyude@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=15586;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=9hL/Ym1XWv5mKj+lba/rSfvq8WqlYrmtCap0biBuow0=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFl+7+e7tYksMV3wsa9+joiuWtKNKM83l94sq9Jc0Tez9
 m652KHyjlIWBjEuBlkxRZaz9kY94lXvjXTn/2+GmcPKBDKEgYtTACayfT0jw1b7jS+mqLy9N6v5
 cJpk24T7HGr599enzT0240aL+82S17mMDMfLpDfIPT+leNF9m8XWvCC1uFUMv5xMAuud/H6ztbp
 LcAIA
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

The slot manager initially assigns seats to its free slots. It will
continue to reuse the same slot for a seat, as long as another seat does
not start to use the slot in the interim.

When contention arises because all of the slots are allocated, the slot
manager will lazily evict and reuse slots that have become idle (if any).

The seat state is protected using the LockedBy pattern with the same lock
that guards the SlotManager. This ensures the seat state stays consistent
across slot operations.

Hardware specific behaviour is controlled through the SlotManager's
specific manager type that implements the `SlotOperations` trait.

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/slot.rs | 385 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tyr/tyr.rs  |   1 +
 2 files changed, 386 insertions(+)

diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
new file mode 100644
index 000000000000..3f58b23238ef
--- /dev/null
+++ b/drivers/gpu/drm/tyr/slot.rs
@@ -0,0 +1,385 @@
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
+/// Information related to a slot.
+struct SlotInfo<T> {
+    /// Type specific data attached to a slot.
+    slot_data: T,
+
+    /// Sequence number from when this slot was last activated.
+    seqno: u64,
+}
+
+/// Slot state.
+#[derive(Default)]
+enum SlotState<T> {
+    /// Slot is free.
+    #[default]
+    Free,
+
+    /// Slot is active.
+    Active(SlotInfo<T>),
+
+    /// Slot is idle.
+    Idle(SlotInfo<T>),
+}
+
+/// Trait describing the slot-related operations.
+pub(crate) trait SlotOperations {
+    /// Implementation-specific data associated with each slot.
+    type SlotData;
+
+    /// Called when a slot is being activated for a seat.
+    fn activate(&mut self, _slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
+        Ok(())
+    }
+
+    /// Called when a slot is being evicted and freed.
+    fn evict(&mut self, _slot_idx: usize, _slot_data: &Self::SlotData) -> Result {
+        Ok(())
+    }
+}
+
+/// A generic slot manager that provides access to a limited number of hardware slots.
+pub(crate) struct SlotManager<T: SlotOperations, const MAX_SLOTS: usize> {
+    /// A specific implementation of the generic slot manager.
+    manager: T,
+
+    /// Number of slots actually available.
+    slot_count: usize,
+
+    /// Slot array used to track the state of each slot.
+    slots: [SlotState<T::SlotData>; MAX_SLOTS],
+
+    /// Sequence number incremented each time a Seat is successfully activated
+    use_seqno: u64,
+}
+
+/// A `Seat` that can only be accessed when holding a `SlotManager` lock guard.
+type LockedSeat<T, const MAX_SLOTS: usize> = LockedBy<Seat, SlotManager<T, MAX_SLOTS>>;
+
+impl<T: SlotOperations, const MAX_SLOTS: usize> SlotManager<T, MAX_SLOTS> {
+    /// Creates a specific instance of a slot manager.
+    pub(crate) fn new(manager: T, slot_count: usize) -> Result<Self> {
+        if slot_count == 0 {
+            pr_err!("Invalid slot count: 0");
+            return Err(EINVAL);
+        }
+        if slot_count > MAX_SLOTS {
+            pr_err!(
+                "Slot count: {} cannot exceed MAX_SLOTS: {}",
+                slot_count,
+                MAX_SLOTS
+            );
+            return Err(EINVAL);
+        }
+        Ok(Self {
+            manager,
+            slot_count,
+            slots: [const { SlotState::Free }; MAX_SLOTS],
+            use_seqno: 1,
+        })
+    }
+
+    /// Records a slot as active for the given seat.
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
+        self.slots[slot_idx] = SlotState::Active(SlotInfo {
+            slot_data,
+            seqno: cur_seqno,
+        });
+
+        self.use_seqno += 1;
+        Ok(())
+    }
+
+    /// Activates a slot for the given seat.
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
+    /// Finds a slot for the given seat. A free slot is preferred, but if none
+    /// are available, the oldest idle slot is evicted and reused. Otherwise, if
+    /// there are no free or idle slots, return [`EBUSY`].
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
+                SlotState::Free => {
+                    return self.activate_slot(slot_idx, locked_seat, slot_data);
+                }
+                SlotState::Idle(slot_info) => {
+                    if idle_slot_idx.is_none() || slot_info.seqno < idle_slot_seqno {
+                        idle_slot_idx = Some(slot_idx);
+                        idle_slot_seqno = slot_info.seqno;
+                    }
+                }
+                SlotState::Active(_) => (),
+            }
+        }
+
+        match idle_slot_idx {
+            Some(slot_idx) => {
+                // Lazily evict idle slot just before it is reused.
+                if let SlotState::Idle(slot_info) = &self.slots[slot_idx] {
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
+    /// Converts an active slot and its seat to idle state.
+    fn idle_slot(&mut self, slot_idx: usize, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        let slot = take(&mut self.slots[slot_idx]);
+
+        // If the slot was active, make it idle.
+        if let SlotState::Active(slot_info) = slot {
+            self.slots[slot_idx] = SlotState::Idle(slot_info);
+        }
+
+        // If the seat was active, make it idle, or keep it idle if it was already idle.
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
+    /// Evicts an active or idle slot: calls the eviction callback and marks the slot as free
+    /// and the seat as NoSeat.
+    fn evict_slot(&mut self, slot_idx: usize, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        match &self.slots[slot_idx] {
+            SlotState::Active(slot_info) | SlotState::Idle(slot_info) => {
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
+    /// Checks that the seat state matches the slot's state.
+    /// If they don't match, the seat is stale and is reset to `NoSeat`.
+    fn check_seat(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) {
+        let (slot_idx, seat_seqno, is_active) = match locked_seat.access(self) {
+            Seat::Active(seat_info) => (seat_info.slot as usize, seat_info.seqno, true),
+            Seat::Idle(seat_info) => (seat_info.slot as usize, seat_info.seqno, false),
+            _ => return,
+        };
+
+        let valid = if is_active {
+            !kernel::warn_on!(!matches!(
+                &self.slots[slot_idx],
+                SlotState::Active(slot_info) if slot_info.seqno == seat_seqno
+            ))
+        } else {
+            matches!(
+                &self.slots[slot_idx],
+                SlotState::Idle(slot_info) if slot_info.seqno == seat_seqno
+            )
+        };
+
+        if !valid {
+            *locked_seat.access_mut(self) = Seat::NoSeat;
+        }
+    }
+
+    /// Activate a resource on any available/reclaimable slot.
+    pub(crate) fn activate(
+        &mut self,
+        locked_seat: &LockedSeat<T, MAX_SLOTS>,
+        slot_data: T::SlotData,
+    ) -> Result {
+        self.check_seat(locked_seat);
+        match locked_seat.access(self) {
+            // If a seat still has a valid slot, just reuse the slot and refresh the bookkeeping.
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => {
+                self.record_active_slot(seat_info.slot as usize, locked_seat, slot_data)
+            }
+            _ => self.allocate_slot(locked_seat, slot_data),
+        }
+    }
+
+    /// Flag a resource as idle. This method will be used for user VM support.
+    #[expect(dead_code)]
+    pub(crate) fn idle(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        self.check_seat(locked_seat);
+        if let Seat::Active(seat_info) = locked_seat.access(self) {
+            self.idle_slot(seat_info.slot as usize, locked_seat)?;
+        }
+        Ok(())
+    }
+
+    /// Evict a resource from its slot.
+    pub(crate) fn evict(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) -> Result {
+        self.check_seat(locked_seat);
+
+        match locked_seat.access(self) {
+            Seat::Active(seat_info) | Seat::Idle(seat_info) => {
+                let slot_idx = seat_info.slot as usize;
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
index 95cda7b0962f..7c9a8063b3b9 100644
--- a/drivers/gpu/drm/tyr/tyr.rs
+++ b/drivers/gpu/drm/tyr/tyr.rs
@@ -12,6 +12,7 @@
 mod gem;
 mod gpu;
 mod regs;
+mod slot;
 
 kernel::module_platform_driver! {
     type: TyrPlatformDriver,

-- 
2.54.0

