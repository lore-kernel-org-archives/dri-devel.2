Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03AA6C79F8B
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 19:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CB610E1AE;
	Sat,  5 Sep 2026 19:18:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nIXCsIua";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F06410E1AE
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 19:18:51 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-399026951a2so208740a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 12:18:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788635931; cv=none;
 d=google.com; s=arc-20260327;
 b=MDLw2Dlu0DNraeMNzeqVXGDvUl65qS+hlkmMZ+74+Wf86aT5KqlIJ9eBndcx4Az5nj
 4LVtfS/o6gvsxg7OhMZVpPKC9k+Hpo3O4Xvk8Khwe0LyL23DTQDU6fgi6NRP+9xqM/79
 Msswhxa838Q4BF2HC96Z4zQ5v6XhuNl+mPrxEmTeMRSzHBOZSQKtXqq20LdZNa9XKB9/
 kGmK7SSVdFMft6nKbl1VnbcW1dzyHJTQmDAjC49/2nFebSBSiPA566PEojreZEA//sSY
 jcMfbUdS4KHdGLOR17pfITVWDUhxIuQsinNZVLs2T2TXI15KRdGL/YeMB6O9zYedeEit
 G+lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
 fh=Msz/jBxas3F/iBIX0Uy39T9SqHkJFbwSGXbOTrSAgrs=;
 b=VVH6KM0q+5TYd52gidx6GZvHPoJD25nal9tUn8nzDRsz2Cdl5Mm3M/LuOdEdREV5yr
 Yj1/WVpLkBvbstXXRuYcIzmTWTPYMg9mvMsqGVXQ7b6v+1o3Vje8THRt3pEaUWVyJOJ9
 NB9twIPL+5tNIoN/xvLVmZ1DgPtXx9HVDQRfgfuYrgr2xukq4lJYJHd6ibLeUIuVUjAw
 dmvdBN+m17oM2l9PaPbtU1emoAZI0DABJWP/+0FQ7sPFCzu8UlXMYvQMbsM8YBHlm4l+
 mY1efZ23jc6Un8vwlMz/amwT6v9lMJ4PUqwebFX8yqIKg/uvEL+PdOtMCGLL5Hf1ClET
 pfAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788635931; x=1789240731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
 b=nIXCsIuaMO2R9AifhH8X4HgSoXsHSfVrMlNiGwXkkkT6qbnVGDgw4rjvvMP7vm1Sjt
 r+96jDMQSU7H2BAE0rbSJ/RgYo6647D7RsnSjB34tD3aW6n1KzVXMJzgXmcccFCDKctk
 79Gn4enb07nJZ6D3xDhJTgxD7q9YCSEqvCy4rncUQZN5lyyW7Of/WKRi4nak+CNPRZvu
 vszWPEgxoMXCneUe002uDIp4E+d7I1r5CE1vavV01hxwHwCi5QI4WIeZDOiWgSGoEUeE
 pU+5fiOHwT2nl1jhimORBnj/o6gRMTKtpogQ3smkA3RKbIiPEPnt+myTHx7XEzzRMGNs
 PMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788635931; x=1789240731;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UrMnI4RvZpvC5+h4ZWEpWSIko85Oy8yeuJXFlCAJ2Is=;
 b=oZkgGH9LZ85G9e2DcZaHUXgnUfM5YP3yz1Mb3sn41HRJrOwDgFzRchgsv5Fi2avcJe
 ClOrT0LxFv/heyo575Lybhk38Y8al9c5pxzZH5htU/CM+5CNjKhs14Z9kYxaHoJJR5Xs
 LUa6oQfb+Yw7ABMxUY+YSKmUFrjjYzssdGnOKsUnxt2yqhmgiNjBesxN4koI4QMulPEH
 T/IJ3N7H/ynRcQOjWOe5SGRFaKDAXdJ1zJzpAokeQswjepkfKaUXkOG68gZ0iUZrHtBg
 IIY2UCdg5MZ+sTRWzutY8SawrDVV7pcfMSIMDfGrfE3IJkiD7op74uimS0JLeHLi68cH
 UpvA==
X-Forwarded-Encrypted: i=1;
 AKwUvByk1CY0/U9g5HhUi7VusN+x7rmr2LPdPh50wcNXfnJPQi8K9Ddr3x8gPnxR1TwxBWfKbOIQNCwBrJg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lawb5jgEK2H9u9zRAMWESnWLUiR/1O+Vc1SXIFIom+JneIh7Y+
 fbvNrT/eDHEVXtlfYpclEFLyzbbwtRpc0niNaTcu4Vx8iYXT7P8Xo58sfJnem+wENKcABXQHNQV
 U6WEmdjk118/IYMpyGARPKghHiky4oEA=
X-Gm-Gg: AYBFou1Zu4yC6laRzdEIHCWt/r6+f43A7Usev3oqOzRLdFnd6PZvvJXK8YSX+0Udf4H
 i5YwkPspZI6T5kZQoFEzh9HLM/j3zgkcPXvR3tIQ1roja2CHD8CWDutGrKR6s8/dEybrBHLO1xa
 ligNuh3sL82Z7wM59qOsZuf++TRtwC3hGv+QCIM68gH72vitVtw9rMif+gKCKC7pEYtkp5KAUB8
 l8Vx8sqmmP/fHmAO6UN7IfCVFVTK+LeDhN1mzrknqadUE169y4y/fLr7+MN8s9Y/TrcRvaUraPo
 OLwZUCnDC6ayABtWhVxAK5vU67P0mO9QH+HSz31gDede268Zj/4j4K6ifmpMj1MbDYiB9fjA5Zl
 HYOYpEAhMBa9OXGHq9Zd7UxFv4JjG5KqbXZdWM2TXVj44NbxNi/kVUuWXns1h
X-Received: by 2002:a17:90b:3843:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-39b3d3db82emr6481594a91.0.1788635930630; Sat, 05 Sep 2026
 12:18:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-2-5552b1d59525@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:18:37 +0200
X-Gm-Features: AcwNN1W_ZpD7BnW-6N9vI0Wb1kb0jyPzchOyBf701rQL7ntZoTH7GyzL5sIHsSA
Message-ID: <CANiq72k4NQ6yJByyb73Sy+iwqVc=i5CuZy2b5uRVksA+gkr9qA@mail.gmail.com>
Subject: Re: [PATCH v4 02/16] rust: mem: add `transmute` with deferred size
 check
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
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

On Tue, Sep 1, 2026 at 6:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +/// This can be used when types are known to have the same size, but onl=
y at runtime.
> +/// ```no_run

Newline between them.

> +///     // SAFETY: We've checked that `T` is u32!

`u32`

> +/// This is typically used in generic code where it's known that type wi=
ll have the same size, but
> +/// the compiler cannot prove it generically.
> +/// ```no_run

Same.

> +    // SAFETY: transmute is safe with `IntoBytes` and `FromBytes` bounds=
.

`transmute`

I think we could also link to the intrinsic and the `_neo` one,
perhaps with a permalink to avoid drift if they go away, but not a big
deal of course.

Cheers,
Miguel
