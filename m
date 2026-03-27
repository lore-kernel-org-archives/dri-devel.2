Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 317E310F2861
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:38:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 894B110EF31;
	Fri, 27 Mar 2026 17:38:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oaZu2gX6";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB18710EF31
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 17:38:21 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-127148c2112so215493c88.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:38:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774633101; cv=none;
 d=google.com; s=arc-20240605;
 b=lLvm0SD1egK14rKILFPn0m6+1EujFa81kKgG15UiwMJeKBP0s50awW4bCcmQFtrBIl
 x3qGDbk0s5N9K2Sq9UMqLeKKRLC5QMdaDKHlM30pwRj0SHUYcOfhjqdtN7AZ/jyukuRH
 4lm/o10NMQd1lDMCRCYkgSeyFfMMoIyIqqokBQ02vTAT6nu4AZQH0xh7baogaRRP6IVx
 LUap8Gh0zykrB8SKzMYbIJd14IkdhVAKeFtv9HKhf6aSZweRjkYvx71qRriHIVp403tK
 U/Md/wU0WCVz6L9YHzZKVO0D5WlcLjnO5ge4rlnBznHnIyO59VSgEDqzMl0CjOQYwtzv
 j0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
 fh=OEIpHNxQFzSYHloTx1qQVOVzWSiyEfDOANTmxULuiz0=;
 b=CM/jB1DOqFMPQnYAwYiDzc33EIBpR74IHhn11Jy4QcSDQw7ccXNfsZgxv9s7fyM2N+
 rMvBQCSGAo7kzD2o9XzW/dWC87THzm/S8PU8ZFOcO+Z5tp9e6utr7R3nsB6bQpcMbTF7
 2h/OQ2bV5fAOanfO5tSaNdyZfsiHt0LV6HOHea1kkioI5c5jiX51EqN/RS7kqDNmWK68
 dyt5qhquPmC5MpBwxY6YTPFV2aQ9jf1rMmA9Jcy93RBJt9/r9uzD5+b5lmr4wKWQt44f
 CHQ7f/TsPffO3a9evonQVmMkXmU0GjGACznfKYxnuDMFIh/Cbhu0OnIdFeQKHNYWsDCP
 FOcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774633101; x=1775237901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
 b=oaZu2gX6gtlAozMu2cT3UqoX3j3EF0dVSLPzvvnlX6dHSULHxJktaV9W/AUUDKnUCd
 FZXIUhMpaqRAU2ArnkVfcTJIGvriZHSCc/nreBtvc59NV2Komb9mYQXcBTgPdl5mbrV4
 Vbv3BwtP3wuXYXd2ImexHl9QkxIBag/MIdtnMy31qkm2By/HO23s9eiLfpYNsq5GWdoB
 9+8U94frVspAIeSbLiw9csLrZ+3etw4Ujx6Ndy5qmTujzbliV1SJklkbY72pHDT3o5jI
 yCILakjYpKfsT59M/38CE3LIaI4uQrp/dHRjb7zSwEHRRXad+8bNxPjHlPxCKBHZwpRV
 L+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774633101; x=1775237901;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i4XRoGQ8ciAxF5LF/eeAmJpc/qwTn1D2VGvZGqV8ZKk=;
 b=WiNc3d7xIFnh/nJnDTu/V9ghmbAh6LPXk7MW6zV6B8+h9EK8BmEYuFoD2/uDg6Foqd
 U+qvs7xbBfTnyxW8H1c7JnZJXnc4+HGECqf2BOSgqZcCoum6ncCcj6mzbPgKnhRjxLLe
 TJiI7WiaqQ2NYDtdrGl4c0rINBC2/pmV9Qv85HkeagMbISAU/NSDqf35l1yjoSZLh/8p
 V78zkFcBcjHzH0yd3GkkghAR4T5qN9qbfd1FATA5LMhe8IVmOfyM2jq2Pqt9BRjS1Yin
 RzI4ADzTcaOxLpA/ZS0H8W7HYhxicL1g5HYPbKxtfaNzOlwz7Gz/gQNmm2dfNKXM5lDF
 rTlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiS9OGavduwwx9e0QN9yPV7vnUeIrPgiXtCTEEF3r5NisHA4xG48KRTh8FX+VjTKBQuFuyfByBoI4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwrBQAtrIqeb6Mm7f1qOjJIf8Of0VFQbrLuUXB3GUssgI9I2Dkj
 tqM9w+QiNeR3vIgPtKRTJg4tjC2B0YHUb96TnRCzHCZiALfjW1dvi+wvPCATBh7GLEiIw12CaWP
 qi6XxRl41vBhOYr0iNEYJZ4N7CLQCGXM=
X-Gm-Gg: ATEYQzzsohSvyicLPRT7v1oFxamOJ4ecoXF+jPIzXyQ8ah5ZuJm0DQCrNB57M8EfYKh
 4Wv6o0myRBNKNAeEHWxsU8U2sT5PqVoxnx5ZFUcV8UuJxNt+beKS+9d6MBPK4MpPSjMUt31zfOJ
 DfsauQPRMLKqBLyb2vh9bgQMvWG4ARo3QunO6nDJS7P2sfDQdV8rGepNogaFTr8BBgyed9kBj9x
 /XdpJrxisvMku0eG5YLVi6AFghCfuB4j/nbj/EeIk7A+nfRhqhyNniQrn/giPZxlBM4jSXP3D1u
 wo5aWK45/0Bu69AeBxnbMIsR9PmchcirbRM8OnDchFniG+cZCacjdP+7eUzpiJFcyBOivlLATZO
 fdSfQQVPUiOYgY9DqT61HJOI=
X-Received: by 2002:a05:7300:3254:b0:2c0:fec3:fd2b with SMTP id
 5a478bee46e88-2c185f4195cmr868301eec.5.1774633101017; Fri, 27 Mar 2026
 10:38:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
 <CABx5tqL+G9i1ZW7i5AHaTqUFTVRDmBvP=RycUdwjG-GOp4uzBA@mail.gmail.com>
 <CANiq72=M3H-06L7udG_LqTwLykZkAjfy2d5NXQZn5TYRJ+N37w@mail.gmail.com>
 <CABx5tq+TdGvL+SCUe87qWFgeAq-1Zf5w63jn2hLe9+YTyz4sNw@mail.gmail.com>
 <DHDOH1FXTIZT.1QKZIPZ73YNLI@kernel.org>
 <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
In-Reply-To: <CABx5tqJho=k88A1L0neVeaiYCXpLsc7UjzGSgAug73ZC_amYag@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 27 Mar 2026 18:38:07 +0100
X-Gm-Features: AQROBzDgjWTAFVxg45-x5LUiec7rwVNiECYCnGtFbz1GIQ6qZ-C218NzMZcOD9c
Message-ID: <CANiq72=E=fyCjr_5zEoiUoSOYnXTzfFjE8KJRGsDeEQN1cFY=A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Maxime Ripard <mripard@kernel.org>,
 Stephen Boyd <sboyd@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Michael Turquette <mturquette@baylibre.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Drew Fustini <fustini@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-pwm@vger.kernel.org, Boqun Feng <boqun@kernel.org>
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

On Fri, Mar 27, 2026 at 5:54=E2=80=AFPM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I mentioned to Stephen at the last LPC in Tokyo that I am interested
> in becoming a clk co-maintainer.

Thanks for the context, that sounds great -- more maintainers and
reviewers are needed in the kernel.

But, of course, it is up to Stephen.

Another possibility Stephen could perhaps like if he doesn't want a
co-maintainer for everything is having a sub-maintainer for the Rust
side, possibly in a sub-entry (e.g. "COMMON CLK FRAMEWORK [RUST]",
i.e. with the usual square brackets we use for that), assuming you are
interested in that.

It is an approach that we have seen works well, because it is usually
a win-win for maintainers that cannot commit time to review new Rust
stuff, i.e. they get more people in their subsystem, they can use the
opportunity to learn Rust (assuming they don't know it yet) and they
can assess how often Rust changes are needed, yet they still control
the changes (e.g. in cases a change on both sides needs to happen at
once).

[ In any case, I don't know the context behind all this -- if I can
help with anything, please let me know. ]

Thanks!

Cheers,
Miguel
