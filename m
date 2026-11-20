Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E623606AA45
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MK02NyNG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E27FD112926;
	Fri, 20 Nov 2026 11:44:43 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CB2C11293E
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:44:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5AF166291A;
 Fri, 20 Nov 2026 11:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CB791F000EB;
 Fri, 20 Nov 2026 11:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795175076;
 bh=5L7qqB5WaMtNMY9uDK4imR6R5lduwPZOBAPzSNwaOt8=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=MK02NyNGVt3ebGIuf7j8ititOe/z/miWKxC/cxRWpaUwoqWbdiGhRQvU8OaMCnYwS
 j90977RhLU5XEfTut81+FJClZVIn6vGa5AdoBLBiocBd87c89OiQPzCwDmssryaBWy
 jaOwv8Ws2Pvbr0/Jqe12F3wSyeJ7/lxSoBcG0C6LMvt46SOWFWgWL7iApA3ZTBxIJQ
 r8vv8oHlRieseBk+vxJ0jfn3VoA4zcPO0VuTJ6LhfNzmP2W3B6ufNf/6OJ3ifZDSb3
 4NJ14njem1N4mzF1c2R/lShdOdWSJbTlYuq/igCsgM317wLi0DTSRuKHTmukFsh8p7
 J5TfXh/NYL1+g==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 12:44:31 +0100
Message-Id: <DN00GAPAAQTY.1T9M9U7UAFYC0@kernel.org>
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
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: DamFence: Remove warning about unsignaled drop
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
 <202dd0c3d515ddfa77a8ec8751badadd31b8a7b0.camel@mailbox.org>
 <141892f8-180c-4157-8c59-6e69057334f2@amd.com>
 <DMZAQ0G6LTTB.1CRPNXSYB4QHG@kernel.org>
 <c18fc55a-717f-42a0-b37f-4ed81efd29d1@amd.com>
In-Reply-To: <c18fc55a-717f-42a0-b37f-4ed81efd29d1@amd.com>
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

On Fri Nov 20, 2026 at 10:15 AM CET, Christian K=C3=B6nig wrote:
> On 11/19/26 16:34, Danilo Krummrich wrote:
>> On Thu Nov 19, 2026 at 11:47 AM CET, Christian K=C3=B6nig wrote:
>>> A dma_fence should *NEVER* signal because you waited for something. Ins=
tead
>>> the dma_fence is what is waited on.
>>=20
>> In the end, despite doing it on behalf of the hardware, the driver is th=
e
>> producer of the fence. And there are cases where it can't wait on its ow=
n fence,
>> because no one is going to signal it other than the driver itself.
>>=20
>> Assume you have an execution context that is torn down, and also assume =
the
>> hardware supports preemption. Then some of the jobs in the queue might s=
till
>> signal, but some jobs are not processed anymore and hence are not signal=
ed.
>>=20
>> For those jobs that did not execute anymore, the fence still has to be s=
ignaled.
>> So the driver has to signal them after it waited on the preemption and e=
xecution
>> context teardown is complete and no more operations are in flight.
>
> Oh well that comment made me smile because it confirmed what I wrote :)

No, it just seems that way because you ignore everything I write and instea=
d
repeat "wait for the DMA fence".

Again, how can a driver wait for its own fence to be signaled (e.g. through=
 an
interrupt) when the hardware (or firmware) queue is dead?

> How do you wait for the "preemption and execution context teardown is com=
plete
> and no more operations are in flight" ?

I think the generic answer is exactly the same way as if an individual job
completes, the driver signals the fence for otherwise.

> That waiting for DMA context teardown must be done through a dma-fence. T=
hat
> is the whole concept of dma-fences in the first place.

Again, how can this be done if the hardware or firmware queue is dead?

> I wish I could enforce that in C somehow but we missed that opportunity w=
hen
> we originally designed the dma-fence and now it is to late because of the
> fallout and complexity required for such a change.
>
> See the discussion here as well https://lists.freedesktop.org/archives/dr=
i-devel/2025-August/520640.html

You ask about whether dma_fence_work_commit_imm() in i915 should exist in t=
he
first place. I can't find any subsequent discussion and the function exists=
 in
i915 till today. What did you intend me to extract from this?

> I think we are at the point where I need to make clear that practices lik=
e
> signaling fences from a destructor or other IOCTL initiated teardown is a=
 NAK
> from my side as DMA-buf maintainer.
>
> When you want to push forward with this anyway I think we need to raise t=
his
> with Dave/Linus to get an answer if such an approach is ok or not.

There's many indicators in this discussion that show me that you probably d=
on't
understand Rust enough, or didn't engage with the arguments enough to make =
such
a call (mixing up Rust destructors and IOCTL context above is one of them).

At this point, none of this needs an authoritative answer.

That said, maybe it helps to find some similar examples in C. I tried to fi=
nd
amdgpu ones. Xe code is probably a better fit as it has firmware queues as =
well,
but let's try this first.

amdgpu signales fences in a way that is a destructor too.

[1] was introduced in commit 97ff19462539 ("drm/amdgpu: Implement a new
userqueue fence driver"), explicitly suggested and reviewed by yourself.

(To me it seems that this signaling loop is unnecessary though, so maybe fa=
ir
enough.)

Another example is amdgpu_fence_driver_force_completion() [2], which is cal=
led
in many places. One of them has the following callchain:

	amdgpu_pci_remove()
	  drm_dev_unplug()
	  amdgpu_driver_unload_kms()
	    amdgpu_device_fini_hw()
	      amdgpu_fence_driver_hw_fini()
	        amdgpu_fence_driver_force_completion()
	          amdgpu_fence_process()
	            dma_fence_signal()
=09

The comment in [3] explicitly says "You can't wait for HW to signal if it's
gone", which is exactly my point.

The same is true for when a firmware ring is gone (or dead) and the firmwar=
e
guarantees that there are no more outstanding transfers.

And then there's of course the case where jobs didn't hit a hardware or fir=
mware
queue in the first palce, e.g. in drm_sched_entity_kill().

All of those examples are all destructors.

[1] https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_userq_fence.c#L183
[2] https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_fence.c#L668
[3] https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/amd/amdg=
pu/amdgpu_fence.c#L543
[4] https://elixir.bootlin.com/linux/v7.3.1/source/drivers/gpu/drm/schedule=
r/sched_entity.c#L305

>> The same is true for job fences that are in a software queue and never h=
it the
>> queue of the hardware execution context.
