Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E174C9833E
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:11:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF3F910E7F0;
	Mon, 28 Sep 2026 08:11:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AXFG54NN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7BD310E7F0
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 08:11:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 93550600E2;
 Mon, 28 Sep 2026 08:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450541F000FF;
 Mon, 28 Sep 2026 08:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790583101;
 bh=oihozRlFZ7lt6GDwFed9U05sgh5zM+CW01iJD4rrReU=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=AXFG54NN28oi8qNx/+8HghJ8/4iBl+tTWjh5BeAP3onSRThy2zn/N1FdOwcSei4tG
 YwRDAfKywfqDIEEmpBMNcY7xY/qZ/UrDSvKbIw5xEOVzJEohYjSkb5QGeFoN+3FrXK
 CWOVLe84KPfzX5QfxV2PPG2x+eKPIBcp/ER1VBC5Cs6YSGHB+Zlse696OBWVweH4E5
 fBitSGWnjM7hHzZ8n2M63pTUvnvZpFUwQjErotQ+xKiOv0yaTNygFdwWq7kB6baGdN
 SJb2L5ZmB9y0Q0Zm0+GHPr9YjNDQWI0OZWqajuKdZt3yY1CT3X9Fg0seL4k0uR6yqW
 lMA6pweRMAAXA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 10:11:35 +0200
Message-Id: <DLQSQE8ZXLY1.1XFW8PGSDLICT@kernel.org>
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
In-Reply-To: <37a2858a4687e4d9bbe0aba4c1861b96875c4ed7.camel@mailbox.org>
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

On Mon Sep 28, 2026 at 9:52 AM CEST, Philipp Stanner wrote:
> On Fri, 2026-09-25 at 19:32 +0200, Danilo Krummrich wrote:
>> On Fri Sep 25, 2026 at 7:21 PM CEST, Philipp Stanner wrote:
>> > I guess we agree that it would be a horrible bug if there's still a
>> > command buffer running on the GPU that can access memory which might
>> > have been freed once the associated fence signaled.
>>=20
>> Sure, but that's unrelated.
>>=20
>> > So I suppose what you are saying is more: there is not much value in
>> > the case of *JobQueue*, basically because all the jobs live inside of
>> > it anyways.
>>=20
>> No, I'm saying there is not much value in general. Whatever thing owns t=
he
>> DriverFence has to represent the "device access" of some resource, which
>> already naturally establishes the relationship.
>>=20
>> IOW, whatever thing owns a DriverFence is also the thing that stops the =
hardware
>> in its own drop() implementation; anything else would be rather question=
able.
>>=20
>> > So I suppose we agree that a warning is fine. It won't fire in JQ
>> > anyways, but might benefit others.
>>=20
>> What scenario are you thinking of?
>
> Drivers doing "rather questionable" things, like we've seen a great
> many times already ;)
>
> Note that the dma_fence backend fires a WARN_ON if a fence is freed
> unsignaled, too, for the same reason.
>
> Life finds a way.

I'd rather you engage with the arguments I made above and give a concrete
example of how it "might benefit others", instead of resorting to know-it-a=
ll
platitudes.

The comparison with C does not address my point about ownership: C relies o=
n
explicit cleanup, whereas the Rust design I described ties cleanup to owner=
ship
through RAII.

Again, please address the arguments I've already made.
