Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039CDCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 07:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 566D810E69C;
	Wed, 10 Jun 2026 07:30:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZfgQ9Ljx";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A02F10E69C
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 07:29:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B3726001A;
 Wed, 10 Jun 2026 07:29:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E31F00893;
 Wed, 10 Jun 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781076598;
 bh=AiSFfMoIY2TE+nHxtwX/bpt7ovICgLMC4JbA8Q1cu8w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZfgQ9LjxioHkZ8YmzINDziO5XNY3bRg4375unc2i/iSTsSx/Jf6jtcxsX1oVw34A2
 Maf7TTGdgfGi+Txkn/Iv9h8Thn4iKD0Hxas9qKpQwjYc73/VkVbjnajBP6xGu58eMH
 7cgtoE8Fks9ZbYWqYxMw9J8XZYy+BZpTny4HvF2HHyG8rB5J4n3P5vm9tw26sPRIME
 h7uWafB37kG+MmaIz0+uALe77dnFgyQJey/7f7J6v3FU/boWoLfLPqxfqT65JM6b8P
 ffLt+NgkW0QM7H1eQZQHDi4d15RamybNOry6SIKA4jD4d75nf7qbPwJg7ZOkVZ9cEZ
 FROfc4w+6TjWw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, daniel.almeida@collabora.com,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 fujita.tomonori@gmail.com, linux-kernel@vger.kernel.org,
 longman@redhat.com, lossin@kernel.org, mark.rutland@arm.com,
 miguel.ojeda.sandonis@gmail.com, mingo@redhat.com, netdev@vger.kernel.org,
 nova-gpu@lists.linux.dev, ojeda@kernel.org, peterz@infradead.org,
 rust-for-linux@vger.kernel.org, simona@ffwll.ch, tamird@kernel.org,
 tmgross@umich.edu, will@kernel.org, yury.norov@gmail.com
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related
 macros
Date: Wed, 10 Jun 2026 09:29:47 +0200
Message-ID: <20260610072947.338278-1-ojeda@kernel.org>
In-Reply-To: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

On Tue, 09 Jun 2026 19:19:42 +0100 Gary Guo <gary@garyguo.net> wrote:
>
> I think I just kept it as is when rebasing. It's file to have them grouped in
> the crate to.

Thanks for confirming!

> This one is using size_of, align_of, c_void which are all in prelude. However it
> looks like I forgot to actually remove these imports in the last version, and I
> didn't change it during rebase.

Ah, I see, makes sense.

> Are you okay with fixing during applying, or do you want me to send a new version?

I did it on my side. I also tweaked a couple more bits: they were already
`no_inline`, and I noted that they sadly do not appear in the prelude anymore,
but the change looks fine and that may be more of a `rustdoc`-side issue or
design choice.

Cheers,
Miguel
