Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECFFC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:17:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA4E410E85B;
	Mon, 13 Jul 2026 08:17:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="nik1LZEy";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A73B110E0D0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:17:12 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-493bf840a69so20692205e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783930631; x=1784535431;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=e7biIQWq4ayHoPrEIMSf8dlPvUrUBRV5RYriupriJE0=;
 b=nik1LZEyOLeFJKshh+dzlYBkEq8y3KRSDuC8f1lFV1D3C3pTIt2a1l36p/qZcKg2vg
 DQVWTx1DyVHItpvDIRPUJVm9GEX5nw2O3aWoqt+jT5B1/NJrFJq5W0gbJKuNimklEL9V
 31mEWgu3TqCcmGUeRGHAUwvmaaZNjj0ej4JSyHQBTCxx+R+7yekyiKRYABzC4Sc+auGn
 pffJtRxq4fXvkvVhjt0REO8+eNYUmy0k5fg1o/gHWIKYeZggB7bMLpWUvIfiaCtnhFkB
 b9BqgmuMYLzENitdLgTfSL7mN948XKutV+i1ptgN5VWgrRhVgtWBdzvuASiLx77HqfKe
 Bn0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930631; x=1784535431;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=e7biIQWq4ayHoPrEIMSf8dlPvUrUBRV5RYriupriJE0=;
 b=Y/QADAYyoRahJCaia9ldlynx+Q3Anyve04a+TjQV0opicXnIlOjYIMF70D6wRJ8Ya/
 XSD3dy4cWW77JWKfRASbdj3xVeelJOu2u/L3hLFBL7NRWc0djw1XMZvvrA6us/c9KJSi
 EtHA6V1nEglUOARxQ+AJk/rhCcH93NI6LFTJSRXEKSJxmcYuzIWnX0NreWuGFB9umpx/
 93GlPyhHWYGdEbWHJyzOvelodfWCGqK5fTxZlghTMk9hBbpv70lvdjpZD+E51Cx+6iag
 Im8iBXwHhSf1WTT5QCx1tboSOK1G3mVh24OnKieZQtx0+iqLu+L4w4VEvrcezTMLXKks
 eK/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqScJkkEmOPWkFsOvLBUUHgnTzpMHCusPooYXVPJje4FMhhfoEyJMdeoTW68VunCljEwZz9Oh/UNDY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVFDFpVyBHleTEmmxtRrJgVO2Wblb09SNmK29yrJLgqcdsCtFv
 1j3PIfw2JXOhZJzfiQjDVPwm2Vj0Wixf0Ys2LobCkIUbAZbI3oigNJEW2EGkdDtGoY8u2Fd+6sx
 klZ2kGaLAXIcML6ltMQ==
X-Received: from wmpu18.prod.google.com ([2002:a05:600c:4d12:b0:493:f522:9fbe])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f91:b0:493:72d3:4a81 with SMTP id
 5b1f17b1804b1-493f87e5bd2mr75050475e9.16.1783930630723; 
 Mon, 13 Jul 2026 01:17:10 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:17:09 +0000
In-Reply-To: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
Mime-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
Message-ID: <alSfBXoFjX-W_Ch1@google.com>
Subject: Re: [PATCH v8 00/10] Fix missing fops.owner in Rust DRM/misc
 abstractions
From: Alice Ryhl <aliceryhl@google.com>
To: Alvin Sun <alvin.sun@linux.dev>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, Arnd Bergmann <arnd@arndb.de>, 
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
 Rae Moar <raemoar63@gmail.com>, Breno Leitao <leitao@debian.org>,
 Jens Axboe <axboe@kernel.dk>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Igor Korotin <igor.korotin@linux.dev>,
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, 
 "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>,
 Todd Kjos <tkjos@android.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>,
 rust-for-linux@vger.kernel.org, 
 linux-modules@vger.kernel.org, driver-core@lists.linux.dev, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-pci@vger.kernel.org
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

On Mon, Jul 13, 2026 at 02:45:21PM +0800, Alvin Sun wrote:
> During tyr debugfs development, a kernel NULL pointer dereference was
> encountered after `rmmod tyr` while gnome-shell still held /dev/card1 open:

I left a few minor comments, but otherwise LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
