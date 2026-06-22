Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D227CDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 09:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACBE910E5C8;
	Mon, 22 Jun 2026 09:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="m27Mm4H+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9EC10E5C8
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 09:46:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CFE4B600AF;
 Mon, 22 Jun 2026 09:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C2D1F00A3A;
 Mon, 22 Jun 2026 09:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782121564;
 bh=Q00CUE1AZx2Is/tR2ZY+tJyYPGGBbW4ZIr/9ZAf2s/U=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=m27Mm4H+bNsp/UDzGbjPabw8c3K52wf9UvHVc04VXLJqtFs2HQ68r8BWa7uMKa6Uz
 S5Ie1fqQgf9OQCGrT50avcE/nsutuav9+kJz6dZkE2eH55R6B5ANRZ/RPCLhlLPhN1
 jPj4Vr4Xlr9NTE7DvZBi8Stc8apcARyyfE+JEBIH5VIuohm1SPrugrQ9W6RqrwOJra
 fc79nL/Q9WEkS4VUMWrmYkX/J8miWIsFI/oN5Yn1v2AzEfv6WGLC7/q8FGAX2/3EVy
 vzWdtoGdFg+SriZ2BTaJODZoVQnfiNUTRT5zARyVT/H30Zio5IOpRiQUXpMwpcyKBM
 3duxEp7ZNlfsw==
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
 Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org,
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org,
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org,
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alvin Sun <alvin.sun@linux.dev>
Subject: Re: [PATCH v3 6/6] rust: configfs: use `LocalModule` for `THIS_MODULE`
In-Reply-To: <20260622-fix-fops-owner-v3-6-49d45cb37032@linux.dev>
References: <20260622-fix-fops-owner-v3-0-49d45cb37032@linux.dev>
 <20260622-fix-fops-owner-v3-6-49d45cb37032@linux.dev>
Date: Mon, 22 Jun 2026 11:38:11 +0200
Message-ID: <87pl1iewzg.fsf@t14s.mail-host-address-is-not-set>
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
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



