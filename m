Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3274EC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 03:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E6710E233;
	Tue, 14 Jul 2026 03:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Sm9VTPJU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C23010E233
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 03:26:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70A30601DE;
 Tue, 14 Jul 2026 03:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00F31F000E9;
 Tue, 14 Jul 2026 03:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783999609;
 bh=SYwzNm8AN9YJXw0TJtGM6715/FEv+mMfOi9OnDhupl8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Sm9VTPJUUwkNIWE8eb89FiZmdUjKN/KSojOAiwejtKSi3UaZ/mDtB37zg4zZqE6ta
 NzyobO4Tox+/cBapv5KW2T5eUeQAf+BS/VS56FrzV+C+DSwOkPYuMcsx2NOWaW9run
 qAOJOhGJ2mGMxrc59VzBytpCqq/kABuI8GibTG7icpXHHi9/glKs6BR+3D0oiRhig6
 0P2v0LsM6cbO497tmRqMT99+Kf13W40Zkvznz96bvU4FKPUn0rw4wDg/VeE7DVqNIv
 s+E90rmVoGiwgssC27+rhuoAlx3/O5eWRdt/vJrb3k5sBhsUYPYzg5PvBU/xsMon33
 OhB/quDCn21Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/7] drm/tyr: add a generic slot manager
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260713-fw-boot-b4-v7-2-afd8dc1494dd@collabora.com>
References: <20260713-fw-boot-b4-v7-0-afd8dc1494dd@collabora.com>
 <20260713-fw-boot-b4-v7-2-afd8dc1494dd@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 03:26:48 +0000
Message-Id: <20260714032648.F00F31F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Hardware and software slot states diverge when `manager.activate()=
` fails after a successful lazy eviction.
- [Medium] Truncation of `slot_idx` to `u8` causes permanent leakage of har=
dware slots when `MAX_SLOTS > 256`.
- [Medium] Re-activating an already valid seat with new `slot_data` updates=
 the software tracking but fails to reprogram the hardware, leading to mism=
atched eviction.
--

--- Patch [2]: [PATCH v7 2/7] drm/tyr: add a generic slot manager ---
commit aac93e6de5af8d0538293cb60a9c909446516880
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add a generic slot manager
   =20
Introduce a generic slot manager to dynamically allocate limited hardware
slots to software "seats". It can be used for both address space (AS) and
command stream group (CSG) slots.
   =20
The slot manager initially assigns seats to its free slots. It will
continue to reuse the same slot for a seat, as long as another seat does
not start to use the slot in the interim.
   =20
When contention arises because all of the slots are allocated, the slot
manager will lazily evict and reuse slots that have become idle (if any).
   =20
The seat state is protected using the LockedBy pattern with the same lock
that guards the SlotManager. This ensures the seat state stays consistent
across slot operations.
   =20
Hardware specific behaviour is controlled through the SlotManager's
specific manager type that implements the `SlotOperations` trait.

> diff --git a/drivers/gpu/drm/tyr/slot.rs b/drivers/gpu/drm/tyr/slot.rs
> new file mode 100644
> index 0000000000000..5c266fcf30eab
> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/slot.rs
> @@ -0,0 +1,378 @@
[ ... ]
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
[ ... ]
> +impl<T: SlotOperations, const MAX_SLOTS: usize> SlotManager<T, MAX_SLOTS=
> {
> +    /// Creates a specific instance of a slot manager.
> +    pub(crate) fn new(manager: T, slot_count: usize) -> Result<Self> {
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
> +        let cur_seqno =3D self.use_seqno;
> +
> +        *locked_seat.access_mut(self) =3D Seat::Active(SeatInfo {
> +            slot: slot_idx as u8,

[Severity: Medium]
Since the SlotManager::new() constructor accepts any usize for slot_count,
what happens if a driver instantiates this generic manager with > 256 slots?

In SeatInfo, the slot is stored as a u8:

    slot: u8,

When record_active_slot() assigns a slot, it unconditionally casts the inde=
x:

    slot: slot_idx as u8,

If an index >=3D 256 is used, wouldn't it silently truncate? During subsequ=
ent
operations, check_seat() would read the truncated index, fail the sequence
number validation against the wrong slot, and forcefully transition the seat
to NoSeat. Would the actual high-index hardware slot remain stuck in
SlotState::Active forever, causing a resource leak?

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
[ ... ]
> +    /// Finds a slot for the given seat. A free slot is preferred, but i=
f none
> +    /// are available, the oldest idle slot is evicted and reused. Other=
wise, if
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
> +                    return self.activate_slot(slot_idx, locked_seat, slo=
t_data);
> +                }
> +                SlotState::Idle(slot_info) =3D> {
> +                    if idle_slot_idx.is_none() || slot_info.seqno < idle=
_slot_seqno {
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
> +                if let SlotState::Idle(slot_info) =3D &self.slots[slot_i=
dx] {
> +                    self.manager.evict(slot_idx, &slot_info.slot_data)?;
> +                }
> +                self.activate_slot(slot_idx, locked_seat, slot_data)

[Severity: High]
What happens to the software state if self.manager.evict() succeeds, but
self.activate_slot() fails (e.g. due to a hardware timeout)?

If self.activate_slot() returns an error, the function returns early.
Crucially, the software state in self.slots[slot_idx] is not cleared to
SlotState::Free and remains SlotState::Idle(old_slot_info).

When the previous owner of that slot later calls activate(), won't
check_seat() see matching sequence numbers and leave the seat valid?

Could the seat then seamlessly transition to Active without calling
manager.activate(), resulting in the software thinking it is active while
the hardware is actually evicted?

> +            }
> +            None =3D> Err(EBUSY),
> +        }
> +    }
[ ... ]
> +    /// Activate a resource on any available/reclaimable slot.
> +    pub(crate) fn activate(
> +        &mut self,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) -> Result {
> +        self.check_seat(locked_seat);
> +        match locked_seat.access(self) {
> +            // If a seat still has a valid slot, just reuse the slot and=
 refresh the bookkeeping.
> +            Seat::Active(seat_info) | Seat::Idle(seat_info) =3D> {
> +                self.record_active_slot(seat_info.slot as usize, locked_=
seat, slot_data)

[Severity: Medium]
Can slot_data change between activations of the same seat?

If a seat is already Active or Idle, activate() calls record_active_slot()
directly. This updates the software tracking in self.slots[slot_idx] with
the newly provided slot_data, but skips calling self.manager.activate().

If the new slot_data differs from the data originally used to program the
hardware, won't the hardware continue operating with the old configuration?
Furthermore, when the slot is eventually evicted, would self.manager.evict()
be invoked with the newly updated slot_data, potentially passing incorrect
parameters to the hardware unprogramming routine?

> +            }
> +            _ =3D> self.allocate_slot(locked_seat, slot_data),
> +        }
> +    }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713-fw-boot-b4=
-v7-0-afd8dc1494dd@collabora.com?part=3D2
