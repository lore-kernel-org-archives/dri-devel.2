Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EDEC624A4
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 12:50:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAECE10E46D;
	Mon, 31 Aug 2026 12:50:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TCxO4Hou";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C1310E46D
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 12:50:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8A06241927;
 Mon, 31 Aug 2026 12:50:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6941F000E9;
 Mon, 31 Aug 2026 12:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788180650;
 bh=Inovtz74UVnffXMRGGA0BiEeub/zuwAj1xL70AVyNwc=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=TCxO4Hou9hJTqG87TXYEr1lJiPlzZSAmr9LLrTd+Yiddslbj2o0tFIjyOWiODscB/
 qlKeI39pvn09PqSPfkdpHt4ddH5O9kTDX9KZuBgT+Rr6vJYZ8eZra8L5YSlbVTxQIr
 OApRT0qVWPkJ49b/OUhTeMD4J7TgsG5PaZ3Nd0gvDzEp3YqK5Ms/f67D+7v1Y17U8h
 RJ3ZYd5Cqu9s7YCKymJBovk1SO9xC5tCNIOpQSa+CZ6zkNlJYtEOMhqyVbBg3KVgZN
 bZfucOFUwURuB5gYJc0OEuqhC+PuK1jKL9DIbL9jlsFzc1HHMFFjD9xkekD6I2Ave9
 r+tySRyoXP2uA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 14:50:45 +0200
Message-Id: <DL354W1TVE2X.CVZ3GXX2O2JQ@kernel.org>
Subject: Re: [PATCH 1/2] gpu: nova-core: use kernel lossless integer
 conversion module
Cc: <ojeda@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Alexandre Courbot" <acourbot@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260828-nova_num-v1-0-e21f17ba4127@nvidia.com>
 <20260828-nova_num-v1-1-e21f17ba4127@nvidia.com>
 <DL0KDAXUZOXD.I8FBZZ51EIIF@kernel.org>
 <DL142442KXHA.3VFWP2DHD7H2E@nvidia.com>
 <DL1O1NFXUX6N.1LFASWF425I4Y@kernel.org>
 <DL2Q6ZZ1EK68.2SARDMRGQ19X6@nvidia.com>
In-Reply-To: <DL2Q6ZZ1EK68.2SARDMRGQ19X6@nvidia.com>
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

On Mon Aug 31, 2026 at 3:08 AM CEST, Alexandre Courbot wrote:
> On Sun Aug 30, 2026 at 4:14 AM JST, Danilo Krummrich wrote:
>> On Sat Aug 29, 2026 at 5:34 AM CEST, Alexandre Courbot wrote:
>>> On Fri Aug 28, 2026 at 9:09 PM JST, Danilo Krummrich wrote:
>>>> (Cc: Miguel)
>>>>
>>>> On Fri Aug 28, 2026 at 7:33 AM CEST, Alexandre Courbot wrote:
>>>>> The `kernel` crate now features a replacement for our lossless intege=
r
>>>>> conversion routines. Switch to the kernel version and remove our own.
>>>>>
>>>>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>>>>> Reviewed-by: Danilo Krummrich <dakr@kernel.org>
>>>>> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
>>>>> ---
>>>>>  drivers/gpu/nova-core/falcon.rs                    |  12 +-
>>>>>  drivers/gpu/nova-core/falcon/fsp.rs                |   4 +-
>>>>>  drivers/gpu/nova-core/fb.rs                        |   2 +-
>>>>>  drivers/gpu/nova-core/fb/hal/gb100.rs              |   6 +-
>>>>>  drivers/gpu/nova-core/firmware.rs                  |   4 +-
>>>>>  drivers/gpu/nova-core/firmware/booter.rs           |   4 +-
>>>>>  drivers/gpu/nova-core/firmware/fwsec.rs            |   2 +-
>>>>>  drivers/gpu/nova-core/firmware/fwsec/bootloader.rs |   4 +-
>>>>>  drivers/gpu/nova-core/firmware/gsp.rs              |   9 +-
>>>>>  drivers/gpu/nova-core/firmware/tlv.rs              |  11 +-
>>>>>  drivers/gpu/nova-core/fsp.rs                       |   8 +-
>>>>>  drivers/gpu/nova-core/gsp.rs                       |   4 +-
>>>>>  drivers/gpu/nova-core/gsp/cmdq.rs                  |  22 +--
>>>>>  drivers/gpu/nova-core/gsp/fw.rs                    |  42 ++--
>>>>>  drivers/gpu/nova-core/gsp/fw/commands.rs           |   4 +-
>>>>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   2 +-
>>>>>  drivers/gpu/nova-core/mctp.rs                      |   8 +-
>>>>>  drivers/gpu/nova-core/num.rs                       | 211 -----------=
----------
>>>>>  drivers/gpu/nova-core/vbios.rs                     |   2 +-
>>>>>  19 files changed, 78 insertions(+), 283 deletions(-)
>>>>
>>>> Please see the discussion in [1].
>>>>
>>>> If we make this change, then the subsequent conversion to const_as!() =
would need
>>>> to go through the Rust tree next cycle, which could be a bit of a mess=
, as I'd
>>>> expect a bunch of conflicts.
>>>>
>>>> Alternatively, we could the the full three cycle dance, or have a sign=
ed tag for
>>>> const_as!() and use it right away.
>>>>
>>>> But honestly, the former would just be unnecessary noise. If we don't =
do the
>>>> latter, let's just keep the nova-core num module until the dust has be=
en
>>>> settled.
>>>>
>>>> [1] https://lore.kernel.org/all/CANiq72k+-fNWZCwGuQ=3DFTchxgm-X-f6WR=
=3DtG=3DErcn19ic1edQg@mail.gmail.com/
>>>
>>> Maybe I am missing something, but wouldn't the following work?
>>>
>>> - rc1 gets tagged, `drm-rust-next` gets the `num::casts` module,
>>> - This series gets applied to `drm-rust-next`, then `cv!` (without the
>>>   nova-core conversion patch) in `rust-next`,
>>> - We wait one cycle for `cv!` to trickle down to `drm-rust-next` before
>>>   converting nova-core to use `cv!`.
>>>
>>> Would that work? This series doesn't overlap with the const conversions
>>> that `cv!` covers on purpose, and it would have the benefit of getting
>>> rid of the local `num` module in nova-core quickly.
>>
>> Take casts::usize_into_u32() for instance, drm-rust-next replaces the us=
age of
>> it next cycle, but rust-next wants to remove the API from
>> rust/kernel/num/casts.rs.
>>
>> In this case rust-next would need to get rid of the users (including nov=
a-core),
>> but drm-rust-next will likely do different changes, so we'd get unnecess=
ary
>> merge conflicts.
>>
>> You can resolve this either by keeping casts::usize_into_u32 and friends=
 around
>> for one additional cycle, so that all users we introduce now are gone. O=
r, since
>> there's no rush anyways, we just wait one cycle and use the real thing r=
ight
>> away.
>
> Sorry, I should have explicitly mentioned that `*_into_*` would remain
> alongside `cv!` for the next cycle.

Maybe we have a different understanding of what "next cycle" means. As of t=
oday
we are in the v7.4 cycle, so I call this the current cycle.

In the next cycle, as discussed in [1], rust-next will drop casts::*_into_*=
(),
and so would drm-rust-next, if we start using casts::*_into_*() in nova-cor=
e
this cycle.

I don't want this situation, so we can either keep casts::*_into_*() around=
 for
even longer, or just never start using it.

> The reason why I think it's preferable to use `casts` in nova-core
> sooner is that some of the series currently under review (and that will
> likely be merged next cycle) add more uses of the local `num` methods,
> making the eentual conversion more painful. If we move to use `casts`
> early we can at least avoid the churn on those cases that do not use
> `cv!`.

It would come at the price of adding cross tree dependencies and converting=
 the
cv! parts twice, which is much worse than one clean and independent convers=
ion.
