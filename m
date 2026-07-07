Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C0EC43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498F810E4B0;
	Tue,  7 Jul 2026 13:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="ol+fF9zJ";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C9D10E4B0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:04:28 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490cf3000f0so39565645e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 07 Jul 2026 06:04:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783429467; cv=none;
 d=google.com; s=arc-20260327;
 b=CUDk7RsdoLnNR2uFRCIWewMK5lKlfSKVFmjpRMtWOJt20vS0nPrurFkZSIP2+gcNUX
 6arDhVK9s382hvCepm/n5Ukz8+bnuJFwIfmWpS96pHiMRxh6f0EUsRnywG5Bt/TOsRxP
 fH7Dh0jZwaOqWjHYq4egFFLlUjThTllFsy9FSuhZWElMXWcmwi1wWOp6uqCij3yB6xhp
 9lY8j6K6reK2R80+31b330MrVDHg/8CJSxunAnb2+7Sjb76Upf/zEUT8epzpQ0LEZFJz
 hS317T6wAGAhwkDga8/ZwUFMPERGbv7drJfRw+DWNcRlmBpjISQCAruxuN+D818Kg7IK
 fkag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
 fh=/S1//JdbQMl9uzGIWNfCoFv/MHDXsG9YOqlkOsKefe8=;
 b=geRZpDja5LKXdZx4HSDz1yTfe74XGu1jm/3XlTTnLQ+x+2pwnkiRQRuilYWyRCyiXE
 iRyVl80nv6Mdzo++WSuy6N0lnfSScaRsIH+Bn/qspHv2P9MVNMpC8HL5TEEgg21zXcsj
 qXvjOcw4ab6QBmuSS8KX7sB+HtYyZjLby+dD0cG0p5GfUEritEBUu5NmjDPgWwj3JMD4
 o6/xrXpCcBw1qd6Frqwzw9fjNHV+ULuNHZuk1bw01fkBMJ/PnbcL7HcTSfFRYWCakavw
 ouN8+Gyjcq1Kp/oJSFaPy+TK6Yzl2PK9aXs7sMulCSWOFhwL9S73V3jBg40ra87JPaic
 qXqQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783429467; x=1784034267;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
 b=ol+fF9zJrnDs+QOb+xQcWTjB6EtKV9DDtAid7RSp95hsWThfHChFvypCpYFN67K68u
 xb9gPgTr9X0sT1v1OLk7WsAKq/KIMnJCkWu9jU0S3a87S2UqambEafzrs9gatZkJas0q
 Qp2FbLMNrsofF8ZPS5pACJ2Dd65hvRD5pzcTwswooB2bcaAhWA1q0yUL2mBH+MeW6qg4
 Ld9HeUnf158LU8SM8Ndn7t3X6hIoKmxa5jv2LTlevD8d1xc0O5jdinRtJW/VUvvQ7xov
 wu1gajHhOD8cD1i4SmjWWUyX24TlOPmRlE+aMqYZrTj8ZIgqsHJGZ4dnKkmj8Oqth0Wu
 zbZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783429467; x=1784034267;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kMZTTwd8MYpbLMhgPf9wJy+JM0u3tngYW75375hm26s=;
 b=LGksbIojWerS/d8bUDXQPklvt3vTUCXibUTR4cvbZR4AkL6Rwhj7GYRtUEL2cE/K+K
 lHbWn2HXJVlEUw9xLG1yPIX74GtxQZsDOEYF2XU20ZuO2agf7Wne0+R8qYl0tCMh+FtP
 MuHTJ+ZC2fyFs6m2y7z3O16x10t5R7822KG7piKC/q0fdF542sm1TUOtBuBX3L3o1VtF
 W5GE0CCShDHh4GRAxa/uooueokvXVX8+fsAwdaIHz9/5W3a6nVj3JlIlZsDy11mejqVv
 gFT/4u9LBuDoV+CX3udHlfMeW6YNZ9ABsUfKhbQEa9geOsjuszS0TYU8m7zNMe7S6CCw
 Osbw==
X-Forwarded-Encrypted: i=1;
 AHgh+RojpmG5TyAWc/ITuaUBaZTjPUWyRD2ZZwcrEL92HoWm94SiNEzEUoRd11GXa7W1/9pjmzPB0JVhCcU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzAn3MybMgXm71+EWy2D79eZjQmz5dnqjs9FteDuzAbFqxjSYPk
 Sg2uPQb36RHg3uO0ns4GpQaFJ8xAZWxKuGMnpVpk3Oi8msrDQqA+taus2o+CTVDFciP9Eafid0U
 YbO5skuovHTtnecytti9CJxP4F5KR8TyXruWkWIku
X-Gm-Gg: AfdE7cmZeBR7BJgfVMr+nQQHg/KIiHHLCUaCUERyjbePIN/b1jUYG+HN7EtSeH90b1W
 GriVXFJ3vAcpRlyYUX+vKo5hjLwrjZNM5uVByxFq4PlTf4pklOExng9cRF/yJ+f/YaeEDcUy6wg
 AwB290CQw0ffQy8bxxJ6fkeJ8Za0L7zELbnFnr5VOypHtW9pzDsBsZ8lh7ovRa67DatsusJikAz
 oiSYCc+WlOoEWHt0fGJPCV4pFksqEINL74in6FipyJXSKssqfmm/BCOyGwaJX1Bn6SaIKTrW4Hp
 vtojYTehNlnjKnuXXEPGlBsYpC0=
X-Received: by 2002:a05:600c:3e14:b0:493:bc4a:e7d3 with SMTP id
 5b1f17b1804b1-493df0a08d1mr56240095e9.39.1783429465838; Tue, 07 Jul 2026
 06:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-unique-ref-v19-0-2607ca88dfdf@kernel.org>
 <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
In-Reply-To: <20260626-unique-ref-v19-4-2607ca88dfdf@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 7 Jul 2026 15:04:13 +0200
X-Gm-Features: AVVi8CcTh9Rs6YX_7yLE2pYLhG0EOfuYJdmTfdwdI6hvKkhrcisIrByGWFuDPNk
Message-ID: <CAH5fLgguLAQG7mUwD1NPECYSsPdpPD_tLskU3NdwLZhKR1H=aQ@mail.gmail.com>
Subject: Re: [PATCH v19 4/8] rust: page: convert to `Ownable`
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
 Michal Wilczynski <m.wilczynski@samsung.com>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, Asahi Lina <lina+kernel@asahilina.net>
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

On Fri, Jun 26, 2026 at 1:56=E2=80=AFPM Andreas Hindborg <a.hindborg@kernel=
.org> wrote:
>
> From: Asahi Lina <lina@asahilina.net>
>
> This allows Page references to be returned as borrowed references,
> without necessarily owning the struct page.
>
> Remove `BorrowedPage` and update users to use `Owned<Page>`.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> [ Andreas: Fix formatting and add a safety comment, update users. ]
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

>      /// Returns a raw pointer to the page.
>      pub fn as_ptr(&self) -> *mut bindings::page {
> -        self.page.as_ptr()
> +        Opaque::cast_into(&self.page)

cast_into() is mainly used when you have a raw pointer to opaque. When
you have a reference, you can just do self.page.get()

Alice
