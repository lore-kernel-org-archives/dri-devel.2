Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC8BC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:21:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4569F10E1D5;
	Tue, 25 Aug 2026 13:21:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="fh2ALwdi";
	dkim-atps=neutral
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 713AE10E1D5
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:21:00 +0000 (UTC)
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-49808ea1b64so6536265e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787664059; x=1788268859;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
 b=fh2ALwdibb+yIqs1wm9Tv+rvWRKuxDKubpg+txrL9teBnRyPgsB4PFn+rO1m7aGyEz
 ksX2tc2oDsLR/ySEPc9UgVE8N8XVaMSpHnXJYzrewPViCHqHf4710DE4d/3pn6y6sISS
 3OKS/p5n+39EWzuVyOSvsxbmpEspO/ARFsntDqaQ2gM2DnvQjRkqBzXLFqn1QxnnjUCM
 5tEdp5hfhntZOYoeDy7nreKH+/Bc+uhC6Ve8HB1LjMQmjui1glkVJHsneOiWfuS3AGrA
 03PHWln/Lba5x3anJXpWBqgeARORvQKEzVvuACgq6sLqaBmDW3kw5Flvgtu2CDErRWC5
 09pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787664059; x=1788268859;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/wDF0hN/FW6BAXrcHvW79QxhTrkNJERnJhXR31M87d4=;
 b=kQBkvq8vyp8WKEpxtJ7uczE/83OnsIP+KyIcFmlXc63L/XhpRP/99yb4ZdiAgYLzQE
 Z8vroUbAR1NzUCHJbyBtV6YSZjGxcY5F8JzGsVj8s4cl7EO9d/139OXjOkW9Lc60l7xp
 Fpktvz/Rwac3PT/ERDuIar7GY6QPNhlnPdm9eEMfH7V5LOomfj0tm4XSij4gb3BEThL9
 xloBFV5UdQ7xwT8n2w/MG3+Icn2hnP9tv8nen4IJjlkBfyQx5HcYBKo7XzAGUXE+XBNY
 ABMNtDIreeQ3mA+emeJR7v/9eT/nNaBmPsSd1FYp2Kn05qGGMTQsJHJe+z/wOFh52UVR
 EpzQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJOtWQzibjCTgI1Oa6Zxk3Ek4U8IcILy7Jo82kOLIijYSSd23luN1exlvGMqjgExZEg9/hWZ3xBPE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lZrriDCtU+s5NykaJi2pzY56uBfqSpwiEAyVyt2EKtZLZdW3JH
 I9s2HW/O95T05/RNHBFmNsOC5y+2ZP8xWJIZmWd7uSduAg/1/8flFDPg5X3zZc5HprO7fyYE95Z
 NxG+5QfwuPznRqMoXsg==
X-Received: from wmjs24.prod.google.com ([2002:a7b:c398:0:b0:499:9f79:18de])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4f89:b0:493:f783:c46a with SMTP id
 5b1f17b1804b1-499d63308fbmr60648795e9.6.1787664058484; 
 Tue, 25 Aug 2026 06:20:58 -0700 (PDT)
Date: Tue, 25 Aug 2026 13:20:57 +0000
In-Reply-To: <20260824-unique-ref-v20-4-490735672187@kernel.org>
Mime-Version: 1.0
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-4-490735672187@kernel.org>
Message-ID: <ao2WubjLtDuHvRzx@google.com>
Subject: Re: [PATCH v20 4/8] rust: page: convert to `Ownable`'
From: Alice Ryhl <aliceryhl@google.com>
To: Andreas Hindborg <a.hindborg@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 Vlastimil Babka <vbabka@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Trevor Gross <tmgross@umich.edu>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
 "Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, Lyude Paul <lyude@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Arve =?utf-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>,
 Todd Kjos <tkjos@android.com>, 
 Christian Brauner <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Dave Ertman <david.m.ertman@intel.com>,
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>,
 Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>,
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, driver-core@lists.linux.dev, 
 linux-block@vger.kernel.org, linux-security-module@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-fsdevel@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-pwm@vger.kernel.org, linux-usb@vger.kernel.org, 
 Asahi Lina <lina+kernel@asahilina.net>
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

On Mon, Aug 24, 2026 at 01:17:56PM +0200, Andreas Hindborg wrote:
> +        // SAFETY: We just successfully allocated a page, so we now have ownership of the newly
> +        // allocated page. We transfer that ownership to the new `Owned<Page>` object.
> +        // Since `Page` is transparent, we can cast the pointer directly.
> +        Ok(unsafe { Owned::from_raw(page.cast()) })

This doesn't satisfy the safety requirements of Owned::from_raw()
because the page may be used with vm_insert_page(), which increments its
refcount and causes it to be shared the vma system, and this occurs
before Page::release() is called.

Alice
