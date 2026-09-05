Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B988C624DB
	for <dri-devel@archiver.kernel.org>; Sat,  5 Sep 2026 19:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2300810E32C;
	Sat,  5 Sep 2026 19:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iYyPbqup";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB6DA10E32C
 for <dri-devel@lists.freedesktop.org>; Sat,  5 Sep 2026 19:22:43 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-39666e7c9eeso117698a91.0
 for <dri-devel@lists.freedesktop.org>; Sat, 05 Sep 2026 12:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788636163; cv=none;
 d=google.com; s=arc-20260327;
 b=c0pPNMfH8TGlBAIY9i8Fnmxf8JBG4omRMHUxtSruaxOO7xYme3Z1r0NMqGU5WsTqWF
 WIffNnfaLfjG/hFJ0OvD/+iVcNcvxqc1cUKvLG7aRw23Y8p3IuQbI6uREYD4V2hwy5u7
 QiO7RHB+qQ2JhoVjuR/c0N2hd2g4WnORYBBD1E+u/W6vT5t0KrXh7X4uFhAmOk+iXMto
 ALHKjiJQpyGKR0kCYakcLiKvdd3yzAHnY/Ly0Ahy2+YKiugLmjT7evFsA3CBQxeejRSm
 mjxJ7SQMUytafeRPp6D6rcyczK/Xl/ThLrkqvLJ2DUKLLMA/0+ykgFmCL890SSQ+nGEU
 jJ1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
 fh=TMAy2h7MggMkI3rVxQyD0PQ+lUQc1OBLQ5dKjoDrFRk=;
 b=bBBZsV3+LusEsAzZUpL1lh7Pp9oalSOh299OWjSopdof3Kne+iZClpVYwI5aaiyvBB
 HSdcLvA+0GJ3rfJ5iGyPmTO6d4yO1zztXYQN3NEg8l7jweowJqf959zDRB2/ZqQ6ETbk
 foPAtojNMpCKZ6tOnxn1vCwYf6D+Yl1ZfKtNu0353fFuIK2dWxIJ+McVqxogUz8UiYem
 fQyTZYdppFl4zOiU4wy6sbvDPi5EJkD/3UrYeyOwZISMUJEHWt/mlH6RuzSJa51LOM0K
 18M2wmiTwigU8HNpKP397bHezj7J6UT6dmXSkrIxUwTJzgUJD+qD2JC1CoBeN+QEfogf
 4kUA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788636163; x=1789240963; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
 b=iYyPbqup9XSCXCmLuzMX9UFjWQaj+XxI+BBTFnWZk2N7T5U6ZQHNfrrmkq1ahfMLsD
 BU2DQWTa66VB7sq5n68irnxrSZULGxC2VPRNl4hTEH23VHqp6a+ty/YL2wz6B4RW/+7h
 QH2aJAOEgyR+pGYIbOpO+b6wCliU+jfpbKz4vrzPuJhO2s3RQQxkegDRMAtrNSQHlbnX
 u3STyxPImFwUl+ubMkCUiz+pC4weU9/WCpaRn5bzmRH2CwFEIlDWTLS9w31sqf+pIfWY
 VEops4mCzmp6nMyCsQY4e3mUH+QJFqvckjzjELNX437PThn8QmTlH/FNvaLp5WeQkl4V
 uh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788636163; x=1789240963;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=F0hp8ol4MVmew9w5JiuEvACCnB101tW8NVpWQVhjcY4=;
 b=n91HikT1yHbQgqQ38vSW9NuM0vDlXyLGoJPhqVwSeojvjeNBTGuMBeAYlAVjTt3hWJ
 wEnseTOLH1By1oiGmW20VgVnqMukvsqXUXz+xNUPP04/t5OtfZVDJemMXOMLpVywvuMq
 FqpphQCFs1slRbdUu6GPZm6tY+9CbhW1f2h/SenDadDq3nZaakelzxOuvUazVFTugVD+
 LymZEIBzrxU0tG/5F9wvLUitduWfb+rHxf6F1xOX/yNf5JdSQHg6SFD2C0kjUzEoOCRu
 qY5VLA74J6YuaUvK8JkghfqcIWL1QkKzOHjWfuO0eW7JM0z9Xfdfk3ECfYkfUb1cmQNv
 nGfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzx4QIAAhZLiwRUzkfbJjgmNighMOlmwwlC0XKOF4yP2Wvwr1fua8hl/9vRfouQgIN4Y4dL+IQKdQ0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lhQT38deR8vsHrFZpdRhV0lUmX78cGfHs1GEK2i3DJIk/YNJV2
 dv4UFo024H2IobH3ozUUQMKmwFQgEgELan23JhrmASym0s2X3q0nByr8oam7Uk0fgTvXs7t2TxX
 BIVsYFnG0Sm3aAMed+UpHWjKY4ozF3fY=
X-Gm-Gg: AYBFou1IrlL5jJrwGgTFz9QsyY2REePz4e4y3oV0aFmOiGoQ/IrMWdXMlgeJwS37BZ3
 f8Clpcz+z+3c9RzQo1CNuMHxbtWbSvhULuQ8ORjobAruDzvyw1RipqmRPV/NFo5PinV07ndKibr
 BGJ6XTd3vc16DKreEohqhpnbYNLXi6K1+srczyPIJ6CEezpEprIY9cKwka3UoQCV2Bt5+r3OEJw
 ESTzGcehJ0pY00Z+G5kbsbjLzLzgUP0a0h/y/h9UkRWC3Nu4BIsu0rHxR+ekUOiztLcdhQb9yCA
 t9/S+jqyax7uoA5qZsse6tnEDWEs6+1GU8bQhPe8a7k2Tf49+y4oPKajIFa0iKwd19KZz2sYIVe
 jdf/WrBPnBI48NgR0nM44eO4NOadQghgQtAxKAwe3xfTksSs7RfrtuYcQUFcd
X-Received: by 2002:a17:90b:384d:b0:398:bac0:238e with SMTP id
 98e67ed59e1d1-39b3d8377camr7470429a91.6.1788636163260; Sat, 05 Sep 2026
 12:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260901-typed_register-v4-0-5552b1d59525@garyguo.net>
 <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
In-Reply-To: <20260901-typed_register-v4-3-5552b1d59525@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 5 Sep 2026 21:22:30 +0200
X-Gm-Features: AcwNN1XYNGZeZdAbyqW_MpHHmRnUCoTfhvfgQ1L93n760L7NneO9Fvtxk2YGC7Q
Message-ID: <CANiq72nxtehkGdb9RZpd=MsjWzp9euoLw=MmCzvcqOgxxEwymg@mail.gmail.com>
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

On Tue, Sep 1, 2026 at 6:50=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> +    /// Convert from `Self` to [`Self::Repr`].

I think [`Self`] etc. work too.

> +/// - [`Self`] must be [transmutable] from [`Self::Repr`].

We say "can" in the `AsRepr` one -- we should be consistent.

> +// SAFETY: `bool` has the same size and alignment as `u8`, and Rust guar=
antees that `bool` has
> +// only two valid bit patterns: 0 (false) and 1 (true). Thus `bool` can =
be transmuted to `u8`.

`false`, `true`

> +        // SAFETY: $unsigned has the same size and alignment with itself=
, and is transmutable to

`$unsigned` (a few below).

Cheers,
Miguel
