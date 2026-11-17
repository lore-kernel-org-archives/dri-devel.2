Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC74D606A329
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Mwj+1W86
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B02E10E5BB;
	Tue, 17 Nov 2026 13:50:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B6210E5BB
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 13:50:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3B63A634EC;
 Tue, 17 Nov 2026 13:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 711D01F000CA;
 Tue, 17 Nov 2026 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794923410;
 bh=1o4o8OU/LTUKe0c4Pab57k6q3vQbpxxV5mCVPeRuL3o=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=Mwj+1W86/Y/8v2cZtnYY838nYHLxs7WiSVqv6DjPWOE1U6N0KqyaklL1htWHwywyM
 PZcfIRPuvPLY7+G+fxikiJAKqliw18DXBdIYcweVwkE0Y05KCwnKqUBtWjnsG0Sdk6
 DXAGcG5mlbwK6JGHoWVR8y4ELSRQwIJkNDLxk8BpzjVh9YC74Z7x3llK9tV694CwMw
 xXLUdjoQyBmqxtSBbGeOm+jZD1NQI2vOrr0DSBy+cVCNCnbOXoZJsngbITcbYWKP41
 s0dEbuoU4VpRXfs7JGgyAc2e6aIxckWRpElB3t4Y1ZmWShAs4c+yq8ZL4V93tjKubX
 z2A71PEF4BpfA==
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Nov 2026 14:50:06 +0100
Message-Id: <DMXJ8TBSZJJ4.3HG0OJDI9URTT@kernel.org>
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
In-Reply-To: <c2dd46ea-94d8-4720-af37-897c91809338@amd.com>
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

On Tue Nov 17, 2026 at 2:40 PM CET, Christian K=C3=B6nig wrote:
> On 11/17/26 11:54, Philipp Stanner wrote:
>> On Tue, 2026-11-17 at 10:51 +0100, Christian K=C3=B6nig wrote:
>>> On 11/17/26 09:24, Philipp Stanner wrote:
>>>> struct DriverFoo {
>>>> 	f: DriverFence<()>,
>>>> }
>>>>
>>>> impl Drop for Driver Foo {
>>>> 	pub fn drop(&mut self) {
>>>> 		// Signals fence implicitly & automatically.
>>>> 		self.f.signal(ECANCELED);
>>>> 	}
>>>> }
>>>
>>> Yeah, exactly that is still a bad idea :) See the HW eventually
>>> doesn't necessarily stop doing DMA if you unload the driver.
>>=20
>> I know.
>>=20
>>> So just signaling all fences with ECANCELED is not enough.
>>=20
>>=20
>> Yes. What I was trying to tell you as that you have no way to enforce
>> this in Rust or C.
>>=20
>> dma_fence_signal(f);
>> free_driver_resources();
>> // Driver forgets to stop the hardware. Memory corruption occurs.
>>=20
>> You see? Neither your BUG_ON() or WARN_ON() saves you if the driver
>> does it like that, no matter the programming language. You cannot
>> prevent it.
>>=20
>> The only one who understands how the hardware works is the driver. The
>> only one who can stop it is the driver.
>>=20
>> In Rust, the place where a driver drops its JobQueue is the same place
>> where it has to halt its GPU ring correctly. Enforcing this cannot be
>> done by dma_fence code.
>
> I completely agree that we can't fix things from the dma_fence code, but =
it is our obligation to tell the user that something very very bad happened=
.

That's the point, we can't infer that "something very bad happened" from
dma::DriverFence being dropped unsignaled.

In Rust we use the RAII pattern, and drivers structurally embed a
dma::DriverFence within the struct that represents the corresponding hardwa=
re /
firmware queue (e.g. through Jobqueue).

Consequently, if dma::DriverFence drops unsignaled it means that the destru=
ctor
of the structure that embeds it (which does the required HW teardown) did r=
un
already.
