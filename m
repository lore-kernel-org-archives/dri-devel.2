Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA910854D1
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:59:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD1810E77A;
	Wed, 18 Mar 2026 08:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="AdFXKhWb";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B9D10E776
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 08:59:06 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-439c794edd9so6634950f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 01:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773824345; x=1774429145;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=MXY9EHBXCnPWVfnYnREpBujBITTjaoQ0F5qTzNSzUus=;
 b=AdFXKhWbzkC/P817pKAHLvAFJFesMoJvZ6h/nH+QUkSIxbKYNe61F/ZctegLuzcC3s
 G9kENx49LoQ8X7AJnMlIN/HkepXTElQDuybO69SK4QlStqtJ/Z7fK/eD++u9/4USNR1Q
 KzHRdBmKmr6aOlD1HdiZGsW4+DkrPcd76+Rk+jn25js/y5pxkE9I5BLYjdNnfNHf5kqJ
 wVGwcWtc8vUXLYnxQTG7DeEZa7MVwHSpfRAQwovjjHfRfZNOusOliqfICJtt2fvD5aJE
 J1TjfeGrEPXDPZPqLJCzJbj4ckHZ8AcMQMlxMr2bKdxhKUjc8Iziuw9LOnkK0TFTw6rS
 XLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773824345; x=1774429145;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MXY9EHBXCnPWVfnYnREpBujBITTjaoQ0F5qTzNSzUus=;
 b=DoZprxO3JNF7TmWOjjjS3JL6v5nk902Ueq4D40rbszazmufViloVSdwSS/Y0btSV3Y
 tSAVhkBWC1ClDWd1naA7GEVNmZEidwesv3B0Aj58daGvfEv9YuceH5HF3OYNbhqNb6xc
 ukCTdXw1Tw2hNDbQlQE8miY4yHD3w4J9lOnLmZcXxvV4P8iLVVVbW2RsU6qLDKMtnjdQ
 ll0Ks22x/+cRGBN3cTaNYWQlCFrg3NDbIAzK2lLzy5hDhkqsxg3337Xuf9NW+u8LxprQ
 ZeTPGl8TKWil5FDi2RUrzKAaIeFy5jCn4dwsQi16IZIx8ptudydVQ8SOzKLCrTdiNwsL
 Y3vw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4k93DVdyy5y0YqcWRSA0aG4h1sDPZz3kuw+VQZBd9Afd5HX0XY+ldJgulIWoQM4wySjCw3hqq0SU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQ6FxpeOW2PnCcrg8RUMzI418VWcMrrbnq4/CaR5Xuo7NRYLeT
 ITRXGYaUsDxXslZQwrQsvWopc3EtANcN2MlDVwUR8hg1E6A/1xiMvZQcpI3jvHAsAUqaINqdF90
 OQJ5EsDtLqqpgV5ixeQ==
X-Received: from wmqe14.prod.google.com ([2002:a05:600c:4e4e:b0:485:3539:bc05])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a20b:b0:485:3bb5:92cf with SMTP id
 5b1f17b1804b1-486f4422300mr29381305e9.12.1773824344660; 
 Wed, 18 Mar 2026 01:59:04 -0700 (PDT)
Date: Wed, 18 Mar 2026 08:59:03 +0000
In-Reply-To: <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
Mime-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
Message-ID: <abppV3e91iVzplcv@google.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
From: Alice Ryhl <aliceryhl@google.com>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
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
 "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 Lucas De Marchi <lucas.demarchi@intel.com>, 
 "Thomas =?utf-8?Q?Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Helge Deller <deller@gmx.de>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Edwin Peer <epeer@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 Andy Ritger <aritger@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 alexeyi@nvidia.com, 
 Eliot Courtney <ecourtney@nvidia.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
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

On Tue, Mar 17, 2026 at 04:18:46PM -0400, Joel Fernandes wrote:
> 
> 
> On 3/17/2026 4:17 PM, Joel Fernandes wrote:
> > Add a new module `kernel::interop::list` for working with C's doubly
> > circular linked lists. Provide low-level iteration over list nodes.
> > 
> > Typed iteration over actual items is provided with a `clist_create`
> > macro to assist in creation of the `CList` type.
> > 
> > Cc: Nikola Djukic <ndjukic@nvidia.com>
> > Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
> > Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
> > Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> > Acked-by: Gary Guo <gary@garyguo.net>
> > Acked-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > ---
> >  MAINTAINERS                 |   8 +
> >  rust/helpers/helpers.c      |   1 +
> >  rust/helpers/list.c         |  17 ++
> >  rust/kernel/interop.rs      |   9 +
> >  rust/kernel/interop/list.rs | 342 ++++++++++++++++++++++++++++++++++++
> >  rust/kernel/lib.rs          |   2 +
> >  6 files changed, 379 insertions(+)
> >  create mode 100644 rust/helpers/list.c
> >  create mode 100644 rust/kernel/interop.rs
> >  create mode 100644 rust/kernel/interop/list.rs
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 4bd6b538a51f..e847099efcc2 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23251,6 +23251,14 @@ T:	git https://github.com/Rust-for-Linux/linux.git alloc-next
> >  F:	rust/kernel/alloc.rs
> >  F:	rust/kernel/alloc/
> >  
> > +RUST [INTEROP]
> > +M:	Joel Fernandes <joelagnelf@nvidia.com>
> > +M:	Alexandre Courbot <acourbot@nvidia.com>
> > +L:	rust-for-linux@vger.kernel.org
> > +S:	Maintained
> > +T:	git https://github.com/Rust-for-Linux/linux.git interop-next
> > +F:	rust/kernel/interop/
> 
> Sorry, I forgot to add an additional F: for the rust/kernel/interop.rs file.
> Danilo/Miguel, do you mind adding this when applying?

I think you should consider a mod.rs file to avoid this. It's tiny, and
just re-exports submodules, so I don't think the "mod.rs name in file
view" concern is that big, and IMO having files related to interop/
inside the directory is much better than having them outside.

Alice
