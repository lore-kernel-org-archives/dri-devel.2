Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1603310A88D4
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 15:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80B8010E234;
	Thu, 26 Mar 2026 15:49:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="TLeLCmWX";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4877010E234
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 15:49:37 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43b949bf4easo656604f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 08:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774540176; cv=none;
 d=google.com; s=arc-20240605;
 b=aUqjpZeTBI6qMkfyk3xr3QYtjdUus3+Z6Ax8qWGeJ7MoKWekK5pNGXO65HXY79eyj4
 6GZLKtM4OyUqGAuijKbfe8W+Zfa+OvmrWYRACn0jWcPxRtWuwpN2rbK82yOTec11N1/J
 LgR3/SOMDiwPOMtPzPJ/xv2cGInXjTyuNh4ugOzYHnuWLDZBV8RAeWasg34EGBHpbTlR
 Ue5N4BRRBBZsS9V2B2Cd39Z40AztJY4G38voMydGTe79nLs+tGglHmqoRiHBO4OtWbwZ
 gbWriq3kvv0G5tSapSdYGqxGE7OKcqx3X4lo19QNTakAPUSdR0V8e5KNOpvFhlqH5kop
 0yyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=JqxiEEmSPUC+jwOexatjBHdDcPhEBeaDQL5wAWmGtEM=;
 fh=MlTPdCvaFeB08M9dDJxrolu9Du2rTxZLWjlfsEOd3sE=;
 b=aH6p5U6GI8At7d5Dqs7e7jNCylnGnyUXC5lpH10bQMnbjGqVwDTrjOljMKlX7kYRht
 Cbghdx2emq98EbJiikcdUwpur3Si/xOAhiHo7g5xHgtZzRENzxBVe6mq15HHqtOhcMDo
 NBwt29/YZi8awqk6nvy0s21YY745EtpXk7jKlcMWySAcvLC04kqH4ceQ3sWFT/fH0EAT
 aGrLpnLVxik+i3eD/fMNRLMFjCQA/pyht8zwy6VU4PuFPuIf3wedM8obqzvBuQqhdrMe
 qeFq70cv/JF9gkHqgy8TN4c2lmgQeHSr1Sm7FPFKqKCLZm7egbcO7ybMugNPo262641q
 l1Cg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774540176; x=1775144976;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JqxiEEmSPUC+jwOexatjBHdDcPhEBeaDQL5wAWmGtEM=;
 b=TLeLCmWXeqsszQ/+M6aPJaGkx+/HqMwkPQpUTWzxiDXOYgmikqQR5/VmcVMm+RR8yB
 cKseQ7mStq/BwhT1YMHKdZf8omZtRHtfMAOt7+7YvXDUQsEjb+sknYJGvfYthnbzM3rt
 hxDfLYUwZPLvEReso2IOpURJpzA1gu0IpUcXP3lREFFrou9npDAcciEN62TKa+sXL9/h
 DMvkSnZv4b0khld5Njtvh1aeJSUY7ow8Ytr1c23FhJI+l8Sq5OCqAYhyNnUa+1Vc/eOL
 7DH1EEVAfY2gjtVaRgdYOGzK2MWEfsM2i9iwVf59kZVCyOO4cDPIj9UwMnl3QzwmwDNE
 zXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774540176; x=1775144976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JqxiEEmSPUC+jwOexatjBHdDcPhEBeaDQL5wAWmGtEM=;
 b=KGjAcyYy5qpZZaBXcALN7F4RR3ZMhvm0Wnf6aW5FfZKUcXoB8lDv4UBYR5H/H4erVF
 j18n+ZZSxbLtJjTznH7H93KzhKKJuEuWzFAunN4NUdh6/soH6ceXpcp1z/DvEc+NiswK
 UA3Lv03hMX9atU2vOpXttHJaRkAmlXZTMQdwls1HG5nqQUxZefL3U9YKK2osBQQGaDl8
 6l3vvSusKTlgOI7lJdRuTWFh+7utoLYyJ69KuY3qspUS+pZ6WbB3MB7r7yfJItJrPOKX
 bIE9Pp0Jge1qwBvcx2gLpOhtQBIfP/TKT8N6SjjQc6w3Bm9gaUqwd/nSQ5U+7dx3TiIZ
 rHNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf+C5ITeZsqXmS+9MnLeLxBu6Yh/wOAk0fxbc7Nrtr9OQggPW2y1ZswzEJW6Ol3gY0+cpxJvAqYMQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxibGLLrGQhOEMLGA4Ro2mM/E4SXuhgiG1uOWUQLFBuJCkWmtO7
 8zqD/u83GcdIq8ITDMDFLqBYhRExPJFkGpq7ooDQKe7adAVnkNATiZKX4Yzv0yWL4botWa9gK5y
 xZT1ZFbM+eh6j77PMJvp0L8Y4KrqxPohpixN1UFog
X-Gm-Gg: ATEYQzxJwNPrg8Tf8uJj5fJ6kvh28Bx5QGYCul6d9fIRnfT9Ra0lNE17O5CDTzkIMBx
 D7T6wZtbohD3E3yoDkkZ+jfyGNDZGDvTUwoSNjN+kIyCx4xPWKNwvLQX1k2Sp5mYWHL5zyn5Zip
 1eQQoGQC2LI0chnQyMCFhBxJ6X00ZXL0oUY0P2rjKRIk4r4hpnzXpkc1Aj4Eic/5Ve7EPrczwUQ
 66uDDwf1LBi7EM3Kyzuvc8TEpf3GNG0tKyq7Yqdkid68Kssf9b6caeLqrOohBus/IyyfbMCYhf4
 DbF8ULKsMd8cRexQRpY6b2FDlrA9R1fUaSnNOZzwDbHTa8kr
X-Received: by 2002:a05:6000:1786:b0:43b:945c:e557 with SMTP id
 ffacd0b85a97d-43b97a1f474mr4141498f8f.11.1774540175323; Thu, 26 Mar 2026
 08:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
In-Reply-To: <20260326-drm-rust-next-fix-aref-v1-0-7f6f58d2828a@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 26 Mar 2026 16:49:23 +0100
X-Gm-Features: AQROBzATTslqsw2j86jGnm7n9q_dPLelyscJS-8dyeA6axRzEYbPwPuUtl774ws
Message-ID: <CAH5fLggj1nFqQ6yxAgQxrTGJ11pzBdObbu7WNxv7YZDbhkCE2A@mail.gmail.com>
Subject: Re: [drm-rust-next PATCH 0/2] Fix sync::aref imports
To: Danilo Krummrich <dakr@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
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

On Thu, Mar 26, 2026 at 4:25=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> A few imports of types::ARef were merged into drm-rust-next, but this
> old path is being removed in rust-next this cycle. Thus update them.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Alice Ryhl (2):
>       rust: workqueue: use new sync::aref path for imports
>       rust: drm: use new sync::aref path for imports
>
>  rust/kernel/drm/gem/mod.rs | 2 +-
>  rust/kernel/workqueue.rs   | 8 +++++---
>  2 files changed, 6 insertions(+), 4 deletions(-)

I'm applying this now to avoid a linux-next break tonight. Thanks for
the reviews Danilo and Gary.

Alice
