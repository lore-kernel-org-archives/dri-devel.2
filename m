Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 287EAEC01A0
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 08:11:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74D8710E2D9;
	Mon, 23 Mar 2026 08:11:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XLg4yXqV";
	dkim-atps=neutral
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com
 [209.85.128.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D887110E11B
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 00:08:24 +0000 (UTC)
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-7982c3b7dfcso32446817b3.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Mar 2026 17:08:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774224504; cv=none;
 d=google.com; s=arc-20240605;
 b=JEmyEsJbfrCNr8+Jkp06Fy7uhvQyq3pXLL4Vqvw3TNfcvVxgujMM6uN0Xn7Gsyz+2h
 sVeLaoaix84n3ETiDYW/BqJ1BS+oNV2MILR+RiAlc7Ip/0wJKQrmTtPPY5/r/RU6AkIc
 q/ik8/ppUz5FNsmLHFcc3sIV+WKcIOoFTKbiHxKEV9UmWz9MdH0Yr5WjXsjmwrB37KHZ
 bKbkNslQkBv6JHXrCh09WTyOoeTxRz3rSV701mVyTz++pWoOgA9PvlsJUukLuw4/VxMc
 H0B1sqqlMp9VHGAYc76PrVavEjmIrt5OrHY4oGIAvUg9dTOjHIlIHHppfgLk/fGhDfh5
 D4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 fh=fB4h/8cFUNlV/AhzRKyQJB6iCUFu7+bzqZaWURHinfE=;
 b=fM5SzvXyrBU35i3/hOb78IZGl5uyXcojQ+DaTzv87xnldK4mlYWjxA/jDlf28LsbYJ
 TJnOluSZM7BkdoV1oObbDUOi/6+UYMY78O3nWmu/elU9KANQNnCQL21FHvUcEYZkJFyr
 CzOULT+uB3isTbcMn/v4Rfh0hh91/oHLzyYRp8XN0B/yLgoXmkW8uEYPPU27i9lsTwoz
 SKYdTTxEki9CQuAYmJcHTqyybYapZugAGtF+3Vate5oRjV6UOLZHaYQBhH2mIqrrw4CI
 61x7BwJtyMeyLcvmOEBUvBUDBXDutYWhUGHKgmuvjv5ZjVbXd740CmcoKaZEJ6Rzumqy
 rK9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774224504; x=1774829304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 b=XLg4yXqVtoI6Js6CzCgTpQdhimcZCTlL1+n0pYJnQ+I2KFcO5yJQFe15pE8Tk9s1x5
 SWrOdwMA4593z+w9M884WZkEahL6TsyabSjAjDPmi8Y14kBDvMYtWnxM9l7GfVvZWGzY
 2qSVGLEA0Q6irsDbBMdZzWIHvpbzOSxd+yJMZCDBHEXfseq9syt8d2rLSadwnuOd26Hi
 nlPQdgniYE05ryqfYkHev4n6eIqIae54fSdWRcsQM8ne8HBj0lZuttSfq27jDSdHR51m
 Do9sB9y7WK09Ccp1EFwKgrosIDcTc/10g9jwFPSCaidUEZptKQTVxOUN4vVt1bidnTMi
 WHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774224504; x=1774829304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+To22M9XrloAsp8zyktj8aS2Z2Pum4SQehyzZWues4c=;
 b=Ljyh4s9xKQ47lHKASO2DdgcehSqy3Vs2jcd2KDYu8Jxz5/q7uLpIRByRdFQcYZT5ak
 r33Ua+mIUhC1oLE0beh3F0B37POmp1szx+BEC5L0J13j48ub5eW+N3YSBaEXDuqxHuS8
 mqylKmgNJGTn9DuvLPnoVxBQSlrON9JewEfX2xCFbFSys4A2st3e+dzkARekCwFQ5Ny2
 bFYylVeZWVUeb+tIudvgivJbPffmVqsIp076ywlkA6+7GhPSvq+/OnFMiQP2/SO3m7EI
 qR7ynZIlmonCwTMHTh0E1AJXEzZ9OH1Hvr1a1z6VVelwyM1we+wnQtlv6a3Ck9K/DJEU
 BMCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp5WBccRurRX5AMmQ5nyygnadGwdQHteTKolou8L/jGLWXu0cObXxrK24wWZXKJiDkM00mjjHjwt0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/Ar1g9J6r2Qugoi/d3anqUGXn1fgXwjGLnqqLm21iLeb0s8W2
 rsTYYLRWodDGZ4axlNhX2nw1nPx2u1HsLUgTdvnb80P0LVkmenLrND/Eynhk+szXKrfXbhRf3ce
 LE/LC2/fLk4qT/hz5ZzmN1PAxmSKohwM=
X-Gm-Gg: ATEYQzxsyeQcdpmoSWlxjieRPNGUIAmhyJQz39O2l9lNlqIrm+J3qLAtWg8GUU1Ld1l
 P2NJStCDoW3loHiwinULgGb0gWEOK+PMQcm0zcOjE6qka33Mw4EkfQoPDxSSxX9SY67nKSq/mO9
 qF0PPTqvmYMu9roc2cKy0M9E2iCDd8VChA1zi5TMyD8qmHE8Kue8MqMW6yrysr8UJP+CjehsLlD
 IhGMspVHp4xLT363Bx+l8H0XFO2fBy4wGcbKPlAa1VGp1uvoUBHbXFxmYTzTGErhOWr1xO6Ggmg
 LpK+JF5oH6Ti2GgE64SGrnEDqhHJN1NUzANEJFU7aHVUd5Q/
X-Received: by 2002:a05:690c:4424:b0:798:6f13:2419 with SMTP id
 00721157ae682-79a90bce798mr96296727b3.37.1774224499042; Sun, 22 Mar 2026
 17:08:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
 <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
 <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
In-Reply-To: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
From: =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Date: Mon, 23 Mar 2026 01:07:43 +0100
X-Gm-Features: AQROBzBsI6copsViR8GCb5s4kn_1rinKOMbl-9Inr9UPp4mS88b9cJGUv5vqwNA
Message-ID: <CAGeanHfNwP6Zs3LSfc9eEO7_LG0kK-jO24oUd7BjxrQbndEmNw@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Alice Ryhl <aliceryhl@google.com>, 
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
X-Mailman-Approved-At: Mon, 23 Mar 2026 08:11:26 +0000
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

On Wed, Mar 18, 2026 at 7:57=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia=
.com> wrote:
> >
> > Anyway, the fix is simple, just need to do // SAFETY*: as Miguel sugges=
ts
> > here, instead of // SAFETY:
> > https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dP=
id89LExw@mail.gmail.com/
>
> So, to clarify, I suggested it as a temporary thing we could do if we
> want to use that "fake `unsafe` block in macro matcher" pattern more
> and more.
>
> i.e. if we plan to use the pattern more, then I am happy to ask
> upstream if it would make sense for Clippy to recognize it (or perhaps
> it is just a false negative instead of a false positive, given
> `impl_device_context_deref`), so that we don't need a hacked safety
> tag (Cc'ing Alejandra).

The team is a bit hesitant on adding comment-specific syntax apart
from the widely used (and already on clippy) `// SAFETY` comments.

I'm pushing for some more comments specific to the Rust4Linux project,
because we already tailor some lints for specific projects (such as the
Safety Critical Rust Consortium), but adding more than new types of
comments is a bit much.

On this specific lint emission, I'll see if I can get it fixed,
because it's a false
positive.

Cheers,
Alejandra.
