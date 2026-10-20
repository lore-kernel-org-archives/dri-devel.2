Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72041606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 20:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=HVqJ1iPl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D267410E116;
	Tue, 20 Oct 2026 20:16:54 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D6A210E116
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 20:16:48 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1d2ec9aadso2875e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 13:16:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792527406; cv=none;
 d=google.com; s=arc-20260327;
 b=FmOLDj7UnTVySWr1wFNaO+TKK1fyiTI1OmUW6iBFr5y6SoqBMowz/CnFhuTJOEKTE8
 YIWRKfhJ7l5f+BnUTG/t07DjpX/AE3P3VOkoKxVfu23s7dn5PhsNJTiVoPNCQX16wdU0
 rB/Vm9JKeLbBv8iUHNVXLx8ZFNHx6ZCcnRsPVz7VU8lXpGBpDRSs8T0q9mJI9A2K3kCf
 BhP9FeuaZVBD3SNm2UboJJ/c7tOpUSxQ7urFXxOPnE6TOj6REVblOgBQm4CQCMvFyTvH
 1i1mpx7Gr6Bz7A2SLSuhdUjMqpa784ZW20E+E1Fkv54TFSK4Tz/NkxcWaaz/CkcIOgO3
 GEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0h9M3TYjYg/Zu0GFYIpY3pxrKT9v+m/rFawThlx/TC8=;
 fh=KhSVQyRqUJDpTr1vuVBa1CCUmIUSTRgbL8zHgSQF/aU=;
 b=mSBBswnt01spfYwn7MX8vls7o03r+sQTg0LBoRRxAicsOllshClGfn8odJkGUfZ/hN
 8GPSFploWw56egdO5kq6LkMgEXoNbirE2oxfNPQQX0YHYNhgfUB5UIy9CnKAi+h1T9A0
 QCMHShMrsehj5szGKIy5m6wmVdHlcvO9sUM9wCt2jwQsSnGffBiKTtKm91RFGSGHaFpz
 vOQq65XfROr1rff5Rn0MPn0N3ZXUbJSZLey3NScNptB9qAb89tBXdDLYUJyuG0pMMcPA
 IcBEl0PNG7W2bPZuV4wYVzrx7Kv3vOoOK2C9U/MzDtlyYPE3i+KwuOGG5GiC2OS7ih4t
 PX+Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1792527406; x=1793132206;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0h9M3TYjYg/Zu0GFYIpY3pxrKT9v+m/rFawThlx/TC8=;
 b=HVqJ1iPl9o0t1f+shPzfHs3Y0es7+zj4nzL8BLIAtzSt6zQdX1SB7+F2ErROgBej4o
 fdP8Ewtr4Cs0Q6F2ftO/XXEoea7u2yGzA1r4GVqb7o0eFRcVAv90v3uAjOW09VsLgB6D
 kvgPVJMZ5/zC73qwWHRzIz8Ma1AT7iRTybnW9X7W/56HxoGTlxp0Kt7wTFCMO9uaWg7e
 QH4NOQgz7LnJxwYvEes2guLbsyOQN4c/Y4vsDWevLTMx6CF02jsSfeMUmiFB6rUSuhvF
 Iq91WVhmk4q7zh5qA2EMHrq1hjxoRfuMiJGN3VNh+Mpv4UTURsO1kGJuqfKbgBM0Qb5F
 +oWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792527406; x=1793132206;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0h9M3TYjYg/Zu0GFYIpY3pxrKT9v+m/rFawThlx/TC8=;
 b=glWa5n9Ml8XPzqFisbZzfs35WVg0/drgvZ5wxhJu0ZnvlsZ9+v3Ods10U1SBXBtsA0
 xkfGWRk8tAHPVJapqAKNXoLBc/5QSKMuCHdALyqLXS6B2e5++oyf9mC2xKFOL/RGXcRG
 DeaUE68rXVL0AoH/bJ23IBXTRSIofQnqGJYuDKV7Trggpx/2++hmoIGxbUQ6kLwp0zl9
 TgkE8KGfdywZqkvxetooIN87EGo56nvMw9AxRTpH9pCQ61IG2B27KS5X7OzJawWcgaAN
 P9jEqoEB7KA1xSkIs33cBAwMlmb1MDLykf20StFfGaoqpfFduvH/VCrdmuR6KPeSjiOg
 ryhA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzY712FfhtO0XrRvhWDMlWfVKszNA9VN9GaS8DzACPxYVgLXHs6RkEDlyserPDzso71W6UZNSiOESI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYICDFv9usP/DWad8AA+k92lyIUZXs5Y9/xX2Gpm3LCbA3UChUpm
 8cLaYjMv+xcuREWBq2aVEIvw8Shlrb8reOy1rU0juBDt3WtRVpEdBNn8X+25RJrGSUyazrUDFHd
 m/vilW3OXGn7DoVIg0M9FL6T/1igb6SfiD5l75P1a
X-Gm-Gg: AYBFou1vNPcaw2Nl+ve/hi4a+wj8nHC8S+jOyEZqwbDwbZ1TpxVIYGtVjAp3rKQa8I9
 X1YDAwZKJQVN2AwSTi9DaKp1G2wF4oYqsh3+PUWRjjcqyoIJcE9zCReESYEx4LkBfLJN7NmJiLm
 CL3PgHSM+hAA1VV31cl+ZAkR2UHjjjCOv3U0buFqIZqwFrVB6REZRTe4DGpI7oIGtbiTItjIe9B
 51157m7Pjr7/k6Rgp/97SClC5/BzGJmSNHABH/VaO16gui8P4n7UMOKjtlWXvDIgRS8sxM32Ck1
 +GO18WkLkzLBo3AmO8cFrmFwN7ZlcoHrA4VFkUa0S+87d+qotmDDUu9xJ+jInXZHAGgLXh2TCI3
 /bxfTrfBguQ==
X-Received: by 2002:a05:600c:a402:b0:4a0:1ca4:2741 with SMTP id
 5b1f17b1804b1-4a1f598682bmr1067665e9.9.1792527406013; Tue, 20 Oct 2026
 13:16:46 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019-rust-shmem-fixes-v1-1-3f7f6de5b5e7@google.com>
 <DM9O11JY63Q2.1U3PB5GL0JYOQ@garyguo.net>
In-Reply-To: <DM9O11JY63Q2.1U3PB5GL0JYOQ@garyguo.net>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Tue, 20 Oct 2026 13:16:08 -0700
X-Gm-Features: AclHuK-3k8j6k-bTltQ8cEj3qPss7TOR1d3Ms0fv42pBRizgtolJ9QhEZUGBs_k
Message-ID: <CABCJKuf=7aVKfC14cXymn-BBfvA--3cfWjpTnBY0orkic5NzRQ@mail.gmail.com>
Subject: Re: [PATCH] rust: drm: gem: shmem: do not leak pages when sg_table()
 fails
To: Gary Guo <gary@garyguo.net>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Oct 20, 2026 at 5:31=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> On Mon Oct 19, 2026 at 9:21 PM BST, Sami Tolvanen via B4 Relay wrote:
> > From: Sami Tolvanen <samitolvanen@google.com>
> >
> > `SGTableMap::new()` takes a pages reference and maps the table before
> > `Devres::new()` allocates. If the allocation fails, dropping the map
> > frees the table but keeps the reference, and the next `sg_table()`
> > takes another one. `drm_gem_shmem_release()` puts only one, so the
> > pages leak.
>
> Sorry, could you explain it in more detail?
>
> Creating a SGTableMap and dropping it doesn't restore the state? If so, i=
t
> sounds like an API design issue.

Correct, SGTableMap::new() increments pages_use_count, but
__drm_gem_shmem_free_sgt_locked() doesn't decrement it in
SGTableMap::drop(). The count is only decremented when the object is
freed, in drm_gem_shmem_release(). This works unless Devres::new()
fails here and sg_table() is called again. I'm not sure if there's
some background that led to this design, but I do agree that it
probably could be more intuitive.

Sami
