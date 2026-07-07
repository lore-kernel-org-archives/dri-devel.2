Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0092AC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 657AB10E4ED;
	Tue,  7 Jul 2026 13:32:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="S+/MuUX0";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBA0810E4ED
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:32:17 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493b7612475so39688275e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 06:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783431136; cv=none;
 d=google.com; s=arc-20260327;
 b=MrD3XI/B/QRMm9ti9KTC+MfFbJmtK2QjDunbuSbOhVfeOOFyuDk4+FdLou2RiX36P7
 APPusC/et0CU4AVXM+xdcumG6t6IGZG/tlsNkZb370xlKN85sGEAipKb7K68uE+u/CsT
 dMePsLcSpniESx4ZIFRKo1z4VGX2q83za050/i2OFDp6DU/mkoxTEIh6ei5xxOnVyNuB
 JY1UBZUqw9J5e1g2Izc8jE0gqoQbJIfBuELNpHx3zjtaMAnTEY6LP/NplBCDqbw8jr3j
 oU6oSCVsYpHoZ9lTLiAucT8HHGr0ACjl49A5gVpbMu5DSXkFw/qniEVI1MQdaK5TZQIE
 H1jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YbvH0rz9v2LuEGavTdE4vxLt1YV7PzWsO2f3mHG+f40=;
 fh=4zDxZ+o38fE/0J+VzLM0J7oi/48lFHZsb8MR/q5at7g=;
 b=KCMpWCFNSFuCL7PRA/Li30pnj7lPKyCyI2M6KSUX6z1zUFfaI7X8/TjNe5E7H3LLCv
 dLRkFFGeFcTiiv09NnrIlqERblrcEZfFFVKwfSReYs/Tp/A4p5MVtE5E7eCB0vsoUQSf
 qWtgqDIHzwHq26nEcxiargAfGYHSKi/RktZ4Ke8C+6BQKjjxX7S6VFWOI9H94zd89YFN
 5TfXbMS41uJBg3+uoD6nOF6QM/W2KZhTKkOBy1GmyEPXvKKrTWhmMLA1NVBmCqpHnkFj
 cgKsDT9yU2wcs8dcmst62ibyBOFxloVP8JJklyg6W4KkuoTwd+S6Be2QOqeREVNRaXbT
 GwFg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783431136; x=1784035936;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YbvH0rz9v2LuEGavTdE4vxLt1YV7PzWsO2f3mHG+f40=;
 b=S+/MuUX0Z16Z+5oXBc6pJAydTbMUENYhW2GRkw+kHn3lfLfHDoqm/937Nwuv492OWi
 inB0ji4xKbKhWID2uixZzJ5VRmZzD7Yu1Xtd6GtYqYB6SOYk/4v/Liu4EsrpCfUQnZD8
 0fnNuEUNIIOBixgjTmBIYwDyy3QnynuFREqy87ACJ5ITW2lDxKy145+Tti32miGhzKWI
 RYSVshtDpbnayex6HoqAc/T2rbq19arx1MSpuVxuLzxkkrwb7Tuvv+Di6ok2XcUGCb+X
 tma/+qdPV0+TQJSaKMnOQZ+7vgqest4JwVWCn7De+dps1io3L8aIwsOortnbVgecTC5P
 sSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783431136; x=1784035936;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YbvH0rz9v2LuEGavTdE4vxLt1YV7PzWsO2f3mHG+f40=;
 b=COTDtw0N4mTqgZO0Gep8Cukl4dku2cq4CDPh95xbNQxUvw4TDXq2S/NyBzY8LSuKNJ
 yHsIUBGq5HYZn4yhJunA8DKOI7D4aE4i0LDI3abScrG9Pu2TNzhSDfw2tYRZSEcR/VA+
 7vxIW2kQ7lQYNuvToe6YTubLFMw1DJitmvpQjfa4NloqqG7yAlqGlGe5qhLa0+yP/zBF
 loJ++2oFv9/UJDsR3WTTiJ6Xliwb9MsTTWkhjzT2XxJ1yTNdmtd/pdsb7WXmFe1g7Vel
 Q7785geRHTpMSgg3CvofzxVLTKxSt425u0e8arVlYJwTMmO/5adLHX4M3xv6guC/Ssoi
 YOkQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro1qEoceVSJiSHe0sM5OUE8rEmMk7skdLuxH98L+/KHefy9ICjPTUlZoUwOPGFuwTjM2NKQ4A//+dg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwC4/T06NxgxCVNNVcyoH2FW3hgXuTDzFXlKca3vbnWuPT6mFc9
 37W3zebMsyyJind2FapPAXRM5WQzus02mEMbjxGKvkdzxuNgB4DBtFycx+WP6smOP+dxtq6UQ9p
 66Eca1MPA0ORr6EsObUf9sS/FfTQXNv5i0GZycMFR
X-Gm-Gg: AfdE7ckbP2mR30H90qM7vFfnhjkUWBF++G27FG3uBLeVZho8EjoD2Hd+VUusrjWbcP6
 veIm7VfIJkJwKGR1Iq6U3z52YXXW1wJqZjDOKLJKTil6CTdUMoHNFg1JFi2DLAhdy6vTBSLj+lC
 2c2FEBgIJlDfTULJHdCEfUU92HFUKtPL8GNoqpydv/7EZ/M8L8lB9RtSfdgHwbpXEr0i+ZCh8Sv
 fo6z+FtJyQozXXO/+faR5+uk/udQDkTj0zTzVOB3m9ktUp06lG3LWUMgIC769RCxsjBIh6bHfcs
 3SVZvxXP1LPHzmA+AFQ4uvUMjVT3KDi/WFlJ5Q==
X-Received: by 2002:a05:600c:3115:b0:492:3e66:6c84 with SMTP id
 5b1f17b1804b1-493df095172mr60789075e9.30.1783431135794; Tue, 07 Jul 2026
 06:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <akuV_GRAM4QPqf-o@google.com>
 <DJSDG3RE8MDB.135TG7FX4Z1G1@nvidia.com>
In-Reply-To: <DJSDG3RE8MDB.135TG7FX4Z1G1@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:32:03 +0200
X-Gm-Features: AVVi8CeuDxVjaDzyUQSDcYcmcH9Nnk9YtXJ9KbqPE51Mhk7CXpF1V1tW2Dtgja0
Message-ID: <CAH5fLgidT1MFYp8Qc70yeYmKBSi-LFKQWw+M_kjR6b2N1ypMEA@mail.gmail.com>
Subject: Re: [PATCH 0/4] rust: Add support for reserving of ranges of IDs
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Burak Emir <bqe@google.com>, Yury Norov <yury.norov@gmail.com>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
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

On Tue, Jul 7, 2026 at 3:26=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.com=
> wrote:
>
> On Mon Jul 6, 2026 at 8:48 PM JST, Alice Ryhl wrote:
> > On Fri, Jul 03, 2026 at 07:16:03PM +0900, Eliot Courtney wrote:
> >> Add support for reserving of ranges of IDs, with a usage in nova-core
> >> for channel IDs. This entails adding the helpers+users of the C bitmap
> >> API for ranges of bits, then users of that in `IdPool`, and finally a
> >> user of `IdPool` in nova-core, `ChannelIdPool`.
> >
> > If you need ranges of IDs, perhaps you want the maple tree instead?
> >
> > Alice
>
> I think maple tree would work, but it looked like not as good a fit to
> me because:
> - the number of channel IDs is small (limited to 2048)
> - allocation of a contiguous sequence of channel IDs is sometimes
>   aligned to its size (which should be a power of two, AFAICT) - I
>   realise patch 4 doesn't reflect this (yet). The bitmap APIs natively
>   support this.
> - maple tree's alloc_range stores a value: T for the range which isn't
>   necessary for ID alloc

The limited number of channel IDs (2048) is a good reason to use a
bitmap. Please include this context in the commit message for the next
version.

Alice
