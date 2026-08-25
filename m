Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D59C61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:02:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F340010EA2E;
	Tue, 25 Aug 2026 13:02:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Dkp00pUl";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D3710EA2E
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:02:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 65B866011F;
 Tue, 25 Aug 2026 13:02:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1972A1F00A3F;
 Tue, 25 Aug 2026 13:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787662929;
 bh=VNcoz4Pw6SFuZfea+o/jo++KMcxe/kAZME+DPG+fZOo=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To;
 b=Dkp00pUl9EQ7kOKFQgqA2AIpvWU64bXsCrPAHo2qX5sNnLEOXJ5aBfAY6fhEeaYrk
 plBRhMhwwqmDXjQzXoAF4Y9UnaE6++ghDotlTwDLqWYKco+ySPZ81338ywjIpV8Yuh
 kG5jEQvKZwhGsnHdrk1/trpBPttTYxDHgVrm53gWUteDdiXjBJVIq/kI3zv6QlPkIM
 2f7Z1LsZE/FhsO0XeZBWqSuG8SmpE0fgIDqpLmj6Z7m3FMEITvXj/nUH5oYfWO/l67
 T3X7eYN53W8nSAZXwL/AS8OsYKZ0bU6cnO/xBj/O/fGL++eW5F8VDSMJZSXdfvsV0M
 Vf4P8RYBCMHAw==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 15:01:57 +0200
Message-Id: <DKY1M6ZZENAL.152ELCOMXURCU@kernel.org>
Subject: Re: [PATCH v20 1/8] rust: alloc: add `KBox::into_non_null`
Cc: "Lorenzo Stoakes" <ljs@kernel.org>, "Vlastimil Babka"
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross"
 <tmgross@umich.edu>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Tamir Duberstein" <tamird@kernel.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Lyude Paul" <lyude@redhat.com>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=
 <arve@android.com>, "Todd Kjos" <tkjos@android.com>, "Christian Brauner"
 <brauner@kernel.org>, "Carlos Llamas" <cmllamas@google.com>, "Rafael J.
 Wysocki" <rafael@kernel.org>, "Dave Ertman" <david.m.ertman@intel.com>,
 "Leon Romanovsky" <leon@kernel.org>, "Paul Moore" <paul@paul-moore.com>,
 "Serge Hallyn" <sergeh@kernel.org>, "David Airlie" <airlied@gmail.com>,
 "Simona Vetter" <simona@ffwll.ch>, "Alexander Viro"
 <viro@zeniv.linux.org.uk>, "Jan Kara" <jack@suse.cz>, "Igor Korotin"
 <igor.korotin@linux.dev>, "Viresh Kumar" <vireshk@kernel.org>, "Nishanth
 Menon" <nm@ti.com>, "Stephen Boyd" <sboyd@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Pavel Tikhomirov" <ptikhomirov@virtuozzo.com>,
 "Michal Wilczynski" <m.wilczynski@samsung.com>, "Ira Weiny"
 <iweiny@kernel.org>, "Philipp Stanner" <phasta@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-mm@kvack.org>, <driver-core@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-pwm@vger.kernel.org>, <linux-usb@vger.kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
 <20260824-unique-ref-v20-1-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-1-490735672187@kernel.org>
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

On Mon Aug 24, 2026 at 1:17 PM CEST, Andreas Hindborg wrote:
> Add a method to consume a `Box<T, A>` and return a `NonNull<T>`. This
> is a convenience wrapper around `Self::into_raw` for callers that need
> a `NonNull` pointer rather than a raw pointer.
>
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

Acked-by: Danilo Krummrich <dakr@kernel.org>
