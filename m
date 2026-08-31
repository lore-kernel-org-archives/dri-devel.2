Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2851C624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 15:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F9110E95F;
	Mon, 31 Aug 2026 15:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MpqdX/Gu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C52B10E95F
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:40:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3445601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 15:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8FB1F000E9;
 Mon, 31 Aug 2026 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788190844;
 bh=ecb88+bKQX0mzMVAx/wqX3VuEyd5q2bv9oPAnEtA4Ms=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MpqdX/Gu1owyg8fyWAYLdCd66yidsTaTCusJuVqgK9SCFHjUt72EElYZHNbghihvR
 eSnOM381DVB4X59SZ4vom7qYNEi+ICnrbEDPSWLkgYo2oQ4U5Zvyna4HHUKsEA+p3y
 kXMfocHsqBY9umqhPzsc+39EzLOW27WJA7xk6Da6pOANQsTLQN9vFnX1/AtTWo/KCQ
 sg502aol4GQXkzA/H0UlNeAhcFy5Z0ltIGqptsw6P7VObrm4ycS5U1ryysbx5thkNw
 dLVEErczPHUB1giboQLSfQ/HxoAWvMjDzwhrLJkAwRk72e4x1hA4UDPtZKK+vYAOPc
 o4ZlKhN8/dpUA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] drm/amd/ras: reset CPER ring on corrupt
 entry size
To: "Sasha Levin" <sashal@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831133314.4125787-317-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-317-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:40:43 +0000
Message-Id: <20260831154044.0A8FB1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `strcmp` on a non-null-terminated `char[4]` array causes out=
-of-bounds reads and relies on adjacent zero bytes.
- [High] Out-of-bounds memory read when CPER headers wrap around the end of=
 the ring buffer.
- [High] Incorrect read pointer calculation during CPER ring overflow recov=
ery causes random pointer jumps and can skip valid records.
- [High] Truncation in ring pointer arithmetic causes overlapping memory wr=
ites and severe data corruption when encountering corrupted old records.
--

commit f138b5a4c4364a5846a5ccacfcb8f7aaf6be9542
Author: Xiang Liu <xiang.liu@amd.com>

drm/amd/ras: reset CPER ring on corrupt entry size

This commit detects when a corrupt entry size causes the read pointer update
to make no progress during cper ring overflow recovery. Instead of getting
stuck in an infinite loop while holding the ring mutex, it resets the ring
to an empty state.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cper.c
> index 425a3e5643608..2694facb06c73 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
> @@ -465,7 +465,7 @@ static u32 amdgpu_cper_ring_get_ent_sz(struct amdgpu_=
ring *ring, u64 pos)
> =20
>  void amdgpu_cper_ring_write(struct amdgpu_ring *ring, void *src, int cou=
nt)
>  {
> -	u64 pos, wptr_old, rptr;
> +	u64 pos, wptr_old, rptr, next_rptr;
>  	int rec_cnt_dw =3D count >> 2;
>  	u32 chunk, ent_sz;

[Severity: High]
This is a pre-existing issue, but could the truncation in the ring pointer
arithmetic result in overlapping memory writes when old, corrupted records
are encountered?

In amdgpu_cper_ring_write(), new data writes are chunked based on the
ent_sz (record size) of the old, to-be-overwritten data:

drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c:amdgpu_cper_ring_write() {
    ...
    ent_sz =3D amdgpu_cper_ring_get_ent_sz(ring, ring->wptr);
    chunk =3D umin(ent_sz, count);

    memcpy(&ring->ring[ring->wptr], s, chunk);

    ring->wptr +=3D (chunk >> 2);
    ring->wptr &=3D ring->ptr_mask;
    ...
}

If the old data is corrupted, ent_sz (and thus chunk) can be an arbitrary
value not aligned to 4 bytes. memcpy() copies chunk bytes, but
ring->wptr +=3D (chunk >> 2) advances the pointer in dwords, truncating the
remainder.

For example, if chunk is 5, wptr advances by 1 dword. Will the next
iteration's memcpy start at the new wptr, overlapping and overwriting the
5th byte that was just written? If chunk < 4, does wptr advance by 0,
repeatedly overwriting the exact same dword?

[ ... ]

> @@ -506,9 +506,19 @@ void amdgpu_cper_ring_write(struct amdgpu_ring *ring=
, void *src, int count)
> =20
>  		do {
>  			ent_sz =3D amdgpu_cper_ring_get_ent_sz(ring, pos);

[Severity: High]
This is a pre-existing issue, but are out-of-bounds reads possible here
when calling amdgpu_cper_ring_get_ent_sz() and amdgpu_cper_is_hdr()?

When encountering garbage cper data (e.g., during overflow recovery or
reading uninitialized memory), those functions call strcmp() on
chdr->signature:

drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c:amdgpu_cper_is_hdr() {
    ...
    chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
    return strcmp(chdr->signature, "CPER") ? false : true;
}

Since signature is a char[4] with no null terminator, strcmp() will
continue reading memory. If the struct happens to reside at the very end
of the buffer, could this read into unmapped memory and cause a page
fault?

[Severity: High]
This is a pre-existing issue, but can these direct struct pointer casts
cause out-of-bounds memory reads when cper headers wrap around the end of
the ring buffer?

The writer seamlessly splits records across the ring boundary using
memcpy():

drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c:amdgpu_cper_ring_write() {
    ...
    memcpy(&ring->ring[ring->wptr], s, chunk);
    ...
}

However, amdgpu_cper_ring_get_ent_sz() casts the direct pointer and reads
fields that might be past the end of the buffer:

drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c:amdgpu_cper_ring_get_ent_sz() {
    ...
    chdr =3D (struct cper_hdr *)&(ring->ring[pos]);
    ...
    if (!strcmp(chdr->signature, "CPER")) {
        rec_len =3D chdr->record_length;
        goto calc;
    }
}

If pos is very close to the end of the buffer (e.g., < 5 dwords
remaining), does dereferencing chdr->record_length at offset 20 read past
the end of the allocated ring->ring array?

> +			next_rptr =3D rptr;
> +			if (ent_sz >=3D sizeof(u32))
> +				next_rptr =3D (rptr + (ent_sz >> 2)) & ring->ptr_mask;

[Severity: High]
This is a pre-existing issue, but might this logic incorrectly add a
size/distance offset derived from pos to the unrelated and stale pointer
rptr?

When the cper ring overflows, the recovery loop sets pos to locate the
oldest un-overwritten data, and gets its size via ent_sz.

However, instead of advancing pos by this size, it adds ent_sz to rptr
(the original read pointer, which is completely unrelated to pos and
points somewhere in the middle of the overwritten region).

Does this mathematically meaningless addition corrupt the read pointer and
cause valid records to be skipped?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-317-sashal@kernel.org?part=3D1
