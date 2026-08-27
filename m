Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0719C61DB9
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE79510F0C1;
	Thu, 27 Aug 2026 14:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hLU8g6oQ";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CF7810F0C5
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:55:34 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-482db627cd8so1004513f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 07:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787842533; cv=none;
 d=google.com; s=arc-20260327;
 b=hns2ZFAMsCIhoRr6+9Eh8D2B/iwsUfkRa2tvoNe5O8lE0W1KX14cng+CGD3llyOzMx
 Bk0/XElMLp7gBtN8uTBXMcW4K+cDiHVcGa9RdvEQ6YsfLeS53JFExlY8UFWi0qvm74pr
 4MmlovmJggI0jIW10ZQaNDfDmJ6LJTPECUkJBby5xCtmV0yy6dwUvLuDo7CFwQEIQwwD
 48MOEgy4FkVWztiWcLrU4Z91c07Hpn7bh6/i7Rru8f0UKwe8mTyEnOfjYHDZ5knQW4En
 E+AwCG3s5Fl5g9KIMuEGkeWBOFYMJ1Zkrlsn4W49T8Xy1N7imhEzHE0v+rm0El67eSJV
 FfUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qVBhIMzhe7WHb1kI7rr6+dI+gx2GywitZXgSUgINjAg=;
 fh=wuBqH4iNlQbZLw5qmvjLGd7IHlI7POPITD61nkbT0Aw=;
 b=ThvHNUoYe0xw4hnO6xxxbfxChSRQz+l4RSAr5fcoXewraJH5+ekFzAt8qEByJyLo7/
 5D2SJONbARXoqZXwObarkiE23K3QOeTRUaiK30naav7b/cnp8XZ7QAPa/vq4e/LUdDmR
 OD3lEWbE3FTD0lnvFWrXkwkmADsImv1uIhQy4P8+jHv4nU6DBM/JIr/J5eJA096e85zI
 Om8McvE9ioLM9FGRecqQ3WTZIUhp9MMssg+OEqQ1CZNjID2WhzXHd1uDb+GzZzK01t5Y
 8HrsStjxGaM5aXXFzuABEnU712ejAtJAWqHUX6tVYEHiugcpEqtMmisndERRejsZ/Mtt
 qFHg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787842533; x=1788447333;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qVBhIMzhe7WHb1kI7rr6+dI+gx2GywitZXgSUgINjAg=;
 b=hLU8g6oQzqWTvtCwQaDB16+xb7aB1KA/7CWaM5Mg3PwLeBYBMvc9vyGMmg/xdqjZ6I
 b6sXKXqriMINmOCBahBRN2uXpwjlsm3ABaSbRgEqHpFWn/2ysd13z0qaayKb0wge6QVl
 Xmtdnwa0Si9fCvtWxXh3I64abSZ4WqARVWEHPU9vlADYjJdlbDX6N64+wvkuPI2iWtYn
 QSdb5W8SLE3OcS4EGG+FpAn8gsAkp0Rn1q8+SLWUW1GFs8P750pzJoDEX+JDQyuLkCoz
 /iJc4yTubUXV/at0gvrXFIbsvTDSe41Inq3alBQfbZs6MrQ42kc3+XD8r+BXOjgcxyr4
 ilyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787842533; x=1788447333;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qVBhIMzhe7WHb1kI7rr6+dI+gx2GywitZXgSUgINjAg=;
 b=maucRHqOTtLchPE98RJMKQ8FOiOEyqUmrqJyqOsoF9OIyylE6Q2f9sZ8+Z4l9JNojr
 9ue7bF+1OdXnTI3hJcEi5ETpNGcvz2a+yhvmKtMK+/XdPgG/kd7IZwaYklEcl/wIM2qf
 ce0sgkzGN31YVFiO+cV13X2dhABSFKuNXB3q7X/260OR6NB7emckn3VcmAtKoDshCjlx
 xpuz3rrePI/WnCCZWcjzhlVRTaXdzsBKXetG66e6kZNHREjisSZEodYJevGLW2lxxFk0
 gKmATg61ZRnbH2FTS4BmmPJPpjO+DSPbC6F39Cc+6iYB2x+A4gEEc5Vsd2DumNmckSBJ
 84rQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpmASfUXhsV1yS0p0AMxzuLmI8yp49iwqNdyi0cWEo9FGjEtQDx8hnwux3u4H50UhmUwr5DqQwvqcY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nFCqOrTttdqk9WHYOv1xfvHczpWU7dU7g5fSToke2XloZmIvnc
 n62xnml9ItSPOHY1bNhbx9fg42pugQiFqi4GAtI6LpLutqYMAdJyrvJqXSGiL784QFWc2P/WnX7
 LZeVIeblcnwby+3ydQVptSaGwooOSU5XPg9+yAwEo
X-Gm-Gg: AR+sD11afD4Tq5bJqgY4qeDBPnM45q/cGW/poCpAeisiWNBYeObBP3Zf2qzKjO528Hg
 HdD9RK6xjfa1L2KPfLrubfSV5JDPJsYStFGiUlKqCOsOgCKwLV6xRFbVunu0K9brYeM1DT3yGhn
 hOW5x3sqk0OQ0mW3iBnvxUwljQ2a3lIOqwXnjMXS8R3Sz1VjhqEe7DVXvoUQ2jTVnlgQAfjsRoJ
 aO9Fmhvve58Jwf4pIuH1lmMGROs57PEFSYJlunAo2x+8P2yauIEVQnbOlc3nnw3VcovcLl/kfUa
 Uh7uaUIMhyXtCZ9vwcWM/j/cjcXbMK6pTc/KZmG8xW9EC+OpSyQyMYwKyO4p7yO/0TT1lYhj5WV
 HPUM2H2OtZGSd+PjXHXO07cexduHOQJw=
X-Received: by 2002:a05:6000:3106:b0:482:e2f2:19c5 with SMTP id
 ffacd0b85a97d-482e2f21d8dmr18185624f8f.4.1787842532050; Thu, 27 Aug 2026
 07:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260827-chid-v8-0-bc74c77d0214@nvidia.com>
 <20260827-chid-v8-3-bc74c77d0214@nvidia.com>
 <apAEK9CUZICDTL1i@google.com> <DKZNWJZTS063.3Q91LQ4LNE4Q6@nvidia.com>
 <DKZOJLLRFT75.1967F9U9JUTVV@nvidia.com>
 <DKZRUNURZ645.1R1EVJ9ZEXFDE@nvidia.com>
 <DKZSPZS1CQ29.11DHEBVKWF21O@nvidia.com>
 <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
In-Reply-To: <DKZSWB7OFDRY.1QKAIFC1QP9RA@garyguo.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 27 Aug 2026 16:55:19 +0200
X-Gm-Features: AcwNN1W6xr0Wm3p3I71rq2uMxpgrJyrhaLEP44TiP1BL4sxWyBuOjb97Iy1a-84
Message-ID: <CAH5fLgiGcOn+HQLj4w9yDc31V54PbqNUQv8cUFRoEuFzQrAAZA@mail.gmail.com>
Subject: Re: [PATCH v8 03/12] rust: num: add cv! macro to create values from
 constant expressions
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>, 
 Burak Emir <burak.emir@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 dri-devel <dri-devel-bounces@lists.freedesktop.org>
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

On Thu, Aug 27, 2026 at 4:37=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> On Thu Aug 27, 2026 at 3:29 PM BST, Alexandre Courbot wrote:
> > On Thu Aug 27, 2026 at 10:48 PM JST, Eliot Courtney wrote:
> >> On Thu Aug 27, 2026 at 8:12 PM JST, Alexandre Courbot wrote:
> >>> On Thu Aug 27, 2026 at 7:42 PM JST, Alexandre Courbot wrote:
> >>>> On Thu Aug 27, 2026 at 6:32 PM JST, Alice Ryhl wrote:
> >>>>> On Thu, Aug 27, 2026 at 04:28:31PM +0900, Eliot Courtney wrote:
> >>>>>> Currently, using NonZero/Bounded constants is quite verbose. It's
> >>>>>> unfortunate because it disincentivizes using it in interface bound=
aries.
> >>>>>> Introduce a macro to make it nicer to use. The macro `cv!` (for co=
nstant
> >>>>>> value) takes a const integer expression and widens it to i128 (at =
build
> >>>>>> time only) before passing it as a const generic value to a new tra=
it
> >>>>>> function `FromConst::from_const`. The trait is implemented by NonZ=
ero,
> >>>>>> Bounded, and Alignment and lets values of each be constructed from
> >>>>>> constants without a verbose turbofish syntax. For example,
> >>>>>> `const { NonZero::new(1).unwrap() }` can be written as `cv!(1)`.
> >>>>>>
> >>>>>> Suggested-by: Gary Guo <gary@garyguo.net>
> >>>>>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> >>>>>
> >>>>> This doesn't work in const context, so I don't think this is a grea=
t
> >>>>> strategy.
> >>>>>
> >>>>> I would want to use it for cases like this:
> >>>>>
> >>>>> drivers/android/binder/netlink.rs
> >>>>>         const BINDER_CMD_REPORT: u8 =3D kernel::uapi::BINDER_CMD_RE=
PORT as u8;
> >>>>>         const BINDER_A_REPORT_ERROR: c_int =3D kernel::uapi::BINDER=
_A_REPORT_ERROR as c_int;
> >>>>>         const BINDER_A_REPORT_CONTEXT: c_int =3D kernel::uapi::BIND=
ER_A_REPORT_CONTEXT as c_int;
> >>>>>         const BINDER_A_REPORT_FROM_PID: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_FROM_PID as c_int;
> >>>>>         const BINDER_A_REPORT_FROM_TID: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_FROM_TID as c_int;
> >>>>>         const BINDER_A_REPORT_TO_PID: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_TO_PID as c_int;
> >>>>>         const BINDER_A_REPORT_TO_TID: c_int =3D kernel::uapi::BINDE=
R_A_REPORT_TO_TID as c_int;
> >>>>>         const BINDER_A_REPORT_IS_REPLY: c_int =3D kernel::uapi::BIN=
DER_A_REPORT_IS_REPLY as c_int;
> >>>>>         const BINDER_A_REPORT_FLAGS: c_int =3D kernel::uapi::BINDER=
_A_REPORT_FLAGS as c_int;
> >>>>>         const BINDER_A_REPORT_CODE: c_int =3D kernel::uapi::BINDER_=
A_REPORT_CODE as c_int;
> >>>>>         const BINDER_A_REPORT_DATA_SIZE: c_int =3D kernel::uapi::BI=
NDER_A_REPORT_DATA_SIZE as c_int;
> >>>>
> >>>> `const_as!` [1] should do the trick for this, provided you don't nee=
d to
> >>>> create a const `NonZero`.
> >>>>
> >>>> [1] https://lore.kernel.org/all/20260825-const_as-v1-1-1ce712225fe2@=
nvidia.com/
> >>>
> >>> ... but I agree it would be nice to be able to use this in const
> >>> context. And there is an overlap with `const_as!` that becomes more
> >>> obvious the more I look at it.
> >>>
> >>> In for a penny, in for a pound of macro code as they say. Since we
> >>> agreed on using macros, how about unifying both under the same `cv!`
> >>> macro, with as many branches as we have types we want to initialize f=
rom
> >>> a constant value? For instance:
> >>>
> >>>     // Does what `const_as!` currently does under the hood.
> >>>     const BINDER_CMD_REPORT: u8 =3D cv!(u8::from(kernel::uapi::BINDER=
_CMD_REPORT));
> >>>     // Calls `NonZero::new().unwrap()` under the hood.
> >>>     const SOME_NONZERO: NonZero<u8> =3D cv!(NonZero::new(kernel::uapi=
::NONZERO_VALUE));
> >>>     // Calls `Bounded::new::<{ ...}>()` under the hood.
> >>>     const SOME_BOUNDED: Bounded<u32, 2> =3D cv!(Bounded::new(kernel::=
uapi::SMALL_VALUE));
> >>>
> >>> I.e. we would have one extra matching arm in `cv!` per type it handle=
s
> >>> instead of implementing a trait. The syntax of the macro would look m=
ore
> >>> natural (bye bye `const_as`'s awkward `=3D>`), albeit it would have t=
he
> >>> limitations of such a semantic dispatch.
> >>>
> >>> Even the name `const_as!` wasn't really accurate to begin with: what =
it
> >>> really emulates is a const `try_from`, and we even discussed
> >>> implementing it in these terms in the future.
> >>>
> >>> I'm sure the idea needs more polishing but I think there's something =
to
> >>> explore here.
> >>
> >> Yeah I agree that const_as! is similar and if we had const traits we
> >> could fully merge them and have it always work in a const context for
> >> both duties (which are really a const tryfrom as you said).
> >>
> >> I am not sure about the suggested syntax (e.g.
> >> cv!(Bounded::new(kernel::uapi::SMALL_VALUE))), since it seems very
> >> verbose.
> >
> > A bit, but what I like is that it looks very close to what you would
> > naturally write if you had const traits (minus the unwraps), so you
> > don't have to learn a new syntax. As long as it's not *more* verbose
> > than natural Rust, I think it's fine.
> >
> > It also has the benefit of relying less on type inference, i.e. `cv!(5)=
`
> > requires the caller to specify the type even with a `let` statement,
> > whereas you could do `let v =3D cv!(NonZero::new(5));` and it would wor=
k
> > as expected.
>
> Even with const try_from we'd still want `cv!()` to avoid having to write
>
>     const { Type::try_from(...).unwrap() }
>
> I think having `=3D>` syntax is great because it is a good place to *opti=
onally*
> require type annotation.
>
> For enum repr for example, I think it'd be great that
>
>     const BINDER_CMD_REPORT: u8 =3D cv!(kernel::uapi::BINDER_CMD_REPORT);
>
> would work directly. It might need some tricks, which I have hard time co=
ming up
> as I'm not feeling very well today, but I'll give it a shot over the week=
end...

One could potentially define a trait with a MIN and MAX value
constant, and then implement cv! like this:

1. Verify that the value lies between MIN and MAX.
2. Cast the value to uNN of the same size as the target type.
3. Transmute the uNN to the target type.

Since the trait has no methods, this works in const eval.

Alice
