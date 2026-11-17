Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096AF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J/KyEHp6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699C510F78D;
	Tue, 17 Nov 2026 16:37:05 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25A7410F792
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 16:36:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CF17A42443;
 Tue, 17 Nov 2026 16:36:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1CD1F000C4;
 Tue, 17 Nov 2026 16:36:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794933418;
 bh=tgGdYiCRp9arr66Rhn5MXQJr5Tmse7T13KsVZcqATvc=;
 h=Date:To:From:Subject:Cc:References:In-Reply-To;
 b=J/KyEHp6WZkYwqBQMW1p9K2gCDFtEvoeGxSBGmb9nCN12CYtopOnKuvpw5JKZQRR+
 6gLCpkBzEnH++3YQEnMORwrw+jecKasETW3mwRJbiOollaFCfCaJ1JvF6JEkHnvZfr
 A02Qimv9QEi8HDcxjBtIn8tfKKYPukbuOqjibH097LN8S1sYU4J9jBOyjn5zajjeta
 kDLivp7MbvSXALiioN206smDguo0tTi+HE/Md9Y0gj64D+ZyCuwzrwsbYPG7lybkp/
 VMJn7RMKGVz6LeZyit6HUW4qqmVPJLCsWis6eIIjvzqZ6PCWxLXAoD9levG7wHRHXI
 zTP6khDzdzqYA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 17:36:53 +0100
Message-Id: <DMXMSIQONGUW.1RRNS7I6LACD6@kernel.org>
To: =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
References: <20261112101015.528127-2-phasta@kernel.org>
 <5d466f7c-2e70-4011-be04-9ffdf877b915@amd.com>
 <49298d3a328c1695ea27993f714c20b8a1c05f32.camel@mailbox.org>
 <e2ec8a39-56c3-4274-91ce-60c273904877@amd.com>
 <ab99758408df682c68a3792cc3014b77d6e1c8ab.camel@mailbox.org>
 <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
 <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
 <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
In-Reply-To: <8da4a8c0-1740-450c-9cf1-1a7b21d12997@amd.com>
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

On Tue Nov 17, 2026 at 3:50 PM CET, Christian K=C3=B6nig wrote:
> On 11/17/26 14:50, Danilo Krummrich wrote:
>> On Tue Nov 17, 2026 at 2:40 PM CET, Christian K=C3=B6nig wrote:
>>> I completely agree that we can't fix things from the dma_fence code, bu=
t it
>>> is our obligation to tell the user that something very very bad happene=
d.
>>=20
>> That's the point, we can't infer that "something very bad happened" from
>> dma::DriverFence being dropped unsignaled.
>>=20
>> In Rust we use the RAII pattern, and drivers structurally embed a
>> dma::DriverFence within the struct that represents the corresponding har=
dware /
>> firmware queue (e.g. through Jobqueue).
>>=20
>> Consequently, if dma::DriverFence drops unsignaled it means that the des=
tructor
>> of the structure that embeds it (which does the required HW teardown) di=
d run
>> already.
>
> Oh WOW! The signaling state of the fence should *NEVER* be bound to some
> object lifetime.

Let's engage with the argument and understand things before throwing
overgeneralized statements like this around please.

Realitiy is usually much more nuanced and what you say doesn't hold in all
cases. The case described above (and clarified below) is one of them.

I assume the fundamental reason why you say things like "software object ru=
nning
out of scope is not an indicator that the HW stops doing something" is beca=
use
the lifetime model in a lot of existing C DRM drivers is backwards.

Drivers often reference count representations of hardware resources and har=
dware
states and hence keep them alive beyond what their actual lifetime should b=
e --
even beyond driver unbind.

This causes lot's of issues and I'm looking into fixing this up, see my tal=
k in
[1] and an example from Xe [2] for reference.

That said, in Rust we don't have this kind of ambiguity, lifetime and owner=
ship
of resources are well defined and the core infrastructure guides drivers
accordingly.

Consequently, it is perfectly reasonable to assume that a driver object tha=
t
owns device resources (such as DMA memory) will, in its destructor, tear do=
wn
the hardware to not access any of the resources it owns anymore.

For instance, think about how your logic would apply to e.g. DMA coherent
allocations.

Those are allocated with e.g. dma::Coherent::zeroed() and are freed on drop=
().
They are then owned by whatever object represents the lifetime of the HW us=
ing
this buffer.

Following your logic, we'd need to conclude that a dma::Coherent allocation
needs an explicit free() method independent of its destructor as well, and =
have
the destructor print a warning and then call free() anyway.

Now, eventually drivers would just call free() from the destructor of the o=
bject
owning the dma::Coherent allocation, so we wouldn't win anything.

More in general, in Rust the object taking ownership of a device resource i=
s
responsible to deal with the device related state that makes use of this
resource regardless.

Insisting on an explicit method call is not improving anything in this mode=
l.

To get back to dma::DriverFence: This is slightly different, as there's two
different signal states, but the fundamental guarantee is the same: If it i=
s
dropped, the HW has stopped accessing the resource that it guards already *=
by
design*.

Signaling with an error on drop is arguably the correct thing to do, since =
if
the operation would have been completed successfully before already, it wou=
ld
have been signaled already -- if it drops unsignaled it means the hardware =
was
forcefully torn down (e.g. on driver unbind).


[1] https://youtu.be/3A2vGbc_rxs?t=3D668
[2] https://lore.kernel.org/all/as07AdBFlOQZrH_4@intel.com/

> That sounds like an extremely bad practice to me. Just imagine anybody
> grabbing an extra reference to the HW state object to inspect it for debu=
gging
> and the fence not signaling because of this.

That's not how it works.

Rust ownership rules will guarantee that the driver fence will be signaled =
with
an error (if not signaled already) if the HW state object is destroyed (i.e=
. its
destructor runs that tears down the HW). But that doesn't mean that the fen=
ce
can't be signaled (and subsequently be dropped) independently through the
completion of a job before that.

IOW, the HW state object (for instance) owns Jobqueue, Jobqueue owns jobs, =
jobs
own driver fences.

If the HW state object drops (e.g. on driver unbind), the Jobqueue drops, w=
hich
makes their jobs drop, which makes the driver fences drop.

At this point the driver fence either has been signaled already because the=
 job
completed before teardown (but wasn't dropped yet), or it will be signaled =
with
an error in its drop(), which is fine since at this point the HW state's dr=
op()
is completed already and hence the HW is stopped.

Besides that, reference counting HW state objects is bad practice. HW state
objects have a bounded lifetime, so there's no point in reference counting =
them.
