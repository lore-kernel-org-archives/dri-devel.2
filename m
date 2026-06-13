Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1917CD98C5
	for <dri-devel@archiver.kernel.org>; Sat, 13 Jun 2026 10:05:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDBB810ED75;
	Sat, 13 Jun 2026 10:05:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G2EU0shD";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C96D510ED75
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 10:05:44 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-304dc707bfbso108636eec.2
 for <dri-devel@lists.freedesktop.org>; Sat, 13 Jun 2026 03:05:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781345144; cv=none;
 d=google.com; s=arc-20240605;
 b=NmCa+rS2RcoAIKaqzxF7B00+TaZiRyzGDkpHNzerYlmEZmYYFhvOMNg5scStmwnLBA
 GbHN6M5bOkPTL7NXgVPkmtYUa11NqrSJVEhTD1NELHwm1xDPHmeR/emeKL4yxiv2HJ9Q
 yraRBkPVFQQU4H36lw8WboWI17eGuk3Ax/w08u5DdCmeUXmCwItuANJ8voaAJc0hdjfc
 HRg1ZFUgvZlOAMbaN2v2WjazNPEIcWoCDTVgQyj5e5DHjALllPtxsChsZaGm7Hn6LsUT
 WMchVoTpiutS40pztxJy5Tvr9/Z0hwWOHo9WEH8qkG2Lv9NUbkax9f7Wu2DupBiWsla0
 nOpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
 fh=f/LkzcYB2z9+gXO8dUVylimpgZ8Dq1Ilxy7qJMKCIQg=;
 b=ZRwJL9yNlPnu9ckppsu6O/8k9S+yaf9igesH4SwM9yAT1UzAcLSAI2c6zYphivRXm2
 +qqZbxVZwtP+w287VhUL5sDdvohJYqQf3COmP1iFRpShQ0FTceOuzzBGrI5UDXFqCPzO
 YI+YBf1WLIcD4bvy1+cBHAaIg17Mp8moA4J6yLrS+OJuM0UY2gLMBKdDXri1bBmBVggu
 Cl1b5/XDg0hqLT7XcdiK2s1P/RXNdUwXt3hh9S4IbrueA8SJQ/ZmtO3hx2716OpkrkyJ
 TEKf1/A/nCBSvXkcGbtmilSRVa/hdniJpU3wL1VpSaqkPOtGC8O6CchR6hK3Q1CwFXSS
 u4gw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781345144; x=1781949944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
 b=G2EU0shDXGd1BTDKaLU/UDH7C21yCvWpHpB2OcVTSVEaw7D8RJL5Rk5pCDBprNu2yi
 loB0/Tj5ISwobfd3mUL1KUOo+FCUUSbcBT+ngJZHpBrywpLP2hSnMrowoDsnGzwaWiN9
 +Fwap3PfaqPZbhJpbYSve8PnEaYJn5E+ezJ7GWjkri5WroV/CvELEIGvL7zEkb1qtqGR
 03DL18PNpTu36IFmD8MuXI18baaB6n/BmS+3QKenRe4cFI0qwb1pRCUGb9PGqjxsS+SN
 yQi0lpWDGuzFwxWAHInpv/Qhgu5T9jtWSdtYaVyxLK8N161imWRLfSY2/a2zZdXgvNSE
 fyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781345144; x=1781949944;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CBjNOSpJlw+yD+1WI2YpvIUWPKEOoXhGnrq65FYW9Fw=;
 b=WR6ZnIJAGbx/XkFEoh4U2qLW6/hOCZ0RnuUKHJa3SYCsQqnqnz3x1+CYNpvJ+DC5tI
 UjiLT0DL2r4gPL/VrpPzbXq9eszPY26f8VOifyL+iCqOAVz4He+dOtzJHg6Q7Y34g8ln
 WxXmpgY0FcgtKuWSe8K1cBXJTmJUZQTwba4OjUt6SHJ3cs+2UrTj+3+7sxw0TTaqsSv0
 +soBnYQiamwoTzLCT/vWQwM2viMWpHWx1qwKCXfYFebpzdkLksVFoTLqhUoXLxkkSvkw
 L1bYca7w9wiBK06/2LqtUQ2gLwqNFBjHnxcnjWV0q4A7P38kS1WHmu+VURUV1IQsjrea
 yYSQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+j6ByNJg8JBg+Dw4HgpEVoXVzzo1oAppn5ULNMFj5WlrX1mC2v87TjCMvat9usCJH+iUhVMzNRmfQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzf60bYxE5LHvglBj9KbBRLuOUCR8CQxpPgRcBFcQ3FqAYjak+P
 gRIZD7NFE/UVd3s4/0mTHKKJH317Ir06KJNP8fileNWilp/HwCLcp5TEUwNLUtXxWbMCiGU1E8y
 TyRGNiORl4su/dt5XMdgrhogSFxRYzVKcB33C
X-Gm-Gg: Acq92OGqTWLscRMr8sNQ2QsOX/QvAEi/A7icigsYk6m2wYnaExywG/mhfseik4GyH1F
 YkAPBLTJxKU99zcPBnXe3rzdZxoeI6+BgIaIcnA1gwpq7exN+9Z101O055ZVDc4V2s/iFHFIefC
 B4tX0PcTya3j+tQL1fM6F4IJj8Te41sbmB5l4pbxoca0wwl9aWFxM4wpPBmhyZAHIh0TKRWaJGO
 SHdGrpd/IpjwEf89M86GMVTOv5NkojwFvXloX3ThvB/ntyCDnGgctC0cMO0+6WK3XkFvpeveqEd
 InIN/v5GCXONA0uw5TR3skTdMPDOe8c1d2X2AfiStwXPaD/A3tvtiHC0h6GFu3xcIL3yfQSbVOI
 xU4zfcJ1tMiT1YDJUNLBWGlk=
X-Received: by 2002:a05:7300:641a:b0:304:e327:aef8 with SMTP id
 5a478bee46e88-3081ff62e8fmr1477519eec.2.1781345143929; Sat, 13 Jun 2026
 03:05:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260611-io_projection-v4-0-1f7224b02dcb@garyguo.net>
 <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
In-Reply-To: <20260611-io_projection-v4-1-1f7224b02dcb@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 13 Jun 2026 12:05:30 +0200
X-Gm-Features: AVVi8Ce5ZWN0tgHXx4wgAxeDGhIDTq9KOdKjeJ9s14OzuckvDKwA8hSyjUXURv0
Message-ID: <CANiq72mLqrcdZEAGM1wJ6OE7yUxzDT4dRsYjO91kPzoB5h6mfw@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] rust: io: add dynamically-sized `Region` type
To: Gary Guo <gary@garyguo.net>
Cc: Alice Ryhl <aliceryhl@google.com>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Abdiel Janulgue <abdiel.janulgue@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Thu, Jun 11, 2026 at 6:28=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +    /// Create a raw mutable pointer from given base address and size.
> +    ///
> +    /// The alignment of `base` is checked, and `size` is checked agains=
t the minimum size specified
> +    /// via const generics.
> +    #[inline]
> +    pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size: usize) -> Res=
ult<*mut Self> {
> +        if size < SIZE || base.align_offset(4) !=3D 0 || !size.is_multip=
le_of(4) {
> +            return Err(EINVAL);
> +        }
> +
> +        Ok(Self::ptr_from_raw_parts_mut(base, size))
> +    }

Hmm... I wonder if, at least for the `try_` one, we should have `//
INVARIANT:` on top of the `Ok`, since we at least checked that part.

> +// Stable since Rust 1.87.0.
> +#![feature(unsigned_is_multiple_of)]

It indeed appears available without changes since Rust 1.82.0 <=3D MSRV.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I think Danilo asked for the Acked-by back in the first version but
you dropped it since the patch changed, so here it is again :)

Thanks!

Cheers,
Miguel
