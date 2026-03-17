Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5FFAF33805
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 06:52:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A0410E340;
	Tue, 17 Mar 2026 06:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="q3nF+TF3";
	dkim-atps=neutral
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com
 [209.85.208.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D532410E342
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 06:52:21 +0000 (UTC)
Received: by mail-ed1-f74.google.com with SMTP id
 4fb4d7f45d1cf-6641f13b1c6so3388857a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 23:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773730340; x=1774335140;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=FV64adRB9qOuDZltuxVkHORmf9URma8WDk8N3r49JmA=;
 b=q3nF+TF3VaiJ0tQYnhZzGu+ov+JTB6akvHBAQZAuujL2iB1HdsCc9BQJsS65PQpS2C
 AGlyJn+pBwQ66Mx1WsDWSloxGXL9vlTGRUJ+pxcAwGDBtBpPeeBBwa0APq4fdSEH0Rs6
 0SbQl1ZRui1v/OJAVCZhxZBQ1WdgHtpnv6WFu/Du3pYui/8qfdZK5S+IQEsTonozLsSW
 Xxcj1GA92nY/drszk5ZoV7hlY3aufHWGRjcD/ZmQBcXkl+YaoW48MLEdVidi+v5SvuzI
 ILhKjolwh1+Den8S4LmaDZTH7YQrMqE53hYSOi/B1apz4Z8+MUy3Dr7pyzAaBmZRrFf4
 L4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773730340; x=1774335140;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FV64adRB9qOuDZltuxVkHORmf9URma8WDk8N3r49JmA=;
 b=Rzq90zbEK98WdTBdSfeb6H76A7ekYGxprIWQ9fB3AHD/bhSJOK1k6NA5nfyPv+3s6X
 CqIF1fv/4AtwcXnugdIe/n7r9krJM5FHIbjhf/oRpgh1bz9Gzw86Cj4fLP4hNIcCKeBz
 X09gcEdbivujIVN1ww57B/NQgSzHsi8AG8pcnrYpTX92h3wzQhElVd08wjrXTuDQu0pw
 QhQXfYVXCBu7bc7BoLX3LasWoP4V9LpqFO5zx6c58wa2GA4d3OUL2FezyX/U36lEvuDn
 4kllEFE04IDLBjTB9XyLqKA3qAEjObW21yavs+4IYtDvgnj5BkyuioNUoBetwPUp+3gO
 +xYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTYQyJFraBH1o4RyHXplKg0cfkMeretoQ2hdPh8yQ0rX5Fsu8/etfpzBrvUq+kpC7A7xPDM6NplUM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk3/EIjlLySrcYWZ4968sde8j4IbXyQXgE8BfyKwC8jdsHvnFX
 3Nngd2SiLovXZn3843BB/tPXfV/JZ50r0He458YVLd3c9YioKY2pTySFT4x86S6OUuKfp8uAoQ1
 0WVHNUWcBVXvKC0vUYg==
X-Received: from edrd8.prod.google.com ([2002:aa7:d688:0:b0:660:cd0d:914e])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:27ce:b0:663:8841:17c9 with SMTP id
 4fb4d7f45d1cf-663babc44ecmr8734757a12.10.1773730340157; 
 Mon, 16 Mar 2026 23:52:20 -0700 (PDT)
Date: Tue, 17 Mar 2026 06:52:19 +0000
In-Reply-To: <20260303162314.94363-5-dakr@kernel.org>
Mime-Version: 1.0
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-5-dakr@kernel.org>
Message-ID: <abj6I9c_2IR0cKJ6@google.com>
Subject: Re: [PATCH 4/8] rust: dma: introduce dma::CoherentInit for memory
 initialization
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: acourbot@nvidia.com, ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, 
 robin.murphy@arm.com, driver-core@lists.linux.dev, 
 nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Mar 03, 2026 at 05:22:55PM +0100, Danilo Krummrich wrote:
> Currently, dma::Coherent cannot safely provide (mutable) access to its
> underlying memory because the memory might be concurrently accessed by a
> DMA device. This makes it difficult to safely initialize the memory
> before handing it over to the hardware.
> 
> Introduce dma::CoherentInit, a type that encapsulates a dma::Coherent
> before its DMA address is exposed to the device. dma::CoherentInit can
> guarantee exclusive access to the inner dma::Coherent and implement
> Deref and DerefMut.
> 
> Once the memory is properly initialized, dma::CoherentInit can be
> converted into a regular dma::Coherent.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

overall LGTM

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> +        let ptr = core::ptr::from_mut(&mut self[i]);

&raw mut self[i].

Alice
