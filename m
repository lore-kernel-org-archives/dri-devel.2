Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1557CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:40:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F226410F250;
	Thu, 18 Jun 2026 10:40:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIbFrpOl";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2678610F250
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 10:40:28 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30bc5fa5a2aso97749eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 03:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781779227; cv=none;
 d=google.com; s=arc-20240605;
 b=ILYniEnAAu1Pos4bo0/kbcvfkA9KmKqvg3afBz+yIeJIqfxHyxXslA4gIimkz1d8mu
 Rpeob2/QAHTU8SztJT9SLDSaPXpwM9ueU2+oEmW4qMX8ewoOM9mkXvipSdvYja6k0VLQ
 BknffBx1f5aLpxV8MvuII7OGDewC2ma/cHouu8x1sTG3j4G4oXnVYa01zasg5bdPRrqA
 dWYUZEqWC5Z13pqFvhun0n0SIljXKhzoNOoYT305UCy0rHSO1yS3KCs2KKgF2McFORux
 5O94auVRaYzMdHMgkyP8ehQek01ucMOUs6JbaMVYJWSdVBzvEEbJNBEMDltmRPY1t93G
 pX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
 fh=BVBpsGqQBEyNhFGE95Lr3HJAR2cD7Gsq7gLYk+zoB/U=;
 b=YwJ8KQDB+tzJHYHwKHZGFP5CWouH/nMmOYRNnmXI2zPyGLMUE2w6Bvv82AmorAQD/q
 EEdX8FZh82ufw0eQg2o9qkxmk3ChI6jexJLivZU7RuLG0dfGIx+9CV1KZaxrdGsDlc9n
 KtCjPTUvM0UKyaHF2kmQ7+T9YYUCwY2waqT3wezg2RJQScFXMzvLMGUFShjR/9oqVZPt
 MdEcw8P4gdTmRwNL6RzEN16Zdlx8b4HWU+VIUMqa0UKUsA0HsbszuQVqdFo6CIvvv9CZ
 npemkZpy2KN9Dnpo3kyJyDS1VDLqYXL40OH08caS22uTZcpx5w2+eh3TVHovhxbiGWCL
 NTmQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781779227; x=1782384027; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
 b=YIbFrpOlQYJBAiCqIjH03dxR0qevsSLO/BIT14blP/QW0T++tMqR6DLH0xH9UfUU+Q
 9PYZY4icwEJGwFI5m0dACDYEqCTqCEaxHvbp8JAODPt9Ox6ULpErOZlRSdEkNnAIX8o8
 D2aErrFhDGOgs+Pm+va9BRyS/4SizaMG5TQEOzMWEqZg1yoZEgA6cQFrN7hkt6bHdHFT
 +kkQ1GDw+FzOHr9JzzFCfx+T+TNdh2zDfwj+rm0jlyffcrFUwTeq3zxxZpNBF/1FSqIN
 +5LMrwP1CD93t0Jgh2QEG2GpXayPNNxGbGc5H+9JXAdsYi5cj17SxVIWyTYVpqwGLyPL
 LN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781779227; x=1782384027;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DUQbCb92xOvO01pv+r7iCHPQp0UAu27WllptLJOlB8=;
 b=k03xLW/mwhHrINgl1c9yC87KFjVdn05uWCaIupWwXdiPUnNoMWHLXDfYofcd8Pe/wB
 +fBWLLIWMPvRVughoGmCLsvopkveLcZqSpe3Xkd2s0Ll4p++CJCjum6J7sxQcQ04rGJW
 YOxKcq3XlJmdkBXqZrnxEYFr1XnTfY7BUPToU1xGxNjtEjw1lMWXUOPJPyr9v9YXQEN7
 7O/VYtueBXGtGdVNN5Mew7OZxqfV6lYK8GiU9fp1Bsqr2FRkitR+UvEL5Zll2aAzqNQA
 7bs7rlU6Rw7LQpg4bvCT3sNieM0Ls845K/cHmBra4dyA92B4hNRnnDp4YRU4PLTUgmw9
 rX2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ZX+rLV+7cQ03SZ3uFRNbEfybOOwdx8QuvLkFaveH7/dSBDItt/t2zX6J3+k6zZYb/onz0mRNbktU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yykk5ggQVcExWNOOYULZt4CcBaSY/T3Eqaz1zoMKDEFpznWLqou
 RgZUOaHF59sI8FvaxhZkos+in9wOHehpaxXjPmB7WkNpCeWMKKgNSyV/8iOxch3JpvPurEFdSpF
 7XyWGyXy+VZ+cAy8ozf/W/A9II5V0q5E=
X-Gm-Gg: AfdE7ckwYK3/bF2eVsSx+UaD4I1I9J96f+8x3QZFqQa90b1LQZZ467qaTFxoCSHBDxp
 j8+0QeKUE9MzaKmF4IxaycWc5GCM+1RET3czNYHIP6hLWKrH2eFwLQiW+k7dFb0DOCu5/otsN21
 JYwDOI2hnW2WNJzf5448JlCO2FJsTJdL1QbnHugCbeTT+4w61QuBJ7xebFXRRzm6BlLk/sVcqMU
 AImi4zFCNuMPo1tvkMv9iuPojkIzb+LkNc+GvvzrcdY7om9Tm9bITSiZm+TDbOVWdfF+Uj1s+5K
 59N0O+OGpPV3LIrfEc5GCXdsYkKMy2hrGn6fbBRhnuwflh1mgM3nSQOXbyrWawIGur2eNWNobTv
 lk21X1HxQl3iy
X-Received: by 2002:a05:7300:ed85:b0:30b:c021:5045 with SMTP id
 5a478bee46e88-30bf09c4416mr1020403eec.5.1781779227291; Thu, 18 Jun 2026
 03:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20260618-clk-type-state-v4-0-8be082786080@collabora.com>
 <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
In-Reply-To: <20260618-clk-type-state-v4-3-8be082786080@collabora.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 18 Jun 2026 12:40:14 +0200
X-Gm-Features: AVVi8CcKkRQ8t8MfiUD4gXtI1Y4DMiQAI7JLxiiYKqJ_3SsG98lF2VyIrlJ2k1o
Message-ID: <CANiq72myoVT9npyaB0pVvbJ1v9ELzw68uAvSoAkdJJX2MJQ=kA@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] rust: clk: use 'kernel vertical style' for imports
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Michal Wilczynski <m.wilczynski@samsung.com>,
 Brian Masney <bmasney@redhat.com>, Boqun Feng <boqun@kernel.org>,
 linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-riscv@lists.infradead.org, linux-pwm@vger.kernel.org, 
 linux-clk@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
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

On Thu, Jun 18, 2026 at 5:48=E2=80=AFAM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> +            Result, //

Since you import the prelude, I think you can take the change to
remove e.g. this one.

>          /// use kernel::error::Result;

>      /// use kernel::error::Result;

>      /// use kernel::error::Result;

>          /// use kernel::error::Result;

Similarly, the prelude is imported in doctests by default.

Cheers,
Miguel
