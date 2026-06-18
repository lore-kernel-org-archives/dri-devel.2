Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76430CD98F2
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2B7310F2B2;
	Thu, 18 Jun 2026 12:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U2Sk2fni";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B42B10F2B2
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:18:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6ADC943A62;
 Thu, 18 Jun 2026 12:18:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE0D81F000E9;
 Thu, 18 Jun 2026 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781785106;
 bh=/IMHFCTpEmbT0Ogk1LeIliz7VqNHiat4WqgNfPhAoMk=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=U2Sk2fnigIIfCCreUea8OkXmiOdd5RIh66lLcOJcr/59X6/gAuq+RJwoA4CokLAS6
 b5wtJWgQB4IibAdeZh9tM95pttJYCc71yKnIh1xj5mA49uxJhGrVcBBVnTG/SdmdMd
 gLmnUDVKG7cfWL1wNLXP3iZSyo5q1urY0GN1JXC0V1LY74iQiyXtq4DhZ1VhZqjsb/
 II9LC0+wBVMdxCWEEFehp3uCRdMEf7eBb1n33QiHnGXcbxyMYMSZ1ZGXuj9a7p7Lqv
 s8DwSiV1yYg+n/I7ElpP7FJOqbayB0FQ9M38f3pF06U3wiQmvZDUgFMl975kDRVPWk
 xOXY+DDSlpyHA==
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
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, Alvin Sun
 <alvin.sun@linux.dev>
Subject: Re: [PATCH v2 7/7] block: rnull: use `LocalModule` for `THIS_MODULE`
In-Reply-To: <20260521-fix-fops-owner-v2-7-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
 <20260521-fix-fops-owner-v2-7-fd99079c5a04@linux.dev>
Date: Thu, 18 Jun 2026 14:17:53 +0200
Message-ID: <87cxxof3f2.fsf@t14s.mail-host-address-is-not-set>
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

> Replace the `THIS_MODULE` import with `LocalModule` from the crate,
> consistent with the move of `THIS_MODULE` into the `ModuleMetadata`
> trait.
>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>

You need to squash this with the previous patch.


Best regards,
Andreas Hindborg



