Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5353FC79F85
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 00:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85DFC10E1CE;
	Sun,  6 Sep 2026 00:01:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rrB6YTdh";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E76F10E1CE
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 00:01:45 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396672b2566so298689a91.2
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 17:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788652905; cv=none;
 d=google.com; s=arc-20260327;
 b=KNX6ZBgL4hSAglPPfQZ15O10Cca79T4xuN2SRCTldUzeEryEnkHq2Bg4cbb43uSr5y
 sVDnQ15Buh0IM5XUzj0Re+p0CAUMpzda/LMEQDWvUyb+u38KDdHyxVVfSdTuJJHo9aHS
 x3yXPS4QVDQzIUdlMCO5x417ePVzgZRJVFqI5xt6vgVym3OetePshrimkt5VZMVpQW7H
 r8cGcYA79TxIjCSIxIXd9bgwjiLf/qwHcRSw5RNwBELNpsQ47lA31i+tvbMC2NIJpD9I
 teILFVFCeqdzPqul2JndsLxEqpOTAQhYheZmFZRcT6xaayc3/G/hY93CarSqywDczsrB
 9mZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
 fh=hWbI3aMkPjE0pGmvgfYO6RgIJUlLWh1gVwDd8i25pjU=;
 b=DcswBH6gPimOz/GyY/272CypwukpwLQmNh19jlCeE3wzGAG5b8q1gcN3OYsj84wQlQ
 2BVoPF50I5SqKz2GYJJ74iavjwP5kb5D/EVGSM8sTrqwtwHEtQ+0f3QKQ/URi4cAp2Z0
 l7yhyxgBZho4RdJdi3phIFgES+XoLZ/b8LT6K2bUOE7jvAEg8jtJyr9/z6sCkcPwfamS
 OhhVI4sq/HJYvxgWM5CHU6xnLkqzKyyKfadj3tQ7PHtS5mM/hi63NorH/imQTThgGbbq
 cFn5rX1q0Ndn959ubV7/64JkYwGbI5X/3P9QYej5JvuraW7QEe4oVtWW1VqKB9mONsU7
 wEqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788652905; x=1789257705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
 b=rrB6YTdhR96W1SIrCyQSTvpG0uSJz0g61W1qrWLesj9cKM+7vcpQKf0W2Vxo/gulDY
 8S3Q+RccraabDLGEV1PdhMRb4pyG/LQDSHWsx6Y0LOwdxD6MqeadKbA7lv8YdNtqydw4
 pov5F18ru6IsyTveXz7lEyh8/9Th4zwLuaLtkjOTQHVtHSe1RIBs8EK8fKyjWiP6yQ2M
 8rM8NXvWAhwlJ6Xw5N3UBhNfn6dIOBtYhrxbOpNCDzBmJ1WzMV9L13L5lbyyH9yE2AQY
 lutx9VNTrfvmEeTdRTKkJlffmTjQqAsBXjdLEQpTtwCOQZpNs38rGuxADP3JEVE8IYCV
 6tsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788652905; x=1789257705;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2MqN60FsZvPdTZbJyxVZaz/7XO+slkluE367ZcdhXfk=;
 b=H7Z1ySb9vlLg6RjIBx57iA1QGHozhA1hoJD+p55qbgBXuRWjzqc2ZI476ZiWp1vCxP
 efo1NGW8/775gDy2bgfgSvcqnPeAug+mEg63JwWNlSwKSd5GX/igdy1c9xsK2XisoiU+
 j7DbL2uLpdiXDcqqguJ00GJ28w3w5Mi8bGfSf8WHnMd/xRrI9BIaHSaZN/A2QeDD+Gtu
 YrPmEsxrop0Wl4WdxiWRnTcz7PTxhPwfJCqn7Bo9AJf1dVxbfUepMF3I+/Y9OzY8yoCs
 NyU2ENdHfhuoySJXH6k488CYgcDtwBI5ZunR0QwtKD09UJieN0EOSi/CkvfUjWnjgHll
 9jMg==
X-Forwarded-Encrypted: i=1;
 AKwUvByvKsYLdQpZ+9elxh7q5To4A181rlP8wiAYS21Z7LRlbFULvf6rWgyFy37sehLhNME5IUcfXhCDiQc=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kW0hXcg6cXJlX6keSby4RmwaALBQ+uhuZ5rmhyorL2y7zN2h/h
 wzLx2UkYBM+L6B1vUKbOChyKs6ydcinbrLekIq1sCJZkuxGFYQH0fHQAfff0NzNLRcL5OzdYg+c
 fHFR/gWpYKd3kvJhyQRViL4z/WxNG77A=
X-Gm-Gg: AYBFou3FWqdcF0ON01D8kX08h9AuN/dSzDgDVKKGn2/kz2mNgCxzbpIZLmA/8lqNVzc
 x02xjAEpMKVnrF+M/jTCBBSuVQwAJR91FJSGxtLdCygD66P/xQfytUuwQnNpqnPMFt1yjiYO57m
 zchZO3qwIDT2PWFbMAWyUPBptOm+G/2L9ye4dRR5eJh2pll8uUyMvk0ftK+CVfbJ2rVETucqqgq
 xpdhyGkHsqSS/QJjqOy2QfgkDYQ4SdihwMFatq6dbA1cfESFyGhkJLBX4JioOExEJf5bjfHbm7M
 JTsGqYKqo2lcN2rAcYJ3BLlK3Mcqc4pZa3byKWwETKWbqoUD5ahECOqrhrAd05pVKzL9tggqIq5
 FnsW1M4Q6DlZRpyMzfL/KOszx0HnFx/aO1Zq1Uuu2wlZirjV7a0Sx7BsGudDH
X-Received: by 2002:a17:90b:3907:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39b3d8a3d1cmr7786501a91.6.1788652904655; Sat, 05 Sep 2026
 17:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
 <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
 <DL7RX130417U.10PL9U4D6JU9L@garyguo.net>
In-Reply-To: <DL7RX130417U.10PL9U4D6JU9L@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 6 Sep 2026 02:01:31 +0200
X-Gm-Features: AcwNN1XKuKFBV9qEAm_z4sB5Fo2qHcAE7av8dqRfbpy9oR-6X3rQ---1a2fINJY
Message-ID: <CANiq72n2B=7TXtmtQXEC-VZQNZ6NQTkPsxnnNCiWWYb=U4TyZQ@mail.gmail.com>
Subject: Re: [PATCH v4 03/16] rust: mem: add `AsRepr` and `AsReprMut`
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 driver-core@lists.linux.dev, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org
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

On Sun, Sep 6, 2026 at 1:32=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> I'm not sure why we'd want a self link.

It is to follow the guideline about using intra-doc links on things
that can be, which prevents mistakes and improves consistency, and in
this case, for huge traits, it may help readers of the trait
implementations section a bit.

Cheers,
Miguel
