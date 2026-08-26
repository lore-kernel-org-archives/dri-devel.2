Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95DF5C61DC2
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 09:30:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C899010E297;
	Wed, 26 Aug 2026 09:30:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="We01mxx0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5780010E297;
 Wed, 26 Aug 2026 09:30:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 54A36600C4;
 Wed, 26 Aug 2026 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702F41F000E9;
 Wed, 26 Aug 2026 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787736628;
 bh=iMEzDkYcY451+lpGVbq4N303Ki4TMyeDEp9MG7bMHsQ=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=We01mxx09AWtjjIEC7dgcumwsPTlnB+RumUI2X0cDWBcS8vCWRsEp95aPLzwMp3cZ
 02Qz7Xa8UziCq4AVb2PuyW+VeMwVHCBn7/Ht9JEsUpbO66PmqRHIYGlGme6/JRYYfF
 4hwgZ5jHIH3cKf4LlWBOPWrXAshUGINwiIuCBBZ9A+pg3n8jwT2Cdg0romH8wAoany
 v6WOn2w8PTxqpz5X76NgihkagKy381C55iE9qZQDsk7OR92r7bc3bFDjNNF2oE+Jba
 CoADfDyTO9Hogk1Z/rRoipR5eCZMWRtbg0iU6x8zaas/Si3BBz0BOA+XZYR16VH061
 ai9S/QRmsD/IA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Gary Guo <gary@garyguo.net>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 Jani Nikula <jani.nikula@linux.intel.com>, Joonas
 Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi
 <rodrigo.vivi@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Lyude
 Paul <lyude@redhat.com>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 6/6] rust: hrtimer: Make HrTimer repr(transparent)
In-Reply-To: <DKY2AIA7ELLI.1REFFZGXL78Q5@garyguo.net>
References: <20260825-expires-v2-v1-0-90411c6217c7@kernel.org>
 <20260825-expires-v2-v1-6-90411c6217c7@kernel.org>
 <DKY2AIA7ELLI.1REFFZGXL78Q5@garyguo.net>
Date: Wed, 26 Aug 2026 11:30:16 +0200
Message-ID: <87v78x1b6f.fsf@t14s.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
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

"Gary Guo" <gary@garyguo.net> writes:

> On Tue Aug 25, 2026 at 1:16 PM BST, Andreas Hindborg wrote:
>> From: FUJITA Tomonori <fujita.tomonori@gmail.com>
>>
>> HrTimerCallbackContext acquires a &HrTimer<T> from a
>> NonNull<HrTimer<T>> while a &mut HrTimer<T> can exist at the same
>> time. This is sound only because HrTimer's sole field is
>> Opaque<bindings::hrtimer>, which puts every byte behind an UnsafeCell.
>> Adding a field to HrTimer that is not Opaque would make acquiring that
>> shared reference unsound.
>
> HrTimerCallbackContext is removed in patch 4, though?
>
> Still worh preferring `#[repr(transparent)]` over `#[repr(C)]`, but the
> motivation should be reworded and the comment on `HrTimer` should be removed.

Yes, I was a little too fast when I added this patch. I'd like to keep
it as well, but it needs some edits.

Best regards,
Andreas Hindborg

