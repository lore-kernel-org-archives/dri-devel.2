Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8678103E17A
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 14:31:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 284D410E11C;
	Wed, 18 Mar 2026 14:31:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="tZiWVFHj";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C673210E71B
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 14:31:26 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-439bcec8613so5411254f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 07:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773844285; cv=none;
 d=google.com; s=arc-20240605;
 b=CiKJZwfuDt7p8ii/jEbEs7RYD9eWsPVTol6IWZJCrI42eijupXZp4HZT6/tYLlpEbW
 1/Kw11I5nxuTaWOJcXuGOhPv1EJp534N1yXK0ru844sFbIvSRXYi/ECHnIoOAOStxD4B
 MhgVFbVucRFZOGUOqhJXhTQkkBjosXL8FEWPo3laAaqjYTCVc8GLaRju5w+lInn60ABx
 dXmah9vX94l2dwWB7w2qCmzyTH/+b7rzw03ZvdewJPF+lGoNzzDHGkzTt2XS2x0ZIwo8
 v0dPSF5dz7J9IEe18Vf0ldnTtIoR2Pan3I6q18SGY8pegdxE4giKL7fQip1L44cgO7T2
 Tk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
 fh=FQT3epLemwCF9T1vPIBXGeGlQpyAASR6TYO52R5qLRA=;
 b=Upg5VE18HjyNkHgX7rllUGk2K12LKJukCDsiRGubejlrJ1IRKJqTvZwphtpo98BUbd
 gypB+/knkzEZNAj+tSup0kLGnfL/kCHznqUMqvnB/eBuX2wWvqx4LnXO8qFYQu5Ui7wf
 vcMShVr6ODOAZq8tOasGMhqtFsNVJXz/uFw9AZ4jvFdDIMU2fXIA/Cz6RDHQwfMStlD1
 /aSKXnq7TNLSvJKomZd5XkpiMV0H69K9np4gKVLFOD6FbcnPz/VJgxwiq6CBA8k4Y2UX
 PNaGL+tx9hJh0INrGYZVlb6z6hcqnUm9BcDADTWm8Wb0FeR3M5UIEQFdHBBI5AExMy8U
 vHWw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773844285; x=1774449085;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
 b=tZiWVFHj2+g9DuubpbvnUXJzjWS5yRLIEcmLhSkfowhQcU3h/pW3rjvyiXbGjc+J/c
 yMXzCnq5OHsbQLHh4+cBCjDzAMD/CWOZz+ZIib1V9AfKHxoUg6I6Sstd6ZwvHtXhhnvu
 Le9Pe1kBpFN1rF8CWmgr+R2SZT1/2+bgHO9STvNDgbH0RHMrGJvOWtiSDTBHKi1Up97I
 Vm4gFHYOBRIfifX6Of4PjHpHX1fogGRo6PaqPa/7hsv56sri5qan9WKTEzb7iMUUV6Uo
 rlE1gPcXYzpDPNPYKYLtupYS2L64GX0H45xTr4ip0Ra8LQNhT46Mvpvy9/Da4Nb8lTwp
 ZVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773844285; x=1774449085;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9Oke8F3j0iNZ3cSK0OCeOVMy+GmzWDcEKfA0PeIuC3c=;
 b=si+YsmrqoZPnhrUjMrhTcTND3Hg9qRjToUD6/pW8Apz51A+nhxeIM9efrZrd3VS6V/
 pBtAUT21gzVYD78lWy278l36gN5TXdKRc67lngVqaQE8Ao+Hx89KGHDT+ZRT19lhdcFi
 zq+tuk9YONPvRyWcPrfobXc3m84CdXuUceCvy7J1XTgWcFh3maEC0InDeWE8vURUd/Gr
 xYNsDsQ4z6eFe4VQThopHsYfkepwhdJYRe75q7520c8jD0ZtG/AFYOMf3I10Q6Hmj013
 AVGh+y3Zh4ps2QRrl9Ba59GlvDZVCHXx28zI6frOSQ7w25D/7xmh87g0RCdNUeVmuNJr
 vEIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNNOr0tJXMzLfv/hPt3TNy4vl7j1ILtEZaSySGP6G5PzTI2W99X5tMyzCCbc4+PKbtW2V4A8mfgIM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtjWWBtYYE8MDccRgT40SxRrKEpN+oK61izopJ0YgPFFCov0ZR
 XcgC8+yvZ2VoCSBu9zmWuNr4zcOXbL5+/OxSp2utpMc5zt0HQUVYkORCtxOu+hB23qIxlIXUENv
 L7Ta3fIYFLFKPWT4F838A/l1SqOvPw7lUl6fX3Pfm
X-Gm-Gg: ATEYQzxr4BjEQzDY+akcZSaAVKcjaP2vHGWWnjLvnbQS7ijE8baeYxBq9hZrBp8iD8k
 D3uCK2s8+fkpwOSgsm7lJEzKmp5BDU36wV8gB0LbhNJn1WfiYnh0C4QQizpFy4xKaQPs9YNskB4
 fO/yG4CHF+lxIlLITcLxkljKJaUC5U46qJ1Tf3lwD7ibobUPC5qWMtn6qVy+jU0nycD5joq3Wi4
 TD4kC0fixMD4e+UWAZDKl98nnLQ2fa6GwDp8jwKDB7+olRuLKhqQVF7ufvbL8+G50xByzwRm7cH
 FOvbGrvpdHw5SmAyA0gGmy0pP5G3I4LWIcDOxP9xjSs07u+gLNx2Xd62pDVlhx6B4sFTKg==
X-Received: by 2002:a5d:5f43:0:b0:439:ca85:8848 with SMTP id
 ffacd0b85a97d-43b527aa344mr6004289f8f.16.1773844284463; Wed, 18 Mar 2026
 07:31:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com>
 <46986da6-8c89-475c-8561-964adaa7d034@nvidia.com>
 <abppV3e91iVzplcv@google.com> <DH5UOS96171T.Z8XSRX583Q60@nvidia.com>
 <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
In-Reply-To: <CANiq72=bmJ_GWKowAgv+DWQ8FcWK_HePwjaVgeDmRH+gVD-z5g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 18 Mar 2026 15:31:12 +0100
X-Gm-Features: AaiRm51O3ZORqMPG2oSnP3bbIvsHXlypg7QXuPo86XIFyKOog2BgXzbGuVDuzJY
Message-ID: <CAH5fLgg-kgeBw3Py-EZmAEJhm357u5NJP6na4qJe8v3aeFW5Cg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
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

On Wed, Mar 18, 2026 at 3:21=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
> [*] I would have preferred a middle ground like  modules being inside
> but repeating the folder name, e.g. `.../pci/pci.rs`, but I doubt that
> will ever be supported upstream since one probably wants to support
> the other ways at the same time.

In principle this is possible using

#[path =3D "pci/pci.rs"]
pub mod pci;

Alice
