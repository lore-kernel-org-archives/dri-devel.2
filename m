Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3249EC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:14:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8928C10E586;
	Mon, 13 Jul 2026 08:14:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="L4zWeZ7i";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00BD810E586
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 08:13:59 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-4744b72f90bso1482851f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 01:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783930438; x=1784535238;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=CzA7AdLdyanHGDYnO7UeyFW4jvO3vgqbYi0TkaDMqeo=;
 b=L4zWeZ7ilcZrg6/bWzIAe/IZZPJV9EqMt1rAxdDHDSk4E1hz/QWNYf9Vfb0LFXkoXN
 /DSrFlUzwHydYvyKyvUw0fX34dweoRnaHiIj1+wiZRcfJJAi+z++cVHL6hSsklXyL8+v
 pKWuJqyBLWPiL7Y+SCqSSHwLQf+4FMbS3ZZFabB/Lbh218pliySPzSc3KDfco1KaKQti
 FoGi7eYzsJC9VND2tec694iIpuAMsKjs0JUBcyM6fvnFRNs0TMqTcPHHDw90od/dEYgw
 /a6qGXVIJl/1/xasKj0iY8DEQU+8By7Z2bf+t/odDHw6Xc0C9t5BVez9ABK21tNt9STv
 JyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783930438; x=1784535238;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CzA7AdLdyanHGDYnO7UeyFW4jvO3vgqbYi0TkaDMqeo=;
 b=grupAqooAjhuwmaHpFyEIx0jcbHl/QGXJMweN+E9oEF4HjpBovOGGRc7ssdyfBrbRr
 4IEoSAIOJz9WNtvOUoRezfJQj/UJU2n/Q+OCJogRRu0+7bMGt7bgiJcyiERGJjbkQza2
 Tm3NliZHj6N7l7AQ/IfxV+JBIaSmCEgyGHw03M4WHhgpOS5R6WphvwaMRSDSmPK/59CJ
 WY2/u28Td5kNQ4r4nRPI4IKPUShfBfgdqfGDr7+/rLZdostyNIMZ3TQPBaokI6q+qMdd
 YQzBuZnJoj1IIoN0iJJR07+7gbFxzaZMLurjHEhLxSCmLz36UbMozaQY0sasZ82PAB+/
 ZEyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGIqTDScEjSVPAAP/uMUjtN+xdpK2x19LSniRZG8nHaddr60pyRYSLCeIZsnAl1Vom9skSJYcYK68=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwId+d1DD5Y+OW4t65inRu+CsWYevpGlW/T8EfzIdGkP7T6M4qp
 swEX7gwp0lUQqodD6YwaxkHABgV9V7CoD8AB+83XIYJ4lLsd8bBkLpfPgC1QIZVjeNxEasglKZA
 1xjIg7v5t/C803VqhGQ==
X-Received: from wmbje14.prod.google.com
 ([2002:a05:600c:1f8e:b0:493:beda:c864])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8710:b0:493:e81c:fc9 with SMTP id
 5b1f17b1804b1-493f87e5198mr88665935e9.15.1783930437954; 
 Mon, 13 Jul 2026 01:13:57 -0700 (PDT)
Date: Mon, 13 Jul 2026 08:13:56 +0000
In-Reply-To: <20260713-fix-fops-owner-v8-8-2495cfa82d47@linux.dev>
Mime-Version: 1.0
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-8-2495cfa82d47@linux.dev>
Message-ID: <alSeRIaps6QSqxJE@google.com>
Subject: Re: [PATCH v8 08/10] rust: binder: use `LocalModule` for `THIS_MODULE`
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

On Mon, Jul 13, 2026 at 02:45:29PM +0800, Alvin Sun wrote:
> Replace the `THIS_MODULE` static reference in the binder fops with
> `this_module::<LocalModule>()`, consistent with the move of
> `THIS_MODULE` into the `ModuleMetadata` trait.
> 
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Most other Rust Binder commits use 'rust_binder:' prefix rather than
'rust: binder:'.

Alice
