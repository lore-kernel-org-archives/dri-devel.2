Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E557606A6A0
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 21:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z/0OsMGu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C031310E34D;
	Fri, 20 Nov 2026 21:31:45 +0000 (UTC)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com
 [209.85.208.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB90F10E427
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 21:31:38 +0000 (UTC)
Received: by mail-lj1-f182.google.com with SMTP id
 38308e7fff4ca-3adfe7a31dfso1047821fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 13:31:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795210297; cv=none;
 d=google.com; s=arc-20260327;
 b=TgTZHc2ojQpxd4W94UCRf+MbTxxxTYLGmZuR7dZYFxu2kCyTTOvrx9YLLmfAe3EgZY
 P84ANdQ4OD/OiZ0atG0tc+AF4PT+/v1BNGCry7QkldlRPF/qhTmAcZJEtEHPmydEVzjh
 /h8pya35nRQ7pfPu49wHumsSjPIlKhCY1fx/4j3CND8dDhcry2pDU68yclJYEjJGiJwh
 eXJnV427/z2PhMuX3cGbSgX4f9mLTtt9EgxpkDRG8eZWgvHR5nKEjY94Ehv1vHLl5qkA
 xSUbO3EjXoe9LTUQYeGIagAgbN1Va3m3Wv1H9w9SBDtdqBZtM+B1FE9ArtCoRVsVsdPI
 xAdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
 fh=38kzyzpUle3PQPWowwbbFxvUQjySP/8ja1jTQF72eCo=;
 b=eReDpXPbPU6RDxL2rEeH7/Wq4pEXQEBtuzgsLWRY2ThH2xQHWK62kvOCk1n1WZnnUk
 pgVXCrwJthXX7/EoXItQl5gamELDK77LHpb6U8aoAgEHR5dT6Bf8zcJVICiQhdu7/lym
 ENAW8X6dEb7BkVwypzL59KYdf71506l5yh/jGdgP2PCwraWViBLuutSR3Pf5KCnb4bLC
 0nx77G2GExf4ALUE4EmxbMNBw1E3UKwmgDDLHLgkDJS2lf2OLv9+b3HHz5lohDqBv76h
 k0QEhHmvLsE6vZg1EEJYJh5bGl2aRjNr2Ht+UMrdi1X4HPORRZqIpZd5S8k+aC87LOat
 ej6A==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795210297; x=1795815097; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
 b=z/0OsMGuKj61729cCKYUnBREixYY4Rm9gJwPdny13mf8HNfiIH961BCmkPwq3edsiM
 c0TIU0Qopgvhqoq1zngmPXhH3kQqV6EevJucR27mIsR4KnjYS1qlXtWhYgbyOdzYDGBQ
 lTP5ZOsWbEFLXV/v6WD95ntVkkv+YgaFqsZSAO8MZWX2qBGfZ7ZYK+52nlF5rNBZRkyq
 sy+sf5QUzGx/zCl+ZNzslRw919B0Nbyv1q6eK3o8QXfO8ed9T1mqnIYFRqCzFu4eSKvX
 hL7f0XIgiLCPglqc9ZK0L7/bpiP/aA4qsx4D5jyz3iMX2x4faosmK1fQz8ZnaNnrYzfZ
 gQFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795210297; x=1795815097;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=26y+of0VW/d3qa/IzkivZULa62OBHde+4TVDHu/Ebbs=;
 b=IFsxHB8yF3Qssx8u2s4npXNOCm1m+RHSPfOhQSTv5WR1xh4Dj0HyegwZ1oPWVQQtOO
 i53iqvz5NL/1LyK6RG0pG9oYwDIK2dBX0gVXRlrqd/JmYE8NpkxBiSoDW0EMbimrwsuL
 y7HOhps2fbU2/vQICyDtVSIF4pHCX9+gialyFw8qIWxoUcgZ5OJUBs0/RCC3+wtH9b8+
 weRLDpUbJtMj+DlkakgLJW2DFBO21h4HPPkfkHpAo8wboLcYZqbcmjmUj4WTPLwUwIyg
 zhkPRjcfSVVbUOQDdsB2MxakQptFCxBNrQQjNW7QdZlZhKLqrhC6ZCTJgRVY/49Cbp8A
 B/aA==
X-Forwarded-Encrypted: i=1;
 AL+hErETvNHGHqK1HbmnS8spLEFhZTNZwTuc5yqf8QzchESC3XUCyQgEI9DfKuwI7GbHWjZ5ePjj47pjC4U=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/210jCtPH9hm4OHP1GcXmUr+iVUx0iH8XuO4K6ULcP8KlYi0lY
 0+aTumXMNlOyFtfMAZ8Hs3N0MiNQ39pWAshjwwHg7vF0BcfJrTR2sIsHRN93+Qa+qtixsti0Kc0
 bR6yFRFO9SzGa1f4ygzoY1qBlkm2UhJU=
X-Gm-Gg: AZFdTZewHb+4PRPw2vgc97t3WiZ0jWjVVx1WBJ9oCWxHdrjbetuULpyuqcrMAzoZ5r9
 1TBsrx/PU6SalluFC59Lkn9nY+5+7GlHgTmHRA9ekQfTX/cylnfoO5wIsrWYnxh9BE3ndlSEi0g
 XE5LYnXMmPPEVaMrq9iFedFxv1fbJsAx5aGFyVMJkPgv96hp4F+zyfMOye7a6qbCR1MTqs2ZSiL
 xxgYbXyrH4ZySqxpa4We/tjI6snXtTmnZHSmL+ui/+CT8ShVeZ9xFluzs34pLVxluivaG2srGKT
 8AXutUjHBlo2Zhapq1UmFvDB7JXf/v+6CdopyR8mrkEyfAbnjY1PSZsk3UTlO0cQcmxPqWn1g9K
 HyTdZV0HzUGXknEkH77xiA+3oLnU8LuQb85q0UcT3f2HRQVdIOsBLeHyddp7dLeoPFQOnMEXJxL
 WWrGVlIpEW90y1ii6sQ/ZSS1Mu+hEDtvu2/fV4A/tCK1BRVN8XCJN58eur8F6pON0GaSovj5URz
 tBdDddxAD3CDr7ZiIRxtHaT+UdX28kC1lCdF8DigRUkrCq4xgTAnBTINhKj2yjo5hmCCC87
X-Received: by 2002:a05:6512:1320:b0:5bf:cf6d:ef1 with SMTP id
 2adb3069b0e04-5c1bc5767fdmr1687437e87.0.1795210296624; Fri, 20 Nov 2026
 13:31:36 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261013-clk-type-state-v6-0-a5e9977b3509@collabora.com>
 <1a1cb87df11.2c57f9fa237371.844135553238709982@collabora.com>
 <179519331840.3795820.8047048832159165355.b4-reply@b4>
In-Reply-To: <179519331840.3795820.8047048832159165355.b4-reply@b4>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 20 Nov 2026 22:31:25 +0100
X-Gm-Features: Aa3M54o4i_zALBjbkgtOxZes0dCWZ4jiHPCTwn8GOTMZ7mrp5N06gIycRXOv0PA
Message-ID: <CANiq72nOKrAtct_eb7tjc9JFFpOQrN0=5bOyOZo1p4C+4U5bsw@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Clk improvements
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Danilo Krummrich <dakr@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Michal Wilczynski <m.wilczynski@samsung.com>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, linux-pm <linux-pm@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>, 
 linux-riscv <linux-riscv@lists.infradead.org>,
 linux-pwm <linux-pwm@vger.kernel.org>, 
 linux-clk <linux-clk@vger.kernel.org>,
 rust-for-linux <rust-for-linux@vger.kernel.org>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Maurice Hieronymus <mhi@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 20, 2026 at 5:49=E2=80=AFPM Jerome Brunet <jbrunet@baylibre.com=
> wrote:
>
> I was wondering how the rust folks expect these changes to be handled sin=
ce they
> touch the rust/ dir. Should the clock changes go through the clock tree o=
r the
> rust one ? it is fine with me either way.

The clock tree would be ideal, i.e. a lot of subfolders of `rust/`
belong to different subsystems (the file is already under "COMMON CLK
FRAMEWORK" in `MAINTAINERS`). The "treewide" Rust tree can act as a
fallback tree for files tracked elsewhere if needed, but it is meant
to be exceptional.

(The files will be able to move to e.g. `drivers/clk/` eventually,
when we lift the limitations of the build system regarding that.)

I hope that clarifies!

Cheers,
Miguel
