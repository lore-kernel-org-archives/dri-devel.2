Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53981E7E361
	for <dri-devel@archiver.kernel.org>; Fri,  3 Apr 2026 10:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B01BD10E0E8;
	Fri,  3 Apr 2026 10:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="obLYgTGC";
	dkim-atps=neutral
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E796410E0E8
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Apr 2026 10:04:22 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-2bd801b4078so213498eec.2
 for <dri-devel@lists.freedesktop.org>; Fri, 03 Apr 2026 03:04:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775210662; cv=none;
 d=google.com; s=arc-20240605;
 b=crzxtyQTGaseIWkjyBu8pRNPZpHIV9oQXij8XwJk5e5zJvOD7fcH1RdKJsu70KDjSO
 yxYsdG9oY1+QG3PC4hBhVG43y3AutSLN6GYeXJoXy2nRLfj2Iih2AqvBqNk8W1BE5T2g
 jWSX9IfPRzx080cqi8+jMIBKDGUu50WSlRwarrTT2ZpqFhFkdzgweGd5reUqfUU0RGqY
 BSSO6VS9+95bNWW5RmcChxG+h5G+t17g7t9OQBDBTeQudL9NNX88t2Xb13GQm+yNuR33
 nYm/a9WUAXqcPRIQn59292uxjLPRL8FLkPqAeZ6BdXo6zbVFVfeHl7SzOxTchrump33E
 IfYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
 fh=SPjXuQJzqYzZBC5e+st2vC502RXh28MxRuAIPSsyzG4=;
 b=cJCeC4yOoRF6tzg1jl+jWWmsxoVa+mP5q+3l/3xRrgeS6ufN9WhGy13duUyyI5jd6T
 6GgXDIh+2P5pV+SlUm6790sRk6o1UF4YzGsk1V/a/4HgXq5V4qWYAB19vkIiNGH/vM0Q
 YMMCzQ/XDYmTugAxcJV46iXrJ7LSvyxfkJxaMY0Z5EcaF57K6DotHbYFhICgejaPdRXI
 2IHE575CgWiZgTgSuHfs046a45hamca36gu8pacNA+93PAiKB4TclNhxrRRlkvn2gjFW
 aSBDrcd5y+VJ8jarlgx+ckpyOO3ttZfxBMZFsiOLgNyxgsM9f73G5u5nz2EqDkk6n/20
 nAyA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775210662; x=1775815462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
 b=obLYgTGCwsOz/6izTFFzbu0MDtlDDbJHQb465nZGOqQQgRD7FKcUUyiRs93tD/peU4
 ADwmF8CRHak7LKtOZTaFN+ISZbuApwCM/Tab+EQAyssT0vFdfMfMGqPNCysQbBcobpIz
 3rFn4acbAa+eXsM/FvXlH5OA5IM8L/BGLUOfj8Zk3HeGEsAJISXqMNWZGg6gZmxkoZjZ
 7e4WBTmhme2yXz2rwsFAOxvw9i475yBYM7ew/JL2QBPTo/L0yDBGH6HWO62zwvOsRKrg
 pOfZBTXOXAsrVS64SwaWMJEvSAeWp1h+UEGsvhfM/SOjavR63Iv2eHH1ZKBbASQ9ksUQ
 HrBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775210662; x=1775815462;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Ub2qm2j/9wtMhk2YXDRQubiyelrtrH9hR7TQ8pFlUk=;
 b=kZXK8sd4Z+830g3ueoYnJAPkW3tb1gH1r7xCU/FbEaGXrPjgjAcN98CQXu3ufYgC9j
 0kV2etnCJEjd33QY0Tyw8kAAJ4s3gfv0DABNdCHlqyu5dvpoutd+tJI8PJyHKgsTZCNN
 5qEkzXXK9eZktF0SSSdErZ31/pYicnGkIwMo52pMumwTSyxqB4WifrufF8Z1xLTfFKKV
 CkNdE4hX1Ljnc1cD+rdx8GoJ0L0q+mpPouFTuf08Er3iglSN28ZpyenYe1UZ2EoNj1Fi
 WVgQRm5Zj90Bb0M8FibA6vqoXrgEPTVv4Y2Xcb3PtJGbKfbe9ew16whIV+DTPLIZfjDm
 4LIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWycunAqvm50YcYhKZRLACx9cySrBCKEtj6QsPymPdAJlMA7wc593CdN6wDhTL0Q20qExFy1Czyo5A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMyl5iwPDrpE73B2iocrGIEd9EvvzLx8Z+MffxGsArD151mT4B
 l6BqXyoZwNH4xIHQheCX+zuk8aFVFyeKq2qiftZxTaCdJ6JqqgMaEo0w1DltuSnSTExfI6Bf2Jf
 qTQdEtStC2uh+xJB7uwpW8WR/o7mbJ5A=
X-Gm-Gg: AeBDies09iQlHnHeeivQSLozCMeis9myOZAY/zFzW1iSfoYOfqjJP/srfLpFaQtVWqH
 X7z2zZLsMLEdeLQjRP422Ho98A+uexR9o0ImcRVP5SRX0MOOkZdeA1/yl5SDwkK5l52CxtRZHXK
 tpJOd3yZgqSkOymnmp4PuoZo79QlZdXjy1qQqpkXIsNOaIQ3reRNIcqUThM+VTPQ1PzfUtmlVnU
 26fVALOhSHBqNBqdw8u3nkVPTIf96EB+VMPNymOQD1qE8RBQb7wB1JQOvnUd+L5rK5MGDz+SViS
 Nru54gfDBaGQBts1yRDlFOqWYad0i9Or0D5boHpsEU05JQ2y5fHHVb6NIiFE+BvFHS3AB6QDbL2
 oZUf7RI/cDW6d9c1SmmyVANXzFniUDFcLyQ==
X-Received: by 2002:a05:7301:129a:b0:2c1:7ca:cec2 with SMTP id
 5a478bee46e88-2cbfce5068dmr491773eec.8.1775210662077; Fri, 03 Apr 2026
 03:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
In-Reply-To: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 3 Apr 2026 12:04:09 +0200
X-Gm-Features: AQROBzDGWGQe8LG7T9EapBc3mqC597eB6i8cF8SGIYhy3xFBCktFl3DRWuS1lDc
Message-ID: <CANiq72kZOtA27UuDZztLCAfR2rLeO=1a_ajAaza4idrC8AzDog@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Alice Ryhl <aliceryhl@google.com>
Cc: Stephen Boyd <sboyd@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
 Fu Wei <wefu@redhat.com>, 
 =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@kernel.org>, 
 Michal Wilczynski <m.wilczynski@samsung.com>,
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, linux-clk@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-pwm@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>
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

On Mon, Feb 23, 2026 at 11:08=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> =
wrote:
>
> The Clk type is thread-safe, so let's mark it as thread-safe in the type
> system. This lets us get rid of hacks in drivers.

Applied to `rust-next` -- thanks everyone!

(Given we heard nothing this week either)

Cheers,
Miguel
