Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B484D58CA3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 00:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82DA110E030;
	Mon, 23 Mar 2026 00:29:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="azEvXoKG";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A4DD10E030
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:29:51 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2c0ccfcbee3so192825eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 17:29:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774225791; cv=none;
 d=google.com; s=arc-20240605;
 b=DFInDBHJhLOyPnXfWSwmtl/dtkInqe1KJncujp0v64qusOI2fsBwbg6xDxDLLjgtiw
 HiNUSv5p4S2BQhwwIRjn3FK7qxN967BopU7Ehg9cuEXPPrcsGhdgmfha4FDHu6R34l3u
 tMG9PrEzTivH+CTBOSFWApNaaJjP2hDi1M0gEj5tcjF6nTbnsZRdZZiTL0iYjKD1dmEe
 UwCLTPQyRoY97vA7MDvjunFyCTKLbJ6icKxs/CBJDFkGZyMaep0hGD4E9xVJWFj0aW5w
 bESPH0CEncPCelL22t6cWDPWySh+PiQXNTs0ZF8C6JhSKVfvlS0tHXMZsKk2XMqPMA6p
 0XaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
 fh=tFt9k/joi2V42+wicRsUWxSCqjMb3VowhwCNXYBq3Hs=;
 b=iHiNcT5tTzIf9QiInQB1xq6IkbfgJdv+PXyhwH31So9qR0IOkk2o/CxAwOB6mkb3vE
 WoQH2BCLqtK0IIppYcdLWrDfiC/RzaJ4pxhnJP6YdYm8mnwOU2oQkDsPjYUET58/j02e
 gxluUANM5jqgip0RzXU7XlZjrth9MclM4Z4fpEogtSZV2+W1th2lyoChlQZVSClAVuUt
 MHMG1rSp55/RJqrKyqvB5iawqjaWl+NX8h891ZYXpFVV01eqSyXE0Vy3ZewJt1KuN+HG
 M5hIisknGV4W973unRpPqcusT8yU9uOBpXytgskrwkCNiaxB7S5RpZzPAYsdVjjvTKUX
 z0Aw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774225791; x=1774830591; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
 b=azEvXoKGE6k6mpWW0nAcx+oL+LZp+BoS0jxMeZb5AF+fuHXJBT2mptRj5qSQ7cdxdq
 Q9drdqda+0YyacCV+rcRKX6m1h8M6ApQrV1p5w+S1KR6vyzyyZ6VN9NeSOihuOQJO90H
 dETi1ain0jqBqnl7RoHxjKFOY7x7LeSCqh+aSKrkcMqjQqRqc5D1N4tD7KhBfYDJTaB+
 yuRfZ8HivU53nS5pXdRQc1zTxQVTY/xoYdJL94lAtWvkLO9Yw0LbATnCd5hRgrBsKdK8
 M4alSpvrWcySpvkTcbpUEkFrlNxfZbtS/Odvmz9SKdJCTvRflprLMu0Y+pWD/TtBcuwM
 zGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774225791; x=1774830591;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cbHdiwHVMGwunEQtejbJGfCgtUR/AP8Rb2GG4SIKJY=;
 b=kCl8LTNhgghS+aAEB16XMhXcGuc9tr/T1LZNm+S7JSaEVdzyY5iHBKBVkZwIoc5V9x
 UxZ35UoUEIoks6q6J3LZvqarJlhGCG3hL6itDxtm2Nax75D6NkB9XbAo9iRXUF13sh6T
 Yag9tXLcs0j8x5dBl2P1vU7F+g6f+aXM8ZFuua6rnT1m+uO+XTprsSN0AjjKU+dl2/WT
 hdYV3uXTcHKsRRdoSpwZ9lR5jLgVmUU5eZapKUzjPVMqqMKFy9s6oUCfr8axmd2iO+1c
 pJ7oXXGuxfzH71niufwmTDeEc/DGTbKS1ySdmxhFUKeUGLR7bP1Jrfbw67xeYUPUfcpH
 dtfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq4cJM2IrXjl6mFbiFahAHunIae70ehw8rssDH7fWhKXkasZ2CUNUkQ98BSY3KeHyYVBUoGrx6k54=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwM53E4m9LpUuvxaRHTX/YDaN3xq9xPDnIYxFSMUWb649f1ELgz
 G/NCh640B/3YACKwRkNUJDWI+Q1PQUyJe6yogPGFuPZ//rjSQA8TfDdGCmx9JZkvcgXQ+XrEAoD
 7Tkl/zVMYxhHGU2Q2ZLs272HTrMBmGag=
X-Gm-Gg: ATEYQzwB8qTQxisbPXVoM/QmK3EbjZHxmb1lbiRlyfrCnZYe1qCS+SuJizTRrBOMGy+
 Xih/coa45qAfQhCEk76M9qggDt7yYY02Mi89G51qXQgna9trsTW37jD3VhbSOdN1Od2d0ioEmkt
 H2HtVwY6+yVDvEJXZfxi10gBUMHTIJYoDG4IOvggnl6ZKS4FxKOGDzYkaFJE86NIJe4pM1DlRms
 2Do3Foz1TMVxg9xjbJ0sBgGOxQhNqDIWTAEA8A/dneezEOXuAX55+xOOyxesqPllQ1zceT0hAbA
 ONPHrEuwh/ffmaYUNv38vO2hbgIKiviq8gLlyDAtgL6hpepaIgLwPxuGFR1UX8ywEbVgpg3aLta
 6yexXCbN0X++8kWUPdcSzPIc=
X-Received: by 2002:a05:7300:aca5:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2c109862618mr1863580eec.5.1774225790638; Sun, 22 Mar 2026
 17:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
 <20260321-awesome-hot-kingfisher-5d9f55@houat>
 <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
In-Reply-To: <CABx5tqJvOFEzmadeXpDxSUjkghviqtP0jo+kzSB5X6u_P_j2ig@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 23 Mar 2026 01:29:38 +0100
X-Gm-Features: AQROBzA_7BqFHE98PrvfdrcuinIkR-uI5M2p9UFW_-ESSorfSt0DS6xmhkt5poA
Message-ID: <CANiq72kAhVALH=CoQ37GPOKp_w=3_kZYu3Rkwnwc4CX3V5e9Sw@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Brian Masney <bmasney@redhat.com>
Cc: Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
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

On Mon, Mar 23, 2026 at 1:16=E2=80=AFAM Brian Masney <bmasney@redhat.com> w=
rote:
>
> I'm planning to send another clk pull at the end of this week and I'll
> include this series.

Thanks Brian!

Cheers,
Miguel
