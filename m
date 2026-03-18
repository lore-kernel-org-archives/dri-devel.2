Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50E5D103E187
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:04:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDC2210E04B;
	Wed, 18 Mar 2026 14:04:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SP3day0O";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9964410E04B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:03:59 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1273c690e5bso416159c88.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:03:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773842639; cv=none;
 d=google.com; s=arc-20240605;
 b=hB3YeAjlP5kVY+/etujn90WUEifeKouYBH8D/lod80yFe+j/vU1D6OwSpoox5NEHcl
 e32wNZ6ZuzdbE5oEg6SmTtLfEgB2Z34famjXY2q0gt3Qur7wfhTdZBiGy1PIGtcc9vUr
 nYo93cLmPE+sR+weYmJtoaXjy423UjrOVTwkjRAe08VZ0nucZLK0hVtx7gnfX+yrUQAq
 bURB2uSvqHKdMaOliuzCDVwR+juXAMUBUSTnMHNns5USq3e4EHydW1/ALfA2Kgd9aav1
 ZG3Johd8zkx2jttKW3yNnhvBbb06IOLvedX3iDj8kqVd6iHWMqhYmzXGNUJeJAG3oH9R
 /WPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 fh=66fREoh3GsvwO6DfBnebrGy51XOYaD5Sn1LtqQ+yIj0=;
 b=a0K/0QpTBcCONIpjDdQHq21rRyMv0JegKQi48AsQFWtgOSIxDKmxxiO6rH4+ZRpQWt
 FOrKw0Zm7sbznpszOwoEHHmnsghPe3xB028z7wV+u0fmdR7Gh17kAgiKvlsDydzAaflx
 /dJi182sCFtvLHhvW4raug43LbiU47tg7C8CW5+6fgUW0ShN27Vf48T8nxDuV9tFpOpV
 k1D0UZuuBjbYBfWdH9Dd9PwHUuYT9O2vPySjiZ7gy0Mh/F76DbzyXCi8jv8GFrxHjHka
 C1kLJuNOTpp8jEh8Hf8+u/KGKcStN2RDM7yXWGn1MeZw52uCx/L3Sn+TQEfc1GurcTzA
 F5jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773842639; x=1774447439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 b=SP3day0Oj1/DjmRsdSyPMUjcp7kcdrq1r2LXRBcppvHqjaVbg2DfE3Tt2aO9sP+SCL
 FlumoOqH/KiCk+ke+0A+w6l4K+3rQA929h8DWAlc98BtNpAYgAM5ST6OUNaoZMfq3apA
 trVFMVqhsG6ESM3trF/LoKrJ1/QvbpZqLyM6iG6yLu4oSWMJnwadH7ovP3j6n7oDDf49
 YDFX1qOuZNNu8rCyHXzZ7857+F1qSq6KrjnCp9mHCnXNjnLWMoK7WT2TN1eg9UpToaiK
 iZosSFEBYX/VOD5d0F++HRFKCfCqz8wGlL8opS1K+hQsXqLQ9HvqwlLUV5JfyihExxX5
 IEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773842639; x=1774447439;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k/U8OvDUcJJhqeuFuNoQEHJ2yWsVYBLtuE+GiuKyXfU=;
 b=j3bdbmL81dDrcOGORBGcZcz3RrlCifTIEQ7UOb0yWBBNvijXEy9hAf12Muzir9tyqY
 sWQlDgULs+YHPx7cSNWi57GQ/aIbmSBoxFgOQ3OEN7Wo0iifx9hDnLN/MUmmUW3bWLAH
 ShqVjMMxrDsgAWYhq+IMtvhnFkpMw5K0glBDAJsbaRwJ906Bz/zdeV1lCdj/VjJyTVFF
 gRAhqyxX5Dap0/36wKvdPqHDSJV5GkUvYLDmlgxnWou8u2mqT/mVWcPzTb0i4vftHcGB
 g90D/Vc0Qi51vurs5Uux8J+jiFgNAh+Gb/Q/FBTFmJ2KFyBdL24b4KuMzjRXKWQZ8wnf
 DD5g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXbCpz6OCqEbEhLGFKh+CIQTLyBEyiUt4OoNzc+Gwz7pAvISBeGS/v4mMCwtU91j/XpbUmRRjCgHU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd2qu+uFv9l+VvYQXhxgjjHTO8OqumSgtm+V0HEgPSspSUTu5w
 DBLcm0Lf+EwpuUHE0+Yja8wdzQhlIScO/qP0Df1KYDBkUWnYwQoF/thMqTb3wcQxdlAyZqBiJLS
 yRSYTrq+wiaOGFUZzYL/RHidOgGJm6JU=
X-Gm-Gg: ATEYQzzpoj2e8oUc9r9BBLN6kPG4r+Qc3of1pytBPYtMzhQrI1qw2r37A+ODbeRzceI
 /mxpG7Nx3yICptu5WSQ/LJnSEJq+21m8+68sAnZUr4r9EoKMCm8pId/AKZagmk1I28sOEm9kCI5
 Y/oiT+3C116s9mccoWd58XTDDgkxzAhPNGIqWVtEeLbnIE7FgNR70IL3IFljlDEDVnEgyLGX0zt
 MAG2oLKdalcqER96Tfvt1FdS8gloSpwlnsnLa6q3pyHJhWVy1ftAfk5gejVM/tFrzw2yYfpHLpV
 0xLQ5wi5FAgNlQlr0Rekt4HcSsycQ0m/cVb1jErgxr9jr3dnlfYZDybWiTCvmA03KmFJNAF0FxU
 ooNRDC4w3803XvcP0OxsRi/I=
X-Received: by 2002:a05:7301:1e92:b0:2bd:d8e6:90a0 with SMTP id
 5a478bee46e88-2c0e5071063mr859030eec.3.1773842638629; Wed, 18 Mar 2026
 07:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
In-Reply-To: <abqdUBqchnVFo7Qk@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:03:46 +0100
X-Gm-Features: AaiRm52jPRFXXf03k9diVYR0ZGnNxGkoAlPwk0mwDAEpyLjxWwYifunzB4OTgFU
Message-ID: <CANiq72koBNCeXFh7uX5GHRJoAu7fyhttDHHN0WZzx9Q74F=mWg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alice Ryhl <aliceryhl@google.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@redhat.com>,
 David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Alexandre Courbot <acourbot@nvidia.com>, 
 Philipp Stanner <phasta@kernel.org>, Elle Rhumsaa <elle@weathered-steel.dev>, 
 Jonathan Corbet <corbet@lwn.net>, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Helge Deller <deller@gmx.de>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Edwin Peer <epeer@nvidia.com>, 
 Andrea Righi <arighi@nvidia.com>, Andy Ritger <aritger@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Balbir Singh <balbirs@nvidia.com>, alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
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

On Wed, Mar 18, 2026 at 1:40=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> My build triggers this warning:

I reported that in the previous version -- Joel, you said you used the
workaround I mentioned, but I don't see it here.

Did you decide otherwise and retested and you couldn't reproduce it?

It is fine either way -- I am asking because if we decide to keep and
use that "fake `unsafe` block" pattern, then I should create the issue
to ask Clippy to support it.

Thanks!

Cheers,
Miguel
