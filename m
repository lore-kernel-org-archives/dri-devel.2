Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D711077608
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7228A10E439;
	Wed, 18 Mar 2026 18:57:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L0DTtRSj";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D3B910E439
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 18:57:23 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-12714f01940so25272c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:57:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860243; cv=none;
 d=google.com; s=arc-20240605;
 b=iH2FWzIlpC6UC8fCwjbNHLawSbYNgKvuKSKfbYx0AYsHj3K1fY3/0jSkUzBLrxJLeo
 yWodQ9uPxtuVOzsQf5c/+vScU6N9R4yygquE/uNILQchgXsXt79tP5Nbq37bgnE3F1lA
 Gk2/m8j4L5u1tVXuV/jKjh3fOT9nh7OYxhRl/I/c0fKentyL9AJcaj+Ir0lBDec3vlCN
 vN1hhUUHtxcQGiVM8M9qrkkA9f6Gf8n+hvvhjn62ZigOxiFIgA3gQ/fxAkoNTd3ApRaP
 CNK9nneVjGkv6HE56105zD3yKn6AWTRGQ0aKb1CyotuDP16dsBmLdgaTjtLbG8HgkkSa
 JJ0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 fh=vGC/WPFt1tAnSIcBFJDp47LTggzGVSUwPAID3KC4cyE=;
 b=NJ6+zTD8les3SLA2/Wu92m1tkNDLahC7ZmdP2Xet6sWOEKXAg7vN4h7QrP4YajDrGD
 WWH+CiROQd6h3QpMR2u5dJDxK8sAqzu7X2CvlB11BKQs6ya1KBZCWGz6pAM+k2CjFl4a
 LIcm6n9Y4w88b7GmatBuubpWk+CIRRN3HuSypAEEHHlGbOMynnxf2yG0z8Y7afPt/JeY
 ZVG2pNT97qHqyFbr32VvCxzabq3qH3Czpvne71tMofmcR+FQYQaopeR1a8rx5qBttco2
 wu6vkUquHh3b+rY/OtytoB7mj4j6e79ksExwB316vKi6GHP2kE7Uzf8aVj7oiMQg1/Hq
 EIAw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860243; x=1774465043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 b=L0DTtRSjD3P3foLZzcumBUqXBNdSjOrQZwtECp9tPcgS0q9LqHnvJaH7dj94Sxq/sr
 PUtC+N5h1uLnGRTOxod6NNqMaqXGx48v8gHJ2IQVnb8CjT9EBQ+KRLYMnqvtqn34seen
 V3g9URV6HjGebB3Tenn4M5DkDPl8vZDMYL4/1urXKbasaSZFknDwmg17N8CaIrosgceb
 +ZST64CeDqVD1cHP3sXqLhyS3XTCHF7iM7ihUMzKaostxn2QgSAQymx72ePvSrRaH77p
 UpGQrWPmWVLBKoGU2Zl5A8Bj9RwsUcOlWNLcrjVzHIrs/lKK/3JIh6PuVUmnX9SCaiEX
 sduA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860243; x=1774465043;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VupaCI1OwER3l7ohvi40E+Y56v6gbAu+x5/VVVtmeFc=;
 b=DhmMM77ICswd5gsym0nkPobqkrdMdKZsBroU7wpx5RoZcCk7O8o2vMU/xqmMI3ufuz
 PBN2VkY0aQ2AgfQOnqmVHKVQLqk5m385lWzrwdFfbsztP2VJnlyUtZCv7STde4pm+waW
 Kru3yWMf/S1HfrM0rVOhkik7ZqSFBCeckczZB0rfoOffZ5PEy5GtZ+lquphC1Ho6qnUs
 vHFXMkboBM89108egkr61LQQEW5B6xMmuH9FJ8qZdNYC/xkH2qiw3GENlUh9JIHFXoie
 68yiGWo4msy8IhuHJdE3GlJpjupAUIdRvV1SvAxzgR0h68b3rSuFd8um9GGo+x5ya2r2
 XrPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX4FZe5NNSc7wQ9AvxoLoH+j6+RLeyNZR6omlsWAbsxpcbqmOieO5gC/qYQlNTQrvSr7kgIDZkUII=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFzzVBTJUNiGvIkXphMy1mUQb4eKf55tv+1hbkxRTM9eBcwTDR
 7SLd8/xIH+Ce47AVMTi1XtoZq6RkMKJN8UoL3UctNSk6KzME/WAPzvKiZnsIL7Oy+uVxKJR+o33
 EfDZBkGYxNNcIWNfFC5MPQSMkMpsxu7A=
X-Gm-Gg: ATEYQzyt3sJDSUdFKaZht0ajOZhPfdolD65yK3qVqMKHjD5HkxegBSpMxDTs2WtYXl6
 xBbyPbu45dXCOfRx0rJ4R+jJVAStlLgqlPmvZs0LyjQEmDfNW7Q0RC4KdPhH+BgW69lFTameCV0
 rmTkaccMcEcc+dJJ2jXlzT7kka9619AQ8LextasH7sr0ir7zwt6aDcusg8fRdpaDeZmzktFExNj
 KGACABVS5fiSdG3rogmiWEzmB9LKHhAGGHEYOqDxGqUmkKIwz2mQD/5ArS9HZGFSZxupoWtTS1a
 bnQCUemxcvLc7v4sy0Wq6iR7Q8Xd1k94QS0l8CR2WSkCRYev0dpJYyO0sgzmM14lv/13HramDge
 zWbYDB66JF4e+N5ZRrA2LMrh7J0FRBpZXAg==
X-Received: by 2002:a05:7301:658a:b0:2bd:a3fa:9bdc with SMTP id
 5a478bee46e88-2c0e51afa4fmr1076751eec.5.1773860242532; Wed, 18 Mar 2026
 11:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
 <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
 <CANiq72nad-60tOJeAfkvHTFrWXQS_wbG4JUGQNnkjm_NvhhaYw@mail.gmail.com>
 <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
In-Reply-To: <DH5ZP3IUEWMD.TOOZSEUTLV85@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:08 +0100
X-Gm-Features: AaiRm53Z-cAG5mIpOPhPdv8BAXPHEZ1FbMlHxMtUEupEIZpM9NVL3ZvZ5w4-nno
Message-ID: <CANiq72ndoX123PKYr4DbJpvQaM=1YjYoYhoTq7wMoY51X7PuNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, linux-kernel@vger.kernel.org, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Koen Koning <koen.koning@linux.intel.com>, 
 Nikola Djukic <ndjukic@nvidia.com>, Philipp Stanner <phasta@kernel.org>, 
 Elle Rhumsaa <elle@weathered-steel.dev>, Jonathan Corbet <corbet@lwn.net>, 
 Alex Deucher <alexander.deucher@amd.com>,
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

On Wed, Mar 18, 2026 at 3:49=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> What do you mean with extra file?

Right, sorry -- I was probably overfocused on the `mod.rs` symlink for
some reason. We may have talked about generating them on the fly in
the past too, I don't recall anymore.

Let's assume "s/an extra file/extra lines" on my message... If folks
are OK writing manually them, or that we generate them on the fly,
then I am happy I can get the option I always liked! :P

We can chat about it in one of the calls.

Cheers,
Miguel
