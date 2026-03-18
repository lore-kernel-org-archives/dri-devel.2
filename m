Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D053E103E183
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:21:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 274E610E0D9;
	Wed, 18 Mar 2026 14:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fn/6vfKJ";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C10EB10E717
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:21:46 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2c0c9994199so145529eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:21:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773843706; cv=none;
 d=google.com; s=arc-20240605;
 b=jYJlgE5DWqXqfzy5b8Sb6M5YDfg9e8q9rOcovXxUNA6WjSn6bPph8oyr+YcjrgFJmw
 VV39rdOZh8RkEzmg/nH7N3tjl92/cK86RuMum8FVYvSkpYsObLIIc2B+CvAjaEudRn5j
 nithVd4uxLG5cTTOoyieqVfaQY1XCCLMCLBZgGYpEBt0TbuH1d0c5N6uKIYjY5QuyQUK
 T06t7+mjAE+VNVk9jk59s1O6b7WjA9aWGgSUbbCMSY++VN3cYrpiIMTw4dJPA591cviV
 hIn9NFUApw2B4lCkOwpVT3VYuYB7TBMuOY6M0IXZFzDKtdZTNluzMU3sLRyaSj6hTXjc
 nMMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 fh=WzYCO8f2xXt3VqWDcl2xQ4yaaACajGgL8QQE5oPgTH4=;
 b=Ko3Wtprma7nbT0AX0vd2FO4n1j0luw+zb+7qDSg/F1hdAfzlwIxiEnhgyCYckLcwgh
 G7+8XjdNL0La7hi1QlGwpT7U7AQvwqbL9soND8dD4ruB5qJIBQFM/o48VWTk1XwHUUqn
 XEcNqYVQq5PNqEtsSnI+DEBGh2hWhkFkhUJEMziq1PNzGbUJdhC6X2dfJDmSdTjdFtzD
 JF8OSdgDcPXuxd1iEx9ScFGLTlVewNbHFl938rY42ZZNHbKpdGOcbA1DC5hJEXvlfOvQ
 CBjJBWbNbKoeLG8ep9E6+YuXVpDrTBbGSb252H9L/Mepx7BxhEc5GXPNpxBkv6Z4YWKi
 Wkig==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773843706; x=1774448506; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 b=Fn/6vfKJAm1PXIA+PjVSinbVk50X9xttHklztIQGz3nIKnd9QCJmU4Y3KXdS3HR9P6
 Yf/n9ZvcGlAmtezUQW4HDqvYlZEodElBA9jNszqClTI+1hT1rdvBYi0/ZZ8VxXz61hSm
 2PoqXjdBsBVPOAJb8IzHPcMgXRRnskoTgIf8yHvh634XbgT2yQSk7in4PV8LXLLJ+yH3
 LpYYM3A7Nn+aes5Qx84UrOsqTQ/SGjlWyZKJ96nOnCXk/ZOE8zBYpV28V4CqSvZft/5F
 J3oT0LVWwyobrkp2B1ArTRqFpxliEEq2PpivGxli/1m7PKbJnPXPQQEWfCoR7QVrWD1U
 4ofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773843706; x=1774448506;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=N50RuEjVo0iFefZqItqTOtUCCVZJT3+xKOol5E25ZQw=;
 b=EqAtu07wCzf1JZB0Lz5G68osPV2Yw+R9O/U/KiJEJwyIxEF+4WhIWaRil5pzPEMtsG
 ft4Ywh3QfV/t+91WOasMJxR14Yr8FQSoTbMGL3fuWMZ9ie1MbTXbVaiYgOfAU7yrX9a9
 il/PH8i3LjfEDxcmHnBSdoETIpm8LSDrib7ZxuZbgZyKWPa9UY4FEa+xtBRxbo5eoUDb
 vAPgsAmkRHqA18SxkyWW2/RhfQpnOqH2ZHapaW5Bm8Ayy0I2UlM8Qr+XnQeimPWvtMWN
 w18uwoyH+56ZS/jwMjplG0ITdtns/yfWhgXgRkOb83kno9byCq5ogGhXzTxPLlSCeKZT
 Or0Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/bMVYP0ftHxjeXHjnDqn1lGuFum5Iqok5+rVOQfD8cb6CX9HgcA7+JrC/i/IRLIGYR0w/tWnI6xY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxevG6zj3REnhvoiiMHrxtwFYfrdz3j2BC9zpZ7FhnP3+PBYXBd
 wEF3CwYY3T9SAP3u9IvmgfExF29bj9ySrukg7xx7xVZ2ecxIGWApCyVJ+WjJVV3MDmPAfdjMQQE
 46iix9XgDn1NcQBxdEEc/xNTbZs7VZDs=
X-Gm-Gg: ATEYQzwDaMK98Op0ik6UuZzk/kZQny63u7zjponztlv/y6FrLxi/dyPqI3TlFSCNkVd
 0kGwj58P/wKM6qQzyP/q4XV6AohAdnHJDpi+8e7EymHgmjw2v71VasuNrZ5fOfBb1qZLyJCkJVO
 EXcwjPwsdxe+c+wAkyv3UEj84c7Qcv+5BnSSHnHghAfw0zp0vg9D1vg3kzExa7dZqWqe7Lyo50t
 Vf1T3/28teck9zczQizDAJr3H53fHPTHd6XTpGjeCEJWIy7QZAf/lvoIZDV1Z8Dr407tSEdYWnt
 EHvZjUe0UFFOPOT+nvzU94NqKclX0EsyUjTqT7xqUu1CZFwt1DpqPaVTe4/fWF2yKBtIbVKXmHB
 QS5UeQb6ImRqqYxbI+H1HbJE=
X-Received: by 2002:a05:7300:3724:b0:2be:1f56:ed32 with SMTP id
 5a478bee46e88-2c0e4f79e7amr862302eec.1.1773843705849; Wed, 18 Mar 2026
 07:21:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
In-Reply-To: <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 15:21:33 +0100
X-Gm-Features: AaiRm52hYvm4SlfuaD_e2Ur_BKHJMunoPzi20wYq7repEoz5nN2Go3Dpr2oWwgo
Message-ID: <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Alexandre Courbot <acourbot@nvidia.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
 linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
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

On Wed, Mar 18, 2026 at 11:54=E2=80=AFAM Alexandre Courbot <acourbot@nvidia=
.com> wrote:
>
> Ah, so there is a rationale for using a `mod.rs` file after all. What
> are the project-wide guidelines re: `foo.rs` vs `foo/mod.rs`?

Quoting myself from a few years ago:

  I don't have a strong opinion either way -- this was originally done
  to improve fuzzy searching, see commit 829c2df153d7 ("rust: move `net`
  and `sync` modules to uniquely-named files") upstream:

    This is so that each file in the module has a unique name instead of th=
e
    generic `mod.rs` name. It makes it easier to open files when using fuzz=
y
    finders like `fzf` once names are unique.

Another reason was that it is what upstream Rust recommends:

  "Prior to rustc 1.30, using `mod.rs` files was the way to load a
module with nested children. It is encouraged to use the new naming
convention as it is more consistent, and avoids having many files
named mod.rs within a project."

  https://doc.rust-lang.org/reference/items/modules.html#r-items.mod.outlin=
ed.search-mod
  https://doc.rust-lang.org/edition-guide/rust-2018/path-changes.html#no-mo=
re-modrs

Now, several other people have argued for the other way over the years.

For instance, one reason is that tab completion can be smoother with
`mod.rs`, e.g. every time you complete something like
`rust/kernel/sync`, you have to decide whether you want `sync.rs` or
`sync/`, and then if you wanted the folder, you have to tab-complete
again.

So I guess it depends if you use more the shell TAB (like Linus really
values on the C folders) or the fuzzy finder (like Wedson argued for
in the commit referenced above).

I personally don't want to bias it one way or the other [*], but
please let's avoid having both mixed if possible (unless there is a
reason not to). I can put the result in the new guidelines rules list
file.

I hope that gives some context!

[*] I would have preferred a middle ground like  modules being inside
but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
will ever be supported upstream since one probably wants to support
the other ways at the same time.

Cheers,
Miguel
