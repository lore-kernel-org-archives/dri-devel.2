Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18575CD8C88
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 14:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41AAE10EA79;
	Sun,  7 Jun 2026 14:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U0xqEVeU";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E77F010EA79
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 14:50:39 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-304eb0fc233so280041eec.3
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 07:50:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780843839; cv=none;
 d=google.com; s=arc-20240605;
 b=ZT67drudQ9IeFZe2gJNpkOGHUCGKojA9WJPa/16/Lb/xTuznBO9PALZPrRTy6mNN6B
 DKrBeSygLqvqFpOy0t5QbNmUMvlc25TAhmqQ1qUVzPL70GsjJ7xrHfowUYSgrutW+VNl
 b0Lw7HBwtvOWT1B5kZRI4OyUWSCy61z4PkB/sOYYBjO2U2+rLr7TBrI6j44+rTvwdjGE
 8YhpsuLUGX7SYMBbW1bovhoXULnQMKATLgYjU8PI0RuwCgIKud/XveTEthj4+iR9fZY+
 k258100hLxdzX6+g+cr4/n8HraxDSvb8Z41h2/IyklfxiX/QER2n9n6WlM0RxargCJwK
 CEyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KeOkw3p+smUt9mDbUXijVkwoFTCqBK/LvWOrl4P+Zo4=;
 fh=uB1cf6ah3zFvbXP33fM8JGnRTZeSo1A3Kzr7M4LvDIA=;
 b=YlGG0OX2W7NggWcyfC/nqN/w5KxQh8CVKHgCTC3eEgaLlCo8Bq10onf9GFrmZY3DCU
 kYgVUWdPOizZo+rh9KIy5qb+M19W/oCw9jpbmjwVlxRs7ldqVtnDrgVga4QYG310E+vB
 o9DiQM9xq2P2YpQi/NpkYxtWJ3GG4oi1kEnauM6Dbhbn3WNLPs9oledVFxrtqb2iOVd4
 mS7Q3CYMha11HfomBmMi0VbhXc5quZHeG+4dnuTC7KoLzZNy0PB+1h5PRKwSC4fv3Cke
 AKHQV6RiLaJjft+ugXCXJDnsRWo+3QAp6dfIQBv67stmVeENsMPJUkv/WkjAmqVmI/Ww
 6z8Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780843839; x=1781448639; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KeOkw3p+smUt9mDbUXijVkwoFTCqBK/LvWOrl4P+Zo4=;
 b=U0xqEVeUnlH1OXz/AKAGbQ8DLAPySFBexhdxsJZ03A5vO4i09XSzamIrttWTcYu9+3
 NPQ/BUpwQPdqNKXqgQpZOf89Oxo8sW/YN3SQUsvIj93+SyxkmM9Xr85/RSVHKQgG6sKp
 SUmEuG7QD3fDaZDzEPVRjVpDJS9/2VK5gycdTazhGAH2hJTcijT6aG17n6jyhQaewVuG
 2Vj8xNjxzJNmoeC4xeD8HjO7jvr89FklwdlEheuoU0R6e/jDnhzf8GG6goR5t3JIpBsa
 k2rIn34e1cr5SQLrxj1iwhwXqMubLiK/CEnu3kk9McJ0CM881YsM1jZ5dbE7REaswx05
 mcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780843839; x=1781448639;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KeOkw3p+smUt9mDbUXijVkwoFTCqBK/LvWOrl4P+Zo4=;
 b=mUb5ZYsznHNty1NvQGtx9GKGCJpiZn0TFIndV3LRxolLfNvVEK7Zqey0Bb1GZW0OYi
 LaAz6m7xuyUX7pgkO1+AtH3+dCGEW0h/8wBgocdwkDjowjNh9TewwL75ROZQh0sVCa8N
 O+CfTDc53bl7/gSgOiv0T4FrZcGHWuBZ2DCjq5G132lqWqeuvb8dbSLJfTuCNTF+Ep4f
 JAGyJ535aJsDZGbv1ngmIjt9vsh7ZivaYpCpzDs3IbNgSs141qofaFdzlHw5N7lV5Vay
 GtHarOWgUQee4FbTcvYUn0WN600lmEKO50H2CHHHiid5kSrsYg0fB2rDoEB2Qzxmdic4
 My2g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wMVBq7rkpbMimzvkhPPFNI38XpSPUfxQgPHQbAfbTUtaK5JP0Btex2wg7BLSs4AZXQYFb8A9vSVU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx5atOir8rjxSz156pTs7cqxxe/Mv9vph7auW5k+sfqG7ZXMQ7F
 BZDPHKwuUA90YsonJi6yTsoRaBPQHpyRMYRAC3e7IdnsUrM1+WFPF4Bs/g0MDcNPJ36Ai9WZ2od
 V9DLlaztpWG9mNK+Jv5G9BxxakYg1v+I=
X-Gm-Gg: Acq92OF/1bUxy82NKBCLycfMRsoZ1nlkpOpO8T9O93yehvwbAariFYm1O91UkPBJSO8
 aWkRFxqVWX9y4HEtV9d+2DQ5h+3LjChX1X3GYwfSvHapcWi+anYCDC6k3SNld4x3G8tNaSxtU7b
 kXpJyyAbZMWIEAHmua57Pw6T45i92MCpikWK2r804pKVIgnwNYvfaBIgHw0cf/v4KpnJRgd+ftG
 LhPnnfzmZ9MzHsTt70c35gn8lqBHD9tJKgkRnWvEX0wK4Y3KPHbGetS7AfdFTDY/bcl2dUAE3YZ
 /a4bht68B1PRqSqaPqKlRis1DYPKAj1J8nNsCQGAqMnjREZwPd1YthOP4uG6ZSefqxfjhy9g+rS
 gXyvNXRqm0eo8KPYlop2cTF5vAa+54a+Mdg==
X-Received: by 2002:a05:7300:5723:b0:2ea:5057:a320 with SMTP id
 5a478bee46e88-3077af4a612mr3072058eec.2.1780843838713; Sun, 07 Jun 2026
 07:50:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260604192740.659240-1-lyude@redhat.com>
 <DJ2G8D0N6EK7.2PDDSC28O8K4P@nvidia.com>
 <DJ2T75A5H6Y2.ISIBOQVMAO4I@garyguo.net>
In-Reply-To: <DJ2T75A5H6Y2.ISIBOQVMAO4I@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 7 Jun 2026 16:50:26 +0200
X-Gm-Features: AVVi8CeFi5djIGvrvuLFIe0ggcr2ckGO7PwhkagBDt7mLNkIJPuv5Gv_nWehfL0
Message-ID: <CANiq72=qKckJXFJU6TDKf1yh3a2wBS4SQE9fiGKpVOYWYtL8QA@mail.gmail.com>
Subject: Re: [PATCH v18 0/4] Rust bindings for gem shmem
To: Gary Guo <gary@garyguo.net>
Cc: Alexandre Courbot <acourbot@nvidia.com>, Lyude Paul <lyude@redhat.com>, 
 Miguel Ojeda <ojeda@kernel.org>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 driver-core@lists.linux.dev, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Alice Ryhl <aliceryhl@google.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-kernel@vger.kernel.org, 
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 linaro-mm-sig@lists.linaro.org, Danilo Krummrich <dakr@kernel.org>, 
 Mukesh Kumar Chaurasiya <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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

On Sun, Jun 7, 2026 at 2:17=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> IMO we really shouldn't use Clippy to generate code. We spent too much ef=
fort in
> fixing codegen issues that are only present when driven by clippy.
>
> We should just run a check phase with clippy to get the lints only, and t=
hen use
> rustc to generate actual code.

Yeah, given the trouble it is giving, I think that will probably be a
better approach medium term. I don't love it, because the original
idea was to avoid such an extra phase, but it is definitely better vs.
random source code changes...

We could also increase the symbol size-related variables
(`KSYM_NAME_LEN`, `SZ` in `modpost`...) only for Clippy builds to a
ludicrous value. The extra phase approach would avoid surprises more
generally though, so I like it in that sense, and has the implicit
advantage of avoiding someone using a Clippy kernel in production by
mistake.

Ok, I can take a look at that. For now, I will pick the other patch.

Cheers,
Miguel
