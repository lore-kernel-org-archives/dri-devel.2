Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A2E1094478
	for <dri-devel@archiver.kernel.org>; Sat, 21 Mar 2026 15:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B594710E1BD;
	Sat, 21 Mar 2026 15:03:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OP4r7SvE";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C88F210E1BD
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 15:03:41 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-127148c2112so291797c88.3
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Mar 2026 08:03:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774105421; cv=none;
 d=google.com; s=arc-20240605;
 b=OybzBiUm7nZXEpOY4GyMMoH0uQ0SPu60VCf8Hin2wqbW22BPSrUsNvyntJe2ePLbfw
 TfJJ+1qYHG4Av3l4GMVSYjV7OjGqgj2MIV/MibFJgASE8e1gIy+x2YyYxYDs1UeTZCGi
 m37feGc+dBbf9dAe8lGtxBkmjSlNVoozQZs8AUeevRgr0dsPYw557ExIuqONiPeOLOh7
 aS7rcC5GT+QDxSrwAKYEevU5zJv6ChhJLe9hfYfxLH/3v8ZlTvKAx7l45mvvzQ4b8TOi
 viNDdYgXgcmylMGyVKF4hcDtJlnpG92b10GJgmay9i8JGlOCtYq1/AxLkiiDmJCn6kcL
 SCuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
 fh=eg4bFzcg6NcrMM9rvR2jNbbIDZtZTmB8YWjd1MrTgGo=;
 b=WSsDHvHQlrYsGs+CzrmYKRwk3VFIrOeDlaICNV2M/LCOteTrzDHJAaMrFx/4Xc3O4I
 PEfMj0F0onlB56a9+nX0QCoaTFTzpuYhnnZbyw0tny9HnUrGOfik8T5nIR5fagEBxtIM
 LSMTEArNvbrSfqASoXS59fDdF5GsZCswApFbdwfePa/KNEjyPJZGbD+rzh5Ts9rFkBby
 Q3nMoKt6ZAJbzQ+dauvtK4Mdpm9JVfwkGZvEDrd5lYX5RO4Kh2AaTSOHdz0uw/gwygdm
 +plu9czLvg1mP4eX8IC0AsYKH0y5jvs4cwVLe9vV2s9n6U/XXzsI5xd61xiqjUc9F+Up
 KyMQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774105421; x=1774710221; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
 b=OP4r7SvE6OIZqNHUEoHcJct8j9khXR2elC9ZT31hA6fae98ke4x+YJsw7szqUxhHzv
 4CqRJ5HjCz+vPS8VA5g26fyZTtrb8wPsLkdDWCAzNFY6kjCgDfCGl60LGqGvDLNxX2mQ
 KXeV9VttYGLwYpZjUEtCMSq9R4WQBi0b8OUn0WDDiKY5+JL/GbwSZ/lh8HTHh33Qt1wf
 is2u+INHEWbn5mifSHlAkOC7L2TkpIiu4OtJ1MX9TGsKlX0Xt1EpKCvX98NwGqGcy0Hj
 LzGHXSfO5YiyVbZ5PEYMsZijwOUqKqzBBN6RPJEu8/dRJ01r6zDQU8+VHIVu/9tph7Ud
 mCvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774105421; x=1774710221;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ucO0y1q7MG/iWCmErUhGurBrhiHi/90k+hcQ7EeukC0=;
 b=Zn1wV3SrUmy6N2EjKsnx4UClGM0zfg/md90iEimBAMiF/5vIh7gdbZdMB3v716rzEw
 lmvZyqsayBF69T+JqR3VP+4c+LhQEV40AIfZ4OIKxx2zIQjL8G/HHs+JG6eCwc7QgsvJ
 KoYOfXIXoITEcvvYW/mJNNj375TIM90YNF4FEPEwuej8xb7f14cqUsNG9iODH18D3jyd
 EIiEt+ksDIhz0uTDoBLID70L4uy0EQMtQr42uFSlkoNstA5/kWF4FFDomQtfzH4WV3j8
 X8Y7rjwmsHcdXGdsfAgSv3Cgf/RskKE8iKLNOGww/mbXx0YHkowAdJc0VmzM8zcXXqqb
 qOQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrf4ng7YuRbXp7bM7XlrcEqIpMH3ljGa+QCpZISTIuiQk7mYwRGpxG5qhXINC9gkcE7ImAkK+O9Wo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxSjnfrNm4jqsnyyriJGa+bonOec9n2RLhKCL2S01OZlIsTXj19
 yfvrvQj1DrDRBv6aOL9pn4wTuh6Svu4u4FcGqFBtWuTP2xNwtn2F1y0pCMa/AmxVCUM5myyIlwv
 1eqJhcNLUDwKmzT8p4UDR1/A+lmh30fE=
X-Gm-Gg: ATEYQzzeugg1nHDxmiaLqlupWKXao2iGnt40T4THsVeSSn1XF0ml9FGkrx3vuwutwy5
 meQ5XaCBQO2Np/wAAKEqJA28BWbcD0BRVtpVdgl8EKtr7lZcUtgp2LLNhVM15f04Y27npx8WMnN
 B52kY5p9iJEgGB0h4NuUky7f+qlus+3DzhXAqZphaaM84m8mNQaI3loTLyV6amw2JOY2rjdmmt5
 VF7tOirOs15PxxVDP/XNpSCzSJ5eIwUo6PH6LK9ovprqfZcAiD/DvWd65wK+jVIqlaSz8pL0pVu
 4k46bv58J5xYnqQAh1ULvmaKNyODARQRZ05/Fm5J37OLEfLcUZaDAsj6B4pHXS5gX5Uj7JJa8Az
 qnkf/WS1O0I3QJMaXOfYLAvc=
X-Received: by 2002:a05:7022:792:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-12a726513cfmr1588676c88.2.1774105420874; Sat, 21 Mar 2026
 08:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260223-clk-send-sync-v5-0-181bf2f35652@google.com>
 <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
In-Reply-To: <DH7L09UFWGTK.2MT0OTWH1DUV4@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 21 Mar 2026 16:03:28 +0100
X-Gm-Features: AaiRm52lxzUk0_iCcIFX3-uHQqZ_28CgqK_qR7We3jIMceDCHvhnu1d2ud_6c3s
Message-ID: <CANiq72mqpGk9DAjkt+Ohhw9K2xQChKtUQXPM8iucfokbYT_uTg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Implement Send and Sync for clk
To: Danilo Krummrich <dakr@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
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

On Fri, Mar 20, 2026 at 12:43=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Alice has resent this over the past three cycles, but it hasn't been pick=
ed up
> yet. Please let me know if there are any concerns -- otherwise, I plan to=
 take
> it through the drm-rust tree in a few days.

+1, it will keep accumulating changes otherwise. Alice asked me about
this one too; I can pick it up if needed too.

Cheers,
Miguel
