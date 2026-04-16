Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7E7F88089
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 06:59:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E6610E81F;
	Thu, 16 Apr 2026 06:59:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="olbFbP2L";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450F310E7D4
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 06:59:49 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-488dcff87b7so33560515e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 23:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776322788; x=1776927588;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=p5aFmDnuvFPblx4c0gjd64DFbv9jYF68Xx/BpImY+Xk=;
 b=olbFbP2Lb/9kizgBo497Fw3QGvXdDCqDzdZuR9w9N2K0hHz2TiB1KtAnAsTWFd4Qnn
 zpreUqXBtdzutC/FieG3huY0Lje6WQO1hCBS+EHaJX1iuWX/BJngodDflycNQDtqb34P
 DMtKnUHi69sHLqFqiFZIWHDQ8xEXtuto8HE7NHZjDHdc/YYK8wgeCGA78Cu/M57tSb+K
 ImlM+erwuoGM5Ff6l25ZIVU7BgNCIdiRre28nwJ/M3q09id/W76YigQZCJyBmWc9FClf
 lnlQrJQoCTL5ifEwhspCSWm2ddPCvUDyDjSwSkYGaFl4cr8CKKIJxATTy2U1/TjG445X
 inuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776322788; x=1776927588;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5aFmDnuvFPblx4c0gjd64DFbv9jYF68Xx/BpImY+Xk=;
 b=BSVP2km7E+KCzI2x2VPeknXF//mO/rp/13JV1XiR9gImt089eM/wOKRobjTnQQzGOG
 rqyu2/W+4PRQ/Tj11rXtSBLcb7GeX2bqFaQA9bYUuHffq/SQzZYNzZnCZWnRJv9yEN8M
 ZJi2SAIfctE5rn07XLRRNXO6vX1TZSRr0eRYDR6UDo8nAZCqq32pwabPYFoLWmgdr7cZ
 QNDGufpnLELeQq6c+pZ06RBOF7+vzBtvorfsk9kgbF+KpQjwJ9kmP2D2tjs2koyGGtXO
 2NfaZPp1PAfL1Pje0M+fZ+/q9jbtXc9WcbHmx6QuXti3nBqykee4N3wq/bLzKiHXmH6N
 H+0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8o3Zq6JB1dYDmlGCdB6BJHAwckJTbaLsM08pK4z/kjdRk/8k2etAFTU5B//oivvzyTcw3+OBv7ci4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy/dxU75bJouPch0VjalMm0zrQzX3UU3xcler0T3zcwDe53NsAc
 PEYa3SRlAWh318qwI3oMv4/vV0M2bMOcmqGc/iIZseXOV0FcnfCt1hNA4hljfv2XCsngI+I9Ww3
 WdwRWkddXWQ/mZWfiew==
X-Received: from wmbgz10.prod.google.com
 ([2002:a05:600c:888a:b0:488:e127:aca1])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a415:b0:487:1108:48af with SMTP id
 5b1f17b1804b1-488d67bf7c7mr256452475e9.4.1776322787516; 
 Wed, 15 Apr 2026 23:59:47 -0700 (PDT)
Date: Thu, 16 Apr 2026 06:59:46 +0000
In-Reply-To: <aeBM8fTW46H9RNg7@yury>
Mime-Version: 1.0
References: <20260409-bitfield-v2-0-23ac400071cb@nvidia.com>
 <20260409-bitfield-v2-2-23ac400071cb@nvidia.com> <aeBM8fTW46H9RNg7@yury>
Message-ID: <aeCI4giN1TEL_uJn@google.com>
Subject: Re: [PATCH v2 2/3] rust: bitfield: Add KUNIT tests for bitfield
From: Alice Ryhl <aliceryhl@google.com>
To: Yury Norov <ynorov@nvidia.com>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 Zhi Wang <zhiw@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, driver-core@lists.linux.dev, 
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

On Wed, Apr 15, 2026 at 10:44:01PM -0400, Yury Norov wrote:
> On Thu, Apr 09, 2026 at 11:58:48PM +0900, Alexandre Courbot wrote:
> > From: Joel Fernandes <joelagnelf@nvidia.com>
> > 
> > Add KUNIT tests to make sure the macro is working correctly.
> > 
> > Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> > [acourbot: update code to latest bitfield! macro.]
> > Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> > ---
> >  rust/kernel/bitfield.rs | 318 ++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 318 insertions(+)
> > 
> > diff --git a/rust/kernel/bitfield.rs b/rust/kernel/bitfield.rs
> > index f5948eec8a76..9ab8dafff36c 100644
> > --- a/rust/kernel/bitfield.rs
> > +++ b/rust/kernel/bitfield.rs
> > @@ -489,3 +489,321 @@ fn fmt(&self, f: &mut ::kernel::fmt::Formatter<'_>) -> ::kernel::fmt::Result {
> >          }
> >      };
> >  }
> > +
> > +#[::kernel::macros::kunit_tests(kernel_bitfield)]
> 
> Reading the Documentation/rust/testing.rst, and can't understand how
> should one configure it to _not_ build the tests? This should be the
> default behavior.
> 
> There's half a dozen already existing unit tests, and I didn't find
> a mechanism to individually control them.

If you want this set of kunit tests to have its own config option, then
you can declare a Kconfig option for it and do this:

#[cfg(CONFIG_MY_RUST_KCONFIG_OPTION)]
#[kunit_tests(kernel_bitfield)]
mod tests {
    ...
}

Alice
