Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C11C43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8CC010E096;
	Mon, 29 Jun 2026 16:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TJoazlts";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F43810E096
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:15:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D4074172B
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159D61F0155A
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 16:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782749721;
 bh=2echV2TuUCorDUo3P+lP4EOwfZ6UxnA7Vrhb9+2po14=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc;
 b=TJoazltsXCrMCTgucF9n2rj55ynbhFXimvamVNgnZhCjgNyjgNqGE+fB84F2BOlK1
 Lhep4YdXesYdd4f+yP36ezAZZrT5O1TXql4Eq7vImX0an2xO5P3S37240UffBz51JH
 F3OhdkIPez8rlNHeQchlruofSmheg8cfSA7hNy5fv1OwhBJmiJSLX8P2+qE0X45xRL
 okDyyj6H7k7wo4fFTcbK9a7Sh+rJsQe9YgiHuH0jnIwIhNoP2+bk4RCNC0CnkEPhhr
 lyayZgs64iOAznZH9uHM9q2Wokb0AxK7AQaTYq/Mwb3dFzVDr66xXJ8cp17sX3KN9q
 710v1sBBZcBEQ==
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6984169c126so4413275a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 09:15:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/Z2DxsKzvMrOTDc8me6kFi/IafER8pwG7F87j1E/aA7ioL2loDkTX2Rr5k39Da2TGtoBpO2Sw/1eY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeYYmqItTTHeHs049frP12nA9USYCHOyZDoYdL80Bhw5gIWg3e
 Eg5lYAUKU19GSXh/4Ef8F1vNbD9AduGRfkOAfi/BBx5mA2YRACwq9FJeAOHnDAOkoQ67tcAwej/
 gDIWbcIIhgRD163IC+sJYD/RUhzOxfQ==
X-Received: by 2002:a17:907:1c91:b0:c12:58ac:9869 with SMTP id
 a640c23a62f3a-c1258aca1b9mr349323966b.9.1782749719747; Mon, 29 Jun 2026
 09:15:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260603-rust_serdev-v12-0-3400ffb88b12@posteo.de>
 <20260603-rust_serdev-v12-3-3400ffb88b12@posteo.de>
In-Reply-To: <20260603-rust_serdev-v12-3-3400ffb88b12@posteo.de>
From: Rob Herring <robh@kernel.org>
Date: Mon, 29 Jun 2026 11:15:08 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJEqUbA8t_01E+QBbsfdV6JWKGJPhEQMD7YKPKYk3vYuA@mail.gmail.com>
X-Gm-Features: AVVi8CfhB--Db5QbuVKNGlVOJyT9ymFkRQjZNe17XqY3kKJM0r_8jlarJXXYsZQ
Message-ID: <CAL_JsqJEqUbA8t_01E+QBbsfdV6JWKGJPhEQMD7YKPKYk3vYuA@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] MAINTAINERS: serdev: Add self for serdev
To: markus.probst@posteo.de
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Wed, Jun 3, 2026 at 10:56=E2=80=AFAM Markus Probst via B4 Relay
<devnull+markus.probst.posteo.de@kernel.org> wrote:
>
> From: Markus Probst <markus.probst@posteo.de>
>
> Rob mentioned he needs to find someone else to maintain serdev.
>
> Link: https://lore.kernel.org/rust-for-linux/20260430195858.GA1650658-rob=
h@kernel.org/
> Link: https://lore.kernel.org/rust-for-linux/da85ceb81f51079d4a8248a1ffde=
6a27d2ef24ad.camel@posteo.de/
> Signed-off-by: Markus Probst <markus.probst@posteo.de>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Rob Herring (Arm) <robh@kernel.org>
