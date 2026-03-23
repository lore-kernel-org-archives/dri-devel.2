Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1000BF483F8
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 21:56:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59B1010E4AA;
	Mon, 23 Mar 2026 21:56:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l1Z2F02g";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 105C610E4AA;
 Mon, 23 Mar 2026 21:56:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9115742D9E;
 Mon, 23 Mar 2026 21:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A516BC4CEF7;
 Mon, 23 Mar 2026 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1774303014;
 bh=kI3bMJRdPfjTY4J1ka/g4c7ItdC1C2EpVS7Hjd+xIms=;
 h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
 b=l1Z2F02gyMyZJBFpQf9P9PihXMbmx1Y6+anjGj6bBrtHMyQb7tC/h29f3Cv20spBo
 2RmTqi1HiT9eUWcS7k5cjlUKMYfCxr3Iu2A5vOjQ2ttJDGdrFSGfkLPtgSuwiitP8c
 b4KMSqh9rhJ3FDv6qoKve4ZZmdPWx6aiv3jzqcxpm+8PY3Uw2CpFnP5c+s+XbURzmO
 rbIgOsgY0BtqzvOk4vUgIwyaoEZ2wTwX/lCjJLdYAqa241FdPLO0cyRp7BeXv0FWpU
 QA6cSN/tbG5ksPGOvkdJcqfJZYdW0/j6u1VTp4keB5Ch8sxhw9Ma2WK+Hah+iMZT9x
 KqfvKf4MgtsTA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Mar 2026 22:56:48 +0100
Message-Id: <DHAHX9OTSGDZ.3YRZ455BB0J7@kernel.org>
Subject: Re: [PATCH v2 0/8] dma::Coherent & dma::CoherentBox API
Cc: <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Danilo Krummrich" <dakr@kernel.org>
To: <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <a.hindborg@kernel.org>, <tmgross@umich.edu>,
 <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260320194626.36263-1-dakr@kernel.org>
In-Reply-To: <20260320194626.36263-1-dakr@kernel.org>
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

On Fri Mar 20, 2026 at 8:45 PM CET, Danilo Krummrich wrote:

Applied to drm-rust-next, thanks!

> Danilo Krummrich (5):
>   rust: dma: use "kernel vertical" style for imports
>   rust: dma: introduce dma::CoherentBox for memory initialization

    [ Remove unnecessary trait bounds. - Danilo ]

>   rust: dma: add Coherent:init() and Coherent::init_with_attrs()
>   gpu: nova-core: use Coherent::init to initialize GspFwWprMeta
>   gpu: nova-core: convert Gsp::new() to use CoherentBox

    rust: dma: remove dma::CoherentAllocation<T>

> Gary Guo (3):
>   rust: dma: add generalized container for types other than slices
>   rust: dma: add zeroed constructor to `Coherent`

    [ Use kernel import style. - Danilo ]

>   gpu: nova-core: convert to new dma::Coherent API
