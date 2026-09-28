Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8887AC9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 10:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE17510E882;
	Mon, 28 Sep 2026 10:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Z4jfKm8t";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9E510E882
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 10:44:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6894C60052;
 Mon, 28 Sep 2026 10:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281B61F000FF;
 Mon, 28 Sep 2026 10:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790592243;
 bh=Mp3XtGy21aQRxosj8wN/TOa0Q0Kwk8FEiqjAOGlRKRA=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Z4jfKm8tURgzkzDL8XMRwfRfzIx6XQt9YZ3Cj5pnOFDdx9l+/VWZPCzVfKGoLILhV
 kwyWZ7ZjgtWu4UV4VJIsbSu5w+WcMUw2oGCOS5rHSQYm1RRokk84vXQ6YRJj0LkOhc
 5ognTu+rOZRN5YMdnW1SmVs0tSsnzi25zPkOqsFBkuJ0AJJajd0NMUGvwtmmPPA5Ty
 95oF6vcOBJD77eaYExtR5IDk6V2U8SPws8oHSofzVjF2WHhhiTtrNN1WJ2utgF+DR4
 o/ElFe3+3iM/ZLt8mjy8KOAggC0m34zuQXjbHixJ7Gw6RhTlo83clvqvB4/mubwyvA
 z6FQo7senxhKw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 12:43:57 +0200
Message-Id: <DLQVZ218WBQS.2A4Z1DSNU4I6H@kernel.org>
Subject: Re: [PATCH] rust: DmaFence: Add better warning through Device
 reference
Cc: <phasta@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "Sumit Semwal" <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, <linux-media@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Philipp Stanner" <phasta@mailbox.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260925081958.3048112-2-phasta@kernel.org>
 <DLOBPY6OBEOG.2Y4I4LRA276WU@garyguo.net>
 <DLOECU7X3MTR.31Z6N1I0WB0MJ@kernel.org>
 <f0248d1529378ab8be957009a93a0a73ee74bafb.camel@mailbox.org>
 <DLOILT0V4HCX.31L2PE7YIAKY3@kernel.org>
 <ab1241777ac432666bb1564d875211bf142a6398.camel@mailbox.org>
 <DLOKSGU61PUG.WSZBN04H0A2Q@kernel.org>
 <37a2858a4687e4d9bbe0aba4c1861b96875c4ed7.camel@mailbox.org>
 <DLQSQE8ZXLY1.1XFW8PGSDLICT@kernel.org>
 <a44b26ceb273f0cdfc04a4391040c08386b31e01.camel@mailbox.org>
In-Reply-To: <a44b26ceb273f0cdfc04a4391040c08386b31e01.camel@mailbox.org>
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

On Mon Sep 28, 2026 at 10:32 AM CEST, Philipp Stanner wrote:
> On Mon, 2026-09-28 at 10:11 +0200, Danilo Krummrich wrote:
>> On Mon Sep 28, 2026 at 9:52 AM CEST, Philipp Stanner wrote:
>> > > > So I suppose we agree that a warning is fine. It won't fire in JQ
>> > > > anyways, but might benefit others.
>> > >=20
>> > > What scenario are you thinking of?
>> >=20
>> > Drivers doing "rather questionable" things, like we've seen a great
>> > many times already ;)
>> >=20
>> > Note that the dma_fence backend fires a WARN_ON if a fence is freed
>> > unsignaled, too, for the same reason.
>> >=20
>> > Life finds a way.
>>=20
>> I'd rather you engage with the arguments I made above and give a concret=
e
>> example of how it "might benefit others", instead of resorting to know-i=
t-all
>> platitudes.
>
> Stating that I cannot know nor conceive all possible patterns and
> misbehaviors is quite literally me acknowledging that I do *not* "know
> it all".

I mean, you expressed a concern about a fence being signaled before the har=
dware
has been torn down accordingly. I provided arguments why I don't see that t=
he
concern holds and then you mentioned that the warning "might benefit others=
".

To me this sounded as if you had concrete scenarios in mind, which doesn't =
seem
to be the case. If that's correct, and given that there was no reply to my
arguments, it seems we can just remove it.

Maybe to further explain my reasoning:

The concern was that it could happen that the DriverFence is dropped while =
the
hardware still utilizes the memory "protected" by the fence. As mentioned, =
to me
this is not a concern because of the programming model we have in Rust. Tak=
e
this analogous DMA memory example:

	struct Channel<'a> {
	    shared: dma::Coherent<'a, Data>,
	}
=09
	impl Drop for Channel<'_> {
	    fn drop(&mut self) {
	        self.stop_hardware();
	        shared.free();
	    }
	}

We could use the exact same argument to require people to explicitly call f=
ree()
on a dma::Coherent allocation as the underlying hardware (represented by th=
e
channel) could still use the dma::Coherent allocation if we "drop it
accidentally".

But as you can see, the ownership is already properly expressed by Rust, th=
e
Channel owns the dma::Coherent allocation, so the memory can just be freed =
in
Coherent::drop().

The same applies to DriverFence, the thing that takes ownership is the thin=
g
that operates the hardware.

> With this patch I was just trying to accommodate your post-merge
> request for replacing pr_ with dev_err() or WARN_ON. If you think
> neither is actually necessary, that's also fine by me.

I did arrive at the conclusion to discuss whether we can't just get rid of =
the
warning entirely in my first reply [1], which you refer to, already.

[1] https://lore.kernel.org/all/DL9AEUZ4VGV5.2RT33JE0MHYME@kernel.org/
