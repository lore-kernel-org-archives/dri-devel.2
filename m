Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8FE606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PY4pBa7B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE5C3112058;
	Thu, 29 Oct 2026 07:59:14 +0000 (UTC)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BDF910F5E6
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 14:35:36 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6afa651700eso5964825a12.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 07:35:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793111733; cv=none;
 d=google.com; s=arc-20260327;
 b=T6hlEFH9XBod1jP9C0QSUWG6uqFzxZh6dO6FQz/4dwhipSfkfLcJdU/2c7EuC2HoXA
 Q762x25J6zz68eq9tVIQExGGAZP2Gz3MsYdi2KLSj9XDjpE2p7fKtRItoBe57XavEylx
 OSybPoRKEYGmeDDTEDisCQgp2WxBrxzNtC1C+vFZuy5Sr6SGdcWcJSFxcrkyB9wApTRp
 PI6UjhWdOW7xP0z6FErLYGCa1vZf3WoykPgJe/0SNKpaetfdHyaYOr/y1NoKyMnvPDJv
 iV7OviZdAhkl0Gr6I7URfD62SIjcW6Ntnh6R4UnFdh3Qhg1xuLWzP80ufySm4klASEUj
 oiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=R4PvwjpIeFOLVCtuRNnnzwQtCCwBRvOOzElq7eLGth0=;
 fh=Rka+eBT7YbH1W9a/HgET10N8vLttfi0iX45InCsCQ8c=;
 b=Rz9IM/Nj79wwLOM0CnTQrrkaGrxDPBa8bTjVuW3sC1cH5uDsSg95z/DQj8iznSXVkN
 H/jcsVI0UFLD2zydK+gmAS49QNvUYDQZsaQ8XLFHc9tiRjaWOV+U6/qHm4sv3XSkyfuE
 IHfGnPaSGWKxObI/ddYnr+0MMuP6chNAXkIfClUgnqhcxVBGYbUuaSXpNA6roAyLE4ht
 jLVA4NbFR16H94N+F0TO+JdGZRbL9K40fHP3bKcmZa8kyESNJwbBsK35BUfck0WtJhSq
 tebm7gWpFsDg9WRKDak6MAdlbEfblAyNxV8MA/Rv7r6KDA+PbkMj238Mt49pjnVYeSuB
 59Bw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111733; x=1793716533; darn=lists.freedesktop.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=R4PvwjpIeFOLVCtuRNnnzwQtCCwBRvOOzElq7eLGth0=;
 b=PY4pBa7Br1ST217j9XwmnQ0X3ByFMQLAp9U9X6QViWBP+4uAXO7m2e8meLVxc5YpY4
 2vvkilz6VyIeXXstd18KnDCS3Jw0/EYeIEEI1+NbKXlt3goqCWVPIoUZtQd8tiGyTQZE
 f9lmkfvwCHNcYw7sq/Eb5QS7E1jvu2onFyfDFT6TMMoQlFgVaZ9IJOYdftNkUqJ6wswK
 pTzV8yobIlWc7NZHf0l+afuvqJ/IdaVtGmT8quB0UFe1vFyOwHazTE3Qi9/Z+r5xsv+m
 QJi1NBbvGFFRIjId3UONNpxWk54Zxas3+xgDHBI4q/bZVyRCU6RHJ+qeSweFUUlqz7yN
 DNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111733; x=1793716533;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=R4PvwjpIeFOLVCtuRNnnzwQtCCwBRvOOzElq7eLGth0=;
 b=GEJwxYW53atFdOc0EtEzvaTAqzIK1LZDdn2fs7xq6Pd4BlyfTXj2HYC3HFBYqcwMCy
 5HPj5ivLcgNmNDpw7C4oh8aE/qfSOdMvvy+t/TzwfQjvgG+Ulop/aku55RxFr6YnjBB/
 7VX+c4gSg6NigI0/D0i8XBNF/LNEltDsB2tDessCSfSHvuCZvlR+FDoACrDPFg9bdbMl
 Z0V0rjvY5pT9nl+ORNqnRAzWOECS9QH2kv78Isu9EtJdi29xgEb6p9kUL7BQI6S6lkN4
 qxD/tNC12tI+eHyw+KhKBSdI0RJpAVjJcnRGnxGSkCmNX8qEN+/37AFevPV3wme4Owz6
 gJCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBysUCwVjMj5TzjjJSSboxuPeqXbAPDkrC/Q/DmMaqvmDl6soTcG8cQjpone9/a7pbIqyNgGj9c7YMc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIGDbylSnGeKT1nKyW/6hW/EhVf1/tdf5hcBI0Pt3KUz7phf/UK
 79qrTr+EfFhbAfTMDw/6Mt2GZR+Q5GrRx4PzX+spT2dh3fktfahUFB82KesnzxYeSsLR+TDquc5
 dF2efTsx8ikmcWZfhdY6HlvYLfVHY174=
X-Gm-Gg: AYBFou0p9MzEvMyc9yt9A4EW8wqfDXmUZUaST9hXJuEkV+62RduCOUFo9f29SBMqPFV
 dPNHQ3bbE4vQhTyZYwoYnMhMtDMXfMT/QKsEvzz7z6k2MWMKy+nwjY6Fm9VGDYIaf+7mvYjLIS0
 IyEgrsBMURMR9g+/TuJ6ibw2R8WZdeeiYxl7xWofW5VkxcoLQSP5yPe81c3ILzCTVMwdSs1ur4R
 KiGrXyvRhV5mnogCo9wcCcM/PQN+BqeJ0J4SwF7TIQuFi/+c7ts8JYjhCK9wSJkVAlq8aSijUGl
 Dewrh3WOkTmx5kE+W5qn3QSeWBIwlv4ekhYWchCNAh0vmC6VOQWKAy7XIIsz+CwmfRGv0ZPHI4C
 L/GiAMAWRivkBzH25Kf+D/N8m/CDADA1XWtpqAw==
X-Received: by 2002:aa7:d48c:0:b0:6b1:c7d9:b61e with SMTP id
 4fb4d7f45d1cf-6b442fe0840mr7297104a12.22.1793111733086; Tue, 27 Oct 2026
 07:35:33 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
From: Felipe Agger <felipeaggger@gmail.com>
Date: Tue, 27 Oct 2026 11:35:21 -0300
X-Gm-Features: AclHuK-GHLEyqr6KB_kfCjwvu3tRikc3hEyilqurJguoavY6ZDCGH81xmKudJ-c
Message-ID: <CAETh984mtGx=sJciwk0Gdfa54FXpBgE1S-0XZ-eg=BHLDveFtg@mail.gmail.com>
Subject: Re: [PATCH v2] rust: impl_flags: add conversions for raw flag
 representations
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Felipe Agger <felipeaggger@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Felipe Agger <felipe_life@live.com>, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:56 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-1.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Andreas,

Thanks for pointing this out. I hadn't seen your patch when I was
working on this.

I will use your patch as a base and send a new version (v3) of my
patch set building on top of it,
adjusting the missing pieces.

Filipe
