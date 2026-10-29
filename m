Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50781606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BhRY32Y6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B4A10E533;
	Thu, 29 Oct 2026 15:36:58 +0000 (UTC)
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B5A10E533
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:36:52 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e1291432aso1725409f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793288210; x=1793893010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D6UUa2xNPRVirPhujwvkv6IdDdVKe4P8N23+MP1pK9Y=;
 b=BhRY32Y6A9bVwtj5eVb34uEyy6gGXHOmKAr0q3GePEAZRmnz3HKijMaMaOJ810KrDc
 +lmWj462TE2bGpx2jjm9/lmKii+spCvZBLh2Dxn5kC0eoY3DtnY/ziiWvQYOnkDdBrK6
 IJ/60+9+KQ2KEzUJbTgZPw37aSr4IYBuX9BXvNTcGZLZ3CpR98MMR4GfZaPI75Qg++wi
 isA3Cj/aPzSK+EmlXzBaqzAuiaVHELuCw7DXeH0n/78+nQYGnjNeNF5NSJ29PGiF3eZW
 GW+VruNVpu4xaa972JUJ9W1v7XRmEE3pQoOOzGpt94d7gjRILpIVG6x6Ez1sWH/CO4HH
 ahzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793288210; x=1793893010;
 h=content-transfer-encoding:content-type:cc:to:from:subject
 :message-id:references:mime-version:in-reply-to:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=D6UUa2xNPRVirPhujwvkv6IdDdVKe4P8N23+MP1pK9Y=;
 b=sJzIxekQtgMG7rct7IgE1T3TyLPik7QOz+ImoZ+W8SMWAyxZx9AZ2tVsQwHR4iYwqJ
 PaEvl4HzgbIJFZNvHdLCE9AyyHXBtqkNEf8W4Sf9o+VOMohvIqwj9aYlN6i4SXGITPT+
 S6mdzBbAlxMzU3LiRPcNY1lfKtnvGXIeOKhVlLKLFEzIPbioFLPgxlqmDJgi13vVD/nr
 E5xkPY0ji5ZgvD3Y9AN15DrQ9OkBKplH7MYXW7m3kHRVDt8Wml4+CMOrMhsbhukOzApS
 x7+Z0jCSJCqaBMOYegov6Q1zfCueNmwX7w+30dEL//W0bQxaeBQ5XHX+nFI8FRiaE5ea
 8DbA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzrrbZOQNVB2mMsydb2t8TJGp5l9MW4V5fcpIlRwaqRyP4tfv5roIa0s5i2YHCXXH4fMVOcbZOGUhk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI7HK1ZbK24PS870xm+YJqyEjhdinhscE+EuXzUxKufMLZvVl6j
 c6YR1SJTH3Ef+MnKTVJoqqwmvmvh6i9RpPPLlhMj54DTG/ISr0YP7ei70INzBS64xzr4sxb2Eh1
 0idHkwsUX6zgxvDjniQ==
X-Received: from wmap17.prod.google.com ([2002:a7b:cc91:0:b0:4a5:9877:cd58])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474f:b0:4a1:cd83:b23e with SMTP id
 5b1f17b1804b1-4a97452869cmr133905495e9.0.1793288203757; 
 Thu, 29 Oct 2026 08:36:43 -0700 (PDT)
Date: Thu, 29 Oct 2026 15:36:42 +0000
In-Reply-To: <CAH5fLggAuPdmwOFiOMMRUCP+yLPjmdjYGGfBxZJ=7+bkGODJmQ@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261020-b4-gpu_info_intobytes-v5-0-3e0c7c93223c@collabora.com>
 <20261020-b4-gpu_info_intobytes-v5-1-3e0c7c93223c@collabora.com>
 <athToIRyTjSB_jVg@google.com>
 <CANiq72nP1cXVOQp0xciGfBhZZfEfNP5hx8c+1ZPhXwrr=EOUGA@mail.gmail.com>
 <CAH5fLggAuPdmwOFiOMMRUCP+yLPjmdjYGGfBxZJ=7+bkGODJmQ@mail.gmail.com>
Message-ID: <auNoCpPLYfr6hBu8@google.com>
Subject: Re: [PATCH v5 1/2] rust: add zerocopy to bindings and uapi
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Deborah Brouwer <deborah.brouwer@collabora.com>,
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 Jesung Yang <y.j3ms.n@gmail.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Oct 21, 2026 at 01:44:12PM +0200, Alice Ryhl wrote:
> On Wed, Oct 21, 2026 at 1:37=E2=80=AFPM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > On Wed, Oct 21, 2026 at 7:54=E2=80=AFAM Alice Ryhl <aliceryhl@google.co=
m> wrote:
> > >
> > > Miguel, is this something we can take through drm-rust-next? Or perha=
ps
> > > you want to take both through rust-next? Let me know what you prefer.
> >
> > Both sounds reasonable, so whatever it is easier -- do you think there
> > will be lots of movement in the Tyr side?
>=20
> If we're able to land JobQueue soon, then yes, otherwise no. But I
> think we've aligned on how to get it merged at LPC, so probably yes.

It sounds like Deborah does have other changes that depend on this that
she'd like to land as well, so it'd be great if we could find a way to
land both once the merge window is over.

Alice
