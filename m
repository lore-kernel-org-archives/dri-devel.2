Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EC11CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 15:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D0FC10E554;
	Fri,  1 May 2026 15:31:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c4cL+ty6";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E70C10E1DF
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 15:31:43 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-2ef397ad64dso23326eec.3
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 08:31:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777649503; cv=none;
 d=google.com; s=arc-20240605;
 b=P0cvL37kR3yTS+Ltmu67KkasCI8JdpNC1YdZuYlPHCNSfpeIUguLWrVK4B5XAjfHAh
 yCQHQ6E0YdTc9/5d47ysekx8tA94FnICmlh4sSCaPSIowwKAhU2ofW81OzmhAt6/WIEu
 77DUDzyFpU8u2woYNVQAfa/eEZ4MSADSft2zOo5h6AiYTro00Ervd84YoaejkSdo5WS5
 wedLA/VfArLevgEEKtSMuJMbuhWgNTq7UeUSCV8qs5yzETZKwnsnmLCGhw85Hvq1A+8C
 O4JERNmM8ANwzL298fZeCl88UkfEzommyDvIJbZ+6C2isHoAUPROBCz/LWEMP+v82KcO
 kBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LQm9FlebjcspKv6fTqA1mawXQMaJDUpiIXw8pb4GJnQ=;
 fh=FREh/siFuMcxX9XOYSlB8cfVKi/jB1BIv6W9YRHOO0g=;
 b=BgvpIWUExC+KCTAMkBPmfu0WVco4HR6z3j8nb5ohao1zRc58ot7DCjuX1sLv1BTUkv
 /ep56OcMx0fsjUukmkLCv8PSAVtSozMH3n27pE8svHZsOEs/9MrhGlmfcZ8atAOh17Tv
 IhSNWAv7u0mkdzCP88xhafm8GrxBUfW+2rXJYg2rffryGRcEInPNX8vCXa2lnG1LxMmi
 TGOc4nICFP67rp31GdikV5CcZCWH+Cs2ffk/R5lLZUzxvbOrTgc1lnHZ1u1LuwjwEmHs
 5jrzlrqAIgvWLK0ixI57WvdzwNhFiANI9Xc2d8goFo9ZEy3k2+oJh3ZsHGvEo2G/+Nby
 3r3g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777649503; x=1778254303; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LQm9FlebjcspKv6fTqA1mawXQMaJDUpiIXw8pb4GJnQ=;
 b=c4cL+ty60oxuzKwtM3NkLWohk228h9aS0a9ub8UurwTrPsDCNexDTVbB74dWUTMGlT
 hYhahWn6WogMRIqhVqT4R7M1AzI5vrz489utLFlexyPRO+x8d3up5VDhTyaJwK+VgeCd
 AslxZlXwJ3j3v7j/5HPGOWWuf0ty0x1ZGegB6cFa9X+d2pF0DyEHXbU+xKIbSmuG1MYK
 pKWn0V5VTcMVKnFioqg8aBqgIP4+KucUFBgCwVjI88KQp5+4G6aFeCgtKYCW9lFMLm7V
 iQmowRxKvq+00EApQg15gswEra8cmYCn9m0SlJw8socuJQNpJ0wVBlPrTC2eErlMXiqg
 iEFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777649503; x=1778254303;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LQm9FlebjcspKv6fTqA1mawXQMaJDUpiIXw8pb4GJnQ=;
 b=bW7FN0ICAW0sSZd8ffizitn+oYgsrXxRBRyu9WUtUmlQyDF9XO1Jxf5cbzkMDYifJr
 VgflmjhqsVBP9Y+iDojexSnEy+usEUTD3SLNYfPGmpz+iL1Rxo0xzuTySS16tCgLnDN4
 193VC+KslPrBHGB2Qf1ATeCxFaLoMajAZkDDEL7MtjDb+5fB0QnM5iUgxZLb9GGrZlMb
 oJ11n3/b3nyd/9HO3EpqwdxK7LaZieux95pOLSCRi/DjDrqZepDg5aijtSQR3IOgrIvn
 HMF4iRsuwVddOsWySwEk4IcbvwnLUhe60JhQtvsubOtaPwokaTue1Dv2Ylvw3FeGU8q3
 9Gzw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+X7bGPGGphn0wy7Ik11SlUMC4H5ubdanabboH8o9M94XUX+ioGVWmowFFnpb3NQGCXU92vH8NXF/Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxjVyttIVID4mhbqQqyIoOOu5/sVurZonVBZyYg0nMO5HcgaTJh
 1vu1XLT2gxuO8oAwxexvSt/5EvMEwRSEBXZHvxAtwMDaozFbPlqKxehEN0vgsE94+QJAdKwyHcm
 TXrSyaiv+Cp1KxFHdYbcIJCbCb2I/Mmc=
X-Gm-Gg: AeBDievaM1PAchK4DPPqbbJc4AMb08tyuUHtCD+vxtChVs7wH1tCX+UPB2IPK66UvG6
 87k65gXkcq+tqEo58GJwoBP15r+PmAsbeBzFlMoBo6CUic//XHvgui+rD4GDf3TeNFap5sDq1JJ
 ojAf8orQ6sb5uWYyPDneW6frB2/N5/++BSE9+TkxWjj4JEBLg69cELgQtB8VKaNIOvkjL2uBXUE
 5dV41w2C9XsdPaodiY8NeIVeCY7FzMEvRPa0G0vxaeF2L+fsSGkHF4bKTQdbOzji3S5GhYiGto0
 pHkdTAj6YRtirFH/UsL4ON8WJB07h31vOPdt2MGTRssofeaM4x7iha10Zr9f+HcxzB2V70axalW
 I6sS6FhFvWSbkMZrfysVZOcBTYPH+anPm2Q==
X-Received: by 2002:a05:7301:4190:b0:2d9:6373:ace6 with SMTP id
 5a478bee46e88-2ed3ea69fb9mr1648901eec.5.1777649502468; Fri, 01 May 2026
 08:31:42 -0700 (PDT)
MIME-Version: 1.0
References: <20260430-nova-exports-v1-0-7ca31664e983@nvidia.com>
 <20260430-nova-exports-v1-2-7ca31664e983@nvidia.com>
 <DI7CZA3ISGOE.1CP5YEM3NNSH6@garyguo.net>
In-Reply-To: <DI7CZA3ISGOE.1CP5YEM3NNSH6@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 1 May 2026 17:31:29 +0200
X-Gm-Features: AVHnY4KtSS48VYj6LcLMSfxEHj79WIZaC9QZG7nspbiebeuoKBEVWk4DqsY8Ue8
Message-ID: <CANiq72ncENCdGCjiC04Yup4i4jbY7S=k62fiT1RtQAYT=5wfzQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] scripts: modpost: increase buf_printf's buffer size
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
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

On Fri, May 1, 2026 at 3:02=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> The only case that I've been hit with very long symbol names so far is do=
c tests.

Yeah, nowadays where I have seen them are doctests too, in particular
for UML debug builds.

Cheers,
Miguel
