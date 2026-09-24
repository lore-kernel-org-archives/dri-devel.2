Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9879BC98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAA710F362;
	Thu, 24 Sep 2026 07:11:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="EaT0soVL";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4786B10F362
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:11:36 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd4ba9f68so19122685e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:11:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790233895; cv=none;
 d=google.com; s=arc-20260327;
 b=g1zEGtwkwsADO4c5ZlgEavqhkgwzigXEVEuOd5eK43jOm1n+I+QyPEWoNKuNNCFZxU
 bfWb/DEFp8ykxI4VJ+rdhv9XwWyurflqNqRKfbiu70f7PLQCen8awN8j7KqCa/aT8nd3
 cPOgjWSFdZQOxnitMGdTpAj3tEqk/2/RMt/LD/7ve1AWh3MF0+zBjY9rXy0xnLDU09uA
 Zf/lPj981WmIwivkpTow7cdGwNJ1/lRNyD6/VwNVcvSVJXWqH6Mru8/h7uHkeKjGRwaj
 hyROJGEL1d3XpHAfXrH9GqdnKQDFtuzkFm5A2cB9FnieerrvAH/c8Ru+R1reHI3hjrvD
 BQNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I8ZS9uQVTg/RTh2r6b83ebQzg64nZ6k+e24taUncwLw=;
 fh=Dr8DGyDGWjtaWj5vsnWMeksB7njfGX3rmeqSNRl+Npk=;
 b=M3mP+u1wKp76qy5TZG6oTyHD0dSps+ClTaw3XFTc8gbHHOkAFXniLd/cD8OOcsMhM0
 6Sm5DG9ysb4ALEgRGXJgQ5cXuBz5fEu4Ro+r2dLBAYxG34tDNmaQitdynnPG4ANXgj3m
 /k6GpbXGtu7eZaCbF4VZlDolfLyTni8u9zVPLqsDmWh1QHG2YoZ7X+0TWuIN3+YU0Moo
 WTM2i1OYfoDJeTTMeGGy7aByPMaXpTgnb0slyiGkzgICzi5PZ3xA3vp9nfw93TOTPAiK
 6NktjXqSkxRQ1DfMjlkgX5rjL2dJRl3FxM7kUkLvED7GvuC3DT1p7XouS4XVBD/odpSI
 qx0g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1790233895; x=1790838695;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=I8ZS9uQVTg/RTh2r6b83ebQzg64nZ6k+e24taUncwLw=;
 b=EaT0soVLnu4ngNHoQ6ybrGuQ1tvUDfVxsEI2xEQdG7MYeLUlCeWfHFTPrnzvWst+JG
 846xtm1olE+8uXALyCdcI4gxRgiiqbc2uyF0je/rHrwkRhj8UshNJewo/zEf4ilSY66m
 cWmRzVeMbFqpfnWEAkIpmjnxJbEvh08EZmDqkTnboqGoIQDFAOHv37HGBJeZuPMwTXlF
 6v/kyG4UTrMvU8c8OAQNjcP3MLNSIcLArTVRCQlKwoMPLTylOw7ztXs759mLKWsDAbvp
 19gWvuSftCYd6jHpAmpZkR/TK+UJOnk5AJ61hIxM/5DrUjl+ipfKxInWxsiFRevMxygx
 a8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790233895; x=1790838695;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=I8ZS9uQVTg/RTh2r6b83ebQzg64nZ6k+e24taUncwLw=;
 b=jnjWECma6fqjeBLVBejqvTla0OY7lJS8FxQldxC0qzRfukTUcgVQcUraU9ZMvt0KeP
 5UA/hWdiq/44vxTjHgZkqlbPCCkSOYHI+9Mqe+WDcWMQBFYAbGpqaYTceliJfXDHhJ7e
 qT3sC4g8R8ZYxq3ZRHDYliuZXAVp1kzsEKQzLGS1+zZtUKmyLoMizepxZ344WQJaju2P
 IsbXpyFlljJwYaSNJPkQbTV7gH3LZCXjBFwy5vkyGHys6jzOml51NHOS469QSGdSTNhZ
 6P/A/Gdi2qzChZewa9kdyzvAm/+g6TxR+Ac1rsi7rJciD2K4gaZLsBpoBsu9E2NL2WFq
 LZZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMmjkl2IrfCt+WEoZt0FH1MdyhccasekFTL6fBmF8J+XRhGe5DXFaeu2aQGkUDu1DY5ak+Ab2tRl4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n8TmNxbZ45FD+KZHbe6gx2j2PvBKpzyV8aZSDTD99IBHzfsweQ
 PVX+jKqrk6e049GXTxeqmlfe6NPoZJlNpFXBY5JuXlRyuqwkENOVPlpOr6dmrVoAPTIwoTnhdaG
 gQt1zgyHifAkPwffaPnEubKZrQ1VEuLPEyZQ2XeO3
X-Gm-Gg: AYBFou35s+rc/Or12bemdNFQfYTMGJAHINRwj0hoZX4txQV2wI6v1x+KEJdzZecjtIq
 ZeVuvOPu4RN71/ZNLp6RSVP0EAqEFELtabZD2Srt0x+g7QExhZftsMmIPAXXF4Q3Bd1UMOecmP4
 29oicx9Zxbnztk71alzkgrMrCFz5MlzdoPk8Q0SmjNiDwC3AUDm3QglXfIQ9nOtlGjNDhiwm0cp
 j95wW+qQPrZcCd2rCgyF21LTnptuH/Qw2TpLJ9B9OIK4sClbf1d802ibyfRnNQRk8u+126F5qew
 fBB482NLfj9fhzWLl1HmBhfmKyFz1BRLYjGYaogfVGvcIQmRjwN2jUS3E+lK9QUFgOhmVe9Wj6F
 s/0P0A0bEMkXnS/T2ZTkX8xvosYacndEE
X-Received: by 2002:a05:600c:8486:b0:49e:745d:c317 with SMTP id
 5b1f17b1804b1-49fe66b426bmr22734545e9.12.1790233894197; Thu, 24 Sep 2026
 00:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260922-b4-gpu_info_zero-v1-1-7259840069c6@collabora.com>
 <CAH5fLghN0w908Z-MYDfmaeC7gvAB78MMT7zg599=1kU0HexkOw@mail.gmail.com>
 <arRua6cN7FXIDOvF@um790>
In-Reply-To: <arRua6cN7FXIDOvF@um790>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 24 Sep 2026 09:11:20 +0200
X-Gm-Features: AclHuK_E9AAemunGDpBVxiUGy0rHsdGrBH4aZK_TH2BuNmOFFvcup1Ldi-77Xl8
Message-ID: <CAH5fLgihqM5WcUaQd=WTUs6JhxoGyn-m2N1kkrsNvBXShRZWHg@mail.gmail.com>
Subject: Re: [PATCH] drm/tyr: gpu_info: zero out new/unused fields
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Benno Lossin <lossin@kernel.org>, 
 Gary Guo <gary@garyguo.net>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 karunika.choo@arm.com, boris.brezillon@collabora.com, laura.nao@collabora.com, 
 steven.price@arm.com, liviu.dudau@arm.com
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

On Thu, Sep 24, 2026 at 2:27=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> On Wed, Sep 23, 2026 at 09:42:23AM +0200, Alice Ryhl wrote:
> > On Wed, Sep 23, 2026 at 1:16=E2=80=AFAM Deborah Brouwer
> > <deborah.brouwer@collabora.com> wrote:
> > >
> > > If a new field is added to the struct drm_panthor_gpu_info in the pan=
thor
> > > uapi, Tyr must initialize this field or it will cause a compile error=
.
> > >
> > > To pre-emptively avoid compile errors, use ..pin_init::zeroed() to ze=
ro
> > > out all new fields added to this struct. Tyr can subsequently change =
the
> > > initialization as necessary. Also use it instead of manually zeroing =
out
> > > existing fields at the end of the struct.
> > >
> > > Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
> >
> > Merged into drm-rust-next, thanks!
> >
> > With regards to sashiko bot, we should look into whether the
> > MaybeZeroable that bindgen adds to structs applies on this struct. If
> > so, we can remove our unsafe impl block. But it's not an issue in this
> > patch.
>
> I couldn't use MaybeZeroable directly but if I add IntoBytes and
> Immutable then we can stop implementing unsafe trait AsBytes. Could you
> please review:
>
> https://lore.kernel.org/rust-for-linux/20260923-b4-gpu_info_intobytes-v1-=
1-bb2173f91e11@collabora.com/

Oh, yeah, MaybeZeroable isn't the one we want. We'd want MaybeAsBytes,
but I'm not sure that exists yet. I think we asked for it, but not
sure the state.

Alice
