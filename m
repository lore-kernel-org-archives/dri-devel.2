Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F87C44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B52CC10E037;
	Thu,  9 Jul 2026 09:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="MCVeMoLD";
	dkim-atps=neutral
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com
 [209.85.208.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 384AA10E037
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:01:32 +0000 (UTC)
Received: by mail-ed1-f73.google.com with SMTP id
 4fb4d7f45d1cf-69af1cdc95bso1198353a12.2
 for <dri-devel@lists.freedesktop.org>; Thu, 09 Jul 2026 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783587688; x=1784192488;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cKWh2FN+uopuAMuLcrvUAZLjx2pCwGenf//G8cQsjMQ=;
 b=MCVeMoLDdj8UtUUns6vzq85Iro2qI2T9O7dRUfopdpZzHa64pY9kj2RLvaSOHnxiav
 eXyENFgSVh/kI/DrjCml8Aqkp4urySASq+NwnwbZ6giCq5SiB9f3NSGi6Td/07BXh2OC
 gL6LPmFoAnmYzIlGat9qKt0p4jmhHYB3aTSCfooOr6hcC3PgrCVwwXTRgPDVCxPmWyno
 /KM7QDdnyMB/zs1fYmHXT7HTUAYe6s1Jt/3aBb1V+I2me7a7fpD5TXtHpHLToKj967Oc
 7v525sqFTMpDOtLQw7SRpqkCp+jc4lv39EDJ48kq1D+sfkSssSwOqHbWV210KCp1ZnP5
 gqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783587688; x=1784192488;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cKWh2FN+uopuAMuLcrvUAZLjx2pCwGenf//G8cQsjMQ=;
 b=ElWuHbszjKeDPdQ3bKlidFNmTlNOchszmXymBsTDO3z0iJpapQFEnXvPZzw6RH1mSj
 iLxG4gHMXPZ0OUkokb0iVRmMwTUIgxKTP4niP5BV2LN+jiY3DypWY7zPdZNTjJ+sPg8J
 aS14PPVnbblC3WYJVvFXhMGCyGk+2Gl0ChQtDvqUcRGgQ/RVwahJqSbxw6gbOw1JZ6qD
 UYcaoguF7JK3PzUn3H1Mb2lmXFkq5ZUjcyTTyds7uTvbDDQtEadzvlIktsKkoZ5HX2K/
 pGfJ+1hj2yrZO0FohaOEPq1YAGUU8Mum7XnmuFnCF6fFs80vs5IVhP7h3k+zlFC/WAx3
 2XXA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvrgXRqOlaigBnW9Uj0YrBGfwNCmxELHShOouZ7bJ6hUHOj5CZqiuKoWTYdD/tX4B3boZbKa2WKC0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzGG4mon26qYxG0hIvvWhVflYjTZQzHMvCIfPGOqdNXYMvRgAo5
 jJizNCPW7ku1GIrjv6fG/43SAhYxDvkX6GvX4W26NVxU724RKxtPafDb0vmyjNdUIFF0Bk4RPx1
 ymj+5q14HqhDAISDreQ==
X-Received: from edfg18-n1.prod.google.com
 ([2002:a05:6402:a252:10b0:69b:3a15:6755])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2b9b:b0:69a:57fb:4783 with SMTP id
 4fb4d7f45d1cf-69ab445ed4cmr2326024a12.13.1783587687331; 
 Thu, 09 Jul 2026 02:01:27 -0700 (PDT)
Date: Thu, 9 Jul 2026 09:01:25 +0000
In-Reply-To: <DJRP4CD15MC5.J47HDEUJS7V1@garyguo.net>
Mime-Version: 1.0
References: <20260703-chid-v1-0-84fe8259e46e@nvidia.com>
 <20260703-chid-v1-2-84fe8259e46e@nvidia.com>
 <akvXzPd169ahMuCi@yury> <akvkNuh2bHhFwmQM@google.com>
 <DJRP4CD15MC5.J47HDEUJS7V1@garyguo.net>
Message-ID: <ak9jZe11r-A4oVf0@google.com>
Subject: Re: [PATCH 2/4] rust: bitmap: add contiguous area operations
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Yury Norov <ynorov@nvidia.com>, Eliot Courtney <ecourtney@nvidia.com>,
 Burak Emir <bqe@google.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 John Hubbard <jhubbard@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Timur Tabi <ttabi@nvidia.com>, 
 Zhi Wang <zhiw@nvidia.com>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, nova-gpu@lists.linux.dev, 
 dri-devel@lists.freedesktop.org
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

On Mon, Jul 06, 2026 at 07:22:27PM +0100, Gary Guo wrote:
> On Mon Jul 6, 2026 at 6:21 PM BST, Alice Ryhl wrote:
> > On Mon, Jul 06, 2026 at 12:29:00PM -0400, Yury Norov wrote:
> >> All three are the wrappers around the regular outline functions:
> >> bitmap_find_next_zero_area_off(), __bitmap_set() and __bitmap_clear().
> >> 
> >> The inlined version in headers is optimized for small bitmaps. But the
> >> optimization is all based on inlining in the C code. It doesn't work
> >> if you wrap it with a rust helper.
> >> 
> >> There was a discussion about the similar find_next_bit(). The function
> >> itself is an inliner, but it's a wrapper around the true outlined
> >> _find_next_bit(). So we decided to minimize the binder size for that
> >> type of functions.
> >> 
> >> Please, keep the binder minimal unless necessary.
> >
> > If we can just call __bitmap_clear() without any downsides, then I agree
> > we should do that, but we actually do support inlining the helpers now.
> > See CONFIG_RUST_INLINE_HELPERS.
> 
> bitmap uses __builtin_constant_p which will only work with pure C inlining and
> not LLVM IR based inlining.

Ack in that case using __bitmap_clear() from Rust definitely makes sense. Thanks

Alice
