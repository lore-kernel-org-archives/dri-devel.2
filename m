Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24C7CA5FCE
	for <dri-devel@archiver.kernel.org>; Mon,  5 Oct 2026 13:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDE2E10E5CE;
	Mon,  5 Oct 2026 13:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iqM3LLpW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1418D10E5CE
 for <dri-devel@lists.freedesktop.org>; Mon,  5 Oct 2026 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1791208498;
 bh=e64f0BFclbfDHk0y2rETkW2L9KRwiIfRuzKqbE+Za/A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iqM3LLpWSbP6utL5X854A3/Y7NUB4L3zl0JUPA7QrYLnH0jkXJdRZT7lNgh8sC1xY
 LfFh5Txu8iPWZe7RxRreLzSlUySFpUH6EIXGZnyDwtbn1g5cA571yMmbgULbrz5U7r
 LgL78uisdasdnWCcuw29ktVVFDN6RBgI8zr3h81mRvsrEJjD6umIQA2JmMzuinGsiW
 eha+4evyl56Dc/b3ToZ3RUSjNf0fUFRO8H6cx9Fa1zTJ0lJZrkNKwVxs8gqBNfsLBf
 0xnOyNfO8Db82YqO0jJe5OZx5Ofp35iIgW7YD9MTeTRzuU9TG3yD1Z+UKn9Uw4oUz0
 cwgaH74vYLObQ==
Received: from laura.lan (unknown [100.64.0.215])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: laura.nao)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EAD2417E0243;
 Mon, 05 Oct 2026 15:54:57 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: daniel.almeida@collabora.com
Cc: a.hindborg@kernel.org, acourbot@nvidia.com, airlied@gmail.com,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, boqun@kernel.org,
 dakr@kernel.org, deborah.brouwer@collabora.com,
 dri-devel@lists.freedesktop.org, gary@garyguo.net, kernel@collabora.com,
 laura.nao@collabora.com, linux-kernel@vger.kernel.org, lossin@kernel.org,
 ojeda@kernel.org, rust-for-linux@vger.kernel.org, simona@ffwll.ch,
 tamird@kernel.org, tmgross@umich.edu, work@onurozkan.dev
Subject: Re: [PATCH v6 0/2] drm/tyr: add Job IRQ handling
Date: Mon,  5 Oct 2026 15:54:48 +0200
Message-Id: <20261005135448.303426-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <987240A7-9626-4520-8143-B283B431A2AC@collabora.com>
References: <987240A7-9626-4520-8143-B283B431A2AC@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Hi Daniel,

On 9/25/26 21:29, Daniel Almeida wrote:
> Hi Laura,
>
> It makes more sense to have Onur's reset v7 land first, so the Job IRQ series
> needs a rebase on top of it:
>
> https://lore.kernel.org/r/20260912-tyr-reset-impl-v7-0-077ce72084eb@onurozkan.dev
>
> After his 3/3, the registers are only reachable through HwGate, whose
> access() takes a mutex. I added try_access_atomic() for the hard handler
> on top of v7 [0]. Can you rebase onto that and carry the patch at the
> front of your series? Then:
>
> a) hard handler: try_access_atomic(), return ThreadedIrqReturn::None on None
> b) threaded handler: access()
> c) drop the #[expect(dead_code)]
>
> — Daniel
>
> [0] https://gitlab.collabora.com/dwlsalmeida/for-upstream/-/tree/tyr-hwgate-try-atomic?ref_type=heads

Ack, thanks for the pointer. I'll make sure to address this for v7.

Best,

Laura
