Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54456106ACD6
	for <dri-devel@archiver.kernel.org>; Thu, 12 Mar 2026 19:16:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B484B10EA8F;
	Thu, 12 Mar 2026 19:16:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="I70LgRYw";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E225910EA92
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 19:16:13 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bd801b40dbso96436eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Mar 2026 12:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773342973; cv=none;
 d=google.com; s=arc-20240605;
 b=k1dAD8RDuJMotZrpgM1SLvYRdXC48vLjeYo43McixmxVp6119y4c5pElJGWJBpXPJG
 6GnELKcuM964Q3Yn58wXERPqqyxrCxC+a921VHIf9rHRUqdkCHnZ40vLoxTln0TqeSmI
 x8i76Yt//+U2pghL9EgygCGGALAKvDjA+XjEvHtwU/gD7dxOmrcOHdubwFhWlo3VzbGR
 gtnDhttRQ4ycPGKRZe1utqAki7ejp4b8OdCQN/IqtDwBHd9WwIVsjfC2wtfqM9i37212
 d9fnpmnD2Rzf1gizPtI4gxpTD9jESNOWkSpVBEax5nlAj3rNCQdkW5fRRwy7FpyvC3My
 avSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 fh=PHasE2GOynPMehqRiCoEJyEmr7ZavUwcNDSfcke6llk=;
 b=OhHKmxmIKOsbXJydWCbFPoEbMpK9pYwGesi2f1tpkVYKtaRDeyX4PqNCTQLtFsHIPV
 fdLBOrVkYXbdIIhoOrZKGFe16rCYMxJBJfQnWwdrIoHCRXyhj7x7x7U+2fR5Bpdzjl7X
 ZlJAqHSZEPlaczGuE6B9gYsjLk37WXA34x4183Dt19P7QWl3A/LFtxpE8vWlY9eCHMLi
 Vtt99WKKpRrTf0PmCOljQ5PCeZlVhJc2KigFMwsiaYkyuqqDKuUgXe8YCWpcfmRCstyW
 wvx29RrYYCSMe/Toq6c8gKod3QKRsvkNKEq+Rgm6I5kGIwo5FEpqlZ/LeqRiWj9hmrr1
 wAZA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773342973; x=1773947773; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 b=I70LgRYwmb1Kf3TSnl+ArSLtzExyTBoa7dl04aKCHbpIOVlt0pkM+kTuMC22F9ryVp
 jUv01TLfI+UOeUVX6Sjz3kZS8LJyXET8ksAMjQMZzMqR2UNwz/RhUR0Dh0iVLA9TJZHL
 QXDsAXdQJiSbkyV3ypZv6uYxCyR1eCY+nrb6KQRwRLstb0XzDVTra1OJoA7lxpmr4sXI
 kaiXA9abzkmSNzENEsVuZBIyKPxgfqceCeSC5GzkFLFj33Ut8QJ5agezs64BnIL5WFv+
 4K0QJleWgs+yILD46TlDsM4JTXcyiLlouPXq9bhfJihv+HoQC5so3WutGFCQ5CAn3ICC
 Xoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773342973; x=1773947773;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2hzSysAOGotLHY/Gk0vtKsQ07bdjUjpPdIHGXWzs09g=;
 b=mE2EoRURLOIxibKqVEECgrjZgymqEyrS8w99Gvrq3IzxQlk5OEe/9WR06QXhkHjvit
 Bj1OHhSRN64DQVEaBSduyCkttQVgj/UiYrXL5lChR/P8SJEx6INKPTyJBZpFZiXKUBpU
 8T8bycUCS53gOQZv+Ndpz9ovMcWP0NBnkO60B0buoft36f9S9wq5bIgNuHD45+ix1aRu
 mMstqSoDgD2kBwdp8wTFV915yOC3Eu/0KlfIWJMTXA16L5JhYKb6qhKRoOg14tlxygQv
 nr5AtlQm1REoejGDo/Pw6CwbHsHk3/m3U65Y9XDFQcUZXYBvTEtz7w+SK2fAvK47dWvv
 9z7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXy0xPl/IC2Pz5Ll+XnwVfLuMiOA7/Q05VdgbBmBsSd3LBzBQ0gYcx+W/ReC9EpgRqRh8xjD+dewZ8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz7vOzHsY6jIkHUUZoXr2W/A232F/I+v1U7PJntxIUqX7M1PPkV
 XzHHwSY/jkhd4Uw1wngsztoIgibBdVpbx0XPjdXF51/P15293J6NEbnq51qKGtge3obgOGcavZn
 F8iWkpybXSvR0QsrwyscdHRKeLfaDB90=
X-Gm-Gg: ATEYQzwezrDCavB9Na0/TnbG8b3EkcxWaMb3A3mzPdeivKUEVdvDCX3o6NmSvqAt8rF
 U1dYxCI+3vYTMePf6kyAeYuRsg5UgMJHJECK04b9DUAVTA6972yR6NT72impprOwGrb1foi652w
 VLi9VjXNDOctbgyHGiwwK5n9glRNK7GEgsZnS5gfkT7mnAf1XYo8lDYiVN3yTgog42vOUWJCdJY
 4YncmVScOt2FQFQt+gqF7Drzw+N4u5M9ptyGB5iKBQwDT9k6ruM9rmZJ8Z1m+gSZUX10/8Ix4ZR
 swdpf3zE0NhP1KPUUUt7T5/9czU9yDs5Xr0R4TbZwcWlRCV+isGDl0wpbKa4igvpQM3DnmGa5bD
 GwSVoY094NJshnVIPxIGUn7U=
X-Received: by 2002:a05:7300:fd03:b0:2be:171c:2177 with SMTP id
 5a478bee46e88-2bea5744a60mr186533eec.7.1773342973060; Thu, 12 Mar 2026
 12:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20260306203648.1136554-1-joelagnelf@nvidia.com>
 <20260306203648.1136554-2-joelagnelf@nvidia.com>
In-Reply-To: <20260306203648.1136554-2-joelagnelf@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 12 Mar 2026 20:16:00 +0100
X-Gm-Features: AaiRm537cVQtFBzSwOEaMgXdjzYeE0uMIzdX3f2cfwXX8kFS15LK67mGvYzfQo0
Message-ID: <CANiq72m2Eo1UAuwMC0LhiD4+yqKixRm=+oHtEnpwY-VbNdR+fw@mail.gmail.com>
Subject: Re: [PATCH v12 1/1] rust: interop: Add list module for C linked list
 interface
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
 Dave Airlie <airlied@redhat.com>, David Airlie <airlied@gmail.com>, 
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
 nouveau@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
 linux-doc@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-fbdev@vger.kernel.org
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

On Fri, Mar 6, 2026 at 9:37=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.co=
m> wrote:
>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

> +//! # // SAFETY: head and all the items are test objects allocated in th=
is scope.

`head`

> +//! // Rust wrapper for the C struct.

Empty newline comment between these:

  //! //

Actually, should this be `//! ///`?

> +//! // The list item struct in this example is defined in C code as:
> +//! //   struct SampleItemC {
> +//! //       int value;
> +//! //       struct list_head link;
> +//! //   };
> +//! //

Let's try to use the usual style, i.e. no empty newline at the end of
docs for an item.

And the example should be in a proper code block with a C tag, so all
together something like:

    //! /// Rust wrapper for the C struct.
    //! ///
    //! /// The list item struct in this example is defined in C code as:
    //! ///
    //! /// ```c
    //! /// struct SampleItemC {
    //! ///     int value;
    //! ///     struct list_head link;
    //! /// };
    //! /// ```

> +//!         // SAFETY: [`Item`] has same layout as [`SampleItemC`].

No need for intra-doc links in comments (for now at least).

> +//! // Create typed [`CList`] from sentinel head.

Empty newline comment.

> +//! // SAFETY: head is valid and initialized, items are `SampleItemC` wi=
th

`head`

However, this is giving me a Clippy issue (please see the other email).

> +///   `next`/`prev` pointers are valid and non-NULL.

We started using `NULL` recently as a convention for the null pointer.

> +        // - [`CListHead`] has same layout as `list_head`.

Intra-doc link not needed.

> +        // - `ptr` is valid and unmodified for 'a per caller guarantees.

`'a`

> +        // SAFETY: self.as_raw() is valid per type invariants.

`self.as_raw()`

> +/// perform conversion of returned [`CListHead`] to an item (using `cont=
ainer_of` macro or similar).

Intra-doc link to `container_of`?

> +        // - [`CList`] has same layout as [`CListHead`] due to repr(tran=
sparent).

Intra-doc link not needed.

> +        // Convert to item using OFFSET.

`OFFSET`

Newline comment after this one.

> +/// Create a C doubly-circular linked list interface `CList` from a raw =
`list_head` pointer.

[`CList`]

> +///   pointing to a list that is not concurrently modified for the lifet=
ime of the `CList`.

[`CList`]

> +/// Refer to the examples in this module's documentation.

Perhaps we could have an intra-doc link here to the module.

> +        // Compile-time check that field path is a list_head.

`list_head`

Cheers,
Miguel
