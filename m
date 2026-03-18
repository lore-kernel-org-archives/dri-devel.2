Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 093311077609
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 18:57:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 649A010E715;
	Wed, 18 Mar 2026 18:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hls9sLPd";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B602010E72E
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 18:57:27 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2b8095668ebso7422eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 11:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773860247; cv=none;
 d=google.com; s=arc-20240605;
 b=L8WzMzEuTIchIDjdMrPvhkILkFMP7C4+p7gdU1NauUpXBYqYqt21Pq8PU3ObMddY3b
 F6aDSOTosIpXHBhQwX250rX76zStyKC8gXA2Cbd7lhK+0SzH7W56yM2WbgqsaWjxIU+5
 YldguNjbCLZEaIbVjLPzJTvh4sL26S7dWUDccyMtHyw9TiC71Q6+N+jwAEqc75g1UQ7G
 6m5T0Q5P+fc5IGsPNN4UznvHOLdRewHmJDGi+YfCKGV2oAK42iUlQNRcjxlwDOOif5Yr
 18GLZ7MMdQRjY1hinAm3F6Qi0ZUsEgXBlU/3lNoU2Ob1pqcMgQiY/cbP7H3f4IYILCt2
 H4tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 fh=4wyFo5ecije/E3YEEE+o8a55DyXjWo+F1GO2RkP2sS0=;
 b=S0r0uNA3zVYQsHbqBbUmkf+JLT+rsNmBhBHfFxyGRfzZcGAzDWjRCMSNmvrFh1TeH7
 imv54LOzjOEj8NhYnkrcuA/u5ayRQnit7jK854csqpUmr4SKNk0sEDrIHI4R9BnPdv9J
 uGhrqAb3s50s3d03hbmjqr9CUpRdLyFjsYFfcNHiM2/jqTLxQd+XVdE/j9dMXYT/xb1M
 m9B4x0HFUsJNi5jFXo5gJfTs5fZoNA8bN2L8TfIiPjEo4RJsi0UXZDutcPs3R8DF/IjP
 Pft5UPdtSF4hPdeoaTIRAled9EfjRDXdcZF0UZsdY+cbqpsdGGG74Nt+Ei0hPOksWFwg
 48vA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773860247; x=1774465047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 b=hls9sLPdPRx7gKm2di3aMw2U4eOoEz7UL1WQuwlgmSVnwttmdt5y3dmL6ifcOEIPm6
 vrrOEbeNXy3TVfnEm89bUrAf2dQ2n2Hg7X5bICkUMdC1wuJgnDVthMzkTACUH0dki0Pa
 ba8a7Yr0Qd5tu4BFRsVH/vFH95M2ttgA5ZlLadSrmsZTog02L1DjqGm1IKAk9IyBp3Kf
 7pq9Uem0z0W1RHuHX3+FZyMXfWHEcl04Ue1fqTnqdjs3o4ftWaGArAH66masDZ8xzSm/
 4ZPs2eD8zzbFGTW5Tgn7LwbRB+LF5nwVfebtJzIv6vm3rVID9I5dt03Z0uautMoxF6oh
 DK7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773860247; x=1774465047;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=d3bcHjPGT0Fov9B4KoCksRHw66Y8wxvQ5LjIruDyWqI=;
 b=f3eQILn3PH4cZ0WXHkLxQDGlk9/SC2rMHiyzck73tpV5drp7Twjjo2oOji+Z+VWID2
 TVkLKlJSeLqmnnaPdc7TPAAkYNiIf/eM6mLB2dIitDEN+7fwfUgSdEyyjA37HeD4YEGz
 6cJCdbTSKsBiZAvg/F8CJIHZvxcbB87e/6zXD2UsXBjsj8CV39Mnzbrm0KCBhObtwQ0X
 8V/g6H18RsJylSfxP6ATGx8sMBrzzAMnB8Rz5rTKMeMJb+FFf6xoG1QlWiD50TquCofg
 rS0PxShC32Xi1EA+eXbprw/J+4tY4epBphNpIquZf/KFXE91JLuuIW0AgZmH7OrrF0dn
 ctsQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWN8vekUkq105ogE66++PM6Sl8iTdwkN6dzzE+gHK+TO+uF/1sjCF0QmB/kOMjhHvYTR5aRdehz7E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyz3Jxr0YzO/e4WGwlzIGKmrlOxk7rKEk4lfbcX5KMncE1PcXga
 3Ent6NMePM0OlkXRNhj4awCEMihThVTq49wfGOmqCfxPCjOmK7T8VYrsTK9RMAEvJ+3sqcrLaWj
 N4CRLXnbIldcKQgkTthWcL1hPrINQUiM=
X-Gm-Gg: ATEYQzxAD2Xg9zz67KbWF7K1nx3mjH17GvRI/CB6sXVf9xH0WfaQypQ/tqkuYQPxujW
 rCjJHhO697AE66J6w1jC46lE3RUjJ/lppy2qrLvdB77OF2zo0dAqtD/DJVfBRPIoxsfctkYn16P
 G6LcfHVa2hu182VAz5rl4V3PmXLFDD1UsU9ysUsGNC5onKyvvV0a3SgvhDy7g6wKuOqYYtzx87s
 F2z+0j060r+M0ZaaOKLA0Kth//PIkLhzBoPALQQtSUMnASa9ui1ja9QEMW0sB1k/AJW2kfnhrP/
 oSv5yl3lU1ct98qSnQae5W4Jw3OeKXeqY881qGdpMOIMgmL7nftNWDj9gPjWkNqekFOr69zD+v6
 MkBQWd8oJ+COd7q6tONeT+XE=
X-Received: by 2002:a05:7300:f191:b0:2be:9886:d4ff with SMTP id
 5a478bee46e88-2c0e50fefe8mr982481eec.2.1773860246896; Wed, 18 Mar 2026
 11:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260317201710.934932-1-joelagnelf@nvidia.com>
 <20260317201710.934932-2-joelagnelf@nvidia.com> <abqdUBqchnVFo7Qk@google.com>
 <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
In-Reply-To: <71b6a115-98f1-4b09-9c04-a99349f51e49@nvidia.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 18 Mar 2026 19:57:14 +0100
X-Gm-Features: AaiRm52hIUr0vzgoavDmbzyJmg3hgU_AUfgRxMfUiR8zNc5S5daML4wMbNTdaCA
Message-ID: <CANiq72nZKx7pw_rZK2mHHvR=TaeGvMRvg5GTHOd58X17oyxieg@mail.gmail.com>
Subject: Re: [PATCH v13 1/1] rust: interop: Add list module for C linked list
 interface
To: Joel Fernandes <joelagnelf@nvidia.com>,
 =?UTF-8?Q?Alejandra_Gonz=C3=A1lez?= <blyxyas@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, linux-kernel@vger.kernel.org, 
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

On Wed, Mar 18, 2026 at 7:31=E2=80=AFPM Joel Fernandes <joelagnelf@nvidia.c=
om> wrote:
>
> Anyway, the fix is simple, just need to do // SAFETY*: as Miguel suggests
> here, instead of // SAFETY:
> https://lore.kernel.org/all/CANiq72kEnDyUpnWMZmheJytjioeiJUK_C-yQJk77dPid=
89LExw@mail.gmail.com/

So, to clarify, I suggested it as a temporary thing we could do if we
want to use that "fake `unsafe` block in macro matcher" pattern more
and more.

i.e. if we plan to use the pattern more, then I am happy to ask
upstream if it would make sense for Clippy to recognize it (or perhaps
it is just a false negative instead of a false positive, given
`impl_device_context_deref`), so that we don't need a hacked safety
tag (Cc'ing Alejandra).

But if we could put it outside, then we wouldn't need any of that.
Unsafe macros support could help perhaps here, which I have had it in
our wishlist too (https://github.com/Rust-for-Linux/linux/issues/354),
but I guess the fake block could still be useful to make only certain
macro arms unsafe? (Perhaps Rust could allow `unsafe` just at the
start of each arm for that...).

Cheers,
Miguel
