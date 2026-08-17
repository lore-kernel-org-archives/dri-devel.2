Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E683C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 06:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C7D210ED1A;
	Wed, 19 Aug 2026 06:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G5Zh75Ph";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCEB210E3D9
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 21:36:23 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cc891373e0so50994005ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 14:36:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787002583; cv=none;
 d=google.com; s=arc-20260327;
 b=MHk4a+ffmdDMD2BL4InkeJvjSic/2DD/AbG5dGYPK/4772v/9iuwz4UY63roCE3FYT
 CWicL+bdQJZs0AzhYeLiQHvoZN4yfudz2FVPrbMcTcEeLvPRlWoOpUoVVm2TDBk+oR4X
 66KoxTn6ktx4Xan2qSStw4an6aj4747cfwwXf7rCItbLoFsO2V7D8YsHGpjRpfPOL6mT
 IBbrzAjiteoUpYi/DPm5I9r+q9aafG7r0ZAVsdDT2jR9X+ZIhfaIwZX/ngK60I62qP9l
 VrzCdacc45bZSycIqa9eoFmqUlBI8kXakcsTfKFfG9+lEKv605fa13xXagxe5KayuzV9
 fAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7Y68zBPMs4znH9swRVTxBCKPvlMjSod2fiik0Befd3E=;
 fh=QJFVIo3CDpspuTXAmO1bF0Fm/euO3ZO6p4d4cnEYs98=;
 b=hmkdfKuUAmjvUVBf0EWB3h+7DAzWcO3ofa6GG9f5dmoTkalBq7YE32NbTZe6V2EFLZ
 TUAuHGW++KPvxz/VvYlkIwlA88uSnnM245mUHpM0jxisbQuyCcj1YQw1z/RzDuRenDHp
 jfmBe3kcFwTeu0dTtzhw6Vqw6dMOFN0PdO+S7d4xFB4jwd9GlbmQieDpP7AzqPBc+tYI
 6O+N9g7Aks1AMay2/rzjlu+YP/Iw8JFdaS4KzMyZsIlzcDONUDv6YcdmB9nzgumPXcTb
 i4bk9ycMXogP07YxkIWHgOoveANXzEwXQyFUL8AV4xBiPxJts+Hq1QPjikZBBFPzcCUr
 Rsrg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787002583; x=1787607383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7Y68zBPMs4znH9swRVTxBCKPvlMjSod2fiik0Befd3E=;
 b=G5Zh75Phi1NbAKxckcxTocUF/Q9l1nMvt/nGW8NztsMKyG7Lzbo/crztCVouSEAjkV
 X3kFajzOaQg7jgoRfa4dj1AxuH1Am3MShXUH+RCKqteW6i9vXqlbFpW4eWuvZQJlBcOY
 y4yH1ycToFgSOiTSFtNYrL88r5Gr6Av7auNWLHPWI7jluqMwPB3LMO+uBtUmpP29/Rd1
 oNOpmHAV9E5fpUV7h1IM+VmdoB9QGlQn73aIqMJEFUFknFJGCSwYvyTstzPwKuLxBdiw
 7G9cj0OrbJ/Jpyqi3kFrFFxbaJ8Zsuiv/cmG9Udd92bVjE4Y1Ag4Os48ZZBu4lQUNquB
 rjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787002583; x=1787607383;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7Y68zBPMs4znH9swRVTxBCKPvlMjSod2fiik0Befd3E=;
 b=OuWaI0XkL+EeYfQL6bLNtwzZjPiyyAsZ+mHHFOMLmeNdA9w8jGHl0kiOBSpjIotPP6
 WppDFUlvUpQ9AZ+OuC0DRaivbb4skcxADR4jqRfOAhNtXiZZ0vUQcvXGgW8mUhjHPlD/
 pIWB+tx1awLq5uoTdE3wNLNii80jAvpNSkkvNnngT7Go38HX/b/V/CW9CoM9EZ8448bF
 KTgdS76X3WDxNXPatyfQTau9y0bMOgZUsokK6bQFa+ET4GLtgRhWxFdNCn633uxK/ApC
 dpZkEUPyLuQUBB4It/Jwa6tniEMEJ95vwWiuhSSGtdyYKjnBWWLTy9FWX9OOUi00u6Fk
 qv7w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqq23I19UfJKW77esURyBgS4mZuHy4yw8QOdMRXepTV6TCTGvCS6mx2HZty+Yn/kaHjH2NYvEM1hi8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXmjK/JNsIoJKprCgUPyTpEqtagLHvWUfCG3ZVrbvHvk2qnFHT
 1itHgMjd1pxbSpZQTY/r6BlJKoTyDTv4K3JqVA6n++utspx6jX5ApwF25UMa4fn0mfAokjuUYJX
 VqTCMmp6m/y1OZ1jUNftQZm3qmCi4+UCgZ7RlzA0=
X-Gm-Gg: AR+sD10IQu6FkFxM4mig2+Tc4bRpNRcqrqf6D2sgtvnjAkRYESpXZlVHg4UzmFO9Eg0
 e/emHU1CvgCycwIcAk1HdD2W8JMTQ9wTN2lsc2hqN2nwepbYEcQpcnp8qgQ+XAmgxF0Hhof9fUL
 dSzHHyAIzVXBL0OGNNYiwlX+yZFHroPvc+UB2ncpnVczeXLHUp9RI32ayXGmoAQjQIziViW7mEw
 f2RuRCrSgcmfV23zMazhFis6wYvgBqORsPNcQrEwq+MzFUDqBKmivGZSC2Y1lfCvAJtHmUySiXH
 ycvURNexhsNypCGY/9zHC7ZePCDdI9dG5mzpGMKVtF4JuoDmN6vXPrQfETcpiHIqK+k/cbmYGA2
 CWRPM23KSwIbtBVsutii4S0tHUDyEiIHCt7j0kah7
X-Received: by 2002:a17:902:e54c:b0:2ca:329:3da1 with SMTP id
 d9443c01a7336-2d3b0f3e8b7mr293499905ad.16.1787002583324; Mon, 17 Aug 2026
 14:36:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260812-chid-v5-0-6c767770b3f4@nvidia.com>
 <20260812-chid-v5-5-6c767770b3f4@nvidia.com>
 <anzxKO0X1OrNRD32@yury> <DKNN2LHZXRIH.5LUX95CZ8EA7@nvidia.com>
 <an4NvQBt3389jP6E@yury> <DKO414SNC0B2.248FUBGJGSPLU@kernel.org>
 <an4xDp29VX8Am0uR@yury> <DKOAY7J1IFTP.DMKSXK625EW5@nvidia.com>
 <DKOECWHEEAK1.3N3JXH9MH7Q58@nvidia.com> <an7bG2bEd28AbNRr@yury>
 <an8r4VECQ8iFP8ze@yury> <DKR0ZNGYW9IT.37N7TEN97GG3N@nvidia.com>
 <DKR5W5DGAWAJ.38LHLLNPO9R4W@garyguo.net>
 <DKR6EB8OWPXG.2QYAY81UG1RF3@kernel.org>
 <DKR724N9V3Z8.1HJP6NJC5A4ZK@nvidia.com>
 <DKR7N2LLIQZH.25F7VF4CET6PO@kernel.org>
 <DKR8MCRB76L2.1TV4D7261PVTH@garyguo.net>
 <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
In-Reply-To: <DKRA0IU4WVW1.3AOKCY38VHTKZ@kernel.org>
From: Burak Emir <burak.emir@gmail.com>
Date: Mon, 17 Aug 2026 23:36:10 +0200
X-Gm-Features: AcwNN1XmXhLOponMxlBCxSPGSKMVYcO46R_BeY41tQkqF8gOc9dMzRGpz2Bx5zg
Message-ID: <CABwQupNA=NuctKz0FRaJsWowf+=24C_o7u8twFFeUZ+dq6u+Jw@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] gpu: nova-core: add ChannelIdPool
To: Danilo Krummrich <dakr@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Eliot Courtney <ecourtney@nvidia.com>, 
 Yury Norov <ynorov@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
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
X-Mailman-Approved-At: Wed, 19 Aug 2026 06:36:32 +0000
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

On Mon, Aug 17, 2026 at 4:08=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> On Mon Aug 17, 2026 at 3:02 PM CEST, Gary Guo wrote:
> > Now, with `NonZero` or `Bounded`, we are doing none of that. The only t=
hing here
> > is that there is a range restriction. Other than the value restriction
> > themselves, they carry no other semantic meanings. How you interpret th=
ese types
> > still fully depend on the API that accepts them. Therefore, it is very =
common
> > that you'd be using these with literals, and it becomes an ergnomic pai=
n.
>
> I agree that NonZero and Bounded are on the weaker end of the argument. B=
ut
> there's still the flexibility argument.
>
> The API itself, i.e. alloc_area(), does not need to bother with how the v=
alue is
> checked. I.e. is it a runtime check, compile or build time check, or is i=
t even
> unchecked (or panicking) because we can derive the invariant from another=
 type.
>

To add a minor point to this, if rustc could figure out that a
suitable non-zero number literal can be treated as NonZero<usize>,
we'd not need a macro and it would all be very ergonomic...

cheers,
- Burak
