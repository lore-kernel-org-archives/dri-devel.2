Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA71CD8CB9
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 17:19:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAA2B10E404;
	Tue,  9 Jun 2026 17:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DctiSB9k";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEC7010E404
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 17:19:38 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304dc707c7eso543570eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 09 Jun 2026 10:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781025578; cv=none;
 d=google.com; s=arc-20240605;
 b=XqqXHP/lLyUqAT8UGpid8nenSAY2hmoJoEVCuKqWGljpfZfIzx/w+RSZ8oFEB4UWNi
 VsKlvtTujJ4EafgNpRSygQ2Kl35fZLSqvXhecEJGcPaSUNQFdVpRQVMuPrvGP4ObbRfy
 XdOEvpnAR+FG5egdU6dEUHgGnhU2L2eY2DTiyai0jCq4V682c/Bw3p5CE9B8UvhBhVou
 RjfpzuV2FBWu9k1SlMpvjG0maGHUECtv0KosdMtFNZ32IbT9oP4HHDrr+B0tGBt1e7FG
 eZT4CN5CVP5lX9tJG9KQ9iqsfvPuLOHJbDtZiudo+55tzyhm4kSpDAeeFUT8NT4lgoVx
 nvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
 fh=jCMac+r3nPDeGexROdStQdRU7yIXPW6ErfpjUbHEpFU=;
 b=VKeyuq3xJbMSKa4lY11Q/zRpHHL2fL/ueMCSBa76gJdj++VD+lMoMbeUlG06qonC2e
 BoARZZ9th/nWI008p4ZW/kA/FpYPBngzDx0eQ3r4QcE1OrXxdxuJmon66lOQ+uP+0qvM
 iTKx35UPorbClMvLFhevyz2KeQVnF862Ef8fHUT3tCu8N+FUjfV/5orvgv/AAm9HLWO4
 7yL2v9I2JRCzhZ3q+ZpzW0nzaBC95Bdg0LNcI3hK8/Z0NPVGpLOYOubknbph1Wh9Q/F8
 2Bh8UneX1/oxRYps/daFvhuwiLZzdAygyIPQdgnyQkj/kzMcLpWaPg3APf4bEo9r7huV
 KwBw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781025578; x=1781630378; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
 b=DctiSB9kEHxtkNhWPCzLmQqklHOB/qyi5Eq8+t59uBVpAzU8/HGfzuXa72aW/HXuwN
 nPc3oCbj27iv4y0flUpDCRtJUZxde8LBCMWGJZShXoXDSofkMnk1sBonxpKOaux/L5gG
 um1lbt2jSm937pFVgt4mJ0PX+ResYrC8KK3vdmLna2VVNJcZRC6S9yfB5COtlWHqGUNe
 46blRG3BA6JYVFroZAuEP0gpFdkfwI79So+4i7+YwZg687CFnApmRD9t5e+zu3QueV/k
 Ja9uLqi9h53TyR5PrtS7WxYfmYZGikj9YO4pj6ejWRqCUgR3yCaRQZOMi9ToE6uvkY56
 8vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781025578; x=1781630378;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qdj1ZDhkK9hVS2s2BU4ZL0QegPmYjb1pgGPh1FYEFmw=;
 b=kGfpnEseS+ywip4llNuhsmfNhv8TK+mHSq4br5LrQ3HRloIOEHR0ZIzXNc6RGj+tQA
 riHycaWo7AHrg4yvrk+E5504H7l1VkIkNk+nsLQFfyZschHUk52y1Gn6lzkeUsXwiAC+
 xbeHwUDsGYKhU7Zwq1cjI2lp8fxBaosph+Tuf5712pjZ65xUyqPOdaA24GFU1uU5cJfy
 nj4yUGqOzb9qfTkWVq6WYwMN5+lMAvEqAwm48t+GlHNHCWANkbDeVF44W0NYQnr7qIEH
 DMvYUZ9MCjOVs1bMDKg/rSgvXXIbHEqB4H58C4F9AhlhSLV/VWxq/uJmSuZqws17Xvxt
 bpkg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IjbkWwtjDwLkcg7hrpiF29Sb2lFZ7HX0RUx/iFcSwWLnRrr2cnwYBdgOqFt3YIueLxFzltg0F6oI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyEf5+gozXSnrZT4I+WuEjDvADMtMKYSalUtVzyIyfqsmbPtfn
 KiYn3lZrFrqiuSqtR2IINk0jzzb9oWYIPpQzrrNt9DFXmtmo2Qf3oRhsRpijJMahRtSDI+wIyCq
 ErBbOCBGv8LFFtqyu8x/gZ/vdAdrJIKs=
X-Gm-Gg: Acq92OFHwhIQx12hnxSv1iwgUrpITzA6OZBLmqprYhw6WP8/K4XESp/X8jYAJnj+cQJ
 CGjjAtP1BUgBsTk6+M29fpCkc7ogC5lFZ/pstOSBP7j9N1HrBLJ+eCWRMvNwHrWqJ9C+g7Cllfv
 4AmnzjZ3ZNevrp9dfkp11KuMSpajfhpdOkWqtkYj3cTJhwLY7FyfQcd7qIHyJWeXsA+mtMT2gjA
 qZd7t6KEF8OqNCbeds578XxttTiAwObYd/GBCIudQzKvbA4jVqgWKZDcduZGKCU193wkl6HokdL
 oy1hKr+Y/63HYpZhVFAgWPju6QA18mNZuHS3Do2In9gT2O5IkPsFWOEgyAY2F7ddPuMlZtHr7n6
 ENgHs2BqmJWx9mPhnutld3h5msQLhOLcfXw==
X-Received: by 2002:a05:7301:169a:b0:2ff:b29b:87b with SMTP id
 5a478bee46e88-3077b5fe235mr6554986eec.5.1781025577871; Tue, 09 Jun 2026
 10:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260609142637.373347-1-gary@kernel.org>
In-Reply-To: <20260609142637.373347-1-gary@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 9 Jun 2026 19:19:25 +0200
X-Gm-Features: AVVi8CeFkVbj9E3PXx3Az4UAa3Y8O7iOpi-vamCvayZRaQa0QwlC9T9yRU6Twpc
Message-ID: <CANiq72miJLmc2EadxUa+yVZ5T72QuTES4Gz=YVUsNivYvR=wDQ@mail.gmail.com>
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>,
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
 Waiman Long <longman@redhat.com>, Tamir Duberstein <tamird@kernel.org>,
 nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
 netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Jun 9, 2026 at 4:27=E2=80=AFPM Gary Guo <gary@kernel.org> wrote:
>
> This is the remaining unapplied patch from
> https://lore.kernel.org/rust-for-linux/20260319121653.2975748-1-gary@kern=
el.org/.

Thanks for rebasing! I had it as "Waiting for apply" in the
spreadsheet, but this saved me a bit of work.

Quick question below about the prelude...

> +#[doc(no_inline)]
> +pub use crate::build_assert::{
> +    build_assert,
> +    build_error,
> +    const_assert,
> +    static_assert, //
> +};

Did you split this for some reason? I moved the file to a single group
per crate when I moved the file to the new formatting style, so I was
wondering if we could keep it non-split. I mean, it may be nicer for
macros since it allows us to group them, but I hope we don't end up
with many `use`s again if we go down that road again...

Or perhaps you did it for the attribute, i.e. it may behave
differently, but I doubt that is the case? i.e. if `no_inline` somehow
behaves differently this way.

> rust/kernel/sync/atomic/predefine.rs

In this one you used the prelude, but in the others not -- which is
fine, we should be using the prelude more (though perhaps it is a
separate change), but I wonder if there was a reason.

Thanks!

Cheers,
Miguel
