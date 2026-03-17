Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47411FD875A
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 12:19:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5D8210E4B2;
	Tue, 17 Mar 2026 12:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GypqWCLI";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6B8510E351;
 Tue, 17 Mar 2026 12:19:51 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id ACA35435A8;
 Tue, 17 Mar 2026 12:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55742C19425;
 Tue, 17 Mar 2026 12:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773749991;
 bh=UieOFz+D2vIk/mOObD9j/eJjAo9MB/imC/AN8dxznY4=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
 b=GypqWCLIUZRr3YpzzpXxvFJgnKC/RpOFtaklY2O070qzJoxx0spGlxX76DiSUCrT1
 x9ro2LeLhjocJDxuO2p3patgylJtH2Mf7+Rmyt4QNjihfsDnmIlp/J5YTQiOXCnJt/
 eNMER8E7IcqEirBQ7w3C/KfnlDS/lTMCI5kdd73Upc9GC7NDI+0t4JS8wUDW3bJYBr
 Hn1y2+xOfbSSRWD0sPW+/v+vAETSuxkjoHTNmZh7LeK9k07A5BhJaM/EOrIKtMhL0u
 NAf4TqmPfOw4HPC66eNDp4sDQaCqp0llIpfaP36VnytHgDohya6KxC6sjUQoueOpRY
 BLWuCrxQ1GUnA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 17 Mar 2026 13:19:47 +0100
Message-Id: <DH51W6XRQXYX.3M30IRYIWZLFG@kernel.org>
Cc: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Boris Brezillon" <boris.brezillon@collabora.com>, "Tvrtko Ursulin"
 <tvrtko.ursulin@igalia.com>, "Rodrigo Vivi" <rodrigo.vivi@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David Airlie"
 <airlied@gmail.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Philipp Stanner" <phasta@kernel.org>, "Simona Vetter" <simona@ffwll.ch>,
 "Sumit Semwal" <sumit.semwal@linaro.org>, "Thomas Zimmermann"
 <tzimmermann@suse.de>, <linux-kernel@vger.kernel.org>, "Miguel Ojeda"
 <miguel.ojeda.sandonis@gmail.com>
To: "Matthew Brost" <matthew.brost@intel.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [RFC PATCH 02/12] drm/dep: Add DRM dependency queue layer
References: <20260316043255.226352-1-matthew.brost@intel.com>
 <20260316043255.226352-3-matthew.brost@intel.com>
 <DH44U26ZLJS2.3DTS9D6PA0IL4@kernel.org>
 <abjiTQe4/mRQ8wyA@lstrano-desk.jf.intel.com>
In-Reply-To: <abjiTQe4/mRQ8wyA@lstrano-desk.jf.intel.com>
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

On Tue Mar 17, 2026 at 6:10 AM CET, Matthew Brost wrote:
> On Mon, Mar 16, 2026 at 11:25:23AM +0100, Danilo Krummrich wrote:
>> The reason I proposed a new component for Rust, is basically what you al=
so wrote
>> in your cover letter, plus the fact that it prevents us having to build =
a Rust
>> abstraction layer to the DRM GPU scheduler.
>>=20
>> The latter I identified as pretty questionable as building another abstr=
action
>> layer on top of some infrastructure is really something that you only wa=
nt to do
>> when it is mature enough in terms of lifetime and ownership model.
>>=20
>
> I personally don=E2=80=99t think the language matters that much. I care a=
bout
> lifetime, ownership, and teardown semantics. I believe I=E2=80=99ve made =
this
> clear in C, so the Rust bindings should be trivial.

No, they won't be trivial -- in fact, in the case of the Jobqueue they may =
even
end up being more complicated than a native implementation.

We still want to build the object model around it that allows us to catch m=
ost
of the pitfalls at compile time rather than runtime.

For instance, there has been a proposal of having specific work and workque=
ue
types that ensure not to violate DMA fence rules, which the Jobqueue can ad=
opt.

We can also use Klint to ensure correctness for those types at compile time=
.

So, I can easily see this becoming more complicated when we have to go thro=
ugh
an FFI layer that makes us loose additional type information / guarantees.

Anyways, I don't want to argue about this. I don't know why the whole threa=
d
took this direction.

This is not about C vs. Rust, and I see the Rust component to be added
regardless of this effort.

The question for me is whether we want to have a second component besides t=
he
GPU scheduler on the C side or not.

If we can replace the existing scheduler entirely and rework all the driver=
s
that'd be great and you absolutely have my blessing.

But, I don't want to end up in a situation where this is landed, one or two
drivers are converted, and everything else is left behind in terms of
maintainance / maintainer commitment.

>> My point is, the justification for a new Jobqueue component in Rust I co=
nsider
>> given by the fact that it allows us to avoid building another abstractio=
n layer
>> on top of DRM sched. Additionally, DRM moves to Rust and gathering exper=
ience
>> with building native Rust components seems like a good synergy in this c=
ontext.
>>
>
> If I knew Rust off-hand, I would have written it in Rust :). Perhaps
> this is an opportunity to learn. But I think the Rust vs. C holy war
> isn=E2=80=99t in scope here. The real questions are what semantics we wan=
t, the
> timeline, and maintainability. Certainly more people know C, and most
> drivers are written in C, so having the common component in C makes more
> sense at this point, in my opinion. If the objection is really about the
> language, I=E2=80=99ll rewrite it in Rust.

Again, I'm not talking about Rust vs. C. I'm talking about why a new Rust
component is much easier to justify maintainance wise than a new C componen=
t is.

That is, the existing infrastructure has problems we don't want to build on=
 top
of and the abstraction ends up being of a similar magnitude as a native
implementation.

A new C implementation alongside the existing one is a whole different ques=
tion.

>> Having that said, the obvious question for me for this series is how drm=
_dep
>> fits into the bigger picture.
>>=20
>> I.e. what is the maintainance strategy?
>>
>
> I will commit to maintaining code I believe in, and immediately write
> the bindings on top of this so they=E2=80=99re maintained from day one.

This I am sure about, but what about the existing scheduler infrastructure?=
 Are
you going to keep this up as well?

Who keeps supporting it for all the drivers that can't switch (due to not h=
aving
firmware queues) or simply did not switch yet?

>> Do we want to support three components allowing users to do the same thi=
ng? What
>> happens to DRM sched for 1:1 entity / scheduler relationships?
>>=20
>> Is it worth? Do we have enough C users to justify the maintainance of ye=
t
>> another component? (Again, DRM moves into the direction of Rust drivers,=
 so I
>> don't know how many new C drivers we will see.) I.e. having this compone=
nt won't
>> get us rid of the majority of DRM sched users.
>>=20
>
> Actually, with [1], I=E2=80=99m fairly certain that pretty much every dri=
ver
> could convert to this new code. Part of the problem, though, is that
> when looking at this, multiple drivers clearly break dma-fencing rules,
> so an annotated component like DRM dep would explode their drivers. Not
> to mention the many driver-side hacks that each individual driver would
> need to drop (e.g., I would not be receptive to any driver directly
> touching drm_dep object structs).

I thought the API can't be abused? :) How would you prevent drivers doing t=
his
in practice? They need to have the struct definition, and once they have it=
, you
can't do anything about them peeking internals, if not caught through revie=
w.

> Maintainable, as I understand every single LOC, with verbose documentatio=
n
> (generated with Copilot, but I=E2=80=99ve reviewed it multiple times and =
it=E2=80=99s
> correct), etc.

I'm not sure this is the core criteria for evaluating whether something is
maintainable or not.

To be honest, this does not sound very community focused.

> Regardless, given all of the above, at a minimum my driver needs to move
> on one way or another.

Your driver? What do you mean with "it has to move"?
