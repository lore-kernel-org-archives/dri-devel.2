Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5632E9A769
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 10:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FCC810E59C;
	Tue, 24 Mar 2026 10:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="d3tCkcte";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2861810E59C
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 10:58:50 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so30584525e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 03:58:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774349929; cv=none;
 d=google.com; s=arc-20240605;
 b=J59El6Epv+Zzb185UJX0CJfL/e8Dzdncb7hFivqzdzJF8BbnXpcOBwmFqM4NwxRbTk
 4XA4vcwWaLDTKUwFaE3AyyrReNjeXP1dJ8r+Qa9Je3+rCV+7NXaz/NsHPu3YI3lhrSFG
 QzOTWw7y3mWGXDBLRO5f0hgTnj6fJeFEkplfvepRb1/WHABqeN2KZHiOOlt+3YjY7Gaz
 qyYjA+E/fxJmaGPVtbR1gUcI82a5yqGoAEea+BS1iYkSWziBhhl/yDzH/c7daBnodtPs
 l8ftUzxDlTE2zEbW5UAOz1L4y57Ysb7yOgGsl6mS84e3BKrXwIr2iOIOhlgkq/BxegWi
 9tDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KHpvLLQnm+0s2ip7c/TcjqSG8s4Eycqur8euWeGF39k=;
 fh=O/amFsa47HFxDR3pmHDzfGdrhdWepBZ8YDjB12UB5l0=;
 b=HDQswg8wQW6Nh4ea5E76ctGXUe0y5LGW3KWgH2nrtVdA/5QmCGevYkcvS6Qco/IbSO
 l8iNw7Cy7YYKH9TjlBKx2/mR0E6c4GCmMJUT36bCTNhhLRnzLm2xTtrj00n60a/xtTgK
 coj8GkYWWUs7x8nyP1HlcsPsqh1hy5uECLAniWtiCzYV4FdVpzZTHzUqdo8Fv4siCwMv
 suP6JA2iS0jdd/1tPTgKC1k8raAncbjariECtNY5bZOFSgpkgogEsbVedVNu67U/mr1p
 stK3Lfv5npiNgRirTS7t6/L8A7PdC9kc7vBU5+Sdd4ZU9OvOIQbfXewF0+2/nloo9W+c
 LW5Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1774349929; x=1774954729;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KHpvLLQnm+0s2ip7c/TcjqSG8s4Eycqur8euWeGF39k=;
 b=d3tCkcteL+2VezKZWVOIGuMMF2JOtAEmz/XVuFOc9iojC8uQhsYoP8krtrnI+DN+82
 U7MQmapwxChQsp1UkEwerHuhmraDQxxZF7NU/E/Essw/za8cSw/qMpYLaSd6++F9p0Di
 GzKQmBBHWuovwV7R8kCMmLlxdw2BxjWqEDoacXg87FqwmEmzSCVVo3wcoZwqwy/3UHZA
 Ax9eSd4aM3d6/+jOQYefIz8arX9k8yRX7uWaO7YWuk1b214TdR91Gmtvd0ilyKMdZtmG
 qfgvSH0rv1uH+Yy0/eUWqIRYeGcuerj4QVZPL6TyCkdCRZWwf4mTS+3GUn/5JJjyvnfh
 bCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774349929; x=1774954729;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KHpvLLQnm+0s2ip7c/TcjqSG8s4Eycqur8euWeGF39k=;
 b=BBBiWeVkEb5oDmeum6MX+Iau6oHo9X+/q//dz/FPOMgCHqRmb7FB2a8FpwPdoILo2u
 zBzOOghOe+ieWhRr8aUtdEFz/H7djU4Euz2MXhUAfkxR1rO5hi50kdeOxVE+Q3yR97aA
 fNuaKFHYf97/BQL7VEpCNt5VyoLidUrRtoYiEQPkIK98uJmbePw45/T5lOpUR75NULUi
 ZbYggyVJUu9Mpg6wMrLfLVLsU5X9dW4jvwXrFOfiyzDUDmYuiucwXvwwXRgu4cjKdonh
 3CumjiDeFKKoLVcOh7zyyfpri8mOr8B69fgfwEDUBJuHpFEC8q6+NfiRLUp+vRvs371c
 0cXA==
X-Gm-Message-State: AOJu0Yx3m31aNSkrgVz2zCYNOoIDp3CjF+N2jBgMRrmnD4swgZ+idxO9
 8CwkYDeIZE3Z4KCg6ZVJhkcna1vzr6U7ECk7e1IjMftE0zjFu7qhd5HL7S3dnfoqMiOEQb2zcd6
 tZ+XHEdVYCFvX8P59TIUIrjEPgeZQWQVqevIRrx7i
X-Gm-Gg: ATEYQzxS7UP5JkEilQj1Hrmc73PHBFDv6Jlc0nkwjzBhkE14dJ+kU3FRS8ZZIsOy7sm
 H/1oBdL6rGVgyRlKuhFyG7sGZqXk9z/Yuc+yPtbZb3JUijzTt7i89JNznYi/ScXeULa4yZ9NtzO
 w4aysY4Wv7H8EQMsmWLwoJTK09rkzCTl2Eap9HSmQSB7mP1z5g1o4kHbUt7E2I65w+TE1eAHlTy
 Y39wqmWekMVXQcTsY7y+p7RJFAYouQ2KaBRA3KtDzdTKI7Plt5oJArgQltSru15TsF0+EIa1duB
 Y+PpPB6+LQybOt6dOs2+8qAwjqYkgkjHGSyImA==
X-Received: by 2002:a05:600c:3b8c:b0:486:d76c:fa51 with SMTP id
 5b1f17b1804b1-486ff03ffa5mr209926245e9.27.1774349928185; Tue, 24 Mar 2026
 03:58:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
In-Reply-To: <20260323-b4-tyr-use-register-macro-v3-v3-0-a87daf9e4701@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 24 Mar 2026 11:58:36 +0100
X-Gm-Features: AQROBzChC9No4ct04k5xNIFBXW8QZ-WT2wc3OVyceKvhXpdZyi6NGTcj_kNJ-Vo
Message-ID: <CAH5fLghWAQOkH0bDw3vC5UZaCJyXaXn16D_2K8wWOraBcktg3A@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] drm/tyr: Use register! macro
To: Deborah Brouwer <deborah.brouwer@collabora.com>
Cc: dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 Boqun Feng <boqun@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Steven Price <steven.price@arm.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Dirk Behme <dirk.behme@gmail.com>, Alexandre Courbot <acourbot@nvidia.com>
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

On Tue, Mar 24, 2026 at 1:18=E2=80=AFAM Deborah Brouwer
<deborah.brouwer@collabora.com> wrote:
>
> This series changes the Tyr driver to use the kernel's register! macro
> for hardware register access, replacing manual bit manipulation and custo=
m
> register structures with a more type-safe and maintainable approach.

Please double check the AI review:
https://sashiko.dev/#/patchset/20260323-b4-tyr-use-register-macro-v3-v3-0-a=
87daf9e4701%40collabora.com

There are some concerns regarding clock cleanup on patch 3 that seem valid.

Alice
