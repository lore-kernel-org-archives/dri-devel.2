Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC02FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:00:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59AA210F2AB;
	Thu, 30 Apr 2026 09:00:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="PQg2CdTR";
	dkim-atps=neutral
Received: from mail-wr1-f74.google.com (mail-wr1-f74.google.com
 [209.85.221.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79CB710F2AB
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 09:00:22 +0000 (UTC)
Received: by mail-wr1-f74.google.com with SMTP id
 ffacd0b85a97d-43d1dea12aaso587562f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 02:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777539621; x=1778144421;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=PqBhPKhd+Br9ZjEmkXcxZU210pei7kYegjOF/K5Z2t0=;
 b=PQg2CdTRVRD+twkWAtl0oB3Zl0WEFK7zq/BOkWzyCS7xU22C4M2I9HssMfQ02VoRUx
 6LNf3KH+l182QdRQ3hr8zvrjNny7e9p5x6GiRawo0lKXX2jtJ1W+2VU+YS4gY+kYJJiF
 pjHETQJ0N3+yttRc+8eGL66dEab+wcJQG/ZuSzOHaWBcNau70wyavaXU5SjU/zT4iTdI
 hspNxuJ5hZUl8ymFv6W/AZracDMtQWfyxS+myq40om4LXdj8NTQM26nwf0G8H653ZU/L
 WCazKAVyw1L5W8kcLVyEbx9wRU3hpuTnUyNc8oM/QnvdLlj2fqLXQSeqH1qHuc9K3qXJ
 uoRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539621; x=1778144421;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PqBhPKhd+Br9ZjEmkXcxZU210pei7kYegjOF/K5Z2t0=;
 b=WU/AYSF4K/kub5tv9FatPS0fmls7vITb3h0w0gkS2MaOJLFotTVsKYNobd5RLq5uFs
 Y8q0jf5fgK16V5rTUrSa8Tz0FOqfsXg+xRB+mi6OJRXC9waGXxyg6wW8/wHSAtuxJODx
 +MUhbruc4LQJNZnI6nozHWIcqOzQpHYoKn6vkvJ0M+6E6+yreADwBElxG4zv5wQSLOv4
 UD2wAlcK1E3VCKCv4zcSRyV5Pj79jpSOctbrTi28YixFCsk18GCfB/MeaSi8CdBVpMmJ
 zIjHHNV60lhJXe/FvmeLOhYlQuirbg9HXaoMk5z7xxsma+VqpDmvj6q5XOZl7Sr4JABX
 CH1A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/cgnfjTWzJ2d+40EKYMcMfGfHyhTdZO9ZLq1cLv1obVwM+wnFlsRXv/NU8fb5rVswKy9te5j7/Vvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyW8fILRuN/jRhBqdImnyq7JufA+qtY/Cj7Z6CXBKGDliQoUYIv
 4nizrMZ2XKMv6oBytdKfLB6ZnlQO+pLm2VErNNEGg40GIN6sPSXbgNrCkuYl6tsFVGch66U45rM
 R560R3d+CoWx45e+9MA==
X-Received: from wrwv10.prod.google.com ([2002:a5d:6b0a:0:b0:43d:74ca:3105])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1869:b0:439:b8b2:fabc with SMTP id
 ffacd0b85a97d-4493e1c1512mr3145148f8f.21.1777539620636; 
 Thu, 30 Apr 2026 02:00:20 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:00:19 +0000
In-Reply-To: <20260427221002.2143861-3-dakr@kernel.org>
Mime-Version: 1.0
References: <20260427221002.2143861-1-dakr@kernel.org>
 <20260427221002.2143861-3-dakr@kernel.org>
Message-ID: <afMaIz-EUsHbzqAc@google.com>
Subject: Re: [PATCH 2/2] rust: driver core: remove drvdata() and driver_type
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

On Tue, Apr 28, 2026 at 12:09:41AM +0200, Danilo Krummrich wrote:
> When drvdata() was introduced in commit 6f61a2637abe ("rust: device:
> introduce Device::drvdata()"), its commit message already noted that a
> direct accessor to the driver's bus device private data is not commonly
> required -- bus callbacks provide access through &self, and other entry
> points (IRQs, workqueues, IOCTLs, etc.) carry their own private data.
> 
> The sole motivation for drvdata() was inter-driver interaction -- an
> auxiliary driver deriving the parent's bus device private data from the
> parent device.
> 
> However, drvdata() exposes the driver's bus device private data beyond
> the driver's own scope. This creates ordering constraints; for instance
> drvdata may not be set yet when the first caller of drvdata() can
> appear. It also forces the driver's bus device private data to outlive
> all registrations that access it, which causes unnecessary
> complications.
> 
> Private data should be private to the entity that issues it, i.e. bus
> device private data belongs to bus callbacks, class device private data
> to class callbacks, IRQ private data to the IRQ handler, etc.
> 
> With registration-private data now available through the auxiliary bus,
> there is no remaining user of drvdata(), thus remove it.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
