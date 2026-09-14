Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD92C88E75
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 13:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0514C89D5C;
	Mon, 14 Sep 2026 13:57:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PbijN69z";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CEAE89D5C
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 13:57:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B507041B5C;
 Mon, 14 Sep 2026 13:57:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881E01F000FF;
 Mon, 14 Sep 2026 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789394253;
 bh=hWQfMjTwrhS/wEak3lQlYZWJXa+nrsd9RSvMVNpNwAY=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=PbijN69zCRfEB+alm6uXogzEaz9s2BRnelOZWna8gydWoSEci7YrJjkbOhNJEWnZo
 MtmEE5UYbXR961euWsi0jvDmgHVf0rZdgb+vk/K0jB+DQ7NLjXK3ydMY512gxEtfHo
 coL8g+XJONkwIr5azr9son0ok5LpRHsn2J2hJTwse41koUTTxb+irWE4UO2SzX7UkE
 JFg3ZBcnVloIa4vLixpg9T3NzQn298tcSxWgHRZoPUZJuHzftzNchk6A7nBmOAcfRe
 Oscetkf+QV+1YJWZJDCqsqDYL4QwN1OwdeWOP2gHJwExNAxWJz/6xPchz1QquNpb58
 swUFTXsR2v+fQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 14 Sep 2026 15:57:29 +0200
Message-Id: <DLF3BLOLU8HS.1AXNNXWVQUFNU@kernel.org>
Subject: Re: [PATCH 2/2] rust: scatterlist: honor the device's maximum
 segment size
Cc: "Robin Murphy" <robin.murphy@arm.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "Matteo Kloiber" <kernel@matt3o12.de>,
 <aliceryhl@google.com>, <ojeda@kernel.org>, <airlied@gmail.com>,
 <simona@ffwll.ch>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <a.hindborg@kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260831233215.287881-1-kernel@matt3o12.de>
 <20260831233215.287881-3-kernel@matt3o12.de>
 <DL8QLYLQJEL1.3F653J67DYZ47@nvidia.com>
 <20260913210806.125589-1-kernel@matt3o12.de>
 <DLEMH1X0KQA1.D1PYVJD0E6SR@nvidia.com>
 <DLEY8AHWZFCQ.QUHP2NHJW1QX@kernel.org>
 <DLEYQNUGTQYU.34AISCMMZXG8B@garyguo.net>
 <ea8caba1-eb78-40cd-b025-e8c02009f2d7@arm.com>
 <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
In-Reply-To: <DLF2GNSEGHKR.2UI219W5RK94F@garyguo.net>
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

On Mon Sep 14, 2026 at 3:17 PM CEST, Gary Guo wrote:
> On Mon Sep 14, 2026 at 1:17 PM BST, Robin Murphy wrote:
>> On 14/09/2026 11:22 am, Gary Guo wrote:
>>> On Mon Sep 14, 2026 at 10:58 AM BST, Danilo Krummrich wrote:
>>>> On Mon Sep 14, 2026 at 2:45 AM CEST, Alexandre Courbot wrote:
>>>>> On Mon Sep 14, 2026 at 6:08 AM JST, Matteo Kloiber wrote:
>>>>>> On Mon Sep 7, 2026 at 11:43 AM JST, Alexandre Courbot wrote:
>>>>>>> It also means that without patch 1, nova-core would split the firmw=
are
>>>>>>> into hundreds of 64KB SG entries, which is not breaking but still
>>>>>>> something we want to avoid. The correct fix is to make sure that
>>>>>>> `dma_set_max_seg_size` is called by the driver, and while we are at=
 it
>>>>>>> we also want every driver to call `dma_set_mask_and_coherent`. Idea=
lly
>>>>>>> we would use the type system to make sure that both functions are c=
alled
>>>>>>> before any DMA operation can take place (using a safe interface), b=
ut
>>>>>>> I'm not quite sure yet how we can do this.
>>>>>>
>>>>>> This sounds sensible indeed. Should I open a thread regarding that o=
n Zulip?
>>>>>
>>>>> Probably not necessary, the mailing-list has a larger audience and is
>>>>> the right place for this. I expect people will jump in here with thei=
r
>>>>> thoughts.
>>>>
>>>> The problem with those is not that they must strictly be called before
>>>> allocating DMA memory, but they must not be called concurrently with o=
ther DMA
>>>> operations, such as allocating DMA memory, as it would technically be =
a data
>>>> race.
>>>=20
>>> Do they really have to be called *before* allocating DMA memory, not do=
 they
>>> just need not be called *concurrent* to DMA memory allocation?
>>
>> Similar to DMA masks, the segment parameters should be set appropriately=
=20
>> before any dma_map_sg() operation. Plus since they likely influence=20
>> scatterlist geometry, that means typically they're also going to need to=
=20
>> be set before building the scatterlist to be mapped in the first place.
>
> Right, in that case I think we have the following options:
>
> 1.  Have setters these being unsafe, with precondition that they must be =
done
>     before creation of DMA mappings.

As mentioned, I don't think the safety requirement has to be before using o=
ther
DMA APIs, but just requiring to not do it concurrently. Not doing it would =
be a
semantic bug, but it shouldn't have any safety implications.

> 2.  Have a `dma_info()` method like Danilo mentioned. However, we cannot =
expose
>     `&Device<Core<'_>>` inside such callbacks, because otherwise driver w=
ould be
>     able create DMA mappings. This however is too restrictive to be the o=
nly way
>     of setting DMA masks, because Nova needs to access the bar before set=
ting the
>     DMA masks.

Just to clarify, I mentioned this to be something we could do in addition t=
o (1)
for drivers where those values are statically known.

> 3.  Use wrapper type instead of generics for typestate. Then, we can expr=
ess the
>     pattern of typestate transformation (generics cannot do this because =
we
>     always place it behind a reference).
>
>     For example, we can have `Device` to mean `Device<Normal>`, and then =
have
>     `Bound<Device>` to mean `Device<Bound>` (both of which are behind a s=
hared
>     reference, like today, and `Bound<D>` can deref to `&D`).
>
>     Then, for `Core` typestate, we can instead have
>
>         struct Core<'a, D>(&'a Bound<Device>);
>
>     where it's passed by value. We can then define the DMA setters method=
s to
>     operate on `Core` like we did today, but safely. Instead of providing=
 a
>     `Deref` impl that turns `&Core<'_, D>` to `&Bound<D>`, we only implem=
ent
>     forwarding functions for APIs that can work without DMA configured (e=
.g. PCI
>     bar).
>
>     Then, provide a `into_bound()` method which *consumes* `Core<'a, D>` =
and
>     give out `&'a Bound<Device>` (this is why typestate generics cannot w=
ork,
>     because `&'a Device<Core<'_>>` is Copy and we cannot represent the ow=
nership
>     consumption).

Yeah, we had this discussion in the past with similar ideas; it is the kind=
 of
complication that we concluded not to be worth it and that I mentioned in m=
y
initial reply.

The only safety relevant issue should really be the data race of the primit=
ives
values being set, which is more on the theoretical side of things.

>> I don't think there's any expectation that they would ever change=20
>> *between* different mappings - especially given the underlying hardware=
=20
>> properties they represent - so while that might technically be possible=
=20
>> in the C API if the caller can enforce sufficient ordering, it should be=
=20
>> fine to rule it out in the Rust abstraction if that makes things easier=
=20
>> to reason about.
>>
>>> If it's the former, we can require these to require mutable reference i=
nstead,
>
> Correction: this should say "latter".
>
>>> so the probe takes `Pin<&'bound mut Device<Core<'_>>>` which still dere=
fs to
>>> `&'bound Device<Bound>`, but Rust will require the shared reference to =
not
>>> co-exist with the mutable reference.

I think that doesn't work, there are drivers that need to perform MMIO befo=
re
knowing e.g. the DMA mask, i.e. we can't have Pin<&'bound mut Device<Core<'=
_>>>
at the same time as e.g. pci::Bar<'_>, which borrows a &Device<Bound>.
