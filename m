Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DEDCD98DA
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 11:50:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1252110EA66;
	Tue, 16 Jun 2026 11:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="aE9syYKG";
	dkim-atps=neutral
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com
 [209.85.218.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D4F610EA66
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 11:50:31 +0000 (UTC)
Received: by mail-ej1-f74.google.com with SMTP id
 a640c23a62f3a-bfe735f3bc5so381906066b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 16 Jun 2026 04:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1781610629; x=1782215429;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=hcH8wbzZOm8yn4lLoAkAwb8V6hZltU+bJ+2UV9XpA9s=;
 b=aE9syYKG9Zj8ZvP7XCtj+hJPZoI/98BL2W8MVYbQBreoxAJLxtIy4cgq7+HhDV0aiQ
 +JOcRTZtouUtimpiqPeBFAYy3dSkDW3feMpADEK1RsgzZ3J6tyGGiGJLWN0EgWubYg2h
 r3r/bM+l5sX4oYIaUuA38C+NaDS7IiR1JEY66MAur6mldEiJQ/9m3uYy7mnav432Xd4p
 LeaL2p1UiZ4tFAjqZuW19fcfTyrTDDDiE7FpCRytDcg9QRBTa6ZcD7BW+7JsVtsBYTfn
 kVVaun4/zEowuZ3n+i9pMp32Gmk3UXIaO/t2OmOj2tBSvmpXr8CjEkeyQduxFbCrwR5f
 oaVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781610629; x=1782215429;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hcH8wbzZOm8yn4lLoAkAwb8V6hZltU+bJ+2UV9XpA9s=;
 b=I1VOKBClyZPNhC2j+6M06ciTSD5DlY6Ii81ULHkWF4kkEiXM7oiNVTFPxMQjzqk4w0
 nTotL+iRr0JbL0DQlAqAqbM962LnR3yb+v2zuRU3rQOPIXzZI6JiSR+3K3w42UqRsREq
 +UB0kdd+cykGUeqY1Ra1Z3hmIzAOOuE2oqHDNDGi3UQYgjfCtLjnBpKCvpGgagZNzQgY
 rOpyAUV5e3XllRkBNQZgGsNdK7PKRz05eQwc3M7mKSy0V/p6CG1tSq4kMWur/DMQxlWI
 tBgtRxHInO9xwW97vNxrnuj533WQJ5o/0cNtkUVGME9FH7zNqNxlY8Bkk5jFuPSyf5J6
 CW5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ90Wk5JJGJZlyxGXb7Fi02PWcEtRC5rhPvN3HAtGfulywnII/vzZWDcGDnvFpMVe/7WJ4+KzmqLd3Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyAcCD6esULf+SXqHozbnrytbAeD+ts0tvHewJjWOcrXz/2cLO+
 zRC1afNT6Z2wgEcpvjweQA6030SIwXl3bZo5ksc/k6ILWs+9zM51r5T9yLq+vstaScsj3fprRBP
 yhVb6tDuNJknO5Bq+2w==
X-Received: from ejfp18.prod.google.com ([2002:a17:906:e92:b0:beb:c99:aa2])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:1dd6:b0:bed:9a7:5ed1 with SMTP id
 a640c23a62f3a-c043a477df5mr130254166b.5.1781610629337; 
 Tue, 16 Jun 2026 04:50:29 -0700 (PDT)
Date: Tue, 16 Jun 2026 11:50:27 +0000
In-Reply-To: <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
Mime-Version: 1.0
References: <20260604-unique-ref-v17-0-7b4c3d2930b9@kernel.org>
 <20260604-unique-ref-v17-1-7b4c3d2930b9@kernel.org>
Message-ID: <ajE4g7JsM6bnpEOu@google.com>
Subject: Re: [PATCH v17 01/10] rust: alloc: add `KBox::into_non_null`
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dave Ertman <david.m.ertman@intel.com>, 
 Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
 Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Boqun Feng <boqun@kernel.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Igor Korotin <igor.korotin@linux.dev>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, driver-core@lists.linux.dev
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

On Thu, Jun 04, 2026 at 10:11:13PM +0200, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
