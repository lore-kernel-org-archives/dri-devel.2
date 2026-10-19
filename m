Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 349F9CCF2D3
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 04:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 614AA10E778;
	Mon, 19 Oct 2026 04:37:41 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D5E10E778
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 04:37:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9687B601DB;
 Mon, 19 Oct 2026 04:37:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721E81F000C4;
 Mon, 19 Oct 2026 04:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792384653;
 bh=d+qqxLO0uMgUfP0IagOu8i6E4S3pBHSASehhGJyH+S4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Pct28buNLdmszT33OjrkZxssR1Wc+lIkLprI0go3bot1IHKbvvzPngcyWAQgmTueq
 ewcc8OkDCeu2SUdBQVw9kFxxUHIRoFUbMGBniLTFNVtl9rm5CAYkZOHq4j+Y/7mD8D
 aiKnsrfQKD5uN6yzm8RuAnRKVXFE+kfqtUikAwtXk7Wa+84iG2zdGFrttiB0USh7eN
 ezRhh+ES/0qrsRHlGqP700AxB/Ni/MyL9LxK1v3hGVta6d0zLCOXAAs4sLzdd/OmNJ
 W32nAHyPERlZu5ZixB9MpkU76mqiCYk2kfmG6scikuNSQPjaLiooYvJTewVLrXyBUH
 IRTrtC9DMksog==
Message-ID: <sashiko-outbox-176642@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 3/3] gpu: nova-core: add ChannelIdPool
To: "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Burak
 Emir" <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 "Gary Guo" <gary@garyguo.net>, 
 =?utf-8?b?QmrDtnJuIFJveSBCYXJvbg==?= <bjorn3_gh@protonmail.com>, "Benno
 Lossin" <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?b?T251ciDDlnprYW4=?= <work@onurozkan.dev>, "David
 Airlie" <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "John Hubbard" <jhubbard@nvidia.com>, "Alistair
 Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Zhi Wang" <zhiw@nvidia.com>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261019-chid-v10-3-67de9180b4ed@nvidia.com>
References: <20261019-chid-v10-0-67de9180b4ed@nvidia.com>
 <20261019-chid-v10-3-67de9180b4ed@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 04:37:32 +0000
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
- [Low] gpu: nova-core: call to missing IdPool::reserve_ids() and release_i=
ds()
--

commit 086e60d9f7e7ac9b6628a571ed585382eb5212a9
Author: Eliot Courtney <ecourtney@nvidia.com>

gpu: nova-core: add ChannelIdPool

This commit introduces ChannelIdPool on top of IdPool to automatically
track and release contiguous ranges of channel IDs for nova-core.

Link: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvid=
ia.com/ # [1]
Link: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nvi=
dia.com/ # [2]
Link: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.com=
/ # [3]

> diff --git a/drivers/gpu/nova-core/gpu/channel.rs b/drivers/gpu/nova-core=
/gpu/channel.rs
> new file mode 100644
> index 0000000000000..485efaba059d9
> --- /dev/null
> +++ b/drivers/gpu/nova-core/gpu/channel.rs
> @@ -0,0 +1,198 @@
[ ... ]
> +impl ChannelIdPool {
> +    /// Creates a pool managing `num_chids` channel IDs.
> +    pub(crate) fn new(num_chids: NonZero<usize>) -> impl PinInit<Self, E=
rror> {
> +        try_pin_init!(Self {
> +            inner <- new_mutex!(IdPool::with_capacity(num_chids.get(), G=
FP_KERNEL)?),
> +        })
> +    }
> +
> +    /// Reserves a contiguous area of `count` channel IDs starting at a =
multiple of `align`,
> +    /// returning a guard that releases the area on drop.
> +    pub(crate) fn reserve_ids(
> +        &self,
> +        count: NonZero<usize>,
> +        align: Alignment,
> +    ) -> Result<ChannelIdReservation<'_>> {
> +        let mut ids =3D self.inner.lock();
> +        let range =3D ids.reserve_ids(0, count, align).ok_or(ENOSPC)?;
> +        Ok(ChannelIdReservation { pool: self, range })
> +    }
> +}
> +
> +/// A reserved contiguous area of channel IDs.
> +///
> +/// Releases the whole area back to its [`ChannelIdPool`] when dropped. =
Releasing locks a
> +/// sleeping [`Mutex`], so the area must be dropped in a context that is=
 allowed to sleep.
> +#[must_use =3D "the channel ID reservation is released immediately when =
unused"]
> +pub(crate) struct ChannelIdReservation<'a> {
> +    pool: &'a ChannelIdPool,
> +    range: Range<usize>,
> +}
> +
> +impl Drop for ChannelIdReservation<'_> {
> +    fn drop(&mut self) {
> +        self.pool.inner.lock().release_ids(&self.range);
> +    }
> +}

[Severity: Low]
Does this fail to build under CONFIG_NOVA_CORE due to a missing prerequisite
patch for IdPool?

In drivers/gpu/nova-core/gpu/channel.rs, ChannelIdPool::reserve_ids() calls
ids.reserve_ids(0, count, align), and <ChannelIdReservation as Drop>::drop()
calls release_ids(&self.range).

However, in rust/kernel/id_pool.rs, kernel::id_pool::IdPool only defines
single-ID operations:

    pub fn find_unused_id(&mut self, offset: usize) -> Option<usize> {
        self.map.next_zero_bit(offset).map(|id| {
            self.map.set_bit(id);
            id
        })
    }

    pub fn release_id(&mut self, id: usize) {
        self.map.clear_bit(id);
    }

Neither IdPool::reserve_ids() nor IdPool::release_ids() exists in the tree =
yet.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-chid-v10-0=
-67de9180b4ed@nvidia.com?part=3D3
