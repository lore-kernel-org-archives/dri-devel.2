Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7DC3C44507
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 23:17:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B3810E24E;
	Wed, 15 Jul 2026 23:17:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Mpcp/MIl";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF95510E24E
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 23:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1784157441; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Bmm7F3VRsW3WPG1PirQ27wZ9qrI4boKVgP7ebP36Y2jloa/fFTn5+iCcPiGiMNg1Po5FQrZ3DeUDmhSosnDhnerTT89tNBivv9kSS+ON9PBVuQLAhrmnYn2Jij630g2ePH+zD0d3Oeji3XkbHaqmYKdT5ms1rf4js9CsH9gLqXg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1784157441;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=toTzPTSrExSOJV+tv8XiAz+9wu77Jfj2cu4BzZcT4UI=; 
 b=ZR0tChEA8K+tm8U3wmY0E7mMcgjLL8XxAAWPuMgYs7y7N6THAa/tm6LoJN2N2ezaMo7whNuD7/pW77S5xpocKBgN7eiWe9KX/16opaV/p4dZsV2o+LLd+rGbbpyXv2H1GPtfbg2HQU4OSOWoFtuoqsOvB6myt/HXwWdSV69BVjs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
 dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1784157441; 
 s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
 h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
 bh=toTzPTSrExSOJV+tv8XiAz+9wu77Jfj2cu4BzZcT4UI=;
 b=Mpcp/MIllA2wHcfbu8vTbbT+VZjkKGihBbBIItQTeZJ7NcTXQuODrUxOBnzvdHQ2
 gNSy7pbc2iHj/P9TcaBjKCNi4SH8ct0El7QdUjhvbHzdYSdKMBbCFetaKk9SKNO0NsR
 dt8gUE3ElrFVKZ6Oa3oBUfyHerD5BaZHiV3mVFEg=
Received: by mx.zohomail.com with SMTPS id 1784157439654931.4461996631151;
 Wed, 15 Jul 2026 16:17:19 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v6 2/7] drm/tyr: add a generic slot manager
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20260709-fw-boot-b4-v6-2-ca391e1a4108@collabora.com>
Date: Wed, 15 Jul 2026 20:17:02 -0300
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 samitolvanen@google.com, acourbot@nvidia.com, alvin.sun@linux.dev,
 laura.nao@collabora.com, work@onurozkan.dev, beata.michalska@arm.com,
 steven.price@arm.com, lyude@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <41798711-8EFA-409B-9BA2-F718181AEB67@collabora.com>
References: <20260709-fw-boot-b4-v6-0-ca391e1a4108@collabora.com>
 <20260709-fw-boot-b4-v6-2-ca391e1a4108@collabora.com>
To: Deborah Brouwer <deborah.brouwer@collabora.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External
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



> On 9 Jul 2026, at 18:36, Deborah Brouwer =
<deborah.brouwer@collabora.com> wrote:
>=20
> From: Boris Brezillon <boris.brezillon@collabora.com>
>=20
> Introduce a generic slot manager to dynamically allocate limited =
hardware
> slots to software "seats". It can be used for both address space (AS) =
and
> command stream group (CSG) slots.
>=20
> The slot manager initially assigns seats to its free slots. It will
> continue to reuse the same slot for a seat, as long as another seat =
does
> not start to use the slot in the interim.
>=20
> When contention arises because all of the slots are allocated, the =
slot
> manager will lazily evict and reuse slots that have become idle (if =
any).
>=20
> The seat state is protected using the LockedBy pattern with the same =
lock
> that guards the SlotManager. This ensures the seat state stays =
consistent
> across slot operations.
>=20
> Hardware specific behaviour is controlled through the SlotManager's
> specific manager type that implements the `SlotOperations` trait.
>=20
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Co-developed-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> ---
> drivers/gpu/drm/tyr/slot.rs | 385 =
++++++++++++++++++++++++++++++++++++++++++++
> drivers/gpu/drm/tyr/tyr.rs  |   1 +
> 2 files changed, 386 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
> new file mode 100644
> index 000000000000..3f58b23238ef
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/slot.rs
> @@ -0,0 +1,385 @@
> +// SPDX-License-Identifier: GPL-2.0 or MIT
> +
> +//! Slot management abstraction for limited hardware resources.
> +//!
> +//! This module provides a generic [`SlotManager`] that assigns =
limited hardware
> +//! slots to logical "seats". A seat represents an entity (such as a =
virtual memory
> +//! (VM) address space) that needs access to a hardware slot.
> +//!
> +//! The [`SlotManager`] tracks slot allocation using sequence numbers =
(seqno) to detect
> +//! when a seat's binding has been invalidated. When a seat requests =
activation,
> +//! the manager will either reuse the seat's existing slot (if still =
valid),
> +//! allocate a free slot (if any are available), or evict the oldest =
idle slot if any
> +//! slots are idle.
> +//!
> +//! Hardware-specific behavior is customized by implementing the =
[`SlotOperations`]
> +//! trait, which allows callbacks when slots are activated or =
evicted.
> +//!
> +//! This is currently used for managing address space slots in the =
GPU, and it will
> +//! also be used to manage Command Stream Group (CSG) interface slots =
in the future.
> +//!
> +//! [SlotOperations]: crate::slot::SlotOperations
> +//! [SlotManager]: crate::slot::SlotManager
> +#![allow(dead_code)]
> +
> +use core::{
> +    mem::take,
> +    ops::{
> +        Deref,
> +        DerefMut, //
> +    }, //
> +};
> +
> +use kernel::{
> +    prelude::*,
> +    sync::LockedBy, //
> +};
> +
> +/// Seat information.
> +///
> +/// This can't be accessed directly by the element embedding a =
`Seat`,
> +/// but is used by the generic slot manager logic to control =
residency
> +/// of a certain object on a hardware slot.
> +pub(crate) struct SeatInfo {
> +    /// Slot used by this seat.
> +    ///
> +    /// This index is only valid if the slot pointed to by this index
> +    /// has its `SlotInfo::seqno` match `SeatInfo::seqno`. Otherwise,
> +    /// it means the object has been evicted from the hardware slot,
> +    /// and a new slot needs to be acquired to make this object
> +    /// resident again.
> +    slot: u8,
> +
> +    /// Sequence number encoding the last time this seat was active.
> +    /// We also use it to check if a slot is still bound to a seat.
> +    seqno: u64,
> +}
> +
> +/// Seat state.
> +///
> +/// This is meant to be embedded in the object that wants to acquire
> +/// hardware slots. It also starts in the `Seat::NoSeat` state, and
> +/// the slot manager will change the object value when an =
active/evict
> +/// request is issued.
> +#[derive(Default)]
> +pub(crate) enum Seat {
> +    #[expect(clippy::enum_variant_names)]
> +    /// Resource is not resident.
> +    ///
> +    /// All objects start with a seat in the `Seat::NoSeat` state. =
The seat also
> +    /// gets back to that state if the user requests eviction. It
> +    /// can also end up in that state next time an operation is done
> +    /// on a `Seat::Idle` seat and the slot manager finds out this
> +    /// object has been evicted from the slot.
> +    #[default]
> +    NoSeat,
> +
> +    /// Resource is actively used and resident.
> +    ///
> +    /// When a seat is in the `Seat::Active` state, it can't be =
evicted, and the
> +    /// slot pointed to by `SeatInfo::slot` is guaranteed to be =
reserved
> +    /// for this object as long as the seat stays active.
> +    Active(SeatInfo),
> +
> +    /// Resource is idle and might or might not be resident.
> +    ///
> +    /// When a seat is in the`Seat::Idle` state, we can't know for =
sure if the
> +    /// object is resident or evicted until the next request we issue
> +    /// to the slot manager. This tells the slot manager it can
> +    /// reclaim the underlying slot if needed.
> +    /// In order for the hardware to use this object again, the seat
> +    /// needs to be turned into an `Seat::Active` state again
> +    /// with a `SlotManager::activate()` call.
> +    Idle(SeatInfo),
> +}
> +
> +impl Seat {
> +    /// Get the slot index this seat is pointing to.
> +    ///
> +    /// If the seat is not `Seat::Active` we can't trust the
> +    /// `SeatInfo`. In that case `None` is returned, otherwise
> +    /// `Some(SeatInfo::slot)` is returned.
> +    pub(super) fn slot(&self) -> Option<u8> {

Can we use on pub(crate) instead of pub(super)?

> +        match self {
> +            Self::Active(info) =3D> Some(info.slot),
> +            _ =3D> None,
> +        }
> +    }
> +}
> +
> +/// Information related to a slot.
> +struct SlotInfo<T> {
> +    /// Type specific data attached to a slot.
> +    slot_data: T,
> +
> +    /// Sequence number from when this slot was last activated.
> +    seqno: u64,
> +}
> +
> +/// Slot state.
> +#[derive(Default)]
> +enum SlotState<T> {
> +    /// Slot is free.
> +    #[default]
> +    Free,
> +
> +    /// Slot is active.
> +    Active(SlotInfo<T>),
> +
> +    /// Slot is idle.
> +    Idle(SlotInfo<T>),
> +}
> +
> +/// Trait describing the slot-related operations.
> +pub(crate) trait SlotOperations {
> +    /// Implementation-specific data associated with each slot.
> +    type SlotData;
> +
> +    /// Called when a slot is being activated for a seat.
> +    fn activate(&mut self, _slot_idx: usize, _slot_data: =
&Self::SlotData) -> Result {
> +        Ok(())
> +    }
> +
> +    /// Called when a slot is being evicted and freed.
> +    fn evict(&mut self, _slot_idx: usize, _slot_data: =
&Self::SlotData) -> Result {
> +        Ok(())
> +    }
> +}
> +
> +/// A generic slot manager that provides access to a limited number =
of hardware slots.
> +pub(crate) struct SlotManager<T: SlotOperations, const MAX_SLOTS: =
usize> {
> +    /// A specific implementation of the generic slot manager.
> +    manager: T,
> +
> +    /// Number of slots actually available.
> +    slot_count: usize,
> +
> +    /// Slot array used to track the state of each slot.
> +    slots: [SlotState<T::SlotData>; MAX_SLOTS],
> +
> +    /// Sequence number incremented each time a Seat is successfully =
activated
> +    use_seqno: u64,
> +}
> +
> +/// A `Seat` that can only be accessed when holding a `SlotManager` =
lock guard.
> +type LockedSeat<T, const MAX_SLOTS: usize> =3D LockedBy<Seat, =
SlotManager<T, MAX_SLOTS>>;
> +
> +impl<T: SlotOperations, const MAX_SLOTS: usize> SlotManager<T, =
MAX_SLOTS> {
> +    /// Creates a specific instance of a slot manager.
> +    pub(crate) fn new(manager: T, slot_count: usize) -> Result<Self> =
{
> +        if slot_count =3D=3D 0 {
> +            pr_err!("Invalid slot count: 0");
> +            return Err(EINVAL);
> +        }
> +        if slot_count > MAX_SLOTS {
> +            pr_err!(
> +                "Slot count: {} cannot exceed MAX_SLOTS: {}",
> +                slot_count,
> +                MAX_SLOTS
> +            );
> +            return Err(EINVAL);
> +        }
> +        Ok(Self {
> +            manager,
> +            slot_count,
> +            slots: [const { SlotState::Free }; MAX_SLOTS],
> +            use_seqno: 1,
> +        })
> +    }
> +
> +    /// Records a slot as active for the given seat.
> +    fn record_active_slot(
> +        &mut self,
> +        slot_idx: usize,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) -> Result {

This looks infallible?

> +        let cur_seqno =3D self.use_seqno;
> +
> +        *locked_seat.access_mut(self) =3D Seat::Active(SeatInfo {
> +            slot: slot_idx as u8,
> +            seqno: cur_seqno,
> +        });
> +
> +        self.slots[slot_idx] =3D SlotState::Active(SlotInfo {
> +            slot_data,
> +            seqno: cur_seqno,
> +        });
> +
> +        self.use_seqno +=3D 1;
> +        Ok(())
> +    }
> +
> +    /// Activates a slot for the given seat.
> +    fn activate_slot(
> +        &mut self,
> +        slot_idx: usize,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) -> Result {
> +        self.manager.activate(slot_idx, &slot_data)?;
> +        self.record_active_slot(slot_idx, locked_seat, slot_data)
> +    }
> +
> +    /// Finds a slot for the given seat. A free slot is preferred, =
but if none
> +    /// are available, the oldest idle slot is evicted and reused. =
Otherwise, if
> +    /// there are no free or idle slots, return [`EBUSY`].
> +    fn allocate_slot(
> +        &mut self,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) -> Result {
> +        let slots =3D &self.slots[..self.slot_count];
> +
> +        let mut idle_slot_idx =3D None;
> +        let mut idle_slot_seqno: u64 =3D 0;
> +
> +        for (slot_idx, slot) in slots.iter().enumerate() {
> +            match slot {
> +                SlotState::Free =3D> {
> +                    return self.activate_slot(slot_idx, locked_seat, =
slot_data);
> +                }
> +                SlotState::Idle(slot_info) =3D> {
> +                    if idle_slot_idx.is_none() || slot_info.seqno < =
idle_slot_seqno {
> +                        idle_slot_idx =3D Some(slot_idx);
> +                        idle_slot_seqno =3D slot_info.seqno;
> +                    }
> +                }
> +                SlotState::Active(_) =3D> (),
> +            }
> +        }
> +
> +        match idle_slot_idx {
> +            Some(slot_idx) =3D> {
> +                // Lazily evict idle slot just before it is reused.
> +                if let SlotState::Idle(slot_info) =3D =
&self.slots[slot_idx] {
> +                    self.manager.evict(slot_idx, =
&slot_info.slot_data)?;
> +                }
> +                self.activate_slot(slot_idx, locked_seat, slot_data)
> +            }
> +            None =3D> {
> +                pr_err!(
> +                    "Slot allocation failed: all {} slots in use\n",
> +                    self.slot_count
> +                );
> +                Err(EBUSY)
> +            }
> +        }
> +    }
> +
> +    /// Converts an active slot and its seat to idle state.
> +    fn idle_slot(&mut self, slot_idx: usize, locked_seat: =
&LockedSeat<T, MAX_SLOTS>) -> Result {
> +        let slot =3D take(&mut self.slots[slot_idx]);

I think it=E2=80=99d be clearer to have mem::take here instead of take.

> +
> +        // If the slot was active, make it idle.
> +        if let SlotState::Active(slot_info) =3D slot {
> +            self.slots[slot_idx] =3D SlotState::Idle(slot_info);

Is it me or we don=E2=80=99t place the slot back in the array if the =
slot is
already idle? Looking at the caller, it seems like this can=E2=80=99t =
happen today,
but still, perhaps we should use a match here as future-proofing

I think that would fit better, specially given the fact that the code =
below
does use a match.

> +        }
> +
> +        // If the seat was active, make it idle, or keep it idle if =
it was already idle.
> +        *locked_seat.access_mut(self) =3D match =
locked_seat.access(self) {
> +            Seat::Active(seat_info) | Seat::Idle(seat_info) =3D> =
Seat::Idle(SeatInfo {
> +                slot: seat_info.slot,
> +                seqno: seat_info.seqno,
> +            }),
> +            Seat::NoSeat =3D> Seat::NoSeat,
> +        };

> +        Ok(())
> +    }
> +
> +    /// Evicts an active or idle slot: calls the eviction callback =
and marks the slot as free
> +    /// and the seat as NoSeat.
> +    fn evict_slot(&mut self, slot_idx: usize, locked_seat: =
&LockedSeat<T, MAX_SLOTS>) -> Result {
> +        match &self.slots[slot_idx] {
> +            SlotState::Active(slot_info) | SlotState::Idle(slot_info) =
=3D> {
> +                self.manager.evict(slot_idx, &slot_info.slot_data)?;
> +                take(&mut self.slots[slot_idx]);
> +            }
> +            _ =3D> (),
> +        }
> +
> +        *locked_seat.access_mut(self) =3D Seat::NoSeat;
> +        Ok(())
> +    }
> +
> +    /// Checks that the seat state matches the slot's state.
> +    /// If they don't match, the seat is stale and is reset to =
`NoSeat`.
> +    fn check_seat(&mut self, locked_seat: &LockedSeat<T, MAX_SLOTS>) =
{
> +        let (slot_idx, seat_seqno, is_active) =3D match =
locked_seat.access(self) {
> +            Seat::Active(seat_info) =3D> (seat_info.slot as usize, =
seat_info.seqno, true),
> +            Seat::Idle(seat_info) =3D> (seat_info.slot as usize, =
seat_info.seqno, false),
> +            _ =3D> return,
> +        };
> +
> +        let valid =3D if is_active {
> +            !kernel::warn_on!(!matches!(
> +                &self.slots[slot_idx],
> +                SlotState::Active(slot_info) if slot_info.seqno =3D=3D =
seat_seqno
> +            ))
> +        } else {
> +            matches!(
> +                &self.slots[slot_idx],
> +                SlotState::Idle(slot_info) if slot_info.seqno =3D=3D =
seat_seqno
> +            )
> +        };
> +
> +        if !valid {
> +            *locked_seat.access_mut(self) =3D Seat::NoSeat;
> +        }
> +    }
> +
> +    /// Activate a resource on any available/reclaimable slot.
> +    pub(crate) fn activate(
> +        &mut self,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) -> Result {
> +        self.check_seat(locked_seat);
> +        match locked_seat.access(self) {
> +            // If a seat still has a valid slot, just reuse the slot =
and refresh the bookkeeping.
> +            Seat::Active(seat_info) | Seat::Idle(seat_info) =3D> {
> +                self.record_active_slot(seat_info.slot as usize, =
locked_seat, slot_data)
> +            }
> +            _ =3D> self.allocate_slot(locked_seat, slot_data),
> +        }
> +    }
> +
> +    /// Flag a resource as idle. This method will be used for user VM =
support.
> +    #[expect(dead_code)]
> +    pub(crate) fn idle(&mut self, locked_seat: &LockedSeat<T, =
MAX_SLOTS>) -> Result {
> +        self.check_seat(locked_seat);
> +        if let Seat::Active(seat_info) =3D locked_seat.access(self) {
> +            self.idle_slot(seat_info.slot as usize, locked_seat)?;
> +        }
> +        Ok(())
> +    }
> +
> +    /// Evict a resource from its slot.
> +    pub(crate) fn evict(&mut self, locked_seat: &LockedSeat<T, =
MAX_SLOTS>) -> Result {
> +        self.check_seat(locked_seat);
> +
> +        match locked_seat.access(self) {
> +            Seat::Active(seat_info) | Seat::Idle(seat_info) =3D> {
> +                let slot_idx =3D seat_info.slot as usize;
> +                self.evict_slot(slot_idx, locked_seat)?;
> +            }
> +            _ =3D> (),
> +        }
> +
> +        Ok(())
> +    }
> +}
> +
> +impl<T: SlotOperations, const MAX_SLOTS: usize> Deref for =
SlotManager<T, MAX_SLOTS> {
> +    type Target =3D T;
> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.manager
> +    }
> +}
> +
> +impl<T: SlotOperations, const MAX_SLOTS: usize> DerefMut for =
SlotManager<T, MAX_SLOTS> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.manager
> +    }
> +}
> diff --git a/drivers/gpu/drm/tyr/tyr.rs b/drivers/gpu/drm/tyr/tyr.rs
> index 95cda7b0962f..7c9a8063b3b9 100644
> --- a/drivers/gpu/drm/tyr/tyr.rs
> +++ b/drivers/gpu/drm/tyr/tyr.rs
> @@ -12,6 +12,7 @@
> mod gem;
> mod gpu;
> mod regs;
> +mod slot;
>=20
> kernel::module_platform_driver! {
>     type: TyrPlatformDriver,
>=20
> --=20
> 2.54.0
>=20

