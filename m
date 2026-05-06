Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C66E6CD3436
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 12:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 191D910ED67;
	Wed,  6 May 2026 12:42:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="B72gNlIh";
	dkim-atps=neutral
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com
 [209.85.128.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D9F910ED67
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 12:42:30 +0000 (UTC)
Received: by mail-wm1-f73.google.com with SMTP id
 5b1f17b1804b1-488e097a270so37424035e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 05:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1778071349; x=1778676149;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=GgVBoDfFSnA8IrE1su9Kgw5EWmAPu4xV1AP/RXJBkOw=;
 b=B72gNlIhD6ytwhl5o4QAn5aDS5CFKyogJJeoyymSPOoJQz0mr90P0c8Vboy08xurWa
 ORtJ8xTfiUcViSdp+o1SPYOYt8zoH3hAeQ+gX15bC8NeLoLEVHTw9ZU+vcTFSjM/GCe7
 Ex5bMiCF2KEsW/LI1IZK1kG4T3A4o9bjshNvmSGdczlKsnl379gFgCgeRFLc32zJIKXM
 VOMzRlGVVeKOlOU598eq53zvxY/zoi9IcfG3m4SQfXRSKrkYH58kFoFxWFzbm3JDKuxM
 /sbYpfS5mY3A6sFHiWxcxlNAhPEWAXbcWegkdmCSug3GIn+/jfef+9ZhNCK7oY5mI2Ut
 hM2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071349; x=1778676149;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GgVBoDfFSnA8IrE1su9Kgw5EWmAPu4xV1AP/RXJBkOw=;
 b=JdncQr7QneOwjODtJXKa7+0EJfpR0TCJytvjMGCbCJorgRCidCDQDPpTCHOYAmD/pt
 1uIPZAiQcArwxsOmXLU2sFD5VBj21Br4T6E3WGIbJ0a9FwaCPCm0JWgPFC9ELFUZz9m1
 byiEZzm7Xj7qt5tmIzKYy2N3WNw6KvqtxPL4iR5+iQr0JRnuDlAVfRO/r9zG079GAmyL
 RWcWjP4mVUnTYDi3+JDy5L+RDIGIVJxQlu7qLIfYtF8mGHV4oP4uSijtKt6o/AqAG4lM
 5al5iwJvfni9XY8675aV85qUJ1S583A39QXHgUDWYfm8siBNFLWg84+O1ilic0ft4OrF
 PyjA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ikS8Ppy7uLwNcuFk5VA1oXp8kHdF2t76E2ycq0Dy0u7Ie7c9P8XT2iRmO9s2LpVTmFL+QS8P199s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YymUJHojNz6yMhnyrD0RDBuuTqdD+CJqL66jfp/8b7pnLjaraKT
 K5DlR+04b1YHToWSeumXnnHKi9GiZw43VdQO+mDX/QgUSXthKn/pKaNidZaMc6sUVFNhXe4gUkc
 aS6QrgtCrUlYDqu3ttQ==
X-Received: from wmbil16.prod.google.com
 ([2002:a05:600c:a590:b0:48a:73ac:6247])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a08b:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48e51f4119bmr57153895e9.21.1778071348766; 
 Wed, 06 May 2026 05:42:28 -0700 (PDT)
Date: Wed, 6 May 2026 12:42:27 +0000
In-Reply-To: <20260505152400.3905096-3-dakr@kernel.org>
Mime-Version: 1.0
References: <20260505152400.3905096-1-dakr@kernel.org>
 <20260505152400.3905096-3-dakr@kernel.org>
Message-ID: <afs3Mz8J9oOeqF34@google.com>
Subject: Re: [PATCH v2 2/3] rust: auxiliary: add registration data to
 auxiliary devices
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com, 
 david.m.ertman@intel.com, ira.weiny@intel.com, leon@kernel.org, 
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
 tmgross@umich.edu, driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org
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

On Tue, May 05, 2026 at 05:23:08PM +0200, Danilo Krummrich wrote:
> Add a registration_data pointer to struct auxiliary_device, allowing the
> registering (parent) driver to attach private data to the device at
> registration time and retrieve it later when called back by the
> auxiliary (child) driver.
> 
> By tying the data to the device's registration, Rust drivers can bind
> the lifetime of device resources to it, since the auxiliary bus
> guarantees that the parent driver remains bound while the auxiliary
> device is bound.
> 
> On the Rust side, Registration<T> takes ownership of the data via
> ForeignOwnable. A TypeId is stored alongside the data for runtime type
> checking, making Device::registration_data<T>() a safe method.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The change itself LGTM.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

But I'm not entirely convinced that this is the most convenient
user-interface. I'm wondering if the auxiliary driver trait could
specify which type the parent driver data is using in an associated
type, and whether you could eliminate the check and error path that way.
But then again, AuxiliaryDriver does not appear as a generic parameter
in auxiliary::Driver, so it might not work.

Alice
