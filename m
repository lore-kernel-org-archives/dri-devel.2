Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1B29CC6B2F
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:56:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA879112124;
	Thu, 15 Oct 2026 07:56:37 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A14710FB7E
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 07:20:55 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-354ba08cfd1so6450070eec.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 00:20:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791962454; cv=none;
 d=google.com; s=arc-20260327;
 b=GkONXPfi5rr1AQIWzvVV89k2kkcPs2EsSDCdMogctyDUpjMChbA04oP76kxU4Op8nj
 QpThVI31QAu2hKl+kqVZ7kpnxJOQJsAQAG5yleo0phSmlPAOIyJAfZOQAK60HNK9HUNx
 1GxgsvHDHjoOVzyxy0r4V/Ud8hVHVPQ5cLWpRtT7knmebridUDKm2bRh2f0d6+vhr7Ah
 lHXaEXyOaIm60/z+llo+bGZgs0CwiqN22LQV/iJdidcr9vj8n4uRGSyFevLWtplak+hl
 LAHKaYB1z/k/A9j83pm2/C8f8MJCtnzdTYXPzm8fWHRYQmryBcfsW7EdbKJMl7+Aqn0b
 nhxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=lOqIiE4c6ssXVSy50LPJhAKLmMDJn1HolGWfMJ3me+U=;
 fh=50oHhaAEQt+QYO9n5IYvm78cCCd3PxBbRS+ph53Dcac=;
 b=Y4v7tkq09OgeKgKEAQ72RihMhBOCOdag2u7YXDzdwgk12uQDvAHGVRLbBKM7BO6tJF
 cto8D6r9LJ/cT5/m6IyvBSRiJ9YxCudFo3nzapKfTQiI3NP8t2/xfPII2ZgA+p14aAkw
 cTQ/IhWPPXlnMutZmv7qdGpH+U2T6ctDs8r9nA2lZMbzkErGjVZr6GAuzUPe/hVOfB2z
 If4Egw20VsAMj3BDjwAYOMq0TZ9cXHn9RI90w2hxyTPK5BFHYEJqLaiGqT5O9xZ4vNKq
 LwvZAOYV5v4GrW/JNLeHrcolYI2IQw71peA6AlXHR0q75DB2m0Ug2VyzG0cUYtEHElhr
 NuqA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791962454; x=1792567254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lOqIiE4c6ssXVSy50LPJhAKLmMDJn1HolGWfMJ3me+U=;
 b=SD0crtxhOMGof6+0VwFxV3DlRmgdvobep0Ja9fKKdUSpZ1aw1s3l72QzgjIDMSU88M
 STOapwUVOgWkFuvdB0xyzD7GpzqhWYov3Mzc2wwp39D+9IEeGo5Lr2wAaO+ooo/E6h4y
 HrNc5IcwksU1b/azOrJ3G8CCmRy4Ld2C1gYOGBdCCBMlTIYD/ErTHX5DcJRECa68+yvP
 iIPkwdpcEyD1DSj9wVnnJS8DCL/L4Bg3szxpd9yq2OZfVK1EAYSd/JBtSrLUHvGYFU7a
 5VBokgkv15YEXa4fWRU5lOvo07wEXDyDSAazlH5i8BECBYxhiCIN/c4TT/2x69iaS3Mt
 Zxxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791962454; x=1792567254;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lOqIiE4c6ssXVSy50LPJhAKLmMDJn1HolGWfMJ3me+U=;
 b=mH9Dnnp1tM4C08kNEVK6CaUtAVlP1QrpMJv8wBR/dC25BpA30k5sEP6xLA778FLlUD
 czDTu9WJ6vRc3BEzNlrJRVWPqu8eiCN18W8daQGImWb6lVRbNjmqFBypKWY0fCJSzwzk
 HIOGeKRe36yBgY7XGrgmbIBwKP7+qYJ+ETARh7YYv3ZR1lIFvLaWkgC0yTFLtOdyAuJx
 oM+a6G/E0JnUliiA+sS7lkte3bC6VLnS9KMUM754/oNLggfTnaBLaLXyLTWgnaXJlXsu
 MnZWbhBn8CHzQ2CkHFTYDlrwUpHT3mtqHo0ZJckOXTevgokorLJIbQWxcoTwVa4f6vqZ
 egpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQoy5mO2XWSM7HQTenU10cufF6q9CNifkFX8g90UnTPRhLvCwrhW7nOAXVrv9QR3l+0W3NpRREZGo=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3ysIPPVoFnqLvSVldM+CoTizARKwHCetCc0GkTdydRrijdhuM
 H3dhVfjRTp2Fd1sBJUv8vf67OCvzqRbodJ56NZ+DL9jHI3PglL3aA3Q5zmvDriiiiRl14CrXzzb
 6QAExhcz4Sdz5NlWIGqzM+iY1hBlMSXE=
X-Gm-Gg: AYBFou1tlK4q85lOcoJn/iHJeXph/rq+Znk9fI7/peWh3kpDUSf7lceBmve3rbPHSgC
 RcXOS7HpxN2K1eC7dzhldAD7TMKhVtL6Tgxn2kh9Uo5mdErVxMCjdH4iSnoxsIYnIyxgJzDh34d
 detchQIZuCRhtCjOsZ8wCadRr9AnaT+8bj9KqHMSzy3xui49g6unDphl4HQTXmghuHzz916Wk3S
 N6/bhdxJupa8AvVE3GWEdY3iC+iHlSTquVJBb7YgTX6BQQyKPwGAC1Seznuu2WwUu8bkiCTBSOJ
 tFj+FzeB6i1LLkaI7P6PafugkDqQtPTcQBU8AHvyFVp9WPPeZHMeOlB83kIIKzR+6hP/axFmReK
 g61G8oxHxqH/nRQjMmCF9Z1DTuSieTo+dhb+7xmJegbgxaGGyhS5B1+JisqPSUd2rUt8WYNPSyz
 si49O4r+ed0YZileoW5HN4ig==
X-Received: by 2002:a05:7300:7f21:b0:34e:f5f1:2f46 with SMTP id
 5a478bee46e88-3537e03ef03mr21519176eec.6.1791962454025; Wed, 14 Oct 2026
 00:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260930-chid-v9-0-0d6cca376cff@nvidia.com>
 <20260930-chid-v9-8-0d6cca376cff@nvidia.com>
 <aryYkkB9j14xnWo3@yury> <DLTA93JE6VF2.37UGB3SWU6ID6@nvidia.com>
 <ase7IBtZjQsPVWSN@yury> <DM0D75ZTTQXJ.2XADVI38UGH7C@nvidia.com>
 <CABwQupMVzUOsqP_fTZQdwUU+xEO1k2Q4=RQQuq2qd5HCYY0ZUg@mail.gmail.com>
 <DM46Y905AJVV.1K0F8AK1ZP4IO@nvidia.com>
In-Reply-To: <DM46Y905AJVV.1K0F8AK1ZP4IO@nvidia.com>
From: Burak Emir <burak.emir@gmail.com>
Date: Wed, 14 Oct 2026 09:20:41 +0200
X-Gm-Features: AclHuK9j0P8UdZSidrrjx2Ojz1IkBJh5CagOtrg90NI1i0FixMsvpGr1DSVhkR4
Message-ID: <CABwQupOYBBev5WkQry3oOoX5tGCs-ggDE4L_nK8BBYvrO=81bA@mail.gmail.com>
Subject: Re: [PATCH v9 8/9] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Yury Norov <ynorov@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>, 
 Alice Ryhl <aliceryhl@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:56:36 +0000
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

HI Alexandre!

On Wed, Oct 14, 2026 at 4:04=E2=80=AFAM Alexandre Courbot <acourbot@nvidia.=
com> wrote:
>
> Hi Burak,
>
> On Sat Oct 10, 2026 at 3:48 AM JST, Burak Emir wrote:
> > On Fri, Oct 9, 2026 at 4:07=E2=80=AFPM Alexandre Courbot <acourbot@nvid=
ia.com> wrote:
> >>
> >> On Fri Oct 9, 2026 at 12:47 AM JST, Yury Norov wrote:
> >
> >> > If you still think that you need 0-length bitmaps in Rust, can you p=
lease
> >> > give the clear and thorough explanation why rust needs those 0-lengt=
h
> >> > bitmaps. Are there any in-kernel examples? Any language concepts req=
uiring
> >> > it? If not, it's still a NAK.
> >>
> >> I don't know of an in-kernel example, but please look at the
> >> `bitmap_vec_new` test which has been here since the API was initially
> >> merged last year: the first thing it does is create a zero-sized bitma=
p.
> >
> > Well, yeah: I wanted the behavior that the implementation rounds up
> > documented so it can be recognized as intentional.
> > Later, the `new_inline` method was added, which is a clearer way to
> > get the largest non-allocating BitmapVec.
> >
> > I think the problem in this discussion is that we want to treat
> > capacity like length, which is maybe suggested by the BitmapVec name
> > and its len method.
> >
> > With the minimum capacity behavior documented, it is as if we have a
> > specification right now that no IdPool instances can ever have less
> > capacity than BitmapVec::MAX_INLINE_LEN bits. This patch here proposes
> > to change that.
> >
> > It is not clear though why client code would be happy about *less capac=
ity*?
> >
> > In other words, why should the client of the IdPool have the right to
> > control the *exact* initial capacity, even if it is below documented,
> > free-of-charge minimum capacity?
>
> The ID pool is used in Nova to track the number of hardware channels, of
> which we have an exact, fixed number. For this use-case rounding up is
> not "free-of-charge", it just allows to allocate IDs that are invalid as
> there is no hardware resource to back them up.

This makes sense, and I'm glad you can reuse the code.
The origin of the bitmap IdPool to isolate the Binder-specific
spin-lock-compatible resizing functionality.
In the Binder use cases, an "allocated ID" corresponds to a bit that
is set to 1.

> >
> > The IdPool, despite being backed by a BitmapVec, is not meant to be
> > used like a vector: it does not grow by itself but client code calls
> > grow and shrink explicitly, and client code has no control over how
> > much that growing and shrinking happens.
> >
> > Like, you cannot grow to 65 and expect to get a capacity 65. So why
> > insist on exact small sizes?
>
> Actually with the current code you can call `IdPool::with_capacity(65)`
> and you will get exactly 65 IDs. And if you call grow the new capacity
> will be `65 * 2`.

Touche, I was too anchored in my "IdPool is just for resizing" thinking.
I meant, when starting from a no-allocation size that one only gets
multiples of word length.

However, I do understand that you would like IdPool to track for sizes
below 64, so ChannelIdPool does not have to.

> The point being that in the current code the initial capacity is exact
> for every value *except* those below `MAX_INLINE_LEN`, which doesn't
> come across as consistent. All this patch does is remove that exception
> for which I don't see a justification.
> I think we are conflating capacity with length to some degree. Actually
> the code does exactly that:
>
>   impl IdPool {
>       pub fn capacity(&self) -> usize {
>           self.map.len()
>       }
>   }
>

Yes, the original IdPool is "conflated by design", since for Binder ID
allocation means something different.
- "length" for BitmapVec is length of the underlying bitmap in bits.
- "capacity" in (binder-specific...) IdPool means "we can allocate
this many IDs in total without resizing.

> >
> >> It is also easy to imagine a user starting with an empty pool and
> >> growing it on-demand. Having the ability to create a zero-sized pool i=
s
> >> convenient to avoid special-casing user code, and in this case I'd say
> >> expected, just like you can create a zero-sized vector. Again a size o=
f
> >> zero does not trigger anything that a larger capacity cannot trigger, =
so
> >> I don't see a reason to forbid it.
> >
> > With an initial capacity of minimum MAX_INLINE_LEN capacity, it is not
> > about forbidding, it is that the added capacity already comes for
> > free.
> > You could say "not enabling" instead of "forbidding", but pretending
> > that the capacity is somehow not there does not seem to buy us
> > anything.
>
> The capacity is not necessarily there when allocating IDs for finite
> resources. I suspect that's where the misunderstanding stems from, as
> Nova is using the ID pool for a new use-case. But I think we can agree
> that this use-case is not particularly specific and matches what one can
> expect from an ID allocator, so it makes sense to support it, especially
> as it doesn't affect other users (`with_capacity` has no caller in the
> tree at the moment).

It makes complete sense to support it.
IMO it is less of a misunderstanding, but a design decision to juggle
the requirements.
This IdPool thing was not meant as a general-purpose ID allocator.
But I do see the appeal to generality.

> >
> > Do the other patches in this series need this, or can we just drop this=
 patch?
> > If they do, maybe a demonstration of how significant the special-case
> > handling is that can be avoided with the exact small capacity could be
> > part of the commit message?
>
> The next patch in this series needs this to implement `ChannelIdPool`.
> The alternative would be to track the actual length of the pool and
> return an error if `IdPool` returns an ID after that value, which is
> what v5 [1] was doing (see `num_chids` in the v5 code).
>
> That's the special-case handling that this patch is designed to avoid,
> and I hope we can agree that it isn't a satisfying workaround,
> especially when the backing `BitmapVec` *does* support exact sizes and
> that artificial limitation is introduced by `IdPool` itself.
>
> [1] https://lore.kernel.org/all/20260812-chid-v5-5-6c767770b3f4@nvidia.co=
m/

Thanks for the link.
To me, having IdPool support exact size seems nice-to-have.

We are changing the design in light of different requirements, it is a
defensible but not critical generalization.
I was worried that we may need to have proper separate length and
capacity fields (which contradicts the binder use case), but that is
not the case.

I checked the grow_request and grow dance now, it seems that even with
exact small sizes we avoid allocating a bitmap.
So I am not opposed. Like Yury, I find the 0 case slightly odd, but
unlike Yury, I find that tolerable.

The phrasing as "dropping an artificial limitation" does not
adequately reflect that IdPool was done for a specific use case where
the design made sense and is not actually a limitation.

I wanted to highlight this perspective, because notwithstanding the
name, IdPool was not meant to join the set of kernel's dedicated
supported ID allocation mechanisms.

cheers,
Burak
