Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95264C98321
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 17:32:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA2510E094;
	Fri, 25 Sep 2026 17:32:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtGM5+BJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4447210E094
 for <dri-devel@lists.freedesktop.org>; Fri, 25 Sep 2026 17:32:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D65A840605;
 Fri, 25 Sep 2026 17:32:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007401F000FF;
 Fri, 25 Sep 2026 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790357574;
 bh=XX5xuckpzIuBGSkpTDAZLOD0oioLLWvieHwioo1oDWQ=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=BtGM5+BJ88YkzDX70KvcCtZ2YFT1jDLJxL0cCIZBFqM6T515dC9yMTR/mn6rHr2Rp
 CN5q8Ybuc3huauaPrW9Hs8OAw6OMMsk/ZEs2KI2GLDIcgIIxmC5KeYJrsQ99VQ9/Ce
 pia5WKjlHdcTpVgsbyNJf9ZPZ+kv/Wh/EqJT802q2cn+V+fx2od75rPNsNskKj9gfP
 cBqhtuRa32xw16owzpJtMC+Zkju6G4YsY9GnJKOcGHNTWb7Hofodt3Q0j/N+E31l2S
 bkThUwVyBg4D5yfdmlBkWi10cFSq9b9WvqiT1SrhAj5KLZgdPzmVOL0XqMqLuZMh1S
 byDZUjeyY6eIw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 19:32:49 +0200
Message-Id: <DLOKSGU61PUG.WSZBN04H0A2Q@kernel.org>
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
In-Reply-To: <ab1241777ac432666bb1564d875211bf142a6398.camel@mailbox.org>
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

On Fri Sep 25, 2026 at 7:21 PM CEST, Philipp Stanner wrote:
> On Fri, 2026-09-25 at 17:50 +0200, Danilo Krummrich wrote:
>> On Fri Sep 25, 2026 at 3:08 PM CEST, Philipp Stanner wrote:
>> > The driver can avoid dropping half-forgotten stuff by calling
>> > jobqueue.complete_all_jobs(ECANCELED) immediately before dropping,
>> > which allows us for having the warning without false-positives.
>>=20
>> This would just move it up a layer from inventing a new type around Driv=
erFence
>> to invent a new type around Jobqueue which does that instead.
>>=20
>> But the Jobqueue won't have any procedural teardown, it has to teardown =
stuff in
>> drop() anyway, which includes dropping jobs already.
>>=20
>> What I'm saying is that there's not much value in DriverFence::drop() ha=
ving
>> this warning in the first place, which then either the driver or the job=
queue
>> has to work around on teardown.
>
> I guess we agree that it would be a horrible bug if there's still a
> command buffer running on the GPU that can access memory which might
> have been freed once the associated fence signaled.

Sure, but that's unrelated.

> So I suppose what you are saying is more: there is not much value in
> the case of *JobQueue*, basically because all the jobs live inside of
> it anyways.

No, I'm saying there is not much value in general. Whatever thing owns the
DriverFence has to represent the "device access" of some resource, which
already naturally establishes the relationship.

IOW, whatever thing owns a DriverFence is also the thing that stops the har=
dware
in its own drop() implementation; anything else would be rather questionabl=
e.

> So I suppose we agree that a warning is fine. It won't fire in JQ
> anyways, but might benefit others.

What scenario are you thinking of?
