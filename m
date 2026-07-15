Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 110D9C44501
	for <dri-devel@archiver.kernel.org>; Wed, 15 Jul 2026 06:47:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63B8B10E131;
	Wed, 15 Jul 2026 06:47:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Rxe5BH0x";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071B710E131
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Jul 2026 06:47:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 01B0343046;
 Wed, 15 Jul 2026 06:47:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7291F000E9;
 Wed, 15 Jul 2026 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784098068;
 bh=Kspjd676zvs0DkYjbeRjHFL+eRleqOy5TmzjeLfcgxg=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=Rxe5BH0xxS8Vh4oYbl/NJWNcYGvgJM17Umbc51sM7xu1SMeV4cV515HpEvcKV4FMP
 TGJ8PNvDRgCYG01V10/2gn5Q6f5ZuvzRtp9u8pLjXDAxuYDZUmjxg0UxhJR2UstyQm
 QQk0Exe4Ex7DMTCVrb5jDz0CQlyGwXtccd3Fv5EUvYKRyPrOtJ7wl03qR7SDDiSixz
 Vvx+lW4UtYvtbN14sNTyGLAY454TSkUZoEZ8NdAShabcq7GngGNDKCIne4gq9uY0XD
 W8mnw/OD5Qm36U8Ti0gXvCupfR0ODtgPQgMa4APmfNia4h6YM6yxGVLzQBjGW5yoyE
 ryb4o97GKAkIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alvin Sun <alvin.sun@linux.dev>, Miguel Ojeda <ojeda@kernel.org>, Boqun
 Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu
 <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>, Daniel Almeida <daniel.almeida@collabora.com>, Arnd
 Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, Breno
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, Dave Ertman
 <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, Igor
 Korotin <igor.korotin@linux.dev>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Arve
 =?utf-8?B?SGrDuG5uZXbDpWc=?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Christian Brauner
 <brauner@kernel.org>, Carlos Llamas <cmllamas@google.com>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v8 07/10] rust: configfs: use `LocalModule` for
 `THIS_MODULE`
In-Reply-To: <20260713-fix-fops-owner-v8-7-2495cfa82d47@linux.dev>
References: <20260713-fix-fops-owner-v8-0-2495cfa82d47@linux.dev>
 <20260713-fix-fops-owner-v8-7-2495cfa82d47@linux.dev>
Date: Wed, 15 Jul 2026 08:46:42 +0200
Message-ID: <87ldbchhrh.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Alvin Sun <alvin.sun@linux.dev> writes:

> Replace the `THIS_MODULE` static reference in the `configfs_attrs!`
> macro with `this_module::<LocalModule>()`, and update
> rnull to import `LocalModule` instead of `THIS_MODULE`, consistent
> with the move of `THIS_MODULE` into the `ModuleMetadata` trait.
>
> Assisted-by: opencode:glm-5.2
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Acked-by: Danilo Krummrich <dakr@kernel.org>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>


Acked-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg


