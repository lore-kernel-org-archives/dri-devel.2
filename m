Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F8BC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 01:01:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C77810EBF3;
	Wed, 22 Jul 2026 01:01:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="j9WlEXmS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5472810EBF3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 01:01:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D105402B6;
 Wed, 22 Jul 2026 01:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAD411F000E9;
 Wed, 22 Jul 2026 01:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784682088;
 bh=j/lX1enO0GcHpC/n8g5LVwQ1h8xezuhujH7moU7egUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=j9WlEXmS1vfGjnH6eMIbavlnhtGZVYWF3m2nWXMUdCyIj9MG7mUfyZbdJ1kp368wV
 JbfjKda5zvc7wkoa1RcZXpe+VaGHby3pFXKk6NtDcSAG/8mG2RAL3n7Iz+T890/A4L
 hjfav9q6c7w7DptB2gtiIkn2UR2b2e0Kunicqm2sKTOfbl0V+pc4u9LMzqnF//gJAV
 aYjz/Fh6ct7UukO92dRg5fxHqa4GIWeBwjbfwmm6S7VSeN3nLlvBeBvd9QX/s2ZoSN
 2wV4y1HroF18yn7iYHjHDQCF//CsJSkbwq6aXQeOmtn3TIECzhVIBVsWLs1ly7Q0rs
 AY1nS+tNex2JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/7] drm/tyr: add a generic slot manager
To: "Deborah Brouwer" <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, ojeda@kernel.org
In-Reply-To: <20260721-fw-boot-b4-v8-2-b28f744581c9@collabora.com>
References: <20260721-fw-boot-b4-v8-0-b28f744581c9@collabora.com>
 <20260721-fw-boot-b4-v8-2-b28f744581c9@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 01:01:27 +0000
Message-Id: <20260722010127.DAD411F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `SlotManager::activate` is a safe function but can cause a Use-Aft=
er-Free and hardware state corruption if called with mismatched `slot_data`=
 on an already active seat.
--

--- Patch [2]: [PATCH v8 2/7] drm/tyr: add a generic slot manager ---
commit c0b62f1ee506ab72e8c6ddd5dd7d561783c86a38
Author: Boris Brezillon <boris.brezillon@collabora.com>

drm/tyr: add a generic slot manager

Introduce a generic slot manager to dynamically allocate limited hardware
slots to software "seats". It handles address space and command stream
group slots, lazily evicting idle slots when contention arises.

> --- /dev/null
> +++ b/drivers/gpu/drm/tyr/slot.rs
[ ... ]
> +    /// Records a slot as active for the given seat.
> +    fn record_active_slot(
> +        &mut self,
> +        slot_idx: usize,
> +        locked_seat: &LockedSeat<T, MAX_SLOTS>,
> +        slot_data: T::SlotData,
> +    ) {
[ ... ]
> +        self.slots[slot_idx] =3D Slot::Active(SlotInfo {
> +            slot_data,
> +            seqno: cur_seqno,
> +        });
> +
> +        self.use_seqno +=3D 1;
> +    }
[ ... ]
> +    /// Activates a resource on any available/reclaimable slot.
> +    ///
> +    /// TODO: add a mechanism to ensure that `locked_seat` and `slot_dat=
a` belong to the
> +    /// same seat owner since they may be reused. For now the caller has=
 to be careful
> +    /// to do this correctly.
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
seat, slot_data);

[Severity: High]
When a seat is already active or idle, this branch refreshes the slot by
calling record_active_slot() with the newly provided slot_data, but without
calling self.manager.activate() to update the hardware.

In record_active_slot(), the assignment to self.slots[slot_idx] overwrites
the old SlotInfo and drops the previous slot_data.

If the old slot_data held the last reference to resources mapped to the
hardware (such as DMA buffers or pagetables), could they be freed while the
hardware is still actively using them, causing a use-after-free?

Furthermore, when the slot is later evicted, self.manager.evict() will be
called with the newly provided slot_data instead of the old one. Could this
confuse the eviction logic and corrupt hardware state?

Since activate() is a safe function, relying on callers to be careful about
mismatched slot_data without marking the function unsafe or enforcing the
invariant at runtime seems to violate Rust's soundness guarantees. Is there=
 a
plan to implement the mechanism mentioned in the TODO before this is merged?

> +                Ok(())
> +            }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721-fw-boot-b4=
-v8-0-b28f744581c9@collabora.com?part=3D2
