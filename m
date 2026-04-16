Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC51EF8808E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 07:07:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 214D010E81C;
	Thu, 16 Apr 2026 07:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="koq8gCOO";
	dkim-atps=neutral
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com
 [209.85.128.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06EEC10E81D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 07:07:39 +0000 (UTC)
Received: by mail-wm1-f74.google.com with SMTP id
 5b1f17b1804b1-488c2aa6becso61509735e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 00:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1776323257; x=1776928057;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=OjQRj3BbickNf0HB/Z2DC2BFmyenMexJ4QcHYs7WLw0=;
 b=koq8gCOOOUCi4JKX114j7+WGbX83jiwE+5J7tiJmrmI6WxSAS9uvwzVwKQ3xvkue65
 9MIuQCzy2dx0fOlUyd7mHQMAizPjGl5Hke2JV0g7aXa29Vas06lEkrBNLQPFtoY3b6kv
 mQP7WbVI4+f1ssS2Vu5TgbTRnE/885v08eqsSEKQCqFSj42YVpP/76roqpep2LF1b2nv
 zbn3YZ7wLMaAMdO3nXB3n8PEKZR1cWb68FsEUlsB51u9Q6k+pJifXwnspegDoGCJLiYF
 bucBMOPpzgOttffaYe9u6a++/YP8yHLDRbPwcFzNW6Y/SdDvC7lAPCUaVOtCugd92xRL
 +2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776323257; x=1776928057;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OjQRj3BbickNf0HB/Z2DC2BFmyenMexJ4QcHYs7WLw0=;
 b=BizEHPEFkFdsztfiYXXt1kk74thJ5rfcLGmcFh3aYT3reqdct3X+q56e9iPbpZSf3x
 JWPisQf24/cQVSgQglrpVUgV6AIU+5s1jbSP8oMmP6F32Ca0ZhY6nH24rIlw3NjN9rtu
 aip2kKtIqRgWtf+dMPqdPMij4MtuJIsghF45zE1H59qgzA8/cmIb94G+IBLKAv22uuWr
 Pyw3Q4LCbq2x/d8hzIl8BrvXx4J2rSfjS2DMochtKf1h1727JQy++qgItVTBmxC2qjrF
 ZJOsX7lXUCI9ElGB5LB7pvTq+9G6Un9rp55TpgIVDx8U3nwG9n2fWr6QW55oi0Fi7iRq
 adtg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+E7u4VpVOfev1lWzOT14AfdGCtlZLRDsXVwOJTk+TIwsi4F4snjbXhMOrXrIMzvLxemGXDxzVmP3I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLVtiiloAOHgqcfbu85sFf8xEpoEgp3s+IFRXj/WpE5u7JjRAI
 wW2xA7D/U9bWTpLi6gYYpiz2Paomjj8DhJwJebS2Kmlui0D9izOOYGkXeJdpiQixbRitXgZ7k7N
 J0QdphvSQgf9fhwqIBg==
X-Received: from wmop6.prod.google.com ([2002:a05:600c:4686:b0:488:7f1e:5fba])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b6d:b0:485:9a50:3384 with SMTP id
 5b1f17b1804b1-488d688209dmr315526135e9.25.1776323257405; 
 Thu, 16 Apr 2026 00:07:37 -0700 (PDT)
Date: Thu, 16 Apr 2026 07:07:36 +0000
In-Reply-To: <20260415-projection-syntax-rework-v1-2-450723cb3727@garyguo.net>
Mime-Version: 1.0
References: <20260415-projection-syntax-rework-v1-0-450723cb3727@garyguo.net>
 <20260415-projection-syntax-rework-v1-2-450723cb3727@garyguo.net>
Message-ID: <aeCKuBOrhHWtGvAF@google.com>
Subject: Re: [PATCH 2/5] rust: dma: update to keyworded index projection syntax
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Danilo Krummrich <dakr@kernel.org>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Alexandre Courbot <acourbot@nvidia.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Wed, Apr 15, 2026 at 08:57:13PM +0100, Gary Guo wrote:
> Demonstrate the preferred syntax of index projection in DMA documentation
> and examples. A few `[i]?` cases are converted to demonstrate the new
> variant.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

