Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C964CA5FE2
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 16:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDA310E639;
	Fri,  2 Oct 2026 16:59:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppWn5pNO";
	dkim-atps=neutral
Received: from mail-dy2-f12.google.com (mail-dy2-f12.google.com
 [74.125.229.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4948110E639
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 16:59:47 +0000 (UTC)
Received: by mail-dy2-f12.google.com with SMTP id
 5a478bee46e88-33bc6ff6cadso1188943eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 09:59:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790960386; cv=none;
 d=google.com; s=arc-20260327;
 b=FFwG1FVMHoXqSgIizQCkLyvMd6ybVLLHv+M8lmxvFDWDHfwt8FF0TJAMb+t+o/l8do
 Bw2CLmh+CJ+fGkb0SVgePBuYEl/U1OeP50DMgs+mqMBZCJXmz0vYQ4SFL1ZHVq+GNyrG
 cHQMfgWqBkHLqZgW0skSxF5SftmXA3Xz/5x36M4vLtnAFLb1lgf0QWGWCfk+TNy+bbyR
 M3TdMR0mStkrrrZn9flEtlwiEp0smDlMaFNSPHHtWLMPaWWcq2JFogIaR8OLPYoEjECn
 o0+2rPkkrO/ZwceKrOdAQKR4zX1I9wRVH/RS1sfHuTWiEUeC0WTNEgNLfWEjO5r9iIso
 /qZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oTUdZg9mDghQf1o9x+wxMpJYTch+gpQ19dcPDYZue7Y=;
 fh=JjrUam8UZtXTgCEH71mvy8Z1Lyvs3UwQZASQ65871PI=;
 b=SwRHGKS3xcD5CbL51eXR2moHKdzLYAAv+8a+MFoiyVYfsiAxGrcw2Six+2xWp8sogC
 clJ5PIFRG5iQUUiMjw6rFvu9Spfn78ZEc3wYBbixO3eyRGibT6usAIabXGbftjs6fsUL
 JipfTjoHz/wZ5mHM0ITE/A6yg4NU52GoM9+FF3Gx1sepI9B2gDoDB1R9MzJji6MhwJ9L
 ycecUTfEOhvuJAVKJTe3usp/j3jymqECIpAZUQXaYYjCwyJgWnhw3+Voow6NT2M2fNrr
 K63Mm6rYu63R87Mww8Kt04l8GOWp6B1997+xTiTfB+huaXICAcsgEqJdaPs/eirJybmB
 QZVw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790960386; x=1791565186; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oTUdZg9mDghQf1o9x+wxMpJYTch+gpQ19dcPDYZue7Y=;
 b=ppWn5pNO0cGSUBeJzUGH0WLW1q2G7BqK8FAWyAzMSJvbmuNRAzE1QtW/lfT5UHW+DY
 Hgqawcc1VFay0SEBbZQtlNWR2kHJM+JHq5v6fqGXZEOpZl4bGBAwN+i71Zzjscf5mopB
 tGye8Yvch0wGoIl7txU31nIgnD4pyWuPOlhKdPuU080VL1o2EHxo4i5rn5nSWctjY751
 DWxpPGdex2ZMmabM3ayP6njw/ZViqp53nuU4ZLBqvK2o9U+lCp6uWyl0gCI083wyZslW
 xVPp7JkLoO18gzWa9F3l5b9Xaw5oQKc+SaoZwkOeZwQNLRcPRIKIF7e6u+OuU2zSEYaE
 QDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790960386; x=1791565186;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oTUdZg9mDghQf1o9x+wxMpJYTch+gpQ19dcPDYZue7Y=;
 b=b93jsrGMtyozwDF9KBg3u5yFTbSuECQ8YgpZLqYr6Zfd3QyTFZll9zrr7fEqOLB6bj
 qC7WgMHA+s3EVnMnrTo8c7m5+OC5MLoH8d3waeC1Q2cNnOB9QvqWIz0KO6bt1zI3G8Ly
 yRwMYopCI4xrL29JiWL7TsW2dhS0Y64uDZ2e9s3K/uY4WvJahDZAmOH6TuqfA6hBKp/z
 c5sGQVSh2JkD0UeKYTo4GYHp+XPP/HN3ku/lj/FHk694ko4zolnk3kGBkML4uc6500rR
 lVBZzr+uNhXbyhWFX+itGuzI4YcnFozcoqc6FeeZoR2RwIzsxN4u8uOdzdDsxvmQSKGn
 0gaA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxGLZT8ViiPPaEYekz8W/fJZpzvyj8orQ9KeEm8hfhA0efKwg44BtNKfsEY7LaubrV4AdeKUuQ3/GY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYImrqB6NzITmBqFHezDZOxbXwxcGQTwIJzQhPl57+kTONwcw5Bh
 16fS48JbHrS5sGaGgGz43pjO7SJM4P5kqZqPWPBye14HXvjE/8R6YreNdgJbv82scCqL9cWP18S
 oZknVzyqLF1mL7axVSukZmWHmClhYOnQ=
X-Gm-Gg: AYBFou3DDAPpm5GUqhtJ10agxK7tjQu6ixYzmgTqq4sMhRXPzc1IEGIQA3PMlubDfrC
 H90abq3dzajtzb/lnRlB4ViYiQaB7P2qTOlIuFs0fxeGa2Mv+soYmyrE8VVak5oUnloXKiYUvRI
 oFOV2rv48x8cWY5J07DaZvm/HsN27QkYs4JcuAxvP1aepTguVvEptLul/MNDNK6NNZyQjmMNl6Z
 BJPwPqooTnMVfOXMJ1ogo1XgY7r1vV/dfrVS+5AvFBCM6w5U3JaCsRRY06uKRFWX+xnVIaG3J6R
 ZPItxKUCQjgLMt/GPjupd2p73nWAYTsUvU5WiZ5pWsmyaLXeO/NppJGoeo9nlFHiknzW+VI2mxi
 YoYinV2RuV3q0/fjKoTPcNUTJkivfQGs/Z5lkDzNjNAaKkjPLCT+V5P3N6yegkCA9cJ8zPu9rpf
 TwltCvZSGxNqqwJ/PKRJCfm9rjkX5ZXj3PdmgSfy1VhNgm1Nk5bKiX6W9KpStjaw==
X-Received: by 2002:a05:7301:468a:b0:340:f698:fd56 with SMTP id
 5a478bee46e88-34f1507015fmr4716231eec.2.1790960386330; Fri, 02 Oct 2026
 09:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260917-cv-v4-0-547ef5727451@nvidia.com>
 <20260917-cv-v4-1-547ef5727451@nvidia.com>
In-Reply-To: <20260917-cv-v4-1-547ef5727451@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 2 Oct 2026 18:59:31 +0200
X-Gm-Features: AclHuK_QhqfJYiyMedO2piq5-wcrguEMff8QxYGEopB8UiRg5ASf89kljYpIsb8
Message-ID: <CANiq72m0PLhT=-ODzQtX7k3jn6=XXpESDUbnHcAmR-1gFqR7uQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] rust: num: add cv! macro to create values from
 constant expressions
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
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

On Thu, Sep 17, 2026 at 10:35=E2=80=AFAM Eliot Courtney <ecourtney@nvidia.c=
om> wrote:
>
> from constants without a verbose turbofish syntax.
> For example, `const { NonZero::new(1).unwrap() }` can be written as

Word wrap or newline?

> +/// Creates a value from an integer constant expression, with validity c=
hecked at build time.

Maybe:

  ... a constant value ("cv") ...

since we explain that in the commit message, but not in the actual
documentation :)

I would also say "at compile time", and possibly mention it is usable
in const context (we use "build time" for things like `build_assert!`,
which can be much later, e.g. link time).

> +    };
> +    // Using `FromConst<V>::VALUE` means const generic expressions can't=
 be used, since it requires

Newline between these two lines?

> +/// Types that can be created from an integer constant expression valida=
ted at build time.

Ditto (please see above).

> +/// Implement this trait to make a type usable with [`cv!`]. Use the [`c=
v`] macro, not this trait

The second intra-doc link should also have a `!` for consistency.

> +    /// Fails the build if `V` is not a valid value for `Self`.

[`Self`]

> +                // CAST: the macro is only used for types up to 64 bits =
wide, so `MIN` and `MAX`

"CAST: The"

> +                // CAST: the assert above confirmed that `V` fits in `$t=
ype`.

Ditto.

> +                // SAFETY: the assert above confirmed that `value` can b=
e represented within `N`

Ditto.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

One thing before that, though: are these assertions expected to fail?

    const X: i64 =3D 1 << 31;
    const Y: i64 =3D cv!(1 << 31);
    assert_eq!(X, Y);

Or:

    const X: u64 =3D 2 << 31;
    const Y: u64 =3D cv!(2 << 31);
    assert_eq!(X, Y);

Because that is quite surprising, especially since we say "with the
target type inferred from the context" in the documentation.

I hope that helps & thanks Eliot for working on this!

Cheers,
Miguel
