Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55CE6C43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:56:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A820310E4C0;
	Tue,  7 Jul 2026 13:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UwGrPMMO";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FA3F10E4C0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:56:14 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so2622183f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 06:56:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783432573; cv=none;
 d=google.com; s=arc-20260327;
 b=P29GquiVCSsgE9dSRK/0xC4O5IuHWvp3I1kGrSi8TZ3L7ifiLNDKj9Q9wY2S2Ppub7
 o3+8QOhYPQVF6T/1C8im479Wed2qs9QEdQkEp7wbkIYZgcXY82gYl9+dsB/SXanHsuMQ
 M7O2bDysOUdq8zw9SO23VPF+sOdo3anGpM2ZObQr8fI6CFCFxKOVh5ow7sRncG4Z4n/A
 w96yNi9Xo+2gOjcd0vQGB8vLxzTINav5NOuiolwgOACZh8QWjRPwCFu5OI0143oesjCU
 cWEkcGXHYKkp4fCL6Di9J/xpJySoj+PBQ9k0XSOtXRgQ17Yp+514I8IEBStUGpd1hiBN
 ohNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nNxmK9/0e1DDLDiWJdtnZznbYGrC+zqRTQAuKd0PNlk=;
 fh=YehOWRU4M5zyE+3qSrihE1lapnKzUBXKDq0PSpeznHg=;
 b=W4jc9vTsYTDAyfRQa4TAzskoRttyqCc2g8QkRAiamwApZOfiAJHpW/4kBmrWGsgUez
 GGmKIQNQeTNQJTyWQD0h+5lPX8rdlgVBj5So9plZ2X4dQylAMaQQFD5Wf2EOy3cLGKRp
 kDn5GgeXLc8qfOVt0eLxyHEADIemMkJGXmV5XY83/27fLGGCu/eCh1Vhw6oRwHEJBNBU
 ObtoyGzr8Oe1+Z3CIwYYygwqR3/ouWzz5z8hghJNFXUsmnTQNHnVg//9P96dXAqcSm1z
 VoQiLliC8XiMDhuAcLJTJ2/HUBRMsVct9StgOMbIDJKADePIAv8v/pwAu8zEDSon2GTs
 L4lw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783432573; x=1784037373;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nNxmK9/0e1DDLDiWJdtnZznbYGrC+zqRTQAuKd0PNlk=;
 b=UwGrPMMOFcFyJLVk9blkQE46JjG07xEOeJU846wBklgAc6ZV6x7sQWcJFJNIufRr39
 ZwRBvaHzZWqcq4g/0svWR3MOLoDg9q07xcfV0otc3qViaLtfWv364/ux+PHnU/Nksfr+
 ao8RIhBgzBCcZ0WCY/T0fXbUiOKxbXQJ2LiFmKUVVvwTd5DvZqcfWxk3ExAbpd7PqXcR
 6gC342Ay0x/5rUnLqWMspQpwWnKbLOO92yIEk3dwMGA+F0iZLbokSfcYFUry40wcm4L6
 aQOw8WWNozH4DONOc3PaKjPzPcUdRmw1IDbcaH3F8gjDh/66LPa1lH0lEmV1s5WIlP2C
 jOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783432573; x=1784037373;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nNxmK9/0e1DDLDiWJdtnZznbYGrC+zqRTQAuKd0PNlk=;
 b=Iav2bqwOtXh6RkBU+ock9fAepjTkdbUPpzrxRc07A+QJeZx4Efrj2oR0toErey4e8p
 iMgYpeDmfetuBBgwgC8UwR4Peh2YUqieN4MH/mJfAvMCwBWnD+YtxWtEsy8yCN8lVrzK
 tOrz2NaC1H2HiPfrkMQZ84i4jMu+jpvDiUjLfI3L6XIInMbDM6tKPvLYIc20RuDD35GJ
 9LrHRPk6SjadOXfrbQx7kSRYxdSPKiGT6bNc/meHW7Dr40zHkjdHMGeUJxL8GlWsAjDH
 khcUWke0KmLnE70a0nidy7DP6z1+I2FVJryW39gRkwRXnUMKaap3ZaUD3Ej6QWJfGmWZ
 VLPQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rri7Ibi6bLz/KQH2lqBYYaDkes8PVrZ12TQozczX+j5XzxUyFgyTX5d3nn0VtpNWrdAERdK41iyNFE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr58KbjyFTbkAXIaGFUE2T8xaGPk+niJHL2/d5a/SNae7sA4ni
 2EBfsALT8Edp6bOU8pYxaIFtKEc66aat5eR93BnMigCPtrW7oKNUFNnGZ7a/EUzSxDvStbjEobr
 EwU5ezd1/8vV0TjkUexZCWJV8B5RVMERTxlYrrtuF
X-Gm-Gg: AfdE7cmxrW19mNYYJe+G3171QBdYlTrTU622XHA4JIuaR5P5oXxE+Br9esE3pMQiECA
 YrNE5Fa3GGrDrOblmFnsIGRP0ZvK+D7gyxYzUJdgsg0oJkFwsR+Xb/N8R35JuDUYECw8RMAX1ca
 RkYFT7Wos204pmJrchhY6D3lHJHXHyA6sMOMKOzCQZzox4s8vXHkCj2OyuqQixWQOP9cA3/xvlu
 RAJNwwIdGN8Ck0AOmYs4ylmSjiIh+CYIv9d1h4wSsqqqQaaui39wk1MvostwgfwFkurZozl1NU8
 Azb38kdvuM7GiZngu2mch8iMnSBpC5rQq9oNRQ==
X-Received: by 2002:adf:f290:0:b0:477:2e75:522c with SMTP id
 ffacd0b85a97d-47de66cdccdmr4577090f8f.28.1783432572316; Tue, 07 Jul 2026
 06:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-1-84fe8259e46e@nvidia.com>
In-Reply-To: <20260703-chid-v1-1-84fe8259e46e@nvidia.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:55:59 +0200
X-Gm-Features: AVVi8CdHfosGlUDJEhRFxdK1GHnnIUmv0dXkgaoEgKtaKne6Vk4-CO1ueEwiEf4
Message-ID: <CAH5fLgh1Gh0ypT3R9E1NrDHXha5G-BJJdTzGxz240QJ0inZ5wg@mail.gmail.com>
Subject: Re: [PATCH 1/4] rust: bitmap: use function-level cfg on kunit test
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
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Fri, Jul 3, 2026 at 12:19=E2=80=AFPM Eliot Courtney <ecourtney@nvidia.co=
m> wrote:
>
> Since commit c652dc44192d ("rust: kunit: allow `cfg` on `test`s"),
> we no longer need this workaround.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
