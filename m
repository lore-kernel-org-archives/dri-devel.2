Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B8F2FF8862
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 07:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 950DC10E290;
	Mon, 27 Apr 2026 07:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BW25sMZu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C409010E290
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 07:44:26 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 709D741A08;
 Mon, 27 Apr 2026 07:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9EA4C19425;
 Mon, 27 Apr 2026 07:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777275866;
 bh=UhvaxafvAV+ZY92qW1p4rqQSumkIHXI0RQwzke5UgDE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=BW25sMZuhPdjNa+iM6VMCaTjMZD5Kev7T7jEtroyTfS2+f86qU70P9PmiZb2nsE9K
 CHbm4UknzWpbPGmHIDKy2/mXdJZNj1p81lXtZ8TZyzbc63XrmW/Ztn09RTsfQacE5q
 S21iB+vRtl3S3Qx5KlxHCdHBJua0C+5MUnEq5Tu/CGk2B7u1lWwkzDDTFte27gYpKH
 DGCpXpfr2yD8c0f1QvWa6DAQn71OpkjJ2/F6i9MZptA9gmbKipGa3c+CWNDBldcnRz
 OlcAgiVcch6SuTaVv5OjnfxWY3wRsUA3qiTcEwzcfY9edRNQ8dAffTZXqXdfl2EXlC
 ted1yOxdHRADg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Deborah Brouwer <deborah.brouwer@collabora.com>, Daniel Almeida
 <daniel.almeida@collabora.com>, Alice Ryhl <aliceryhl@google.com>, Danilo
 Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Benno
 Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, Miguel Ojeda
 <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, =?utf-8?Q?Bj=C3=B6rn?=
 Roy Baron
 <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, boris.brezillon@collabora.com,
 beata.michalska@arm.com, lyude@redhat.com, acourbot@nvidia.com,
 work@onurozkan.dev, alvin.sun@linux.dev, Deborah Brouwer
 <deborah.brouwer@collabora.com>
Subject: Re: [PATCH v4 19/20] rust: time: add arch_timer_get_rate wrapper
In-Reply-To: <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
References: <20260424-b4-fw-boot-v4-v4-0-a5d91050789d@collabora.com>
 <ZpKRFb-Ves9nQ6lMstVDx-dk-vA9CSQMUQDTgSz4zBssvYj06calaHWnfeBCR6Zv92SVSX3QohKqUcY1KpTzHA==@protonmail.internalid>
 <20260424-b4-fw-boot-v4-v4-19-a5d91050789d@collabora.com>
Date: Mon, 27 Apr 2026 09:42:52 +0200
Message-ID: <87wlxsrgqr.fsf@t14s.mail-host-address-is-not-set>
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

"Deborah Brouwer" <deborah.brouwer@collabora.com> writes:

> Provide a safe Rust wrapper for arch_timer_get_rate().
>
> The underlying C helper returns 0 when the ARM architectural timer
> is not available or not yet initialized. Map this to Option<u32> to
> make the absence of a valid rate explicit to Rust callers.
>
> This allows Rust drivers to query the system timer frequency and
> select appropriate time sources when programming hardware timeouts.
>
> Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>

Looks good to me, but it is weird that this is defined for non-arm targets.

Even if this is available for all architectures in C code, would it make
sense to gate it on the target being Arm in Rust?


Best regards,
Andreas Hindborg

