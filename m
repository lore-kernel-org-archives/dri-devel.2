Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D3010706DC
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 13:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B79D8989C;
	Sat, 14 Mar 2026 13:24:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="pMXttIvs";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB23B8989C
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 13:24:40 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-439c4d71603so2809519f8f.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 06:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1773494679; x=1774099479;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=HELqxrOQ/OwUFnReaSfuYgQk+nnNmP4iYE5u5YV1ltw=;
 b=pMXttIvsaabAI78W+OkE4KaB1DYqAkbjEFJhAShTIzyQsnnKpS2NQwc49DjMX07F/U
 WW+VH0QPbgKCGzDQ4EOMYQy0uwL3DmTkcW67jHVKaiNPIE7vvyWV0zi4BpYWIahLBDE3
 wu2UfNu0sDSSDlF6Tn5Tcjc1JunR/SjMhTdyAXnW2uzWRcfAy/Ohyh0O6NEIYtyNjUTy
 XShTUz0XDQbdipBAza9rbJRZ8gZ4y8kjjydg9ABBrD3R4NOwWcP6EWuZfZN4+RWvQWEq
 qAIKb0byZLM41GCOJj41VSFSPXddF26Hnzsd7/KSf7LBxxoMmw+Aw6TNH5OIes5OcJJ8
 3JQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773494679; x=1774099479;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HELqxrOQ/OwUFnReaSfuYgQk+nnNmP4iYE5u5YV1ltw=;
 b=C260JOJZJ8b8youhxdfGxGFkYxQv5XRioYUHR2Zthv9WHqW6qSA+GgWL7ER95gzWAI
 GB1YUIV/ktU1NZ58Ftya4C0g2kVAlbPaqiOmQe7dRcy5BEIxCSi8xxL/3uZ7AyRRWTb3
 InnDEyWAkz09ZYbVeBnRZs+NGPWracZkkQk7skZVG1rpS43kPddo3qPiWARysE6+d+pJ
 RRuc3FOk+IfONqEy21FwXlrsBxhKgFQKFh97MTsuVj+62nBphoAiGJAYom+Tx5iQaxv9
 vDtGUxaCzxQCRXylBu5Opqe60Qd0DpNeM2tqff8jRYRwc9QuWeG7ooLFR8JVHP9/hHZc
 DgkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTM9vE4wV75YfAAsrulIIrdru+NnxyZbujLULoIknD/lHHJeiyvSf2JoomTbKDusimFAbZzWU7I8s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzD+8g7uw1aVEX+70//MARxniZAalqLPHFKAHnZBZH8zwBr88RC
 HXl4dkt9/93l/2ksU3kdbxVSY+QtZvmvsb+bJ2SZYRjJcitQDwLFv0hWrMyu1C1obdCPhIiWxWH
 +OQxRUoba08TdBPepPw==
X-Received: from wrxk10.prod.google.com ([2002:a05:6000:4a:b0:439:d5c0:336d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:64a2:0:b0:43a:4e0:1774 with SMTP id
 ffacd0b85a97d-43a04e01813mr8786099f8f.16.1773494678748; 
 Sat, 14 Mar 2026 06:24:38 -0700 (PDT)
Date: Sat, 14 Mar 2026 13:24:37 +0000
In-Reply-To: <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
Mime-Version: 1.0
References: <20260313-rust_serdev-v3-0-c9a3af214f7f@posteo.de>
 <20260313-rust_serdev-v3-2-c9a3af214f7f@posteo.de>
 <2026031402-absence-graph-af5d@gregkh>
 <a9618d034bd48ec21bd26060573770a548619402.camel@posteo.de>
 <2026031422-shaded-matchbook-5078@gregkh>
 <fa25ed4ff4688a40bd601d695804def772e47af9.camel@posteo.de>
Message-ID: <abVhlQ91AMViBsPu@google.com>
Subject: Re: [PATCH v3 2/4] serdev: add rust private data to serdev_device
From: Alice Ryhl <aliceryhl@google.com>
To: Markus Probst <markus.probst@posteo.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, 
 Jiri Slaby <jirislaby@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>,
 Kari Argillander <kari.argillander@gmail.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Boqun Feng <boqun@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, 
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-pm@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org
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

On Sat, Mar 14, 2026 at 12:08:09PM +0000, Markus Probst wrote:
> On Sat, 2026-03-14 at 12:52 +0100, Greg Kroah-Hartman wrote:
> > On Sat, Mar 14, 2026 at 11:42:02AM +0000, Markus Probst wrote:
> > > On Sat, 2026-03-14 at 09:07 +0100, Greg Kroah-Hartman wrote:
> > > > On Fri, Mar 13, 2026 at 06:12:31PM +0000, Markus Probst wrote:
> > > > > Add rust private data to `struct serdev_device`, as it is required by the
> > > > > rust abstraction added in the following commit
> > > > > (rust: add basic serial device bus abstractions).
> > > > 
> > > > why is rust "special" here?  What's wrong with the existing private
> > > > pointer in this structure?  Why must we add another one?
> > > Because in rust, the device drvdata will be set after probe has run. In
> > > serdev, once the device has been opened, it can receive data. It must
> > > be opened either inside probe or before probe, because it can only be
> > > configured (baudrate, flow control etc.) and data written to after it
> > > has been opened. Because it can receive data before drvdata has been
> > > set yet, we need to ensure it waits on data receival for the probe to
> > > be finished. Otherwise this would be a null pointer dereference. To do
> > > this, we need to store a `Completion` for it to wait and a `bool` in
> > > case the probe exits with an error. We cannot store this data in the
> > > device drvdata, because this is where the drivers drvdata goes. We also
> > > cannot create a wrapper of the drivers drvdata, because
> > > `Device::drvdata::<T>()` would always fail in that case. That is why we
> > > need a "rust_private_data" for this abstraction to store the
> > > `Completion` and `bool`.
> > 
> > So why is this any different from any other bus type?  I don't see the
> > "uniqueness" here that has not required this to happen for PCI or USB or
> > anything else.
> > 
> > What am I missing?
> In Short:
> In serdev, we have to handle incoming device data (serdev calls on a
> function pointer we provide in advance), even in the case that the
> driver hasn't completed probe yet.

Why can the function pointers be called during probe?

Alice
