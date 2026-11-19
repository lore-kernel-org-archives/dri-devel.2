Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E1606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIHdUJVr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93F6C1121C6;
	Thu, 19 Nov 2026 12:35:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FC931121C6
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 12:35:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 71A586183D;
 Thu, 19 Nov 2026 12:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7D31F000C4;
 Thu, 19 Nov 2026 12:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795091733;
 bh=JZwSzmbpLd5nw3ADrG6ZagdEQ6wcWuReHNoHgHSQPmc=;
 h=Date:From:Subject:Cc:To:References:In-Reply-To;
 b=IIHdUJVromNgk06XuE0ek4z2uYmPDN4cm9kJkOcMLBK+zNb1ZzDQeRC1i8jGYixaQ
 k2sJ8j0ChtKyYbp2/+XognzOqVmK6nZIjIEwF1iUBiwKIfxk1aQyFl2lmYEo9dlYXq
 Rt12i40heUzjSNHvh/nyF6RN3DXMukUjX6e3Okbv6+UeanHgdXJ4iPLndRPB5ZhHLv
 SSySjs2IHmu+ymUI1akKPhKClVipDmn5TC6uqXMud7ExPzUfnoZSl0oCo9iWgJF3e2
 IaP1SwBJtMSip9ZBGtig16CmHQB1/vmWBpr8Xpm32mtTT0xf1VG/UlBzrROzcgmZ9v
 junKwu5ae5aog==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 13:35:28 +0100
Message-Id: <DMZ6WRFGHVQI.22OJY1Z1QP2MF@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
Cc: <phasta@kernel.org>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
 <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
 <a7f9e0f3-b299-4d40-9230-106003725dc2@amd.com>
In-Reply-To: <a7f9e0f3-b299-4d40-9230-106003725dc2@amd.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 19, 2026 at 10:32 AM CET, Christian K=C3=B6nig wrote:
> On 11/17/26 17:36, Danilo Krummrich wrote:
>> Drivers often reference count representations of hardware resources and =
hardware
>> states and hence keep them alive beyond what their actual lifetime shoul=
d be --
>> even beyond driver unbind.
>
> Yeah, I agree 100% with that. I know why drivers do this and there are un=
fortunately really good reason for that.

I don't think there are good reasons for that.

Given the below, I assume that you refer to a teardown situation where you
instruct the hardware to stop and then destroy the representing software
structure once that actually happened.

But this can't work without synchronization. Drivers live within a bounded
lifetime model, where they must not keep device resources alive beyond driv=
er
unbind. If they do so regardless, that risks UB.

IOW, without synchronization you are trading one potential UB against anoth=
er.

The solution is not to reference count device resources and potentially kee=
p
them alive beyond the kernel's lifetime constraints, but wait for the hardw=
are
to stop in your teardown path before destroying device resources.

>> Consequently, it is perfectly reasonable to assume that a driver object =
that
>> owns device resources (such as DMA memory) will, in its destructor, tear=
 down
>> the hardware to not access any of the resources it owns anymore.
>
> Exactly that is a pattern I have seen many many times before and I can sa=
y
> from experience that it is very prone to human errors as well.
>
> I have worked extensively with OCaml which to be honest looks like the
> grandfather of Rust, but Rust does a lot of things better in my opinion.
>
> See I have like over 30 years of experience with that stuff.

[...]

>> For instance, think about how your logic would apply to e.g. DMA coheren=
t
>> allocations.
>>=20
>> Those are allocated with e.g. dma::Coherent::zeroed() and are freed on d=
rop().
>> They are then owned by whatever object represents the lifetime of the HW=
 using
>> this buffer.
>>=20
>> Following your logic, we'd need to conclude that a dma::Coherent allocat=
ion
>> needs an explicit free() method independent of its destructor as well, a=
nd have
>> the destructor print a warning and then call free() anyway.
>
> Yes correct.

[...]

>> Now, eventually drivers would just call free() from the destructor of th=
e object
>> owning the dma::Coherent allocation, so we wouldn't win anything.
>
> No, exactly that's incorrect.
>
> See the problem is that you rarely can tell HW in a linear or synchronous
> fashion to stop DMA operations.
>
> What drivers do instead is to send a request to the HW saying "Please sto=
p the
> DMA operation" and the HW answering with a response which takes the same =
path
> as the DMA operation itself.
>
> Only this way you can be sure that there are no more DMA operations in fl=
ight
> between the HW and system memory.

Sure, but then you have to synchronize on the software side, nothing stops =
you
to block the teardown until remaining transfers have stopped. And this is
exactly what should be done.

Freeing resources underneath the ownership model from asynchronous scopes i=
s
clearly not the solution.

>> More in general, in Rust the object taking ownership of a device resourc=
e is
>> responsible to deal with the device related state that makes use of this
>> resource regardless.
>>=20
>> Insisting on an explicit method call is not improving anything in this m=
odel.
>
> I'm not insisting on an explicit method call.
>
> What I'm insisting on is that the response from the HW that the DMA opera=
tion
> has stopped is signaling the fence.

This is reasonable if there is an asynchronous response.

However, note that the destructor of the object representing the HW state h=
as to
wait for all this to finish regardless, as it also owns the actual underlyi=
ng
device resources.

There are also cases where there's no asynchronous response; the drivers fo=
r
NVIDIA GPUs for instance do synchronous RPCs to tear down runlists, where
pending jobs don't receive completion events anymore.

(The same is true for cases where jobs are queued in a software queue and n=
ever
reached the hardware in the first place.)

I get your point that the DMA fence kinda is the synchronization primitive =
to
wait for, but it can't be generalized that way; the producer (which eventua=
lly
is the driver that only signals it on behalf of the hardware) can't always =
rely
on that.

> And not that driver tell the HW stop DMA and then continue and dma fence =
is
> automatically signaled without explicitly saying that is the signal that =
DMA
> operations are stopped.

That's the point, the destructor of an object that holds device resources c=
an't
just tell the HW to stop and go ahead without making sure that the HW is
actually stopped once the destructor returns regardless.
