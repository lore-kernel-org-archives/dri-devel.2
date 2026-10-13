Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3936CC6B03
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 13:27:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3426B10E0AA;
	Tue, 13 Oct 2026 13:26:57 +0000 (UTC)
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CDF510E0AA
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:26:51 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-33c30fcf33fso385902eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 06:26:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791898010; cv=none;
 d=google.com; s=arc-20260327;
 b=munDGb2SSgtwwGlRpcCj6Cxp+2FFUPvEN1SHg7z7l7G+WXDwERRlt5CjT6lWgJz2rH
 9L4YibUxaxvpgWPXOpgEzOXaNAInMUEq9RSIuPUOBwKDpN4x0fVkw6RHQ8BhIviQOrFB
 H45gPF3gsT0MyVynfxCnmVszrNgOVtGs3EyOt9olIuf2KUlN6QsOg6FCp9YZF8NRLerJ
 91WhmqPBT+VBJH16ZANMtMjM0wqe8+jIj2uS/h7m+5eRetmAQ36qx/pY1VTXg26lWCME
 BShnWfN1nNUBBcHsXx1KczGDgFDqtVCtE4cLzWD9EDxnp9IfpU3GRjhaTnL7uWbmcp8m
 8RUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fGIxI7204PZMse0yE/ISC/r7QTFczS4XL47HKFAk11s=;
 fh=ShmaYxBziIrDHNDYKtl1iBwbNH7ZGSGZuvaWhCnqa8o=;
 b=dAplDZXO02s+VDB688NznwQVV0P6igOZ6q/F3V3vtLhja+yD8E/sJZDrHJz5QY3E+i
 3gdn+fD9lSmWeJIl5QJwW/Fbp0bseMoryjT9OVcFITbPcTe6LpudnpmN0Uztrlw1Qs1k
 qDDQsYWv579xTvnHvW9sCJwd75jMA0L4nfwbjN46NDrSqMM+GtRQ1eBp3W4eroL4loTr
 BpPWuGzEyUB+leGb6FXAd8GESp/HKKlc+AMRLWzQi71+xf2CCdGRoUWtTDyfrgSANB5O
 pojnw0ZgM/hQwlYuuQt/YNR3w0x+MFWlNKabciZfE+yUua1mDKW1bc7x7wN43+2ftPCO
 yB5w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791898010; x=1792502810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fGIxI7204PZMse0yE/ISC/r7QTFczS4XL47HKFAk11s=;
 b=QnaGLNWABcBl42jW5IRqg5lLjk+sU8SFnbBLFczNF3UU1kr/u8UAXqXmK22TWxOZBU
 9/+7JDab4ejsLyclwHVYI0FgCqihT2AYLvzjEkMMaiac0+M1uSI+nhX2al34izeiYMR5
 u4urmM6ZqUtweorkAvqKWtqzts+WFQcPG2/ohtFOniqLOXzYlE9BHuwmdAuRA++kz35W
 XFSs/MlapSz7QKSRZ7igyH+Ig+bA2QCLcNKHC6/YZonurHQYmOrPep7ezn2+nXPo+Dlu
 Wuvc+3OeXwSkXcNzlKdOmDTMnyE6ZP/wjYixuMQUcERH6e9hq58hwC5h3XlPojkJrt40
 Z8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791898010; x=1792502810;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fGIxI7204PZMse0yE/ISC/r7QTFczS4XL47HKFAk11s=;
 b=z3dB/7b4yBgyEKT9EYRYyMJgFKZVP/STdzW0/FMjdGGNgF0t/CpjBUiXPN/APRBYpG
 /VSeD6vdhT5UPCtebo5YnZtprr63UEG6lLTg85rYkpnd1JlB1csl1CPtNrf6tQHRfpiq
 bc5zTu0KRymqJ02tKz9+f7TNwQZxWwXCw3Xpq90IoM72YBahYIpM2YJ+9Xcgrsuw0y6a
 dQy5DdY0rlHwY9Oi1vtNotTn9WegatFE+7VSAI0R1QCpOEgrLC1JxI5i8BTLHDc4gGT7
 OAzgmDLcB3zG3wBLbY6TEACFRDQSageBsEtNPp8Wxk1CqNv0tsaLasFfieG9gFlwElJv
 ly1A==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ4bGG80YVaD6YFHwX0FXYeFu1YnXrZxL2P0OQ5ZxyLjyWEADi5q/f2DWwuLrF6LnQY/eDXzExoQY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKwFk8lM6GbPuhgRqHMlhvwSsf+ljjtKZCEhsQqC3BkENc2wBCe
 jwN0Sj8S1l4WoApkSmKsc070nXrA7jgqBQppzvbUOYeaUrzerSJ4aYWMoReuWCo5ZcOzPTsoLSQ
 kOrVoevTbV3qpd/QBaUFXTOTKJ/wMrS0=
X-Gm-Gg: AYBFou0p42Q2kZYlFSQ5u1zM5nLV+cz8XEkBespfJMAY2xfEu0s8g+hwsg7jBvsnsr0
 V9U4HO6JWwZn80BqcHc28CDkZSRn3vx2s6xUDYB/9p7kxPXQ8vYTXOZcnEJSgxKdnrknllxC460
 487IxVuahID7QKFBpwsGtv6GCWQ2CjzsE9WGGIBI0L+wf93vexGEfqx96JXHUyzpSCv0W142oKe
 /NOecXKCebqYv7wTKvE3azqErsu/RTVAoaXUGwu3Nv4rPVCsqr+vbolE7+EVxe6pdacJNlwTzPs
 PXBbO99jutWeMWgI8lWH6bhSL7ZUQgt7fVOsuaT4tixmelf/WHHMR6Mm6Bte7g/QEiqcr7Q7W2x
 QvTcx9z48FwUMNYkvZ8+8zK6gJTP25V0bJxQkEjZsy5+PqSjpn7krgJemY0o2KuH1J4dCaC1bpO
 wSVusmeucq2alO/EqbIBpJMH2/TsUQDvkQb2zoQRVPgyFTkLmijhs=
X-Received: by 2002:a05:693c:8810:20b0:35b:cb5b:c71e with SMTP id
 5a478bee46e88-35bcb6b1c6cmr7485005eec.1.1791898010056; Tue, 13 Oct 2026
 06:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
In-Reply-To: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 13 Oct 2026 15:26:36 +0200
X-Gm-Features: AclHuK8MId34SKofgkVHxoilN91tJK91SiQlB8ktXLqMDzqKOFOns7JAmHwAjko
Message-ID: <CANiq72kohkx1-9iendYSD4gML8wv5bF+HrY7RO2vagLhtXYSKQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/9] rust: Add support for reserving of ranges of IDs
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Burak Emir <burak.emir@gmail.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 Yury Norov <ynorov@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Sep 30, 2026 at 4:44=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Add support for reserving of ranges of IDs, with a usage in nova-core
> for channel IDs. This entails adding bindings for the C bitmap
> API for ranges of bits, then users of that in `IdPool`, and finally a
> user of `IdPool` in nova-core, `ChannelIdPool`.
>
> Channel ID tracking is needed for allotting ranges of channel IDs to
> vGPU guests, and later for regular host channel ID reservation.
> nova-core needs allocation of a contiguous sequence of IDs with a
> specific length and sometimes a specific alignment [1].
>
> About the tradeoffs between different data structures:
> - IDA/xarray do not support allocating a contiguous sequence of IDs
>   (ida_alloc_range() allocates a single ID within a range, not a contiguo=
us
>   sequence).
> - A maple tree works, but is not as good a fit. The ID space is small
>   (limited to 2048) and aligned allocation needs an alloc_range()+erase()=
 retry
>   loop (plus a Mutex around it, or new mas_empty_area() bindings) that
>   essentially reimplements bitmap_find_next_zero_area(). See the maple tr=
ee
>   version at [2]. For 2048 IDs a bitmap is also considerably faster and s=
maller
>   [3].
> - The bitmap API natively supports aligned contiguous area allocation
>   (bitmap_find_next_zero_area()).
>
> This is based on drm-rust-next and depends on the cv! series [4].
>
> [1]: https://lore.kernel.org/all/84bc8bd2-e292-4b84-9580-a1b5df4c5bdc@nvi=
dia.com/
> [2]: https://lore.kernel.org/all/20260710-chid-maple-v1-1-4ee869055268@nv=
idia.com/
> [3]: https://lore.kernel.org/all/20260717053241.916441-1-ynorov@nvidia.co=
m/
> [4]: https://lore.kernel.org/all/20260917-cv-v4-0-547ef5727451@nvidia.com=
/
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Applied (the following subset that Alexandre suggested in a sibling
reply) to `rust-next` -- thanks everyone!

>       rust: bitmap: use function-level cfg on kunit test
>       rust: bitmap: restrict bitmap length to at most i32::MAX
>       rust: sizes: add sub-1K size constants
>       rust: sizes: implement SizeConstants for Alignment
>       rust: bitmap: add contiguous area operations
>       rust: id_pool: add contiguous ID reservation

If someone does not want them to be applied for some reason, please shout.

For the second one:

    Cc: stable@vger.kernel.org
    [ Added a few intra-doc links. Added backticks to C types. Capitalize
      tagged comments. - Miguel ]

By the way, I didn't modify the patch for the following, but we should
migrate `id_pool.rs` to the vertical kernel style. Also, before I
forget, we can clean up a few consistency bits in `bitmap.rs` before
we keep extending it (like in one patch here) -- I can copy this to a
"good first issue" or I may just send it:

  - Fix the broken intra-doc link for `c_ulong`.
  - Add backticks around configs like `CONFIG_RUST_BITMAP_HARDENED`.
  - Capitalize tagged comments like `// INVARIANT: ...`.
  - Make periods consistent (adding them) at the end of bullet points.

Cheers,
Miguel
